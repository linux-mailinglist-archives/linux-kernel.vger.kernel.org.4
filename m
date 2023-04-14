Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89846E194D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDNApe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDNApN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:45:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11hn2200.outbound.protection.outlook.com [52.100.171.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4C12690;
        Thu, 13 Apr 2023 17:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HC53oMDuyyAcB5ZyIyaR13anTOEjlQlpdBiifYKqJVMnm0OUHBJXGv4Rf/uEz39RqP1phYDNEH6eaFfLO/eKKVYjHi6DfaiUC6T8oezGauvbmhKDfmxUbyn181Q8FsA9Hke/UXaH57so2V6OtHBg2tY6K9maC0Ac0MaNyUKezoBEukh1ufuqnqHE7GxGfTfnxQkOiVlLKMAiuu+wcT08Nev0CiqEirELb9dX8uEv66wnp9JTgu3nUSEHPqFASZyOaFOT/fbUmMKMpc6ut6ctccNqnskx7TvM0zssLR5HaPeuFgMmWq3Jj4OsXYIDs2fPN5BQFiOplsBOZUjI50JIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToLO6wYFpDWXzwE1dY0cODM/gErn+QWn5+et8Lsr+AM=;
 b=VhCu79US8gXgP3cjw97B5CJN0Xru2ggNv39bR26SbWID0HwG3meKhuRaV4VdK/yGL0AjSP+TFNakVIzOHIxIHvpwb2+SP0UUHmsa+tUerJdEV3hz7Hdc15068bN3Zea1pif6Jawc3iB6OgEUtH7tsAEfBl8+Nglo7ob9gwprTaEuQq0XFjqpbPu5+DA/uEqJvOdSRnVub6H4irgxnY0OPD1DkdE22u2SWY90S2lG9DP8Ja+nEysRfnjrUEDMhdwL3bWFz6tc7PgQTWmP7Nboir1n5YqPvU401tOaUGh+lGJuE05GfaCB2nsvu6zAl9hU7fkPvCnUU1byEpBPRPh8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToLO6wYFpDWXzwE1dY0cODM/gErn+QWn5+et8Lsr+AM=;
 b=MAcvztDUlArnZ1lG8ezFKTFcan45hLwPCZlb5xCfwMokZdymj5q8nP7ppvcy6nUbVF4Quze9y5DwFuU6UsYwpVOrom5TxgD6mK34bg4DSlQKzQsiN/UYD6Q40eTyNOOqEOMKsEqthT+ykQRaJKV0ezeY31WdJwTdEsmHJoikdHOxkK/zflhrDD/0jsAzNUpFuGQFjrtRSoVGQ/w9WcU/cMJQnx9wiOPkN6iFm5fBV1p8m7v23LLTeHsswEn5GbYa2nN6fFyOWQYa/3CIJwgwIMQOh4xbSuAPSwpIcBTwGWBu5i9iVCuwFXCWKqaXoD7GAuA7kz/gi5+tqmh+Gg3/JA==
Received: from BN0PR04CA0090.namprd04.prod.outlook.com (2603:10b6:408:ea::35)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 14 Apr
 2023 00:45:10 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::a5) by BN0PR04CA0090.outlook.office365.com
 (2603:10b6:408:ea::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Fri, 14 Apr 2023 00:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.32 via Frontend Transport; Fri, 14 Apr 2023 00:45:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Apr 2023
 17:44:59 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Apr
 2023 17:44:59 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 13 Apr 2023 17:44:59 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V6 3/9] dt-bindings: timestamp: Deprecate nvidia,slices property
