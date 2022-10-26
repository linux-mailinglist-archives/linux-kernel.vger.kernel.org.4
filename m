Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4549F60E6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiJZRwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiJZRwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:52:01 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD4B688A6;
        Wed, 26 Oct 2022 10:51:59 -0700 (PDT)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QEjikJ018352;
        Wed, 26 Oct 2022 17:51:32 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3kf6xmgqmq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 17:51:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN/oHO5g3O1fmrfqtD0m52mubT5LBZ0VCQKhD2yP+bTjEmzhl8ya6skfnMlEvvQYXYiCnkqZXeIwgKEqjIjE/kx1Mw7X3Kjuw+3h7fdx1hEKNeqpWeIR93hPR02CfAGMl1wEdsTzEvAWMn+TdGJjMlin8HPESCOYhExJ1XuSVVmScGya7rz1MjW6+xsLbEBKYRN2Y4bZQpa0FkfMxPIrjGmxFnAQ70nCQ5lTgvA2tj5RZcmxDdMPujXWqx6ri6kUxc4J2RaiYzweUKDK+vkoNM99d3EU5U9SSs+ybLviD+n6cBnf24mDGDAFQmzEhJ8+A7AxJOcSYX7lgT94u51img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+1WC84f2iaxn89JSuzPy35y1q+KdFOtVMGejLN1TsE=;
 b=Tm1RqT9L05E/s9gGRaY0CCIxAHcQpEPMxIH/9GlzaZDXs2jh+jjtbQDLGq6DWDRtPMPIgyn5Hs+tyO0kuo19N826b6xC9vTKmR8yClhREPGQkGnW/0ciGHUTEKm2Bg79wILsTmVXz9o0mICDoND/mxKNP6oMwybWz9i58kVp/YHUv2LhTyDmIpYEQjL+sg9R5f1shcPh/mNiomVutf50yNM5KGhC/c1sqtbhrKf2e5gt6Fo1kYXpMYdP1biIpba8y8c1RbZgBOPE+l4Hc9NCQUxMYUbV/5DuNVMKrADHb9/jew7mKZDz7jPTQfouJbqLHoDqjJJZXJJIMGkBAEEFYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+1WC84f2iaxn89JSuzPy35y1q+KdFOtVMGejLN1TsE=;
 b=Wi2Sm/WDrEsN+rZtDn57QA/mjQkq2DIKpoQ6uLxX5DW7CubLcEV4ILd/nO8Ess+KHdHCoXwiix2X//q2WWO3oi6vWlf4B5zj6IT43+JqJWh9apuPd+F2DtsfUj3Dl9MxJ+E/GhiX7bHRc6QcIxCXvMzLmo+4vUdDGuSKHQ9LVtzt+4DaZMEPYSUzZWxiZVKosH+V4PnOt55RXxwL0ONzZbXn7I8L0nUYateRSHL8BGzeLj3RkgSNJHn2TqKYgdZ8G0ygdE+8KPbB5ONe0qxJWoYQo7n/A3qevCY8QunUbxp/xfF73/FZe5UCtpUpGRnvYTPTIez/8+9LVCBrvYgBeg==
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
Subject: [PATCH v5 2/2] dt-bindings: Document common device controller
 bindings
Thread-Topic: [PATCH v5 2/2] dt-bindings: Document common device controller
 bindings
