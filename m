Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18E86A5EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjB1Sib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1Si3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:38:29 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10AFA255;
        Tue, 28 Feb 2023 10:38:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U56saKib9QqFiLwWOZAFLTY1WwZIXE83ap4YKudYmda5fsqYAAMFGJSMsAXpFfxo7uE+Kr1g9IytW/Km4Ce+osEInCMrdPVfY66z7HrD5coSKvC9MKveOOyFcAUqEmDAnw+Vypmiw6IVHpZj9pbdrg74rVVAVuMthBOltE0Xr9g+vfeI19C+8rvfedeibvks6U4zvIYgwLrOqfqs7evp9xTZW8P5aPMQ2occSKwzpgmvYJqlCg8FQPZo3xGdSE1AONeNJZ0GSLyKIb+TH/3derQwlHJZ7b10BNUZDPz4Y7TB5mmYsW/4wfEEQUvF0//rQq5SiCVhStWNgR0eEHl5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNM47IEniWCWEAiAKvbOGdXd/Nno1636Zy33ydv5j2A=;
 b=a6okuWYjBsUUfFRpsjJnfiwNPPrdeougCiCdjRvUYV13Z9sqnVfZW+7WvE7mL917cc6bT77a+8CEqTsCCFkbBOSOr/RGRtC+b1XICDj27Wdw12UfJO/lh1VZCBI68udTFeesgS2/QO0qDCVJsUlh14Lm2rVGkWm9X3zkNzcegxBshyhysfx/31hPpBYKpUSqr2npP9XPEuAQe1Zo2r/WYx3Ugdyuxi9HgBSRInApCk41dwqdgcsjfmN70st5nGGh8KSRZ8McKWusOPSGYsCWueTfBuWsbK1/rXr8ZK1SvmzC44a/00WIVUdf6Na/F6248YtQIn/Hjt7x7dbsxJjFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNM47IEniWCWEAiAKvbOGdXd/Nno1636Zy33ydv5j2A=;
 b=nVXMKkDzkmWgIDBVur+c7Xc15xupOSl/ZH+lW2NkrHYaMgYbWplujFSMb6TKmlwMyDzZD70RsWXUqHJIkAJ8dWjdxqZeozVOmPF09K7m7qx3919Azt0mVdPLnlbe6clybCJTSJ7RUN527VVvkVfdVi+5idxkNlTYFgURqGMlHhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS8PR04MB8213.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 18:38:25 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%4]) with mapi id 15.20.6134.026; Tue, 28 Feb 2023
 18:38:25 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, franck.lenormand@nxp.com
