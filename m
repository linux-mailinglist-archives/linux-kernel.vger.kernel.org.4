Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8725EDDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiI1Nc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiI1NcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:32:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B617686729;
        Wed, 28 Sep 2022 06:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAE0UHgE7wdfKzofRYZeQq8qF4O3kstnxvhpGDQtrHycsutXJWVp9SO6Ty+no/6C4V+r+yzqo46sHtIsNdUK+pNvcbYIn5XbNXXePRdo2ZF4/YUzFEiIPev/wa2135oyMCx+GpXXSLV9RjJOa1NxGrZIiBqxSk0/a9uoXpzWRre1yZMVKj/j5BtIy+tfF/Ig6j2srfxEgWbFxvaN3QP/FYlSDNau199r4NcCEUpSyFF0weKX2muOypiLRd4Nthf+ngrYNXGV/7jcVEJzm7XHb2hN9LDiohndthLOV8m/6hE9KCt5M348K4tyya+90C4tVjZdtD1BHUOtMT+KUNeHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbn++JLI/IaVbjTpfEpNv3vg5hAJTZtAmwdsfWj6W8g=;
 b=Wo8XjMq6IyP4Oixx94poUNKdtpFwCb/zxwiyEX8Qpu/T/PHKc1JH8fLxF5gIBszysWUab+GJET3ucJi4Onb5gmpLhXXccdUkYdYgqrS16iv7DBEzKKWTp7Jn9hMts+pfSRfp/bkSz8Gm2WNqbStGg7PBkEvBrKK+bGQfGn/tJUyIloQhKlXSXI5ZL/bH4PjeBrOmhQAttHW4CNQdJGBaSbDR5hkcPPKVljonUbZzV4tUR3ToFeFwEcaYuYPLEjIaa2bB/t4Q0ac5rCdsddKNUXXCxAvPStcRjznkPI2HFU1gJvKCUawURtURTLLnJ8QD4fHYeFaqsMsaHZHXmuAX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbn++JLI/IaVbjTpfEpNv3vg5hAJTZtAmwdsfWj6W8g=;
 b=k8zwVZfhBALghIT7wpUKUDH2j5yyrLGmUde5f1V3fCeIQnA2BghBz3a0AqJg9AJ/0FMcjRLhAojlC+Jyc8K1rAFFS23yTnZ5naVoXD5R3s2c/5MRaAaE1k8YZbED7mSAPWCmR6l5QWMEZ+/hvTNzkKAslxHXvrDDCU378//14NogFoejEVALAuSpLsf6338Iy7elwlvvP6HTJEGVRk8Z7ImGFR8Fzs5Ap4EefWKThuJcZO9opw48zeocFc5waxdvr3r6VDDYCdRw3caj/kH6Kp+vEqUatr8rjxZLTaaRgLRSESvojpAadtEa6lCHZE/FUFABM3olXgXbjCDAIQCggA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 13:32:22 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::f0c0:3a28:55e9:e99c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::f0c0:3a28:55e9:e99c%5]) with mapi id 15.20.5676.018; Wed, 28 Sep 2022
 13:32:21 +0000
