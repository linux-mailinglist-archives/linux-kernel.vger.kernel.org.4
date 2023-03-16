Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059146BD9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCPT6F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Mar 2023 15:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCPT6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:58:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1472B860E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:57:17 -0700 (PDT)
Received: from lhrpeml500002.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PcycS5638z67PTQ;
        Fri, 17 Mar 2023 03:53:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 19:56:34 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.021;
 Thu, 16 Mar 2023 19:56:34 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
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
Thread-Index: AQHZUnWRmBwtrmleCk69JH8tQLhaPq7zzWuAgABY2gCAAAIMsIAABIwAgAABG+CAAAW9gIAAAcuwgAmm7QCAAAB98A==
Date:   Thu, 16 Mar 2023 19:56:34 +0000
Message-ID: <7726b990f7c4486d9f3597979ebc4e7e@huawei.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
 <ZAtNrFAEHvmM4FOW@nvidia.com> <f61ca5693d8845eba0a2139324e52d98@huawei.com>
 <ZAtTNK1NbMJ4iyE0@nvidia.com> <b9e850a91c494a5397a0ae154e9ef1da@huawei.com>
 <ZAtY8S53//5P5egd@nvidia.com> <ba7f4b9f81264832842a6c7486cb6dd7@huawei.com>
 <ZBNzNo96O/Cnhe2R@Asurada-Nvidia>
In-Reply-To: <ZBNzNo96O/Cnhe2R@Asurada-Nvidia>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.246.25]
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
> From: Nicolin Chen [mailto:nicolinc@nvidia.com]
> Sent: 16 March 2023 19:51
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> Eric Auger <eric.auger@redhat.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>; robin.murphy@arm.com;
> will@kernel.org; kevin.tian@intel.com; baolu.lu@linux.intel.com;
> joro@8bytes.org; jean-philippe@linaro.org;
> linux-arm-kernel@lists.infradead.org; iommu@lists.linux.dev;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain
> helper
> 
> Hi Shameer/Eric,
> 
> On Fri, Mar 10, 2023 at 04:30:03PM +0000, Shameerali Kolothum Thodi
> wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > > -----Original Message-----
> > > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> > > Sent: 10 March 2023 16:21
> > > To: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>
> > > Cc: Eric Auger <eric.auger@redhat.com>; Nicolin Chen
> > > <nicolinc@nvidia.com>; robin.murphy@arm.com; will@kernel.org;
> > > kevin.tian@intel.com; baolu.lu@linux.intel.com; joro@8bytes.org;
> > > jean-philippe@linaro.org; linux-arm-kernel@lists.infradead.org;
> > > iommu@lists.linux.dev; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v1 01/14] iommu: Add
> iommu_get_unmanaged_domain
> > > helper
> > >
> > > On Fri, Mar 10, 2023 at 04:07:38PM +0000, Shameerali Kolothum Thodi
> > > wrote:
> > > > >
> > >
> https://lore.kernel.org/linux-arm-kernel/20220420164836.1181-5-shame
> > > er
> > > > > > ali.kolothum.thodi@huawei.com/
> > > > >
> > > > > So "boot configration" is more like "don't change the RIDs"? Ie
> > > > > don't
> > > enable
> > > > > SRIOV?
> > > >
> > > > Yes. Don't think it will work with SR-IOV if you can't guarantee
> > > > the RMR
> > > specified
> > > > SID.
> > >
> > > So I think we are probably good them because vSR-IOV is already not
> > > supported by qemu, so it impossible for a VM to change the PCI
> > > configuration in a way that would alter the RID to SID mapping?
> > >
> >
> > Provided we fix the issue mentioned by Eric. This was discussed here
> > previously,
> >
> > https://lore.kernel.org/linux-arm-kernel/bb3688c7-8f42-039e-e22f-65290
> > 78da97d@redhat.com/
> 
> Have we fixed the issue? I saw Lorenzo replying in that thread:
> https://lore.kernel.org/linux-arm-kernel/Yi8nV8H4Jjlpadmk@lpieralisi/
> 
> Or, what's remaining here regarding this topic? Is it a blocker?

[+Lorenzo]

Not sure it is fixed yet. Also, assuming we take RMR path, do we plan to support 
DT base Guests at all?

Thanks,
Shameer

