Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEC96CBA7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjC1JY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjC1JYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:24:20 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2042.outbound.protection.outlook.com [40.107.241.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EB159C9;
        Tue, 28 Mar 2023 02:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTBUivp5kg/IsmlteunuHbz+3M0cUYXytdFSYfSOfr13MLipntv1X9fXTQQ8OjeBdoCkxX8m1ZASvlTV8UnSbhwKRINRkilTBsQqRmDSCR6A9OnGzkhT9ptta6ZmQVfMKcZULGm7Fa/ngDCaujW79VFJIy9FYm50PY+25cK1QsLgM7WkNtNDe6M5x6cms1z038rYPPfw3soy0uqpfAAugcWqi30TrFNj9GmtGawGKzCxXT7HZ+pd1h1bKw7KEL4DT+1VFkjp7W8BcKV9ZN8kt1KXheZvYvuVYXsnHPixds7jCPIlH0xPHGN+hN+WIKM7+gpZiIP3rFbDZp6rnjQwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJUj5Lsf8MXRGZMO4YrcoHZkHxXy3xcGQoq/C7PPhgo=;
 b=nFTl1ycCsJYq0WJG8X8K01CKCUNPdTtAxWQSL3ZzqSF4LoOAJZlN9lcwcWiCgm5b6GUFMsEh0vB5Kn2jBLG8EuQ//WcrPItsYjiWiJVASy8VGSQ9ZRSg6lI1gbfdsI+6cJJ9QmQwdMNqQWvl8fA1DwEg6OdZpUE+8RW3BnEkGc/KD8vPsaxmTg9m5xKWp8FSNn32vrWCvT+hsV/QsUJu1LYMm1UEOzu1PpyFsvtLq3wgZn0j58FwXGkioWpikiXGGvc1tAzengfod7Y2PRE8DZHnfbXQjdFLGWFiR2CScbZU/fQXa0ZJBUOYXUxOhfDChuDi/tVOu11TUTFlAh3F8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJUj5Lsf8MXRGZMO4YrcoHZkHxXy3xcGQoq/C7PPhgo=;
 b=j1VgJzw4EkBcGgXHvBl2vDWO61qDf4jl3pFwdURUY1JhSa+Hs04HNmoJrpqqZ+YVeth6Xl8Fk7tevSb0sO5nZzUXmZTdMBkQxeUjw5MibMHgjKHWdVmELn6CcnkKAm/9Cgwc6FCIIaP3Awb8nRKBtBLtChu+t9h4zV4uWtVzakc=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by AM9PR04MB8306.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 09:24:15 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::5c99:52d9:e4c3:3318]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::5c99:52d9:e4c3:3318%5]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 09:24:15 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH] dt-bindings: usb: typec-tcpci: convert to DT schema
 format
Thread-Topic: [PATCH] dt-bindings: usb: typec-tcpci: convert to DT schema
 format
Thread-Index: AQHZXVQoc6CE6PVfa0OMBVFP1XlRAa8ORFEAgAGnVtA=
Date:   Tue, 28 Mar 2023 09:24:15 +0000
Message-ID: <PA4PR04MB96405A3B0B5158561D9E068F89889@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <20230323065824.3857573-1-peng.fan@oss.nxp.com>
 <5675373c-af4f-906f-9906-7853a85f8ed6@linaro.org>
