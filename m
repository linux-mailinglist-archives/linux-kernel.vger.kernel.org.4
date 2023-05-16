Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A795D704FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjEPNtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjEPNtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:49:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463B5193
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nenm0oiW9mnez0/IWDNSuAxSZawECMuaxzKTLyLBtdBB3OSPDJmm7jEIJpGpzTLyGYO0vHCFrf0hDvrIRqM81JZ+HZ8Q3SCUSG9sBiB4ps5zai8zbbniwnWr4Tzi13zpGAwCysW4PG4mULOf6Y4GiaXM1QROb6A/Auo46QEUUaLK05aeFG/wZv5Gjbq3lLVaFV3TokcRlKUzA8OCktZwI3b/QQ6ULWwDpBs/gWGJqAPaY0TBa32sUmj3tBz3FOtw0dQjqNqm3F9PHOfOjbfWgjb492n3yVwx0vvwnNfigEzCsBoQPggcAmrbSJIx6op1fYjslmFPJ+RNpnGY4kk/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxeRndWKrNQNJoZVrVYNkwio3s9YVbwxUgb63Gv917Q=;
 b=HNrNfyGgHHgkOHjSBZLeRCl3v0YL3zFmefBVG4J6+Ovp7wL92X6nMazK6HbFe13Kqr6k5ezj2KiyrkNwmeN/wNovqxKKEPMAQv32EVNJ6RqWiEobJepxflwgNf3YHB1ZvD4xDEzOj2eii8cKoocTubeNVFjlLvKZUgKDBRkwI/EnaaFvdHVMj8phCO35cFC8H+Lauiom/QaLmNi85ZIHe0VWaPuv0NvG7TJ25fqoB9J31PiYCz8Obb9MKJ0JF/Z9KJU9XLHdmtxGPaup08vTxtD0D2UCw1r0ZN4ZPW2jLjjWSek9b4BWFf/D42XnofGo+jVfPfH83EoQE/YxcAKlvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxeRndWKrNQNJoZVrVYNkwio3s9YVbwxUgb63Gv917Q=;
 b=McYMYisVBIzRowNvS2iInGoloAp31HS0dT0kGmu5F3XTwbBqEXGPPTVP0XlLAltsvDYsuZoJWfODI5stuiwavPnm1MTJxNykjgYqeKiZDeK4tKMubTGwpZKL/92xWCm3HWLxB4vaUUpKOrgdH2SofdBpNc24MQvsWD4cM0lBmHo=
