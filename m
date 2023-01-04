Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C38665CB57
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjADBWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjADBWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:22:34 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A463120B1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:22:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfJAIKCI2etei00zU0m/32+7cXcKSO/AqDvDKIpOUF52Dn+675cBVKvnkGEQE6RvtGzBMzG+QEPxlVuWudF2NZBVwKQdQ+j2QfafyUVaFL6kCJ1rh9QisRfvg5X/q7ls/mj5lxE99h2F/Rgrxpcqrcgo9s/hVS0K18pEJWuSZ1kwlNdfGSdBrrNQZR9DA5ARG7QSZRs9uiYTnX9gq80nHnraXjXN0RJkyNFFTfsJUNreUSCJLhSq3v6+g+mV4mf/y+znhWwkzow9QMxcO31rFj2c1UtqOdAge+RMKqC97sqUaHzjJVbF2Jf6y8ejyZApKqfo345wRxNEbfiKqeiPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8yu37O2QCpAzqxY2AphNZJUs4R3hPPxQsLcKe3KLrw=;
 b=j7WA/9Y6Svb+hULgeLtfIehN/HrWzMjMvYsLufL+pSuvVjZsQyH8x2ainMJDZwlGCeIDcken1amZmbIfeWXih7QhStyIyYhFX0dY+r4zWo+7aBhH0n0Bru2nItlJYw8/fDuqn2C15v8tJpnp/Y0AtcucnivsxO/KnkSLUqP91+LT1WbVv3iqYhexUGAyL7xZdXu3fIX8p1kXKJGl3SMH9+C4k2IKLdBayCizFWUyG5kVQSDKvYWYJncddxH7PxGfDeGUGD2oXoOrpf7/h+UE60CIUAF31gaLN2vmOaXjXZcB9TPE7Z4QtMnCl5r0fRaJEyEUJ+VEohYs4GvlyOoh2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8yu37O2QCpAzqxY2AphNZJUs4R3hPPxQsLcKe3KLrw=;
 b=Mhv1GF4YA5eDg5yfgbdJi+3Yjtoz7oPE+2aBWpmOpw0EmfTNW2MOeZ1QXBJTYwXJtZpNyUfj6i/Py3DuRyyZ0nKuttgDdGH/jqTHXmt3AXOmF+oWSTX56QOUlSACuGTzEvij2wxQuhBAdbofRJi7JmsC17hUKHTFS1bO2EpbfDzqdTU82bkIWLqmbE9Z5gKfRMqNk7ZP7w+UYBRjdK8PEkvRqtFa9Sgogyvcwzy1c3rKPldJgSvWrkNRgKHQvC27XS3PQBNgDKh+Q3JYlW4aUSP6r74QdS6apJCLKIoSSCT9PovSJsVfRmyGDwsmdpIsyuiBBV6Rx4nJprTBs7gQ9w==
Received: from MW4PR04CA0177.namprd04.prod.outlook.com (2603:10b6:303:85::32)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 01:22:31 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::92) by MW4PR04CA0177.outlook.office365.com
 (2603:10b6:303:85::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Wed, 4 Jan 2023 01:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.16 via Frontend Transport; Wed, 4 Jan 2023 01:22:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 17:22:17 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 17:22:17 -0800
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 3 Jan 2023 17:22:16 -0800
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH] arm64: gic: increase the number of IRQ descriptors
Date:   Tue, 3 Jan 2023 19:22:15 -0600
Message-ID: <20230104012215.1222263-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b33e5cb-2091-46a0-d5ca-08daedf2268e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8K0umbqjJgjCcGEh7at+m746uZ7IK7XQq4JoUBjr/oWjcIDH/Q5IUm3utyQmKBplWltUeFBBkzUc7qOuyCGo6NldjH4W6sBrjYRW3cGGvjvcdlsDmsEI566ZMFwkcH1QU8XaTdG6SlNNiJ8HorUWSuy3QB0rXQlRSuQkfmleaNvJku0Db8lUpRChE4lD6JRSUszg9vquEBSw2EWsuiHIwM22sGXX319IlsH4it56/zamsm3Oi7J92h5nHgDUohCUtfwJJ9TGI4y5CHcaARCcidPFllQ+vVeHQ70CxKA7zIRTtdJ8qRwu6v9/GgF0h8AmFUt1BLW8v8pauU+2jMFyXQ3XCm6eyToyyv1+8TUJdv32NuIZ3z4aqGScQ8aSU2bq+591AUpZ34+i5PwH5GTe7W6QISwGmuf3qkojwrQIgl+lHUZTFuMWefIdgfdYPXoiJGq9g+oF6+8jstMaoWdtKITBXRc6bLejB9HcycA63nAR6ZERF8KysxnPbEpGgPXoUeF1DyzixS19dLDepxtVD4q/DIwKRH7wAC4mkjQxq68VuaWcsyBG1frqLzcQVyQa2Vf3ESkpHuhxmNr3LViYmItF/FgTbgQruw4Qw9PS0ov0A43J3qTOjCa4NPkidj9MI69f/Dbxf0XQBA843ozKN4fOdFjoqs7WIpz/LHWAihTrah7X67wH2UBJ8OPhMjCdwJD92cGnPWMTzYO/GT+TXQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(41300700001)(5660300002)(8676002)(8936002)(4326008)(70206006)(70586007)(4744005)(316002)(110136005)(54906003)(2906002)(7696005)(478600001)(107886003)(426003)(47076005)(2616005)(86362001)(336012)(40480700001)(186003)(26005)(1076003)(36756003)(356005)(36860700001)(7636003)(82740400003)(40460700003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 01:22:30.9703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b33e5cb-2091-46a0-d5ca-08daedf2268e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default value of NR_IRQS is not sufficient to support GICv4.1
features and ~64K LPIs. This parameter would be too small for certain
server platforms where it has many IO devices and is capable of
direct injection of vSGI and vLPI features.

Currently, maximum of 64 + 8192 (IRQ_BITMAP_BITS) IRQ descriptors
are allowed. The vCPU creation fails after reaching count ~400 with
kvm-arm.vgic_v4_enable=1.

This patch increases NR_IRQS to 1^19 to cover 64K LPIs and 262144
vSGIs (16K vPEs x 16).

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 arch/arm64/include/asm/irq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 168d710a7b70..741e0e9148ed 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -4,6 +4,10 @@
 
 #ifndef __ASSEMBLER__
 
+#if defined(CONFIG_ARM_GIC_V3_ITS)
+#define  NR_IRQS  (1 << 19)
+#endif
+
 #include <asm-generic/irq.h>
 #include <linux/irqchip/arm-gic-common.h>
 
-- 
2.25.1

