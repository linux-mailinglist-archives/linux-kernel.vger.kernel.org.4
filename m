Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305086C83B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjCXRvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCXRvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:51:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6AE1ADDB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2rEmTzLHYyjJfTeuzZvNiubTf0PrZbL4t+R7Q/3+zzhFbBQC4KDT+CIo3SNNssjTejIeSG2oLlh+bBV3mkUKxVadyCr1Dor1xXGSDXjLyri6nzqWiRtLeLSf1dkq6x6P2arqh75IaixAXGrBFEuyXOZCc5BQr15jClsb4zQcpe7yaOr8yEnb9eX/gkMQCoMWsSxSf2gyyqGrrEsOkai+ujVF4qduaWtphp58RgilVStXqPwBs3Bbxvk7z7ygWb7UFleE0searwXXQtElpy34/IFvgiBxRL06jXHXhv0u4EMtRTcidgYOJynbAWnZ4VgELh8C020FXuQxvvnZHP/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24mq2hZGwUSuWTzgH/k8ffr2YyYpV48TSOPtn3gOyBo=;
 b=i0UdVJQN9kWtXjL/2EOBTn3nqkNXWDPJywh0GMypNzE2fbZ5rzVTF1CwVqxRtTf8J/XtmhJzbcYLLvCeM1jda/PGUoUtaQlw2YH7jTLExq81/AtIkySeWsop09nnWSfx94u4wYAwtJQj0Z0BqS5GpXji/ry9YleSHgx7DkzviOurSUTQkNGhN0b5ZqzCIYCswjMktiJ/YhS0sCMVSp9zb47K85GMxUIUwQw/ls7N6A6Thd6FDy2Nx10mWnsUyJzEW/cDswLNPd7fkgWFcunHbBHX/rv3cCZOTbbycqpmhYQTUfgIi7MDwcF7G/Rg6iD2NwA1gocIYx4ci9WUJX8NQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24mq2hZGwUSuWTzgH/k8ffr2YyYpV48TSOPtn3gOyBo=;
 b=e2QZpm6nckIyBrm34HPREGwoe3dRPgRxGqcjWnXSSLkJorQHjvHafXF9L1zHWmn5i65XIuRVbjapGYNZCwmBFTQPPYheEWzC0ksIjszGaXzZFcoD7y+wErVvXU//ljrM6eGnQNkuu2wm1N11blYUkiXEkKQFEzB08qFrPGw3DvcrKWDo3rLICz5Zo/AybqKZgyYZOayPDGP3iI4VFGElaAYdgThlfDT8LYAbbeAP2kvTvVafrGNMgl+v5HEx82QG34OTUHiuRWu6dXgN8NZH3XJBjL6cqEq1SibWa5X0fAsgCGSQS//vAu36J7Mp7avUjji67Omx2XobZXEaVTiSIg==
Received: from BN1PR13CA0005.namprd13.prod.outlook.com (2603:10b6:408:e2::10)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 17:50:49 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::4b) by BN1PR13CA0005.outlook.office365.com
 (2603:10b6:408:e2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.9 via Frontend
 Transport; Fri, 24 Mar 2023 17:50:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 17:50:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 24 Mar 2023
 10:50:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 24 Mar
 2023 10:50:36 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 24 Mar 2023 10:50:35 -0700
Date:   Fri, 24 Mar 2023 10:50:34 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
CC:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 12/14] iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
 type of allocations
Message-ID: <ZB3i6r7QD4NVBXkK@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <b01b2bad6d0d34908812d964eba118a9cc1e89ab.1678348754.git.nicolinc@nvidia.com>
 <b870ec68-623c-df0c-3ea5-7fe6a95e2ef6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b870ec68-623c-df0c-3ea5-7fe6a95e2ef6@redhat.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 017f3d26-75f7-4978-065f-08db2c904dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkkuYH7NcJKhbP17IiCKpOx1MxCAW8fSuBEmnGPx3GuAvSguU03tTJQ5R7Fem1i/AL/2T6/HUjGT5FWSCLDAkMJ9JZ+fCbNLDU4gqVD909jzcY6R6N64h/JMHVuJULDA/MsZh+OkR3bt9UoCi2StZSG7984HYsU2e0MwHGRs6XTRtd3kSYxTw3MpcyS3OM3+M4vulLC3HUYfemBAdB3FG7r1etkwLkCYnVPqjYl97vo60kfNTjboF420g7RLh85/RnKGsGoB6hDCLcIAKohoHUF5WV/mehp1+p1J/ehaxLP0rAgHoRxf3tWiG3gz19JeK5Jpvq5BNisLd4gdcNjoGdIAxZJC8rQq/psopRR+GdUXbTwEdjEWEPtu/Q5PgDOdt4wxXw7M4MOAU5MUE+OLw8ZSBgec6dBGARhEWScZqXM3hDMvK2bUaC8gJmuzzC7V93p7LUfJm1gYMN/2KN7llXGSV4IZvBc1VwcC0CKaFJEh5UwBNzzE2YE3LweYmXgNQ6jT9OOW/RqiD2N5Zm1CrF16npAPSCb/xTC8iP/jusajN120b1bcKXmHcPmlb8Y/bBHujUVPRoHgzFpR8cL319qjAmPW2vZSLlqU8xHeoInn5t/cN+2PlCdr7XR/g/1Ra041MqHlyRmatrU5650R8yITIl0Qw4HPAVUoVlsxoJJcjl/EFwAfu74/bDZgC/KVCqpBiWnlol9GAAu4UE0QngAzTDrellKXMFgxr3Sit0E=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(46966006)(36840700001)(41300700001)(82740400003)(9686003)(186003)(54906003)(426003)(478600001)(33716001)(4326008)(70586007)(82310400005)(70206006)(8676002)(55016003)(6916009)(86362001)(2906002)(5660300002)(36860700001)(7416002)(26005)(4744005)(8936002)(356005)(40480700001)(47076005)(336012)(316002)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 17:50:49.1885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 017f3d26-75f7-4978-065f-08db2c904dbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 04:44:58PM +0100, Eric Auger wrote:
> > @@ -2923,8 +2949,16 @@ arm_smmu_domain_alloc_user(struct device *dev, struct iommu_domain *parent,
> >       const struct iommu_hwpt_arm_smmuv3 *user_cfg = user_data;
> >       struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> >       unsigned type = IOMMU_DOMAIN_UNMANAGED;
> > +     struct arm_smmu_domain *s2 = NULL;
> > +
> > +     if (parent) {
> > +             if (parent->ops != arm_smmu_ops.default_domain_ops)
> > +                     return NULL;
> > +             type = IOMMU_DOMAIN_NESTED;
> > +             s2 = to_smmu_domain(parent);
> > +     }
> Please can you explain the (use) case where !parent. This creates an
> unmanaged S1?

It creates an unmanaged type of a domain. The decision to mark
it as an unmanaged S1 or an unmanaged S2 domain, is done in the
finalise() function that it checks the S2 flag and set a stage
accordingly.

I think that I could add a few lines of comments inline or at
the top of the function to ease the readability.

Thanks
Nicolin
