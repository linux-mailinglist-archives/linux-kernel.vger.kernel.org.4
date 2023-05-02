Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866656F4513
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjEBNgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbjEBNg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:36:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CC365AF;
        Tue,  2 May 2023 06:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExmTwj7FN3soTDYIc3oYsjXFAodAShFltKiWU4UdJfINbMgGtUBL7jRRHx/Lc8+r3L8n18qiDnzYcNOWnMdz/77tGXYhGf8rcvcT04AgEhDM6bI1tYTMVmYg/m7r5ovkoX0eUXXQ8qDC8xTf7OkxF5lynU0WLkNvi2ZNpRxFUFbju3tKU3X6BLyil1XRrjp7DoMzsqYAg/+L2bN05TtAOlXynMo1p1Ph0y+93gqbknDus5t7yAAZpIuUlcQxTiyr84WuZ2jvvaLv/8owj032oRh72fr9UqUB8E0SYKEhALWQbKk1DYYTQ9ozzih54nJy8MTpIsLxlUVmSDm+OWtz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSLM1ZYwm3Jf8rpjN6ZjicpZV63LXH3UPixwcm/Y6Ng=;
 b=Luhvj3oM4tggijBV5YrbuuSn2vy5vlhwFFkHUBqKhKug3wLo3boIbP9lMbXlo6/I8n0VRM+98dbrCERQorakJ0Lx6tC9surBbMnSTz6b5y9CijEHHpHwhGX+81a2xKpoVNlwFgyWNyLk6oa9HXlKMJvFzbw0RlXW56VwI3mkf4NyiHCo7R2QMrNmsn2Ypz0W1PhVWSX7qzNVogNW3uZlPN161f5tvBLGQQb4444E3rfa+3Tj7LklG1SubmEh0L98hcYYHXCCwJs2mCtx4QWQd0W4TXOEKyanQYzj23KXGBp4neVA9F1DycoinRVkHXqpstG2cAEAzVtiajpaZ7WWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSLM1ZYwm3Jf8rpjN6ZjicpZV63LXH3UPixwcm/Y6Ng=;
 b=kbo7KAmdGfwRtxAJTo5IC2ZCiqhJzamkaw/BvuG5h2jadfUSGrQ7KHE+FSBaJD7gyD/F/klox4SocTcO8/O5Q3egcD0vFZCa0KNL9LgJi7jYMuJzcOEAx7EZFY0gWNOAkspIcxdnbJNDFzmwFy07oG7yYxtN0WCM7LFo6X2m01I=
Received: from DM6PR10CA0022.namprd10.prod.outlook.com (2603:10b6:5:60::35) by
 PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.30; Tue, 2 May 2023 13:36:14 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:60:cafe::df) by DM6PR10CA0022.outlook.office365.com
 (2603:10b6:5:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:36:14 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:36:09 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 04/23] arm64: zynqmp: Fix usb reset over bootmode pins on zcu100
Date:   Tue, 2 May 2023 15:35:32 +0200
Message-ID: <d117473da3bab39a82fe900cecd8ca78df9adeda.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d753b7a-52ae-4b0b-96e4-08db4b12330b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVXXy8lXskiyM38uWva57ZEY/EHZ3zOMl3ETWPYQMskYuI/AOdVJmkCP8jJp3oQBX8p3/aBIfndbqR4hLtO2d0kYnccA6+yoFcLa3rm0KEyR2Hpk2sehoEzfQB5iQupbisnpkcsEfhn/oNOZ+0NiGeeuzWTnpYFO3U/7lgcd3ClZsMhN6mw8+cMnNWvrtZfxMqoYZPGFEQ5w0v3BSejepH1RVYO0s1p5VwIPbLSXNHyc8EbY3HL+3VZjf55pYUt6HdBCYG0otnREk9l3/6m+w1TULl+cA8YT3fWlZyteomhP5TpuxNWQWRWalenYSZpeHK5QUcleZLLKNc3QWVGuON0pbCj45yIfrKY4OKZyu2SK8rxl6PbxR/nnsNgqa+XsOEWFIxmDpH9TMNNdfaunbw21PMW/TpZ/0fXGkJSZaMqPpFPvLv+xLEjNQVjQDMuwg8j6A11zqrRDIvDAQ1veLS6Oeb6pAIPFhvtr8gQfNOC3Xoj4wwhdT4T7vOhydFP5T498LiiM7N3AUWUuEwoGHXlS+lT/0JnisYZgMs+T/gLb6sUKfs0slhn2Dfg0ovQiluK3XuTM+dcvGsjx0CVqWfwIpICE+JAF6udkLWiAR2i8P85qprNai7WlGaMonEk0EI/0051fVygwR5jF6ptUjxzLc3YuEF8PPxGFoW/Iz3wLEya2Z9GcE9cm697s1wO3MlqIw0j+XnqEcVbBDQAezJcRy3/kwLH2zJIHPnNi9B8wVcJDRQi+12IrPGqv7h4e
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(16526019)(70206006)(70586007)(4326008)(186003)(356005)(316002)(82740400003)(40460700003)(478600001)(82310400005)(110136005)(54906003)(86362001)(36756003)(40480700001)(6666004)(2906002)(36860700001)(26005)(426003)(2616005)(336012)(83380400001)(5660300002)(8676002)(47076005)(44832011)(8936002)(81166007)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:36:14.0167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d753b7a-52ae-4b0b-96e4-08db4b12330b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 53ba1b2bdaf7 ("arm64: dts: zynqmp: Add mode-pin GPIO controller
DT node") added usb phy reset over bootmode pins by default on usb0 only.
zcu100 is using usb0 as peripheral and usb1 as host. Unfortunately reset
line is shared for both usb ulpi phys but usb_rst_b is connected to usb5744
hub which is used only in host mode. Especially this chip requires reset to
operate properly that's why better assign gpio reset to usb1 instead of
usb0.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 2dd552cf51fb..c99abb99efcb 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -552,6 +552,7 @@ &usb0 {
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	phy-names = "usb3-phy";
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 0>;
+	/delete-property/ reset-gpios;
 };
 
 &dwc3_0 {
@@ -567,6 +568,7 @@ &usb1 {
 	pinctrl-0 = <&pinctrl_usb1_default>;
 	phy-names = "usb3-phy";
 	phys = <&psgtr 3 PHY_TYPE_USB3 1 0>;
+	reset-gpios = <&modepin_gpio 1 GPIO_ACTIVE_LOW>;
 };
 
 &dwc3_1 {
-- 
2.36.1

