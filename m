Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA2A68E394
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBGWti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBGWtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:49:36 -0500
X-Greylist: delayed 646 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 14:49:33 PST
Received: from out-225.mta0.migadu.com (out-225.mta0.migadu.com [91.218.175.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB5DEB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 14:49:33 -0800 (PST)
Date:   Wed, 8 Feb 2023 07:38:35 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675809524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vwuRw1o2exT5ngAZcWIKwa411GMUiDhgomSfWzZ0N9w=;
        b=vcbhtsKTlCb8oofvqjxO4zBOt903cmfLMqyGuFOoV4/ZuEa/KfTb8zJgdn0u+gEozLEEW4
        Yihp5XMCgUcQUFOvMQXCrip9RR9ArJ/xxv7+5daX0Tk3x/orzIvMAGozbI8JXBlm9F2fDZ
        Edhag0P5MR8g9M3ntViXe0GkZwDHTQE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linmiaohe@huawei.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: hwposion: support recovery from
 ksm_might_need_to_copy()
Message-ID: <20230207223835.GA1039769@u2004>
References: <20230201074433.96641-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230201074433.96641-1-wangkefeng.wang@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 03:44:33PM +0800, Kefeng Wang wrote:
> When the kernel copy a page from ksm_might_need_to_copy(), but runs
> into an uncorrectable error, it will crash since poisoned page is
> consumed by kernel, this is similar to the issue recently fixed by
> Copy-on-write poison recovery.
> 
> When an error is detected during the page copy, return VM_FAULT_HWPOISON
> in do_swap_page(), and install a hwpoison entry in unuse_pte() when
> swapoff, which help us to avoid system crash. Note, memory failure on
> a KSM page will be skipped, but still call memory_failure_queue() to
> be consistent with general memory failure process, and we could support
> KSM page recovery in the feature.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Looks good to me, thank you.

Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
