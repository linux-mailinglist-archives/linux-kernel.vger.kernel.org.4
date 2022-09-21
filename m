Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F62E5C006D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiIUOzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiIUOyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:54:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2698117597;
        Wed, 21 Sep 2022 07:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1I7ASTZ6sqYElofYs32FD0rEKlefVc+FX58ug6CJ7IFt496FLQyqXmpd1i/ERhHnCTixxzuNAadP8AYOzSkHIowVUv8vz1Q3bOOHqPRqPal0v3+r62uOAaGw/IEvAXHuO0Azd18CbBsuVm6TqvY2bEMu9tld5JzRCGeqr16X2vASGtM6qd1JfPSSLeJoqG9J2bhO6tUE17COi/b9vIl9CRy/a6y08M32jef2UOWGK5tCOMseS5/hvUukSFnYX2Cn2ocTLVlWr04m92Bez/CQ2bCVCplXlm3HjNTomtbIrAYQgRm+txaFi7Hb3HX6sB+F3X6KT+DQf5zBPLRwsSKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v0QBtGka5aJrkprvRPsPqcAK7O97kF4wDG7GSgdB6Y=;
 b=TVXpKWfFZqvxNq1+BYZE6M5LDKpjUkFqlXdKJ5WuH4bEjws4oAYN2q9vjFW7jAMqLJGUQibBIhMRXrCo0gf58bcc3WTbk5tWbQ6B0t202r/X0qUDNs4gfasfX8OYi9skToxFSlIcJaiK966tgbtZcQhTVqaWSYkZxtHSOvMKkIh2BOmoe45G+GmiVf/D733k0w/AGw4MaJGCT/HiTqD3mOuUoNsAnY/a8gQkd3clBI3Xv1tPXugXw17CMjWSsll7VL+En9dcz1U2SmNkhEor5o0OeaMPQ76Qhk5iLuKPxgku4R2TCEtfCVpM3ri0YKqYLP/89S4gyKgby8fh5y/27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v0QBtGka5aJrkprvRPsPqcAK7O97kF4wDG7GSgdB6Y=;
 b=AExLtYxfEKWiV/kg0HEu4NuoGEvLVemMZOXBMKviSbXO6VpUil2gwxeGhdcEomwWODWoGpfZ/O287iAR4W+WCng99xGthNfpEKPdAZw+8RppiCM4s67ZX+wDdDzIiiy66e9+Yj2fiy03HPYwafI8vq8OjPogf/vIdbh9RMEpX08=
