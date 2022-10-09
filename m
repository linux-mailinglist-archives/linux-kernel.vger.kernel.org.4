Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798BC5F89EF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 09:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJIHLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 03:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJIHLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 03:11:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C8423394;
        Sun,  9 Oct 2022 00:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsknZ0wS5AnLLJiMjq3kU1+GYwy62suCFHHY+2cNEkshIoAILLiA07Us/Zb152dDpNAQXINb2jYG3baLJuSzm4jSh7Bc+J9GuorwvdBQnI1G+L+eLRhz6TYTmYVCq1OSYVNj+muPuRAUyn883FhNGXXDvKpzBoCkzhohTo3QCFD9QwbVPtLz/ehO2es2OvXyeIWTAcehDNIdxE9N80NgnbrYt34iF3qFcUt0HXBR9cgSeEQ4GTGeEchlbis1ulgvk3O8FpBHfDpmglMdCF2DLFaCdpzVT3s958oZBf1Q1jJMhL4krce+m6WSr1yb3g9zw5iOaIzUo48W4uj8JGM5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcgwwgUTea8LzxYVtl63IA8DkBDwDsPFufaAzSXP5Xw=;
 b=lSWi2XvQaL54meEajJeSX2WNQW8MlS/oDTvSjkDh5ctOdSV8qzJQvGPspPqAoB8jm11tCCZkIEe0BrQD+JM/rRF7Npw3UXVa0mT/ACz8eEj6V2xzZHFcbi/cPAyjOv2n3dUjnRUkFI4TvjRo1Cl+HUQyJQQajm+QFXidLRYeKedvqBVPcTlA4JOX/Ml0wKJODzWNYtLyAVYsrcKKWDP7XXp4TMgIMkY6ZOq5ipafI321H0wZ1dOB5Z5L+cYxflj/LuDxLT5oN6FpFrQMd2WqcAXjMVngixQGcwlwx1wOTCdxplt2itq+0TiQSJCYhXEDgQ7hMCVTPQP4PNUrh28dSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcgwwgUTea8LzxYVtl63IA8DkBDwDsPFufaAzSXP5Xw=;
 b=OBAAROgA/eOd6Zic6dMgZP3DYzh0ZX74vuFlWdpgnxY7MozSKB6+q8to+rr5Ly1u/JW6GkuMA4H2cd243oX9EiQnKgjZAgN3Uub7uD0hE4gZ8nRC3SUhFIva2nR4TokFsOtmC37FMl9EHvjMG74jvV0RJ8RzB4SCQLYxHBAS7ZY=
Received: from DM6PR03CA0100.namprd03.prod.outlook.com (2603:10b6:5:333::33)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18; Sun, 9 Oct
 2022 07:11:29 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::cf) by DM6PR03CA0100.outlook.office365.com
 (2603:10b6:5:333::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Sun, 9 Oct 2022 07:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Sun, 9 Oct 2022 07:11:29 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 9 Oct 2022 02:11:21 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 5/9] Documentation: amd-pstate: add EPP profiles introduction
Date:   Sun, 9 Oct 2022 15:10:29 +0800
Message-ID: <20221009071033.21170-6-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221009071033.21170-1-Perry.Yuan@amd.com>
References: <20221009071033.21170-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8b8fad-8dab-4d1a-c6e3-08daa9c57c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RBWGf8wb9mCUapHYyMyUEf7pFOxtlyRoNpmcX5/m3gJ33TBs2tPiJd74P3CLwGjJlgCOAKc5O2qfkQQ0bWlAaJSp0mDAutOFIT1jriyfOu5xN2bqOon1wCyb12S8+/GxphVLNq1RP+hySV2kt/hE4nXO8spmEVPQaql5qdgaYYqDyaf+K05dG8ijGRsMPzS8srU/uEeT8/CqVjFcDTLGjlD+gz/q6lfGelAhXLFy5Q8udHLsk0uVQYd1RhriNIFQubCoEs2HyIz+n78COky60oK1wr8REa9i4tHQOkYcLSYohhskiZP8rxzSZ/QoHeOpOLrFFkgVbjPM8BJwIO7v9DdPgvC753r7tX/Y9L6FVoFfQ32DjrX1X+X93WER1eyoan/7v/Du9j0zOzzkicvSej2BKjPm9sSdnmuw7TG6RYHUIzxmgs/NJK8qpytu2yScYFqGSW1Li0JQT4S62/UuZ+DHmmFC8tLyP0NeeoJIECgBt87QrkHdoAkzXGpn4ogMJTzBxDpyX0JFNTj8HzY3bWQBB2N/GW21+Qn7l571mn7bM0nVgRSPCDzzKtJPwYgdB3RHcpnSu7K167yVeZKqvPKDKZAWgfsNy1LnveIiSopKxZ3ZTYSVAq9aAdCxXPt55MgTwZRcMNKKtWKgZ43oB7J/vTuS9FlI8BbTTKPNJK3LltDM2aSSeHK0YWhpqH/Qm9FY1bFT/NBseNQfUkyzbS8CuM0lL0ocn/dNXzbHQnEtiakQyOOE8NWN6ZxlRx1IIwJ6QM43OTvkwv036ojMlXP36f1sXThdP8QmTLvUOUrLXKz3RvP3HJhhTCiEcsRKI+0aLDaaLDVECpsUf0glnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(26005)(7696005)(40480700001)(36756003)(8936002)(70206006)(4326008)(70586007)(82740400003)(54906003)(110136005)(316002)(8676002)(36860700001)(86362001)(81166007)(2906002)(356005)(478600001)(47076005)(5660300002)(426003)(336012)(186003)(1076003)(41300700001)(40460700003)(83380400001)(82310400005)(2616005)(16526019)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 07:11:29.0218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8b8fad-8dab-4d1a-c6e3-08daa9c57c9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch add AMD pstate EPP feature introduction and what EPP
preference supported for AMD processors.

User can get supported list from
energy_performance_available_preferences attribute file, or update
current profile to energy_performance_preference file

1) See all EPP profiles
$ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences
default performance balance_performance balance_power power

2) Check current EPP profile
$ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
performance

3) Set new EPP profile
$ sudo bash -c "echo power > /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference"

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 83b58eb4ab4d..d0f0e115013b 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -261,6 +261,25 @@ lowest non-linear performance in `AMD CPPC Performance Capability
 <perf_cap_>`_.)
 This attribute is read-only.
 
+``energy_performance_available_preferences``
+
+All the supported EPP preference could be selected, List of the strings that
+can be set to the ``energy_performance_preference`` attribute
+those different profiles represent different energy vs efficiency hints provided
+to low-level firmware
+however, the ``default`` represents the epp value is set by platform firmware
+This attribute is read-only.
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

