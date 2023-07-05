Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC391748383
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGELw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGELwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:52:49 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2096.outbound.protection.outlook.com [40.107.117.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2765AA1;
        Wed,  5 Jul 2023 04:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdGc9T/oCAzL2cc9ipzQMs3aZYN/ZHOK0rgzxelBqixgiAizIrT3qHNRtOgiedPbLbbDoGcwKNWgrMKsOhqGkdaa4P0NPaC4IAQXnxTl21aCUr8dp6eg7rVF9xkNHN1+4zMEcZwdD/x34D+G7OGI/xtr0f9kWk77gxBMYcubS7TegGR1iBaffW8/C7wHzFhpGTQ6Ly/xqOjTKDIhpI0eNEaVk8uCiqbNNoxuR0V1RbxSh7FCsRSVxv7TvONgr/Vc1p083hGMk62Y7jvMaaOHSo8gM3ijy4Qz4+uCkbaXYipAdWxJ6lqez7ojY2T1pCYEcWOgZEnQimfFRPgejZhIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhKoEcFO/nFboTl5hfagpPiR4RL6dnBfwevl8uFJU7Y=;
 b=kRtSZ84j0gZr+FQwc3hAnGZYsDsacMk7AVFgRt+xaTO5p7rHkI8miL6cPNhHyk8aGPJsxYlW2qwm+H1Za3eif2zXbPqwHLVp971wGmh04JZ1XsrHZXJJ3piDhLnxB/apQEa8fbJYt9AZurvs2zpbv6T2HizqSQ8oqrvZXoYyw+MrvVDSL+VWdGj/lA383/8JIeTltmKTazyS10EenznADSOZ7NXYfmsecHjgnIYlj2lK4RUQp9WbmNWBHXxwFOxspR8+bEV9ZFbGeI+eN3kXjUUaczm16vb37BYhYR8lOYrbZK173seWLPNAus3RMCoqiPtmWjpIEZvCyPur/2NAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhKoEcFO/nFboTl5hfagpPiR4RL6dnBfwevl8uFJU7Y=;
 b=TGlloowt6asAICBB7HCg1g0mhDn8MQcD1YVYGHLFqy0Ju51XNke79LtjoIvt7ofIR89ZfiBLkqkOXXHvKfGT47tpW/UJBQONjJ+WWmSCWxTKEj+wQDKEt24olWxuiMw8qTKZiL52qfF/WM3eE/fOG2rQzl42raHACEArLgpwNHU1mJYI6BlQ65sMv8LgS49mpameg5DoX7li74wYN9R7u1sjFmO3r+x7FdzhGrzhBHebG0IfvQtgPynz1a83Y5LJ2Eyz+HnuUHIM3aWZ4UCeVH+hHZVovOkU16954LyQefzYW3o4jmW3ZDb0rZTqAoRNhe6ESCeAsra8CUXYpkElxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SI2PR06MB4139.apcprd06.prod.outlook.com (2603:1096:4:fb::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.19; Wed, 5 Jul 2023 11:52:44 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 11:52:44 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Markus.Elfring@web.de, Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com (supporter:BROADCOM BNX2FC 10
        GIGABIT FCOE DRIVER), "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org (open list:BROADCOM BNX2FC 10 GIGABIT FCOE
        DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v2] scsi: bnx2fc: Remove a duplicate assignment in two functions
Date:   Wed,  5 Jul 2023 19:52:36 +0800
Message-Id: <20230705115236.16571-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::21)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SI2PR06MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 82da0398-a577-49ca-32fb-08db7d4e5843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zz/r6UuCq77Xo8yxr/CSQ7CnWqBIU5758NrbxKmedHLJhepi9efdU0qf1zyxGbkYvrBzKK83wihWZ+D6PPOqvcjgNoY2uO/44s7VVEgGBCFC8o3ZmUJmFSWf+iGHGUw3ZZ67TtJQ5wdftecxE3+02xniq+7KN1xXTxqRPc2kH4xCs1zMEEeOP2EkLGQxI1lijixBDCSQyeMCCFURRCsU8giCXymyr/yrdzCFnLDWx3RT1YYc5C8G0E1kzeY1yHXd20Y1ikiP5nd9BrsFTh7LvXjO17cBvU7viiRGFWjl3hkS7qWCnr8TbH5mxazvCJGCvyFNbo1U+pRjP6hkl+HInCA736F8YGewfqhS67x0DcE0TqTuTJn0fOpyn+KoecJRAyEizF/YjvMWWWLJDH8TKL8F7cs3CL6wVez21x95ED7wwGQ7hf+964lVxXPHzehArW0QIZRrFny0APQUCG/IteMnwdB/6ttpBDt+AhQdbmxWbjXkqgImahKy/z3Hf6TDq40IalnBVuRTFS4ZHXoxHc0CJXzEI5DyPS0Aqg7eW7GzNyuaIvWdGshVXwh30j2wnOpx3Xq8Db/xxIIEDegYeKsc8tuNAjY8z89Sm8Ikb7FE6sR/CL+M/hxK0wzht6oY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199021)(107886003)(86362001)(8676002)(5660300002)(110136005)(8936002)(26005)(6506007)(1076003)(52116002)(478600001)(186003)(6486002)(6512007)(66476007)(6666004)(66946007)(316002)(4326008)(66556008)(41300700001)(2616005)(2906002)(83380400001)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A9Q7gI7RMZDHC8ldN05hqfpYPhTUDf2ikRaUrqZdSdrI5U7rhWcK/cLpCU2C?=
 =?us-ascii?Q?AOeY/cuBn+B646SenqjQjsItCxj7j3sZdvH5jScwxJa2rZiK9fCyI00KKzQu?=
 =?us-ascii?Q?bnIq3rSgTnXqfGNmnq8DnDnZ4POhlLBTbDhqwDiaZ8ThTnwOgcb7Sm4Va8PN?=
 =?us-ascii?Q?UAc9gZhPl4EPJ2R2CcZeq6QBIrvW63j9MjHtppMV6lH06hIkuq1XpQUhU71R?=
 =?us-ascii?Q?hE9/G5c0OrZFeahDGZUQCaNM+dOpWsyHWxEZ7A94AYGx8QJwWN36fN+TBi81?=
 =?us-ascii?Q?YqR2fsQxF5ygrI1uKTi/2zSyJBjNDGmc/0fwNc07zPtwEQsqpITKRDUseKxi?=
 =?us-ascii?Q?7J7JZ2h/UwRypAdIZfj5BeCcPuMF36M/lW30tFSsLcgaWrWxRbbslqQwr09n?=
 =?us-ascii?Q?D2F/pj1XEuRVg3/ow/0gOyTPvsHFCGu9hUL1yw4IBJZBwwh6YHXawwpxxK79?=
 =?us-ascii?Q?yUakSX410Vg8G9Ej/BZSLxSahgCr0uLogGumlcNK+AmO+ygYXY8uRpURy8FF?=
 =?us-ascii?Q?SAorzJeU3IHWo0dalVvqx6Bqq8/kLSkjXNBczWEIyKi/0RZY8QrqLNgES1Zv?=
 =?us-ascii?Q?yawhpW3eYKy0MgnDTcMhjdAgqxe+J6EE9qaI7fVWxQ/Mq5B/V/TwkkKkittx?=
 =?us-ascii?Q?+ng524BAdhiQNDF1pSogOqdDpM6J24sOT/Df+65h/yuPI1MAeVJFu4tYIt8k?=
 =?us-ascii?Q?qetv6vRpoJfiONm/6Ag9yiMlmlsb5HvC/lLWzypYXqI9ahJ4wp0henrNSwaL?=
 =?us-ascii?Q?c8YzbYoOfXnZ5TzCqvnpDBmw006kGXJ/hXAkNM1SVx4XNdGIphDwMVZAR19G?=
 =?us-ascii?Q?nNknK6TuSuMYl7d6Qh8dVRQ7W0T1CwEASqcPVgIGnnPTDllxAto4WeojIfa4?=
 =?us-ascii?Q?9SGpl7Yro1SIYQ5kVriipsrSXqzyJzronNpOlb7rgOqmkUtim20VSuzm8qvY?=
 =?us-ascii?Q?a3EzMfH+icXNhEMkm+00J8Nlf1Xnpet6p/HJZfenmNcO2md4+/HgK2UJ13j+?=
 =?us-ascii?Q?pYrDGEOeL9Om3Bs14LCbpC7SN1DPsvmzpAF93/u3bL6vSaM9Qa5+F+4fZTBO?=
 =?us-ascii?Q?Ks3NQkMHG2qGLp0MR/BvxIDwL2od8uX5v4LPXJCGkJYvzRonLdiK0nTAi/Yw?=
 =?us-ascii?Q?jv22K9jyv+KLEwN6fXR8RjFCqEi+qzauvrNoj2A3ZnR3w1d40eTV2qLsT24p?=
 =?us-ascii?Q?L0nNA2b+irSaOyAHoi4dnYZ5iWE2yrpxahP7ensNtUH0i+8/ktnIGS1Yqp0A?=
 =?us-ascii?Q?nFOjahyzH17l2gDAm+b8L9HMsJtIHH1PgwzJcbI0Lps+VuahR30NYKghTL3u?=
 =?us-ascii?Q?VIbKHYHbBTs2DCd64PoStKudA8RQ8wpwn9W/6EIujvSYy8hyg7nQkeDrU1L+?=
 =?us-ascii?Q?wh1pGzCgmUr20VBAdCSsW/m7XRrQXrwDKQiHTavy2ILQQ83nLibH3AQGeloE?=
 =?us-ascii?Q?1GhlR3RiV4eH1zrp+DwfgV0ocHENjDKUSnSPumIf2mmOlKCLT7Krfqo6jqOD?=
 =?us-ascii?Q?NmQsL5AAfE1y9HznnaoUuoys6GqXDpr8mB79wzEzqj5l0QUrYzGZCezwJ0lT?=
 =?us-ascii?Q?02HFV/v5u0OvNyJ2ZOV88bnCbuynsSXDG74P2Zrm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82da0398-a577-49ca-32fb-08db7d4e5843
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 11:52:44.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLCBIPbMIRXcP6jGWWl40GyBPR3P5+sjvtM4EjXzuI5uPJ3YklkVfDCU0xq8P2at+NNl/UL5hU8/DHd9sJJpzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete a duplicate statement from these function implementations.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/scsi/bnx2fc/bnx2fc_hwi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
index 776544385..0474fe88a 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
@@ -1521,8 +1521,6 @@ void bnx2fc_init_seq_cleanup_task(struct bnx2fc_cmd *seq_clnp_req,
 				FCOE_TCE_TX_WR_RX_RD_CONST_CLASS_TYPE_SHIFT;
 	task->rxwr_txrd.const_ctx.init_flags = context_id <<
 				FCOE_TCE_RX_WR_TX_RD_CONST_CID_SHIFT;
-	task->rxwr_txrd.const_ctx.init_flags = context_id <<
-				FCOE_TCE_RX_WR_TX_RD_CONST_CID_SHIFT;
 
 	task->txwr_rxrd.union_ctx.cleanup.ctx.cleaned_task_id = orig_xid;
 
@@ -1763,7 +1761,6 @@ void bnx2fc_init_task(struct bnx2fc_cmd *io_req,
 				FCOE_TASK_DEV_TYPE_TAPE <<
 				FCOE_TCE_TX_WR_RX_RD_CONST_DEV_TYPE_SHIFT;
 		io_req->rec_retry = 0;
-		io_req->rec_retry = 0;
 	} else
 		task->txwr_rxrd.const_ctx.init_flags |=
 				FCOE_TASK_DEV_TYPE_DISK <<
-- 
2.39.0

