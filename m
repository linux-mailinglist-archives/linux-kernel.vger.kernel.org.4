Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D98B6507BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiLSGnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiLSGnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:43:12 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86164D9;
        Sun, 18 Dec 2022 22:42:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lo5To0TfPHFwbrhr5X6iCy95xtf6KwP6c8mSP10zIu+S4Lh4LsNhlSQPxT1U6R34Y+DrocWhy2EwFmiatcjD296G8UfTLGSDKaOXwML4NVkAVu4YJcm4EeyMIzMjbGb9XkGXrJaEgnCULH6IFECvvnVfkci4pJeshzB30LIzS8vE4tPtsQQN7vZYHAcI0r8Hu9besLmydsUgoOeRZV0EYFLi9jO4kROjaY8PgKTYETbrIFvmNyUcqf/wf3lk/PQpNl9+vKOuvqvYvw9IzCmOnQkcO4Qb4Kg/3MAfS9lYWg3hUjXVxgGQxtTg87ojQxCquce4ZFJeJVpXFLeEoPXjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxSUIAACm1gLPreRTTndDSZLb7y82ILlUvysupIkp7M=;
 b=K8M4NHCieIJH77MRZqWytr0xcXbmejTdOTYpIB5iiZ8kP27jPHQpFYOKQjXYaIYc79Iy+H77aFAvGNel74rQOCJQIeHuY1i92MQpzNdSQYqcI3+fWmyiwHSNlSM5T+e23CqOEDDbuAAT4pHXb/J1hm9Z9H2utpM0cuvA9pHWcpxeF6E2HjQOCmd5IKjMJP/XcXQGnaesgwQemwYyHg168t1Z6JcZoxHXspFcqmqKnS6xoWofrQozd3fkMk/8+r9gvAMwEXfVAqFG9PA+ovtdGIxWONoqn0TrE3nObBMxiwUlLscPc3SzdACFzj46WnWKff7q9qDSw/mOsgDGOVvJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxSUIAACm1gLPreRTTndDSZLb7y82ILlUvysupIkp7M=;
 b=l72z9aoA/gSbe7aRt/2drrkdoG5B8wpahO1PooRMrn+btsZNB0PHBXmS6h/Rtq0vJjqpU8TgKR/EiXGbUsP2XglIFEOKJvkt4CHQdq7KcxSKx93ymoTP5Wwhv62QItaR8DlbhpyOLHbgtB/qZiL2wjgJW2iHCyX0ya5YmsyEsEA=
Received: from DM6PR08CA0012.namprd08.prod.outlook.com (2603:10b6:5:80::25) by
 SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Mon, 19 Dec 2022 06:42:32 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::a2) by DM6PR08CA0012.outlook.office365.com
 (2603:10b6:5:80::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.20 via Frontend
 Transport; Mon, 19 Dec 2022 06:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Mon, 19 Dec 2022 06:42:31 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 00:42:27 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 13/13] Documentation: amd-pstate: introduce new global sysfs attributes
Date:   Mon, 19 Dec 2022 14:40:42 +0800
Message-ID: <20221219064042.661122-14-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219064042.661122-1-perry.yuan@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: 634f4576-0d32-43bc-feb8-08dae18c347f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAtiWyiGcaqrZm8Z0cUyY6trbuSVAcS5MmOgGNoeiP1Efn2VbUKJGDjQqkf3baRX01ze0HuEEsrntcc7Z6b8K5cqKv606aIJd7E6aM6QHzh3mKSjscdtayMej8WWx/UW018079Rncp+QVK3MpEyQflSm3wpjS6aRO50e3BWXEUHtrrLCNcMuEV15rOUrpzSl7uusg+a2/y+KwIsoyz6bgi2kJ0oW4o00PHLAHsn09ZuMcn4ZXVFJmelpY4XzmxtRaI/Qo5xkx3YV6AFXA4EPmeWpgeMKbndfGuJP50y2sgV9AeGsBBeXs80X1wKmsVSbe4+BkIYNJAdb9kKALm7au3IrFzzA2j67w5Rm/gakMsW0v8bXG9suC0g72QbRbY7NQwI7Oig+698Rgy0CEzX4aSdxeuAiJnh3geu2EMiIloPbSdkmbfhesJDIqdcVgYn6i4r6LNMFE196nY+dSQgA7cvZkvP0uLX6nPdaPhrXd3rWdWQhFqxdPEypA2fTLgKZXZZQ3wUw5H9yWxeDcuZZO/9sKLpqP30juKc+oeWRdcL/e3M/1Z3Buvm4K+tcr8GaY2KYEH2IzRUAtSXJIPdOjP5nb8COMCD5LQlrYlM0n3PfJ77BxXx8Yutj3fKGrDNWAm/a+9nfoDZy05XcT9SLHsO+PNxxgvqkNYpvXmPzjsLgZ4ADoY2EcSuXlfL41dVKL4gAjyOnEETn9GTCY5ePGOKBsxjqVY6qV/SuNoL5kK8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(2616005)(86362001)(82740400003)(36860700001)(6666004)(40460700003)(40480700001)(16526019)(2906002)(336012)(36756003)(186003)(26005)(81166007)(7696005)(478600001)(356005)(8936002)(110136005)(54906003)(316002)(70206006)(4326008)(8676002)(82310400005)(1076003)(41300700001)(44832011)(47076005)(5660300002)(426003)(70586007)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 06:42:31.8039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 634f4576-0d32-43bc-feb8-08dae18c347f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
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
$ sudo bash -c "echo passive  > /sys/devices/system/cpu/amd-pstate/status"
or
$ sudo bash -c "echo active  > /sys/devices/system/cpu/amd-pstate/status"

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 28 +++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 62744dae3c5f..f3a8f8a66783 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -339,6 +339,34 @@ processor must provide at least nominal performance requested and go higher if c
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
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1

