Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1975A728AC4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbjFHWAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFHWAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:00:20 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B1D272A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6iYfDG0G96jvo//mqQG3E8X0oIgoYtZzAOE4Z4PbgrIymP77JqkE3d+v5q5nsZH6Ne+V3Y9FIVWyFSi9dg4BbqZrVtGrod7RrS4bO/1lQsALV4X6U/mOFeQ4bT9eFr+VJHNvRt4nAGNZNEaSkNyziumtRoXE16frhv7QcWPClwCoz/RboDiJIgTB3s5azyY4XDAtISdrCpI/y92YfrPFB1I4S3EmcYnmdfvlFSuc9+iVTwQfDyNXiXk9mtEI1GQJKMrXhEt/5va1D0MM1yjIkuVHTeE6bvWpN4ek96M8YsQU7TvBhil8yy5XToW27WXyqIxFEPPmKiBI0rZ8AAxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN0jHxyOPad11nfjdZpLmUnZwCrZ0AE447gHNNpmrmA=;
 b=k+QSYUpcP+wGubtzZZgAUxIojv+4iBNLP3tLnFL5ho9wZAP1B5Ljs/qa6aGVK8783ax7Th5O7GD4ZQMQFZXgFOkKGfhbmosDpiF8LFx6I8dQpMfNRmiF1mCZy0sD+EU3BgsyZsRUuRT5Hwil4MzAz+MI+yPAfJsDJVrXPmmq4XB6yXZWLBj4e9FVebZtg7iG7r/LwflAi/xg2vg/rRG4YL3qV2IGYj7lxpNN79gbHWqsVYiyj25FTd4RwVc2Kkw3boXOAg2BSStYQkftA70VkUhC2qOfgL0ypZeOkXwbE7v1MMeOdCWk5Qc2ghbO4qehwCSnEKgqGCVgU8NPXcOyQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN0jHxyOPad11nfjdZpLmUnZwCrZ0AE447gHNNpmrmA=;
 b=aM8PTHzWGivQ1ljI6xup2X2TA6pLAAXTXMX4CIMfUxAMeob5ZurRQ+k4EY/86juxBG/y9NGihj1rrTY9AISmLqDN3lDw8cV3KLHm8XoZqZpFVddajKJovnWVnIbBOHfqCACQg5jdyXyKyl3Kp5kYA1dV6aS0E80b7j7Td1+h4i4=
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com (2603:10a6:208:145::23)
 by AS5PR04MB9853.eurprd04.prod.outlook.com (2603:10a6:20b:672::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 22:00:14 +0000
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::7aac:2f58:b7e3:2c24]) by AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::7aac:2f58:b7e3:2c24%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 22:00:14 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nathan Chancellor <nathan@kernel.org>
CC:     Stuart Yoder <stuyoder@gmail.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH 4/6] bus: fsl-mc: fsl-mc-allocator: Improve error
 reporting
Thread-Topic: [PATCH 4/6] bus: fsl-mc: fsl-mc-allocator: Improve error
 reporting
Thread-Index: AQHZlJ98Oz9RTwIAQkWKphRxSM1C9a92K6+AgAtT7NA=
Date:   Thu, 8 Jun 2023 22:00:13 +0000
Message-ID: <AM0PR04MB6289C7212F52C7A9DA4951D38F50A@AM0PR04MB6289.eurprd04.prod.outlook.com>
References: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
 <20230310224128.2638078-5-u.kleine-koenig@pengutronix.de>
 <20230601154101.GA2368233@dev-arch.thelio-3990X>
 <20230601165945.f7itlyso4rbp2nbb@pengutronix.de>
