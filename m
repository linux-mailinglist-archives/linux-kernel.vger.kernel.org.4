Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB4869DA7B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 06:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjBUFms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 00:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjBUFmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 00:42:46 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434B01D93C;
        Mon, 20 Feb 2023 21:42:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHSsvWtrwf+XzOf/1cVhYJfpCM0NpfhXgdaQsOfURreQ9kBJDMqZDt/kPawz5Gari+iUBZcrJeXiXAQ3zYRwzLBoFF9MalMsdt4W7cZ/o3FY7RNxtyBbqs9sJjZET8eFrRrttoYur9zorVxK7h/2Skngs0+8S/7rUkMPAQTYCBfKrwtY09WYjSxeREXGNN8yWuGQqokefL3EHbvdOMyMF+4vkO7lRvGf1u5/JbE+DcOIsBu6SN59Qg+3O83Q0RvVWDLHKjd/lEVN77OxAoygfGBIktD1GtwIcQsYuH1lG9pAL6tHlVbiuWs8f09ZMdZFU8Znl05OOOgb1ws2yv/0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iw3bARIXB9Ci0V10LB5HCq4NgPDxUJAqpA8Y4ZkJIA=;
 b=mvBw9gw2Ymgp5RW6AJXOUbmppxxAuef+K5Q+myCUL0e3+Z0qi7+QzSiJUK4O2mBmbyQINRYqySdVHFp7FQEM76/I3GlsAFcncas7PJ6xKY7ZDKc+0y12YReD35jmtGBtwQpYbFkFD96gXOvNTVE9/y5iN9PTXRooSIQ/8khVVYnWnYq1sIOQqqlkvRzkvfdF5sJu8EcF3yHFSIgb+83MAJurNnzYbn5U1B3BFRImyxSzAbb0UDAr6e8/wJ1ymXEQV97n+EIm2Xha+qWihp8fWWEXvJBb+2+8qDsVq+AUEdhCYAgqw4p4QntY54absHAd1Fo1LtRDdbhfKdx5mXf2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iw3bARIXB9Ci0V10LB5HCq4NgPDxUJAqpA8Y4ZkJIA=;
 b=c/u502TmUrl5Q4gB7pm5YCvhxx706b2ozo+GSncv7ymE4j17pj168ArdrokiA1HUyMLqF21OlwPSgoA6YDTlkK6+Wx2hf//67TN+SvGUhcxx6Uyv3ZAg8Hen0b4ZMDGkFudb9jZzPmu//9h/qEivP583PDLbvwR9RuGJoAdpr5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS8PR04MB8577.eurprd04.prod.outlook.com (2603:10a6:20b:424::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 05:42:43 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%5]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 05:42:43 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, franck.lenormand@nxp.com
