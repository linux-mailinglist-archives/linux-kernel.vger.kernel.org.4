Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB37032C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242659AbjEOQVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242622AbjEOQVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:21:20 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2071.outbound.protection.outlook.com [40.107.14.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1692685;
        Mon, 15 May 2023 09:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCOudD2/vUd9QXn8MtuMCcmcdBkgS24NN2iOVzFhCZqJuwxzUU5ovttuMGSz0/I9ot9FshGL99Uo7OeJ5mOLIlVKKQgsnhOz8Dg0T/iP6XKR5nWZqG7/n+z04gNe1ote7CWqk/8B39BBuhAEUMqXaZ6dOQ9Pg2kyxjUNMThV78jrzWI8SU9PGtDHE5gw9GP+cJcrgIAZTm0FZu7fzAZrNQJkIxtMgS3tofVUOroKi5eSfw/1HTkFJGcViC9xcE2Ubuf433odIhVsvt5UlAAJjYMmPDkB4Y/bq6bx3tJnQyBPLBEuwE5gc33Z60lO6rGcc3b5EbQkf6K9GSScd/OA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtxmeWh9W270PLRSIwCXgAmG338/JeWxnihTBH+ZAEc=;
 b=IBwaakc1li5wSat9Psr+CyrLNvir4po6PDJl1KIt3+Ah0wVI6AXB3Sx3k/9C8HMk38LiEsOmw9MhYQCIAOJ9F5iLNQTo6vWIVsy7z5htiiU1eWotH6GTH4W0pJfJxgQFTRoPesF61nH6DmEzn5F3l2j9L/i/WpS4NN2iYgEujT0n/ZFvRNkLAEmQHcye7Y0efke5Hph7oC6TIjYtJpOjtL37RKpPnG3+W5RWIN40/NlCD2WSt85mO9BkXORsvVMyRNvuTlWO/Ck9sU2lrG43gWuh+MUeS0YqR3dFyB8IjpsiqasRr8YLnYYfXLFpFGaEYa0kY7twI8fB02w1Oi7nzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtxmeWh9W270PLRSIwCXgAmG338/JeWxnihTBH+ZAEc=;
 b=isv9grRKCplqyalLMCqmcuZ6vNg34VwAL69ynaMKYisg7DeZ3yUF5XZ4StUAOQAYJk/iW7R3Ga2qu2gJi1weB/WyWVNf16aj3qmqsaZbyDwfyInaUR1bqFas24LXDrw2Sm4LctOW4eZ6hwDb+KtqvgzsMLjW7+Q4R/YkytAsmfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9474.eurprd04.prod.outlook.com (2603:10a6:10:368::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 16:21:12 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 16:21:12 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        linux-usb@vger.kernel.org (open list:CADENCE USB3 DRD IP DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH v3 1/2] dt-binding: cdns,usb3: Fix cdns,on-chip-buff-size type
Date:   Mon, 15 May 2023 12:20:52 -0400
Message-Id: <20230515162053.2825405-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::33) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: df8c1caf-f371-45f6-ab64-08db556065e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUOpkEMFlGomXQ8IJYPaXtXmMW9IJ7hLsv9n0jvhv37dXPRXa8ZnTOitP1PSFFXtiDke9beKYjl4hVCvJyMmkOw9+LlCqDaxPVG1bAn0lEynS+2a6YHWk6Ujumi5tsVwyHnsw3Os5WrmPsjg9vVmFQFai8antUG6YEg9l+W5/eIG6zu2EK8uje8WYUqt7CZajvPjEYU6BNXa15mmKTrJURfckwgQPztaM22ZbfXa1VXss8MbeV8YcLeLsWr8wQrPjbrvP5zz9FkX/ltDPC9AgzdLKTTlQazFRouq9opG/8NyroSjE/Kt7mvcLe4EUSMixCz08HKqgZypI2KDTSYq0vB8WlQtZpUkKZ+i3CVq0rm67ZbhNwZO9Gr34co1zHPFADlGVDVlaC13UPdd6qqCo8GluN0ol4aY9GqGkmdroJzfcd2VZmDDtxPOhFwFe26QPD6v7tDHi4ooREOqS8/CHUVmPEqV+p9GoAKBarC+OBYIBhbsJ2ESgAVgyDQwA1E1jT3N+kBOi+cTF30DaW6IN4OvRm+wLHa64J5Tw3T/p/CY00Ri61cUf3O0T/GAtX4ao5W9aHlAvccqVo500+ZEYpru97KTt3g1lskJOEdnN1ozP/7tQSJMc9W7r1Gw4hJts+uySvCdpxb9iuex8YOtMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(66556008)(110136005)(478600001)(4326008)(66476007)(66946007)(6666004)(52116002)(316002)(6486002)(8936002)(2906002)(8676002)(41300700001)(7416002)(5660300002)(26005)(1076003)(921005)(86362001)(38100700002)(38350700002)(2616005)(83380400001)(6512007)(186003)(6506007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0nwbpN4sLQaa7UUSjtDyNYVrjVeoe5KV1INEOc+uFUkdulTsLoncklF5rvKP?=
 =?us-ascii?Q?nzqNwSwearZuqlDu7mEn9GqF+2CWvg4Vmey3oRLX9BZIOdorRyf+rTzzkvJy?=
 =?us-ascii?Q?RA6lms4C+pxSHK+wPNPhnjCvMiwSOINDBk+lhbFZTAY/13DJlY+okvJx2hTB?=
 =?us-ascii?Q?C1bRs/RcY4YUciITH5TGqdH28PUC7DHo1C+dw6QukYBAdUvlJCx/Za5hf0k5?=
 =?us-ascii?Q?mffdFII9ndXVN+OuoCtnnjVOgOinR3COF2kcvV1kMxJWXBS3GMxRTrRU0dcE?=
 =?us-ascii?Q?HokKC50UB5z0G12QB0KCVx8KI5hE/QaNFeg5/oaqdKeaQ9bOo92zVJr8eEKJ?=
 =?us-ascii?Q?idzjLLgIEclsxGcinQ1kCw7qQn2z6LKde77OWCySh2llSoK/9HynC5mSb+mZ?=
 =?us-ascii?Q?Mpwqh+IJ0bo3rY9aJfzMYc9r8Fczgz4z8qtcnjCZgSdUQNody19u4v5VCBO8?=
 =?us-ascii?Q?7/B2DafPbvtIzkHu0Vhge5vQUJN6r90HNHDJ1sE3IZ94MELnmNg+zk8uK8RF?=
 =?us-ascii?Q?nhDhIXVDGXF3JM3RBTzmw8CETxcBewiTxoFMaA3B7/9PNc/UNzbf+FMAiAlC?=
 =?us-ascii?Q?eYZgbohSoEJs6Z044Vp89llGH+bXyGZrhA0GF0A5SZZiBimcMFTiwzcpR5cP?=
 =?us-ascii?Q?xMXu3G7eH3MK7qGtQ+fxgNewVPqKaTBa9/tOBp6wL5ZqMjWlSjEURPIjIRhM?=
 =?us-ascii?Q?Ztl5tb78nJDg8Y1Mjia1x9uVaKnF6ABWOJOoTYBfK/aG+8n41Wp6xeJw49xn?=
 =?us-ascii?Q?OGOGzPy9QzRwDJ8ict2P1awlMiAv/9Gn6AS91w8JzG8H42oaz5vsd4uP3f6a?=
 =?us-ascii?Q?F/J37kmiYJp2Kg1AM+ViAG135HdNpYPV0J8v6BD84WKIuYL/M49VNIJ91IXC?=
 =?us-ascii?Q?RXR0QivEB9vlclrNE5ISXKc8K8YgvA/ZtWOCSblM1Btz2BRPR5h+zulD8UOJ?=
 =?us-ascii?Q?l9LfE9p4yQJvhOAxaUsqRLowNQuNZmVor3ugN2pi1ZltcvbixURCG+4io/AK?=
 =?us-ascii?Q?jkhd03HVePI69CA8DZc9OLaw3aun+KjoFKeuYx25T9OQTBcBSVJzNbanEq17?=
 =?us-ascii?Q?sII9fTCKR2yP83z8tUGFPn4j+EANsUrAmWTxSIPQ+vzAUJPXFhzUkxGosQdp?=
 =?us-ascii?Q?rUDTI9u00NKsvCI5YbejRhdaO+LMsTBOghkUpuN/m6f4CbJDQfkbbjT7NiFi?=
 =?us-ascii?Q?IXukeJTFHqNfmxr4YY0E2Kdj9GrjL19yit3NyAKUVMRNihGVqhtBOCc0ESAg?=
 =?us-ascii?Q?LoGmN3klMUov+YJTORT3l9UUin0N/D4dZaqF6S8zH0woGggovE6ks4eGqNDD?=
 =?us-ascii?Q?XmDyoL12PSfCjtKQNhTvyTKamSe+eL7niSZBAeA5o6VxQdXcGVyJQ2PoJMcs?=
 =?us-ascii?Q?xm4Ey/hrH+FxG+uHOcG7KDsaLJi0nm3pxB4/cxiqxf+v+1wZIvhoaXUw6jhX?=
 =?us-ascii?Q?G8EHBbqMRdVlSMHqMrL+AsEGWbYySz4eWGa6HXzxvjHE6YauKnFkB/0k5Ur7?=
 =?us-ascii?Q?4ZHQc6KhviR7KMJ55NzcPjM80FQ/ujEJYQi7f+uAaMJ40RXVoZPFhkxwhsZy?=
 =?us-ascii?Q?UUwKrd2p4UMswdBh7M4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8c1caf-f371-45f6-ab64-08db556065e0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 16:21:12.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VP4rTg6RQr0rrW1NblxjsvUx17Z160CV0YtCWhD+eA4vvKhX46hADpvFUjt93E7vdIrK+J14LHMeoQ+GSKjoNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cdns3-gadget.c, 'cdns,on-chip-buff-size' was read using
device_property_read_u16(). It resulted in 0 if a 32bit value was used
in dts. This commit fixes the dt binding doc to declare it as u16.

Cc: stable@vger.kernel.org
Fixes: 68989fe1c39d ("dt-bindings: usb: Convert cdns-usb3.txt to YAML schema")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- add fixes tag and cc stable
Change from v1 to v2
- new patch

 Documentation/devicetree/bindings/usb/cdns,usb3.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
index cae46c4982ad..69a93a0722f0 100644
--- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
+++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
@@ -64,7 +64,7 @@ properties:
     description:
       size of memory intended as internal memory for endpoints
       buffers expressed in KB
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint16
 
   cdns,phyrst-a-enable:
     description: Enable resetting of PHY if Rx fail is detected
-- 
2.34.1

