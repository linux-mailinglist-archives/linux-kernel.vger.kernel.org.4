Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E316860BD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjBAHgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBAHgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:36:41 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87AB11140
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:36:39 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4b718cab0e4so234560587b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx1zARWQRp48CZ4kQ2x9yqFjiGpyMZcTuGlBFtRENQ8=;
        b=BRlZce3Mvkorg1JlE2Wn1RlKnSRnE2Kv+cjMHl7bPVvhXBvI3EsEGNQCBqfTULNHfs
         OIJaUMb6Lw1Mrjv7rhACXJIw2oT0RUBMdRxVbqhZ38hOC7RnHuFHmiIBfggjs1v7OSZs
         F1IaLNom6Wq0vQiiSCyhsQFpTNVL2ictpQ3UYV7RfWWHEV4BbLb2NFc9Bl8kA9VFQvpj
         yYIrvgho2njaNqV43HIQ+d1ZdBvnmUj1O3494UXIkt6Jhy4xtt47j8vwxyNlDfhC7Uvq
         PJHcTwVdYnDDWTIUX/jtU76HRoMlKspKWbZIDsInfk/ZA4DSSsdkCQeMezIVBj6ji1UJ
         zTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dx1zARWQRp48CZ4kQ2x9yqFjiGpyMZcTuGlBFtRENQ8=;
        b=gqkVaHNYc2j5G57AgUi7bYUW6iY7OVjEEj4ZDQJ81NsfYSV1WYFbyGaOxbOz/hjWCk
         CquGVCt8IqaeNjYmZqcMghkPXR33xxu2QwUfqD/c3tQNxhlj7490kkcufzjCHYl0f6L0
         k/Frt8kGxAJWkFUbTQKDXrQ/+JcPBxvZXj4JUSKFxz990+BVZSKiDpG1aNfEgGquejAt
         DBxpvgLI1pbF+6PGwoNW2uKXRlyiN9aQBAq8qOc3Yto0UO364dHpO3Tpn9DfQbt+6p4N
         lUAYlj9WFvUgr2Nq+IJpD1vdkRajSydCbCVJPsO4GWK+zI/JMdTVrThUVTi7BJNbVMvj
         3UMg==
X-Gm-Message-State: AO0yUKWbT3dISy6LlZy8Apjw41YqgQ0MhvdoI2UZTq7uq3Vo25xwiQio
        +5kC/xcWUrGN4oLBvvXO6QpeqwbFFv1HRZlR/ApoFA==
X-Google-Smtp-Source: AK7set9m5+elP4l199y4Ungn8cTJMrhmcu+zMRDCt/0pfgHMmTXjacsBA6C+zGyfsSND4y7wWAZyPtDwbItCigzngy0=
X-Received: by 2002:a0d:c046:0:b0:517:b161:1f4d with SMTP id
 b67-20020a0dc046000000b00517b1611f4dmr146538ywd.399.1675236998861; Tue, 31
 Jan 2023 23:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20221101222520.never.109-kees@kernel.org> <20221101223321.1326815-5-keescook@chromium.org>
In-Reply-To: <20221101223321.1326815-5-keescook@chromium.org>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Wed, 1 Feb 2023 15:36:08 +0800
Message-ID: <CAMSo37W3gRkP02tSCxGX71ZDAt3WgPZrkTRTM6J1iQ4gvUS9vg@mail.gmail.com>
Subject: Re: [PATCH 5/6] driver core: Add __alloc_size hint to devm allocators
To:     Kees Cook <keescook@chromium.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kees

This change causes "Kernel panic - not syncing: BRK handler: Fatal exception"
for the android-mainline based hikey960 build, with this commit reverted,
there is no problem for the build to boot to the homescreen.
Not sure if you have any idea about it and give some suggestions.

Here is part of the kernel panic log:

    [    9.479878][  T122] ueventd: Loading module
/vendor/lib/modules/spi-pl022.ko with args ''
    [    9.480276][  T115] apexd-bootstrap: Pre-allocated loop device 29
    [    9.480517][  T123] ueventd: LoadWithAliases was unable to load
of:Nhi3660_i2sT(null)Chisilicon,hi3660-i2s-1.0
    [    9.480632][  T121] Unexpected kernel BRK exception at EL1
    [    9.480637][  T121] Internal error: BRK handler:
