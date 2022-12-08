Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EDD646E58
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLHLVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiLHLUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:20:36 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C15663D60;
        Thu,  8 Dec 2022 03:20:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emr0XqOJyTsVY/feWPVzHiubHGCehweHtBPLdI1uDI0oXbbNgEhn5pAJhxx/OjZtJetNdOzZuvRx4AJgLJXfTeVjZ/Mf/f7p9IOah0u/OGR1pPa+eJEOObYx7QvpgtqSy6+6ITEs86qrOEbBK4mRj8nNKGr3wJqJIScLazydIIXhK2goNazrmc7squFGCRUD/sRMF4GGOxqhaiph0imbOFUSJ8TdffITTMxV6bLgYJ2b0ZH+h9j83FS8NwhNUasPeKLwF6xOboZcTX8RnidYyloPHM7clW+FuWWQjydydDYeMgEk/4R7kUnvtGyJtewRDu6TArwzvnFliNQ0St/hIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7HUaZF2RWtW75YfO1ls7LGL9pKvYziwGx2Mp2RHCeg=;
 b=Qhc+gKR6hOAvg9RQ9sKn8LX2uFFh3Wrihcqac1+qpeAkiC0WgiKSCiImATcwuk5l2j0dYyqLWmK7LAgSEVpgNeUB2UanEDl3vkGK8Boa9eCwVrgu0ui3DOYvppsQQ1/c+0SzHNRyKZ0DEUElxT6+ilPvT1lLpyxdBI8COB1e4k3+380HRE/MIxXo/7rxmZY8Q8BCsOWbmt4l1ZXN2bl0MVm5bpjlMUmhdNuZYY4f8hB7d/S5S6JG6a0FtcKBU2nzmIsvZOLLLf0b2gYq9Bb72pIoZg2CvgKazRiC6fPycTjjzhcla5EBDLQ9V5vY0QAL9DgwztIKDvrvqHwBxoX3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7HUaZF2RWtW75YfO1ls7LGL9pKvYziwGx2Mp2RHCeg=;
 b=Sd1yfJHViNCIALnkioh0ya/e3jVPkBllv99rcTPS+pghZdrn28/s+c8os8I7/ejMMq+lcnJXrfNVDXmchvChGE5NqgOza8qyF+KurZX5QuZAz7Kof9hoKH9Zh4cw11aDkoWeucgEvvFIGJrv4oJKa5ECW6ipXg95JdGucThpYGs=
Received: from DS7PR03CA0167.namprd03.prod.outlook.com (2603:10b6:5:3b2::22)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 11:20:32 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::78) by DS7PR03CA0167.outlook.office365.com
 (2603:10b6:5:3b2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 11:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 11:20:32 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 05:20:01 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 11/13] Documentation: introduce amd pstate active mode kernel command line options
Date:   Thu, 8 Dec 2022 19:18:50 +0800
Message-ID: <20221208111852.386731-12-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208111852.386731-1-perry.yuan@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed8645f-9d4b-418c-e5f9-08dad90e3873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GfFAsZenlzeSVcYcqsQXJ5oFur8adDvyBAZ1UGnJlUpnPIsaFKdz49jUytsJe/8gW6t/ONASb324AWpC5wvxnWhANbV69XN+8i9seEEhFS/ugz23Bw++pRTXAASZExtjmjrl1jvDgeNA0K0n9+BFoVmcXj8Ry8s1p9kUqrJzShsmxoF1FGeewKt3T1+K+qxEBf+Tvq4qvPSy3SXKJYEfJ9Ep5XZwn5NvhrK5HT8KCntB+YrnOH7aGXKthRwGRWQcKFM4JOFtjOvq5x1x5ftlnmazNZ/rrEGZwNxjTspkwamyGjX1Y7DVlrsZxrneys9RBQcX9Y8+pBmNzDv2SynEMhc/X62sWmwilYarg4WbYErcPd2GSndIqW1bhg5gUrTz8F1nl7Hv8e1pp4y+ZSyFozLvnEIDTA80tY4QwkNOm60fv1oO4f4pWPFRJTgJEdmZIJLMa0aiVJMDPNOX6Hgnu/zuEDh8FU2/WftCvg4yWkfzr7Ho2x2qeaGuoRfMopNJrF1okyvTCGfq/a4KNgpVnmnWlIPQAJVRGs09Qj9jQCR+Ueb+3EpDlpfAViwPttqKZdw6NL8nFFcjToxMP0KM569CsqfG8g6jwWS8ef2nzW0kVeupbfTzkbPvtBGP4o0HttfR6J8YuxixuL4mwiP6oKgj0p269kssPVXBYcQTDNjFgub+zxP/BCN5gP7/h2YnXgot7t12ttmlulDVQkniW/0JrUgiYU/0e/pWb8NQeA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(86362001)(41300700001)(82310400005)(2906002)(44832011)(83380400001)(5660300002)(8936002)(70586007)(70206006)(8676002)(110136005)(54906003)(316002)(4326008)(16526019)(426003)(40480700001)(356005)(81166007)(336012)(1076003)(47076005)(40460700003)(2616005)(82740400003)(478600001)(26005)(36756003)(7696005)(186003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 11:20:32.5298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed8645f-9d4b-418c-e5f9-08dad90e3873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Pstate driver support another firmware based autonomous mode
with "amd_pstate=active" added to the kernel command line.
In autonomous mode SMU firmware decides frequencies at 1 ms timescale
based on workload utilization, usage in other IPs, infrastructure
limits such as power, thermals and so on.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42af9ca0127e..73a02816f6f8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6970,3 +6970,10 @@
 			  management firmware translates the requests into actual
 			  hardware states (core frequency, data fabric and memory
 			  clocks etc.)
+			active
+			  Use amd_pstate_epp driver instance as the scaling driver,
+			  driver provides a hint to the hardware if software wants
+			  to bias toward performance (0x0) or energy efficiency (0xff)
+			  to the CPPC firmware. then CPPC power algorithm will
+			  calculate the runtime workload and adjust the realtime cores
+			  frequency.
-- 
2.34.1

