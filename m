Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3F069E582
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjBUREq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbjBUREi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:04:38 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6969B4487;
        Tue, 21 Feb 2023 09:04:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOyA2OmxJLKmSJQ709t/mTVoX78ajAMnjDsOg0AZ9m6YQ5+uZzwGMFuONbN2DDfRUV76D+qfHcGf0W6FN77cqbVIMJ4M3Vs/jL/FD5mARIoSjMFeCiSHoAdZ6ZdX6zz7rgQnNf9C5Pj6Cmik7cs+LA9HsxIc95mORDkAmwr7UViSLafXK6ZQ1cUVF6CKkzE8ebjziAug8opEEmQG5lPMOatOuOF0iyyA+2Z4jBpuoAEJkFyK4gyZKoQiLveY5+WuFNSwHhHkXYrVz7V9Qi7T+s7limMX2ffHybtBm8ojZgMwJyHSTKne+JHtsu4ewx+HEI+wCJRMEFKzlRN3Bu/9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWEhDYYDH3AaKGFZ9v5r8GdL5EdLT0WKlL58Q0MfrXc=;
 b=hM2U7+wHdfEBBp+5mZZsfCaP7jjEM84sNvm2sKJa05758amUnISWmDHuZ8FvFxL5Y+FO2SCJtXjE7cIojv12mpdl4PtE6Et4xo7slKn8V1JTOgoWN+cqhss9G1+ELRKqNR48FfoyMe0wZzehkDoNeOVO3D5o+sEQ2TaAe9flg7v7cNVKpzNPTpCxzXuj3Tl0cY5ehOdIIi7Z2ces7/KBAqw/SPRb/jgl2aT3JXXA4+iSSRHd50rFnjbS3ThrZ/PgfN2znUXgFjWj2HgshB4ahIocy/VbyJDaekT8aSdd8lL8IZZ95bZn/a4Abq/e1KNOdeDEe1eb357nJuWEDe7M4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWEhDYYDH3AaKGFZ9v5r8GdL5EdLT0WKlL58Q0MfrXc=;
 b=fD2h50/bcnKrVjtAjyjsCmWCwgdPChDQPgKwam8e9Ra9jnE8eYYFft4k6uZcg6EvWh3LqdZa8DoZsBQ2vtw2QftRBlSjRUCFiEqQ06AEzfy2s0JEAQOXxzl7ddWlk4Zkcd6eKQaIKdOY1wg0rBhtce7AZQE+uuPnjoc9F7zmMbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by AS8PR04MB8039.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 17:04:18 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%5]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 17:04:18 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v5] remoteproc: imx_dsp_rproc: add custom memory copy implementation for i.MX DSP Cores
