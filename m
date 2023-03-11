Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348D76B5BE3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjCKMkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjCKMkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:40:49 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3130E1386B2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:40:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghD2NGq2QIwEhr4eTd5BXL3RzuBZZfsxKULgn++DkBUTLO0CssJ/55FQdf3+uro2vmUBtgAGeTtI2KLmhbKqipGEJ9abxICRDkJhUAthL6bD/D2Emof38QCq1ErFqvOOaOQ2nxFdrv+gNZog2IH/wPGJcnRVDibsmo9Gh6DEDQOqD8kqzQ7Q7IoqnMPZ2tCK/82N+M72mLWGeZ24kbWFkvPy4r+d4zZXafjbAUPjcAQ9iSkO2UVXRLitAKeDDZEHyTz1IyJ6HeItdQ4MSUcVBm0sOSERDrbgzJdhouhV8h8KdSRRa7GUXi1nCZF5llotjHLhZWtugyBskKu9Z3Af3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7eS/qYqY2rxchTeRXq4XpIhNuglt//FBjPzG0JEyUk=;
 b=O+OVla/OslR2k7dBZU8uOlOl7W3DbaKAjbF9omA5182nOed1MSkCB3aJm+6X25EpLzqfftyNh2PDGiCMihTJKRNfKiH0/KY8enGOpMM0yilmkCz+dY0AzQGKUL8gokVJ5ZoOWy8CKZ5LShrrDURWwsnrKcTjh8q64kxi1iSFtK+bf3stlwMc7jI4CFajC+GLXR83GNP+5Gr4oahsJpG2ELgwg6BY4QxsJW3AC0xY4UcrvwDhPDpWTBABx72p/JCIhzEq374Ujbqu78ujZ/1mqNAUAsC2tyD6CHb/G+rjTXbkz86XBX8C82h/3iRIYuTwi5Af/XTI/UofYzf16+jZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7eS/qYqY2rxchTeRXq4XpIhNuglt//FBjPzG0JEyUk=;
 b=nNuDsiCvpYhKi+amN35qbKXB7NV+W7jeyYBV3gtPZk1oWKf7Iinrdv5Qi0w4Nx9g8SFU+Hs9QMiSu+ChuGfhWZRAItt35cDapUSAUX4iLLrFtwdwZ04Crrphv2++1m/9IJRD41TBvtK3tZRLstj74O8RoZW3NT3Lyg4EvWI3Zgvm2jCnrDKNFT+w5DMcxOeCnaXKOqrrrTPSW8rojnz/aS9xewnXGPLVw1VPsS7OzbrrRozAmpZCpZ02uhdMhXiBcuBLKaVe11RLc4icZ9E24mEhonvg5dmrAxSuekbwgMQduBNlrTwMUJ4XxozG3CHiQPtHBnL6iCHP/Q2yER5FxQ==
Received: from DM6PR07CA0130.namprd07.prod.outlook.com (2603:10b6:5:330::22)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Sat, 11 Mar
 2023 12:40:47 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::9b) by DM6PR07CA0130.outlook.office365.com
 (2603:10b6:5:330::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22 via Frontend
 Transport; Sat, 11 Mar 2023 12:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.23 via Frontend Transport; Sat, 11 Mar 2023 12:40:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 11 Mar 2023
 04:40:42 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sat, 11 Mar
 2023 04:40:42 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Sat, 11 Mar 2023 04:40:41 -0800
Date:   Sat, 11 Mar 2023 04:40:39 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <will@kernel.org>, <eric.auger@redhat.com>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 08/14] iommu/arm-smmu-v3: Prepare for nested domain
 support
Message-ID: <ZAx2x8iCc0cAFk19@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <4740f8a40caf68ccc1f9fee5fcdf1604546fb354.1678348754.git.nicolinc@nvidia.com>
 <0d1e585d-9a11-3f7b-4faa-dc2aa8f961cc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0d1e585d-9a11-3f7b-4faa-dc2aa8f961cc@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT113:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e10820e-69a5-4696-9c5b-08db222dd69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdsKRV9pdVXsQfDWfRwRyN2x71VRrwBEVTKMbHV6OL17zMPAUIQaZY+Lp6nszrL6nJYIOKqK+jaVwjZ0pGsG/SHwaLJKGNomZFE472Am5cpTXHos9xT5ZrZevFwwqiwwotw6psJNILpGSMjoRHuXIbpaMP2DsYkxsCkSgECxsVkFPwItpVHYSXAu2zFGr0MhkewAEJt9HWndL06Kce3KNPBCSxYerfvJs4yCqUVwWLX1oSRwbgFvlkcdpVadNnoEGzIHXRKlQilj0+NT8h5QTyVD5TCFJ3rPLJTDS3Da02NozNmMz1mI5BGqY/fSz2Abn9AH8CfemWrEsS9/fYZ2Da5B7kQjf1plkeXeOKZ89qs9fQprGB7VzclaGGlx1dcNfq4XI1LMgFIyy26eyfXNuh9bE6C702c7m5MYHf/9PhtdsVYn3xooodqxt+9ZWk8Yyo+TeC/gm+3pCSMcFqQR65mPPkivw8+6vL9MOu3yqN7mBIEJsKQbCDANwRF4guknJ1d5rnWjAY2Zy5/cTW1GdF8b6fg0b0dPu7EO6Aj3OcwGZERaNZqE+yPFOqGwooBcKSynQlNn9rPf0R4nkhu7LSKY0/G6Cf5jC68hfEJ4aX52R33POIiubsjE3HFbE5aIeKTNVHxeJnnuJWoHZplTvSZgWzr35WzYTFIQ9f+Rvx9S/X1fkBkKHqCd44rGkmMIiqGB3mAieV9hNP9O6qMqRxbc212+ML0gPdosnimx/Qc79MwZAXyjBwnybHrVWw1z
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(82310400005)(33716001)(82740400003)(36860700001)(426003)(47076005)(478600001)(54906003)(7636003)(55016003)(316002)(356005)(336012)(186003)(40460700003)(26005)(9686003)(40480700001)(70206006)(7416002)(2906002)(5660300002)(8676002)(70586007)(41300700001)(6916009)(4326008)(8936002)(4744005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 12:40:47.0889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e10820e-69a5-4696-9c5b-08db222dd69b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:39:20PM +0000, Robin Murphy wrote:

> > @@ -1277,6 +1295,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
> >               switch (smmu_domain->stage) {
> >               case ARM_SMMU_DOMAIN_S1:
> >                       s1_cfg = &smmu_domain->s1_cfg;
> > +                     s2_cfg = to_s2_cfg(smmu_domain);
> 
> TBH I'd say you only need a 2-line change here. All the other cases
> below are when the stage is guaranteed to be ARM_SMMU_DOMAIN_S2 (once
> ARM_SMMU_DOMAIN_NESTED is gone), so pretending it might be otherwise
> seems unnecessarily confusing.

Oh right...I will drop those.

Thanks!
Nic
