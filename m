Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8107564EB8D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 13:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiLPMmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 07:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPMmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 07:42:54 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2138.outbound.protection.outlook.com [40.107.7.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9876AE03D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 04:42:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMBrweB1iuwZwunqry+TMIgxLXjsRK4qYmlpPTso+G7akNjJV9trGEoi+e/Sw0Dfa8v+8+oUHBY0Hs0w4nXRpWz4eBxhg8rH8U+cYeFOvujVtI1MIRya+uQ4FjQ7EYAMmNXQVY0Wd939UgllDIDQddzbAylNm+okVCc9R5c0Z37zC9QOUu0vf+T/EgT1oStxgtV3STXjTsp07/eXGsqmHOILhL+fWBD4wBiIlikanCyYxIwZ+rfUmHwDnSnIE1RcMl0pnXXmkZ3NjdpTxPkQnGKv3q7FJcucEKuq0hsAMBFHx1oxkXhHjTJtAF2GYdeWGR4+l2oljo0jYom4u4WuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NzM5bPNgoZcA1NomhBWx/cryuopF4ePRuJNhuJwv2s=;
 b=CulxirNBNaXScAoGQ16tS+lXrkmtKMpvmWvQVBAlmlIZ6tLnxpTlVgnUKsQU5h+1vZY0KwjyQ2yGTY0pkBA416chphDx31b/ngLfqHhC/70G4u7MLPJfEbQhmQLn7kOJwm8G0aYfNRlXzlhYMI2csPSPv0RtZKfrDmcFrgoaSr003qNikxtSsEhepS29/+WZSGszi0fz88n387Lg1aUeMKEmxC3g3INiaD4Y0U74RNsnDU2EXSV3IP6kgtAp75zhkEweHooVDksxSi3bhKK4vF8MLqwXNSLdEdDq47j3wql6tGlKSLTrFvugQwXdoCyMKc6TRFZA0/7uVlOQHwP8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NzM5bPNgoZcA1NomhBWx/cryuopF4ePRuJNhuJwv2s=;
 b=DFFslC2/DGx4Gb6yHVNjsXMXwR5eZmg7D3HWMcQZ2XpatkLWhJE3IRKuERM7y9gJyaS5IsJnBF4gmnmUM84RhOZCp6ZyeTTT33f1Wbwp9wuDtbCpMzeh90Kk8s1ETZUowvtPEjubzvc6RLGGrUc+3VQvifElqHrdgchT5yWn8qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com (2603:10a6:20b:1a2::10)
 by AS8PR07MB7767.eurprd07.prod.outlook.com (2603:10a6:20b:38e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 12:42:50 +0000
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::1087:71b8:5b7:f8b9]) by AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::1087:71b8:5b7:f8b9%3]) with mapi id 15.20.5924.015; Fri, 16 Dec 2022
 12:42:50 +0000
