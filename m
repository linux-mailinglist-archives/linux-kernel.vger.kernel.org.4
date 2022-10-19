Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC84603B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJSIWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJSIWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:22:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560897CB54;
        Wed, 19 Oct 2022 01:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3FC9B822B1;
        Wed, 19 Oct 2022 08:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4763C433C1;
        Wed, 19 Oct 2022 08:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666167709;
        bh=ZcFAeGx1EwnfKZrHKPUrcfaAFLv6J+3Ph/ReVNboKEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKlG9FYdHnGZXMWbztJX/zTbSLVTaPplGOMsa99WkY4+MlJf39dSEeo9JxvGwQvse
         O3kNszDPaYuZc1VzCbFLp0JskeUfqHmf4tCfv8nqTV97J9hyIJqK4nQcdmi8JCmOF0
         SvAKlA6KnokHWd01qnqDTYJQHa39mbrs1WoRHvVcw1MRxrl8zlWn4uTahbqlh+tZVb
         vU22VYBYgN7Pv862BUMvsaojqKQUCUXAZB/Salt2Iq/53/s/9Mnw0oYUSHyl9aj7Iz
         Hezwvygxd4cRQc0W819j7Ka40CGZFqjY1y09PnKVNfmTglb5uZplbH5vEtt7o63jOt
         6OztPNsGddqTA==
Date:   Wed, 19 Oct 2022 10:21:42 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Yicong Yang <yangyicong@huawei.com>,
        Jianmin Lv <lvjianmin@loongson.cn>, yangyicong@hisilicon.com,
        chenhuacai@loongson.cn, robin.murphy@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        loongarch@lists.linux.dev, liulongfang <liulongfang@huawei.com>
Subject: Re: [PATCH V5 1/2] ACPI / scan: Support multiple dma windows with
 different offsets
Message-ID: <Y0+zlpFPM8+c8oCD@lpieralisi>
References: <20220911090635.5559-1-lvjianmin@loongson.cn>
 <20220911090635.5559-2-lvjianmin@loongson.cn>
 <8e9df8ea-06f0-3989-2563-d5dc6b09a062@huawei.com>
 <CAJZ5v0gBBdTxRkE08PO8W+yi1eTkWqzpGLAyMNuzZmqx02EzFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gBBdTxRkE08PO8W+yi1eTkWqzpGLAyMNuzZmqx02EzFA@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:08:43PM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 18, 2022 at 11:33 AM Yicong Yang <yangyicong@huawei.com> wrote:
> >
> > On 2022/9/11 17:06, Jianmin Lv wrote:
> > > In DT systems configurations, of_dma_get_range() returns struct
> > > bus_dma_region DMA regions; they are used to set-up devices
> > > DMA windows with different offset available for translation between DMA
> > > address and CPU address.
> > >
> > > In ACPI systems configuration, acpi_dma_get_range() does not return
> > > DMA regions yet and that precludes setting up the dev->dma_range_map
> > > pointer and therefore DMA regions with multiple offsets.
> > >
> > > Update acpi_dma_get_range() to return struct bus_dma_region
> > > DMA regions like of_dma_get_range() does.
> > >
> > > After updating acpi_dma_get_range(), acpi_arch_dma_setup() is changed for
> > > ARM64, where the original dma_addr and size are removed as these
> > > arguments are now redundant, and pass 0 and U64_MAX for dma_base
> > > and size of arch_setup_dma_ops; this is a simplification consistent
> > > with what other ACPI architectures also pass to iommu_setup_dma_ops().
> > >
> >
> > Hi,
> >
> > With this patch we met problem as well. The DMA coherent mask is not set correctly
> > for a ehci usb controller and lead to the below calltrace:
> >
> > [   16.699259] ------------[ cut here ]------------
> > [   16.703855] WARNING: CPU: 0 PID: 853 at kernel/dma/mapping.c:499 dma_alloc_attrs+0xc0/0xf0
> > [   16.712082] Modules linked in:
> > [   16.715124] CPU: 0 PID: 853 Comm: kworker/0:3 Not tainted 6.1.0-rc1-pipe-deadlock+ #5
> > [   16.722916] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B211.01 11/10/2021
> > [   16.731745] Workqueue: events work_for_cpu_fn
> > [   16.736083] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [   16.743013] pc : dma_alloc_attrs+0xc0/0xf0
> > [   16.747091] lr : dma_pool_alloc+0x11c/0x200
> > [   16.751255] sp : ffff80001e46bb50
> > [   16.754554] x29: ffff80001e46bb50 x28: 0000000000000000 x27: 0000000000000000
> > [   16.761657] x26: ffff80000b33ce18 x25: ffff800009cc6c48 x24: 0000000000000000
> > [   16.768759] x23: ffff00208c830918 x22: 0000000000001000 x21: 0000000000000cc0
> > [   16.775861] x20: ffff00208ae82080 x19: ffff0020865c40d0 x18: 0000000000000030
> > [   16.782964] x17: 626d756e20737562 x16: 2064656e67697373 x15: ffff00208ae82640
> > [   16.790066] x14: 0000000000000000 x13: 646e756f72616b72 x12: 6f77204348207379
> > [   16.797167] x11: 73706f6e79532067 x10: ffff205f43980000 x9 : ffff80000830b3ac
> > [   16.804269] x8 : ffff0020861b1b00 x7 : 0000000000000000 x6 : 0000000000000000
> > [   16.811371] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000cc0
> > [   16.818472] x2 : ffff00208c830918 x1 : 0000000000001000 x0 : 0000000000000000
> > [   16.825574] Call trace:
> > [   16.828009]  dma_alloc_attrs+0xc0/0xf0
> > [   16.831741]  dma_pool_alloc+0x11c/0x200
> > [   16.835559]  ehci_qh_alloc+0x60/0x12c
> > [   16.839207]  ehci_setup+0x18c/0x40c
> > [   16.842680]  ehci_pci_setup+0xb8/0x680
> > [   16.846412]  usb_add_hcd+0x310/0x5c0
> > [   16.849973]  usb_hcd_pci_probe+0x254/0x36c
> > [   16.854051]  ehci_pci_probe+0x40/0x60
> > [   16.857698]  local_pci_probe+0x48/0xb4
> > [   16.861431]  work_for_cpu_fn+0x24/0x40
> > [   16.865163]  process_one_work+0x1e0/0x450
> > [   16.869155]  worker_thread+0x2cc/0x44c
> > [   16.872886]  kthread+0x114/0x120
> > [   16.876099]  ret_from_fork+0x10/0x20
> > [   16.879657] ---[ end trace 0000000000000000 ]---
> >
> > After reverting this patch the problem resolved. Tested on the latest 6.1-rc1.
> 
> OK, I'll queue up a revert of this and one more commit depending on it.

Hi Rafael,

there is a fix in the making (you probably noticed):

https://lore.kernel.org/linux-acpi/e94f99cfe09a64c590f009d21c566339117394e2.1666098844.git.robin.murphy@arm.com
	
please don't queue up a revert yet.

Thanks,
Lorenzo
