Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0665ED559
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiI1GtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiI1GsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:48:03 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A388ACCE;
        Tue, 27 Sep 2022 23:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHUMIl8aRai+rgxLT18C4LjFnWgBc7MRJz4UYzg/Ry8Til0ie795lf3XZZX9jncTAvz03Mn4U6bZEAAe30WsgE4Lw0ytW42M+YVaNHHXKk7GzfIJb2jiNcoiBXlmKkYzCsyVu9caEjV5UKrll6oeIldDu0TIyqzrFA+U9L6sl1LLrkQvOjoFdWVKLSgx+k0cC/3/NGq99Qd6Z9T+cZRCpXnH+SH3ZNhdP6GRODLxVjjywaywHPGyEiH7sHEZKHoY95wwjabTv/v4qTCZDIMK2zCC8tucod7+jGwq1WkZiCRSVDdD9DgvwHpJM48ToxOqd6Cx2MbywzdnCfvsSzAMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0o0LhgeW6qnZb8Z71qTJ9VV/bwWRMd/H2FkwbwmX0g=;
 b=TAIVXetbBjKvLnLYXMaxB2jj8tcdDvwoaaFlj4HBhVkvY3PEIHK8FjoCu96aTahVguafdfQXMPa0jCjNSj5jkq96sAv4+TqMFddYvwDSasDuY8zpunuKfACU2zw7fxbvS4z7lLeQPSe2zW4g06WZJdFHbOxxs0hG1KOKm0DNRVLsq2Jyupd+/VCln6wRlgn3bfRiuxWF7++1lajAmLmOPEuLCOn1aU1QgKVW/91HBefNxrCNuWlQcyH+ES3YCjZkyBVtHu3xMkZXoO/3IYFLS2gBp1EN+GyBm7vcvTHDmYEEjoJdTAlK7j9nny2XJwU66WdRJyjd4tBR4fV2p+iong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0o0LhgeW6qnZb8Z71qTJ9VV/bwWRMd/H2FkwbwmX0g=;
 b=EQfWSpeOHiZ/JCitVWPzSPWxWnbWGc89lYpfDdiCAnzD1Q3XtG+yBRxLYqcdSvwFl/JRB1ZY2El0Tcr9mZBE8gFHlMLDwNIyFtcbBuDTHxtyWIthwioDx+tLsbZsgqgMtRen1hLmmfmYMncoNemCk3WUpjpicok46DLnJxnZ26k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8451.eurprd04.prod.outlook.com (2603:10a6:20b:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 06:46:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 06:46:28 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 2/2] remoteproc: support attach recovery after rproc crash
