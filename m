Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0965BDA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiITCqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiITCqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:46:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4437449B5B;
        Mon, 19 Sep 2022 19:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz+px40pZhmQlIo+9AuezvdYAOeTi8JkKKk737q9j/GyQjVApraJ0JXgrjsndSNiXclpkGtOJM62qAeljFmp3KL9GPSwobjH6qXdpxBEjSxeaxyXHuucQ7jqZJtK5XEeCkmlbPHLGHh+7rscAXSjRdxMjrOrwHHahnHLFzjGMrp9+Ncbg5shkpiUhfECWXXj/JLz2ZYfJ9rWYzEGspRmle+yu6uaMI1LuVQBTAdWW7ItEPB2EAcB/9y3DRnpFDV6CxJd/D+JkDRM96c2Ct30JLMBfDljTZQkY8e+iEqfPKZHPAJCJnx09Qu2Y2CR2Pkn2pBxZfnyQ3IFFLIwi1PXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGf+8yDB/GkaGwPH2krK/OvGK0qw7Zk2ojYs3qu/0xs=;
 b=iklZEWWhoK9CvUVK3zYAi9e9Q8utePYO94q7T1UvFLDLcrTE/efmrpvYNmZ98xe9EFoYew/lBTLc2PyVQZgMluJxsw0KbkXOhHaJoV+SHzUwdLXCtqDim2jwUfR3LvTN9faHcbFGSz70WMadlwVQvMa3T97V/EVFrRC5Wwi+pFAtnjfc4wyOem3jsHmEroQieX9nPiXlCA0RERX9a0o6L3pjOZ3S5KN97z3Wi8cGjr8i2HgTOCkLsUeyUqj9H5pRtDm1LcG4c7ZHPSq6URnCL0mAWQspz69/IHB1aspOnIi/fJ1dcItMsHZOofaR6Z7mybkECmfS6YdTVyUatf25PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGf+8yDB/GkaGwPH2krK/OvGK0qw7Zk2ojYs3qu/0xs=;
 b=QTfUotvcAMJyriIQfY4N5oGmsLINpcuD8PVb/m1+Mt/LM1tY4VVc77L410+TH7esPf2BTsHz6JqxGwIjDJCinRZMRlXySn2uTie02isp+qiHd9OfxCm3mn62B0FFMGI3G/x4g7EswpQG3QsXoBfvkJmjmUk5QVXSU5jrtXBbUtUzipuo7LXMjZAHUXcrGjErgLUyeFSAgu5kP1wZbvncpqH8wJlbfhy7uM76hOelRx+dtDFCi4a0SqQE6YD4/1G9ENg65Z1YLGbDMUcF2gyuQSk3BfpS7e6j4f54pq1n6SMBQJjhTtU4ihyXGblQDuyjJA1E/ZuulWB9wT3Hpwqtgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by KL1PR0601MB4498.apcprd06.prod.outlook.com (2603:1096:820:67::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Tue, 20 Sep
 2022 02:46:08 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::f9ad:4efb:64f6:856b]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::f9ad:4efb:64f6:856b%5]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 02:46:08 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] scsi: qla2xxx: fix excluded_middle.cocci warnings
