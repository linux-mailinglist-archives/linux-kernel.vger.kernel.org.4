Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3018646E53
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLHLUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLHLUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:20:16 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66014B745;
        Thu,  8 Dec 2022 03:20:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUN3AEoEWt0t2SaIgU8m4Mvt0N796svrWuJ/lRJyH7X7pPPVNZ5BjTlPCyAs+HufAYLhMPcABcpCTBwD9wRskVy2F6eTACzqr92fk4sf82xoPE/Mf46oLtFKLFhC7QdWlAi+SQd5lFzaLGwn9R26pBxfNe22iuhgtdSMJSmSGygnz9c/JfqeZrk5t4RvUqZ1bFlpXoy/jy8gOkaVmbXpHLtia6wt0T4YLxbCdY96qW8ktx4pbh6E3iQJ71abSYEYvusBubuwTp/pHV351aADYAYuyGasG4TgU/ro6opdNP6aFvvrnRJsYh8LbtxLXNJOv+EU9hxughoM3FkdDauy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iLNwCDA2FPuXX0XbspH2ZQmIiCfHs2C+UB1BWc0KDM=;
 b=VqsO43nskzXg8YuMuc6HaFZ1kjmrjDNXNWeKLFwk9xXZQmhxARqkbGMw5eMwokPKGommNp9ezs/pGQqr3FNWMgI/rSg27ikVF/U1H6SsN2ajsbCrTZ3ukRTaCJmpiDkbuIU0zfBKdsN8baUiLlBBAuLChb1eMOsnjVR1mKgZHVc8tnug0QqSQRXTjT08utBzsl+fScWV0y6FwcqO9bGMKIf04VECo/Y58Bp2L5izQdLPslETZq3TRcV4fTV8YQuCmXVYIcn5Eiv4NybZ4SnXFILt/hhyHG6T9ZGznM/ZRZ5dpF21hNAf464bs0Pn2RmVyw9SjbkhLRGqroksn71NXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iLNwCDA2FPuXX0XbspH2ZQmIiCfHs2C+UB1BWc0KDM=;
 b=a+tf3Bd8xxf0f0ppycA5WlefalOVZeYf7I1aLWeW+n0C24tEXnusVm1hkr6S+RZGMxq+CIpCIEOWnc3fBkMQiAJcEIOKqXOX5/J4oRJBrr4e6uVJtvXCP4xGV9SJ9FW8gFjTejU0ibGfxhSRE4r7nzlCdp8KOhRR0sW4NouhZkI=
Received: from DS7PR03CA0153.namprd03.prod.outlook.com (2603:10b6:5:3b2::8) by
 CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Thu, 8 Dec 2022 11:20:14 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::c6) by DS7PR03CA0153.outlook.office365.com
 (2603:10b6:5:3b2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 11:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 11:20:13 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 05:19:58 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 10/13] Documentation: amd-pstate: add amd pstate driver mode introduction
Date:   Thu, 8 Dec 2022 19:18:49 +0800
Message-ID: <20221208111852.386731-11-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: 993c7075-13b4-4aff-0130-08dad90e2d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sxJfxVm7/uct5icJBWGHAlMeZmFQG7eorGIzEeBBAjqhaWf2T9DcSIlqiRfN7hgzSLEGoW/4AEGPdgqfRCAaJIDjSGedCbdW4H+rH1CvXYyvbw7TFPbveErmojqzLEzGNfY7usi8YQ14blOG0wQt13STMKcgdd/h9BQYRp2pqc13s2r1XLsjF8j6b5LLIdFuy8i2Sy/BbtZTnogQontlgQReBuV3KvcsCwuN3mkUzePWmTG7f6aW9MIRox0CG/cSOK2+nXUSA5IsnnDPwntDIUCmXegVmk2q+ImxGwVmeWvS6vEo+cLCQA2UrneQ0X7mboH+e6aSr73d2/3Xm1DyP5piYnskmNUYezXJmZgKRzSdnVR+bHgstAb86DI6Q9veFoWNRbAFfjY8ZdCKW67nw0WHS4EDSmpHRmOSoK7+jITCRSy/jVmeHrdtAW3WExZsnHDD9DQ/YBA7Cg6ml519E6xJ5ms4cj/ti9GxjZXn6T3hJ84brp6drX9yyea6ta/BZjsBhgcsOn2ErB+gqb0fCjAyIDl/wQZixzvJ0k12kcNOsbHEJa/HNF/VAaaqx96MDAaHyXEx6h38ggh+JJ9BANEh2Txx+gzRLYItGbKksuuBfX25gAy9Z7bAC3V5goDtAU62J+88NO/ykgvPpbbhh+DpJ6YNkPHqXh+RwwvSHTAADkuLF8mZbr2zpgwr5Qr/6J/NcGRtHwp16O1x/CXfgwSXTCGDI++C+bWQxivaJm8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(8936002)(81166007)(86362001)(356005)(44832011)(40460700003)(41300700001)(82740400003)(4326008)(2906002)(5660300002)(36860700001)(83380400001)(54906003)(316002)(110136005)(70586007)(2616005)(8676002)(82310400005)(40480700001)(16526019)(478600001)(70206006)(186003)(6666004)(47076005)(7696005)(26005)(1076003)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 11:20:13.8749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993c7075-13b4-4aff-0130-08dad90e2d53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338
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

Introduce ``amd-pstate`` CPPC has two operation modes:
* CPPC Autonomous (active) mode
* CPPC non-autonomous (passive) mode.
active mode and passive mode can be chosen by different kernel parameters.

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

