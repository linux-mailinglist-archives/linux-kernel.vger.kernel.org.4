Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786616F29D3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 19:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjD3RLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 13:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD3RLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 13:11:39 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2067.outbound.protection.outlook.com [40.107.247.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C70172B;
        Sun, 30 Apr 2023 10:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBnf3o1RRho6yHY0blbsMRfra+Xmoh3pJxlotpdSQOopg46RI8l1yVC3iK73Vhzv3EWaMmRoIS7alKyjsZYcqRCgIV1qp9g7Llrw24z+qEIVF/gjbpHx+bOWKHbviCKqd2S1Jxg7C/QOW8lLU6Y39F2RIXSStzJG0AbvM94S1IjuHdBigYK1bpsG85aTnXre4AA9+sLglo1IHmiDKngD9pB7Vq9isJN+ZNl0/in94wCHwpiiSPyFXsGMsyLO2YRsFhbnK2tF2JmIvr5nACqDldkEs+DYPhNt0CuS5i11e9yRr3z/f36FjMlkAyXlkK9PRxVoUIyeQvunyRr3V/QSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUHt9DFzwBnioXtwGUII6KoWBXDLRKEOj3Mh2OHRMDw=;
 b=Z2CcpdyPdB76soNQDwuFO3vAro+/QJWfLPTDMzGtRHf+Qd0ss1TlF1k4WI0wQaZoBmE4YDqR9F3dnxpL0k0B7TEUXGJeuN5jwq/Rc/2FLKLSGNSvH/gXKumb0AeAoa8x9O7Fy9nhwLpTqpEeJvTCqNikdisfyD2y6nQRV0bDMXN9H0ypGQHZ0CgkOvOGDVTaY2S6jLwy8bXTZn4jLRlSJyCl1fQpm17E1Y1EuclyTvDNc9032DQymuRjRfQsioi+ZttQU44giYPDu+zen1IKxf+1+TWrcPXsMjiYDKJ0RkABC2RfIKQln8WNar6Lc5rAgtezcFw715wvF7PezlwYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUHt9DFzwBnioXtwGUII6KoWBXDLRKEOj3Mh2OHRMDw=;
 b=gZEFJXtzeaeWuwYhlvXUI0eaW0fH3ZupQYL3DVxmCRjl4iQDK1GURp61riJclD4+WxIg6pw1mXukEdL1/p/Y8GU2ZeCIHUI9riRiJFQtKrN2pABfsxWNkuV+MkETHmuUIDtLWpMC3Xai98JLMSeNvyvMj9IU86smwgsVD6wFPQ8=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAWPR04MB9887.eurprd04.prod.outlook.com (2603:10a6:102:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.26; Sun, 30 Apr
 2023 17:11:34 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed%4]) with mapi id 15.20.6340.027; Sun, 30 Apr 2023
 17:11:34 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Petr Machata <petrm@nvidia.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Parthiban Nallathambi <pn@denx.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH 1/1] iio: light: vcnl4035: fixed chip ID check
Thread-Topic: [EXT] Re: [PATCH 1/1] iio: light: vcnl4035: fixed chip ID check
Thread-Index: AQHZeU+TSQ4kFOM18Uy5VgMIUmSRZ69EHjEA///8dGA=
Date:   Sun, 30 Apr 2023 17:11:33 +0000
Message-ID: <AM6PR04MB48389B230A43D8D48E7321F488699@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230427213038.1375404-1-Frank.Li@nxp.com>
 <20230430182258.7dbdd39d@jic23-huawei>
