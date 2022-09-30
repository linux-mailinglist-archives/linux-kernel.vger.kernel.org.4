Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8934A5F0CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiI3N60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiI3N6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:58:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E5415C1FA;
        Fri, 30 Sep 2022 06:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ku29gCPpzKBtWfABdXYNkcvg6Y5YP8EvaeYb3aEAG20kG32sYYReOU9vWJiGS4KYiHsRKMHqLbAXaScU9qE1AFrDy0/7soq79LX+iq3bpECuYb3qVP+PiOILNUMoeOLTE5JIj0IydgMsXDFGCVyp+CnskgqhsYeSL12oe222+8sb7fAA7hiuTl6aEygJ/ilCiO/WdlrjN0n6rQj+klfi0IwRtjZxf0prYhtCZoHKQilVzBD8nPqLWcZy4z5bsZSYqs1N/DgZox6IOsbjtncaWDfBXYPMRh0GCqcdoW2YkRkCnwJatjExNoXsS4vgSbwJGhTptLEN2iClzQGkspzFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8c5YYbnbCYJlj0HUR6twXuRfMosQoed4byK8yxzaZ0=;
 b=m+p8DZ0WLBTUCA4GBzVitYh29uTwl7rTgyPfxV3HaEtDlMoQ5HDkNNdAUfL+CJ5nWYw2N/dzSsRlrRfonp04czLi+KmHvnsWKUzjKmd0TKc3WnYIl8lRyS17RUmSB0Ta4yHCvBDS5/xU65+ifzS7e2rZEVtM+OGkGGzQRB5eHaFPFdMLB+CopjaEzkZoqmJaag+F5QeTNYK/vZeAvKa5kkjyMrWnx+yN0arI6FhCwa59FtpC2BfGjfeZ5ynlD/3uuN7fa78ptbEZGmimwQdbHSYAcZPkmF0+aeHzUobKA8pOcW/Fw8HaH0CVWlGFDgv9wQ6/0JFLcA4O8v5d2GcSEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8c5YYbnbCYJlj0HUR6twXuRfMosQoed4byK8yxzaZ0=;
 b=BCGewXYD9GMtnKxvl+QkCiGiY8OYxGfWeeYl6yTQduXb5rUTh1G+kB05X+CiRMZFetQRgTNtH1KwpqzkzDsz9WhCOPiInY3qDvNUrHGwybGykcFxUUr2tcbCzKXO83MCrLIiJDqkCUmcMozZFvO4y6nUzA8CvYUmWP7nmOdL/mNCMx+0Rc3SW7H8n9M9msPRzqd6ywIUHllh2n+XXcuC/QBz7B863Txg/JbPoX29soAG6CYrcNzt55IcUS8TPIac3uRtS3+xp2qUi5+Fhyd3fQbaRF+W49xFqaYShsjeE/C5/GpC0WjCnjhJq9KXNyiznknWRyHz51Qct+SSX32q2A==
Received: from BN9PR03CA0791.namprd03.prod.outlook.com (2603:10b6:408:13f::16)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 13:58:20 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::71) by BN9PR03CA0791.outlook.office365.com
 (2603:10b6:408:13f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Fri, 30 Sep 2022 13:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 13:58:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 30 Sep
 2022 06:58:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 06:58:17 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 30 Sep 2022 06:58:15 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>,
        <treding@gmail.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 2/2] arm64: defconfig: Enable SND_ALOOP
Date:   Fri, 30 Sep 2022 19:26:34 +0530
Message-ID: <1664546194-735-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664546194-735-1-git-send-email-spujar@nvidia.com>
References: <1664546194-735-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|BL1PR12MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: 0506dc37-cc11-436b-40cd-08daa2ebd556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2PxRJslRO5dqH1FjcxpnsrN37amAPVO8RjwygNh7lEf5Lclfuzu84p/xO6AoELO4jocji3QJK5vW7OAACTtzuhuoIsHrNjVnIHPpF4bOk0rTdb/qbKljyof/jxi4uRmvoIa2UmQG6DzjEuDNKyLlSlHrhtuxb22Ed5id+7NsmUF0HQ1DhLCrKNUj43dRsrxCKQRtc8IvW9clY6UwIe4n91Xhb7OeJBaM4ti/tTHuKV2D5xIFCTK1m3Wbd5L9SiTeDtS/T02T9PE+hglRDFn5IhgGOVGpo1EYIaMfOBFLPAqvXo+/PpOoQ3jvNHlS6xhZCUApzniQId3C3AlFBFONAu7BIBXMQbxMVaOYgCWhus7TRD2OBl4rEj4gEOwBEmel8Drmp7YuMfSKbxsbJXpm1AScTpdvwRh3iCfQiOfuOQBposRax+q9kq0oG8zMalGjL+/2h5/DUU3DGOYqh4PYHLxOzNI9+Olo09eUjkTnDiNUzUhNPMu5lCw4dMadB/rwR3qO6hz75xpXsvUZIAY0pp0dUbo5KNXp4zz8WzHgL6KifTjLqPMIejlyJD6Qu03CZBD/5QZr53E4vtEnch5D0clys/Wn/mP3KZVx8OJVVCX3CqHxHO3LygD7nduCJH36TNEIcfO8MpfIzw4BrMWpUPG3Kn8wKA6iQbior57FxiFyzoCKFzrkCCTYcfHpQ2uao1wJ+mVyVLDgQM2hRbTamTP++Ql7w60uB7bxOIDB3MGWXouiRv5S2EP5li/NLxzPtznX1Q0CbQ4jZaC45BpILQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(4744005)(40460700003)(8676002)(54906003)(316002)(8936002)(7696005)(41300700001)(5660300002)(4326008)(36756003)(70206006)(107886003)(70586007)(6666004)(36860700001)(82310400005)(26005)(356005)(7636003)(82740400003)(426003)(40480700001)(336012)(86362001)(2616005)(2906002)(186003)(47076005)(478600001)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 13:58:20.4529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0506dc37-cc11-436b-40cd-08daa2ebd556
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable generic PCM loopback driver.

On NVIDIA Jetson platforms, customers use this to loop data between
container based applications and host OS.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b682318..048e479 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -789,6 +789,7 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_SOUND=y
 CONFIG_SND=y
+CONFIG_SND_ALOOP=m
 CONFIG_SND_HDA_TEGRA=m
 CONFIG_SND_HDA_CODEC_HDMI=m
 CONFIG_SND_SOC=y
-- 
2.7.4