In-Reply-To: <5675373c-af4f-906f-9906-7853a85f8ed6@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9640:EE_|AM9PR04MB8306:EE_
x-ms-office365-filtering-correlation-id: bd373fc8-4ddc-4f83-2c26-08db2f6e3321
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jZMHSgKXRKdV5kGlqsn9kSEt/5Ky+AaziQ0reKsaWoU9pX/fQkS4ULEEtpqjasYml2ki6EIgyT7EtE78RUkZYeh4P7jYN7oYPI0P3pJH0xOdhCuD2yoBz8alXwFw7ij8zHhziHa89jFq6ulRI2nhqBnDcEVXNiVPFf7Zb5FiCBN6/i55V5I2WOqGBlbawWYJiX2F60N2wum78WxA4mhw98O4Z5kgDzZCN5lBbKNewehVYdZxS8cXQkXW4WtHo21QYgFDghvoQFSpZrBmC7fdciMFfKqDhrZor2PoEVIivfSbz1ZA0i3yyCR9RU+YJP3s3hfptrE7GEimA8G8v1EN8mCCYR85uDEYyztynZBbi495wK/KKdvjwtwVKTYbJ0DnFC3oNdB/SKhibSkKyhXd/m66mLESe89LQDw3jED1qSGpZfQPxJneGh9pufTgwsb5NnHzBp3jYYN6WuGPh0VL1WhGcpZ9/Th8RbHzbTj0UGfoK92dafjs2HwLOG6tpc9nl5zYxwlNyAXh0hynRM3tYOIDfPgQcShLf1TDgklE/geJIUASJmil6pTk9+A2NinbgC4zWt2qFMEpHuWYaScRV+eAGpDZ0Zwjh/N7H9PcKzmvtJRhkDE+dHL8s8BF5QJK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(26005)(53546011)(9686003)(33656002)(6506007)(186003)(83380400001)(8936002)(66446008)(8676002)(66556008)(64756008)(5660300002)(122000001)(52536014)(4326008)(41300700001)(66946007)(66476007)(44832011)(76116006)(45080400002)(478600001)(316002)(54906003)(110136005)(55016003)(7696005)(38100700002)(2906002)(71200400001)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gxAk09x1uwYSTaXCiqkR0ZmP1jnVS37a14KGuDIOgln0qF9CXF6hdjB0SOD+?=
 =?us-ascii?Q?GukETus7inTAmNXa7k/pv3NIUiaQbmdfYi0q3uP+dReYDiRmNfeshbhR77oq?=
 =?us-ascii?Q?67A3f0dXDg9WQI7ghQjGGrmUK7oUeIIjvDwmPEwiIrQCMeq8AFhF5QGTadkN?=
 =?us-ascii?Q?6t1AaD+XOAJLqJyU8UWeJxeToizmmTHlfjMgk7faFEWqzDK2teKa2B7hB6lb?=
 =?us-ascii?Q?qJdWwOrxq5e+ya+SM/stiOiS/7bNSpEDZhZ0kw+RdHrPGVaMXwq6eXYfD1C8?=
 =?us-ascii?Q?2rQukrv+B6eZSUiFy5CjZ6DiD0jwwSBJeaOO8RLhrp3y90qMWKxuj7sDTRiM?=
 =?us-ascii?Q?C6PXFDd7MuEDPGNFZReFtY4VBUqi3wAvXXBJ3zDlg8nSammy78MHRYggrl/J?=
 =?us-ascii?Q?mBswZUFNia7faH61Z3ouWnjdHj1oBjE1wmxiIhnxaLBuivseiUMBXwON4aXK?=
 =?us-ascii?Q?qF8uFUXhjA4pUuzlJP9vR1RTwtPnd2Te/TFWA2pu7EmmvSukESVl3KbcfRcQ?=
 =?us-ascii?Q?KvkqBIyy26UqRhC4ehMgk48qo4r5muiOTLXwOAbVM5ISrtUqc9/U4OnZ+hMC?=
 =?us-ascii?Q?bqB3GDOb34sBdKLe4nEW7I1ECV33kbEC+0R8i2RbC62+KoK2e5sio9gZjp8Y?=
 =?us-ascii?Q?YyJEg2OqyEL2QIw5Nut5lnFceOaju/Xg4sQUoQMoDLByzMGxkMrik6ttjCsg?=
 =?us-ascii?Q?U8twZYmcf2MCsCzHEyWn8eKomJh1+vjPde8uD5iQBg9qdVOvhCy0e44+nTwf?=
 =?us-ascii?Q?M6dYMD0CVPw+zd7bmMPNuh/vg5s93NLBoVH1E6EKphhysUJh6bSuczZNazHY?=
 =?us-ascii?Q?ZE2gORka0fEUPGEh4i8OWTRVzRsRPCcmg/Z6x1Z4kTnL0YmfridLHAH+UD9l?=
 =?us-ascii?Q?wpBGUk4HbSHhztJRNEtG9516YUTi7SU9rzn7x7muWamPeZY5ymNtmRVF3iYn?=
 =?us-ascii?Q?ev82RTmrelXE8WwmfcA4G3MCnoohR9Vbo8d8nqKXoxyPg0xyZBKcBYuOyRlE?=
 =?us-ascii?Q?JyomiVLxewpOvS8ELoB1jMa7uWh4OO8CxnyiRzBJ6RNXk64TqVJJQk/AMLkO?=
 =?us-ascii?Q?MlpQq+7zmIzG445GSu53nCVtD7BjWy4QeD9QRdEOgmka5T/ee7Jv3X2BXcqj?=
 =?us-ascii?Q?PF0fh8aYzrGECEyvFj/ofgluJj/IIRpRXbIwFuqUQIzbP0XIkI7ngSuKN2zL?=
 =?us-ascii?Q?8Kb+3RKzPlsWRdh48+Vd+N97kv176f4huUmVnQqc2aPwX2c4QvZx/8C9bRm4?=
 =?us-ascii?Q?jIJYoqhoAF6vlb8RLzRLGo+0mXsPmJdeN282ICmGKPWnLVN5cc3DmY45vpMK?=
 =?us-ascii?Q?5javF5vzhpRrONQJns6pVMgwxUq4FlH9R9scfpdsgIOCEowpAQg0g9u2FD8z?=
 =?us-ascii?Q?8LnQS5q2chMaEnIigsYWmJ/9R2PInTS0qos4+PQd+sHZ5Dpj266MYbFpdmUg?=
 =?us-ascii?Q?0N4bTunwrAdN34JWBle4BKp/yMGPVU2BR7gSVIoOftkzGgKKIiLxFj4ZCaH/?=
 =?us-ascii?Q?QACEJF0d3RW4WLt+4wl7hZufMHdKrh+mCJP9oQK9GXIC0rgsPA2zD7m/vEQ+?=
 =?us-ascii?Q?kALzPLnB253W8NFVjOk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd373fc8-4ddc-4f83-2c26-08db2f6e3321
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 09:24:15.3803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxiDKqlNngc7kPgTpIuglO0/KOu4Qewwb2S6X0k1PsNzrB4Gvyh2Gj3p6mLFZ2tB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8306
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Monday, March 27, 2023 3:41 PM
> To: Peng Fan (OSS) <peng.fan@oss.nxp.com>; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; gregkh@linuxfoundation.org; Jun Li
> <jun.li@nxp.com>
> Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; Peng Fan <peng.fan@nxp.com>
> Subject: Re: [PATCH] dt-bindings: usb: typec-tcpci: convert to DT schema
> format
>=20
> On 23/03/2023 07:58, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Convert the binding to DT schema format. The default speed is HS, so
> > add a dummy port@0 in the example.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V1:
> >  The default speed is HS, so port@0 is not added for some device tree,
> > however the usb-c-connector requires port@0. Not sure we should drop
> > the required port@0 from usb-c-connector schema or add a dummy port@0
> > for tcpci as what this patch does.
>=20
> imx8mq-librem5-devkit has full port@0 so just use similar approach.
>=20
> >
> >  .../devicetree/bindings/usb/typec-tcpci.txt   | 49 ------------
> >  .../devicetree/bindings/usb/typec-tcpci.yaml  | 80
> > +++++++++++++++++++
> >  2 files changed, 80 insertions(+), 49 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/usb/typec-tcpci.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/usb/typec-tcpci.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> > b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> > deleted file mode 100644
> > index 2082522b1c32..000000000000
> > --- a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> > +++ /dev/null
> > @@ -1,49 +0,0 @@
> > -TCPCI(Typec port cotroller interface) binding
> > ----------------------------------------------
> > -
> > -Required properties:
> > -- compatible:       should be set one of following:
> > -		    - "nxp,ptn5110" for NXP USB PD TCPC PHY IC ptn5110.
> > -
> > -- reg:              the i2c slave address of typec port controller dev=
ice.
> > -- interrupt-parent: the phandle to the interrupt controller which prov=
ides
> > -                    the interrupt.
> > -- interrupts:       interrupt specification for tcpci alert.
> > -
> > -Required sub-node:
> > -- connector: The "usb-c-connector" attached to the tcpci chip, the
> > bindings
> > -  of connector node are specified in
> > -  Documentation/devicetree/bindings/connector/usb-connector.yaml
> > -
> > -Example:
> > -
> > -ptn5110@50 {
> > -	compatible =3D "nxp,ptn5110";
> > -	reg =3D <0x50>;
> > -	interrupt-parent =3D <&gpio3>;
> > -	interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;
> > -
> > -	usb_con: connector {
> > -		compatible =3D "usb-c-connector";
> > -		label =3D "USB-C";
> > -		data-role =3D "dual";
> > -		power-role =3D "dual";
> > -		try-power-role =3D "sink";
> > -		source-pdos =3D <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
> > -		sink-pdos =3D <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
> > -			     PDO_VAR(5000, 12000, 2000)>;
> > -		op-sink-microwatt =3D <10000000>;
> > -
> > -		ports {
> > -			#address-cells =3D <1>;
> > -			#size-cells =3D <0>;
> > -
> > -			port@1 {
> > -				reg =3D <1>;
> > -				usb_con_ss: endpoint {
> > -					remote-endpoint =3D <&usb3_data_ss>;
> > -				};
> > -			};
> > -		};
> > -	};
> > -};
> > diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.yaml
> > b/Documentation/devicetree/bindings/usb/typec-tcpci.yaml
> > new file mode 100644
> > index 000000000000..067d3b032e3d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/typec-tcpci.yaml
>=20
> Is this a binding for PTN5110 or for generic tcpci? Looks like the first,
> thus name should be rather device specific, so nxp,ptn5110.
> Specially that there are other tcpci chips in separate bindings.

