Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C966CCAD4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjC1TjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1TjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:39:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2125.outbound.protection.outlook.com [40.107.237.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639C7BC;
        Tue, 28 Mar 2023 12:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+UGRm8QXTBWQMO6kiQ4pyj7k6785u0qbL+mFqtRb5yPWSTIieqVPOAWoSNd42ZbgYlkmidDNeZ74cDbxst4gcUKN7BSw0DUxJT14qlWsjbZJY8hvzdOq8mOITD998Pb7sQRi+jmz4TvemN4wP9iCUSlsR2rM0PhLk7F5DdkbA/WcTLgLZGWKkqlXhW1VHgicwrErGT7eUZoxo4HTXptGyFJcojAJUC7bkkQmCluaIpYCJXeJ7/1rEyaZAVQtatODgGDP40f4hqXukxmoP4VDl9QEesp4yBCgIx3NVcDTjefTxXhMUt4a3SsEXhHwfMg3Rl0tXGaj87sfrVLCRMu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umXcZf5at/TimhGid+uhEy1Y5kAv+WdgkmVfyPjjZsE=;
 b=TjggBgcmBUq0Mf0uFhXYOjxRqOzqwxuJY1eOeC9drUV1A4M05Oz2fb2cAnWZH9SxTk/JnMKJU+0qzwii2lueYeagx5YNhAvrG5k9PoekEHh83RAurp/hswRmF1fDaoyBinu8V213t/kogvVUV+2IZcfR8jcR3PKdwtftZfgKVVbNCwWY8e1sfo82dPcZhfRUyJYsP05dWFFY2ZLRrTFQCsTqIWN28FJyH1WitIOEn/PHIWTdzMClEYmHpcyZv1Wyb2LHbDT9IGZ1LcaLjPhaidldfy7OkAMsbGfmmKdFl2gWKfbTB4ul2V4mGbBiczFJ182Bb5ogVri4E6M/5EftEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umXcZf5at/TimhGid+uhEy1Y5kAv+WdgkmVfyPjjZsE=;
 b=SgzInUjQm9zJTq1qMdL40K0Iwj4mXtd42v9/ru2B/ZujrNgjRsqNt9z/LFOdPq41UpXhiDyRL5+CQIqrbiU5szEEzVtRdc8w7WjS6QJmtEy72wnnSpKT2miUnfGqjIpkYuHVg9t+EG0gPtj5g0ulloKs41HHaB6W9RVdr1l94vM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 PH7PR01MB7557.prod.exchangelabs.com (2603:10b6:510:1e0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.10; Tue, 28 Mar 2023 19:39:00 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26%3]) with mapi id 15.20.6254.018; Tue, 28 Mar 2023
 19:39:00 +0000
