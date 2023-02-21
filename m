Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D1B69DA77
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 06:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjBUFlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 00:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjBUFlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 00:41:19 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68851D93C;
        Mon, 20 Feb 2023 21:41:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHvDTJveeyR1ESbhsQ7qbj/B8zMw6SlgO11K3DWydcLaBHXFahTMGZ2kyxAByjUcvjdrjPJzianOh4dga57ZduPiQENutTP5XsDNlMydmULubO1yP/C1ke2XP4YfYa06FwyfPAP69YTh1Q4cRrBD3oESaMPHsaAXi6TcG/aUDF3ROSnvnCl9mkksOUGP61guodvi3JtnOsdHyscvu0/vqjijFRhQ92dLLgZqXzn8eYHxvxTEiJJlXvyMUP87BizQW79nx5lOaNbgx2FMFPwNFjvCdsz/bljHdVJd0KEf6Mrz0mdTvWUfYbZitRtzxYqs90DJSTEscMQkhZCaXDRkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7jBEZCklkP/XzXteWJEE6Cz47LBC6NYxQELvdV7c7c=;
 b=C1tfio1uEBxXaA8YflvXojow8xhS01b2yThbOB1BS3HVc0Ai/gDZx1dhgLmGgKDcACHKzS7EN5pnYg1CABqSJNlxbv8k+af1gtOgS0sk8v+jppgkCHb3MoBivicwbTDePdEEs9aXMzWKRWTvhB6/asBdj57CQEMft7LffxT/kpL3dCp4B8DNtKTNm7XQQTvFgyk57w29MBq7zy2tNhdjDwkLjf4xxWycRNcD58CFCwLbmciw1wYjy6XXwetPDc9Oz0p3E8PfL7FlNb1z1lp4WQtVlrw7gITnvLXXnjXwz3sqtjNpS1TuPiLctxw2yTwcJg+ngt78alO8WQbXuc26jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7jBEZCklkP/XzXteWJEE6Cz47LBC6NYxQELvdV7c7c=;
 b=d8oMQry5LBUIcR2KvPf5/jHfX73w5yxQGiDxG1i1QmL2WWdn9yAgKleOsNTQuhz/QeMyGP1nVlPsFthvonSMGDjo+Fxg1wELb7fdRHMtGRM+QToqbJdsf6qcAqznuaTt9GHkTNW1NbYELUBHKb3Vs4nlt7Fx68gilDAYVtaQqgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS8PR04MB8577.eurprd04.prod.outlook.com (2603:10a6:20b:424::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 05:41:15 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%5]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 05:41:15 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, franck.lenormand@nxp.com
