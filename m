Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DF26FDF45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbjEJNx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbjEJNxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:53:01 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733C5D2FC;
        Wed, 10 May 2023 06:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLCUt4bmIKBALLZBRKI+ZiqkRGi80j4+BLwgK7vJbg5fpl29lVq5E90es1OZc1xo23fibAdsoO0vx8qxJm7H4p7Yd435T+cc5jUb6MLb5lS5J0I1NB1NOqXqtzZPtS6LlDTqTpC/h/TjNAk/C/IKNBV+DbYqwaXHd9wy2DXrBqTy+cTk5q5g/qCBQGcdTaWQ/AjwNgImd8aj+xTyGKP712sEBQemmonOJ1tsyNtYejucLS4tyATn0/sm9sF4kMJ8UWN0EYVIgVYD/PoV2mMlMkJM21qQckiluRRMIB5BUSqqu1wM1stej4VJC1M66Bkd72jY1xb88bXpgDzvWtDaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ke1LFs/dT6GQmzTiLzBym6UON1WUtBhFgAWU2ef3oII=;
 b=UbQG/LXfS6DvylAJHwES5A6k/zbqXwB9XgOMaagPynv+vKJ3FYQmCwS7U0qCcWA72FUkq6qIfASuyrmirXllw7O1D+qGdIzNRCjSmyPBq19lTyaz+iy+PUsMSxzMm8M+k4hz3Xumfwd+xVngGElDhMZ2grNPfrWRVoNl2HuzELAf7pUI7SvexPPXfcjwsXR1OpWA1f2ZlGNFrmIxMGlcU32ExbTJmPD425071X4yeF/drXgxLpVdSI9J/fyMsSMdkRu7GySEZF0ONkywtuL43SXs8HNoZr8XN7GYU3thGVyOizKF8DePWgISHEZQQXFEUvQ/yMHhyC15jVAlb8lq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke1LFs/dT6GQmzTiLzBym6UON1WUtBhFgAWU2ef3oII=;
 b=Lc4CNG02Ekn652HwjAq6oiX/q9lZK91e3gL8l/YeceWWH/5wLJ0FyI3j1mP6z23U14vRvm2MBx/SaG+IfrCTj0QMuc9vWdNHgvE+BGzjKTVn1+o20HL6SsrUYQKGfrCvcJnM/j6CrxzNIoRXDapZyKdfbkgah7jczXGhI2Uh2Tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAWPR08MB10212.eurprd08.prod.outlook.com (2603:10a6:102:369::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 13:51:12 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.019; Wed, 10 May 2023
 13:51:12 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Wed, 10 May 2023 15:50:47 +0200
Subject: [PATCH 2/4] dt-bindings: touchscreen: add virtual-touchscreen and
 virtual-buttons properties
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v1-2-5ae5e81bc264@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683726670; l=2958;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=oif59evYmkWx/9LoiD8k2HlA1dSFIUUqMXLuvbr2Lqk=;
 b=PzFUqKYA9spA9HVPy0NQowGVPFY6XWsf+m5guzxZwONFkKWUt0v51cT/CTBChNhfn1/QXPMIR
 tWxcavHOxBlCm72auxFBBbSha80HbYL6raye9SIZjOqvw5UJgLUnRI1
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0102CA0093.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::34) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAWPR08MB10212:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ecf529-b5b4-4ce9-0505-08db515d9d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RIv+VKXC3HObnyQvw+BDinCebPoI9inh0dLbujFdWKLvXGtc4wxhVkNHOc8KU2TcnyPtMPncou+a8yzobz82HSpzzzvLjqz73MIwy5l4OMxlqjdWAT6N+2CS9VH+aBGvPwt9EAew+VlTipPW6egH8m22Tn6qv+nGWrpVu8LIJ+8k+Tl+mPUlUfyYDW2Y1Lp4uy0s1lHuEiST3fHVjQM+BCjR3k03+LHafTd9FVUFuZPWi6zYoNhZQxY3j4hWB6U7S5SgrhUwdzUYQzVqeMDDAe/Q9UWxSfTZQYyEdfUrpzwk4iMGEloylOGk1QJw/5rgkvXklaautfP/NsdpKT1Z6ZeVwNbtuvV21HTg/TD0zlW2LxjmIGZP1feGBp48waD/lVtz51u2srgBjsmfUny+y6beO/i/D3KYOFvn68tb1aakCPRLAaulVDZZxPffhY09C1PYR8SIR3iCiRLSe0xr0kYICvhSwZrxTiONQuRZJFtYNMFl+Zy/uyLfAuVP7OM9W3QNZP9CXWb+sVq4CeHHKXuqU7MgdsnGhAQc6dwhw5TyDJ/XLx0J8yEjmYvmhqodQOjDz6bGwjGVQWNdzvYoddIsOyVQQGY0sUR4997mEa7xgilXD2j4/CG0lUpTPCD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(39850400004)(396003)(451199021)(86362001)(36756003)(6666004)(110136005)(316002)(6636002)(4326008)(66476007)(52116002)(478600001)(66946007)(66556008)(6486002)(41300700001)(5660300002)(44832011)(8936002)(8676002)(2906002)(38100700002)(38350700002)(186003)(2616005)(26005)(6512007)(107886003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0s4dkFGWWl2cSswQmZRNjhibC8zb1hHeCt0ZElWZGpyaVEwMW5jdktYeFBI?=
 =?utf-8?B?R1RyWVh5RTNlTUwyYithWGV0RDg3SE43aU9ZK1A2QnJjUWU4M3dHZThGenRG?=
 =?utf-8?B?VXRHSGk3b0I2c0tKOUNFYlgxbXNNQ3FneEM3OUtCbGVJSENlbFFLN01TTm9h?=
 =?utf-8?B?TDBaN2NGaFUzTVFHS0t6akxYUXRIdk5YTE16WTBtTjN2RFBLOFRpU3QyUFB1?=
 =?utf-8?B?a0NIWXpDV0JNcUxxSFlJK0ZuYURGdEJpekM2c0FnVG9LbzgvcmplZzB5Zzlx?=
 =?utf-8?B?STNZSHNqdnlwRTNLSkZWSjZUblBMWmtCOHVWUDBTUk5ZeUVTMFhuQ3JBdVVz?=
 =?utf-8?B?dFB1aW9IV1VYRDd0ZEtXcnA1eHEweVVOM3R5SGNQVS90eEl3N2NnektFMXFa?=
 =?utf-8?B?Yld6NSt4Qzg5Y0RRNTI0VUFHN1FXeW1tbmMzRkQ0RHc5RFZSM0RmZHRxZ3No?=
 =?utf-8?B?SGRuWlVRVlRkamVaRXp0M2dHSWZPei9mQ0c1eTl6ZzExenVrVzJVWkxiUXh6?=
 =?utf-8?B?bXRoSnFhTER1RnhHSVhndEdlWDR3a1Z4bjZxZ2YvTU85aWZ2WW8rUXh3TDB4?=
 =?utf-8?B?dGEzQnduVUdKUjIybGNPaFV1R2ZTc3Vhbi9ERDJ1bU1BL1VKdEtLelRIS1dj?=
 =?utf-8?B?eGxYN2xWWjM3SmRUZmJkY2x3VXVwWUg2TDloSDFpRjhCbDRvaTNMV0VEa0Zy?=
 =?utf-8?B?ck1BWFdCUzdlaFU5MmM3WlVoRmRoaFRvdEpzUXErMEpFUEtIbTNDZGJjMXFh?=
 =?utf-8?B?cVNWYmgyRFozM2hNQmIyakQ1TlhlVEliOElIOERVbWxLcUgzTEFhUU1YbFJF?=
 =?utf-8?B?eTgyOWNyeEdvZkxEQndOWGpTVFpJVVJvYlk5WDJ2eDFpdThobDJieVU1VEw0?=
 =?utf-8?B?dGIyVW10MnA1RlZWdWhqbDlWdTQ3aEtiaUdNcWhMYmN3NytwU09VUmVBVVFm?=
 =?utf-8?B?d09GMUJuR2tvalZ4aVdhRW1vU0dWNmlLVllHNFl3ZGlXUDV1TU5tVS9RUTlq?=
 =?utf-8?B?MWh1VXhRMWdXQTcwbGpMd0VMODBGZGZjZEJ2VlE0QzI0TFZpNy9MRmIrNU0z?=
 =?utf-8?B?WWIrTFRPZ1EreE1sS3ZNMWZENFZXby91MTIxTGt2dzhoSDJTUFRPdHRIVEhO?=
 =?utf-8?B?Ti9kQlJoZXJEVDQrT1NwSVpNY1N4RzB0VENwM25YWWJ2WGpZQ05tQzN3WFIv?=
 =?utf-8?B?UW13VGlZakVWS202WC9HMU54TVo3Vk93c2Z6Q01LY2pMTnlRaDM5cWRNbVNS?=
 =?utf-8?B?S2F5NHp4NG11WXd2YTZGYWNqbkxpSVlOd0ZXdWxiNGFIdGpZcUIyV2JVSkds?=
 =?utf-8?B?YXpEcVQvWmttS29EdUYzdU9CZHJhSnptRERya1dpdWluUzl3WFVidkpkTWRw?=
 =?utf-8?B?b0VEMDNBSW1acnZZRmJETytFVFh5bVBieElGZ1RZWlNSODJPMEx0R1cvbHI5?=
 =?utf-8?B?MkJUdmlZOWJaTHlvU3BIdzJEbUN4TkVoTFlHeDhsOU5jdExnclZUbkh3L0VL?=
 =?utf-8?B?eUVJS3hNNWJMM2t2SjRsSGlMWEZ2OVZLMVN6clFTbWhQeWRIZ2Exdm10QmEv?=
 =?utf-8?B?cS84YkRDbnl1UDVsaVhOcXZwVktnWWY1VjNJTW1DcERvSm9NM2NGTlQ5Nmc4?=
 =?utf-8?B?Z3BjQ0JMd01mMUdnaWJPN1h1QkFmOHVIUEZTdXJobGxIS0hMbXVaZTgwaXEx?=
 =?utf-8?B?Q0tqV09IK045eENEWTZ0RWxNWVAzajYySHJmVGc4NGVPWDIySmNSOE1KLytI?=
 =?utf-8?B?SGFKSlVHdzFvVUNPSDQwS3JsMnp5dWZtUEkrNXJ6Z0l4aU1xeG1ZS21sUGVY?=
 =?utf-8?B?ZkJJeGVwRExLYjVZcVVrYTV2eWNocDVrQmlCRUh6cDNLOXZoWUlwNk8xTVpO?=
 =?utf-8?B?Y3FadkVSK2JkWGF0cFV0ZzdkL1p3ZUdiK01odU5RSGRYL2x2eEp2clVrY1N0?=
 =?utf-8?B?d3Jyek5qTFNKams4K0FVbHMyVDBkUnlaUzdNWkg0VktaYWtVZVY5WCs2bGp5?=
 =?utf-8?B?YjlaOFhPVTVHNkJOUFdJaG5wbDU3MUhSL090TksyeGtFVENhVzB4NFpGL3Ir?=
 =?utf-8?B?c3A4dzVJd2xXUUgxeXRNVVNEVEZFdlg5TXcwNGZyVE44aTV5ZjBoUXBBbFRM?=
 =?utf-8?B?ejZwTTNGY1EzVjVBU1Z1TkRWRmhoTzNSVUJ1RkNoMC81VkZTNHNNbE5QbGEx?=
 =?utf-8?Q?UFhzfSeRn7NpsxyTyWVeWKA=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ecf529-b5b4-4ce9-0505-08db515d9d8f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:51:12.1890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o99MtG53dc4xH/rpmLiIf2UvdN+wyhCxrk/bzVG8IHPjwsa4Spz+OOOBVdwPnFNb90OJbZUgt5aq6s+TUQRd5jTX/gaOonbCTGJMIWjkNQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10212
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtual-touchscreen object defines an area within the touchscreen
where touch events are reported and their coordinates get converted to
the virtual origin. This object avoids getting events from areas that
are physically hidden by overlay frames.

For touchscreens where overlay buttons on the touchscreen surface are
provided, the virtual-buttons object contains a node for every button
and the key event that should be reported when pressed.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../bindings/input/touchscreen/touchscreen.yaml    | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
index 895592da9626..869be007eb6f 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
@@ -80,6 +80,60 @@ properties:
   touchscreen-y-plate-ohms:
     description: Resistance of the Y-plate in Ohms
 
+  virtual-touchscreen:
+    description: Clipped touchscreen area
+    type: object
+
+    properties:
+      x-origin:
+        description: horizontal origin of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      y-origin:
+        description: vertical origin of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      x-size:
+        description: horizontal resolution of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      y-size:
+        description: vertical resolution of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+  virtual-buttons:
+    description: list of nodes defining the buttons on the touchscreen
+    type: object
+
+    patternProperties:
+      '^button-':
+        type: object
+        description:
+          Each button (key) is represented as a sub-node.
+
+        properties:
+          label:
+            $ref: /schemas/types.yaml#/definitions/string
+            description: descriptive name of the button
+
+          linux,code: true
+
+          x-origin:
+            description: horizontal origin of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-origin:
+            description: vertical origin of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          x-size:
+            description: horizontal resolution of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-size:
+            description: vertical resolution of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
 dependencies:
   touchscreen-size-x: [ touchscreen-size-y ]
   touchscreen-size-y: [ touchscreen-size-x ]

-- 
2.39.2

