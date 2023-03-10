Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C066B5095
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCJTG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCJTGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:06:50 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E7A1308FB;
        Fri, 10 Mar 2023 11:06:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSEJbTfEm2rsLNFqtDhiahYXKq7C9nX5AnFHC20qzJiLTvOGJ1uRpZXirmQHDJcYX7QasLUGshEEyHpJ/dVEd1IUkFYn6HZG5WTAa6ZKLBXW0xedNADethDmNb2KaLbEtYGEOXQtnZrQx411ZT79IsigE0tI/43D6c/94U3ftk+CE8XxiA3+myHzJzGTMmEf9THaRRTWisELXwjeVVjpkztcPOnPUscBNRamYpsMiw9JQ5ExSzrakVVO+GYRSIco4QrMFy0xMS3WGQWBcvVKzuY0lENFaz1Yo2BjkapZkT4hybRu7GyJ3baxDYN+vjs0+XP8NyEsNkbm0m7r+4agDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjFx6t6ewKuT1HROZmJBJ4zFt63V8v16WCuDZSAYzhY=;
 b=MvUhZXpG0czXMB67hnVdqnZZuS6lUMjS5yBS8pTOneUTN1m6vAKuJDrvlsQsJBwz9ISxlpVCEqlfundpflNCqxV3pNWqH9SN99XOBh5IjvX224uZCuwDrw++98aU7cSncbf2f3z+QejNF0F4RkxZ3fXi6CO2PujoDzQ05QpaDQQ6/oJyWJe4zjRbVMQV8MLvb5fswAPSCo725v6jW7PfOr/S5PlmRILlvxjaFyL5tB02uUWhQiG78JBbfzejGu4dpyfErrr3SJ89Kmk58gQe4G/5wfEOsFmmyzJFeRmQHSOfZ3kTxAg+ec42wZMwohzb5iautoNpP9g/iKjJDVX6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjFx6t6ewKuT1HROZmJBJ4zFt63V8v16WCuDZSAYzhY=;
 b=IjsTctKaJtkGaijfW1rZ2oZQBmy2plpy0+DpYtM11Wacktdw4g7JomygW3WLsyUr2Ap9sOdwGBYHIkB+AJm4PaR3qCxbcz4FFGquITGYk/UelqYthNFQv/ogT/gpdthj+/5u6XRcMEHrC2XklAjyrxcTHlsMfwIKCG9QebqdAtYw2p32llAcgzsV0B/JD6B7UeUOWF3ZAesDultw1Qq1XC+hl0QMO/7ovPGvX0/yUErycCkHcl8HIcea5XKm7ZlIQGCb/Ep4iLN722Tz+XkEeTh7WAS6xYi1HV7aHIftJNlHWCqJ4EvVAyw/06X47p9kjyJqphe8TmBVg6+aquBgKQ==
Received: from MW4PR04CA0257.namprd04.prod.outlook.com (2603:10b6:303:88::22)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 19:06:46 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::ce) by MW4PR04CA0257.outlook.office365.com
 (2603:10b6:303:88::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 19:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 19:06:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 11:06:39 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 10 Mar
 2023 11:06:39 -0800
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 11:06:38 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V3 2/6] dt-bindings: timestamp: Add Tegra234 support
Date:   Fri, 10 Mar 2023 11:06:30 -0800
Message-ID: <20230310190634.5053-3-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230310190634.5053-1-dipenp@nvidia.com>
References: <20230310190634.5053-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2a12d1-aa95-474c-c35d-08db219a9859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0LuXL6QZkZGpOchzl9frMhvOSPAUEpkbe2b10/xKEzJazqDh54TNklpqBXf2soHHt1uDobqATwahPgy3rbPBzbIRLKlagC5tsjDk7MQCRtGf7Rd1m1Vd1ZIbWa0duF2HUiHR5Y64u6fEqDLHDqWXB82eaSfjbOIlyZPL/mUMtf7WD2UL/tLXIfs1z6MdHcLh/pzgsS5FYqfHw543SbpeSHI9lxwYYumqCAh2OrIpyrqP3I1VApxtdpZfW5AV6Qqn1VLI8dLrJwb0DVr1cDYr0jt22Lg0zLprdxksMQW2JQPO1VOgLPTrtZjZ8yWpG8peznwhNub/gb8X3bCtwjffZD9iWISJHfVd0i2ko/MbIXQs33K4GPNFjNa6HnUNN3YR0XBa2Iy8xpIJgo618Utwylgi1WGm41E2zWgm/Vlp9z8q00RzjW8UvlcbFwYsUZ9mO9OKXt3Mvs1cG1aGmEz5exLxuBIgrcRTR5PZU1OHEeSv+buZ5I+Ih5yThavEftzy6kEvia6kR7ZcsxOsRtneGpTpXEauMKLl7lSRtkcoTUtzXnXr5z4MyLAgnIrBoPc6Qu0GLapyTs8kaAvJisHkWQC9FSYQc7nvvHVbvgxutX7TrQ2rSuvHmzZDjJNzx6DXkmQOqYJkRZ9W7PC0pRGAhsI8Z71gxka3jbwnXK9lpf//XoDgQu9iBMkgvHSyi4dWUJyMMQbQAFDGWzcpps1KuOQ9PYUgF9ink2xWoXOgWhCiIM85q7/25nfxe/1G4DuKY682Otxz04cHwV3ryUOVdDi1IkiNenF2KJSkBScioQpJREqyD17IXrTVIJ3veiy4ZKf8pHkWmF+EaxHcqW/kpB/GFFGa+Gmp2yvjqhrR6A637gfUh0NLu3tejdrFzSRCs945V0GeU5tPd62p/PliZA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(46966006)(40470700004)(36840700001)(26005)(966005)(107886003)(1076003)(7696005)(2616005)(83380400001)(426003)(186003)(6666004)(336012)(316002)(70586007)(8676002)(70206006)(110136005)(36860700001)(8936002)(7636003)(82740400003)(41300700001)(5660300002)(4326008)(7416002)(2906002)(47076005)(921005)(356005)(82310400005)(86362001)(478600001)(40460700003)(40480700001)(36756003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 19:06:46.6663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2a12d1-aa95-474c-c35d-08db219a9859
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added timestamp provider support for the Tegra234 in devicetree
bindings. In addition, it addresses review comments from the
previous review round as follows:
- Removes nvidia,slices property. This was not necessary as it
is a constant value and can be hardcoded inside the driver code.
- Adds nvidia,gpio-controller property. This simplifies how GTE driver
retrieves GPIO controller instance, see below explanation.

