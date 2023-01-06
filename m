Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7CE65FA64
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjAFDl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjAFDlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:41:52 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D116A0DD;
        Thu,  5 Jan 2023 19:41:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hyrg/rMT4aun2ZjJmn846V+1wuTJL8AKKg3yZ3UADp1AOFIBwFLUPL6MYp7zwAvWgEINQhwaGKIJufzfbZbfQP1DlnrTtSTN7KjTzPlFl7P4pmu8HYAnVhcVXxblRJdZTnbaJR671vy68CfJMzwr69VWg2tr9BLMKrngmq1EPgNt7eDs5Vzla/pXIvmLNTd3kWyx6xDYOX/fo8DrGt8+utRB5fWvs2eh1ovF8gS/RCZL+UmVcs60/yAXAxcjgDRdDZCaNNN3nNS84I0Fm/8vKGFmHq8LChAPPfLtQuE5ROf1HUk2Gq524Nj9w7mGyl3NQ81BolVKcv5wv0CC+5nGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mtyz/Id7LtYWFBn/7/P8gXCcUUxg9YUQhRDL5xyN0uo=;
 b=lTiLvPWlnbcVfPDhT/BoqaNirY4Ono3d2udDENH7ldHbxyZenr/WXUaAblsAkJxXvCIWhh4fkKIe3RmUbfnhmkIgEO4nupamlIVNS4jDHzkGm6K5Hc3vOhQCi174RC9nUIyjcJmE1Em6aX+7CqIx1xSc/yApwq95zazrPdkgIwSglCFxLDG7yRcbVbakDLrc9ewPRk6ea1M8Hk6d5NeMxt8rWeyy4bFBSNHVf5vw++QULjREZNv0rOC3S1HqzgP1JNdhnQUYAxGTLctT4EdAJ3ZWfBzuAAxktgDubpacHQLK0Kma/CQqhUglG6YYHsOO5YS6wM0D1i+4EpFUjd3hIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mtyz/Id7LtYWFBn/7/P8gXCcUUxg9YUQhRDL5xyN0uo=;
 b=RyEMPNE2z7zJ5WV7o2S30OTdYuAN3oRtWOIFay81ee/q65Il0MWkIlCdUAc175yBkshc2dWsPrJePQX9M/fir0BwW3W8fP+IEP2GaWKoBdmNO54DVZrFRiMXYpmqRi+eoUygxZUa54FB4cjJacS6fva2xjsO9utsYnOdf+Y2jc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 03:41:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 03:41:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/5] remoteproc: elf_loader: introduce rproc_elf_find_shdr
