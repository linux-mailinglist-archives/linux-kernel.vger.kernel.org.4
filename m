Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1575C714C08
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjE2O0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjE2O0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:26:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC665AD;
        Mon, 29 May 2023 07:26:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFoU29IcmoEHeWmiHYbwhbwROk8X3nci+0xA4jab2D7C8ggJTgMlQJuKzBwTB0FLaZvZb4rbiq/Oy4aVbPeGVyPM8XWra+YlQ2/WI8EDFHwo7ylnLT2pPbwzMHrxmrCxBAgwJ56wGw8sbQJAt+IFtOHCnSMq2fx2Hmhd2za5rPU2f4BVjQJ7O9SQ6gbkqsq8jqBJogMt2CUGRNzPFuTLLwFtbPcHwcbKry/daUPmu3w31KqlS2LJUASCCLSJPOFnSoL2X5qqN+U/lFTRxnAARm/OQ8m4LYw4cW+JFysunLsgZ+L7wU5bBhnTdo+qsT91eMpX1oOgPgoTbpQpGzuvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt+sGacx9pFQSAiTq+amlfY0UnB7lAqOtAew9J7J20U=;
 b=RDoPzEHLsRtz5E7hpSQFhwhLID/s8aPuI/ZvgUI7dUkaQ/9Ga6fI5t6wz0diWccfa7CWMfqgrThw3G1rjrs8nOI09DwW81n1ukX1EfDL9DTCxvRrKmf5POcxL82JbzC3IOM78nEYs8eRmxlaAuhEY3doss/t/rJk1pFAlOZLwqF8quV7vn7BYdxCa+V+/ONqEG082hl1rvqRKuGpgA6iXWl5N7Pv5HI6YqJDz90WRLtqEVOVo8QoNx0/KoQHKPBM6URK0ohFzZG33XXAsN6tA884ggz2i/Kj0ghfohiDa8L2RH/MIxyFPIWM3nOFrdDfH/1EFrQoW1cDG344pjQgJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt+sGacx9pFQSAiTq+amlfY0UnB7lAqOtAew9J7J20U=;
 b=SZlejedGuCRqEdEIR5Zk9tG4CnqAZHaoKKGotbqoyIIpsoa3dD/wp7rFCzWd2fQuNRsW4EGi8vQfMokGrXAi2x+5pv4dqyknh7MApF9+U4q8lBI7dm5vNgBxKYKmrMaK2zcImcrR+YcBt13L8I2I2ytyc2xftfFsnMWr9rYRYtU=
Received: from BYAPR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:c0::14)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Mon, 29 May
 2023 14:26:19 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:c0:cafe::bd) by BYAPR05CA0001.outlook.office365.com
 (2603:10b6:a03:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.20 via Frontend
 Transport; Mon, 29 May 2023 14:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.20 via Frontend Transport; Mon, 29 May 2023 14:26:19 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 29 May
 2023 09:26:13 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <ray.huang@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v4.1] cpufreq: Fail driver register if it has adjust_perf without fast_switch
Date:   Mon, 29 May 2023 14:25:51 +0000
Message-ID: <20230529142551.6726-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZHSx61V6fgMcXsvh@BLR-5CG13462PL.amd.com>
References: <ZHSx61V6fgMcXsvh@BLR-5CG13462PL.amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 6921794f-4bcc-4fb9-b4a9-08db6050ab81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUrDgO4BdfoslLIMt/xKT2jiF4H/W3XVIsUozKdIw+8COY8DneIRxEIZH0Q/7dCQ+8wMT5tAx7Wbi45qyFZ47v9oILwZIwCxSUoJluofILmNxyk0d8j/J6zeqpcCJYGGwH3gW3q1s/rOmXRKBi03MLTcxain7fA/zKQT3zE9ybVyNTxMXqqRlCljfyVabLgSKLINuGcJ7OKPRQdpaOwyyrxxDidsxakJl4QiKRB+FGF4HqMnlQC5tUqrCw2Xa+tzEsy1I9OPeFMPcgcvAPL0Hlx/1cUR5+U4dfmL8nAHfaUnWlryZhYEwT4Af6sQumGTUIMWgagMWbHOfVG1iudghRvrdgyHDxL+aiMOFX+zA3PaFYv/6EPsMEuBE1/AUAX+sEnpEEOKFAq3Ie+9JtmpTsrnZzcsm6KEuubwxX9B9BwhZje7gqqzgXRhPogpnSg8dSAjljaVEZu4a1gWlQOVPnuuIk06Tj+5negogS+onNkOPQDPisMFRHr6yFwPG97baqBxi85J6/H7etTwlRGjLH9KpIMZUp0rphdYI242FbiCo3QxoBGhpHctPvmYiPv3iAE3SWtyrdxHDeAvupWKFlaMKOo3rxstSfT1i1XdzjWXBY3Mju6Psb0FgG/GrRCzu1xouWLAA64whqobhVnqYrkEJ0zhv9pgy8dbdQJ7jT6xucl1IcUUivtltFuqTlXxbhRh5SrSj7cEdFJhOatnTyiF3IT+ZwvbdUwhg/hs31q9aXT5IBtVD/emULd1dRRgEmAmGFIyg90/I0Z2SbnYRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(70206006)(70586007)(4326008)(110136005)(54906003)(356005)(82740400003)(478600001)(6666004)(316002)(41300700001)(7696005)(40460700003)(86362001)(16526019)(186003)(40480700001)(81166007)(8676002)(8936002)(1076003)(2906002)(44832011)(47076005)(82310400005)(426003)(2616005)(36860700001)(336012)(83380400001)(26005)(36756003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 14:26:19.3174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6921794f-4bcc-4fb9-b4a9-08db6050ab81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845
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
is free to select fast_switch function even if adjust_perf is set.  Some
scaling drivers which use adjust_perf don't set fast_switch thinking
that the governor would never fall back to fast_switch. But the governor
can fall back to fast_switch even in runtime if frequency invariance is
disabled due to some reason. This could crash the kernel if the driver
didn't set the fast_switch function pointer.

Therefore, fail driver registration if it has adjust_perf without
fast_switch.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/cpufreq.c | 3 ++-
 include/linux/cpufreq.h   | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6b52ebe5a890..50bbc969ffe5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2828,7 +2828,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	     (driver_data->setpolicy && (driver_data->target_index ||
 		    driver_data->target)) ||
 	     (!driver_data->get_intermediate != !driver_data->target_intermediate) ||
-	     (!driver_data->online != !driver_data->offline))
+	     (!driver_data->online != !driver_data->offline) ||
+		 (driver_data->adjust_perf && !driver_data->fast_switch))
 		return -EINVAL;
 
 	pr_debug("trying to register driver %s\n", driver_data->name);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 26e2eb399484..172ff51c1b2a 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -340,7 +340,10 @@ struct cpufreq_driver {
 	/*
 	 * ->fast_switch() replacement for drivers that use an internal
 	 * representation of performance levels and can pass hints other than
-	 * the target performance level to the hardware.
+	 * the target performance level to the hardware. This can only be set
+	 * if ->fast_switch is set too, because in those cases (under specific
+	 * conditions) scale invariance can be disabled, which causes the
+	 * schedutil governor to fall back to the latter.
 	 */
 	void		(*adjust_perf)(unsigned int cpu,
 				       unsigned long min_perf,
-- 
2.34.1

