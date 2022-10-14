Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8665FE79D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJNDbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJNDb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:31:26 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00052.outbound.protection.outlook.com [40.107.0.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C953E8C5F;
        Thu, 13 Oct 2022 20:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUi7RrT1LrYYXNhdT4FvV6ENiiDftwV+QKmtUxtr5EP+haluUKvvKjNTPgvkUJSocz2qOx5lLW2C9cBcPdEmrw/oUu4vh88p3NJLnH0oDKkYOpD75vIY6H86yw/3bke+OPCKwXFKGHDHDVTJKACBpuqWSIRau3bmu4WxuuMyKTE/LfQy7sC3kjgApV9lAZ6SXAzt1F0ugZTZ9QkC9RtEYetaEuzlCG08T1CRAA6SarxnO0uHRaEeUsvdc/5ZJn6AbuYigJtLc6X3evOCPVoeIweN/hhbx1+q+dmfbsSRjxaCn+PIb2fFcpScKORfsAGB0/h/yLJYM48JkKfglAI8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hs+2TbkfeMy1WgWEvNLXwvqg2Ul9E6hUs1G8e8ESsnA=;
 b=QEmzHq6oudw0bsD703V1urp8SaspTgqqvFoQqDqok/FDvLOXu1wnSnIXghgP+eOqMKXaPZ2ULMBk7Lwcey6Za/zstBJK25KL3uzHwtTBZp+A3ZWSlqqQiGJQXOGJpepYWzOqGgkUZWivh1VzoIQWSbBvqktRxfM+nmRwH95EjLgaRjlRlVWWqMHROIc0iyGHwGcpLpCRwwu6bQakKSMBJXBt8VwhiomTTZx+FeTpxMpxpz95enkzb+qVAUCpVhXef5uc1S5pkmqJaDexIGt2H/grMqOFeXszjpY/j7Ww+XRjUPTFdq89kmDsrrT3ElSaDrWG+s3FhdjRWXzn+/aNmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hs+2TbkfeMy1WgWEvNLXwvqg2Ul9E6hUs1G8e8ESsnA=;
 b=afBJRSZ2zCsLb/ebVDkIh0aca66FaRANBAA9m3WzXuxvK0kWtJNjIJkdZktuy4njL7xErbdjHmcZ1dPHogo5544+eOCLtDb+ApDbqN8UaxrhZs1B7EWtA9+pCvYriuy+o68kV6DZnGSiuvB1yA0QmI0LxIUOgrbQYLZMEDSKy48=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8654.eurprd04.prod.outlook.com (2603:10a6:102:21d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Fri, 14 Oct
 2022 03:31:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 03:31:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH 1/6] dt-bindings: usb: ci-hdrc-usb2: convert to yaml
Thread-Topic: [PATCH 1/6] dt-bindings: usb: ci-hdrc-usb2: convert to yaml
Thread-Index: AQHY3JFpH3+SFeJjVEaQOeCmvKBDc64Kwq+AgAJ+l4A=
Date:   Fri, 14 Oct 2022 03:31:19 +0000
Message-ID: <DU0PR04MB9417DDBD94BAC6B6E11CA7CB88249@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
 <20221010101816.298334-2-peng.fan@oss.nxp.com>
 <14d359c6-8cfc-c426-f264-1dbf79d1f09e@linaro.org>
In-Reply-To: <14d359c6-8cfc-c426-f264-1dbf79d1f09e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8654:EE_
x-ms-office365-filtering-correlation-id: 62bc430c-b873-4b74-dbc4-08daad948f86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R+gsMqByKJcdBny6BsJ3dILh4Sg6f5eTK0FkXz3zhuJyP3gtmpeTyBd4NuJU0M8Aw52YlTIj7lcAmaZWbiepgl4bZk7ug9P7OcIOQyx3BCDa+Y72FYyofj/pmoooKwPLf4aBFnGY9M3nWoOLwSxGoePZ6X5CwFmprdigwgRRJnONuUGxsUicnIs9WxvEfUsEeVwPCmH2BSrWEQKVjOJKWHxysmh3h4/RTpHKoTFqxrfcCoU2WDeZTVd6c9Ga5A0kDh+ES43Cujrw0TMirzrwjhcOd+VI7+q4PQtABvcGKivwMz/67WWv7BNG5OChzoO5dB4j2tZuRhH7ZRdTJwxwFRZ+TN4sVNksvAn3B6VDPKCLzyvBxoIvBXz/TsV+YXl/gsWklSTUoxDGsX7S4S+aRI9H2hdh1GE/QA5/Ldg/0b2ZHp4XoLheUxndreJA1CN7gsIo5JlunKBgu/m4UzOJ5wi6w7P/+XFVLkZ4G1DQh4ohDzagB0o4o6LdHPQL/sdY08zcPMDiPjcguEV3BOz5EGV4QnKmIu7xA6cbQftqT8gICYBPwsw9IfaHePqkifsae5unwzt7MFIYxqnybDBqt4pKU/KsC1PwOoUF5lFITuAvpZhfqPNCgB0W0zTn7Gl6ZoK47wG8pYiYXlo961qZkN6coDLOU8N01FHoL+lcAH0IHZShr8baMXzpii9gjhk8hqEipia3+nBlg1bKwI0N4x//aCUXu3/sSv8XSc8lFbD0yJ6jJvpA8hSCupDioSXxzrpAnw/rPlcJoQIcRRtojpgdPtiGzFR/IazAqd6Mu5A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(38070700005)(122000001)(38100700002)(5660300002)(7416002)(7696005)(55016003)(45080400002)(53546011)(478600001)(316002)(8676002)(54906003)(64756008)(76116006)(66946007)(66476007)(66446008)(66556008)(6506007)(4326008)(26005)(110136005)(41300700001)(86362001)(186003)(44832011)(9686003)(2906002)(33656002)(30864003)(71200400001)(83380400001)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jqIiBlVjEUqVTd77Z/pHWmXpGkH36aOxus88lJV39Uwkh8DiUpjk1Hnrz5/K?=
 =?us-ascii?Q?jMnU9r2MloybTCdHQ4IY3EEJHe8cLXY/S1CmExV+nVks0VtcieAO4+YwTjyu?=
 =?us-ascii?Q?xEuCAos1isvbFSGsbhdTUp77iAx3WlYl7g8RD4DV7d/7l7vS+5t/KqKmFKgD?=
 =?us-ascii?Q?e3dS5Jyzzlt3apmp7+goM7gMQLMYwlFXFNGqr5yKBf6IG3ibyCWQKzAu++4D?=
 =?us-ascii?Q?nT/bNKwYf8+mTlNgh6rJo6tQpu8L+rxYqdOf/jtuJRX8Frm8m7hba63YI9aU?=
 =?us-ascii?Q?DBoZgeslE1A5iVwscsN/wm1zmAulVGB+rrWQa5RxyvMzWYDeQkxQnWiTf/Vm?=
 =?us-ascii?Q?0lSotq4gDRqGv5ygUuou0INHk0li6x7NGaugMyEeEPHUrQwxndVaHoMbmWpv?=
 =?us-ascii?Q?X8oQtI4CUFrrJ7VkjQ/iUg9aNH/b6haCC6OfoKdUhHPE45h76PRj3Lpc/s2u?=
 =?us-ascii?Q?sqdxtROV5VJYNVw1/oYjxrGi1PIav9nAFqsiM/5+cr5U5x4khD4cZQb1yqT2?=
 =?us-ascii?Q?1ZUCthuxibk5MS/mdHQCTYoAkgUqzXtEysWO/dB0iRRJHbOfebQTEljPGn1+?=
 =?us-ascii?Q?viL/8xL0U6RGzQ5UJFp6jnE3B+72FqbDB3NS0Hg1bAjVk61odwOSuHiLp+D8?=
 =?us-ascii?Q?k8+Vvjbyj8Acan2D9a5y+0nK5tDQ31esQ1RoIeggwvHQ789LY8XWsRBisVCE?=
 =?us-ascii?Q?o2xBiSEA5nW4lbV9Q+lv1PQJ8Pszld4vIhBuaDv8vRTvyjvAezC5BJ6EiWA+?=
 =?us-ascii?Q?dgYEPdUcQ2yJglj7FntneOai7WJe7ohFq42bbsG71Ukp0ZqvYks96Xk6uTru?=
 =?us-ascii?Q?4eLEp3wGELmNBlhaJajUD5qCCll0Xedlho+2Lq2LmIiRuADze7cU1RxrBafE?=
 =?us-ascii?Q?5Oxt9Yiwb7wu5KdOaLJLEmApl1t+c8RnoNzy9ivHDurkCOqXPOXeeEDw+v1d?=
 =?us-ascii?Q?bqW8Hs590LOp5jVT9xWnu2lEg6WbbuA9RdBf+9jSFNfnUCNMeD5mX1tTfrL+?=
 =?us-ascii?Q?D7XWfnCZCXfMZenxjvyyKdmP/IKLEjd2EJPd0+ZCTp0bwRBSotTnromQZsy/?=
 =?us-ascii?Q?kzAglndjP/oBFpOXPyazwCD8uzmf5LD3PfpEJjCcPBob3S/2R2OUiJDC9/qO?=
 =?us-ascii?Q?Y4aO8AD4qnyrNl54JfQl21HP7bHelZq4Rl3Uz853K5uBliQebj7cwJeEFJS7?=
 =?us-ascii?Q?+K/zbkIvGMO0QmYsE5Prq0TVWv+GuL78yq8A8iDYeLb0CeNAlaH5pjTW9qQS?=
 =?us-ascii?Q?SX+TJIa9HEKZwRpPM3OzH4s88n2Ury/i4vry++AWHlXvdvCYRUTE6tY+NlPD?=
 =?us-ascii?Q?0eBJFHKHhLaMzddEAikM7cCxcu/waLPhJHfC4wBOrSqOLoPwPa5wEZ0mXWSs?=
 =?us-ascii?Q?pIB3wvGHjqX9Su1DD2YDXjHPcizzANitHgNvhJRDsUs03krLLNhU4O3I4gG0?=
 =?us-ascii?Q?Ci95z8M2uExMlDFTfXY4xan4aJa1r6vPC2Cdi3a61Z2u6l0rc/IyWxGIVw6V?=
 =?us-ascii?Q?r0emVS6uxerY8+LCTbFdc25aYAdgYSahQINxPQen2LAO4SY4JSHEHumWX4Fi?=
 =?us-ascii?Q?rDu0B137HceS9jTUvos=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bc430c-b873-4b74-dbc4-08daad948f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 03:31:20.0466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GoOjprX8eeXY2ByaqUzmw10mr8nqa5zjJCLupUP2/ajS/wJlaxLqOlQ48zfoMFFuGf4Q8WvvF1P5wn1XWbRXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8654
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 1/6] dt-bindings: usb: ci-hdrc-usb2: convert to yaml
>=20
> On 10/10/2022 06:18, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Convert the binding to yaml format
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 158 ---------
> > .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 306 ++++++++++++++++++
> >  2 files changed, 306 insertions(+), 158 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > deleted file mode 100644
> > index ba51fb1252b9..000000000000
> > --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > +++ /dev/null
> > @@ -1,158 +0,0 @@
> > -* USB2 ChipIdea USB controller for ci13xxx
> > -
> > -Required properties:
> > -- compatible: should be one of:
> > -	"fsl,imx23-usb"
> > -	"fsl,imx27-usb"
> > -	"fsl,imx28-usb"
> > -	"fsl,imx6q-usb"
> > -	"fsl,imx6sl-usb"
> > -	"fsl,imx6sx-usb"
> > -	"fsl,imx6ul-usb"
> > -	"fsl,imx7d-usb"
> > -	"fsl,imx7ulp-usb"
> > -	"lsi,zevio-usb"
> > -	"qcom,ci-hdrc"
> > -	"chipidea,usb2"
> > -	"xlnx,zynq-usb-2.20a"
> > -	"nvidia,tegra20-udc"
> > -	"nvidia,tegra30-udc"
> > -	"nvidia,tegra114-udc"
> > -	"nvidia,tegra124-udc"
> > -- reg: base address and length of the registers
> > -- interrupts: interrupt for the USB controller
> > -
> > -Recommended properies:
> > -- phy_type: the type of the phy connected to the core. Should be one
> > -  of "utmi", "utmi_wide", "ulpi", "serial" or "hsic". Without this
> > -  property the PORTSC register won't be touched.
> > -- dr_mode: One of "host", "peripheral" or "otg". Defaults to "otg"
> > -
> > -Deprecated properties:
> > -- usb-phy:      phandle for the PHY device. Use "phys" instead.
> > -- fsl,usbphy: phandle of usb phy that connects to the port. Use "phys"
> instead.
> > -
> > -Optional properties:
> > -- clocks: reference to the USB clock
> > -- phys: reference to the USB PHY
> > -- phy-names: should be "usb-phy"
> > -- vbus-supply: reference to the VBUS regulator
> > -- maximum-speed: limit the maximum connection speed to "full-speed".
> > -- tpl-support: TPL (Targeted Peripheral List) feature for targeted
> > hosts
> > -- itc-setting: interrupt threshold control register control, the
> > setting
> > -  should be aligned with ITC bits at register USBCMD.
> > -- ahb-burst-config: it is vendor dependent, the required value should
> > be
> > -  aligned with AHBBRST at SBUSCFG, the range is from 0x0 to 0x7. This
> > -  property is used to change AHB burst configuration, check the
> > chipidea
> > -  spec for meaning of each value. If this property is not existed, it
> > -  will use the reset value.
> > -- tx-burst-size-dword: it is vendor dependent, the tx burst size in
> > dword
> > -  (4 bytes), This register represents the maximum length of a the
> > burst
> > -  in 32-bit words while moving data from system memory to the USB
> > -  bus, the value of this property will only take effect if property
> > -  "ahb-burst-config" is set to 0, if this property is missing the
> > reset
> > -  default of the hardware implementation will be used.
> > -- rx-burst-size-dword: it is vendor dependent, the rx burst size in
> > dword
> > -  (4 bytes), This register represents the maximum length of a the
> > burst
> > -  in 32-bit words while moving data from the USB bus to system
> > memory,
> > -  the value of this property will only take effect if property
> > -  "ahb-burst-config" is set to 0, if this property is missing the
> > reset
> > -  default of the hardware implementation will be used.
> > -- extcon: phandles to external connector devices. First phandle
> > should point to
> > -  external connector, which provide "USB" cable events, the second
> > should point
> > -  to external connector device, which provide "USB-HOST" cable
> > events. If one
> > -  of the external connector devices is not required, empty <0>
> > phandle should
> > -  be specified.
> > -- phy-clkgate-delay-us: the delay time (us) between putting the PHY
> > into
> > -  low power mode and gating the PHY clock.
> > -- non-zero-ttctrl-ttha: after setting this property, the value of
> > register
> > -  ttctrl.ttha will be 0x7f; if not, the value will be 0x0, this is
> > the default
> > -  value. It needs to be very carefully for setting this property, it
> > is
> > -  recommended that consult with your IC engineer before setting this
> value.
> > -  On the most of chipidea platforms, the "usage_tt" flag at RTL is 0,
> > so this
> > -  property only affects siTD.
> > -  If this property is not set, the max packet size is 1023 bytes, and
> > if
> > -  the total of packet size for pervious transactions are more than
> > 256 bytes,
> > -  it can't accept any transactions within this frame. The use case is
> > single
> > -  transaction, but higher frame rate.
> > -  If this property is set, the max packet size is 188 bytes, it can
> > handle
> > -  more transactions than above case, it can accept transactions until
> > it
> > -  considers the left room size within frame is less than 188 bytes,
> > software
> > -  needs to make sure it does not send more than 90%
> > -  maximum_periodic_data_per_frame. The use case is multiple
> > transactions, but
> > -  less frame rate.
> > -- mux-controls: The mux control for toggling host/device output of
> > this
> > -  controller. It's expected that a mux state of 0 indicates device
> > mode and a
> > -  mux state of 1 indicates host mode.
> > -- mux-control-names: Shall be "usb_switch" if mux-controls is specifie=
d.
> > -- pinctrl-names: Names for optional pin modes in "default", "host",
> "device".
> > -  In case of HSIC-mode, "idle" and "active" pin modes are mandatory.
> > In this
> > -  case, the "idle" state needs to pull down the data and strobe pin
> > -  and the "active" state needs to pull up the strobe pin.
> > -- pinctrl-n: alternate pin modes
> > -
> > -i.mx specific properties
> > -- fsl,usbmisc: phandler of non-core register device, with one
> > -  argument that indicate usb controller index
> > -- disable-over-current: disable over current detect
> > -- over-current-active-low: over current signal polarity is active low.
> > -- over-current-active-high: over current signal polarity is active hig=
h.
> > -  It's recommended to specify the over current polarity.
> > -- power-active-high: power signal polarity is active high
> > -- external-vbus-divider: enables off-chip resistor divider for Vbus
> > -- samsung,picophy-pre-emp-curr-control: HS Transmitter Pre-Emphasis
> > Current
> > -  Control. This signal controls the amount of current sourced to the
> > -  USB_OTG*_DP and USB_OTG*_DN pins after a J-to-K or K-to-J transition=
.
> > -  The range is from 0x0 to 0x3, the default value is 0x1.
> > -  Details can refer to TXPREEMPAMPTUNE0 bits of USBNC_n_PHY_CFG1.
> > -- samsung,picophy-dc-vol-level-adjust: HS DC Voltage Level Adjustment.
> > -  Adjust the high-speed transmitter DC level voltage.
> > -  The range is from 0x0 to 0xf, the default value is 0x3.
> > -  Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
> > -
> > -Example:
> > -
> > -	usb@f7ed0000 {
> > -		compatible =3D "chipidea,usb2";
> > -		reg =3D <0xf7ed0000 0x10000>;
> > -		interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > -		clocks =3D <&chip CLKID_USB0>;
> > -		phys =3D <&usb_phy0>;
> > -		phy-names =3D "usb-phy";
> > -		vbus-supply =3D <&reg_usb0_vbus>;
> > -		itc-setting =3D <0x4>; /* 4 micro-frames */
> > -		 /* Incremental burst of unspecified length */
> > -		ahb-burst-config =3D <0x0>;
> > -		tx-burst-size-dword =3D <0x10>; /* 64 bytes */
> > -		rx-burst-size-dword =3D <0x10>;
> > -		extcon =3D <0>, <&usb_id>;
> > -		phy-clkgate-delay-us =3D <400>;
> > -		mux-controls =3D <&usb_switch>;
> > -		mux-control-names =3D "usb_switch";
> > -	};
> > -
> > -Example for HSIC:
> > -
> > -	usb@2184400 {
> > -		compatible =3D "fsl,imx6q-usb", "fsl,imx27-usb";
> > -		reg =3D <0x02184400 0x200>;
> > -		interrupts =3D <0 41 IRQ_TYPE_LEVEL_HIGH>;
> > -		clocks =3D <&clks IMX6QDL_CLK_USBOH3>;
> > -		fsl,usbphy =3D <&usbphynop1>;
> > -		fsl,usbmisc =3D <&usbmisc 2>;
> > -		phy_type =3D "hsic";
> > -		dr_mode =3D "host";
> > -		ahb-burst-config =3D <0x0>;
> > -		tx-burst-size-dword =3D <0x10>;
> > -		rx-burst-size-dword =3D <0x10>;
> > -		pinctrl-names =3D "idle", "active";
> > -		pinctrl-0 =3D <&pinctrl_usbh2_idle>;
> > -		pinctrl-1 =3D <&pinctrl_usbh2_active>;
> > -		#address-cells =3D <1>;
> > -		#size-cells =3D <0>;
> > -
> > -		usbnet: ethernet@1 {
> > -			compatible =3D "usb424,9730";
> > -			reg =3D <1>;
> > -		};
> > -	};
> > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > new file mode 100644
> > index 000000000000..1c10691c45f2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > @@ -0,0 +1,306 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fschemas%2Fusb%2Fci-hdrc-
> usb2.yaml%23&amp;data=3D05%7C01%7C
> >
> +peng.fan%40nxp.com%7C730bfc13b48e44f69cff08daac550e45%7C686ea1
> d3bc2b4
> >
> +c6fa92cd99c5c301635%7C0%7C0%7C638011778555556152%7CUnknown%
> 7CTWFpbGZs
> >
> +b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3
> >
> +D%7C3000%7C%7C%7C&amp;sdata=3DNkNmk8iE0PJIBf4nd4%2FzVeJc7BvQZ
> bKgSDPMeqX
> > +RBzE%3D&amp;reserved=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cpeng.fan%
> >
> +40nxp.com%7C730bfc13b48e44f69cff08daac550e45%7C686ea1d3bc2b4c6f
> a92cd9
> >
> +9c5c301635%7C0%7C0%7C638011778555712848%7CUnknown%7CTWFpb
> GZsb3d8eyJWI
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C3000%
> >
> +7C%7C%7C&amp;sdata=3DPRa5a5NBGffcTadY6hzRM%2BZbyUSGLfWKlGkKyu
> xjnJI%3D&a
> > +mp;reserved=3D0
> > +
> > +title: USB2 ChipIdea USB controller for ci13xxx Binding
> > +
> > +maintainers:
> > +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - chipidea,usb2
> > +          - lsi,zevio-usb
> > +          - nvidia,tegra20-udc
> > +          - nvidia,tegra30-udc
> > +          - nvidia,tegra114-udc
> > +          - nvidia,tegra124-udc
> > +          - qcom,ci-hdrc
> > +      - items:
> > +          - enum:
> > +              - fsl,imx23-usb
> > +              - fsl,imx25-usb
> > +              - fsl,imx28-usb
> > +              - fsl,imx6q-usb
> > +              - fsl,imx6sl-usb
> > +              - fsl,imx6sx-usb
> > +              - fsl,imx6ul-usb
> > +              - fsl,imx7d-usb
> > +          - const: fsl,imx27-usb
> > +      - items:
> > +          - const: fsl,imx7ulp-usb
> > +          - const: fsl,imx6ul-usb
> > +      - items:
> > +          - const: lsi,zevio-usb
>=20
> You already have this in first enum.
>=20
> > +      - items:
> > +          - const: xlnx,zynq-usb-2.20a
> > +          - const: chipidea,usb2
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
>=20
> Your patches have several white-space issues.
>=20
> Don't send patches which fail checkpatch.
>=20
> > +  clocks:
> > +    maxItems: 2
> > +
> > +  itc-setting:
> > +    description:
> > +      interrupt threshold control register control, the setting should=
 be
