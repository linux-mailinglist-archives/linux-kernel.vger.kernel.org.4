Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6616F61FC8F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiKGSCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiKGSCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:02:09 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9861ADB5;
        Mon,  7 Nov 2022 09:58:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af/kOH/8AnHSOcfF+fmGv5TO6i4YN6uTwAc+KCDOuk3ONtONXNgX6CxMXFV+yAY58vkcYl7jfuDUtIDaNIxXc2xxWM78AHTH7A8Hf7+Ht2w0xySUp8tjO/g/RDlRetknOfFdRQpcG0g6ld3JGxbo8uVL1g0N+pUqEsdpFHeShP3PZlnyFhkamDbw6Xao8seGHVgLk3yD9Y2UbdsZopDVRGPrQ/a3nBso7BALqd6Hi2m38DrcTHS1AetO0oBambfogbrDUdz9U8evo82FJLjQCHMxo/4319Z3dDXvcuQHAcdQAao4AWd0uy4pSwJvw/YU2ig0enfzk/v7kekkdPwEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OJEqzlRI0OFP86PgETJLu29/NT8+dk0EQ1IXp0RhQ8=;
 b=So/bkKgBNF+iML2qa1g28c0EXXoJI0cn0fNuc+JxbmsA59yi5N6SuL6QnOW51XrXUPQ1kPuTm93+9fhmein8Ks9xDGNxi6+WKEVtQNwdJnzXWeyfMNpHminwivP6z0o5g6CmjuR72btJxvIoPAirn8lWpepgUx31NSAybMaZuucrQR0HeUkdrzDz6DbUteivnR9Pj4dITUcumT2mQXbII9SVto/9OoN972gIakKNRqEFoNgodqPkwvhMaXPW4pxaK9S6OXitSI72/Gi4vZnBvtPQN7hIv5wwocy+uSswMoeNCuTxXxdrn+oI8ZGfBOaeYhzsA92KNHnkLvVNr8zRug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OJEqzlRI0OFP86PgETJLu29/NT8+dk0EQ1IXp0RhQ8=;
 b=vmjExCuA5XxFMiYN+b3/S6PkuS4Ov6IyhuHgGkO7o65NKZkT+1yf/aDMyJ6tZ34Akr1H/CzeTXZ+GcboTzcuOj7QSlSpZXM32S0+8emfMDnpuruOFk5BEdxjhV8qUNR41xbhnHHdUctE5YZnSVrOX+DU1tly9mj4XYMXz7DJXpg=
Received: from DS7PR03CA0159.namprd03.prod.outlook.com (2603:10b6:5:3b2::14)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 17:58:34 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::27) by DS7PR03CA0159.outlook.office365.com
 (2603:10b6:5:3b2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 17:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 17:58:34 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 11:58:02 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 3/8] cpufreq: amd-pstate: change driver to be built-in type
Date:   Tue, 8 Nov 2022 01:57:00 +0800
Message-ID: <20221107175705.2207842-4-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107175705.2207842-1-Perry.Yuan@amd.com>
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: bf36bd7a-e805-465a-71a3-08dac0e9b027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQGZVuG3DJ3i+uj7XNqGd0MV4bz61tK9+Y8U1rNslxRJVX+A9JMIOPm73F5GjIYixz0WaC1Da+1NspZAafm4XLa3X/pRoC7RGpT2Rusxrmlp6XjcYkhQa6ueAkzGgynYVuduXicAbiy0TbSIH275cFspB6afEaQeStxzNu49Mw3bte+eLMPAPh3bhhJ9HN1YrsGa77AfDV/YU+iXYF5MwppYK7BdCHQ5uHGgNCzgpVuXpUvzMr0P5Y8AdRAw9HPQswxW+Ce76k4ENai5M+hntD7eEHDl7qF9DgwySH+cAiBrFWp8Wau6N3Uvzb3Fz+eH2NqacuJp/4swlg3huuSdgngPD5dfshbWyQyM1///PFO68xOvFQpjvJ1p5k+CKFF9fhDbQyDLzt7P5yezx3JaISJpYswipJGyr2eNzauYuhrkpxfmSFZ/xI+MgOrLoZ90aavwZM13QjyxW3rJAPlWoI/+mAiHToagOEcM5sidx7n6dg/3NtD2WjkPc51V0f2LrvlJWRcy5sM0ONV32cKa1MYVb27QiJ9F0eJU28QupsCJX6fwQ+f7tQ+2q5aZmmYtTXRdxAVbX7zXEfE5mbmzQM++/YdOn0+sBtY3aE752iaejnKT5oLEfF99MkDAFW9ZLSnEj5bmCfST8phkCYmR6IUYmdgIQNyFiJKtetrIolTE3u//ZlbEZBC4rJQY7HrYMIrMUhEv/FX7NGHaHt7ybxpswKq/3/s7ICTG+Zl8tKoPVSLncLB9/SctgvT+k2yOZqS4CEr+GLQPgRDl1IgiyUUMjM4MjlkauqTZVkLx5B25qUs3r/3Nfv9ueQoJsqvl1WWlmQDnLpbU2M70DNaabA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(86362001)(81166007)(40480700001)(82310400005)(7696005)(110136005)(316002)(356005)(54906003)(4326008)(47076005)(40460700003)(8676002)(2906002)(83380400001)(336012)(26005)(82740400003)(36756003)(70586007)(70206006)(5660300002)(426003)(41300700001)(36860700001)(2616005)(186003)(8936002)(1076003)(16526019)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:58:34.0853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf36bd7a-e805-465a-71a3-08dac0e9b027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the `amd-pstate` driver as the built-in type which can help to
load the driver before the acpi_cpufreq driver as the default pstate
driver for the AMD processors.

for the processors do not have the dedicated MSR functions, add
`amd-pstate=legacy_cppc` to grub which enable shared memmory interface
to communicate with cppc_acpi module to control pstate hints.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ace7d50cf2ac..14906431dc15 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -59,10 +59,7 @@
  * we disable it by default to go acpi-cpufreq on these processors and add a
  * module parameter to be able to enable it manually for debugging.
  */
-static bool shared_mem = false;
-module_param(shared_mem, bool, 0444);
-MODULE_PARM_DESC(shared_mem,
-		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
+static bool shared_mem __read_mostly;
 
 static struct cpufreq_driver amd_pstate_driver;
 
@@ -653,16 +650,22 @@ static int __init amd_pstate_init(void)
 
 	return ret;
 }
+device_initcall(amd_pstate_init);
 
-static void __exit amd_pstate_exit(void)
+static int __init amd_pstate_param(char *str)
 {
-	cpufreq_unregister_driver(&amd_pstate_driver);
+	if (!str)
+		return -EINVAL;
 
-	amd_pstate_enable(false);
-}
+	/* enable shared memory type CPPC ,if you processor has no MSR, you have to add this
+	 * to your grub to make cppc driver loaded successfully.
+	 */
+	if (!strcmp(str, "legacy_cppc"))
+		shared_mem = true;
 
-module_init(amd_pstate_init);
-module_exit(amd_pstate_exit);
+	return 0;
+}
+early_param("amd-pstate", amd_pstate_param);
 
 MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
 MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
-- 
2.34.1

