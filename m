Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A648B683347
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjAaRFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjAaRFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:05:04 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2074.outbound.protection.outlook.com [40.107.247.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B328C164;
        Tue, 31 Jan 2023 09:05:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlGAHhQiaL2tnAG85Mly/Zowm1zST93SluorSam5li/ysQ+iSQi0uXtdYOAbIyMWJH4fHeeyTg0Zn6hdAmIcs7fZHPTPtNKQ8BIQ7aXYTlWAIFT0S1zQ8LWlWbgob/jTvCwF/NOxKmS4z/lNF5F1WbXqQjFigWtELSLeocNNqnqBdHjDUMoXHXVQ6OTEawQszblhLA3zhwh4g2whULh52ouzBu2SQfCuQ8MFANcLNo53fkT0UsCwBMNPJKHucDGX6UBZt8SgxdncJDUfv8707dVfshu7Wb3f2zX0WQjdZyQt7g9sdS7Q1D7l5brk42HmJJbN/JSHW/qPooPus2ihtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ECWxyBnPgbhXlmTne2bgYGdNpWeI3gLkLTwetTNR6s=;
 b=aRs6ZfLxuhbY7LC4xectVZR4XQXgDz9CHLVJ2yJN3GCwqXh8eSx9tDO28OPL6wRBwa+o5AE02TlEMAQqQ58W5VifLIpsT0A+g0Ds1dU78YYIoGU4OyGmqpoJ4BU51phXt0eIq7T+dcHKxetN6D2SEcuk63NxN/cxXbEoHZH4Bqnh5YDiPD2x+UxoocW1ldADOZ0u1lWg2cq2s6WvEoWOMpJEzFvsIN/wPvX6Id/PmoU9S+dX9gK1Sb9Q1FLGi+FiAB6utAoDGBv4Lfl1SmjHPoGD6qQXb1beal47np8WcThN2dK6WnP+uRn5HeP1nBQzvZrMNMEuy0fZWzpHG+k8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ECWxyBnPgbhXlmTne2bgYGdNpWeI3gLkLTwetTNR6s=;
 b=TN2rw7ix3UI7H2ue36PbVqnwA4bsBC6zEPnhzmaGwGvE0fSpxuHzwUVyVga0GxU+0KhUopjwuXD1S7PaztUeJzv2i1n4O+xWBM/SPXuh44FkQSg7ZLxuo7H0E4VVOZwiNNWvXcGh01McXQZwa4kfvBxrNAdxmFWngmiTxlbMowk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by DU2PR04MB8757.eurprd04.prod.outlook.com (2603:10a6:10:2e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Tue, 31 Jan
 2023 17:04:58 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%5]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 17:04:58 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2] remoteproc: imx_dsp_rproc: add custom memory copy implementation for i.MX DSP Cores
