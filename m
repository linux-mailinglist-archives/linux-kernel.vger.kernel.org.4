Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFEB5F7404
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 07:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJGFu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 01:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJGFuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 01:50:24 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAB5688BB;
        Thu,  6 Oct 2022 22:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTmgA8uG6aH89Qr4QrwoH7Q+nLgY5z8qnMGUNdv3ZRbv43jw5QulstxyPjRMFfQmcR5duoNiaUrmYUNp0jhhYFwS2yVPq4mScRocq+272XwQjFSSi6ZL9VZWgPFVdTeQNvXfGLDZfWec3WMs3D4KSEkT1vJWC2Y++sEuPNjxtQAMPV+DdCDiJRBL5oRySP0haKrn8xBbY/9qK8LKXuEs5WoqL+CW/O6Z99YrAxl70pFjNcsPkxfYZhekxDtsWpH81awGMfqdQ30sWLKLFh3zglU7OHXGoGbCSnnskpzs5XquBtDk91SldqCNXLzFho36HLtQwe8mZxKLbczkjalvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6USFBRBKWSVQOAfWLIrwQeHiyCex7zYqzTLwvjIkQ0=;
 b=WTK37D6FzzdT+axeG0ZKQ4ySJCkqbPDIpqERGoUJOX62EC1KlNt+5yzrRto8FEsjtTCk8Y6LhKHqYt96IRM8iqMxc3nrBTSkP7ho73b6Mmx3YC8F1L5zm32aX9lSome/ind67WMOeeJ5L0NzKREEpeLI+OwX03sFWjRGXTSHYMCSxA2DEfdREtltd7MNNnAajafXffQgy0aZncjw3ZzbpAmCLuQ4hHXt5aHXpxjM3kdi8XC9Ugs0NiTnW81JE/ZqhyS4h7R63EXKPDawxtv5yGtEHc1mZDDazgurJBEkFeSiMP2y+qpGNXpWMCDl/fix4akB4nkYuPp8ocRVZcN9+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=linaro.or smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6USFBRBKWSVQOAfWLIrwQeHiyCex7zYqzTLwvjIkQ0=;
 b=bcXhSh+CttaMo2M25gErpPaSZsAchAOv6iBHW+mIntaluYJRFlAmiDTJ6s4+uPV/rwl25IXW2AFjEJ/H1CWapPMDxdQ/uObu6XTvI3BzHo6m1gBfKyiheuoLBleDknGGI2Ck80wIEseSyChYnDaoXpwa74A9Btq9NErIqkzR0rCtZtvlR2as4bqA34P66zCU3b5QKw+IueHkrONLM0wMBOSULEurhN2s18feMWFXOzQUUtQa/iKlvkdDK4TjeT6ohrVz1Aa7i8vwSACJScGfzkvBGduqolO7al0qqkUyYHNifVG+191YVbvhXo1I1/NLgvZDFkQuWrIB2K3CROKxUQ==
Received: from PS2PR04CA0003.apcprd04.prod.outlook.com (2603:1096:300:55::15)
 by SEZPR04MB6273.apcprd04.prod.outlook.com (2603:1096:101:a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Fri, 7 Oct
 2022 05:50:19 +0000
Received: from PSAAPC01FT040.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:55:cafe::a5) by PS2PR04CA0003.outlook.office365.com
 (2603:1096:300:55::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36 via Frontend
 Transport; Fri, 7 Oct 2022 05:50:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=Wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=Wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of Wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 PSAAPC01FT040.mail.protection.outlook.com (10.13.38.122) with Microsoft SMTP
 Server id 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 05:50:18
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
To:     krzysztof.kozlowski@linaro.or
Cc:     patrick@stwcx.xyz, garnermic@fb.com,
        Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>,
        Bonnie Lo <Bonnie_Lo@Wiwynn.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
Date:   Fri,  7 Oct 2022 13:50:05 +0800
Message-Id: <20221007055008.3468691-1-Delphine_CC_Chiu@Wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT040:EE_|SEZPR04MB6273:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f08accff-51f8-47a8-58ab-08daa827d0e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9g6nqN67GvHI2/yDR/VnzhPmRz29beF6KWgls3S+Us8xxPRXSJBDchrxFS5RcdE431FxUkpaF/8k6dI5MhtiSc3rTJx8mAergX2mx/CQl3wBdnXCg+JWFBm3v0+m27OZI6XWBOAQ7+1TCb63TOt3lqlO5U/d5l4Uye2QD/3Vl6zkkCC/9AWWBpE8jCeZYRf94YR+UJFfy6t0sxPrbozvN/TRsH11GU1Z0bMxxSg6GMgYi1O3luP/4buJOU7FcgGVIsYLdwJve4xOP/Uwrbnqywfi95BVowjxXvQqfj3VAhMfXy3Tm9cbbxt4odjAsN8T0NbxpHHBhpHCGVnoZAwqBB266E3KaSpeIPE2P21fXL1gNoncnpdUhKKYAJ7bqrT+MEdLVQnEg1VDyoAArZ5hG2kMr0OEgHsC/k2sRkYh9MMRSkwwN4/dQEGN1l61GVg6Au9H4EaGm5dbI7P2WCvU5ZVr2Rthd5yeI+5Dvt7TTzw5Ft+aBMx0xDJaaQfjoythfocGYoek/Q10/eK59s+Bm7DsmODQDXd9eNDi6CDWkuUtRIQJMQI51tibl7zRIopUbrSwIiWbKP3gZTKG5W+r6jSrGZMBjHTYyH8CUBtGfv+rMksE5D3ZFOB8ERyTQz6ZF7edQ0SfWwJI+E5OEJkw08wDPhqw3LrjxWh+KixkNKfgTu59yYgP5AKWKSj3KruLwQZ+TxDDFIfeWMrzgq2d8DeUCdo4/X99ttchTmmMUibiq9HaSzhlqPHyE4We1E3w
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230022)(6069001)(4636009)(396003)(39860400002)(346002)(136003)(376002)(47680400002)(451199015)(46966006)(36840700001)(2906002)(4326008)(6512007)(26005)(8676002)(41300700001)(40480700001)(70206006)(70586007)(82740400003)(8936002)(81166007)(82310400005)(47076005)(356005)(36756003)(336012)(2616005)(36860700001)(956004)(1076003)(5660300002)(4744005)(7416002)(186003)(9316004)(6666004)(86362001)(6506007)(478600001)(36906005)(36736006)(316002)(54906003)(6916009)(6486002);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 05:50:18.0245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f08accff-51f8-47a8-58ab-08daa827d0e0
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT040.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SCC_THREE_WORD_MONTY,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new compatibles used on Facebook Greatlakes

---
--- v2 - Add binding document
---
--- v1 - Initial draft
---

Signed-off-by: Bonnie Lo <Bonnie_Lo@Wiwynn.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 1895ce9de461..f12b94ddb9ec 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -75,6 +75,7 @@ properties:
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
+              - facebook,greatlakes-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
-- 
2.25.1

