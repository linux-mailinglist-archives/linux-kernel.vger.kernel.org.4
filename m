Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A904B6B4BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCJPwA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 10:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjCJPvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:51:39 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEBEEAB99
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:44:06 -0800 (PST)
Received: from lhrpeml100003.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PY9Lh6fFLz6J6rP;
        Fri, 10 Mar 2023 23:43:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 15:44:03 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.021;
 Fri, 10 Mar 2023 15:44:03 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Thread-Topic: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Thread-Index: AQHZUnWRmBwtrmleCk69JH8tQLhaPq7zzWuAgABY2gCAAAIMsA==
Date:   Fri, 10 Mar 2023 15:44:02 +0000
Message-ID: <f61ca5693d8845eba0a2139324e52d98@huawei.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
 <ZAtNrFAEHvmM4FOW@nvidia.com>
In-Reply-To: <ZAtNrFAEHvmM4FOW@nvidia.com>
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
> Sent: 10 March 2023 15:33
> To: Eric Auger <eric.auger@redhat.com>
> Cc: Nicolin Chen <nicolinc@nvidia.com>; robin.murphy@arm.com;
> will@kernel.org; kevin.tian@intel.com; baolu.lu@linux.intel.com;
> joro@8bytes.org; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; jean-philippe@linaro.org;
> linux-arm-kernel@lists.infradead.org; iommu@lists.linux.dev;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain
> helper
> 
> On Fri, Mar 10, 2023 at 11:14:59AM +0100, Eric Auger wrote:
> > Hi Nicolin,
> >
> > On 3/9/23 11:53, Nicolin Chen wrote:
> > > The nature of ITS virtualization on ARM is done via hypercalls, so
> > > kernel handles all IOVA mappings for the MSI doorbell in
> > > iommu_dma_prepare_msi() and iommu_dma_compose_msi_msg(). The
> current
> > > virtualization solution with a 2-stage nested translation setup is
> > > to do 1:1 IOVA mappings at stage-1
> > Note that if we still intend to use that trick there is a known issue
> > at kernel side that needs to be fixed.
> >
> > ARM DEN 0049E.b IORT specification mandates that when RMRs are
> > present, the OS must preserve PCIe configuration performed by the boot
> > FW.
> 
> This limitation doesn't seem necessary for this MSI stuff?
> 
> What is it for?

That is to make sure the Stream Ids specified in RMR are still valid and is not being
reassigned by OS. The kernel checks for this(iort_rmr_has_dev()),
https://lore.kernel.org/linux-arm-kernel/20220420164836.1181-5-shameerali.kolothum.thodi@huawei.com/

Thanks,
Shameer



