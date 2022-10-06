Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60335F6A94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiJFP1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiJFP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:27:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CB5BBC454;
        Thu,  6 Oct 2022 08:27:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28A00106F;
        Thu,  6 Oct 2022 08:27:52 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC4623F67D;
        Thu,  6 Oct 2022 08:27:43 -0700 (PDT)
Message-ID: <583c4689-844d-2ae2-79fb-4750b21c4304@arm.com>
Date:   Thu, 6 Oct 2022 16:27:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v4 05/16] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-GB
To:     Jon Hunter <jonathanh@nvidia.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>
References: <cover.1660572783.git.robin.murphy@arm.com>
 <d342b6f27efb5ef3e93aacaa3012d25386d74866.1660572783.git.robin.murphy@arm.com>
 <89d873fc-9f0a-156e-dcf2-48a2b9f93dcc@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <89d873fc-9f0a-156e-dcf2-48a2b9f93dcc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-06 15:01, Jon Hunter wrote:
> Hi Robin,
> 
> On 15/08/2022 17:20, Robin Murphy wrote:
>> Move the bus setup to iommu_device_register(). This should allow
>> bus_iommu_probe() to be correctly replayed for multiple IOMMU instances,
>> and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.
>>
>> At this point we can also handle cleanup better than just rolling back
>> the most-recently-touched bus upon failure - which may release devices
>> owned by other already-registered instances, and still leave devices on
>> other buses with dangling pointers to the failed instance. Now it's easy
>> to clean up the exact footprint of a given instance, no more, no less.
> 
> 
> Since this change, I have noticed that the DRM driver on Tegra20 is 
> failing to probe and I am seeing ...
> 
>   tegra-gr2d 54140000.gr2d: failed to attach to domain: -19
>   drm drm: failed to initialize 54140000.gr2d: -19
> 
> Bisect points to this change and reverting it fixes it. Let me know if 
> you have any thoughts.

Oh, apparently what's happened is that I've inadvertently enabled the 
tegra-gart driver, since it seems that *wasn't* calling bus_set_iommu() 
before. Looking at the history, it appears to have been that way since 
c7e3ca515e78 ("iommu/tegra: gart: Do not register with bus"), so 
essentially that driver has been broken and useless for close to 8 years 
now :(

Given that, I'd be inclined to "fix" it as below, or just give up and 
delete the whole thing.

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 5c5cb5bee8b6..7b3f7fd6e527 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -230,6 +230,7 @@ config TEGRA_IOMMU_GART
  	bool "Tegra GART IOMMU Support"
  	depends on ARCH_TEGRA_2x_SOC
  	depends on TEGRA_MC
+	depends on BROKEN
  	select IOMMU_API
  	help
  	  Enables support for remapping discontiguous physical memory
