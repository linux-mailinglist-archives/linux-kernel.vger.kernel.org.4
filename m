Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE1A7484FD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjGENa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjGENax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:30:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B346D1727;
        Wed,  5 Jul 2023 06:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUsWNzjhHjY83cbJVHYduU75F6744+l4L4uMR0SzhiDSpA3e3HVyTzKCQJt0WbJ11SEMb/05TGrIU/HIfiz9LecPuOIXQa46DyM2wxoRQQKNxD/H5CeHeNtKWxxdUYQVYvLs+GR0NZ0hUbaOx4a1oW2Klu5d6EsKutQLt836SbHOQHkyV8gz5/tMePsTs7J3ugn6L0qTRTSPV0jh9wJNWdEFJOYBqva6NN+FRI5+cbAbxA3vDhvXsBSNAzMpomYSuox/ZNgqC5yJ0IiahATeyzAuxKYSd1lZeyA/mk0KYzQJkaFcwEqY0VKjlvqQ1VkQEx2tS1HLnK5XoO1lDkPtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lf0ifmjCQsN+rdlyur0+JYyn1MxCaZiHcdPVX4tHKTA=;
 b=g17s3eO9CDUOKfBIhWmNQ7WYQjsIA/1GjQ40YQ0tu6ugcXsa6inCgLHzN0RHcsAvFkjmiA/fUDQ3RroOyyC2wgZaJXBmyb3InQjF8MEBQ0ON9vZ/XFZK9AjBJv4JaAS3bqeL/jvRdK9TGyYVIC6XG9BjMMrEc9fgmDDIOLBs9eaD1S+4d7l+j1XMVI6yWUnsOmSBZexsMESI1DVCoX3aAmKhU4+d7zzjkljC5CMCwUs988kA48wbx/JCsCEZrorwueacp7Jhpl8IIL9xFNQpiVe11o09X0zl+GWHZzgnDKCaoahE8lmidVCb8PuUq9yXFbfXAQ0Q7vmkzUlk109cNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lf0ifmjCQsN+rdlyur0+JYyn1MxCaZiHcdPVX4tHKTA=;
 b=Q+T9WaCU9su5Mxjl/EQD2oQwW5e9O625ySJgRdI+kVpYd1g484Q+81VtT3Ta//j8SoPi0SbxyQjnTz91uDhIeNnWh7tj+D5dsgCxxqdURgcgPgVV8glXz2wabaCGMJZfkS/qIY2XZ+l+YrOa1nfZiWoYP+VpkQgLqRfAemii33M=
Received: from SJ2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:a03:505::28)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:30:29 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:505:cafe::75) by SJ2PR07CA0015.outlook.office365.com
 (2603:10b6:a03:505::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 13:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Wed, 5 Jul 2023 13:30:29 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 08:30:27 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <linus.walleij@linaro.org>
CC:     <andriy.shevchenko@linux.intel.com>, <npliashechnikov@gmail.com>,
        <nmschulte@gmail.com>, <friedrich.vock@gmx.de>,
        <dridri85@gmail.com>, "Hans de Goede" <hdegoede@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list" <linux-gpio@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2 1/4] pinctrl: amd: Only use special debounce behavior for GPIO 0
Date:   Wed, 5 Jul 2023 08:30:02 -0500
Message-ID: <20230705133005.577-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705133005.577-1-mario.limonciello@amd.com>
References: <20230705133005.577-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: bed3e68d-7a0d-4623-d9c9-08db7d5bffe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVGWVhFXBLWyA2kpCHoOi2KvGXly+WnqTI33hadm1J9Vc+9qnMSvRYR5cLg86f1lbsWpb3uZI6ONTIXgooA1L8SPsCRlcgDTZGHPn19zavCQBAP9JlUQbrrDI4H3kmFfzBVH06dBslF3TbeV2bdJLLASBOxxG/IbqAdb6BwXOBL38/3WUXkFkDXrcyQqmQSRyxiIE053Ez/verE1pHZqzr22XBSLdnxigSXqRIEALUlRVovOwFC+2T/Ejv+FFS0Fnsdq1CVj2rNcu9tFCvFgHbm5mzpCbp7dDLmf1tK42HnXASASUV30aQOIhG+cXq+A1j2oypHRrGKj3ofRcKJRHp2A0FSsRZqazASHw+jBx6k8PA+4WT9z6NH5E3OwIVoQcnwGNnKmmdmnJYySWV99xMpVlgCuXqGmGuO5KTtLb6e3PFdO5iqz1Y5kZ9HREfZUPEUGnh1KMDNS1m0nTiDpyIS7wSRkzD89ma7IGL+Mz0HJpfW++9ZXFQT+Jepx1tawiDf3CxQa5qmSkcX6f8LWr2xTCJhrzoQVTmrPGIBHAC5bSS0vVUm5gXJ4Q4u5SX6Wed42gKHq3iv1gcbFasqA4cvwfCG1MimSezhu1cuElsrR1WZcM3pjtWSQWfglqokm1P7DMn0MPyfYafHjvZOvgPCqYqV421KKZdS0hGtLvnEG7Fmu59fKjKrE9zzeKtrZlYlNOxp/MntCJUhlcXC5usFJTIuc5aoqL34q03iDF8G1Ddf1fUczZkogrink1beoRg4Uns+B3C2mlk/t1YRlgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(8936002)(8676002)(2906002)(2616005)(70586007)(70206006)(40480700001)(16526019)(5660300002)(7416002)(44832011)(1076003)(26005)(186003)(336012)(41300700001)(40460700003)(82740400003)(356005)(81166007)(7696005)(6666004)(426003)(4326008)(36756003)(316002)(83380400001)(47076005)(36860700001)(54906003)(110136005)(478600001)(82310400005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:30:29.1091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed3e68d-7a0d-4623-d9c9-08db7d5bffe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's uncommon to use debounce on any other pin, but technically
we should only set debounce to 0 when working off GPIO0.

Cc: stable@vger.kernel.org
Fixes: 968ab9261627 ("pinctrl: amd: Detect internal GPIO0 debounce handling")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 7a4dd0c861abc..02d9f9f245707 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -127,9 +127,11 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 
 	/* Use special handling for Pin0 debounce */
-	pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
-	if (pin_reg & INTERNAL_GPIO0_DEBOUNCE)
-		debounce = 0;
+	if (offset == 0) {
+		pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
+		if (pin_reg & INTERNAL_GPIO0_DEBOUNCE)
+			debounce = 0;
+	}
 
 	pin_reg = readl(gpio_dev->base + offset * 4);
 
-- 
2.34.1

