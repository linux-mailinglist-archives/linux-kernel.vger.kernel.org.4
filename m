Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A66E7472D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjGDNh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjGDNhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:37:51 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A5710A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlHg4kjueTyZUIXHopP6lmSmr3NMDKtU+o2G11ww3rAUAGdgUtwAScDN97rLsiSL4IRo3Krk4f4lD04WTZhjLQ4jE3KwtvEIi1JTNma3hQVVrplll8fe8Q7uLCdX1APUpY//d/+djglgYJb+ViA2Q7c0PtIzjYRkWn0dYU2EIep0yn8JwW9zq5JkvNp81MZfTt+tgA3EFpKal0s48UWubvuO6FhchHS2pTsHjjjxJ18w7rJOLkDZSFi0Q78AzLY5eQ9zlB5uPcbEEh+yWnRP3xb4eOJnGV5LBIfaxbssa7EnyLGIYe782jRR18zHAmZ2VzNqMqH6J9+B/mHTSsL7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCATtVih/ccF98JyPH5yiZMXmA0DvBmONiMcBdK0iLQ=;
 b=RKHO6lMGSx0opIF0fk8I9XTHMx7pX1rhT2Yz9FAU8euFZL471xYTYYRZeFbvQ6/c99m7cdp2Qn8peNq0SNnDked/9MqzqkXjswaYDrC3ET3MGvIDCDJmWkbxcb9FnUh3ayT7acjeM7W2pC+gWaF5sSY0KjFOWyBNUAW8OSoB31pQvEsrGuz7rHY/GmCXQAGm0qmEkMAzSb6g6ftgzrcj5Xznk2a0aOXvle1VK8fcE+RuCdNmSKNEJjHqtEAwS5BPGSVgpSS7wrgJBSFLAzUQlAGWdfjhDuuqcWlgaLpyWSacCXlLGIQs7yyInYulI4ctl/4d10kEzT27//MN6BVbag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCATtVih/ccF98JyPH5yiZMXmA0DvBmONiMcBdK0iLQ=;
 b=Rg5JBv9gOGu7x3S3NmQBjdbNNVECIuWlOSCd7QEPX0PAsSYa1WZRWGJzb2eRb8QFYgNN2zmjIfhdlmgWN6BqGxRvgOYsFMStepCeqQCn48SLSiG10AXPMRpwRL0NH4XEa3ekXGO9WUveeJoE+KmT1tmrnQlQihkngJ/EsAa1or0BKmoDYofYzyj+DqkQXAlbl8vxFphyHQLCIB9kWNogfjl6W7H/zUqBHapVp4FYyXRafhk9H1SDQS2Chpkl5CTxcTI4MZwnX+QgcrzO85UYhxcO4Pctb44hnlYlODiv6ZeD9vv1miHKgheGRPwMIGy9WwOOC2P7TtwtPCmOkr5P/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5708.apcprd06.prod.outlook.com (2603:1096:400:270::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:37:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:37:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] mailbox: bcm-ferxrm-mailbox: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 21:37:22 +0800
