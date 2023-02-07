Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C7268D99A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjBGNoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjBGNo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:44:28 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA39F12870;
        Tue,  7 Feb 2023 05:44:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrkDgTDUdmCh304CIwZ3Xm8vZMZRkkW/8MKysZYQxjBKLRrjOPCXQ4x6JXdFhy6kd0vJIjecKomAxgZvw3Gb0c0rs2QbOH8vJOX9UE4BeRF7lVdBj5vctN0PglvClejTf8+FUoobQMRM+bmC2Ayy4yPSNZcB1XMoyi8vXjTKASuGoLvWIg6I9LOx5PrhxI3lJuxy+X4bFyZ4RSw7CKsmjmWYH1haBl5L3+j8vS3perINGbsl41tdyNCc8AvuJaOmoEhqKdKTLm0ud58qyQNp5tb2fFvG51HCeGR0lFgyBoAwYhCCHtkwZ9e/HR3+DLio8IMFYxY2hPN+6T0PKEVXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xl6zVvQnLspJUwMB84Sf2NnPShkhNJDYIHsGEx2g7S0=;
 b=QKyOHrgzlOLYGEsJ6BkAsrHIQ+BIlztlQuaJj5ij2yiMy36djYQhsrCORcWi+y0XvS6k0RDn4ctA3xOC3ifyOMZviqkbXjavwCnwM3MazqYdzcxePfe2WnsqOyVK97DOKmw6EA/TkoSzdWJyAzn5lGolpd/9cEsEZ07uKihNKrIkhRmEgaAjdTbF8LW2n4yi6WLQ2RvnLTox0HwA24oK5kdAA0nWz9EtPoqjFjzGairl+oN5MUrNrV/Xz8L6/Zh103EqoYmgnf4Fyma3iRg1dhfAFcy7WiCr70Uc13aMh0GlNzay3a4GX9huDnRNM6iaMSQtlus4a4VDAszNIoHptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xl6zVvQnLspJUwMB84Sf2NnPShkhNJDYIHsGEx2g7S0=;
 b=Cc8n3OctmLZlPV9utq0/dTs+wCJFxSsZrNwieNOY06JzR+XlJqbA7owR2rl1E+t0f74fOm2aVJ17bTBgBqGxHJ0YkseW9yFiGzt7HVd3aeZtKL0HsUhuMYbYgcRQgbuD3yCjJjOpV2e+ArZo+ecL7eGT3oZVA75miX8E8vXvKsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by AM0PR04MB7074.eurprd04.prod.outlook.com (2603:10a6:208:196::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Tue, 7 Feb
 2023 13:44:23 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%5]) with mapi id 15.20.6043.038; Tue, 7 Feb 2023
 13:44:23 +0000
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
Subject: [PATCH v4] remoteproc: imx_dsp_rproc: add custom memory copy implementation for i.MX DSP Cores
Date:   Tue,  7 Feb 2023 15:44:01 +0200
Message-Id: <20230207134401.26724-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0022.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::35) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|AM0PR04MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 8696a40c-5c60-4975-00ca-08db09116bf9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUpsoeS+VESWzXeWiW2pcdBBmP6nt+wJxBXYFbomKd75Ye9WxcNp/P3M4wn0VumWj4QdxkrUsHX+3UCpdemLGDtU1bbGQjRI1k4E30bAu2wSvT4WnzKmCW7wO1X2gOFJNTJtvlWom84PxBht3B9wQ7HG5hU/lEO2VH+kr254Ohlyxlpd+8ix/b9gs8RzOZm2BwykUhEdLPlpg5jLmmgQdv3QaNJO/sTocluV2pAsAGWgXZ3HoDMWEFvW7ENASCUleMONFI6dHYWCqRdIdrwgP+xK/eL3YHA5/xXhMqRe6WhfxzwRS/vpdSDLL8GGFcBvHlT0vAbRnwyYS8vHSO5jLwG/JdWaEapDnxq5L29ENzFMwlYbuECcxCpUpcAQz4VJbE9GPBmGx9QRLiEATLhQkk5IZtp3nfG8JExuqk6QYcZ6hfXZct0Xf4R132LjrsT7FPgZJMMsRVqWwF0k43UmVFOQoZ6if8WtmNelChCKAvsPs+p0K6wBfgXBoItaTn0jQxWOghB7lMVHDHC1INvpyw3MwP7nlfs5SC234QhV/2ERSP63nKuF6/ac9yUXLkBDdFJDuSLZJ4k4v0kM3hHL3leorEXP2NfJ8GtGBAzdMFbOw4qtvE0/qcMIjAJ8AqgN2hr1NCJmQ4knxvdKbDk85m+LvJVFXt62e852wpv/RqixpCLV40YWjNfps6ECvtVHDeLYK5X3Z+1/mn2Gsz1snQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199018)(2906002)(54906003)(5660300002)(110136005)(66476007)(2616005)(38350700002)(38100700002)(1076003)(4326008)(6666004)(66556008)(86362001)(66946007)(6506007)(8676002)(26005)(8936002)(186003)(6512007)(6486002)(52116002)(478600001)(66899018)(83380400001)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C86PcvgkdBCqUkRpQ5+Aw9ZKyNhobAKlYm0BomwX6H0DO6MGcjQYlFnSEyFy?=
 =?us-ascii?Q?uwvnxzwfw2rI7KRgzW7g1L401h9CxpucAXRbXwM7egZzDhqJA17h5U8aLzIa?=
 =?us-ascii?Q?ETFM4AHzIZIUIWKStQZhnylhi0zTplvYPHtYtu08/aaPF9EoJqnousoG8pvS?=
 =?us-ascii?Q?x11FKq0VR/GuFIYWItFion/XwL3eamXBg/MqnHLX2Wfpf22IxbpeuF9O+k+p?=
 =?us-ascii?Q?fBchVi6hhQUGQGpx+PR8a6S32wTva8Vr5sGWaeIHkaKNBcJcXW0z8h7iDXp5?=
 =?us-ascii?Q?oy7BoWy9r9d7mAx3I37RNtGjG79DK9LtCYte+PwsTa0JCVKcSUSwbFaF1Ybs?=
 =?us-ascii?Q?cuDyVBd0ya3q3rxlhZOdnClZ4xR5gApQZJagx22UXls/594MyW5DnfCmJvR5?=
 =?us-ascii?Q?RKaQztZRSZJYzzKXCLwZEJbxQLwEtaFbJhuhbLn8RllEVxICul+6sEbSUdIo?=
 =?us-ascii?Q?PDSXtUA+vKzZapZRyq/v0FUPs/J/GKOPT8JIp9iq28g+7Qu/IbWSDwza5wmy?=
 =?us-ascii?Q?jhpkjGiJnxBuFnb9Zgz8D6abHGyXa54Xrd+CwE+KSz+TypQfvh7pBR7v13zX?=
 =?us-ascii?Q?Ej80Rw39e0DoU34s2GoO7UDPhroblTLm2w+4kHWxcYfZvn4MeHhhEVGL1bQN?=
 =?us-ascii?Q?3bZc2yf3b1tlzKAgZ+EOX1Pugjza7L2X3SMXRNjM0X2zToVOM17FTYFP2Fro?=
 =?us-ascii?Q?h4ceowH0KfUStPEj1JWzXx7f9hr2lljTHQ9BnYBEUNWWzQqtnUjOPAL/Qkrh?=
 =?us-ascii?Q?wcb65EzDtbuqqZOowrYajjr5wHj2PpkU3SWFXeKz+OJrDLj7pfH8GhIJaFip?=
 =?us-ascii?Q?4pV5aW5otGHsJ3l2MMsZLwBg5ljUXZ7T6gTmYkja2qPVwJSumQ4hEQri2/3+?=
 =?us-ascii?Q?EPutX8t/BM6lYrTpcVl8T1cfTwiBASvzBmD8D8fWgWbSkk25fyob5XkHowMt?=
 =?us-ascii?Q?9NrlJzQ/UQXHUbkP8pqQs/y+ZSMlzolM9CLz19HH/tZFZ8T1DdM36tIGk/XZ?=
 =?us-ascii?Q?rK/BmWCh7K0g9iDMDBBnJkxzfqHs+sm0Q9njplAZdSmgWkkYK8WNoQJN+atw?=
 =?us-ascii?Q?Cnc5orMZmUt7EmmbjvqgcIJGA3xA5eWUIdEnSHhmrvNt97JFmpomKQXTvIab?=
 =?us-ascii?Q?ab79ha7AGQTEFApn6aj/6zJ1eXEdPM18hk/T5GWMrXYvtl5CSC6WRKjJzqpl?=
 =?us-ascii?Q?QVw+lAuFwFfpwyS2bcluVRZyvxDwo3vwvPvfFLuNR94+iDkwDV9MshbxOqIE?=
 =?us-ascii?Q?3Iq3veVoCfAMz4/DImOHMmMd8LanHsRal1dBKKlh9jOxdbngnEkZg/1JKNkD?=
 =?us-ascii?Q?7km7DQdDroDs/HJxWiBNWbSYv5qe8KQLOoEGn+926/hdrmiRdpiOUflXfzp3?=
 =?us-ascii?Q?ySy3oXF+KTv/qrn3Kegm6xb2jN+kazzmQxMD/KGP/alqzo2Ep3nZhz4wxRfM?=
 =?us-ascii?Q?a2cgthPNdIs9/N3rdgSCc948JJEtpU3Jovy/8fZpRDGW6sbNUtpbVDe35OAN?=
 =?us-ascii?Q?BVZMtTlShTGpb99q5CXQw0iybM/dz4Q9DCrn5A/S46fHTgz7jZCsOJio8VCX?=
 =?us-ascii?Q?d7mGPj2P8GP+4KRjxbdsx2/dPWuxOOeM0GDMAbV0hyrOnrnIOlLXjRf1X36g?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8696a40c-5c60-4975-00ca-08db09116bf9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 13:44:23.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+QV7iJWodb5YNRPcZqAXP1LFI7uqMjL4b4DCMRgvP4Z6Vc0PEmwzICsY5QyEGcjdCf/k2vYg2cKmURu+kCjag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7074
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