00000000f2000001 [#1] PREEMPT SMP
    [    9.480644][  T121] Modules linked in: cpufreq_dt(E+)
hisi_thermal(E+) phy_hi3660_usb3(E) btqca(E) hi6421_pmic_core(E)
btbcm(E) spi_pl022(E) hi3660_mailbox(E) i2c_designware_platform(E)
mali_kbase(OE) dw_mmc_k3(E) bluetooth(E) dw_mmc_pltfm(E) dw_mmc(E)
kirin_drm(E) rfkill(E) kirin_dsi(E) i2c_designware_core(E) k3dma(E)
drm_dma_helper(E) cma_heap(E) system_heap(E)
    [    9.480688][  T121] CPU: 4 PID: 121 Comm: ueventd Tainted: G
       OE      6.2.0-rc6-mainline-14196-g1d9f94ec75b9 #1
    [    9.480694][  T121] Hardware name: HiKey960 (DT)
    [    9.480697][  T121] pstate: 20400005 (nzCv daif +PAN -UAO -TCO
-DIT -SSBS BTYPE=--)
    [    9.480703][  T121] pc : hi3660_thermal_probe+0x6c/0x74 [hisi_thermal]
    [    9.480722][  T121] lr : hi3660_thermal_probe+0x38/0x74 [hisi_thermal]
    [    9.480733][  T121] sp : ffffffc00aa13700
    [    9.480735][  T121] x29: ffffffc00aa13700 x28: 0000007ff8ae8531
x27: 00000000000008c0
    [    9.480743][  T121] x26: ffffffc00aa2a300 x25: ffffffc00aa2ab40
x24: 000000000000001d
    [    9.480749][  T121] x23: ffffffc00a29d000 x22: 0000000000000000
x21: ffffff8001fa4a80
    [    9.480755][  T121] x20: 0000000000000001 x19: ffffff8001fa4a80
x18: ffffffc00a8810b0
    [    9.480761][  T121] x17: 000000007ab542f2 x16: 000000007ab542f2
x15: ffffffc00aa01000
    [    9.480767][  T121] x14: ffffffc00966f250 x13: ffffffc0b58f9000
x12: ffffffc00a055f10
    [    9.480771][  T123] ueventd: LoadWithAliases was unable to load
cpu:type:aarch64:feature:,0000,0001,0002,0003,0004,0005,0006,0007,000B
    [    9.480773][  T121]
    [    9.480774][  T121] x11: 0000000000000000 x10: 0000000000000001
x9 : 0000000100000000
    [    9.480780][  T123] ueventd:
    [    9.480780][  T121] x8 : ffffffc0044154cb x7 : 0000000000000000
x6 : 000000000000003f
    [    9.480786][  T121] x5 : 0000000000000020 x4 : ffffffc0098db323
x3 : ffffff801aeb62c0
    [    9.480792][  T121] x2 : ffffff801aeb62c0 x1 : 0000000000000000
x0 : ffffff8001fa4c80
    [    9.480798][  T121] Call trace:
    [    9.480801][  T121]  hi3660_thermal_probe+0x6c/0x74 [hisi_thermal]
    [    9.480813][  T121]  hisi_thermal_probe+0xbc/0x284 [hisi_thermal]
    [    9.480823][  T121]  platform_probe+0xcc/0xf8
    [    9.480836][  T121]  really_probe+0x19c/0x390
    [    9.480842][  T121]  __driver_probe_device+0xc0/0xf0
    [    9.480848][  T121]  driver_probe_device+0x4c/0x228
    [    9.480853][  T121]  __driver_attach+0x110/0x1e0
    [    9.480858][  T121]  bus_for_each_dev+0xa0/0xf4
    [    9.480864][  T121]  driver_attach+0x2c/0x40
    [    9.480868][  T121]  bus_add_driver+0x118/0x208
    [    9.480873][  T121]  driver_register+0x80/0x124
    [    9.480878][  T121]  __platform_driver_register+0x2c/0x40
    [    9.480884][  T121]  init_module+0x28/0xfe4 [hisi_thermal]
    [    9.480895][  T121]  do_one_initcall+0xe4/0x334
    [    9.480902][  T121]  do_init_module+0x50/0x1f0
    [    9.480909][  T121]  load_module+0x1034/0x1204
    [    9.480914][  T121]  __arm64_sys_finit_module+0xc8/0x11c
    [    9.480919][  T121]  invoke_syscall+0x60/0x130
    [    9.480926][  T121]  el0_svc_common+0xbc/0x100
    [    9.480931][  T121]  do_el0_svc+0x38/0xc4
    [    9.480937][  T121]  el0_svc+0x34/0xc4
    [    9.480945][  T121]  el0t_64_sync_handler+0x8c/0xfc
    [    9.480950][  T121]  el0t_64_sync+0x1a4/0x1a8
    [    9.480957][  T121] Code: 91132d08 b9001814 f9000013 f9000808 (d4200020)
    [    9.480960][  T121] ---[ end trace 0000000000000000 ]---
    [    9.482201][   T72] dwmmc_k3 ff37f000.dwmmc1: IDMAC supports
64-bit address mode.
    [    9.482225][   T72] dwmmc_k3 ff37f000.dwmmc1: Using internal
DMA controller.
    [    9.482232][   T72] dwmmc_k3 ff37f000.dwmmc1: Version ID is 270a
    [    9.482261][   T72] dwmmc_k3 ff37f000.dwmmc1: DW MMC controller
at irq 72,32 bit host data width,128 deep fifo
    [    9.482406][  T117] cpu cpu0: EM: created perf domain
    [    9.482677][  T118] ueventd: Loaded kernel module
/vendor/lib/modules/btqca.ko
    [    9.482745][  T118] ueventd: Loading module
/vendor/lib/modules/hci_uart.ko with args ''
    [    9.483117][  T117] cpu cpu4: EM: created perf domain
    [    9.483767][  T117] ueventd: Loaded kernel module
/vendor/lib/modules/cpufreq-dt.ko
    [    9.484265][   T72] dwmmc_k3 ff37f000.dwmmc1: fifo-depth
property not found, using value of FIFOTH register as default
    [    9.484326][  T117] ueventd: LoadWithAliases was unable to load
cpu:type:aarch64:feature:,0000,0001,0002,0003,0004,0005,0006,0007,000B
    [    9.484335][  T117] ueventd:
    [    9.486508][   T72] dwmmc_k3 ff37f000.dwmmc1: IDMAC supports
64-bit address mode.
    [    9.486564][   T72] dwmmc_k3 ff37f000.dwmmc1: Using internal
DMA controller.
    [    9.486572][   T72] dwmmc_k3 ff37f000.dwmmc1: Version ID is 270a
    [    9.486620][   T72] dwmmc_k3 ff37f000.dwmmc1: DW MMC controller
at irq 72,32 bit host data width,64 deep fifo
    [    9.488281][  T121] Kernel panic - not syncing: BRK handler:
Fatal exception

for the full serial console log, please check here:
    http://ix.io/4mLg

Thanks,
Yongqin Liu
On Wed, 2 Nov 2022 at 06:34, Kees Cook <keescook@chromium.org> wrote:
>
> Mark the devm_*alloc()-family of allocations with appropriate
> __alloc_size()/__realloc_size() hints so the compiler can attempt to
> reason about buffer lengths from allocations.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Won Chung <wonchung@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://lore.kernel.org/r/20221029074734.gonna.276-kees@kernel.org
> ---
> This is already in -next, but I'm including it here again to avoid any
> confusion about this series landing (or being tested) via another tree.
> ---
>  include/linux/device.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 424b55df0272..5e4cd857e74f 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -197,9 +197,9 @@ void devres_remove_group(struct device *dev, void *id);
>  int devres_release_group(struct device *dev, void *id);
>
>  /* managed devm_k.alloc/kfree for device drivers */
> -void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __malloc;
> +void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __alloc_size(2);
>  void *devm_krealloc(struct device *dev, void *ptr, size_t size,
> -                   gfp_t gfp) __must_check;
> +                   gfp_t gfp) __must_check __realloc_size(3);
>  __printf(3, 0) char *devm_kvasprintf(struct device *dev, gfp_t gfp,
>                                      const char *fmt, va_list ap) __malloc;
>  __printf(3, 4) char *devm_kasprintf(struct device *dev, gfp_t gfp,
> @@ -226,7 +226,8 @@ static inline void *devm_kcalloc(struct device *dev,
>  void devm_kfree(struct device *dev, const void *p);
>  char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
>  const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
> -void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp);
> +void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp)
> +       __realloc_size(3);
>
>  unsigned long devm_get_free_pages(struct device *dev,
>                                   gfp_t gfp_mask, unsigned int order);
> --
> 2.34.1
>


-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
