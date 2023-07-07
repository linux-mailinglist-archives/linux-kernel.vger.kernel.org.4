Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5D174A9A7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGGEGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGGEGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:06:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2103.outbound.protection.outlook.com [40.107.117.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A841FD7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsXkjT6REKY2c9b941TxU/mMeb6T5cKrPA+wNFWFESHHjSa4/Q5ehNcu5qy0fh+jE+sKv+xQdEx8kE4019LQhRDju6rejL17Y5bdAyOu0pWcQ3wp7HxNfXmZ7U6dyiZoAI1AxKbwoCzfBowbnJejiZuo/Xd2sUT/q8BecfnegN/+xviCmH7nAO1Gor6MMBjq/bLROQwrfsfy1fWsgb7fAwm9HIxiW7YsB/01nvFGUfelfk9FNgyhbD49m3e2zUqVMsABa9+1kQY/ws+uWU7l0UtOKW6JSzA5wnCEiht2ON3TuMhqonsBY4zDT0jWqOYFypShQkq/7yIR3BSy3aKpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLIjEIDSi/Gt4CbhogrAqQEpSG4L/IDdFUD/+RxMDXM=;
 b=kTZWl/jJQWJUbClz7YU0CVFMJqeLK71bwp8QD8MHJUfcY5bqmQMZHQ1JN5joAn3NW4U8VD4U+x5rxBSs8o7ssBZ1WA29BIznoqld9cfQrHelLx61oY1fYmyaT9vxmkyVXvGgXyAUCcTVft+n47zIyT5dgYQTKfIPcktXZFZCV1/69phsY0FEElMCnbnN3VREJN5hl4E49jZg9Im0LBSEv0Qjbg3sQelQBvPTWUYZ5ecXkzt9RJ4zkXEhz/kTvTF1cgxeV4G4Ps0hyUDg0AD9pvShxgwWPcNCaWKJ+Z98jBShooauHnbRt7zacSfEO1shptn3QHRntwpox8n2E1gTrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLIjEIDSi/Gt4CbhogrAqQEpSG4L/IDdFUD/+RxMDXM=;
 b=PAgW0rTHR86PZsTq4n9ZIS7fOxvi+eEgDvTF7SmXvnOrss6FyOBnhat0ihyWY6Lqg2Eq0HF/D+LndrcUWl43H2HMhDlvRXnEbkCQQceEGdKDmvHpqcSt2BzGABBBZ1StLDx6uqVxEc9LALns+tc0OKWebTEAUoE1TIEpQdjSa3Zx0DUXn4sD6Ug6c/rY/AX7aINTlcGFrC+9rfhS3+95ScmWuRWUMFBJMhxpja9qjf/+Ek0jYrmx/PX2qFlrC6XI9aUJMu6C2wenNZ7VnoAknk1atORryeVzPLlWiUZ1KR0KzavIk8+ZkW3iAtnxcFXnrPGFf1OZg8NY2AIkWvfZ3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 04:06:34 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 04:06:34 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/18] mtd: rawnand: sunxi: Use devm_platform_get_and_ioremap_resource()
