Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5080F6BC305
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCPA7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjCPA7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:59:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA4B1A663
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ4xSmYuLldQvn53NhhuRJ/JRN+z1/hcpMgEb4pLG1E2tpFfHGZWC+qE0T0Nha1vn94kmVAleYYYEV7hq36bKcXzQzWX3DPnCcGEleD2SGh1QnBCxsKLe1n5TAf/0DQjhYXjljnTD/oDpdjYC4tr8zFmqbjZy2K1ghr6AvIl/7dCLZ+DSQH0nIS9xtiQDJ/oECiuuew4tUZh6KBmUbAE6WdlY75kmo7pHYmpeOpryWILGWc6iNKTMisUz4bUYu+DqIczCBXg/DQINAxaBC0Zw//kmKtFCdgdKS+HaF5u2d+O+4vpuNiT0k596uhvA6bRgYEFbwtMbfpkwj3VMmu+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Sc5ngt8zESYZYXPFu0DsdNN1usiEmPY9wvPeexNplY=;
 b=l2r9N2w5A+fWM7EncPU79Q5AdLhGljw7aJvCeniQ4gxuRNfGxDPNnHXttPbspYzThGtJaAqH0u9UY/hTB+QzKjQDWDmv1q0VRVjjqYotqJbPR7RzF0OaJBx4sR7LRC6cHslPpiD6cZQ+TiXSNf5X3D0yMYPDjV+ckgxA1JtzpJn5LXPx4QWZozY7PdZr8wSWeb6xR5f/DJlodgNniOGNpo7HyrkhoZw6pbl0mi+DqNHFj6TjXXQ0qH79XpEuZIikZW1Nj3/XTB2c0ru9l1w9AZsfb/FhaHtXQtSVZ1Evbh8kQnXgIj0eKJJTIKsQoTM91Nqw5/XvaHdeCdoiX8x8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Sc5ngt8zESYZYXPFu0DsdNN1usiEmPY9wvPeexNplY=;
 b=qmru32V4b5QlKDfb9dWVVVvItaB0VgbG/Ru6r3hoyFhZpTyXX9xwgOz/v3JCRqzI5LiSaVcU7zQpKjkAuGggsVJlnIiiXSVwS5GD2vM3dKAnX6YOCv84XqaEqCEyj1jSKGg78eMTbBWjnNiwgXscDoU68NW29diYF0xT4lXnWdVV8Fleu3bUKLGvXoITDB69UEgM2xpvNazUilmX8l9a2gmP7NU9tSVCFqTgzFnTuMXXk8AMcsdr/4RNE+rHm3HJYSQDd1dqKd97fErSg/zr1ZsnsK7QOEfxePdLACPPNbEn2xwHipbpo+A+HhDpyEC7BCCQISbZatMW9Evp9uvJ1A==
Received: from MW4PR04CA0119.namprd04.prod.outlook.com (2603:10b6:303:83::34)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 00:59:43 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::49) by MW4PR04CA0119.outlook.office365.com
 (2603:10b6:303:83::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26 via Frontend
 Transport; Thu, 16 Mar 2023 00:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.17 via Frontend Transport; Thu, 16 Mar 2023 00:59:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 15 Mar 2023
 17:59:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 15 Mar 2023 17:59:36 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 15 Mar 2023 17:59:36 -0700
Date:   Wed, 15 Mar 2023 17:59:34 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <robin.murphy@arm.com>, <will@kernel.org>, <eric.auger@redhat.com>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <ZBJp9qhc9UON/Z5/@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <ZAnx0lUkw02cVTi+@nvidia.com>
 <ZAq3LJgbo8ApejvU@Asurada-Nvidia>
 <ZAtVet99P22FNusJ@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAtVet99P22FNusJ@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT021:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 1818604c-ccf0-4797-0aa8-08db25b9b925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJ9PkLBIeF0XYwQfzJsbfKk7k0GDeoY/uLT0VY+DepIAgJmN+aXIce0Ndh8SFxTkdTLtYkSii7yAbYuojJVr+4xNCj5ADQ2cDqBE3p5Xve1KgSgBz4MO2C21fBXXkUXSarbSEDF79oD93ZRx6qqq18w6BQJySf4+kQiK5uOF3LJxUZGqJ3l56qyVGsiEnId4V3koEoDb35EzhCmQy81d/GHlBxGCAiQ/2F0pe4cs/ZRSfS+v/tbnTI9VyQIqB9/iNX/mWOxPbrm8fHpdYGH19XcNU3wTAV+4TYbgW1TXAaQTNQk2qoEwFSTpheJbfjfqknWMmOzPQjhdmKWHnC5htb5Cv6veZY06NvXvs2QkUCzhVTWAkLKHKvwhFc/libm9j01tMQ9HRlIfbOQsqw+yP/DyzT6uo/VFAv0ZpHk4+ytzU3dGtg6TdqrTzBbIcwoqbri6ldp3YtbWq7kpMa5yF9i1F2LZOSg/iXA/cNgpzPSQVJZ5dFABncIJhhrQ9jkKSZ/RnD8P/Ro2QRjM2SmawddxEhmDs8E89/RArSN5Y7i7Om3L1FjANjUggH5g0MJph5DGhW80oqTKanYN+GXedN+eMLLvvTmPmqlvPBd85UqSwvMtFCOZ3Uu04fEmuJw8uzzrrmhM1pqKZxahKpapjYYLrvZjfqAYLzm+jmpCQXJdUIpD6MAInmj95Hf/SR8ae0PrZD1VEv2XWZOmtD05l8/MU35Kr8d3sn2ylSn5wO3sZJ1bjtyZqyyhn1U3QC1q
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199018)(40470700004)(46966006)(36840700001)(82740400003)(356005)(36860700001)(70586007)(41300700001)(2906002)(55016003)(40460700003)(478600001)(40480700001)(6636002)(86362001)(54906003)(316002)(8676002)(70206006)(5660300002)(426003)(7636003)(47076005)(4326008)(82310400005)(26005)(336012)(7416002)(186003)(9686003)(8936002)(33716001)(83380400001)(6862004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 00:59:40.7509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1818604c-ccf0-4797-0aa8-08db25b9b925
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 12:06:18PM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 09, 2023 at 08:50:52PM -0800, Nicolin Chen wrote:
> > On Thu, Mar 09, 2023 at 10:48:50AM -0400, Jason Gunthorpe wrote:
> > 
> > > Nicolin, I think we should tweak the uAPI here so that the
> > > invalidation opaque data has a format tagged on its own, instead of
> > > re-using the HWPT tag. Ie you can have a ARM SMMUv3 invalidate type
> > > tag and also a virtio-viommu invalidate type tag.
> > 
> > The invalidation tage is shared with the hwpt allocation. Does
> > it mean that virtio-iommu won't have it's own allocation tag?
> 
> We probably shouldn't assume it will

In that case, why do have need an invalidation tag/type on its
own? Can't we use an IOMMU_HWPT_TYPE_VIRTIO tag for allocation
and invalidation together for virtio?

Or did you mean that we should define a flag inside the data
structure like this?

struct iommu_hwpt_invalidate_arm_smmuv3 {
#define IOMMU_SMMUV3_CMDQ_TLBI_VA_LEAF  (1 << 0)
#define IOMMU_SMMUV3_FORMAT_VIRTIO	(1 << 63)
	__u64 flags;
}

Thanks
Nic