Date:   Fri,  6 Jan 2023 11:43:01 +0800
Message-Id: <20230106034305.2868740-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230106034305.2868740-1-peng.fan@oss.nxp.com>
References: <20230106034305.2868740-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 253e3d80-691a-4b98-f05f-08daef97f0aa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g73t+q60DJ2bCRyJ/osZJsZFDFUQZUkOaG7mjP61qtUX/yKL3RUSLEihWBLD3hUt1Iwjxrw1T9DOXFIMoiTdzCLmDg/q9pKyz61BJFbOiJoMVIwPWP5TWUBJqr/gMpsR+LCjZdcs2CKKSSdKFcWFUftl6lffk9xsuc1rEw6jx5aiPaFnnKOSpbWDpZJ9mVdzTPPmDsBx7kzsY8TEOSHlW61qNz+l+X8rRAsnhBuIFcFmQxXiWcCthpofj+yFHdXDPBUEMmtLttJesM3X4L4UKCQDbXE/945+cSwHYOylWjlrRX7owaQM754+XNobXfGc4gGOtbl2e1Ete8R1P/OMjpnrTyA3cJv7oSVNeN1Hc3qQHCCyYSjcRKbdNtXsstF+PKv91t61XN/Y8o4kquYEv//hfMoYo7Fj7rp6GaM3NO4gsnfW4lH6oDXL4tjslpBA6c15HXcW9RfsTLVkLHgxOrD3ClbO/HpC8C05lsXSMkeKyWI/FJ53h0PxanbqPErgDmzjudkKaF38tOYy4dIQdALROrmlGyQfxmQDmQgOJPmu+oMEt3GzeTIo1L5MumrClY0+vM9eAEeOzqPWswkYe+SQmdFGMK/HW4M623hJvscGjmP9sKfovSAJ/q7NmhKa2/UiJ5nyaIZ31snQG/YHGyPMiijAndGPigfH6N4xBJCMpjRtlHlcvSpdjbsYEF/gng24UbcqdTvxqEJpPjoJTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(38350700002)(38100700002)(6512007)(86362001)(186003)(6486002)(316002)(26005)(4326008)(8676002)(66946007)(66556008)(478600001)(2616005)(1076003)(66476007)(52116002)(2906002)(6506007)(6666004)(41300700001)(7416002)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QQ5I9sZ1Uaz9oDs7PfLapC9Ig1c1bqtUpm1ijPacmIz5uU5DarRX7V6KvkMv?=
 =?us-ascii?Q?fbYnY+dsQlj3CikMFvFADWWTZW8O7rnLXyk2rG8Mc/wmPBXVXBxT9oIuFXHB?=
 =?us-ascii?Q?moWYJVF2nkijE2jdaYe1+mIie9imxvy2PrShwnrpi89Xf3S71tHnSapeAH5Y?=
 =?us-ascii?Q?yjxKlO1UXuCOs/OdzQu2BcPo7PX1jLN7O5nN1Z5Lai04TFcSaRRb6L6DDqq2?=
 =?us-ascii?Q?/Hiz8iVpYVyGrTLlxjozljXXBzcDqyVg4DAFutp+vcZm+CGAPuVCckBw5/cy?=
 =?us-ascii?Q?mjIl4m7/md10M7oaJicF0LoD8PZBmiK31pBOlIw4Uoc3sJEneAM4B2KDZ5Ad?=
 =?us-ascii?Q?L8MduJHtLGb2Ctj0aEWB4FcyDxF6WaIVYtEa1mPxnce01Dw7Iwrog0yQ7idT?=
 =?us-ascii?Q?d1JVdnex9nzzxo/6T+5QPIjTl4rdEySf0PTgTmZuL5/qPR2oyrkpMQNcIZ0P?=
 =?us-ascii?Q?ZE4h3naLaHGoDH5u1jz8retntRusJF+TQ2I7bI24Of9exwsLeDcIAWoZ8w+s?=
 =?us-ascii?Q?m+ZVIvBf4YXsplEe2F7XHeeLzrR36BjGEdeefANeUUkdGt5j5+KcHNi7FFwC?=
 =?us-ascii?Q?Ss2t5iIMIYn7mO9bCaw9ubRi74KZmevtofkJ3sYPq9lS9W7ov684Du2Tb+Gu?=
 =?us-ascii?Q?t+9K3XT1mIBIqsOVIKCr9Tm44II6YEtalyAxN+Rk7Lx9hNB2sNfth+xitQdS?=
 =?us-ascii?Q?kz8D04pJk/0br1xlKGPhS7P2nQedphDZoE5/TYh3qJQbmKCaZTpVRrfjlH9n?=
 =?us-ascii?Q?MaMgTGEvE7YqjAwnY2M+DCVS0RjRc1ypEfTFj2zmEkZG0Zze4xpYae491iHV?=
 =?us-ascii?Q?wtqrqcUBkoDeWlNH4bH6yVYqLj9EBTPhr4FkhxCvY+4VBF3/t5Q89ZQ8rAkI?=
 =?us-ascii?Q?iBQT2BxRVI8pxkQTZ/hIdARYcQwKM/SnhDXkGFV8FEy9GspOPTo+JTBv2ZzS?=
 =?us-ascii?Q?IqOrxGBE1gXv1JaiCPcwzdnGHqA2X2DKk1txZGSwMtwqNgkm6MsyDQG7Bbfe?=
 =?us-ascii?Q?+KxqjOPIF1ROOYxkWUnthW4+BRLzRAlX5eTDd+NYR6fuN1UksqB/Rm0NkboL?=
 =?us-ascii?Q?yU3gAsgs6XW415M/AHfPQvT8bpiyg3r9E+XG1fW/xKCrBus1Z1OikTfGztZO?=
 =?us-ascii?Q?7Z2rDWXlp+ujFRq2OfgDO6laeXQ3PXHyCWNAnKfOz/Xi/eutERhn3OWEFakZ?=
 =?us-ascii?Q?83fL/EyOiGFb6xmt9QHhIC0CogkqTluMqw37vb6E3HIlLLFV0PJ9Mpkwt1b7?=
 =?us-ascii?Q?T6ELo6eilnqxisP+GFq+2+OBwCOIUJLshS3tZ1DiqpZWTgvKlZdoTgECDBbw?=
 =?us-ascii?Q?dJ6aQzNIxTvNQuY5lWT4FEEwGJLyxFlEw7GnxYeGDlH+7FJtyo12nVm7s5wa?=
 =?us-ascii?Q?lchIodHzz8fJGgcKbeyDae1bfLKNFiE33y8y7UAq3Nj5Qu6SqNiCp/yl8lYN?=
 =?us-ascii?Q?+kaUU+uFlw9bPw5gNUZFj8wg7ekmzE5T4dyxqCttDOiY2YT2gzv76njKZ/wA?=
 =?us-ascii?Q?qk9tM2Sx0WBSOlKNLAtQOCjViwwTzyfNXeJf/zC7H5g+hNobPTlcIy3uuZlc?=
 =?us-ascii?Q?coC2wEXaNKkXwQM5w2SdrVFf2NkDqWtBalqBuU34?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253e3d80-691a-4b98-f05f-08daef97f0aa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 03:41:48.5368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6/nYu1sLAk0z2ZkwONwZqiWtGgCAahxRwmUyuzSkIgb9MMf+Auyo58Fu3HKSE4XLwDvT7g0RylWkiFp5reARw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Introduce API rproc_elf_find_shdr to get the shdr pointer. This API
