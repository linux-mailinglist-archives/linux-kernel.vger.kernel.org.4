Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD6568263F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjAaIUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaIUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:20:13 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2121.outbound.protection.outlook.com [40.107.21.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA623EB64
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:20:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx12B3OCme3Q/eJeKsSMXSEXsRMfl6f9h5yYy4msIB2kl8mCme96PHqa1uWVeZUE70qabccEmSCbXiG1G5UqsunzyTGbd2f6Taq6wKS1/ZdyNj2CX5xfNIsSC3zwTr7+9IWWvn3BpDS5GrNQXg9WtGvqfvwGhWWYG66zlNgg1KkXSRUIlxOFd25Emrnnkobh/kyajTKuEyyl6b9biMRUIDezAxfRnFZJ8fa34hwFd6nMGpYUQaZrug03gq5FKuA9pr8tBa/EM8yC8VjkkvpEehDGLpoGnAZUL5cM4LRGKVgz7Wkl1kV+qIl+PBLkgWMfJtsjSRMmDLjkPZWwPVWbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83JhzwrKqHOx6vi0FndZIAOlBI2rQ6Zyeq0BF4S9GYI=;
 b=Fd8/oU9QPtgj8it/jQX48hCJRlZG/glPHEhz8sa2dTcEKtuVj1kjsAsoxMhU2fETTAsvJrtbyxMZh8CY1wv2+f5MGMnR2K+lr4YsCfF+HdWVYDYuhjrQzbdBrnl2TIlLimqXSFqQKHuk6MzmIbVVLM1a0KKyQIKKLfgXqoN3c/AztAN3cCIRW1Hc9R0SYppuxCqwTfwu6B9dyYFHSrOmSnScQfQi8rSn0QtNYHqjT6cJOkKciHewhuvQencaIZzGLHZfmRg/H7Ka7FxKHUixO2gEp4lo5RSP4Cpa5fUcLHvv/QbrvPUyz0u4j8JDdOQL2BdESGC+5wLNFwPFf3Sm/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83JhzwrKqHOx6vi0FndZIAOlBI2rQ6Zyeq0BF4S9GYI=;
 b=InAj/Sz/Gv7KDQ+VmbdU9RNI5bGqEJn8sBckAFfZSoBLwVpjYGSD9J83RQP4ltSOl2KOJR5vXbnq7EhQB5TuiDFLnUoaR+rVMbq6V5sggreKuXAGTsf5e8BYk5PKVsjMSipOvTJ8Bm67GYQPf7niBCGTMkqWTifMLqCTGPl9EPPXpI/xrfsfLjiHLFWsMSHV53k3F+i6bHkZSarRD0rPTQhqlehSAfgFjTOVUbW9d4xJPzoPwJjs0PMyCQd3oqjeIln3Zxi2pX0ZhTvP9+5FkxlIAHwVQBhj2+BHLpxVPUfbxBorMgbvB4my4mYlByV4wR4JWNMssuqmduxo1FUJ6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com (2603:10a6:20b:1a2::10)
 by AS2PR07MB9490.eurprd07.prod.outlook.com (2603:10a6:20b:645::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 08:20:09 +0000
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::ae82:d9f7:79fc:ae68]) by AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::ae82:d9f7:79fc:ae68%5]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 08:20:09 +0000
From:   Stefan Wiehler <stefan.wiehler@nokia.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH v2 RESEND] arm: topology: Consider clock-frequency property from parent /cpus node
Date:   Tue, 31 Jan 2023 09:19:49 +0100
Message-Id: <20230131081949.57917-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.31.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0012.eurprd03.prod.outlook.com
 (2603:10a6:208:14::25) To AM7PR07MB6705.eurprd07.prod.outlook.com
 (2603:10a6:20b:1a2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR07MB6705:EE_|AS2PR07MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb49804-2d26-425f-8001-08db0363f751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HC6HHw0a7pUqBNx6Llx6+DAHvwa1lWpWQo4hJa/TRa3IbdcfuqzyZXR1mLT5XKdWITU0ub/GHs8JMXTemEwysDNk7gZT/IJeeSjSxLiLsb0yILm5f17AzEV02q67Yf+z0r5rCSU/e9/CdWjm63AgR3jEQu4SH6d3vuJ0K/aqTnUxSHAZV32LOFe8b9sk5f204iEM3u/8ybPisjYa7mD5/ITmJ2zIB501vPBNweqqnBoPoD9Zgm/hvWuQMCGQIC7Dag5ZK19ETSKUqJK2tbvpKMZG64agUC7XqjJlMv6xyJbQT1nXjTvSyIu8G4cMEvoJ/iiJIKhhX68walYnusY2zHsxs1r25QKfrEZhDrPNc9mylpo6+dVWTvtxMAtJxwKxwRN/wljWLTywcAEWUU97uctHqwkGF9M5klT2qOFvmaDvscZmPvvtqkA5JGMxE7Ih0S0N2l5id1WCyYKnKcWvuyM/lvNgmCGKotu+Yj5PkXDJFKqf8MplfQHWnBZ8vCC6DF3nKONvnWhSgojjusdhtjxQxThutGdsP/il/bt8GK7tWieaJzP3FVy0KXq2t4V+MGbfwrjyYCEQzhJgqB2xdR1U5tSRjvwpoe8dHSq0LEvV9zRT89hVgfwM4rZiYhpMXilNZaFLr4+LxYFa7SusgAAyDy1NrZcLXSiytEam+uqGXBxBHEC7zVWsyxMvC3SjHP20B+bCT3jN9TCJVEU0lR3t42GIy6i/5ERJNYf34RVg+HhCRqKwO/xQs4Rv8TrK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6705.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199018)(83380400001)(6916009)(8936002)(41300700001)(316002)(4326008)(8676002)(1076003)(66556008)(107886003)(66946007)(66476007)(6666004)(6506007)(186003)(26005)(478600001)(6512007)(52116002)(6486002)(2616005)(82960400001)(86362001)(44832011)(5660300002)(38350700002)(38100700002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UD2DDNvMI1ummQXNEquKrefqvenyuS7Co9tyQPTC9QfRi3qPN03IpGEAtudM?=
 =?us-ascii?Q?qe8NCWmO7O5O3wsP9c70+3a3vcKJ3PKEXmEhFAB5vudVhcaW5jqpIJSDtvTZ?=
 =?us-ascii?Q?y3FlJ242JKbgXHCo3QUNOLZIRz2wEvPQ35lSQ5JOwziiZpSsxgaByhS8x++6?=
 =?us-ascii?Q?YZyP95sYzFsrM3EgKOBm8gZpBDpuGllCHI1pVlKn66yix+epBtDW9NZTUIT5?=
 =?us-ascii?Q?DweCuCnRFfoX3i/F/Vf16lNnIoAeav7zmr7AigGm8vkpzmlxF9Hm9zpf0/zy?=
 =?us-ascii?Q?rlHm+r1OXIA1jWY8R8zxbTU5L2eq1fU0dQ7URG05caJyxCuLU8ChEzkAbBjG?=
 =?us-ascii?Q?3TEcYgr0Qy90aMsU9dzxoOz/C3fc6LBIGAucftPc8/a9b8OtbW4c8Ix78wy8?=
 =?us-ascii?Q?WqecffhUaJiYD46WkHrL1ngO6C4Otx41jBwLlL+UzNmnxSwip/E2hGG3J2Mm?=
 =?us-ascii?Q?vYppTDLfDQPhe0nHu11nHhHJEqg88XBzMOo9b+JlwYWv3D0a1mxrxhouCBGP?=
 =?us-ascii?Q?pHSq0taVrk3ryqZlYbQvV+gP6ca5W8SaS8aLiXSqEF4HiJjTUoiasCqRVM9e?=
 =?us-ascii?Q?ahdUedYL2M70EtN9qtkSCoR94GV1cJj69BrUr+s3cHqFmnmzwizt2epEY0sS?=
 =?us-ascii?Q?8va7DSB+Sh6NPoYD64keCTPy+h7BvSdv6ncUY/YoxDksoCUtBkXxGgFhPHt0?=
 =?us-ascii?Q?UxRKoiv+FLgums+dHEP/cLz6mrql27IYD3kEQOdzH1V9DnCsXUaFKD0EWKaK?=
 =?us-ascii?Q?1PNbvqNWE9LaBsNsdcwkanmsIjy5HTZmKxHHgQvqWhxkEdy4PLV0HPSvj2al?=
 =?us-ascii?Q?6vdrg8RWzUZnao0C1HQj5KytEyl076pxEoWNriH9NvKcjooG785gdCXbRb0Z?=
 =?us-ascii?Q?iG0h/5VmX4WUlSkRJOIu+bvO9soKIZahqFsTpLbazM8dMwASxnPBrSB/0Sri?=
 =?us-ascii?Q?HuNyUK+Nd7KGL3xJ6dbxU/BgCG1lZ87lKZ91897r7LRTXYjYyNUZo+9yF/Vh?=
 =?us-ascii?Q?oBjGMOpCWZf34darxIwJSpoTrDIWZiaLyrs8E0KglMDUPWBVQ/MuibY7Ykc7?=
 =?us-ascii?Q?hnX5dw5E+klGV1BQe5OJoN6LSicpY1YrtstOk0t/ku2haN/0jLVEquANP7+h?=
 =?us-ascii?Q?0gALbcx1uMF/CPUU+/C/jMAulJgbGNNpvuUGIVoFTqPG3Q9jWmgk2DeaMpqs?=
 =?us-ascii?Q?hTDaWx0HZ+eHjy1O0ns+GbY8tVAfr5ktogjCIvL7DdQwqoSByi34hDuGjGKE?=
 =?us-ascii?Q?cTFehXpkbk/JJF6Oed+3ZAs6nCeHtOaaWQQWX64pHRCEJUsSdfH64rGPYo99?=
 =?us-ascii?Q?UMICKRVi5EH3vtMP5+UvSxqzRqG+0rq0R+WwFJXHcD/myzCzlRiG3WLAf0ba?=
 =?us-ascii?Q?413F9MfE5WDj4RpEtlqWHQ3eXbF1Um8NLMVSpV9F2fxoSyKp0YXvSaiycXMn?=
 =?us-ascii?Q?BRjwviESp/8o0yC/eGFTg8cGGPVvGZj80u3jIGQAqulq0j2AfU4pBw983ZoK?=
 =?us-ascii?Q?yRQqHVFLNDMfoowENM8djYokmZ6GQzRzNeQemGGP46gzUBI6JxdulccOs0sW?=
 =?us-ascii?Q?yUOogLODmMxBd8QthpTdmq6RjQmff35hdMwxxbZ+Cc0HWPzYQGTKi3D3hIOc?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb49804-2d26-425f-8001-08db0363f751
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6705.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 08:20:09.0578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jt3gJUH0km0QoJz8oChToDxi4Ulvq3lfdwMeVYcs6SoN4KfWPH0OnL+HekS8Do4k69oes1x9tujHlwZ+aQ0sKW+0dtAm52kbQ49gZTW/kvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9490
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

