Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6794B6A6C60
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCAMbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCAMbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:31:47 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2070.outbound.protection.outlook.com [40.107.13.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F43C39B9A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:31:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW0bWCZVavj0JFlPx5B37YGWZUqBu5HN8KSvTbvqtB3WnHqaMX4zvkv4noh0jHS5+ecfXfgOtWgDPaB9sMWICGaBFT9yGZHpjGXuMfIb6hZqA0WOG7BD4sdr9R6ZA/y4IQ22rNzAlTVz++QMWvlSHyUjZGZy9oxE0crDafFt3/n2K0YGEmfr5j27E6+fzw+vuORHRR8uQuY599uBs6PyJ/gZLDuQlVnwNXS9jp0QRkAlRZE+xbyqRcOHN9Kw3AH/PK3ujpm1eCXY8Py6DXH7vo9vVFVe8OolGuZglx4Hss4hZyWh1bjx/KjoHr4msYwyMw4hyUzuojpxkI5mff/3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nm489R+K37KVUue95aysabA+f4VovNB2NmrdTu0CS+U=;
 b=R0aKLyrgZEt4rDpeN4JNyx/6HSa6yhZQjDW2eZj5R7ru6mFOa6u3GkcRWQUiVJuS73ogAK+G64h6VMVacdGIIkeNftFUH9iNuIRczTVQBgzpiXn1wF9/wbU4XgbuibwoMSXJX6eexk6hbwfjS+sLuW7hmY3q6+S2FuTk/acB5onwFHz5NEIb8EirzEAdRBZgNmhxxdbiiAN8cKqmmR9xC6rLVxs8ZWhoSMR2gFWzEkhc/OxCt02muzoq6Xtm/m1XvrpnIkfGLuzH6xZEmmWgmPl8yC0GGFyRwgeiff+M3fjhsgHIiNPnHnllzZtECIyzxzORFt/3QFlzyAcu+2DIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nm489R+K37KVUue95aysabA+f4VovNB2NmrdTu0CS+U=;
 b=mPrvPouWRCRqtTQ/H/0maUCKH1cSyDmdKbnhP3qIBhCdFYSt/eHjuuVp18B94yw5OgONaqprBYWk2AZZY5VPRSAnmdIsDjcUNIdsmk0pKbZMQDoFmPdsucm4j82jE4K1LWurfkObqk1tU/H2y9knME413mhGheqHmyIkBg7rX6A=
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20; Wed, 1 Mar
 2023 12:31:43 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 12:31:42 +0000
From:   "J.D. Yue" <jindong.yue@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: RE: Re: [PATCH v2 1/7] soc: imx: imx8mp-blk-ctrl: Use
 dev_pm_domain_attach_by_name
Thread-Topic: Re: [PATCH v2 1/7] soc: imx: imx8mp-blk-ctrl: Use
 dev_pm_domain_attach_by_name
Thread-Index: AQHZTDnHyebNUArZAUOYHrMHVoGHdw==
Date:   Wed, 1 Mar 2023 12:31:42 +0000
Message-ID: <GV1PR04MB91834769F5276CED6D0F9623FBAD9@GV1PR04MB9183.eurprd04.prod.outlook.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
 <20230301030042.2357706-2-jindong.yue@nxp.com>
 <20230301093102.f76wulx4mo7435qz@pengutronix.de>
In-Reply-To: <20230301093102.f76wulx4mo7435qz@pengutronix.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB9183:EE_|DB9PR04MB8233:EE_
x-ms-office365-filtering-correlation-id: bd43c7dd-8a88-44b1-2101-08db1a50e9f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /3AXHqimp6dlzeW4Q0hU85FtGS0d5huJofRS4KFbFdzGyJ9m7Byrfq7UEonlQQvBf8IfgmbdbuVaTQ6JrzhMcbyKIxMOf5BHJfFPPpx7jSOsEWl4mY/kIL/eCiEOa2lUbbtW3AshsirkGsSoMpjROqYLWxtxZjmN2G+myWLLFgbXKkEDrxsCOhuSsn8bHYcBJOKlb9BdlzbifmzrMwtrOE16x6LebE8Ym8lPb9FTz6ASsVAvJmoowHtxchCN7IFSv3oe1KSEZ25gLdx19zA5lG2LE/IeREiEvLiOAgseix2/oFp3vlPvpM5nKZZxHSLZ40tnUObtC49q/6wstKsZdzw1Ni41wceVgHawy7ydfrBf7fHc4GzdsCirtPIJWfNQN3sRw8je5OD8mdHiXv2rH1hWeW4RGKEgEnYS/399wFzzedb/pHUGkSf4kAee+mktrlRCcxKhqjnaEJvlqBeuJTxDcu5EGqjU04IN0IctCmvOH2avQ7BFcYSx+WMe8LxYyGz5AnKYmbNVdoK0A3im7pbmV/2nu+XNLA1IOBiRr/idd0v895Oqg0Mzh+xfgdY8TaSxl3R7S+mz1yAnvT6MA6wgMKrlhcIhZ79CGKnl9EHdlYa5SDBY7Z0QHLijPuofCurWR9LzVw0bYnV5PuCguuMMa7TUDHzEoWu5qKUaZnyp6ltYVQuwRydeuB24WM9gzW0+otRleSD0Oz9cBmni8wGGjC0Pz0CGoCX2PCgrtPU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199018)(2906002)(52536014)(66446008)(186003)(76116006)(41300700001)(55016003)(5660300002)(6916009)(66946007)(8936002)(66476007)(4326008)(33656002)(53546011)(7696005)(6506007)(86362001)(26005)(478600001)(64756008)(316002)(38100700002)(9686003)(71200400001)(83380400001)(54906003)(8676002)(66556008)(122000001)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+xcbB28MLFAxsgo9nd9FhxqpI8C9iYSzkksZjMkZWLedu0NsfdjQIYQJfUkp?=
 =?us-ascii?Q?FFaKg/i5/vWdkeTXTL5iSHo7U4Q+Omv2BwUNp0zamaGOOrMemm5JeCXx25zq?=
 =?us-ascii?Q?CwxeV8hhbxBa6oKG4FB7erRNKH36LwoJ6nLSGnFi/YdAux0v2W94ABMKSr0t?=
 =?us-ascii?Q?eQ9DgpSwGPFPaIS2VV91gUA+8n7vN4cwB4kL3SITurkHyJLIGAlXz+frwag6?=
 =?us-ascii?Q?V0mAN/oZ0sdWcPJIq9mXFhJ8Jvc+qqr23rLZpBSk7tCCQ11N6Q+7xVcMdKt2?=
 =?us-ascii?Q?fqZ9zeJJYDYNkIYHpFctsO5e9aA8ud1ukpklcxmGiy4lNSSYeMNCvYex4evc?=
 =?us-ascii?Q?7AR5keP8O36/oiM5Yxkqc/KRJuQNKX9tDjFjMqenX2c2fFs+NqWUUyXb9Fey?=
 =?us-ascii?Q?DkXZS/sMgftytOtfBTESEVJ9ythDpAC8fZE1qu/q9hWbVeO6GaeY0bcc8NAj?=
 =?us-ascii?Q?Yzz1R8mv3BcWg4XRuP/vyJ2hdeihFfqlA9akcW4hJ+sIZ9PqDUfZOwiQdQ1P?=
 =?us-ascii?Q?1QEVvAAYl8y7HDf6Bz42kpfntMcxAgsQ/h7SUCpkfUtV0vegvgRMhk/RjkZF?=
 =?us-ascii?Q?FK7hHgIC3yQjpZL/5EnyEjwF1jKJ7haroFtBG+MKATh6VxMX7xMwmwrukkYn?=
 =?us-ascii?Q?Zrf83itvx8zi0biDAyRNfHu/MLco4mdfa6Mw4Fa7Ky5eTmY+xaPYD387/zxE?=
 =?us-ascii?Q?fA88JTJwh3BR/nXGm8XB25WKxCV4vtfbUj9CwWJHT0qZuS0hhk6gmF5vjOjX?=
 =?us-ascii?Q?Ez2TdbiOhi6xm0P3TqOzSLKSSgpTM3KJcy9hWzB1b4xoac0Uh1t5ztNlMFqR?=
 =?us-ascii?Q?p501CQbQ/eUlM8FOW6XeqwdcYwdEhK2Nvceb7xijGlHcVhOrKF/QaUvv+Cu8?=
 =?us-ascii?Q?6B0S44EB00sgJXZn3Z2e+64pCCwwxHv9aObeFVDDbWl5aywU6o6wP3slR3A/?=
 =?us-ascii?Q?Z3WCQG1eJFsmAb1aXfWzaQMBFHLtg8Vb4RwaIe0fxMvp4RlMPmSO3KYsqIZX?=
 =?us-ascii?Q?1Ebw46tOyhMmPxN82bRj08WKC40dE3lv/SXenTeEmvxwIH6x6LVXqQnKrfmO?=
 =?us-ascii?Q?iKqonaCbjDzOFNGb0wXx/4hrX8kLHVokkWjkFQ8uRl7P347/TwYhvtu4Ne8q?=
 =?us-ascii?Q?jWvA/Sstrp7mUXBr3VoAtgzo4fd3PYgeplJVIAiBW+chC1NeqHnKTORMpjQR?=
 =?us-ascii?Q?WYulNR/5Ul84cck6CM628HNjZfPIKxPuj4A/LbqdfSVjpWrtHSWpHhzlQ9W9?=
 =?us-ascii?Q?iLlyVGdMprKArqoTWJpwBz+dfbvrSxIOJ7o+jcuAiNJWOebpl1JL25YGC6v6?=
 =?us-ascii?Q?IdXVXxn+QRyOQ0A89Sp6L//NkbLu8lmH/WR/Ni2b8/pp06/2FM7UOCfHWraj?=
 =?us-ascii?Q?t9WpE0CPjGrGL9l8oPCNjPR0bcgH4oguTiMvyHjmwvFXsH6uHkyST7T7tdA+?=
 =?us-ascii?Q?TMw7snyAOEwd76mrG0s6QnKOo3mms7T6PPvRAnn+pN6vp0pLek0yx9YgQ6nG?=
 =?us-ascii?Q?bQDix+RlkQ3C6emmOkaDiC/BT0NjN0EvyDSkfgEd0oyNwcXu2JYkc/sXSnp/?=
 =?us-ascii?Q?D/q2O+FzzKiYbsBk2M4/qG+VuiYuQ5tpp4VgDQM/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd43c7dd-8a88-44b1-2101-08db1a50e9f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 12:31:42.7500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92ePRgy/GZkOOC6xPsQ9oCTkhGrjfOcqy2MZgNKwPaxE0JvcUY6oE+FnNpVgNS4swkN4dgqX0YCNOkJAgx7QDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Marco Felsch <m.felsch@pengutronix.de>
