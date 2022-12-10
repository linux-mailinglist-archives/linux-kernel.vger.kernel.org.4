Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CB7648BEC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 01:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiLJAuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 19:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLJAuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 19:50:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F040E532C0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 16:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DCC562343
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 00:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964DEC433D2;
        Sat, 10 Dec 2022 00:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670633416;
        bh=2Ri2KSdIUWoQ+TlB3H1PoS6/faC9fDqVI+PSLZ4D4sM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m5EoJ8B/gpS9tSEK/CfSq1s67bAo9+L0k2xT6mpzyKHAOpGmrbZJcTqXJQMxeBitv
         8ktWh4i9vgDTOiJnw1iBM6DoPgVGSlMTMP8fnfTswk0tMWdiGljA5OcwRMpdXkPZ9A
         K7cvxOTDKRBetLYyBBAUF93xC/pGQC6ajJctQqyI=
Date:   Fri, 9 Dec 2022 16:50:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: Re: [PATCH -next v2] mm: hwposion: support recovery from
 ksm_might_need_to_copy()
Message-Id: <20221209165015.7de5f7173c534c10875e10fb@linux-foundation.org>
In-Reply-To: <20221209072801.193221-1-wangkefeng.wang@huawei.com>
References: <20221209021525.196276-1-wangkefeng.wang@huawei.com>
        <20221209072801.193221-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2022 15:28:01 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> When the kernel copy a page from ksm_might_need_to_copy(), but runs
> into an uncorrectable error, it will crash since poisoned page is
> consumed by kernel, this is similar to Copy-on-write poison recovery,
> When an error is detected during the page copy, return VM_FAULT_HWPOISON,
> which help us to avoid system crash. Note, memory failure on a KSM
> page will be skipped, but still call memory_failure_queue() to be
> consistent with general memory failure process.

Thanks.  Sorry, lots of paperwork and bureaucracy:


Is a copy of the oops(?) output available?

Did someone else report this?  If so, is a Reported-by available for
that?  And a Link: for the Reported-by:, which is a coming thing.

Can we identify a Fixes: target?

Is a cc:stable appropriate?

