Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAF66B626B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 01:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCLAqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 19:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCLAqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 19:46:37 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B05C3CE3C;
        Sat, 11 Mar 2023 16:46:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6fq5ESwVTG/N6V8hSNQSD1O2OGiITjpDOch9GH9xf3mKfEQujgHnDTOfch1jOQ11eX6wW7FQxl5lSdZPdzQkfEiv4LU+ZSCBq/Cg+cw6/BTKqN4EgtSOgPKZAkstAkdxIXPIr/QUplP8uVbkbTXLk36s3puL/m6MIyPNkC7ZAIT7qBMwHKFGMyuMkf2fMwd6wAJT6axvcmkFMGVWXEi/L1XVIhv4Wifk0wnzqvbkrMuQaicmfzkGf4CrWCdFwA0Dz3/cL3RTvLgR4MN9qzEtm0ipzdPQRYdPPOWBrqg6suVLi2bQjc6qyFKE/KFeKxubfOdPZz2F7RWD38VgrcWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d82bpmyF+6P+qy1C97qBN4cXmEmhjcPYdPiNzeQJ4E=;
 b=iup4Z7wOWsf42sBIDWz2fF/njTzHYKdJdZDy0oKtz0SSd59xIzktx+WcjNs6B5ZjCOsGiPSH4+rRAmL7r1aQaP2W2HLdOZIQyW6EaFXCJi+yiN+Ib7RkFr1niOXGW9FvIKTUcKChfT3j3ygmO+c54lsIcpLBOw9uzJpB5B/13kwy/TG+WpWjQ68WdxMegi3tjj02gRyjHBV7Agt4bw6r9iil8ZQNV0dImn7YEBKn30ts4I0kNRUx2g09lyURtt5VT7VcymNQJWtr/19bYjuML6j4DTx4VKJs6VQZb7t/fikXh2w/Cq+tI5xQ7HUp50j3pTF6d5uCtCqbWwaSbX3XOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d82bpmyF+6P+qy1C97qBN4cXmEmhjcPYdPiNzeQJ4E=;
 b=Qw82+etmP5yLMw+6642tt2svlovFf8iQPJ1XSzR18I0ynL283xlYACora+TlDGuD+qN7Ne/CaJ0yNB7UeXzPXqmtPvPU1FjlADCNWJPJhUwCI9Gu9rL59INTcJ09JDC+L9WD2xqOlKKMlbzwfAM/jsH6auLULnnOSQ5o7nBPEBA=
Received: from DM6PR11CA0032.namprd11.prod.outlook.com (2603:10b6:5:190::45)
 by SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Sun, 12 Mar
 2023 00:45:55 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::36) by DM6PR11CA0032.outlook.office365.com
 (2603:10b6:5:190::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23 via Frontend
 Transport; Sun, 12 Mar 2023 00:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.22 via Frontend Transport; Sun, 12 Mar 2023 00:45:55 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Mar 2023 18:45:51 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v11 06/15] MAINTAINERS: Add entry for AMD PENSANDO
Date:   Sat, 11 Mar 2023 16:44:36 -0800
Message-ID: <20230312004445.15913-7-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230312004445.15913-1-blarson@amd.com>
References: <20230312004445.15913-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|SA1PR12MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: 83cd7601-2a07-4a1a-cd64-08db22932359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Drfx8opMQvb1iH/iumRDoo00YUJjG4M4G1W0gRpyCyhGI6OIfAfjiq2dv4yrC/0338TiEyVGAaaus9dcVVy8sJxeYif+jCXrWmhbP89rj4O1HPTeMaljeiN5H0nkL7ToDwwnCsUrOxgSQT4AF0NUdeEuwMBtDHaMbgdNajIjUdBP1h8xfgY9L14WI2NS38wJVqzbYeJjUjjIRFyTgxBcPBZZj+EYIxGNYCa+gb0hspjDBqmi07DAjOxGqSm6esWsBBL+NIs4mvBKtV38NYKc2bICfEvGkxkpRzJcLrdTYU8roIedTOSLphkAkXLqBvc5p/G+v9HMPk9vCZ6HCiYJH8LD5R0EUdzWODTrtbTkbNh2ciQJnvA6v7W9OUljxuuW+Vvikkkeh/1c/9y2JJrk1UTFsfuJpNLtaKxyUTmoEgqXrksdFVmDMhHURfPPETmPuCG+/uR953nv0ZJgusrTQXQJ1ejYNUDOusdEYdGASPVhY2pxcgGWELsvKWzvPryX5z6yKGWv1MRAG3e137EGE+BCMQUNajsdops9WiTBtd7dFaoqBb/62YlDWoxhnxs4QbE64A2ATeuwb399NszUBBU2iRgg7xXqF/Zi1hAsCEyCSZRUFTuklZRqjOzkNuakXf9dQKzJLDhlHpzlGRjV6rdSu1S+r8EFM4ilsM1LbSNw6QW2CNIEr/1tihv8FPp3kTqNpYIjQnqLFmg1ZAzz/39d3PGuND/jLeGoqXJEEqw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(6666004)(36756003)(40460700003)(4744005)(26005)(1076003)(7406005)(5660300002)(8936002)(16526019)(40480700001)(186003)(41300700001)(2616005)(356005)(6916009)(8676002)(4326008)(7416002)(47076005)(426003)(70206006)(70586007)(336012)(81166007)(478600001)(82740400003)(316002)(54906003)(36860700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 00:45:55.0900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cd7601-2a07-4a1a-cd64-08db22932359
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for AMD PENSANDO maintainer and files

Signed-off-by: Brad Larson <blarson@amd.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..5e39def215c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1875,6 +1875,15 @@ N:	allwinner
 N:	sun[x456789]i
 N:	sun[25]0i
 
+ARM/AMD PENSANDO ARM64 ARCHITECTURE
+M:	Brad Larson <blarson@amd.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/amd,pensando*
+F:	Documentation/devicetree/bindings/soc/amd/amd,pensando*
+F:	arch/arm64/boot/dts/amd/elba*
+F:	drivers/soc/amd/
+
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Jerome Brunet <jbrunet@baylibre.com>
-- 
2.17.1

