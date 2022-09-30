Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878285F062A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiI3ICz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiI3ICw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:02:52 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D6B129FCE;
        Fri, 30 Sep 2022 01:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMzm1aCFS57oxx8i5H9DN7EcsnbX+5whyguMpqcRXR+TtlJl8OuqmWXV5LBofe6C/C+uqPi7qqcxwVaeuzGBXLcRukhZlv+n0w8/jeivrmzsVSvZi0rnqsWJMRSSAvhIChZAD4ivZLO6LYg5F7lHfteGV6tekpKsiNNV4Dg0ZXasjHFvCAIYr62jpAJ8adHpQUzPD+RtHJm6ZalWYN8DQBs4nSeIKdZxYnGpAml2uo6TF26QvGcsP5klKvq1gb1jDCc06iqAM6vKfrurTEqUNisEqXCLfTaYPXnmpXxlsJ087DGqLAl6ZhAd8AfEnxv0IK+SwsUxd6WEDkObifcCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGL3Adm0yEIaFJbuecOZy9ZWFgI6Ggj9Jn1S6y8RU00=;
 b=EtQN3Ly0i3azhn7bMs1Fnkam6bzkoVHPpQXuQd7UVanUiko7NvIGD+6sX5hjUYf8OmVFxyH2CY+GecZcJYzpuT7sOqO0VYA0zx5T2REnUzMU4Q7yvpGdsPK/x0lCXUxiG/RWeDS8Pdu8vQBeu5ERKhwfM0VObbGAm+CjThX4zGWaizr4r2vsZX9evczoKyW6ZRg8qCozel4OnSVChmbShMhEoJrXZbCZQTgE85q4wdp2qykCBc+mV6K/HmwKubR59dRYwlbs3hhPhsnf+cXMShkom2R/87sLHZj2Jgjn4Lwe9HhpuTHdHYz8bBgWur/qtv2hkAnACYy/gDZNb58A2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGL3Adm0yEIaFJbuecOZy9ZWFgI6Ggj9Jn1S6y8RU00=;
 b=nA5/H0icnbyOuQo2iTR1iPXfXgSZvQjJ73mDc+uoUhjPfh0ZKJfEh24VLBc5WQ/NwGtByZXTIIJd/E567tNlV7XEG3l7vv8IzrlM+cEzSsqTakT3RNqm8cWa8PXiNsqaaGtGERWbxm4BpStiS1ZmXFNyuFzEvnPjl49Q7E2kxpo=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR04MB7005.eurprd04.prod.outlook.com (2603:10a6:803:136::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 08:02:48 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::121:6a2a:2d4b:cb8a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::121:6a2a:2d4b:cb8a%8]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 08:02:48 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] Revert "serial: fsl_lpuart: Reset prior to registration"
Thread-Topic: [PATCH] Revert "serial: fsl_lpuart: Reset prior to registration"
Thread-Index: AQHY0+EeaAH9c/DrIUi1YG5YmLZWk632OyYAgAAB3mCAAAXMAIABWEgQ
Date:   Fri, 30 Sep 2022 08:02:48 +0000
Message-ID: <AS8PR04MB8404FAD25C9881FAD2754FB192569@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220929085318.5268-1-sherry.sun@nxp.com>
 <1265873d-28f9-d39c-5cce-858dbed1e8e8@linux.intel.com>
 <AS8PR04MB84044F397918A3475B5D8D1D92579@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <39c68295-947-2353-d9b-3bd654c38c7@linux.intel.com>
