Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74125646E43
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLHLT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLHLTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:19:21 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66324733C;
        Thu,  8 Dec 2022 03:19:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ucfa4za1RZnKCYNkc/Nw0XHgFK6P9onlednDhxS3/kiMG4UWk0gJT0AWT0LJY8zcdGAYgnqvuhnTu4vqhEMv0s9lxJMKbMOcaULhpzpmqCqZ1nMmo7CsOtjSefOhmgxvwtyyIZ02z3H4E3r+4Bh8pEpo/eygCK8Qnqg2JtRZqoPlbBHum0tkkUKnca6s5K5Cv3Keqw5tbaOeP1BZoj7UWVeGMV1Wdu49SD9Apfs/GLg0ewveNVqcMQUUtv2XvoIBPh8EhLexB/KDpZdoJpgDb2Y10Jgz9wg5oq861uyYLgTPo5dP7CC9j9HJNZGOQBWPxZ89S2RfbPVv9EuY0muRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lHyokvSSTNMOUXwriwhOhupYBjdKujambfB0vTM8Zk=;
 b=jD6JHI0cInr4YkEP0FwXDMFDxsr/DZYS26GLH/f5+eBOi0RXQWppx7GEMZRUdCr9oYal45WLFNuxAgKwn/NELT8Gm3t8IMKMLNWpJgEpA0zFCQtO/9cSnzTF+dTA0qH+fJl/olw+cmhnGrRZZZZ7LyjOwYGDex3xwlWibAAVUIdiDZM5SYYiXRh4dJSwPKxtUs6+LYnWoch0dD9VQFUyAQHINzLLliwAFlqV3UFy+AVDBKPw0tTW8+MsVLek87ESMS+x965vE1WRk9oQnv5nvOht/jPdEID9l3Nzh0lT+CK2BICPgXsw2mqROvRhJHM99QvTPD6yGUUTgJTUgHukPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lHyokvSSTNMOUXwriwhOhupYBjdKujambfB0vTM8Zk=;
 b=2FPCgmrJhI2FIs2aUgC5kID3VRHqoxwpDeGCrcwn0EepyJZOM44y6OArCT2XFM0OumpWr0KW8hVYobS4uRXoAbVTccvYogUwofbEjDEruZtmlDyZammX3ahOwYyDJc3YYU49RC3F8gBuQxPKAho2OQlq1S02CHBSSC4XjpUoBAo=
Received: from DM6PR03CA0080.namprd03.prod.outlook.com (2603:10b6:5:333::13)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Thu, 8 Dec
 2022 11:19:18 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::8d) by DM6PR03CA0080.outlook.office365.com
 (2603:10b6:5:333::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Thu, 8 Dec 2022 11:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 11:19:17 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 05:19:14 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 02/13] Documentation: amd-pstate: add EPP profiles introduction
Date:   Thu, 8 Dec 2022 19:18:41 +0800
Message-ID: <20221208111852.386731-3-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: aee08f5f-f542-440c-ee4d-08dad90e0bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddrwh4sDnClz0FI/09rju+9DXk7vxsMpmC4DmhcCkXZCv/9P6kPimcY6zhnnvtUOPs2iIpR3kYaFu/PyLsNPVZKkLyaJXaOK3zLVg4weRzTwShCQn7W5nIaTWcrDUhfCU9S0dnBebhQbVUjG4OXSAuGYuHa7tqVPabK0Pl7rTVeBNkq3315mEgrATdpvb37O8HJ3aD88LoQEycC6QGFIN1JISkcPaOpfVJR2MOheX+uxXDx+/4OdRqBSWWdQelynCKN+pPtMaha0erP1xMr5IlIR/ss7zabGz5rPYbuLHEX2CNUi428ucVP7YtvRI/DVm06u62EWOGfdcfseAhBfcou/hvcttob3XbvrC9f7Vb4mLEu/r+S4/pP7lrd8xeUK5uq5+WdDauuc4qFhBs2cCyN2JOaCZC3sGL+DGLWT1Xhde+p1lLxQF1VXkFNskMCCz5uRlHvSwg1ET7dl7BWhiylscYuOwWAm5NJVrmpd0IgiBhEo1p1I1zZtcTCZpK1i9Du+mYe/cBgrBAR5J/fsnhWexloBZ+uPELeDtLg2wQZaZrYRJm1vk8XNOZsnfGttCRbS93Q4iWuHIPbZFgWB3hw6M307DKM3B5gPDaMeXa3DYaKgulo2VLJCeaU9iqmOVCfSL99Ljqd3d5TUHGERP9fQTO98/W3Ub8Er8LseVeVrJaN70tmiFC5LhgAJAmIEE8CAFqPGvEhLIwusGGgH7nzPcjttvodEUO1Kjw0oy3U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(7696005)(6666004)(26005)(336012)(54906003)(36756003)(1076003)(110136005)(81166007)(40460700003)(36860700001)(86362001)(82740400003)(16526019)(186003)(478600001)(2616005)(40480700001)(426003)(82310400005)(83380400001)(356005)(47076005)(316002)(5660300002)(41300700001)(70206006)(70586007)(4326008)(44832011)(8676002)(8936002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 11:19:17.8608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee08f5f-f542-440c-ee4d-08dad90e0bef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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

The patch add AMD pstate EPP feature introduction and what EPP
preference supported for AMD processors.

User can get supported list from
energy_performance_available_preferences attribute file, or update
current profile to energy_performance_preference file

1) See all EPP profiles
$ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences
default performance balance_performance balance_power power

2) Check current EPP profile
$ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
performance

3) Set new EPP profile
$ sudo bash -c "echo power > /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference"

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 06e23538f79c..33ab8ec8fc2f 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -262,6 +262,25 @@ lowest non-linear performance in `AMD CPPC Performance Capability
 <perf_cap_>`_.)
 This attribute is read-only.
 
+``energy_performance_available_preferences``
+
+A list of all the supported EPP preferences that could be used for
+``energy_performance_preference`` on this system.
+These profiles represent different hints that are provided
+to the low-level firmware about the user's desired energy vs efficiency
+tradeoff.  ``default`` represents the epp value is set by platform
+firmware. This attribute is read-only.
+
+``energy_performance_preference``
+
+The current energy performance preference can be read from this attribute.
+and user can change current preference according to energy or performance needs
+Please get all support profiles list from
+``energy_performance_available_preferences`` attribute, all the profiles are
+integer values defined between 0 to 255 when EPP feature is enabled by platform
+firmware, if EPP feature is disabled, driver will ignore the written value
+This attribute is read-write.
+
 Other performance and frequency values can be read back from
 ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
 
-- 
2.34.1

