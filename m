Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6237C728998
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjFHUiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjFHUiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:38:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2091.outbound.protection.outlook.com [40.107.243.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EB21BE8;
        Thu,  8 Jun 2023 13:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYJfLF1j3jcXaJIZk8Z6WePGjRMyffWCDxle+AllcBvjRXWBkGeJSbtz08DxA8xhdwbHgDc/uklmuXLjWLs7VSVvYrekYgNZhjrsbQeFkcNR0Su0R2pbJTdWHuX1SwhhlbvLiT542JxBOZkVRv77OYLmEHtieVZoubfz+LwoAwBR35Ejvm7JbiDhG2Ynr0YYuSzU65PYO3G0Y969nfZJ/wSdKN/SufymXFcYEJVaw5BDLQ1HTQfGI22S3VUcspPLGC7nheyytooutHdJFQz8IU5iaInEzhk/LM0sSRtKYv7lJEGijcTU9VhRD1K3rNrN5vT2/tE5Or8UkIhvJn7d6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAgeodxrHzBfPD3iF3I6usiMPaomjhchm9OeASXTV5M=;
 b=MC5j9fH2dOF7IcomSjrYBl85xWUrDDd2pT0LV1FFfggLw6hFcqsaqfgftJRj4djvH3rpiMoPC2gdezhVDoTOeoIv5HeEJLux1FedxfDu/3JvYI3CSaVBEJY+hsXOMS8d9cf7gczYDol7vgR9PwWdboyhb8QJlM5CysvXAFXKVIlXrnegqwWxnTxW4kjPOT/JsMQ2Xr2j7GtSSfaMYPkG09dZhDpeSWCqEwRRGSQUgy20/dYbXKC5jUSOeNqPYx0x0tdNkEILJhTHHSKkLu0TVH7pFr7qec3RZs5z1Nvm6mSLyTAeNYMZWB6kxnUl6fOtaEzKr7tvqY3KiH0SwBxT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAgeodxrHzBfPD3iF3I6usiMPaomjhchm9OeASXTV5M=;
 b=irAAOb+jgzMXzWKr05/ywd9me/I9/TI/icqLQezFNagsAv8FeU/EWZL2qg9zmxq4x8HKdoEU74VzHP62ZIRU6phQ4I3266Zz/BURAGkLyk8sgZ7fXQm1K30bZHzEoMjrR82a/ayerpunSAV8nZ5z+MzGzmPpbCPnUmg0y91/Z6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 LV8PR01MB8656.prod.exchangelabs.com (2603:10b6:408:1e9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Thu, 8 Jun 2023 20:37:59 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%6]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 20:37:59 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH] perf: arm_cspmu: Set irq affinitiy only if overflow interrupt is used
