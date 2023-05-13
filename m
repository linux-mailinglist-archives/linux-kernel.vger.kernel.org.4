Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9B701455
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 06:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjEMEX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 00:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMEXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 00:23:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9FB10C0;
        Fri, 12 May 2023 21:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c39LirA5RzuOJ2XnH7wV6aiip09hkCPR/k6VDggl359lT5y0bGuB15ajQnso2vj7J3vrYG8hCYlOGW7DZWhHf/yRSCEeHj4XwDuzeX+Nyw1u7zgbKlrKUt1zFuk+pIcZJQRqQrMxVHRmkVQGojEots6KW62MaBBwRKbKOIwiyZS8x2pM05dBvqdTL7cHaXnKRxOmvjSjfIfeenW6TMIr3CaypyRhhC/0jMw7pFw6kx/Wy0Bvbe6Be64RE2vAb1tRNItB4NsF70MpEGB8K/uBujdcxWOL1pADtgw0u5i3b3bwTBc+suwrWGoYt508FWTInzC24l4gvlbInP9taDSRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6QxG1sx4D1SPOj2AHBh9YpqPsVr/iUVRlnWOYrL4Rc=;
 b=eATMdPka1NeyeslIW2n8bIomxORo2Ye0kJahrKuEzSBTRIWHj7RrPWcWbLLqkUIb/DZfC5ECwoKmDWjuqLxxPoCKqDAS2M7sbXNi7Y8wXhHsZCBAvRMnuGKBMNKsWbs6b9FsUi3YIpFaBQZOD1MzyiJBDKyxmuvm7tRSLmbQqszHtdZwyDCCfo8ITkViG5E4CGgcNwpNTa2X5usF+LH6RryOX/HUsKg6cjSjDHD49IVNhe9GmA3bsAwAbpx10kTPzmSpN+L8Y9MuuCShCub3xbyjzbPaf7GzdhcqGev5CuE22evJ1HmlcREhw3W8oybBdcdfryvIWyp7Z7WzHw9rJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6QxG1sx4D1SPOj2AHBh9YpqPsVr/iUVRlnWOYrL4Rc=;
 b=R4VWP0icAAb4HTF2vkW7sTwZvEuuY7lIi6rUDb4gVoWRCys9CExBMfuc3uCGTV2fHKH4Ex/PwgKezHp8HZqkOkn+SO6iSQlZ7t1WO4/jawZ04kViVft7x99t1fgtSQrGWWwEm5ElW69q1wfVsPkxTQ9kf5vwDzTMat9Zn+fCY9Y=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7419.eurprd04.prod.outlook.com (2603:10a6:102:80::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Sat, 13 May
 2023 04:23:50 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.023; Sat, 13 May 2023
 04:23:50 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH 1/1] arm64: dts: imx8: fix USB 3.0 Gadget
 Failure in QM & QXPB0 at super speed
Thread-Topic: [EXT] Re: [PATCH 1/1] arm64: dts: imx8: fix USB 3.0 Gadget
 Failure in QM & QXPB0 at super speed
Thread-Index: AQHZbh/AiOj349Wx2UW73kdHsqlF4K9XvroAgAAJy8A=
Date:   Sat, 13 May 2023 04:23:50 +0000
Message-ID: <AM6PR04MB48384EE068A9B8247C69E3C6887A9@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230413155043.102307-1-Frank.Li@nxp.com>
 <20230513034624.GE727834@dragon>
