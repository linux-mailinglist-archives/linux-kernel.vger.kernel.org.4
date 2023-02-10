Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62847692011
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjBJNsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjBJNsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:48:05 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2090.outbound.protection.outlook.com [40.107.7.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F67632E55
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:48:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WL0NPmsussCHHNDTmaoDD8jJ86XJMhJbttSMNiQWNL0ll0I3+Mx6OP2RDS41C1iC28V84LmmpF+dPmNI9t/uwHY40CoSEoGP6zePsUH1nOUWZ7c8PVQ8NPdtrUrILMsvm5ocqoh8yuBXXSKZ5WKUkF1A3ADzsoh53ch5ECnLh7alLiopzn0MRv2GBmiRN3308HAsufXV2PEbDf2yATft+sBGlD7DM2fuAjVbSPRKnJe++NcvtI7f8OquPcfPPILj+e4Ex09wcctiTGOU6/q58TLKnQCUZxU/0Il4JjBUYaq84PBxYrKrdIqmI0KbJXvkqusWX/IIfnAc9eo1i0ekmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83JhzwrKqHOx6vi0FndZIAOlBI2rQ6Zyeq0BF4S9GYI=;
 b=Ge2bCAIKZ0LGsPTwtKvuoHV2B9fw9uNoGo2pURriH1IjPMd6YaeMShuTGYNTPTgyk46t8lkkRkmu1s6Vzw/8IxdFALyV6xfel9eZYtNxbFFbnAMK4vq45qj1UnbaCir/QIc7yrrT3w3w4k7X7IjssWPfVGzs7bTZr7CCeKGogN6nVPeln2Rp2H2KMsY37/x7o/2LbK0xCkehF88V80O9yzGagiDSIkQkKlebdF84EthH/jb5QAn1QOVbqhFtwUg7Sj3nk4PZypAQSjFoDR3yMsyUqV6J8lgjWwdO/Ch2miGJcXiBOXho2Ef25pN+cIctQudRbtuFGO4h9XigrR/XJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83JhzwrKqHOx6vi0FndZIAOlBI2rQ6Zyeq0BF4S9GYI=;
 b=l997D3wRjbRfJ+Ynpw5EHDrdoaj3gCf9/qpez53MeF610gzWYQV0VbnFZqoVHUfOWKI2vwtyX+3Ilryymb6Q8wTSEMGbt4x+8b9Mu8RPkS9RfFb3/bLQQo8gmnmv4uZcER+DIVkmVyqkL5LsGijODopetvGI6wZ1Hl5bVxjxCCm4VqLYBdlur4+d9OidaMK3jWPzyxmsdYHIxWsBWupQqW30RCVeaTZ/MKnaJ3jd6RbpH8ZYCFVHKbiybHzOLwmBrxVQrY4KoOSFaDyIC1AEbHLpRC1VTDCuVi/buLwLIBOtCnLO7JRUXT8PjiUQeApPBWzL8O+3WpDWDbt9BgSZOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com (2603:10a6:20b:1a2::10)
 by DB9PR07MB7801.eurprd07.prod.outlook.com (2603:10a6:10:2a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 13:48:00 +0000
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::ae82:d9f7:79fc:ae68]) by AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::ae82:d9f7:79fc:ae68%5]) with mapi id 15.20.6086.018; Fri, 10 Feb 2023
 13:48:00 +0000
