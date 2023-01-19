Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54480673030
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjASE2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjASEJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:09:00 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AEA6CCC9;
        Wed, 18 Jan 2023 20:04:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lobgojhzM8Nx1vENj7BysLpY7KIYJxpKKNjJJFmi816A8b7A2x0jKOu4cBy0N6U8V0AUEvS2mvW8hIB2sx5LsMSCEFKj9U87ARFGOtCcYcQHlQOrTPn6yV0LwilKj2NTY1KWNonc2cKKrnzLOxJm2vl3fz1tjZjgVJq0BAGTYAof1vlAyqhb6BpaicPcTLL5k/r7KU9+lxtM7QhQcrXGukbElfk497ZISgV0CNylepeD2UxHI/ce0qnQpEjlNdGpOfL5yuS9Fdm6jHo++CGbDfsZN39cHfF91Iq2JeCUa2DVgHtXGR590pYh3Ry+BTUN8Ek/TxcoaR+cLKeOVwLgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVkJKiJ32kgmrV9HwlRJqykEjqFOh7CBZW3HRZVDDmc=;
 b=dJDthTBZ0wJijKzmn7E2PzRItx9IncR7XPaJ3OgB9eT7149qr8ZD5jpWduKIefw3pB7tN5MziRMQv8BGTpPyaxGOs6b5beKWvGXRlES4/zeWCkP8gBA+hG/5E+niO7+hx6ITUZkUs8GILCLq70xVSCm/IjWoVdqrEJfxLbWIA1rPBoIxsAqGYE0aK6A2DWMtYI51BZNx2WPY7J7tik7qCjL5HMxmlO9ivYIaLOvf2y8hltPkjE6R6gM+QnagfwrUyis2eVKvyUPkoI6ZyT2PxXTjYCkpTgLqqJW4skI1pLde8m+KL1NC9Od1Nn7AnFkiR6GNJvfu26gu9sjvqFWHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVkJKiJ32kgmrV9HwlRJqykEjqFOh7CBZW3HRZVDDmc=;
 b=OhU6uXNTj/NJwMHC2DR3ua5mYgMMCF24t8NEFPE0F2gOnqTqBnsFtQOiFsS0BC6cTJ3UWJUT4Mk6Se2yaG/QPFs58g1lSABsATzOwYDSooxt7O5+oGXi2rscsiWeTTveWyu8jNNB4bQ9Gwhm0e+Vw2+RZGNjcIElPrsC9AE4QMQ=
Received: from MW4PR03CA0202.namprd03.prod.outlook.com (2603:10b6:303:b8::27)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 03:52:33 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::b3) by MW4PR03CA0202.outlook.office365.com
 (2603:10b6:303:b8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 03:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 19 Jan 2023 03:52:32 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 21:52:29 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <brad@pensando.io>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <brijeshkumar.singh@amd.com>, <catalin.marinas@arm.com>,
        <davidgow@google.com>, <gsomlo@gmail.com>, <gerg@linux-m68k.org>,
        <krzk@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v9 05/15] dt-bindings: mfd: syscon: Add amd,pensando-elba-syscon compatible
Date:   Wed, 18 Jan 2023 19:51:26 -0800
Message-ID: <20230119035136.21603-6-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119035136.21603-1-blarson@amd.com>
References: <20230119035136.21603-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddc0077-103b-4ca0-371c-08daf9d09850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJ5pOHxkzkOW6PEY/2NdggBVABewZAx8xt33+2JnvAA7bIjajqNeWU9L6WbbKIOY/cKcyBTZTjUVg8IxsFHQhY1srUAwJoTY3OzObezMWzZWtppkuIh8o3a1T0f2A5jdHEYbd5RfGv4tCLIYHHqfnLfGSck1Q5QudQu/tJG9qDXLOgyXJu3tz0zCWErXcm5h+VSZ/qo+aLWiFkoYKc51KEG9XaPfI2bgTkS1WIo/G178yRkN9OGsMNIwalLjbnI1tsq/x8MTC7ytuAquLh3VkK8S4cLf6SMkRwiCmnXe7X9ebaqB5NaG1se8OdJitqCFbZYsNePch0Qvi+m5qdWRKB178nalVrvE+r65p96ThlAn0e6gd5qNK1lD2/YgBllu8KRDykIvP+AtNP+OSR9KFhr0iXbMyyenYSsLKE1eWzBWraSLpfRGY8cASvKN33f2hX59fw6ZIaGNtzHjlc88MOeKlFsidCmx+DT+HjYLU65wDj3ry7i8STAnYZN8du2/OeGQVKUonVVinQnwhTWAYaGRaXu4tQPQe96Wvh7vuavFv3dy8nvjRsyJ/2yrzlGyQCsD697G5vgy1Y0nhHpWnme3xFhQ67S5zx3mN5cN0ttMg0kzzIMKsCTKNOrwcJ+t81wdqv3lLsxlPzNMVdhHvV6DnEP3Sle85NlVcOpiYTIDwBZL2k+iLrNdCMA01dO1E/0eQznrYYiP8Key/M1lzbN1s82r/EkEjP3YE3DH5y8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(70586007)(4326008)(2616005)(41300700001)(6916009)(47076005)(26005)(426003)(8676002)(186003)(16526019)(70206006)(82310400005)(36756003)(5660300002)(336012)(36860700001)(82740400003)(478600001)(8936002)(40480700001)(316002)(54906003)(1076003)(356005)(4744005)(81166007)(2906002)(7406005)(7416002)(40460700003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 03:52:32.8535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddc0077-103b-4ca0-371c-08daf9d09850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the AMD Pensando Elba SoC system registers compatible

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Brad Larson <blarson@amd.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 1b01bd010431..f4b0ed4ff03c 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -38,6 +38,7 @@ properties:
               - allwinner,sun8i-h3-system-controller
               - allwinner,sun8i-v3s-system-controller
               - allwinner,sun50i-a64-system-controller
+              - amd,pensando-elba-syscon
               - brcm,cru-clkset
               - freecom,fsg-cs2-system-controller
               - fsl,imx93-aonmix-ns-syscfg
-- 
2.17.1

