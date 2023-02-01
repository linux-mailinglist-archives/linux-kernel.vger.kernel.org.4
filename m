Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE356685F71
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjBAGEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjBAGER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:04:17 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132355C0DB;
        Tue, 31 Jan 2023 22:04:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g57+Dh02rMueuanUDisUQLpuaEaM0xEM/bXvHHJ9MDiHxiBt8AW/3Zdh1XL7obNxULXVgEvJLL45h5Lb8ForgzchA0oVAVnr3YnGJ5VBx+am+b63AuiI7o7Ac07rK7IYrS5Y9j96VpBSX8RByhJG1YvnbLdDYUUM7/r8XCtAGRKKxjWqltcP6vrgssBu/FT/K6ME/TMUtVJJITXNV+eijVg/xlBkCnh8K7lJouw2C0pSEXXSrYABXN17IwtPe/geJFYs8wNa44XtvLOj53QjkjwMt+y5HsscpsjeyIlx7FnvE7AjxEa4YOttvhONynZr+5lro3bQetoRB0zGdsvhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWE2v7gcmTZgAjF135o2R8bWHo+YHguXRwe76ddTpZg=;
 b=Rp9fD2lxKZk/OyzO9ICbgNmLszxnSeIze7AxAGR3a9EA/XJPguAh4a/599hPSW0N5Rnek0Luoz/BoAkQ7oQwwboCEHvuQjYxiNrwhdtw3LpqIbGdpLmtn5d6JM0YX20u/4Dhy/V4ytq2rpRoD7Yq7hFoZtdTiDK/Y4WZlI62+uCS9aLMqIyYeOlmb/LyF8CvoryONjaOBpd6095v0uNrbQcDwk450Ht9K2DiE0ltNGd0E8qthQ07pVLCQUeKSU3DaGN18H0g7Q4rVrQp7KFPC2gk8bA8Zxn+NbJq9DnyaYdCdfQ6q8AanvBH0tI+eN0eGTx4XSvGSaZda/K+/wwO7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWE2v7gcmTZgAjF135o2R8bWHo+YHguXRwe76ddTpZg=;
 b=YdNZT6Abe9j5eY0+RBFBjSOZIr3lMz9qNBdMKki9NQUyfCzB2uH55jORdtDUG7y58yNrNdXa8MIhvryf5ceFrRy5cbi87v2EnNVqHX3RkWcd2fCsezjV1+Gq20aO3JtCsu5P6mrLCdm7Mxepbv0tUEdkoQSIl+/6qO78BhvBvUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 06:03:49 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 06:03:49 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 08/10] media: imx-jpeg: Clear slot next desc ptr if config error
