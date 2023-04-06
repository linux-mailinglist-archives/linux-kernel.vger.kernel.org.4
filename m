Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86216D9E96
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbjDFRUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbjDFRTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:19:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A838B74C;
        Thu,  6 Apr 2023 10:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxZLdjcR6OrdSkDlySlSIqGSSC61drOSYTUhW3cqF1LDnwFU78ER/o8PQi/cU2BvTgNGOKVdRS5m7qD497cAEfflyWrTQV7AmhZX+Nk1IdRqP2dqC86jLFkqiTVWie8ck84zygt7Rbd8JeDbf8QXryyCxAnEv7p+g7DgZrLVglxMzzWnbWymFaejAbiMzMUp5JWQ0dDGEjkQAtnCpJ1E1BpSx+q8xxrBR4JHPeWQyJX6jr52MhUfkYLvjUxBMJje79SoydiTj5x0CmID2cVlJYo+5+/qPFu2r4MkK2n03lbQ1eXlhVPMnE346x6dHSYz6NCqQ1ntxINeDcodfSc8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpr7mmBjfnZDPZpotB3Ko5DC5NCtrzswAHRmVD+pezE=;
 b=H7LX46BGNEqMSM7TzoZGQa9P3w2d9gZNAYYwS0cTiRGYVywhOBEgLfP7zjVypmX37D4VnDjf0kHBw/TC9h0TV/G3cMpuEbCe1OkF3JSyNPcol8a4IzRAX+uJueYr79HPDl3rQbOVcqoYP53Xg42i7/ohk7fD52EfesfW2fJcXMMKRU7dj8TsvOrVoxEh3Cx4hX/Olc1HI9NuysZKnMqGOfBeEe1R41OFXq0hUbun2eaAk/maD/pV5mpsmHxxVina7rTbYs+4yjaaCvvg1PysmX7Ftr9KDR9GaOBiUsk/SZ0ZErL648RgM3kgCzXDRfs/TliAQniVhnR3CaSyDkCtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpr7mmBjfnZDPZpotB3Ko5DC5NCtrzswAHRmVD+pezE=;
 b=kLj6MsE3k9Egr3XQlOpzkq0xZBwEm/hfozHmndb4Yc7wb/Ddxib5SoFtSmBDJvu7BkxRq3Wa0FjC720QXxpr1b4SLTicM3LPnga0AtEfAPQeG0c3hdyoYrUf02GT0tDiDpERFA815LVi5H/VVkEbR8S57cPoI72vStKr/9tvMlGhrNdG0UJY5+JMmn/R2+hFRStk8axnZAI+Kp00c9hHI11q3XlbiIlpUJNzniaI4arR3fC36vQ+2h5U0TPb8Wxim4qLg6rLt6S8G7h/ljXtz7SArzcCf/hs2hSH4IIogM1tU6lGcE54Os9XPDEgxeNFdWTPKOGFAmQreFfa/j2V/Q==
Received: from BL1PR13CA0359.namprd13.prod.outlook.com (2603:10b6:208:2c6::34)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Thu, 6 Apr
 2023 17:19:07 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::4d) by BL1PR13CA0359.outlook.office365.com
 (2603:10b6:208:2c6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.14 via Frontend
 Transport; Thu, 6 Apr 2023 17:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35 via Frontend Transport; Thu, 6 Apr 2023 17:19:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 6 Apr 2023
 10:18:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 6 Apr 2023
 10:18:40 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 6 Apr 2023 10:18:40 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V5 04/10] dt-bindings: timestamp: Add nvidia,gpio-controller