could be used to find the ".resource_table" section, and could also
be used by i.MX driver to find the ".interrupts" section.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 93 +++++++++++++---------
 drivers/remoteproc/remoteproc_internal.h   |  2 +
 2 files changed, 56 insertions(+), 39 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index 5a412d7b6e0b..c09fd5733aee 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -244,22 +244,19 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 }
 EXPORT_SYMBOL(rproc_elf_load_segments);
 
-static const void *
-find_table(struct device *dev, const struct firmware *fw)
+const void *
+rproc_elf_find_shdr(struct rproc *rproc, const struct firmware *fw, const char *sh_name)
 {
 	const void *shdr, *name_table_shdr;
 	int i;
 	const char *name_table;
-	struct resource_table *table = NULL;
 	const u8 *elf_data = (void *)fw->data;
 	u8 class = fw_elf_get_class(fw);
-	size_t fw_size = fw->size;
 	const void *ehdr = elf_data;
 	u16 shnum = elf_hdr_get_e_shnum(class, ehdr);
 	u32 elf_shdr_get_size = elf_size_of_shdr(class);
 	u16 shstrndx = elf_hdr_get_e_shstrndx(class, ehdr);
 
-	/* look for the resource table and handle it */
 	/* First, get the section header according to the elf class */
 	shdr = elf_data + elf_hdr_get_e_shoff(class, ehdr);
 	/* Compute name table section header entry in shdr array */
@@ -268,49 +265,68 @@ find_table(struct device *dev, const struct firmware *fw)
 	name_table = elf_data + elf_shdr_get_sh_offset(class, name_table_shdr);
 
 	for (i = 0; i < shnum; i++, shdr += elf_shdr_get_size) {
-		u64 size = elf_shdr_get_sh_size(class, shdr);
-		u64 offset = elf_shdr_get_sh_offset(class, shdr);
 		u32 name = elf_shdr_get_sh_name(class, shdr);
 
-		if (strcmp(name_table + name, ".resource_table"))
+		if (strcmp(name_table + name, sh_name))
 			continue;
 
-		table = (struct resource_table *)(elf_data + offset);
+		return shdr;
+	}
 
-		/* make sure we have the entire table */
-		if (offset + size > fw_size || offset + size < size) {
-			dev_err(dev, "resource table truncated\n");
-			return NULL;
-		}
+	return NULL;
+}
+EXPORT_SYMBOL(rproc_elf_find_shdr);
 
