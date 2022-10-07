Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422755F76FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJGKlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJGKlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:41:12 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50051.outbound.protection.outlook.com [40.107.5.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAFED57EB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 03:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mddBh08k2FVpwme39ndydmElk1Zu3rKkMtBhrX9l1LfVC8c0YIDphEyQJKU0N83/d/7xFkklUkTD2UatSLsXmwg8GKLPxBWEMFu72ncTbCY8DvynQ87nSYsHnYJYFvM8k1cfEIg9XE8yse9//5p3TQRs9yNdBa5bsm98RkKToFrbvzs0GkOkadPEalTKklDWfSyKCx9kndPz0O/ejqP0aR4s8LiEtDvBAlQ/wjrgTLN05X8JJe1NDPipHQC2772K9hnpacKTUNHFdC95HnUJagWnI2c54QMkGC3rN/BpI8vxWDyBE6hNT21CSm1KDtdAjG+smR+3F0dlrPOrBjSFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW9D+BSmI6pRhbYTKCGKsKv+BuzjNz4WwrRy7sRVd8I=;
 b=jJcWDmRPQdKhszPsnfUcuxCfGCCfUTWJPcA92RCakj0GsPtXJm2kCzS/lT1Z9GRlb+QVN2CkA41D9G8FjZqIMzkGlk9Z8SDvH/RJsACXvaeMAI3+K2igMOu6l4h53pRgnks9u6Xzz95OiumEQXm9PGTrRCsWhOChNQJRzTytXJN3uOwG4P79I6jAdzYeilkzwA7j5dWIj6s+naJv6B6WqsY+VnuI2s+w2gFWFTGa3YEpyWM/1bgtd4aPQBGR6WlB1Aj7k9TvtBd7i1ywLkZFnfuP6o7/DhVhHgqfT0OL0oxPuoJh9soB0TKdHN5cfLoGAN2jTrmU2twktifBbRrydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW9D+BSmI6pRhbYTKCGKsKv+BuzjNz4WwrRy7sRVd8I=;
 b=ZOG46vJxvfCrk8Uwi5cLVhpo1buLU6je8h7hGh0Tv2LTX8BKPnoRoz5qxIxY4M5e5r9sc3KPfiI20qP7VdyUIV+MH15Wf10hN7o9iMflW2kTzq9H66wOdbw8k21AZo4OvqeB4ndd1/Lmjz+3Q0Z6EgYH8DgFx+03Bw8VJWog/kI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from PAXPR08MB6494.eurprd08.prod.outlook.com (2603:10a6:102:154::16)
 by AS2PR08MB9595.eurprd08.prod.outlook.com (2603:10a6:20b:609::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 7 Oct
 2022 10:41:06 +0000
Received: from PAXPR08MB6494.eurprd08.prod.outlook.com
 ([fe80::3c25:b934:e13d:d6bd]) by PAXPR08MB6494.eurprd08.prod.outlook.com
 ([fe80::3c25:b934:e13d:d6bd%5]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 10:41:06 +0000
From:   mikhail.kshevetskiy@iopsys.eu
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 1/2] mtd: spinand: winbond: fix winbond lashes identifications
Date:   Fri,  7 Oct 2022 13:40:57 +0300
Message-Id: <20221007104058.198039-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::31) To PAXPR08MB6494.eurprd08.prod.outlook.com
 (2603:10a6:102:154::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6494:EE_|AS2PR08MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: be0b6dc2-c6a1-438e-a1bb-08daa8507054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfaaiQeF3E69cJefnn0/NzFcxiPMWz9baGS2bBlFk5rSrqX4/Mp8m8TGlVaZno9+BWYdk+ZQ1Rd9DfzH7yBQmbWkpk4QiyP5mg+iM/TW4qUHXLl2E2jbA+YSUuIjxpJqHxIBDHeKbj9Lu7T8o0+IOWnSLjC8LOEpfsTDajUMvhZI73VT8oT49iM4gMubDQfeUFuvAWtdkLuLZF63PheV6t8OSgTJC6MN6/K1O8x/pMf5BKhFld3Qp8VXBV9oQYLEa0wZmozW2Yan/j4wEaqfuymECg862evVkxP9c8Lt2o6GxDYVEkXVSK6ZbD/aOydU+q9fQAtiTjuMjAOvnBtFWfiKcFATDpcIBRBKgdzOfARPJGfehZqeGG/VOsVGu+Z/VqraGmIeg7adHhaD3SzjoB39IGVnaCS4t6XSXa4Ux6x62P/ljTPvJFOwXa/A7n9Ijl7TJmgekBvCBCrGtFzyPiah4TC6p+u9n+2W1Fv0NOTiEeF6vfp7AH6eM0qeI0L89qV5T3XnAtzfMYS+69sy7OTNutWaVzYxf0Kql8sgZheotE8KMg5sX728p7fDuE+gCXKlQXn6gCTDJ5H3gXlFBsIVKEauxgIMaqKDVWjpuemZYlepb0NFVisoNewt3LF0ANpnlKNPHCQpfnMRAUuLusKfb1x82eD7cH3E9QLalDN3MYKx8Qxpbn13vw4yIBm26sFQP8WeEJm91kwXtpWH4vTjCZHFNGvcgTaCdlZjoL539XwRIYqHF+DbW+OfkdiHivXPuxS9o32zKiROcf5Kag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6494.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(39840400004)(136003)(451199015)(2906002)(41300700001)(4326008)(66556008)(66476007)(8676002)(478600001)(52116002)(2616005)(186003)(6486002)(1076003)(6506007)(38100700002)(316002)(86362001)(6666004)(26005)(5660300002)(38350700002)(54906003)(66946007)(8936002)(9686003)(6512007)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zcF8YnC4MeqOo9Ju2GM88qjc/7iisUjUfnKRDah13CUqK2y0HJ5JMPK/tuGN?=
 =?us-ascii?Q?GQuW0O0W2gVzrpBPCKAhuChNQkM4XBMEzJMqa+WAz3pyOHP8MMMJ7+HMcz/c?=
 =?us-ascii?Q?XZA9cBGfydMc7aHrJdTJBXe0Dn0NAILZxp7wVdyBhubghSFJoyo+4BQJQT73?=
 =?us-ascii?Q?BVT9brmUj2re7jPTOBybwYa0QTgziCbQPnBIff/JyVN17O6pqXY/MU9o+q5k?=
 =?us-ascii?Q?fKH8iBhsghUJc7N0s15+d5cpGRMa5Jf+BEstwQUWJ/gQRyrkeRiYo2w/gXVi?=
 =?us-ascii?Q?EEiTu0eJEcm2Z5fY4W9Lwmnk5TdFYLmPtnvIu4FdqAFSCm/I87IVEqbJzmH2?=
 =?us-ascii?Q?bPgQs/VXcmqdj79sj+EL03hB/sxdtFePn0c1LCsEWdyZTcKc51G+mDq70yuD?=
 =?us-ascii?Q?jEv5A9uGUoFWkTeTqvQpxAKMUxg/EMQZcriOcG714riAxmFhOzIVRx6i2+BY?=
 =?us-ascii?Q?g4zx4CM4BVqoJ99bdiuXiW8uc1FaKLpDrep2hQhQofzMg0xeQRqwmNbASxrh?=
 =?us-ascii?Q?bJJumDcC84J10N80YfQuZeLU2bmUaDCt5kKUbBD4DRIeKeK1ugMS8IRwoG6i?=
 =?us-ascii?Q?v7rfTKMMHRmFjU3gNp/QTwzbJ/XS8egQPq4sbxyqP3eGhvA3//ftw1bV9QFu?=
 =?us-ascii?Q?j6rb33jidPac7S+fut9VtVIsKJxZDacmVWmyUyo545KIDJm9ik3121huZtLk?=
 =?us-ascii?Q?JbCCFxWZR5h5+zTfN7LAwpxnQwmZ9G1KH+IWNEivUQXvBiEZBihyy8N8d87q?=
 =?us-ascii?Q?wViBcjGB7A9rH++Fc3O4iwByTXeH43j12sRNGAzEnmzvTzw8ksfZpJ4wstYJ?=
 =?us-ascii?Q?eU5eq9RHuSfRcuuWzsqzitZM3nN7cwUjQcMSLY8VF3h4XWhaH78er4nUM5l4?=
 =?us-ascii?Q?pHeDpVmtwNrJPI3l1uaPSee504564IZ9jS8PBnXQDREuwnobmCAetLgCJX52?=
 =?us-ascii?Q?qWClD1XKZI/qmBdWOv5W5Web2Em3zftwash5bYW4YZnAI46ZJ1Ze/G3lhwlU?=
 =?us-ascii?Q?5z4q5NT5pyIOqCQfVq9g6+ttBHNyMD9MXHIfF6jq/44jDWD/2WEX7gh6FSRk?=
 =?us-ascii?Q?gg1pprno5RX1NGU0+X/gXn94GxBRpf73mYERMjav6ZFSC0kXzEhNtwRqjMhz?=
 =?us-ascii?Q?h4b18Odl4wk0+APFr8YH7SQ1m5WD37eCCTiOPDmEQsiZtpE9Yara2O40m6W+?=
 =?us-ascii?Q?1EpFH0eJf6W19Zw/TZIXpYg4TDTEoZBUJDxw2YIPTDQCsJSPYl4fXdBwZTNz?=
 =?us-ascii?Q?0bcRygUT/2bzyfHpVCUtE6ocNy58IX6q0iZwBaqh9XM4msYFHymhst6ArqIz?=
 =?us-ascii?Q?Xjtcri5JbH1GeBWfnSQU3k88vQ41RdGA4ae8HgZ/qC9tAibLZeWwWKEKozyn?=
 =?us-ascii?Q?D0lQe6oaej7qssT7VY70RG2zXjw5JS+G+zx9lbl8kcJmY+2Gp5kF8jR8BxmM?=
 =?us-ascii?Q?Q16ToYVm6HlEuf1I70+1cN1qSgGL7tUWoyRGp/2bzSuDTHt6NCkZ9r+60s0f?=
 =?us-ascii?Q?ZKHQuUCjG+0ZSqFc6c+No201pB8QqGBqwvO5ZUnTdPWutnuuIoWMBFLw9lkP?=
 =?us-ascii?Q?1sdyKTHFTmMTCN3nzZYzvAANBccycoYCOkDtDxJeeNtmCSh1otue/VWXL8I7?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: be0b6dc2-c6a1-438e-a1bb-08daa8507054
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 10:41:06.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wpElxm8lNVmLJrzlf6rq0+6Qzf3ClMsxoKZU+i0QO+HMBTViWnNMzq6k7EcS2FPKW+Xx+58uqMNWiybQwV0G4yfbj3K1htr+TC4nTy2s2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9595
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Winbond uses 3 bytes to identify flash: vendor_id, dev_id_0, dev_id_1,
but current driver uses only first 2 bytes of it for devices
idenfification. As result Winbond W25N02KV flash (id_bytes: EF, AA, 22)
is identified as W25N01GV (id_bytes: EF, AA, 21).

Fix this by adding missed identification bytes.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/winbond.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 76684428354e..ed368a55d68f 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -76,7 +76,7 @@ static int w25m02gv_select_target(struct spinand_device *spinand,
 
 static const struct spinand_info winbond_spinand_table[] = {
 	SPINAND_INFO("W25M02GV",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 2),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -86,7 +86,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
 		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
 	SPINAND_INFO("W25N01GV",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x21),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-- 
2.35.1

