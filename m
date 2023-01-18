Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDB3671633
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjARI1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjARI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:26:04 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1985AB66;
        Tue, 17 Jan 2023 23:52:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2Owtn8JioG1hbivnxfce4XmgGmayDMHbk7BU+iD9a2c6/ANaBinCdRDlkWxpPiYLB6aBsOu1EQI2GLOsimHU6CiSYMm+ZtPEho1Ti9L09UpW23hrVIos6x//wnxaMImBOT0a0QyA60G0/zwlMTYrmMJhXjWIzuzRzLIJc//v0V7ol/K8Pf3ASn0EJ42RoDp2UiNQd2H4juHAatsdI0Ecvy81ftYqX3Cl+vIR3zqKaAkOARDlbkvwBR7nmaWM7G9zM6zPJtO/WVhU5EVdPzTDrK0dkf+aHEQ7GRsXFQ4OroQSP374360jSSiBluJxg7eX/YJJ4nagzQrr3JOMkAMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jr7Q03mitAi0UxfYb0SVlJs7m7zbY4Hr7jcyAHdI43E=;
 b=mE+YzDhT4VV+2RCkZdeX0uf4WRvAYS1aXOKl/BeLiBKFBzAiDGfQQ0MWPA8ahuFkXU2OF/9bJKuBDHIh6wEYES5tK/B5E744cP/9eiJdinFfwY34T4MIFB6ZTkrjzqe6bsyWDfaqechnwwOTqjV/bDXTIrGnerM4murngmEpG13rac3lRGgj01DFLNWWEYyDSXlKluS2iiYqN46EUfnhWq43F7m5xB4GPke66wnwVXosyz0wvu3kiJ34m58dCY63/2ta60JM697cYz75nnycHG/z8AXMIFiZ3d9qH1btCZ20A9yMuApPa6+E1JBsnNAK/upMRzYzfs1tjEXf/Z74dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jr7Q03mitAi0UxfYb0SVlJs7m7zbY4Hr7jcyAHdI43E=;
 b=EGKpOKCXlDl8yLNXRT4E2AHCVAYH12OgSVhhH02tyQvv/XW+3tMwBcj+fQZU39Pl39RwGqjgSKFJNSkgX1+U6lEmiNKURa0S/TrOn+iJWaIRpxRpv55v6UPX1f4fE+PuxvVpBhOtbyYIZfGbaTDhuFYm3VlVvZfBwcXtnn9tvks=
Received: from MW3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:303:2b::29)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 07:52:54 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::6a) by MW3PR05CA0024.outlook.office365.com
 (2603:10b6:303:2b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.12 via Frontend
 Transport; Wed, 18 Jan 2023 07:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 07:52:53 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 01:52:49 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 02/11] Documentation: amd-pstate: add EPP profiles introduction
Date:   Wed, 18 Jan 2023 15:52:01 +0800
Message-ID: <20230118075210.447418-3-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118075210.447418-1-perry.yuan@amd.com>
References: <20230118075210.447418-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 42618b67-1d9f-4289-4584-08daf929014d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGnbmqQG7rjJx8Iy1hF9LTUlk8uNY8Mw4JK5ifQ5H90nRc+V3Gdy0bHQmB4+RSBD0d1892513+a9rPToBPdsnQCtri5gpqOT1BLY2q9LgiMLLVDf1u9ecrItiYcGkRUd3dHWkRsh8/6q+2uMK0ppKLkEj2syBM1duP3ynaScNk9gW+oEHgqFE71DZCy2vvFnHGNhpiNh1AMCD8rjXhXkDPWc6RVPuM9EdXFj7YROa7L88rmM6S0LGJF45LNhGPBxM1IU3QG1Vv7xmj1Z4uuWdZGITywn1OFwlzWxxLihiNCxlA3FSr60kPBA1WAbJ5+ESrHWaU0Vuu4rhZg3u4l8xgmJiYiXapRAReU63CXnVP8/eIY3I8d3ARVqRf/9VFwVdwNeQKK4YwBlInTkcOQ44u/51YUQlZsSp2DmgD/uHt4oP1BtVvDQC8gIa3gbtDWppFgLAxMJoM+ymnm3oNtxyikU/RnvpMoPScQn9PUf2KIVWD7FmGAOOR0yR08EO737E+4xMTlCR4n48YyXLJNkicsdGTE+A/qiPl2FGTa1flmiQ/GcvtNEBf6uRY65MC4S2hqZX1H87raZ8YPWG9VbtNA3aKXNmtqTzleDd37zdaMFzSzhmOo1JeUUFgHXb4wJ67KdOrKxRPMP544gznU6C4Xh9cPQe/F9uWfkcQ5r26IGf+SvSt/Wk07Be/QhjUkajPATJfEjIYvBxwEJZRwifcPGcGiXHsigx2cUK8sXh6I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(40480700001)(54906003)(16526019)(40460700003)(478600001)(110136005)(7696005)(26005)(5660300002)(2906002)(186003)(41300700001)(8936002)(316002)(70586007)(44832011)(8676002)(4326008)(70206006)(86362001)(6666004)(36860700001)(356005)(81166007)(426003)(336012)(82740400003)(2616005)(47076005)(1076003)(83380400001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:52:53.5757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42618b67-1d9f-4289-4584-08daf929014d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <Perry.Yuan@amd.com>

The amd-pstate driver supports a feature called energy performance
preference (EPP). Add information to the documentation to explain
how users can interact with the sysfs files for this feature.

1) See all EPP profiles
$ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences
default performance balance_performance balance_power power

2) Check current EPP profile
$ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
performance

3) Set new EPP profile
$ sudo bash -c "echo power > /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference"

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 5376d53faaa8..98a2bb44f80c 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -262,6 +262,25 @@ lowest non-linear performance in `AMD CPPC Performance Capability
 <perf_cap_>`_.)
 This attribute is read-only.
 
+``energy_performance_available_preferences``
+
+A list of all the supported EPP preferences that could be used for
+``energy_performance_preference`` on this system.
+These profiles represent different hints that are provided
+to the low-level firmware about the user's desired energy vs efficiency
+tradeoff.  ``default`` represents the epp value is set by platform
+firmware. This attribute is read-only.
+
+``energy_performance_preference``
+
+The current energy performance preference can be read from this attribute.
+and user can change current preference according to energy or performance needs
+Please get all support profiles list from
+``energy_performance_available_preferences`` attribute, all the profiles are
+integer values defined between 0 to 255 when EPP feature is enabled by platform
+firmware, if EPP feature is disabled, driver will ignore the written value
+This attribute is read-write.
+
 Other performance and frequency values can be read back from
 ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
 
-- 
2.34.1

