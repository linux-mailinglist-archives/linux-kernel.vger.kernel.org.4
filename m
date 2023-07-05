Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48847483F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjGEMOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGEMN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:13:58 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B5619A1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3ockCw1JprI42+9zM1P3uiqq1R3FQrahQJz6ximZdRkZU/RQBUTJA48JRmVPU//lAEFn2K938Oop+CmDvTMtwgsnSjWJlSHEUwYFq1vzyOId9tQb3UDt8rzXJC/OahNO2rNwv/nWhZs85FSaEtRKECE8qgcJjijnQJx3hnlvauaBUJRevBY/vlYIaVAPZbDQDcuDPShnnEFU0JKyWhryW/z+z5T9h59HcoMAOPjg49rrVEFktE5LCMx2vwGaxB6ZVTtS3z942WNkdVz+sdhOJ+5WWOyqgnbPbQkVO7hayg8rzLA7i1VgFYY/cvooYU1XPxgUQ98YNrvqT+svSSgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HevA+cnnj52toenaN0EtxrUgLYWmtqMQru7abavgc90=;
 b=gIaReQ+g7ArGA7vF4fir7/9TEhFXabWj3PaROIwJwDnbuZasUQwZJHKAEHc8vtjbmM8y6hoCCxBoTSy6XSlz8S+H9LSzdfkmQnxsQ45BWUUFgPypsZis/g2fQAGlHMmDNbUM91JAE0A8nHvlEwPNsUSNqICv4d+MiKKPwZQu4v62T0w/X6CTw/0eXQ4Ak+Ptbw5ZxIrp9PCTuwMCj+Du3ZprrzrpBTfMmWt0mJYA4zUwhGZ7kQcJAtxf1LDvJJ0DuQ7iYhNhH+QaooZDtDruvmVabDBY8UJnxVAHz3WldNL5iEH5rHo4HwYSo6e2EBjVYrnEg4z2ZMaIMB4bYwrMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HevA+cnnj52toenaN0EtxrUgLYWmtqMQru7abavgc90=;
 b=gMJzRsF3yyj9PLRamN5cfiF8aP55FvbmBjDIJtVcDa7JRB0gvhAKkwX8sGbdNIKtj2GH+c7LPCxRkXyJ+fhS1CJxoRH2hxxGc7pCNDuyBSHIlgjESQ2kcT9vHeDec+m+2nfMaTLpz5CBe5IkwXx2tY1u+T3IfiLRGYGJEF7VbeBI8X1UpqHLgiR9ugLoEpzcDikyE6uINeO5jg3IwMci9PrapsiV/CyBMSNGv/grXJcr1NsHJaPRzKaMiapDb8jQwYmjKoO/kb93os8+QXM3M+4F6O9aeCM/WmrC4h4HH8mrn3Ebl8VghnGi8eGpcYJlKyQiJJUy3GTIdLPbXG++lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR0601MB4403.apcprd06.prod.outlook.com (2603:1096:820:7d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 12:13:15 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 12:13:14 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Minjie Du <duminjie@vivo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-m68k@lists.linux-m68k.org (open list:M68K ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] m68k: apollo: Remove a duplicate assignment in dn_timer_int
Date:   Wed,  5 Jul 2023 20:13:07 +0800
Message-Id: <20230705121307.17204-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|KL1PR0601MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: f056e357-8bce-4ede-f03e-08db7d513590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cs97W3RHWGD4ioJesViUCVt4kDE1WMvb+P722D24y6ZOqrC+eFBTXKtdiSewxoUp3uopOiBTjaptqG1lRwUru8cuhEz1oHPmaW+rq7ITeUcWjqoM1au+os8pr9MIlhADUcHAgaN2U9IMIVCr4AfxI2KR+0Q5BSvMu1f9Q6eDFPtPPP8f2D79jL8kZWrpsGAMJZxqYmwjrfIzpRchQaXlVa1Kp5DBTSjAXQdzKzEWNAfmKHMlinosp44eSyCSYoSjGok/7uT1zEBze+gd+gFj3blepI63ME/DAgf/IOanshPj+U8SICS2JT7nq4mbSIkJVy8HL8+Yxn/h8bdHwh/9t14qPJ0+pJikgOD04s/m5qFe7zcgCdZ2H9qlNetPxl72Q6Tbzz+2LsvQq/PkE1SFFWGnBVMNoGsXt9y9+PreXBZxm+i1zcR9NT8ckVkiYqasZJpAJvNjnPRqYNr+Wpjcp81h+dSIUGY6cZmwgePy95Vfw9FiA74en3rn1i8hjkZmiQ7qsvLMbjx/zobeczFN8jqgyT/9ai46r+O2c0Q5K64JkWrRVm5PDnwjbdGJgt/fHsHzjYDcVGxrfnNanWNAIquX2p5TL/CKIW4XjtqSZbS3O8dZA7R6t6E0HLQZvt/ZlRwrJ1o8EIphLdlJLTDv1dXQLpTsYPoLZR92v3Ciz9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(41300700001)(8936002)(8676002)(110136005)(36756003)(6486002)(4744005)(316002)(5660300002)(2906002)(66476007)(4326008)(66556008)(52116002)(6666004)(478600001)(6512007)(38100700002)(107886003)(38350700002)(186003)(86362001)(66946007)(2616005)(83380400001)(1076003)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uy5YVZJnJ8AE5pqepNb6z5V1OUIqzuZN6PygxwPNIw7TdrEOgiEmmdCJ5hZA?=
 =?us-ascii?Q?K8YdhHxry/AXi6MYFKECXmrW2yKzmDUen6PYT5y5pjhFZ8ncOfvXbdfLpzko?=
 =?us-ascii?Q?joPoHPqSIM9l66yJOKLrPm4GVDi7DOXHmPVBUtBhc3ZqdPpMnZcBPnu0Fd4I?=
 =?us-ascii?Q?JUz0gCNXumMODAgaYGzDBBSRnlVRrAWhJQV8cxHVHpqqhWyRtuEOdO2pW5WH?=
 =?us-ascii?Q?NGnGBUweIpGwR6ktCcFwAx+8Lc0yU2pkFrnfxpUhGzYUpHxeXVTD0RusuWBB?=
 =?us-ascii?Q?TZXxdCtSIBGYoCxLhZysRddkmlgq8KvTbkVk4AkveLFkBBPYh944lE6uZoIz?=
 =?us-ascii?Q?TLIX1SoGwQx7RZLhEDv3psdJmnfM90W/CH/uJtVaRTdaRz0m9Zp8YXuYDPAf?=
 =?us-ascii?Q?PteqbnOWQ6oJkL/asDqPM7nHtSkzaUxip8TuQibLvAzOVZc/ArwLelZxTIaV?=
 =?us-ascii?Q?JLEBTCPpXcg1lBZk4EtHtBkIBi13a9CWbjJyv9eFcRJxaxNUlxVCCamnmvqo?=
 =?us-ascii?Q?KqPsE4GFGlYJwx6xIypWq+fkP1J9L/o/fJNOYxohd996m8X42j91DfpSQIeM?=
 =?us-ascii?Q?q8/fol5U16TNU+ib4mFEhekRUSQBpVU17oNmF1Ua/hCtgqVEGCfVqbLJIRB2?=
 =?us-ascii?Q?zPO8zdOoo5HRBBovCxGGAqtKYQBrTfSqeHhVvFOZkcbHL3ogqU3CB/+0JQjx?=
 =?us-ascii?Q?+X39Ofj4FLqexqgqK2tI+QK5JbphnSky+iTy39HLd0ukIOD8JjS96VXpyMwz?=
 =?us-ascii?Q?RscZ+702VYVB9LvSM6CgiJQ830TPz/VhE8vOYodTAJn2x6OA8Q2Fj+3IMic8?=
 =?us-ascii?Q?9VCbk69qtcgpvB5T4RgIWh0Dbf9VT2OIQrdmbW/5b0VWDU4ciGPjbXNmU4JL?=
 =?us-ascii?Q?eNPeAiGPtHNQXINHCx+ifAd7VMRTVR2XpUkxK8FV9CtRmqhFTMCKlFEF7elJ?=
 =?us-ascii?Q?F/L8YMO32UH0z9TI3xm2tYMK1nojgJIYrjnWk+HglZIbruQxEFVMmiS2uY/I?=
 =?us-ascii?Q?0d5gb4lxN2Qsnsp8b5G5voPjAq9br2K8D5OkwcWptDy4sVz0drjZsx/VdCj6?=
 =?us-ascii?Q?+rTDPf9wbL1MMXKphGFyvqE2R+AWK2BG4JQj48fN9pLnbVbP9kzG31We1Nzv?=
 =?us-ascii?Q?Ncl+v9P6BzW3F5MzNBDDKrR2Q8Oc9kPVP1M8nyGi/taVGgWWgK29w9EMcJT1?=
 =?us-ascii?Q?0WTHoKfIfLmh6tM9hcsSTA3GlBoPK5A5XxiM+62N/72TOlqwotnd3vdTCZBT?=
 =?us-ascii?Q?1vMlCadXnpb1JjzvHzxdgrEXoDM4XYbVYJaXe+oqFQEtaQYdlGzBSPQr+bq4?=
 =?us-ascii?Q?53nR7mGNyTcm9U/kn3LqAmrnp9uSC3+uA0pFYIgpVfvq7TBGqugRwYYmF8BE?=
 =?us-ascii?Q?7ZDhLE66hNj6PhIBmawnZJ9F8Npo47hsj0A3IafdvAi94HHk2z5tWcwv/AJo?=
 =?us-ascii?Q?mi8kpXcJJAOCwzMVtDtPRgpV6dAr8dhBzdE/JoUucSjj1Hwk2l/d+sfyXA33?=
 =?us-ascii?Q?Xhj8wnmcHYfGVRM7RnHpriQU+KKannoVzG/V3xhbJF9WTUzLEQoBS4hnMiZK?=
 =?us-ascii?Q?mBVPIOYwsLqtPCd8WikexSVYCVxEIYJTWNVaZCBm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f056e357-8bce-4ede-f03e-08db7d513590
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 12:13:14.9697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9LRBwIbqu8xqBs9IXA90NVEQM+aABhz3QNUnUzw1YEfS5jzguWSLoitQc61Wus4RFNIzILQaizfIMRVP+m/7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4403
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

Delete a duplicate statement from this function implementation.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 arch/m68k/apollo/config.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index 42a8b8e2b..5645d2018 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -173,7 +173,6 @@ irqreturn_t dn_timer_int(int irq, void *dev_id)
 	legacy_timer_tick(1);
 	timer_heartbeat();
 
-	x = *(volatile unsigned char *)(apollo_timer + 3);
 	x = *(volatile unsigned char *)(apollo_timer + 5);
 
 	return IRQ_HANDLED;
-- 
2.39.0