Date:   Wed,  1 Feb 2023 14:02:30 +0800
Message-Id: <fc13259ec56aef6da1e1158a4327b0b677128590.1675230665.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1675230665.git.ming.qian@nxp.com>
References: <cover.1675230665.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB9PR04MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2bbf4f-dbf7-4ce6-cff0-08db041a1640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWDpJdKg9FVp8yqEk4qW22BXhEx/MqLgtpnvqm2328sl1gxPYp5WOHAsaQ7ESBCXUrIp4wY2gVuwiP6GD3hUOqnpy7jbeVqBzzP+3d063PTUS8Y/9MAmXXEpsIc2p/HP+G6b53CboysP6Ne2eTf7uPFIHen/orjlp+jspjFg0G8VrbSJ0855gmxn/hN3V2iZYpNCILEz8P1mrYL8UEUM8zp5GEi1aoblWtMr/ALvgcS7o0wKyCka89kZuVFBGdLYtX0FoqpkHSuHNrjM5IXh82V/wQLZLlHQ7rj/aXoDO8GKG2AghHWI9xerAah1jq/O6Egrf1XF00bR5tLR0hiyEullfUN37m4J4JE+7N7l5ENLo0qjTx6xcAXvBP94tnUU4JPGNP1j7N4VVjp2bIFYiZzTr6VnPeIARoBUSjyrmwBur2vQJyNn4UyarDOmG6T5IEdfeaPSWtgkjPV+lV+cIpyNv7GWQ/b0y3oLiQE4mVxnnq56Gbwa9fJ0giv9s8Y49osKqHAG91aDT9aWK+fA35TKKyProOu8rX5QaDuyII+2xorVMcZfY2rrVqeNdkHZ0VZdqImReVaMDWSsEIhYe5iWats1XlXf0QobU/jnrDDb7BoekNwukC6Iblamk+gn3XwS6+2EzMEVhvs5crUsQ5FrcsfCUzT+G0woWzw4kLl6gp3Pgqaxr96XV0+5AZID8gBHPaNSplhMwzHbGYIB3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(38100700002)(52116002)(2616005)(38350700002)(36756003)(7416002)(8936002)(86362001)(5660300002)(44832011)(316002)(41300700001)(2906002)(6506007)(6512007)(8676002)(4326008)(186003)(26005)(478600001)(66476007)(66556008)(6666004)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?61MDlAlUMhNlXHwGSNOFcJcwlJyM1n2zfoPB/LythPhpY370+pOlRNT3VFzf?=
 =?us-ascii?Q?a6gR7i0Zznr7bkuA8PWyyL40mbdKVIFfF5ydFrMuuKik9N32FqL5zGbRzQSR?=
 =?us-ascii?Q?9ZBQd7V5DkjA2zv4BukALUkJS77WiHw9kd3l4vgDWz+XExAo8Pm4jC+VBlFH?=
 =?us-ascii?Q?k+MpAS4fsTOLASWaSvwBJBJvUDMMc23uNcHw51FQtMzroCPyYywzccFgOYKI?=
 =?us-ascii?Q?fMdioQsDAB+Z1ObWPIVO6zu1BL2ZWZzOaOV6/JbIogMBk2hyyx+QzjoYsucl?=
 =?us-ascii?Q?7s+R8vyHQhMLAAkpdiorxL9oLRwb1xWxHMDlDZpkYOi7iaU3xrQFOwqgOzkO?=
 =?us-ascii?Q?M4sDS61/cY9jjHt5e2bIa7Wewv9RmvvC3pzpvH5MAVAi5wj5Zlr86VGZJGjV?=
 =?us-ascii?Q?CBqsnoxbVsLESJIt5SsmmbFIW53UNLLyuMscPA4rKQm2B3KdTDdFJndz9s9J?=
 =?us-ascii?Q?n71nlWuhw9bhK9YN8YMCfA+DMS1Ra9drj9VSRo2GIxUhPlmyBOy6grPmZnVG?=
 =?us-ascii?Q?9IYBj2VzB/OkPpoeTebc7ybsXDf9P6drU48FZ3ZsU9OgkaqMkYdNTNzMIUx4?=
 =?us-ascii?Q?WGa7IXUm1mUg59qStbaoURxVj1OOzmlkPhsMT2WBES4Cfkx3MetHy5s8lELo?=
 =?us-ascii?Q?3I2Tc6/k/rHP4RKZX55EqonELxC9QdX6NKdYdNl7aLPVsyWLIFlARQOtVMGA?=
 =?us-ascii?Q?ApMtlbB9Av2X+mlrooEDDXRuMgxem17H+w1MiHGjz9HcwQc+RKJTLI3qOkr2?=
 =?us-ascii?Q?Nx4M0VYbG5bfjK0HJHuoIDsaND2CTGVj2VVCuhDeY8IqFdtLJInTTLdqZJzK?=
 =?us-ascii?Q?Xh6lL4iUySqmN3v8uoUQ8jUCCLIGFIT5hx8sK3kI13WcSyguQjqIqBPRrFPt?=
 =?us-ascii?Q?lCIWH0KflQyR7qCbizSdsckK0Kd+VJ0H1q/CkSgPn0yeyQmw+9zD/HM7ghvL?=
 =?us-ascii?Q?cCXjtVv4XfqDsFeUrFYfACkLPqT88SdvzAU12NiVhQrn+CJU45phEKS1MWby?=
 =?us-ascii?Q?mx35mDnaaITVRstuthpNIh6AfMz3udXaQPz0NzKzIye+wBuxFMTi+zCN65bZ?=
 =?us-ascii?Q?cTCx3S9DXCNlyKoMLZSrSR1iTX4pY07nCmpuXDJ120ttfSLL+E6h2VTHD5kw?=
 =?us-ascii?Q?YKAK2TXzP00Nk4vlpTiBx4tTv0m08lxnMYwUMN2gquEKzuiWMCKj+McWghVa?=
 =?us-ascii?Q?B0RNQxT7p4CqPbTuxVcdyE18o5ltUUjMfq5o4UxK9Mq9GY/RmU0Lj58H61Fb?=
 =?us-ascii?Q?qFbNu0l/PXVl7A5TXQaKOBAun2qdQuL2vhkG/feHYGKoPfcaXLfMjK43I1xz?=
 =?us-ascii?Q?bAbOLq1DVh+E11D5xk27BjdhCKHCUIrt2dSAVCoHYA7bncU6MDnB1gAj9YcX?=
 =?us-ascii?Q?JKrQ2PaCzRN5w0F+/cfuCvM1RWyDF6GpUtZWGq3ie/Df1Dvau8i2BWtGUXW6?=
 =?us-ascii?Q?70pA5RbK5YnrDOMRRlBgpro2RcNNELX0HV2x6cQPmtkVaCHyaaBm0XbSIjds?=
 =?us-ascii?Q?IVlBGS7MDzkdSjanFEgasCVsHOXuPmT3bqi02T3gghzJ3c+KAcru1Qgftd85?=
 =?us-ascii?Q?7atRji/ElhYhZ0SrJT/Zx4vQlATQZM5tmdeM/adK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2bbf4f-dbf7-4ce6-cff0-08db041a1640
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:03:49.3626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+rSYZZnEM0v9c6x4+HKuEFobGtZ3nr1g/vCzFIWGJP2+8kqcga4Q4lB6e/GdvmqJ2s7llneiJgQkdD8pc058g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear slot next desc ptr if config error,
otherwise codec will report config error interrupt repeatedly,
it may led to system hang.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 5 +++++
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h | 1 +
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
index ef28122a5ed4..bbd5d6a9fc86 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
@@ -178,3 +178,8 @@ void mxc_jpeg_set_desc(u32 desc, void __iomem *reg, int slot)
 	writel(desc | MXC_NXT_DESCPT_EN,
 	       reg + MXC_SLOT_OFFSET(slot, SLOT_NXT_DESCPT_PTR));
 }
