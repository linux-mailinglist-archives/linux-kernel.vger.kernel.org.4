Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D0A72B5A3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjFLDEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjFLDER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:04:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF10E6D;
        Sun, 11 Jun 2023 20:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbRSl/1esxCmAWzoa0HruxM6hsL4XfWERLnNKKXD6jMbzRs7rhTa+YjBUgaXUegnvl2IEXUDwX22vTnH09NfVWnnw+g6J6sGvQiNcirhJHUZLirMElDPTdjH6F5AMtD1JGi3tibQTe1BT1FYZxFZPdOyLTmETH1lknqJ5BqnzyE51d32gjrpSpta5TU7Ng7KKGOFhX3faCckt0ElNpbIICuZYDi3m0t1R+4Miy3UpvkXHFWENzjXz2lNZ4w2yimgHc5XwFXh5saoLRgKI0znDGd6LfyD4Qs4fcP7D9P/1DhZ1QmArGZm+CxgNU79vFO6GUNRYVqQADAkmSgSUq36/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoJNc7OGaEcJoJ78c/kXk7BWZcWtLCfsDyvP5r7Ioyg=;
 b=BQeCYnUgqwT/K8UuveszFLPYlItD5DNN+ef4xTuI/sdESBGx1KIyaHRBGqPXo63aQeSF8JPCuk5Zkerw3NzB6xVtMuLfp3THr1hcep3iT/h+s6u0lfppErpCmrzZ4evHmIU+05N2HhPjpSyFYGk7McJi0j0y/yZhEJ7RV8ixYsfsdgcVMElVNQGkcli/yuYAhdcNlWbj9Nn152IPXO4f6F2odb79OQGr/iqfIdr863hgKargOxlQUJIBGtlwNHn8mga69Bt4AvCEEST36m4hNc16OucYJkbro5jj1y7rwr89FkIIOc8iPivdW595IAACZf8XtIRkLMgPhWrl9UK1jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoJNc7OGaEcJoJ78c/kXk7BWZcWtLCfsDyvP5r7Ioyg=;
 b=uozANHeFhquwHmNZ90XVssPFLGb4BoTGlqKlfNFssiN8inPd1wf5pC0/rwJM7diUf0qG00nw6rqlrA8y1HfxJWmgkLP7Tf9WCCbw5VuvYbT6E50YrK/v2W+bkefie9QQ4NJ6Rhm0rkxDwlEPPlQLv72sg+EH9yNElJX5PP0IZ64=
Received: from DM6PR07CA0095.namprd07.prod.outlook.com (2603:10b6:5:337::28)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 03:03:33 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::ca) by DM6PR07CA0095.outlook.office365.com
 (2603:10b6:5:337::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Mon, 12 Jun 2023 03:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.21 via Frontend Transport; Mon, 12 Jun 2023 03:03:32 +0000
Received: from pyuan-Splinter.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 11 Jun
 2023 22:03:29 -0500
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, <Mario.Limonciello@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Wyes.Karny@amd.com>,
        <gautham.shenoy@amd.com>, <Sunpeng.Li@amd.com>,
        <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] cpufreq: amd-pstate: Set default governor to schedutil
Date:   Sun, 11 Jun 2023 23:03:21 -0400
Message-ID: <20230612030321.3097627-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c7c8ac-bcd8-43bf-ca03-08db6af19b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lf5rQ78Bz3eYlRiqtjpvkitEvMGY6hzsSmt/hLtg8t/BwUdeboSQz1KdPrPGmRxd2Hs2yYby0FWPE5BnrE0q+1IEVhNTJqVl302W+Tkvh6OS40VJv8ICRy3T/yO1S13hJxioOHyvFF3M49nrO0TFtY2hwqhzwEBgKXxnK2dscTj9DE5QpeGIDqXoV//1kwbejAy7O61DMWVEE0zYmuPSHMk6yfZ6C4cmC2w456xny6HRsHI35CJCZA4CC1VbVPfUGBaT3wbFvo/p2ViHirKYhWAsru/3C1xfNx+ShB6P6a1aQLzUMeiXIL46Q8tG6Nb5EJgA5B0/KIsX3Ys448J7tg89ZxgRDpd+A15NSTQmr+eoCzfRBng12s97SAme47ngZN0M/w8mG01neKZe4+dNAF1kehpp9ZpGz3s1/vaD1P6PX3OGvkk2dMOpsiU4ebJ86DSlalUMnRotUYs0BOc5TQ6EJraYW97L4dsfrL4cHfx2x8UhD/MNHQXmaqq0drhw64xzb55zWAytx4ZNbg8ko9KAoFnJ02mFWcjTrDrd7wbgJVMuddBpCfINyl/q/axUZvZwms6JIdwf/YgMRCwYooYNXU+N6K/09n8L4fXV5kN1crJFp9wDWC+6fYFYOyLd8VtcQv/T04b1QeqmkPyGHkj2khTlpsHqo9eZEPJOzK0WHbXuwzG4YqfV0XgyjbKW/s/E653NKwoQfhz0tWfR+rBT0WM/4wRaaJgVAzV2jJ0cPfgUtrdsc6vwX1JfE7mCtsGad2UGR9sF2bszw0A6Ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(136003)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(7696005)(316002)(40460700003)(41300700001)(83380400001)(426003)(336012)(2616005)(86362001)(82310400005)(16526019)(186003)(1076003)(26005)(44832011)(36860700001)(47076005)(2906002)(81166007)(82740400003)(356005)(40480700001)(36756003)(5660300002)(8936002)(8676002)(4326008)(70206006)(70586007)(6636002)(478600001)(110136005)(54906003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 03:03:32.8241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c7c8ac-bcd8-43bf-ca03-08db6af19b5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

The Kconfig currently defaults the governor to schedutil on x86_64
only when intel-pstate and SMP have been selected.

If the kernel is built only with amd-pstate, the default governor
should also be schedutil.

Cc: Sun Peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Tested-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 2c839bd2b051..a1c51abddbc5 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -38,7 +38,7 @@ choice
 	prompt "Default CPUFreq governor"
 	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1110_CPUFREQ
 	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
-	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
+	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if (X86_INTEL_PSTATE || X86_AMD_PSTATE) && SMP
 	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
 	help
 	  This option sets which CPUFreq governor shall be loaded at
-- 
2.34.1

