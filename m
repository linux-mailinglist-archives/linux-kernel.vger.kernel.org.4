Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DBF702BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbjEOLjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241380AbjEOLhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:37:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AEE1FC6;
        Mon, 15 May 2023 04:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT1agKCUUN0zIA7srugBfsYAP722x+2XD53CBBU6MFwbrb5pV25fcEgXIuqpvvengYZ7OTUzr54bOVIXNDg09X4Jf/SbhrEKOuOYNy3iJfTLUiwSUBLxTlUNZL+jB50vY6dCx6ShiE2nfDifMs/JVq0z0S+MLuVz8TNPmK0a34TOj3Len2vsqvcRepUmlwypt1eGj6JY7euWcN4QlqFRsKnKE3R0ZB7HLHqOzdAuAUPAOjqZTg4+P0hAXh4B7g499NeQ7vHhzJY5i+Rt+y2tPM1smlaQA5UfdYjoh8lsku5KDeDPAiOtHnsS3qn4JixipygxKHT6a1areiaBaBh6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRXhIKRZ/2FXxPqmOfRoyv9iskERzUU5hGr9oe2SNqQ=;
 b=Y39yXPOTu6V3tf9gaIIEwhKQXZRI9+CX7Bu3KMXuNpCPcLmTkjwXYt9VIjUvb9MxY6BiHqpg3Qih8PIm58/bxs9v2gr3ie1PXlbG3frPbsK7/HFq0uW1breKtrEklesIPVpF97wwqq+j+JHrMcBBE5slz3U2luQQQU7uCVjMd+XjA7+8BsRXs7tn8EvnpkWqbzrjHz45jA/ycBCletQYxpEbs87U3JiS1XauxSn3utIwPzbTjTCCMi+vlk7TbYzTDeODfhfTer9+6X3Kn4Ttfc1OawWN0eIaIS4mrHGy9LX5SEhEL6fL5sUUQWKREkHFTx8yX3g3v/95IKK+7oT5VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRXhIKRZ/2FXxPqmOfRoyv9iskERzUU5hGr9oe2SNqQ=;
 b=YWKanpUEyXoJhr+eLcEuDzbYru4thswFUDXA4ieE1c+OdBGIRro1VYWjk6olNawFP357wHj5m9gFwylD0w0jlIf9cfIYN70bV03mray3l0kHfd/przu1mNdV3c0yhcrrSzP08XX/bMOGN6mP+oa/p3GgTw2g6aBpnISrxF5p1S0=
Received: from DM6PR02CA0133.namprd02.prod.outlook.com (2603:10b6:5:1b4::35)
 by SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Mon, 15 May
 2023 11:35:57 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::2b) by DM6PR02CA0133.outlook.office365.com
 (2603:10b6:5:1b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 11:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Mon, 15 May 2023 11:35:57 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 06:35:54 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v3 2/2] cpufreq: Warn if fast_switch is not set
Date:   Mon, 15 May 2023 11:34:04 +0000
Message-ID: <20230515113404.4259-3-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515113404.4259-1-wyes.karny@amd.com>
References: <20230515113404.4259-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|SN7PR12MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 11278f8e-7ab8-4b47-fa31-08db55388cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hj8TMh6p7SkNGR+PDlFBS/ILqreUlau0lcZhtgaW4TSg3UK4IWNxl0lNaJacBbtE7W6GMBv7N003gYsW8YhUV9Yv3gyrqMVczq91ra+BoBjAj+xn84eUz/qdfFXpx07Vl5oLjHRYIfv7Q1W7lmV/8KBoCQUvBTF7m88qig6kjNF7pQJlK3S5RJ2Yu82XfVUoqnHE2NWExiTHR8EI9eOYfpc9ORHF5mzSYdA6OCZYf17WLSIPF3YYCAgE9bdpBVUDW47KK/YxkoptWijshGdLx3Kw3077F2X8GSRNAIyhfCfQTFZ8spvG/AQWGYc9E76XBCMDFHPBu4S7H8eYRtueWdRDp3lzAr53oobJ9udZn6Thu0VJ13WtuTPi/ZI+vd69POylM2I+Q5zzNLHTVa/BidYkY+xR58FUdDnHbCaAzoAEZWEqOMaXnEpCpyFtSYypfrHcHqBT9WLmC167OgT49N17LOcZgt42yPSU7uPkptTuRHOa26zXwk8Q30iQl/Hc5RgRIrXY0KJXaLZfGpBxC5ZPtAZ3bRqCXXvuWrr2MNdAYv4ewKkxS2lFfSXhsswAHLqpZ6rcWO170xM/sdZOGpUco1TAJn4RQPmcSvu38oGI2tVcnCR8Vyl4Drev40R0BgE2MXULua5hKgeF+GcLg+jZ+1fgZ2GHhrqedibdYzGdH9DT06nHnf6Fb/yOD09HZpX3XtIyArHix8X0BepeuDtaMivdw4KcTUiKoIR/N/CS3Czj9qxJVk26ziAwpJ5js+pBePY8ZLHRtpeH5EtstPscIql//hDwDyxmPS8njKFkHTGHAqhoSk7G2hJMuXhN
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(70206006)(36860700001)(426003)(4326008)(40460700003)(110136005)(47076005)(336012)(7696005)(2616005)(2906002)(83380400001)(6666004)(70586007)(316002)(478600001)(8676002)(5660300002)(8936002)(186003)(44832011)(16526019)(26005)(41300700001)(1076003)(40480700001)(54906003)(82310400005)(86362001)(82740400003)(356005)(36756003)(81166007)(36900700001)(2101003)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 11:35:57.4325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11278f8e-7ab8-4b47-fa31-08db55388cfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6909
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If fast_switch_possible flag is set by the scaling driver, the governor
is free to select fast_switch function even if adjust_perf is set. When
the frequency invariance is disabled due to some reason governor
fallbacks to fast_switch if fast_switch_possible is set. This could
crash the kernel if the driver didn't set the fast_switch function
pointer.

