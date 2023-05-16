Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA0F704F83
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjEPNko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjEPNkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:40:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC441FDB;
        Tue, 16 May 2023 06:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtXoTdqbOa3810aBZjDTkPszH3xShLXH16k8xiB4Mp8DHimCCde/ERzof+6uORXqkxoFRHVlHED2ENIptNdMXjuu0gE5bXGhi3HCK84iBc9aaihQhp0XywDxGTYAXyeON7bDpKfTbVyynWALsjM7qYKG8W5mtZANhZZTA4lW8aRxQky/x5yU5qHQIYs43L9oqqAawYkBIUVNawgwR5xBDvmQ7ikUW163JDdxh6PPeEOpJGw2huhLxG6pa1MmbNYXScnTMTBugNxJCm9gHssPR4V1f57Na+Ucux7qWxiOfjSyq9GyG2OUFqgnaJ6T9b4wGBAtEj/i8ioWQ8iR1DzKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBAn5BR9QEZ/CZjZF4awDSJbARdn1rL3/ob8JCiwhgE=;
 b=CnNYyVgshl3BT88uDRieXfhGwAPq3ZNF+6jFYSfOr4Gg2RnLPQoXyUU3QgR8Irbs+1E9tXyulHYnEkmKl+++wepYkNSE0AP0PNK9rsr4v7JCgoKbioPRP40v9p2CMeiwXI5QyKWZK7tPlXatrco7i+GdDgA0mVFHhTuDjDIpR1dSiF2ojEmRCeSXZfmxryhaBukSdMfbrMiCdlMs6QzL6myjgH/ejPo1dBc6/kf+zOnD0xDAQfq3bdI4z2779sqR5nC+bmSN9gtRDzSjsJ9MskxtNT1/gIP/MVNEuIi9WuyLy0WADJSWArRfUA1vYhmp5fKArDPmiGCNvLlRJHHLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBAn5BR9QEZ/CZjZF4awDSJbARdn1rL3/ob8JCiwhgE=;
 b=yDMgplfbHenRpUpWeO5Pp/iNYij98HRB8Mu2SBPb0V9ImLEOZfE4F5sH9uMF5jnj9DWgAdXwYcIFst7TGD3GUy+LFXO2lUQ/eSX6bSY2pXmAjNwg4W4fzFeBK/i9FNJAp/TRqMnasn8N7xXFMpSCY/j/1rorTpyQozQR2XjVYcQ=
Received: from BN8PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:94::36)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 13:40:36 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::82) by BN8PR03CA0023.outlook.office365.com
 (2603:10b6:408:94::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 13:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 13:40:36 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 08:40:30 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: zynqmp: Convert kv260-revA overlay to ASCII text
Date:   Tue, 16 May 2023 15:40:27 +0200
Message-ID: <9161f4e1d449edd86e642b6769575b8e201fccf0.1684244418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=michal.simek@amd.com; h=from:subject:message-id; bh=7swBR8l5WyRYShv3c4xFdoqrlBDZ2+IKkr7+Kvvtntk=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTk9iPr73NeiLb+9GCS7Zk5y/lZBacF2z88LfBU9bewf c2Vtb6uHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiOiUMCyb8M2IJPOxTlDOr d/WrFUmXPn2aN5thnt1qqc17j4qYTTvrv6TRgT+4eMmUaQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c28c6f-675f-487f-a28d-08db56132108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9agwgz+pgySU+jncmEtpA3oz6EOmeotUZOgfzxc1AIFfafs1iQn1gsJhyIBQPfeR1dcd73/rCZvhB3eD2RabijDM8OPj10Fgo2fdNz2RQ594JTTwOoy+rEIa2w01oDQUqgd43G47hSb5RUEqXLurhErkFLJPb+SJGTxIXEPU7jyZi6GMlojhx5WhwRc6UUYRg7tcv297gLGJORT/Ur+sy9pX2d/Yq1dGDpjOXcthBZpiKXunWQKeWVOeFN9f5Xyf0D6zpkgtxooeeT7eyKXZ7pbfQ/kPtQgkTJAmxix/YVv6tg2mqaW0LcH/g4ppKw9mLMAthXLkFaj267XqZ8v1Z7cwU5IsOV3me/ZyaYnGJ8yHH/0AL7Jjl8u8JLOdzIpbMOXdjkG6ZllSsLySCKCdWG0hOdVFbnW10eONNxSI6k+7XpYwuaRlxU9DHS85Rb3AypENpJetM8OzX8QRS4qEPgcJFKXcRuXRSVrBTb4TKjm+h8FIMSFTgtkDxO0Y/+ZzLyNMHJdsqFb9iSTlcaDRLK0dDoQ4O99ClqHcCmMf7edqafkYC9WdpERrqnzNg9jaFFZsppsscIv12wvZJeMTAQalr+vy+S7xcnrgU+yvTywF+zC6GfElv9jfqw/ZmXVhjjXPDIhIs6rsJYehnN/tVbBX3Co/l178oWsfHg6/u4f/n+h2CH58XVsFdOMpyfQZJmAb2h9dgcfPJWLAiUkI6KImAlBk4Uh/e7OQQR+XE8EUhurrWJ8Qg5Ud/SlRKq86Bq+a+4NaATJMsxqvSiO4LY3aeIh319O9jC3ieON4PBg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(81166007)(82740400003)(356005)(82310400005)(36756003)(86362001)(40460700003)(8676002)(8936002)(7416002)(478600001)(5660300002)(44832011)(26005)(40480700001)(16526019)(186003)(2616005)(47076005)(336012)(426003)(4744005)(2906002)(83380400001)(41300700001)(316002)(6666004)(70206006)(70586007)(54906003)(110136005)(36860700001)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 13:40:36.1169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c28c6f-675f-487f-a28d-08db56132108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
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

File was in UTF-8 format but there is no reason for it. Convert it to
ASCII/plain text.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index bd7628a50b04..bebbe955eec1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -5,9 +5,9 @@
  * (C) Copyright 2020 - 2021, Xilinx, Inc.
  *
  * SD level shifter:
- * "A" – A01 board un-modified (NXP)
- * "Y" – A01 board modified with legacy interposer (Nexperia)
- * "Z" – A01 board modified with Diode interposer
+ * "A" - A01 board un-modified (NXP)
+ * "Y" - A01 board modified with legacy interposer (Nexperia)
+ * "Z" - A01 board modified with Diode interposer
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
-- 
2.36.1