Received: from DM6PR08CA0018.namprd08.prod.outlook.com (2603:10b6:5:80::31) by
 MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Wed, 21 Sep
 2022 14:54:39 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::3b) by DM6PR08CA0018.outlook.office365.com
 (2603:10b6:5:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Wed, 21 Sep 2022 14:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 14:54:39 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 09:54:38 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Yehezkel Bernat" <YehezkelShB@gmail.com>
CC:     <sanju.mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] thunderbolt: Explicitly enable lane adapter hotplug events at startup
Date:   Wed, 21 Sep 2022 09:54:33 -0500
Message-ID: <20220921145434.21659-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921145434.21659-1-mario.limonciello@amd.com>
References: <20220921145434.21659-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0d1109-0d21-46e6-27a3-08da9be135c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXR0BRlECM88U+lim0mkzCboSlEvnCZQ0QGZkAJA1+YCzHe06aPN2ljgBKeGajaCD9gE2m0QPApb8GlMXgoQanDPYk3eduRlRaz5Gm2mg4vgMtrtMKHcc7L4zYFzyALVwcxUXMCk2QDhlZ3entB5rDL3zEVoreOt1cLLyRXjX/Xg9Wg8jzBxD/UdsnzQYvAAuC5DGz6XSXZBRHk3YIIROuS1Uu3lM3+EPe3Gbflo6o4HizVRJNJ/udP3j3vDIYZ+pMatf9ODjc/u7gm0Hz0gaI+G4XeGNjV5xG15SV/RgZZWWlPmQsFk705pkEsva/yUPM3FVE6FP+lvws/4dHj8Grs29rRslLjGE7nQi8JcVhJ1IuaEQmrPTXfbxFxt9lYNjBqoa5gtO1B6gP0DvNqu1Bg5Z9lA9UnJhQg2Nwcvbkxv7Iy7y54dgAq+JZAXT0Dwyj96fJhLR/EyKRCXO1JP629HFTcZCqcbluiEmZQI6nC3lOcZ9E4V+EIMQackq88EsP5Ww9/w7dDbvtpUkyo1w61KY/V00cx1rR0C4z5/A/SWSIWyt3f4e5gljpRD+cxWL1RfmGL6IcpmhatzvzUBzORWC1TCK2ITWYPskGPITJf97eymgsTmRhGIThMuyUayYKOAYTP5HMdGz5zo/+LnBBc7+HJ1THMgDN4i/JgbcmAOj2e9UNgsfCyjgGfvJ4eUxrrDMyVJH4GdG+DmJtvMaO4My/1CSc1fpLelJFkmefh4eVTXtiXf6wkQfPGSi6f4BDIRFPn3CR3zp2zeCpsjTr0Oa0y/ibspae1MEGoCInw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(8676002)(6666004)(40480700001)(7696005)(36860700001)(478600001)(36756003)(41300700001)(70586007)(4326008)(44832011)(5660300002)(8936002)(70206006)(2616005)(356005)(316002)(54906003)(110136005)(2906002)(81166007)(86362001)(47076005)(1076003)(16526019)(186003)(82740400003)(40460700003)(336012)(26005)(82310400005)(83380400001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 14:54:39.7509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0d1109-0d21-46e6-27a3-08da9be135c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software that has run before the USB4 CM in Linux runs may have disabled
hotplug events for a given lane adapter.

Other CMs such as that one distributed with Windows 11 will enable hotplug
events. Do the same thing in the Linux CM which fixes hotplug events on
"AMD Pink Sardine".

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/switch.c  |  4 ++++
 drivers/thunderbolt/tb.h      |  1 +
 drivers/thunderbolt/tb_regs.h |  1 +
 drivers/thunderbolt/usb4.c    | 19 +++++++++++++++++++
 4 files changed, 25 insertions(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 77d7f07ca075..65f65cfe1101 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -792,6 +792,10 @@ static int tb_init_port(struct tb_port *port)
 		(port->config.nfc_credits & ADP_CS_4_TOTAL_BUFFERS_MASK) >>
 		ADP_CS_4_TOTAL_BUFFERS_SHIFT;
 
+	res = usb4_enable_hotplug(port);
+	if (res)
+		return res;
+
 	tb_dump_port(port->sw->tb, port);
 	return 0;
 }
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 5db76de40cc1..b66781ae9c16 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1174,6 +1174,7 @@ int usb4_switch_add_ports(struct tb_switch *sw);
 void usb4_switch_remove_ports(struct tb_switch *sw);
 
 int usb4_port_unlock(struct tb_port *port);
+int usb4_enable_hotplug(struct tb_port *port);
 int usb4_port_configure(struct tb_port *port);
 void usb4_port_unconfigure(struct tb_port *port);
 int usb4_port_configure_xdomain(struct tb_port *port);
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 166054110388..bbe38b2d9057 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -308,6 +308,7 @@ struct tb_regs_port_header {
 #define ADP_CS_5				0x05
 #define ADP_CS_5_LCA_MASK			GENMASK(28, 22)
 #define ADP_CS_5_LCA_SHIFT			22
+#define ADP_CS_5_DHP				BIT(31)
 
 /* TMU adapter registers */
 #define TMU_ADP_CS_3				0x03
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 3a2e7126db9d..40ba14e8e227 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -1046,6 +1046,25 @@ int usb4_port_unlock(struct tb_port *port)
 	return tb_port_write(port, &val, TB_CFG_PORT, ADP_CS_4, 1);
 }
 
+/**
+ * usb4_enable_hotplug() - Enables hotplug for a port
+ * @port: USB4 port to operate on
+ *
+ * Enables hot plug events on a given port.
+ */
+int usb4_enable_hotplug(struct tb_port *port)
+{
+	int ret;
+	u32 val;
+
+	ret = tb_port_read(port, &val, TB_CFG_PORT, ADP_CS_5, 1);
+	if (ret)
+		return ret;
+
+	val &= ~ADP_CS_5_DHP;
+	return tb_port_write(port, &val, TB_CFG_PORT, ADP_CS_5, 1);
+}
+
 static int usb4_port_set_configured(struct tb_port *port, bool configured)
 {
 	int ret;
-- 
2.34.1

