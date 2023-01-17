Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16D566D9EF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbjAQJ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbjAQJ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:28:58 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A0218B04;
        Tue, 17 Jan 2023 01:27:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKf4K3GWFCb6/2rMcV1zXOhHvxcQCJZmhFijHWMXAgWvaZbBvd+WI5KWLfwAkEAzxRjtyceQX4EkzgEyPij0dOB6ORWFyd7RMuiI8ZqjuOEuiBxA/PIniUmQBuxJ9AD7bYF4YjE97l32P+7vxctVmGN8M5O68D3pIrwPwgTNRxrT1IZpuZwZCKz3I1nogJxwjR6LyMvD+bEd2ONbaRKPFUe8lhWL7xaMQa648btQt0zJC5hXeWFsIVPNRM1pwPxzlrAnFdZyVGwOBLIv3VP6rWuJiJeU4ic8HIJTjHT90G5ncM1mlwdp+Hyj632lDXgIacxQW2/m+fZOvAG0SC/x7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wEIrlM3YYtOsWyY6bbyVhEpdD6zUn8nLkj1fIIequI=;
 b=ju+KqrMB/Zg+uvmyg04IJdL6XLfMRiG7zTdmN2VJ3xgtA0Srf+7RDCp2fHq1NnSjFKN1xz+LHDbDraXjZ4C925uawXK5ZaDGeYw9R9amz8KS9+RX92lY1vSvYROcPNCE+6p1EYQBFQEwYxoAt6jib0LUuISfavcMpOkqOPxx4qf4gjwZ016kg4JF9S2vQRuz8nDsGH3EAdnjoQoji7O7+ZSARHxKR8T27UWEYaOft3QhekUp2HB3KIw3+KAaj2uMsGGr1AETHEqRYBC7pMJu7YGE/5V+VXHfyxC6xLdfpvJ3hCZ8Ic8v7kqIcSSrtBVoqHd6P3PoxSi9PI03a1DA5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wEIrlM3YYtOsWyY6bbyVhEpdD6zUn8nLkj1fIIequI=;
 b=WQX5Cz59BzJJkSsZCQ7BZTy3MeO+MPQ8AXayvQHaQvAu3LUE518u6FZWN+3OkBpVD7Stp0NuBq62bpwbOdY9xhb+jvgnT2lkJXNkp1NdvhmU0k5gpg7KEAtC8yQIZ/ObPEl5y4t2RyAGKf2ELW85hJakL/NWdy3O8XXiDmNhJb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 17 Jan
 2023 09:27:10 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%4]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 09:27:10 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        SOF-Team <sof-team@msteams.nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2] remoteproc: imx_dsp_rproc: add module parameter to ignore ready flag from remote processor
