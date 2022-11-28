Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861A063ADE4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiK1Qfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiK1Qfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:35:40 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABB320F64;
        Mon, 28 Nov 2022 08:35:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CM2eW9kRSMD6N1NjTgzUdqzA2eqL3RE44g581IO8/7tvvIWCqeoId5J5ExkMp3QRekb4YCONOdDUCYzEYiz2KB5IUxOkcYF6DIRZejwy/WUUGXWKoPU67+FpbDqCvUu7J1UnNDflEtfue6fDXR+Q0JqPHSpvjZw6Qn15sx2iIpjICw/Sj6k4ilSmIJeqYh0/4uMo0srsPjO8EcRFREal05VYv/wfue9yR+mkFzrNr9icidUnNDRrMy13N+sktGnJpA8QoYSK0UlWTHiSXWzG3cfrs+7ihTJy0QoaVTQvWgpgaFnVMH3AIdxXjyNy5vHwUjBvYtvXqVGKRpx2QfeWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdS/xlFTV00VHwYQ/Di5PXTr4aN/gTzPlKL5GK9ys+0=;
 b=QGWw1HkfyMo9u2WFxlNHxhop78vaCNK8+yZ9ZEvMu3qHC/+LCmbkSbDKb42/O4UGf3Sfmu5BRCStBsYtjzyVdy9umuJ4+6eYyIkarZD0rSx1/JyZQSePCJSEKBaq7cYAl/SULL0hvEiKIMj0W+32v4EG84ar9v0HR9Uo2mN16OFj+mTXpQfuUUJoJhuh17Jagemzqri1iTu4l3b1lUCU9SVEL82TiwvZK0OnKDDQnwtZfv+EZiJJTyO0xTjKZZ5AExb8KDg4aKgoVPR/TYfGXmaaNZwzgf8yIeHQsOIVSwXu+OHz96yoApPjK3vAd5lv5eS/swy3ZExqHyDyiDOjwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdS/xlFTV00VHwYQ/Di5PXTr4aN/gTzPlKL5GK9ys+0=;
 b=H6TUE/r04NusyXdAdcWiNpvhFo5xPlNHGCMoa2yiXvzdlHaE4mQxRpO9NNuBm6gGiEkH0s3LEGXj9iHuJdr2Y5KTWpfayMrVaAR6nV26+z6W9wj8lhWr89wFyj5RU1ZWGspLinNmzx+3T1luNAD+2j5JK3PRH3UVvEMGPJXJ6PqCRW0XBjauUTrMrj/S5rXR/WDZJEZjqCWIimgA5XC2/WT2UXPiCOPBg+Wnaf7CX5Ndt7zbxaVlKFefdjCWgBspdwxhvgvoJ0qdHqaEMDHGdIpqFHqZFCrQCk+rWot1m5lSqO5auHGUwZv0H1oMJvPmMXBHBP1MTATAIByxGCLQdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 16:35:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 16:35:38 +0000
Date:   Mon, 28 Nov 2022 12:35:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
Message-ID: <Y4TjWOXYD+DK+d/B@nvidia.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
 <20221116171656.4128212-5-schnelle@linux.ibm.com>
 <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
 <9163440eb6a47fe02730638bbdf72fda5ee5ad2c.camel@linux.ibm.com>
 <Y4S3z6IpeDHmdUs/@nvidia.com>
 <52fe7769ca5b66523c2c93c7d46ebc17dc144aca.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52fe7769ca5b66523c2c93c7d46ebc17dc144aca.camel@linux.ibm.com>
