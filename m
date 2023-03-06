Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DF26AB552
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCFEJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCFEIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:08:48 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84941B751;
        Sun,  5 Mar 2023 20:08:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKDVTE4Tn2JRlrb82Nvwo4vxLE/VQo9BG6sJwXycWJ5zovwtkidm4gqR/tluMAY+pQq89xbVsDNeSFURRKEreYVU+WuLNGglmpQsY/5TL72Frh4SiFBYnWz8aN7R5jWY+wwTVFme4/2A63bO8wnLRzgM9eIkr4BPubBFX9oX21gshQmeoBjaGXSHtHy1lxChHempPI7qO/iEAqRl3udOBo4d81SpA+Gvmg1RKC2HyHQrSTum6BZhQwqUKwd9F/eTeosCn1z5lpzlT0rYkubUCQSYG+frAQBCHMb+xPbxu3TEsAJPTReThE8okP3LvUTzYQeNWNuER4j2ym7FFgIiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5U5yLLDArFJ9KRK+V8geTZcaXHIx+KJMkrxUGinL6oI=;
 b=MKc8rs6Os0H9v7HlPyErhIfKWBGnoU7bv8NZDdXUyiQ5SHK5on4F478EAwc9zHOX0jFR4cdDbf3lZ1bF6iJSa5d3DSU4eMRJTzHxHlCWHZbNCIBYSnieuSrt569X1EahWQWRfNqgD8XnDYzZW5dIjr3uR50YtXySIkFgdnTaokEuzQMy103BBpzJ3uOYvjDNRfMLxd8hJZshc4hqpW09ubgVfmjoZ4Ux3XgfVpJIw5NfaB2yUBmzKPWna4lzKUL8du1HqO69hmA80FCAXblKAtL1j1ICcJFplA4/VwTrq4Fgqoyi4g++b2dkrbjXrlKYQOSqwsvbjXAJlSVDfcN5xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5U5yLLDArFJ9KRK+V8geTZcaXHIx+KJMkrxUGinL6oI=;
 b=Ble8l5RpnUVcovjCmIg1pNOQmHsbX35/e2Hkr+/SI5Gc5OjVe+hF3U58RT2PRCq0bbDb57gvGMlmgvVS2ZScvXhOeSfVDXvPDRVfPi207bOREyR8Ls3Mvr9c5AX7WJPM2RlIoX6QJ7rm0EUQWQ1hwXgOoEJUwrsd9+db9sE2sNk=
Received: from DM6PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:100::40)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 04:08:31 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::c1) by DM6PR03CA0063.outlook.office365.com
 (2603:10b6:5:100::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 04:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 04:08:31 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 22:08:27 -0600
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
Subject: [PATCH v10 03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
Date:   Sun, 5 Mar 2023 20:07:27 -0800
Message-ID: <20230306040739.51488-4-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306040739.51488-1-blarson@amd.com>
References: <20230306040739.51488-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 46940115-6bde-4d1d-296c-08db1df87294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: srCkXfqAjokpape0R7Bx+ZR+Y4no58DhAPYPlOrZnF1OyfxxClfC/czbNS4MirDqunuXrOXCNt0+zZKE5Kalz0QmxEf80S0iCNhGZNKXv5W+1cOkgzxKIiMaLSoWgKHKEyaG1M8q0wNk/F7Oan9Q6fKuluJfUtm9RY6wl/ff3L3VyCHnzl1rduxZtOvOEevUuV89NNOfvnWDLACl5UOjNjC3OJRYZRdLHluuy/qux9aFYsJo8jysBQ5OiZg5J0w61KIqBHbFAoJbWyodKi2RIqjOvoTJEJbRZuwrOdBZgv42aFXKusjDeYRNmHjaOZ8PNyRut0nqXJavbTKlL19B6a0EXrwGyIXylWbypkjddObDP+Dz2uyig0+DbuVehRJprrlTFyJF2VunahfLHzohXO2oQR0GJSeW7oqDQXlOYeW3p9cj7aaXp9Pvt7r+/doNED0qdkjJtZHheWUChI4ARYe2yuptG0ZIKjbM9amzOWkJo0Kw2DORzxBQO16xNNnVYPlfxac6woznKFfoV5+OU62tvl+oCT8WdPzlLBdqh79YAJf62Ecd3OqMexOXSEPjf495OK8NouBbQQ1OVwbjubz6rM5Cg2xBQhmiqlipaNkcCkYhNbKD6LAUdgMy+WBDiU5+HAb7qxfD7q3ifYug/DcEVeqnPSa8vtPWz7FfRMdPW0see8CS4JMFGi5e4VXA4TJtzS2PnwMU1T2ILs0oC5T/XjHeK90lrVCxp5N/+2g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199018)(46966006)(36840700001)(40470700004)(40460700003)(16526019)(186003)(81166007)(356005)(8936002)(36860700001)(4326008)(6916009)(8676002)(41300700001)(82740400003)(2906002)(70586007)(70206006)(5660300002)(7406005)(7416002)(426003)(47076005)(478600001)(2616005)(1076003)(26005)(336012)(316002)(54906003)(36756003)(40480700001)(40140700001)(82310400005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 04:08:31.3683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46940115-6bde-4d1d-296c-08db1df87294
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the cadence qspi controller compatible for AMD Pensando
Elba SoC boards.  The Elba qspi fifo size is 1024.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v10 changes:
- Fix cdns,fifo-depth, only amd,pensando-elba-qspi is 1024 bytes

v9 changes:
- Add 1024 to cdns,fifo-depth property to resolve dtbs_check error

---
 .../bindings/spi/cdns,qspi-nor.yaml           | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 5c01db128be0..18e4bc04f091 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -20,11 +20,39 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amd,pensando-elba-qspi
+    then:
+      properties:
+        cdns,fifo-depth:
+          enum: [ 128, 256, 1024 ]
+          default: 1024
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amd,pensando-elba-qspi
+    then:
+      properties:
+        cdns,fifo-depth:
+          enum: [ 128, 256, 1024 ]
+          default: 1024
+    else:
+      properties:
+        cdns,fifo-depth:
+          enum: [ 128, 256 ]
+          default: 128
+
 properties:
   compatible:
     oneOf:
       - items:
           - enum:
+              - amd,pensando-elba-qspi
               - ti,k2g-qspi
               - ti,am654-ospi
               - intel,lgm-qspi
@@ -48,8 +76,6 @@ properties:
     description:
       Size of the data FIFO in words.
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [ 128, 256 ]
-    default: 128
 
   cdns,fifo-width:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.17.1

