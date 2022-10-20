Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1372605BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJTKDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJTKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:02:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DC8A17579C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:02:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 075DCED1;
        Thu, 20 Oct 2022 03:02:39 -0700 (PDT)
Received: from [10.57.5.187] (unknown [10.57.5.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60FF93F792;
        Thu, 20 Oct 2022 03:02:30 -0700 (PDT)
Message-ID: <5933d917-a026-7150-2e05-2cb283a73174@arm.com>
Date:   Thu, 20 Oct 2022 11:02:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: 6.1-rc1 regression: bisected to 57365a04c921 iommu: Move bus
 setup to IOMMU device registration
Content-Language: en-GB
To:     Brian Norris <briannorris@chromium.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <Y1CHh2oM5wyHs06J@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y1CHh2oM5wyHs06J@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-20 00:25, Brian Norris wrote:
> Hi all,
> 
> I'm testing out asynchronous probe (that's, kernel cmdline
> 'driver_async_probe=*' or similar), and I've identified a regression in
> v6.1-rc1 due to this:
> 
> commit 57365a04c92126525a58bf7a1599ddfa832415e9
> Author: Robin Murphy <robin.murphy@arm.com>
> Date:   Mon Aug 15 17:20:06 2022 +0100
> 
>      iommu: Move bus setup to IOMMU device registration
> 
> In particular, I'm testing a Rockchip RK3399 system with
> 'driver_async_probe=rk_iommu', and finding I crash like this:
> 
> [    0.180480] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> ...
> [    0.180583] CPU: 2 PID: 49 Comm: kworker/u12:1 Not tainted 6.1.0-rc1 #57
> [    0.180593] Hardware name: Google Scarlet (DT)
> [    0.180602] Workqueue: events_unbound async_run_entry_fn
> [    0.180622] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.180632] pc : dev_iommu_free+0x24/0x54
> [    0.180644] lr : __iommu_probe_device+0x110/0x180
> ...
> [    0.180785] Call trace:
> [    0.180791]  dev_iommu_free+0x24/0x54
> [    0.180800]  __iommu_probe_device+0x110/0x180
> [    0.180807]  probe_iommu_group+0x40/0x58
> [    0.180816]  bus_for_each_dev+0x8c/0xd8
> [    0.180829]  bus_iommu_probe+0x5c/0x2d0
> [    0.180840]  iommu_device_register+0xbc/0x104
> [    0.180851]  rk_iommu_probe+0x260/0x354
> [    0.180861]  platform_probe+0xb4/0xd4
> [    0.180872]  really_probe+0xfc/0x284
> [    0.180884]  __driver_probe_device+0xc0/0xec
> [    0.180894]  driver_probe_device+0x4c/0xd4
> [    0.180905]  __driver_attach_async_helper+0x3c/0x60
> [    0.180915]  async_run_entry_fn+0x34/0xd4
> [    0.180926]  process_one_work+0x1e0/0x3b4
> [    0.180936]  worker_thread+0x120/0x404
> [    0.180942] [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
> [    0.180944]  kthread+0xf4/0x14c
> [    0.180953]  ret_from_fork+0x10/0x20
> [    0.180968] Code: f9000bf3 910003fd f9416c13 f9016c1f (f9401a68)
> [    0.180981] ---[ end trace 0000000000000000 ]---

Hmm, on the face of it that callstack doesn't even make much sense -
dev_iommu_free+0x24 presumably has to be the dereference of
param->fwspec, but __iommu_probe_device can only hit that failure path
after a successful dev_iommu_get(), so dev->iommu should not be NULL.

> I find if I revert the above commit (and 29e932295bfa ("iommu: Clean up
> bus_set_iommu()"), to keep the reverts clean), things start working again.
> 
> I haven't worked out exactly what's going wrong, but the patch looks like it
> isn't async safe at all, due to the way each device is poking (without locking)
> at the global iommu_buses[].

We shouldn't really need locking for iommu_buses itself, but I guess to
support async probe we would need per-device locking in
iommu_probe_device() to prevent multiple threads trying to probe the
same device at once, which must be what's happening in your case to
cause a double-dev_iommu_free(). I'll see what I can do ASAP, since I
think that's worthwhile. In the meantime, as to why you're hitting the
failure path at all, I think that's another subtle oversight on my part,
does something like the diff below help?

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4f2039789897..00fc57c86ea4 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1163,6 +1163,14 @@ static struct iommu_group *rk_iommu_device_group(struct device *dev)
  
  	iommu = rk_iommu_from_dev(dev);
  
+	/*
+	 * Use the first registered IOMMU device for domain to use with DMA
+	 * API, since a domain might not physically correspond to a single
+	 * IOMMU device..
+	 */
+	if (!dma_dev)
+		dma_dev = iommu->dev;
+
  	return iommu_group_ref_get(iommu->group);
  }
  
@@ -1293,14 +1301,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
  	if (err)
  		goto err_remove_sysfs;
  
-	/*
-	 * Use the first registered IOMMU device for domain to use with DMA
-	 * API, since a domain might not physically correspond to a single
-	 * IOMMU device..
-	 */
-	if (!dma_dev)
-		dma_dev = &pdev->dev;
-
  	pm_runtime_enable(dev);
  
  	for (i = 0; i < iommu->num_irq; i++) {
