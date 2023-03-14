Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8985E6B9DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCNSJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCNSJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:09:28 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248B0199D;
        Tue, 14 Mar 2023 11:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWwYj5AXIxEYm1L17ZZZ1zr/VQ8gXyqgENN7DfSIWaJrxmX2pmk7R+lKfv8xjc+lzeYOQpQfFoWGmi+t371DLqpYswUiSkrrWvn+vzbpKiN92+FbsnI4Lt0w9X9L2+73693yq1bA/CFM+k6qkL6OnFnzSPqBwpptR6oGFuvfqovu6nTnERytYeEAqGjuwopLVZk99yd+lzii5tMx0AOA91h8HsAd71FU0lfJbtp5ayGYa/3gMKHvMFNT04GXHntyeFiitFn8QUIfxctEZZ0Znqz/Y+IIy/HC6XPMBd2Fhv8FrurLvmFL5t+TMr/UNT0RBkLZTDhiBUWRoibAbkfmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ddnqp9LKZO+kpQZOE+BmOXoc32auHqPQBWLLp0CWzuI=;
 b=Wht8UB1QbuI4/BgE+9vVM6QtkVBuBGtJiy9aY/G9hK8YicQ76eyNLCSOsHScTNsRSKFnQdJOLrDh5zguIDKUqztfc3yZI2znXrWZeh/C0S/ksr1tCInvqs32u6PSR2JYr1dlI96Uo5FjBmVy4nGN/2PYYFTYchyYQsg7VNogq1Qb66OatQKQl3X55e20OQ3sRMAEZhbYs8lH0uUaEn4DVBwET9+XqqBUXEyE06Gp8r944oN7ri5onXDr2X48a2Kp0A8wndQZfdh/wT2Z33HmnxGKBUr+nd3nmU9699eKN6WlVv4+QNuFwoqhTzS9oLioMJQbymYL32v3wMysBujr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddnqp9LKZO+kpQZOE+BmOXoc32auHqPQBWLLp0CWzuI=;
 b=NGXyWLuWg/aTYT4mdED5bXbR40WcW0nA80ZKSUQ5NVq3bn1s98PG1HU+cAmNGlKwATPP9C+4DQCYg00o6BUjc5qRHqQ0E5S7BN2W7y+Xk0NdUtQbe7xoBNESw+uy3/g6CE/GCOFPWmlMIVCYj49KKzJUUMqf4PVOMZHiWhzQu+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by DBBPR04MB7755.eurprd04.prod.outlook.com (2603:10a6:10:1e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 18:08:06 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 18:08:06 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: caam/jr - fix algorithms exit/cleanup
Date:   Tue, 14 Mar 2023 23:37:33 +0530
Message-Id: <20230314180733.4167836-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|DBBPR04MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: e55e93f6-4d29-4b3a-13ab-08db24b70fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCR1SmlXsCJ8wuQPOXmqHddJzxmPUT6gtDSIUKx1Z91tqOPdGXJ6qfo95b4+6/7ipcZ2lPma09kr1PQu8/r2OPQ8JHBMjideMMGRDdm5PpHKlIY9861xZ3SLzTxVfqdJQ6x5776foR9YoUabE7WEIGkwrHQRvhH407v95TD9v5nBX7qXix+l5WZDwNmbESYGu0XHwM7NmRdZ8jjIhYNnQV2IL16mU+/I37LtGCUt4Zcpza28GWWRGG/pH9mezS9R7QX0qfE/ZpVpGWvG/IKC37pn4GhmnAhCA+tELZKsUb+t0huTSrQY/WoQfo6K2/U+KB6Oyw/4MwseDjgBbTZyEl/ZRtYRJuG5MjRIi25sX9ohkaqmMkdt3D4HU9uLpfVTFMePZEFxNABixH2g4bJ/Y2nFuqty0DI2VlpNcflU5SrDOuoyWAD4ASiQa4HjlJGcZJUpk2aJGgridlxndnYsKedTM6IjouH7XAxa/M5oadPaSsWNL9aSaJQMenq4l7hxIczL6xf2X23iVuSFcxABN5bwJWqyd0j3AyPzQOppWn8yIXr1p+ng6hNV6V996pEkRSMYy4jg12oDy3+YC60j7ArX6w0gkPmWX9aqg2tsJfzPFofV1gZOghd2OTvYjMOjW/a7hAtACy5G0Sni1+SKV6Bq2p/bWXcfEhXoEw4KkI3GjA0lMoKxJYefx8z0Ugzu+vMFEyYO+WqzKsQrxtDedg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199018)(86362001)(5660300002)(478600001)(9686003)(2616005)(6666004)(36756003)(6486002)(2906002)(52116002)(186003)(26005)(1076003)(6512007)(6506007)(41300700001)(38100700002)(38350700002)(66556008)(66946007)(66476007)(83380400001)(8676002)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kdJCN5HzPSbg8+iUoIKBOaspMafeN8mQ7IBELYuRcXhCQf4Eo3Ra5aMZq6C5?=
 =?us-ascii?Q?7i+yaVnCxPPY+Cwo0kVPdoei1hA7Tq9wU2+iog7zrW0Qtb4y+ouJOi01N+Vv?=
 =?us-ascii?Q?PhWsV8Tqgf0QZrRIn1IvHgauJLAaneZzgxAFVcpa78b35Vhu+1+ELnU01Bhz?=
 =?us-ascii?Q?t90EYXNa1uVx5yPJTEgqNcdvtimn5An6gadvuD+f6hXRAA8OSVBKRcrSd5/N?=
 =?us-ascii?Q?u+o2zkZOAaOKcZPIcoR8jG9p47asOAjbJrtQ6Due9Bf49y+4BSDadvqY4RdH?=
 =?us-ascii?Q?1ORlSGOY4mR+5oYcQPQuonSChU2M6/bL/DbbN132RPVKS8XEhA/dIvJbOeRb?=
 =?us-ascii?Q?63w8VMphVhkjbAW93WhUa2XRYMdS0fI++PtmZJzljet7oBDpg/VfJ/5+Q6x/?=
 =?us-ascii?Q?ulhrHyT8/QhGA3DuE27e7jJzZc+wrUOw5dIgG9bXp3YDwMc/Jw+p3loaTMe4?=
 =?us-ascii?Q?fHHmz8SC5NUqun0U/9ZxXyxaGjCpG6LMfpC/4i7eLk+Tr6Zz5tRxY8uBlPiE?=
 =?us-ascii?Q?GzdoLhBllViSb9wbI4NqLFYVK78UUa4/ajum2v6HWbIuTnDRKcfvFfyDmYew?=
 =?us-ascii?Q?1cJsm56REQkH24WylqLKT06TgH+ZjblUzALYSjCwXlMnmfhrUF3rOGFTKRCu?=
 =?us-ascii?Q?+x0d5roeO2w1SLr0dyninbP7gPnoac/u4l9kq17M8fUFuzZWO3JZe4B0nWjP?=
 =?us-ascii?Q?gZFVCyiHABSJu4wF/iBRyhru6M+Oy/HepHrDUPLkVrxdthbFKOG12GBm4FNV?=
 =?us-ascii?Q?2rkb5bKdUrdKYnhVJIgarp77nPP3mRhw0+IwHPjkqrEPitEh7HiOlHWLK8b0?=
 =?us-ascii?Q?fNO5tyScAlIN74uArID5TmU8Susli32vFl+xoLiXE7/OvcB3vKRAUAQ+byEi?=
 =?us-ascii?Q?Q++K+L/OxOrd6AHtW12jCDQIipdtwyYhbzckKXUjCtLZBHosktwY3nGBnHhq?=
 =?us-ascii?Q?5YH1POg4ZrooZ2C/l3u2ZOnOI5qvRFGJM+1cH9UhN3GciBwV1wfaqXys8p33?=
 =?us-ascii?Q?9cNHD+Lx/eE921Kir8vhYUD5H7bwPD1vZ9DQpbbp3Oc77GID2hS392We0VXg?=
 =?us-ascii?Q?CtKltY/Esr5bZo2HLP6uqB97y3Smdzi9r3qbhpTlEcL/Y49PPXt1RKvDsbFl?=
 =?us-ascii?Q?MguDEeVqDY6Ibg67ek9gG+uSj39xnh0i7MhZ2P/Uh9E4u3DBkSkCGzW3Ipo8?=
 =?us-ascii?Q?soQ/X2gfQQF/0y45aBkKfM1Yokgwg7tZn3QZ7/Z0KaBFwh0i/qObkFJkBbYf?=
 =?us-ascii?Q?0I+jLqT9C2cLl5oDGo3kItlU8BUIjiHZkri/9t4uEQUbjHgEFj3917LyPdI+?=
 =?us-ascii?Q?7ttRokJSJxWEx57UNQbGJCfVasuc1gTNzUE1K147aK+OcClsvqM21LH8cYbQ?=
 =?us-ascii?Q?pznz+ndkVCuebQA50u+MWbEyOAw99QV4SCAeHT4CosAsbNyj2l89UFLfCf81?=
 =?us-ascii?Q?9/pzKrs9p1NGzmYdmMDQYX9jizMX6rXbV1P/K//RNisWd6epYYHhOnoBZWKK?=
 =?us-ascii?Q?r3njkEi9dYEA2TOoqYHyplULHdl+FBVXefp+nyGgJ5v1d1LxyWVhXPwBYr1Z?=
 =?us-ascii?Q?JyIYh0H7wa2o7+NgjJIZTMQ9doUGA7KLk7+wvHH9csYX1zqz4gLoUYgpUZVE?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55e93f6-4d29-4b3a-13ab-08db24b70fbf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 18:08:06.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OkOBBCEoYhczCl+uVo+Ho7DhAi/KkpuOkSFiwPDNWjC30EOdpbytVq61T+Vj1UgydeeeXNRTZISA7pkVk2vt38+3fDydEYk206NPZ4BfDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7755
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia GeantA <horia.geanta@nxp.com>