Date:   Wed, 28 Sep 2022 14:47:56 +0800
Message-Id: <20220928064756.4059662-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220928064756.4059662-1-peng.fan@oss.nxp.com>
References: <20220928064756.4059662-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dac70b5-97b3-4191-ced5-08daa11d2b3b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RJen7K5wLR6nbo8xDB9W2yGZ3OcXXxHJ/Xgdq/vOeyryJj7ETTLlqu3cytdDM/55xu3X7aiT2HX4QeUEn2s7qkkfuLaWaLP0T4Afb8seTe/lvWJHyJP3rPzLoM+jgXD3kAhenMGrwnkfVj1razU3J+3jA6UrEgU6iXOvIe4V29BWP6ZKRWB76QB3MGPHKO4AXDvSQjQ17ThEtxrGfgBkwL7MirqX7AdvWUajZmBzXWA5GUFfXSvOn5YZ8+yzluKnfx8iib/bT7tPJRmhf+CQeiIfRiVdG+jg8CNB0hMA7f70rRpVMA03L5YCIWed/JujTpEPMbprBQgnNrtuLNepPPHkcdfsqJk+0rwcBbcIaquQ7ZDjn7JgNipI+dLg7L9SAY+Kbp7XDXmFQea5+jCOyje6MKCdmsI2urlT0KRXkBvEhIwcD/3sm994R/TUmCI2QD97XXbxWEJFKQ4lrSGkqHsM/ZbVbS1T8nn9mf1vXYKxr9T6RCSM+5GXCk/5vOqrwh9mZa5y0OSZ7gbVw+w9uPHIUvY6etf3JDT15l1cW1jv2eri5xQkvD/ABLKkiWrkTZxoMoDcOkTv77RS5TXvd/Z8Po/+97a4ZSj1Lq2lhinOxarefAg3gIOTa1HVtTErDdHM6QVuTYqooNdJGMZlBU61KQEn5HlhSmAXJ2scgACj/JrboM/zZD4x3DHXrVJSHyMTBzFLqTDDkcvxtc+sPMBSAh7mxH9Ti5HtJmz0hO7fNQyrKblTyzU1y8xbIOHBQTtUWSXHci845tc8MEe3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(2906002)(5660300002)(4326008)(38350700002)(38100700002)(8936002)(66556008)(66476007)(41300700001)(66946007)(316002)(8676002)(6486002)(478600001)(2616005)(86362001)(6506007)(52116002)(186003)(1076003)(6512007)(26005)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hpcOXsgUInOcYscKD+LkddniQbMgG+8KsFj6ZWQiuZojAyp3Tn605p2Jokxi?=
 =?us-ascii?Q?ZSwkvTWS3YgSw3UHD7ParNr6oMwj1D4aVrRjvAp+AeYK1WVaZ2nLLl0ieGdG?=
 =?us-ascii?Q?Yl1r0vlZZ+ixrgTwWnp1Bw2RR7RlnEhYcEOcnbx9q8M8zDmLJYQcEmkYTzNG?=
 =?us-ascii?Q?VY3AnKMdR2IT2CrXjjZcRtLFH6BebDQNqdYYSXeuDzACkguDNRtmmNpzRaQE?=
 =?us-ascii?Q?txEo2JYyVjXqH5ee7sXCxq+Rat3ICj7oDeDZbaajXQrT9GfB5UndhMtZ8ZgB?=
 =?us-ascii?Q?WWOJP26YYePgwqVQfHgTC8+/DT+UJOFK/g4bgdsxzi8WuY7m9EZ4CsrGXYOq?=
 =?us-ascii?Q?2uerdV6sVvC+arbKJ6OcbQOGNiyTumObua2vW/zt8piCdSIuEoE2XnxlAi9o?=
 =?us-ascii?Q?dSub7Wr9bsV/2N8whEw0bnS3oCcHLmPBe7RLeCXm/NA33Kh8dEtegwp+PsSs?=
 =?us-ascii?Q?m0tsITByGLB2dnKbB4dREU7cPGI1GIKVkDnv/BHCSX+pD5uBdZD1rfsZ7QKT?=
 =?us-ascii?Q?s/bjydT0JvSLiV0HGV3kFS9xJDRzk6wbcIAqdyBnCQc/Nn1UvB6wojEc1txv?=
 =?us-ascii?Q?CR3umQMOIQen13vObhhUKmJhm3NgkVe6aXVUwMD4RDKykm4ZElOJwC1V9996?=
 =?us-ascii?Q?jnBwNp38B+6q5xMvLcmCxxiFzsOSY4AF+YFc6+3z7Ce27ZNhTfXMms1/3O02?=
 =?us-ascii?Q?4Eyr/IJqJnY2rT9yD86xwry2qvF2mSqP6DoHcqnjxe76F6KzRjCeIMaWMJW7?=
 =?us-ascii?Q?fQN9HzHyFF+6236NEZ5MnOCGj6ViiDT7KB4JIHQpU03I5nVtnIp+obj/XkxJ?=
 =?us-ascii?Q?4zs1KXISA5hgsfFD88HRhzu+Tp6670UlkycrQITmIdedxMKiB+PKzBVdORg+?=
 =?us-ascii?Q?5jLREBPXyuNWjxzaaMNdSgw/QkjRO6xKDYNReChU8i6UqkDgyiJA5hhnBpFy?=
 =?us-ascii?Q?d6h+8XMI85RrTcVlDiWvwyVbPfqs2o1nIjvd8PL0ksP7xcKa8l2nCHp5dVjs?=
 =?us-ascii?Q?Zrt+RSlYTXol0OGI0Fq+Q9PKNCz2TzNySYEaHlm+zEWQDt3SZ7w1K27QzM5C?=
 =?us-ascii?Q?u5M4fev8mBIGD9Nh8bnrEYW0hA9R+AzXJOeTxbwaLo7q1GnmRzQQi3NEKc3n?=
 =?us-ascii?Q?PmEKso6xnl6Dv7CM3BYxNzO7AEAwYufo6Din870lh5+O3YCU4BWb24LKwvbw?=
 =?us-ascii?Q?ts9dvxFyouyNH9tT6x7QDIcn1SXoWlGJYNR1c67r8TsdWd/8ORq1OsmpzSjc?=
 =?us-ascii?Q?M0/qhHRDg0G1JBmnezo5ofIHWd+tf0tdWbfOKpbS2JSw8SLO4zFfLKNZLY8d?=
 =?us-ascii?Q?PBekQzIUjLTC9XUoJAP5hAMCERFsJSEPKIIQ10g9eOmw0/O8iXkU9Xu9x/Tt?=
 =?us-ascii?Q?6dsYrhdWXFKRBwP8XUey5vC68io0524AcF6R/Tq0gnpHqdkeFw7cqtuN9mjx?=
 =?us-ascii?Q?XRTK0k2Sej1+NJZZWhODURppmlQIIp+o9h9m994bFVZHP3NKF0LtMKdtSutZ?=
 =?us-ascii?Q?Y4kDRdFZDADrZE5Dp/+BmOPBOCE/yfhNeFjXBY0JfHJoy5X+m1ea2n9j/r41?=
 =?us-ascii?Q?LKf2GIBYYmTxZPn/+Fs5rWfcGmGHHzbAwLpOHSIm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dac70b5-97b3-4191-ced5-08daa11d2b3b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 06:46:27.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjzJM7idSi0+47bybFbWXQyLM085d9WxE2JgPtoe3iFeT/lZWuodOZdKnCsvt3K9LgIOQLqz1siKthxFn7ozjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8451
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Current logic only support main processor to stop/start the remote
processor after crash. However to SoC, such as i.MX8QM/QXP, the
remote processor could do attach recovery after crash and trigger watchdog
to reboot itself. It does not need main processor to load image, or
stop/start remote processor.

