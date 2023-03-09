Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7BB6B2929
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjCIPvt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Mar 2023 10:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjCIPvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:51:46 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FFFF2C24
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:51:45 -0800 (PST)
Received: from lhrpeml100005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PXYWX5s9sz688wM;
        Thu,  9 Mar 2023 23:48:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100005.china.huawei.com (7.191.160.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 15:51:42 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.021;
 Thu, 9 Mar 2023 15:51:42 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
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
Thread-Index: AQHZUnWTVXhuXoh0OkWPSyQY1srSfq7ydQKAgAAVzLCAAAsqAIAAANyQ
Date:   Thu, 9 Mar 2023 15:51:42 +0000
Message-ID: <39979642ba8042ba9d4de651fecfeffb@huawei.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <213a05ef06944a55a148995053b187f8@huawei.com> <ZAn94BXkjiJKQ66O@nvidia.com>
In-Reply-To: <ZAn94BXkjiJKQ66O@nvidia.com>
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
> From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> Sent: 09 March 2023 15:40
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>; Nicolin Chen
> <nicolinc@nvidia.com>; robin.murphy@arm.com; will@kernel.org;
> eric.auger@redhat.com; kevin.tian@intel.com; baolu.lu@linux.intel.com;
> joro@8bytes.org; linux-arm-kernel@lists.infradead.org;
> iommu@lists.linux.dev; linux-kernel@vger.kernel.org; yi.l.liu@intel.com
> Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
> for ARM SMMUv3
> 
> On Thu, Mar 09, 2023 at 03:26:12PM +0000, Shameerali Kolothum Thodi
> wrote:
> 
> > On platforms that supports BTM [1], we may need the VMID allocated by
> KVM.
> > But again getting that from user pace doesn't look safe. I have attempted
> to revise
> > the earlier RFC to pin and use the KVM VMID from SMMUv3 here[2].
> 
> Gurk
> 
> > " In the new design we can require from the start that creating a nesting
> IOMMU
> > container through /dev/iommu *must* come with a KVM context, that way
> > we're sure to reuse the existing VMID. "
> 
> I've been dreading this but yes I execpt we will eventually need to
> connect kvm and iommufd together. The iommu driver can receive a kvm
> pointer as part of the alloc domain operation to do any setups like
> this.

That will make life easier :)
 
> If there is no KVM it should either fail to setup the domain or setup
> a domain disconnected from KVM.
> 

If no KVM the SMMUv3 can fall back to its internal VMID allocation I guess.
And my intention was to use KVM VMID only if the platform supports
BTM.

> If IOMMU HW and KVM HW are using the same ID number space then
> arguably the two kernel drivers need to use a shared ID allocator in
> the arch, regardless of what iommufd/etc does. Using KVM should not be
> mandatory for iommufd.
> 
> For ARM cases where there is no shared VMID space with KVM, the ARM
> VMID should be somehow assigned to the iommfd_ctx itself and the alloc
> domain op should receive it from there.

Is there any use of VMID outside SMMUv3? I was thinking if nested domain alloc
doesn't provide the KVM instance, then SMMUv3 can use its internal VMID. 

Thanks,
Shameer

> Nicolin, that seems to be missing in this series? I'm not entirely
> sure how to elegantly code it :\
> 
> Jason
