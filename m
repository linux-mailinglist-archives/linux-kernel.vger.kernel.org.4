Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A126DFAAB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjDLP6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjDLP6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:58:46 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324CE40FB;
        Wed, 12 Apr 2023 08:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxkmFiwgm2AeaAUqqgCvFrEcZzt/c8h/IQjCq8OTF4D/t5wAovOwWTxyTr/GNjNRFjKb2aVYaZlYm38tAmA39jcnVZ7Gz+kCJfK7khyx6rnyt0lWqs9Mz+WhZ8XRbU5aiuOTwo/SLQhpvF83c8eH1UIGvxjojQv3zhf3XiyaNNCSZP3mEO2Yvr3EKzX9ccxaWfS0lgybekw07oE7NW/hfWHGagk8CEHQc1v+ZVfrsXntgvZPrCroUoYkIcVcsnXkCpz4XCIVAdhmQfsP+kkLFMhlZ+A84gpbnqSAmfb5pLf6xK32cB1WgyIczi4GAelqsuNrRx1GX750LqWHzu8NZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r15SnCdbjuHf7SajauLwhK2wfi+V+kCAwdFWO7zsK7Y=;
 b=AhkaH9l3DT/TDJb7s6wUJHEU5F2Og2RxMom52EhUj2aJNExvbR5QvW3fhBLG132ATr4ptJjdaQVduYcN8FhbPTq8O9UDq9eeGpC2oWgL+n4IURxPn2EDNQYz6GD5LFk0YP5b+RF5AFGF3CBdXOBwYeuuEHptkQXrrDiSF8xush9bMzKSPhByjiGGTh7NtGYMR15V1jSs7mADLvvlGjbQeeAWbmLfYTLZAFA6vzixtSHWCHVZ+PAg+YbtyL2AVsZjBipmHawp9BX3l9MOMZMsIHghG2TTadwATR2mqXujKK+yT5szSqJcRJsRz0FINxPoIIuHIfV6kbE/vsOWeNTerw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r15SnCdbjuHf7SajauLwhK2wfi+V+kCAwdFWO7zsK7Y=;
 b=opl5En64wFWXQJJwh+mucEe3Ha1VQxTxRtzDNt1b8aisjymsiILtoTBjeza7BGBAyQ8Tnp9ln+J8jhi90VSW7bRYVjJaHvdjBiYlKc/JlY+wIaJw9XkAmmY7CsLdhKpnbM9ebGQVMPVcwnVDpJMYwAFQumY3vps+Xvxb0b6JawU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7714.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 15:58:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 15:58:40 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] input: imx_sc_key: add wakeup support
Thread-Topic: [PATCH 2/2] input: imx_sc_key: add wakeup support
Thread-Index: AQHZXWmUVLJFWxBDC068h5KGnJZKqa8j7hEAgAPIhwCAAD2TgA==
Date:   Wed, 12 Apr 2023 15:58:40 +0000
Message-ID: <DU0PR04MB9417185EB8243ED2D60A6E43889B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230323093141.4070840-1-peng.fan@oss.nxp.com>
 <20230323093141.4070840-2-peng.fan@oss.nxp.com> <ZDN00vwyCOzFrDYt@google.com>
 <DU0PR04MB94172C2BBB554E472576B2BA889B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94172C2BBB554E472576B2BA889B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB7714:EE_