Current implementations is not being able to gracefully unregister
crypto algorithms from crypto API while there are users / allocated
tfms (cra_refcnt > 1).

When unloading the caam_jr module, the .remove callback for the last JR
device exits with -EBUSY and doesn't perform the clean-up
(crypto algorithms unregistering etc.).

One side effect of this is leading to an oops, which occurs due to a
corruption in the linked list of "misc devices"
(drivers/char/misc.c - misc_list)

Signed-off-by: Horia GeantA <horia.geanta@nxp.com>
---
 drivers/crypto/caam/jr.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 724fdec18bf9..9918ae0a33a7 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -27,8 +27,36 @@ static struct jr_driver_data driver_data;
 static DEFINE_MUTEX(algs_lock);
 static unsigned int active_devs;
 
-static void register_algs(struct caam_drv_private_jr *jrpriv,
-			  struct device *dev)
+static void init_misc_func(struct caam_drv_private_jr *jrpriv,
+			   struct device *dev)
+{
+	mutex_lock(&algs_lock);
+
+	if (active_devs != 1)
+		goto algs_unlock;
+
+	jrpriv->hwrng = !caam_rng_init(dev);
+
+algs_unlock:
+	mutex_unlock(&algs_lock);
+}
+
+static void exit_misc_func(struct caam_drv_private_jr *jrpriv,
+			   struct device *dev)
+{
+	mutex_lock(&algs_lock);
+
+	if (active_devs != 1)
+		goto algs_unlock;
+
+	if (jrpriv->hwrng)
+		caam_rng_exit(dev);
+
+algs_unlock:
+	mutex_unlock(&algs_lock);
+}
+
+static void register_algs(struct device *dev)
 {
 	mutex_lock(&algs_lock);
 
@@ -38,7 +66,6 @@ static void register_algs(struct caam_drv_private_jr *jrpriv,
 	caam_algapi_init(dev);
 	caam_algapi_hash_init(dev);
 	caam_pkc_init(dev);
-	jrpriv->hwrng = !caam_rng_init(dev);
 	caam_prng_register(dev);
 	caam_qi_algapi_init(dev);
 
@@ -136,8 +163,7 @@ static int caam_jr_remove(struct platform_device *pdev)
 	jrdev = &pdev->dev;
 	jrpriv = dev_get_drvdata(jrdev);
 
-	if (jrpriv->hwrng)
-		caam_rng_exit(jrdev->parent);
+	exit_misc_func(jrpriv, jrdev->parent);
 
 	/*
 	 * Return EBUSY if job ring already allocated.
@@ -595,7 +621,8 @@ static int caam_jr_probe(struct platform_device *pdev)
 
 	atomic_set(&jrpriv->tfm_count, 0);
 
-	register_algs(jrpriv, jrdev->parent);
+	register_algs(jrdev->parent);
+	init_misc_func(jrpriv, jrdev->parent);
 
 	return 0;
 }
-- 
2.25.1