Cc:     vijayb@linux.microsoft.com, code@tyhicks.com
Subject: [PATCH] drivers: crypto: caam: jr: add .shutdown hook
Date:   Tue, 21 Feb 2023 11:10:47 +0530
Message-Id: <20230221054047.2140558-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230220105033.1449263-1-meenakshi.aggarwal@nxp.com>
References: <20230220105033.1449263-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS8PR04MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee0cfab-15e1-49f8-3db6-08db13ce3f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+7UVPuyrnO+Yptn49OzoOgzPh7fJNKKqWg3Zg8crIRth6bYVg8aSSXGQtnuri/aGXWbiKsFm1Nn3A3DpkqhwVPC0Qf62VI3im3vDjzHzdSxd2ZF4MVSU2vTn/oSuCxntXLWsPGOnIKy3q/YAI079Ly0ZmolWDksjUK2fnYHmwlowCsBqgpDKOoVf0lOeTT3DepqeND6ORiRFQbv/g6rz23/yWnHq1axJtYoFw/UcF8nofBxbgFhcIXvL1U8oW9OyFp5vkCAM4SPwUa5l1R8VnjzmiYVI5gl79ptVug/JIApJAviHQWgpWw6aAsLKgWzicAoa6DNi039zm6qk0HnUlxonFhILT1xyWumi6r0l4VZLcaOITiFizbRRg3IE1nSlrCjjnlzwD8M+XcMEekLmuvhKEsttPpVsyKmI09wlkUVQoyLumInjba61LqfWISpasjNWCaKxqtR6DtYv6RwHQyXXkUGDY0RACP9F6o3v0fIFzK5p04GGhqAha4A2zLE9q16BWO3y5e+ygzn507UL5XvgC/JRyMzeuHkCeE8u7xGUCH15yj2GWxYVEpwG07v/yPIS6FQViG1FPH8bSbGn3ykvctX1Cq1RG9TWsjyT4Ixw2LLGz4+5PeyjmSB6wkXZaXxbNeWzidGIxVSneMg9TVQ+tEQkg8dDi3EoflDVzeuM2OIUAEY2Fbnm83Mrf2pHxHWrmx04f1q5w3tsXYRoCFgtlBI06YHTAY4dsF/v24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199018)(38100700002)(38350700002)(2906002)(8936002)(5660300002)(4744005)(6512007)(26005)(9686003)(186003)(41300700001)(2616005)(36756003)(8676002)(66476007)(66556008)(66946007)(4326008)(6486002)(52116002)(86362001)(6506007)(478600001)(6666004)(316002)(1076003)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?30Leq90Zle+MeIiwfqfyf38aXb7l10EmGJbvNhqDRKa0OZeACbkHIm+nxW6E?=
 =?us-ascii?Q?lrlJbCF0JSjeF71/SaG2DnSQ9Q8AoUgyj8fv7225AW3wcw1GwXBjXXQ69edO?=
 =?us-ascii?Q?PPFfzYxRZiLXqJd0aImIs/wGhJJZN8KPKr+aDETtQ1IvVUZ6YtPVEuGI9QZu?=
 =?us-ascii?Q?WFkOlNdNppdarLno83+HrZvWF43ozrzTJ6GO9MNHctoCgLD1mGmswbVcHUQO?=
 =?us-ascii?Q?APpKw+aJLXwNHbm9203ZlCPDZ+d7GAum6OCVXeqwxIfqH4HO7aL+c1uNOVUT?=
 =?us-ascii?Q?Cqe4a9uSNcRDAxsipkzDPYA+DeHZ3bHFQgSSH3xWLDASiOEjL1qhHdf3g9z8?=
 =?us-ascii?Q?XAfNcPV6tD746a+e62TIPt/6E3djMSoiUWyWebsT1Joz4lF0fdxTVXovt3Si?=
 =?us-ascii?Q?xLusb2pJMB5zWRvn+PU0R8hk6PdvG050rliDsIoq8+zAlbtJiX4JAq8aFPZa?=
 =?us-ascii?Q?HGEulRQ00SEyy7kjYcRTAVp7PeUwyBb1hha+pecWIuXufvhzdZLiqo7CvtmX?=
 =?us-ascii?Q?9I5WlVColpQAzqJldWAv4q5kzeh999GB6acD6aBuLh7h6SERJzwiIEEaIoXD?=
 =?us-ascii?Q?ELvbujEb72A/7XeycRIw/8u6Im04veBpJNCtsZVklIJje7BAWc/dqbwbTUMG?=
 =?us-ascii?Q?B/iZT7rVrIlGoJjfalKZU96+M+5nSxNuSznoPkxYiy05fBEvYNqVgkCGdqQZ?=
 =?us-ascii?Q?BhR1DVoCtz6faIap7VtFF211hNJJTea/hbcqn2Y6tcK3WzsdFhg7HWKxQ1as?=
 =?us-ascii?Q?AeXgtv5rEmp8O2b8ZiXzCrCNwDpBUJbKnEb4ZU8/GSHj0Q0DUPAnnb+JtFdc?=
 =?us-ascii?Q?oT3+taXiqV/+eSCj/kOCsTlUJ3OQLkX86Cd/L470zYPiuswyfF5W3GfMHK5o?=
 =?us-ascii?Q?Us6J+mBjtOvLUas1YunJPF0lMHcFMxEeXOUSam4otXTtIPK6Om+zdcWS7lHF?=
 =?us-ascii?Q?IXlR30EQRW2pGj2fIhFEinvhFhJzh7aAB98gXYJUTKn5A7cTZIUZYNsnLaCG?=
 =?us-ascii?Q?W6anPlD9CHmHZBw1w+85n0aejrjoyfTpPVlOh1PxYf1l713A9PxqU1WsZdIr?=
 =?us-ascii?Q?fyIYjPfzwu1HNRmdzs/kN/ceeaF1AvVUsnjtA0WY/a8VKvB8aNfSHYud8Yeb?=
 =?us-ascii?Q?RQXjTysXKKuo28ZvULHGcqVWc4rjqy6lSWqoamrghZ9FTxd4bN7yhEz0vpUU?=
 =?us-ascii?Q?yn3VMHpCvcNMZRg0kcIUjWVimD9T1YvqE2Wnphg9QUgX+hDb/HY1MB1qJJPF?=
 =?us-ascii?Q?K7JjHoi4oPlv5KwetV8vRZU8UFQwX/dMRs0yPTVwWOQPd5ZZFLfamVyo1bcR?=
 =?us-ascii?Q?PK4yhIwt/jbrdC1VotlYRn8p5ssky4oBUXpMEs8U86cm5y1jG8PzXTQBKyMs?=
 =?us-ascii?Q?Sj5wIt0vBup932Mt1shdR+/bSlEBfPegX3N6jyzaSQjwalDG1zhx0FgrhMnt?=
 =?us-ascii?Q?4iFL8n1Wn1Nd/TuUHYk7noowwelBng/TIvxR2f82utTVg1OVy6ABXpfL3+a0?=
 =?us-ascii?Q?k+YVFmP0y/Wh404XoZKMG3CkkoGzWOFxetuws5ukDKz8dJqxhc9Tm1VgOy05?=
 =?us-ascii?Q?f8GuuQhCpRcFKyE6EIHYEgqXKwc8l1IwLSI6oN6K/XTY+Mra7A3MgJ5Ytf6n?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee0cfab-15e1-49f8-3db6-08db13ce3f5a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 05:41:15.3875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eZogWMf3FlLt9istdMM98N6WgqvBmrvoWSZhaRj+YLyrWYYqfWLoss5zOiJ1OkY78USLH7kP5iYhNZgy43pBGX5kKsNrE6rtVcpngZPMNI=
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

From: Gaurav Jain <gaurav.jain@nxp.com>

add .shutdown hook in caam_jr driver to support kexec boot

Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
---
 drivers/crypto/caam/jr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 8745fe3cb575..a2a99d09b4ad 100644
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
+	.shutdown = caam_jr_platform_shutdown,
 };
 
 static int __init jr_driver_init(void)
-- 
2.25.1

