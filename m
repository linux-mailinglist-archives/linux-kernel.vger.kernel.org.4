Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEEA67164B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjARI3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjARI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:26:04 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1C65B58C;
        Tue, 17 Jan 2023 23:53:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbsOIEEcbKfsK/oL34GJz0nN1i80E2hpvEXy2Ytg0BtIXpIBTLzOgrPBtS+DWRAiaA0gOhLfggIn/MmP7zDZSQvGkkhOStI2Zvbc1eRDk3V/QjJjt6xa4uPCPW5x3N+KYKyl63jH8yozMsQPLYPIYTxJSPaqDIvfSNpptX7xTb/6MQxdzM6FHhtcOx++8FL7t6CNVg/OmS6qydUrLL3htW0qRA4rJC6p8bC8xkDuk/nDIOA6gl+tQFnGhwHyTihLs/HS3b25vQM2i8WLGzlIGLYLBP7GytbpV+HusG3LzbbIqr++38IP0zg4g2EKOnI9mcRorzbMfeA/lwtjC2sOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pN/GQKK9MgCxkcMYrhkjw00Ga1ZbUCwtImYGqGqYF8=;
 b=RFBKRxOebfiycEBC25Gk+/NxKjoj4l65zE3SJxGHMYIVdsbE0KoCmt3uLOEyYMwAV1xkeKNcQy07H6Cn+g/fbH/gDdAWTZCavDxHl9WRn6/OyJl0Wr/i4YS9dy+kBzfdTC+1PIreyTU2k61FkJf8ASBGnyFC8L6lSC+ll/K+aWCOnlod+kX/Sjq3gf3hSHa7jo52jvTAOnr9Zj6vrCiKND2CeECiSjgL9lL+1gN7JE5lPzQKVWdR9hwroeFtSPX+hmsTLm2yD/k9GVRVXKAfvrR3D+6mq/l3d7O5P7ar4na2RIMbIywmR1ky6CcS+SZXvZ6VUbeqnVfSJeF5BjFgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pN/GQKK9MgCxkcMYrhkjw00Ga1ZbUCwtImYGqGqYF8=;
 b=vGESCMiqcpuOBRv/9PqvtSFbTmMaw+rhITG+dmDXVY1HrKNKvq/lAs7awdLAeEPhlTzJ2HdUDQszrkYcnl96NV7mLiF/l1sE1di+48Cx3ks080yIkd1wzonZ39mKBzJqXCyvaLLyyTlcnm6YmJdeABXyRrSl2575sx+Iz16KqkM=
Received: from MW4PR04CA0270.namprd04.prod.outlook.com (2603:10b6:303:88::35)
 by BN9PR12MB5081.namprd12.prod.outlook.com (2603:10b6:408:132::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 07:53:15 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::47) by MW4PR04CA0270.outlook.office365.com
 (2603:10b6:303:88::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 07:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.24 via Frontend Transport; Wed, 18 Jan 2023 07:53:14 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 01:53:09 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 08/11] Documentation: amd-pstate: add amd pstate driver mode introduction
Date:   Wed, 18 Jan 2023 15:52:07 +0800
Message-ID: <20230118075210.447418-9-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|BN9PR12MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ecb011-b045-4eed-932c-08daf9290dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eb4GMHjZCHYz3z+ENRlLD9wzQoi6mUhMpB2XxZnoD6rUKR+gWbPfUaYgUr+JXbBX07m+8GD9stq4pQGWPmLGWex3D0rd8EwP0Bf5jVjBlE6ktBrsSEs/sAMtwIqkJnnJEoibjdUM8GCLmOBW5QwewEWJenEmFtcj37U9+kJp6gjWOcwvkfp/myi0LgDgzff6CBoFOiAGKUGaP0zUtYyWgcG3kKgsPpE57NxVd8sxM8BNBZ3cbsLb66QvX3LzUlvmcH4ShOxbnFflQJntz0EIZqlYTp1wBHiBuzf45RCEvxVopZTNze7l+DqvTDDHfqJbAlIPvzXBdCOIFQZqUZtJ3TLWqXqoI4VbQtFJIwmzA9daF6aGr+0g/vhw1pnwRZvUfrEUTJLWa43DYVvG8PgKy2wunbi9dKJX6SNg/rUpgNqNPbl4fjSEXJOqbByUxzeeO8OBGyIGGZai13N+1kxTJ5ncn0GJFOca07Je7yUsAwzpw1uUxraCqoy7/GaTwW2SWU1CS1VwRUVdVz8q9XG/ij+gMaQBIr97tCJXnqURNno9LBF8OwLrYiLNVFgl6YSgVm7hrIsXEMMRY5fjKEerx8bfKZjc4cw/9hEyXwQfYPDUgrK7uL5cgeg3aE64s1eOi17PxTGYUh+3pRfOB3tYWobGhynAcga52IkMRa4R3ypE/yQaIfB5W0wR7gqZqXGlJzisVbQUTlxYq8kRYnbyG81hHJxQ5OvY/fn0FCn5t4M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(8936002)(5660300002)(41300700001)(4326008)(70206006)(8676002)(70586007)(36756003)(2906002)(44832011)(7696005)(1076003)(478600001)(336012)(86362001)(2616005)(82740400003)(356005)(40460700003)(81166007)(16526019)(26005)(186003)(47076005)(54906003)(36860700001)(110136005)(316002)(40480700001)(426003)(83380400001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:53:14.2366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ecb011-b045-4eed-932c-08daf9290dae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5081
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

The amd-pstate driver has two operation modes supported:
* CPPC Autonomous (active) mode
* CPPC non-autonomous (passive) mode.
active mode and passive mode can be chosen by different kernel parameters.

Acked-by: Huang Rui <ray.huang@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 26 +++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 98a2bb44f80c..b6aee69f564f 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -299,8 +299,30 @@ module which supports the new AMD P-States mechanism on most of the future AMD
 platforms. The AMD P-States mechanism is the more performance and energy
 efficiency frequency management method on AMD processors.
 
-Kernel Module Options for ``amd-pstate``
-=========================================
+
+AMD Pstate Driver Operation Modes
+=================================
+
+``amd_pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
+CPPC non-autonomous(passive) mode.
+active mode and passive mode can be chosen by different kernel parameters.
+When in Autonomous mode, CPPC ignores requests done in the Desired Performance
+Target register and takes into account only the values set to the Minimum requested
+performance, Maximum requested performance, and Energy Performance Preference
+registers. When Autonomous is disabled, it only considers the Desired Performance Target.
+
+Active Mode
+------------
+
+``amd_pstate=active``
+
+This is the low-level firmware control mode which is implemented by ``amd_pstate_epp``
+driver with ``amd_pstate=active`` passed to the kernel in the command line.
+In this mode, ``amd_pstate_epp`` driver provides a hint to the hardware if software
+wants to bias toward performance (0x0) or energy efficiency (0xff) to the CPPC firmware.
+then CPPC power algorithm will calculate the runtime workload and adjust the realtime
+cores frequency according to the power supply and thermal, core voltage and some other
+hardware conditions.
 
 Passive Mode
 ------------
-- 
2.34.1

