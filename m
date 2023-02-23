Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442516A11A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBWVIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjBWVIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:08:11 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6415BBBF;
        Thu, 23 Feb 2023 13:08:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+GrbWsoFg68oSTgjWI97qJ96PF/bJbjQ53YiTU948BCQQHNlC4Nrvtv8kGHiBPTm5UZ2WhIJPUTvp08A+TNhoHJjjMdXo9UGyEcW5K+5pG5TvSEDR+OLY0DZ1Fq+roCy+gw1EueLfTsu3pP3mcCdQg2D0t5Uf41GCsdAEx0FOfq+umqVye57rZAQ68iXzcRWXtD5obt/E1DqGdGCUlcNamV3qbUQiGvzs/sGiTBBAZkUbKthyihp2tna3ZhdJI50ilXXTqyaYFxeh0+LrBcrOZUqKmffj4b4oF3IzT54NasTNFkWVSowYzAv3thDzGEGxyK79zOFpk/qvcWKXm/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOmldiO5IixD7ffouzN+S2oyW7fiGjGbVzWBGYRop18=;
 b=LZrUcGIy6sp5UQeJnPVngK9BFdXbiWKIIv83g3sx6cRx9K2yIdUbtjyiKDztW1EtQYA3ck5oVR1M27kyNGU6n/eQYE+RO4GyETGu/EOdUIolN1WjVvBoZrmZFLgZ8dzIv0xLwH31HF6P7gh2Bz50gf0n3Lp5OfHDTvsDd5pQlnvZICZoS3u/DCwa9kMDmyc4fUa4TXlcfpIQm2EXqDGp88ROpT9kgQOgT/+L/f2Ibtp7EisgRgi2f3hQk+GY3U2T4Kel1jFo8NqqhU88lskXMyJPN6adUPim/djuwFlAKwVnl5vdnNYC+QYxZJ1Wsyq3UOsNM0UG118EeNkiiPN3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOmldiO5IixD7ffouzN+S2oyW7fiGjGbVzWBGYRop18=;
 b=gbGS+PnYwsO6ldMi6RLWtOcpR2mPLQ0W8McYF6fc3Fjxg/t0PXdTvA2/JR7eLFvoNjMZdmCYtwE2i8Gs9hJ9MIFcbcMQ+QBJkics4lgA686ZuhCC5RA8z42jk6SKiI5nhM0mprkcEqF4Dou8jA+zkY6K3F6B5ND9jhU5whDwgEQ=
Received: from MW4PR04CA0159.namprd04.prod.outlook.com (2603:10b6:303:85::14)
 by PH0PR12MB7791.namprd12.prod.outlook.com (2603:10b6:510:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 21:07:59 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::d1) by MW4PR04CA0159.outlook.office365.com
 (2603:10b6:303:85::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Thu, 23 Feb 2023 21:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.21 via Frontend Transport; Thu, 23 Feb 2023 21:07:58 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Feb
 2023 15:07:57 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mika.westerberg@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Yehezkel Bernat" <YehezkelShB@gmail.com>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/3] thunderbolt: Refactor DROM reading
Date:   Thu, 23 Feb 2023 15:07:43 -0600
Message-ID: <20230223210743.9819-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230223210743.9819-1-mario.limonciello@amd.com>
References: <20230223210743.9819-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|PH0PR12MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c694fce-e2fd-405c-8a8a-08db15e20aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BP7ouDPH5nJ5iQYSZ9FvP5bFKplqzvkDOEAc9NVVch8q851Jowmcildxgyw6ewTEVlpkh8ud2X+hRtfsmbB7GyoV+nQumPxYXo/9FjXtCBTVQjhi3sLHw9aaWrBV1liXKqSankawfiYbSKkt7c+PWNjoneiOkoFavaHJX9JbFWJSJDCXUIsRai5/1qIDcI5uiSoMYqY3IbAat7tlnSFQPCrQY9eH8SQDuEQujEJD6ef1GapxV4y3sWKr6vIlOmT3bMreHXEqXAJmhjXulXQ30MVfKgGFFQyGdZXe/nAT5TXtkSXispVt5KBswswhh4BNyoJC5kagY3qg47g653dABo88rfBNCMNyTzMQ7YRgFLZFDTvNW+g6+MJjH296aAxYA2rxTDbya2Uc+KI046JsW8XKwsHJTWP+qgLY1FAIAzzLuAXSD8bb26Z9qH8tECVSpYrlyx2YESYyr+yyDRK7yPHoJ9s07kP8tBRzqrUMwsLnyEOQSj8SpX6jg6MFRS+FZdAnYfsRjMIJtF8XfELPlbkmVRN5msTccG2P6OZcmkik+zYW133QXLdTuv+VV1qpJWZFeLEMgWNllkcxQQz0l9hG0DD4SJN99MtNJYwm8KrqRf3sFt1gAu6ENf+uHSqoKb9FbKvvNDXp5tfdUW9q0WDCbhhTPl4QCb293GTe0vvBjbdqWLQ1ciOWhFpmzwP3YjwJuIzbYeVBnvOV+ueM14YLEGapBiWiUUKBe3hILv8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(46966006)(36840700001)(40470700004)(186003)(26005)(16526019)(8676002)(8936002)(5660300002)(70206006)(40480700001)(4326008)(1076003)(83380400001)(70586007)(6666004)(2616005)(36756003)(7696005)(336012)(66574015)(47076005)(40460700003)(426003)(478600001)(316002)(356005)(110136005)(41300700001)(54906003)(86362001)(44832011)(82740400003)(81166007)(82310400005)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 21:07:58.8440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c694fce-e2fd-405c-8a8a-08db15e20aba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7791
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
v3->v4:
 * style fixups
 * rebase on earlier patch
 * split out root switch case
---
 drivers/thunderbolt/eeprom.c | 219 +++++++++++++++++++----------------
 1 file changed, 120 insertions(+), 99 deletions(-)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 873fa4300507..1f7f2d8c453d 100644
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
@@ -512,7 +512,7 @@ static int tb_drom_copy_nvm(struct tb_switch *sw, u16 *size)
 	return ret;
 }
 