Date:   Tue, 17 Jan 2023 11:26:47 +0200
Message-Id: <20230117092647.15107-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:205::15)
 To DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a4db2e-3202-4917-3ed8-08daf86d022c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVK+fACbh+bVGcEPKTe1n9NSdXR287O7PABQ7yIFqcaU9Dh9ETzs5z/FLQH38CXVAXp7ZOwR8bMJal3cdQgLwTBQmMge+bZeTpeMuliyZJ0azLqpNA7pFjGntQDCpk6BbcCcx9kg89MnthuPBdsj4WIsT62qnrQok2opgW9CtXhY9basHseD6NzOP7M3QOsi5RhXTAf6WyVRTckH6w9N0ImPvA50msCqoQ74/54HBxKm1AVF3bmzVjDhTM7UMSONMvOo4dvlwyvisfKTViDXJkogn+FBQhsC//Nh5p9yB+aZeiAduX9n6Lh7G6p5+fxugbkrY/RTakmRAX8EECGZpVxjH808u7gIQ1R0u6/eBBEjoksQHTjCAQelBhvPB+u99HWyYcr9atSpHknVH0zz8uvu07s0A358+dVB9OM7QAf8NEvlWyTKuVPMthjYLuDVGVa0j6Bt0RBStRKSJEYkqSwtZP3KqR33CavMva7WYfsNCV6aRukWwdLN2nNGfnub0UPDSOBkyFQVUDAdWn2U3yPcBsTi+uaY5sMm+P+fJfKwsrXpZEJgeeOIzuPwNkAOWgR9jSlDz1vDz4qitzw46uLX/crxV6/SPkwo2AO8gRJ6KuCfVFiqfEiSWecZlyfdtzkbollJxQ1grN9S89kFBBqUv2U/rhPkKwIguOVt9lHO9ZfwO+MLqSxn6DkPaCeTB1Ruyc+ry2rPKt9bRJij4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199015)(2906002)(2616005)(6512007)(1076003)(6666004)(6506007)(186003)(26005)(66556008)(38350700002)(38100700002)(86362001)(4326008)(6486002)(5660300002)(478600001)(54906003)(52116002)(41300700001)(66476007)(66946007)(8936002)(110136005)(8676002)(921005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7/XkhccMm9awIyjxxc/Z98jYf9tTJOoqAourRXvy8oQOXaRwMYCvo/CiPNGv?=
 =?us-ascii?Q?LUUHl1Lm94J+irlihQcizMXsMgNkWjlR96grXBCuNWJmBxPUcOBd3HInDKqi?=
 =?us-ascii?Q?Oq6L+EPNe9czp6ge8egdTap9reDRAP4io89F9jv7Ekp+VJRWEQbsEXayKgHW?=
 =?us-ascii?Q?1odLXWXkJ5MxX0b9AYXWWwB/C6n58ztKv+30Jiam1CptFMQvhH8C+ErWBuvH?=
 =?us-ascii?Q?tZ0shJp5D7Z5Zhm1dOkIYRj6BNNYgqxy9TXi+tpos5sxdvzUi4tQza3E9M7Y?=
 =?us-ascii?Q?wzZ10qO2OYcXYBhQzc3IESPuhHy3cdfS7+F22OlwHLWpjjtr/fSDkr61KXKe?=
 =?us-ascii?Q?VrqNur1/GSU1C5Uue9OHuhfxl3roX/6sVuYkWMpyshOOEzfxOKKPAREphDYd?=
 =?us-ascii?Q?XvTCZEHYqPkr52pay0ERz95ZYFy1mNmLrQU0Klo0zUjjsXx+KwT8+C78QBCe?=
 =?us-ascii?Q?gZ8oOfn/PPeYjJ9ZKw1XFb44NHKlWneLji5N2X3Ju542djSVAQmbWvY0BnT/?=
 =?us-ascii?Q?508xgu6S+cs4cY1aaFyQ5+hQOL3pUemPCG313CJsMDF+rqANoOCGJO0r11oR?=
 =?us-ascii?Q?ed3RyV8rVAdp5eeA7SWvwyoIKSIlIdpFuP/RqP5QZVRfA6zXZTqIK5SYdAND?=
 =?us-ascii?Q?uO71pdIBYRL4+xTydf1CflhJPrJzcIJMKY4tLU6w5WxDE81I9ypIFc7tXocV?=
 =?us-ascii?Q?KJlMPsdlvTgzSXtYy1UyurEFegLjlri0XuZlwoibIAFx+8HwwbePhQdBLijM?=
 =?us-ascii?Q?FixwSC99KvP5kHP23EXSqMDtmebCYqFib36OqhstnLfSlarzn0U9pAd3AvDv?=
 =?us-ascii?Q?3MLE8chFdoBcwMILXcuDAurBstEmW9bb+kv9Iy7TJaPWrkz7iFp9pLIBw/uc?=
 =?us-ascii?Q?WsQhEEwNcO0Pn4O48yYxIuvRan8ZKFzbIwCdR+y3XjZ0H9CuSK+3h7V43DG2?=
 =?us-ascii?Q?J5mI5v1S71NcrcuueV7MLtkq6vH9D7GDJwTsY++Sm9R2GrvgX9SgAyBB3MZa?=
 =?us-ascii?Q?S13m6WbgN1sXL1acd8DJXBxYxAlpFJhQnh0V2qXy1zT08P/W8Djt+eKrF23w?=
 =?us-ascii?Q?ZE0XD5/dg5ppO+rdF5/v4SWrR4HMAlXhkYQ/fDzvUh4NFKxELPHnLKfZPsk9?=
 =?us-ascii?Q?oxF9MaKFYHSlGA/w80x5DjH5CC2v0NE1SqzV2ZzjgB5QHzlZo3kgq2qH/Y2j?=
 =?us-ascii?Q?4QmBDFOywdIxvZ847S1XJKb5zo2kix1yfSL+/VEFWxmSbbfwS0kXUgMNEZ7O?=
 =?us-ascii?Q?+WFyXqLz6Onxfi3jdT37rcowLpM2rxRpzE82/l0i+PZ0SUSwmR5pcfjmae0X?=
 =?us-ascii?Q?FsKp4H8c+r3lsWcpCHxls9JTvR6+aSkYHyYTmQ+nW3RchwIw7StBRukDO/gB?=
 =?us-ascii?Q?gwpsN+P3CtETXRTYmiab5iCyDwWY4tN0rdexxZhVFIawUj8xZoXC8HogmabO?=
 =?us-ascii?Q?Be0kHVOEAKWYLhd+EYQxtWNFD+nfQPbpnIvt7LNU/2bx0PuWQt9m8VtumcUp?=
 =?us-ascii?Q?z/2cgNCoaq/nVjZ4rJx3bzYD3JyaYM36pSFucvbsGozEqyXJNXOFOHzKNCXj?=
 =?us-ascii?Q?4Ae2Gpq7itWH8liip3qtKX6m5wPZsYMnTZLeRuey?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a4db2e-3202-4917-3ed8-08daf86d022c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 09:27:10.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xH3mVSZDo88FU+/h2e2z4AqsvyHpM3DDZNtvkjLR/wr6TFVazol0cSH8JLF/YIeg9p+E7Xh04bnuQU/N2o2p+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104
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

Added "ignoreready" flag while inserting the module to ignore
remote processor reply after start.
By default, this is off - do not ignore reply from rproc.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>

---
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
+static unsigned int imx_dsp_rproc_ignoreready = IMX_DSP_IGNORE_REMOTE_READY;
+module_param_named(ignoreready, imx_dsp_rproc_ignoreready, int, 0644);
+MODULE_PARM_DESC(ignoreready,
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
 
+	if (imx_dsp_rproc_ignoreready)
+		priv->flags |= REMOTE_SKIP_WAIT;
+
 	dev_set_drvdata(dev, rproc);
 
 	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
-- 
2.17.1

