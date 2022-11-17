Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB1462D4F0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbiKQIYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239414AbiKQIYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:24:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F2F6DCF8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:24:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F91C620FE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2FBC433C1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668673483;
        bh=ILRX15KGqyKu8+u5JNGQ2tQtPbAfM+RA/0Wr4Ct0E5g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LfTwAska/uNn2Ts5/GBMxSUyEAwR85VG0H0k5urLduOIjpWzihUcd1wVwh8Gvxsud
         Zbx+3CdONTPpzbi5lyhKwKDepg2j05zcvooUed0D56pQru/FdAclZB7BS3gnr42UCM
         oP7x6rkKmJIzrrnT3QdkjnLD8ueperIcqsc8j7neOhi9MAWlx4ENrryoQcHjiiSPBO
         j/4QYwsspLZYM+IHAM5OiQ5gGrXviptuP98z2T0KRRtxiYdSwM/nFLZuCHyS9qShko
         0eVNlXNi+HU5GiUGsxzTtOSPPwq1RxU4WeCXIfpOKtkrjUQrDVKTfisT5+V/xfgo6m
         YS8itPG7owZmw==
Received: by mail-lj1-f169.google.com with SMTP id x21so1725532ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:24:43 -0800 (PST)
X-Gm-Message-State: ANoB5pnN7RVMFb1oGWmRWngSm+o8FohH0YIoZ1AqzeqKf9YPUsL8FakJ
        1QlVDXeBpQNu7MSsiX5Vl36NqESL98Te5q+if9o=
X-Google-Smtp-Source: AA0mqf5p/fpwnigRIvEHgbP88nKwFZfw+UWEOFWGA6o/3zQAQwQ/qCHyrKB1nW95XzjzAlj4m1WGgQ2LZ0+uBLo2wyw=
X-Received: by 2002:a05:651c:1601:b0:277:3a1:e86d with SMTP id
 f1-20020a05651c160100b0027703a1e86dmr695741ljq.152.1668673481480; Thu, 17 Nov
 2022 00:24:41 -0800 (PST)
MIME-Version: 1.0
References: <20221117072100.2720512-1-sunnanyong@huawei.com>
In-Reply-To: <20221117072100.2720512-1-sunnanyong@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 17 Nov 2022 09:24:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXENCa5TK9EnRa9Mtn+xGLrnV_X0sAkTC64GVOShDsTK1Q@mail.gmail.com>
Message-ID: <CAMj1kXENCa5TK9EnRa9Mtn+xGLrnV_X0sAkTC64GVOShDsTK1Q@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64: mm: Add invalidate back in arch_sync_dma_for_device
 when FROM_DEVICE
To:     Nanyong Sun <sunnanyong@huawei.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, sstabellini@kernel.org,
        robin.murphy@arm.com, jgross@suse.com,
        oleksandr_tyshchenko@epam.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 at 07:33, Nanyong Sun <sunnanyong@huawei.com> wrote:
>
> The commit c50f11c6196f ("arm64: mm: Don't invalidate FROM_DEVICE
> buffers at start of DMA transfer") replaces invalidate with clean
> when DMA_FROM_DEVICE, this changes the behavior of functions like
> dma_map_single() and dma_sync_single_for_device(*, *, *, DMA_FROM_DEVICE),
> then it may make some drivers works unwell because the implementation
> of these DMA APIs lose the original cache invalidation.
>
> Situation 1:
...
> Situation 2:
> After backporting the above commit, we find a network card driver go
> wrong with cache inconsistency when doing DMA transfer: CPU got the
> stale data in cache when reading DMA data received from device.

I suppose this means those drivers may lack dma_sync_single_for_cpu()
calls after the inbound transfers complete, and are instead relying on
the cache invalidation performed before the transfer to make the DMA'd
data visible to the CPU.

This is buggy and fragile, and should be fixed in any case. There is
no guarantee that the CPU will not preload parts of the buffer into
the cache while DMA is in progress, so the invalidation must occur
strictly after the device has finished transferring the data.

> A similar phenomenon happens on sata disk drivers, it involves
> mainline modules like libata, scsi, ahci etc, and is hard to find
> out which line of code results in the error.
>

Could you identify the actual hardware and drivers that you are
observing the issue on? Claiming that everything is broken is not very
helpful in narrowing it down (although I am not saying you are wrong
:-))

> It seems that some dirvers may go wrong and have to match the
> implementation changes of the DMA APIs, and it would be confused
> because the behavior of these DMA APIs on arm64 are different
> from other archs.
>
> Add invalidate back in arch_sync_dma_for_device() to keep drivers
> compatible by replace dcache_clean_poc with dcache_clean_inval_poc
> when DMA_FROM_DEVICE.
>

So notably, the patch in question removes cache invalidation *without*
clean, and what you are adding here is clean+invalidate. (Invalidation
without clean may undo the effect of, e.g., the memzero() of a secret
in memory, and so it is important that we don't add that back if we
can avoid it)

Since we won't lose the benefits of that change, incorporating
invalidation at this point should be fine: clean+invalidate shouldn't
be more expensive than clean, and [correctly written] drivers will
invalidate those lines anyway, as the data has to come from DRAM in
any case.

So unless fixing the drivers in question is feasible, this change
seems reasonable to me.


> Fixes: c50f11c6196f ("arm64: mm: Don't invalidate FROM_DEVICE buffers at start of DMA transfer")
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 3cb101e8cb29..07f6a3089c64 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -18,7 +18,10 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
>  {
>         unsigned long start = (unsigned long)phys_to_virt(paddr);
>
> -       dcache_clean_poc(start, start + size);
> +       if (dir == DMA_FROM_DEVICE)
> +               dcache_clean_inval_poc(start, start + size);
> +       else
> +               dcache_clean_poc(start, start + size);
>  }
>
>  void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
> --
> 2.25.1
>