> > +      aligned with ITC bits at register USBCMD.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  ahb-burst-config:
> > +    description:
> > +      it is vendor dependent, the required value should be aligned wit=
h
> > +      AHBBRST at SBUSCFG, the range is from 0x0 to 0x7. This property =
is
> > +      used to change AHB burst configuration, check the chipidea spec =
for
> > +      meaning of each value. If this property is not existed, it will =
use
> > +      the reset value.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0x0
> > +    maximum: 0x7
> > +
> > +  tx-burst-size-dword:
> > +    description:
> > +      it is vendor dependent, the tx burst size in dword (4 bytes), Th=
is
> > +      register represents the maximum length of a the burst in 32-bit
> > +      words while moving data from system memory to the USB bus, the
> value
> > +      of this property will only take effect if property "ahb-burst-co=
nfig"
> > +      is set to 0, if this property is missing the reset default of th=
e
> > +      hardware implementation will be used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  rx-burst-size-dword:
> > +    description:
> > +      it is vendor dependent, the rx burst size in dword (4 bytes), Th=
is
> > +      register represents the maximum length of a the burst in 32-bit =
words
> > +      while moving data from the USB bus to system memory, the value o=
f
> > +      this property will only take effect if property "ahb-burst-confi=
g"
> > +      is set to 0, if this property is missing the reset default of th=
e
> > +      hardware implementation will be used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  extcon:
> > +    description: |
> > +      Phandles to external connector devices. First phandle should poi=
nt
> > +      to external connector, which provide "USB" cable events, the sec=
ond
> > +      should point to external connector device, which provide "USB-HO=
ST"
> > +      cable events. If one of the external connector devices is not
> > +      required, empty <0> phandle should be specified.
> > +
> > +  phy-clkgate-delay-us:
> > +    description: |
> > +      The delay time (us) between putting the PHY into low power mode
> and
> > +      gating the PHY clock.
> > +
> > +  non-zero-ttctrl-ttha:
> > +    description: |
> > +      After setting this property, the value of register ttctrl.ttha
> > +      will be 0x7f; if not, the value will be 0x0, this is the default
> > +      value. It needs to be very carefully for setting this property, =
it
> > +      is recommended that consult with your IC engineer before setting
> > +      this value.  On the most of chipidea platforms, the "usage_tt" f=
lag
> > +      at RTL is 0, so this property only affects siTD.
> > +
> > +      If this property is not set, the max packet size is 1023 bytes, =
and
> > +      if the total of packet size for pervious transactions are more t=
han
> > +      256 bytes, it can't accept any transactions within this frame. T=
he
> > +      use case is single transaction, but higher frame rate.
> > +
> > +      If this property is set, the max packet size is 188 bytes, it ca=
n
> > +      handle more transactions than above case, it can accept transact=
ions
> > +      until it considers the left room size within frame is less than =
188
> > +      bytes, software needs to make sure it does not send more than 90=
%
> > +      maximum_periodic_data_per_frame. The use case is multiple
> > +      transactions, but less frame rate.
> > +
> > +  mux-controls:
> > +    description: |
> > +      The mux control for toggling host/device output of this controll=
er.
> > +      It's expected that a mux state of 0 indicates device mode and a =
mux
> > +      state of 1 indicates host mode.
> > +
> > +  mux-control-names:
> > +    description: Shall be "usb_switch" if mux-controls is specified.
>=20
> Just define the item here.
>=20
> > +
> > +  pinctrl-names:
> > +    description: |
> > +      Names for optional pin modes in "default", "host", "device".
> > +      In case of HSIC-mode, "idle" and "active" pin modes are mandator=
y.
> > +      In this case, the "idle" state needs to pull down the data and
> > +      strobe pin and the "active" state needs to pull up the strobe pi=
n.
>=20
> Describe the items. Otherwise this does not make much sense, because core
> allows it.