Cc:     vijayb@linux.microsoft.com, code@tyhicks.com
Subject: [PATCH] drivers: crypto: caam: jr: Allow quiesce when quiesced
Date:   Wed,  1 Mar 2023 00:07:58 +0530
Message-Id: <20230228183758.448396-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221054219.2142012-1-meenakshi.aggarwal@nxp.com>
References: <20230221054219.2142012-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS8PR04MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c7d6be-1e33-4710-7e14-08db19baf9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXKBN8yXyytI+duPA5CW10nIDx2iU4kRKr+EaYKc7Kytg/oVtyVnXOFHSOWlZtbapXeiuDTpWY1+GPlYHKZqgxMpLtoMCBy+thNMg/ltimHFMk8AATlakNHvdBZK3WOtx3lnnWh/+h8Uz4gyNigr8ZY5njeyPxO+aGBV8J/4YlNQdc0hG0gNM6/w/xuidJP7p5hqovw+d5vpMfWSTb4phHD6DdNjoFo1Q+xM1VeHso3bD+wYqg3kR95C4ECzYyX8xlA+bJmujB81/LziaWaML5uKBU6TOHVl+gZacv5j2zjUEKUWira1Gm8a5DuFeay4uN9+HsOlrbEB0obtNakHvfu9iGTD1CuxGN/phj0OFTy26rB+0sx2OndCsoTkk4gFpm8kEnMu3+IFg70l6JXih5otVyCF/tFwX5+7GjAJO/LlBkpJ9WBjn7QjjpMpb0EDXVIOXtGplkLjrXmXj7J5BpxNIilAVn/WS3AQ2jF8V2I4tmOteljA2KxRvsymo+npGBMxQYwFGh6Yh+MM8mnTsiyiw+Mw2tqXYhlppPvNQp0Vknza/iXfmmZXNlpyLNzWWOYT3d01tsc10W2wiP6GGln928GHfDlOZYkJJ1CNhzYiOzXlfOAGXJ7Nj7X+a0TDW/TkQBY0LzEDYYJ+bEWc6wB9cQBtdz4aYClCDdTvH9sI539+N9sQ7kxBEJRcntRo7STCW3AJPQjNm8eZhYUpOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199018)(83380400001)(36756003)(478600001)(316002)(2616005)(41300700001)(26005)(6486002)(9686003)(186003)(1076003)(52116002)(6506007)(6666004)(6512007)(38350700002)(38100700002)(8936002)(5660300002)(86362001)(66946007)(66556008)(2906002)(66476007)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MdRetrs5R2pbaQEC3+Gjl5U7MROgc9r9hV+HMC06S/WljlVrT1F5dj8S2YAb?=
 =?us-ascii?Q?3QwERQ7Hb2Y0F1uvahKHkBGa5Ln0vptP2aN0wAJHqkNst5J3w0lnQCgsfpD8?=
 =?us-ascii?Q?3uN6NGJeqWIsOG8vt9Fhg3wFcpgIVCAVnblz/B8U4R3NwTBNipPbm5DnSecu?=
 =?us-ascii?Q?uKwjLjlS+k9Wp639YqlYsg/RPPZ6ywdmjgbeHoJj2xUYoQe+mjSLG7zpVyNb?=
 =?us-ascii?Q?lRsX3bSCT7ELGxHVxYPO28YaVNm/4qCvqhJRoV50HpC6yQaB3KeV/GXkafPb?=
 =?us-ascii?Q?gHLVMLvTAcfeWhE/Eyz5QUXkZ+lT3P0bA4bGRcLKdru+ibsq/AhyknjOVknV?=
 =?us-ascii?Q?q+4lnSL3JnqVXz+eQO5OZp5lLTxKMyDNk0ciQsci66BgxaAm0xJDGmCZaTMt?=
 =?us-ascii?Q?9ygqICW7kldZyJcp/ZEvJzFPGlqPabQd0tUqnghWpntOjR5PKiXyZxbPtg+9?=
 =?us-ascii?Q?oriwKxSJ1YgIUodxWmZdE2vH0tVytDTZqZOcDvfwvXgopi3vRM4tE2BRTZDx?=
 =?us-ascii?Q?qamuqkDnq0SxBJbZG7o42yAgOo9L8/xxQsVI5lEkrIaRSbEQ0miY+nhYwo0K?=
 =?us-ascii?Q?Tgk+AJG8QSf+4l6vZY217878nStL0A8FOs+q6V6LBLlM0s9KQTH3W1DBopUd?=
 =?us-ascii?Q?YWxmfrcIQ1MdtI8S02gOoe2KY2lE4omUBQ/658NVGW5+/1G1XAL9zdLheqiE?=
 =?us-ascii?Q?HeGXspNl3ea1oUvD4qZ6c3n5UnEwTqw/DQZ7t8dJ1PYI+x5N+YCD+l0C8uOE?=
 =?us-ascii?Q?4L2+i8H4VglIVjcXgLGXMfUarKYvv8j/3YmiCdoY2Q5jxYRuouyoLUJnAnga?=
 =?us-ascii?Q?4P3VITgzFOF67s6vPk/dChBwDS45fzhQJanS0CniC4DInP0vrPnIU5vHZfBb?=
 =?us-ascii?Q?L+nrvDg9n9PPC7B2Yd6pjGMf7qIr1PRj6WmQTtP6g3NN8QyRAS3Ze4dbGg3K?=
 =?us-ascii?Q?JMw5+/eK7aB9IVM5pTqTokOtLP/JzJlmCDZ2SixX5o5csXEAgrKAkvpp3qfl?=
 =?us-ascii?Q?fZehfO6E5HIUq7zFQGYgtcmacoOAzoc7e61gORpIyBcs2VaBheBEyqSr/tb2?=
 =?us-ascii?Q?TkbNu4An9wtGe542Fs4jo+6IShzC+KHHW64+DhvpGvG/Zx4/2XPfj054sfSq?=
 =?us-ascii?Q?7jgS3IRASCPiJOcUOYkH7oXX6plu8EBphrRw6xHPDQEmhoooBQwDbdCmCjDH?=
 =?us-ascii?Q?eTvCSK5rRQZySVJh6l7X96nQ78EvakHYMPY+eBaNdqNhY11Hqb/thl01eC4f?=
 =?us-ascii?Q?3GjAPA7cAWvF1BPGoE8AsxzRY9Wfk+uRmwI3DCYsfLXLRZN/JxqlsGqWfrf4?=
 =?us-ascii?Q?BbUu4HMtYzImrWqD7h9T7ryRGIbKvamWEPiRbz5idvvpIL5HvqBmPmPGA9Fg?=
 =?us-ascii?Q?3rlHDIn5iK94J7mFcGMnsxdjcyTdOgya29QFEbGYVQM1ZY+/UXMfxPpxwusM?=
 =?us-ascii?Q?GjOw5HR3xuRw5s/ODQF7nCSgVDQuxutqbfS+zIbgmj4mOId7oR3M2ViXNp7y?=
 =?us-ascii?Q?lUBNlZ4zv2KxVEQwEP+OGx3mIGUbu6wjruy1B4kBCmEMAdQjsj3ugSWmdpvF?=
 =?us-ascii?Q?ajUEIEh2D89Ywb9P0UawPjqVE5btznJKDOFQkMBzs74MaKnf/96j6ORyfvBq?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c7d6be-1e33-4710-7e14-08db19baf9ce
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 18:38:25.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOFW/iQ5wBG2L4AGGQn8/8aOTvCtexwaLRKiUsu50LH5b6CkXiOPJGZmWI5i++C5qcw55Kmx8O0RzESyVtDG/owaQphWyvbS1CPVwJmVncs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8213
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/jr.c | 55 ++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 724fdec18bf9..eb3b9a7e9a35 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -4,7 +4,7 @@
  * JobR backend functionality
  *
  * Copyright 2008-2012 Freescale Semiconductor, Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2023 NXP
  */
 
 #include <linux/of_irq.h>
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

