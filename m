Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0386706E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjEQQas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEQQam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:30:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EA05FDF;
        Wed, 17 May 2023 09:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQJXa52zHOG95jNSqBBK2qrvaeajeSW6T26hSkGdpTZatxOwuMvM+qXL/evKfjPLkbVJdKhni+Gihlm5YoiB6fI5LN1AlrTzs3y3gUjgWtj7K9kr5Lh+2d6JxpZWoIRoLb9sujwAg0px2zak+7BbJvKkqG5m9NLuqx08SUCt4J1xlIB/MY+1q8qfO0SbmEeUhqW/rEhAv41NQjmT2ljzSNWglfBkcf4R0W3uVz+8xTXtpoFnDWZBq2T8hYpI2mymncHfOw00xaw4+VNuM3b3iUglk5xXOrLRB0O49IPUawfZc+yZJ0CnlcdaqJ7/YM0SdWsZKWWFPcLE7TlSejWGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKsX6FtXJrK9YU1t6JxfuHJ1PC4JDhdf2NNtKaFKVSM=;
 b=OfVwwmXUfpsYBCmH6ufk8okpHNZZ4GApB7GkWUuNvbw9MdS5GnI275tif/MgzyfcP30VMs06Dwn3NnsNloJsxhceSD/g3XzbHa3+Ut/09pq4FLxcS8JYvexHE4jOj8dHsi8rUHQkGaU2Pzhpz90cVQ7A6Ngd0Vvol0rbGaFwHlhKEa/yLqCRrBzjIa4SWZ+q77/PKn/3odNia0zLEnOB55j1wYOKeemwLDwhaC8DdJvNcOB0uJym4nRShxykgmOZVqFaXmHijLiKKclTf6hQjqSESLAKWP/AKh1YqNsRZawaZffIwpIAKVKr4x6FuDVyref17Wa8CtJH/YlN8SageQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKsX6FtXJrK9YU1t6JxfuHJ1PC4JDhdf2NNtKaFKVSM=;
 b=2SGNpkzCq9vI1C8lLUnxNLRFz7wsBlz8krtaQG3CkLVmtb9ElawOJ1e39abbsi+tQI3YF+UFn0B/Gxd8uZcQJb/anCEGQyvCWjagOyvst7IYXaJM6Td1nffc8BQxAeOnjn3Z1r17cUxSUDgKrpEcVVVBQkp8+qYSvIBsh9U1fQs=
Received: from BN9PR03CA0164.namprd03.prod.outlook.com (2603:10b6:408:f4::19)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:30:35 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::1) by BN9PR03CA0164.outlook.office365.com
 (2603:10b6:408:f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 16:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 16:30:35 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 11:30:32 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v4 3/3] cpufreq: Return failure if fast_switch is not set and fast_switch_possible is set
Date:   Wed, 17 May 2023 16:28:17 +0000
Message-ID: <20230517162817.8538-4-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517162817.8538-1-wyes.karny@amd.com>
References: <20230517162817.8538-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ababee1-a5d9-463b-6690-08db56f40acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuMcOYEKfio8OydOUHWzEGNgvH8RcK7HSLIqvF+lzEYUYAGqZyO3FY5QXihCeVgpO8xgCSeXHXThV480UyApbZx/+gra/RUvksfvlrZeu+Ht9DSs1KXe6gpGApDmJq+H1raubzm1v/wHojVKT6pzZO8i25tQkxmAbq+f+y63EjyMFprazf+54Z/GBO5bGrQDdEKVVPJxl2FBDrlAW1ZUB0vb/eQRsGMk8m8yQ9LbT+kR/RgL0wS8+3+RMp7YdsuSLPNRi63b/3aRq/perzyjY5A1KnAIO7t29WFanVmMjEClHok4nlt4Q8zSYplMFZfirEUC5P2h8kjlrCSyyFrlG9bv/OfRFFo3OQ3X8IfLHfM2Kz8JNWXqQmp2pUnJ08BWZ/W8E0cmsxEr4bRKK0UTWnjvesFFKRHj3xxZVf8NyytZPCtzdGa9Z99R+szvy7E6mdwYw3CXBiXezJ+zBCXtFo2ifErKZSiKtYDUy/WQpzIQeJ91WMtd2MsIoktcySlMEYPDp7+Xl0E7vMU9v4JKGKhjGacL1+rR1Vn3A+BXZrGAgXeLhoN1AX7rlun+m+aTHKgSQDpB5s1dtFiECyXxnIErG/xcwwKT0P7NSaRMeZG0cdP2bmFGLoOiUnKKe6bo2W1tP66dEeyxvN0Ka3rXHEnVfrsU+ySgDqV9hDmdPG33a0Pqf9LUirvkoEHRDgMOFps3dFU6TqUBv2avhKND5L3HrEMxObNOSNCghEkVbe4PBaFKBcanShMYrCCn+gH3Qafxw6GWEyxqYLyWD1BiVqMoN0nYRnjc8ALtOj8Gze0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(26005)(40460700003)(1076003)(7696005)(36860700001)(36756003)(47076005)(40480700001)(83380400001)(426003)(336012)(2616005)(356005)(86362001)(82310400005)(82740400003)(186003)(16526019)(81166007)(2906002)(8936002)(478600001)(4326008)(316002)(44832011)(110136005)(54906003)(5660300002)(8676002)(70586007)(70206006)(6666004)(41300700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:30:35.5961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ababee1-a5d9-463b-6690-08db56f40acf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

Therefore, return failure in cpufreq_online function if fast_switch is
not set and fast_switch_possible is set.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/cpufreq.c | 5 +++++
 include/linux/cpufreq.h   | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6b52ebe5a890..7835ba4fa34c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1376,6 +1376,11 @@ static int cpufreq_online(unsigned int cpu)
 			goto out_free_policy;
 		}
 
+		if (policy->fast_switch_possible && !cpufreq_driver->fast_switch) {
+			pr_err("fast_switch_possible is enabled but fast_switch callback is not set\n");
+			ret = -EINVAL;
+			goto out_destroy_policy;
+		}
 		/*
 		 * The initialization has succeeded and the policy is online.
 		 * If there is a problem with its frequency table, take it
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 26e2eb399484..8cdf77bb3bc1 100644
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
-- 
2.34.1