In-Reply-To: <20230601165945.f7itlyso4rbp2nbb@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6289:EE_|AS5PR04MB9853:EE_
x-ms-office365-filtering-correlation-id: 3dc85c8c-218a-4244-4c07-08db686bbcbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WH81Q5Otv7HPkkOv5wDhjH7sYsIarVtgLszgT+GAycyM0VD1GW4jAvHUQawyiSdT90XVAPK6JeH9gj2eU1s11T98au91ymxHnqn6SFwwBlvWwYifl5dZecfxm4z7VC+LoYFCzWsteEz8RSPupbOHIyEC/4TABeCGG/MvoABqZ+FUIf+OWRECO3XS+sv7IO94hvukIBiooK967R2IFZdDJv6ebpQKiWFIwU/5Miiu5d9tmRWHzcAvmfAYH4pp6kkBhLPVqJy2zzTX6Ogcl+fHekl/HCZbOBozXbDZHhiVH+M97y71ZcHQcd0vunaOczKFMwUp2XAgkbEr0TOr79botiG37n95zLwXaLsUvBYD/Q+CTDLtRmGrf8si99j5vyvbCP3axsBiYn0Fh6ko2/EZBtDwX5Zmuq865PtLrnLUhdSjnZppDhQBU9enevGQJI7Ef8KmOeIXsEYDBI78TLXkcolCk18L5K29Tp3jvqUYae6Hn6wTn0r5ZFEnMyGnL0VPnqo8ieIeU2Cw89icLxFECZ/+TErS8t+10ORGO0fCUqknIy2kkctx97vA9NUQT6pKnLyRvfkggMuUaP3IXiZj8pMzubVyuz1oOL+0x0CwRpCvGdGfXTOh2O9n6momaJ2y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6289.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(86362001)(2906002)(38070700005)(33656002)(52536014)(5660300002)(66476007)(55016003)(7696005)(53546011)(66574015)(6506007)(9686003)(55236004)(186003)(26005)(83380400001)(54906003)(71200400001)(110136005)(76116006)(66556008)(38100700002)(4326008)(66946007)(122000001)(316002)(64756008)(66446008)(8676002)(478600001)(41300700001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QHeNscDZdvT0ItVAAPjInChTw6RJb5rmeBB/290YgcnWfBGIFgAGKR0eJA?=
 =?iso-8859-1?Q?tgF390i2fBO8BBDol38JiJVsgkfDs71ybxoadd5XsFBzBRc4cSHo/Z6hIO?=
 =?iso-8859-1?Q?5XMRPUez25+3I0eHzdM1ZVXaMQJH1TUFVX8hu6f+bzEkaEoelb0iHA701h?=
 =?iso-8859-1?Q?vdFc0sIuUJP3eqJdz8VaGqA4oUKlm+gqTXekgxspvtSCaQAZuJvPJidfUB?=
 =?iso-8859-1?Q?UjZivzc6h4dmkQ5AMcUWSeEt2+wgjUjeLLl6VY5ONlmPD/x4ilPhbKwgs/?=
 =?iso-8859-1?Q?065JflUDV+1w+mQYEUrJwd2Xrxaj6/npeQzB1BlAtdf1BYTSe4fBkQbazo?=
 =?iso-8859-1?Q?uEBSVett2T6rNoVB7TOZDzX3OOLvlTvva7tnmRsWrntInVtJb/sWi04uL+?=
 =?iso-8859-1?Q?kO0HNfyqlr8nXuKBf6a8aYzEalP4/RZ/VnXZAWkMDvX9tSgCIHnK86zsE5?=
 =?iso-8859-1?Q?3vcIIiadb0UcEFAEGsunho2WAQhVdXBxl17Fq02TR1ImO9SmzdlLLtnmgj?=
 =?iso-8859-1?Q?t5LrHctq5OwJMybqQdgOSriNdTIm4gyzBJ/rvkqqkrEvV6oVzOlbwnUbWZ?=
 =?iso-8859-1?Q?eu78fti3JvHlaFKzJjUWM68AbEm3OOlW4DUWYKvRCKcQP35vODYFSLU+AS?=
 =?iso-8859-1?Q?yOh27sZ0YRSNBsO5YX0zX6CUBzIrUjkvq234g598FCV9ckXCh9XLCXF8fv?=
 =?iso-8859-1?Q?BConiGWC3vGl84PvUuSkhuUUvdbGBvm8jgh696Kk/DGmencuJNhwbW4oJj?=
 =?iso-8859-1?Q?6Zkq34axCLsLKX8p2xbCbUtE+rtLT1ft/SibGP/lXKQ5Sx9qAUmdS3BBrL?=
 =?iso-8859-1?Q?OaVqXZfZrmXzCl2KCpe7Ckn9yq5EvFVICGi/AqwoHl7uDK9yfhjB11a9tQ?=
 =?iso-8859-1?Q?qhpRSLUsnzapA3JLZWOiBO4OpetH0kQtPWoH2atiUdlrSYzC24iW1k40kj?=
 =?iso-8859-1?Q?t2dkvigEMREBiUHPHDH/HD2Fz1++Yei1zHZ2tiKNRFbZyl1vl9PgtBz3S6?=
 =?iso-8859-1?Q?mqnXXmfGTkQa8hOAKW3BVwZiK+W3wlp0IIxiBj1g8ZZ5GCcLjfQ71CEaTn?=
 =?iso-8859-1?Q?b2xUpsP4UdD9oWbGMzR1PWzBQB/DJJ/q16aPWDHgXeOot6UJty0m5VvanR?=
 =?iso-8859-1?Q?0k6YBCV/wKjuBwqnKqI1G/rY2Bt7E3X2Lsu1QEb4dDQetacr/fRN5IpR/j?=
 =?iso-8859-1?Q?MJuemYeRNBBrbmd3dZT12xT4W0kvFKna/yJ2OoeETks8u+0Amw/xASYNhI?=
 =?iso-8859-1?Q?Led4Jfmn0Z8kKWRSPIyjI3n3CPUJK+/xI5e68UkPQrYFfvo9zqHwlTh9Xc?=
 =?iso-8859-1?Q?5RzsehpPvBfPU4xV3NNMMmQ5NX5x1GibcDgDcRyqpc5WAvGMntciYtHhlH?=
 =?iso-8859-1?Q?QG+hT9Cg2WRAEQ7TnWc0oTWOx2k71AKKvjm1il3PkVmlHmB/zKAzWwNRTo?=
 =?iso-8859-1?Q?JlACgfci9YVb11w75HWp//YME4Zh1OQcMxOuGockka4DOeBT/XdVuvKug5?=
 =?iso-8859-1?Q?r27Q/6IThL46QzCEtnDD2oN6xjiO1OmBewq0OFGkqoHuguEQbVJVuyy+2D?=
 =?iso-8859-1?Q?WrVDbGLdGJF+1QNianYZ7P33YyywVe2GN2DXdbRvcOtCAe2LW5ALqqmLLg?=
 =?iso-8859-1?Q?Nqtgb9qqw74wE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6289.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc85c8c-218a-4244-4c07-08db686bbcbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 22:00:13.9955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfyl/MTxuZpLA1xawS0jrAUdyNbbwKupIvuu+GiA5Cz+XBheNFE85Yy65ODc2C0q5HZwhhRYOT8Y/FMob+sEvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9853
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Thursday, June 1, 2023 12:00 PM
> To: Nathan Chancellor <nathan@kernel.org>; Leo Li <leoyang.li@nxp.com>
> Cc: Stuart Yoder <stuyoder@gmail.com>; llvm@lists.linux.dev; linux-
> kernel@vger.kernel.org; kernel@pengutronix.de; Laurentiu Tudor
> <laurentiu.tudor@nxp.com>
> Subject: Re: [PATCH 4/6] bus: fsl-mc: fsl-mc-allocator: Improve error
> reporting
>=20
> Hello,
>=20
> On Thu, Jun 01, 2023 at 08:41:01AM -0700, Nathan Chancellor wrote:
> > On Fri, Mar 10, 2023 at 11:41:26PM +0100, Uwe Kleine-K=F6nig wrote:
> > > Instead of silently returning an error in the remove callback (which
> > > yields a generic and little informing error message), annotate each
> > > error path of
> > > fsl_mc_resource_pool_remove_device() with an error message and
> > > return zero in the remove callback to suppress the error message.
> > >
> > > Note that changing the return value has no other effect than
> > > suppressing the error message by the fsl_mc bus driver.
> > >
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >
> > I apologize if this has already been reported or fixed somewhere, I
> > did a search of lore.kernel.org and did not find anything. This change
> > as commit b3134039c5b3 ("bus: fsl-mc: fsl-mc-allocator: Improve error
> > reporting") causes the following warning/error with clang:
> >
> >   drivers/bus/fsl-mc/fsl-mc-allocator.c:108:12: error: variable 'mc_bus=
_dev'
> is uninitialized when used here [-Werror,-Wuninitialized]
> >     108 |                 dev_err(&mc_bus_dev->dev, "resource mismatch\=
n");
> >         |                          ^~~~~~~~~~
> >   include/linux/dev_printk.h:144:44: note: expanded from macro 'dev_err=
'
> >     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev,
> dev_fmt(fmt), ##__VA_ARGS__)
> >         |                                                   ^~~
> >   include/linux/dev_printk.h:110:11: note: expanded from macro
> 'dev_printk_index_wrap'
> >     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);            =
           \
> >         |                         ^~~
> >   drivers/bus/fsl-mc/fsl-mc-allocator.c:100:34: note: initialize the va=
riable
> 'mc_bus_dev' to silence this warning
> >     100 |         struct fsl_mc_device *mc_bus_dev;
> >         |                                         ^
> >         |                                          =3D NULL
> >   1 error generated.
> >
> > Should this be using mc_dev->dev or is there a different fix?
> >
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > index 0ad68099684e..867ac3bbeae6 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > @@ -105,7 +105,7 @@ static int __must_check
> > fsl_mc_resource_pool_remove_device(struct fsl_mc_device
> >
> >  	resource =3D mc_dev->resource;
> >  	if (!resource || resource->data !=3D mc_dev) {
> > -		dev_err(&mc_bus_dev->dev, "resource mismatch\n");
> > +		dev_err(&mc_dev->dev, "resource mismatch\n");
> >  		goto out;
> >  	}
>=20
> Hmm, clang seems to be right, and I just confirmed that gcc (arm-linux-
> gnueabihf-gcc (Debian 12.2.0-14) 12.2.0) doesn't emit a warning. :-\
>=20
> My approach would be:
>=20
> diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/f=
sl-mc-
> allocator.c
> index 0ad68099684e..991273f956ce 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> @@ -103,14 +103,15 @@ static int __must_check
> fsl_mc_resource_pool_remove_device(struct fsl_mc_device
>  	struct fsl_mc_resource *resource;
>  	int error =3D -EINVAL;
>=20
> +	mc_bus_dev =3D to_fsl_mc_device(mc_dev->dev.parent);
> +	mc_bus =3D to_fsl_mc_bus(mc_bus_dev);
> +
>  	resource =3D mc_dev->resource;
>  	if (!resource || resource->data !=3D mc_dev) {
>  		dev_err(&mc_bus_dev->dev, "resource mismatch\n");
>  		goto out;
>  	}
>=20
> -	mc_bus_dev =3D to_fsl_mc_device(mc_dev->dev.parent);
> -	mc_bus =3D to_fsl_mc_bus(mc_bus_dev);
>  	res_pool =3D resource->parent_pool;
>  	if (res_pool !=3D &mc_bus->resource_pools[resource->type]) {
>  		dev_err(&mc_bus_dev->dev, "pool mismatch\n");
>=20
>=20
> Should I prepare a proper patch, or is it possible to squash this change =
into
> b3134039c5b3cf879841e3ec84c8cbf7675554ec?
>=20
> @Li Yang: Please advice.

This looks fine.  Please send a new patch and I can squash it to the origin=
al commit.

Regards,
Leo
