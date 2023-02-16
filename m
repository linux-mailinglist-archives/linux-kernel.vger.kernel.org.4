Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2D9698E94
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBPIV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBPIV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:21:27 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E13474D7;
        Thu, 16 Feb 2023 00:21:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyH4kqyJyP4LH+YmvU0rhzD0vlNFfnj9EesAe1dVGEO4cty5zWaLexSqTILJOTEh2ejHfMRvXQ47uD3imM1PIGRN2qwyUksdPHRBl9NQSz7XawbcIULtZjHhOxgFlhdU8k8FMfWvcq6u4QD7hdECil48gEtR7Kw3XQFwDoLOm+N0prGCBBZakcRlny8qfm7Lyb+hUJermmN6I2ge+l6E2RzmBZ+g3jj06Qt0U6Fixutxt23mTqkCbDu7XF2eoeD3a6SRhlAk+EXY3jPSwXVc2JPSzAlQh3u9O/oRKjnMjVeH9A7r9Cr6EdeodG7Cd8JqaImBwgYeAEw1fAKq0E/h1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYHnwtjE4Ts7dhIt9xsEXMlV6Wkuhg50KYm9bT1XLzc=;
 b=bzA2muXW6Rm1s5x2NbW7g5OZbpSeYTQ1I6RmavEP7aBnoqD0P/VSQDYfnuHgEayUFJzXMQOHf0m0qPHWEG3owv8L2tIDrKezJCZCkIDEVgpJd8uEI4VMRuWmYSToPHPQMSoQwPEwh6BPgbqcb8J9oFTOHhlDx+kLjJ58c+KV39+2gFWE5EaV9SPle4YmJ11Bc7T3LkhjXhFyOH3SWhrsMOfwkVxm8109gocc0E+2J7l7OHKX/pUVtO8leJkPOtwoB+RApsVJ+prDBKTid6BDgg0oX0Gq9kgsIp19ZqxrolPGPUKj1QwV4MFENVZB5uoJLYIZSgdGZi1NRy7f4UCGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYHnwtjE4Ts7dhIt9xsEXMlV6Wkuhg50KYm9bT1XLzc=;
 b=hUq3ksOV1HCYv7SaCijG9tDwHBPSjNXo5ZmAWmawsCwgwGrkx1GegE5O+GQPs1m0XdDIAqzQmseuZ5sYP8cCXYuaZcUtAeEF6xsm0uw7gZOz5V9LFwF1VhLRra2t3apmiCVyHRUKEkdBGkZ5Pq2JAmnqPjavVn71kmO2ITE4oE0=
Received: from CY5PR22CA0013.namprd22.prod.outlook.com (2603:10b6:930:16::23)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 08:21:02 +0000
Received: from CY4PEPF0000C97F.namprd02.prod.outlook.com
 (2603:10b6:930:16:cafe::c1) by CY5PR22CA0013.outlook.office365.com
 (2603:10b6:930:16::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13 via Frontend
 Transport; Thu, 16 Feb 2023 08:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97F.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.9 via Frontend Transport; Thu, 16 Feb 2023 08:21:02 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 02:20:55 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        <santosh.shukla@amd.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>, Tor Vic <torvic9@mailbox.org>,
        Russell Haley <yumpusamongus@gmail.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v7 6/6] Documentation: cpufreq: amd-pstate: Update amd_pstate status sysfs for guided
