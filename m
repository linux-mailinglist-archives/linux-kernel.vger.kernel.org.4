Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E4B60E6C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiJZRwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiJZRwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:52:01 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4406715D;
        Wed, 26 Oct 2022 10:51:58 -0700 (PDT)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QEjikI018352;
        Wed, 26 Oct 2022 17:51:31 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3kf6xmgqmq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 17:51:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPN0r2gLndR2X7zWH6EQz/+G1KK544QqLrkPVmYYhD6VGYj4hgRWJ8MdfkZOSqBKsMZPIS2Yg0eZ5U+2++bVyPBeOY5OUWFlJPoSYmbdI/HP1WRIc9dLw+bB9vevXS5rb/iufrIjuc1wgDbe/URKRaVR5OO5RhwCzmAB88bjs912UPRGhKNTV138SD3NPLs/ZFtjHgiLkw8v9osRhCyF/uYu8kK3nhob7g0Mw7S7rcxsj7JG20t5Q1OsMJ2QQoXwk/N6KxWCdeWMg+PWH8poXwpWKpl9fvkzmXVI3VNiAuBLY0rWsjuef8uVOpnFOuMDGi2PXcBw/h2OSF+y3ld6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNEU3t35K0jIfMO/MTC+fZdGI9jEk6JBqLcDHJDuL+Q=;
 b=KhaMn0qE3f0ZcWq2ySDhoiJasC6s3hSUn+szoIzL14GAi9ij6VajB+ikrA0QGvtPu2BfOAsR5dQI44XenxfGiGTrgocnAvZatbVs4dEiY7+NbssuUHVg6VnPKT3OYmgIbI0LrI9BDp7mTKwiwTb+MMLDiXPhe0n0hocZIkCnzt/Yfs7QK3KserkGl2ycU7gbbEaGFjcdBRaZ4ZD4xjllVOUQw17gDsdWnORKKTjnG0KzCYoJToGh2BJGUps1nftHUc6vSOQH7jipqHLM/uXYGKuqV78E09rFfF/bRP8saLevRLZPokaJgLSQpy1Xw4EpBKYYM5P6pGxrWMVpWwv2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNEU3t35K0jIfMO/MTC+fZdGI9jEk6JBqLcDHJDuL+Q=;
 b=HjmL89j36ksCUKYa1pD5u+HbTCjHhdxWnQnosuW22WenPA+ud+VBUMYpXBNZ5j+9sR9llniunNlbf7YWLqKP+kfHqtmOcSWoh8d6LNP3Tpp9+HYcTmBabENqA/3QCaavlQ1S0Zu81DSnhbTNym/HpFs/XMFCe7UQ1qbmQ3e7pUI8wRThPVzzHZP0RMU7Dg+G8CUxbfB+cRiJynsEGeUN3zbOMsNvzdiVSQRDxHaPFWjQs6NTmWXn8o2YjtRUif4yfzO5PtN78L8w6/YYvSGw+uCzVWBCVZBFiJb2/VMSjI6KVyUroOXHPfcPGjgKAiOu51xQQImSoLPIiysJoSYpPQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AS8PR03MB9069.eurprd03.prod.outlook.com (2603:10a6:20b:5b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 17:51:27 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::551e:e1bc:b684:b7bb]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::551e:e1bc:b684:b7bb%9]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 17:51:27 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        "benjamin.gaignard@st.com" <benjamin.gaignard@st.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: Update scmi node description
