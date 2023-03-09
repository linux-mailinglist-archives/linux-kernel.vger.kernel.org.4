Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461046B2AE1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCIQfO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Mar 2023 11:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjCIQeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:34:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624AA1116A9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 08:25:56 -0800 (PST)
Received: from lhrpeml500002.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PXYwl1bqWz6J6rf;
        Fri, 10 Mar 2023 00:07:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 16:07:54 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.021;
 Thu, 9 Mar 2023 16:07:54 +0000
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
Thread-Index: AQHZUnWTVXhuXoh0OkWPSyQY1srSfq7ydQKAgAAVzLCAAAsqAIAAANyQgAAEp4CAAACeQA==
Date:   Thu, 9 Mar 2023 16:07:54 +0000
Message-ID: <4c1f57adbe0c4d48849d585508595939@huawei.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <213a05ef06944a55a148995053b187f8@huawei.com> <ZAn94BXkjiJKQ66O@nvidia.com>
 <39979642ba8042ba9d4de651fecfeffb@huawei.com> <ZAoCf9+kpMof6R+4@nvidia.com>
In-Reply-To: <ZAoCf9+kpMof6R+4@nvidia.com>
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
> Sent: 09 March 2023 16:00
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>; Nicolin Chen
> <nicolinc@nvidia.com>; robin.murphy@arm.com; will@kernel.org;
> eric.auger@redhat.com; kevin.tian@intel.com; baolu.lu@linux.intel.com;
> joro@8bytes.org; linux-arm-kernel@lists.infradead.org;
> iommu@lists.linux.dev; linux-kernel@vger.kernel.org; yi.l.liu@intel.com
> Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
> for ARM SMMUv3
> 
> On Thu, Mar 09, 2023 at 03:51:42PM +0000, Shameerali Kolothum Thodi
> wrote:
> 
> > > For ARM cases where there is no shared VMID space with KVM, the ARM
> > > VMID should be somehow assigned to the iommfd_ctx itself and the alloc
> > > domain op should receive it from there.
> >
> > Is there any use of VMID outside SMMUv3? I was thinking if nested domain
> alloc
> > doesn't provide the KVM instance, then SMMUv3 can use its internal VMID.
> 
> When we talk about exposing an SMMUv3 IOMMU CMDQ directly to
> userspace then
> VMID is the security token that protects it.
> 
> So in that environment every domain under the same iommufd should
> share the same VMID so that the CMDQ's also share the same VMID.
> 
> I expect this to be a common sort of requirement as we will see
> userspace command queues in the other HW as well.
> 
> So, I suppose the answer for now is that ARM SMMUv3 should just
> allocate one VMID per iommu_domain and there should be no VMID in the
> uapi at all.
> 
> Moving all iommu_domains to share the same VMID is a future patch.
> 
> Though.. I have no idea how vVMID is handled in the SMMUv3
> architecture. I suppose the guest IOMMU HW caps are set in a way that
> it knows it does not have VMID?

I think, Guest only sets up the SMMUv3 S1 stage and it doesn't use VMID.

Thanks,
Shameer
