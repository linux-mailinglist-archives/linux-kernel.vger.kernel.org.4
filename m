Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5363B67B086
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjAYLBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjAYLBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:01:39 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11033B3D6;
        Wed, 25 Jan 2023 03:01:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7lAwjn/yZ8vk9HOY/Ea5nMauUn/wmpTXiNXB5pUTokr4DQyFVcabcoUwnohbTn1DQqLd1eiTBTVzZqJKUwMLM3hKsCh+mxNwiBKqhrlApEETCEnPhubfmRuTJ2TA280ZU9tI1dAghVRrYs8rk+Y/jlI2bT00ohLyvU5XQG9GUbST7PAaYGaEyUR01VV6jRFKbh3L4R1wIbQ23fJ50ks57FF0nWMkFDKC2SRmtByMcM/UuLJ3vOn/f6R+x68vsWT6FCIUVXVMk+3RA6DKq2OVDGGCUwg4Ki0UsWqrJXnYeyUKR0ENYhjsb+YRZGn+K/S2WnOA91KE8Oz5nM8Vo24vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hE3sHsyVhX4kIixaNS45pqPOgRnTmu8/3c/yb5S+1Xo=;
 b=h7FzvRTGqU6gtWTtQ53cOgYwB1uCG752u4ENC9ZKZE/bCDizfQKV63TZ5xVu3DyjR1cGy6OOC3O6Z0Vrw57asIBK4orSVnkEog4MJkOr2J1LtNM+CUM6C9j0iBB/imza8oVoMcWtCuq0oDBvxl2+jV4qyzEFThyra+MA5EYrPM9itVEA1XWZwl6hVmbUu9PNbBgI8Nq+d4xU3m4YAwtDD/1537hn5e/EnA3TrKHOl2oGUxIAJ7a9+iVNbIBwqahxdOOJP3eKk59+ChkVpRrofwdynYDLmKh7i8WFF6jgOzhqG6FoAzDgOQdAsvZB61frbCOBSZ2Jjy4R+WA15ilDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE3sHsyVhX4kIixaNS45pqPOgRnTmu8/3c/yb5S+1Xo=;
 b=DQ8WRRqpuMZQQ0h1aCmRUwwDFBzRLqg0BrGhu/OrrW3kDBehI9ED0Zr8MrI0/UkOg+jsAV+voQ+OALy3T/tuGMgU3M1CmOPR1eN3OCiG0FmTxoHgUw0vHvyUTdSam7BMIcd8rXWDzXFdRUTIEY5+nj7O2FBr/M152lghexR/Cs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by PA4PR04MB7582.eurprd04.prod.outlook.com (2603:10a6:102:f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 11:01:32 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%4]) with mapi id 15.20.6002.028; Wed, 25 Jan 2023
 11:01:32 +0000
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
Subject: [PATCH] remoteproc: imx_dsp_rproc: add custom memory copy implementation for i.MX DSP Cores
Date:   Wed, 25 Jan 2023 13:01:00 +0200
Message-Id: <20230125110100.14647-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0200.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::7) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|PA4PR04MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b67701-ca38-496c-3784-08dafec384b0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPdw2GJ0PIScieM/usQZ0FopDX18lovhZK6nm813VCDPXRMMRbGwntFIs2GR4dD1eAEMgYq6c6yLyhUQI8fdyxy8JeVlc8g5Z+aak7OZ1XRENQv8KZJH81uL4nUJ+2TmUN73Ig6BbCPicnH4wQs7JEhrwLxKE08xiq+4jFJ20DSnuAHBMIhjoU8xTmEAAOQBaq7yJGnI4AAAHHtu/Q3y20IKiRuc3GWzCYn0dbpRXLbfdXMd43Mf7lJGfPS9D25CQ6k/Le/iJlF3fP9rXH4A9dBHtV9JchJgsu+8yxbCi4asMxngIISoCUHwyb9eLobaexYJviscHrCedjAKWGPO8EEFvM9MihvOmd4A+99W+3bqtCN8KkgdZGyaWLO2wyoYtNMkNzSf2YSP7u2CY/m3X8Gvfoc8pOtt7QRgwKd1n2pCsLpweer8uaoD9a2cx4ervqCfavcRUyJqpFL4B5oKaMfRKrQHitz3ZqzkpSXOmNYYBB2ZCJkrSYLnafzb7Nw0bumRilix3/XYyP4tet4tfgcu9CrqrRWmqULgw28VikXK+wry3ANsC5DZpwv4u9gmUsgVY8rpaDmmfX1kUIPmltDkFxZnCYF9JnG4dAyhg/pO7tSAiIWL33WAe7cue/rgqkGGh76hI5Ib4Zr377P3aFiBRIoVPxpy0QG0n/fp759Q/CBPcFpP/YyCG2yFxja/rAo0NctJ2aK3F3onxQ6WXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199018)(83380400001)(38100700002)(38350700002)(54906003)(66556008)(2616005)(478600001)(8676002)(186003)(66476007)(6486002)(1076003)(110136005)(66946007)(52116002)(2906002)(86362001)(41300700001)(26005)(5660300002)(316002)(6506007)(6666004)(6512007)(4326008)(8936002)(921005)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kUxoQRCZnPz3meEMhD+ZSdAut8ED5YE0lLRMMAg0kqaSHmaBislYglVzn9Vy?=
 =?us-ascii?Q?pKUhTJT9tR7uf3hdLFWzBB8yJQDynda/leYVs9rkiUpPcPces2spWiqMgBrX?=
 =?us-ascii?Q?Vpts7s0GLzjX4O2GQ7z0GpdBc7/LMjRoYF97mTWm7Kg1JQZgLuCVzEpao3DK?=
 =?us-ascii?Q?OAkywE0aitGLCBHbT5ktadLcu1pLrLfVT3f0YY5VbnS0+qK/dIbwZZ+Dm2aH?=
 =?us-ascii?Q?Hytw5fj5xmk2uccQuTZmnepNGMgXLXz9FhrbBMYvvobdUZQIOoN0uyxuwMe/?=
 =?us-ascii?Q?L3mLg6El7iOywmdJAW0hjtI+MVY3DPtqt/1Y7rQpJM6KQZt1WDiiLYOlmIWf?=
 =?us-ascii?Q?bQx+Yhz826JLQXl0dZvZoQzhZ58o14LKswhujV6hsaNyMRnNAcYiIRwhBmhP?=
 =?us-ascii?Q?KN/dafwtJ/mff33eh/OMSWHHIRrMmxurthejrA2X3lehBGREBSgAF6rUNJCs?=
 =?us-ascii?Q?dxcvK4B2N+7mzVNHDaN2yXidHVY5VsZLYV6m0LrMT048klrE8U2VzpE6v1jO?=
 =?us-ascii?Q?WO+XueiGL/oOeeGfVnqO6gvS+YPpHpHePpVX4FNEhFR7M9kkVIKIcskZ0ko9?=
 =?us-ascii?Q?6k65hKthBYUDNeHxOgMhxm0AAAq9QHpM9N1UbJr+KwDs1UHQijih35rfaB5m?=
 =?us-ascii?Q?Tr0EVkXq2U98U7S1xdp+xPJU4zNou6gdWyVO9Xr6K2FSa2Nz4FOP/8Z2XQn2?=
 =?us-ascii?Q?68Ij5MZBw4NuzQZqL6mrO3jj2+EYLqo3BUAsVrr6SX+LOoewswckmzJrSOl8?=
 =?us-ascii?Q?w2Gqfuc2vdkHXJXCQdJMHE0/5gUHd4ADivr17WQ6cOxkD58c8EACVvQ49Z5Y?=
 =?us-ascii?Q?QVxC3pnoa1wmdNw2nljtaAFBZBxlRGmvcn1a7EEGiLwPQFaQO2dbyedE933Q?=
 =?us-ascii?Q?/ZeRdkRs2raBym2iTequYlGbmUO0NC7pOcNyFmBEvihwHu4O6FuKKTcsIQEW?=
 =?us-ascii?Q?iOy0IpW/jw1RBrJSmfb7tm8DKRp7ridaeXNRsu/HpUPRW/9gL6+xMCBT5tJZ?=
 =?us-ascii?Q?cfRutbpc3UePTxLJwKMcZsdVue5/VyZHwm3Hll/+NqE220mBEx9OMu5ghRXT?=
 =?us-ascii?Q?+8j+BKd0y+46GiCztMsivMnY+NKbYZU5E3+tOK7uAhWYdlilrPip+iBTNHvs?=
 =?us-ascii?Q?hL0YREjHSzevKZjYFUop+PKayIiPPqXd5x7XYHknDVhkcYmjoGVKw6XZH2Lu?=
 =?us-ascii?Q?PyFU30H+4XY06SLRntOBndfKrAveTeMvCXWyBP4fNffPInOZo5qnvavqU/Bb?=
 =?us-ascii?Q?VW2mZBlZ1SfHcqzZ0fgjyRcEzD2qCeZk/cVP7CpxjzZngFS3zvF2XSNy23hh?=
 =?us-ascii?Q?2AJhhyCfS7PvIuzZrzjbOV2fPhwn8BEWjxd1XxIOu+9SPtmNn3VufB7xalUN?=
 =?us-ascii?Q?1vPSPszvz4taMZRDnZfygZBovVIe5esQbRSAXsRG4eW1+ly/2MguXi941keO?=
 =?us-ascii?Q?R+7lUBmg9uqMvZXjg4JB+ubCQ2TO/i5V5W5blWR4tep6C/oTc7z2Y1YH0gGU?=
 =?us-ascii?Q?nJupLtHLJTAi+O2+qkfp4koc38eMYzuCsSwn/xu8ZFLfKMk+mNOK0c/RCwp8?=
 =?us-ascii?Q?qOWemn9Frvw3SOi+7lZdgV9T2AeUAAbK8gWBodoKFZiYAricUyNoTP9tf9UZ?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b67701-ca38-496c-3784-08dafec384b0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 11:01:32.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APpLmSETBM9H9Yl7WvW6XFv0b/tV0gya+8difbRBT03E41Oa6bq0HBrnQE5MaZlVDC6n0vwViSlBfIKcCsUlSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7582
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

Therefore add a custom memory copy function to deal with the
above restriction.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/remoteproc/imx_dsp_rproc.c | 122 ++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 95da1cbefacf..a9991d085494 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -715,6 +715,126 @@ static void imx_dsp_rproc_kick(struct rproc *rproc, int vqid)
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
+	int q, r;
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
+		tmp |= *(u32 *)(src_byte + q * 4) & affected_mask;
+		iowrite32(tmp, dest + q * 4);
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
+		bool is_iomem = false;
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
+		ptr = rproc_da_to_va(rproc, da, memsz, &is_iomem);
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
+	}
+
+	return ret;
+}
+
 static int imx_dsp_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 {
 	if (rproc_elf_load_rsc_table(rproc, fw))
@@ -729,7 +849,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
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

