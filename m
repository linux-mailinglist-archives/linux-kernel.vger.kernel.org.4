Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58262690074
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBIGhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBIGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:37:16 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2046.outbound.protection.outlook.com [40.107.241.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6373F2B1;
        Wed,  8 Feb 2023 22:37:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW4E8unEKvTT1y9UU2xaHuwlu8iIy+8axkGPdkRNS/ACj1jSg5fssTXnWJUFF8LwN3DyCPkonP1QdGefhUK8wZ3qZ+Bd4JnvnE8tZFyICUyqtLHZ0aHUcY3G8Eur2EQ9O6XJNmJ5Dx8WA6juDRdHegJlKlFpu1GP1nqFrTXW5le5uBX+y42FrRymzz4+yjUeo2rISHXTMCzpiuea852D9n2XBdb2UkhalfcnkCdF9GtnTE8Rb5o3cfujmy+BpMuMnVQ5s7uBT8U+qB5PJgee0rzHLGH22TXmljdZsOc1dDEJ1w73BW0HPyL0M8s8dXmhXbqnJvPFanHHo3jhs2AbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JkRLjElN/hvoRUa9Qe1a4NLYuIcWhbRbz0xVhmDAl0=;
 b=f91mcl9XzWmbgTpVR7D+SWW246eFl5UIyeTthUvQ4hT1Tf1rBlCHZC9wiMuZ4NLxxx+jJXmVpOK65Owb5fEdoop2FmvjiNY/ExHmby1ixqX4oRjz54vmnrfGi7pvG42f0WiHeeDEvBRzutnlDHi4BOGHPP5Sceplep6ejgHrD2Rz7sh1K8//MuLPt3U86q/vmgbfXgcL7eg9KtUSWx0rLGBGmCfaaEdbyhUCCRh4n9Sno6cNLUW8GUTNEx+wXiIzpQsY2R3FfIG1bwFtXxNWgPvIIIREdaD/38mVsBdXCKCyv8pOWlzC38Vki3tkG7lxC95Yl7UBHjuCaIIrjQQiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JkRLjElN/hvoRUa9Qe1a4NLYuIcWhbRbz0xVhmDAl0=;
 b=kBnQ/UvNbdbPExUifCaj86YsBKtSkINOdLV0CqCWALOL/cc/6ja9bTTti+TMH7iZoHVkCOAjDQ5LLlhUc70WkTIJaTsH9Cw+dcizZUaeGKMfZ0qdUIrR7P9/DxdQ7xwtVNdc7n+xBEMko8gBcTVMn0YPLuzHQR6DTwm4DOQUzNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 06:37:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Thu, 9 Feb 2023
 06:37:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com, daniel.baluta@nxp.com,
        iuliana.prodan@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/6] remoteproc: elf_loader: introduce rproc_elf_find_shdr
