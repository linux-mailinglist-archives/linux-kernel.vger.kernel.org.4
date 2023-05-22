Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692EA70C1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjEVPBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjEVPBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:01:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69DBF;
        Mon, 22 May 2023 08:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PetQ4kj1QCPpOaEP9P38lD/ZsiejDpQAAfWgULEcMl76xXlLx9zZ/rICHd+VRE4DfyS7oWc6SpvQFAi2KEBg7B9uSu/VThFwU1Ob0fl0EY6pCpnThG5wDH2cv0HpKcju3Qo2/A/BoTszYde/A+WAiIhJJN/wgghL8hMHex+2fhTbagHlAXGGXJmd1xgBwMDWsY6sR2wZbDnOrHU4nD14i4vt43lAJHr9twrBqgkegjfYh58wUQH6wZhxvsqhvqpdrPdAOBSB6yn7s/SI3kIRgCUHCM7fs+sHWjzLavDmrGlNSrtxOSlUBRDeP5uOK0qewFowREHudNOnHAel5mWWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54LbxK74auC0Q3JumSFGOfyyOoGlcKDpIjKf20bFWcg=;
 b=PQqfzoww2FsQQXh3IylIzq3xDmVbDUOHOA0bEj2Sk/4J2nbkRckhL7SfEZyijxwPQU00D/8RN711NmeUJzyu8CsVsUU1IgQ6KqWRtwg2mly40fF+wKPmX3dzlq+Q5b0AKu+f2S/waiTis1JJh8uJI/dLGt5u0Kh6SD+7hTabTbrQehVsqtNNJmVLkTjSjyTl5csufgDkiJ5lBGXa7Z4UlInH3FznEMBU+MEQrCkLX4SEtF6g+3G+0F+kJ1Z+k9dp+kr/IAxhorlchVYQV21pEoWQmKpLKfDfYyq5UQSM9XhfFtN9dH031B6WsdlfZSXSDSAqezKYiNXRcTgGmAuizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54LbxK74auC0Q3JumSFGOfyyOoGlcKDpIjKf20bFWcg=;
 b=VW8R9v+BUST+3A3uAlBX1dkzhOLQFw9U5gdFOEcFj8nwT5tfqDHT3RuKR40WKnXMeX9VX67Q75IsIA8BqqNAgqpEWRYkAyzUSTwe4R8mESl8hs+EimicfrFy4ilTnfQ/k9lmaWi0wHGdANJtcNPi6t6NugRS2q5X4n/97JTczsU=
Received: from MW4PR03CA0333.namprd03.prod.outlook.com (2603:10b6:303:dc::8)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 15:01:00 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::50) by MW4PR03CA0333.outlook.office365.com
 (2603:10b6:303:dc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 15:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 15:00:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 10:00:37 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Robert Hancock" <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 5/6] arm64: zynqmp: Add pmu interrupt-affinity
Date:   Mon, 22 May 2023 16:59:52 +0200
Message-ID: <dde2e4b5ac6018adb9bfae05bb3800af6b7c0f0e.1684767562.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1684767562.git.michal.simek@amd.com>
References: <cover.1684767562.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=michal.simek@amd.com; h=from:subject:message-id; bh=9Rv4kfaaoFDqsRH/cym30oBfA0Mc6YevG6DaHOmICuo=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTs5ngOsYoHm3JOX83qsdbt/2/zzDfY18vwXzPD7PmHX h5vmiHTEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACbilMWwYDrjyz0d1lmXXMt9 Y8+yhmc7rdmawTC/uud4+RXmKckB085dyKx7qy2f8/wzAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: ac45c5df-6c5d-462a-a692-08db5ad55aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVnq5g3Y1ZSx3ydVETHRMoo8pIzMD3S+6UckTGy3C1KgUpruq30RpOZoFDLtcWJY1JaQNI3c8OXBFRZsKZt1UX3UMQne8Rv30lQx8V1c73kqQVkXMeVm5OcSTCHc/FKah6rbNlU1+rtDXTiDt+lqZnrCY1heWttJtfH04wBVkFRYKYDIMAzFe9uMjhB+t2FdbeX6ctIwEBT/GC6tvwTLiogWSZMda5eC6AYCyxgUruIICYFQXFkhIMB/Hg7IWpYIU1sooaeVnZXJmcIB1CenW8Oq8Uvma4f64AXbfDRn6C2ErkMl0X7sbMQuu+5uyVL/7TxGOC6/idipTAr28RgWagKnXrOY4CwBtj8cHQ33rPaikD/k3yaAlko08AQY7WhFZRXTU+1eUz9kkwqSu40c6jE6MF/t6bmk8wSZRNUcLjxIA+L3044CHDU+c1ReMj7xntrnoUI2alt4n0SrMVkujdtybw24B6k4Jp+rkDUoMlymA0Ynnm5l3/hqewmLw6Mnm+JQpkTbnOSPNolRN9k1WosnxG9IFGRpvZb7t87c3KxGb9HAaW2vjqdaPum1IFswJ2wdeDqV7qWVOvA/DCi0WKHawSSufSZKkeDNl0PHP+ijKqIBa9uzXuzXmXTn1/0vcrhpEftqgHsgzQpfozLVzRz2OYjwKfQRvKag7S84ZIvnWz51K1ODXBI49Qk91hhBwIl2BowItvqq3xIdN0nzjM35FJRZFArhPZzybJNBqqwufsKGAXwvR478WjkKu8N896jAjzeIQtssiqTfF4HI5oXf7Crf/23dCXuqb8g7RTk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(2906002)(6666004)(82740400003)(356005)(81166007)(83380400001)(2616005)(426003)(336012)(47076005)(36860700001)(82310400005)(26005)(186003)(16526019)(7416002)(5660300002)(36756003)(44832011)(40460700003)(110136005)(54906003)(478600001)(40480700001)(8936002)(41300700001)(8676002)(70206006)(70586007)(316002)(86362001)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 15:00:59.7489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac45c5df-6c5d-462a-a692-08db5ad55aaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Based on dt-binding "This property should present when there is more than a
single SPI" that's also case that's why explicitly specify interrupt
affinity to avoid incorrect usage.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Update commit message to remove OS content - reported by Laurent

This avoids the following error upon linux boot:
armv8-pmu pmu: hw perfevents: no interrupt-affinity property,
guessing.

---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 02bd75900238..fc5e21bc647c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -164,6 +164,10 @@ pmu {
 			     <0 144 4>,
 			     <0 145 4>,
 			     <0 146 4>;
+		interrupt-affinity = <&cpu0>,
+				     <&cpu1>,
+				     <&cpu2>,
+				     <&cpu3>;
 	};
 
 	psci {
-- 
2.36.1

