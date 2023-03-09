Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD006B28D2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCIP0g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Mar 2023 10:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCIP0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:26:18 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132FF6A060
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:26:16 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PXY186fLvz6J7Xn;
        Thu,  9 Mar 2023 23:26:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 15:26:12 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.021;
 Thu, 9 Mar 2023 15:26:12 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>
Subject: RE: [PATCH v1 02/14] iommufd: Add nesting related data structures for
 ARM SMMUv3
Thread-Topic: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Thread-Index: AQHZUnWTVXhuXoh0OkWPSyQY1srSfq7ydQKAgAAVzLA=
Date:   Thu, 9 Mar 2023 15:26:12 +0000
Message-ID: <213a05ef06944a55a148995053b187f8@huawei.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
In-Reply-To: <20230309134217.GA1673607@myrica>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jean-Philippe Brucker [mailto:jean-philippe@linaro.org]
> Sent: 09 March 2023 13:42
> To: Nicolin Chen <nicolinc@nvidia.com>
> Cc: jgg@nvidia.com; robin.murphy@arm.com; will@kernel.org;
> eric.auger@redhat.com; kevin.tian@intel.com; baolu.lu@linux.intel.com;
> joro@8bytes.org; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; iommu@lists.linux.dev;
> linux-kernel@vger.kernel.org; yi.l.liu@intel.com
> Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
> for ARM SMMUv3
> 
> Hi Nicolin,
> 
> On Thu, Mar 09, 2023 at 02:53:38AM -0800, Nicolin Chen wrote:
> > Add the following data structures for corresponding ioctls:
> >                iommu_hwpt_arm_smmuv3 =>
> IOMMUFD_CMD_HWPT_ALLOC
> >     iommu_hwpt_invalidate_arm_smmuv3 =>
> IOMMUFD_CMD_HWPT_INVALIDATE
> >
> > Also, add IOMMU_HW_INFO_TYPE_ARM_SMMUV3 and
> IOMMU_PGTBL_TYPE_ARM_SMMUV3_S1
> > to the header and corresponding type/size arrays.
> >
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> > +/**
> > + * struct iommu_hwpt_arm_smmuv3 - ARM SMMUv3 specific page table
> data
> > + *
> > + * @flags: page table entry attributes
> > + * @s2vmid: Virtual machine identifier
> > + * @s1ctxptr: Stage-1 context descriptor pointer
> > + * @s1cdmax: Number of CDs pointed to by s1ContextPtr
> > + * @s1fmt: Stage-1 Format
> > + * @s1dss: Default substream
> > + */
> > +struct iommu_hwpt_arm_smmuv3 {
> > +#define IOMMU_SMMUV3_FLAG_S2	(1 << 0) /* if unset, stage-1 */
> 
> I don't understand the purpose of this flag, since the structure only
> provides stage-1 configuration fields
> 
> > +#define IOMMU_SMMUV3_FLAG_VMID	(1 << 1) /* vmid override */
> 
> Doesn't this break isolation?  The VMID space is global for the SMMU, so
> the guest could access cached mappings of another device

On platforms that supports BTM [1], we may need the VMID allocated by KVM.
But again getting that from user pace doesn't look safe. I have attempted to revise
the earlier RFC to pin and use the KVM VMID from SMMUv3 here[2].

But the problem is getting the KVM instance associated with the device. Currently I am 
going through the VFIO layer to retrieve the KVM instance(vfio_device->kvm).

On the previous RFC discussion thread[3], Jean has proposed,

" In the new design we can require from the start that creating a nesting IOMMU
container through /dev/iommu *must* come with a KVM context, that way
we're sure to reuse the existing VMID. "

Is that something we can still do or there is a better way to handle this now?

Thanks,
Shameer


1. https://lore.kernel.org/linux-arm-kernel/YEEUocRn3IfIDpLj@myrica/T/#m478f7e7d5dcb729e02721beda35efa12c1d20707
2. https://github.com/hisilicon/kernel-dev/commits/iommufd-v6.2-rc4-nesting-arm-btm-v2
3. https://lore.kernel.org/linux-arm-kernel/YEEUocRn3IfIDpLj@myrica/T/#m11cde7534943ea7cf35f534cb809a023eabd9da3