This issue becomes apparent when aperf/mperf overflow occurs with
amd_pstate (passive) + schedutil.  When this happens, kernel disables
frequency invariance calculation which causes schedutil to fallback to
sugov_update_single_freq which currently relies on the fast_switch
callback.

Normal flow:
  sugov_update_single_perf
    cpufreq_driver_adjust_perf
      cpufreq_driver->adjust_perf

Error case flow:
  sugov_update_single_perf
    sugov_update_single_freq  <-- This is chosen because the freq invariant is disabled due to aperf/mperf overflow
      cpufreq_driver_fast_switch
         cpufreq_driver->fast_switch <-- Here NULL pointer dereference is happening, because fast_switch is not set

Put up a warning message if the driver sets fast_switch_possible flag
but not fast_switch.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/cpufreq.c | 18 ++++++++++++++++++
 include/linux/cpufreq.h   |  5 ++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6b52ebe5a890..180be9235b08 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -501,6 +501,13 @@ void cpufreq_enable_fast_switch(struct cpufreq_policy *policy)
 	if (!policy->fast_switch_possible)
 		return;
 
+	/**
+	 * It's not expected driver's fast_switch callback is not set
+	 * even fast_switch_possible is true.
+	 */
+	if (!cpufreq_driver_has_fast_switch())
+		pr_alert_once("fast_switch callback is not set\n");
+
 	mutex_lock(&cpufreq_fast_switch_lock);
 	if (cpufreq_fast_switch_count >= 0) {
 		cpufreq_fast_switch_count++;
@@ -2143,6 +2150,17 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
 
+/**
+ * cpufreq_driver_has_fast_switch - Check "fast switch" callback.
+ *
+ * Return 'true' if the ->fast_switch callback is present for the
+ * current driver or 'false' otherwise.
+ */
+bool cpufreq_driver_has_fast_switch(void)
+{
+	return !!cpufreq_driver->fast_switch;
+}
+
 /**
  * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
  * @cpu: Target CPU.
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 26e2eb399484..4277d6f8e50c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -340,7 +340,9 @@ struct cpufreq_driver {
 	/*
 	 * ->fast_switch() replacement for drivers that use an internal
 	 * representation of performance levels and can pass hints other than
-	 * the target performance level to the hardware.
+	 * the target performance level to the hardware. If driver is setting this,
+	 * then it needs to set fast_switch also. Because in certain scenario scale
+	 * invariance could be disabled and governor can switch back to fast_switch.
 	 */
 	void		(*adjust_perf)(unsigned int cpu,
 				       unsigned long min_perf,
@@ -604,6 +606,7 @@ struct cpufreq_governor {
 /* Pass a target to the cpufreq driver */
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq);
+bool cpufreq_driver_has_fast_switch(void);
 void cpufreq_driver_adjust_perf(unsigned int cpu,
 				unsigned long min_perf,
 				unsigned long target_perf,
-- 
2.34.1

