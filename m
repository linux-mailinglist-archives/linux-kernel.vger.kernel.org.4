Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3D5653395
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiLUPmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLUPms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:42:48 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2128.outbound.protection.outlook.com [40.107.15.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A355ADDC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:42:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRfCGMSUuLCnPvsDZLFMUXxJWxy4A50R+fa/ISKLRgO84GRexXZasJSXUmAkiyb61ebjycYqmZcEqT4d4UmA1PtUJ+gVr0CJsqQp9VGgtUHG12w5JkHG680dwJPQ6aA7MKCsR9xTEOVc+PK0LcKRbicggAqZnpgLUpE6ZuAlEpMHoTNkn9h2QmeUisBZ2pj+fs0GgXbMIRj98WuVjkZTNcRdmxt0k27gJTscUr3Er71zQ5NlO0UbEc+yvoj9uJunMlCjqmZipLup+7qleN05e8J9YSvsHW/G5G2NU4dSC2Q4zfE13M8ZzM8K9QkP39ndYO2OfDQzy0pD3w59rnnBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83JhzwrKqHOx6vi0FndZIAOlBI2rQ6Zyeq0BF4S9GYI=;
 b=MZQ5VlGDWZOv1/EWdISYHybqhlmChcmlOIbVyCTQi19XsAddFKVBB2vflh25aTaAA+fT8PDL3m/eAF6Ug3tpfPti0D2jZP7ADMPyemLlQaOC7ouLRflVc1lAKoJlOSNrL1Whl33mnHflwg+OmH+TgKeZDxZBwDPxHGkSnp4Y7m/9Qa7Siki0fgKCncEO1JvtlAhUfI/89tFDztVr3dmaf/0FwPS4fsw+6lf1MrXcMYaCloxi3TeSYlubiPJ811XppL6LTQJNFt47qS5AqyUZFUmTyEqUXBwiX9d2edVdDOkWy3ejheuyGja+yU/pg+4hmJfhDuwdcaN9ljN7e5/85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83JhzwrKqHOx6vi0FndZIAOlBI2rQ6Zyeq0BF4S9GYI=;
 b=M9oZI1Dn4mwKfnaG++UfXQkbKn6cUQUt3oy0Lcsd+eGxshhF+XGBM7ZDffAfdMYwALV0ATDUGMC/HvoWfgc/c+kNS7I9iF5HOY80FYNnXF4o//uU20FROXwoaMe1v/hurT6pih10o+FXUYwfwlwalY9vLsmaBXYseV3daaJTkyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com (2603:10a6:20b:1a2::10)
 by DB9PR07MB8678.eurprd07.prod.outlook.com (2603:10a6:10:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 15:42:43 +0000
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::1087:71b8:5b7:f8b9]) by AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::1087:71b8:5b7:f8b9%4]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 15:42:43 +0000
From:   Stefan Wiehler <stefan.wiehler@nokia.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH v2] arm: topology: Consider clock-frequency property from parent /cpus node
Date:   Wed, 21 Dec 2022 16:42:13 +0100
Message-Id: <20221221154213.24382-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.31.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0020.eurprd02.prod.outlook.com
 (2603:10a6:200:89::30) To AM7PR07MB6705.eurprd07.prod.outlook.com
 (2603:10a6:20b:1a2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR07MB6705:EE_|DB9PR07MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4cd0cf-23e4-4fa5-7376-08dae36a0032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcZRgSp2iKhZsEVot3ccUTdb5uO4qfzaeAXAJ95YH4aMgobXgu+4UoWpPYJTtsiWDZU0wtspExRurnTfqfYe9bNnXBGaXmNF4JgE6VS4lTdcRKuTysutpPbByln7Wkb6udfjy4beQJBRMfs6+27Sm8lM9wjiL8dKRdk8AHmtZu1DpPgdAj0vZgdFnVFEUl5ev9VI6jeh8XUs9fFTZWf69kbghMgclu3T1PBHsKJMg5FvqGYEwAUaYcoxX8WLhcsxGDnYQr8OPLZ1Qb5obA7vNh/Ff2YtvFMusU6dr8LqYeSFyZN6W0PRPtfDcVVocNNOQUNS5MklKb9agyNi9Cbms/ZURkUGfCll+sGEZT1VpwmzO+ZmUOnTzypgrRoBWZwiNC0obYswnMVdETKIFs+lJscW1J9Z7EHJu1034IqRsq41RRvEuFJYSJn1zZwMIyG+H/zuxlQrkQ9V5jqlHRNvIh9v+31y3uyostYAK9WKAw2Dih4rm4f2izlThT5Q3+i7lqZ+YEQVAxAGmjpt+tlYuXIq9u7Hv6LftNN11OYBVN9BO05C5iWcVy0Nl5i/l6EKrrvpJD7qDPgDc1d+swaff/DiVdQS4Q5juRoy5QGz8qFN3vfbmJo2PZdODQDZbo5IgYnh6kCeP6eg+NTr7xS1KKGPO7q6UOHcG/3LoHQjNbylpod8k82TO1KkKEvhYL0K6Xnc9/wwkh2ltfiSy0OF9fK/j5GchNaPeAKMuFOGmtWgTT3TzN50n1ZzUtvzEYB3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6705.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199015)(52116002)(6486002)(6506007)(82960400001)(6512007)(6666004)(186003)(478600001)(107886003)(8936002)(26005)(4326008)(6916009)(316002)(66476007)(66556008)(41300700001)(38350700002)(2616005)(36756003)(8676002)(38100700002)(66946007)(86362001)(1076003)(2906002)(83380400001)(5660300002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E6se6wbVy5p8nSFMWbT8rsaBT1ND8G5Ep0d3u1fDAvTbSD98DFMg2XJqtugn?=
 =?us-ascii?Q?2EuyKK2aQ3d6XcEJ7VN5y5pXIpk9FIrbtrowYoaSiNNlHSegLEc0agK1RqV/?=
 =?us-ascii?Q?LQmoeaT/U7uFHOVwKDs3q0d0W8k5o8arbdDIYZC04dK0GYE4jOtVhq2pZl6c?=
 =?us-ascii?Q?5yJVmvKJRssgh78UxIgHacwh9dQ3rtVfz/KtmiM6cB1feNwmoJms+uoIiiFv?=
 =?us-ascii?Q?2oDfb0H5X3xX6MWB8/kQawSOqdtaLASbgovbu+PVFxBtXlP381IiTMoIzbFP?=
 =?us-ascii?Q?PuHMXYYX6t7IZKG1kZcsXCF3eTNnNPBSz83n249dynWk3o7UIdVXDyxlVdx/?=
 =?us-ascii?Q?GPJ2W3QEVFywdHhTyQpgbaAC2IVnxgTMBrhpITeXuoZmu+rmm6GNqrURrZOA?=
 =?us-ascii?Q?E160VEe35dLGngtYCb3j2hIazj4L2nohxCGuAXUT/pcxu6bQI+n3HFnIBLgC?=
 =?us-ascii?Q?I3/G4XeVwUe94JKR9QA75VTGlylIe8Y7QAcbwStKu2z3derr/qDz1fZfc4l2?=
 =?us-ascii?Q?YCFAZqi/1dv2oFCbSjQZDl617laYFb1pyc7JOcgPnGltwhWMzA31bXPO7vm9?=
 =?us-ascii?Q?kX9XmY+OZqbreFOXKHBh0W9zWL8p8LPYAm1OkSzpMtq9S27MzU6gpgTnQi4p?=
 =?us-ascii?Q?jf/qUQwp6A/yk7ecfA4nfr5uuMSOT24SVtrLE84hL4zbD02vba8DfXmBIu7K?=
 =?us-ascii?Q?sDV0ghbS8wNggCKjIa+CR4czWuVS3k87NDu0tVemsf5xlr+UOVLlElyYgipV?=
 =?us-ascii?Q?EaHcIvpAOwca+5+1v8iKEplbRHpHwgqVLCZZCu/Uj4P8Fa+78VB+2grnxCzj?=
 =?us-ascii?Q?qC22AoEZBhd5JYXeTD918dHfa/E7+NVYLHKO06JER/jK06204IHyu/AIT3S0?=
 =?us-ascii?Q?lyhbSliul2kErLPpzXIizySuMsVLDieLBRU33minfGYFkXI3/gQddX7qxhzz?=
 =?us-ascii?Q?H29TY/cvQT2O8Aknv0yAcMX/GGmHJc+Q0dwIyYkrn3C+kcpO9MXx1LI81dav?=
 =?us-ascii?Q?5jFxrqtJza5vagCmMu9GFg1erIwQ7f4t/0Nm4XbjA7Our9Np1YRAq9XycPc2?=
 =?us-ascii?Q?QBku1ExN1S3D8N6qf1j+GuVrbjOGc+XyGdWnKJrmtHIOn3sUslB58EfQBNMs?=
 =?us-ascii?Q?E3+C2HTGJsDW9dtzFPu4/+dXDue/FOU0PgxZWzdhRst8cCpyG/8u8l2FWNTx?=
 =?us-ascii?Q?OMuEQZ6oOdOgJobrLZBWMwxiePA2n+6iHodGKJseGsUlWXAZq4OT0kDbLG06?=
 =?us-ascii?Q?Kav8mgLxoP5bNVSGipuI7bpm7IW8oSVs7eezN0v3HUm0W/eU79XK7Anugj/+?=
 =?us-ascii?Q?Bn0YFQldtK7WtC/pccg2WbtMoIcOpatBvbYpUME3isram8gwhSsTpbyvVGWw?=
 =?us-ascii?Q?36hzIbRNQI7NS4Tz4wGHCByxBXkUtURNK1PAUym5RnKRIjxmfo3D7u3CEVF7?=
 =?us-ascii?Q?w2dFGl+dv6kfF6SAnNYoK9cH2SRGs0HFXnYqsOymNuf4MpQEMlYNR9k/N6mg?=
 =?us-ascii?Q?ablswAwXzLd1vWsHTaLNB5GoPcwzy9hsgk6Tb06mdzJY5U7mVx7kt9Z+jZzw?=
 =?us-ascii?Q?ZiT8A+zbNT7o6fLbjloDmx0OTboR8k8nEQURY31EviYNWef8QeoL1st0/XzT?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4cd0cf-23e4-4fa5-7376-08dae36a0032
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6705.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 15:42:43.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /S/ziaFS4hFCU6qD/tmaz8p2nsnuAzTbu7ZlOUJH/eijWImfFlcEWmuHljzO7iACAAxLHZPqvZXhOWOfo5tnLsoXLbgLWz5I3XTrjatmaFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8678
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