From:   Stefan Wiehler <stefan.wiehler@nokia.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH v2 RESEND v2] arm: topology: Consider clock-frequency property from parent /cpus node
Date:   Fri, 10 Feb 2023 14:47:43 +0100
Message-Id: <20230210134743.41496-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.31.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0117.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::22) To AM7PR07MB6705.eurprd07.prod.outlook.com
 (2603:10a6:20b:1a2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR07MB6705:EE_|DB9PR07MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e427f0-26dd-4687-21aa-08db0b6d6ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NRqoyCEZMKSsiqTt2OrXSeTmW0YgIDePmyq2+LHFqKe4gB9jvw7YIhPRTy58rMbOvcAnQbwELOWIOGrijSTza4PvucZFMwTcuagyowFdgti+L5qjfU7Fp1DjC4/iQApwvzAMN7pdvay3ydvKRbkqOhFn49NEV9A/SWYkoyGQMGujhExUQxWEXbRHl87jmuii3rpEKdtUL6q/CfhmjG7ejv9RJsu3c9+taNt2Pe+1r881shnR1O8kHJQFV1Et3nS5L+4+ivDh8T8oNYfgyY9b7ijGhQK38m/t5YYHFjfLsnjgwzTRNKoTMC4KnWPjN0g6xjIHEZChmdblabjFPesKLqIn7ouEJB6A2zDI8m219bUczgWGHJDxGFrxNsmZpKRriDjIv8EVx0JHLaezWXnqPy1Ko+1QLw52sn0GlbqstAfjykc32Au3nDmUT+MNCSrFel63bIwjJ2PquuMkKwZ/8s+arACKc1hM9wsrGdSf7BMOzZ2QaBKIH233QNEERKSA8Y+jHTlkT9F4E+GuFtxN9NOIjcyqFmhG7OijP2qSr9EMP8a9sC3/hgAol/Bo04P5KK+nx4ZxqfjKHG3EKZ+AdNCz55bfBOS7IBktOqNvtGGvClzCk104cRKMHBP2SGSVwDJfnMjYp29270hbw7aX0zXQdKxZ7g7N8vvrqziEwIzTRvrOOX1l2DR83IQZ55lVJELWDvUd6yi45dK/p1C2lCMjFwGNlFgey51MjoyTOMvS1I+sX5WLBaMEwJckvHD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6705.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199018)(38350700002)(36756003)(6666004)(82960400001)(66476007)(66556008)(6506007)(107886003)(1076003)(186003)(26005)(6512007)(86362001)(6486002)(6916009)(478600001)(83380400001)(5660300002)(41300700001)(2616005)(8936002)(4326008)(2906002)(44832011)(38100700002)(52116002)(8676002)(316002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R9FT0W5l3LSm2Ee4sRX3PEaNP8EkQAiIQmWhtlKver7SJ2K3QkEUse3BI7kO?=
 =?us-ascii?Q?CkLmS84n1gVmGJxGzaeUZZh7kXTLewooUYbbBseQqcXyp2aLuwAd9I2WsyuN?=
 =?us-ascii?Q?PZy5FNDSmpYfrh2yCuQBwPHvPkkWnanpdIDKb/L3bgjppRBKELx1gSyTNRL8?=
 =?us-ascii?Q?CaTT0D00GsWeBHoAcCUkk6LP1Wj8rKEGlVsWnZerGWnHYo928BnnUrnbqETd?=
 =?us-ascii?Q?mlR1PU7+bYORQAn3sK3wQvJKdGYAPXA9XnA9xskdd6TvhGIo2LS6XhYnwSEk?=
 =?us-ascii?Q?QzVJJWj/93KNdlXEA09GHeoVMV/1c2a1HZJuOKTFWvtPCNLeZARPXUfr4yXb?=
 =?us-ascii?Q?wzHMuTf/x8mMFibV0VQN5MGBjzWtILIvqk8nsRL6CuoN1npi8CIueIAQnJcy?=
 =?us-ascii?Q?3agRXQ5XOpHejljiJIyLQO3LF0Cvrkmhyom13obBw5UnQeXYBcsEpuJKBPwx?=
 =?us-ascii?Q?8gh8oJZcAKsMG/amwBj4FkajyYnt8ugxIhhXLicRca3BNGOAwxg5YVmX+6dA?=
 =?us-ascii?Q?4ml44kgW3Y/nSn2Xv7cdjs7JIBkCb1MGhPoEuni01KdBcPOd3Os2ryeP6OPp?=
 =?us-ascii?Q?Eirnmu2CKnq3BXzUooXrZTP1BW//z52sOLma2cJtoXDhOwin4OUUF4aCZpZY?=
 =?us-ascii?Q?lFoB+h/wLDVCbGofXlV+9EMthzGr2KhFGebSh80pD5HD3FAUrrnQuIP1seMK?=
 =?us-ascii?Q?7FGg2ND5axNH2WNsw+AXRSiuWNDDB0uN9hHHGlex8rUIXuEtG+9/9kDV4pzP?=
 =?us-ascii?Q?/DeIeXJcHhMU7kfa+CBiTf1VhlL+dTljcIE3Wln5OcMKjaHxI6pbXKUV2fR+?=
 =?us-ascii?Q?ni1VM3df9x6Dtx2jVdZ9mDdFAo8s4ty/OQnc8czFpNeQXXkn5IA1ckfqkPs0?=
 =?us-ascii?Q?sorDuPWM74iNq3GR9ZY/nCwmNlt6oQcke3meBjvyhTERIyH4PPbEtGOD9DDl?=
 =?us-ascii?Q?xfdXCyNj9NZwNTR3BOm2gMiWULGK6wnOz+5nbw/eEiMcKiiKz9LBkT5LYLO7?=
 =?us-ascii?Q?OikWFnGj36cdMylVzLnT5B/u62gokx91sD0D/lk6aw85XQqkwXGBFc45zsXp?=
 =?us-ascii?Q?iWpW8UGPmyhS1AThpw2WA4weWAt+Qi68ScAcU0B9h4yV25t+69yvZR3272N1?=
 =?us-ascii?Q?GeHgY40dhqfA6gRA3EGk3vYO0pmguAfg6NnF3Pk2MHr10QEfFpTMEiff/BYX?=
 =?us-ascii?Q?y5P8eOb6TYXWKmDiFCK78AUELf7VxMDKSe5I3HtVK3dErZx/yaeYJDIej2dJ?=
 =?us-ascii?Q?SCgOgLfeIyNsta9lLuSHiUXGqiaoPbeEciEMoRM7tBbfQ2Ww0As6NtoaAU6S?=
 =?us-ascii?Q?La/ng1dS6GtY8gEhmAZdrb5kOUUKLvm7K1VVzp0Xybf5bvsenCOSij9C02QZ?=
 =?us-ascii?Q?E7Vl36YPFNyVUd4PNf1JvMFsoVAFnPvYWKhtFTJI0T99f0U4GHf0Xmz+peX4?=
 =?us-ascii?Q?HHL6rPRGlD7ONC1/6SgvIMMniXBfRFkw+fs7Pcl7IkK8aM3TgoiRh98aZEue?=
 =?us-ascii?Q?M0XAJED/sQnHi+JwRE9B0Fw+PRPoBQTAl3/lO5bXjTPhTfSsrKEEeb/0bv32?=
 =?us-ascii?Q?fHQWT9epznoTuDE44FPCXC4tAY/5EfOh8UXILtRlATxE/Vc0CZzV7HrsUiF9?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e427f0-26dd-4687-21aa-08db0b6d6ca7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6705.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 13:48:00.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdwezocyzXW2whOAus++LQhFYLTd9eD0VQAsZ1GdLCgDQIxLrtJsVfpSEUwIQWT8UXwk1KPzaQsDmFlerl9EUriOHtWUZ4zHJZxvJKYEo5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7801
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the clock-frequency property is not set in the cpu node but in the
parent /cpus node, the following warning is emitted:

  /cpus/cpu@X missing clock-frequency property

The devicetree specification in section 3.8 however specifies that
"properties that have identical values across cpu nodes may be placed in
the /cpus node instead.  A client program must first examine a specific cpu
node, but if an expected property is not found then it should look at the
parent /cpus node."

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
- Refactored /cpus node lookup
- Add missing node refcount decrement via of_node_put(); of_get_property() does
not need it
---
 arch/arm/kernel/topology.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ef0058de432b..773c46c07a1c 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -90,10 +90,18 @@ static void __init parse_dt_topology(void)
 	unsigned long max_capacity = 0;
 	unsigned long capacity = 0;
 	int cpu = 0;
+	const __be32 *common_rate;
+	int common_rate_len;
 
 	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
 				 GFP_NOWAIT);
 
+	cn = of_find_node_by_path("/cpus");
+	if (!cn)
+		pr_err("missing CPU root device node\n");
+	common_rate = of_get_property(cn, "clock-frequency", &common_rate_len);
+	of_node_put(cn);
+
 	for_each_possible_cpu(cpu) {
 		const __be32 *rate;
 		int len;
@@ -121,8 +129,12 @@ static void __init parse_dt_topology(void)
 
 		rate = of_get_property(cn, "clock-frequency", &len);
 		if (!rate || len != 4) {
-			pr_err("%pOF missing clock-frequency property\n", cn);
-			continue;
+			if (common_rate && common_rate_len == 4) {
+				rate = common_rate;
+			} else {
+				pr_err("%pOF missing clock-frequency property\n", cn);
+				continue;
+			}
 		}
 
 		capacity = ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
-- 
2.31.0

