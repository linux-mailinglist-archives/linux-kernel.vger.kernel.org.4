Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3249A622468
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiKIHGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKIHGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:06:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669861E3C1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 23:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667977562; x=1699513562;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KoL9bh+OZDE2qfWgGP9kJQPzoKxI/vr8/BhK/mLkjcs=;
  b=U+8P6x+UD75QzDKWnm1zTBgzXwmiuocl5o+EpRCF3WOKaPW/ALIknVzZ
   F8MRbGToHAEzB8ByEBBAnTzeaK1Vb0y39iW3DG1IGXQ1zLcIILyvZE+6L
   vQuKlhwLHITCpXEFSol2ZBdnLENP6PPM853bizEQD2vZ7vvXx2vZr+8eQ
   M3arILgyvf/j8ubBKvrUSPvv9sk89wyTdvUJ2f9A+3qgLhbxj4jfHr9Cn
   gGUBC2r5OG0ZejAkGVKqHaUpqpzjhslJhMRKlYBLWWQSANICKwUx08R3B
   xzWMEt3C+94pu/9zhEfphydGGUJZ19M3lywC78Ok+AW/HCaDKjOwcbVyq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="291296105"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="291296105"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 23:06:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="742280776"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="742280776"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.213]) ([10.254.211.213])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 23:05:59 -0800
Message-ID: <dc463b3e-2875-8aac-aca1-edacb90e5650@linux.intel.com>
Date:   Wed, 9 Nov 2022 15:05:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Cc:     baolu.lu@linux.intel.com, konrad.wilk@oracle.com,
        harshit.m.mogalapalli@gmail.com,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] iommu/vt-d: set default value of INTEL_IOMMU_FLOPPY_WA to n
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20221108125855.2984751-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221108125855.2984751-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/8 20:58, Harshit Mogalapalli wrote:
> It is likely that modern intel motherboard will not ship with a
> floppy connection anymore, so let us disable it by default, as it
> gets turned on when we do a make defconfig.
> 
> Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
>   drivers/iommu/intel/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index b7dff5092fd2..c783ae85ca9b 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -76,7 +76,7 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>   	  option is removed in the 2.6.32 kernel.
>   
>   config INTEL_IOMMU_FLOPPY_WA
> -	def_bool y
> +	def_bool n
>   	depends on X86
>   	help
>   	  Floppy disk drivers are known to bypass DMA API calls

Nobody selects or depends on this. How about removing this bool? Only
less than 10 lines of code are impacted and are not in any performance
path.

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index b7dff5092fd2..5e077d1c5f5d 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
  	  to use physical addresses for DMA, at least until this
  	  option is removed in the 2.6.32 kernel.

-config INTEL_IOMMU_FLOPPY_WA
-	def_bool y
-	depends on X86
-	help
-	  Floppy disk drivers are known to bypass DMA API calls
-	  thereby failing to work when IOMMU is enabled. This
-	  workaround will setup a 1:1 mapping for the first
-	  16MiB to make floppy (an ISA device) work.
-
  config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
  	bool "Enable Intel IOMMU scalable mode by default"
  	default y
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 48cdcd0a5cf3..22801850f339 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4567,7 +4567,6 @@ static void intel_iommu_get_resv_regions(struct 
device *device,
  	}
  	rcu_read_unlock();

-#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
  	if (dev_is_pci(device)) {
  		struct pci_dev *pdev = to_pci_dev(device);

@@ -4579,7 +4578,6 @@ static void intel_iommu_get_resv_regions(struct 
device *device,
  				list_add_tail(&reg->list, head);
  		}
  	}
-#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */

  	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
  				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,

Best regards,
baolu
