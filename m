Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C1070CF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbjEWAk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjEWAZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C4219B3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684800616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7dG5YdmnL3Weqna4gM6GxGrV4/Sj8R56RKJ1KU2i2lM=;
        b=c63D5cAJnz74eYNPEf4cpJBaU5R65uKemVy0MSbw+6tDiljdGPx55bkhM3/JuNdYOpHPMb
        YoR99xVFmLNtw2owp5oZyQnJAjs3sAPd9NjdaI/1yPdZzszmqp7z3wryrpG/LdPX1pAboT
        LWKhi9w8Wfvlf2YtIiWoe0D17iYoNQg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-3WI5yxJ8NzqdAJuXO3O9pQ-1; Mon, 22 May 2023 20:10:06 -0400
X-MC-Unique: 3WI5yxJ8NzqdAJuXO3O9pQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-624d1043e4aso17861706d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684800606; x=1687392606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dG5YdmnL3Weqna4gM6GxGrV4/Sj8R56RKJ1KU2i2lM=;
        b=VnNvegMt5Et4qRpPPQ6Uew9kR/0YRalRaxk363plh/jt5ZRzJcB5glANRyTMbWBBPW
         BKo0kDvWdvlGjp9jf95WfcNMgXnNrtyFFVzfxCVg2AdwpqraX3N0illv0grhOTEqwFar
         Ptt47MazOyE2JDzO92BqqT+P3KJZ5BsG2VSTcW2UeIWzLVBrBynpXq5FYN0OrCEDrmvT
         mKu6gA5rGPXBfJQzoL4EBtBG3aQdqLVp3CoFqyf8eM72xFMKR/VxKuz4m9jNTf2G9mh2
         7ssKmnU+Bm8F2onNEwJkL7r0QODDJ4MKGo/wg1IYz7aRBC7JAXQM6UObjEIphNXbFcqN
         k3og==
X-Gm-Message-State: AC+VfDyCjUVCnBy1+4sFCJ+UO6A7mG8zwMsmNnXswVNDFfyYQY3JSdS/
        y6/TXTVf6VcmoUg4LS5H3LEZFgPGjtFRgUy+IGs5ddDTGa9PuBzTDfBWv90CbNHxECyIlkEJ7qy
        SGKx5L+PSOT1IXcfHlXhO1mhw
X-Received: by 2002:a05:6214:202b:b0:622:199c:c4dc with SMTP id 11-20020a056214202b00b00622199cc4dcmr23205599qvf.51.1684800606456;
        Mon, 22 May 2023 17:10:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5S6h41GdM85gKktnEr0J/YZo1Ilm5BfR+uLxMd2oAczz1nnh2830KQbyzAG+Lg+sfpsdhsfw==
X-Received: by 2002:a05:6214:202b:b0:622:199c:c4dc with SMTP id 11-20020a056214202b00b00622199cc4dcmr23205561qvf.51.1684800606175;
        Mon, 22 May 2023 17:10:06 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p7-20020a0cf687000000b006238cf6d2a8sm2370925qvn.2.2023.05.22.17.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 17:10:05 -0700 (PDT)
Date:   Mon, 22 May 2023 17:10:04 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, joao.m.martins@oracle.com,
        alejandro.j.jimenez@oracle.com, boris.ostrovsky@oracle.com,
        jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com,
        kishon.vijayabraham@amd.com
Subject: Re: [PATCH v2 3/5] iommu/amd: Introduce Disable IRTE Caching Support
Message-ID: <qbcm4ac4foyafz7xqkkv45exevquu6psqnczwq5dnyrwm3on2o@auwkdo5al2fv>
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
 <20230519005529.28171-4-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519005529.28171-4-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 08:55:27PM -0400, Suravee Suthikulpanit wrote:
