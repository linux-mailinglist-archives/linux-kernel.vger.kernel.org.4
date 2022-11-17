Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7089162E8FF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbiKQW7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240483AbiKQW6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:58:49 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E75811155;
        Thu, 17 Nov 2022 14:58:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9o4ZgamFJvqJ2V7q07XPFiYiIttwAHrI99RPLprn6pinZ85mZX9wn8imigemtMShFEP0lJj1wn3Ba9nI5cs2gKhrOPtqUvTMrTOAurZxbU9XTYWndIx2XqsAZgGBTWvt4TdHBhuimQ8o+nL9hXdGZ5KpGbzL4rGSkOnpzRRrCPiaLhNXCnAs/1gSlY2TMzwbM6zg2Rx+V1SCI4lkSCkHy62SaGNZKA70d0YaO5za0GCIbDOn8ZXjXfjTs3fLEb2QucPp0hfynzdZKU99DYRBroSR/Sa4GNYX4KGhIB35YVGimegAIuboqzc2YWlggVlW4S+aGnf/WJ7QsRWucmh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex27RW0cibhWiM+YZoJD3N4nbEElqwCzQ/Q7Nx4RqsU=;
 b=YJ0H783K/gaX6ld7HRzme0oAXn0C6a2QYKoY9CBMfpvHmfkQmasmrJR/hq+IOAL+5+Mhc8VItc9MDgeWfTAPxrlTZWzEEl/wo9Bav6aXymXe4c7CaiRUXLd+icn4FwKfybm8tGSOjFQ8lUuw6tK6Pet8A/Iw0mSungJct2qMnyqReNKbvSUQ3M8QyiXdm4J4K8gHLVYNOdh1Xr+2hRnk64ga7bEhvszp5q1IBo4gzkUn1ADPV6DYsXhGTg1ipL3rB38ilPcybnzdLoZ5/olbK9HOpby18F57uyNHx/G4EZ3ryR6DkvXZZKpv7Q5WmeYT0+z6h2TGsdwmlVJL2+B2+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex27RW0cibhWiM+YZoJD3N4nbEElqwCzQ/Q7Nx4RqsU=;
 b=M4xzqJ7qi9Vv+6KtSIzsiIaSik8PB0Jp7OiAgsTV7Tv07E9j5EqFbss0nAdFeeXQy3l1qCON6XSHuXzb2n1obVnT5haIXcz8kPGdFCdETsTHPC7aI0WAhzcuJ7niFTLYmOY0vbRatEuB+dL+CC33u0dWpQhhFjBKfryKM1vxam0=
Received: from MW4P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::17)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 22:58:30 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::62) by MW4P223CA0012.outlook.office365.com
 (2603:10b6:303:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 22:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT092.mail.protection.outlook.com (10.13.175.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 22:58:29 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 16:58:28 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>
CC:     Sven van Ashbrook <svenva@chromium.org>,
        Raul Rangel <rrangel@chromium.org>, <linux-pm@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Rajat Jain <rajatja@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Subject: [RFC v4 4/5] platform/x86/intel/pmc: core: Always capture counters on suspend
Date:   Thu, 17 Nov 2022 16:58:20 -0600
Message-ID: <20221117225822.16154-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117225822.16154-1-mario.limonciello@amd.com>
References: <20221117225822.16154-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT092:EE_|BL1PR12MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: cb989b5c-5b4e-47df-e64f-08dac8ef3e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hAKDsCZrHJNX20Qnr9USVvkF6NEH31XBowymQmxr0Ba4DZDzs0jCi2Yd205vb58HhY0hKK6WzEv/k3gQhg3RaO98/WYt+SVt9lc8uZBG+Ko2XJYvQcZZcq4u0FykJWZcOok7TVN/7Djkf8aaMNxhm6FAzQCEjP0QT9NiihvMsCXif8LdA4zgjXzZweiwK7uQYKXj9qAGnvg+eSs/zQeIDUHyvsplH+UdrDomkj3hZyxQdLMYGVW2E8Xxe8EzWYYR6L7ZGkdJnBWAokRxOTxv2n2sc8FYK0qB9KDj6yTGWDo2uNqGqYLMCR0BNCoUZ6G8CEcVRLCxXhIIu/1fpQ4+iUg2R/nNfpjjH/EzJmcL1ICIP1CerId9yOe4oSecizSptA/Hbf5a9mrodvk/vJdNnORJGHxpbQ1mr16Y1/mc44XjbtLwK7rciFQH6M4H9G49bTlLXUj9o+xGW4STP1s+i1aS/K4rBQ2vAqNXAqem/JDDQLyXjjdIiNKBwN224nG3hSTPcjTM9C+49pJ4g8kZEMRrpNdQ8dTZQgnbJJg/zpx12uArhMDDCFtpGfsbREH1e3osPaP7OztzauD6nP3xD2Nou3i1vudqTXRpIeTMWteVhI6QXZlegHIMTj8nHgOzX/fVSVG3BFerLWG06VDiY+1VlWHHGKg5piEPBQEod5naQRk0lv/oJO8P6dDPISaj6jkHNCM7w2NAQbAqwKXGiu51IcmjRVPGNUVsolQjXRU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(7416002)(86362001)(83380400001)(82740400003)(15650500001)(8936002)(356005)(81166007)(2906002)(4744005)(4326008)(82310400005)(8676002)(41300700001)(6666004)(40460700003)(5660300002)(44832011)(110136005)(40480700001)(70206006)(7696005)(26005)(47076005)(186003)(1076003)(2616005)(336012)(316002)(54906003)(70586007)(16526019)(426003)(478600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 22:58:29.6813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb989b5c-5b4e-47df-e64f-08dac8ef3e8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently counters are only captured during suspend when the
warn_on_s0ix_failures module parameter is set.

In order to relay this counter information to the kernel reporting
infrastructure adjust it so that the counters are always captured.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
RFC v3->v4:
 * New patch
---
 drivers/platform/x86/intel/pmc/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index adc2cae4db28..9baf2bb443c8 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -2059,10 +2059,6 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 {
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 
-	/* No warnings on S0ix failures */
-	if (!warn_on_s0ix_failures)
-		return 0;
-
 	/* Check if the syspend will actually use S0ix */
 	if (pm_suspend_via_firmware())
 		return 0;
-- 
2.34.1

