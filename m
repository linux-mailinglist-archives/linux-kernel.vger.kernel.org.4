Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A22E6B625F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 01:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCLAqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 19:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCLAqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 19:46:03 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F9A43907;
        Sat, 11 Mar 2023 16:45:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Osj8j5MwYROr0GO68CwlaPd4RDrT1mMo87CO2mrLIkZ19cZuJiXaKWAdLmssxxw60W/gFNU/jN6kAJnczVMTcPdJzqirNUIHiNM44pRbkWYk7DtTFZgTH6hD9iRLcYTk/4jwuVY3FF7fLSPdi9nzhe0XMNmOqUr7xPvxXKL9C/+SC7NHKYVuMQ6cDYT9+VuaDdozCCWz/iszdaekrz9uLS9T5vTOh+A+gt3aCehUL+hH9jqhztI7rVISEOaif75o+bYb3uoAGKUi2XCtsoR8BkWP8P2iUORJR976sFICiP8Qk6vjytySqRQL/CkfH/MYfJp9f0meExydaqizDUg6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/28g7A90X4yGafo6uL2pTeN1XvMkrQG1dvwvegdlS0=;
 b=l+IFFf01TersyK8G2v1xBx0WFMy9ir4RqSqIsKdsz6g1QZYXZquRsy5H+dgXwiXRsZFiaqtIi4+vVLec2nfNjSkMk7qUP8R6clQCFRYbBS7rpa8VHPTdpdUUMtBeeDLjgvZ35OoGhhtjePr/IuLvf9foA7j0EZftGzLOedy04+wgd5B+Rs5JINLjhI7yzAHMgH7BhanRqSiakjVdLtmxD3o+bkROzdVruvxu5eKZIKsoR0T35g9gsgNmtbytdqCBGgaWWMsS6LkzSLHLGZ1GSaoujGi6obC2pcN4JkR/fnZjY1qLvsTupFxcrKMuAuoVOf+BKncgH+3NOP4gJsOsqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/28g7A90X4yGafo6uL2pTeN1XvMkrQG1dvwvegdlS0=;
 b=T7N6/j+YhwUcD/s/WZ9C6xSuyhXRNuPwzX0Hn/izwymLX5XIqQllTQiPxZ7kpXItz66ORLPmypelUZcDNID260cvkUbDUzryzs3rcrvf5M6sNoU9+vyQ/ku3TKInlLj5gs7LiRW2pwBmKuN3RYCoxRA8XUxVu/NiPr6Gx9BopiM=
Received: from DM6PR07CA0047.namprd07.prod.outlook.com (2603:10b6:5:74::24) by
 SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23; Sun, 12 Mar
 2023 00:45:28 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::e0) by DM6PR07CA0047.outlook.office365.com
 (2603:10b6:5:74::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24 via Frontend
 Transport; Sun, 12 Mar 2023 00:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.22 via Frontend Transport; Sun, 12 Mar 2023 00:45:27 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Mar 2023 18:45:24 -0600
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
Subject: [PATCH v11 03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
Date:   Sat, 11 Mar 2023 16:44:33 -0800
Message-ID: <20230312004445.15913-4-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: a4fc0ee2-d8a1-4df6-e7dc-08db22931317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+Zz0CgyQu/iD4WmftVX0PG9i1mwHQ1/s4IXfy1p/5dctybKFDG9ucQ5zwGEH5yDYfnzCLG8YR1lygNcxTL4XKr3ljvgK7nPheiK89H+X66UOXvqeF6cYEqI6JdUn8Kkzusmp9goJMk0NBVrzFSmFSTzsj9NmhdjXoCxIvsGk/mbeF3Blp7xmJOd4n4ourxsWcVjq6RCOeOGlvpaOwfHmAB1ZjfLMp4mXo/8/2j2rJkruIKmmwc1dk0L9RIV7bVE41um3/bWCaByLT48Ly/I15slc+N2W0uvAi5VPT8KRRjBU8VEgDnDVN6EaofVliT03Af7/4rpOAEmgGQAPXFactZZ0dmTzYf9I+aggfPKI/0/+rpqYGZrj6AW8DBp2M9hQkoKVw9ozOjY+0wNC4gF5uuHkG3EXxh2BZxj67DkUpaM8XepKDxJuBCprhOCuIN/hjz+FpHmK1hHpheOJGI1xzE7M5lzmwpUd/ZoSbEGab8p5vDRp6KYIKITnNnc/xwrNm1e5vLI7kfYk+Cm71ZhglEpm/GvIFDs5mlGgN6YrpgBrPDDYrrESAX7cnjGSwSvjRYTmCIXP5Sq+IgTNse5D5G7q8fh9O+Ri06ohvpxqU2vZH93p+z7eI3of1xLRgdXRot1C9uA90wkPRtESDip1VAA1ai2K3alHgt+NAMegjeh/vboLYFor5m9hkIU+Vg1n/GBxohpaoztUekDOcDlAAc/S/SLvzn/saWyTzXUeRU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(41300700001)(54906003)(478600001)(8936002)(8676002)(4326008)(6916009)(70586007)(70206006)(40140700001)(356005)(82310400005)(36756003)(40480700001)(36860700001)(81166007)(82740400003)(316002)(1076003)(16526019)(6666004)(186003)(26005)(7416002)(7406005)(2906002)(5660300002)(83380400001)(426003)(336012)(47076005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 00:45:27.8146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fc0ee2-d8a1-4df6-e7dc-08db22931317
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
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

v11 changes:
- Removed redundant if/then for amd,pensando-elba-qspi

v10 changes:
- Fix cdns,fifo-depth, only amd,pensando-elba-qspi is 1024 bytes

v9 changes:
- Add 1024 to cdns,fifo-depth property to resolve dtbs_check error

---
 .../bindings/spi/cdns,qspi-nor.yaml           | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 5c01db128be0..6e67de9da293 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -20,11 +20,28 @@ allOf:
       required:
         - power-domains
 
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
@@ -48,8 +65,6 @@ properties:
     description:
       Size of the data FIFO in words.
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [ 128, 256 ]
-    default: 128
 
   cdns,fifo-width:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.17.1

