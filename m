Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AEB676692
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 14:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjAUNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 08:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjAUNsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 08:48:03 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF86193C6;
        Sat, 21 Jan 2023 05:48:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaJeJRwNDwvIzz0Z+PzlybffhrfYCbks2Y2tWz8JFAVSFsJTvFiqupm5KLQuGyJaLOvroO1w12zGAf1F3yMVvZM735sYJwBpEbd5uWOGYVgOc8KoUX0MvVp0KiHpMWDTR7Nf/EjVVmLike2ijNYNxqh2hHy+ymTNkadfZ6S/IUjrgME39UyvM++bC52bFd4hjTuzq/5cWYYIvbsoHwTF2PAKDZFF1JaMcZx23Y7NGLmQv8BDAdwlGaa5OdBawvytg9WzF566o4joh598RgKgxlqtLfy0sYbgP1ta6Gsyt0HzEQhPwBEJ0mPBW4buHqe9mOWY9dVQtA3NuykwmhArdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVjrdQ95Nyzp9uvrw3fHnYuJLUT+gMUZ0Rs8346Vf+c=;
 b=HHrrFQiEUdx2R7rm8ITUTPagZ5a16j1onZgPDWRLiaQ85dGKnaxCpqxkXLNzzwweJz/ZDrCGLniqZkEvUABUaHc4jtjuAAtsTsF0We9FyhNZCqXLVuM80tluEpiRJmocu9T7jToDoxW4QyYTf2M59uGnHhVDlIOci37vW2uRellStVji9EO9qzcJYyG0QX+OiQEfJCOqKM6R6g/5lyE3d6pCN5cCpxHGsbz1t4G9cY5odmafVIXlVZf+8CADFrUnu8BNc7+EqS+s/AGJDO099FVLqsSFu3tkp0fgn2GmjXJJRvjhovNINW/URZ0+61LE4LY/NY6+AlR5WvAClN8vzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVjrdQ95Nyzp9uvrw3fHnYuJLUT+gMUZ0Rs8346Vf+c=;
 b=jVIVsar2lRRxJtb0zxk2F18Y3LG0sdsbadtxhr24PYDYOPc4l1MR6WC7U6sTE1ArmiKiwOHep4SYRQUQWXQ9T1qs69p8VgclPRPO/VdwWHffCTkp6iijwXYtvPrzw9eyb+vxtnsd6DAcURdJrWUHt4X7R9THghbiSz+5LVYE9w8=
Received: from MW4PR03CA0314.namprd03.prod.outlook.com (2603:10b6:303:dd::19)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Sat, 21 Jan
 2023 13:48:00 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::1f) by MW4PR03CA0314.outlook.office365.com
 (2603:10b6:303:dd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28 via Frontend
 Transport; Sat, 21 Jan 2023 13:47:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Sat, 21 Jan 2023 13:47:59 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 21 Jan
 2023 07:47:58 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Wolfram Sang" <wsa@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Mika Westerberg" <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Fix some more fallout from GPIOs from _CRS
Date:   Sat, 21 Jan 2023 07:48:09 -0600
Message-ID: <20230121134812.16637-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: c177ab20-9461-4370-1857-08dafbb61bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVmIYuSmOw9GR6XCKqReMtdei36OKs0tO0VyIE34H34R0HBk0Sx3zTfU3m7guVaxygFJL/9nffNEo7lfbUBbVQkBAcsv8IUXbr5DlNhxIRyeeBpLnv8B8LJJZWoko9TiH8slbpmEAutd6LGJ0+Faq2hqcbfMeMeq9cKQwn/YyZjOiti62lOajcDnvYvP4iWm/l9w2M9NyXryabznJV5fn/9DFiLbamnT4oq+IkjTN5mG/qKjFgE4aNo24san8jlV0h+STZFpthdS96RnUV1DrP7Op9i4+ODxRyRgmqmydUC633Z8Ujma8eE7r0gw/aaBdMUhZuOJpxykvRUdQbq6SgvCqgDkFQukbXnCkAAQYTX1yPiLiO7FlxTXSSC46ox3/HMWcFaG5AWYkx9MCMpyKFH/D7q5AbjVWdboVJazPlKT+RiPTEL/ktTePPNQi5DyoUpO8Vq+U7qSOKaDg3LdgGJosbNCQN8ibywtNlXRb7spqfdr+hRuIMAeY4S0RRlE217+swG7WOnSau0KDovpPVh6FW0KbuoyuNRgELLXwbx/F1mMyWbu2wnH/abcra1OU/HbIXMg/kNpM6FLySJ5r4CEAKrtypiCZ8dlnYEqVuG3dIwBjvXMOYeYoWU3dBzMZhmAGcD7V6sE1teIx0EhDOq+sT/lGBCkpAF086t0VHbSN9uBKYDKkqVxiSd4GA+S0vcPBgllB+FKT2hIy+MPstlRTJ+yjTnMckFP3KP26F0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(336012)(316002)(8676002)(70206006)(47076005)(426003)(40460700003)(4326008)(2616005)(1076003)(70586007)(110136005)(36756003)(54906003)(356005)(36860700001)(44832011)(86362001)(81166007)(41300700001)(82740400003)(2906002)(82310400005)(478600001)(7416002)(83380400001)(5660300002)(40480700001)(8936002)(7696005)(26005)(16526019)(186003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 13:47:59.3199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c177ab20-9461-4370-1857-08dafbb61bc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raul's series that let GPIOs be enabled based on ACPI tables
caused some fallout on systems that don't support s2idle.

When systems were suspended they either immediately woke up
or never (appeared) to enter suspend.

This affected at least 2 System76 systems (pang10/pang11) as
well as two Lenovo laptops (X13 G2a/T14 G2a).

Initially the solution was developed as a quirk for these
4 systems, but then it was discovered the systems are ONLY
affected when set to S3 instead of s2idle in BIOS setup.

To fix the regression, don't set wake capable for those GPIOs
unless the system claims to support low power idle in the FADT.

This effectively restores the behavior from before
commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
but only when utilized with S3.

Mario Limonciello (2):
  pinctrl: amd: Fix debug output for debounce time
  gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode

 drivers/gpio/gpiolib-acpi.c   | 3 ++-
 drivers/pinctrl/pinctrl-amd.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.34.1

