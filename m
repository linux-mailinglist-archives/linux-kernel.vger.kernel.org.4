Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E086C842C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjCXSB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjCXSBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:01:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEE81E288
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 11:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjhUgwfsVtEMSz7pdK9h8cPnqxYcwXJ7j2h9wypjkGAc8vnXOux0TP6Bu2YESO2oaSiiAVt2vFqMbUyiNCGNPjIQFmSX5krXd5PjcgkS9ypqXujO0kL1oKCEgQetTnVuj9nsaKv0r4VWOMM4Lx8ZxbdL6vRMPCFTMkDMUDVEtLSh/bVfMRfqFFDFpD3pB+ofy8fmAArg9v+Fuhjf5ZxwrT/BU5ZvNnLdNnRqsWgWA5Ta1ROhQ74DNzaPe+1RNtjgb6AJF3rohnx2bO/BaCtOrdus6m82FzrxbjJzskKm3m4FvPtYO3FWNVtJ5FJ48MUeBV5MElm0BW7RKlpG5gconQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92meGxCohnurVWLH49GJ9Sr3dhcju6YN7M4r97SxYsI=;
 b=jbZeSIjq6KpEAAySucqHfgjBCn67DPrzY5EUwAIxmjmslvU7IK3pLTth7VILEU6Os5mUCqJZls2YwWGIjOi2PJ5/pSSQjCxF+gBJI8Q7rEuQGflbBAmre7HiIrTtJGJrga9PZFzZ3JhSvudHxtNwY/5orw8AjN1wGnK9Tg6N7CR5mb2UD6NadapJj4fYDPNxWxwrPiKYEl/ts1EzsAXxzAoQ5tz2llGwZ3y+kldPrPaxPNJgcOlid3+n0O6ZVmktppZlVdEoYLEyXjVq+NaD5ug6vtdvElpzYepzUbU2OvTC9lr/wioRDMHLyOy9hK5mnJ7gZC8/thUvA5qDeGGCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92meGxCohnurVWLH49GJ9Sr3dhcju6YN7M4r97SxYsI=;
 b=lPSFhZm0j4+rVdx03sglXtKW4LiU2K7HRvNOiqpoX8z24ivgP+sgPGBqEJm9mT2SkyOtS/sSOCAhGV+YD0Hgzq1wwJW+j4DuwsjBteihhXpJNDJVaFoXV6VI6lCc8vXlc6VfO2tnJJOrChHzUJd3Hf9BVol0bbGUvoVs5LUMYD6xS1SGvmYRteGweSnZE62GX2ZthCy0hizpE0WuA1eyoYwdarPGkyrWLo+5WcVL2JZ1pJpylYng8h7fdJLDNtE1c1vuJVfyZKU9vQrnjw38RoC2ySwaHy57Ogw+40HF/hnM4B/0U1iJfsRmw38Ed2XzKIZMs2Di3ufq5Q+y1nAtpQ==
