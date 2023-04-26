Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2517C6EF577
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241055AbjDZN1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbjDZN1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:27:02 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35831170D;
        Wed, 26 Apr 2023 06:26:57 -0700 (PDT)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33Q9uUQw029566;
        Wed, 26 Apr 2023 13:26:45 GMT
Received: from eur01-he1-obe.outbound.protection.outlook.com (mail-he1eur01lp2054.outbound.protection.outlook.com [104.47.0.54])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3q6ahkwm6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 13:26:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNoN8U6No9BJlQkSIvV76CeaTY4QfbLiEIWvXJOr9jsMVrpjCoB1HsOtTMHXFMe6M+m9foiKJOehRQTdmN5K2+mqAnwZfriaAWEgHzDDrzVS+4A9lbdDIPRSf8MqHIYUQ/XQoU5UqWjImDOBgJiDGhdTzDcOdKC1FhUg4vhyCPiRMGDjmznvzudu7RUa6awlmJS1eBfbzU7hAg1J9m0rWCOMsnpDoK6ql3dVtDnKqDwH59cFuKA/IzZc09Z2nwrwZ9g21VzWMYxDghvtnHF6cqq1PyIlEkCEckM7EcfD5+E5vh/32Z6el0QwLsKV8YECD/AQCQnrir4YyaE2NWeMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyof/IvHyf2ZBLD2cKuGurdEc+LS5/o9SwZ6hqrgSJI=;
 b=Dpstp540/MOrtmdYtDU6j/sdPEQEAO41VqsMjq+wkMmMhXyIFrVqxAjmX2Heku8fJ3uVAITkhbaG0HJEqLwDvvUawK7BM/DkfvMnxFXBKfXvAhq0QmeKn9MY5sTlbTteFacVkRYz+UlFUgZ3qZHv/0zYkhDEJ4XCUg6kfsfFOkBcM7Aj8e6KvHa1kcquZNgQKRnRtxw/XVBUC+NId4K6Zp4RXULVlsPCjnntSLR5hTj2HSNZPxDaZYoiAvmQdw1qXS2sMiLxeu7x/uD0nHj6r0Wyqaiv2ANeSTfsLUUbUMP9XSU9FLG2XW5GNFsIgeiM/XO3+d8COsSCrETHYRH5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyof/IvHyf2ZBLD2cKuGurdEc+LS5/o9SwZ6hqrgSJI=;
 b=sNLL2FLJbO8mti75yGLgSxiYO5BaXrhxHYU2ojgwpfAqDURE3r0jx1sLjq4kOiYsX3f14/cdwfkg2Wrbieu+r39CPXABFtjF7UqvEXVxSYqnWjYwjOx1/9+C45idygxuVLhqpz9q2QEXzeuRhCFYAd1KsusiY4AIdslUL3J82paH+vPXmxEVaQuqarLp0X1qyF9otYYhhT6IyueJ5BPqHUXrDMhkobrzBWlk2CcFwlXNSxSndwTXqLBV4AW6EBGahNXYOCzs0QFzdlCCwB6FIcGD9h1SYLM5feXZcvmX7eaJQNniV2DBExeFuPaosBkrChhouxgBw2sw4pvHHQqtyg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by GV2PR03MB9380.eurprd03.prod.outlook.com (2603:10a6:150:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.54; Wed, 26 Apr
 2023 13:26:39 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%8]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 13:26:39 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Peng Fan <peng.fan@oss.nxp.com>,
        Michal Simek <michal.simek@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [RFC v2 3/3] dt-bindings: firmware: arm,scmi: Add support for pinctrl
 protocol