> Sent: Wednesday, March 1, 2023 5:31 PM
> To: J.D. Yue <jindong.yue@nxp.com>
> Cc: shawnguo@kernel.org; s.hauer@pengutronix.de; Peng Fan
> <peng.fan@nxp.com>; gregkh@linuxfoundation.org;
> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> kernel@pengutronix.de; festevam@gmail.com; l.stach@pengutronix.de
> Subject: [EXT] Re: [PATCH v2 1/7] soc: imx: imx8mp-blk-ctrl: Use
> dev_pm_domain_attach_by_name
>=20
>=20
> Hi,
>=20
> thanks for the patch.
>=20
> On 23-03-01, Jindong Yue wrote:
> > The genpd_dev_pm_attach_by_name() is not exported, it should not be
> > used by consumer driver.
> > Use dev_pm_domain_attach_by_name() instead.
>=20
> I'm not sure if this is the correct reason. If it wouldn't be allowed to =
be used by
> consumers it would/should be private. Instead you should mention here tha=
t
> you need the symbol for possible module builds. Same applies to the other
> patches.
>=20

You are correct, I ran into symbol undefined errors when building this driv=
er as a module.
I will update the commit message in v3 as you suggested. Thank you very muc=
h.

> Regards,
>   Marco
>=20
> >
> > Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
> > ---
> >  drivers/soc/imx/imx8mp-blk-ctrl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c
> > b/drivers/soc/imx/imx8mp-blk-ctrl.c
> > index a0592db8fa86..1892c2c78831 100644
> > --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
> > +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
> > @@ -642,7 +642,7 @@ static int imx8mp_blk_ctrl_probe(struct
> platform_device *pdev)
> >       if (!bc->onecell_data.domains)
> >               return -ENOMEM;
> >
> > -     bc->bus_power_dev =3D genpd_dev_pm_attach_by_name(dev, "bus");
> > +     bc->bus_power_dev =3D dev_pm_domain_attach_by_name(dev, "bus");
> >       if (IS_ERR(bc->bus_power_dev))
> >               return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
> >                                    "failed to attach bus power
> > domain\n");
> > --
> > 2.36.0
> >
> >
> >
