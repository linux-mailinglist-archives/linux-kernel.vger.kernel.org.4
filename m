Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B51602904
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJRKJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiJRKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:09:00 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60093868B6;
        Tue, 18 Oct 2022 03:08:59 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id z18so8966867qvn.6;
        Tue, 18 Oct 2022 03:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10SS1JYPy7IO9MTKGwq02lwvA+iKgTwkRVe+FH4lvRo=;
        b=jnhaEEXrgGP37aqmwgv55bFoZyA/nTPNeY8Hq6CE04AIVy3sb9FADeAc6mfunw1JRt
         g31Dx4FN9kKoTLHUYg5bBwPTGJwgNGPTbaV5AsHfAJlz11LPki6J0+WMUT92/H5cnq3t
         KqC6NdVyNdgzEOa+8b2BzASb4dSnQ4NK2wVLgV6b83IcUjcZbACkKJlerswIVm6QPGX3
         3UyrL6Rfo2gGfZYHOSNu9kRWUQgghhUpinyvDwTaqUKnopHwFrOhrWYkeELUOH93yxWQ
         EZMYjiLHjMRrkLNr2fP6PduK4JlKiRS9pFEQAU5ZV/6U+Ntt6lkQNxoIeekm40CV/36Y
         7hMw==
X-Gm-Message-State: ACrzQf0MS+IlpfEQETM652eVYX0nBaQlHMFXsgAjhWuRbO0VLT2z+c1A
        ndWdIgflQ0P3ss/QX/jEhTgToQtIAyZ+8ksYucc=
X-Google-Smtp-Source: AMsMyM4ZirpgfPL5vqKpneme4JM1FdO8p8DWVrkH8kGGiCUhPN8Yl7WGBp6lR9RbNe4ddAHU1+iwDuyJpjcBVX85H8s=
X-Received: by 2002:a05:6214:21e5:b0:4b3:efa6:4b17 with SMTP id
 p5-20020a05621421e500b004b3efa64b17mr1455809qvj.22.1666087738484; Tue, 18 Oct
 2022 03:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220911090635.5559-1-lvjianmin@loongson.cn> <20220911090635.5559-2-lvjianmin@loongson.cn>
 <8e9df8ea-06f0-3989-2563-d5dc6b09a062@huawei.com>
In-Reply-To: <8e9df8ea-06f0-3989-2563-d5dc6b09a062@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Oct 2022 12:08:43 +0200
Message-ID: <CAJZ5v0gBBdTxRkE08PO8W+yi1eTkWqzpGLAyMNuzZmqx02EzFA@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] ACPI / scan: Support multiple dma windows with
 different offsets
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, yangyicong@hisilicon.com,
        lpieralisi@kernel.org, chenhuacai@loongson.cn,
        robin.murphy@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        loongarch@lists.linux.dev, liulongfang <liulongfang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:33 AM Yicong Yang <yangyicong@huawei.com> wrote:
>
> On 2022/9/11 17:06, Jianmin Lv wrote:
> > In DT systems configurations, of_dma_get_range() returns struct
> > bus_dma_region DMA regions; they are used to set-up devices
> > DMA windows with different offset available for translation between DMA
> > address and CPU address.
> >
> > In ACPI systems configuration, acpi_dma_get_range() does not return
> > DMA regions yet and that precludes setting up the dev->dma_range_map
> > pointer and therefore DMA regions with multiple offsets.
> >
> > Update acpi_dma_get_range() to return struct bus_dma_region
> > DMA regions like of_dma_get_range() does.
> >
> > After updating acpi_dma_get_range(), acpi_arch_dma_setup() is changed for
> > ARM64, where the original dma_addr and size are removed as these
> > arguments are now redundant, and pass 0 and U64_MAX for dma_base
> > and size of arch_setup_dma_ops; this is a simplification consistent
> > with what other ACPI architectures also pass to iommu_setup_dma_ops().
> >
>
> Hi,
>
> With this patch we met problem as well. The DMA coherent mask is not set correctly
> for a ehci usb controller and lead to the below calltrace:
>
> [   16.699259] ------------[ cut here ]------------
> [   16.703855] WARNING: CPU: 0 PID: 853 at kernel/dma/mapping.c:499 dma_alloc_attrs+0xc0/0xf0
> [   16.712082] Modules linked in:
> [   16.715124] CPU: 0 PID: 853 Comm: kworker/0:3 Not tainted 6.1.0-rc1-pipe-deadlock+ #5
> [   16.722916] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B211.01 11/10/2021
> [   16.731745] Workqueue: events work_for_cpu_fn
> [   16.736083] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   16.743013] pc : dma_alloc_attrs+0xc0/0xf0
> [   16.747091] lr : dma_pool_alloc+0x11c/0x200
> [   16.751255] sp : ffff80001e46bb50
> [   16.754554] x29: ffff80001e46bb50 x28: 0000000000000000 x27: 0000000000000000
> [   16.761657] x26: ffff80000b33ce18 x25: ffff800009cc6c48 x24: 0000000000000000
> [   16.768759] x23: ffff00208c830918 x22: 0000000000001000 x21: 0000000000000cc0
> [   16.775861] x20: ffff00208ae82080 x19: ffff0020865c40d0 x18: 0000000000000030
> [   16.782964] x17: 626d756e20737562 x16: 2064656e67697373 x15: ffff00208ae82640
> [   16.790066] x14: 0000000000000000 x13: 646e756f72616b72 x12: 6f77204348207379
> [   16.797167] x11: 73706f6e79532067 x10: ffff205f43980000 x9 : ffff80000830b3ac
> [   16.804269] x8 : ffff0020861b1b00 x7 : 0000000000000000 x6 : 0000000000000000
> [   16.811371] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000cc0
> [   16.818472] x2 : ffff00208c830918 x1 : 0000000000001000 x0 : 0000000000000000
> [   16.825574] Call trace:
> [   16.828009]  dma_alloc_attrs+0xc0/0xf0
> [   16.831741]  dma_pool_alloc+0x11c/0x200
> [   16.835559]  ehci_qh_alloc+0x60/0x12c
> [   16.839207]  ehci_setup+0x18c/0x40c
> [   16.842680]  ehci_pci_setup+0xb8/0x680
> [   16.846412]  usb_add_hcd+0x310/0x5c0
> [   16.849973]  usb_hcd_pci_probe+0x254/0x36c
> [   16.854051]  ehci_pci_probe+0x40/0x60
> [   16.857698]  local_pci_probe+0x48/0xb4
> [   16.861431]  work_for_cpu_fn+0x24/0x40
> [   16.865163]  process_one_work+0x1e0/0x450
> [   16.869155]  worker_thread+0x2cc/0x44c
> [   16.872886]  kthread+0x114/0x120
> [   16.876099]  ret_from_fork+0x10/0x20
> [   16.879657] ---[ end trace 0000000000000000 ]---
>
> After reverting this patch the problem resolved. Tested on the latest 6.1-rc1.

OK, I'll queue up a revert of this and one more commit depending on it.

Thanks!