-static int usb4_copy_host_drom(struct tb_switch *sw, u16 *size)
+static int usb4_copy_drom(struct tb_switch *sw, u16 *size)
 {
 	int ret;
 
@@ -535,15 +535,40 @@ static int usb4_copy_host_drom(struct tb_switch *sw, u16 *size)
 	return ret;
 }
 
-static int tb_drom_read_n(struct tb_switch *sw, u16 offset, u8 *val,
-			  size_t count)
+static int tb_drom_bit_bang(struct tb_switch *sw, u16 *size)
 {
-	if (tb_switch_is_usb4(sw))
-		return usb4_switch_drom_read(sw, offset, val, count);
-	return tb_eeprom_read_n(sw, offset, val, count);
+	int ret;
+
+	ret = tb_eeprom_read_n(sw, 14, (u8 *) size, 2);
+	if (ret)
+		return ret;
+
+	*size &= 0x3ff;
+	*size += TB_DROM_DATA_START;
+
+	tb_sw_dbg(sw, "reading DROM (length: %#x)\n", *size);
+	if (*size < sizeof(struct tb_drom_header)) {
+		tb_sw_warn(sw, "DROM too small, aborting\n");
+		return -EIO;
+	}
+
+	sw->drom = kzalloc(*size, GFP_KERNEL);
+	if (!sw->drom)
+		return -ENOMEM;
+
+	ret = tb_eeprom_read_n(sw, 0, sw->drom, *size);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	kfree(sw->drom);
+	sw->drom = NULL;
+	return ret;
 }
 
-static int tb_drom_parse(struct tb_switch *sw)
+static int tb_drom_parse_v1(struct tb_switch *sw)
 {
 	const struct tb_drom_header *header =
 		(const struct tb_drom_header *)sw->drom;
@@ -554,7 +579,7 @@ static int tb_drom_parse(struct tb_switch *sw)
 		tb_sw_warn(sw,
 			"DROM UID CRC8 mismatch (expected: %#x, got: %#x)\n",
 			header->uid_crc8, crc);
-		return -EILSEQ;
+		return -EIO;
 	}
 	if (!sw->uid)
 		sw->uid = header->uid;
@@ -588,90 +613,14 @@ static int usb4_drom_parse(struct tb_switch *sw)
 	return tb_drom_parse_entries(sw, USB4_DROM_HEADER_SIZE);
 }
 
