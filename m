Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446F26B3C12
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCJK3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjCJK3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:29:39 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AB2E20CA;
        Fri, 10 Mar 2023 02:29:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaQAbqCYuVxk1xnXcZ3tUdhoq0BGCPoC97iej1ZDnVc9BP3R/RteztnqS0QoPnxstf+2Ekh5Jnh2FuHc+qZRNLvduxx9/VPYR6X/Dso2mrtxATWj+tbGyk7IkS/OKBaW9wplPhDKUhVk86kloZVlai7Ld8cJwstxCt1wjWDVyio2bnzcfszoaftjYPQtXWXl9V5KiKvMAbpzH19Omd7r8VfpmeynJRZfiShifMD8D02ZensukGspMkBr5vlyw+LFv2EqPSLz4n/c4fF5Pq6AatyYvzT/uaPmahM1RzQRHY74oH3X0y6Keegxm27pqaVI85NNH6491c0h/J7gW9iRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ql39N5ZvR00orrSNw1Z4I8k6gUaXib5hijXJ/Z1GKww=;
 b=MPm01k0eaoFSP9iKgycybZNIQzKTOg71ErDoYicT3a+1sYlJpoxgHpcmuc9U/c4D3JwYpf0ukefvCCwyIZYvxHCi5erVNewIY6WrJqK0BEaNaK+6T7jXWocJIKSQ+aRRsoY+3umARfx9WyS5xRmdZ9yXg8JAFxCs/ywxTPKP+j8ejp0GexMLuRAsOtk870lySBf/P8XHSlAKloWuJRPcJRGMyX1gOSebF982KtQ16pYewR3PC1lm7+jXNTc2g5+CAqHtipqZOIDrgUOW09PRgfRxawKZh6fR2rWtiy/brrhuwXMBJ+XtZrvaFW7aEcn/o/G9jxY6e2DhtpStYhZLuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ql39N5ZvR00orrSNw1Z4I8k6gUaXib5hijXJ/Z1GKww=;
 b=pevL0H0Xk0n+3gmyqWOi/P1z7l2Q4IbmucKcDSiAqOJm0KCBnrEFuaXXJT9F7HCVZZD/mmOaRYDa+Bebxica76a5eqySFoUHrL6wpHhBmcrN4t+LEkxTwWigqOjO16flnk7bhB6gLdhY51YxyHncZv4ETrxmqmLdClyXomMfCYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AM8PR04MB7313.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Fri, 10 Mar
 2023 10:29:35 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%5]) with mapi id 15.20.6156.027; Fri, 10 Mar 2023
 10:29:35 +0000
