Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB636BC5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCPGIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCPGIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:08:04 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2068.outbound.protection.outlook.com [40.107.241.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF979136F3;
        Wed, 15 Mar 2023 23:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKts8KHYEuPpWrvmjCnTEe2XBfTCzD6VwQBA1QYov8/RADNFSs92QdcT2AlGkdj8mdfsHiRvMtjJTtMPG74SzOOUsf2RSkWDgX05Afm3SM2wKO/fgK71kvNta05y69Dt5eJELktfRH1HmLWp432mGAIXWuKg6fJVal+0VLVWRu/SWDs6SfPXBQatCEBMFYq6ymtwztDKg5QVHEoP4N1pZSIS9eKZHp1mBGtWCZKGlaGkPGBDXXPYxtHbSbMBR0sxtoWAuidVJeeCgchKCmXDE3yREujbNL69tm8obmUKh0mqpUJiiDlzU2FEBEkotvSiLFkT2o42WFyvWTyxhcN9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZU7mdkg8q2vIHljpakZrveryrF6x5uJGidNfb5dqG8=;
 b=eeVvAgsLuVYKh81trqki1BOfktY4+sbrgUyMn/ZyUmM+caL5pWFaHzzW1AG+LrTsF0JtN3GxOaF3zmcwo0Cmf7Q2QFfbzi6cOeXWy0SB4gbq/CsetAlbV59ylUvKB+1uqwf5acbjRTDqAdQD8k6S/8tEX8TOfOoJ1PenfzaZYuoOON2S0ZuCPmvmxeXFgDd1j7+v7GANafwu3sOodVYLGI8X34hhJauUg0+XF/ulKdi/CsMGLWIYDumiTAi81XqJMXO1ZhzWTQQi+UQ1Ro2hd2PRnTQVzO6OT3A26Qf8lW/FvQ/x3gsHL/QtBOVa9aRVWKPql+gzBOeMJHbW+LkPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZU7mdkg8q2vIHljpakZrveryrF6x5uJGidNfb5dqG8=;
 b=g/6cPPy7iKVLTsUJGqLjf5NrLGF0wlagmMYUP0I4wTvYHeBuAkEKVQy6/IGu3HKQ+9bwIPgXtqWxwkyD2uoHR+JfW/AYhp3h3ndEUR0x87jcM5XzlbvPGy49w78Pka9jWR75tb0W05uogWCzaWycrosPf1WZfEa3Ccpg6O5vN8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS1PR04MB9334.eurprd04.prod.outlook.com (2603:10a6:20b:4de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 06:08:00 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%5]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 06:07:59 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, franck.lenormand@nxp.com
Cc:     vijayb@linux.microsoft.com, code@tyhicks.com
Subject: [PATCH v2] drivers: crypto: caam: jr: add .shutdown hook
Date:   Thu, 16 Mar 2023 11:37:34 +0530
Message-Id: <20230316060734.818549-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221054047.2140558-1-meenakshi.aggarwal@nxp.com>
References: <20230221054047.2140558-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS1PR04MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3fc986-b56e-40b4-95eb-08db25e4caee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b30NmlixCJBmb1GsDT/6DL7SLPBx0gN/p49n3NZ6XbnRjhX/FEkTz8MkGNjG6xSLbgyeaIQzfSgABnW7/9PmmxNMDZx03qxzAOnSfmJvN4hDjMobII5frAHrsCt28uTMfq970PryHbsdinxcTLriIZkmG0rHDB4OrUN6GfL18HC9C41ssbI/IDVxH4QGqGI0lnBjwZXLQb0LuUHoxrgzkFhatVTxnoSJD/SUdbLC7kaaPviYkx5X2+0IOyo+7Ofyxy/TpDTBCJgkRyeBgo2J/zQzS3TE3XKFXik088eDemf1TKxxUJMkIL1m5qpQqaU5wWNyypv8Or59o5aRGz5WFzmd0WKrm9bUe7R+DoqPGFV014Qg4gK68uT+pXCy+lDXEbWiZFOeTKf/WDBkiEthtXJFG3nxtprdwdMmS8fEkZztxk8qCZL5gF/6IyP+wc6azqf/mSyLo7qlFaPIyAryKfPA601Ag/Wbi5sCGvT2XtTqueSIEuUjx0iZV/JpVjt+eNUCUwBeV/BCcW8mfdGn4xyk0tE3w3x+Aeiw+Uclfmypuw9Ci7i/fHj9RmuUXIsXyHYhDumkUadfxpW8nVooHXLJP0gle8vl1OiMGAme+qe3no49xb6hiPDxndXY/FNgPBO7+l3fNG5AtrdqH9F/7BTZKVP36Oz4vbJV775vwG82jUyUaBgdagMnS5EqVQ18u4htTLm9c83PArKDgDLX/NQDyDHhIw7TZxaXagKWTN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(41300700001)(5660300002)(2906002)(38100700002)(38350700002)(36756003)(86362001)(8936002)(478600001)(52116002)(8676002)(66556008)(6486002)(6666004)(66946007)(66476007)(4326008)(316002)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(9686003)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k+ko+L0z8aKGCbR6jSkkdeDV9p0oJhze1XwqBGysPVbAR/hTBnhWIrGHxYVT?=
 =?us-ascii?Q?U8jcnVJE+QAu3zZjvFyGzZnwVWQ+h+ucRVIsOHVV6XIwjMFF3LdRscSSEl/t?=
 =?us-ascii?Q?SxmQfeZ/pA4uGKKRYIyYnMeFZxon6IRrarxdJvJzn4Uxm+sVG1Xq6/YrK/Qd?=
 =?us-ascii?Q?XRzvMt+drw5JdH+re57Jl2Mi3O/mAQtjG/2+YUcU1hq7Ns/N5VbanpMMBPEV?=
 =?us-ascii?Q?mqHT+RFpu+p0f/1R6dkAJiG5f5v/PR5P6IU8RafVdSXzn6WoyMuGwaNILwNH?=
 =?us-ascii?Q?5ifTcEoNMoGPo1t1zA+B3c2MTvhSVzNTwsIeWI6wXJ9EdNZg7I2IAi4mBhZQ?=
 =?us-ascii?Q?pxv6oyCFoXKSRbNxAIAllQTfOu3E2HC6Q4k/GcZLEJj9sPU3Rz/N+1GZJQRg?=
 =?us-ascii?Q?+9mrLBE0WM1St4PRbkULTzjP3CYe49tqU0G6OSisgEW6bRKEpNuINwwCuCvk?=
 =?us-ascii?Q?GEXBuX3MdGqnDxM28pN8mMLfQuiNTOkKardC1+lQEyzCqhXKoo4uf6PwEdIt?=
 =?us-ascii?Q?7FrFR9fLy/yt60caShLxee6W7tNKM/DozuGprI4Kg6djY8lLk/yfR5PcY/cO?=
 =?us-ascii?Q?SoXAz9PWU8UsJAbkW1cR5XyVAbZ/lXSLQiIc0sFHwn6t8mpF/Xsouzs0Dtke?=
 =?us-ascii?Q?ch06ddDqH1BHDyxplbIOWNr2LIPqwHPbjA9tmxl3tTAxbVv0SOKCSvMz2pOB?=
 =?us-ascii?Q?uHnk4eHhZTuRoFbZiUOWo8FlBfcddTriKPZZ8c6dW+Tu/HkoxF7nYfuzBuLf?=
 =?us-ascii?Q?SNzPnPh9UMpmxPE6QD9G3RrKuJagNg72qgyYhkA9Wq1a2pV2wzJ4eOX+DQsA?=
 =?us-ascii?Q?YF+fpalcHK163zSvw5lNDAJzNLWM2Oke9G9VNHvkiNe6lD3N2g4MXDyUVLZT?=
 =?us-ascii?Q?GpGtRUxtu63MQwZLEU6u4aLac1ocGpe2WElDV8S/AhSzjVqT8AAQ7QbqYdCG?=
 =?us-ascii?Q?1FHaQmnb5YSyaLsMY7ASjOB3YqZyvaJ5H5FZLH/rFwnOHldtHFZWtUi+H9pN?=
 =?us-ascii?Q?oRdEG56+frwr2TmOe9st3flSn6bnBR05zFxYDXYrY4M882+gHuQdiymuXs6z?=
 =?us-ascii?Q?SMVsHjoJYi+5Ut+IlkAit4fv1x8ZROjMx+5DDYnHcq55PqOyIADqKCxEfwbW?=
 =?us-ascii?Q?naBZHDfjSkYbki2CGJ82P9rsi2NPv+RkzfJU8zDW9w2CwinknDtHWP2TVPMr?=
 =?us-ascii?Q?tVSie2gF3Yg2sM+/oMYMgAq1Tcs+G3nJez1cHTbi+OlJin5BRosE9kz6Yk7S?=
 =?us-ascii?Q?c9V8H0h41oPof8Jk7xee0Z7VoUHJhCu/5ODwL1od409/KSuO2HoV0UYex+Dz?=
 =?us-ascii?Q?jN7Cg5lffIq48wpltlqpA9gzHkFdL4sU2pRzjCC18YSmccG+Evgo6hyObRre?=
 =?us-ascii?Q?TK7f3KWknYuY/a9JppgJcbh+BCUzdgVMYjdSxQoArlFJeC3w9LsIpSI208C+?=
 =?us-ascii?Q?xhu6fETmlLGnoSvsm6m4XqCLJ3onafb0xNx6vXe6QY0u0Nofnqf4YHtHPWN5?=
 =?us-ascii?Q?4j+foQzVLsPCyjZpToCToYzd5pI5v48q/v+fchUf34xgtLXPGPO4IIGPiiL6?=
 =?us-ascii?Q?AtmA/cMfrlZhmtRZ5ZxmVLY998tIfFOIclmBpnwbsCE1SV0WiLuOBqIKAE90?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3fc986-b56e-40b4-95eb-08db25e4caee
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 06:07:59.7348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcZJzMue737PE27Y+lnVcObrSHgWLy/NkEJvTXkFUO6i9zQA4yF/o1A5rRzsXgoovz6EBFyJAMkgaDXCJF0TDiDcbLQMHsDVvQjH8HM87ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9334
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaurav Jain <gaurav.jain@nxp.com>

add .shutdown hook in caam_jr driver to support kexec boot

Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Tested-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---

 changes in v2:
	- corrected alignment

 drivers/crypto/caam/jr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 8745fe3cb575..28aef9ba8eac 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -198,6 +198,11 @@ static int caam_jr_remove(struct platform_device *pdev)
 	return ret;
 }
 
+static void caam_jr_platform_shutdown(struct platform_device *pdev)
+{
+	caam_jr_remove(pdev);
+}
+
 /* Main per-ring interrupt handler */
 static irqreturn_t caam_jr_interrupt(int irq, void *st_dev)
 {
@@ -653,6 +658,7 @@ static struct platform_driver caam_jr_driver = {
 	},
 	.probe       = caam_jr_probe,
 	.remove      = caam_jr_remove,
+	.shutdown    = caam_jr_platform_shutdown,
 };
 
 static int __init jr_driver_init(void)
-- 
2.25.1

