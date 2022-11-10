Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3DF623E20
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKJI6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJI6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:58:05 -0500
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21B167F74;
        Thu, 10 Nov 2022 00:58:03 -0800 (PST)
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AA8XZIN005288;
        Thu, 10 Nov 2022 08:57:31 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3krwuag33q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 08:57:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdPXTqp4N9d54KYTDO5vc1H3pd1D/6ORvaxtp5PW8nI0Bm3fQCqFimKr9mvY74XlFzkQ6e3yoT4K1ghO7wT+3QwdlQThRYYon3KIwhEt3e/l3kG45Wu4onjv/VJgEvmL+Y3vaIFN8mQqzsyF83AG3BIQtr6Fggm+0rWYdiwCY/yZEZQZ69wPUvEQi68yYURJG3KQqWogFYnFh9X816eZbcR7rXcHyVksea0PCumN3shw21yRSLY7fHQAFiR0dev110BRKW4LBmgBquXgnWdf3z+LaA7JigMUl+HqRoQ1/chwmPUFOa32msKDXmGrG7f2r/Jtsk2yw/MS18pr1yQf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gISmrocsyx+RrUwOu+W6m/pLDZQZ1ZADokv3gjt4T2E=;
 b=GTy9l12ZgtpvflfyddR6hKAQwr1oP6FA4GVaFgRAdwcIUqyOu5aCxsVARb0kL5rQ/pfKjW7a1A1JWCH09miXendVlL5Pw6ChaDARORHMQSAk1e1cEzAdzFlXpGJhfw+j3Z5t55AIrHL1dIzdslFxGioijzRNb+QtAUxBiyH0KDpqQ+sdh/d82bl/VTCXhdpHq+ol3WwV4jRfZchnKQqoJD9A+6A5NzTq6zfhqNwmCGKnOa0gZ8Y8AyFvUdMZ41C66Wts25bzD5mh6d5G7nNI7TmZ7JEIEJqfay6qTfmNEOEDNn9nQ+FXhctuD7Y1S3h2B84Aun5MdHCaGuhTievggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gISmrocsyx+RrUwOu+W6m/pLDZQZ1ZADokv3gjt4T2E=;
 b=nKzTx1cg8EI+ZPQZooLcvMQEse3q4HkOgNbYwkbZUgFTlqWWC1xdwKw5nXGSdLM62EHXhvMSonBpvdcdR0pc70Q3wD9/TFhElyz/8DJbOoW02MulQ2y8+J9MvpXAXnOpAF+det2Eg/2ublMZotCBZwXV02Vpzibm31ZvQihLkezkipJw13RmJOYYNblR+cvl/PpSbgFiGqeGNZBblrxxhwXX9oxCxQvgBp95PVCrPZSw86wfcZGfpNNUukMim1pwH256ZVALEhwjz/bDgnvLznhF6WFLiI0ptXd0HGloZ9C369x8BnY8eLDpCVIaNDr1+hWYiVA0audFZ1+Os4DUqg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AS8PR03MB6822.eurprd03.prod.outlook.com (2603:10a6:20b:295::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 08:57:28 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::cc80:5238:61b7:43c4]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::cc80:5238:61b7:43c4%5]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 08:57:27 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 1/2] dt-bindings: Update scmi node description
