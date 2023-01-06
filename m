Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9265FB4E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjAFGQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjAFGPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:15:47 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F58E6C7EA;
        Thu,  5 Jan 2023 22:15:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKiJ6vsMFcx/VJMEBBpkkDvhMlTF9dQEhJxGmK5qYkEzPvnoCq8dGBXQtUdEHd/yRPs3yQItzlvhFuhfBb/sRdgGropbXQXmgIZsUrY2ccpdEw1VUcqzyZPcRprssuOuQyz9iquG32lCKU1/B6wJCtgQnVz1N7s/kJV8wgZ0zg7YmHBeqMlltzK95CDdv9sW/KK3iNRFUVYYiMs1Z6h2lECANlzuq6tCJzkq5oMHJBqNeD3NWo59Q0hF2awTPxCRCfLKl8RNUF664t6sQuve4j7jNDel5uB8bkITc8lnpsmXPDdm4aTSSwICJGdrqG5CTlIz02wUCEcS6TODOvNOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iII+df8dnkVuEFvhtq5qZL88U36fP4G+zC7Ke47Rcp0=;
 b=kLLx0sDiRI7Tmah0XRyyo9EZYCzN2QSiQzONzONEzwxpUZMzBk4fnEC4z8o39OTy3msY3KLPQ0WgNfkPc5bcYeD0wCe9GGPnsZ5yPh0agSR+++kpFfksqg0UuP/73VjYaOl33UwUNp0M+4I/WY3dkWngAR3xzCWQob7NzdnCzMs8A4KvHHf8CFy+qyVhYAcCRYRubLquMq9Lrr5ed0meHcuFwwUcvulFbhHrfUYx1YUNtdIzE4GeUDrlZ7THfkreti9s8s4zFrwGjnxhgDb0C9iAMtNEdH34MEgMUtgExQDmwKx6vJsLPQy23OrPkyRNfz2eRqZLqhOObby+l7V6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iII+df8dnkVuEFvhtq5qZL88U36fP4G+zC7Ke47Rcp0=;
 b=K1zDd6hbXTeGNE5FynL/pOxytDht+vFPtowFNIjYGIRYLiAXYUbQa67rrLP/xSlot2+8TRhe7tO0DdyoBhH9YpsGNcTSC2YsnHsy4LG1D2QYJ22WYWcjicpP6tqEX+9uXnxCMBsCFeYcuEOeFlI9Zc/q6Fstkuxm6z94wb5KR9E=
Received: from DM6PR11CA0036.namprd11.prod.outlook.com (2603:10b6:5:190::49)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 06:15:44 +0000
Received: from DS1PEPF0000E635.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::ab) by DM6PR11CA0036.outlook.office365.com
 (2603:10b6:5:190::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Fri, 6 Jan 2023 06:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E635.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Fri, 6 Jan 2023 06:15:44 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 00:15:40 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 09/12] Documentation: amd-pstate: add amd pstate driver mode introduction
Date:   Fri, 6 Jan 2023 14:14:17 +0800
Message-ID: <20230106061420.95715-10-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106061420.95715-1-perry.yuan@amd.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E635:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: d868b0f1-d82b-4e22-a66c-08daefad71d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VaLGDYzUs7qp8E4Ag0mjlgYtD8fgiU6K03o5R6Q8iqrkgyuL7cJghIYZnzbKApy7xRAGXorW8jThFk+aH5HXdZC3FKbtHYDIOxSXlc+ttnhUZEnsXLOX1owZ6BzOarQuFGzjfH4mhz9fDQ44vEL9W/XhyYx8StgwtQHy5NliDFF7sNUpeNHS1gEAMluNYYZ2tcZiCH104Eu7hyxfYxVvfaik+W6BeBiqrMvAbhaBt9E7ea1Vrevocl5xnnoLS4VTh/EVqm+v/SpytkDPGEsL0yILlFdKpZad8KiYK87qLMlBKTJN+F8tShSDFbb0T3aiVb+tLZlIeiS9tn84ldb8iW3eqPG66mZf++syorGm2MIBoARLw1MrnjxiGI9NlRT3AfazHsfqVz2R8iUToYaBTSDf29Mpd7yVsLuBaupOX1Xf455xDnX5351y8pRMoj9qBNnW5loHQ3fyBtck6m7wi8jPlmuVouqqgxDpgs7UbrGr1lQGG1M4WfkN/hV36Hst++cAVF1ne8h9NyLdv0xOTHW+LUPQDk5urOK3ke8d5hzmb+n9K/WY1wGbAJVR5MhMc9Uvw/VJR5cnbktVWyE8exU/1DTO/kSDoeKo7EtDTkns4W4bL4I7T5LMElRe/SVJ55arlbui44xS0oeKdnU2PBPTvFnxisHrawZsf1eHhZjrKL6plwSjMGxF/OKwNMEIhovdCliCyR/fBv6bG6VNfZw8DKL85V16l0mzLs9tyB4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(70586007)(316002)(44832011)(5660300002)(2906002)(41300700001)(54906003)(8676002)(8936002)(4326008)(70206006)(83380400001)(36860700001)(110136005)(82310400005)(478600001)(36756003)(6666004)(336012)(26005)(186003)(1076003)(426003)(16526019)(47076005)(2616005)(81166007)(40480700001)(7696005)(82740400003)(86362001)(40460700003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 06:15:44.3969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d868b0f1-d82b-4e22-a66c-08daefad71d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E635.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
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

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 26 +++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 33ab8ec8fc2f..62744dae3c5f 100644
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

