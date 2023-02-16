Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F51D699D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 21:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBPUTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 15:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBPUTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 15:19:37 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2728252CD1;
        Thu, 16 Feb 2023 12:19:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwyjkpjdC7W5QXYoMCu3eCNLIcTV9SmuOTAtn4DWI/kVh4o22W6OuebMSkYoZVTqznq4AgK0z/YFGs66gDko+Goj2Mk4DaswTHBFdJt33oL/RSNg/SPAoasW+YgPDqQZ7/J8D3wOFqn3MU31OL9FpLx/CBc/sZd1fkP77OVHy9aok3GEHR7U89XOtxqFgXhadjSEcVBfQsPqyS1oUzoULnF8aTpG/lk3TSHlc65d1xcXUgWFdTLP4HtEVIpmKkZuQ6qhey8Wu2XbJLLucblDKk1j2NYztmTXhy/gML3M2nheW1KFwJCOlvi1KzPcrrmG/r1c0WJNCuL4V/lCgZPdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWQKDMjWFK54ldm3wFoFMU6eEYsprjlXLNdZB1/Hl88=;
 b=eW6gFAmUMkjyT6/XcTK2T6YjmqS3/2Kzji9ZicaXncQYxHCMr1ly2onwPF5DQjxQEn9fo8g2zSmmSv2ro7ENcvMRJ5Ol0zOTwJQjQNMfnOmLYrlnVWtfsjdPhMC0vRLn9QeTac7MQMfmc7fBtMJ/PloDHx+9ryijHYV8CO02yM7vJ4SMZJ4Q70xfo1+z83gYjpcp4kUF/l8z9HYT7PSczZMVW4kQWxlx/KPwEBHqSQ4pLz/7JaXqt3bi7HAsgDx+iFvR149wUT6Ex42rkUAmfkCKwgC3KIwsZ+uuh/p8KpCkDQSKP1huEHcJNp0WRgwwkbfU9Aszcj3KeK+9Bddi6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWQKDMjWFK54ldm3wFoFMU6eEYsprjlXLNdZB1/Hl88=;
 b=oumFMhY4Rw7JGqhhsu/VhKbGbTrjd9Fq5ABBnZJdhzQxY/EzM5zjR4J2lT8U8flMFabiedddyjGTj9Kq4OK/l8XpemXHUWGzDn9hCxjFF3ZLckgFg1IssBEHNAgcSVoRlM4oDC4NTum/Csjp42xGS9KiFhJsFpFNkKLKJ1PDClk=
Received: from BN0PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:e8::18)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 20:19:32 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::fb) by BN0PR04CA0043.outlook.office365.com
 (2603:10b6:408:e8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13 via Frontend
 Transport; Thu, 16 Feb 2023 20:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.14 via Frontend Transport; Thu, 16 Feb 2023 20:19:32 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 14:19:31 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] thunderbolt: Refactor DROM reading
