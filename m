Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B168645DE3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLGPsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLGPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:48:50 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116C924951;
        Wed,  7 Dec 2022 07:48:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJQ58hUq/+1/pxI7ErCcqkE927hd5FX0Ml33ngNiN87UDTeiFjbdWhQJ2uYZ8NGP7Fed471036pWonAjPXqomk5h/MK1Kwdm20NqMBJvTTa54rGyXcvoGTyqjGZGzmoK4JvlJ6bl/HQF23U+vhe13OU66GKZYV1H8bc05XF5JatKeWiRtfZFR6NAAxLTLfvmy8pjxwcEwNxqdBdlNcOwo8GNKGMr9Q5U8KjgeFj1rVVZQjvrPH9OYihUO0TDocX9uPtSeD6f12cLuU+weMmkDPJjJebPNzWy302vbs5c2JPxnZTIA1lpcVXkuot2Q84bqvjYu3cFsQ4HfvDZc4NrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLcjDIeSEGypdO8KnNGuif8V4VRy6SJ9CgWUnp/jg/4=;
 b=n6H+JmS8mRObsBj57t40exPEeTA4pIVx3MQg3r5jcqhshwwhx52bQEGwaKg16zVo48gY9TYEpSDZSDwDJ2Bj5Gwgx0kRqEQXH6QRsoUZOV/gS+ajePBocfWkXDWuF72UAcry+8YWxnd14BltIQ9f/ZvMwRq0wtRQ5u9kEwOAmecniuSiSQES5J+kMngtsbsefATZx5c+MHTLQ++UGTrfgqnxjyBkgwAMdbdDktdTmT0OM4l9SuHASNO0Ql/1cqwU28vt/QgDczsZXMyDbl/oxmH6Yor7rBsXU9eSXqUm37lHMY6QT3zG4BG9UEYtXMNdkYSGuERkor6vVONFmamPug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLcjDIeSEGypdO8KnNGuif8V4VRy6SJ9CgWUnp/jg/4=;
 b=f+ih5tvv3eUK6HCr4a7EcF36N5vP5Uec2fwNtFKtOh5oxA/M1NO02XmkPX9B5Yii4mf/oZiTPKkJXvhNNTe6Rvv7zM7GGk69BR6USUIGFjj6HTpZcUJn9NdkFh/1Is45RFflQ+SXLiFb3OZaD9CKNzVB4zDHFwEcgYXxrM1hg8E=
Received: from BN9PR03CA0630.namprd03.prod.outlook.com (2603:10b6:408:106::35)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 15:48:44 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::f8) by BN9PR03CA0630.outlook.office365.com
 (2603:10b6:408:106::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 15:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 15:48:44 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 09:48:40 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>, Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 2/4] Documentation: amd_pstate: Move amd_pstate param to alphabetical order
Date:   Wed, 7 Dec 2022 15:46:46 +0000
Message-ID: <20221207154648.233759-3-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|CY8PR12MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: d8984a30-00ce-46c4-1fba-08dad86a8578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDQqxwG6zV78pDDR6l9li95NUW38E7v9Nhvh20ntmCvYP2fcZwJu33RsJ6bMMdDO0QtLQVeJBoiLi2cVP3rRS/hlXo7aH9xe2AT03WXsBa004akPGClZZMasayQPQogna2PzgYAieBZefjJGI3idN4N2+JaiSgED6tgknOiDfGuV4NpKcvflADKG9/MYTdUDWKZPimazSfaArU7my+LwNQrEUv3ckAcbsHjeyBzqdQsAeJ5jDSsuaqgvtLwt9GgCWAybG/fIVBbxn/CUY5PPflYK+EwSKB2MRFOxoNf/lEOsXYeqzcKfkKf1cn2j4niKGX2W4A7eS0qz/grjdnfZuVBnpAn5RQ2ExPUrI+6ylK8ZvddWniRQA5u3pnGaGOedH9GazS+97iiw7mZJWIgNPjkRBIGpSlGXNZT6Duai9teduJjI38k6Xx3VVG5LJdjQZJYSCdxZsVK7XBezK1diXrLDdrzAJygJAVD8yUA2ESZpoEZdNQLSlK/KrAj296k14CIRZEUdZWQZRmbmwgc+EoGIlZQpG5+Iv0BMHQfdtSaeTiEJncqTPdYySO+OZfJSStfJSoQnLzHN2lstx935Dy/k2ncnenER6ZBLrKabJmC2ei/O4O1gtEC2kBcipx38jr/XEWicA12PjwyqSI6AO9YGsVsgIhW97d96ZO5GCOetGuWEc2IUZMxvonnVOSSO7coBtGYhGXNtdXxW8utNqS0WPTth0FQ/aPSKmp6j0+s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(316002)(44832011)(110136005)(82740400003)(86362001)(41300700001)(356005)(54906003)(70586007)(70206006)(82310400005)(47076005)(5660300002)(4326008)(36756003)(8676002)(8936002)(426003)(83380400001)(186003)(1076003)(81166007)(2616005)(336012)(16526019)(40460700003)(36860700001)(26005)(7696005)(40480700001)(478600001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 15:48:44.3409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8984a30-00ce-46c4-1fba-08dad86a8578
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move amd_pstate command line param description to correct alphabetical
order.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 .../admin-guide/kernel-parameters.txt         | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 75e57afba77e..143a38ce27e5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -339,6 +339,21 @@
 			             This mode requires kvm-amd.avic=1.
 			             (Default when IOMMU HW support is present.)
 
+	amd_pstate=	[X86]
+			disable
+			  Do not enable amd_pstate as the default
+			  scaling driver for the supported processors
+			passive
+			  Use amd_pstate as a scaling driver, driver requests a
+			  desired performance on this abstract scale and the power
+			  management firmware translates the requests into actual
+			  hardware states (core frequency, data fabric and memory
+			  clocks etc.)
+			guided
+			  Activate guided autonomous mode. Driver requests minimum
+			  performance and maximum performance and the PMFW autonomously
+			  selects frequencies in this range.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
@@ -6959,18 +6974,3 @@
 				memory, and other data can't be written using
 				xmon commands.
 			off	xmon is disabled.
-
-	amd_pstate=	[X86]
-			disable
-			  Do not enable amd_pstate as the default
-			  scaling driver for the supported processors
-			passive
-			  Use amd_pstate as a scaling driver, driver requests a
-			  desired performance on this abstract scale and the power
-			  management firmware translates the requests into actual
-			  hardware states (core frequency, data fabric and memory
-			  clocks etc.)
-			guided
-			  Activate guided autonomous mode. Driver requests minimum
-			  performance and maximum performance and the PMFW autonomously
-			  selects frequencies in this range.
-- 
2.34.1

