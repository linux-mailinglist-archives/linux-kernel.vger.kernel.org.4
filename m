Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7FD6C837A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjCXRlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjCXRlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:41:04 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D19C659
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxYwEHIVy4IY6hgrNYgLtBXTipJ63AZYs70ggDv6nc9E9HeRJyuxYvzlsdFuKWgprc1HgeySYbDrSI4fisS5N+pFTyLDPKKXKcWFXLM3u4Gsc3SdlPtQHu/eVI3L+3XjIUDmPNryww67Bn3ciGcMHM+6UHh+H46UZmgYC+jzdr9j6YmJxjkDgRwos7Ss2hi4nxFr+TsRZG+oLRVWmR3Yexd/8WMQuonsfGgiQ77wDLD6tzBqw7IEMlRyt1LMkgiZxX+ot7SOul/LrFi1zsF56sOrgmpxcASa0zOrGuF3Tbrpa2Mf9DiO987ceYJRbPNtLeEBsXQDjRikqbYBD5LwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTUPjhB64WuDigAC3hJihDUbn2g5xzZQfF5X8PDqcSQ=;
 b=ciAWEkgcWIGTjtTq5MciPk/tibk3LrUZEkkOHAQasQxj0bFY60cOGnlVP6GV+wSfHr+NB6HdRB0vGRssGF8QLox9RIj/0nNBwBHW+I7VoLoBQgs2hRp3G2A0+p5Kuc7WWw35EItE/zGPXEeHj37j9D8c7rdLjYEBxjQpahXoKWhvTdPSiATqPHeGymkjGT+ibk/ApKVD+b5qs8jfho5RuN7916vkgyJ/MHDf8n281CaUu3qYgSfg6t+C1Qvk3p6oRt2PFHcNhE6fUPcQymsjrxt2T6o0mBzufe9vMWLON2vZvy3eZpeMMtlPJFqYPUydBLjk8yMFKbLvc/855uYbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTUPjhB64WuDigAC3hJihDUbn2g5xzZQfF5X8PDqcSQ=;
 b=e0L3XCpiv8Mtkp1EcE64UaUexuzLGiL3xyCGicLBzWxxorzxcR4hWfHCJGTHyW1HxwrURLKIaJ/942wgIZ2V7ocVsLUd1jt/nDpv7gHs/SIUHy5Sah2/u1PTF9ni5kBFMTn5rOvIwtfiq5gyTDEgjVkeBVhYF/tjgQEOFcHWo4vex0ECU4+OQuu358yTHlINv2B+3V1NLJrR/Nz2MijmR4AUNA7wJsgiExao9w+8YexxkPtI5bLIK3J0V/X0sYsCV3qBVQjmiJ4n3PqB2L64GxYIRs55/ftJDphO65giLNu+xOvmW9BKSyCuPm3C5X1SE45RQ4fNuI9zVexDV2RZ/Q==
Received: from DM6PR07CA0079.namprd07.prod.outlook.com (2603:10b6:5:337::12)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 17:41:00 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::c9) by DM6PR07CA0079.outlook.office365.com
 (2603:10b6:5:337::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.40 via Frontend
 Transport; Fri, 24 Mar 2023 17:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Fri, 24 Mar 2023 17:40:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 24 Mar 2023
 10:40:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 24 Mar
 2023 10:40:48 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 24 Mar 2023 10:40:47 -0700
Date:   Fri, 24 Mar 2023 10:40:46 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
CC:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 11/14] iommu/arm-smmu-v3: Add
 arm_smmu_domain_alloc_user