Cc:     vijayb@linux.microsoft.com, code@tyhicks.com
Subject: [PATCH] drivers: crypto: caam: jr: Allow quiesce when quiesced
Date:   Tue, 21 Feb 2023 11:12:19 +0530
Message-Id: <20230221054219.2142012-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230220105033.1449263-1-meenakshi.aggarwal@nxp.com>
References: <20230220105033.1449263-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS8PR04MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3689e2-60c4-49fa-590e-08db13ce73b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJJRHnB1Sl8V4phE3CCG+BZAa4DED7leGX5u5Yl36pIzjXuyJZgBUkN0eiX124ke/5/35SgeOs0qhsgK4BbalsUsSxb07hFdo0AbVd79Pn3krtDSaJY7WuMvFtqlb31BCMRZZxCcbV/nIZsrZmtA7H7Gq2lIIRCMP8B8m7WYHhxsOTHdsWuhuCbMkX0PfkruU9qoIfSoXBaSCmzdT8cbVDxfnfxKNZQejPZQUbcRJQo029CIMTc7sj1j2BfPaSGeCg39zVWUEPbtw/CAfc8O1fM1p5wt7erP8xu7jY7lIZudhYD6hJXz/8MsxNX3R/WEMkpPWOt7dYPk6+ho8Q/+6pHboKoGiRIK9NG0vGxREKlJrfd8VCqatUmboNnFTDZe2P4lqpMexOCz79z6Uu+RHFJww/yV5Y40U2omaQfBZQ9qu5snTkFSY+Tu3YNTFHMrKJTdR5/47RrWjqQhn5wQ9yZNxTNNPaWZQA40jnOiVS4P3SIwttOmIuYUwP/RXAAeJqoQ7FhyFQqzuORsp0vlOh6Ip/Z3JoIWvXNNRECKjqw7t8Avn0DG7j5HOuPmtzxVM5T25fWw1fOtclEIJVgLn+qy71JYHiTvuhiMB2TFAiDxXlQaUecQyfFyzM/DChBVLt5V26knypGioug7dkpVh3k2cPeyQxH/dCWxGkjwdIVndOa5gpDcpK+z0Tku7Qli93HwNOY59T92iZMYCgs5sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199018)(38100700002)(38350700002)(2906002)(8936002)(5660300002)(6512007)(26005)(9686003)(186003)(41300700001)(83380400001)(2616005)(36756003)(8676002)(66476007)(66556008)(66946007)(4326008)(6486002)(52116002)(86362001)(6506007)(478600001)(6666004)(316002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZzNdzTvhUfVEOSuE4yTmtW51IqOnVqxvXAb6aI6hNfhl93E+IvLwkbxTzlol?=
 =?us-ascii?Q?UyWTKBBBEkLyYJoZdwApzhZXrlgw48nPZ2h33mn4hAGSjfBUTNN3fSOFO9Xb?=
 =?us-ascii?Q?vB/PSZ2sAZwS1ZhjbdcKkhooQbYY9Mss72gMMytDW7BW1NJcTbigpgcNG186?=
 =?us-ascii?Q?IQIqVEzC7KHLRek/U4FMamnE6h780EeEmusrLl+YRqhbaeTRcqejKSN2NmYX?=
 =?us-ascii?Q?iIWmPhFaduhJ5SfqidjFXOyl3WLiNOiBT/1wPVmIC6LUkctpurLJJiA4jSrz?=
 =?us-ascii?Q?IqG2PgnoECMDBqZHqRNMRgTPrW2WgDPonu3DxyyRaIK/Qm0EuEtvfqitxy8t?=
 =?us-ascii?Q?zsvYN8jFzav6srGeL9hMHSSy3NeJ20KNiLRH+Uxk8MBowAeEzeR2PQ+zQYSN?=
 =?us-ascii?Q?95EPjJYsDHFzS4fXVrKdKl7+Oo3RWr22n6V5lUiw8gVdvZ7Cbb2R27DsTrd3?=
 =?us-ascii?Q?UCBLn8AmzWopGYQzZX7LCQ2EEI3WKChqAup0qGJmc1wB33mfLQ1tGWf3pVp0?=
 =?us-ascii?Q?V4IGYCK3Ui6vaAKaQbSk8pElESqqQc2+MlKeNpS2h2J0zXu/12tN9hjIMNCr?=
 =?us-ascii?Q?8Qv3Zh4RMEozbLKLBIdMzZgQyTQUg8EpDwfbY5uQqqQ2pmomO2FaonOT3Esl?=
 =?us-ascii?Q?gNNb1kLHnk3yal7XgAO4HfIpzllIthkphzer66j6Z9qK4pI0yoNJxvjsLQMx?=
 =?us-ascii?Q?2QOZub3C7RW97aUXiqNRlOPMANf82skLDHegYFU+YEdQmZ8oKBtQMExNGGQU?=
 =?us-ascii?Q?l8ZaWdRAEfI++X6y0rI96elGqA2C1jQzi8OFygn6iTe6I+12xHsxhvJ2ahc8?=
 =?us-ascii?Q?ndO8RBbgl/8enn2eGkH+nx8kHgkIuonZZBkI57/BK36sruqOVticGf7+8sSn?=
 =?us-ascii?Q?FKwnK8tN8aIEBB3L6WLvANqnRwfhma5CmYGI86tZP/C0/OpYvTIJ5BKp8F0w?=
 =?us-ascii?Q?On/qEE6FSUcz0OnVH/ZjHJOEgPLb2OaSGH/zJeZ61nFN6TD1HqoEqRWDiwSg?=
 =?us-ascii?Q?abbR60//dNyJa3bOedV53pDVxRXDBfNYQ5YIRI4a6yUf1LqRcZQYURcABCDQ?=
 =?us-ascii?Q?f7kgkxZomTPXPPlxqqur1H0w3y8Rl75Nkqs8EDp2s4zJSEZccjkV9Fj7jzWs?=
 =?us-ascii?Q?CgAlSQMSDt6J66EI5aMMGTf+dnyNH/68w/27hyU6O3RsHxFo4oTweaR/Gu8j?=
 =?us-ascii?Q?3zemXD8TwjXbT0mvHKdtS6L+arUDRnV//djcrvTvhdELYzs386sE6y76mAS9?=
 =?us-ascii?Q?9EWm+aYHgJwT7X9THYp376/TFEVY+IYRm20igzzLzMWqxbfOTYKBd8f9KnHI?=
 =?us-ascii?Q?HbYTyB2risyEPtTPjqc/7v3OXXvUe46vjeIG24zm9ls2OwojU+g2MVTmKvBF?=
 =?us-ascii?Q?sVK6zvq2HICYhReiQoc+a3oe16JdgN/rB+N/vxbIG0EibJsF1SVbUJvKAkfv?=
 =?us-ascii?Q?oeUlIhUADxgaDuuVKGggBagrP3Dy3+r3swypw+5W9Ncp9v63a8Ss9F/C+geD?=
 =?us-ascii?Q?GvBv2qQAvHK3ich4VTegTBkWJIc/OKCF7kMfszIB3enpFq/jadipWK4n/xc9?=
 =?us-ascii?Q?VJIVf5UeWzPLgrvEH4QEYlWLV6ajFcyA8Cda7KHG6Zkmu+PQN51ss5wa6JYp?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3689e2-60c4-49fa-590e-08db13ce73b2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 05:42:42.9721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgagWgsk09e5Q763S4/0J4Tuh8Fv1DiBYW1fdWNr2VkApbfc+7qGxTNg5R7alwNbrfSlCvABYfOvYvGYIc7CdW5zh6WnXZT7W9fQmG0lAVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8577
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geanta <horia.geanta@nxp.com>

Issues:
- Job ring device is busy when do kexec reboot
- Failed to flush job ring when do system suspend-resume

Fix:
Flush the job ring to stop the running jobs.

Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
---
 drivers/crypto/caam/jr.c | 53 +++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 724fdec18bf9..8745fe3cb575 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -72,19 +72,27 @@ static void caam_jr_crypto_engine_exit(void *data)
 	crypto_engine_exit(jrpriv->engine);
 }
 
