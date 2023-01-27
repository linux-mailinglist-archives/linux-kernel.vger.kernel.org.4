Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25F867DFF0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjA0JVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjA0JVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:21:38 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB2A5BB0;
        Fri, 27 Jan 2023 01:21:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub0UPzuf7pLAaCWtB+8kBvG5GBf20GYH+ll7x/vGcfW2bbCozwT59QX0yfo9Gp8df8q+N8TMWSd44mOiyrmnoH2m9cQYGEUmkNhpkwACUjLscLucWD3k+KURWbPdWehVLKTmBAM1kKxzNWrI/Ur+zeCxWndNxcVt/36m8yFBGnlkenRD9Qc93I2/CSRAqbUe+ixtMYguF3e5HUPq/Sb18PNvRVMVGCQnLpo+i9psISkHN6cCQ8Mwpd4jPm6FGRmGgwcdv2uP/z/W2VOj8ocZLxDWRWA3r+DL9MPnn4CQvXCNi13MYZf6govxZpNeqew8woXsNArbRQ443PzQAtDHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JkRLjElN/hvoRUa9Qe1a4NLYuIcWhbRbz0xVhmDAl0=;
 b=drQgMQidUBpz7gkOL6w7PR9rbZwrvQPmviT03jTPMTsbMY72MKeT0iLGhlTKUOUbSZ7kyfGOAUWM8+LZhzAQc7YP2vjksgK2zp2umko8cIn9bcJ/qf/MN0teLH5TZeUgDYsMy0shLXszXFzhCrCVUx8+NApj5jWD2ftoDvLeTauMgo0NUxLItEruuWF9p52Q8/Ku2aDxhtYjikJFnRx257L3vU/zwBH02Ozftb6UNfo7+/ash4ofnMIBTvHW4sn+VIS7J7A10XsGqTeLnALUTl6M0xl8HBNniyKJvYN7dNvPSDMQrPTAXcodoHRyDt47RKL4pN3hswcMIN+HeAc50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JkRLjElN/hvoRUa9Qe1a4NLYuIcWhbRbz0xVhmDAl0=;
 b=j8UrOmKXEgqJ32m2QoHDra7T4790ViOE+flJuEn2iFxnzEtULFiFIDH6NF5r82azpn6qM8JWr/qiR55nLj7s4BQlVp570orZTp/V872WMX03b8w6lECcp7wygpvmBA0nsqwnpNAi+dgCyACB4VRN0M8UeZLn1gMKEXVe3Xz4Bx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7530.eurprd04.prod.outlook.com (2603:10a6:10:1f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 09:21:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6002.033; Fri, 27 Jan 2023
 09:21:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/6] remoteproc: elf_loader: introduce rproc_elf_find_shdr