Message-ID: <ZB3gnjeE2I/ubdug@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <7d26e897780bdc009b11bc0c0ddc7b755a769b24.1678348754.git.nicolinc@nvidia.com>
 <857004e1-6ab1-f825-7796-9c0b557e7cc8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <857004e1-6ab1-f825-7796-9c0b557e7cc8@redhat.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: f22981f9-5168-4362-3848-08db2c8eee62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3RQrTZA39SRm1n9CZ6ElUNoc6bIK6wc/t5LRwJu/zTpfRAiXMY0SLvXxz01gA3OO6MKUR7Yb++PapzfeoCiSYBwmJZH7LyiCQyo2DT1GS7APrYVpYBfDBVKzD7zFAh9kTMOUaTxtXOP3qyD7YIKKPAZDq5jPrhvIxmMOE08C7wwURNLiOQCucuV0d/R8fOjpOf6FE3FUvGRM2jPdmeSvs41BJI0ozEOY2O81SMnC8JGB/qj/wgwcMw9pIfgHpqdcfptMVYGaV0ObnnYsYquPxXDVQoz216/ezev/xuJVOXcHiE4fc0d7FQoVu2UlmopobjDTKNE1LkwrS0PPr81akY/2C/1bJDpBpZPBkRRe1yXW0ve3Bwj7Lx5wa19T6/ctcbJ7T83lNeAfqoHlDJURdLJOzo0NUn35nkGtBnW3uLau6+JtqIrqW/hDPm5J38gNKeqcC/M7AXNjWIc+5h2kpm3wdemtHFEi4Fw8spvKPJXi1vqDo5cIdGEzcSK4Xo1QM+ke2HpvNCMOm4NkCIurLrf0bsVC3xXXi2esJws3j0dW/mh1yvaJqMSnru0X7rbwluTFDEYp7K1S4fK2i2gseJCJoIUNFPzzUQVFnj7KuHlrT/OVHepVavInl8PwumYzB3t4B/gYUEnF3sK6YIyhK5fAHII/SzonXynCrG1CyNKGOizXIBraFBXxsy7kKTIJPRyGcVc8U81hGNisZs1BcjPSE9MyRr8sU9T1qqG2rBbuRo/Wl0sewEtOSkVbzdd
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(8676002)(70586007)(4326008)(70206006)(36860700001)(40460700003)(6916009)(82310400005)(186003)(336012)(55016003)(86362001)(33716001)(478600001)(83380400001)(2906002)(356005)(40480700001)(7636003)(41300700001)(54906003)(9686003)(5660300002)(82740400003)(7416002)(316002)(8936002)(426003)(47076005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 17:40:59.7887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f22981f9-5168-4362-3848-08db2c8eee62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eirc,

Thanks for the review.

On Fri, Mar 24, 2023 at 04:28:26PM +0100, Eric Auger wrote:

> > +static struct iommu_domain *
> > +__arm_smmu_domain_alloc(unsigned type,
> > +                     struct arm_smmu_domain *s2,
> > +                     struct arm_smmu_master *master,
> > +                     const struct iommu_hwpt_arm_smmuv3 *user_cfg)
> > +{
> > +     struct arm_smmu_domain *smmu_domain;
> > +     struct iommu_domain *domain;
> > +     int ret = 0;
> > +
> > +     if (type == IOMMU_DOMAIN_SVA)
> > +             return arm_smmu_sva_domain_alloc();
> > +
> > +     if (type != IOMMU_DOMAIN_UNMANAGED &&
> > +         type != IOMMU_DOMAIN_DMA &&
> > +         type != IOMMU_DOMAIN_DMA_FQ &&
> > +         type != IOMMU_DOMAIN_IDENTITY)
> > +             return NULL;
> > +
> > +     /*
> > +      * Allocate the domain and initialise some of its data structures.
> > +      * We can't really finalise the domain unless a master is given.
> > +      */
> > +     smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
> > +     if (!smmu_domain)
> > +             return NULL;
> > +     domain = &smmu_domain->domain;
> > +
> > +     domain->type = type;
> > +     domain->ops = arm_smmu_ops.default_domain_ops;
> Compared to the original code, that's something new. Please can you
> explain why this is added in this patch?

Yea, I probably should have mentioned in the commit message that
this function via ops->domain_alloc_user() is called by IOMMUFD
directly without a wrapper, v.s. the other callers all go with
the __iommu_domain_alloc() helper in the iommu core where an ops
pointer gets setup.

So, this is something new, in order to work with IOMMUFD.

Thanks
Nicolin
