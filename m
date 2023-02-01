Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76331685C2C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 01:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjBAAcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 19:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBAAcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 19:32:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DDC530CB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:32:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EF376174E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F431C433D2;
        Wed,  1 Feb 2023 00:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675211525;
        bh=PC5yQB77oK31WqmkfHnumQayq11crcBL2x05R3KZ/jo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eM7d9f3yIifo5Vnn8aCiNI/6u7IUTKp3GPkBvFDqVGPAoz4cQWOtWZUTptCOxkzaE
         t/AVdKH6BRMb5H/svi/a1maEveOSR5ehDkOR4+YhySclWTbDJjvQx6/e03NCBhAh2V
         boev5JpeCML2iltM0x8FScbAAkhNAhBGRiKJKZ5c=
Date:   Tue, 31 Jan 2023 16:32:04 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH -next resend v3] mm: hwposion: support recovery from
 ksm_might_need_to_copy()
Message-Id: <20230131163204.2c511663bfece90d56121cc6@linux-foundation.org>
In-Reply-To: <20221213120523.141588-1-wangkefeng.wang@huawei.com>
References: <20221213030557.143432-1-wangkefeng.wang@huawei.com>
        <20221213120523.141588-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 20:05:23 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> When the kernel copy a page from ksm_might_need_to_copy(), but runs
> into an uncorrectable error, it will crash since poisoned page is
> consumed by kernel, this is similar to Copy-on-write poison recovery,
> When an error is detected during the page copy, return VM_FAULT_HWPOISON
> in do_swap_page(), and install a hwpoison entry in unuse_pte() when
> swapoff, which help us to avoid system crash. Note, memory failure on
> a KSM page will be skipped, but still call memory_failure_queue() to
> be consistent with general memory failure process.

I believe we're awaiting a v4 of this?

Did we consider a -stable backport?  "kernel crash" sounds undesirable...

Can we identify a Fixes: target for this?

Thanks.