Date:   Fri, 27 Jan 2023 17:22:41 +0800
Message-Id: <20230127092246.1470865-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
References: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: e47d44ee-53a7-49c7-5fa4-08db0047e1bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3gAd6HJMZW6rqMuBO7pHsX7Yt9cfcTNaFi3/dNlJXxY5Ga5/Jue7nIY+J8e8IHgtF7AmWNGefxnSGUSq3jufnhyz6Z0/x8V9u5F3RwLohJOI+amXkc8J23W1ZI2Tgd0Yn0YABozAA451YTvgMdhmsYLuQvEiaKHmnRlLThE9LUQEx26lUMiIJFVT5P3Ok/dRp3LoLVa1iQk/ndIG1GNzD3p5Lexy71ZtM0WYc4RAALFw5AGcDzfkhRLIIBtg48CQv5nUkaUKwKEsuQyr/UAZSrhwuXdq+05xS8pJv5aOCOq1DTzNvK13W+Bxi3Hvdgksg9HsXBF2MrE4yzdXXimX+5Goo7ZxiUVZiTdi7d5+ynEA8Kp2n0zo/VK2KDssVw13wRBf3tpwxdj+G9ZzyqqLfGo5QdEhzKdeaHpnJWFpzVfVPIxeeAtzGNu56hjsqJZwtRHdEmdaWgCleqY+OLBSjqUKiobp6ifMhZwQiQ78mhxgbH9XO6KmF56sHCWWfN5x3/hy9HWuPqsuEUnoJzNQDQHUqQlDMJvlG8QY54F78d+f1xTAzibG9+tlj6cAvRYb4jBJ2A7fF3dxFdSljoz+qFK8tibhzriNUbgZknf4OvgVviRm2Scx6pnzmtJ3+ZTC/PI3/B806WMm5G0nq8GZYacEeuHXykka8ELbme+bqIF88fi9LNJI1wTKzZjVWIjwVAsTxyNeFs1l+S9kcue+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(38100700002)(1076003)(2616005)(8936002)(38350700002)(2906002)(316002)(52116002)(41300700001)(6486002)(478600001)(86362001)(83380400001)(6512007)(186003)(26005)(6666004)(6506007)(7416002)(8676002)(66946007)(5660300002)(66476007)(4326008)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CxrwyFVdB5CDv+2v8uZ64gmMd0Bnv+T3FHje5Y8gHVBPzqNcUEhJqmmTusv5?=
 =?us-ascii?Q?4vlwanUVEvy3/sM3niLOL2yOFHtvY1fUzDyAGqd227PmS9QkYL1jXA/tFZ23?=
 =?us-ascii?Q?znLTbITSC0u56BuxBOHZVbbBESHnITyhEJhY1vNRHWCeJrsHj7ceCfbuSUKb?=
 =?us-ascii?Q?lgiCUvhCyinn5Kg6OSVFAJMMfSIR4ZmhNN1+b8jHWcX90N7YLVxhitYsDtH9?=
 =?us-ascii?Q?ckXvwCnAi0uB5BMLn8Ql7cVlFtXtXtV+1gsD3U2teCSeHlV1e8WmoZ1md+O0?=
 =?us-ascii?Q?tYfp/AIiULySnl7XX1GQ20Z54k9re0mjn3utgIe6hGrlcJH0Y7dSA3d+di/k?=
 =?us-ascii?Q?HHVmeHZgZt/4u8euXMZfLXI1uPl57HLolix1VOy/7hj4OQDx1jxeu/PAHvHz?=
 =?us-ascii?Q?aQLbd2JIhkF8IPM5RNA3IoSwb/zyIj8ErVoCNmI8VkgExImKk11RZjSh6n0W?=
 =?us-ascii?Q?hPnJt4gnzQ0yhT8cXYXcPTIcPgvpgXhIgL8bq4ygKToLuNg2Bb6IeJ4+QA2d?=
 =?us-ascii?Q?PRudXgiCyGm4P+9u9HjnSUPpZQ6Me8RpYjHiWbm86KELNE86N/Rv3i63vl7/?=
 =?us-ascii?Q?QpXiG9kKPw+WgrxSLQVN1M4QAVUfXbcEjvJMMT9qfMY4ut2TOyHBSA7sEpKM?=
 =?us-ascii?Q?N8NUZGgk2hNoj+sQZJrR7llJpfKRtYpOOprMvQEidisMQXjMR0wRPoFOOtuX?=
 =?us-ascii?Q?y+4YFIPQ6n54WwyK74V+dOTOxMhro0m2cSWmyiRMAXFX8lE76E/rs2jjWDFm?=
 =?us-ascii?Q?bbH/J6RDCt7nb0WNGoZwRgHH/X0I34E8en66ODVfqGUUAAz+VK+NDQzhoJxQ?=
 =?us-ascii?Q?nGiHnNPUKVlzUofUbYKsxk/GvhCnW4BjM/EQByVZBoX2xS66uj/DScFqDPm6?=
 =?us-ascii?Q?jgjlRCsdqbhlJLP62X+y386r2Xlj7V5aVylA1J45JjdnfCciNXStDrUD/0gA?=
 =?us-ascii?Q?ArdSEw/1gbIhXqjqIRriNKjbJmxpA89eM9c44DwcvPjafIUIJ7n1sf1tjvkn?=
 =?us-ascii?Q?wxeHTh5CwoKFz8mwnbZ3AGkrnq/lzSR6eA16+tviKny80Or8IAxtj6j8sRlq?=
 =?us-ascii?Q?BYR3vGiM4f773LjKj1fY326uP1aEZs5TOJPt4r8hmph8iaTziJrZ1kMDBISc?=
 =?us-ascii?Q?6nAYBPhBjShk4owmHFDk7dn38DtZr5Pl60U/hgSNpto300AwGeAClA2ZTKY1?=
 =?us-ascii?Q?Fi18yOe3eAJjP2Cy4Pr3Qnh2RYUyy1lBoI53vv4HrrL3Tiq+lZSlFOiOtaWL?=
 =?us-ascii?Q?vfrIsA14PHjvNExkTBpLR1CCYueW8y/5oxnwcckZOGSzWihnwLk8Jr4kYMIT?=
 =?us-ascii?Q?CX795jMIIzvArH85VHwzAjj6czDbK5YkcVPKstIbzXtiUFvXJx17MMmfRkty?=
 =?us-ascii?Q?XjTgj03N8MSOtWWRDQyowgvCHKWUPqcE55RVv2EMJnFCgFOK5oBs1kXu+JGb?=
 =?us-ascii?Q?NsD7LEmiNz5vPEoXL7WdHGP3zNZ8pNONTxgXca6PG1pWP90bVWovfsRYs6hY?=
 =?us-ascii?Q?ckHQOwK4gd7ftYJKOegI99XTho/gHsnd0jKs/oOy7Qt8g7mSucuWSpl1EbbX?=
 =?us-ascii?Q?T6tFTTk00VjTx9fz5dImkrFRRUkp22bvA8dwPlPd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47d44ee-53a7-49c7-5fa4-08db0047e1bf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 09:21:33.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e67/u8c47Mb88fAzSPFPLU6huKZYklw70Ecuu0PaCiHJK8ftwA3mMeRbXhwm2XCdyt7YpbkasWwcQFhbkDxL7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7530
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

