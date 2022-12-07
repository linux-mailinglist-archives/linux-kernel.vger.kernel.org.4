Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DDE645DF9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiLGPul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLGPt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:49:58 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F9E5D690;
        Wed,  7 Dec 2022 07:49:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpIAnjDJ3WjWy3BSS3GMVXOAccUUMZ/6OswVjHcW5rjWqJE43+xjIOOXku2Lw/aPlIpMQs8WhQCu/EYgiJOoSt0OIR4R7Et292ume416kZ9f0rg+cJOxfl+NPjRSUj/X6zyXBKZTsLMxcIUrZwmGeCO5GMh0CyzNmWa7Bk6SkRS37fr55SrCVj7Jv0KvupYKJn4S1i2hwBCjcVSDN7+/Znht9jCKx2Avnk+7nsGcW4OJX1ydOM5zaEP3a7OXnRQj0JkKD37ZR/3XVCFJB99yoQDvP8xCdtMEDJCHrSq5hBmPSbYmipqM42XAM1jghPKN6AOvFkBoBXFXvtaHf7mI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdTCKrYg4Vocmoj1X2D2pS5MTAwtyjEWaMTIrs2/9Fs=;
 b=mdZk+yT3heE2Ux+tT4WakgZjb2ATb5yszd1IDCB28y1bKlwKid8UAS4UrJpzbz9K3NdpV5vdMy73Q2EVlNlfNhhFAIhRrwL9z9+eO0rTy75kRqDSq6o8HID7QJiBuNrASEVSc9EWIsOqn/uyEyVV3IprWKrETtQMs8mPh2V5Hebek0DHUBEmZrZO2vbK7hC/6yp3fg9ApoTn0XP+44fPRUMOt/qmwdEBvkaz5f//dU4Pz/zbcWrgVwVm1pB+fnBcdgOg7mkb7rawJ4uXqr5pPjX3/biG2Cp2orNYF81i9oluXz1MvI3dyN69ChksPamNZNMX9VgLEYb4Pe+8ierIGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdTCKrYg4Vocmoj1X2D2pS5MTAwtyjEWaMTIrs2/9Fs=;
 b=P9KQHibSNLgJYOpp0vP13j3fi6ba5PhuZuk1o9iGYsBEXhxqiU4MFnJqI3jeJZOF+okwgvFXTZDPGVGzgmPh/pejDPRHJhH9GjjZWGMlZ5GNV6noJFA5pWi2AQQ/cCJ8omvF2G2n9kb+cmpdFkOOAlxPW3TRIAYE4n4lXDrnfVo=
Received: from BN8PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:d4::23)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 15:49:56 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::b3) by BN8PR04CA0049.outlook.office365.com
 (2603:10b6:408:d4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 15:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 15:49:55 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 09:49:50 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>, Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 4/4] Documentation: amd_pstate: Add amd_pstate state sysfs file
Date:   Wed, 7 Dec 2022 15:46:48 +0000
Message-ID: <20221207154648.233759-5-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207154648.233759-1-wyes.karny@amd.com>
References: <20221207154648.233759-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|MW5PR12MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d2e681-5b36-4222-592b-08dad86ab00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhR5+KGNOJ7yhq4E1zsbMURCoDRnhD4Bdzjrhoq0Ztj7hO/R88xYSu92oNhtQ/iZOPVhqcdb3rE/y1BPHAaCiMAehid60iF9ZoTAhbgHmMeF0obn2zCZD+i98paIjpj2yEEcRCchLxNPhWfQvihbpdTlofHtfhVE+Hj9s/j43pKqldtllUaE9/B+RZ5r3MzzcOOCQGekbKrbW0r4E7PG+x2L5yLSiC/cOduRymY5gCkdyOlAVF2jml7DNeLQkCOBvu2AYsBmiMSFCqjQT83v7uFhCDuwyFmj7Vp/o3zekD5uPghxaV/1G2PZo5ZBxhTAlt12GMTSHA+ZBsbMZipSJPqiyRuppwEPZH+ej4y8wydk+OkWmRt/KBfZkvO8QhfsCitSKvnnx+2Og3diS2smU5PtgnMn0qC3wnUHJUsv3m0HVQ0IDDUE12ys5iN59GTc1SO9+ARRLboNs+A7BXiqo/HUJt4xdPBkbj08nirLocGWkCFj4OquCLPs1K4sTGtkZTcDjKVUnQyhRTWIXJpXCbeYYWJRYD38ijvgLJAOtSKasJnYa8wUN1u6R/XQwdqxFtZrsaa7jR2KwFKk0HSD1wYlBOK1SCZ/90bR1HmyyRPb8xI1giBwUByuv91KiG57Dvl0iEVDj+KX5XHgYRShhPTTvGdI8wnOPyHtMKYCVyHdM4g/FU/P/hud0ojVukWnbxc6oc1RmAR4x+5AhklmwY4Q7NDwurVTx05jrCVdW1s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(478600001)(82740400003)(36860700001)(356005)(2616005)(2906002)(81166007)(7696005)(26005)(44832011)(5660300002)(83380400001)(82310400005)(47076005)(36756003)(16526019)(336012)(186003)(86362001)(41300700001)(40460700003)(426003)(54906003)(110136005)(316002)(1076003)(8936002)(4326008)(8676002)(40480700001)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 15:49:55.7544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d2e681-5b36-4222-592b-08dad86ab00b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for amd_pstate `state` interface.
User can see the current state of the driver with the help of this sysfs
interface:
  # cat /sys/devices/system/cpu/amd_pstate/state
  # disable [passive] guided

User can load/unload driver with the help of `state` sysfs interface.
- Load driver with passive mode:
  # echo passive > /sys/devices/system/cpu/amd_pstate/state
- Unload the driver:
  # echo disable > /sys/devices/system/cpu/amd_pstate/state
- To switch to guided mode:
  # echo guided > /sys/devices/system/cpu/amd_pstate/state

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 06e23538f79c..4d3783516ddc 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -265,6 +265,17 @@ This attribute is read-only.
 Other performance and frequency values can be read back from
 ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
 
+``state``
+
+``amd_pstate`` also exposes a sysfs interface to view and control the driver state.
+The driver state can be one of the following:
+``disable``     : indicates driver is in unloaded state.
+``passive``     : indicates driver is loaded and currently in passive mode.
+``guided`` : indicates driver is loaded and currenlty in guided autonomous mode.
+This file can be found here: ``/sys/devices/system/cpu/amd_pstate/state``.
+
+To switch to passive mode: ``echo passive > /sys/devices/system/cpu/amd_pstate/state``
+To switch to guided mode: ``echo guided > /sys/devices/system/cpu/amd_pstate/state``
 
 ``amd-pstate`` vs ``acpi-cpufreq``
 ======================================
-- 
2.34.1

