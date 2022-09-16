Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F8C5BB20D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIPS0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIPS0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:26:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A7BB4E8D;
        Fri, 16 Sep 2022 11:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XP4qxwdwPNz4RusU+say+zwHpmSW1E2pqY9qfQIDb7xH1IxOeWlwpzDPKOu30tmj1jWwrEDw/+vgVaT1brICZfYpB9XlkL2aRjzkXQLLxLBa7AcNkmefH2C628kh+dEVkfqcEE6OiYQw/IpxDpqECeu+y4AZFPdFUs2yfDXRM3eIfFVkPzbl2NQ+OAGwF78YdDTUmYUnX4c64aua/oLxL3Tcr1wIQlZ0yzwBYk3ap+KpqaVjfRrMoYriOEpC8ACF6sZCQbH42+1w99eHfoTXLC03myWgtqME/Zm8uf7f3WDaeZ9MnJ+xxVNP6FNCGKWMQXEjW2abDDaQhc5lAYDkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Us7N/QSuHQnzyOwQg4A487ax+zBoqjncvimXDfqEc0=;
 b=f9n2PE0TRSY2GrGlET4xA4pEMacj413aORzW03lBUip4BZrcd5KQbmsjz3gqKSvSaERAUIR0XDhcdUtqnpgeDlAg0p6Qy5uRpgl6r8sNPjyZs9yHywzJNMQu58OmLA5kKSUk+hNIEgJi1Q0WyVBXHdvoHCtDsc4GIitYVXFPkEZwY6UudA09mBWf0O3H1LtWiDxHv2NuYW+rlDatxW2Yi40i+Cw/2pTWbTPP4vW4djyQTMpD6vYQdRIho67tXuGqtfaIItlnaYzDF2KMQ4ksRQaA1MOQDXkEBoKNrN7DSHrxd7j8/mf8T3BZwLhXzGinfPOKiqT5c0ZG+e2DFcjbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Us7N/QSuHQnzyOwQg4A487ax+zBoqjncvimXDfqEc0=;
 b=yAEl2bwtEeVoQFJr9kdlTyf4ftqyx3J1KKGuLVm675NznOPZbxYP4pEyJi1leQm1aokFkMg3UAWiCD2Xb6dnW8xKZIhKr4EsXGaYYzuDFc/+lP7sfFF/MECu+AjX1hDYpJlyY44yU3EGa/uK492YC1sag0wNoCHxsM7uCV4Svco=
Received: from MW4PR04CA0121.namprd04.prod.outlook.com (2603:10b6:303:84::6)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 18:26:18 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::68) by MW4PR04CA0121.outlook.office365.com
 (2603:10b6:303:84::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Fri, 16 Sep 2022 18:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Fri, 16 Sep 2022 18:26:18 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 13:26:16 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, "Sebastian S ." <iam@decentr.al>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Len Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/7] Fixups for s2idle on various Rembrandt laptops
Date:   Fri, 16 Sep 2022 13:26:02 -0500
Message-ID: <20220916182609.3039-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b87b0f-344c-4eb4-d7db-08da9810f297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xOGLjkhV69geGEq3jcdp+kbk1TlWDZOOsUYHiOFby1bMmrxN/xJhRM2xArRbVPa5+Ng9Cb0BxT64QG7EWr9ixARTJR750hykda+o/lI7CUg746P8nSt+2olQymBerH5s3jHZ3MOdOG0uIiaDAMGP3iYSn9iqgrfl2xBGGg65RYVkQ+B3hge95iCDsR5JceN462pBzDlpCSS2oHf4zix7v13T6+0mmjKTU3lnf4OUSmz+fJGOtcQ1AvP1K7lnTlQrmnv2GzXytMGWA4yKmhCbjHuIH9NNOm6p0GnsKspcHs18MkkSNqs2EwrcASiXAz9CxpTlIzgd2eLNRX89GVFkcRHYJ8jT3Wsp02l+feewH+7WuzUNy9aODwzW8+efMZlkt7+9UQYS41yWMTHzDBndS4Y5IIVdQ0eO2tvNOwgRlsih9lNuU1x679XVoPmttZyevVfmsQNEUFv6Xfgxfb6oVUrBgRG8htIJ0Bz7L5rBPUMDF2UjGYINlsosFOkFkszFOgggPGiT7T+ys5wLotTCbM/75das0io2yLwZxw86ELuLQ3VL0fbCto4hueDCm+I3/I5Rwv7VmXGUAqwFseLd0dHmR7eXSX28dwN4t5Y1G0uoaJqb3Q5VJNMHOcirdzGnWZawflXEDbQTP7kW5WWwvIlB+DIsDk0zLLZ/2ni82YRAYh0ztBZYBEGayvFBHrwLMLsQZtX3kGX/nhKoCW1XfmZVMiOVkBDyKzgjcREgyqrvM+pGfILRf6DGpZuG0M3pBNXv9WDZMlQoENYzSETUkyXSPJQU7D9yz9OOurkXaZ2okp+CeK7n2diG4brGWpqq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(356005)(81166007)(26005)(36860700001)(40480700001)(40460700003)(2906002)(36756003)(186003)(16526019)(47076005)(7416002)(2616005)(44832011)(5660300002)(83380400001)(8936002)(426003)(41300700001)(1076003)(336012)(6666004)(70206006)(70586007)(4326008)(8676002)(82310400005)(7696005)(86362001)(478600001)(82740400003)(316002)(6916009)(45080400002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 18:26:18.1563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b87b0f-344c-4eb4-d7db-08da9810f297
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

v2->v3:
 * Add more systems
v1->v2:
 * Add two more systems that are reported to be helped by this series.

Mario Limonciello (7):
  acpi/x86: s2idle: Move _HID handling for AMD systems into structures
  acpi/x86: s2idle: If a new AMD _HID is missing assume Rembrandt
  acpi/x86: s2idle: Add module parameter to prefer Microsoft GUID
  acpi/x86: s2idle: Add a quirk for ASUS TUF Gaming A17 FA707RE
  acpi/x86: s2idle: Add a quirk for ASUS ROG Zephyrus G14
  acpi/x86: s2idle: Add a quirk for Lenovo Slim 7 Pro 14ARH7
  acpi/x86: s2idle: Add a quirk for ASUSTeK COMPUTER INC. ROG Flow X13

 drivers/acpi/x86/s2idle.c | 136 +++++++++++++++++++++++++++++++-------
 1 file changed, 112 insertions(+), 24 deletions(-)

-- 
2.34.1