Thread-Topic: [PATCH v5 1/2] dt-bindings: Update scmi node description
Thread-Index: AQHY6WOSKD8hZzACsUOzly7HVHy3Rg==
Date:   Wed, 26 Oct 2022 17:51:27 +0000
Message-ID: <cc624ca7f2d854a0cad7cb440e3f140d55b1a827.1666806317.git.oleksii_moisieiev@epam.com>
References: <cover.1666806317.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1666806317.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AS8PR03MB9069:EE_
x-ms-office365-filtering-correlation-id: 6e7fa768-7567-4481-81b4-08dab77ab4da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 94CQDnVKsfMTO59/BCK9sI+Ydz7hwonF32wy+R2O3GbKfAYA4+omKv/Wdd9xkotSfhpRMUMiwVIZm/wlmccvKazuNu+TK5tunu5st8UhGYKC/9eCj/SqdTQEMTCbDYvn5mgXEeb9gatnb/btk+X+xcWB2v0jboixkVIf6/MHn8tt91sCVxPtDjxlXOKb0EDWXWDqtrg7+tBpNL636rhqXlLON/h3BvEuueOS0WY6yd+j8Gmr3M4NvME0kJQjJp9swJUmtpJigzDc30vysQdxcDeQWRxkJFWGpqVDvuDH9gdSgSjkUcsJct1UZ7EBU4AkNIRyYYUx0S1F9oJ3jLQBNdmXy4yjQltAxGVE8v6GYOmXgx8qBVCw1QIfn/lZa99qXRbKljSsYXfbDh1pGk8P2aJfR56RGTtM927UawQ1FglZpQfdx26umAop/drmrfdPAqiyYGzS1C2+L8T2nXoKK20Q7aMNDH7mJwSESx5l8fxPxa+dBuu4Z9LmtHI3AYhQC1KLMz8/4e18zeoBc96yBwUyACx638yIkNL41v5iFmUEfIeWRLVJ3Qpr3WU7Mq8UH/XqBmvzvlBJaGJ/Y4pYYM5OT7nif0jNdlc3QIGXIiTtwM4C0UMNgm24SZfEUxS8ml4Rw5qtEAJPQuMwSDieqZYI9VKIceSpIv0MBSLFubbmC8oHxgV9D7HJHkOmFWUNc/mljowKEBI1CTptPxTWDm+QmS+JmjNgdaStVGEN/fLCICjhp7Fxn/AECSbTXoDgWmArK3oZVTXZGdrwBLgmo+uZ3B60RqkUNW4iJuA52ik=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(8676002)(83380400001)(71200400001)(76116006)(91956017)(36756003)(478600001)(4326008)(6486002)(966005)(15650500001)(6512007)(38070700005)(26005)(54906003)(316002)(86362001)(8936002)(122000001)(38100700002)(2906002)(41300700001)(2616005)(7416002)(186003)(5660300002)(6506007)(66476007)(64756008)(66446008)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XumrLOZESkspb0Q73rYQkEL2r3eJiPqW9VWYA2VK9YoWMRBF7RbqAEAug4?=
 =?iso-8859-1?Q?EWNNCMKY7H5xAdhLOQ6JcO+uaNDtyIsUfvFLCKJOIxqCKh4GALK3tYRLlu?=
 =?iso-8859-1?Q?JrhoUtVHPSRb7Frq0xKGhzNig6xesmeUhIFScN/ar80AcYi32w9CAFgRVN?=
 =?iso-8859-1?Q?DGoHfxD5msoPlkYqCet+1ZEl6EJztnmwcTBeKSds2Nn4iHR+jlJMQlme42?=
 =?iso-8859-1?Q?CpbD3A0fISlHdpKUDJusIAYS/cgWkjU2+GJFAmcRWwtSCFBqaQ7ei481kI?=
 =?iso-8859-1?Q?IY1iLJ/JRPfs3U78Xqn2uGL+7io3ye9m24VNWZUBLsrlamSP+lG5/yw0AR?=
 =?iso-8859-1?Q?AR8iFUB0LL1IyqmEvbrQ5+goz36g6A7hJfale0LhJjFIE661AF+yykKW5p?=
 =?iso-8859-1?Q?t/2ChNnaXj5yiT92LceSdA91A0cZPYiQ0K9XtV99/zFYQtNJ+2R04mUNKt?=
 =?iso-8859-1?Q?ttcJnKGsMRbeaRqxTVP/+Wz15BVQ9pplogi1/8dhleAugTTjdrMqXhZsKv?=
 =?iso-8859-1?Q?S6DnP3Z578yycfnM4ofPu9y4d2uDwLUEU3EGQhW3OjHmrWsu5vnLmsB53h?=
 =?iso-8859-1?Q?07tLzBjpAKXVjLYlteJ6tADC+gZl4jhI3/VVtwmEIUU57rB4QTBrI6BGzA?=
 =?iso-8859-1?Q?en8JWjGuYzhyp64IX5HSxV9EzfshVFSszHUS4HIAFmlptvhnSK+cFeV0dG?=
 =?iso-8859-1?Q?U2FixPx3ZTAiPz2oB3fVGo7YQyRb7oG/RzhvMxhGKY5U8Nw/Ymi4w4w7Um?=
 =?iso-8859-1?Q?gOTK401d8gNfn4aW8aDg4swG0pjPjkxA68cIiGvPho761TS3kQNzK+7giK?=
 =?iso-8859-1?Q?Qfn/Bmc/SJ9/wNjhuVtYgEd4XgQxmyJoDTDsbVJSZo7E/lFpAweKCmudCF?=
 =?iso-8859-1?Q?EMYgn9WPkUt5Nm/A0fviTULh/dO5u/UMm2SxroDIUCD56xgPCM2+8nw3jl?=
 =?iso-8859-1?Q?dWN/snsKRj6X02pR/pgA9JhVLCypw9UUa8+Mily0M9jME/UWbjQVDFG/r6?=
 =?iso-8859-1?Q?MsDDf4bV3pnRWuL09bw1y+sD7uhKke9G+aBqz8had1pdG/7OrD/lWfQYv8?=
 =?iso-8859-1?Q?Pf+vWdOOZe7RCk7t0Ql+AWU1jZ9TDbwB4KeaRtO1hGjanhUJ4lwG4PU98u?=
 =?iso-8859-1?Q?gQ5SruS6yiyFgiuBYO2AadtotMPFP2EPR65vVkU9p6HUyWSNWva7kT7s5C?=
 =?iso-8859-1?Q?pMqpUYHkK15l9bDp8tnIufByM3DoehlKA618mmU9LfNe4gqFtD6r8bpZOx?=
 =?iso-8859-1?Q?36GQoSXjWgzbB/aYt5v0RyucRbtfhmIenf5m7KIbJ6cGUwahZyF0DIay8j?=
 =?iso-8859-1?Q?kmasW5B9TvY87Mrd7IoZWuBjzpL1HRhgiQ9kCx4WxgLgwyUUmy8Jkz8S9f?=
 =?iso-8859-1?Q?PK8YcTK8ox1QSNqWzobwVMiOyKTeSYyzfAtQ39wymSdYIj2sonqcaAQB7E?=
 =?iso-8859-1?Q?k+xH1s3rCgl9uE3thI+C8hQScmn/Sfsgsnl4NvRpVBmDIQ/CZv4nzzW8ru?=
 =?iso-8859-1?Q?EMuggtZZh58WJH8+0xhRZY58Uh2GEey11pmat3qDt2FkuAuPmcSvFf5TBS?=
 =?iso-8859-1?Q?Ny84IUffbqncvnS/C6z6i5W8G5YqqDuRa7rWu/oOE+v88WsJkdKHKqVLTD?=
 =?iso-8859-1?Q?juLCePMliT0tBJKgI+ZbVrBh/DqsCZLrtkM3HIt2ec3I5ByhQMEdWzMA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7fa768-7567-4481-81b4-08dab77ab4da
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 17:51:27.1491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zohVLeRulhtP0aIV9srhb2WGDUFYM7bAL2TF5Pbypkv7HfBqBrgGkTnE9qG5Je2jxLUlfHCZIuuyD990XmA5eMZ412gV328SDcJOCjIfNtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9069
X-Proofpoint-ORIG-GUID: hMDa7UHCxM-yUdvRxXPQxjA4CMJSSb6S
X-Proofpoint-GUID: hMDa7UHCxM-yUdvRxXPQxjA4CMJSSb6S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=975
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add '#feature-domain-cells' property description to the scmi node.
This property makes scmi node as feature-domain-controller provider, which
allows consumers to provide scmi node with the device_ids of the devices, w=
hich
are using scmi protocols to control clocks/resets/power-domains etc.
The device_ids could be used to set the device permissions for the
Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of [0]).
Device permissions management described in DEN 0056, Section 4.2.2.10 [0].

