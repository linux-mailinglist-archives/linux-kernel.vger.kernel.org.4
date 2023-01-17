Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D2266DBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbjAQLEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbjAQLES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:04:18 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B417D30B16;
        Tue, 17 Jan 2023 03:04:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh7izjd4eJcwQ2qWlWDheAvqxyzcN8SQn2N8ztYapjfZFV/XEnnppXDcEGA8+Y+o6bwdMkvjYiSziKrfrRtT+pyQClrGYbm0I0b2yQrko4jasYGEdqM2I2ayNIcgoH+81JwNDe6kHO4ZH3w02glAv6cInUkp2i5hYJE/gZLLUs/0v6PK/IZUH73DySEaGiSEiUOzAQ/U2FhDiwpuKG8NqRVYhN58OQJYb8y7hyc9SJHt8equrttLwUvZ8gwbK8qYnG/ISFA3T/MWacYTS/X3vdt4zY+v4299GE5Ai2aJMy7pGbGf+KAIoHFtWEHZ5QJXQJ/cRCw/+y3AFyj2uWxFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgZm1XDCRtcGcO9Zu8p7hi4wtccKse1dlKs9zTMIDp8=;
 b=FE8q2Z5mbzv7rW2pMZkYUJOYBvqrlAlYZvgNT0mSKzKj7p3gaJQcLfB+ifZZlRtBKExHmZpoBIQHc0menVG7MMEIdVfka1lFQ0jcZJgrbpVNfbbRW4O4FsGY5a3WL9535O5SWc6vMmkkLMmwWsLoHzh5PgRu1h6h55TnoW/yoZrjVa7TEWjH+BB8eBN9a7/6Imn/p9lWhbQTJ5wVLz8xfqgnytWRZKid1heFss/r8qo9EfAwvoQXwpdqa3cdUMvOBiFxxDSmNP7tzQHxPAeSrX+6zgLNUX35+2UkjOd13wlZBkc8CA48J19tHC59u6BEuQs6puV3MJJsqSmLiE0nAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgZm1XDCRtcGcO9Zu8p7hi4wtccKse1dlKs9zTMIDp8=;
 b=ddDcJBfG2YlQuAMgsVUe3qojZOrnCr54MPmdrKogM+yG5FGUspN6eV5VAdeFNhwPzDWOayv2TYIDYlVhUfAp+lpnyRRztjQqDg1qKRApGAqdg0xkKyq+bp42u93dWXQAzgiSIr4nlbeKSDGpaNfo73pf3rVpj3VdRpyxb6lYAL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by AS1PR04MB9629.eurprd04.prod.outlook.com (2603:10a6:20b:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 11:04:14 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%4]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 11:04:14 +0000
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
Subject: [PATCH v3] remoteproc: imx_dsp_rproc: add module parameter to ignore ready flag from remote processor
Date:   Tue, 17 Jan 2023 13:03:57 +0200
Message-Id: <20230117110357.15091-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0004.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::9) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|AS1PR04MB9629:EE_
X-MS-Office365-Filtering-Correlation-Id: 3403423c-cebc-4702-2044-08daf87a9187
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+pk6jNU+JHWU/NEi6RmoCABATNbCDSQ8NI8yNIvhmAH+4O2asv9iq9AcxOoCwBp+ZLvlJ0IEMzmDn9yc3UyHW49Q9ZgzIu3xkw6JrMqwA3oiEW0CqLjhnd1MMbmD3dZc4n0pggAXz/IqUL1TRLmMP1kh4CJmxb6s5Gkcf2FUPjxFmGdly6+O7rngAFvRb7IlGeTVUwXbyg2tDxbNvlWnIj7aajZdRBI3aPT9YDCxkqYxg/KSlLui5aU558yl/dINRCMy6EtpQqo08jytB13unK22/s78CWPiCNX7cSZC5a0kkUXwWvMjThfx1scfHFqfjmwqpQ8BMuzEtoT15L0TG4EZBfiy0Pf9+e7avYuN8oXPrMxg6bNpLciO+YGBeGUxHPRBx6z/TiCmL1kK1MjpXpa2O60+zuLUZmVSJHlpIipH97ctlZJZQfIR/kDJltfYBfBTpXijUeCndqhH8Rhe6Si0Eqm2p6AfSdjw3r3XX/WgcRhSkm+roHUFeaPGbk1Uul7ie2g9XdO9F4fI93+M33Fn+Xh2/LNjkH9ieYA5A097lq7PNTdJwAiry2kfelIILLe4cI4lC+JXNVbEWsN34fNaWgLi5A//cJL+9SmFxM216qWkqnwGAzQgD1o7GSLqx37Adach6ue3VyaBBq87sPkkfk74nHjsnvw7xW0LLah9saU+Cdq6nJPxHDd0tYis1rf5Jwj0HD6+od6pmwRBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(6486002)(478600001)(41300700001)(6512007)(52116002)(38100700002)(38350700002)(186003)(86362001)(1076003)(316002)(110136005)(54906003)(2616005)(66476007)(66556008)(26005)(66946007)(4326008)(5660300002)(6506007)(2906002)(6666004)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xI6EvNfTgeEJyZJfgborKJCz4T2e0hY261jaomiNRV/G5HeL99u2dGjRJNOQ?=
 =?us-ascii?Q?/EbhWkvXzwR1k/hZ3DTZkuPGrdGNZ9j97+7cwesC1WQGFVLtx3FmTaD4y2TC?=
 =?us-ascii?Q?NgoeC7ftKBElRHRXVunHUbzz/wsGqGSEJAF84nDwuOkW4goCb1Sfshpjhga6?=
 =?us-ascii?Q?x3g3QZudj2Bnu6z8kgib26lhiD5DPDQoKHJxl90a+QDYRYad8A5Qrz1bxWW+?=
 =?us-ascii?Q?DTrbFfhzW8g4JhjwzUhKpIlowJoQwrDKzOudg+4VOWPKAAEelknOX5iT8KUc?=
 =?us-ascii?Q?kzcUzb5fvCll7Dw4dezMflXaA5JyNHpKanyiOIbCbdq1U8uMHfZVwRPxVObb?=
 =?us-ascii?Q?JnFbQJaixD1c4yEMKUV5E5TnAFWPUJi7uzVnEhbDEgQSAf1eRTtQdrxNZHxV?=
 =?us-ascii?Q?ZDhdp90r9XOWHlEdAOspp1DTVRAFtABZYk2OAznuPgZ9iFnAUAQmIV6Jsnga?=
 =?us-ascii?Q?GUoxxwIyZydnDcJAPaQKGYjnmsMEkRHW0gEv4RWoQazrztrfFR+2SC1Q+sEA?=
 =?us-ascii?Q?sje061vC0EMR0XOOEfqvIiPxzA+C2FR0vIZ2U2kNEkt50NqpHp7ocEJnWK2x?=
 =?us-ascii?Q?VOkWJOQMUePYQfSYzYPN6JBFDwVKlXSDvDfze1lvZh2f21JNccnA4tFr3mXv?=
 =?us-ascii?Q?T33Ux//vJefuIx8XAe5Ou+BzWNC3LHU1rgWGHINF9frMudbficttVKar04zm?=
 =?us-ascii?Q?3EzAbaoKQmukmvMz+bzjU0tI6mR1QR9IKb4VGmbf/p61UbjYqNjmmGAje1sp?=
 =?us-ascii?Q?wcXGssCiZDjbDYNvwSWClHYLTaaQ4kxZH/LgQlqfuJDWt42DYZzY3F9zf+QL?=
 =?us-ascii?Q?tcPD4UdbB2h7+3hfmOQFEXgjW3+d2c9gbcR28y5ga1Gv2ij1tv1JWcUpBIUm?=
 =?us-ascii?Q?5kxLd5+uhkZYsSHe6M5FI2NMgro+ITvydcC2cBA2XoDNQT7kzt2CJFebtgg6?=
 =?us-ascii?Q?HvANsDw2jngpDjafINXOI2wLN+hvqWD4YhmLkOu3kj+tW+8rvVRh3v9ra/pw?=
 =?us-ascii?Q?smphtUyDFkzKEXDfnZnXH1r8MlF1JnOpw9xRWAl3qJ/eKPnM/1Gzozu1loIC?=
 =?us-ascii?Q?kCOFESBaNc/P+1laXYIsjY0GiNg6leDWigt+h3u7BH27qESIw2fiS9mQAMiu?=
 =?us-ascii?Q?GuqvmeIqkWoTrgv5F4GRzylmCX10gC6jrSjzegcoIBCJZxRv0hJb7GRCIP6b?=
 =?us-ascii?Q?RwzkvZmQ3fzd1bsMmPFS5AJTE38xNM20yUui2qxvDel9igQVbuUUdC+8ZyC7?=
 =?us-ascii?Q?8PDHcsSPX6qnLgJ4rlt2PT4BhIr212jPQH72L9LkeLPG9jadrid09aQVDe68?=
 =?us-ascii?Q?qrEbISxbw+4o6QaOUhTa8Gne+l1QoKdmWFOQVZA3X3+zSXWCqjTt0lR7iMCv?=
 =?us-ascii?Q?B9gVMGtM2WFumg1W9+IIhUk3071oOObJVZDLnCrWYeBRYjgpSQDrl30W/e6g?=
 =?us-ascii?Q?uu+mVYApVIzJ6yGAT24uETsqRaRsix/r0lieBm1iQCDTNGpwGY/4BnSgLo22?=
 =?us-ascii?Q?bEkCxYiYGrpspLfRRrz7E8hNDsQsckzraQLGqkWsftCwBKWgWkdSJbjG3tsl?=
 =?us-ascii?Q?k8b88jBqHK1gBOaDlhmv0RaAJ/bI+2Yd837665Xk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3403423c-cebc-4702-2044-08daf87a9187
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 11:04:14.1033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLCfTK2icsRl437MKvuiP/TN9OveAiNxp++KEMij1D6ccN6+QaKfI9Y2YBwIIsU4aDoXRElG+FaKBVjyEhThHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9629
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
Therefore, skip the wait for remote processor to start.