This binding doc is target for generic tcpci, ptn5110 is the one
fully compliance with tcpci spec, if change it to be only specific
to nxp,ptn5110, my understanding is then other chips need duplicate
a binding doc even common tcpci binding and driver is enough for them.

Thanks
Li Jun=20
=20
>=20
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> >
> +cetree.org%2Fschemas%2Fusb%2Ftypec-tcpci.yaml%23&data=3D05%7C01%7Cjun.l
> >
> +i%40nxp.com%7Ca2cf429c972a419ad86608db2e96a0f4%7C686ea1d3bc2b4c6fa92c
> >
> +d99c5c301635%7C0%7C0%7C638154996697929798%7CUnknown%7CTWFpbGZsb3d8eyJ
> >
> +WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> >
> +0%7C%7C%7C&sdata=3Deuh5zZw%2FL53DHjrl6uUP8JqZNARczFDYC6QNaCYrYfk%3D&res
> > +erved=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> >
> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&data=3D05%7C01%7Cjun.li%40nxp.
> >
> +com%7Ca2cf429c972a419ad86608db2e96a0f4%7C686ea1d3bc2b4c6fa92cd99c5c30
> >
> +1635%7C0%7C0%7C638154996697929798%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> >
> +wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> > +7C&sdata=3Dx3NzSCn1gUc8KtwoWSGiXh%2FDoqsStnsrNcTBg4FTY9M%3D&reserved=
=3D0
> > +
> > +title: TCPCI(Typec port cotroller interface)
>=20
> Also title should be changed to device specific.
>=20
> > +
> > +maintainers:
> > +  - Li Jun <jun.li@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: nxp,ptn5110
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  port:
> > +    description: This port is used for usb role switch.
> > +    $ref: /schemas/graph.yaml#/properties/port
>=20
> I don't think
> > +
> > +  connector:
> > +    type: object
> > +    $ref: /schemas/connector/usb-connector.yaml#
> > +    unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - connector
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/usb/pd.h>
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        ptn5110@50 {
>=20
> tcpci or actually more popular: usb-typec
>=20
> > +            compatible =3D "nxp,ptn5110";
> > +            reg =3D <0x50>;
> > +            interrupt-parent =3D <&gpio3>;
>=20
>=20
> Best regards,
> Krzysztof

