Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B048F5F6116
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 08:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJFGfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 02:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJFGfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 02:35:42 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2074.outbound.protection.outlook.com [40.107.117.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF9D4BA53;
        Wed,  5 Oct 2022 23:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NybPRWPWeSsvFHffjPMQEOJ1eOmrms9NN5+HBT/FFzbrWtvyzeOXBkMxiOlD1uA5RnynnfGIRr1q13IPVFkVdqg0fWnF9MQpnymnjdgaa7NhxC8K20TZg7pM98R93NfdO0/vJ5e+pvxxKzNlAProkxVTom+4SNQhD6Mi9aIBY/xurFcIl7Ig0QTgEyfZplRoyN9RhjZOMwcbC8Tl6OvriKNcgua4GHWeUXrO5tyaw9kippjSEz3zH3CehZTNUeQBSQHNpBjq6fEBOTDlgdcETsW3p34Ec0XPekNDyIZUh7N7npLDfiyI9g7jD6R4pFbGHk9/QbjoZCGWbPvJurtxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdRw8j6ewhSomUtXlL4QwvKdzvU0UfPN9ERnVl+oVfs=;
 b=WhqOrGYWqVnLYYdFDybwi9e9rhPkQ6919gSu8uoPr5w3QJD+eySKnmgxbI0FpHv1UzIRccLHw9QxsmMnAfTBB3xq2LU2zxYlhwvgV3XtJ7iIyO3T8O3DrUN+Fn5rUnprM+z3wEG2r3GzXnRO8Hak3LONt1DvO7IX2IZcquEC8sS4YydXELnupbU8Qvp63yICqfcHXsabjQbCDMvlQ+bSboyibBqekU2NfF112KzAsepzPzgux3ESZZKPF4cDpSn+9O+x6p2dWmZXughFp4PDmuj5iWI+b7XiLwU4y0+7kNSYMUrl1Bnh8VEOBhAQyveCkZBS8f5uhCDBEDlB6CLAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=linaro.or smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdRw8j6ewhSomUtXlL4QwvKdzvU0UfPN9ERnVl+oVfs=;
 b=mLgJulAJNhPcHu6CbVU1rOAaQm7Da3SUWyWl/s2W5jINNHwDC6kIcRanP/lcwdRoT2rzEv0U7cenrDLuk8NzJ4e2qUURrH73bkiavm9Z1+ofQcXa3poJr7MwSK4+kV6ljGu4yOy0LGAlPloM1fd3ghH3+nmo0yoooQ2YseMBOG/77v4tRFx6ZocM1mDiGSMjqSs+hUCIbj45RsH/GaZI+qfnJUcZpO2d4ib+XI7H3a3CDbi90wr+EeMJldJj315zmbNfaic2r5S2atclE6eIzlk4fU/ajprpTlSM1FAxa5nlm++dyXMJgtpOIUyZg9OaHQpraOd8ocOPcPCKoWP/iw==
Received: from TY2PR01CA0011.jpnprd01.prod.outlook.com (2603:1096:404:a::23)
 by TY0PR04MB6493.apcprd04.prod.outlook.com (2603:1096:400:274::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 06:35:37 +0000
Received: from TYZAPC01FT018.eop-APC01.prod.protection.outlook.com
 (2603:1096:404:a:cafe::ec) by TY2PR01CA0011.outlook.office365.com
 (2603:1096:404:a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Thu, 6 Oct 2022 06:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=Wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=Wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of Wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 TYZAPC01FT018.mail.protection.outlook.com (10.118.152.93) with Microsoft SMTP
 Server id 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 06:35:36
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
To:     krzysztof.kozlowski@linaro.or
Cc:     patrick@stwcx.xyz, garnermic@fb.com,
        Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
Date:   Thu,  6 Oct 2022 14:35:24 +0800
Message-Id: <20221006063527.2007802-1-Delphine_CC_Chiu@Wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT018:EE_|TY0PR04MB6493:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9312a793-7a24-4b1b-f3e0-08daa764fae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVHyuylit35KwXZ4L/5ebEwkZikHiaYX5we7+Ao9SH8Mqnq5gDBC9dGFkAYYMxKMvgrQmOENPChAxKdymxrBxoCii79bPEaP+thX1scSQJlUlWYG0k0S819rqrbGkrO8RoJJ/N/5jbGRI8nmmuGJLTop/sNBy/wrI6VkYCaVIB+Tbm7rd5s3LiHXIspX0ST/QmO9KBjtH7D2gE0OKAzYFu2ETlaGcuy8yELugLdgJMYm+RQ5D5WrwnoAEbzsNH+QduCWB2n1BTax17GXgdq9CcxPUFDEqFgbdWC0vauZuChHJsrponw/dv5+y4N/0v4tz+kvLqiI+gSQVnzA4B8BeWI83zgAP6IDrGMgV5b9GwesQvBZLUn6vLB5Dw4QivVckNDwy4LMMMKctzfTYI69+8uWQnqK6P9P6UdpemjD2a1698g3Zkyf9/BbYO7ptdd3aBy/NL9ngsZMWzsIl+lMbOLwC9wG9ttcdtFEYcDMJPvXAyDhTxG7rr/RViL4GpSBfe608G7IxIoAlzQsN1OwWfItoHPjB42zcZWNuVI7J94iIfSHw+cldkKE0dvJfUEOPkoiRU6joHZlzqXkU8FyHoz0XnuPaumNF36B8wbYFdp/aW5qh70oCXEaxf05qEdDc66OCR9nQowP2VLUmdQm9TW+7aXuRX+9olIQlFREiLH6qICHy8TL3tGZ3aoqnEYGT882fxsPHAP+eOD6iNhOg6HdvyMa/dgzVmge+dhwapkLF+mlZPnFtkS3bU5P2vS7
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230022)(6069001)(4636009)(346002)(39860400002)(376002)(136003)(396003)(47680400002)(451199015)(36840700001)(46966006)(956004)(2906002)(47076005)(1076003)(82310400005)(9316004)(4326008)(6506007)(7416002)(86362001)(41300700001)(8676002)(82740400003)(36756003)(6666004)(356005)(40480700001)(336012)(2616005)(5660300002)(186003)(478600001)(36860700001)(81166007)(70206006)(54906003)(6916009)(6486002)(4744005)(6512007)(26005)(36906005)(316002)(8936002)(36736006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 06:35:36.8614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9312a793-7a24-4b1b-f3e0-08daa764fae9
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT018.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6493
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

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
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