Date:   Tue, 21 Feb 2023 19:03:56 +0200
Message-Id: <20230221170356.27923-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::28) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|AS8PR04MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: f2995374-e2dc-4657-455d-08db142dab3d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWjKh7X1P4hAiWxTq5cZ6v9jjCpdELEbH+fhhAEPbbTBPh2vUHh8RRxeTa8x1jGFMz8ezg4NTXjqgkrjg0bTc6xe6DPkq5DJ7Cvc9bJD37a12ohYJlT1VOoysQr3VrAPB8oEyvFOqb5bnDvkWiI3z9rCcm8zkQ1fJi1sguqMwQB4sDqE8qnXkxTB+CCJqKKiGUI8pa01cu8NAyKGKXHL8l1TLLWGF8w1nK9AX6OGD3L4QOgzeuEZVC3CmWLL5FOMgWRPuRTcuPApfosOWFvNh8Ba7q10rKFe8uBgORM20y7KmC++vd/XvZlhVsKMA89lait4W1hYHbUSPNIjVlqkkXcB77Gk5k5eLzHGUt2RJZY0Nnsi5yqrFrevXyIzE3HPQfpCR6/DNbMWtNOaI5e0v8NbTGWxPVukQj3uJfQ2RjudL+Tc1pkOnKh6/BTimnjMejyGJLGe7KFWv3+ojfItziTP7Xmt9DAsd9wXt1zUnKPXRuebrteyrOSj0VSMchoi3Ptja+cHidbHgLkWz7LFZXF2ueN58fFXUv73qzfn2rU95m1fXgOvMhC7rivYw59z/+wh0h3JFsLOCf7R1vauk+V7zohl3+Yt7O6XdGfBe0JKCpQXwWSQOOfOgAD5dfLnHz8+tA0+1B3g9RqdHZQYg+xpzBGf7qoj61kdnVeCDBObNF/smxRAhbm9aLq0VJzdkLPuan23xZqQwpe8BwjPHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199018)(66899018)(86362001)(41300700001)(5660300002)(2906002)(8936002)(38100700002)(83380400001)(38350700002)(478600001)(66556008)(66476007)(52116002)(6486002)(8676002)(110136005)(66946007)(54906003)(186003)(26005)(2616005)(4326008)(316002)(6666004)(1076003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4t+Goc5hkKP/XYlDI1z43NaK9YHnN4SwNKH28rXxWLUt5iobOvH9oZ3LHtf3?=
 =?us-ascii?Q?6SdgSTd9KrIZ5pHJ07HovBsyPfcgTyZHBmaHZmNphtuxkiX6fDyhAct7+y05?=
 =?us-ascii?Q?3AcNFsOH4d5y38S7zwtr3hROlyECkiOTk2NFted+CM37lpNz8fP2Pj2/ijC2?=
 =?us-ascii?Q?JGOMlAAX+9W3RCtwQFJaScJbVjqdDTES7zbn2ktdXJ2/4EzlZ6/HKse92fNR?=
 =?us-ascii?Q?yxXtgxAKgsPp+AKFlzJS3PIqn9glgdVWprErkhbwhMPxv+Xxa9xUxqu/OniZ?=
 =?us-ascii?Q?nip3QNGtWr7kJXGztHurStIiZ6M/aY4hGYf+XnJUJp1gEbbqw9bNr652UUap?=
 =?us-ascii?Q?2nop5WS8jTRrI00HpklWeTjLBXiVvu94nbg2SVpCq8jHQObu0dexLnbfBw2i?=
 =?us-ascii?Q?qG4QAAGbVe5tc6260RfKnSYBxO1alaHrr+ZcOvTuRCkeeJyy0MJdSR3rjgdh?=
 =?us-ascii?Q?dzUtzjWixvn0i9ngFR5NMrgzmE9LWyv59jT+LffvpYUq6MSkyINhTnG/eG80?=
 =?us-ascii?Q?Y+bmYh8zW8ym7L4OYb6MyPI4hQLnEkl7SXJJdSSvq5EfgfzF9URfg4S5FGWP?=
 =?us-ascii?Q?ZunEIB4lvx2qUDlAdwmFrp4u1TuQYRcCRMa+pB7DRLOe1x8yW1Oo8sQNdbeE?=
 =?us-ascii?Q?QUMHiJXo9U/rAgna9j7HIxFtOb29Tx6HblRsTgntY9OmTzPCgN6ZNAXYMWTk?=
 =?us-ascii?Q?ztrYE/q9wX6l1BL787ivVU1WNlFsvAIA4Tj1wZXya1zFR/EBALztt8djrf1O?=
 =?us-ascii?Q?OeB9ltDjcGPX5r9E0THjigu5yNbpsO17aAI7Dn/9baCHx0V19WVMGsN/i0Nn?=
 =?us-ascii?Q?X48IhdwQHYlFyovFsb6WF7JBisE9pBtzpDNVt+C3xNR8G1LOGe/a0xp9pJIW?=
 =?us-ascii?Q?UPbnFwlG+ulOnc2sJcZzPySQHBavb6Shm6sWhu4xsTpBknOeSxV8JLgu08LG?=
 =?us-ascii?Q?+knoeqKnUK2AS+YsRqH62Frct+aDSfU9c3POK2tKAiANhdANdRlFuxxUMNeY?=
 =?us-ascii?Q?s2JSIpJEsj+C1uTtnFU37GWwopwV08ufxlq4Uz4pnt59NSr1XH99GAZlL5y2?=
 =?us-ascii?Q?5gLwkV7KPo5JbQcUHXksoOr4nvHSNj8Mn+y8JSY8y388StOW+hdeHgm7chB6?=
 =?us-ascii?Q?iCMqUF5q+66D7scaZGpw5ggMKqjFc6m6T1zZXnHrSCH4AAb8doMXZRJxxVLA?=
 =?us-ascii?Q?gvoi77/viWQf4BcMTX1BR26jReJMtSMYewTOpLsxyJ0+UM4Q7oy9s+1svwA/?=
 =?us-ascii?Q?4pTE9g0F7ukUMsrYihY3LMlTw0+lkz6OD1BzbEGowAX12mmVBg+dsXrOqktN?=
 =?us-ascii?Q?BFNsaw2eD/U/ZPXjeh28MFXRhH0y+KUKvtnLMIK0pT4DLr8qyAQiH5ubpM6f?=
 =?us-ascii?Q?2MEt9KcvB3083zUFgY2VgFBjaMks6A7SB6N0ruBjB890MxLH1tDZuWNRlFsj?=
 =?us-ascii?Q?R6ioLKI/rvZcofqd5O37HzMC7r5Nn1mQO6L7VR1Au18FvbypaLKd5oiyVahX?=
 =?us-ascii?Q?17kXQ5u9rnIuaWVfKNboSGpoR1B4w0/FJx8l06lXwy7Jifrk64txkMCWHHPo?=
 =?us-ascii?Q?rHUUtkCLYpw4LX4+iiON54fovy/RWL90QrzFvg7t7U1G4YQ4CCdaj3a3xwsj?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2995374-e2dc-4657-455d-08db142dab3d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 17:04:18.3778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiidcXplYheyO+0lanmrDl1KQ6Hw7bdMnYOO5DP/6qHztoYKUJia2DnduL2grtBlwNqyM0we32mLvTM3++NzCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8039
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
Changes since v4
- use GENMASK;
- s/ioread32/readl;
- s/iowrite32/writel;
- use for loop with writel instead of __iowrite32_copy;
- update multi-line comment format.

Changes since v3
- remove Reported-by

Changes since v2
- fix warning "cast from pointer to integer of different size"
reported by kernel test robot.

Changes since v1
- added missing check for cases when the memory slot is bigger than the file size;
- added a custom memset function
- removed is_iomem flag since is not used here
- updated custom memcpy function to avoid reading after end of source
---
 drivers/remoteproc/imx_dsp_rproc.c | 187 ++++++++++++++++++++++++++++-
 1 file changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 81d3a01e1444..dcbb957bc7ac 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -739,6 +739,191 @@ static void imx_dsp_rproc_kick(struct rproc *rproc, int vqid)
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
+	const u32 *source = src;
+	u32 affected_mask;
+	u32 *dst = dest;
+	int i, q, r;
+	u32 tmp;
+
+	/* destination must be 32bit aligned */
+	if (!IS_ALIGNED((uintptr_t)dest, 4))
+		return -EINVAL;
+
+	q = size / 4;
+	r = size % 4;
+
+	/* copy data in units of 32 bits at a time */
+	for (i = 0; i < q; i++)
+		writel(source[i], &dst[i]);
+
+	if (r) {
+		affected_mask = GENMASK(8 * r, 0);
+
+		/*
+		 * first read the 32bit data of dest, then change affected
+		 * bytes, and write back to dest.
+		 * For unaffected bytes, it should not be changed
+		 */
+		tmp = readl(dest + q * 4);
+		tmp &= ~affected_mask;
+
+		/* avoid reading after end of source */
+		for (i = 0; i < r; i++)
+			tmp |= (src_byte[q * 4 + i] << (8 * i));
+
+		writel(tmp, dest + q * 4);
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
+	u32 tmp_val = value;
+	u32 *tmp_dst = addr;
+	u32 affected_mask;
+	int q, r;
+	u32 tmp;
+
+	/* destination must be 32bit aligned */
+	if (!IS_ALIGNED((uintptr_t)addr, 4))
+		return -EINVAL;
+
+	tmp_val |= tmp_val << 8;
+	tmp_val |= tmp_val << 16;
+
+	q = size / 4;
+	r = size % 4;
+
+	while (q--)
+		writel(tmp_val, tmp_dst++);
+
+	if (r) {
+		affected_mask = GENMASK(8 * r, 0);
+
+		/*
+		 * first read the 32bit data of addr, then change affected
+		 * bytes, and write back to addr.
+		 * For unaffected bytes, it should not be changed
+		 */
+		tmp = readl(tmp_dst);
+		tmp &= ~affected_mask;
+
+		tmp |= (tmp_val & affected_mask);
+		writel(tmp, tmp_dst);
+	}
+
+	return 0;
+}
+
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
@@ -753,7 +938,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
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