x-ms-office365-filtering-correlation-id: 2ee2187d-7a98-4a2a-311e-08db3b6ec8e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xtFm2hxITvQijiKinqHHXDwTOW+AUvLEizKxwdV3sIDRdJ/FabroLXFO/h3iIrd+XU0WHnrCgRMRwpKeL+fDQDYivke5Km3AgfglQ374fZqqJjkVhefHbUMu7pvRJvbBXAPn7YVRxS43GdVEuyMkDf0nKbwDEEU6nWLQC0gjG5BirS94eCNjToFOpFmMC2ADIC+cPMiwOW/Rx3iCiHVKmXhoNXXSLkjkH0j3emPFFIEQ0iXFAg3h7n4X1O0eZcOUnXznytsmx9WseipHq0Q9qzyvREf8adtIEdnDnH+q/pekrlGCGDnqpNtuMMHCBZSaHYTDcnVjhWCaRQPNrSX2wLtPtqYQHmwKFGns0XSvpp5eh92dcPiJWc/5Vav3prQ4YA3uliGzO3wyWkNd/M+1vawYmrXwPno9Ug8ufpPq6E+hJ4ObIqUX/dfK6k2gKzt8hAZsJ8agMOz7GGgkeYq9TROJ2kman6NeSxQwssyd3UIWb80gi/GasKcyiNqnlnQD77cFxXoWL8lNf8VFIAnlZ2rXfMtmUZvDPlYc3+HYvgDyKjPpJso/wz2Y2GnNYbwG+UM+av0/hQ2er2UpolALsKYoQ/tpGWNI6jYTfeyT3i04q5BtAsQvvOUuNGPIKH4u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(478600001)(41300700001)(86362001)(71200400001)(316002)(64756008)(76116006)(7696005)(8676002)(66556008)(4326008)(66946007)(110136005)(66476007)(54906003)(66446008)(52536014)(8936002)(38070700005)(7416002)(44832011)(5660300002)(186003)(2940100002)(33656002)(122000001)(38100700002)(9686003)(6506007)(83380400001)(2906002)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8ac5rjiRCO3/d+WnBFtnnKvP+Vr7JNpd3aTr67YQ8eWQUWdUyFx8bSvgpnp6?=
 =?us-ascii?Q?UzoQagIORzCJEyNVpsll0RXhsdOCmfbpV0XA2RS8yS+JxmnzRJPhG/t1tAnG?=
 =?us-ascii?Q?wXdqDyG4SeHf4YRNVUC5baCZQWCoGdJ7pJlk+ySviO6wAgV2JeUem18ZUSOX?=
 =?us-ascii?Q?2Js+w/uV/DOvoP98uXx6om6skHlLyNAXOxy0TasGUL4ZnLuMiuOj2LX6Y+KA?=
 =?us-ascii?Q?7t1d8J0/fNB9LJ+FUgb3uQLJd9dGZC9D3bBl9h7pm/GM2x6ZkQ838HLP6Cb3?=
 =?us-ascii?Q?Nn+W1NIXRn9Rhl7Ksgm5GODA5u2ftash3MSbRpXPPEMXLGIRMm9S3lDpoHHJ?=
 =?us-ascii?Q?9MHLzlTpjeC17kul3gchzRLdBvMNfwIV6l5swHI6MkdPmReLfk6JR3trSoFL?=
 =?us-ascii?Q?dAM7LxeZWTdXXUFiC70SQ3qdEhFevz8ht01y/6xshH3F4A6B6CCFcHxhvQAZ?=
 =?us-ascii?Q?OpB/c5LojqKj22GUlonup7LQJYNu9YUkso6ylmgOtZ9H5GLmS/h2Ub91gCaE?=
 =?us-ascii?Q?gZDL3c7dWdaYr2syi/jjrIzd2zQGs8oMrwjflhZSx7Np3tk7atCZbXb5Ip7o?=
 =?us-ascii?Q?kPoZJvgSSEgsH0tHsQEHvZW0ImVds8PGlKlAkT/9yTUaB+NYf9OO83uoGueo?=
 =?us-ascii?Q?8IamJgXeSo8WIbjAg6U/u6OO7iFNtgXrXgPde6MuziSqkjUzzVyHxEbns5Ee?=
 =?us-ascii?Q?nVP7pcgjnG/SRfOEZLeDOOkN6JE45VVPZ8TS8CweFOhNktMIJDJjeYi03gU4?=
 =?us-ascii?Q?b7PGdaNdo05JGhpsVjknQbijXCjfBFzrH/jvk5dv4rQyPgfYOAHxt5jGygoA?=
 =?us-ascii?Q?f2S/ib/SLWBsGqE0PQe/wmsMQyBCMGyT6WqXoHxLC9JFaBZCEf+j2b0uLBPr?=
 =?us-ascii?Q?owHlDgg9H0TFHWxhYSD28Fx3J8MTxeAQQM1q2MbCwZn+nvoIIj+7Ic+oADZe?=
 =?us-ascii?Q?QosN5BIy8WIqjSNDnyyO8OiqL1ogVf+aoreUv3uv/LdsJnqMoHOnokigI2/3?=
 =?us-ascii?Q?JJEfYct3qyQ0hPYJWukOHtoV/Q9Zjh4dVxdz5O5Xxl+OIjFtGXnEaSa3mtLV?=
 =?us-ascii?Q?RlkDcaoVyw0vjWUTtpzOsH6PnyTc1Zo7NYbHqoKotNHQOnJ6L9DRNkTxr8T/?=
 =?us-ascii?Q?GYK7yVVysJy0EOWS+kdRYbiHxgWqw53hLTlK2CEWkz5w11N9qNwe6UInVOLy?=
 =?us-ascii?Q?lIeps2kcLNK+TNXKyPWR5jCSjM1sPaw/m8d/DR+RXw5sujkl3spAxuyTeKCa?=
 =?us-ascii?Q?fpV+6LzfXOiBMTtTDj7DeX5gUDwX44lskwgtlRaAonL6gfJXlNv8N4COxhcf?=
 =?us-ascii?Q?9qpRX0bscsere2K+DT4Xky8FznDZYEuNJhipU5qhpoN2VZYftb96e1CItqAM?=
 =?us-ascii?Q?tm++HvUreGSuwpfSKvYtzAqBEn5dcq/HpJZiGbbUOwV0mzbyvhtPULFPGpuT?=
 =?us-ascii?Q?6J9pUAB3DCuTgeEAX3jEa3OUSCicHrYDTddKQzv53ao1r3wRhNSUOb8FhLPr?=
 =?us-ascii?Q?IYcfrXaEGMgkd0d4II7WkSwx/LFlU+S6/Hb7CSqCO2wJos8xaPL1AsF0NOcE?=
 =?us-ascii?Q?RPUExNXeW52TzLyMWO4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee2187d-7a98-4a2a-311e-08db3b6ec8e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 15:58:40.5496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iil3ZOX/QLDjc27eWsKxfBaAJ0L/qgk0ObIhMcvNaFrNgjiCgoo9OUFcSfT/80hlw3uZOiIMgQmnifdc/alfsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7714
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Ulf

