Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19456B25AC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjCINmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjCINma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:42:30 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88003F7861
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:42:18 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j2so1893086wrh.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678369337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cYRhZ+LQKcNjJquoMvKplAWc0Q0BGJcYCcN6PUzcrU0=;
        b=G4hEzH03S6LjSKf3OpeDK0GSaJY6+RnEVsEI34ZGb+KPmZi1JHg1/3wWPX07D7EDb0
         q+zmu3Hd8w1Igy4pfmEN+OGuqnxa16a6XbJjpkZnKYoevxKe/IvU2zW3oHmjo9toFIK1
         VBdCWmv37Wqs1Y3RYn+LkfI2YB6FEba24EKFoqyeJMPvjgPzg93jWqi2GhKamlPikqa3
         7ps9t3681jWMahnZoL45dJkV2NGaCRS7fs8ECdIvdr+ZLC1d48Q7Rd124P0MHnHyGFNR
         PHSwkVAN1GUyCiVx3k4Adk/T7PTt5gG4Uy5tuEIiw85WRkmCOdhmUFS0sV69VKtR/cf/
         09nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678369337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYRhZ+LQKcNjJquoMvKplAWc0Q0BGJcYCcN6PUzcrU0=;
        b=GWRsgn2u+rwC/lJE33f1HOAbU1rnqwuUrJ/gwwFlHtc8kb0s6vRjh6TLEUY4NbqNuU
         gAYT5Em4ID3TGew7bNSHYL6Oe3/9eAOvVTdV8mefXq88yOfSf7yBlf1AzBgRnRjbSRwh
         zJJGU+ngRxoAbkBVHixxvDNKW0hRYt5wYlaU/eT48NqK+0Ao9h9cm5SOp2nKCQgMUab3
         dCoKnFgzS22+uE3ACw5cMeibrzOv+Ea75m95FNMbuUY/Cmw3gFpoO/SneDL6VWyDA9Iy
         62akoEcTqoZa49OPiunYEemELPlti2TxOmySCZG/l1sr56sF27ahK8r+xvDgMCVHlPMV
         pXJw==
X-Gm-Message-State: AO0yUKXZmtKFn/QYNuYUH8blBWg36IgW1F+h2qEiY0SV7H/nBB3qVcv+
        InxzHbTJfwBqCIFtaAyBVumy+WLgWNtzkYfpN/o=
X-Google-Smtp-Source: AK7set9Rn2XbNH+GCzRxmbwEIXEYIywyUUAvuLxkZ7tB/bsYVtC/eaDuRU1SybiJl+td9URPJo0m9Q==
X-Received: by 2002:a5d:4a51:0:b0:2c7:ca2:1a28 with SMTP id v17-20020a5d4a51000000b002c70ca21a28mr13999073wrs.68.1678369336941;
        Thu, 09 Mar 2023 05:42:16 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id q9-20020a5d61c9000000b002c54911f50bsm18042908wrv.84.2023.03.09.05.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:42:16 -0800 (PST)
Date:   Thu, 9 Mar 2023 13:42:17 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     jgg@nvidia.com, robin.murphy@arm.com, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <20230309134217.GA1673607@myrica>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On Thu, Mar 09, 2023 at 02:53:38AM -0800, Nicolin Chen wrote:
> Add the following data structures for corresponding ioctls:
>                iommu_hwpt_arm_smmuv3 => IOMMUFD_CMD_HWPT_ALLOC
>     iommu_hwpt_invalidate_arm_smmuv3 => IOMMUFD_CMD_HWPT_INVALIDATE
> 
> Also, add IOMMU_HW_INFO_TYPE_ARM_SMMUV3 and IOMMU_PGTBL_TYPE_ARM_SMMUV3_S1
> to the header and corresponding type/size arrays.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

> +/**
> + * struct iommu_hwpt_arm_smmuv3 - ARM SMMUv3 specific page table data
> + *
> + * @flags: page table entry attributes
> + * @s2vmid: Virtual machine identifier
> + * @s1ctxptr: Stage-1 context descriptor pointer
> + * @s1cdmax: Number of CDs pointed to by s1ContextPtr
> + * @s1fmt: Stage-1 Format
> + * @s1dss: Default substream
> + */
> +struct iommu_hwpt_arm_smmuv3 {
> +#define IOMMU_SMMUV3_FLAG_S2	(1 << 0) /* if unset, stage-1 */

I don't understand the purpose of this flag, since the structure only
provides stage-1 configuration fields

> +#define IOMMU_SMMUV3_FLAG_VMID	(1 << 1) /* vmid override */

Doesn't this break isolation?  The VMID space is global for the SMMU, so
the guest could access cached mappings of another device

> +	__u64 flags;
> +	__u32 s2vmid;
> +	__u32 __reserved;
> +	__u64 s1ctxptr;
> +	__u64 s1cdmax;
> +	__u64 s1fmt;
> +	__u64 s1dss;
> +};
> +


> +/**
> + * struct iommu_hwpt_invalidate_arm_smmuv3 - ARM SMMUv3 cahce invalidation info
> + * @flags: boolean attributes of cache invalidation command
> + * @opcode: opcode of cache invalidation command
> + * @ssid: SubStream ID
> + * @granule_size: page/block size of the mapping in bytes
> + * @range: IOVA range to invalidate
> + */
> +struct iommu_hwpt_invalidate_arm_smmuv3 {
> +#define IOMMU_SMMUV3_CMDQ_TLBI_VA_LEAF	(1 << 0)
> +	__u64 flags;
> +	__u8 opcode;
> +	__u8 padding[3];
> +	__u32 asid;
> +	__u32 ssid;
> +	__u32 granule_size;
> +	struct iommu_iova_range range;
> +};

Although we can keep the alloc and hardware info separate for each IOMMU
architecture, we should try to come up with common invalidation methods.

It matters because things like vSVA, or just efficient dynamic mappings,
will require optimal invalidation latency. A paravirtual interface like
vhost-iommu can help with that, as the host kernel will handle guest
invalidations directly instead of doing a round-trip to host userspace
(and we'll likely want the same path for PRI.)

Supporting HW page tables for a common PV IOMMU does require some
architecture-specific knowledge, but invalidation messages contain roughly
the same information on all architectures. The PV IOMMU won't include
command opcodes for each possible architecture if one generic command does
the same job.

Ideally I'd like something like this for vhost-iommu:

* slow path through userspace for complex requests like attach-table and
  probe, where the VMM can decode arch-specific information and translate
  them to iommufd and vhost-iommu ioctls to update the configuration.

* fast path within the kernel for performance-critical requests like
  invalidate, page request and response. It would be absurd for the
  vhost-iommu driver to translate generic invalidation requests from the
  guest into arch-specific commands with special opcodes, when the next
  step is calling the IOMMU driver which does that for free.

During previous discussions we came up with generic invalidations that
could fit both Arm and x86 [1][2]. The only difference was the ASID
(called archid/id in those proposals) which VT-d didn't need. Could we try
to build on that?

[1] https://elixir.bootlin.com/linux/v5.17/source/include/uapi/linux/iommu.h#L161
[2] https://lists.oasis-open.org/archives/virtio-dev/202102/msg00014.html

Thanks,
Jean