Date:   Thu, 13 Apr 2023 17:44:49 -0700
Message-ID: <20230414004455.19275-4-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230414004455.19275-1-dipenp@nvidia.com>
References: <20230414004455.19275-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: fef9fab7-12b3-4c44-b272-08db3c818028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVoYMJv1+fSKkOGevZ42Zg2MPhEbRrRcn4NwaFdngekzJbNEK92e5KvddwfeNBlON0FDbqoOOxx41c50gj1BeNUCIVcsNhavtFLTYLeflmv3wwRVFP9Z4N25G4AAAsRgjeJFPEdOFuyWQcTLt+M8tL0bLxTQ4s8IMpB6xtx04HCp8vDOyBtyisIr/ngR6/cjhU+yrAsIbwY/zRJ9rHcaZaepsZQtC9IuYUm45rEk0BNgncs9l+ZSUtmPytzP3pXvT2yoIjbfIH8dH3pX5+W01SX1s7sTYL5qhv9wk62FBT2be9UKO5wpRY1RCYqxJ05KQqs9W2/iQD9Y3asxB7HGKST/KFneYTrCVlda8OPPmOJ+9p9iaM1bTwI5i/7SltLFiW9ioVnqqeyuCPFns0AgvdiiDkoZz5wQsR8DFO66DjNRczj+PP6R93tfbxUuqc6n8DWG3fbo4Z1Iao3AA8tgSP3CsXHQYSAUCH0Py84JSK9Qv8AxTkKAAsBf84gLdm3emN2R0wpQYWxKRHD/6ZS6lyGe88+pf1NH28sni31PB5rh1ZZC9GVHlCW8oTNlZA5zdED191FZrdJW0mpF4Ll2JTS0p/x76ndVOcFCqj/GUmKRW4YruCSriPsN6FeFMA5gAhIy56QG3vUfGAv3eD6Va/BzsjdWx672mMSGumFZwEmrive/w/F+T/e8A2h1F5drTJw6gGbh65h7syEQnIqDklZ71Gs55DQR3NrDznEpBHzfxsWvGkZ+UvDbTa2QQGCiq41SmlCGU2AXYfnxYaJPql466MTtSgeSIsLgeG/Paty2wkTnV7TUMwiOsR2ZGwL+eiZy7QtXDSzxbmSGQHQrqw47yluXECKiDnY2yJNwc0qOFBTgXqL6mNglJ6XJAC21
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(5400799015)(40470700004)(36840700001)(46966006)(36756003)(86362001)(70206006)(41300700001)(70586007)(316002)(110136005)(83380400001)(8676002)(4326008)(7696005)(478600001)(40480700001)(82310400005)(8936002)(2906002)(5660300002)(47076005)(36860700001)(356005)(34020700004)(7416002)(82740400003)(186003)(7636003)(921005)(26005)(107886003)(1076003)(2616005)(336012)(426003)(6666004)(40460700003)(2101003)(83996005)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 00:45:09.9780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef9fab7-12b3-4c44-b272-08db3c818028
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property is not necessary as it is a constant value and can be
hardcoded in the driver code.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/timestamp/nvidia,tegra194-hte.yaml           | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
index 5de1eca9cbcd..456797967adc 100644
--- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
+++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
@@ -42,10 +42,13 @@ properties:
 
   nvidia,slices:
     $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
     description:
       HTE lines are arranged in 32 bit slice where each bit represents different
       line/signal that it can enable/configure for the timestamp. It is u32
-      property and the value depends on the HTE instance in the chip.
+      property and the value depends on the HTE instance in the chip. The AON
+      GTE instances for both Tegra194 and Tegra234 has 3 slices. The Tegra194
+      LIC instance has 11 slices and Tegra234 LIC has 17 slices.
     enum: [3, 11, 17]
 
   nvidia,gpio-controller:
@@ -66,7 +69,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - nvidia,slices
   - "#timestamp-cells"
 
 allOf:
@@ -123,7 +125,6 @@ examples:
               reg = <0xc1e0000 0x10000>;
               interrupts = <0 13 0x4>;
               nvidia,int-threshold = <1>;
-              nvidia,slices = <3>;
               #timestamp-cells = <1>;
     };
 
@@ -133,7 +134,6 @@ examples:
               reg = <0x3aa0000 0x10000>;
               interrupts = <0 11 0x4>;
               nvidia,int-threshold = <1>;
-              nvidia,slices = <11>;
               #timestamp-cells = <1>;
     };
 
-- 
2.17.1

