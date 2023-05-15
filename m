Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153E0703C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242575AbjEOSTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242611AbjEOSSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:18:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159A716EB3;
        Mon, 15 May 2023 11:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKqfkQouHx8aolmRdimYimnwiV0GakwOOdnAiXBDjrb0Y6AQX6vPmcZVVaWekuKbaOQb1MacfaqwVJc8qsM4CayGLHg6VMSuOXK29tOMdRHXuK3cpGmnFvP2zTVw16dLNFUK8htyDm+IlRG/MgcNTvUJiByaSPHobZio9+fBU6YBcH5vmSrazAXXJG9q5K1fs2TwUuTLIMauwy5rvpRmtyoVAf/Wvn8lLTr4jgy55kEMrRM7p6RqFLRhFb6WhtDvfIOm2RO1yVsUqoTQbGFEJTKZwQiULoRzUL+3aCQYuvEzeHN3czhMRcWv4J+9Ep4JuFFChRsB+jYPdqTF6E7DfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIubGDrIH9WsgjmR4Wgu3KJDHt1fcbStapKRe3AeTHk=;
 b=Q8x/EeYmmTFklopeyZJYw3fs4a62BPrnani0+QnLqkvXkVUcofl+fiweAN1+Ic66FQdY8N1Iy1MYhgabOucFgqCzCqoqQB6ogXknfUDjhTSTgj4HvsD71xz0cLzvqY1YQMmVAJ3OL4fJiDOvKy6p6G8u1CxUjtKWlj5M4VRQzYDWIXgmZSobyCiT6AQT5KARuysasFCwISg9JSWOUNvq7NAxkObSwvwERqOOyME0qL6hI1bu8Up1BC4SS4oBEhjixA1nkhe4K48aQiFAcVQolOPorGpg/UoNKgf/GsZOmNN/2f1KE+8HAXBG/18W9IWxyX7m2zk7kdtNh3cHcU6O8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIubGDrIH9WsgjmR4Wgu3KJDHt1fcbStapKRe3AeTHk=;
 b=gN23F8tP4HF9WUqUbf48NetUOOFy4Xb4cJy0kSIX94LpYmEGq9fcwqrwXS3ivR6r6ve2er9xMrSd5kBqIrkLvo3AZlmIx7sXW5OAiXjreziP1+VCXYSkQLyca5P/RWw9+bOYxS+/x9cNhSGXNw2Xwpj0pvNcKVCAqf9WWMtxH/4=
Received: from BN0PR10CA0014.namprd10.prod.outlook.com (2603:10b6:408:143::12)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 18:17:11 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::8c) by BN0PR10CA0014.outlook.office365.com
 (2603:10b6:408:143::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 18:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Mon, 15 May 2023 18:17:11 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 15 May 2023 13:17:07 -0500
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <davidgow@google.com>, <gsomlo@gmail.com>,
        <gerg@linux-m68k.org>, <hal.feng@starfivetech.com>,
        <hasegawa-hitomi@fujitsu.com>, <j.neuschaefer@gmx.net>,
        <joel@jms.id.au>, <kernel@esmil.dk>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <p.zabel@pengutronix.de>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v14 4/8] MAINTAINERS: Add entry for AMD PENSANDO
Date:   Mon, 15 May 2023 11:16:02 -0700
Message-ID: <20230515181606.65953-5-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230515181606.65953-1-blarson@amd.com>
References: <20230515181606.65953-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ee47a4-10c9-46b2-119f-08db55709a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IG2H88g6A0LKVl5zVu2UaDASgvPcydsB+tEYyfp/FXBRX0pCC4ghUSJeyWnpxHi/DrzClmEqay7zQ3+UwCVgFJy73LBCz51m26ns8R34V8Y0jZSonzRS+Rb7foR47qBN7HVf0JiJ1bNDmZCneeaIEzdYB71SXnsMcshH4Uf74hdc9+1cTkugS5QiiAdgDijiKy8fi2aDaeIvM6TQJmA2Jc1l0zUSKowwoWSZTw/6qLAwQmOhxHsC5PWTVkv1zEURdFVfDwNkvh0TFM/pnsbJg0gZDmlno/aYj7jLoewNASw1Ew/esXqF7I6z2cATHjTlSEPASP25Vqg0Eg80cUs77ZXqk728O75ARvTrdc9HRqtfQXC7mpg0tzbLTVuW3WaTz1Gz+enBybTZy5vfVoKLG+45yuFWwIfG4/2qR4cMNxt68HlcnS5vDOWkk5tzsNlhW2qwbbJzBpJAPgxY8EYqm9q6pUqoKspWE/QgXERRb4sHDT82TMMVHTVJRe/y40HFCcEhPEu0fpP8IBlAZpYmFgM80tv59V+GXq0WAqnCTIICV06L06ZCpPzG0LTto2DbQ1i2v5J2iEjR5U/2MVZdf1aRySJ3lV0Cq6PttDiOs6pyyWIpcQqfaBnsVk1IHnBFHcFKzxzyb/RMKJH0Tqs+EuF1WhjWPUsxOoSBGfXie0n6JAonHxtl/bJJUvAdHqf1Wf4qF1gS4chGJzBx5bLLGQAdU/IVe7/T7gywGE4ufX5W9cPQCKrs8nY0bzKeuCZBhtMTMZO5cE1kn/6POBXh9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(83380400001)(82310400005)(7416002)(5660300002)(8936002)(8676002)(7406005)(356005)(36860700001)(81166007)(316002)(47076005)(4744005)(2906002)(426003)(336012)(2616005)(54906003)(186003)(16526019)(1076003)(40460700003)(478600001)(26005)(6916009)(70206006)(70586007)(41300700001)(6666004)(36756003)(4326008)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 18:17:11.3996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ee47a4-10c9-46b2-119f-08db55709a2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
index 638d83d5e135..28483bad27c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1883,6 +1883,15 @@ N:	allwinner
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

