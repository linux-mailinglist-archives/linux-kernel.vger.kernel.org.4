Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60627655DC0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiLYQhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiLYQgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:36:24 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDF2264C;
        Sun, 25 Dec 2022 08:35:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPUydaXqFMs5YJk0gkbiyD2xyIKfp9ZbgMzGQvf/4adZNdyF2j9OCz5sCGAWDe+/L1ZzaAMpUbAOJ9ZI11go22FCi76cDWnU4sqD0OhbHjE8V4SqGA71A3nIiSOxPDNk1V/lFYO/Ny2G5mw2cXeLg9Mgm2OARvmSfS36ACj2Yg/Njm77xpXE1Q7EKYN671wd/7uZtfFXY1/38E4xktzPtvytDUgeO5I9DTNdR4wI7GYj5wZFYTQK5VNzaPrNBexTo1YqbPgJQ3Kkafm78Jue3kQOL2kJet45OuFHfnbbBSiJMp9RpLtEgHwkakcg8tZublPd9kf+hJiKTZUAHQGT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vh5BIiGu8aWs7ta5xjjRUVc33Mldl/eriqxGSSrR6c=;
 b=ae+z2lXJXaClxQB8GvOSZRYZiOYRyNc1fh/ekr0gfNPfGaW5gGJKtrDCY28T2z/NT6052FXw/1PzHsF4MoHtMU0dZRIDOlidza6ibLaRsvG1j5+t3BZ/HMs+TMiOka1uvLF2x6SvQmDlKeW0H+l8kDfsaM3pUF1ZcKLcBJvY93Huom4rYxi50ZTx2KDmPAKHysCXa+7OKtrGj4CBYOAxHaMX7OA2vA5A2qFd3DGPfdNBPDWbzwDPen9n3gNNauBT677EvoO0ZmUtGaEiqjct87zo7dR0LLYRo7fxh/6PQosXvajSCcOehEjJ6bBYExme5tLq+1isriHjSeXMpmwmoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vh5BIiGu8aWs7ta5xjjRUVc33Mldl/eriqxGSSrR6c=;
 b=F3e4Uiz+pP3/13rwnhVPGrOxTkVlPcO6yfDInxSIHn6+x3tFNEW3GleFTMwAROQACbCefdbWPvBEeLh8py42WW9saukjgAHC2MaH8vWz8M9sXn8n8n7B7sLNYTXnailZRzGvLaRVEuutTrookhfIn/Os3w5AFi7k6Ny2V5ywJ70=
Received: from MW4PR03CA0338.namprd03.prod.outlook.com (2603:10b6:303:dc::13)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Sun, 25 Dec
 2022 16:35:48 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::d5) by MW4PR03CA0338.outlook.office365.com
 (2603:10b6:303:dc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16 via Frontend
 Transport; Sun, 25 Dec 2022 16:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.14 via Frontend Transport; Sun, 25 Dec 2022 16:35:47 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 25 Dec 2022 10:35:40 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 13/13] Documentation: amd-pstate: introduce new global sysfs attributes
Date:   Mon, 26 Dec 2022 00:34:42 +0800
Message-ID: <20221225163442.2205660-14-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225163442.2205660-1-perry.yuan@amd.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: c0915225-55da-48d1-b3ff-08dae696139b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCRWvtrMf61b7tzE10NjAZi+IYgUHIKcXwJ5m8Rl0WaoH32qi4hSdPTNteyN91csVVDCMQRc+EdUCs9g0/d14q3SW61/42AU8Cbi9/hgws+76TDm/mUlMhU4S6Ggr8zZ/CzJWzYSLcQPxjNI5uNtFO2eTfICjeGYq6fGSTFXhzXpBdhQaQZYyd1Q9MW5g5V3Oq5LqSdGAi8YKUGjEacmaSe9um6/adn9jNW76Q6x0ZKV5wH9IJS13xDN4VIywRUxLDr4c34lVUHY53jm9UY5c4tc2DFViSTnsB9eAbizp03p9XExYwg7waHUx3hbII3UAUXwU6bfiO+HxDW5ZsKxPLx03KtHsAKXy4AHc8uSw2y1pDQXNq/NrBgZDpHpOYJYFLIVTn3g++VRZ5vSlx4tg5GNBVUANBl6Tq8Dl/Xj9R3JgpGG1jq6w20Tx34eEsCVBiYpZ1YoBdcNnJenP6ycogyQiZ18yARXnkbWQOkIOnb1ydVlM9tOkvItlvi5cjVNPLVC4Izsu2ZvKNaIdvDTYlIPPxBegc+KInUIEjiuzGtJbjdz4pubvrhDnd79ixz5V7vbuu8KD0U4CI3aTIafWNKB+AH/nD43t8WgSqoluAsNTpXlK8DWmP3Xr6oaExlSt+TEnkRCFKXP/3ZehyNnvQyaRLdjJSYE9EKKknb7fLbLn3ZEdkOd0xydTIEn4hE6JprfO2eACfVGGdowDcdvuFYJIA1nSGg5aSbL6eNWq0Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(2616005)(316002)(1076003)(40480700001)(47076005)(426003)(44832011)(336012)(83380400001)(5660300002)(356005)(2906002)(82740400003)(16526019)(8936002)(40460700003)(478600001)(54906003)(82310400005)(26005)(186003)(8676002)(70206006)(70586007)(41300700001)(81166007)(110136005)(36860700001)(86362001)(4326008)(36756003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 16:35:47.3082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0915225-55da-48d1-b3ff-08dae696139b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 62744dae3c5f..5f6379475b32 100644
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
+        these values to the sysfs file will cause the driver to cause the driver
+        to switch over to the operation mode represented by that string - or to be
+        unregistered in the "disable" case.
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1