-/**
- * tb_drom_read() - Copy DROM to sw->drom and parse it
- * @sw: Router whose DROM to read and parse
- *
- * This function reads router DROM and if successful parses the entries and
- * populates the fields in @sw accordingly. Can be called for any router
- * generation.
- *
- * Returns %0 in case of success and negative errno otherwise.
- */
-int tb_drom_read(struct tb_switch *sw)
+static int tb_drom_parse(struct tb_switch *sw, u16 *size)
 {
-	u16 size;
-	struct tb_drom_header *header;
-	int res, retries = 1;
-
-	if (sw->drom)
-		return 0;
-
-	if (tb_route(sw) == 0) {
-		/*
-		 * Apple's NHI EFI driver supplies a DROM for the root switch
-		 * in a device property. Use it if available.
-		 */
-		if (tb_drom_copy_efi(sw, &size) == 0)
-			goto parse;
-
-		/* Non-Apple hardware has the DROM as part of NVM */
-		if (tb_drom_copy_nvm(sw, &size) == 0)
-			goto parse;
-
-		/*
-		 * USB4 hosts may support reading DROM through router
-		 * operations.
-		 */
-		if (tb_switch_is_usb4(sw)) {
-			usb4_switch_read_uid(sw, &sw->uid);
-			if (!usb4_copy_host_drom(sw, &size))
-				goto parse;
-		} else {
-			/*
-			 * The root switch contains only a dummy drom
-			 * (header only, no entries). Hardcode the
-			 * configuration here.
-			 */
-			tb_drom_read_uid_only(sw, &sw->uid);
-		}
-
-		return 0;
-	}
-
-	/* We can use LC to get UUID later */
-	if (sw->cap_lc && !tb_switch_is_usb4(sw) &&
-	    tb_drom_copy_nvm(sw, &size) == 0)
-		goto parse;
-
-	res = tb_drom_read_n(sw, 14, (u8 *) &size, 2);
-	if (res)
-		return res;
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
+	struct tb_drom_header *header = (void *) sw->drom;
+	int ret;
 
-	if (header->data_len + TB_DROM_DATA_START != size) {
+	if (header->data_len + TB_DROM_DATA_START != *size) {
 		tb_sw_warn(sw, "drom size mismatch\n");
-		if (retries--) {
-			msleep(100);
-			goto read;
-		}
+		ret = -EIO;
 		goto err;
 	}
 
@@ -679,29 +628,101 @@ int tb_drom_read(struct tb_switch *sw)
 
 	switch (header->device_rom_revision) {
 	case 3:
-		res = usb4_drom_parse(sw);
+		ret = usb4_drom_parse(sw);
 		break;
 	default:
 		tb_sw_warn(sw, "DROM device_rom_revision %#x unknown\n",
 			   header->device_rom_revision);
 		fallthrough;
 	case 1:
-		res = tb_drom_parse(sw);
+		ret = tb_drom_parse_v1(sw);
 		break;
 	}
 
-	/* If the DROM parsing fails, wait a moment and retry once */
-	if (res == -EILSEQ && retries--) {
+	if (ret) {
 		tb_sw_warn(sw, "parsing DROM failed\n");
-		msleep(100);
-		goto read;
+		goto err;
 	}
 
-	if (!res)
-		return 0;
+	return 0;
 
 err:
 	kfree(sw->drom);
 	sw->drom = NULL;
-	return -EIO;
+
+	return ret;
+}
+
+/**
+ * tb_drom_handle_root() - Handle reading DROM from a root switch
+ * @sw: Router whose DROM to read and parse
+ *
+ * First determine if the switch is USB4.  If so, then use USB4
+ * router operations.
+ *
+ * If the switch is not USB4, first try to read from EFI, as Apple's
+ * NHI supplies a DROM for the root switch in a device property.
+ *
+ * If this doesn't work, then try to get it from the NVM directly
+ * without using any bit banging operations.
+ *
+ * If none of those pass, then read just the UID as the root
+ * switch contains a dummy DROM with a header but no entries.
+ *
+ * Returns %0 in case of success and negative errno otherwise.
+ */
+static int tb_drom_handle_root(struct tb_switch *sw)
+{
+	u16 size;
+
+	if (tb_switch_is_usb4(sw)) {
+		usb4_switch_read_uid(sw, &sw->uid);
+		if (usb4_copy_drom(sw, &size) == 0)
+			return tb_drom_parse(sw, &size);
+	} else {
+		if (tb_drom_copy_efi(sw, &size) == 0)
+			return tb_drom_parse(sw, &size);
+
+		if (tb_drom_copy_nvm(sw, &size) == 0)
+			return tb_drom_parse(sw, &size);
+
+		tb_drom_read_uid_only(sw, &sw->uid);
+	}
+
+	return 0;
+}
+
+/**
+ * tb_drom_read() - Copy DROM to sw->drom and parse it
+ * @sw: Router whose DROM to read and parse
+ *
+ * This function reads router DROM and if successful parses the entries and
+ * populates the fields in @sw accordingly. Can be called for any router
+ * generation.
+ *
+ * Returns %0 in case of success and negative errno otherwise.
+ */
+int tb_drom_read(struct tb_switch *sw)
+{
+	u16 size;
+	int ret;
+
+	if (sw->drom)
+		return 0;
+
+	if (tb_route(sw) == 0)
+		return tb_drom_handle_root(sw);
+
+	if (tb_switch_is_usb4(sw)) {
+		usb4_switch_read_uid(sw, &sw->uid);
+		ret = usb4_copy_drom(sw, &size);
+	} else if (sw->cap_lc) {
+		/* We can use LC to get UUID later */
+		ret = tb_drom_copy_nvm(sw, &size);
+	} else
+		ret = tb_drom_bit_bang(sw, &size);
+	if (ret)
+		return ret;
+
+	return tb_drom_parse(sw, &size);
 }
-- 
2.34.1