Date:   Mon, 19 Sep 2022 19:45:53 -0700
Message-Id: <20220920024554.2606-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4173:EE_|KL1PR0601MB4498:EE_
X-MS-Office365-Filtering-Correlation-Id: 624f0347-0668-4305-1bfd-08da9ab2451c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ty5BcW0eCB5gKo7k/6PfR8Vfj2Ye8zAmsIEt7V0ycfaFeZf80VilDdCjBvcZH3WIi67FETZDXv3JbSmQeP3nYPC7tRab0euaMZQzfQ10+U6vCz6eI4MQ2fCaNqOXbiI1mIOjOEPPJ6XzQ1I4gSTunxbvbvLj7k2PqHnF5oItY/amjinJRXvl1q6m9w0d8uucln975j7C2tTtqYLtiAQpiTmkK8yUYcPG/WHMyzm7IxAVr5RCoafnIzIfD4vsQGWDF3z+hOW2u/SrR1rN3VVtia9bvzbapdPgOEvVQFi3244ytwmIyosLVbtbky1k8QqxNvcJs0F7Y7wI2kWzKw0/pk+AgNRMiFEXrLEljl0oI/Jnqb/4RjuB6dPjx4uZ/7Yw1izbZ+FRf+0xYGu4BZQ9biDrWT+oeknXcKUlAbI+9Lmof1ck7jCZUcVKxG2qayIGQt9iBgcGaTsl/gFu7gyJQgJn1Bm0PCSclvfcqVYFijjIHDojmVEzDY4UAMlnTGTxdIOzDQJzL/HG74cFospwPjWcZKkvtNrKpVUCblu+kAzjQABgGni7sThbEu4Sk8/pSN8jMChUQER/Wvr0FXo7FRSkGt/tp+ZXzwNcU964iIdZhmvC48ONdfaAotnSM+ZDrJY6eQEnHhmiUsyg4L5aVnaljwLC+USklKZxoXooOdPbcTSNmEBB+vrb5Y0EM9FfGCZkkccRXQ42GuUI0YFKQk+b+NLmfjAZlWgWNTZzG2BuZwws/j4/wW/7Ztcly6IM2ROSRfOBllTvdNovws6s9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199015)(5660300002)(36756003)(107886003)(316002)(86362001)(38100700002)(38350700002)(6666004)(2906002)(4744005)(83380400001)(6486002)(186003)(8936002)(110136005)(2616005)(6506007)(1076003)(4326008)(52116002)(26005)(6512007)(41300700001)(478600001)(66476007)(66946007)(8676002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OHSAmQwO/s2G5XCQGM6AbBd0KpxZj8Lw8tHDl4620T5QjORUj6jXdLHk8uWy?=
 =?us-ascii?Q?KQFRS19r8VCk+5USQZLT7oNJOQdIOtjc56KhT23SCw4s264lVNnK4zzqwrg1?=
 =?us-ascii?Q?suSjb/WQ33pd5Q1Kqc4EiX25mL02AegkYXmj+TFyTGBfsO9x+xWl5E3WK+JV?=
 =?us-ascii?Q?IFQThgPJIEHws9D2gr16uiyxRR1i9JS0VQR0gkhY6S7knze2sCoXaDJZtgIY?=
 =?us-ascii?Q?KfGRS8ENmOxv1z9dAQhAtrnWfktxBMBfyk/FJlpvGjQ4yZvCPjeqYCObr+QP?=
 =?us-ascii?Q?ZCxq9bJabljqyYYGx0p2xulxZfAtQTJGE/yIBSVThAleoXq9N469rD+Mpa3B?=
 =?us-ascii?Q?LejpG9N211ZIyQ2CpJER7FguCdlrfK/jGnHvEInhOc6mSFGOrm3VVG1f0GG9?=
 =?us-ascii?Q?pRdfjHLbyXgISONJwOm8hDGZOmq62nnJJ6iuAur7/8pLrPkTLcLPn/r3eEUu?=
 =?us-ascii?Q?V8IGmOWWazRiXw8YvqwGup7DrMzw26sw9cr2EDoUZ4nhCrc/ui3ChsDP71V4?=
 =?us-ascii?Q?yW58BrCblM9n6zInmPdHWheHowfX6pku0vpYTDe4hxjZplYCJJxKaJ1nNQ7q?=
 =?us-ascii?Q?FYKgdWACydUJoVjfB6Q5GX2Ob9JpULKQIKO2Vo9JE/x7n1Mw+2lyHbH/xxyP?=
 =?us-ascii?Q?CidETnI+OIomJDO63Mj2L175lCgQV/3mMpbZEL13ER1EkNqBlQup6UgHBvkD?=
 =?us-ascii?Q?akKyZniA9svkFK3LmYdQ88Y+5NxHp3ZbY7tqMX4/9kwOb9f+hYuD34Zyrow8?=
 =?us-ascii?Q?nNNkaWoWBEfHej9t1EezWr5FmuxTDQkJ1UOMq6CWSjqDbt1VFht7meNNJjQA?=
 =?us-ascii?Q?6Nz9pI7fvw1+s4UWBZ6cxpGPa7c5snBVSxSxFkZ7ZkdINZJ1Jd0/djmspw+F?=
 =?us-ascii?Q?h3x1WeZk/r/QwDdFOdw+N4mO2s8xNypCg2RNpNNYN8ztlNEBNaascTxr5eu3?=
 =?us-ascii?Q?zp//FRT5AdNcDNVJOrZwB3ThHXgNl7oCtGS8/m0uIYKbICW+1J72AoOexeSJ?=
 =?us-ascii?Q?ftJ3Qa7CfGuaQVTgWvcAzYP8UtIVLKrxb0D+jLAwxhlK49k/bO268DYuk7yU?=
 =?us-ascii?Q?rfOXrhNxL7qlxuckIcAcx0dNmKwLQH/52jNu4MbqzomNe+YTCTC6YBMPkDrI?=
 =?us-ascii?Q?SzwR4no9Xo8fK3c+oQVjbKkJvEcoBfMnXYy38QLQMdLXCzv1lNxh3Gy5PAun?=
 =?us-ascii?Q?xdQQWh9zMzlTf5fSOCk0+X+nvtYdJ4lKMFJAs8B1NRrm7hiJJVaDgzsUXk8s?=
 =?us-ascii?Q?2Spi7dKTzBiR3HwjhWKB/CfVsUgBePnr6fYZQyTmyUgtGpgpjin93LcOzQ7C?=
 =?us-ascii?Q?IQrqXWW8yvzlfBeyEaCF/dYbEd5nFqJDIxjEsDQthpk24Dimr8q4l8FTfWQC?=
 =?us-ascii?Q?/p9di0aNcipQb2mxsQenbXTg7vU93PmbbooXv7Dq07nBAQemJRYeIUzMIbW2?=
 =?us-ascii?Q?pMUNahypEW7W+IP5kvAQdMomLdlT9rvUjMyYssiv+3mHKUaSbpfPbaGlqjqG?=
 =?us-ascii?Q?XyWEuFNZ8ON9af6/0u0h+Y97HitejlQvYq9xb+wfxpCxbV/Lxftn7Ygfu4UR?=
 =?us-ascii?Q?pa/9AjLmyXXz2wwDPq3XsDw/4yZwKLFu/x0BVeJv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624f0347-0668-4305-1bfd-08da9ab2451c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 02:46:08.2391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzJXKDa0By4AvZXMujSp6UXR+wEgaP7BuMQKr7HsJVHOtD4/N/6wcNfg1ZQi/82dhKuxzTnarqP8qKYkruwVyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4498
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Condition !A || A && B is equivalent to !A || B.

Generated by: scripts/coccinelle/misc/excluded_middle.cocci
Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/scsi/qla2xxx/qla_target.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index bb754a950802..c2e1ed4b7909 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1028,8 +1028,7 @@ void qlt_free_session_done(struct work_struct *work)
 		}
 
 		if (ha->flags.edif_enabled &&
-		    (!own || (own &&
-			      own->iocb.u.isp24.status_subcode == ELS_PLOGI))) {
+		    (!own || (own->iocb.u.isp24.status_subcode == ELS_PLOGI)) {
 			sess->edif.authok = 0;
 			if (!ha->flags.host_shutting_down) {
 				ql_dbg(ql_dbg_edif, vha, 0x911e,
-- 
2.17.1

