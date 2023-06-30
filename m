Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9197442E8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjF3Trv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjF3Tri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:47:38 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224333C01;
        Fri, 30 Jun 2023 12:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsFufvorpH7USO4TvbUc7ROZ63f+kjYvz7SEWkbzQeuYzP/StQgoJQourm/OxOn1Fc9SxsgiJYH2II2m1uStGS/Qgz0WitA5HSQbYqPZnVCmM2LQsnvLzonEqKKkZAN3/iY4k/WFe1uDoVIhI4X2Fp0O0P4ht4+muAOjgQKl3XCDULoPtBBzNqzLdLYsrRXJfIRhlYRVPnGjRmyaevyd8mmHo7j+lmvMQUGMZa7SZFNPH46De/4EIzvfLhq1IU9oXugvMFIQD/NKuJr9hpHCKumlcZQrKCyEHHG+6R0jYYU0Xczh8IvaTSoNZMdu8RzugyAr7BdMpTZfF6h8wzFFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwuqrKrJuUJwmWA9/ouyd9MXqjC4KhyLrgSquBoT7H4=;
 b=njmtR9/UCQ4KTC2NDqKjCwyS9yK46pVTtfwkLiq25RFb5WDMNSBcJOH+CZxOO8hv/P1Cqk+l7Ymzo9X1VXYnksz9ykuxejoTjcaJHkfEvCjYXm3MJx2G3uNWmQNCc3P/dO2gk8LuZ+q1K1QNbw1hi6tUT9fFEtFE04ck8WzQhuJ18IXdcAyy0cB7RSOYeDZJ/b37eMpJB7+E9c1pwnpEscMeEs+a5telWdVo4sjmKqzrJb2zihMOfXm5tx+jNClvOmrqqylH7/fr/oTlAln6c7+hBQihHHDtyKmZXVbM7nfviuEVyxu5ARm7OuWMB25ik1cyrQk+0UY6qcHPdusWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwuqrKrJuUJwmWA9/ouyd9MXqjC4KhyLrgSquBoT7H4=;
 b=0JUhXO1zYvmUG67xdVV0hrPcaIPzPbHJZ7px7dNpZgBwzgB0FhwaXy3lr4vb3b9beE6yIV6jYdJCxc9sPbevOTEj3bVTBzOQLvoyFUbkB66DLv95EywC/KRh1qQK99NFeOZQbjjp6jV5Mci99ZaDPjmao866TtqG+3D2vsT9Ap8=
Received: from SJ0PR13CA0108.namprd13.prod.outlook.com (2603:10b6:a03:2c5::23)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 30 Jun
 2023 19:47:32 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c5:cafe::bc) by SJ0PR13CA0108.outlook.office365.com
 (2603:10b6:a03:2c5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Fri, 30 Jun 2023 19:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Fri, 30 Jun 2023 19:47:31 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 14:47:30 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <Basavaraj.Natikar@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <linus.walleij@linaro.org>
CC:     <npliashechnikov@gmail.com>, <nmschulte@gmail.com>,
        <friedrich.vock@gmx.de>, <dridri85@gmail.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/4] pinctrl: amd: Only use special debounce behavior for GPIO 0
Date:   Fri, 30 Jun 2023 14:47:13 -0500
Message-ID: <20230630194716.6497-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630194716.6497-1-mario.limonciello@amd.com>
References: <20230630194716.6497-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: ce374f58-e345-4be3-818c-08db79a2d827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DmpIB58ZoEIpIhFqNcEnKp7AaLAVoz9wMBDD2raDG+1lfEd27TOtp0/27VuEzozOw9kAYkv/MA4KKlFOHNmZahpHuHNHegQAjJsfZ3csh2gA9Ac5qwPlwwKHejdkfEtDy73jtXQFu8UblmJxbK2kC7G2wW33ubqjxxzuyoh6llIOTR5PxT5JVo6VKUfsVDY1ZtQSDlybtEfjYmaqVPTytJiUOdbqoQ+kz7+pow2CWFHW3raGrYHachHU2alIxrO756TrNbeTSFUrM1mgUR4vGf7wVLZRQquexdaW3YynXTMVJAI7NTrTUuQjmTy254/m06q8ONGayZzH4pi2yNYj/QtxGI/mRm3TvT9J26vnEgBkY2huec3WmZm+DiH4IkLiq3/Cita+5lrxLejJtHHJEzRSMVXu/EJ2c3sKG2nM/juNNiNrwwFuuH3NZfDi2d9FzH5hP1CwMAdBHZiJIrHxWgiepqM1tOZLXKP2O5PDr5juUi5y66/2RSX5YjOQ1m9oUhtnNghC+z8cpZZnnBFpQQD2UfTMuAM1qLFmiIam26ftJqyJNyMlrVi+NSpDt7qPyigMz0DwBeLDXTJDEg3eSfo70Ll/t+s/tPMCHYbUECZCqyDuOmo6lzyAYHhhnJCPKoEMnVOd0sYhcAilINEE8Scq9qPX38phPKm56i1vt8Xz1+4P5WEBTIuimAGjV9iEVkgGETLJ2KUE8egJHWF6SBLmWe8EntG2AAV5tO8xIOWFzzhKS+uBX8ef93AdCC0xfAinslXt9tLZa0zaoZHhBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(7696005)(6666004)(54906003)(478600001)(110136005)(336012)(356005)(36860700001)(2616005)(86362001)(426003)(47076005)(40460700003)(83380400001)(82310400005)(316002)(16526019)(26005)(186003)(1076003)(40480700001)(2906002)(82740400003)(81166007)(36756003)(8936002)(5660300002)(70586007)(4326008)(44832011)(70206006)(41300700001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 19:47:31.9469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce374f58-e345-4be3-818c-08db79a2d827
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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
Fixes: 968ab9261627f ("pinctrl: amd: Detect internal GPIO0 debounce handling")
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

