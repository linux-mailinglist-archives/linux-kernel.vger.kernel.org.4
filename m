Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547DA65E6FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjAEIlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjAEIl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:41:29 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009D74C71D;
        Thu,  5 Jan 2023 00:41:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9+/OWbccOp0wbXLb8EctepzPdFhnhG+A2CGLeyaCB0EwNp9rZv4ZAxnsZGKjs4CxvBkBZoPt15S9gnFTXwOnJUGNLHtvWon+bo245pCdZ8bAPPeQ94dkf7NzStqEvO+a278JyMGPZ3vh4AXFsAyMqxYal/EyaKGGH2Z6gQw0n4/d1bjukrNzC9H7yKRSOo+dr+lWaRuDNyOJceLoll45SMuJpQr+Hyfpc7PNc/jD5IwXBG2Ra6lbFIwTZF3BsHN8pC7rXcta1ch80LFVoXvvnRagBQhTYT+O+zbT4YaPduyWFGgECwQxz2F1Fe/UJdoLr9ptsAqe4CwzC6geVGHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+omE1JmaWgWBHP0NZROk4F0C9WiSEQivvHFPdn5YQk=;
 b=nxKU5fXaXS7tQop4UyKehHXOevnyXzJfT2+16ZV6/c47zhWG/r32/22D/4+x1tlMf4uw5wC4hwrZqko5Nmnfm7oGM1k/MolIPx/+utWRB0fMnGIMPLMNwNWnPRVZ3Qry1JXePOgX2vqvgmseLaEpTLfhR5uv1eABjct0bAHvObTNB3bz0VV1cc+HzVzZpWeJ9C3Gb0mUMYexnywjyG3csJ+N27WA2/5lbe06KTO89nY5Jb5a/TKTtQTEbCYx5V85m154V2CJWbglQs1zOj2LMUQtSW8JlBKfO8qDqJRlZAyfs5Y0KH4Vd/KnouO2zTSKUH77Lu0qu4J1pztKXLFzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+omE1JmaWgWBHP0NZROk4F0C9WiSEQivvHFPdn5YQk=;
 b=QkcWUYEEp3d1YUVsKVjCSgqiRzS503nhD0ckvGv00gSJ2r9mIcUlFd1SSNXvqL2OL53ob+238FG5nwHQB5yUJq08IxMC/WB/EWEwTTJ6pXMfPKmV7yXbwidQRySH8r2TpKhV00AnibukinDFWg/o+cDUKGh9p3dwWIzRpXU0Vqo=
Received: from BLAPR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:36e::25)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 08:41:27 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::12) by BLAPR05CA0023.outlook.office365.com
 (2603:10b6:208:36e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.6 via Frontend
 Transport; Thu, 5 Jan 2023 08:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.13 via Frontend Transport; Thu, 5 Jan 2023 08:41:26 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 02:41:25 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ARM: zynq: Use recommended dma-controller name instead of dmac
Date:   Thu, 5 Jan 2023 09:41:22 +0100
Message-ID: <5637d7e3464fbc1b2b269a7df35e24edc2c8d4ac.1672908080.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 9726231b-4cab-4fa7-a39e-08daeef8a248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMg1BTdKK92mPCVVsSV+VADhbq+EAQHZr3m/JoDnRnznQJcLiJYp3L3YH31f1xaVcsYTQUu/dtrT9IRHFop7IxAlRvuVwGglLAFFgl5GFnzYBW5jKJzqMG/bSQCcz/jZmu1ua1YEH5osw0sSMe05XS8vM2GUISlOZlDKHwRedIlThATB7T+Y7hTN+2PEOjAyulZzYlwCVLCKcLBlfsMYSEG7kZR1L4jG+FX77xZrtB6GP17Ejv3Nh7NsVQdwVGAxNzH1ut0vTs5TLWortji2b2dvhjfTVJxl3iOeqNGvLqWdZKaeYxXzYslqr5kSzlfDiKt0mlcGM/Lf/B78xqPNEbBvhuF1C7NwTtz5cWghsUwk3XxESelUY4Rl4U3/8i/d8aYaslZ7yYQsw1iXe3X6V2x7n3BR2Rx9+0yrs3rXAcpbR8co83YAW+vndvwoIuBgpW/QtnbH19eSLzJ9AUyGz2bMA/M6cNNJdgkIn0QIFfd4Lv/vI3qzEMyTY//MiMNsUWwPD3KbQ2/GR2sRo3LLmhZ5aHlBE10FC/PCL2nAX/DY0AP5RDPizn5rGtlamqa3b8ZMvr8P9GVX5oWc5wz0Mdz9IMNfYNDVLSaHMgddymDHVdbgU2tnjkIAz4y1WuhX4iBKaCmymq4wMIwh69KSYXultD9JW44tL36Qo58akDU+iOkXonUEGisN2XeBZCu/uawohsAL8sFkck8hM1ij7paml+X35Kupe8ZQpH96lNcB/FBd85gUqhdgB67+t8BH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(356005)(44832011)(4744005)(2906002)(83380400001)(41300700001)(36860700001)(47076005)(8936002)(426003)(5660300002)(86362001)(82310400005)(40480700001)(82740400003)(40460700003)(36756003)(81166007)(26005)(186003)(110136005)(54906003)(16526019)(6666004)(8676002)(478600001)(316002)(2616005)(70586007)(4326008)(70206006)(336012)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 08:41:26.7846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9726231b-4cab-4fa7-a39e-08daeef8a248
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use standard name for dma controller. Issue is reported by dtbs_check as
dmac@f8003000: $nodename:0: 'dmac@f8003000' does not match
'^dma-controller(@.*)?$'

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index c5bb6ddd5370..191fe61cb1b9 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -343,7 +343,7 @@ pinctrl0: pinctrl@700 {
 			};
 		};
 
-		dmac_s: dmac@f8003000 {
+		dmac_s: dma-controller@f8003000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0xf8003000 0x1000>;
 			interrupt-parent = <&intc>;
-- 
2.36.1

