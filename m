Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4533C646E59
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiLHLVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiLHLUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:20:41 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D953A59846;
        Thu,  8 Dec 2022 03:20:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQZ/1vXQjOaRx3WNFVOp0Wr4+P1vVhe0iDMk3Yq0TzMjgz2NTRSmxWuhi7/Sd4NTx0fi275i7mchy/uq/vNl+CP3gkFvB+xkpi92YIPmqoBdJjirimlgVNtxhkG4oIL//ub4BXw+CD7nGkFgbZf4jxiQ1GaEIn8YhZUoF4OQxdBJr+l4ooOeKSBhqkyNcfV5SSEz3EevjqyVXNEZrui4JkS86nursBzt663YI3u4u3BBbsvMxVU3yqhJj+/J4GsF1zZw2v9RgNcDNK7/R33pG66/rDTReWeJj7b8OoqPJr4jL9UtEosM7NW2mKkOoZXwI5YPVKIjAYwqr1zWXgsyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkrXvP21/lXSUDBYE91jYDjO48MwETjEk3S/rbUPzxI=;
 b=g9tn4CS53yZbOrtPBCEoQIgGtSgN7rM1qC3dfootdL38oaJ7TkwzKsFN4l5yul1vzAxURVTh9TJp5xeMqXOUj8U02MBMuOY5k3yC8MvH4pEkAjjzqHsOunD8J12joa4IFdjsxuxIt8+6+vDRzRXvbZz1ki1tju7h6TGsB50Pv2OCnRlpkjhfRQtL+wSlavqBxQFJIIYL7zHJFBTTkRkSGkAupS6fwvM56PcMZECVc8lV9PWxLoFt7ztz3hdXVRY/2Gxhj4bTmi3CqKPyMwLii8zqQdXQGZALCR2ndD2V9YBvndD+YSGiVre+LuVBy23mfC7q2nu91+wYtdnunvt7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkrXvP21/lXSUDBYE91jYDjO48MwETjEk3S/rbUPzxI=;
 b=pCrbkmCfB+V1m0++ir4qbuORlj8Ezw7f+1MY8IJocaruXZlpswyBO5DPRlroobuSikMxLxehXaYDaecNPgGm0BqIno2XlO9AOY0Mx+u4ovo0UxxVJhT+xnm6tpW+Ni3EoMVT1tUEmYkl9oaf5TMw+kR5qB7duQzV6bGTmBt4NMY=
Received: from DS7PR03CA0178.namprd03.prod.outlook.com (2603:10b6:5:3b2::33)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 11:20:35 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::f9) by DS7PR03CA0178.outlook.office365.com
 (2603:10b6:5:3b2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 11:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 11:20:35 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 05:20:32 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 13/13] Documentation: amd-pstate: introduce new global sysfs attributes
Date:   Thu, 8 Dec 2022 19:18:52 +0800
Message-ID: <20221208111852.386731-14-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: e97cfb31-3870-4748-c7d0-08dad90e3a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zm4oGxTejcJzydospRkb2Xoqs+Pi+LL/t6NCHId24guxT9UwscWcjjixqVXov3LnngUARrOutZWNOdiTEOO4N8A3BEQkyHv/q6hSx1ts6QKgQB3AUlVEjSTbmntBoD/+46Xt7qLuKPM+w+r4cuN27ll2eVoKKrbH+sUXWBCYWnZaQgpOl1KHLnDtlX4KlBZfNi7/M8VR15cV6X5CYEfevtislCCcr9PQD3DH1JbBmw/HAr/ss9mkJgRIVezB1ng2jzmhNrd9SYcCXsryjyD7h/qiocX0evbWrf4G2+vGVlX6rzQV6/8F1SrJLTvGB+BX2HX2wA3ZKRclnhKWmR4KBchkW5ZBkxS14i3kzlVXMWZfpP6Zztpxqbf6JTnaSaxP9YEhYWyLAQbFQmPnGDM4tgArQc9fd1jPEYl2W2lsnJQhIWjUVK4gBTgnrA0UA41HRcKyIN00SAjJjkxxUz3JeHqm0P+SdJc63iz73wcjmm/N0FvIfgUUgeaN5UctWjtGgrasfKqZ/Ow/iwN/szKdfQiqHpbuPGO7TvHJPMwCm+TBG52efFp9OnEXL7DAkMXj4AvGMdLZM3mBRe2IImCU9MyhTiQJqnhxQ8H3W5DO33k6TKQTPaXFY4CxTjucWUik0vMLnF8RuE+E1qAOHy889E1IZA5keUMeCCn7wlmxO89JpjvK71cmvpAEcbhb13KNViZutGC+Tt4cFy3+nSVwSjRkNMR2Bhbu7e5P09/y0fU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(40480700001)(86362001)(40460700003)(36756003)(81166007)(7696005)(478600001)(26005)(36860700001)(8936002)(6666004)(44832011)(41300700001)(356005)(8676002)(110136005)(2906002)(316002)(4326008)(70586007)(70206006)(54906003)(16526019)(336012)(82310400005)(82740400003)(186003)(2616005)(1076003)(5660300002)(83380400001)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 11:20:35.5920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97cfb31-3870-4748-c7d0-08dad90e3a44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new amd-pstate driver support to switch the driver working mode and
use can switch the driver mode within the sysfs attributes in the below
path and check current mode

$ cd /sys/devices/system/cpu/amd-pstate

check driver mode:
$ cat /sys/devices/system/cpu/amd-pstate/status

switch mode:
sudo bash -c "echo passive  > /sys/devices/system/cpu/amd-pstate/status"
or
sudo bash -c "echo active  > /sys/devices/system/cpu/amd-pstate/status"

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 62744dae3c5f..b8e33db3957d 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -339,6 +339,44 @@ processor must provide at least nominal performance requested and go higher if c
 operating conditions allow.
 
 
+User Space Interface in ``sysfs``
+=================================
+
+Global Attributes
+-----------------
+
+``amd-pstate`` exposes several global attributes (files) in ``sysfs`` to
+control its functionality at the system level.  They are located in the
+``/sys/devices/system/cpu/amd-pstate/`` directory and affect all CPUs.
+
+``status``
+	Operation mode of the driver: "active", "passive" or "off".
+
+	"active"
+		The driver is functional and in the ``active mode``
+
+	"passive"
+		The driver is functional and in the ``passive mode``
+
+	"off"
+		The driver is unregistered and not functional now.
+
+	This attribute can be written to in order to change the driver's
+	operation mode or to unregister it.  The string written to it must be
+	one of the possible values of it and, if successful, the write will
+	cause the driver to switch over to the operation mode represented by
+	that string - or to be unregistered in the "off" case.
+
+``cppc_dynamic_boost``
+	This attribute is only present if ``amd-pstate`` works in the
+	`active mode` in the processor.  If set to 1, it will cause 
+        the minimum P-state limit to be increased dynamically for a short time
+        whenever a task previously waiting on I/O is selected to run on a given
+        logical CPU (the purpose of this mechanism is to improve performance).
+        when the I/O wait flag cleared, the increased pstate will be restored
+        to previous state.
+
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1

