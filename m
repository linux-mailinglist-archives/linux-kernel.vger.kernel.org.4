Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD4765FB55
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjAFGRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjAFGQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:16:37 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFF46ECAB;
        Thu,  5 Jan 2023 22:16:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb1qDeCNE4G2MIv3U9iyxZNu2JqYQOd8qkHWcyW7Ik2GfdAreueOFLMKzlt4EPI4ddQuNvkc4OhS0k+IqU/KQ5nmh0RzyPp3XPeO3HyDBYWCmT+4S/nybcv1lM/dFJyhBpfl9YMIkRRBeKpNxSE+ouk6hV2FWFwJqkmx5w4f8pAQJvAwFCzydpvSgoEOFw69Shcfkw9Y+ujEwsS0A7HLfBCBjs6NnXE0OwuGDJHL6KmofAySFL1OmG36mulJtrt/IVb4McbNznNt8thQLe2ea8I4DJFgh1aXBpodFqaxwR4o7iY9mq5PMhGeXLX42WY1mLUJhF+FI+zvE4BvB3bAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oWpT1KWCm4bscKLF+RcPwP3efObjQhdJn0hV49o4r8=;
 b=a/fpQNJ75+WR/uL8VD3ywqP7qlGOUntFX/j9IkBsMSoXCH032nl4MiqA/G5dQAIA+xNt2Drm9hzRvb9z1nAK2z9iMD6dB7Iw5AtFeJJrKTcyorqKNBWHZ4qH5QUGptWBcmsWcpnSMWspP6paaB22vdLpv1wf8MUcGdUFUbXIBYWIpqnH7otvCPoN4Xrk2bKUBgunPelqd2CKIDQoQX9a48nKL4uQh2me3b2KfMn0pwijBAUvis/U084ZbFPWD8VBLgDhEKHsq0aVsXCeVx/dUVxTiZnrbaGCtOBT4TA+w2ul+U88YXxu5u+KAywQ53D0udtIC1hYinMcgexFimERNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oWpT1KWCm4bscKLF+RcPwP3efObjQhdJn0hV49o4r8=;
 b=a1b/cNb9Uvf0+uj3UAImLFdms0XkAnHIQshSnra4T8WR7d1YPOvvVdTqSr4NQHCIYQIcuJTWO8i+7SZou1sipRThG86xC3sW+xgeHTTR6RxLvK7TvqOyHCJbxToUlMPnFj3yKdu4HdYUyFIgohslbwCTtC8a2s3xSXf9Rs6xiQo=
Received: from DS7PR07CA0009.namprd07.prod.outlook.com (2603:10b6:5:3af::9) by
 BL1PR12MB5095.namprd12.prod.outlook.com (2603:10b6:208:31b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 06:16:31 +0000
Received: from DS1PEPF0000E633.namprd02.prod.outlook.com
 (2603:10b6:5:3af:cafe::89) by DS7PR07CA0009.outlook.office365.com
 (2603:10b6:5:3af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Fri, 6 Jan 2023 06:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E633.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Fri, 6 Jan 2023 06:16:30 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 00:16:26 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 12/12] Documentation: amd-pstate: introduce new global sysfs attributes
Date:   Fri, 6 Jan 2023 14:14:20 +0800
Message-ID: <20230106061420.95715-13-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E633:EE_|BL1PR12MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f1812f-9c07-463f-68ea-08daefad8d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JBttypW7EOpYxgLn0sGqSi2F8xB8C9lsuxBFV9U2jPYFGfFccX9NTrJektM8p4Lrsr0KoAm+HHbo8Bdf91oiwdDPCvawidy1Zxay3OhT9fOVutOdJ282ZKJU+liaTgvTME5vE9SWovlbvCZJrMi+y8Ync3JD+y4N1KddonJCY6gNqK8LLPOOO5SR94FfQ9VCLuoQU4n566EXYZZDKZQBsZtHiLuiDUGesIIBDd4uq68I7q4O5OQmGcnTjzaLMAuJMJPzyCFyDqvn7IpcsHHI7PfWi+SpQKmKHmz+hYYE3DWuttAI8cmeD4pDvOtprbEqpLRhc+8J9uVWVC8mxs8yPfY5T4UBWkl1/EJmocuRbR8iMyZ17feaIT+yU7LN8YzaEWSjcwiXcDYaK2pla2ASYxvQ1FLOgIVBb1CXrnECookc0k3Fyl9Y8apPEJ7tasmSR4trAosCT+CWw67vhboaN+qGwEHGgUmJSYy0szcObP7anwjMxBThYiBDSpV0UD+CgCjBu/Uc8yN8DYdKhctEMbjYCB3Cbei4Y0JWSpO+aG2oIragzqBf0kG8A6rufMjxbrXPwZAEGi/FX7ZQ7UwZiehs2JOIjbb+96t+7YvaZBEsnk4HJtqqY1lRtUX+UN0HTWy9v29fQovULosANhocQbv+zCY+AMBx43xzbR2bUUd/DnP8OGJ+81MQUEW5se2+LQfqAl7DEw0FCaTc5X0krqsTpud7EeK3QPNXyCLUB4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(5660300002)(4326008)(316002)(41300700001)(70586007)(8676002)(8936002)(54906003)(110136005)(44832011)(2906002)(6666004)(7696005)(26005)(478600001)(186003)(16526019)(70206006)(40480700001)(86362001)(36860700001)(83380400001)(1076003)(2616005)(336012)(47076005)(426003)(82740400003)(81166007)(36756003)(356005)(40460700003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 06:16:30.7359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f1812f-9c07-463f-68ea-08daefad8d77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E633.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amd-pstate driver supports switching working modes at runtime.
Users can view and change modes by interacting with the "status" sysfs
attribute.

1) check driver mode:
$ cat /sys/devices/system/cpu/amd-pstate/status

2) switch mode:
`# echo "passive" | sudo tee /sys/devices/system/cpu/amd-pstate/status`
or
`# echo "active" | sudo tee /sys/devices/system/cpu/amd-pstate/status`

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 62744dae3c5f..df0637a49f47 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -339,6 +339,35 @@ processor must provide at least nominal performance requested and go higher if c
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
+	Operation mode of the driver: "active", "passive" or "disable".
+
+	"active"
+		The driver is functional and in the ``active mode``
+
+	"passive"
+		The driver is functional and in the ``passive mode``
+
+	"disable"
+		The driver is unregistered and not functional now.
+
+        This attribute can be written to in order to change the driver's
+        operation mode or to unregister it.  The string written to it must be
+        one of the possible values of it and, if successful, writing one of
+        these values to the sysfs file will cause the driver to switch over
+        to the operation mode represented by that string - or to be
+        unregistered in the "disable" case.
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1