Date:   Tue, 31 Jan 2023 19:04:36 +0200
Message-Id: <20230131170436.31280-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0023.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::11) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|DU2PR04MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: d21f42a0-8daa-41bc-59c0-08db03ad4870
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lI2AXaZqdUo21t2tkX2Z0D8PofcdP1wM9iAfz3ZN/vM51s5Y6EW6368+AbKejOIg1ppG/dHh0LlI2wlT58Vlj/odLFNR4sHcsJJJPJMdfylH3LGQkyuC8iWl2onH3UWFsgg1KVrC4eGeMDbB3o18lhUXI95ol9xPYKi0ivToXgGLhEHQmhYf1ZlaeBhavI3dXRuMDoNxe/JZyvgQoCny+S+fdBzjKBiUY5Hrl9XjzoYYOexTvhrTox7WY1AzAaZuK0QPplLC2sas5ti/EbixwV9jeqmxcrh+VznfbEB0UQNv3sel45tCn9WvggKW1I06MplTVNYFJ09wrdULTjeG8CHHIqoSw6wHyaI+nSKLtupYW9ue81vIuPZgtL1KO+FkKwtmVxNv+3jZ3MZY/GEQb6ciychvwyfskR9qXt1byJ/OsabXLzaN1VVRX8DchQ4fjf0fOT3oTURQX3cgmFsSKOw6WQpgylRmQCF8nYMan2EN8llHUupDzZdsK73L/Y3wWqsa/heLSB8EUOUBGnMpvymbshNp4UNhpGGjKmGZsoVIIRQaFdrgyDGJZbnEJdgucgmvtoQ3QjDCwokVXkmTAmV1ubvsLFm1zl39TX8CvokI2A6ZPZQPFyQWdIShXiGFYH+csN9/u1bD6i0Unx7Y5Y1hG6bzfdFdnAR9UkRNqOLPUfS5ObleKsOL/+LFAohQVGXlEMaipZkUu4X7xiZejg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199018)(2906002)(2616005)(86362001)(66899018)(6666004)(26005)(8676002)(4326008)(66476007)(66946007)(66556008)(52116002)(110136005)(54906003)(6506007)(1076003)(38350700002)(38100700002)(186003)(316002)(6486002)(921005)(5660300002)(478600001)(8936002)(6512007)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oTglU2IQocWR21LPNIZ4ECC4/VojBV7gnyF8OQTjdPbiS8j3sS36KPBrNU7s?=
 =?us-ascii?Q?btFunFSZASkH43e76Tvie/5KljYScgit9dz90MGwEYgD753nETsNg2+7ChJ6?=
 =?us-ascii?Q?Crrh7Sl2lLlZaoodew7ZKTyjgZSwhbTrOmPVYwBDFtRcGNub1NK8tfKMuszd?=
 =?us-ascii?Q?mNfq9mt6Pn6MZTx3x/6SnmLaH8NMrI/tWjhBPLMfwR6RIDZ/u0eMtC+czqC5?=
 =?us-ascii?Q?zDEp4SU8L+uezSPa4mhd/mLXejw3tJQ2c9w0kyTsnACYZi6WPeU4dcK2kv5+?=
 =?us-ascii?Q?HvoOMUTUvoe/qocjmyIv+MSJRo5kngEYyzZHx+PLof6nsVSVfZS3Z2J1w4TS?=
 =?us-ascii?Q?k+MkNIzHqSNRG2z76pqXux3O2jaRWlk30TrnDzxcaQWhGlAhFf6IS5xR9iPr?=
 =?us-ascii?Q?j2Nir/DYNRSndZForfRIgTuJ7/j/ULi3sFUT1UdcD84xj5Cus8tQUWLnCIFu?=
 =?us-ascii?Q?vmvb8Xdo+ddwhsrRFmGL8kl1y1jQA2SNHdDGNBGhyWvgQzQauVy2F0UK4Yw6?=
 =?us-ascii?Q?pIA4TQbRqtc5xR0mznBG/6u+eAfxNiaJwnEZbD2uR3OyafO7J8lKa8kwEBI6?=
 =?us-ascii?Q?G3zbtDAuenYAUZp7srg6SNv1lDlLiaGW49ex8I6QyAKao8lsT38wMwr+xjEI?=
 =?us-ascii?Q?9Ovh47gPasqkM7WmsrwyZhPk9SWygOsuBgLzQ1vVXRO2XxvU4RvtzG5BYsd7?=
 =?us-ascii?Q?IZO1QWsElae9uh8x9kKqCEoWLNZecUsirQgoXUPi5HxnKtNEi62w++C6kenv?=
 =?us-ascii?Q?h3tXoDsJhdoTDtIosPK52qVM/Nl6XkDAfiCDwGyQd3KEUii+VGVkPUAkmJ8U?=
 =?us-ascii?Q?1YqtI7VvbAyKAZcC7LS/wOKEVswDhilrMPwhmTMXXw8TdhQmXo/lzUNx8IOJ?=
 =?us-ascii?Q?MVZmrbEqFjzLN+M+nv9jgO8AtpQL9spRw6OrTQwnpPO3vrBqhpi4iOx6WDbX?=
 =?us-ascii?Q?WyZYIO/suCO/gTXs/T8dAZ/96WNbKC7SbI9U6dEETQRPlUOJlw2W6dqdsKES?=
 =?us-ascii?Q?FCTiqdEfQ4UXIuV5jXKbChw6jKIYPlj6K/HnfXschxmVuyLoth4LJzbhJRy+?=
 =?us-ascii?Q?NNnwgnn41ssZYY6wFpVcAKIrB610ACVezeDZumzUf7hjuLCvZL1B7YEGNTEZ?=
 =?us-ascii?Q?O0IDJHECSnb8B/CpDSetlCxiEqCx8oejquRunX+nUjYgejrGw8LjlUU2qHG9?=
 =?us-ascii?Q?JPiZg5jBNESwaNowmJKp/nxbiH3WqusX4NVV0SRa+oUiF4kgSsTKEowUQ/Dx?=
 =?us-ascii?Q?KB/RLtX9X4GiPBkZuE3oy9yLBbaL1X6UZUcrs8XfCsafMIAj7jn5KVJovTM5?=
 =?us-ascii?Q?GWVyK9zl6f8qhI5F36jfPIByX0jvIc4LbXsc8ghNX2Zw4hQFCgZhI14sClrG?=
 =?us-ascii?Q?8hsqamj14dAcVdnqHdjJv47bJNuIZw74t9DozFFou2UN/+ixyv/cUE3KgyKM?=
 =?us-ascii?Q?j0ulIalFkgtLMLRGQ2WeZnXtwB/f7CMpkW8wAnRwuhU8fKcUPls2w8MGE3J+?=
 =?us-ascii?Q?riREJGPUy++oKbyafNFOSZi+srPEcz+2GVqeEA4arQgqrgOh5WkLiHe2qRTz?=
 =?us-ascii?Q?D5OVDBkqWlUawi/BQDYZucpvFH7OFhnH6zHuB+9eiNspaYXar05A5kGIrJIt?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21f42a0-8daa-41bc-59c0-08db03ad4870
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 17:04:58.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4x5rp6Y/wlqkNhHyWnnAKjCLemu5lzB1rmzW9MubS2XA+VdD6Qahk6CuE4j7FECXigAh/wKBeC2CnWZSbduuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8757
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