For SCMI this property is used by Trusted Agent to set the device permissio=
ns
for the Non-Trusted Agents.
Trusted and non-trusted Agent terms described in Section 4.1.1 [0].

[0] https://developer.arm.com/documentation/den0056/latest

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
Changes v1 -> V2:
   - update parameter name, made it xen-specific
   - add xen vendor bindings

Changes V2 -> V3:
   - update parameter name, make it generic
   - update parameter format, add link to controller
   - do not include xen vendor bindings as already upstreamed

Changes V3 -> V4:
   - introduce domain controller provider/consumer device tree bindings
   - making scmi node to act as domain controller provider when the
     device permissions should be configured

Changes V4 -> V5:
   - rename domain-controller to feature-domain-controller
   - feature-domains format fixes
---
 .../bindings/firmware/arm,scmi.yaml           | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Doc=
umentation/devicetree/bindings/firmware/arm,scmi.yaml
index 1c0388da6721..bb5aa49e88fd 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -89,6 +89,16 @@ properties:
       atomic mode of operation, even if requested.
     default: 0
=20
+  '#feature-domain-cells':
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Number of cells in a domain controller specifier.
+      Set const to 1 here for nodes providing the device id, needed for
+      the BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of [0]).
+    const: 1
+
+  feature-domain-controller: true
+
   arm,smc-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -429,4 +439,22 @@ examples:
         };
     };
=20
+  - |
+    firmware {
+        scmi_link: scmi {
+            compatible =3D "arm,scmi-smc";
+            shmem =3D <&cpu_scp_lpri0 &cpu_scp_lpri1>;
+            arm,smc-id =3D <0xc3000001>;
+
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+            feature-domain-controller;
+            #feature-domain-cells =3D <1>;
+        };
+    };
+
+    foo@0 {
+      reg =3D <0x0 0x10>;
+      feature-domains =3D <&scmi_link 1>;
+    };
 ...
--=20
2.34.1
