Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FF168C0FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjBFPIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjBFPIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:08:30 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F4626CEF;
        Mon,  6 Feb 2023 07:08:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBVE+z6j2GVVIM1XfHNVkLIv8LTj5nX5IGmgpPci0NQf/nYGwHlcETPrVw/ZiX6zxcpVMf0DY/7DL6IJeQZQsB6Yihpwyb9hIn1qqr61qm/9o2ketEBEM4mbcgRNtzmDgDIE5rrkJYVnuP5/i/KuxG+xy29bsr+/8bOOnj0N4I/AEeQ3flsSSY6FJglQaBCOChTL8MDKWWEBdzubMYQECO3JgW9Xjwq9qnBlu6dwC/RDlnLoLvr5D0/VZvordRu2n42yNS+RfcaAXorIrhOX53yiMhI+9RXGk9EPzziMovi7/yZToPU7PrjRjH2d1g7+2pJj6sKZsHiv4YE/aPP/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6A5jtiwW00+m5AlKZuxgN5ohGZUhtccf95nOTxtKPY=;
 b=MML2XDxcAEizqf3qSv7ZsaM3XKdrdd5VnXG33NeNulY6blsG+invknI81Rga2wtyulT/p+CYXzDyjuqldfIU6bD7RF3IbQY40CeV6fJ2Ag9XUibiMDgHL2DapDSPBkLALdB1cccJ34+XIfMkhkPywH+GN6Yd59br+5aQg9k62YAkiXfzfS1ivE7OyiUIFDOsqVJbHRFOlOGCgbmPssSkOhB56mkKDF3T/Fqb4XcWdiZ8BhG4pYZVVBP3KbBjV4Zh+ZqPcUClRMYLot7VFk7CLqyMm2ELDYhvnLR56c1b0g9AItiUg6XlkZgiF29E9KnsATczgbb4+YOFhTnj5nkx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6A5jtiwW00+m5AlKZuxgN5ohGZUhtccf95nOTxtKPY=;
 b=MAxVdGPH3yRDMXy903ZnmK0yux5DJiqTkhRbVTYCo8wsQI9ysTxtstqSlcDnQYnnpO6GgQrpebq+peoNgsmFv2UIQZ3q/aLaSzUI/XBqPD2TrAjoCMAEin3FzI9Ia8vGrvGV8OQSkfRzzgvIrzB07Veovp5bmv0abyZis/Qs9Z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by AM0PR04MB6882.eurprd04.prod.outlook.com (2603:10a6:208:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 15:08:12 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%5]) with mapi id 15.20.6043.038; Mon, 6 Feb 2023
 15:08:11 +0000
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
Subject: [PATCH v3] remoteproc: imx_dsp_rproc: add custom memory copy implementation for i.MX DSP Cores
Date:   Mon,  6 Feb 2023 17:07:51 +0200
Message-Id: <20230206150751.28618-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0055.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::16) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|AM0PR04MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d344987-771e-4f39-8009-08db0853f68e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BU3mH1VrlfGNL0Hk7oOw9fAKQ4n/XA6U0/XU6Jp68KMsJ4aCF7sW2FCOP45qzWzhyPo8C8DDCVe6pi6/qZphdQs8oqeHc0fjjFjGpf2AJZ+uMa3auZ8Hq8LBO0cALYiKQL2Ysv+u2j8khdaKIXc2Zu8PJM5N55F2gEfYRYAkKnRifsGgOulefmKCD26zYt53zmsb96YIS2EIwmI+cb8xk0WrlibZQo96vvKRpHSPkmcda2QUzqlYBS3DwbBJDnCIULtGrrnhFFPiagGpxCeR4vKFo0YYs0oMtrvgd8EGh7dAG4jS2X3QU756uf42JhMCJmgxRA7oo1kuuzBuS+DAKf1AgAPBfpE9bRtdCXPrphunMc9aPT5RJm4iRgVn/9xLJaobnzG2hIj3XDjgNPIJ0kK2VdqSprqKSY7vgfXM4wb36rs2aT/8F9nrYpzCAxbD61tVhxmEwS5nXNN9sziBUQ+yomu9RPwtE37jnrPUBau9/azxIIxNCZIytnttxl6A2xPGalWQHPe0DfZQBEkagPmClelHUNN0aGsPBgySKTj4MfuAeS3NYO4ln0UvZcmapp/Jv5hM8DStVp/7YY03CNfWX68Qsb7lBfIBFAERg2z1aUVzua4DVZrrGUgOgenMas9nvgbR/pcyA2bIhrqfPeMSp0kaKXdvgP0JQufo7mQJy9cymz2iEEiQ27sGeeS1eTkqz9ncqADzl6/mY5tXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199018)(6506007)(2906002)(83380400001)(86362001)(5660300002)(52116002)(110136005)(2616005)(66556008)(38350700002)(54906003)(66946007)(8676002)(38100700002)(8936002)(66476007)(316002)(6666004)(4326008)(41300700001)(26005)(1076003)(6512007)(186003)(6486002)(478600001)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R/u9P8cZXY1n40xJoLVd5tYxrqcn25gMlGpbXOEgO3FmSm94fawvPuuvR+kA?=
 =?us-ascii?Q?mXFwJXfayYxbSkkj/2LHAPS2WIY2fej5kxdGvvTHVedTOEqcVdCrJvYsg+mK?=
 =?us-ascii?Q?iQBWtTNdYyjxhCqTarAGoVFN/r3BEzUhmBxW1OFV5szHPvWpyug9RsZHgBxl?=
 =?us-ascii?Q?z3PUGv+b7QYbWBf7ZUNBUyso6NnSZIUPPdQ0Pw2qSJhTgw99pkbU8kn8qQv8?=
 =?us-ascii?Q?WbgnQ2V7Sz+iqbM438jxf0COcjnFDLbv5XUnEeffH+a6BIg+7vtS/3kBjPZ8?=
 =?us-ascii?Q?cV8F/7gyT33ffR55gaKLVjwv3vwKnfhkhoKj3cHGm/YNkCFbIVzO8kdaAXEf?=
 =?us-ascii?Q?l52HvEnF5zTlnk0OchzCEradxUFTy/95TTR14Pd0C6BYwxyQhFO9osu4UIFH?=
 =?us-ascii?Q?SpaB9+Wp62JVaaixcsvSfuvAwWgJohhr5udnKrM0XEVd+NZsbgB1HAG6Pyrq?=
 =?us-ascii?Q?FZ+zhRPLOgZkYbFq8mQlY1547aurgpFRSvOO99umP3gdQ7q0cSiuGnq0mry+?=
 =?us-ascii?Q?1A7KJ7nOuqSCc4BJgL5absV6xux7hmo8lTIYRqHIMY/KchnFYIfGhu0Uiiu/?=
 =?us-ascii?Q?O7HkT0pMcDP5AgIiPcybVhbK2w7c829XiMGZUg/660fab2+QGiI00lOiU6dm?=
 =?us-ascii?Q?IsotVEnx8h+Ibql1+5WUoOV9PQVIByhrK85UwkZDic/YK4jiv+wZ5NbmGXb5?=
 =?us-ascii?Q?7v6NkxO0piMvjyBXGBv5NIgNH99KIm4dZ0d5Js0nxiHDDwsNDfL7KcfoJBci?=
 =?us-ascii?Q?+pX7GGFgKoSdKXy/W5O1Wg0v/ySU3O7V8dv8Ow1z4zyygE3DTJ0649DKbjLf?=
 =?us-ascii?Q?KtlPFQAon9l2raI0X3ZbbvgBc/QEvTJ3piZ4SnG0zX0hCPWZZW8sB16HRrpA?=
 =?us-ascii?Q?IhoJpjTKQ3EAPb3JpiixroIuq2B8rgBRFQzAJSAmQ1cyVkb8HD+yfNsBhSJq?=
 =?us-ascii?Q?fIygP2voDwryyjJpGAcXJx6kNMvRrxIpPRzpmf6npRAQ5UU61T4qODFaaqOb?=
 =?us-ascii?Q?GMV1SQbMh9SAvIWUkXS7Myv2NmpdD6GwCjPg3Cnlh2zrmkKNbxdl/9/cPYHI?=
 =?us-ascii?Q?tJ0YVQNAL86GqCi3HS7wpVIb7/KbW8x+Krcyeoji30CD8tdV6fob/wpBKgXt?=
 =?us-ascii?Q?zLNuCtn1kbr1boangRGdzyUF+Cz3Fg5fiwgWZ5KtHeNrBfAsjVuvKMCCXgNY?=
 =?us-ascii?Q?JNWUHGXuTV/9k1tDLijxv/funPsJkamamBVpUrYd041J1JSrp5ex+UNz89w2?=
 =?us-ascii?Q?V8fN7hFFD0wpBEW9mHdhqUHR34pr8yAflzkIgHhrrCY05jspfGrD4XNgcwjo?=
 =?us-ascii?Q?owqUy0b3rB1B437U6xeHShl8MVZ2NAlAnEG0n115XmbNemnfo8QqNxifMECr?=
 =?us-ascii?Q?aBu7SJShuWHxHo3M/cyDvv7aEi6oXLObWEbno0MNXg6SJzNBmY1x0oTobQWU?=
 =?us-ascii?Q?tvIE5FGS0dhy7c0ZKT/HKWBUEIQRR+U4BU8lfyNG/33+H0+yG/ZOrX4/dnVf?=
 =?us-ascii?Q?NaaexonpFmqwlyH5XQPYIK1MRjhym7W2vzld3bC8pzZK7rbk95F39vmtfnff?=
 =?us-ascii?Q?xly8ISYIuX99HP+kSIvqEpUAC/uHGW8k92i7JeRoapBgpUjaUN2+QYQyMeIe?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d344987-771e-4f39-8009-08db0853f68e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 15:08:11.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gj0UJhnVSIIXYDBub3rvPCzmDSlnZhWQS4uN3O6YAY6hGqVcVat+tYvCz6kD5UZ2LoxcXS5veT3KwA18pekimQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6882
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
Reported-by: kernel test robot <lkp@intel.com>

---

Changes since v2
- fix warning "cast from pointer to integer of different size"
reported by kernel test robot.

Changes since v1
- added missing check for cases when the memory slot is bigger than the file size;
- added a custom memset function
- removed is_iomem flag since is not used here
- updated custom memcpy function to avoid reading after end of source

---
 drivers/remoteproc/imx_dsp_rproc.c | 181 ++++++++++++++++++++++++++++-
 1 file changed, 180 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 2d9f4214a4c51..6a7cef1329329 100644
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
+	if (!IS_ALIGNED((uintptr_t)dest, 4))
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