Without this property code would look like:
if (of_device_is_compatible(dev->of_node, "nvidia,tegra194-gte-aon"))
	hte_dev->c = gpiochip_find("tegra194-gpio-aon",
				   tegra_get_gpiochip_from_name);
else if (of_device_is_compatible(dev->of_node, "nvidia,tegra234-gte-aon"))
	hte_dev->c = gpiochip_find("tegra234-gpio-aon",
				   tegra_get_gpiochip_from_name);
else
	return -ENODEV;

This means for every future addition of the compatible string, if else
condition statements have to be expanded.

With the property:
gpio_ctrl = of_parse_phandle(dev->of_node, "nvidia,gpio-controller", 0);
....
hte_dev->c = gpiochip_find(gpio_ctrl, tegra_get_gpiochip_from_of_node);

We haven't technically started making use of these bindings, so
backwards-compatibility shouldn't be an issue yet.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
v2:
- Removed nvidia,slices property
- Added nvidia,gpio-controller based on review comments from Thierry,
  this will help simplify the  hte provider driver.

v3:
- Explained changes in detail in commit message
- Added allOf section per review comment

 .../timestamp/nvidia,tegra194-hte.yaml        | 31 ++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
index c31e207d1652..eb904ac2f331 100644
--- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
+++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/timestamp/nvidia,tegra194-hte.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Tegra194 on chip generic hardware timestamping engine (HTE)
+title: Tegra on chip generic hardware timestamping engine (HTE) provider
 
 maintainers:
   - Dipen Patel <dipenp@nvidia.com>
@@ -23,6 +23,8 @@ properties:
     enum:
       - nvidia,tegra194-gte-aon
       - nvidia,tegra194-gte-lic
+      - nvidia,tegra234-gte-aon
+      - nvidia,tegra234-gte-lic
 
   reg:
     maxItems: 1
@@ -38,14 +40,11 @@ properties:
     minimum: 1
     maximum: 256
 
-  nvidia,slices:
-    $ref: /schemas/types.yaml#/definitions/uint32
+  nvidia,gpio-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
-      HTE lines are arranged in 32 bit slice where each bit represents different
-      line/signal that it can enable/configure for the timestamp. It is u32
-      property and depends on the HTE instance in the chip. The value 3 is for
-      GPIO GTE and 11 for IRQ GTE.
-    enum: [3, 11]
+      The phandle to AON gpio controller instance. This is required to handle
+      namespace conversion between GPIO and GTE.
 
   '#timestamp-cells':
     description:
@@ -59,9 +58,20 @@ required:
   - compatible
   - reg
   - interrupts
-  - nvidia,slices
   - "#timestamp-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra194-gte-aon
+              - nvidia,tegra234-gte-aon
+    then:
+      required:
+        - nvidia,gpio-controller
+
 additionalProperties: false
 
 examples:
@@ -71,7 +81,7 @@ examples:
               reg = <0xc1e0000 0x10000>;
               interrupts = <0 13 0x4>;
               nvidia,int-threshold = <1>;
-              nvidia,slices = <3>;
+              nvidia,gpio-controller = <&gpio_aon>;
               #timestamp-cells = <1>;
     };
 
@@ -81,7 +91,6 @@ examples:
               reg = <0x3aa0000 0x10000>;
               interrupts = <0 11 0x4>;
               nvidia,int-threshold = <1>;
-              nvidia,slices = <11>;
               #timestamp-cells = <1>;
     };
 
-- 
2.17.1

