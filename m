Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85521674028
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjASRkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjASRkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:40:10 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560B42728;
        Thu, 19 Jan 2023 09:40:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBBkkoVwjvzDTBT173Pv8I4wDttvd1f7J6hB8i7wmC/XNq4o6H/0hZ/rkd89I5Q2+skKbAVtgs6I20pL/iq/MjGh7/pqfXrRZ2d+UQs0Xy3dlLVEYL5mvWlCFM5xEawSuvj5s6xKN1XY5A+Phtl2vS2fJB5mlSxtDFZ1+/neEGJ/cCA9vkZhz21AK89WbXlETbbynth06ACC1ksNnxf96co78DpltJ42W7qXDFrqCfSLGnQECZy2VQok+6+kPFzIo6avT44ftLBqr8+IJC97XJp/sdb2nR1MlfFCXVDyKD1NrnKexrsXOcTX8BvVW7axnZGajgnUwc4c/twVcX+t0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/auppgJ2pDNNsl7r96raVoW9nHdmpNOZ3LUnWgPn1c=;
 b=Nl7gSSxMUwXSF4VTC+BFwuDNmzXy8DL8kAg+rydiWcPwQhBkEN32WTOsbFmTitmDBPjQsrBHS5sx3wfh/Puge6TUEmelsbFJnxC4FpQw8Jo4cfIuT7ryZUlpfbrb/y/CUBMD2vbCc7r458+79jd/CRbqljuiXGZmlMH4uFFbV2v06jC4EQgxmaEkqYXKOqExhbAF3jiUrtV+M3H0MRGCF97+8TzuglXBTp3hjwmq3zXPLcwfiFy0EeIC/44w2jl7lfugxlaopFCJ19QW9/1J0ANvKNmhBN4d8fBEweLNzBfF23P7GxB4xlT31VKpLADViitg+EQGCyGLbACLouhnwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/auppgJ2pDNNsl7r96raVoW9nHdmpNOZ3LUnWgPn1c=;
 b=YuDERfMmCVXK8pKIhtUOUYf2sYm7hp7/Al8M4WFLx2X8oNnAOe9COy6+ps8jdpFNFF/WWzs0bH/jnfZMh9XHVWPJhq0gQp2+Ff5c+bDYcTJgYTj3xCQhhziHsC0sRxVCmtZldhWxemL93iA73HFuYVwr1rgYyFuVd7raUCkBz1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by PA4PR04MB9368.eurprd04.prod.outlook.com (2603:10a6:102:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 17:40:04 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%5]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 17:40:04 +0000
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
Subject: [PATCH v4] remoteproc: imx_dsp_rproc: add module parameter to ignore ready flag from remote processor
Date:   Thu, 19 Jan 2023 19:39:40 +0200
Message-Id: <20230119173940.21143-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0137.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::34) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|PA4PR04MB9368:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1f5334-4896-4280-4570-08dafa4432ae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNkb8GpiZmNEY9RZsuwv79rt9hhTqxSLEcFM9PK1VFAPk3YEejnT3/jBYlf1GvK+zFFhQANKoASZ8g13CCjC3/MtEqkJ+jPWihdkRFPBoC7HBb2I0QViBFqMgWGdf3T92s6cKNIFdJWaZSTTi1TLpA83b5ozBsU2H8X71lHZSHOet0Fr4RlZKec6bgJv8BR441Yu/+G/ymp0gfSJEXzeLGa+Spk34KnwnXlqZQu+97+wIWfNvHI+/175SAktAL7IZQYlHZ2NjdHNS+ZrMcbOkMnGVHBlOttDfbLuRlimoVWGUC4/uCGgUmSlKqSTBrqZavg7WtWBJI0/TVGIlRRDdnMsDvn2DQJexfAueNYpozRilECMvEsedMBZWi06CIi1/fMo30GNgrWrrobGIsgVWGK97YV1oPb8NQKrufNFCY9Ww5Hx8BmMU22Df3eeA7pqZEnL1gNof4Qn/vpFUyB+WsfH/1sKPcWXgZRMvgd1reoLNnSEqJ/cTo/Vm+GhmSTwKbKmLEOVfzIwwxbQyPGA9HVlG2/15+DEQyud4AATvrcqoyBva8+pIIGq2EQjuldECiRH8/kEGsPqaXyvpHzgSuTVNNQW9REgFHTF9Ki0C9sFBPAYgOy5wmqqaR+64B6117JDUCclPOE4g43EAksuZ3sOzkgUL3yQE28O7J3EILlREUhzs+L0fbVuZjgJ4n9GxT/EBLitxRjZROTChiCdzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199015)(66476007)(6666004)(2616005)(83380400001)(52116002)(66556008)(66946007)(6486002)(6506007)(8676002)(186003)(26005)(6512007)(478600001)(4326008)(2906002)(41300700001)(5660300002)(8936002)(38100700002)(38350700002)(86362001)(1076003)(54906003)(316002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rmveCwi/eQ+qQKxKQeBtq3lxx27Hg2qJ4zmVFl9XQRCp0AQuxw1Kz6b9Nmg2?=
 =?us-ascii?Q?ykQGqSjTxNeuov67H7EbItTMvqpIsjeUFw442iEM9lOJsuWHSSyNOFRx88I2?=
 =?us-ascii?Q?Eef0mfKh4ffo4Jko59VzCQ6xsSIuXfATuN9nX+iS7pP/e+V8bBIqqGGm4FMe?=
 =?us-ascii?Q?Mr0K7S9O8XYcLC5VZNOWYpO7yuQITwI5NWSiYRbQbDazUL8FD3Qqtb/3ISmN?=
 =?us-ascii?Q?oZXORN8L7WhSutDFpulPovay7cjtnhQOuDPluwM2Q3ph7ypKR0VF1hnF6Ghd?=
 =?us-ascii?Q?0ce8RoTmGVwE1eKG3sk9lnmdaNIOkTviyKemg7uMVq9w5yuJ3g14R+kJdmmT?=
 =?us-ascii?Q?Zsu9MJV+V6G8Zs439Xwft7btnNn2qimjd64zld76sdFI1Qvdr/17PLYTIHc/?=
 =?us-ascii?Q?iuZ1fgzj2Yonc9QkASl3Q9Woyw6hKbCSColUZSmtp4N2s+4IB5pKjI99IIYW?=
 =?us-ascii?Q?qSZJdJEFCi8CMHtPUg9eErGoAWAsV1G21FFa7fNTRtwXpRJnrG9QXg5gqNCf?=
 =?us-ascii?Q?uICHH/RfQ4hAAA99/WMAvdhAxzQRuXuhtGB4CEwTpNNlTYpoly9Aol0Wfxgb?=
 =?us-ascii?Q?z+mTu9E+ifbAySY6sKAZKxWLaCq8Oh8Yw+DPFzwlTi9vZ6ZTYYBplKD2OPqx?=
 =?us-ascii?Q?F3qW/sStL5BM6St9sRvufvrmHV4MjSnWEUoFc0w1sUgtTFkMjG1hfo808hvi?=
 =?us-ascii?Q?KoSQpWub51vqOz2tBNDqbwxq0Rq47oaJYD18nwUy7YH/sz8xyPgwQMzQQPWK?=
 =?us-ascii?Q?jK7f9aN3C9xg4+fnv39hfuCM6igqN0kfmR49yIo7+qE5zLODjp9xwm3vLz6Z?=
 =?us-ascii?Q?pp1XMAUltfmcSJqud9dWC38t1bIqQ4B1h0X0mpTzWVe3BEMnoZRvVPnkDLIH?=
 =?us-ascii?Q?mYK7euAZc0F1ZDLQssTWJli1LAprbBiRA0gp6/VWz3gzyfov+8nzD82IY0Ej?=
 =?us-ascii?Q?vAeInGu03ebf2Xnyxinsswth7suspk8nbNwWv4EYe2CdVurYbK6XKydea7s2?=
 =?us-ascii?Q?yZgTNJpXSDwLU6xRoe85MBDZ3wer/pM6Naayb+DFIguHjpsUrZDihwAp6an1?=
 =?us-ascii?Q?m2lHHZLDO7Reu72RRAa2+P/AE0pZplRWsdNzYCbYJ//DQxwLs1CyP+gcjs8y?=
 =?us-ascii?Q?aie16PCdohhsxj79oJ7mrE2jF5sVi8Wd/V7qmwjGr2InV0b33rrJS6zOc68M?=
 =?us-ascii?Q?A1t4HXjChX8SfVYRB11EmVmvFZy2RMKPkEq/NV1uUF67L3j4GajEbccLqZEO?=
 =?us-ascii?Q?mOR7CK4+ipVmlcMwjOuwqE+nyWIQugNtkooIcPXNTfp3fNWTJS5UghuT/1WG?=
 =?us-ascii?Q?N9yMwb+VWmxtK0nsGSGyf8g19LQLZj8t0RG0b4jLKHnrQ6ctfS5ymM7nTZ/E?=
 =?us-ascii?Q?mj+KQDW4eigTYNMRhIHoUUY+eh/9LIrgA++k/jLaatCvMqBr1bL86DUPspvH?=
 =?us-ascii?Q?05xWNZv3HRm76FMtrD6mn7/8wD8xyaEThJlfES72viKb8JToDy7xC6RSonJM?=
 =?us-ascii?Q?OUwAv4vg4ja3o/MOty+iEp9oqDfCxMxWBPIFyKoj855ALj1Wvh4DO8+U1oEd?=
 =?us-ascii?Q?Kzd15zGBAwlZMKZ7BKqjw++wzAb/B+5pXkVHAZWe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1f5334-4896-4280-4570-08dafa4432ae
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 17:40:04.4316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0lpVBryyJxjRMm1nV6SiifIFhtfedS62l5mP7WRQ08uuYL5xJ4/gBFhCxi/2D088fzYPqM7jgu4vFKFEme+7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9368
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

There are cases when we want to test a simple "hello world"
application on the DSP and we don't have IPC between the cores.
Therefore, do not wait for a confirmation from the remote processor
at start.

Added "ignore_dsp_ready" flag while inserting the module to ignore
remote processor reply after start.
By default, this is off - do not ignore reply from rproc.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>

---
Changes since v3
- do not instantiate static var to 0, this is done by default
- do not initialize mailbox if not IPC between the core

Changes since v2
- s/ignoreready/ignore_dsp_ready

Changes since v1
- change BIT(31) to BIT(1) for REMOTE_SKIP_WAIT

---
 drivers/remoteproc/imx_dsp_rproc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 95da1cbefacf..fb69f4e8ee96 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -26,9 +26,18 @@
 #include "remoteproc_elf_helpers.h"
 #include "remoteproc_internal.h"
 
+/*
+ * Module parameters
+ */
+static unsigned int imx_dsp_rproc_ignore_ready;
+module_param_named(ignore_dsp_ready, imx_dsp_rproc_ignore_ready, int, 0644);
+MODULE_PARM_DESC(ignore_dsp_ready,
+		 "Ignore remote proc reply after start, default is 0 (off).");
+
 #define DSP_RPROC_CLK_MAX			5
 
 #define REMOTE_IS_READY				BIT(0)
+#define REMOTE_SKIP_WAIT			BIT(1)
 #define REMOTE_READY_WAIT_MAX_RETRIES		500
 
 /* att flags */
@@ -282,6 +291,10 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
 	struct imx_dsp_rproc *priv = rproc->priv;
 	int i;
 
+	/* No IPC between the cores */
+	if (priv->flags & REMOTE_SKIP_WAIT)
+		return 0;
+
 	if (!priv->rxdb_ch)
 		return 0;
 
@@ -503,6 +516,13 @@ static int imx_dsp_rproc_mbox_init(struct imx_dsp_rproc *priv)
 	struct mbox_client *cl;
 	int ret;
 
+	/*
+	 * If there is no IPC between the cores,
+	 * then no need to initialize mailbox.
+	 */
+	if (priv->flags & REMOTE_SKIP_WAIT)
+		return 0;
+
 	if (!of_get_property(dev->of_node, "mbox-names", NULL))
 		return 0;
 
@@ -562,6 +582,10 @@ static int imx_dsp_rproc_mbox_init(struct imx_dsp_rproc *priv)
 
 static void imx_dsp_rproc_free_mbox(struct imx_dsp_rproc *priv)
 {
+	/* No IPC between the cores */
+	if (priv->flags & REMOTE_SKIP_WAIT)
+		return;
+
 	mbox_free_channel(priv->tx_ch);
 	mbox_free_channel(priv->rx_ch);
 	mbox_free_channel(priv->rxdb_ch);
@@ -903,6 +927,9 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
 	priv->rproc = rproc;
 	priv->dsp_dcfg = dsp_dcfg;
 
+	if (imx_dsp_rproc_ignore_ready)
+		priv->flags |= REMOTE_SKIP_WAIT;
+
 	dev_set_drvdata(dev, rproc);
 
 	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
-- 
2.17.1