Date:   Thu, 16 Feb 2023 14:19:10 -0600
Message-ID: <20230216201910.12370-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230216201910.12370-1-mario.limonciello@amd.com>
References: <20230216201910.12370-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d023f8-01c9-4d78-4d5f-08db105b1d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VT+qHt/dpj0Dxar1wQeNDwXk2mzLA48nfwcH1qao0D726lCH8ke/SOTrAfjCUD3sB6sQMZPmWxWud7q52khLfbOTuJLTm5haa9lbEd80CxnPoD3yjJlXj/yBLnSWGgm03FbeGOeDrYIlx4ibLcsM1b3J5eOvgwp0HaSFBKH5/CbpH0trd7YSIbw8N17W12lKfh/gFkKvlZQvyrcEXTDjo2PfRCxAVbFSp3exEz0qiO80v6UwgiS3s5n24SN2bR7h4CCTZtop+WxlyIL+iyCELZkZ4z2yAeHw268I9QoYrzB50r37sKcEXfYAgvwg4R7jO6VNVcbN7O9WVGVbJDEoqyRwsKDiDzC91g6Nck2+AF0BjE4yC0pZIjm8clAHV45fiKv0R3otfyOOsTUjDHvpkt1t1/gCg+gCEFYVWez/6E326vVHJGE+mYGHxEDW+/bXQhAm5p2R1tP4P+NGODnCE7rANCRBFtVAr7XLfqaSMw6+vN15BBSPr24U1mS5TED2YGx9itwh0vIjuPXv5ERJwnbSqlHxM/Q2g6Q7BQK08fAOsAnl9uPMoC5qvNulQs16hxYA38FuEfVM+tG8SjIlOQO+yVYkQb3/wNI4NkRvncR3W+WTcIWM3IJT2l8E2mDhfj3K06wEwYYsrP1TrBdUPTvDTLTzmbr7ubxgYtnQGJsBe+HDvXt7/yCAbYpS+xIvlHrCW69HPDtHAphxIKXlGHZY5tBRl9iisQwBw1+Z53Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(86362001)(8936002)(41300700001)(40480700001)(44832011)(5660300002)(356005)(8676002)(82740400003)(82310400005)(2906002)(70586007)(36860700001)(4326008)(81166007)(70206006)(316002)(336012)(83380400001)(2616005)(478600001)(426003)(110136005)(54906003)(66574015)(40460700003)(6666004)(7696005)(47076005)(1076003)(36756003)(16526019)(26005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 20:19:32.0190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d023f8-01c9-4d78-4d5f-08db105b1d2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NVM reading code has a series of gotos that potentially introduce
unexpected behaviors with retries if something unexpected has failed
to parse.

Additionally the retry logic introduced in commit f022ff7bf377
("thunderbolt: Retry DROM read once if parsing fails") was added from
failures in bit banging, which aren't expected to be present when the
DROM is fetched directly from the NVM.

Refactor the code to remove the gotos and drop the retry logic.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
    * Split out refactor
---
 drivers/thunderbolt/eeprom.c | 147 +++++++++++++++++++----------------
 1 file changed, 79 insertions(+), 68 deletions(-)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index a326cf16ca3d..2a078c69f0d2 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -416,7 +416,7 @@ static int tb_drom_parse_entries(struct tb_switch *sw, size_t header_size)
 		if (pos + 1 == drom_size || pos + entry->len > drom_size
 				|| !entry->len) {
 			tb_sw_warn(sw, "DROM buffer overrun\n");
-			return -EILSEQ;
+			return -EIO;
 		}
 
 		switch (entry->type) {
@@ -543,7 +543,37 @@ static int tb_drom_read_n(struct tb_switch *sw, u16 offset, u8 *val,
 	return tb_eeprom_read_n(sw, offset, val, count);
 }
 
-static int tb_drom_parse(struct tb_switch *sw)
+static int tb_drom_bit_bang(struct tb_switch *sw, u16 *size)
+{
+	int res;
+
+	res = tb_drom_read_n(sw, 14, (u8 *) size, 2);
+	if (res)
+		return res;
+	*size &= 0x3ff;
+	*size += TB_DROM_DATA_START;
+	tb_sw_dbg(sw, "reading drom (length: %#x)\n", *size);
+	if (*size < sizeof(struct tb_drom_header)) {
+		tb_sw_warn(sw, "drom too small, aborting\n");
+		return -EIO;
+	}
+
+	sw->drom = kzalloc(*size, GFP_KERNEL);
+	if (!sw->drom)
+		return -ENOMEM;
+
+	res = tb_drom_read_n(sw, 0, sw->drom, *size);
+	if (res)
+		goto err;
+
+	return 0;
+err:
+	kfree(sw->drom);
+	sw->drom = NULL;
+	return res;
+}
+
+static int tb_drom_parse_v1(struct tb_switch *sw)
 {
 	const struct tb_drom_header *header =
 		(const struct tb_drom_header *)sw->drom;
@@ -554,7 +584,7 @@ static int tb_drom_parse(struct tb_switch *sw)
 		tb_sw_warn(sw,
 			"DROM UID CRC8 mismatch (expected: %#x, got: %#x)\n",
 			header->uid_crc8, crc);
-		return -EILSEQ;
+		return -EIO;
 	}
 	if (!sw->uid)
 		sw->uid = header->uid;
@@ -588,6 +618,43 @@ static int usb4_drom_parse(struct tb_switch *sw)
 	return tb_drom_parse_entries(sw, USB4_DROM_HEADER_SIZE);
 }
 
+static int tb_drom_parse(struct tb_switch *sw, u16 *size)
+{
+	struct tb_drom_header *header = (void *) sw->drom;
+	int res;
+
+	if (header->data_len + TB_DROM_DATA_START != *size) {
+		tb_sw_warn(sw, "drom size mismatch\n");
+		goto err;
+	}
+
+	tb_sw_dbg(sw, "DROM version: %d\n", header->device_rom_revision);
+
+	switch (header->device_rom_revision) {
+	case 3:
+		res = usb4_drom_parse(sw);
+		break;
+	default:
+		tb_sw_warn(sw, "DROM device_rom_revision %#x unknown\n",
+			   header->device_rom_revision);
+		fallthrough;
+	case 1:
+		res = tb_drom_parse_v1(sw);
+		break;
+	}
+
+	if (res) {
+		tb_sw_warn(sw, "parsing DROM failed\n");
+		goto err;
+	}
+
+	return 0;
+err:
+	kfree(sw->drom);
+	sw->drom = NULL;
+	return -EIO;
+}
+
 /**
  * tb_drom_read() - Copy DROM to sw->drom and parse it
  * @sw: Router whose DROM to read and parse
@@ -601,8 +668,7 @@ static int usb4_drom_parse(struct tb_switch *sw)
 int tb_drom_read(struct tb_switch *sw)
 {
 	u16 size;
-	struct tb_drom_header *header;
-	int res, retries = 1;
+	int res;
 
 	if (sw->drom)
 		return 0;
@@ -613,11 +679,11 @@ int tb_drom_read(struct tb_switch *sw)
 		 * in a device property. Use it if available.
 		 */
 		if (tb_drom_copy_efi(sw, &size) == 0)
-			goto parse;
+			return tb_drom_parse(sw, &size);
 
 		/* Non-Apple hardware has the DROM as part of NVM */
 		if (tb_drom_copy_nvm(sw, &size) == 0)
-			goto parse;
+			return tb_drom_parse(sw, &size);
 
 		/*
 		 * USB4 hosts may support reading DROM through router
@@ -626,7 +692,7 @@ int tb_drom_read(struct tb_switch *sw)
 		if (tb_switch_is_usb4(sw)) {
 			usb4_switch_read_uid(sw, &sw->uid);
 			if (!usb4_copy_host_drom(sw, &size))
-				goto parse;
+				return tb_drom_parse(sw, &size);
 		} else {
 			/*
 			 * The root switch contains only a dummy drom
@@ -640,67 +706,12 @@ int tb_drom_read(struct tb_switch *sw)
 	}
 
 	/* We can use LC to get UUID later */
-	if (sw->cap_lc && tb_drom_copy_nvm(sw, &size) == 0)
-		goto parse;
-
-	res = tb_drom_read_n(sw, 14, (u8 *) &size, 2);
+	if (sw->cap_lc)
+		res = tb_drom_copy_nvm(sw, &size);
+	else
+		res = tb_drom_bit_bang(sw, &size);
 	if (res)
 		return res;
-	size &= 0x3ff;
-	size += TB_DROM_DATA_START;
-	tb_sw_dbg(sw, "reading drom (length: %#x)\n", size);
-	if (size < sizeof(*header)) {
-		tb_sw_warn(sw, "drom too small, aborting\n");
-		return -EIO;
-	}
-
-	sw->drom = kzalloc(size, GFP_KERNEL);
-	if (!sw->drom)
-		return -ENOMEM;
-read:
-	res = tb_drom_read_n(sw, 0, sw->drom, size);
-	if (res)
-		goto err;
-
-parse:
-	header = (void *) sw->drom;
-
-	if (header->data_len + TB_DROM_DATA_START != size) {
-		tb_sw_warn(sw, "drom size mismatch\n");
-		if (retries--) {
-			msleep(100);
-			goto read;
-		}
-		goto err;
-	}
-
-	tb_sw_dbg(sw, "DROM version: %d\n", header->device_rom_revision);
-
-	switch (header->device_rom_revision) {
-	case 3:
-		res = usb4_drom_parse(sw);
-		break;
-	default:
-		tb_sw_warn(sw, "DROM device_rom_revision %#x unknown\n",
-			   header->device_rom_revision);
-		fallthrough;
-	case 1:
-		res = tb_drom_parse(sw);
-		break;
-	}
-
-	/* If the DROM parsing fails, wait a moment and retry once */
-	if (res == -EILSEQ && retries--) {
-		tb_sw_warn(sw, "parsing DROM failed\n");
-		msleep(100);
-		goto read;
-	}
 
-	if (!res)
-		return 0;
-
-err:
-	kfree(sw->drom);
-	sw->drom = NULL;
-	return -EIO;
+	return tb_drom_parse(sw, &size);
 }
-- 
2.34.1

