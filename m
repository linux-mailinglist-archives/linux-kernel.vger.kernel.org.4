Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B705B3C6C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiIIPx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiIIPxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:53:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF398F16E5;
        Fri,  9 Sep 2022 08:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihmnFSTCdSEs7EGiZyNQeOWsEN/Qu/yXHtbMxZKiuJDOu5MkgndL6vP6D7zAZDGPbmgjD8eFvJh+4Y22R6zQbHz0VAD4rpAFQQfmbJZoMMxrrxLmn+YzevTxMKanCNn9UIkuSHckoS3WiftNVK1Q2rq8VTfSMnnCeKvuXlLj6jF7Djwiom2xWaEzmQj+XKLn11zEwYktLhLx4vrWwbgZfDEuCM4L1XjNzVCYg2XtdevvDqnz2b4uPZ28tJq7Fipz4SmJgUWf8tioyR+a1WjB+EeY8A37M9cxLCm3iWiqk2SPVKo/+o+LqRU34fV1jn1234i7hdCAzHdSEBPYgDVK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkGHmtUzmloTu2MJasQ4sGNQnbvxTpAUfn/QfMrFa88=;
 b=OHUW49jk6wJCa9tNlGIdYz4gwEMq0Eskex7WyVJU0HwAaX8iaxqXYnDjO4C6OpyJDSuzbrmi6bswGraK6xVpdlhEZS4kUllO3MwdznPKJfSzlOxl6SiDlVPnLd28ZGTHeon/y8xuelCgDZT6blLVCaox/AXW8JVa+mORfeA/9wYqxUlMLkiGviUlrzN4lvARNF4Leg2weTc1LBKgplYFhAchzqynYn1t4lsrWLV3ptf9c/s5uZUavblDAzJQSMLVaeAis6lIOjPHmJmR6sWdRNIbXFgsZY3Z5almVSAm+4feKqcdgPjNB5k0re7FYNzV0tdaue0A+m7zytEsEzhnKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkGHmtUzmloTu2MJasQ4sGNQnbvxTpAUfn/QfMrFa88=;
 b=njGWOh/aNONzTyGt3J+pa6geQS92agW5EWT+S4iAnMyX8h0dymupOG2DFn5v7CJSSOEWERff8Pa62G8BpzymosPLRsXnfNuJ5XDsa1hccm7+JYSgbNIw80N53boTW0uRBnTpCf6U59mjXGVFhm7VJbascUQ1Vzm2U3OifwxqDb72eskbJzEVHsrkFxIUH0YPZ142TQ2iEar99Js/MqY6dcaLbVo3BtII6ptjxurKTwAE9d8IkmWwZAmWmJRzCf1tpEtC04dDFKOPMRiWzMRvI0Y4fYdOcYHJw4WTYGrQu/CL6/GngxA3K99VCiv3cioZf1iGOhggUPdDKGTublb9Gw==
Received: from BN0PR04CA0114.namprd04.prod.outlook.com (2603:10b6:408:ec::29)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Fri, 9 Sep 2022 15:53:15 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:408:ec:cafe::2a) by BN0PR04CA0114.outlook.office365.com
 (2603:10b6:408:ec::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Fri, 9 Sep 2022 15:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.9 via Frontend Transport; Fri, 9 Sep 2022 15:53:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Fri, 9 Sep 2022 15:53:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 9 Sep 2022 08:53:12 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 9 Sep 2022 08:53:09 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH 3/3] arm64: tegra: Add user PWM support on Jetson Orin
Date:   Fri, 9 Sep 2022 21:22:58 +0530
Message-ID: <20220909155258.17908-3-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909155258.17908-1-spatra@nvidia.com>
References: <20220909155258.17908-1-spatra@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c75ff4c-f3f1-4507-eb6f-08da927b67ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7eoHYUFTeJI7z6S0BY46kCsAMv4nTyg0Jcef5/EzVs2/N3TmBxVjCzEN71R4KDLm84SCceU5UFJTYf218zdHF7BaVcqdA5ySOtzczcX+h+FNuDBuysuD8CVZunOXMTwi0qhteXn6GYWiPiGaKDb99sKY8x5447SUNT7knx5dyb8yheLjNT6iuirg5i9wg3u3BuYmZdj8XjnElz1rsCrLJM1uQHvS2eEMT0/kqPiGFHrGAlwCMp4NQeYAq7pSSY+wb3BQ4HS+wkv+U/jjWKYWzG4dA/Nvh4IKiZCnfVZAJzVByez4/+h19ZIso7UOk7ZKqGXSYhaM8xIdQkpjz9NVJXrs9D4uI3N3jvaNV7ckwYxNBIwORO5oXETe26ZjBpfhFkc8vW/StItwRA/Y3ekzddZmSxgKlJWGzMEh/rIYGtuhvXZsl2nP+ZQvBXDIJAa5FzQcpsSXVar08/S6V5yMKu4XzXLfESTAp8Fo4URDYhpmVTRf2IdOGpi5HCvkqmcTjsp9ASIE3pyQKtq/gi2nuh/8Ycq1jU4m6YF9vBDMvQPWMLEGHd9onojDN8Sj4Kbq4Gz0hHmhqkLHsiVv/bnz/iCfK+QNiRVfPJnOvHN3IwrN8nAOwip9qV/v3Dqpi7zcMttjM9JoTUIEaMfQHing/SSWljJX5Bw4Z8Rp7X8SII9O5uDNUNDNF26HkQyduegp8IogSgAhWwD8s5Kkk5SggxzsGI3p9WlmiwVpDTfss4gRq/RIWWEhIj0KeKe/UTptBUxVpLlNpRFBmCOdwSlZDN2AKz5YL0sJNQbAU9XTzoWlaGjmC2FVptbFzWWBXt4j1YtQItwaGvolFkYPs/D9Q==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(40470700004)(46966006)(36840700001)(41300700001)(5660300002)(2906002)(8936002)(4744005)(40480700001)(2616005)(36756003)(47076005)(7696005)(26005)(336012)(86362001)(426003)(186003)(107886003)(478600001)(6666004)(1076003)(356005)(81166007)(70586007)(54906003)(82310400005)(70206006)(8676002)(316002)(4326008)(110136005)(36860700001)(82740400003)(40460700003)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 15:53:14.6749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c75ff4c-f3f1-4507-eb6f-08da927b67ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable in device tree and use it to drive the PWM controllers on
40 pin header of Orin dev-kit.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
V2: Overriding by node label instead of node path.

 arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
index a85993c85e45..5108013a18c6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
@@ -3,3 +3,15 @@
 / {
 	compatible = "nvidia,p3737-0000";
 };
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm5 {
+	status = "okay";
+};
+
+&pwm8 {
+	status = "okay";
+};
-- 
2.17.1