Date:   Fri,  7 Jul 2023 12:06:05 +0800
Message-Id: <20230707040622.78174-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6d8d70-e1bf-4ec9-acf2-08db7e9f8d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ove5HzqVHf4+ZMTX9g0aJ7dPKdAwHWjAHTf5b3hrbicUD7g6KsLt53ghh84jLbt2v4YoSA0UYaMYbTtyIfpEmABzT1/8d82892RUtora31I5n4+zEW6uCuNMsuL7zTF+Dl+KwVi7dzFPQtkKGO29qFNtHyFyPjmvEPGPE55zKZj9g9HmHTPH+k6USiGWjh08Jwtk4QwDLMvyT5Pv0ENUGy7VkGLp0BV9pjLnIq8+2s5tc1w1prNJTT7Rv1seYneoXfmKTy7JldP88xDsMIWcxRpP+3tQ8ZD2Sy96KlUPQIJ1t4nt88Bl78AjrHyOpUmXjpRibXUyEYXjsB2X6PUuWfvZoGsHYI+WROYwKpvIL+eN6z6oJ8FjSDQz6y1QYWIcnXDD0j7qi8Au4xVuFNcky8uGxiaHM/ejgczASrgRfVM1k05mfu2aVWas16HBihXJbVcf5CdLarklKrMymRBwpzfnAyDAaAF4B8niwdw4IwBSbLTVrMucmLHohBjCo7qyyruyhOoLjG/55kdXgCHc4jf+7SHBbkKpejFVZoK878gQo+pyg1VQOgD2ZqYFzpiuq3vbmTfp1aWxWuiJxoSZrhEc14eDBU9u9+vG8pVmV9zsgkN+3nws0oSdnYYPxvOU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(478600001)(6486002)(52116002)(6666004)(110136005)(26005)(186003)(6506007)(1076003)(6512007)(2906002)(4744005)(316002)(4326008)(41300700001)(66946007)(66476007)(8936002)(7416002)(5660300002)(8676002)(66556008)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o5hfJDDmkBYVACJ1BHVV054tj9mkbxvdrvU+G3XVc9aJdxO2HArVCh1ehVOF?=
 =?us-ascii?Q?3PhDIE7HONeBAvLrqAlN+RAsSJs16O9C7RNQswWHyAJ9qXahi4qEDRy26tgK?=
 =?us-ascii?Q?A8OKk97aHmPoovRZUTzk0V8TVaMZbFlLAHkh7hohC852H1A7RrqfLlWTimz0?=
 =?us-ascii?Q?UC6v90LJE9DFc+aY24Do96i2/VKTFUpMf3wS/PpJePaPmjZqxKwNuGvXRj3Y?=
 =?us-ascii?Q?52fU+KcSJFxigfCK8ohvqT4yCplBIvf9Afil9ao+SVAjn3fl3H160kyy008X?=
 =?us-ascii?Q?h5GxlM0j4EwXRqRG4IGV/UkPIG1TLbkTfZokJk27KJmwKd/YNAaMfqKpf274?=
 =?us-ascii?Q?pXhslEzWSoCYJFn1pl96HEojSIkqEAqKneY5LUe4P675LL3YyUD2mLC3+m9C?=
 =?us-ascii?Q?O+tjL0yVLZ02AgEiJbH1l3U1dLNtEmDtAr3886iLQ+XQznoRfBbOY+lMSpBg?=
 =?us-ascii?Q?D+jehkq/Tb3aag2dD2jRD8cznewWzr1SwwEtN82EIK382cMdAYiFRw6QDj3N?=
 =?us-ascii?Q?APJ18weXq7jY7LbAEsGZRp4H/aEZ7UNbznptj/AlRe61x/2ML31iiGptRJk2?=
 =?us-ascii?Q?xg78L815TKNeiUlpFvg24O3IuBeu7DISq0Gbb6BIYPrQDYwgLnw5UUB1swTf?=
 =?us-ascii?Q?JwhivlD1gssO/CnPuSRz20ReVcIf+5UTO1RzlzQgTyPvzwCcJhDAEVszn1Zl?=
 =?us-ascii?Q?ucwgRoBSaONsg7x4DN6Jp6w0btH/MCsUGrLDemOAi5stiBAk6IJZJi8KFs/l?=
 =?us-ascii?Q?J54MnrTV8ysHmzbIvrMqOjZTm0o/T/wa2UlyOScgGWxnWVZY5muWl1Y9Ejd8?=
 =?us-ascii?Q?z4V37qhohRde0SNydYWoLEwDWE/glxQstSqiLHrdu+Q+4xFlRfCZJiRmsXjD?=
 =?us-ascii?Q?P7LHRwUpqu8O86f6V7QVc9bv/66KAAdtR8yb4tsCu05ClqoGT6vE8rNRJAjx?=
 =?us-ascii?Q?xrdr+pbIyFNMlaCfCuWQ5cTG41MY8lcFfWgUmLgPczwwXVKPJxGQPmR467mU?=
 =?us-ascii?Q?fC4E7dvZ38e/ZzjpV/qvNfMDz7kJbQALyKFsFuxlwbBxAg26+58RK8deAGD9?=
 =?us-ascii?Q?pcFx+HwbFzXuIRM+sK6AFLf1MgPufBnT3j2qiyro1DRPGNUy6fhe+o0uWSSm?=
 =?us-ascii?Q?dIgHuS9N4EGQfW3OhLTzbZcqsDPlWYD5GPAuHtPC39b40rGFd9YAQ9f13Eev?=
 =?us-ascii?Q?R1xZjPYXZ6fLYzWM1UDwBsBddxdlxcLpUqL6kaQsZwq1YWf63ShVuDx1QAez?=
 =?us-ascii?Q?INiPmMw6XYJJiJ8s1EqA3ZZ1IQ0WDSoyi2cGYL4FLpKkV0vN+JVPq6MyzUbO?=
 =?us-ascii?Q?CG7itdzMvJbvRKCfrVItKDIOFcAJ2VZQnoDeD9ahfDFzOCkK0mB+GDQyCMvM?=
 =?us-ascii?Q?cLPK6Y9PARrN1/KNEy+zmInriz/YxYJtRqxmN4cxwzI8sMlVx0+nUDI/cz/C?=
 =?us-ascii?Q?AVuwhsgyP2jLNFbXjH6/6wkde4KgtdghMwRUjTkb4Zcu/vV304k+dIVq1Yjc?=
 =?us-ascii?Q?UpHZmR30vRre9USB0LjCjtXdqv10K4dNRv3aeuoVheN7FMY94A64xWtmXfQy?=
 =?us-ascii?Q?aSChySKqu1d3vxxTXwZzcD2C2teuSW1kG/uz0sAd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6d8d70-e1bf-4ec9-acf2-08db7e9f8d5b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:06:34.1885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 509JWL/kZ4gSjjIIzydOhzv7rzqQMbbdEFABGjay+zgsXDHRHZypav1AbFxIrsnTPicarLNAuAoir1rHHHvoCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 9884304634f6..db36bd755b8d 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2087,8 +2087,7 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 	nand_controller_init(&nfc->controller);
 	INIT_LIST_HEAD(&nfc->chips);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	nfc->regs = devm_ioremap_resource(dev, r);
+	nfc->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(nfc->regs))
 		return PTR_ERR(nfc->regs);
 
-- 
2.39.0

