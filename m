Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2A2667274
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjALMnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjALMnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:43:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46249CD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673527379; x=1705063379;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZFY+bXP/h/GOiSCdT8CnGT2LBALR/Biax2Bq3CNA3Ec=;
  b=A6WqO34I5Y+wz0kvSS+1DoFz9BP9fgk5Cdf83sLMrj2DiX1qdzkBZ1iV
   ZvQBiKNDRIN4WXPYGgBheUqpam2y/yCrGmTXk6GO2o1B6qQ1oaKx+mJJn
   Bu5kgqBTpW2iu1FFao7sOT2wh1xrazWLMGjEjgC9HyHLjWHZb0GtssvVt
   QG/imwjYyDIxsZjkJvUznV+0P03fXLf68d2hzNqhJJxeX7rPQltH8Gbk3
   j4hT0LcEt9Rqrd/B//zfnvzdywfNczpZPaJGdonkW93FbA/iMj3OKb/u5
   I0aTdi/KLHz6lNAKkbdNZd6H78I8saASDHo3/u9gKJLHYUywA0fXPso8T
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10587"; a="409934362"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="409934362"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 04:42:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10587"; a="903186721"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="903186721"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.188.101]) ([10.252.188.101])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 04:42:56 -0800
Message-ID: <367345ad-33cc-2268-63e1-979299d42c2e@linux.intel.com>
Date:   Thu, 12 Jan 2023 20:42:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com
Subject: Re: [PATCH 1/7] iommu/vt-d: Support size of the register set in DRHD
Content-Language: en-US
To:     kan.liang@linux.intel.com, joro@8bytes.org, will@kernel.org,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230111202504.378258-1-kan.liang@linux.intel.com>
 <20230111202504.378258-2-kan.liang@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230111202504.378258-2-kan.liang@linux.intel.com>
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

On 2023/1/12 4:24, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A new field, which indicates the size of the remapping hardware register
> set for this remapping unit, is introduced in the DMA-remapping hardware
> unit definition (DRHD) structure with the VT-d Spec 4.0.
> With the information, SW doesn't need to 'guess' the size of the
> register set anymore.
> 
> Update the struct acpi_dmar_hardware_unit to reflect the field.
> 
> Store the size of the register set in struct dmar_drhd_unit for each
> dmar device.
> 
> The 'size' information is ResvZ for the old BIOS and platforms. Fall
> back to the old guessing method. There is nothing changed.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c | 25 ++++++++++++++++++-------
>   include/acpi/actbl1.h      |  2 +-
>   include/linux/dmar.h       |  1 +
>   3 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index b00a0ceb2d13..6a411d964474 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -399,6 +399,13 @@ dmar_find_dmaru(struct acpi_dmar_hardware_unit *drhd)
>   	return NULL;
>   }
>   
> +/* The size of the register set is 2 ^ N 4 KB pages. */
> +static unsigned long
> +dmar_get_drhd_reg_size(u8 npages)

No need to divide it into two lines. Or put this line of code directly
where it is called?

> +{
> +	return 1UL << (npages + 12);
> +}
> +
>   /*
>    * dmar_parse_one_drhd - parses exactly one DMA remapping hardware definition
>    * structure which uniquely represent one DMA remapping hardware unit
> @@ -427,6 +434,7 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
>   	memcpy(dmaru->hdr, header, header->length);
>   	dmaru->reg_base_addr = drhd->address;
>   	dmaru->segment = drhd->segment;
> +	dmaru->reg_size = dmar_get_drhd_reg_size(drhd->size);
>   	dmaru->include_all = drhd->flags & 0x1; /* BIT0: INCLUDE_ALL */
>   	dmaru->devices = dmar_alloc_dev_scope((void *)(drhd + 1),
>   					      ((void *)drhd) + drhd->header.length,
> @@ -880,6 +888,7 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
>   	struct acpi_dmar_hardware_unit *drhd;
>   	void __iomem *addr;
>   	u64 cap, ecap;
> +	unsigned long size;
>   
>   	drhd = (void *)entry;
>   	if (!drhd->address) {
> @@ -887,10 +896,11 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
>   		return -EINVAL;
>   	}
>   
> +	size = dmar_get_drhd_reg_size(drhd->size);
>   	if (arg)
> -		addr = ioremap(drhd->address, VTD_PAGE_SIZE);
> +		addr = ioremap(drhd->address, size);
>   	else
> -		addr = early_ioremap(drhd->address, VTD_PAGE_SIZE);
> +		addr = early_ioremap(drhd->address, size);
>   	if (!addr) {
>   		pr_warn("Can't validate DRHD address: %llx\n", drhd->address);
>   		return -EINVAL;
> @@ -902,7 +912,7 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
>   	if (arg)
>   		iounmap(addr);
>   	else
> -		early_iounmap(addr, VTD_PAGE_SIZE);
> +		early_iounmap(addr, size);
>   
>   	if (cap == (uint64_t)-1 && ecap == (uint64_t)-1) {
>   		warn_invalid_dmar(drhd->address, " returns all ones");

The cap and ecap registers are always in the first page. Just map one
4K page is enough. There is no need to change it?

> @@ -956,17 +966,18 @@ static void unmap_iommu(struct intel_iommu *iommu)
>   /**
>    * map_iommu: map the iommu's registers
>    * @iommu: the iommu to map
> - * @phys_addr: the physical address of the base resgister
> + * @drhd: DMA remapping hardware definition structure
>    *
>    * Memory map the iommu's registers.  Start w/ a single page, and
>    * possibly expand if that turns out to be insufficent.
>    */
> -static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
> +static int map_iommu(struct intel_iommu *iommu, struct dmar_drhd_unit *drhd)
>   {
> +	u64 phys_addr = drhd->reg_base_addr;
>   	int map_size, err=0;
>   
>   	iommu->reg_phys = phys_addr;
> -	iommu->reg_size = VTD_PAGE_SIZE;
> +	iommu->reg_size = drhd->reg_size;
>   
>   	if (!request_mem_region(iommu->reg_phys, iommu->reg_size, iommu->name)) {
>   		pr_err("Can't reserve memory\n");
> @@ -1050,7 +1061,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>   	}
>   	sprintf(iommu->name, "dmar%d", iommu->seq_id);
>   
> -	err = map_iommu(iommu, drhd->reg_base_addr);
> +	err = map_iommu(iommu, drhd);
>   	if (err) {
>   		pr_err("Failed to map %s\n", iommu->name);
>   		goto error_free_seq_id;
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 4175dce3967c..bdded0ac46eb 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -802,7 +802,7 @@ struct acpi_dmar_pci_path {
>   struct acpi_dmar_hardware_unit {
>   	struct acpi_dmar_header header;
>   	u8 flags;
> -	u8 reserved;
> +	u8 size;		/* Size of the register set */
>   	u16 segment;
>   	u64 address;		/* Register Base Address */
>   };
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index d81a51978d01..51d498f0a02b 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -46,6 +46,7 @@ struct dmar_drhd_unit {
>   	u8	include_all:1;
>   	u8	gfx_dedicated:1;	/* graphic dedicated	*/
>   	struct intel_iommu *iommu;
> +	unsigned long reg_size;		/* size of register set */

Move it up and pair it with reg_base_addr.

>   };
>   
>   struct dmar_pci_path {

--
Best regards,
baolu