In-Reply-To: <39c68295-947-2353-d9b-3bd654c38c7@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|VI1PR04MB7005:EE_
x-ms-office365-filtering-correlation-id: 5625acd1-8d50-406a-0cae-08daa2ba2a81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SiSSoir+mQdlvwlGKoaVcd9naabG2WRDD9lYDpQefPOrrOXq2TMF70gLKMPdwrwxXYaoareq35zV777Xpvva1HgyNpjL3JWVOM2K3tZwJZuMU7jAhLEUOtRACuwoj6+FaVr0chzP6Y6oS47wTl+P9TTxFyxCeJaa9QLsvFTLEoY64rU5X2G5Fr9mH8QsfIbWHrBNXSuZIl5yl+fmFeTe+B6SzDQKr+lTf4f7DxMhcsK6skDWGPNWcsj4I1aG+kXv7wK7jZ4/S2x5vy9SJeZ4UNKtrxwOASWymz72iDU6u3sNylO7WM6TkO3jobU2GW+OwMSiG2QlUAtwaWpKgDqTBf3mLLU60yRtaTWE+n9bGHvHpJvaIO2tRQzUacO9Ur6/gxo635kJtcUFA5XK1WX8t2TFXnIjIs9a5ScHRF3XIhgPQ71G3zi5VcNdIJyZMTPra4rfRkoiISexh/MmgQYIYrByoKcSQdBopRCmlO8HosMxoojF8Ivd6Dwi3NhYUGcMjULOTp85S9YnG6BbCkCGfZvFUqZUpu7Rqvl9ZThcXf5EsouXpfAk0nlqrd6URcjneYdWZ9YMgdNT16nsozB5i1HWIkykFVnZtiQJBm7a80L1T018daNWvVxG0SbrSg0XGdn5dOyXo92pVfAncVuUa0v5u2L8olyrWhkM1g03+FniX0ZEj3AadLOQKL9XeAUuybD9/ONLVjCW3lByFw0Dqw11c8uCkJnp1Wmn9jOC9/cb5j6ER8TU1/8pNkr7+MQa8zKM4YvrMrtI6jJ3NFmfxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199015)(478600001)(6506007)(9686003)(26005)(7696005)(83380400001)(186003)(5660300002)(2906002)(44832011)(55016003)(6916009)(54906003)(316002)(8936002)(41300700001)(76116006)(8676002)(4326008)(66556008)(64756008)(66476007)(66446008)(71200400001)(66946007)(52536014)(38070700005)(33656002)(86362001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TAogfPksClb8zV3604po88CvBSTxY3VgvMCjzqz8zgWVj1A1VFS/oge74H?=
 =?iso-8859-1?Q?xychnOVguIDVSg69i1IuBE3i7sYXBS7t0SaF5DwUpej0bgm89sdwcPNHmC?=
 =?iso-8859-1?Q?XjZ1CtIaJdVltddwn202KOFyF7p3I2rT+eU/tm3oSnohVUQnrtDY1ywhdd?=
 =?iso-8859-1?Q?mDHqsX1p2j89oJX5c9E+XwpVbPBOHmSFG7c1uXZ9yzN5Gx29wg7RnRA5Lq?=
 =?iso-8859-1?Q?3rVwqYq44TGoU8csuu6qq9z4hocnYdKatN+ionsjzWYmvitDofpN6uo2Fk?=
 =?iso-8859-1?Q?IPz15lRQzE43rwvaEQaPM9h1FKx2SrSayMo7dr5ztHiyZuVFa4kcmWh+JX?=
 =?iso-8859-1?Q?UoI6Pu9w3ddCuPCF39mv0sS12QyuX3jPK5S4xJ2vYO2sasoloiEvGZLT9s?=
 =?iso-8859-1?Q?/P/2meJJFYm7lxDXXBobSPl/PftiF1d7c7oqx2SJqLh6G5/zzehfIy9lW+?=
 =?iso-8859-1?Q?Spsya+qfOxjUavi6e2MjsM+vUv9vU7BCukqu9MaiklFAldv7KIs3f2T1IK?=
 =?iso-8859-1?Q?VA03IhvO7Qffux5vLQIjv1nqaZJpeojiABdlfhIje4yIaQGt1UPRtZBn2G?=
 =?iso-8859-1?Q?GkK0J0sl6xJ4kFgpueamYe1XdedZXt+/sP0JzGiF05iP/ib6JxcZ95ns+t?=
 =?iso-8859-1?Q?Bh2CN5XLZEujvFydNzBe+F7uSk6uZ+SeHANI/dZx6QSsz6W8oxo+0JZcBI?=
 =?iso-8859-1?Q?LTgUCFeJGU+nmMjgrq9VM5cWZaL1bhavf+sOaAzybgqmSuPImCgmQ20xq0?=
 =?iso-8859-1?Q?4LvlsZYedsRFZcn7zy4u3X2WDQJHGanJE/txf04s+FMZkEWMc61g4PhEv7?=
 =?iso-8859-1?Q?FH6E+pWYaqex+glL4WmlR/qYdon7GJlA4IdODWRzkCKR5tchZpQTe9PsnH?=
 =?iso-8859-1?Q?pqsGUXYS6pN0GWKNp5DH8gSMp+cmysBWJFS1JE8cRz6mXliQXrsTUlbONb?=
 =?iso-8859-1?Q?op018NXpkBbPe2HbsHYxX3orzGfj7FhP+U0MuMI8UAKVPdQkzWB9EmdI4o?=
 =?iso-8859-1?Q?89QhBQRBeCcZF1IULWjxfL5C9Txh84t75tBqlPjb02OmaHWjZPem8+H2wN?=
 =?iso-8859-1?Q?rDPE5IOcI9U5Zv3sER5IjuD5nCwUSmWgWn+149o224tjyVy03JywosrkXQ?=
 =?iso-8859-1?Q?6iJLNGD2AXxDnEjJac7NqLzHVfCGZ8sVfVie++Qk3C2qXyQ8AGzbYuJO11?=
 =?iso-8859-1?Q?mr+KukLYooH1VJJHpYuUP9Nk7SaRezIiJbkSOQryktnMc9j6cORWkjysM0?=
 =?iso-8859-1?Q?dAujQkayrKJ+bqBv/PVHBiOfOoI+qfqMEcVqpCMAlWXusHuXJQnkChQqYZ?=
 =?iso-8859-1?Q?shcu+LR7Tw/6+yd36sQJWHDbBtonrEvzJ1yBpzkjt3Elw03oEQJ1w+8tn9?=
 =?iso-8859-1?Q?u7cFA6bOo66LFl3xgzmxziSSd/dxk6Qyfb+iEVmve1sz/xpkL0Q7dwyJxX?=
 =?iso-8859-1?Q?69pXHj2/XIOkQne/T4jumPcYShQ3V/8ftUKZT9YF/neKR//VND/ZdZxx3d?=
 =?iso-8859-1?Q?mtM9UH8qrBI9q48NEwn469gV3/hWET+tfq017rV9i4vdVwWMvIOCWMoojl?=
 =?iso-8859-1?Q?/YdYNAtlfQw6SYRvsbKc5guHPbP6VRpBd8+NcTUBAH+XjAZuWvcj0w/kz9?=
 =?iso-8859-1?Q?i8STNmQ9uUglhKg480kiZS2fBu6kGtVn0E?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5625acd1-8d50-406a-0cae-08daa2ba2a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 08:02:48.6907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shoGH4znGM04OxG43+kjmgVMWV7FtN+jOAe/EH+gjbRo3G7ZObDkL7qOrDrBuRl/aS0dY0NAT9MULBE39Sn3EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Thu, 29 Sep 2022, Sherry Sun wrote:
>=20
> > > > This reverts commit 60f361722ad2ae5ee667d0b0545d40c42f754daf.
> > > >
> > > > commit 60f361722ad2 ("serial: fsl_lpuart: Reset prior to
> > > > registration") causes the lpuart console cannot work any more.
> > > > Since the console is registered in the uart_add_one_port(), the
> > > > driver cannot identify the console port before call
> > > > uart_add_one_port(), which causes all the uart ports including the
> > > > console port will be global
> > > reset.
> > > > So need to revert this patch to avoid breaking the lpuart console.
> > > >
> > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > ---
> > > >  drivers/tty/serial/fsl_lpuart.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > > b/drivers/tty/serial/fsl_lpuart.c index 67fa113f77d4..7da46557fcb3
> > > > 100644
> > > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > > @@ -2722,10 +2722,6 @@ static int lpuart_probe(struct
> > > > platform_device
> > > *pdev)
> > > >  		handler =3D lpuart_int;
> > > >  	}
> > > >
> > > > -	ret =3D lpuart_global_reset(sport);
> > > > -	if (ret)
> > > > -		goto failed_reset;
> > > > -
> > >
> > > So the problem with this being so early is uart_console() in
> > > lpuart_global_reset() that doesn't detect a console because
> > > sport->cons is not yet assigned? Couldn't that be worked around
> differently?
> > >
> > > Or is there something else in addition to that I'm missing?
> > >
> > Hi Ilpo,
> >
> > Yes, the root cause of the console cannot work after apply the commit
> > 60f361722ad2 ("serial: fsl_lpuart: Reset prior to registration") is
> > lpuart_global_reset() cannot identify the console port, so reset all
> > uart ports.
>=20
> This didn't answer my question. Is the main cause just lacking the ->cons
> from sport at this point which, I guess, could be just assigned from lpua=
rt_reg
> similar to what uart_add_one_port() does before calling to reset?
>=20

Hi Ilpo,

Actually not only the (port)->cons need to be assigned, but also to get the=
 right (port)->cons->index.
23 #define uart_console(port) \
24     ((port)->cons && (port)->cons->index =3D=3D (port)->line)

The (port)->cons is assigned in uart_add_one_port(), quite simple.
3076     uport->cons =3D drv->cons;

But the (port)->cons->index is not that easy to get in lpuart driver, now t=
he value is assigned by calling register_console() from uart_configure_port=
().

Best Regards
Sherry

> --
>  i.
>=20
> > Actually I've been thinking about any other workaround all afternoon,
>  seems no other good options to me till now. And after a further check, I
> think the original patch is not needed, as uart_add_one_port() won't open
> the tty device, it should be safe to global reset the non-console ports  =
after
> uart_add_one_port().
> >
> > Best Regards
> > Sherry
> >

