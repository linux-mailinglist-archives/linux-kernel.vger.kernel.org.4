Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48286248DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiKJR7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiKJR7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:59:25 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE77C45EEF;
        Thu, 10 Nov 2022 09:59:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih4KWc6xTA806J9+SwZsd0x8JzN53XaD94jyeBXJq/b7eVU2NK2SzE+o5HtrZyUSe6UO9MY7xCFRnG/Ym7glzDzkXsSEWOZuvnkHhLGlqfsGSg5ZtJWDrDVR41GyxA705Ddpj28KiK+kqw1g4myb0/l/hKM4mYmiltApTaFnNvEwJlB24DpCOOIXzfkAtGT2dIBP8RP+EPm/WC0Yw+QOwbVJcfRjATwQz0KNjTFx7WODL4wb1vIaYebtBm2PGfIIHB/epNBTu4pBxAqdlHjatSxyoAlCMxuDxDCn9zdWXBrb7cDesHShAmcbUPK6M7GMFV2iKBokUAeycZHHG8N0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIaIq+OPQdQhhx7Im5ObgwhaWDiNSceNa7rhrD8XXXk=;
 b=geTIajeAaFY9ify1wW/KBt8st7zVy0dAIFHkCqk3nTFyzQ8yQEU6ibEdSrV5vSqAM/9zuuCV1/12jkB03QMKIKUnv0uRBNcOnK/Y72ccFcP5niXXuQyBCuASzyIyq2MMy0iLtesb4GvKUgubPv5SH33ZyWIjksYnSbslEUydLylUqMHiH5eno/DJsdlOa95CCdIW0LbsyTbG9oQwo9c2FcKWtdUGY52zKdwLdV+QGGXs6AqpEsJ3VbJwKZaSdwKnog0dEhepoxw6Dk1jmKxNcelpD1C2NfFD3MfeyZkZA0Hh0EAEhSV7/OpvR2sJ8zQNmUtB8k5V031n8YnL5koPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIaIq+OPQdQhhx7Im5ObgwhaWDiNSceNa7rhrD8XXXk=;
 b=W3PDm0ZOnQz0j3ED+fq69yRChy3wxciT7At6P3DsXVxxkFufNLbK75GzyRPKeQWCxINN0rPay+FOSC01gcP/akzps3Fqs2GSN9xbACnFXn6qUTvDwMkpTe9ZxBrl0na3pME/m1iVExnbMG+XeXiWCjIslI4kAiirt+niP9GlDrE=
Received: from BN0PR04CA0035.namprd04.prod.outlook.com (2603:10b6:408:e8::10)
 by DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Thu, 10 Nov
 2022 17:59:19 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::51) by BN0PR04CA0035.outlook.office365.com
 (2603:10b6:408:e8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13 via Frontend
 Transport; Thu, 10 Nov 2022 17:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 17:59:19 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 11:59:16 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 2/9] Documentation: amd-pstate: add EPP profiles introduction
Date:   Fri, 11 Nov 2022 01:58:40 +0800
Message-ID: <20221110175847.3098728-3-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110175847.3098728-1-Perry.Yuan@amd.com>
References: <20221110175847.3098728-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 1317a143-6da2-43f0-4c18-08dac3454a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/NIRFtOHWl1IvFyoEGx+CmsybKKC3vZRX9hGvmg8UJ6CnhD/Jhq21BnHp7zhVl/HtLdU+JQGetNqsCk+lWQhNbNBA6DuBrQYULhK7T3VQG7orc4IF4losZ5fpGzGVtKtTx5HQLXvSeKNLehGLJmvDpaZ97gExx5XHmAZVvTspylbKNuUDy4whr/LZw6gjgu8SvzwF9m9XS3/+hmcziftXdx501VPq+pXlJKWyjwfZKgdZ5kOhr1q63hgIGfOwo5NRUSprzANIfaQ4YYf61Muo1b6YPh9sPypYlLIn0bChN5UcDKDLfA/oDRT5+nrB91oCL2xEwILRqGrz0Mk1Xwvyuy2xNo9fUHYHIn+UPoV53V6i4h5s6JoejPDd4oJRVg469P+FZ77RJMkWIbzQ42nBVERrICiL7DOGrL8P2OMivtRamuj35F2mNcxvikCYxoyAyftULR/0A1WERV8RUjnOev3wNyeDgO3gkU8zVr7dpwiQsWYtwTnb63eqz8gr4GYSIAagz4g04yFlnpV8rITcOHp4AGkzQrENM66Zr2B29kMsgdc530ITzhzcEYaz31QoHJO+hw5u+wf6tJ9v9kNBi2wJ7fkt9VZcoXqma3gwwdXQhbboXVF8+tNxPJWyEwdl7MlP06H9BhxkyDl6uNwBG3I3a1Bqz8pp3SPfUNgR1lOETMUKTHKxX2EmQomiTN5xePLn9/prfD3OHr+SoS21mekkNHgF3rTQbZ23rhw86eX+BkUuHvtGx1UXk8fQz2izh2MAcbCovtOjDfjsfBw11lAh3bTgni4pUn5lze0QoiaeEADmnlp+TiIA2FUGYP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(8936002)(5660300002)(82740400003)(8676002)(41300700001)(7696005)(70586007)(4326008)(2906002)(83380400001)(316002)(36756003)(40460700003)(86362001)(110136005)(54906003)(26005)(40480700001)(82310400005)(478600001)(356005)(81166007)(6666004)(70206006)(16526019)(336012)(47076005)(186003)(1076003)(2616005)(426003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 17:59:19.7925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1317a143-6da2-43f0-4c18-08dac3454a9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 8f3d30c5a0d8..e7488891b12f 100644
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