X-ClientProxiedBy: BLAPR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:208:32d::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b64d223-932c-4d58-9198-08dad15e94ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlffHEs+KRdN+CrFpDBQc4Rtf1N/T1QNP10QP1ZY2/c8C1FmrNZwZzdWZ7cdxflRHcUfhq4jPFclkXF8z1DboAW6be6e4FT4T8Pr7uvbfm2LWErZECiEd2xft7IFvsyRv6HOFkz6kcsjcnfadRQjOfKxtI/FHwyjgC2S7b0DPZpLab5/LhiFHx4DuwOU19U914C1W+ft5m81Za/WEVnB4qwYugpNfMuW3v5nx0GZLES563d9G+2eicbuGSA21Ujc/ru2FvPcCNa7kH14uHzCfXGuTdu9PsbJzXd9EytK2YnfN5EkBK16p81urNqy6eSFSqKh3DsKuzJSr1XH5zhG04xha7MSV8+pNpF3rbclHpWCj0YpHNQ2rDVgqE0ytZ4iQ/LtW+W3EDQafUcsuyXTaSLe508ZwIcne2Ul+jsTqE/r8i4SBJpymewGbc4oqCzRaYRz0Xnlzk0ZZ/ggoyAjQTcsqhxnCpO6G1O0DPnfdD/oLBnd5uqPN+a/rptw9W9BnAM5GdSEOiCatfQsX1v1ttyFUndQyxdBfp9GVH+yjIXhWtz/iaBb70uxMYiO/mxqtpi5mQEu9oCS4C8Yf/qN8uOdpoUamztK2yeBe4uB2aXQqy0tjkjMvZcBVhbIaO1UqjUjp1lRU6MRkKlD6wdKkscZq5m77eYUPSp2VXOAjCqFbPI7ATaHbnbA7+5wo+gV8pK+kA7lq+CnJRsa87xnyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199015)(966005)(6486002)(38100700002)(66556008)(66476007)(66946007)(4326008)(41300700001)(478600001)(36756003)(8676002)(2906002)(54906003)(6916009)(316002)(8936002)(7416002)(5660300002)(86362001)(2616005)(83380400001)(66899015)(186003)(6512007)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZZHiegT09Kgg5jnZ7KytYx0z9VeQSylzFGA5nOYjdCuswS/Ras5dWf8T7pJ+?=
 =?us-ascii?Q?MrwUKQ8jEvsRNOHnm/H3Gn8+E3NTeOQg5INwXuh6CUwXGDPZDEnn7vd8KQkP?=
 =?us-ascii?Q?ijPDh+7ekjkso9PE5e9+HNFYaBP00ubI2pmQPDv+d8f1TVCVoswdeK74yxVq?=
 =?us-ascii?Q?ugd+xodX2hoPA41J2o3EF1gHGBOD2it0jpkHcoLO4jHaXRzvcqgg7Ym/gGc7?=
 =?us-ascii?Q?B86hUhqrkQ6ilTYEdFMxERGReAGeaHSZlQQgr3VLWEBKPq3ppiKfHBvqXwtF?=
 =?us-ascii?Q?b0DpF5WLzrHcXtgrbnc1RW8x/a/le7d0Z1uFH0XwmcUaDfSFRSqOlWK8/wgZ?=
 =?us-ascii?Q?4VRVJQl+kp1u4c2gcyln8HLFnSWPENB3f4amU2UPsJzy+zciHmPFbz2JOTRZ?=
 =?us-ascii?Q?QteeNkIS9Q5YpZXfjcGqjfrPPtzk2McL1ZC977drDWlIFqocivesnyZmKp0X?=
 =?us-ascii?Q?35VOo+D/7/INrsu7CRu0YRg6IPtBnL5Ogmzx0fd9POQqSUTt/wDXpCCinImw?=
 =?us-ascii?Q?VJRoNLmoAd8bKAe3/iz1UUOTTnmAtxlSv4lR/lFDroXFmqJ2t5pr4d9uLC0n?=
 =?us-ascii?Q?j5PK1LON18uUkU2ONYjUaB2I/AfhXYN3I6H9HKK3Lu+nHLQItQRXCNtu/CfW?=
 =?us-ascii?Q?pwhnPfIdX7m/0BM+d1uU4cOf6D+0Kn35vasu2kun/Q2a/cfO98cUOI0adjkZ?=
 =?us-ascii?Q?13awXgFdBmOln8AFrD2BBjKA+FeUCZmDc9jjZ7GVHQm8XPkYkhmVDVk16O/c?=
 =?us-ascii?Q?I5ZrPkOGxqLsFheDRvU2lzMSOKF5BpDkAzKoss6DWtTfDMzcUN9VYJjnEf8A?=
 =?us-ascii?Q?AGstgpdYAv2eQGjEzsjSlO+NDJ02P2TbNkcLshX0e8eQ8B667xjKukZIy/fn?=
 =?us-ascii?Q?PK+8RrSIsPmPtjuA+yB67k5abg1FZx2Cl6v28qwX0mj3fsInxsQEMrEBxRL2?=
 =?us-ascii?Q?LMwteaJTBjhdH1Oq1WPLYvmzCOuejzyA3/oRx+C2FygKtmVg+fBoogVPbAB0?=
 =?us-ascii?Q?3MA770meYrZ//TkgnYO36Yva+xfPpu/D7nOlPI97X5v7uYuWODVkdSjdJ9s4?=
 =?us-ascii?Q?QoWZ6V6415osUu0QqR8vicT+qcvElrHCSMN33LXNdt7KdjMb6tUDvtqFAFOA?=
 =?us-ascii?Q?W+eXML1Rv2uR0Zmg8o9MGo6bP1M1Q8rikuYHfMswaxmBflYoSnPHbPaJQ7BZ?=
 =?us-ascii?Q?wJvF4Jf9KHWYImLh/s/Imx/watZMKxSsOeUtrpKCgLEuTkMIOWJnrnQRWowf?=
 =?us-ascii?Q?bU85wFJlkvIh9n1auHmSvjAtfcr8g7cw6+qTcyMtFYzEJ7aT1llw0d9Rx+xt?=
 =?us-ascii?Q?2RYfHH7HK7QjhEd0TynUY4QEoZ0agWfK1VZl5LIxrj4X90oxkYpKg8fJPHDF?=
 =?us-ascii?Q?xLBkyBUvZs6kubMXQN1J/EoIr6IcveMgYvPGSeu4ucF/0WW87JEsnBYRRZ0U?=
 =?us-ascii?Q?1gr7cF8MYFTuBg95ODE2pGCmETcu4o6H0xaSMFy6ineA0vEsMwx9rOsnn8Yj?=
 =?us-ascii?Q?4QChXh3iqCN6kD7XfTH4Rff99jkM0SpeNP3WQAKhWSS8satP/uI+3FNLmkHN?=
 =?us-ascii?Q?Owzuh7eXYKXw7366fxA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b64d223-932c-4d58-9198-08dad15e94ac
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 16:35:37.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSKx/owHR244bR6dpsM5wr7WaahbLVGTuxorkMVHcI6IIFOdmFCCL4CnjYvUzhKF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 04:54:03PM +0100, Niklas Schnelle wrote:

> I agree that there is currently a lack of distinction between what
> domain types can be used (capability) and which should be used as
> default (iommu.strict=<x>, iommu_set_...(), CONFIG_IOMMU_DEFAULT_DMA,
> ops->def_domain_type.).

What I would like to get to is the drivers only expose UNMANAGED,
IDENTITY and BLOCKING domains. Everything that the DMA/FQ/etc domains
were doing should be handled as some kind of cap.

Eg, after Lu's series:

https://lore.kernel.org/linux-iommu/20221128064648.1934720-1-baolu.lu@linux.intel.com/

We should be able to remove IOMMU_DOMAIN_DMA and its related from the
drivers entirely. Instead drivers will provide UNMANAGED domains and
dma-iommu.c will operate the UNMANAGED domain to provide the dma
api. We can detect if the driver supports this by set_platform_dma()
being NULL.

A statement that a driver performs better using SQ/FQ/none should be
something that is queried from the UNMANAGED domain as a guidance to
dma-iommu.c what configuration to pick if not overriden.

So, I would say what you want is some option flag, perhaps on the
domain ops: 'domain performs better with SQ or FQ'

> My case though is about the latter which I think has some undocumented
> and surprising precedences built in at the moment. With this series we
> can use all of IOMMU_DOMAIN_DMA(_FQ, _SQ) on any PCI device but we want
> to default to either IOMMU_DOMAIN_DMA_FQ or IOMMU_DOMAIN_SQ based on
> whether we're running in a paging hypervisor (z/VM or KVM) to get the
> best performance. From a semantic point of view I felt that this is a
> good match for ops->def_domain_type in that we pick a default but it's
> still possible to change the domain type e.g. via sysfs. Now this had
> the problem that ops->def_domain_type would cause IOMMU_DOMAIN_DMA_FQ
> to be used even if iommu_set_dma_strict() was called (via
> iommu.strict=1) because there is a undocumented override of ops-
> >def_domain_type over iommu_def_domain_type which I believe comes from
> the mixing of capability and default you also point at.

Yeah, this does sounds troubled.

> I think ideally we need two separate mechanism to determine which
> domain types can be used for a particular device (capability) and for
> which one to default to with the latter part having a clear precedence
> between the options. Put together I think iommu.strict=1 should
> override a device's preference (ops->def_domain_type) and
> CONFIG_IOMMU_DEFAULT_DMA to use IOMMU_DOMAIN_DMA but of course only if
> the device is capable of that. Does that sound reasonable?

Using the language above, if someone asks for strict then the
infrastructure should try to allocate an UNMANAGED domain, not an
identity domain, and not use the lazy flush algorithms in dma-iommu.c

Similarly if sysfs asks for lazy flush or identity maps then it should
get it, always.

The driver should have no say in how dma-iommu.c works beyond if it
provides the required ops functionalities, and hint(s) as to what
gives best performance.

So anything that moves closer to this direction seems like a good
choice to me.

Jason