Introduce two functions: rproc_attach_recovery, rproc_boot_recovery
for the two cases. Boot recovery is as before, let main processor to
help recovery, while attach recovery is to recover itself without help.
To attach recovery, we only do detach and attach.

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_core.c | 62 +++++++++++++++++++---------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index e7c25477b0af..8768cb64f560 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1770,6 +1770,45 @@ static int __rproc_detach(struct rproc *rproc)
 	return 0;
 }
 
+static int rproc_attach_recovery(struct rproc *rproc)
+{
+	int ret;
+
+	ret = __rproc_detach(rproc);
+	if (ret)
+		return ret;
+
+	return __rproc_attach(rproc);
+}
+
+static int rproc_boot_recovery(struct rproc *rproc)
+{
+	const struct firmware *firmware_p;
+	struct device *dev = &rproc->dev;
+	int ret;
+
+	ret = rproc_stop(rproc, true);
+	if (ret)
+		return ret;
+
+	/* generate coredump */
+	rproc->ops->coredump(rproc);
+
+	/* load firmware */
+	ret = request_firmware(&firmware_p, rproc->firmware, dev);
+	if (ret < 0) {
+		dev_err(dev, "request_firmware failed: %d\n", ret);
+		return ret;
+	}
+
+	/* boot the remote processor up again */
+	ret = rproc_start(rproc, firmware_p);
+
+	release_firmware(firmware_p);
+
+	return ret;
+}
+
 /**
  * rproc_trigger_recovery() - recover a remoteproc
  * @rproc: the remote processor
@@ -1784,7 +1823,6 @@ static int __rproc_detach(struct rproc *rproc)
  */
 int rproc_trigger_recovery(struct rproc *rproc)
 {
-	const struct firmware *firmware_p;
 	struct device *dev = &rproc->dev;
 	int ret;
 
@@ -1798,24 +1836,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
 
 	dev_err(dev, "recovering %s\n", rproc->name);
 
-	ret = rproc_stop(rproc, true);
-	if (ret)
-		goto unlock_mutex;
-
-	/* generate coredump */
-	rproc->ops->coredump(rproc);
-
-	/* load firmware */
-	ret = request_firmware(&firmware_p, rproc->firmware, dev);
-	if (ret < 0) {
-		dev_err(dev, "request_firmware failed: %d\n", ret);
-		goto unlock_mutex;
-	}
-
-	/* boot the remote processor up again */
-	ret = rproc_start(rproc, firmware_p);
-
-	release_firmware(firmware_p);
+	if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_ON_RECOVERY))
+		ret = rproc_attach_recovery(rproc);
+	else
+		ret = rproc_boot_recovery(rproc);
 
 unlock_mutex:
 	mutex_unlock(&rproc->lock);
-- 
2.37.1