Received: from MW4PR04CA0364.namprd04.prod.outlook.com (2603:10b6:303:81::9)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 13:49:04 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::fc) by MW4PR04CA0364.outlook.office365.com
 (2603:10b6:303:81::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 13:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 13:49:03 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 08:49:00 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <radhey.shyam.pandey@amd.com>, <shubhrajyoti.datta@amd.com>,
        <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>,
        <srinivas.neeli@amd.com>, <derek.kiernan@amd.com>,
        <dragan.cvetic@amd.com>, <harsha.harsha@amd.com>
Subject: [PATCH] MAINTAINERS: Switch to @amd.com emails
Date:   Tue, 16 May 2023 15:48:52 +0200
Message-ID: <f7773fdd002f89578b9e5262692a563fe7be4123.1684244928.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=michal.simek@amd.com; h=from:subject:message-id; bh=7dH0huBv+pHPUN3YkQMm19g81BQ0+yDg3DZVRSlZUj0=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTkzoM7jkUxGqyZf/Oo58TFGdPZtgvnJafNC+z7LfA0q XmdaeDMjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRQBeG+W67p52KTX++aOOG Ps+UXLNw5YWTqhjmO6syR2Wc33GXm0e68t9s3Ybv6ou6AQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d624cfa-1261-45cf-17c8-08db56144fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ts4RIVIiFuTclYg7caTcfN/fdV/N/e94XUDQGvHDyyy/npFjvCqd2+SwGZW77iwOoYiV3ca4lTqFzo2GPlf4YHXuKa/y1FHTYKzwSi3l5Ssuv23TBtmLhIFPmkz7/joCm4a/VNP+ccoRHW4u3hz+k/cUZI4AWine1OHzKUCwDa9IBjJwDC6/1WcOlS//rafhx5ty6/7ieRXqNB4CoF3TaAxr/B8ZakZmsKSpyheI/fvNoztvJsp49gCtT68uCCpR31JHgPvOVtwAIu5X5uf+XsVYdKOVANPnr4l5IzCMME9qCmjwKvDNOu3Ojy+tEShedQrH1t+fgVDrxcTXLvtB2tLaHVvBzBGoHfIdOqmiJt9/+DbJqbf8UOsIX9uFgXo5MdVAeJDnWrB7PEuPe5E1t2fNRu2+COHYoF2RhAGTePXh7kb5/iQZ5oV0q5p6q7kk56QoJDwhKDAYcPM4cUYZiOHOqfCHmQE2kkqjeO9btGvBUBABy/zbkDWdq1yoNBO9jOzMQ0oG0KzkUtAIyyl7HnyFaWnWqBp4+wvTa+9ZfkE6NOpAa47E4OsrOD+ZP791UAXCXCocas09H+6+YKLb4q9Zcps5UhbGk+A9iiZ7FZ9v4LKQUMNlTyxjEYvTlhaeEc/08yQDUntQ3Pzi5XhsI8fwvIbb0K9Iw2FPNuU2R45tkHsXk00mDSAtVpet0I2Gqb8VwSsQcc7YK/go50f/Zpe/3WYC4EoYttfqOjev5h6h56CCWB0gSn2K8eeqMXIzTW4I5RKQqYnu1oAXoQrvnCBE8Z2TCI7B8MZaMLUybU86IKBPAP+DtRpczKi7dQ6JylA6CyNB00Yhsnp5T+PWcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(26005)(478600001)(16526019)(81166007)(82740400003)(921005)(47076005)(36860700001)(356005)(186003)(426003)(336012)(2616005)(40480700001)(83380400001)(41300700001)(2906002)(8676002)(5660300002)(8936002)(44832011)(70586007)(36756003)(82310400005)(6666004)(110136005)(70206006)(40460700003)(6636002)(86362001)(316002)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 13:49:03.7114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d624cfa-1261-45cf-17c8-08db56144fa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@xilinx.com is still working but better to switch to new amd.com after
AMD/Xilinx acquisition.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60f6effb168c..4b2ef60a4d01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23115,7 +23115,7 @@ F:	Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
 F:	drivers/iio/adc/xilinx-ams.c
 
 XILINX AXI ETHERNET DRIVER
-M:	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
+M:	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
 S:	Maintained
 F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
@@ -23128,8 +23128,8 @@ F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
 F:	drivers/net/can/xilinx_can.c
 
 XILINX GPIO DRIVER
-M:	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
-R:	Srinivas Neeli <srinivas.neeli@xilinx.com>
+M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+R:	Srinivas Neeli <srinivas.neeli@amd.com>
 R:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
@@ -23138,8 +23138,8 @@ F:	drivers/gpio/gpio-xilinx.c
 F:	drivers/gpio/gpio-zynq.c
 
 XILINX SD-FEC IP CORES
-M:	Derek Kiernan <derek.kiernan@xilinx.com>
-M:	Dragan Cvetic <dragan.cvetic@xilinx.com>
+M:	Derek Kiernan <derek.kiernan@amd.com>
+M:	Dragan Cvetic <dragan.cvetic@amd.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
 F:	Documentation/misc-devices/xilinx_sdfec.rst
@@ -23212,7 +23212,7 @@ F:	Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
 F:	drivers/phy/xilinx/phy-zynqmp.c
 
 XILINX ZYNQMP SHA3 DRIVER
-M:	Harsha <harsha.harsha@xilinx.com>
+M:	Harsha <harsha.harsha@amd.com>
 S:	Maintained
 F:	drivers/crypto/xilinx/zynqmp-sha.c
 
-- 
2.36.1