In-Reply-To: <20230430182258.7dbdd39d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|PAWPR04MB9887:EE_
x-ms-office365-filtering-correlation-id: 6213d2a6-5a2b-4270-d5db-08db499df2ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x7Ld0uLqj+ikjxW5CxPDhpTpvvA2gf6Z2I9Hr8zjxUEyQq3Qbp+DwUm7PmVoLsBsUMxvjeK0n0686Za6hCkSbl7RNRbu0gJ3nAO2bO2HNTiYs0EZ7TfavcwfYHwoclS8rMpFhePlOzm6g5n0SDMpmKFJ77mOe/dL+o2Pp5/DGR8gRJPE6/nTHPT7UT+TBXdjEK/UYz0uzhKTF+lbawLBdIMid1Ny2kRIbZMPLGY+H4wloe6roovQLLwdE2rnZ9pHAb39uC2krtdFC+kPHT3YcrMkR66E+BeSMXovXKYcyHqdvkjNiaFNW6SIPl2pZEKxmxlF++A5lv/TV30ebuQGE/J8EF9djkyjh/NH3o7pncikAecAg/Hv/6IT7Fxm52elVLsAHaBzAHWF/DNcx3wEHZSbC2kkS41oYb3gtaKCAoFA1Yv3Ln7EvbUltnMJVtYD7FAG0CSVAiO79jeUWWCnAZ3Mj36HHfdd3Y8gGuxDYslSdKM1/8pQd/r2ADwHjFbewVVQUr1Xkd7QCY6plBt78GfanuFHNBT7Y6l0MU4VgW9K4E0UZffywBg6/sI4LG3FvYYDzDeoWx5/Fu5/r6qd64nkfP6xbqlDFFBIxop3QzdvHPxfMD02fSi0tnia48Nl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(52536014)(5660300002)(8936002)(8676002)(7416002)(44832011)(41300700001)(316002)(38070700005)(33656002)(86362001)(2906002)(38100700002)(122000001)(55016003)(186003)(478600001)(83380400001)(7696005)(71200400001)(66574015)(9686003)(53546011)(55236004)(26005)(6506007)(64756008)(4326008)(6916009)(54906003)(66946007)(66446008)(66476007)(66556008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kuwFHbHMS7htgYAGKKPUkiqPGJ5bVLDz01gylmgvBiJ9ksumJgnwJHvGeO?=
 =?iso-8859-1?Q?6mRLChQygzVBPMpjprgqf2QndwICwwkzFPXeFsI2/tRsEi2yDO2lt4o7cu?=
 =?iso-8859-1?Q?ZB04W6T/I2l1Ves2LQ4mwkLb0vd9v1v9P28Q7rwWiD3wfmSA0CYJNcvJ+a?=
 =?iso-8859-1?Q?8KEr7ekdxgzW70cRI80ovq4haAw92LVKgl5VUOydgNABkUCbss11DAq8hh?=
 =?iso-8859-1?Q?J1LlPIAg3WvZanTEocaXpNOuN5QLgAwMuUpXlEOnZL4NTzP7LckOG8A2dj?=
 =?iso-8859-1?Q?4XqeINk7GacykigpG/iBbIPhAiSXw8It+rQdIwh5zNCKN2BZskcP2FWgyU?=
 =?iso-8859-1?Q?zjY+i6bN7q0ncETe2ociw5M4cU5vV8t0fFFQjSmejZ9hU7Wg8IDsAS+txI?=
 =?iso-8859-1?Q?LaeGcu0zrhAo5r5lvb9uIgR3h6TFDAhdpWuWSWtfDFloKY5Jxtvmz49HzV?=
 =?iso-8859-1?Q?N7TrwaZaatXMGYzbOC1ZbcDd4uTOBTzeqE4yJPiPvExkAfV7DTcngqLKjw?=
 =?iso-8859-1?Q?gJc421veAadTN9jyiRuHrq6S2zNDCdu2EEU786Bf9/fcMm4wpYEYo06tv9?=
 =?iso-8859-1?Q?w7FkgZACZ6xsqzR0TCSt6rdGEAoLoOeqjR/u72D/pyKd/wv8IT2rjGK7kz?=
 =?iso-8859-1?Q?TNseolriR3LWJJvS9LDNVhStVpAZL7xxoQNkWHKQjrik28X5xlfSmI0/p8?=
 =?iso-8859-1?Q?4G/Vj9pzb15nI6jgom2YWMtajlcW3Wjm8MC/Q74II9pEgbFhMSdE5IBrL+?=
 =?iso-8859-1?Q?3YAoTvsyfwf/aWcxVuA6t9yNBPp7IyqV0SXjR+E7c8PpWT55NrwjmwRPq7?=
 =?iso-8859-1?Q?1wgWc6Ou52MkujRHimyTpF3+RUe8aHoiaNZ5o0gCIClZjXF3jbwAQloSZp?=
 =?iso-8859-1?Q?n9nFx+/iYUZpamw8vG9IubPUo9zfJHjYghSAZUEjBaTWN0tEh++9KXiQJD?=
 =?iso-8859-1?Q?bm6ZY1JuQOV3/ZVZEu3qBWEDRYb6ZgR2M56NaBK331qrgQrcidVNxh0Vhz?=
 =?iso-8859-1?Q?GRPKF3ylT5q11KkXsSu4IHoGV8AhQGJ6Fgt/yUKGFmcjHOilK0/JT5/gbK?=
 =?iso-8859-1?Q?atQdEBwz9vQcdwkiONIvvrIgx/wWg4Nnqn3sra6B8yos9SFu5//WC6oPDd?=
 =?iso-8859-1?Q?++swW379LrOlcKnTDCEnfPU4nHJ5HLUs2EJttns6UxufsXYRbRP58UwnO9?=
 =?iso-8859-1?Q?QCNWfMcVPQr6P2HdahyBPhAs6kuOL2sTMVeJ0L3/iI7ocEsqlnXr+Ql+Km?=
 =?iso-8859-1?Q?+pnmZ3wqwc5uRyIOK3L5Hdz3qs/NDd4w8GPV0p2u4Oi55YLrRJBQ1m+HfK?=
 =?iso-8859-1?Q?lIl9ar1ihGEBrFo94mT9lVdvRXFoqh71dZFtHy0GCyruhF/Ql8trDZUXMx?=
 =?iso-8859-1?Q?0KuJHtk5FJHjNKGhjrzl1ccoQLMmSdH7wHpI4WhoWSMXkUK1vTtP/nnaEJ?=
 =?iso-8859-1?Q?BPZ5pNVY9vNXX4t9Zs+YTr7sK0SFrRO3v7N9a3j02i78nFRTvoGsNQfPvU?=
 =?iso-8859-1?Q?hmmlvoK2rElY7WVh+LRvXE8juvihpdx3XDyoRtJ2iOPCwOJ3yEiRQmBI3v?=
 =?iso-8859-1?Q?ks2w/Gwesj8PwVPxwN4zX1rRBNDm8zAWmwVetvdXhgVKE4vu1A27MHNtYy?=
 =?iso-8859-1?Q?EbHgzRNPza7k8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6213d2a6-5a2b-4270-d5db-08db499df2ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2023 17:11:33.7198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+L0q4XVrJQ3Gl8Zwidx9zbPuVyxFWn2oaTxUZghfnbpAM/IlQe3OAv/RmTaSUiWPf2m6A4tizSza9xKOTP5cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9887
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
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, April 30, 2023 12:23 PM
> To: Frank Li <frank.li@nxp.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>; Petr Machata <petrm@nvidia.com>; Heikki
> Krogerus <heikki.krogerus@linux.intel.com>; Jean Delvare
> <jdelvare@suse.de>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Parthiban Nallathambi
> <pn@denx.de>; open list:IIO SUBSYSTEM AND DRIVERS <linux-
> iio@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>;
> imx@lists.linux.dev
> Subject: [EXT] Re: [PATCH 1/1] iio: light: vcnl4035: fixed chip ID check
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Thu, 27 Apr 2023 17:30:37 -0400
> Frank Li <Frank.Li@nxp.com> wrote:
>=20
> > VCNL4035 register(0xE) ID_L and ID_M define as:
> >
> >  ID_L: 0x80
> >  ID_H: 7:6 (0:0)
> >        5:4 (0:0) slave address =3D 0x60 (7-bit)
> >            (0:1) slave address =3D 0x51 (7-bit)
> >            (1:0) slave address =3D 0x40 (7-bit)
> >            (1:0) slave address =3D 0x41 (7-bit)
> >        3:0 Version code default       (0:0:0:0)
> >
> > So just check ID_L.
>=20
> Hi Frank,
>=20
> Thanks for the fix. A few minor things inline.
>=20
> >
> > Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
> >
>=20
> No blank line here as the Fixes tag is part of the main tag block.
>=20
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>=20
> Just to check, the result of this bug is that the driver probe fails
> if the slave address isn't 0x60?

Yes, I get chip which slave address =3D 0x51.=20
I will update patch soon.

>=20
> > ---
> >  drivers/iio/light/vcnl4035.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.=
c
> > index 3ed37f6057fb..8b7769930f3b 100644
> > --- a/drivers/iio/light/vcnl4035.c
> > +++ b/drivers/iio/light/vcnl4035.c
> > @@ -413,7 +413,7 @@ static int vcnl4035_init(struct vcnl4035_data *data=
)
> >               return ret;
> >       }
> >
> > -     if (id !=3D VCNL4035_DEV_ID_VAL) {
> > +     if ((id & 0xff) !=3D VCNL4035_DEV_ID_VAL) {
>=20
> Please add a define for that 0xff mask and perhaps also use
> FIELD_GET() to extract the field for comparison with VCNL4035_DEV_ID_VAL.
> Whilst that isn't being done elsewhere in this driver, the heavy use
> of set bits means it isn't appropriate anywhere else that I can quickly
> identify. You'll also need to include linux/bitfield.h if making that cha=
nge.
>=20
> Thanks,
>=20
> Jonathan
>=20
> >               dev_err(&data->client->dev, "Wrong id, got %x, expected %=
x\n",
> >                       id, VCNL4035_DEV_ID_VAL);
> >               return -ENODEV;