Date:   Thu, 6 Apr 2023 10:18:31 -0700
Message-ID: <20230406171837.11206-5-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406171837.11206-1-dipenp@nvidia.com>
References: <20230406171837.11206-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: f0189bab-b62d-46cd-5d78-08db36c30787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zUwQCusRD9naTU1onApIMIO8TjEbReIreBwBcAfHZ0uz+IPwNZAE3FK9cb8g4KNs3v5Jayqsw5EABOXYBmELOegkiLRkthEzrwVsb3TylXTcc8EFCnqYyULRSx/Cp7u2kLU0mQuKIh7YcsLCYXiXaUzB+zriUqhDRur0BsyfnnRFKfHguma7edF8CjIUe96Z3J28Onok3nxd1umLj83DTtmU7JhPHGMDoTIFffCVvZ6kNdoOBBhi9wdAPqXquKl1/2T9GAjuixkZAy5kYW65BbGEODU3cAp86l0Q83TbapAof9B+l5qriQs39rWSe8syzupJ6tK0XR9KnGzspt15sxAIINZorFoKeNAqOF2FGV12dzabPZXrqQsn4SJ2hr/rM2hChQznd/t349Q7Y0OLm2iwUOiyXI7Z7qN6H2tow0fgxDF5CMsg3pPpudDiEm1UtGP49lilIloobAoVH7oTy79BXVKKV4784gQ+OBXpOZztcvQQjcSbr2aACK6KvZnEJl+byjuCcEeZ40vl6LVj0Q7oM8jZ1JSyp0FwgeyO2ztdXj2UDpJXHU/e7rZDFwjt68OM8a9xTkYUnMfIbnY3C75jnV4kmtInbqN7Xp5IhXE4G56BrygK48XsSx1MXkzpbEu1ILCxPwkzBSzK7N3DHum64ZOF0AMgzuPUME6sajYWYJ3WCbkoyDMsqmkb5/IYtUZlduxAab3jQFEGDtjLEXBd1+NZXZzDJqBGjunI/b7kgAllO18P9OnTdpkCj71giC2EQZrDw5KvuENIHKD6KXhSlxeweYjmoluuXpk/KsDKpk9VaxqRoEg9rLx6uln
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(82310400005)(7636003)(356005)(921005)(40460700003)(40480700001)(7696005)(86362001)(36756003)(6666004)(186003)(1076003)(4326008)(26005)(107886003)(70206006)(2906002)(70586007)(5660300002)(478600001)(316002)(41300700001)(8936002)(7416002)(110136005)(36860700001)(336012)(47076005)(83380400001)(8676002)(426003)(2616005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 17:19:07.3860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0189bab-b62d-46cd-5d78-08db36c30787
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tegra always-on (AON) GPIO HTE/GTE provider depends on the AON
GPIO controller where it needs to do namespace conversion between GPIO
line number (belonging to AON GPIO controller instance) and the GTE
slice bits. The patch introduces nvidia,gpio-controller property to
represent that dependency.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../timestamp/nvidia,tegra194-hte.yaml        | 36 ++++++++++++++++---
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
index 855dad3f2023..66eaa3fab8cc 100644
--- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
+++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
@@ -51,6 +51,12 @@ properties:
       LIC instance has 11 slices and Tegra234 LIC has 17 slices.
     enum: [3, 11, 17]
 
+  nvidia,gpio-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle to AON gpio controller instance. This is required to handle
+      namespace conversion between GPIO and GTE.
+
   '#timestamp-cells':
     description:
       This represents number of line id arguments as specified by the
@@ -59,6 +65,12 @@ properties:
       mentioned in the nvidia GPIO device tree binding document.
     const: 1
 
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#timestamp-cells"
+
 allOf:
   - if:
       properties:
@@ -94,11 +106,15 @@ allOf:
         nvidia,slices:
           const: 17
 
-required:
-  - compatible
-  - reg
-  - interrupts
-  - "#timestamp-cells"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra234-gte-aon
+    then:
+      required:
+        - nvidia,gpio-controller
 
 additionalProperties: false
 
@@ -112,6 +128,16 @@ examples:
               #timestamp-cells = <1>;
     };
 
+  - |
+    tegra234_hte_aon: timestamp@c1e0000 {
+              compatible = "nvidia,tegra234-gte-aon";
+              reg = <0xc1e0000 0x10000>;
+              interrupts = <0 13 0x4>;
+              nvidia,int-threshold = <1>;
+              nvidia,gpio-controller = <&gpio_aon>;
+              #timestamp-cells = <1>;
+    };
+
   - |
     tegra_hte_lic: timestamp@3aa0000 {
               compatible = "nvidia,tegra194-gte-lic";
-- 
2.17.1

