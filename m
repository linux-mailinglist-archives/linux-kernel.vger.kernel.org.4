Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F5A6A6F05
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCAPIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCAPIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:08:48 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F9BAD28;
        Wed,  1 Mar 2023 07:08:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YccLngqogFwb/5oqz32urRbXCqEAIte3HBPsSroq9qVLLbUOlfglms/q2b6URLUkWipRRWhsXLvGHGA5BNuh+M0ppmkbSz7ypm3LfXBcKyLzIX50iPcj6piO9InWe3xInuEqHctKSSTZ/WdcL4DXUO4X5qMBxWHQu/aGO1tVP3zKf7AfFY/oeW+xJHPrzS0h8DeAXBo2U0oZQmzJdG6EYDTICGhSYVE3xZvyfbCUHM9XbwtD/QrcHLh81tKeVACIKnOlOiVtyDRkTx/7MRrvLRxE9I0twC35Or9Sh8Fotawtm2b3DyMd0hWwC3JWH+LU032pizVBQsJdOayHmuzVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeVPxDh3038mdHDUFMduxjlhkxvHBqfUyEfRQrmaSF4=;
 b=J6fPqhnnm1Kv18GyejSd0wmD2c182E/UArhwZHRqxrSuDYvtIRXo3oQGQYopAe0csCVqC56v1ivtehjXaW+Xso872uM4EgAsqp2HsIah4DSdA0GcLzrHr1oObBPzWGfvHMcjqKIBekBHfB9BAgkYSiOPLcOxhPIzIhA9vCPaavVMkvQGv/hO8xf4t5WMV2kbBBTrIqrRqSNkJu9Ik/EUE128aWsdLgp6FKc40danijMtWSP6dhO+gmpMUD2zBAhL3YDX85lvTPddAjabOttDzAoAEpCSN6++ddb1ry1fLVSnmtckPn7cljKUbIiojmCyr+UwAJAWZ0N9w2RcLaJkug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeVPxDh3038mdHDUFMduxjlhkxvHBqfUyEfRQrmaSF4=;
 b=RTOhgqfWY+MGpRtZqjYC+/f0aXAG3ZIdbwe/W4CDesDxyIGreEw138AK6vkWSBdlJSqY0DcAPyFOwX+Fep5U1/y24kRP8AhBjDJhsYZLC3dqEG+KlgfLSg6zYJ8CqqmJloIHtL1lDNOfVDB/Stb91/cP5QsRBCPpsSFllpIYndY=
Received: from BN9PR03CA0064.namprd03.prod.outlook.com (2603:10b6:408:fc::9)
 by PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Wed, 1 Mar
 2023 15:08:44 +0000
Received: from BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::18) by BN9PR03CA0064.outlook.office365.com
 (2603:10b6:408:fc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Wed, 1 Mar 2023 15:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT111.mail.protection.outlook.com (10.13.177.54) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 15:08:44 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 09:08:43 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] platform/x86/amd: pmc: Add a check for PMFW version on PS platform
Date:   Wed, 1 Mar 2023 09:08:20 -0600
Message-ID: <20230301150821.9791-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301150821.9791-1-mario.limonciello@amd.com>
References: <20230301150821.9791-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT111:EE_|PH0PR12MB5420:EE_
X-MS-Office365-Filtering-Correlation-Id: 668f608d-6c27-4877-93fd-08db1a66d9b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qf3fzcEm8PBth74GtMvNN5BnqNg4idDRmSUCN/zkgKjU/VPJGlBXyOsIM1hsuWYPko+o0/F3dd1OQ0HeXcSiA6Ah2liHYvQVG5eIVPpXSSNbiwdVhLB6khBJMidU8c3itB6X8HftEA8OVtC4T2I1Yc1SsCyATWhKKpbL+AgRer69zXUzB5epKfUKHlZL0IKz19WbCPyKXBI2m6koYiZKT7kIzM1Gj/5yBT5SpP9nChb7dwpeSTZVKeQYhN5LaDsSsxdiUbgMh16w90Oa7RmdUQ/1Kp4o7v+f9/8dvXOjsfams/mbjqRbn8hO0DyKE5YE5rVkkuRbzuZvs9HUtq8oVc+5sWWgFG1qgSBLnm/yeWFPJcfpYeufCZG/DOOoqtssVWzGRtVeR0Irjt9jmNLFG+70haYa8wJbEd2Q2N20fJCRnCagT3DLzKKoMqJ/Yc9YMpN7kIxyvQ4rf9NVLpFEuGq18ICInDXXjy48BCmIRojaSX0b3veELh/0Ch0sluhXF89+tpYZDxo4mhhVIeBUKNsCBFKggl/Wh8cSqoGJ4qv1AOq6xc3JCha0gg0oheU0kfT4FE3/r1zYfLyEvyf1hFOqqnxUn/j0+/NUypBmFLyq+86ZYGSF/v44RT8vV/Qa3CBsn8lk6HZlkGvQ6Q6/5486+JjbUMJalJfDyTrK/bZi9kmK+Gqru8X1QHEacFKQWvXiUI1AH3pW+S2/MbOgOTV4gV9U0H8c0CejhDlCis=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199018)(36840700001)(46966006)(40470700004)(83380400001)(82310400005)(336012)(54906003)(6636002)(2906002)(2616005)(426003)(316002)(37006003)(47076005)(16526019)(6666004)(7696005)(26005)(4744005)(36860700001)(81166007)(82740400003)(86362001)(36756003)(5660300002)(8936002)(186003)(44832011)(6862004)(478600001)(40460700003)(356005)(1076003)(41300700001)(40480700001)(4326008)(8676002)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 15:08:44.4261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 668f608d-6c27-4877-93fd-08db1a66d9b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running s2idle on PS if using PMFW older than 76.49.0 we will
trip up some bugs that will lead to freezes outside of the control
of Linux.  Set a guard that we only can enter HW sleep on 76.49.0
or newer for PS.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index c42fa47381c3..e7c6c06b2ccd 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -778,6 +778,14 @@ static void amd_pmc_s2idle_prepare(void)
 			return;
 		}
 		break;
+	case AMD_CPU_ID_PS:
+		if (!amd_pmc_verify_min_version(pdev, 76, 49)) {
+			dev_warn(pdev->dev,
+				 "hardware sleep unsupported with firmware %u.%u.%u\n",
+				 pdev->major, pdev->minor, pdev->rev);
+			return;
+		}
+		break;
 	}
 
 	msg = amd_pmc_get_os_hint(pdev);
-- 
2.34.1