+
+void mxc_jpeg_clr_desc(void __iomem *reg, int slot)
+{
+	writel(0, reg + MXC_SLOT_OFFSET(slot, SLOT_NXT_DESCPT_PTR));
+}
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
index ecf3b6562ba2..8b7cd6526efd 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
@@ -137,6 +137,7 @@ void mxc_jpeg_set_bufsize(struct mxc_jpeg_desc *desc,  u32 bufsize);
 void mxc_jpeg_set_res(struct mxc_jpeg_desc *desc, u16 w, u16 h);
 void mxc_jpeg_set_line_pitch(struct mxc_jpeg_desc *desc, u32 line_pitch);
 void mxc_jpeg_set_desc(u32 desc, void __iomem *reg, int slot);
+void mxc_jpeg_clr_desc(void __iomem *reg, int slot);
 void mxc_jpeg_set_regs_from_desc(struct mxc_jpeg_desc *desc,
 				 void __iomem *reg);
 #endif
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 70b6eea733e7..3f1c9bc4b144 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -692,6 +692,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 		u32 ret = readl(reg + CAST_STATUS12);
 
 		dev_err(dev, "Encoder/decoder error, status=0x%08x", ret);
+		mxc_jpeg_clr_desc(reg, slot);
 		mxc_jpeg_sw_reset(reg);
 		buf_state = VB2_BUF_STATE_ERROR;
 		goto buffers_done;
-- 
2.38.1