Thread-Index: AQHY6WOSCqHza4Axr0GIca6rbfuD9w==
Date:   Wed, 26 Oct 2022 17:51:27 +0000
Message-ID: <ab68324eea3c788a369260f5a1e5da843a960cde.1666806317.git.oleksii_moisieiev@epam.com>
References: <cover.1666806317.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1666806317.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AS8PR03MB9069:EE_
x-ms-office365-filtering-correlation-id: a333a1b0-d7e1-4957-a715-08dab77ab500
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jg7X+TBYR5GjUAVt3Vj1Mi9ALPnFnqUP0IG4CwA+U2Q9FJDgHt+46gABTTRF/cfU4qOIQDewAl5QLgGYmKlQOTzhicCrbuX1luheGVkxbkNm/Eyh62KT8H7cHacvHqWyiQ+JrWSlliBUAJNPrRuGjzngudx+SMD7kNDsb2Too0QeJLtrQePi0WqwRsxvhGe/EQ23Ykyxxg8OdTnKZUSnU9t/XL8si8x6Mm3lU90mMwFCBikr/UDzzglwzsAE5QPCHQhDou870TNAG8yJBwhlcho3fva5ylUKMDb/h32SSKCtgmmp2EO3vHUEQXJL9qPyH5tK6ihiZD2q2hgOjl/ey6IJwicJBHejxQCQAo++Ke8eI/iqeCO/bVwm9CpHOoDaav1loR7myxmaFb7uQ2kuXrys0ygQAlmpEb8zEfkjiuygs/X0CGlJZ5cWaQflKXUtpwf/nCaPV0wch+62rMzsshROWLUauMxw//Gor4diJQ6/0oxi9p4yaTrbCTB9KuN0/rYG0uHCZyu3bEyNaXKKD+APZdQ9K+iFOuInh78OGCgA8Q075hSxHPA7W3GLXmN4W/LsO0jGkyCzEG9lraXjuOa10AlHflutRXsfbBKrVVvQ2oWj69M8461hT3OqdViSlpdx8K/ODqiVyA7KrHEWjWyuTPUGwKPI3W2nJvRWShZUgOWM1vG17ZBJdDIxc6CiOf/bPKdrAFjRQLPzQTG+DxF6OMsG9i4b+fMXAfI1QAEHxIRi0H4DEIqXUM/zWB7OTvsF92GBVWTkqrqBC89jZbWCnYAHY6ssn7wxuaVPxuE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(8676002)(83380400001)(71200400001)(76116006)(91956017)(36756003)(478600001)(4326008)(6486002)(966005)(6512007)(38070700005)(26005)(54906003)(316002)(86362001)(8936002)(122000001)(38100700002)(2906002)(41300700001)(2616005)(7416002)(186003)(5660300002)(6506007)(66476007)(64756008)(66446008)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fBN8HiqkPiHpSCb4HRjBXh6T0xMAotxyuorSClxD4pjn2mugwNTh4edXmO?=
 =?iso-8859-1?Q?I10ecajlvgwI510Ltv7Trh+VaovJc7NTlzQdI8EoqZEegW7EjXyy8B3rbX?=
 =?iso-8859-1?Q?s03hy8InjL7ExnnJIbVGIRRS+aDZ9bXouw6uNJHrC9Wot4IWOXTKqWXGto?=
 =?iso-8859-1?Q?FcULnBkxf2bRN0u95WBfp9s9ChmiLgvMnAomwvKgnxlU1fWF/AXVNmZI5H?=
 =?iso-8859-1?Q?h32yhQs+m9LYhZAE3/W4clBiOe3nKzw17bNYEqpaPI0kY/JkYlvCZfvRd9?=
 =?iso-8859-1?Q?dAJoa9kNGUDezACXnDBdIfbsrjrs53tKN5e1iEROSGBJger8gbCKE/uQQf?=
 =?iso-8859-1?Q?jJl1HUE3G7Tswf4/yoBBhOXXxDxoOWmQinRQ3ycwIvvNyCDLhL4XVJEf3s?=
 =?iso-8859-1?Q?a6ANF9tuFFu8HHiGLs2jozR51srh3mruIXeSQ2+tavG/mXntiTkwJuZTmI?=
 =?iso-8859-1?Q?rxB4U+Z4vSLkAeIwNmy4e/0vl7Zyuhfa93vSXYy8ACZ/EqXP0ytUZzwQqb?=
 =?iso-8859-1?Q?eZjdInsViqY61hpylO2xM1N1xWdRHa9WOqkWl0GYgWY+6UXZH/YxOoU8CY?=
 =?iso-8859-1?Q?7bPW77W6xRvoUZ09XGFRwxnYKBJrGUNWdbb4BGHcC5ypxJpTU1UohDcgvT?=
 =?iso-8859-1?Q?agtg8XUKY8rDtLdw/iE1Vs/rLvEEkO/W4cbbHumqRTjtEhVrwTzKbYRDbL?=
 =?iso-8859-1?Q?5vBR9Xa1xWcOBDmB3a6RJmx8XzYlooVWbu3fKpAIH5+pXYVotVPwKLaNDY?=
 =?iso-8859-1?Q?qdkCpJoMn3qxWCKp1bwJIltFGsHv8uI3db9gsj839W0tQQtK53bbJOR0Xs?=
 =?iso-8859-1?Q?bMRTQVtHEhQjyu49jmyLVAgO6weaBxOOY22EzXPOKrPRcFiSW/PXq5P5vk?=
 =?iso-8859-1?Q?nZOoSECyCs0wYkrGcjitQUZDMzgxXddzfXTCC9bqZDTuB4oqGxNqMzlcTw?=
 =?iso-8859-1?Q?R/nXSFpzu+fky0iS9/IuCbuNJDt/g2tysSu5YxMlfstcyAevQngoIVIeS5?=
 =?iso-8859-1?Q?M/KIDR1GbnFE/4SEqYGNp8pdoMUeAbQL9Cy0cAMItQJC1IU+j6ltmZlSrU?=
 =?iso-8859-1?Q?HzAFjqTysN2Uz7czkVjYp58kWa4nh+29b5F1YQ/iWX4w1xpN5i0734Tbqy?=
 =?iso-8859-1?Q?5NPWPlTHwZ6FwYkcTLxLYgm9CIOXr7Us4u5UmV38bTC4jJtagqk9VOdBSn?=
 =?iso-8859-1?Q?nLSECzOCtO7bNTYri7ikWRJHudb3ZDYJOXBnWRHP1UHhj+JZyYbCL/B7Pe?=
 =?iso-8859-1?Q?uKeKF92Sc9mVfinnlaCuIPK78sdz22PwhNi5DbpbWG7zNHDcTrNqrXYjrZ?=
 =?iso-8859-1?Q?qKFA/aBRBG0YsuWpzYWGFY4wKKZeWipETj+EJRLcMsekYvxCrsZNXem0xm?=
 =?iso-8859-1?Q?Sdsh1CKEQDwJHl78bTmabaJN38QK+8Bic5PPvMKuzi8GzgUQEf+RcXZsQx?=
 =?iso-8859-1?Q?uR92k9apPnaRyA24y0bOb/5OZxp7oYTdeSDZv7kegsNQOaNoK7matiQqBC?=
 =?iso-8859-1?Q?y+TxFxf0rX8mL/pdnqUpQ8pwCQ8iIvjI30MoQjz5vKtlfWUKickyZVu3jg?=
 =?iso-8859-1?Q?TJntax/lo3KKysUWAspVEaNrR4B4zdQObprV0yDeuKG9OBk1fV3VDUnwAa?=
 =?iso-8859-1?Q?05sxD+t0Z0rg3F94237k3wr+om2ysDWvtk2hMYYiDKaEOMDLSFe3bwUA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a333a1b0-d7e1-4957-a715-08dab77ab500
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 17:51:27.4302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IoWUti+Jc+RBlHeXeseIziZ7/JiEDGbL84chqZgciMYQec9qTyt4tvej8+MC3+u9yT9TQokuRcgljLCC9UmkDpJlDvsIlpum71Ts1YaNjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9069
X-Proofpoint-ORIG-GUID: H6uzWH4gyYEnBoZvrofOy7hg3aUOB_XY
X-Proofpoint-GUID: H6uzWH4gyYEnBoZvrofOy7hg3aUOB_XY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
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