In-Reply-To: <20230513034624.GE727834@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|PR3PR04MB7419:EE_
x-ms-office365-filtering-correlation-id: f3cc5a47-30b4-495b-d07b-08db5369da63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WeV4eb43XFsRHXIO/m1bksTOPBgYYa/Nd4LasUOE0SPK/FKYHZDH8q7J8pmD2soezxzfM/LTjOO7gznzE7lZK5yNcGKzET454kPLYWKjvcTCdCd0vOnHUzPJxc1OoLVclW7CYHq+JqNXWN2LlYn+feYlgPvLy1TLLmbl1GjPFftlUhD+0f+sAoBbGOz1MLksBDmhKgDz/HI7PWNEFRLsPEOwOb+a8qo8UWOJqn3/zyg3H/WxLG1a+vtY5NwD0P+2QER+Ppvo+YicajVXZjTXEl9ZExHPqTbUKaOjsq/3nJim9vLwxnU1O4W7Jy+Ja4IA7l9u4705cIFnqvPEjrW+76HnB+D2VJrecioJPse49LXIow/7Hsw0rYACWCrQ6biBwP9aZJpYJYkn7Hm+UPxb5rW+CJ024Ts1MsqcQH3rkJ850ZBgUWYmNw0EWxcZZVF5iTJKqZi3RCh0uT5jhK217cGh/Rkxw1Jq09jLTiJevc3GdiJGMxS8i8Gdlej1DY3sbSsqsq9Wd0vX3JzIjZQrjEUg21++XwbQ4VIgBziJFuKEn7/zM37oY5ATgF16tCN6oICP5WtJDz+al0J8nj36CYicxl1Sz3ZjzcTuJQnTDEHZ8m3qKWoAuneVJ4QD4TDs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(54906003)(26005)(55236004)(9686003)(186003)(478600001)(6506007)(7696005)(38100700002)(55016003)(122000001)(71200400001)(4744005)(2906002)(44832011)(52536014)(8676002)(7416002)(5660300002)(38070700005)(8936002)(41300700001)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(33656002)(4326008)(83380400001)(6916009)(86362001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vqKRaTC0YYiWT7tU5JMEM3dpyrxfg6WltWs6X8C6wW3JRPKg7CzJ1mHfcpbp?=
 =?us-ascii?Q?0JSXh9CYpK+r5yiURK0u4TpLKK1mfiJFW5TB1o+0TZIpWDOWEg3jgrE/WYNZ?=
 =?us-ascii?Q?pXpmxns2oT16F/BQRRePq51oSSUN8lPCc6AfY8rpIKjkuKyQPxMwgBRFnZwz?=
 =?us-ascii?Q?WP5z3pqQ5Ry+56fBzusgRasKcQPI9qHXA8trSAIxBQlSEj4jMDmJyWBeAOvj?=
 =?us-ascii?Q?fCkwkvOtTlGdtxa+4bhuk2NMrlvARQFv4Y0+Y4vqEXNEZy/YBDgKBKgw4uS1?=
 =?us-ascii?Q?f0vL3InKKnY3zh+m7pzqse0jG+SwVyz15S+NC3KpmdYfr8GeOzA53EqhHJMb?=
 =?us-ascii?Q?hCygTQSwRg38JH/iTr5O3VKo2JZM9yNCTb29DDlwtpDN1lXgIrkrpVHYt50m?=
 =?us-ascii?Q?2UYZ2mTt4AlUHdeFxq7sMiL5PmfStmrVsMNSfci3iQJWUHD4Ihvir7DaHSyR?=
 =?us-ascii?Q?wTlEPhxkmZMMiWXKfRsG3wcBqaIYOhc45e/LexfVWOaJBqipHTa65AGmmeat?=
 =?us-ascii?Q?/aG8bmAKJeA35m/XdjVdMV5KDK51GhGH50kcyDfZDELL6x0K2JojhvJLlDoF?=
 =?us-ascii?Q?N8ZKvUICwwgtd2+tgr3pPYeE9JiqFnwqhNY1UP0XqN0K5lR8a5xa/mTM0mp4?=
 =?us-ascii?Q?KPT54wu8jwZ+lsv4NyFG2y/A/6CzVP8999dXnDiVPpaWW/Ckr9y2TCoSoiMv?=
 =?us-ascii?Q?yTBOpFSazb86bJmvTKqQTEw18BFLZ0+++e/sRZAQPYaqlrqYuKi1bf141H/1?=
 =?us-ascii?Q?SESvCb2zHbv63KM0nzRprfqIlu6bNm530JH83d/xHOS6P3VKexLhR9sVbBId?=
 =?us-ascii?Q?pEwmdZCyGUsaToeBob615/b6s7RlDeRTllnSKOaArNi9aNekHg8svr6eM1hn?=
 =?us-ascii?Q?hGcC0nhoRGjdt4sH5rMJ+a8tTZzxFhesJT9BYIEDXb18v/HKowzquRYc2S+P?=
 =?us-ascii?Q?hvIGO/lWMU5rdQDe69J/IO84Onui4fjg2+tTlR0p/76KpE7o/VYQzpYbQ9rj?=
 =?us-ascii?Q?y4Voz9NxngDdR3ykbNQ3qd1u5SgjD5KUuMpeXw3DtacEgUiXPHZXtrvo5vd/?=
 =?us-ascii?Q?Hsra6GGr1jox1gp3W+aiJvW8v41EheLCYjBXrwADHldR7l8Ryme1mGvakv5K?=
 =?us-ascii?Q?AylD3XzAQwRMHgyDUSaJJsXvZL2nJfTtrGEGS7Q87J045DRqsp8Sb12J9qde?=
 =?us-ascii?Q?LiJ0663HWzdvNkHNghopYKTEkfaqRe7bOuBfedErajEKo/lEmV4GL2r4+Uq4?=
 =?us-ascii?Q?FrHhLZg2q+su14TIpAkOU+4atCC/sbjX72b/gU4CSlpITkq7TK8d6vtJnV+o?=
 =?us-ascii?Q?5uV4DK2+0sNBstM90llnBZh99U0qt7SZt7xVctZ8XC3pu83C8ZuXleTZS+2m?=
 =?us-ascii?Q?QgnVnBODVGJxYE7CfcjocoNzVynaypIwI6XRhYoDvv+oWkVGrWwqmWdzyDBy?=
 =?us-ascii?Q?PabE0p0w4sBwG4qaqoAxhuMQjmeVj4QUb6VIdVNN+zxerPsAw7qohScbycAr?=
 =?us-ascii?Q?f10oinWafjS2vtNhLie69kYe5jaeCVxjNhXQP5WXfRRoe2pAdqEicr8R//TH?=
 =?us-ascii?Q?vQFcLa1iaJ3jmkYqhaA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cc5a47-30b4-495b-d07b-08db5369da63
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2023 04:23:50.3080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kC4idj6ir0ynYWJsFL0afAgMf8vU1ps9BcOuA5M2YWAISpQdiS9p2sWgouLLqru/E1sQMVTV6C2WheG22nWyKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7419
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>=20
> > ---
> >  arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> > index b32c2e199c160..030c273c8be40 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> > @@ -171,6 +171,7 @@ usbotg3_cdns3: usb@5b120000 {
> >                       interrupt-names =3D "host", "peripheral", "otg", =
"wakeup";
> >                       phys =3D <&usb3_phy>;
> >                       phy-names =3D "cdns3,usb3-phy";
> > +                     cdns,on-chip-buff-size =3D /bits/ 16 <18>;
>=20
> The property is defined as uint32 in the bindings.  Not sure why we
> need to enforce 16-bits here.

Driver code use 16bit, if use 32bit here, it will be zero.=20
I have not checked bindings doc. Next version will fix binding doc.

Frank

>=20
> Shawn
>=20
> >                       status =3D "disabled";
> >               };
> >       };
> > --
> > 2.34.1
> >