Message-Id: <20230704133726.28861-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 8023868d-baa3-41b5-f46b-08db7c93d38c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZOt+cl/z9tMuUKb0gJGCpZfgCea1dnZcsJKaUYJEoZVv/OUIQ8/6RFLACf5LrzU45Lbd7fzgYcZr2HISG4L60WfuSqPXYiVn7YXEQqjA4Oh5emU3+LggC2OykKpte/0uzIC9fhPsk63TGbAypMg6RJ5AgnXD06fbmUOE5NoaMyvwHZ7fbgqeoUybRyExmmjy+L/Gwa97H46vz3/oVRavi+9SIeyePmfYlq/JhIcYBD9uZHRpXvk0oWEj79biCjZcF35aVdlTwi+9ISKCZo1BkVDAfOH4UN5CXWpPgk9XW9PvdRFhbv0R08tZMninenIAE1qG7tvUaDdkz7aSwbylgOcrtNuuWivkyFdBQR+O9XvR0e3EQFMtDs0Es+g6mUQDB7Q0vzcHFRABLeQ4EPw1vo/aUfLCNSUOt/lScXHYbM6pnRkAKtATAOtZmGxj0FIrA2thMnMC+2OBbkzdLsvJDuQgN8it5ybxHhJw9S61iK/8YbcS63ZIGZddN+NB9bfOQizoJKxhxcUzi6JYPqUk/ucZewajbOQUJ0KwIN1sNJtnhITiw3x/rsDLEwVPSuv4BPDvzNxjrGI3ZAYMLQbq1sAtuFle5QvSyGM2GpkfSJdOOnQBpbfHIxNN2ZZ3f3s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(4326008)(316002)(66946007)(66556008)(86362001)(186003)(6916009)(26005)(6512007)(66476007)(1076003)(6506007)(83380400001)(2616005)(2906002)(6486002)(38100700002)(6666004)(15650500001)(52116002)(38350700002)(5660300002)(478600001)(8676002)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/F2bLMxa5wtFbVaKIA3dxaRCRIBfRngo8Gh13sV7v3ybD02cGetFNsdKUoa3?=
 =?us-ascii?Q?GN1kkT09/wuoIq5XYjVdlUgDzPT0yr6XajSreD8n7TVlNx/MFjQ6T60LnRGT?=
 =?us-ascii?Q?vqbuiKgsp4njmMS0JHhZEQHrBP7YB1GpPZnNai3zPKT//OiBg9p6HGfUC4pJ?=
 =?us-ascii?Q?e3pcdu4+im2OTFIY3LtwivlH419OzyrnBFNxAmvr/tektlHDiZ2VuihKLpXu?=
 =?us-ascii?Q?H8MVQ/s9Lzo6DJdZ8Ju304qb/fiRqPph9JzixBfT8TGyUcPlB3VBv0FLYwYt?=
 =?us-ascii?Q?lvQrmUiADar7fg39OivtnLXOt3QIlRUgshjdJHOoHbOMNYJ2DRLQvvqayLLW?=
 =?us-ascii?Q?dZZZkVDY3Zfgf+E+NWTK3cNA1/M/7ckUPuraSlCwB5EHnWF3LsaFrFzydHAe?=
 =?us-ascii?Q?tpyoGYKQzFBpLoZTQwQIe1hQP6GdB04OWQSsh/rlHUvocnRM0we0CxLVgRUd?=
 =?us-ascii?Q?Yr8F3jQC1Er5jEnGvc9IXIG4BCaoQ4x36jADUfEqT55jXbqZyZViK03xg8cn?=
 =?us-ascii?Q?iwLgB8yOLTe7DhO4KLnBjw/8PV5IeDwXSZSqksqk3cVAwqR74nnFNM9vgX8K?=
 =?us-ascii?Q?t2EGytZOnLAIgpCFybK7QqfahA2/YTeYOONA+iInM+9CZ21KMUWPx/oNT93O?=
 =?us-ascii?Q?7O8o/PzQMNGMpZQekAWBWW4XzEgm6RzfYcQmHaoL/PU1U9zUowsNCBoct5Im?=
 =?us-ascii?Q?XL4P+kB4I1ic+AFNkcvU+zNlV23wXwh4X8+qwT9tdj3XKA/96yHf+6V3zkQE?=
 =?us-ascii?Q?xfTGsS2vHjUYZxgROIeEORIuhwkrrNdRjIh/8E1etYR1yOVr7XSlKYst2MSW?=
 =?us-ascii?Q?d5CiTo9fXMvUw5GQWWfzSyLEm6/M4hpH3CTg9rZ+H83g76mLCkGCmUrZEobe?=
 =?us-ascii?Q?L+T66+Dyu8NL/VmkAYtx4Ju5NLoLlgdGduQ7GRxGWE8q+DRPydZfkBdMO4gb?=
 =?us-ascii?Q?b//dvNKiJ1jzGWiA40USDnqGXsMk+ufCgjyEOvRXWyBy/b/62AH+mhopyXkU?=
 =?us-ascii?Q?tf+bwXHciUkjkQYswwaIQ9wKpbQ6wAqcEoDeg42PjGd338c+OnB2adi0bu2L?=
 =?us-ascii?Q?RmoadsLRP2rbdass5WxmLT75vWKRgnXjoUEv6o0HSXPuhRNCFszsAspkMLZh?=
 =?us-ascii?Q?n87Qfhuf2Zfm5RWb3wnewPlxWlSM7/aaIeYC0b6YSE8OLMs/1aDMXxfFsZ8m?=
 =?us-ascii?Q?tc90taanwjUZ6LO5+vbY3R/edeOJpqNPC8oMHAvv1W00dRF9Idf2lsfFkcPJ?=
 =?us-ascii?Q?c/Cl9o61bfOYDi/YMiKIZkXJ1rEDeKV/+Ii9VKc98uWU5WwADyOtD/gOB8H3?=
 =?us-ascii?Q?DCkMcGGx3Oy4CaJPRimBi3mI70Bjbdv0MitIsttlTZ6K+fPGMLymY9AWTcsU?=
 =?us-ascii?Q?MfisI+w+lv+IW269YKgD+QhWvTQxvnyfsoCVyvh0y/EftK+4CWH8NA/aSyis?=
 =?us-ascii?Q?nMttL3ZpE0ONzwVxrUbBNQx+iqhuURjxpEsk6Wi78z+I9/O1Y+2WZhQ8u2J7?=
 =?us-ascii?Q?mGiyotxKO0J3Oxusm9R3f31+yFNvc81ynlWeJpVKsnWPTNru+pUT+Bry4F2p?=
 =?us-ascii?Q?STrN2N3tIBvKgw7OzRvPPN+ks4uR/DaYuHVV9mLl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8023868d-baa3-41b5-f46b-08db7c93d38c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:37:35.6466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyoiBjgSt5RVpmIdd393sUeeK+GvM3cE/QdKcGZGL45w+CsaCwfTRyvAUG6wKq/yXztd+JEANkPBFYFfrNseVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5708
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/mailbox/bcm-flexrm-mailbox.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index bf6e86b0ed09..a2b8839d4e7c 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1501,16 +1501,12 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 	mbox->dev = dev;
 	platform_set_drvdata(pdev, mbox);
 
-	/* Get resource for registers */
-	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	/* Get resource for registers and map registers of all rings */
+	mbox->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &iomem);
 	if (!iomem || (resource_size(iomem) < RING_REGS_SIZE)) {
 		ret = -ENODEV;
 		goto fail;
-	}
-
-	/* Map registers of all rings */
-	mbox->regs = devm_ioremap_resource(&pdev->dev, iomem);
-	if (IS_ERR(mbox->regs)) {
+	} else if (IS_ERR(mbox->regs)) {
 		ret = PTR_ERR(mbox->regs);
 		goto fail;
 	}
-- 
2.39.0