Date:   Thu, 16 Feb 2023 08:18:02 +0000
Message-ID: <20230216081802.38007-7-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216081802.38007-1-wyes.karny@amd.com>
References: <20230216081802.38007-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97F:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 059181cd-603c-459a-b7c0-08db0ff6bdb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBnl7vJRToMaV0U6FiFk4V9WUq8sv4R4Gpiml0hRKhEY5Ga8WxHIymUPkTKFurLENE3GGpfxVrYfDjKH1hJQCYeyvRyM97bi+R+llrc2UFw+/Xx9Hf7MzObNO7GtKWCTL3gAcpv/0DrfeRBw4IO8Nesl1gLWI2u6on80JkdtZ1snJ82vjfxm3zbaTJRr/G+Z9708zQSqoKM7pSrQ5NrVHMqEymDAa7NRyvx+fuAGGJy7DPHqegcY/TZChxfcpbzRXTHIXFYFn+Bc5iaAC/EzBshZRpt3c9NwZsSVuJ10/xdW3EBVlR4gM/7Cc6F8M8nLkcxuHl9uV5VHkAqavRA9K6gSYKeKbkAEPZi8ST1ncgHt9j1rdUu5FwxBugePEhF/XYPeeI1fzeXPD9wMjnTpFHm+VTp0Ysn2l1EpaVEaqK35UbHczzNUNnTSYYW5nL6BUSj/F1+3CpaPBxOyVyc5WWGCKIJEtdxeJwI1iZsYBReDGqKs6qJVSP8/3FLhT6lyrDKTOu05GOXJenzNP+PEC7Fna7lOlL5X86eKm0eyg+ujamCbu3W2MVffaYxVOs00FZHbW6mNLKqKJPLn0jtWWrqd4Pp8VvnQ/RNBRv69p+cEcmvPZkV/osS0f67PRdoRVRM0+VKwj6wpzOlkV25P7SGXlJSp9y5VgvdNiEKX4UnnW5fgcRr3ZJY6xq7wifPus1Ql820tp8Rn/BijYprDK0LqJ84ATbepGAkUmjvadhs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(81166007)(82740400003)(70586007)(8936002)(70206006)(5660300002)(8676002)(41300700001)(4326008)(40480700001)(2616005)(36756003)(16526019)(15650500001)(186003)(44832011)(26005)(336012)(110136005)(36860700001)(356005)(54906003)(6636002)(82310400005)(478600001)(7696005)(6666004)(40460700003)(86362001)(7416002)(1076003)(426003)(83380400001)(316002)(2906002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 08:21:02.1334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059181cd-603c-459a-b7c0-08db0ff6bdb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update amd_pstate status sysfs for guided mode.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 31 ++++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 5304adf2fc2f..95d2d0a803fe 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -303,13 +303,18 @@ efficiency frequency management method on AMD processors.
 AMD Pstate Driver Operation Modes
 =================================
 
-``amd_pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
-CPPC non-autonomous(passive) mode.
-active mode and passive mode can be chosen by different kernel parameters.
-When in Autonomous mode, CPPC ignores requests done in the Desired Performance
-Target register and takes into account only the values set to the Minimum requested
-performance, Maximum requested performance, and Energy Performance Preference
-registers. When Autonomous is disabled, it only considers the Desired Performance Target.
+``amd_pstate`` CPPC has 3 operation modes: autonomous (active) mode,
+non-autonomous (passive) mode and guided autonomous (guided) mode.
+Active/passive/guided mode can be chosen by different kernel parameters.
+
+- In autonomous mode, platform ignores the desired performance level request
+  and takes into account only the values set to the minimum, maximum and energy
+  performance preference registers.
+- In non-autonomous mode, platform gets desired performance level
+  from OS directly through Desired Performance Register.
+- In guided-autonomous mode, platform sets operating performance level
+  autonomously according to the current workload and within the limits set by
+  OS through min and max performance registers.
 
 Active Mode
 ------------
@@ -338,6 +343,15 @@ to the Performance Reduction Tolerance register. Above the nominal performance l
 processor must provide at least nominal performance requested and go higher if current
 operating conditions allow.
 
+Guided Mode
+-----------
+
+``amd_pstate=guided``
+
+If ``amd_pstate=guided`` is passed to kernel command line option then this mode
+is activated.  In this mode, driver requests minimum and maximum performance
+level and the platform autonomously selects a performance level in this range
+and appropriate to the current workload.
 
 User Space Interface in ``sysfs``
 =================================
@@ -358,6 +372,9 @@ control its functionality at the system level.  They are located in the
 	"passive"
 		The driver is functional and in the ``passive mode``
 
+	"guided"
+		The driver is functional and in the ``guided mode``
+
 	"disable"
 		The driver is unregistered and not functional now.
 
-- 
2.34.1