From:   Stefan Wiehler <stefan.wiehler@nokia.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH RESENDv2] arm: topology: Consider clock-frequency property from parent /cpus node
Date:   Fri, 16 Dec 2022 13:41:58 +0100
Message-Id: <20221216124157.13270-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.31.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:200:89::32) To AM7PR07MB6705.eurprd07.prod.outlook.com
 (2603:10a6:20b:1a2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR07MB6705:EE_|AS8PR07MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: f2aa00c5-f260-484f-4e12-08dadf630aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCC3eXQ5PVw2DQR05DJl/PIVf43RReBq/YdRQtrKUEHis7B35glGGZLar+A1yw+c/V3ax5Z78qOW2KPXh6nannTyY1OOfXWhs6nkVY6l1Ip2kkWkwq/olLozBPc3Wtp0a8gkEmoEsBTkfWeF6QWYWKukcxvJavUp4sLZOHf6b5hWjQM/rtHdsy1g6xmxL52HLWKC2H27lMUs8cDa3FfakvnVt1MnUrc6eb2PVXNhO7+VHQySxm6k45PLFXIC4j7RdolyZ8WcXclMoB91832I+RT/ZCOAgHXv+c+d0XWasivmzNEhy6l6MmG9G0COR3qfhUzPtTc1dqYmrHdkDyaYbl7id+LBsSFbU51S0oyNHvPaUt3VUzC2xuBIJMuX89a3+7aTanXz0fUp/Zc/L3G8d6NP2QizR1xpD7FeJP4t9NaAIbsPkla3MxCVPqGzkU7wz9rYKf4uIo8CyAf16+rHdmuG89K9Bd327Omwm09C4UnDt4jLqde6yRfZrGRsYMMDJGMzxyf8QtW5d2n9/AFY298NxJyi0X0Ceg6h/wmfGY1sG97RIf7KCXp6ZoR7BufqOJlOZHItC5siaDU2KDtpROUkQZXoMTZmt1XFxDcB8TUv9NF3LMHzTfWr6L/xccdY2xeQmGGJS3A8U3JfXt04jc5EsTEUyymUnQYosxVd/0ckDe914fU0k6BojSHq8tZRtGVVY6QfSQ6PA0MYO9uU9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6705.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(1076003)(83380400001)(86362001)(82960400001)(38350700002)(38100700002)(2906002)(41300700001)(8936002)(44832011)(5660300002)(107886003)(6486002)(478600001)(2616005)(52116002)(4326008)(6506007)(26005)(186003)(6512007)(66946007)(8676002)(66556008)(66476007)(6916009)(316002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1IqxEPT7XrNJWe22pp6Su5rzhrimZq2O5zMsSaseFPHabg66YG9i8mkT/QwJ?=
 =?us-ascii?Q?z/dbMMG0+tshu/QT84HudLVfwPCDR0FIXSBFiHw6cykC5gLpShHQy0VwKzNe?=
 =?us-ascii?Q?DcJjUc3/hZKg2gO1c9WlNXTrEyx4Xoj6dasmC1XaF+jiPI7b5xfsc4YLbf4a?=
 =?us-ascii?Q?XkgFdNuqRuTYISUZR9Byo1PVopdxd5109JawdANAKO4Agdbjl+At92w2TYre?=
 =?us-ascii?Q?k6boQk7aUf34r+OdXf2CqH8B2aOunxO0/2paNQEEgIay52Cunw1WpJFnKzpW?=
 =?us-ascii?Q?PE8MN2G2b9LcmdjFJ3ywe3UQCj4JEpcsGAZQzIonDPUu9zsgP0HEXwBFOqlI?=
 =?us-ascii?Q?kIajkqSGJeaqwikR9Tqvb1CQda1Afno3xV9JwmUpoMljdtgo0DWOsub1wdcN?=
 =?us-ascii?Q?S32yL4Fi9u27EKQgloWCgZVw/14UHdhz9KzjRoBz/5yVkV3vREzo9K6I39Ct?=
 =?us-ascii?Q?unxt8lk+GzuEbva7YGH3YLue3IpoQCvsf2hlA9QaXnGWF/TjEW1lCiGjgqtT?=
 =?us-ascii?Q?rdma43VdAAjTlEihxoMvX03Agnf1QwEHDIIsUY+RFyweRkB8RzH9pkD/tKmA?=
 =?us-ascii?Q?KY7PbiOlGeScV9Cqgpqp5ns10Cy6C6mPr4OetWF/oepNxhUh3ZkU7JFT4xmQ?=
 =?us-ascii?Q?zhF6TnSBaxh7Ag+YyPme2nEfYuI72/OCrOo+1aEMVHSq9XirDrqAdfcT7vXS?=
 =?us-ascii?Q?TftQhL7EIhT9yY6dOvRw4qgWyODSTqfhfXeO80bIsRwvp55eNAMsKIpjZ6si?=
 =?us-ascii?Q?U5DVjfrvtaGEONYJ/KYlyU+gqa9Qpk7l7TKNg2nwiJB4rBFC+wMJEx9PFAof?=
 =?us-ascii?Q?Z6CVP1HE5gUdBr0a3JHhsJj734B5BmpHBbAy1HJBSC9a2urQ4rggQytqjk5d?=
 =?us-ascii?Q?isAwL3S0V4aYECNtL2vxNLcha9nJtooO2+AcMKUQYpZtOW6jvwidjngKTVF6?=
 =?us-ascii?Q?ZIWkUqTjlMSySwy+H01FurOfUTBtDxqBeGkv2YlLzMfXJjlMzmZW0AWbc2Y/?=
 =?us-ascii?Q?SVS0tqq0uaWa5zRXKMDce82BZ6rip4VAiReI62CUa7J9STeXqtHsrOGzldOi?=
 =?us-ascii?Q?GglxVOqr0RNCDvgV60HExzjSJwDKgzE21JZtegc8GuT/UmrWIaCn4HqbMcGq?=
 =?us-ascii?Q?n91JxWiDyHorG//lRpSgkK3vgwpXSK4OHfxR3GCBmdHl5yYo+U2mESroxajC?=
 =?us-ascii?Q?J99uJWWNQswT/F2ZPLbSHw1nirys6vk5vapr+3GnwURk32dyE5luouomAJ1X?=
 =?us-ascii?Q?MUVwki1PodHYAn5fQahanECtg0s3dgiEL5JpFxS3Y9CEYzipiwO9qLCjC1SH?=
 =?us-ascii?Q?yB3cZZWXAaf+9iF3B66NJk2owdNEtVKzFfi1Hq2p0COqDqrzqGtFLz3rK7Ws?=
 =?us-ascii?Q?8DEwFUiqKdjOkgn9lGNMIGkPDD2lKw+F8QPLsgyG5Z3kav62aU9FruffFPt3?=
 =?us-ascii?Q?AG+Ea1k5ae+6uysW7TOc11pSObVHW/ZLfnw1Z5pl7OUIvs8Q8hIUtp8fGDlW?=
 =?us-ascii?Q?2nqY1J6UvuigSVRifewEjHJvG98Tjy8nr2Sb+OAG4JuSf5LxVLQ4mAdcjEHK?=
 =?us-ascii?Q?048EYoN/2hERDjjMlvXp/jInpeQJXe1PC3FDUhTMfHh24TPn0MSiR/0UEvcw?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2aa00c5-f260-484f-4e12-08dadf630aa6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6705.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 12:42:50.0575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylxxeNf9VmKSMankYEna13Mq874pPUdRpPGsxLOjTMBzQuNlQedzARhXqQL/8QHxglXUcOFefK17Q+Exa4beOrOi7r0t6VE5lCzwVH/ttkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7767
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
 arch/arm/kernel/topology.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ef0058de432b..fe03f1426353 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -90,10 +90,20 @@ static void __init parse_dt_topology(void)
 	unsigned long max_capacity = 0;
 	unsigned long capacity = 0;
 	int cpu = 0;
+	const __be32 *common_rate;
+	int common_rate_len;
 
 	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
 				 GFP_NOWAIT);
 
+	cn = of_get_cpu_node(cpu, NULL);
+	if (!cn)
+		pr_err("missing device node for CPU %d\n", cpu);
+	cn = of_get_parent(cn);
+	if (!cn)
+		pr_err("missing parent node for CPU %d\n", cpu);
+	common_rate = of_get_property(cn, "clock-frequency", &common_rate_len);
+
 	for_each_possible_cpu(cpu) {
 		const __be32 *rate;
 		int len;
@@ -121,8 +131,12 @@ static void __init parse_dt_topology(void)
 
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