Added "ignore_dsp_ready" flag while inserting the module to ignore
remote processor reply after start.
By default, this is off - do not ignore reply from rproc.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>

---
Changes since v2
- s/ignoreready/ignore_dsp_ready

Changes since v1
- change BIT(31) to BIT(1) for REMOTE_SKIP_WAIT

---
 drivers/remoteproc/imx_dsp_rproc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 95da1cbefacf..22e2ef068c67 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -26,9 +26,20 @@
 #include "remoteproc_elf_helpers.h"
 #include "remoteproc_internal.h"
 
+#define IMX_DSP_IGNORE_REMOTE_READY		0
+
+/*
+ * Module parameters
+ */
+static unsigned int imx_dsp_rproc_ignore_ready = IMX_DSP_IGNORE_REMOTE_READY;
+module_param_named(ignore_dsp_ready, imx_dsp_rproc_ignore_ready, int, 0644);
+MODULE_PARM_DESC(ignore_dsp_ready,
+		 "Ignore remote proc reply after start, default is 0 (off).");
+
 #define DSP_RPROC_CLK_MAX			5
 
 #define REMOTE_IS_READY				BIT(0)
+#define REMOTE_SKIP_WAIT			BIT(1)
 #define REMOTE_READY_WAIT_MAX_RETRIES		500
 
 /* att flags */
@@ -285,6 +296,9 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
 	if (!priv->rxdb_ch)
 		return 0;
 
+	if (priv->flags & REMOTE_SKIP_WAIT)
+		return 0;
+
 	for (i = 0; i < REMOTE_READY_WAIT_MAX_RETRIES; i++) {
 		if (priv->flags & REMOTE_IS_READY)
 			return 0;
@@ -903,6 +917,9 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
 	priv->rproc = rproc;
 	priv->dsp_dcfg = dsp_dcfg;
 
+	if (imx_dsp_rproc_ignore_ready)
+		priv->flags |= REMOTE_SKIP_WAIT;
+
 	dev_set_drvdata(dev, rproc);
 
 	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
-- 
2.17.1