Thread-Topic: [RFC v2 3/3] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Thread-Index: AQHZeEK6qDUGtqz4K06E9chyDcKW7g==
Date:   Wed, 26 Apr 2023 13:26:38 +0000
Message-ID: <a361b227a273315fe9a9b822419863f0eb59bb46.1682513390.git.oleksii_moisieiev@epam.com>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1682513390.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|GV2PR03MB9380:EE_
x-ms-office365-filtering-correlation-id: 4b85c04f-9786-4e42-6e0e-08db4659dde3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sB7jkFcrAisKbBhIX8tEXnt0jCtyHudfiovAomSOe7kortmUJq00hubfca39pQYjJv6dPYlUtlrCvMDNxadXSCIvgwU9qkI9SWqhIbba1b14ObXYVG66Gs9BXjxblv2F3RJgUbDIlnau8Pcmw5+8ohNhgz5SmWhkOSHO6x7F4p4lN2c3TRayAGrNYHaFP/+bydtF5h/tflt4WRAUQvj5cSJHSVX21Or+iD5jtau0UmkZHeZ0o5xTvTskSFvLleFwMMejoAGDOidtDfMeYj0GVH/d8gBdLqbbeK359TpTx9LeuTQa7iEF5J25p2jpqGB2/0kRkM0OOvdFiSijLGWHnaSQr8J/G51g2KMYSDzJ17Cp0g2hkF6Hi/RTjeYFWRMOMvJ9O1QDiC0lqQ8fMxFcN0f2Jrp6w7s6PzToLQpHEc8qH0N8jylc8oF13hNe0SWkPjfwqj4uTgh8ZBMie4T2G2D6CcRnsJIDxfqFFUvAPykNAolXA/FYep5koin+Gj6Z1f3d4lsPXD4t+S1XRyBx7EPHOKkbAPjr9q0QFHfPxihkW1LjrYOHquT/XCH310or74rs2BNTkHjhC4SRsfpGuOL61Bxr5pO174ZwkY0OXv8Zb5hUKQOm709DftZggoR9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(8936002)(2616005)(122000001)(8676002)(478600001)(36756003)(91956017)(316002)(76116006)(66946007)(71200400001)(66476007)(66446008)(41300700001)(6916009)(4326008)(66556008)(64756008)(6486002)(86362001)(54906003)(6506007)(26005)(6512007)(186003)(2906002)(38070700005)(5660300002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VNu2IY3P5h4I73alhbw/6xcK/baqO7/GhYsSqBOBlLvFziqbPVtYxq6GG8?=
 =?iso-8859-1?Q?cCT5C97YoilxpuCvyIpHpYuMgP49O+9lq/Mt8BpgJcgxfn+gv3SrrXgC9r?=
 =?iso-8859-1?Q?BP7fg8uE3EcuY12F5dLGEWh71KZU0aSER8Z8bNTkVxTKHHGf4W2K6LJcKy?=
 =?iso-8859-1?Q?3WHAdai9l28IPg64za+4TvwP00Dt47B3rY9PWwxmvUMUKOEBqXtEbcbq4z?=
 =?iso-8859-1?Q?F31H95EOUsfEhRrblHcs6UHxZLUOg8/pY3xjeptRH/3fa4kTzu2rWTT1AA?=
 =?iso-8859-1?Q?PT6+aT2DggHGJSSatX43cyuDrKHvjniTtH6iVT8t/Y/PHY+HkypnljDzP2?=
 =?iso-8859-1?Q?Hx4eIKObBmzPsUKW74Muf/O/7+PCdM4a1EobUBHui+tdv/yatbGjnqQHXw?=
 =?iso-8859-1?Q?fbqQJfh4ruKjIqzr1XBAa2AaaZyHJjm/uQ45HP2wF2n4jX8nslnhTHbHna?=
 =?iso-8859-1?Q?n6Tn4q0/IHOWoYhykdI8mILIvhWJPlOaybuMqU2QOIS51YAGVhyR1BUZDF?=
 =?iso-8859-1?Q?TWY3JnxSzdoWWLJEhrfxvFfZpwoVYmSqc0mgS0RnGwPGuJB4uW6SpPyO/8?=
 =?iso-8859-1?Q?6THwPIs/ssp9dZxF0I+nWnE4kodJajtpj1L69O9ymvD3zd0le9oxEy6Xow?=
 =?iso-8859-1?Q?ZU4Eiqy8dUdHt8RRK5fj8/6nL/WdlH1NzZDv7umhEpLtfvu6u04Y2Gg/ne?=
 =?iso-8859-1?Q?cSTJhxtLmXk7uFmike7xLRO9VlReC5KkQu41J1CYpYVSc72I2BiudvGtk+?=
 =?iso-8859-1?Q?TrunehooGOmOr0oDy6k4UFZxSM1VBpQEuzIV2f0LglFsywgNDoAZ3gOP5v?=
 =?iso-8859-1?Q?CoSE5EVPuzoPCiGBffbd/JuoTOhgaP5J/1Vh3zQTaZ9XfMlFoDxJez+JNl?=
 =?iso-8859-1?Q?zvNOHVKHCEQ+MLgD8b0jgl/KAk9QWtY/iE1zx6aO4OgJSBXnK7PVq3lwh2?=
 =?iso-8859-1?Q?lVxWK3j5A2/X6/N0vcWFK5V4jVXf/MwSGOACyPeiZs2Xh3CSwcpAgDJf+2?=
 =?iso-8859-1?Q?7G4IVNG3Xc1R8WxOE3qkv9s1lb3HcmbJm9migkrKNeoNmZ8Mw4c12T2P4b?=
 =?iso-8859-1?Q?BIFCUv976t36GcDTmmDFPMErEoPhR6TWPpeuDIk9tOGQwGlAfMvDJ+KH7c?=
 =?iso-8859-1?Q?oj7ufERZPvJ4IixLMHjQWq5MWtxpH9srnVa1kY1iIQsyOcnNh1ZqbauLjX?=
 =?iso-8859-1?Q?nozP35FcOFzOqEkvpWDkPYfdQkKjqTdfOW2cr4oohtTU/FXl/LPxR7Ogb1?=
 =?iso-8859-1?Q?3c1o5esAzVSw5OszVJWQ/deQdyimoe9Gl+g2dlhLWEfpuZGJde75Sna3rj?=
 =?iso-8859-1?Q?Kv3OEKD/nx1zFwg/6QNjpPxzCn9gUNc2SU/d+qTcY8b0c/acy5/TLGToNP?=
 =?iso-8859-1?Q?VI4p1oFrC0d5+B9oME6+Njdqv2cpRleRc3+LXN9t9Pk2DNwD+8k40ML+XW?=
 =?iso-8859-1?Q?exHVe6bLaVL+PeXKYY1j/LI9gX/bOMt4IJHPAK55ojdFWMvdlYlS0//SkS?=
 =?iso-8859-1?Q?bRDS41Z+ns/vGlFwo5uL+nCmdE39Y3A4iJ5SEdygjveONtb08uiWnYe6uQ?=
 =?iso-8859-1?Q?rmsUxs4UG9UdpOX5ksrva+5ZM8BQXLFBAYrrAwGKvpiKTNyY0il7yACQtp?=
 =?iso-8859-1?Q?ljbRHTZTZ3WB/y0GFVGBnpw2urRQsggf2rrYqGFEEp8DzxltpCjl1YIQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b85c04f-9786-4e42-6e0e-08db4659dde3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 13:26:38.3498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBrjQMVOGk5rVqTcnCFBILkaPLNL7sN0K8ZCA51mBhrl89IEsuSBqCidrCrESLaUKlUQUfPN4vEQk1Fr1d9x6J7P72GBrWcgA16By34N7YM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9380
X-Proofpoint-ORIG-GUID: 2SX5shMOSi0Uup788ZcpSqux5_CEH-j3
X-Proofpoint-GUID: 2SX5shMOSi0Uup788ZcpSqux5_CEH-j3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_05,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new SCMI v3.2 pinctrl protocol bindings definitions and example.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 .../bindings/firmware/arm,scmi.yaml           | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Doc=
umentation/devicetree/bindings/firmware/arm,scmi.yaml
index 2f7c51c75e85..41ba5b8d8151 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -212,6 +212,63 @@ properties:
       reg:
         const: 0x18
=20
+  protocol@19:
+    $ref: '#/$defs/protocol-node'
+
+    properties:
+      reg:
+        const: 0x19
+
+      '#pinctrl-cells':
+        const: 0
+
+    allOf:
+      - $ref: "/schemas/pinctrl/pinctrl.yaml#"
+
+    required:
+      - reg
+
+    additionalProperties:
+      anyOf:
+        - type: object
+          allOf:
+            - $ref: /schemas/pinctrl/pincfg-node.yaml#
+            - $ref: /schemas/pinctrl/pinmux-node.yaml#
+
+          description:
+            A pin multiplexing sub-node describe how to configure a
+            set of pins is some desired function.
+            A single sub-node may define several pin configurations.
+            This sub-node is using default pinctrl bindings to configure
+            pin multiplexing and using SCMI protocol to apply specified
+            configuration using SCMI protocol.
+
+          properties:
+            phandle: true
+            function: true
+            groups: true
+            pins: true
+            bias-bus-hold: true
+            bias-disable: true
+            bias-high-impedance: true
+            bias-pull-up: true
+            bias-pull-default: true
+            bias-pull-down: true
+            drive-open-drain: true
+            drive-open-source: true
+            drive-push-pull: true
+            drive-strength: true
+            input-debounce: true
+            input-value: true
+            input-schmitt: true
+            low-power-mode: true
+            output-mode: true
+            output-value: true
+            power-source: true
+            skew-rate: true
+
+          additionalProperties: true
+
 additionalProperties: false
=20
 $defs:
@@ -356,6 +413,26 @@ examples:
             scmi_powercap: protocol@18 {
                 reg =3D <0x18>;
             };
+
+            scmi_pinctrl: protocol@19 {
+                reg =3D <0x19>;
+                #pinctrl-cells =3D <0>;
+
+                i2c2 {
+                    groups =3D "i2c2_a", "i2c2_b";
+                    function =3D "i2c2";
+                };
+
+                pins_mdio {
+                    groups =3D "avb_mdio";
+                    drive-strength =3D <24>;
+                };
+
+                keys_pins: keys {
+                    pins =3D "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
+                    bias-pull-up;
+                };
+            };
         };
     };
=20
--=20
2.25.1
