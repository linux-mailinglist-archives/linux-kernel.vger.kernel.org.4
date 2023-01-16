Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F8C66CFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjAPThf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjAPTh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:37:27 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166662B2A2;
        Mon, 16 Jan 2023 11:37:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rl8zir9ILkz0yL6jVPrufdusARbBYzXjuNwI5x35z/E5joPD6BuYyDWmyl8i3l6kPt/yskrTzHPkMuGKSu2vXjIYYM8lSLQgkOMptXva39SeyWGg7yseo9ADlMZ82jNrQxlo1S+Gd6qwI4+CuHPUyZYGbWVrvOVlrGg3UZCE1IWdaD6q4t7p0HVb4OC4lOZSUR4PPVCwgDjTXavqerYjTPvKX22Xd6DdjTeLKk/mQhtnxTuZ3Tn5h57MDJfcoLA79FReFlg8kouTv9bCT+i5/51TQ0xmHLhJ83eO0Y73juAozTllAfv5d89KL2AY4/rXC6O8yzzImn5pKqrCaLC/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zYKRvDDtftqv7lYjLd07xxxAPWYl/GbQKE3R0Z8p0k=;
 b=WblNdqZgTw92oF1CTOZCA9zuBNhWt2soNfgj5mcZAO6Sn4PvzDPETg+lWxYxFWSoWtXmvAYiizXfRgWYhN+/nIu4Kvn9KaJa5fPfqvN4bRaBvprkYODEcdrB/DdCa3nmr5IiEeSdBUe7G2pNxH3A0OLMTPEVAerApU3P/xUAjxo87rphw00dG2s1L6+65Inq9qztUSST6Dwl3Yo8d6OdNUBpzdllCk+c8II57fbBAukVBCb7PhkEoeyx76NOJyRZFy/XcEempQz7n5GVgPW0mZAr1mV54GmH8aCEFzMr1AwpGXjkbtPuMx7eqPV5mpec7pY11Lx+31fexoPOsiEzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zYKRvDDtftqv7lYjLd07xxxAPWYl/GbQKE3R0Z8p0k=;
 b=y2YUekaQhWLHcJG35jcTQIrvOpoma6zJI9qXy5xXtJ5ASVdWQOpB22DYFfzUNO20utBKiXFSWsZir59iT1mQm6rbtk6R5Ql0zjYCu4TP6suQ4rV/iOSdJadoNx6uSiVQyjh/Nj40tEHljRBeP8KCGKWPd08MmCJfwF3ZX+OK1zY=
Received: from BN8PR04CA0035.namprd04.prod.outlook.com (2603:10b6:408:70::48)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 19:37:25 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::6e) by BN8PR04CA0035.outlook.office365.com
 (2603:10b6:408:70::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 19:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 19:37:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 13:37:23 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <regressions@lists.linux.dev>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Raul Rangel <rrangel@chromium.org>,
        <linux-gpio@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] gpiolib: acpi: Allow ignoring wake capability on pins that aren't in _AEI
Date:   Mon, 16 Jan 2023 13:37:01 -0600
Message-ID: <20230116193702.31356-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230116193702.31356-1-mario.limonciello@amd.com>
References: <20230116193702.31356-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: b5de0ff4-8344-4d77-ed5b-08daf7f917c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTwdf2OQwcI5g+/fhQ9Zrah9dRRY26vB5p5d7W1iSqcz+4Py+alurJWwHDdWzuQlpy42tcLLUMVuxvrr9nUEjDGo5NKMGIk7mcE8fxrq4yg9gdWJWN3yEVFslnCNqktamAz5REzzqd+w21JoOnZV1T07OJYiV+IeYrDAfUY9e6rEq2ajwkLKJy3HdapWVWQqe2D6QV43UEqbqH3jb2M5BHBJm7yQ2ha2VbBgaq0kZ7+c/nYtc2NGIlyByo6fg0OWawl9XSEGKTqyO/tqvcsfPwTyX/4qi0X+wdABUZyGWtjWVvxhdKb5YRDgk6TnTm9dYN9zgsc1BUI6vKLPQdqGjF7DNQeIR3NW2WsoOpShA15hoM/AJwpDbIheBGm0lcncOXF1CbGAMqnkoYTBkXfscbhmgaUyUE4M3Uvq5ArW8Kbso0OWg3GwJ0BqRtkbrRD/ILBqbXFTdPlTa7A2p5jHBGL7S+8nKX+VCOcaY02iYGaAtsTh0vRfaRS1jWf1UpfJ68V4xK7xzogVmQ0qw7YKMPRTAX3CHhP2q+PrKhsuIK/xR3GfvEnHh0BIudzVGf9WI8Ce9nL6Wgn5FjvExEqE/lR3C+2ABZXnILuBel+5P2CKFsIfhCWzOF/+xefVQt7xUNG3GB0CaYXm4kRcoDRfAVWqaGQQvHwmxBwEUkbYydXby5ozEux87opDe7eEe7+R
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(86362001)(36756003)(82310400005)(83380400001)(4326008)(186003)(26005)(16526019)(8676002)(70206006)(70586007)(47076005)(426003)(2616005)(41300700001)(966005)(1076003)(316002)(336012)(2906002)(6666004)(356005)(110136005)(54906003)(7696005)(478600001)(44832011)(40460700003)(81166007)(82740400003)(40480700001)(36860700001)(5660300002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 19:37:24.3330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5de0ff4-8344-4d77-ed5b-08daf7f917c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the `ignore_wake` quirk or module parameter doesn't work for any pin
that has been specified in the _CRS instead of _AEI.

Extend the `acpi_gpio_irq_is_wake` check to cover both places.

Suggested-by: Raul Rangel <rrangel@chromium.org>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1722335
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpio/gpiolib-acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index bed0380c51360..4287555a12408 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -385,7 +385,7 @@ static bool acpi_gpio_in_ignore_list(const char *ignore_list, const char *contro
 }
 
 static bool acpi_gpio_irq_is_wake(struct device *parent,
-				  struct acpi_resource_gpio *agpio)
+				  const struct acpi_resource_gpio *agpio)
 {
 	unsigned int pin = agpio->pin_table[0];
 
@@ -778,7 +778,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		lookup->info.pin_config = agpio->pin_config;
 		lookup->info.debounce = agpio->debounce_timeout;
 		lookup->info.gpioint = gpioint;
-		lookup->info.wake_capable = agpio->wake_capable == ACPI_WAKE_CAPABLE;
+		lookup->info.wake_capable = acpi_gpio_irq_is_wake(&lookup->info.adev->dev, agpio);
 
 		/*
 		 * Polarity and triggering are only specified for GpioInt
-- 
2.34.1