Received: from MW4PR03CA0278.namprd03.prod.outlook.com (2603:10b6:303:b5::13)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 18:00:22 +0000
Received: from CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::fb) by MW4PR03CA0278.outlook.office365.com
 (2603:10b6:303:b5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39 via Frontend
 Transport; Fri, 24 Mar 2023 18:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT083.mail.protection.outlook.com (10.13.174.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 18:00:21 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 24 Mar 2023
 11:00:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 24 Mar 2023 11:00:07 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 24 Mar 2023 11:00:06 -0700
Date:   Fri, 24 Mar 2023 11:00:05 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Eric Auger <eric.auger@redhat.com>, <robin.murphy@arm.com>,
        <will@kernel.org>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 11/14] iommu/arm-smmu-v3: Add
 arm_smmu_domain_alloc_user
Message-ID: <ZB3lJYGjkI2Qr4X7@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <7d26e897780bdc009b11bc0c0ddc7b755a769b24.1678348754.git.nicolinc@nvidia.com>
 <857004e1-6ab1-f825-7796-9c0b557e7cc8@redhat.com>
 <ZB3gnjeE2I/ubdug@Asurada-Nvidia>
 <ZB3i8pMdz/DCnGGM@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZB3i8pMdz/DCnGGM@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT083:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 661ba353-af68-41ae-562b-08db2c91a2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kgUqqLUyVr8H+354oNrNKHA+pllYQSrBfVSqdKwXq1u60t9/AVMiSHM9WEz1iJeToEMoM+IOcM0jISiWf2zVvo/Ps7zE+xQ1MAFqR51VeTRbRyLViWGfiZWr3gW9vfQ0wSFRKbMv/PFrX5xw6y+2Z0kmd+jiW4QBkeKAoX+F80cIMF9CPKWE5targpUNfyMekF1kKX+190KcVQ53tPfIa4C9EofdtTNgj0SrAfeWlN6Gg4LjY9tkG1HMPlrn+wYsLAJsOPNeTQWxplRKiTlVFKr3lH3UL1nRgcJyd5XR7c9lx46hGMnqs6ano0vuLIVqhYK2vGc1NFZKS4oMtwN99/gCfNJtsI7tkZPZD9zHQK8c11Pd0VZOElNbR+jOCkC7/3HCfgDIXBq5ZTlf7owvxEGAYfz/R1WauJtq2W2BlWqbisQQO5betbJ2oBOaHTJdwEP4+Jw/Euv7TjdOpUwxGBrxiF2rQVPXG9Dh4MUbVzWXdjKMJr4vi88Wnc2ixL9lf2bYehDLQazaUedjMwJbD6E+wniNIFhXOw7wr6UukkrMu0CKubId5d5cAcaAnJceUHLuODPjsm9Qwd50ucnSFUYb1I3isZAY+r5WgQwE4psoL1RveW3ompinzCie9y0Cod4owWXF8B/sadHFlPPybNIk42GunhtILgxMTQ2SCFfnEqJShaycAuNUrolsb0vYYQxFAgUEn5C+Ds1rPAY4wYwgeVVcxqfF8/4sQMZ7f6R6hT6KGRNV/VcphS7By36zrh0eqlpFSntA1ItR0SUIp7nBnTEj01R8pz1eu3AvAk=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(2906002)(36860700001)(41300700001)(40460700003)(478600001)(70206006)(316002)(6636002)(7416002)(8676002)(70586007)(33716001)(5660300002)(4326008)(7636003)(9686003)(82310400005)(40480700001)(55016003)(8936002)(6862004)(83380400001)(86362001)(426003)(356005)(54906003)(82740400003)(966005)(26005)(336012)(186003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 18:00:21.7987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 661ba353-af68-41ae-562b-08db2c91a2f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:50:42PM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 24, 2023 at 10:40:46AM -0700, Nicolin Chen wrote:
> > Hi Eirc,
> > 
> > Thanks for the review.
> > 
> > On Fri, Mar 24, 2023 at 04:28:26PM +0100, Eric Auger wrote:
> > 
> > > > +static struct iommu_domain *
> > > > +__arm_smmu_domain_alloc(unsigned type,
> > > > +                     struct arm_smmu_domain *s2,
> > > > +                     struct arm_smmu_master *master,
> > > > +                     const struct iommu_hwpt_arm_smmuv3 *user_cfg)
> > > > +{
> > > > +     struct arm_smmu_domain *smmu_domain;
> > > > +     struct iommu_domain *domain;
> > > > +     int ret = 0;
> > > > +
> > > > +     if (type == IOMMU_DOMAIN_SVA)
> > > > +             return arm_smmu_sva_domain_alloc();
> > > > +
> > > > +     if (type != IOMMU_DOMAIN_UNMANAGED &&
> > > > +         type != IOMMU_DOMAIN_DMA &&
> > > > +         type != IOMMU_DOMAIN_DMA_FQ &&
> > > > +         type != IOMMU_DOMAIN_IDENTITY)
> > > > +             return NULL;
> > > > +
> > > > +     /*
> > > > +      * Allocate the domain and initialise some of its data structures.
> > > > +      * We can't really finalise the domain unless a master is given.
> > > > +      */
> > > > +     smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
> > > > +     if (!smmu_domain)
> > > > +             return NULL;
> > > > +     domain = &smmu_domain->domain;
> > > > +
> > > > +     domain->type = type;
> > > > +     domain->ops = arm_smmu_ops.default_domain_ops;
> > > Compared to the original code, that's something new. Please can you
> > > explain why this is added in this patch?
> > 
> > Yea, I probably should have mentioned in the commit message that
> > this function via ops->domain_alloc_user() is called by IOMMUFD
> > directly without a wrapper, v.s. the other callers all go with
> > the __iommu_domain_alloc() helper in the iommu core where an ops
> > pointer gets setup.
> > 
> > So, this is something new, in order to work with IOMMUFD.
> 
> But using default_domain_ops is not great, the ops should be set based
> on the domain type being created and the various different flavours
> should have their own types and ops.
> 
> So name the existing ops something logical like 'unmanaged_domain_ops'
> and move it out of the inline initializer.
> 
> Make another ops for identity like shown here to get the ball rolling:
> 
>  https://lore.kernel.org/r/20230324111127.221640-1-steven.price@arm.com
> 
> There is a whole bunch of tidying here to make things follow the op
> per type design.

Thanks for the suggestion. Will add a patch doing that in v2.

Nicolin
