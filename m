Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2F36A725E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjCARxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCARxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:53:01 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B4B2128;
        Wed,  1 Mar 2023 09:52:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM3do3m2hv73+/K4OEnYOlGKoMCquTqFRF9n8q4bJRml4hDTFF+6lYwavLJW/Lzf2bnn3mFEh19Z8Odph7fetsupUJ15A2Acx97JJdsYGaYLKEm2d537k3H25+atMssPQG5Ik9KcsxFuynOET7L8yFbFnXbJtXZ74wDfshexBfLhtHpO11waFAxv7IPBWrjDv7epkskDJJk2tTkDrecKLrMgpp3oVlwDDrpdbz6bH0ImkOfyWyAOnENZIfQCVh+or08YtdcDGKZJEfqNImrxtebCuvkyE979q7EnQpI6m9Z//aJ2mEWG2cHmE+wd8KgKy7XzkUNL1s9QpmSc3qk3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdlBtt0WHQuhSrm1bxrrYQpP1CvyNck9uDPNo5Kj818=;
 b=Rga4CSgoJbva6TrgUyfvlaLD6c+G83jyBKA4sFjIsHZuS4BDqlFfTUKQLmND3YKlA/t0nZbHe/G/xdr3grjRKKnEtKSn0+Tc+NUSPKgmmkvShYQAH86r6pdZaZp/SnmcS6mXNeifhI1i79DDgtJKe6X0p5pxzrWloKvsAM9c+7vJDFkIrpZ8j6OiV06SIQOV2wZMIKw1ZhfhIp09Kn39yqqOdQJnKobRko/mAQp958GKh/u4QVEB76rU1DLl1c3P35OBKm07wsi69CKrvW9zlnc3jTuw3bGt+6jDHFUZQ4zgL/pbxAexsa+19lz3dBzEbsn85V2KqxtMFdlnuR5uLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdlBtt0WHQuhSrm1bxrrYQpP1CvyNck9uDPNo5Kj818=;
 b=jur6mZgaswk6ihVzbODJDiATtC3Y1oKSMxgUkRBBTtieMpxnIH3SROfU7Da2vhp/jLg9YAGOOR0lyxhS6FHpMHlJvhjwvIXPMup/1ctKeNaYrcG+3/laISmvA6W9+DsEjwCglfG4952eMcT/jJK7rZbgJ24tgIOjsTK83wtrVBI=
Received: from BN8PR15CA0058.namprd15.prod.outlook.com (2603:10b6:408:80::35)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 17:52:49 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::17) by BN8PR15CA0058.outlook.office365.com
 (2603:10b6:408:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 17:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 17:52:49 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 11:52:48 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 09:52:47 -0800
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 1 Mar 2023 11:52:44 -0600
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@amd.com>,
        <neelisrinivas18@gmail.com>
CC:     <wim@linux-watchdog.org>, <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>, <git@amd.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 4/4] MAINTAINERS: Add support for Xilinx versal watchdog
Date:   Wed, 1 Mar 2023 23:22:29 +0530
Message-ID: <20230301175229.342004-5-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301175229.342004-1-srinivas.neeli@amd.com>
References: <20230301175229.342004-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT035:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e81c67e-1519-4f5f-f447-08db1a7dc5c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9o3z0x8VrB5fGxVlEsfytV9vrAPcr/Nn3t8yxJoX4M8dUi3eKrvVKyXwY26/svNlOiSygkqfifEWseYtMFxmZzJo06F33SX9XhUclLYocFp0SEvIcFkc9Wz2b6czGSk/pxuh/fNllnowZGfpGzPZBIFMvKZ+rJ28tbjZnU5BNXraGRKk4nqttpDpzNSTjzN9790EoBDc69AxogE8l8j8SaT9wijKJfcoNXeyqFLNTClk2bF1gxymM1W7nmRkOGJH0SKp9KCLcNVSFkw65dHSG+Qu7lo8VOIQUTO7WZLoqHJa5jOU3oKaEB2kRJV1q1RKzyCaG8G5Kk+vahEFFwb754FvQXfrHWYFuFFm0ULFp6Rxb/xl0R7sAH0qkJdd9kiKpTlXSo3mfRlnnnRNUoOKcCipuOiXK0KrbfJsRZb2DV25RlcaIK/pok7IT97CP3M6kcKOqVh8tWJvZESRPSOqJt41r5Gh3icR+6Tw2vNLWG2eBcpPJyJ6NSpfycOXO0YDd6Pk87GCBw5bVQ8z36pRfR7tvNd9LsRUdgYFw9pXKvncYavfZ7pbQMn7942lTJqR+xElSvwUSIQZ0+uLWIOUqOBO2BC6FySQ2+7Gg/tKONMOyIZUPtO4QjozBO3SSVJ+Jgt4rq0gTUHfPqoPai0nyWABk6UqmtNYGIQwb+Avt2sda1AvZYE+b0dWImBw57O28PxHRTBunFXysUqCfmOB+dqWXyfrH8DaLf6nBjDY3o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199018)(36840700001)(46966006)(40470700004)(82310400005)(81166007)(82740400003)(40480700001)(70206006)(70586007)(36860700001)(6666004)(1076003)(36756003)(41300700001)(8936002)(356005)(40460700003)(2616005)(336012)(316002)(47076005)(426003)(478600001)(8676002)(110136005)(4326008)(54906003)(26005)(186003)(86362001)(5660300002)(7416002)(4744005)(2906002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:52:49.3841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e81c67e-1519-4f5f-f447-08db1a7dc5c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added entry for Xilinx versal watchdog driver.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7731e3ccac0e..77a8cff9ef03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22987,8 +22987,10 @@ M:	Srinivas Neeli <srinivas.neeli@amd.com>
 R:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
 R:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
 F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
 F:	drivers/watchdog/of_xilinx_wdt.c
+F:	drivers/watchdog/xilinx_wwdt.c
 
 XILINX XDMA DRIVER
 M:	Lizhi Hou <lizhi.hou@amd.com>
-- 
2.25.1

