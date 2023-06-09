Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2D8729723
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbjFIKlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238879AbjFIKlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:41:09 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2079.outbound.protection.outlook.com [40.107.249.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422E3ABD;
        Fri,  9 Jun 2023 03:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyLLZtimCrl6BG+ReLEnLbl27pVUMr35TJLuCV004ihxNN4EEC08BPtS+YFUnBEVTJsejwOG2a0mVv6Rxi53oF20oBqNymqoARdacbDM/jffV8ddh5nIaPbEvl6bA24xh9729jdr1W1UegYUAy0sE0CQJXpFL2zXgasydh/0i0ncGEUZz6uTvoaicuAB78JiHjJhtkmFPbMzqne/i48q8D9Ys437Bh1ZpDk948UScYal3MV462FnzvLm0fmVDSGUfqfwKQ5G4/KmUB6iK5sKHyBHDHHXQ4uH0SZ+Fe+ITG/A4+MnomcfbwSV1lhAPzK00brT0Ojo5KOBlUNM03CW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9j5ufR3u+JbPKi1Q84BuoPebqdp9Xup6BuwA/asGWk=;
 b=BCaNs6c/T7Y9iiLqqA7Vp+LsMDD+ldFRUO8xHPJPU9pShwHMCdS/vsZjt28PnPlHTavDR4QaQYw7/Hg5d1y4rzh1441iQ4KB0LvOLEPgcI5YQTPI8n4cVQTbnZRAt5A81dV/ya/mvJYrGVLY3VvK+fN6EF7gW/+t54yc1p8AfD1VWpFZcEMXhMQECwi1KgfoW5RLmoSGPWgQafuwQZnh9uvspup5o07rSjhMOrgK9yQkmFYNHW6UexzehEyiqDn7Uq7etOnXMEwyI9a69NFoI+Kjv6PxAWQ81OsrWqTWoL+61K+xHfHdYoUv9oidDvVPlphVn35tMOU1IVzSdsSaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9j5ufR3u+JbPKi1Q84BuoPebqdp9Xup6BuwA/asGWk=;
 b=C9Okn+EunWAZ3Fj/NpIhD+jPdNEVIpLo9syb2T4HEOQXC0nnHn2nI4+xqqE9bZDAO3qv9Z3OPOg8JVCbZzJ2TyQqukFvrBCqRueDVgcdNOAI3Qlj40vpXoRpI2pft0CRP1Use3dh5azFyuUQjUPxFCNgdscauBsjnkSaVQvP8Zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS1PR04MB9336.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 10:38:56 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 10:38:57 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, iuliana.prodan@nxp.com
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v2 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag 
Date:   Fri,  9 Jun 2023 12:38:37 +0200
Message-Id: <20230609103842.4159321-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
References: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0096.eurprd03.prod.outlook.com
 (2603:10a6:208:69::37) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS1PR04MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: d74fee6d-5373-430a-e97e-08db68d5ba65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAASvQowoLcxaGBrLNmbhFyzWaMxd1lqzQzfD8UvKM+25nISsDANW/RxKSlt6PVDf0KTCp+FDB845hW/a4OC9w8MesjS5BEAE+66+SYZRVwtjEKNnMkERYoWsEySF0N6aMq0nyGRaH9kYfL43x9GcUWALpuvNbnPwymGIh8WKzZRIekvIw3uOClFRtWMUqwbIeru3PM7vGOc5PsCDIr+2hFFfLiHGjWvcOHrjh3DoMli3BpqHbwVcDWuJABF/RiBvRd4IyXexQG8JUD8DC6Ed9VtRubmEzNfskZ3qq+1P4+4XzHQKo92UKmNduW1MpbiL30DSCoU3jcmfJRREEniBmOHu4sY3rG5w6hUm8glXEAFe13BSIl1nN3ZOh1qPseGRFCZo9qEc9asmpEvXrRneOGnKjjePbLk0MV6BUz6mLOCm2Ei7GBkijvgJFYSjLgrQpigKhy3hRGPuF8qhtFqdpx8jrmiDAGa3GWoFxE0y0WEUmYTmN0LaS+idc8PLgtuAmv6CtEUp3Mo4wB30idirmnNy81KeID1qMxNIZX8UvhlKQLH6HsVW85C3sejk7MJODTCss9hIlqVYPe3gbBQ/D2OmGbh3EKIjFLRV/OxOjxOYV4G0gZlVfdJwEg575Qr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(66946007)(66476007)(2906002)(478600001)(4326008)(8936002)(8676002)(316002)(41300700001)(5660300002)(66556008)(6666004)(6486002)(52116002)(9686003)(6506007)(26005)(6512007)(1076003)(186003)(2616005)(38100700002)(4743002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FAPdlXTW9RVcROfCjVEseKqqbkJSr/b+lfPSXTm1uSvV7z/fCMt0tGpxZp/n?=
 =?us-ascii?Q?0gJTJDUCWzW+NLjfw53ivOGxAMgrzKIExlhxKlYbDPB2EYoOeyeInIvwF7sR?=
 =?us-ascii?Q?fmsTIM8h8xRSTYJ36wS2K1Z48uEQPdrdZzdBsGlqkxqV9KYa4UATD+7CQdnN?=
 =?us-ascii?Q?C0icw5zWTl1snvLEEdRF6w6krWMbEHyHpdMsZEL81BEvlZvLknsmBPzo3xbH?=
 =?us-ascii?Q?5KZAo1G5Qo3zodz9tyV49hUFVuzfcbmiFeJEkyPDtk/ezm/LZqr8uxf3+3zn?=
 =?us-ascii?Q?AtNPJqSqYM6OEPkfZMmYeYk/+EKAFb10oSopBusnJ52U7NnnjyTwwNv+7+Rl?=
 =?us-ascii?Q?oI+HAxIKrlbDGvlZW9b+6Mn+jmuMprjDJlfhyiPWve5ccMpR+IX02ktDxl2u?=
 =?us-ascii?Q?4lMEiuKoHyw6jRKqXyGmhM0NtvaALKu8zOyAK6yJy5J1l+PEh4KkMfsSPjCw?=
 =?us-ascii?Q?1sZD+2Y7B8n/j+6KBA+UvazT7S8ns0SahaeINpESvEluuTE6b4YFYtBC5J8M?=
 =?us-ascii?Q?AgfFEZ7mN5A/XCE309yLabTwJlfsMvFush0FsBsFpKCmWkuKXUtLSBHqhUgu?=
 =?us-ascii?Q?8v2y1sFu3mNOOuApIXbDQp6F2YYiKNa9AHIe2O9bFVTAZUxRtUWY36BIOjE/?=
 =?us-ascii?Q?iB+2jH7W15lpI04YYetldBo31OLTOnOs5e3CPrA6RhmrvfESVuV9/jprxg8a?=
 =?us-ascii?Q?kCE+1Gt0fZgoxfMghqbdLwubQRKwhki1rS21olp5B7R/dB4wGFklDjt65UOk?=
 =?us-ascii?Q?PFgHwTpPFM6FCdVcajY/EdN/lLjPX2yI24JPXo8XH2ABIhYAIKg0t4jSeZLo?=
 =?us-ascii?Q?nQ0KU8z7bcYdAsC567l2bi4O7Zo36lGrYQzP/cvEVO2S5NQYLwkFeGu5xgTa?=
 =?us-ascii?Q?rho/YUOnNzlmSUolntYYBxNNWyiE2oEXhr1szyV4u/IIlJkGkiWm+P/j6lme?=
 =?us-ascii?Q?s2iEEbmd4C0RC5sLMlBZ11R8LGYN2HWGKmc0xa9VlBULyI7tURb3A66OpmiM?=
 =?us-ascii?Q?UqB0VJdJ8frnLTHNP3atfB8PbTl5Ig24LMS4meF+mGudy2oK0FqPpsM3id/E?=
 =?us-ascii?Q?Ef7SVE/lmb2PfbzAZcYmTHHMIhhHsE2p45BAb6pcgdsZY5fH4AW/c1ZjSPrF?=
 =?us-ascii?Q?wz+MMBRS5dWKRPa1cmXDzpCxvgeKnqAuqjs6UmiKREL5NpioIlPCmPc0s5Q5?=
 =?us-ascii?Q?N5kiEnfJDxoLfSdZlXsoiKrrBGN/n5i8en1GlbcO2hcWlVxzuGEWvBn5oTMS?=
 =?us-ascii?Q?YPtvLpogQ9gWyQjSYY2oGYp9ch7DXkM8R5oF2jGdovHl/n0AtS6t9aq2JMXT?=
 =?us-ascii?Q?AbRaUHRKIAKhy+75NqC0Zg1X4abXx5pmHtYwjhz15Z7Nj1gn5e/z3SGtryjZ?=
 =?us-ascii?Q?e3WACyCpxAsAtMaJ6GUPGJzHHzCOuf1si9rsQ/ja4vzEyRpD1HULztOXbxhC?=
 =?us-ascii?Q?uRljPwsQ0g+ZJvQzFSUWUjLVSfm84xe4BGRhXnPKc0Kz4rHBHwaI9ARD6G3g?=
 =?us-ascii?Q?L2ONaIL65D4ZgUc29woeLYZM4qlY54yXkVMNiSf3q7Qj4zKkpzVClZ+Elfof?=
 =?us-ascii?Q?+z1cIAemhecoMlmu7CJGo2ld7SbLsrV+K3k5Bdem5QLXPKPZv3Bs11l8raat?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74fee6d-5373-430a-e97e-08db68d5ba65
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:38:57.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76XIPW4A3YlGtN0Gz69tSfdXao5jP88WfwxMxsAc4tyNFM9Kwpw7RGNGn1hOq9aqTKCGPdzfMF/Z0h6U7QORqekJHfTO21IAlj/MZsgKgbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9336
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

This series includes patches to remove CRYPTO_ALG_ALLOCATES_MEMORY flag
and allocate the required memory within the crypto request object.

In reqsize we allocate memory for maximum 4 entries
for src and 1 for IV, and the same for dst, both aligned.

If the driver needs more than the 4 entries, the memory will be
dynamically allocated, at runtime.

Meenakshi Aggarwal (5):
  crypto:caam - avoid allocating memory at crypto request runtime for
    skcipher
  crypto:caam - avoid allocating memory at crypto request runtime for
    aead
  crypto: caam - avoid allocating memory at crypto request runtime for
    hash
  crypto: caam/qi - avoid allocating memory at crypto request runtime
  crypto: caam/qi2 - avoid allocating memory at crypto request runtime

 drivers/crypto/caam/caamalg.c     | 138 +++++++---
 drivers/crypto/caam/caamalg_qi.c  | 131 +++++++---
 drivers/crypto/caam/caamalg_qi2.c | 421 ++++++++++++++++++++----------
 drivers/crypto/caam/caamalg_qi2.h |   6 +
 drivers/crypto/caam/caamhash.c    |  77 ++++--
 5 files changed, 542 insertions(+), 231 deletions(-)


 change in v2:
 	Updated description of patches

-- 
2.25.1

