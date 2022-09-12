Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122C35B5F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiILRYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiILRYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:24:06 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BC13FA14;
        Mon, 12 Sep 2022 10:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0jCeeeFB5tAJdBkaaxmpvlvu0C/9QVAM4crXhfoWIAEC7dSYijCXYY7umczMm3F50frQ4xYngsejDR1EkysWToRZjOvk6A85JPe+4MpCq6BHryvmVarImWuFOdZHEv5bgwrjKa42GtL8oOTBSOWR92kvmk3Z42owj79vcpjT2u5PcSSBzOcI2otVJy+qUD+IhsXbNa1baaRF36TAg0nNIYOsvubUgsp826zqXSNbkILxkPC4T7VixpnXsLXwn/qzcjwBfS2L1pwMahIUUP1Gay1K+QsGbbLhMz5Z526YbE5FAKnV/VQY5TdwSViN66hd6wTWpgAYzwVE93YoevkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T4D5tSw/47yKHcVLVUaL5vGiwVfH+pvrRiX3aBpFNU=;
 b=EVHf0bpiSGLAUsBwCXjc/iqwXSU4WBPZz+6H4o2HSI3akVA9gs0k770ecXJntAD63r3sTnN8J2Df/txz0yO7JkUkcSg+XfVX6KgQHU+CWZoARdeoFkc0cUAMA2wJoBss6nVpVEWE1hzniv8n5/wjtj/pn7Ppv0YroPGgtUnTtEPPE5O1fMrKeG6yB44VF5eJx0pWCno3j3xDNLthoaGS4LPrKZ/1E/jgR6ZzVxxWhpVUxNyEi/17okRJprcZC5LU/5kvQ9R76FLuKKfDYVs8IDDLhg8XqTh81oPAJpUY9Gs4RvrOqLHCsfOVchoz+dBMM0HH9X9VOFGG/gRU2SRQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5T4D5tSw/47yKHcVLVUaL5vGiwVfH+pvrRiX3aBpFNU=;
 b=1jvAwqm4c5eYmn9Nu5N5/V2FsF0nKE2RCGlPM9PgLeOCrT93qtx17V3vSeNifyz/DSIeCq0Di48T9uP/zSPmhLWf8jtAl6x1TcFuk0F+H7k2W2wcNSUGfsd0Z86iK5YcxEnxcP2eVNKN0PHNzK/QO7eMcmEu6aIjSKQWeqM7NEs=
Received: from BN8PR04CA0028.namprd04.prod.outlook.com (2603:10b6:408:70::41)
 by DM4PR12MB5037.namprd12.prod.outlook.com (2603:10b6:5:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Mon, 12 Sep
 2022 17:23:58 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::f2) by BN8PR04CA0028.outlook.office365.com
 (2603:10b6:408:70::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Mon, 12 Sep 2022 17:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 17:23:58 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 12:23:57 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>
CC:     <catalin@antebit.com>, <philipp.zabel@gmail.com>,
        <travisghansen@yahoo.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] Fixups for s2idle on various Rembrandt laptops
Date:   Mon, 12 Sep 2022 12:23:54 -0500
Message-ID: <20220912172401.22301-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|DM4PR12MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: cc45aea3-2966-4c66-0c15-08da94e393c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7nVAyhWjhaPS5yLxatpRgl/bT990Sq03Lnwjkxex1STQGrl8AEWBpbhlDqhYCEmaouJBl6kcl8ACiu0gNe5NJx3GEC0BarvWFieqVqjIP/aGkwJvia9jr4g30b3NaIH+BFkwds9r1MMiqnmf4+qHpkUKrjLXDSAjfNLrXScynfWNjun79pC+eEjBzlmozcah3PPCstSNlZiNAhN4bt2i8nYLu2rT33RabVG2tV+pf0jQZ2naDQG7vh4CPchP1R7le6Y2EBlH9RI3VA6Dxi5SNZa8OrHzQZU98DDNFlfobp2aIxZzUMEzy1XrG4/y+R46U+c+H8v4jkRepYg2jDTgocGdoQKSbNcX/wy3SkheJqvj6rcdkGkZ4DG8haAdZQqNM75NxbpxTt8fyi5RcILwqV6vt+szQ3vv63fBjHKSjHKHOQ/i3OdRfpekdGxJgiuoYLFs/27/N7PneUtxpuNiF33L4EwvE3Q/8er2qwU+gE5fTfqbxETw+0FT6VQ6aobK3kualBOodSkxZ4QkyW1/CAGEHEOB257wMUru9QvN2tbFOcZrWuKHo5+Z+ozO+PHlCnoooSTp4Ha8LjiyGKWzO1AGz/c7h8CaVzIKQP+1sTwXEySuKv/79QzxF1ZZzWN9YKhllnI5I5OCQ3O84XljfRRDqYamVEB7U1xk5MjENuDKvwtEW0sjEjnx8/5w8BIRUypgEQbzSa0mQI3WWPqNMAT/ftVFCD1NjaEhp0ZopDMX1HgBwHhyAOXTz9KlnsOowwWwCM4F9cD1A9ZOeerECjt6n3VQN1DaAJLqTaEBBh9hEY1pxBH2jJMbTIg7UXD
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(70206006)(40480700001)(70586007)(426003)(336012)(316002)(8676002)(47076005)(16526019)(40460700003)(86362001)(81166007)(6916009)(36756003)(7696005)(478600001)(4326008)(36860700001)(45080400002)(44832011)(2616005)(83380400001)(54906003)(82740400003)(5660300002)(8936002)(6666004)(186003)(1076003)(356005)(82310400005)(41300700001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 17:23:58.3020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc45aea3-2966-4c66-0c15-08da94e393c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that an ASUS Rembrandt laptop has problems with seemingly
unrelated ACPI events after resuming from s2idle. Debugging the issue
proved it's because ASUS has ASL that is only called when using the
Microsoft GUID, not the AMD GUID.

This is a bug from ASUS firmware but this series reworks the s2idle
handling for AMD to allow accounting for this in a quirk.

Additionally as this is a problem that may pop up again on other models
add a module parameter that can be used to try the Microsoft GUID on a
given system.

This module parameter intentionally applies to both Intel and AMD systems
as the same problem could potentially exist on Intel systems that support
both the Intel GUID or the Microsoft GUID.

v1->v2:
 * Add two more systems that are reported to be helped by this series.

Mario Limonciello (6):
  acpi/x86: s2idle: Move _HID handling for AMD systems into structures
  acpi/x86: s2idle: If a new AMD _HID is missing assume Rembrandt
  acpi/x86: s2idle: Add module parameter to prefer Microsoft GUID
  acpi/x86: s2idle: Add a quirk for ASUS TUF Gaming A17 FA707RE
  acpi/x86: s2idle: Add a quirk for ASUS ROG Zephyrus G14
  acpi/x86: s2idle: Add a quirk for Lenovo Slim 7 Pro 14ARH7

 drivers/acpi/x86/s2idle.c | 124 ++++++++++++++++++++++++++++++--------
 1 file changed, 100 insertions(+), 24 deletions(-)

-- 
2.34.1