Date:   Wed, 28 Sep 2022 10:32:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommu/s390: Fix duplicate domain attachments
Message-ID: <YzRM5HG0t36KUAVC@nvidia.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
 <20220922095239.2115309-2-schnelle@linux.ibm.com>
 <YyxyMtKXyvgHt3Kp@nvidia.com>
 <81463119aeadd55465cfac1f5bc6a8b79f0c9738.camel@linux.ibm.com>
 <YzGtQY+uw4ZzZoSH@nvidia.com>
 <1a10b5baedafb56335231ccbd585412bbb3a108c.camel@linux.ibm.com>
 <YzMrSIGMPSgJ94sG@nvidia.com>
 <a4005a4ae804f852656ff2a6f2f994958b0b02e3.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4005a4ae804f852656ff2a6f2f994958b0b02e3.camel@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0251.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CH0PR12MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c854ce0-2506-4d29-c9fd-08daa155df41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYYRsj5JCN8lZd0njVTVAy0KXzD+TAgRgXt8gRfpExaZOAGqKxpUNArGSct1JxLr/vOdN2dO5BRMh9NMKRfNhmui//Lnf6v24tdiYoaUUxhJOgiUtd5+734WemqzH2TYLhi6+CNwvkK99OjcW2Ex6JdD0BYbYh8TePA07oda3jXpYNHTkcYWyYd0BcJnfoUd23/wW7u5u6PwmS09C92aLO8pVMmYjURpG7Zfx02LTmNpkHaKdH2uFwAoZjogI5NP33joxqQijOJWlVdYN3TTKgDvXAvf71w9I5a4SU+mHDjZ0FGrCHsdViErtH/RVr71fPfqDSZp/e2I4Pm7KZfe+o75nj6Gn1o3JvPIUthQg6UcPaj+HNhqsXBiavgGFEN4YPqRq0SyGjWTzCMs0gjZpNtYajaC/cUlsNu6YcL3aYCPc2jEpYSN1EaOvR9cHoiPFmNK1YwVkbT64TWOk9O+Qe4zv4vxuEunEWiB/fNPsGL1e4vNXkQzi/aa9vOfMgG04qIZcvzH6Q75oYMeTXymOP8EeY9KGxGt2LoCMJ+p1B+nx/eslVEi4kXb5kSpuKzLbU+ev2JpFvkNPWggPnFNDvH7hZ8LrRYEHU8aU4/d+A0DtAC50cVr9qbtnOVmjbMxnvm3rWz3kIjbCFqTyjHNRSKcsqTvD4NiUwiFQhvGAZDxxQWDCNtJaWj2RIFR8YebKojTaB1wCcEoiv/j5uyz+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(83380400001)(2616005)(186003)(38100700002)(7416002)(41300700001)(8936002)(5660300002)(2906002)(478600001)(6486002)(26005)(6512007)(6506007)(8676002)(66476007)(4326008)(66556008)(66946007)(316002)(6916009)(54906003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cK5b+ILuD3qg/fC5TqphxJy5uJg7sl6HwupvwS9nu/IIT0SUYk57yJFqZOUs?=
 =?us-ascii?Q?6jRRQVOBT5q6fTYLTNWx6erQi4E54+Vqq3kMOKgcnNgA8RfpDncsm1LlXUz/?=
 =?us-ascii?Q?KdoyFHDdr6E+s97s2kKQnGNdRG8P8/wfxK4FQEQzgtrLesjl1ad1HPYJ9U2m?=
 =?us-ascii?Q?VgWhoae76GjES4lTMyEi1lDNqYm1ChYm/C2CTbQsC9+AmQVN6U3CZ0DPp4EB?=
 =?us-ascii?Q?SiqjPZ6DEUFiWajLvDgvVRuZ80pWdjzOYXZJOog69CzxqTaEnX7td4lZPfKp?=
 =?us-ascii?Q?c3DTEIVs8iAvu/XTCUG8xWFrtoOI293lRIB0A7wleDheKq/+NWDfDI9/8Auw?=
 =?us-ascii?Q?2nV34d/jXAhNYAIdNw1BXbXgCQ3D2IZJgbevr4PGs1AhvlXeMQLKaZXo7sXt?=
 =?us-ascii?Q?7uAKZ9LraEkYxaZ+g+uP55e/ifThsAvMqGqPbELySg5IWLZcdZwTzmJsxltt?=
 =?us-ascii?Q?1KDpE5dW0NJN0HE8usEj+XnOOG++Z2QCMNVwjlnG1sYGfDyHjEX3rCBdbXzH?=
 =?us-ascii?Q?3epNM5/mB9aWC/2lygPdA1LQl0n/HgRUS+0SncAkB58jGsvPMiaFPNrCI1iI?=
 =?us-ascii?Q?I24s/lrYjKQNJhVdWW6UgksYj+t7EOr4uybK6qHZXdz3G9hloEeJN7oW2Cy9?=
 =?us-ascii?Q?nv9/Ps/z0bZMTI3N2e5w+wDYnZ+d9bv5Q2wHU7svRPlgVNwEvnreUeKJ59TR?=
 =?us-ascii?Q?LBPiUiauxnDBfPD+I7fefiXdvNg2CC7HNZEGKM+SiHbXqJFs/cmapG21wXMM?=
 =?us-ascii?Q?WxwtfWB5BcY5VOoFco0wJolUMVC90s9AZJGYkqCJCX7yACUjicMfL7Q+ojAp?=
 =?us-ascii?Q?qAkq1SHw5IsId6j4DNmBROrs8YXlxPtJdskkepqCs6krPbEw2gl9F1UGsAH5?=
 =?us-ascii?Q?ZVjF7aLckh4+XmGdwCPpKxztfQTxdw5RiBhG0ipEShRVeLdFnHCNON557un3?=
 =?us-ascii?Q?QTiwNqpwyu5ckduhTY1EkKfgO2VKsdrjCaY4lw2brGLTdj+UYpHJw76tfQP0?=
 =?us-ascii?Q?glAQMSH9OJVG5CViVhI/tu2DDCkga+DCje0q07O4wq+qrYkWlFbwl8by3XXl?=
 =?us-ascii?Q?8ERFFV0xoexZnxB6Bp7LpRNY4jpSRDR/v+4LUl+9wHqPJCeysd1GoLmb9A7x?=
 =?us-ascii?Q?rESosBR8Mnajs1Wdc/0+BhysVHfKBzfRBI+bu8I9YjeAJBfS13J/zVeDH8Li?=
 =?us-ascii?Q?mpD9dtkdKIsI0+jpmGGKftMKzxvt3/qEiuN2ShC6Xs2w4qp1yCsV01yRmN2D?=
 =?us-ascii?Q?PElvSTGSxB/rTy6NR5GCs2m8yDSnky3+eGXhKlb3ZA9ab9YPptX40J7+i4BN?=
 =?us-ascii?Q?xJGKEZk5Knk0vBAvpwAltg3RSllTjS19tBWIW8YLyOGrXdl933s/knoTkDnj?=
 =?us-ascii?Q?GTfOPPswhq+p/dQ/OZIyKWDZCZ6sXUGGThUeqv0U00fzrjZWD8pv8Lg4xKSc?=
 =?us-ascii?Q?QshwCMYsvELewdPPEcH7DHFgbC7kYoJVHPoU396tU07t81GFcefbxNh2Jbdr?=
 =?us-ascii?Q?ZV2pUzhnTS12JGHvCa30w0tqqM/9zemTF97gk39wqVPVvSnwsyuRkVDmE3Ru?=
 =?us-ascii?Q?itR060j0DziybQ7KWlo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c854ce0-2506-4d29-c9fd-08daa155df41
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 13:32:21.8456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcDxeN6j7ddcnbXL1lRBx0xxdkG4i08YW/YBrNn+SY+IDsvV0kHqDtRJa5duFWQM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5106
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 10:58:22AM +0200, Niklas Schnelle wrote:
> On Tue, 2022-09-27 at 13:56 -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 27, 2022 at 06:33:48PM +0200, Niklas Schnelle wrote:
> >  
> > > Not sure what the non-MSI reservation is for? It does seem like x86_64
> > > also uses this for quite large ranges.
> > 
> > There are lots of things that are unsuitable for DMA on x86 platforms,
> > unfortunately.. But yeah, I'm not sure either.
> > 
> > > This is because I'm getting a map request for an IOVA in the reserved
> > > region.
> > 
> > How come? iova_reserve_iommu_regions() reads the reserved regions and
> > loads them as reserved into the iovad which should cause
> > iommu_dma_alloc_iova() and alloc_iova_fast() to not return values in
> > those ranges.
> > 
> > It all looks like it is supposed to work
> > 
> > Did something go wrong in the initialization order perhaps?
> > 
> > Jason
> 
> It was of course a classic off-by-one, the table size is a number of
> entries but geometry.aperture_end seems to be the largest allowed IOVA.
> So we need:

Right, I dislike this naming usually 'end' means "start + length" and
'last' means "start + length - 1"

> Otherwise the first IOVA allocated is ZPCI_TABLE_SIZE_RT itself.
> Similarly we need the second reserved region if (zdev->end_dma <
> ZPCI_TABLE_SIZE_RT - 1). In your patch I think you had the
> MAX_DMA_TABLE_ADDR name right but would have also calculated the number
> of entries.

Make sense..

> On the other hand with the dma-iommu.c conversion it no longer makes
> sense to lower zdev->end_dma artificially, so at least on current
> machine LPARs we would end up with just a lower reserved region
> 0x0000000000000000 to 0x00000000ffffffff and can use IOVAs up to
> aperture_end.

So zdev->end_dma == MAX_DMA_TABLE_ADDR?

(and is zdev->end_dma and 'end' or 'last' ?)

Can you include this patch once you are happy with it, it nicely
tidies this series?

Thanks,
Jason 