> An Interrupt Remapping Table (IRT) stores interrupt remapping configuration
> for each device. In a normal operation, the AMD IOMMU caches the table
> to optimize subsequent data accesses. This requires the IOMMU driver to
> invalidate IRT whenever it updates the table. The invalidation process
> includes issuing an INVALIDATE_INTERRUPT_TABLE command following by
> a COMPLETION_WAIT command.
> 
> However, there are cases in which the IRT is updated at a high rate.
> For example, for IOMMU AVIC, the IRTE[IsRun] bit is updated on every
> vcpu scheduling (i.e. amd_iommu_update_ga()). On system with large
> amount of vcpus and VFIO PCI pass-through devices, the invalidation
> process could potentially become a performance bottleneck.
> 
> Introducing a new kernel boot option:
> 
>     amd_iommu=irtcachedis
> 
> which disables IRTE caching by setting the IRTCachedis bit in each IOMMU
> Control register, and bypass the IRT invalidation process.
> 
> Co-developed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> [Awaiting sign-off by Alejandro]
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  .../admin-guide/kernel-parameters.txt         |  1 +
>  drivers/iommu/amd/amd_iommu_types.h           |  4 +++
>  drivers/iommu/amd/init.c                      | 36 +++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6221a1d057dd..f29dee600faf 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -323,6 +323,7 @@
>  				       option with care.
>  			pgtbl_v1     - Use v1 page table for DMA-API (Default).
>  			pgtbl_v2     - Use v2 page table for DMA-API.
> +			irtcachedis  - Disable Interrupt Remapping Table (IRT) caching.
>  
>  	amd_iommu_dump=	[HW,X86-64]
>  			Enable AMD IOMMU driver option to dump the ACPI table
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index a0ff1e852efc..486a052e37ca 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -172,6 +172,7 @@
>  #define CONTROL_GAINT_EN	29
>  #define CONTROL_XT_EN		50
>  #define CONTROL_INTCAPXT_EN	51
> +#define CONTROL_IRTCACHEDIS	59
>  #define CONTROL_SNPAVIC_EN	61
>  
>  #define CTRL_INV_TO_MASK	(7 << CONTROL_INV_TIMEOUT)
> @@ -708,6 +709,9 @@ struct amd_iommu {
>  	/* if one, we need to send a completion wait command */
>  	bool need_sync;
>  
> +	/* true if disable irte caching */
> +	bool irtcachedis_enabled;
> +
>  	/* Handle for IOMMU core code */
>  	struct iommu_device iommu;
>  
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index fd487c33b28a..fc0392d706db 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -160,6 +160,7 @@ static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
>  static bool amd_iommu_detected;
>  static bool amd_iommu_disabled __initdata;
>  static bool amd_iommu_force_enable __initdata;
> +static bool amd_iommu_irtcachedis;
>  static int amd_iommu_target_ivhd_type;
>  
>  /* Global EFR and EFR2 registers */
> @@ -477,6 +478,9 @@ static void iommu_disable(struct amd_iommu *iommu)
>  
>  	/* Disable IOMMU hardware itself */
>  	iommu_feature_disable(iommu, CONTROL_IOMMU_EN);
> +
> +	/* Clear IRTE cache disabling bit */
> +	iommu_feature_disable(iommu, CONTROL_IRTCACHEDIS);
>  }
>  
>  /*
> @@ -2700,6 +2704,33 @@ static void iommu_enable_ga(struct amd_iommu *iommu)
>  #endif
>  }
>  
> +static void iommu_disable_irtcachedis(struct amd_iommu *iommu)
> +{
> +	iommu_feature_disable(iommu, CONTROL_IRTCACHEDIS);
> +}
> +
> +static void iommu_enable_irtcachedis(struct amd_iommu *iommu)
> +{
> +	u64 ctrl;
> +
> +	if (!amd_iommu_irtcachedis)
> +		return;
> +
> +	/*
> +	 * Note:
> +	 * The support for IRTCacheDis feature is dertermined by
> +	 * checking if the bit is writable.
> +	 */
> +	iommu_feature_enable(iommu, CONTROL_IRTCACHEDIS);
> +	ctrl = readq(iommu->mmio_base +  MMIO_CONTROL_OFFSET);
> +	ctrl &= (1ULL << CONTROL_IRTCACHEDIS);
> +	if (ctrl)
> +		iommu->irtcachedis_enabled = true;
> +	pr_info("iommu%d (%#06x) : IRT cache is %s\n",
> +		iommu->index, iommu->devid,
> +		iommu->irtcachedis_enabled ? "disabled" : "enabled");
> +}
> +
>  static void early_enable_iommu(struct amd_iommu *iommu)
>  {
>  	iommu_disable(iommu);
> @@ -2710,6 +2741,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
>  	iommu_set_exclusion_range(iommu);
>  	iommu_enable_ga(iommu);
>  	iommu_enable_xt(iommu);
> +	iommu_enable_irtcachedis(iommu);
>  	iommu_enable(iommu);
>  	iommu_flush_all_caches(iommu);
>  }
> @@ -2760,10 +2792,12 @@ static void early_enable_iommus(void)
>  		for_each_iommu(iommu) {
>  			iommu_disable_command_buffer(iommu);
>  			iommu_disable_event_buffer(iommu);
> +			iommu_disable_irtcachedis(iommu);
>  			iommu_enable_command_buffer(iommu);
>  			iommu_enable_event_buffer(iommu);
>  			iommu_enable_ga(iommu);
>  			iommu_enable_xt(iommu);
> +			iommu_enable_irtcachedis(iommu);
>  			iommu_set_device_table(iommu);
>  			iommu_flush_all_caches(iommu);
>  		}
> @@ -3411,6 +3445,8 @@ static int __init parse_amd_iommu_options(char *str)
>  			amd_iommu_pgtable = AMD_IOMMU_V1;
>  		} else if (strncmp(str, "pgtbl_v2", 8) == 0) {
>  			amd_iommu_pgtable = AMD_IOMMU_V2;
> +		} else if (strncmp(str, "irtcachedis", 11) == 0) {
> +			amd_iommu_irtcachedis = true;
>  		} else {
>  			pr_notice("Unknown option - '%s'\n", str);
>  		}
> -- 
> 2.31.1
> 