Date:   Thu,  9 Feb 2023 14:38:12 +0800
Message-Id: <20230209063816.2782206-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec5408a-6498-48da-0f38-08db0a6812f2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ac4nLLNBPvqIB3tkY8oUDLNY0dNtR/05F9bVDYhVLqp4nv/Ud90A6+Q8ckQ78PeiD20F/seJhABFTCRDjWPCPPHhV1aUmZdSv2c4mqjRrgFnXp1d20TNtWBQo3Ot1gmI/KCq/5Zcz6q4qvJbksu7XN9QjtN8B+SabkrLbU5nDrwFBJ5tu6bbk7ESZWMvIdbvZN7zZ7gawUm+t+iltNTpc76JmbM/A8nJgrNwtBo7DLHh9DpcYLwRtDjNbslAriOTOByafFnDLvZVLWhiY0L9kbVynQzWNTMl14jZstcUcFbwyreLh0yyiWcmn4ou6nXFK8d40DdQB0VxHCXexs2twiYv/okvBaF9CJYVg+/kBszO8Nl598Qe4sqM+haaLaGZCSC0M8RsQ6MpFzn37wVUaJgNFB6pEeiXHqkmQqQH5Oij2wpFxheBalddHK5CeCBVuFMt461Lfe7JAD3LvB1psmiivomvx0brVdxIjefGwMQv/RG6nSA3e/UPL9c3qDnWefp8USiRERjP+yb57OASFgba+fY/MXWKy4h4f5HtyjZFim9qHk5SDaontHCDmRRVnmDNRbX55eqKbNqGYB6dTmzSDLRy/gpf8V8g3dcHqO2GpbgTFNHc7pDUi40uUgRpsgFouzRqDAFfLcoTSVcidz2ALySkYQxOVADOelmisr2cAMNUusdwG4DVMqp+lGv79F8PIfpqJICQm7zvOUsrTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199018)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(38100700002)(38350700002)(2616005)(316002)(186003)(26005)(2906002)(8936002)(6506007)(6512007)(1076003)(86362001)(478600001)(6486002)(5660300002)(52116002)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0TybkDiGFBjJJ7ho3nTJCSnZOMsbWS/78aNkXjVL3WBuUgIxi043GLNKK9Es?=
 =?us-ascii?Q?Dw0Kh2Y6Ez5u8IjDRFZHFVHxQtRd8cyGenYJlaRQwawnuvmM/pAy6QLH1MaU?=
 =?us-ascii?Q?EP6JEVLdugk2UbdaGU4fbb4lXwMNYs59NnIjsVnZRGOu7qgW9Fxe3TsTcoKV?=
 =?us-ascii?Q?fUzCCR9I1ytYQ9KgoeSWPlMhCyC25ADgkqVHXiqxvOYAJlvqrMGj9utznfLK?=
 =?us-ascii?Q?OnMXgOpTma8W9amvbYAGIITUthoTdfYDhRRh50iLl6zwo8kvw7XKgWxVd2nu?=
 =?us-ascii?Q?uqHvf5nIA3jEqmyWZbcB5Q9e/57CgLgCIE+u6CuHjZd2rqFP+QZT1jlGzi4F?=
 =?us-ascii?Q?vxL07VLCX4uuHPVbO2p6Dq7MTP1l26huV+I9TerfmBSwxSwjcvlHi7PXfxNC?=
 =?us-ascii?Q?vbC6crConwWuSRtdCOCXY06f/g2HjAY+N7h6RVi4aAcfcdRkfHaC3K8wJ84a?=
 =?us-ascii?Q?WpVw4v+StBun8Ynr/SriMPY7Hkcso6gMX9CtjNdcgAjX0uq5rl58abuh2CFW?=
 =?us-ascii?Q?eOp7zY3vjkPDWTLRJxp3HMZo22Qtst2QMvGke7sJEPTEiVTvAN0HTN2xx/94?=
 =?us-ascii?Q?UUxTRSWWO+vnlWxEcZz4r6GCc5uw5VrzEC5Bgf7xQMDhHssx3CPmu2a+dHDl?=
 =?us-ascii?Q?Bd6u+KWQ0i9f9At/ZPX/bIN2DZaUoRpSnb2hibY/5oMaK6fvcbKYloUbaeMU?=
 =?us-ascii?Q?eIpADJFobOZDlAlEaPaacQB9kNAd9E98AAQhzJefMk2OiN/DbPvdK0XBgOuY?=
 =?us-ascii?Q?hGvyQYGrB2WxiiRRchqk6lc/fqP8ndicHwWjoQ5dxpno1xXzA/AtscG6/JZW?=
 =?us-ascii?Q?93nweAH+bqM0XDK7sEoxBHkFIBMvqkr2Tt++WNmAad17NORrA1ST2yIVAnP9?=
 =?us-ascii?Q?VB5TpIAubqB/4R3hLStZWOX+ZWXvcPb6i3NjTQh9FmETLkUY5Pr6aWNtGPjS?=
 =?us-ascii?Q?VptFmbod5xleW2AroTCRwhSDxlyZmbAbYYAJssxt2XlYDP6omJivnK2Mt4g6?=
 =?us-ascii?Q?yNT2jSSJEaXw8YfbW2+LSZ/4fwjTbXhyQMmB/iSnMB88Fyjmon7YbooOqnho?=
 =?us-ascii?Q?omzYPIJk3QWkvrUGpnHNr5Bzs9g7AXiHdqpA4nHD/HgRLPufYu6mUmty13jJ?=
 =?us-ascii?Q?C3I4PGbcJh/RJIWVP9m8PwPx8h9jNFGZt5Wj90kHnIniIof7xNpqsYgUvsss?=
 =?us-ascii?Q?88L+BDSu8FR7Bg1opYlGBQcngT7oLxTv/MutDtakkXv1kR1toadj17KgfG+e?=
 =?us-ascii?Q?M8+T32kIjFxpcQCbyY9VLphjG5qJ3/Pinx8oDZ7em5DA/d5RsrFGRzOxKtvx?=
 =?us-ascii?Q?cKKxcmnuFGlRrBYM0zIlM7tVaxuAGei/eCiFwo7Bm1zpNbeOX82c3KBg9i+l?=
 =?us-ascii?Q?Zj81ONdwUkgP/gc7OFFsUchyHmxSnoExJH7HCNaA9k8FrCn45ulonb9gzR72?=
 =?us-ascii?Q?GhQNCcxWPBC61UuZtvcI3DdwT3HZkTsiVBRZ9sxmz1oQh0yLY88DAO4IUm60?=
 =?us-ascii?Q?beFBBxly+1OCiu3lUv4tTZbT4IVPqQvCFSqsMLPAQ1K6hAD3A8Gh3PdguiOo?=
 =?us-ascii?Q?E8TKBS7REz3zVvTRGF9kb3l5+bz4XJ6qBgRD9k8g?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec5408a-6498-48da-0f38-08db0a6812f2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 06:37:11.5661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY2zeUbfNjwN6d2dcoksiFX64iTpdhY/zu1UYZZYkIOVsxZoaLGYuM5Ko8IfO5Y//sXcoG0+IKhCsy36xnMhFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
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
index d4dbb8d1d80c..2a4f75a401d3 100644
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

