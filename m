Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880F06F453E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjEBNkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbjEBNkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:40:09 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86296EA1;
        Tue,  2 May 2023 06:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaOjbM2Lq/BYvHbItMhlPNeXk3070mc1KVAQLjFZwDkFR5DPJAxadB5/bzbema8GMksEtZ7k2b39BM3VJ0O0md6uNmpZA3aR54MHenNPJ+GZz5qeSNTrI7vYCAhAGedyD9gniqry6ZPY7jRCdlZAQLSwrOiVyIjA/tpBwOaB++6fBv228qR4+fdyCCs9oaf4p7nZNWYso+4/nIu5yJFEYtz8u+8k9lE3QSK0kvZ5rhhIJ4EMh+A0DRPGS2EaQjZoNLlV+mNLICAV/dLJtrEAbv25EmoN7v/n2UtqMxMyQUCl77/wYbsggH3NLbIGn2+ghF5ClhqI7cQNuHBPVCNTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlKA4lzSHjnUC0y7zo8ZQ6TN9spPSCrk4L2XerL+xI4=;
 b=lEkrZF+Q+qKvPNrf8M0RBr/RuWkeHZKTVi+u+ysa1/lJUzhg43iLt+yjsGqMX9wwuvyprOLpcqlNPB2E1DguNdiHcCmjaopI1SVXiCOWAi4DW38P2L/T9TUGqsyGPAPfT2Bc885ZrlYPGG6lrsNefN2zsHpJgh6VfslIXrw6B7dgHpvJT7RKAIRlP1YQLoYt07FwoNNdk1UM4zSYM2m+YvSnXV9DCp/KbrVabmol2xuETXISaNvso/cipwPhlZZYVAdG2XYH2HVgMhakV/jOKa7DFyZuymQ1eJc6bD8lg/Mcg7DF1zzAvtxJk1HujF2D1E/9myz1VrtNxNHkXDB/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlKA4lzSHjnUC0y7zo8ZQ6TN9spPSCrk4L2XerL+xI4=;
 b=O4e2gmGO9E5QWUD43YiQBMthXQ3qTyLEmq2ZYGFG5jBQ7u+TeWrHULj50/j8vq7UxMcQakQPkJL6Ogcko+zEhU1gYcrQh2gHAYyMCRj3rYb/c3rUyLIjlKyeA10lDiRV3MZYVY1m4ydS0ZpKGdoeHwndfMIyu0O5GF4+az527pg=
Received: from DS7PR03CA0214.namprd03.prod.outlook.com (2603:10b6:5:3ba::9) by
 MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:38:54 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::32) by DS7PR03CA0214.outlook.office365.com
 (2603:10b6:5:3ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:38:54 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:38:52 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Robert Hancock" <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 20/23] arm64: zynqmp: Rename ams_ps/pl node names
Date:   Tue, 2 May 2023 15:35:48 +0200
Message-ID: <373136eccf8d22cdfb499adbc8d5f5510d6c1035.1683034376.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1683034376.git.michal.simek@amd.com>
References: <cover.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: d57394b1-48fe-40e7-201b-08db4b1292da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIiqdZEpGf2hKdLN7qBy0jYE/hZ/rkLRGEADoBK97W3x3zsdlwsM4B3pstioM2aTK2QQRhrRdGXjUu+iAb4HBzulon7K9xXXzzHX7nxW3miCabMmyjiaKiJ9KrXsFV/PTNEUMVw738YoMBHPsdZRjSS0CM8J7gJ3PL2z8RU95G51zdom58sdIuuAP19G9be+4UReBZBCi2Mh8HVTpflgPVo0sPTUaHOwEBX5kRFTWTvJzJV+MvnHH4oyjuZX6ldoSa0fvcd+qtRUUy5sCNcQ9LahkjWFVcxe9qmyoC0Kg5dzEGhvxf8ogMEnBm8rp0ooEB2wTbhwJAGryUywZPyO/F/ZPoq2ZUVqaC6iVGuMSdb3c9bGOk85V2qENgY2nmRGseARHu1teYlR6dg95nKd2quFWSr0922Hlad3hozumI5v2NrYjDkebH5KK+jHZntqV3QC2yFaAau9Qyjsvhr1902o5TxME2qC6j6C9wMT3vxbHeUYpekivNcmP66Oga/Gup2UetkTJ7w5Eu1NH79A+00UDOf6Rwx89ntOD2hSTSkE/G+Z1+Rf3YCyw82xLucm/Y0AcKWb2ScChaexDPhm4aFWMF/1XQqQdrnbd8786+qW5yMHmKhf27LptO2cpgYwi6gd6e6Deq+Ru+2ZOceXdqqJ58yiI40QQKRGUkDaoqeZm4KHDAZnj/sfFNTOKSItW0tXfeg79/po7rAom+eGSRPOTMLdh24j+RAJ8moIs5idOe2esp0pWlUDt2/CoNNB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(47076005)(83380400001)(426003)(336012)(36860700001)(4744005)(2906002)(26005)(16526019)(186003)(110136005)(478600001)(2616005)(82310400005)(36756003)(54906003)(40480700001)(81166007)(41300700001)(70586007)(70206006)(82740400003)(356005)(316002)(8676002)(8936002)(5660300002)(7416002)(86362001)(40460700003)(4326008)(44832011)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:38:54.7539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d57394b1-48fe-40e7-201b-08db4b1292da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix child node names to be aligned with commit 39dd2d1e251d ("dt-bindings:
iio: adc: Add Xilinx AMS binding documentation") which requires names as
ams-ps@ and ams-pl@.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 7bd3e816226a..d01d4334c95f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -955,13 +955,13 @@ xilinx_ams: ams@ffa50000 {
 			#io-channel-cells = <1>;
 			ranges = <0 0 0xffa50800 0x800>;
 
-			ams_ps: ams_ps@0 {
+			ams_ps: ams-ps@0 {
 				compatible = "xlnx,zynqmp-ams-ps";
 				status = "disabled";
 				reg = <0x0 0x400>;
 			};
 
-			ams_pl: ams_pl@400 {
+			ams_pl: ams-pl@400 {
 				compatible = "xlnx,zynqmp-ams-pl";
 				status = "disabled";
 				reg = <0x400 0x400>;
-- 
2.36.1

