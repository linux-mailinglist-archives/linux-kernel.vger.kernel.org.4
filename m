Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96276B509B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjCJTHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCJTGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:06:54 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E09131327;
        Fri, 10 Mar 2023 11:06:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIi4Q8i0kXEl0rNLLJVnceLPzBkqDpcgxo5KGePhH0etePeT/Pu6ur2IzwGErN8+tG9XY7hFPL+RKJ3JjktKCwXefapUmOzZLrx8zMLj7QiNIe7vJeU28/DqhqS5bn7qIuqoR1JUt9bzdhzy3gfVaSylrgbR76ks9hZ3yh5rR5nJgFMXVXA6cynw0hHFb09rGvgcTZiMTwaWnpqaYsnqRw/EYFN3iokNFiU+fr0lLdyo26nODvBMLciVXVoSIrSTl12aflbWPTIQz/oYWWiKalWYcf1QMmRnhDpQx3dvDJLE8q3/PwkzKCOKJ7pM0c0tDvBTpxexuO9Squuhnor5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Osn1hOJWABaVRqTxJpPMLdffeaDIshnqybP9iTtHLOc=;
 b=AIwHiV8x+jgKlHDe9zfiKJTvLAgh1204t2GYLuSvFJrbAR2kwHiVdkmoJaDJ6FzCCxzlZUYkOTV20wMXdKl31x7ncelHU7W6GmEJ/nA2kVQI6Ooant8rJsVNXLn9fZ7CEbiRkebulgvcUxptxi0cHCZCFsMu9+zNfEku5b3iOJBjgh/kvu14ZrJstuC8oTiVEJFAuFVDfXannDPQrlCi7dMEMYPH8GXJ6xcZlbvIkTNmqfjklcSVmXPriCA83Qy3+0VlMNGUDoeBwtWptt8k/RFbnYJ6AWRio5GjRmHzoA49qi3AFMQp7Q2GYLqQnNokNDzoIVSnURR0dbqImTKRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Osn1hOJWABaVRqTxJpPMLdffeaDIshnqybP9iTtHLOc=;
 b=H3vZSCEtezvf2KYqDPrfyZIfAK9o/mKlVv03kg4WRh6R5fG08cGt9dHwY/YzRXOpuDIDUB3e1u7PsX4xqrInN6/X2TRW+XHvVNW39uldM0mgkqmKSADeZrfIqWSM5lfdx1gVlG8RMg9cbZudX8+e84arIzgXb204r6WIxiDtJ01ZK/0c55EKxThchpKmQjGr5DPz89rhFUHMoEQTzIhIdmSdu5CY3tnnP/QJ31E54zW34xsWtoWwiv2/HRrsWmJxhq/J/Z9W0r8Y7L8k8bN3mKXyii2KWnbmNtT6r4thA94//s3Cus+vwXboa9Hhqwrki3GejOXLPdFt+MIp1SBX3A==
Received: from MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 19:06:49 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::9f) by MW4PR04CA0215.outlook.office365.com
 (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 19:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.22 via Frontend Transport; Fri, 10 Mar 2023 19:06:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 11:06:41 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 10 Mar
 2023 11:06:40 -0800
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 11:06:40 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V3 5/6] gpio: tegra186: Add Tegra234 hte support
Date:   Fri, 10 Mar 2023 11:06:33 -0800
Message-ID: <20230310190634.5053-6-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230310190634.5053-1-dipenp@nvidia.com>
References: <20230310190634.5053-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT068:EE_|BL1PR12MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 917ed2f0-bb76-4b3b-eefe-08db219a99c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZFyzOkhHOeJdte8rGP9MbS9I+T3DJK/7oAQeLZFdmElSRclIVZjQAfYOObLZbvKPh6Go9ESL1Dlv82hkSjlhqazIbkfra4axU8BO1PqCUDAIt0V9vVX6LZVKWp3TDfnqX24uFPNDmrRx8zQ1/jYU7rQWI5XP1FXTleXFagzqql1TI3x6suJFcfAoM7sTBGtHfLv1qY3wOW4UCfzS9VICJbzrxGIIEEOsYP51hXT0uT972twePOzaCB/btJrNXBzQMrcVa/17C6SGi1q8UdEJF/LALW3ovgfGDnwcnrVgQWkDX4Dfkay5uzflYDeJKy3Sm8l5nDAxJg1X3mhunpYupZ3VQyzqsqKBEyLyZroUwAb3Do6B3o2UDbHXBoTUIC0I9+MSdXtvbjE3IRwW2bPbWL2iQWjq4o233pmqJbVEWDZBg83se/L9cyxZNNbAbwPy56aAbcs2UF4RQgPHRRXg2io3+v2/N6vqhagtS89Lu0raZQoMKzzIqN+mkfh0Ao/OpyquJe2/W9Q9mD1vIfhZXPx+as8bdzvB3drvAPjhai0aeaSFHVk9Za0CaYsWtfrcFoILndEVxgpi+NEJZYYDvOEq9kx6eD7C3K0Nx+O99rUrgrdvGz7CNEcanR3s4rzLiZbtHB9fL90eA8Sd4rs3/VRVQetDypx2TdUg27Cz5YhaK4KsWSNMKp5htFoRgVrXqRTb/QKR8hyx1puUj6nXsGU9rK4AM8uw6A/chtNvZONpMh/KBS/Fiz05uuqZ1oo4l7ujEiWN4N50YY+c/T7FjmMFKVT2rkwqifmNwuyY9h4=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199018)(46966006)(36840700001)(70206006)(36756003)(4744005)(356005)(8936002)(5660300002)(26005)(921005)(7416002)(8676002)(1076003)(47076005)(82740400003)(7636003)(36860700001)(41300700001)(6666004)(107886003)(426003)(82310400005)(83380400001)(70586007)(336012)(186003)(2616005)(86362001)(316002)(40480700001)(4326008)(110136005)(478600001)(7696005)(2906002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 19:06:49.0413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 917ed2f0-bb76-4b3b-eefe-08db219a99c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable timestamp support for the Tegra234, has_gte variable needs
to be set true.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 14c872b6ad05..b904de0b1784 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -1134,6 +1134,7 @@ static const struct tegra_gpio_soc tegra234_aon_soc = {
 	.name = "tegra234-gpio-aon",
 	.instance = 1,
 	.num_irqs_per_bank = 8,
+	.has_gte = true,
 };
 
 #define TEGRA241_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
-- 
2.17.1