From:   Yang Shi <yang@os.amperecomputing.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     yang@os.amperecomputing.com, scott@os.amperecomputing.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid high error
Date:   Tue, 28 Mar 2023 12:38:46 -0700
Message-Id: <20230328193846.8757-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:610:75::12) To BL3PR01MB7027.prod.exchangelabs.com
 (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|PH7PR01MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: c97e52f9-713c-48ab-73b9-08db2fc413fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrIXoDXlFFu/yR/QgjmDL5I92dAwHFw/CYw5tYT075/67ECIU+eQSTdpiF7EYdpFsrLkM11iyyUpY9IEI0HAy/YJIgC1R88z2mcn2wIzGeaZMJ9CyfA+xjOXPBAiCVT80NIIg4CrDqDn3u7Cx8JWjxyYdpzAzksVmweCECkN9nkHu+O2SRC569/W+xL/IVC8hRfXmTzVxEi2BfJTltdMyRl1Eft/0lH2qh+EzRXcXdPGVgCVN1SqV32EJTeKP1BTqjhe2wZR4bekRR7R4vx6s6NhsNMqjdauqL+EURft0wf+1VCKcdFSn9LBpEIn8kPWxrIPM13+3T3wyrPP4fSYX3+Hum4kenuk+n/6u/Dg/usJrZjH+NoOB88W6fF+lpPi64da4eMXOBLw0ix5sPR5Shbf0NbXSfG2X024DOxv9x04vj7jPeVoE6tQUM12x/voI1MXxFzbphAquh5uO0JLOa0ulZAncaeC8vL+tzy41M6Vth9ZcMqwIMDVlSLL2cLNhJBmSw+I+XEtwpsa3iukY8U0yS5ATO4aVCaTnCYFSXMtp0JNMsKgV+3X4PBLHntsDaf8ckVAvjB4MHlY3zZF1kIdrbqL7GdBvXmX4xBhjD9Lr1edG7Fl8ip82a7Pe+/I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(376002)(366004)(346002)(136003)(451199021)(316002)(83380400001)(66556008)(2616005)(4326008)(66946007)(66476007)(86362001)(26005)(186003)(6512007)(38100700002)(41300700001)(478600001)(2906002)(1076003)(6666004)(8936002)(38350700002)(6486002)(52116002)(5660300002)(8676002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EPmAvWgHebXP7VqTGa4T5nQL8jUPCpkEzhmGEa8/QuVfuGFEH7zlDlQ+xGRh?=
 =?us-ascii?Q?OiohabjQTd6UuSARNaTVWn0INOHafQFpsv9kpIv8BH0BM8M3dLS1ZWrzkfGH?=
 =?us-ascii?Q?y3/zFUEC3s37A28tth8RBgkwPVkUS1bh8cK4w8Rn95tcIXjm4t2QNSQKgNtx?=
 =?us-ascii?Q?iTgYNVK1RPoFhO1H0b0Lotn1SnKIGTCNwKCLIoT/XxDirFwhNLyA2v0IiW27?=
 =?us-ascii?Q?05t2EVGij5exHdgSQvcBVc88BSKVwj0x9p+cBgBmVeXRv3g/g4WOTm53bFmk?=
 =?us-ascii?Q?dP+c7ly0SdIRA/g0hLuHEphnsRNuqVAK/CfgPLm8RcYjMEbR9027YS+33FHY?=
 =?us-ascii?Q?IUSLxqz3YLUHmYYOpvZ90HHnb7DVj9CxoubAiWgJFI74yPPRX3XOlZUjXAF3?=
 =?us-ascii?Q?5qU8sFuIipluma4bXY9Yo7yvWYp8/q6t3mUBsHPUVETwhbtT2WllDxWgEQkn?=
 =?us-ascii?Q?Vyp+Jd2osOQeNDWeMwbDK09CtR0guybMhYdvZ8RR0cURwESwiH3HDtIgOARz?=
 =?us-ascii?Q?dSgEEDTIEQBueSV9jfAGwazaxRkDbwQFaCX1RSX/jN7Eb06D8b1za+Btb4yj?=
 =?us-ascii?Q?gub01gBk2F0ccRRwQJtXT5p1lucX7jPEyrJVMI0mFpnAyU3WNb/GZzJf4/1z?=
 =?us-ascii?Q?lqQKBFmXlLxF89o4T37xZSvOQTDUVFVJOAXXFF29ThucutJV16zmJGIG7fJ1?=
 =?us-ascii?Q?ahx8PUXvPUDGLAfs6uCGNqNsOguqpzfEOh986EjYtAe05dtGnneiADqUoh1v?=
 =?us-ascii?Q?eBUCH4HThpnNohHUQ0ahCImPMJCv8OW1GDU32XD1lPrKIm7gjq6g9TFRMAqj?=
 =?us-ascii?Q?5QB1eUZ1eNPpLL09wFfBrnzZvzpn1XUe1tUGEstbwqVc4pmMBbuxNSsKo7Ou?=
 =?us-ascii?Q?/cfWLqjB3hFltlTTCvgLw6d29AKZe069SbgUFNTm6nseRANhdt6GriSiu81J?=
 =?us-ascii?Q?FM522Nt08Dy2f6Bk/m3Fzz4FCCZewUQBhg+P7UNe0N4r/+XaWi6TUPXhrcC4?=
 =?us-ascii?Q?Q40FCsYZ+NfSUr1kjPDEz703JTwMvvi8k54NSAUmrwXH4/tJXW0njDwBA9Mo?=
 =?us-ascii?Q?yLgjHRluGy01S4DQkT5BMR/6rniBmUt5YG9dz4posOcnjoSqqbLcjS/pOGiX?=
 =?us-ascii?Q?eTbKNCZkHrjjUqyXRJBEIZb+QPzFKCatjPzMmTDGQpN42q89PB6CivJr2e1A?=
 =?us-ascii?Q?oEJ6ih2oYionpIEdrrcFGMSjjBTSU5yFisTzeNhwZOLGCSU5SMOtzLmkuY1x?=
 =?us-ascii?Q?8J7Z6V/m8rHmhQvHj8jxB7VebZ/ZRnl5Dys95JPbjNez7U8Ss7UojWzI4Y+o?=
 =?us-ascii?Q?d9QMqLKpORF1qEWgyJrtKYU4pFiQ8Ahy4wb/CGEWcBbXRzvOklZ1bgMXgVhm?=
 =?us-ascii?Q?VK+VgpV9dQizvYKTrB2LAaLfo5XDNeyYkR7aVVuIS0OYfKoozCiB0g4l5Afv?=
 =?us-ascii?Q?tQ9AE96AABovX7ZNThyegdypHJNn5YojGJL9yUNs3KR4vAGL7jTbfU96alLM?=
 =?us-ascii?Q?kA1dL/8su7qhl36pXi2hMo1wx8+e1sA6hy/5BALCYqQ+OSak3QBQr57F/DdV?=
 =?us-ascii?Q?zBXV+Y4p17Rbky5xxkLL89CYjpYYbcGkMiT+g6ZAHrrqiRPOh9A4L0uxg1mq?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97e52f9-713c-48ab-73b9-08db2fc413fa
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 19:39:00.0129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOb0OL0wUTFo5bPbrU5TSi46u0nrJFyWo9VLRWIL/tBgLEZFf9blUwljlEDRNvSFClGbujT930w8zfIeQQOo8+NRPpwITbEkJWeMtVFv4xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7557
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing CPPC cpufreq on our platform, we noticed the error may be quite
high and the high error may happen quite often.  For example, on a platform
with a maximum frequency of 2.8GHz when the CPUs were fully loaded (100% load),
we saw cpuinfo_cur_freq may show 4GHz, it means the error is > 40%.  And the
high error (> 1%) happened 256 times out of 2127 samples (sampled every 3
seconds) in an approximate 2hrs test.

We tried to enlarge the delay, and tested with 100us, 1ms and 10ms.  The
below is the results.

100us:
The highest error is 4GHz, 22 times out of 3623 samples

1ms:
The highest error is 3.3GHz, 3 times out of 2814 samples

10ms:
No high error anymore

Increase the measurement delay in cppc_cpufreq_get_rate to 10ms to avoid
high measurement errors.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 022e3555407c..c2bf65448d3d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -851,7 +851,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	if (ret)
 		return ret;
 
-	udelay(2); /* 2usec delay between sampling */
+	mdelay(10); /* 10msec delay between sampling */
 
 	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
 	if (ret)
-- 
2.39.2

