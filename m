Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95D76734C0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjASJtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjASJt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:49:29 -0500
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Jan 2023 01:49:27 PST
Received: from out-87.mta0.migadu.com (out-87.mta0.migadu.com [91.218.175.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EDB6EA1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:49:26 -0800 (PST)
Date:   Thu, 19 Jan 2023 04:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674121271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUe7Jkojk2oaxll/dmHbgXg519+vydqtLcAsij+B87Y=;
        b=ZMIt/hBIr+ut/k0D3f08qLXybt/n/lJBrsn2bNQG87AocIzCyGAJ+3/kd2GTFutCR6W+ZU
        2sCLRg7RFZntRo95ih49u/llg55AdtZfheae9mbYGQhuB89+yQo7n+GAaIVHkJk+DLL3Ws
        /6h22U865gYGvxnVmFaIKDNhjRBJqbs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH] fs/aio: Replace kmap{,_atomic}() with
 kmap_local_page()
Message-ID: <Y8kQM9kzC7cHh/Wh@moria.home.lan>
References: <20221016150656.5803-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221016150656.5803-1-fmdefrancesco@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 05:06:56PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() and kmap_atomic() are being deprecated in favor of
> kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
> 
> Since its use in fs/aio.c is safe everywhere, it should be preferred.
> 
> Therefore, replace kmap() and kmap_atomic() with kmap_local_page() in
> fs/aio.c.
> 
> Tested with xfstests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel
> with HIGHMEM64GB enabled.

I was just looking over this code and made the same kmap -> kmap_local
change, but you've done a more complete version - nice.

For context, I was the one who added the kmap() call, because
copy_to_user() can sleep - anything else at the time would've been more
awkward, and highmem machines were already on the way out. But
kmap_local is perfect here :)

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
