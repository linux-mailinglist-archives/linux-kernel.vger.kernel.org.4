Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23D6C5C14
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCWBaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCWB3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:29:55 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B1EEB69;
        Wed, 22 Mar 2023 18:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AI79XoXBg+JCOF612kz0aT8HwbbEHuFD3ZJS4Jf8YhN7L4JA/wfyzknfuY5OzuXqkiddoov72FQMN+DzJu+6WpeEbyEPo4W2WvteumJ+cPCy1pMrruE9fhBPMg9d6pJhLRktudEg2ogEt1ipGgaOjGeJ8X9lVerOmnjaZMrydi5Hg+C8j3KMGoYvLyHrjHV56OTanPkQYQXW93k6c3Eb+UGBA/oCg9Kz3c9LQbRQYUheuq7cjKqEBoz0BP25lZnAimqvFraCDWx91u+VHZjFAj2jip6F2y1hpf2Tra7sb31XkuFRk1xmjTn5oIpaPlZ25K52LmnDgev0gcits94vwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP0U9I3hrgeSkY3oFuGo2+HNIsfA/g22/zH1rbrIPQ0=;
 b=Cj9Fw9Gw1hrikF6Z1cAQBTZejbbveuQ+uCZJ1Rd9f0fAlI4ZRv2THpqpDPaI5zUrHf1rwWhvCsvs4ziFnYgY4I/o8WrhleHlayV6l6NeR/r5viHbvN8jF9pq8BIgnV9LTwFY74/oPdC12a/ugOEKFWK1o4if2Fu38GI9PQV+50l3/45Nd6smRDxktDRnVcaF7V6bVFz3jR64RnS1W2CPT+ZHD4DiRm4ylmriv0/V09ipat+g6LASlAAGtqtub/l2xjoA7zhrb7XkFmw/xHiy0ilxX1B2IoXDmNwmz09LFxoLnI2RdQJ5B3yVP45cW8cp2OFkyQOw2trCqCpDAoTcdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP0U9I3hrgeSkY3oFuGo2+HNIsfA/g22/zH1rbrIPQ0=;
 b=RP3KtSzoZXru1qsAxpppop/nCD6Lpj2b/xX6cjE8bHUrxLSslh7zg+E5Tt3rWBjFM+CQHn6Gn34HEwVRadorLwGPyqmxf7WEUt5xiVxAQrzH+aMUIiwxrGhQlOMeR9w1TARMVmYqmsSE1DT00fyUrcaIkwfz9gUy7T9RNFEl8Jd6BMX686ehGjaS8itB2TflU0+PDv5m7xMVMn3OpZpfuV3pwFcMiOTQRpjNxnSLtG/yenNVhTR4DF+30+rVXeYsBgtO6mWtq45Rjrb///o7OzzuNzVnNVPDS2ueuV3lgaPJRT8RKdepiJLLTW3NJfuocBtEtdhcWoKsQcOGPAJPug==
Received: from MW4PR04CA0209.namprd04.prod.outlook.com (2603:10b6:303:86::34)
 by PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 01:29:49 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::fc) by MW4PR04CA0209.outlook.office365.com
 (2603:10b6:303:86::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 01:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 01:29:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 18:29:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 18:29:36 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 22 Mar 2023 18:29:35 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V4 10/10] gpio: tegra186: Add Tegra234 hte support
Date:   Wed, 22 Mar 2023 18:29:29 -0700
Message-ID: <20230323012929.10815-11-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323012929.10815-1-dipenp@nvidia.com>
References: <20230323012929.10815-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a40d1c-1d77-45fb-2a8b-08db2b3e17c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxkUABDqu6w5t7T+2ahx/4i5ow4ckfuqPCJsoYk2pJ+lG7DjrXvQ4u09eN6NJhicFmUqTdU2ZTMHWka+0/Fjpfq1emzQmB5pWLiNRGuT/ebvs8uThAnu8HzzCqye2wiLuzd3EWarb3Hb/4lUytULkpSvcqqoZSFZ7OIyS81GnmMSyJSBi0BsYx1sA4Vybj6TfUISqeXkytAIMzzgYR8SYJ1XhNyCfO1WisgeooKoxpyzX8Sh7a8/on9hPqsBMu9TAtbkBzQa2qzB8VOZYhq5PEJoZS4JwIeT4MPSMRh4EPLtAj6TqHngy5TkQ/PN7fNiJut/Fbypi4D5JbQySmjI8K2GNISWIxuQBLvLPdiWPhLQDlIALn14rgwK6LyERXvX0weObV5gWsUA3nk5Fejx9XmddQYVzD2qTweYCjFs/0VHZ5HJ6oVKeJT2Fgw6FsM8ig7hRkwBJ36YTq+s1vtP383uDs8e9mmHo3vYNjcjcsO8IuSdlDCAeNJrZYk3adaYHC19hLdGwX+bDSo8SngcvkJIcNPy+wBsZ1fstSqIuM789Zkv5Pydfz2B53nSXdaME5NNJm5Nptn6is2X6AGr3/XuBYOUhN/dXylXlsfrblDntADZshsFmblfnFhDJfLXF/fyJ+dS/Qax5gmyCZBB946PcxbM/O6DcRbOSCKkG08MsNDITDZSJ/HbFV1Uci6Zt/Ez5prGHSbE1Vl1eXigZmmGwqlDE5ZT/1SZ+DuLU9XyDnJJYVhciH+QA+yb2a3pkpQa8v/LqiiBZN0U57iSqx02dWOtYOkrmaSnGBdmO9QvfJ5rnNEJwr5XhHIqatmN
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(86362001)(40480700001)(82310400005)(40460700003)(36756003)(83380400001)(70206006)(316002)(4326008)(8676002)(478600001)(70586007)(186003)(26005)(110136005)(336012)(2616005)(47076005)(6666004)(1076003)(107886003)(426003)(921005)(7696005)(5660300002)(356005)(36860700001)(7416002)(8936002)(4744005)(41300700001)(82740400003)(7636003)(2906002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:29:48.8677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a40d1c-1d77-45fb-2a8b-08db2b3e17c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable timestamp support for the Tegra234, has_gte variable needs
to be set true.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