> Subject: RE: [PATCH 2/2] input: imx_sc_key: add wakeup support
>=20
> > Subject: Re: [PATCH 2/2] input: imx_sc_key: add wakeup support
> >
> > On Thu, Mar 23, 2023 at 05:31:41PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add support for waking up from system wide suspend.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/input/keyboard/imx_sc_key.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/input/keyboard/imx_sc_key.c
> > b/drivers/input/keyboard/imx_sc_key.c
> > > index d18839f1f4f6..234f23cf9990 100644
> > > --- a/drivers/input/keyboard/imx_sc_key.c
> > > +++ b/drivers/input/keyboard/imx_sc_key.c
> > > @@ -151,6 +151,8 @@ static int imx_sc_key_probe(struct
> > platform_device *pdev)
> > >  	priv->input =3D input;
> > >  	platform_set_drvdata(pdev, priv);
> > >
> > > +	device_init_wakeup(&pdev->dev,
> > device_property_read_bool(&pdev->dev, "wakeup-source"));
> > > +
> >
> > I wonder - could we move this to the device core?
>=20
> I see lots device drivers parse wakeup-source, so I also follow That. Not=
 sure
> whether could move this feature to device core, but anyway I could give a
> try.

Do you think it is feasible to move device_init_wakeup into device core
part?

Thanks,
Peng.
>=20
> Thanks,
> Peng.
> >
> > >  	error =3D imx_scu_irq_group_enable(SC_IRQ_GROUP_WAKE,
> > SC_IRQ_BUTTON,
> > >  					 true);
> > >  	if (error) {
> > > --
> > > 2.37.1
> > >
> >
> > Thanks.
> >
> > --
> > Dmitry
