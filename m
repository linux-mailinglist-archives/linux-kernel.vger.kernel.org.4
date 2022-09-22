Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C405E5FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiIVK1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiIVK1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:27:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEA9B40F2;
        Thu, 22 Sep 2022 03:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMhfB8LqgTvGNRGwkqSVm/OxouItyyFpEgtoS/05cM1EMlJWOSWH1lsXdHyWE6tERfOSV5Qpp8pWHJP1W0IPLWxmfOxnwza6LDVs3Dt7rUhNK2FZO7RqWP4Q+eq65hzVAbvf5491DX5ed3eIp4h12EKJ1NfyNGioYr6KHjYlv3aEGyHOVgrS2VWwEKQS637VYdDoSb03scYktmeSsJEc+gIyz//0iFX7DY2FJXtVHr0EgCTReMMEkNjTklaXKn2xkL3kjW8OtZqAKHtI6OJSS7y3Q48VhIMhUTVhedG9YhS1mQ/iBIWbx7X7E2anp/5bw3F3yj6rN9fNwZTyM0IWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2H3TGglmHF+tsvyRLaNKTuKJk6aRpfNCCAG8z9dk3A=;
 b=RPPhh1B7UgmCIircOKTM4oKjreCMphEEOqd09drJHP4rKVfKS78M6dd6i2Bv2BBCAafR0lnL8/loTjhTYHxYn7U/a5YpR+ae1f4U/QwRpNYBDvVrnCo18EgnP7+gSqThKtyicsZZZh/z38gTLt1JEJNgTXPH+NXEKe1VG0pSFes8Iyxhs1fYcOpidFSqEFlRJb0iOpdUD9TklG2Pm85KOQoDROI/CO0MlSY33axYj1eC3eDlAlcWa04uSwSDds9+eo3F92zNuNPiyE5LOInddGDIw2k6WMC25J8WzNMfVDnnec+HK+4UtMIyz+Ww5KpInzEiCykm6Em6RZXeHiE75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2H3TGglmHF+tsvyRLaNKTuKJk6aRpfNCCAG8z9dk3A=;
 b=RyNdHqYeQjYa9yQqeIlimfTupSQ+6+t08HX70uhBtcloYwDGRYEe1yBiB0nqg8cXrCaF11Vqa5bJmewrS2qlAfOrhjXd+5O+e/djuf59kFMvWjrBM4Zw8IV0cVGDllvSV/5B4Ny29IyXi/voqMBLwiRKX+4ZbRa2JdyO8Uo4EfO6M5T0HdACpPP5jTCKp985515tMmaP+hWmJOYmYG1LR/XPGwenWmr3h3lVOvLPDmkFQTSSRbCVgasXvq5y8gafVq2JGoC6r/CUmHezNfL50J5xAQ1QebW8jr6DTUDbNzByX8KqPhf5f3YGWxh4yRpg6eyPluvpksvA/Fhc1fbAIw==
Received: from BL1P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::28)
 by CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 10:27:35 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::fd) by BL1P221CA0008.outlook.office365.com
 (2603:10b6:208:2c5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.15 via Frontend
 Transport; Thu, 22 Sep 2022 10:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Thu, 22 Sep 2022 10:27:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 22 Sep
 2022 03:27:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 rnnvmail203.nvidia.com (10.129.68.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 03:27:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 03:27:15 -0700
Received: from mbhardwaj.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 22 Sep 2022 03:27:14 -0700
From:   Manish Bhardwaj <mbhardwaj@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <mbhardwaj@nvidia.com>
Subject: [PATCH] firmware: tegra: include IVC header file only once
Date:   Thu, 22 Sep 2022 15:56:27 +0530
Message-ID: <20220922102627.16705-1-mbhardwaj@nvidia.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3f9906-0dc1-4f84-a22b-08da9c8510db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMDDOUk34E8cOH+AqXWt/MnuXpXY9jMNfSF9d1rY+l0zX3+iz/SusNB0zy/dQ5xmU1X9rKEfF5o7XGNK6+H/BouC1Y0eQUWGDxvU9rxu8mu/Pa2ArsxWuw6S760n8+ZeHVcj6VQC7LbK85lrdzhvfaod03kJsN+QnXkPJlXMKPVLNgAvPZ7E4Me+zxm3ZudRL0ngekt9o7vk2BcwbhUAYovE2Ng0wX+j6LHj2xLZ8Qwm1tUr8fZQEO5JfiI8Ew/m5NPhMUiJo6D7VaV/iiorEAHQSEBOsExZHvPxAMz+M3jnrYqmc8IeDrRBWeeDln3mFlYlvaUa9CZvsF34DGYIHoXsCqcs06z2XhDcs4aVChvwRHK1wh0GhawWfF2q3XtIAjtlNiC9mTXu5x6dlt32aJciO8w9TD8WfzgKexTumZTM1BWjxR15Fh0GQxjLhkN3fdsbuGj3heQJwDRVLp0QheaqofPvN3wuMeffbsKn74F/BA9XW9R0tG1XKFDczm33JjqUcEqD07V8LtQ1soFQwYEjcLl9knmy6viwTuieSyrXkTXY8urgjRNr+IDfgy13GlY8K+C+vF+yzhIFEghQObeP6L5l6IpWiLK35jruw4IkfsRGvP1GPr0KUwxT0XSGYNE7SbfWeEepGElD6GlNtLBvu731MG3pgAB4ZEEMXJY68LdD/FtwbAjO3Nsup4rmwSlwXOZKE5SyavT3b80m590NhwtDxxYUZxC2j4oi9x04uNllGwXwWESxUv4oZ0eSaPqWMiOBsFk7bg+lWZelBw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(8936002)(478600001)(40460700003)(36756003)(426003)(40480700001)(26005)(47076005)(86362001)(110136005)(316002)(36860700001)(8676002)(4326008)(6666004)(70586007)(41300700001)(70206006)(107886003)(356005)(82310400005)(2616005)(2906002)(7636003)(7696005)(1076003)(186003)(4744005)(82740400003)(5660300002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 10:27:35.1727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3f9906-0dc1-4f84-a22b-08da9c8510db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the necessary definition to prevent compilation
errors from the ivc.h file being included multiple times.
This does not currently cause any compilation issues,
but fix this anyway.

Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
---
 include/soc/tegra/ivc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/soc/tegra/ivc.h b/include/soc/tegra/ivc.h
index 4aeb77cc22c5..88ce0bf439ad 100644
--- a/include/soc/tegra/ivc.h
+++ b/include/soc/tegra/ivc.h
@@ -4,6 +4,7 @@
  */
 
 #ifndef __TEGRA_IVC_H
+#define __TEGRA_IVC_H
 
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
-- 
2.37.3