-		/* make sure table has at least the header */
-		if (sizeof(struct resource_table) > size) {
-			dev_err(dev, "header-less resource table\n");
-			return NULL;
-		}
+static const void *
+find_table(struct rproc *rproc, const struct firmware *fw)
+{
+	const u8 *elf_data = (void *)fw->data;
+	u8 class = fw_elf_get_class(fw);
+	size_t fw_size = fw->size;
+	struct resource_table *table = NULL;
+	struct device *dev = &rproc->dev;
+	const void *shdr;
+	u64 size, offset;
 
-		/* we don't support any version beyond the first */
-		if (table->ver != 1) {
-			dev_err(dev, "unsupported fw ver: %d\n", table->ver);
-			return NULL;
-		}
+	shdr = rproc_elf_find_shdr(rproc, fw, ".resource_table");
+	if (!shdr)
+		return NULL;
 
-		/* make sure reserved bytes are zeroes */
-		if (table->reserved[0] || table->reserved[1]) {
-			dev_err(dev, "non zero reserved bytes\n");
-			return NULL;
-		}
+	size = elf_shdr_get_sh_size(class, shdr);
+	offset = elf_shdr_get_sh_offset(class, shdr);
+	table = (struct resource_table *)(elf_data + offset);
 
-		/* make sure the offsets array isn't truncated */
-		if (struct_size(table, offset, table->num) > size) {
-			dev_err(dev, "resource table incomplete\n");
-			return NULL;
-		}
+	/* make sure we have the entire table */
+	if (offset + size > fw_size || offset + size < size) {
+		dev_err(dev, "resource table truncated\n");
+		return NULL;
+	}
 
-		return shdr;
+	/* make sure table has at least the header */
+	if (sizeof(struct resource_table) > size) {
+		dev_err(dev, "header-less resource table\n");
+		return NULL;
 	}
 
-	return NULL;
+	/* we don't support any version beyond the first */
+	if (table->ver != 1) {
+		dev_err(dev, "unsupported fw ver: %d\n", table->ver);
+		return NULL;
+	}
+
+	/* make sure reserved bytes are zeroes */
+	if (table->reserved[0] || table->reserved[1]) {
+		dev_err(dev, "non zero reserved bytes\n");
+		return NULL;
+	}
+
+	/* make sure the offsets array isn't truncated */
+	if (struct_size(table, offset, table->num) > size) {
+		dev_err(dev, "resource table incomplete\n");
+		return NULL;
+	}
+
+	return shdr;
 }
 
 /**
@@ -326,14 +342,13 @@ find_table(struct device *dev, const struct firmware *fw)
 int rproc_elf_load_rsc_table(struct rproc *rproc, const struct firmware *fw)
 {
 	const void *shdr;
-	struct device *dev = &rproc->dev;
 	struct resource_table *table = NULL;
 	const u8 *elf_data = fw->data;
 	size_t tablesz;
 	u8 class = fw_elf_get_class(fw);
 	u64 sh_offset;
 
-	shdr = find_table(dev, fw);
+	shdr = find_table(rproc, fw);
 	if (!shdr)
 		return -EINVAL;
 
@@ -377,7 +392,7 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
 	u8 class = fw_elf_get_class(fw);
 	struct device *dev = &rproc->dev;
 
-	shdr = find_table(&rproc->dev, fw);
+	shdr = find_table(rproc, fw);
 	if (!shdr)
 		return NULL;
 
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index d4dbb8d1d80c..f4d392fbaf06 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -117,6 +117,8 @@ int rproc_trigger_recovery(struct rproc *rproc);
 
 int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw);
 u64 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmware *fw);
+const void *rproc_elf_find_shdr(struct rproc *rproc, const struct firmware *fw,
+				const char *sh_name);
 int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw);
 int rproc_elf_load_rsc_table(struct rproc *rproc, const struct firmware *fw);
 struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
-- 
2.37.1