Date:   Thu,  8 Jun 2023 13:37:42 -0700
Message-Id: <20230608203742.3503486-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::14) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|LV8PR01MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c16a67-ddbb-4b90-799f-08db68603f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcIR67CJdI5mKFUjBG83wfX0J7FP2HFHdzJrkigijIS4dg63JI/rkVSQLo91rhAYijTedsRm/zEq4x7q8cUwF8phOLcGu+ag0TK1Z4yF29kQrWirQ71pTcrI7hwu+VQ1qEsDf6iAgPZ5baXdfFZAjIhzm0SaFL7Rfm8uyZDgHxjk9dsFI4iO/xnsF4OFFbrhFFD6fO0je9o91ERGBOEZhqrhid+zVLvKFKoE8DqLMLNQS0l0lxrREn76eT0qO1IIgZhecvMzIQdoYw7oFRlkFF8h4/dteYu7aStIlaCmnD20MD/bP8HrSLUzz4GQZHD5CeJhlPnL2oYUDJUf3YOyfyxRL2M/2z0r40tpqJxbm+1ZXIyPUK7BNvbQHbTdUNp1qquFUxpGhzttaFkmO55uxCsTpdnrmV2gYeBbj5oWMpE5ZYqdaDxoJkiilZUB4AXLy2Ne/YfiKw9wnyXVgGHlenO+Y0xG78BSPs2akQmNWXfh3StT/xj1E+8MJHSEpKyYI5zSrK4KpCVe2R6LDFAzrZMSnKBtjEdEtA0+/bLLAIXb0MECTWuaerOJbNP67RInimkfUZNyjR9BPJIL6iVz+mh0dqnhgt7t7W281tKjBOxRm/qBQCNthsX9ZXvbuQfp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(396003)(376002)(136003)(346002)(451199021)(66946007)(86362001)(38350700002)(38100700002)(6666004)(52116002)(478600001)(110136005)(4744005)(6486002)(2906002)(6506007)(316002)(186003)(26005)(83380400001)(107886003)(2616005)(6512007)(41300700001)(66476007)(66556008)(1076003)(8676002)(4326008)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?38xJ/spOh6I3mfMBTTvKoTRwj3tvqrqKaHSCcq8PmqhXx1EnCjwVD3AbWttO?=
 =?us-ascii?Q?WZpeEcAh+7sNAgVnOYaAO0DSkCmddFklHBPEuXOv7H0pjo6ZcDO0QKvdQ/5f?=
 =?us-ascii?Q?YGUQbug6sWL4tHrowe2fwqRuiT4Q8PWIOnJeD4sXtu0q5zOcjebadJBKoPNv?=
 =?us-ascii?Q?rPUZoJvQ6R2L0voJ1QzDGnprOZ/9SaycdV6IuQJAukUC7a9BgZ8s0VFgEviX?=
 =?us-ascii?Q?CMEhj0kwajN52hAOMY/oYl3Hy64OFKf95YfLl4ACee7CPz80chqL1an3tz6P?=
 =?us-ascii?Q?8Om7+IKvhcQl1oG1HIbMT/U4GffnIaPefjjlw7805Rsjx7FB5kzYxH4zO3wy?=
 =?us-ascii?Q?bx4SrIiYSBCccyMCHCYNgqHGibbflwz1FmCbcMYQP+xIAKz3vXx8C/PxOd9b?=
 =?us-ascii?Q?ZUBG300HtBCm8UP0TGOoVcmTxDhpNNMj4uSzdbRJUO0mKDfNibvexso/v2v0?=
 =?us-ascii?Q?dHUBkka8N3MOWbQtAgqnzg4aanyYd7uhAEd4U2WJdzcygh3hunUJQlfiZEue?=
 =?us-ascii?Q?RehXgfsooT6yGBckYEi6kAYKOFSqomuvDhVcREv+H2yWaKS4THEFLa4bss6I?=
 =?us-ascii?Q?hnbsjabgDQ2quvuG5XK/dXk7aVLIxy/T7FESOUmjxOkA5sTewCO3/QqalZ7d?=
 =?us-ascii?Q?ruTsKSeL9qhBVpdKlOf35im/003VbK3DpN1ifgLiQJcojehL7Ld8YDy6zI2I?=
 =?us-ascii?Q?EUxprAwnxH6s1IhCugjdLnKSEMoBOJMbH3ksL+dx9AU2QibUst25UXqw640M?=
 =?us-ascii?Q?AlDDQ+jUO+yArJFzK9nkzeepPrLBWo5BSgktQSJBQl4aKlxvdR40bP5aTrD4?=
 =?us-ascii?Q?HIDK80tYbUuEuj5jt3gAyQ5JhRhvc0tcJB16fUUUmwGo1tbZtdZz6hg3421t?=
 =?us-ascii?Q?qsjIxV00MOAWIQwUj58ntos5/tz3Pd/vhvRcUEdejhCOMKEjkfD+MHxphqz/?=
 =?us-ascii?Q?hAJl9XCE7LrZ2MSIlNULebM/akNZFSJDck0Huli9R+P22+5G9cg4baAHtYJ7?=
 =?us-ascii?Q?8BkhU4HYRVNNGd0wqaZSzc4c+VNoMC03dIwOWrv4iBm40R1y7l/gI71+FCJo?=
 =?us-ascii?Q?GLIF6J0UpW/lkYMs7rNnpvhy9nV92Z6WLip+AzkZWnrDNuHSsoFGqWS7lBVi?=
 =?us-ascii?Q?LXw2hHqwrqFQtcaxAohwAYKjxDwwRQeI5YdGvrNkDGRavpPE2Jt05bcYbe1s?=
 =?us-ascii?Q?ipKVC4Q1zAv1sHiFqLmUtiBmyMcQAaQajJa0wcrKf4+AuXjGF5koBaJhQ4rJ?=
 =?us-ascii?Q?RJdc8Tm9WXXG5pmT/Xam/n06+Lt6+sMvP+7FLchBn0UUgjxAbQiYFoUmXjvm?=
 =?us-ascii?Q?jxkc+JHxpNgiqz5HVjwFOnIso5E3SoTR1B7lIkSz7wF65vCo/MxhDYFS0pI1?=
 =?us-ascii?Q?XsXXsosmqkufyVEdHrrEYEUYwW76T2wZOyr+029Nz4jZiLP1yN078x7gZgio?=
 =?us-ascii?Q?ZdswkdV/EZyBXryRMqLpV5raQeGpUydpzYpPld9g/UNl4aSqXeDZqMaYj1lP?=
 =?us-ascii?Q?34X42tFek3b7MaIhzn8H2p+/h25ESCjsGRk7Olr0B2atyMViK9BMA2/YTIzv?=
 =?us-ascii?Q?OohQW/Z3SIrjw4OA8chP3omGsjU4xDhfTl8xBWu+3oxOyUb+zC5x6Tf6zKgw?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c16a67-ddbb-4b90-799f-08db68603f00
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 20:37:58.7981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wz7FP5P/eAe0TbTvCU7HdCF4h0Ey/uvcJJhtuCkLhcJ7dDKBEvxb9Rjxvt2dL+ElJgEnOW+uuUnIEgM7POdYU1+xOkPFi2rRFO0r+mu2Bx68g7ICad2R+nEr4WMSJfRB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8656
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't try to set irq affinity if PMU doesn't have an overflow interrupt.

Fixes: e37dfd65731d ("perf: arm_cspmu: Add support for ARM CoreSight PMU driver")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 9021d1878250..62be0956dbba 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1250,7 +1250,8 @@ static struct platform_driver arm_cspmu_driver = {
 static void arm_cspmu_set_active_cpu(int cpu, struct arm_cspmu *cspmu)
 {
 	cpumask_set_cpu(cpu, &cspmu->active_cpu);
-	WARN_ON(irq_set_affinity(cspmu->irq, &cspmu->active_cpu));
+	if (cspmu->irq)
+		WARN_ON(irq_set_affinity(cspmu->irq, &cspmu->active_cpu));
 }
 
 static int arm_cspmu_cpu_online(unsigned int cpu, struct hlist_node *node)
-- 
2.40.1

