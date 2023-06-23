Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31D873BE76
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjFWSce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjFWSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:31:48 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7D92735;
        Fri, 23 Jun 2023 11:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCUaULNxWWAlqQ9xjLo+XGIbrpRt15Jh9GE+Qq9BGT54FmY+xpkhNuYQje53TC54I5btrnznwJ/nnsNGJexvO7jo71LMKe/KHpCStxzZGeHbN741PXC7ao+1gge+xFtwTEymVBTQEEetI/cpcJTPcH6YPbcLNlE6Rhg8v1tFleDycwrUrvlSyirhAaamK+59Vvl6M5uoistQutpo6xDDq0ACruqwHn8x+43PXNXe1+F5ezcXIRrxzNsI0x0uI4MJrkEo+d2l7fnn322MDGVc/EXwVuxnqk4jN6OsuSU1aJ7P5PzBvM1WLEPzdAD8pszQ5VimhBedcCMpgq/cEHeghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBofx8nJ065Z/7xjEOQ94FVM8KU6doa7jjFZg/97jkQ=;
 b=dwLIpR4mA7XCu3hbjEvNOSSv9FN2S2xc7vC/zcd4Od+MjZqNAy7tlhQbSwHqus5jy2yN60f+i3QoqDoYTXt6XZA6yE2zmCyLH2CQJAx8hYAl3APmjbbISJrKli+nHQgCnViVVpppDaybFQ2ID+QhVgHQGjh9fuRtjBGXWwGB1yWy31tDuSsmWb6nP5ly/+yDA6LNFtOD5xE76kos/ajYYNCzF1uaWZAP9YuTYHWMTEtwDyIvgQupP3BAJwLl6OnM+C+1vGAPYpPo5F4fdJ88JSTyoZn9hSsOuc0cVWEsYuE80PuwRnXwxHP6SJO0u9y4ZKs2EsakXxYOveuIEnMVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBofx8nJ065Z/7xjEOQ94FVM8KU6doa7jjFZg/97jkQ=;
 b=MdsP/8VnbyOp2SoqcrsEn6zt6B1T6viSRqbN/iav5z6iEw8Inh27LUGRFJOipZNKdc9B4X74WED/Y618AJcLrisCsybhSNMUiHoqqQGC9d+2LJYdkk5sCGATxZzz2AcExNiN8/72lkpOpOWCYZpCu/uflzPz9INAX2/MQShVyWU=
Received: from BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::17)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Fri, 23 Jun
 2023 18:31:41 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::64) by BL1P221CA0021.outlook.office365.com
 (2603:10b6:208:2c5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 18:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Fri, 23 Jun 2023 18:31:41 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:31:39 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 11/11] crypto: ccp: Add Mario to MAINTAINERS
Date:   Fri, 23 Jun 2023 08:50:01 -0500
Message-ID: <20230623135001.18672-12-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623135001.18672-1-mario.limonciello@amd.com>
References: <20230623135001.18672-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: e562be2a-5fc6-4103-9b06-08db741816bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9akY4JEQdDR5nCNPygGiUixNjemAYd98nwUrSeSerVUzje4rmkDLlvo5n4LZ1C0ue0MoRyoIF2i+DrSF0fmL2OgzflQcv6WP+noKH+NwdmFp4dcs+VR3cvHr5DLNNmeuw+P2pSK6H0+ehnQpbHahMLUJWlAZtZsFXlT8q1sb8YPMdTDxK6c1BDIF6e1bmIVNLVz0LX5X+nTsoZwP0W+4AHwjAqD40HOrkRMf4NzGgA9ObQyGGSYYxjuDIHO0nIFKkDThffGaR3u6N2gLXjygRa4t8FRkMDPHeI2dQOrVKYbQQ5LyCmx4aMg2bN5e04GnfFsXUiQrqYi6grm2hucTHfcNPTLOuFwlVDGXsHU7mTbFrI8Cs6YJH7YsUTdB2267bEBV0L/TxF8HPIsFIgC1LE1qcH2pgPf3DTGGStiVcbZn6+AEI/Dc4GNNHmNoPtI9NaQ5RcRkLxXildDVHen+pP7VKCSZUjiXD8IRVf10YscVy+bJD/I/YU65vND+zeXO7wAu/70kXSC05Pm1RKvkRqqCX/i9AMKTnuZ4eYbD0SHQrUa+QRZTWkt7ObwZfK8OWEZv+c6PTEBCOeNnk88k2S52cCLhM6BPDZY586Zbn9+wuyYPsjwD9JpIRJ0Q9Qove4LelG3PLHAJtYI1itGs02BSD3mvPGVVGS7kWNIeW22y0yDHaFniVDXyouif9njBU9GSeqrsFsUcP4t9e3PaxNzv4IInU2DeFHuPSL9b2+EAP6QeQQddcrJDSlELshbxK8PEtwyV60nwqF4YdH3Fg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(36756003)(86362001)(186003)(36860700001)(82740400003)(356005)(8676002)(8936002)(81166007)(47076005)(4326008)(83380400001)(426003)(336012)(26005)(16526019)(110136005)(1076003)(316002)(7696005)(6666004)(70586007)(54906003)(2616005)(478600001)(70206006)(44832011)(2906002)(41300700001)(5660300002)(40460700003)(82310400005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:31:41.2150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e562be2a-5fc6-4103-9b06-08db741816bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will maintain the platform access interface and dynamic boost
control support.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Pick up tag
v3->v4:
 * Add reference to new tools/crypto/ccp/dbc.c
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2e19f576fecd..709ebc2ebbe2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -988,6 +988,18 @@ S:	Supported
 F:	drivers/crypto/ccp/sev*
 F:	include/uapi/linux/psp-sev.h
 
+AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - DBC SUPPORT
+M:	Mario Limonciello <mario.limonciello@amd.com>
+L:	linux-crypto@vger.kernel.org
+S:	Supported
+F:	drivers/crypto/ccp/dbc.c
+F:	drivers/crypto/ccp/dbc.h
+F:	drivers/crypto/ccp/platform-access.c
+F:	drivers/crypto/ccp/platform-access.h
+F:	include/uapi/linux/psp-dbc.h
+F:	tools/crypto/ccp/*.c
+F:	tools/crypto/ccp/*.py
+
 AMD DISPLAY CORE
 M:	Harry Wentland <harry.wentland@amd.com>
 M:	Leo Li <sunpeng.li@amd.com>
-- 
2.34.1