Introducing of the common device controller bindings for the controller
provider and consumer devices. Those bindings are intended to allow
divided system on chip into muliple domains, that can be used to
configure hardware permissions.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 .../feature-domain-controller.yaml            | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/feature-domains/featu=
re-domain-controller.yaml

diff --git a/Documentation/devicetree/bindings/feature-domains/feature-doma=
in-controller.yaml b/Documentation/devicetree/bindings/feature-domains/feat=
ure-domain-controller.yaml
new file mode 100644
index 000000000000..431382099012
--- /dev/null
+++ b/Documentation/devicetree/bindings/feature-domains/feature-domain-cont=
roller.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/feature-domains/feature-domain-controll=
er.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic Domain Controller bindings
+
+maintainers:
+  - Oleksii Moisieiev <oleksii_moisieiev@epam.com>
+
+description: |+
+  Common Feature Domains Controller bindings properties
+
+  Domain controllers allow to divided system on chip into multiple feature
+  domains that can be used to select by who hardware blocks could be acces=
sed.
+  A feature domain could be a cluster of CPUs (or coprocessors), a range o=
f
+  addresses or a group of hardware blocks.
+
+  This device tree bindings can be used to bind feature domain consumer de=
vices
+  with their feature domains provided by feature-domains controllers.
+  Feature omain controller provider can be represened by any node in the
+  device tree and can provide one or more configuration parameters, needed=
 to
+  control parameters of the consumer device. A consumer node can refer to =
the
+  provider by phandle and a set of phandle arguments, specified by
+  '#feature-domain-cells' property in the device controller provider node.
+
+  Device controllers are typically used to set the permissions of the hard=
ware
+  block. The contents of the feature-domains configuration properties are
+  defined by the binding for the individual feature-domains controller dev=
ice.
+
+  Each node can be a consumer for the several providers. The first
+  configuration of 'feature-domains' or the one named 'default' is applied
+  before probing the device itself.
+
+# always select the core schema
+select: true
+
+properties:
+  '#feature-domain-cells':
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of cells in a feature-domains controller specifier=
;
+      Can be any value as specified by device tree binding documentation
+      of a particular provider.
+
+  feature-domain-names:
+    $ref: '/schemas/types.yaml#/definitions/string-array'
+    minItems: 1
+    description:
+      A list of feature-domains names, sorted in the same order as
+      feature-domains entries. Consumer drivers will use feature-domain-na=
mes
+      to match with existing feature-domains entries.
+
+  feature-domains:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description:
+      A list of feature-domains controller specifiers, as defined by the
+      bindings of the feature-domain-controller provider.
+
+additionalProperties: true
+
+examples:
+  - |
+    ctrl0: ctrl@100 {
+        feature-domain-controller;
+        reg =3D <0x100 0x10>;
+        #feature-domain-cells =3D <2>;
+    };
+
+    ctrl1: ctrl@110 {
+        feature-domain-controller;
+        reg =3D <0x110 0x10>;
+        #feature-domain-cells =3D <3>;
+    };
+
+    foo@0 {
+        reg =3D <0x0 0x1>;
+        feature-domains =3D <&ctrl0 1 2>, <&ctrl1 3 4 5>;
+        feature-domain-names =3D "default", "unbind";
+    };
--=20
2.34.1
