Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09BE666B76
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbjALHQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbjALHPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:15:52 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCE64E412;
        Wed, 11 Jan 2023 23:15:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxC2TCNernmriu2nO/N6e/NrrFLIMEKzSOThM0gXoQA/T3nK2TR7XPuRsCOZsV/+oHvhXDHJrLlO3Rs4MvB3I5coAJUQXP5M/68qgqo4dSLwY+z9X10u8aaJTgZ8oYTEd/hRrDkMI4E8JZmKG28+eRTtDrZLin42AdUjs/ZXtT+uos84lj5fLkFiTYJAw/YLNhbOKVvyRG4aWwCycjPA/0RZVQwtCy3tgu3sjBc/pvzEXKyWuxUFGlGehs5gfMskcnIsfbFcct9I4+4EIQgYeMfk5Fkj2JR7dPJE+r9kiqwIqCsYcld2C5zDFs5k3D0e/QWwR4w3H+nH+8kQGrL8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE6qfLuUmgdS4MhAHMMaadXN3dTiWP3zF+by2ssRUC8=;
 b=b62GwJNqmexoSetslnF2CqCHLBPpWCaolPZC6bHVs6ygu+fd2aQaNp4MzT4OUdzWOf9hgcMKGx5OvxZoXxnWiPAlzanCb+zoh02h72Qz1WYkeIjmorPoaLk0UsG1ND0tg5A1fqPkLWFL6BPbAopr30zmetplVVP397FCmmya/rJsnvQleJefXNCAbl9MZe2jBW25F+DQQRQdNoqdPBXTREkjARpghKSjfowF1aRuJljU2/iLQu4iuc6EXhBwcj20Zbypouw3VO81jj3JiHZQPA68REpEzp6ZIjRCz8wrLS6SWewvG+JC+JF3pazZm0JC0O7IWAI70QhcObM5NoKwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE6qfLuUmgdS4MhAHMMaadXN3dTiWP3zF+by2ssRUC8=;
 b=2gttp5o4WAL3m3ZJ1q5pLXWWe/mL2P7iGT73+Roouou8Acv9AtTZ1aQwpyGK8zbs+O/ZeydEzXx6dLz9iiECs+WLBMx1MVqARvlYX0+TMCRw6JI4wO42aDyIfG1bd4uCCf2rdc3OXvjaiOYXC8N3u4mCKbb8lyhnQGov4hZwlXc=
Received: from BN0PR04CA0033.namprd04.prod.outlook.com (2603:10b6:408:e8::8)
 by BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 07:15:44 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::f) by BN0PR04CA0033.outlook.office365.com
 (2603:10b6:408:e8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Thu, 12 Jan 2023 07:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 12 Jan 2023 07:15:44 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 01:15:44 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 23:15:43 -0800
Received: from xhdmubinusm40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 12 Jan 2023 01:15:40 -0600
From:   Mubin Sayyed <mubin.sayyed@amd.com>
To:     <robh+dt@kernel.org>, <treding@nvidia.com>,
        <u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <git@amd.com>,
        <michal.simek@amd.com>, <siva.durga.prasad.paladugu@amd.com>,
        <mubin10@gmail.com>, Mubin Sayyed <mubin.sayyed@amd.com>
Subject: [LINUX PATCH 0/3] Add initial support for TTC PWM driver
Date:   Thu, 12 Jan 2023 12:45:23 +0530
Message-ID: <20230112071526.3035949-1-mubin.sayyed@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|BL3PR12MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 052cf7f7-684e-48a3-b44f-08daf46cd24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPFR1yVZknG9ldt/Zg1EmY+HHJQ2gNXs4LBseNk6nWZmrxbzdLYfrlEXUjgfYo2aLRsWyOKxWSDABMFoJxa16cf9RgwRh+ayOKWg9RIuXTBonuYtde2liuGbLgqZDRfxyh4XlCXeum3hrn1V/rqKaxlTJc2dOLDmcTBG/zNYJlKnvjgezMI/9QLLkdgoBN9O6KrcXvQhTt3c0PZBZ0F7wB1yDtdorJFMF8675xl4xFeH8TBOdbzuE+XupZwDNfMy+zpZM7Dmh82zfF4zGF2ZqQmmgpnb3lWpZtGnc7hRqXBJIx8eiJxNrRU5NmalVMr9gt5LEDAekXnWF/TDAMl0550LOt8/Vp5vZpFqKKzTf4jXKzTgK0P5dEYsaqSeohhmmdqZZfIS2qIEM3n+jXVZGj+5E79EAcfkbZmiLh3BmogHHAZ9a9oEYrryqaoBz4L9DKbk4UsI/3LKycSqPBrp4rUWethE86JP+P4DPLhrBAUc7qx50U1OuFKNPiU/xogbryLJ3Jm9USHOeJO4TcjEQC3zdSJbkRcvnNlUun7WVxDL596QxD9u2VNKv+hd3gcBnT5z9yf5+3YmA/nb2vbRl0qcAUvu8VowfcO3w+zbbQ6A2uX7BWK2+XrJraAiddAfn4UtEIO7U5X/P0xeNldcEYcWF1+9aM6TNm5zmXgIvmXZRXGEB4brw6JPk9aOuWcWHi3uxChnal/Dr+HgsBgnBl6gHe64I/2d4dSOoRIdFKw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(40480700001)(54906003)(316002)(86362001)(110136005)(44832011)(2906002)(6666004)(478600001)(8676002)(41300700001)(70586007)(70206006)(4326008)(8936002)(82740400003)(5660300002)(356005)(81166007)(2616005)(4744005)(36860700001)(1076003)(40460700003)(26005)(336012)(186003)(47076005)(83380400001)(426003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 07:15:44.7699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 052cf7f7-684e-48a3-b44f-08daf46cd24b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds initial TTC PWM driver. New driver would use same compatible string
as that of drivers/clocksource/timer-cadence-ttc.c.

Specific TTC device would be identified as clocksource/clockeven or PWM
device based on the pwm-cells poperty. Clocksource TTC driver checks
for pwm-cells property, if found, it just returns without acting on it.


Mubin Sayyed (3):
  clocksource: timer-cadence-ttc: Do not probe TTC device configured as
    PWM
  dt-bindings: timer: Update device tree bindings for cadence TTC PWM
  pwm: pwm-cadence: Add support for TTC PWM

 .../devicetree/bindings/timer/cdns,ttc.yaml   |  25 +-
 drivers/clocksource/timer-cadence-ttc.c       |   3 +
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-cadence.c                     | 363 ++++++++++++++++++
 5 files changed, 402 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pwm/pwm-cadence.c

-- 
2.25.1