From:   meenakshi.aggarwal@nxp.com
To:     V.sethi@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH] crypto: tls - Use data directly in completion function
Date:   Fri, 10 Mar 2023 15:59:12 +0530
Message-Id: <20230310102912.1966201-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AM8PR04MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 05822f71-2644-4289-7a76-08db215257c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjZ/wR3/Dq0N6FVUAlBCo83kZSM+1Ih3hzHr1tHO04fhRIpmqNEY+QEKIf6T1Mk9Th0i9FUisIITfPW+AW3dA0FloKco+OXGh3DGzKlZ9NDVEpcbJ3HETmwHI/aXdwTV6u0tzYDFuXBy55+yHMvZhI1/g9o9j0M6Yg5qxWrwlyUNIgaIkTkehpRs9q0pvzYjxQiqRkxSl/4LCCn2o9XMK+QHxIZlGf8ohP3fsNXzsFg5RcFNN15dD1cbeENJ+NMt+wc+DjwuARBgUbTBDJufPZftwZnSflrjJifRsNgYcbdz76sNKenvuOIJyl5lUgzb0XfW+aQxYxRd4NsUj1PlYDIJMOwaFqo0QCI4fsN0DbfTHI5dUh+oYD6FZYvMo4mMNu3L+8MD2ZLJw4y51yP1iyIM8O6cAmPgspUUzd1KCu1ALSudK8rmzyXOHGGbWW/W+tcwTN5g0cFMsSi1bur+i8X5d5J8fVCTy0L6jMiZoJEMYwj+ORlZW6GaLbt7EGzQdv+DGkmGV68lA4WUl2e+4dH78CRaBxXPZ3Y15XPCmtdWk3oJZNMAvhUv44W+9solcsyntPvqOJd8uCvrnEPy3KlEx4wuAagrEV37y+aHyUP8XsSC7i0T6YG0JBz+OPLFHDKeiJ6GcYecYv7ulKGOodbFqclvcGm4QT1qdt124VS5imUR/h47LOriH3XjyDYJO+RtR66Y/cCdzJ65oy1tVJ+xcBSmSjYm4k74tlboxPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199018)(52116002)(6666004)(316002)(38350700002)(9686003)(26005)(4326008)(6512007)(1076003)(66476007)(86362001)(8676002)(186003)(36756003)(66556008)(38100700002)(66946007)(2616005)(83380400001)(5660300002)(6486002)(478600001)(6506007)(8936002)(2906002)(41300700001)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KmnAr9VEgZ/LiJ53Ze98Gdh8oHGkNfJJtX71RpKCwM9jWJvnIbYKxq2v6UmL?=
 =?us-ascii?Q?cHzNRAXnWMT4rb2zBepk/6Z/8J/NTKEPrNUJvo22Btd/osuYcgilf7ndoxMw?=
 =?us-ascii?Q?jZX7/pEuVNwh/Hfy5l2NAl9g1BaDm6WZMWM3ceMtPAQzn3wNfE/V6V8FwxsO?=
 =?us-ascii?Q?y9ZU5uKYHKMZFYijwYgvbFetowmVZUHfAmmfBFDx6Q36AE8I1CXc4YFo7e26?=
 =?us-ascii?Q?yui2vDrTuaF8Q12hwUD+VlwK5tAMcBc/LiFgolu1d18giMkEKzcOEmrm652G?=
 =?us-ascii?Q?ojA4RGi6BWY449xlFNFdAyL/+eJdEyl5GhbRENhuAUS1dnskGJ+xoEcdi6fv?=
 =?us-ascii?Q?CY0PBNAcDK3z+32HJl2hYy3A2/RF8IgwKAE0Xdp9cIyWQPq1I/oV2OyU+bxw?=
 =?us-ascii?Q?tDqtvQ2/Jknwrd+Rigx4GWpxFvcBJRTbhtXrxeXMpnyqUcItPXpzhW3ckC8H?=
 =?us-ascii?Q?OmTExXX0yzYIylIRoeRXsujaLSTzQRVfy/VDJ22HJYQJORZGvR55D9ys/923?=
 =?us-ascii?Q?5YYiXr43If+va7UScxb5jIXQhX1/1W+uYF4HmiFWSBCU7X/haEgkIDbQGUSh?=
 =?us-ascii?Q?1TjfHnQ0uUe70k0uZ/gfRqcYy+TC5hKaXNBqmfGPYrDIM6uC8p0BeaCYnJfO?=
 =?us-ascii?Q?sl7Ur1WisEp5scRXA2zM8lG0MUokvlcbdD3KJ4KWNdjZRRZOO+864km4CdWV?=
 =?us-ascii?Q?glqEk1LxcWmifDBXc9f25IqSqbVRPWzZdVPf+517ekRWY4JmX8KDGo0D6kNX?=
 =?us-ascii?Q?klgeKMipbOGmDWIwQ8GuA5+H/pTzVaQwpLPekZOZ+RvxYZuMb1gLGbo6y3xJ?=
 =?us-ascii?Q?pxpdl+IG83b36xBTh7cEnR8axDLBUTupQlS9haMG0Br7mI3/8mM4gzIBNkcn?=
 =?us-ascii?Q?F6taAAWXssDKPr1A9ZNXNtPsNg/qhPlkCZaCUm1GJGGCa/FEuWFNg9fOxZ2Z?=
 =?us-ascii?Q?1P27KSu8gnDejO6LJbX3PxCfteKsxz+oJP7pdSKqUgeS14vhH+HquYS7EpFW?=
 =?us-ascii?Q?Vsm1eOr4bepKIuXCTa2WTLclmWnh213rbKI+q/3lvgnl0qBVrRP+UYNODn3A?=
 =?us-ascii?Q?5F2vapv3ueJzrL1uouMLOwDo1tRDg01sIEjzqxZFovWf0WfEpA/fYqUCZ+mE?=
 =?us-ascii?Q?uG/IqF36uLwc5Jm/AXl5l7/FSnOCYWIo1xsbC41gejmMrU08VMLMuOXbRY1K?=
 =?us-ascii?Q?QVcDM0UE0E4So5T4BEw3TsCCJB7v73VPUxf833uUO7sMSeh/KHQzugJFD6Js?=
 =?us-ascii?Q?JiSu8FX/e2f7zVn4of1J0xGZRxTyseL8fiK6AfmZKYJGScGO0vPi1sjRZEYR?=
 =?us-ascii?Q?05s1/laXQoJkdeNooT/sggtOaCkWX6XdlG4PugYitqCytV+8GZnBFpsvNKIE?=
 =?us-ascii?Q?P7YhmyhhJgE63S88PIaXL221HNkZrEF+UY8qKpQdYpwLWBs3bmKLPpscStuY?=
 =?us-ascii?Q?zNOf8eJdttrQGBbNUyzjvczm6KJ8BFWL01Lz+R2fCOxru+vn4Bw2Igdi4ng+?=
 =?us-ascii?Q?czYyY5lvHqYOU9jbC839TC8/L/c3lM72z1fvsFl7qT0Xi3PR7M3bqvmdasVE?=
 =?us-ascii?Q?W+jkFqLjN2ITAlHPYI47W3hJa7nJUVWP2I2Crrn0Za3PSF+7zHQPZ7oeNTeB?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05822f71-2644-4289-7a76-08db215257c8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 10:29:35.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hU21fX/tLRcNZcI3SWrjMbIeUbSSK5KIIWL8T2V33FZuFlr0j4taQCuS57Vu27Ob03p5YgvilFfmaHBGRo2rQho1x/DsKXtjI5l95y3EPBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

Facing build error in building tls
error: passing argument 3 of ?ahash_request_set_callback?
from incompatible pointer type [-Werror=incompatible-pointer-types]

Issue introduced after changing prototype of "crypto_completion_t"
function pointer in include/linux/crypto.h, conversion of
completion function of tls was missed.

Changes are done to use data directly in completion function of tls.

Fixes: 255e48eb1768 ("crypto: api - Use data directly in completion function")
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 crypto/tls.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/tls.c b/crypto/tls.c
index e04f3b450b43..f16810238d1a 100644
--- a/crypto/tls.c
+++ b/crypto/tls.c
@@ -1,6 +1,6 @@
 /*
  * Copyright 2013 Freescale
- * Copyright 2017 NXP
+ * Copyright 2017, 2023 NXP
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
@@ -50,9 +50,9 @@ struct async_op {
 	int err;
 };
 
-static void tls_async_op_done(struct crypto_async_request *req, int err)
+static void tls_async_op_done(void *data, int err)
 {
-	struct async_op *areq = req->data;
+	struct async_op *areq = data;
 
 	if (err == -EINPROGRESS)
 		return;
-- 
2.25.1