The allOf section has below restriction, I not understand well that still n=
eed to describe
items here?
  - if:
      properties:
        phy_type:
          const: hsic

      required:
        - phy_type
    then:
      properties:
        pinctrl-names:
          items:
            - const: idle
            - const: active
    else:
      properties:
        pinctrl-names:
          oneOf:
            - items:
                - const: default
                - enum:
                    - host
                    - device
            - items:
                - const: default

Thanks,
Peng.
>=20
> > +
> > +  pinctrl-0:
> > +    maxItems: 1
> > +
> > +  pinctrl-1:
> > +    maxItems: 1
> > +
> > +  phys:
> > +    maxItems: 1
> > +
> > +  phy-names:
> > +    const: usb-phy
> > +
> > +  vbus-supply:
> > +    description: reference to the VBUS regulator.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +allOf:
> > +  - $ref: usb-drd.yaml#
> > +  - $ref: usb-hcd.yaml#
> > +  - if:
> > +      properties:
> > +        mux-controls:
> > +          true
> > +    then:
> > +      properties:
> > +        mux-control-names:
> > +          const: usb_switch
> > +  - if:
> > +      properties:
> > +        phy_type:
> > +          const: hsic
> > +
> > +      required:
> > +        - phy_type
> > +    then:
> > +      properties:
> > +        pinctrl-names:
> > +          items:
> > +            - const: idle
> > +            - const: active
> > +    else:
> > +      properties:
> > +        pinctrl-names:
> > +          oneOf:
> > +            - items:
> > +                - const: default
> > +                - enum:
> > +                    - host
> > +                    - device
> > +            - items:
> > +                - const: default
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,imx23-usb
> > +            - fsl,imx25-usb
> > +            - fsl,imx27-usb
> > +            - fsl,imx28-usb
> > +            - fsl,imx6q-usb
> > +            - fsl,imx6sl-usb
> > +            - fsl,imx6sx-usb
> > +            - fsl,imx6ul-usb
> > +            - fsl,imx7d-usb
> > +            - fsl,imx7ulp-usb
> > +    then:
> > +      properties:
> > +        fsl,usbmisc:
>=20
> What's the type? Which other schema defined it?
>=20
> Same applies to several other properties - are you sure they are already
> defined by some other schema?
> > +...
>=20
> Best regards,
> Krzysztof