Thread-Topic: [PATCH v6 1/2] dt-bindings: Update scmi node description
Thread-Index: AQHY9OJ15svHVoFEaUSVCL2S/1sqYw==
Date:   Thu, 10 Nov 2022 08:57:27 +0000
Message-ID: <c730d1b47223f535ae214d21cfa18e2c011c7dc2.1668070216.git.oleksii_moisieiev@epam.com>
References: <cover.1668070216.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1668070216.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AS8PR03MB6822:EE_
x-ms-office365-filtering-correlation-id: 3a694cf2-63a2-4a78-3e4f-08dac2f99800
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KXOZQgIlKF8/nVbG2ap3Jajp9AaAmYbBW2lM5ON/zK+/t9mRjuvw5Z9K1ddPK/PxQtuxjaJZc24G+9yMb/rsH0qQ5uPT0swZVgKkB+wb2bF3/6Yc2aLGEUHi2ov3XOlv4Dpd/Nt01B/rufuQkYXsfEA3k3re0DvWn3RuPuj3Q/iqEbTx/oYD0qsVECc5Z1QfoUwdRL2iTnn2QOsm8CiiEeGQ2MtgKHsHigSFCPb8sHaLx+ZvJKesDP5+jK0lNSpbJx0Reob80frCH2KpfaZMs9xQmlm3PLuecEv1nG59NsRRdZ6Dv3JFzdpDsqhm77sRhH/RKUxglF54U7VDNPM+O/6U3z9G2YioGX/ea96UGnIE5Oz/ug75OZZanJtMm4GDIwHSiHxPDEyIF/7IfyrOXxt9NU2gIKt+sdg7OqSt0OP9885h0f4WytO1oDc1U+MtaqPVT8WrUt3X6rEhMeqn5DK28eyhYpYT5XNo89eB1XVllHT6+OV6MKvc3FN4uca8Q5SzakejzwKEcyfGl7YHRou82BZFG1bsqaLiZq7HNsEhFMXGh0cl660o9z3RoLqHU4TEKF9DLG1yA4sSsvnGkn9a/NrJxqFaWsEVZNtD5PyjXmV+s2+KxBWxwK8NUcjpirlwuOcTM5g5MyTpMvU0sl92Q84rgpLT/vXT3opiLXv5CgZ5h078TXsYwoiYSiSzR78M1PExUlQ/mOdZ8HtKuObXYZZlH/fJ/uYfNf6YqSLYrXjojAJR1RBpY2d6OlfiO0/3GtndzjROvy5I6oAAsu9gdxZu3JZv2LvCWgkIgz8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199015)(86362001)(38070700005)(36756003)(15650500001)(7416002)(2906002)(2616005)(6506007)(6512007)(26005)(83380400001)(186003)(5660300002)(38100700002)(122000001)(91956017)(66946007)(66476007)(76116006)(316002)(66446008)(64756008)(66556008)(8936002)(71200400001)(54906003)(4326008)(478600001)(6486002)(8676002)(41300700001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ifduplF3GvsiZRYDdpe4nU9sq1L2UUD2ZX6kL1h5I8XVGY0LnzdHVmej0P?=
 =?iso-8859-1?Q?Csx6a2q9a0Xem/IGJBgrnQGtezgw6V/EmUWtYeTwVqfS7i3u3zpWw59fab?=
 =?iso-8859-1?Q?EPiPbXl2SisRXc7lL4qf9q6jKut3ldK8hIwyuCuQrZLySS/4WkcseJUUUB?=
 =?iso-8859-1?Q?DavXlc67+F+5074C8Ou9CWgQpDxCQhrMYmkG1DJW1xe8IxYtnUpzxFzCfp?=
 =?iso-8859-1?Q?UBuezSTIiaBbfypT8//fEOl4Ket4y+mSWxtDrIoNgZPTLuKNvV0YUty7eN?=
 =?iso-8859-1?Q?nEGWd89iL1zrZ0tSAx6pcSwKwsBel7Mv3md2aYMVfHeWgYEmZxd/lTylYe?=
 =?iso-8859-1?Q?lTpjAHqd5vQMIUiH77iT1bzFSf1m9fD9tpbFXGKQyEVxwHvtzA1ByAOrvD?=
 =?iso-8859-1?Q?8AXk42EwoWz1U9KC15uVL9JuxrKFZQSvUcKMoRO9lmOXk0DjWMEYKyhvBQ?=
 =?iso-8859-1?Q?TLEGhh2iY7HtLtSRKOZ+7T+nev+iZu4Wj2sMNuPFUn19m7oOaEQHVU1Afx?=
 =?iso-8859-1?Q?+PctwwYh3woOr1AUiPRZkp+QwpkUfRIDz+petuKkE5BbPZkIkvePZlyY6c?=
 =?iso-8859-1?Q?dvlvPpmxv8/0hSeyuNegrn7BkF4R1vhH2ModM+iKvcXEkX9dW1eluxmldt?=
 =?iso-8859-1?Q?IqWnElPSHL8sxxH86bJgdDcqgsPLi7eYadDIIORxrYFQ/7KDKzn4IAQ9S/?=
 =?iso-8859-1?Q?6t4e70mR6YhcYoe79VOFnsNmlDpHakPWhVRvml+U/7pnuNX7rFA+EdjqQL?=
 =?iso-8859-1?Q?RPa1gLKPynXN9/CDuHWVbgwAd7rCTRwfYrL527WjjclgLJypW2gq8rkt7o?=
 =?iso-8859-1?Q?mDmjOAAn7tXpAHDaXYW5CWwqqUX8Mpk7Ac/5ZGVPkNCpoqEY8svwGcy13k?=
 =?iso-8859-1?Q?MNu68LZthPZhwbr3RPryTTbYqjD/gqEjUIRvrXA8eu6m+xRZPxDhMPXaNW?=
 =?iso-8859-1?Q?IIsdgUlMdh6nWlXcBqD60pq3PuOnxsXZ3epshNrlac+WVb9sdKZcjfCoie?=
 =?iso-8859-1?Q?OaR6cxKMLdQby0PkMll7l+/ngmWhBKIY3rrWTosIHt+h/pUX+RkqlXZGNm?=
 =?iso-8859-1?Q?EhvAkps+cRtypIoOvI4KuZyb+CYAW6LYCm2jUpBnEJ5On4E4VszmKXq63a?=
 =?iso-8859-1?Q?V2jtBFuyG8Z6A76R1nfAKydJjqI0sJwlTarvNQcOXdSNTPh+WkioEsJZcW?=
 =?iso-8859-1?Q?Y1O+9PauD9LiBKNgcGsjVQdO31Ql69/+91vg7yiRmRwUI8DLH4REATOec1?=
 =?iso-8859-1?Q?Ipko0U1CBaXorAB9PJVpUPWxvLZDLAyfQoEcZMiHCV24P9dagAnogTAq7S?=
 =?iso-8859-1?Q?Yj4XEY+lyLaBLHNrCPwuiwky7dJbrtBAxEYmOcYbCL75fU2h1so0Aq7/Co?=
 =?iso-8859-1?Q?9pXOh8FnYSh2Gxr9tQhe4GB6+sSkxUYSLx86FIv5RF4clzA8/Rle6s7lFD?=
 =?iso-8859-1?Q?n5E4kqZuDg3tXelCggtskiZSCyYVnYijgUU1XC5qAsQhi//XVWQs2APFUB?=
 =?iso-8859-1?Q?KXxHOH0cq/ASRjnu5+avqWJD3IzXK/AXBWbpQY8DkiT7i+3lhmoy/egGsO?=
 =?iso-8859-1?Q?5ymaqy3ITkRR1cHilCdU/qn8ssvCCk9WmDHT2PLdWl4wyzil/zvOwNLIEX?=
 =?iso-8859-1?Q?OBUJaLNitcXrp+sAW1gGYNzybvpbNXU+suvyVW/TXpnqQ48DQoC5WGWw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a694cf2-63a2-4a78-3e4f-08dac2f99800
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 08:57:27.8832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NcVCs70c7DAVkbS1NigG5S3maJh79p5gjjUgplmmrxux0fwkQt2tjD4gJ8bh97Y4BKmVFuA3DY0BZFH80Q8kpWAOrYHjiki842qrUjlGUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6822
X-Proofpoint-GUID: Jsq7WKiAmo6uIcjz5QTsSjckB6WOW7HF
X-Proofpoint-ORIG-GUID: Jsq7WKiAmo6uIcjz5QTsSjckB6WOW7HF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_07,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=933 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100067
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add '#feature-domain-cells' property description to the scmi node.
This property makes scmi node as feature-domain-controller provider, which
allows consumers to provide scmi node with the device_ids of the devices,
which are using scmi protocols to control clocks/resets/power-domains etc.
The device_ids could be used to set the device permissions for the
Firmware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of [0]).
Device permissions management described in DEN 0056, Section 4.2.2.10 [0].

For SCMI this property is used by Trusted Agent to set the device
permissions for the Non-Trusted Agents.
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

Changes V5 -> V6:
   - formatting fixes
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
2.25.1