The IRAM is part of the HiFi DSP.
According to hardware specification only 32-bits write are allowed
otherwise we get a Kernel panic.

Therefore add a custom memory copy and memset functions to deal with
the above restriction.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>

---
Changes since v1
- added missing check for cases when the memory slot is bigger than the file size;
- added a custom memset function
- removed is_iomem flag since is not used here
- updated custom memcpy function to avoid reading after end of source
---
 drivers/remoteproc/imx_dsp_rproc.c | 181 ++++++++++++++++++++++++++++-
 1 file changed, 180 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index e4b1e962d56ad..d0dcc0820fadd 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -715,6 +715,185 @@ static void imx_dsp_rproc_kick(struct rproc *rproc, int vqid)
 		dev_err(dev, "%s: failed (%d, err:%d)\n", __func__, vqid, err);
 }
 
+/*
+ * Custom memory copy implementation for i.MX DSP Cores
+ *
+ * The IRAM is part of the HiFi DSP.
+ * According to hw specs only 32-bits writes are allowed.
+ */
+static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
+{
+	const u8 *src_byte = src;
+	u32 affected_mask;
+	u32 tmp;
+	int i, q, r;
+
+	/* destination must be 32bit aligned */
+	if (!IS_ALIGNED((u64)dest, 4))
+		return -EINVAL;
+
+	q = size / 4;
+	r = size % 4;
+
+	/* __iowrite32_copy use 32bit size values so divide by 4 */
+	__iowrite32_copy(dest, src, q);
+
+	if (r) {
+		affected_mask = (1 << (8 * r)) - 1;
+
+		/* first read the 32bit data of dest, then change affected
+		 * bytes, and write back to dest.
+		 * For unaffected bytes, it should not be changed
+		 */
+		tmp = ioread32(dest + q * 4);
+		tmp &= ~affected_mask;
+
+		/* avoid reading after end of source */
+		for (i = 0; i < r; i++)
+			tmp |= (src_byte[q * 4 + i] << (8 * i));
+
+		iowrite32(tmp, dest + q * 4);
+	}
+
+	return 0;
+}
+
+/*
+ * Custom memset implementation for i.MX DSP Cores
+ *
+ * The IRAM is part of the HiFi DSP.
+ * According to hw specs only 32-bits writes are allowed.
+ */
+static int imx_dsp_rproc_memset(void *addr, u8 value, size_t size)
+{
+	u32 affected_mask;
+	u32 tmp_val = value;
+	u32 *tmp_dst = addr;
+	u32 tmp;
+	int q, r;
+
+	/* destination must be 32bit aligned */
+	if (!IS_ALIGNED((u64)addr, 4))
+		return -EINVAL;
+
+	tmp_val |= tmp_val << 8;
+	tmp_val |= tmp_val << 16;
+
+	q = size / 4;
+	r = size % 4;
+
+	while (q--)
+		iowrite32(tmp_val, tmp_dst++);
+
+	if (r) {
+		affected_mask = (1 << (8 * r)) - 1;
+
+		/* first read the 32bit data of addr, then change affected
+		 * bytes, and write back to addr.
+		 * For unaffected bytes, it should not be changed
+		 */
+		tmp = ioread32(tmp_dst);
+		tmp &= ~affected_mask;
+
+		tmp |= (tmp_val & affected_mask);
+		iowrite32(tmp, tmp_dst);
+	}
+
+	return 0;
+}
+/**
+ * imx_dsp_rproc_elf_load_segments() - load firmware segments to memory
+ * @rproc: remote processor which will be booted using these fw segments
+ * @fw: the ELF firmware image
+ *
+ * This function loads the firmware segments to memory, where the remote
+ * processor expects them.
+ *
+ * Return: 0 on success and an appropriate error code otherwise
+ */
+static int imx_dsp_rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
+{
+	struct device *dev = &rproc->dev;
+	const void *ehdr, *phdr;
+	int i, ret = 0;
+	u16 phnum;
+	const u8 *elf_data = fw->data;
+	u8 class = fw_elf_get_class(fw);
+	u32 elf_phdr_get_size = elf_size_of_phdr(class);
+
+	ehdr = elf_data;
+	phnum = elf_hdr_get_e_phnum(class, ehdr);
+	phdr = elf_data + elf_hdr_get_e_phoff(class, ehdr);
+
+	/* go through the available ELF segments */
+	for (i = 0; i < phnum; i++, phdr += elf_phdr_get_size) {
+		u64 da = elf_phdr_get_p_paddr(class, phdr);
+		u64 memsz = elf_phdr_get_p_memsz(class, phdr);
+		u64 filesz = elf_phdr_get_p_filesz(class, phdr);
+		u64 offset = elf_phdr_get_p_offset(class, phdr);
+		u32 type = elf_phdr_get_p_type(class, phdr);
+		void *ptr;
+
+		if (type != PT_LOAD || !memsz)
+			continue;
+
+		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
+			type, da, memsz, filesz);
+
+		if (filesz > memsz) {
+			dev_err(dev, "bad phdr filesz 0x%llx memsz 0x%llx\n",
+				filesz, memsz);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (offset + filesz > fw->size) {
+			dev_err(dev, "truncated fw: need 0x%llx avail 0x%zx\n",
+				offset + filesz, fw->size);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (!rproc_u64_fit_in_size_t(memsz)) {
+			dev_err(dev, "size (%llx) does not fit in size_t type\n",
+				memsz);
+			ret = -EOVERFLOW;
+			break;
+		}
+
+		/* grab the kernel address for this device address */
+		ptr = rproc_da_to_va(rproc, da, memsz, NULL);
+		if (!ptr) {
+			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
+				memsz);
+			ret = -EINVAL;
+			break;
+		}
+
+		/* put the segment where the remote processor expects it */
+		if (filesz) {
+			ret = imx_dsp_rproc_memcpy(ptr, elf_data + offset, filesz);
+			if (ret) {
+				dev_err(dev, "memory copy failed for da 0x%llx memsz 0x%llx\n",
+					da, memsz);
+				break;
+			}
+		}
+
+		/* zero out remaining memory for this segment */
+		if (memsz > filesz) {
+			ret = imx_dsp_rproc_memset(ptr + filesz, 0, memsz - filesz);
+			if (ret) {
+				dev_err(dev, "memset failed for da 0x%llx memsz 0x%llx\n",
+					da, memsz);
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
 static int imx_dsp_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 {
 	if (rproc_elf_load_rsc_table(rproc, fw))
@@ -729,7 +908,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
 	.start		= imx_dsp_rproc_start,
 	.stop		= imx_dsp_rproc_stop,
 	.kick		= imx_dsp_rproc_kick,
-	.load		= rproc_elf_load_segments,
+	.load		= imx_dsp_rproc_elf_load_segments,
 	.parse_fw	= imx_dsp_rproc_parse_fw,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
-- 
2.17.1