-static int caam_reset_hw_jr(struct device *dev)
+/*
+ * Put the CAAM in quiesce, ie stop
+ *
+ * Must be called with itr disabled
+ */
+static int caam_jr_stop_processing(struct device *dev, u32 jrcr_bits)
 {
 	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
 	unsigned int timeout = 100000;
 
-	/*
-	 * mask interrupts since we are going to poll
-	 * for reset completion status
-	 */
-	clrsetbits_32(&jrp->rregs->rconfig_lo, 0, JRCFG_IMSK);
+	/* Check the current status */
+	if (rd_reg32(&jrp->rregs->jrintstatus) & JRINT_ERR_HALT_INPROGRESS)
+		goto wait_quiesce_completion;
 
-	/* initiate flush (required prior to reset) */
-	wr_reg32(&jrp->rregs->jrcommand, JRCR_RESET);
+	/* Reset the field */
+	clrsetbits_32(&jrp->rregs->jrintstatus, JRINT_ERR_HALT_MASK, 0);
+
+	/* initiate flush / park (required prior to reset) */
+	wr_reg32(&jrp->rregs->jrcommand, jrcr_bits);
+
+wait_quiesce_completion:
 	while (((rd_reg32(&jrp->rregs->jrintstatus) & JRINT_ERR_HALT_MASK) ==
 		JRINT_ERR_HALT_INPROGRESS) && --timeout)
 		cpu_relax();
@@ -95,8 +103,35 @@ static int caam_reset_hw_jr(struct device *dev)
 		return -EIO;
 	}
 
+	return 0;
+}
+
+/*
+ * Flush the job ring, so the jobs running will be stopped, jobs queued will be
+ * invalidated and the CAAM will no longer fetch fron input ring.
+ *
+ * Must be called with itr disabled
+ */
+static int caam_jr_flush(struct device *dev)
+{
+	return caam_jr_stop_processing(dev, JRCR_RESET);
+}
+
+static int caam_reset_hw_jr(struct device *dev)
+{
+	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
+	unsigned int timeout = 100000;
+	int err;
+	/*
+	 * mask interrupts since we are going to poll
+	 * for reset completion status
+	 */
+	clrsetbits_32(&jrp->rregs->rconfig_lo, 0, JRCFG_IMSK);
+	err = caam_jr_flush(dev);
+	if (err)
+		return err;
+
 	/* initiate reset */
-	timeout = 100000;
 	wr_reg32(&jrp->rregs->jrcommand, JRCR_RESET);
 	while ((rd_reg32(&jrp->rregs->jrcommand) & JRCR_RESET) && --timeout)
 		cpu_relax();
-- 
2.25.1

