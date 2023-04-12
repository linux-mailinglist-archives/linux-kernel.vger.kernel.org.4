Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD4C6DF4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjDLMTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDLMTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:19:05 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C89273F;
        Wed, 12 Apr 2023 05:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRc20o3NmKttmohf0D9k5w/JQtIN2F74Z4kHdGjD/xbVs2y6+l3ktnRaZ5HLQaKTRJwjQ2hTAbD20mCsDXThlJSi1kb/xmnxwmudq3NpNLQhPbN3mPRpvYkkBi1ntL3aht6xlwUyW+ZBYB66ujZN9xdH+x0JIw/N+edEdHJsE2h+UKnQJ30Sb28XIZf1hw20DYDA3KfoZf6GpQpHPARPyyYfrnOdRsra8WI/HRf8XcsKpAOqFO5vUGYkVqRsmCCHeY5IrtYp92tRtUh/VC1rzmvY8v2gYCeM33K/l3dA+1I1fNQBWQcLC828/C7ZxxFALYTaxyoZmfjAls9w3YWYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttFEsi2x/DgP3FxKCgZ8mB13tX47U4cXA7uUnJNfCA4=;
 b=JsPHsDUBn9b/fmcYToSfIFMb8TUiHaKZwC2Gr6Hu6ad92OwFoRY5bZhjEHtj7TE57o2naQfT0hLfGUGU+ez/M4xI9c8vXw3oxIyjzj3wqMPgbtoyxVMUbc1hIXVxKaw6Z2Yoef+CQAQiij184dQY9fLnHbAAU1QSjVJSA9YcHr5JEyT9IUh5nU2v3CzxiVWzXkBbBljWl9Vnr3XMNs1WjjMUPfQpKoU9R65081zOjwGrWxKcfJK7EUPcUb6+4n1YUAKJoMFh/1xX7l5PdTd8gzjOFrH6qinRWVED/WGdYi4yzrvgv+vpWxg/teU2DEQy7bpxuSILSMompOb6NjjSjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttFEsi2x/DgP3FxKCgZ8mB13tX47U4cXA7uUnJNfCA4=;
 b=qZCuabzthVq5eWSKUtn4phlPa8ndjeYnRrQ0SOxm6nsC1usnol4ZKZ2meBpBjDJl7itcuj6eRfHQt2R8kWDtOO7qgUhCawJcLTbnBQwaBtk0Wwv1LudJmhe8IJwtooy7/GAHNVtOp+lngx4rOGxuSgrCb+W2MX99h9Ui5mIdQgs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7677.eurprd04.prod.outlook.com (2603:10a6:102:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 12:19:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 12:19:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
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
Thread-Index: AQHZXWmUVLJFWxBDC068h5KGnJZKqa8j7hEAgAPIhwA=
Date:   Wed, 12 Apr 2023 12:19:00 +0000
Message-ID: <DU0PR04MB94172C2BBB554E472576B2BA889B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230323093141.4070840-1-peng.fan@oss.nxp.com>
 <20230323093141.4070840-2-peng.fan@oss.nxp.com> <ZDN00vwyCOzFrDYt@google.com>
In-Reply-To: <ZDN00vwyCOzFrDYt@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7677:EE_
x-ms-office365-filtering-correlation-id: 1c49c9ec-7edd-4843-8333-08db3b5018f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rjRHLeubsLUBvPbBBiqDVG9fcvTWmFt3OEhoYKRImeq607Qa/dJmIjKUEoVu/scC7fPPjxcY9H36rRdxf5eSxreBtOa5jBTuL+dWDueSHBfOUmmIJUqbM9aYLSWV8YaylN2rY0M3xT1uprO2k3vhMFOKOhqHqWPXLb2nPMtK0r8ARCipNjdL0oOe7Dbb7Xr/bTJdgFvOXgIPQISxGpWdMLgCDHXJjNOJGqgcq2fhnonhNYEMawmUx9gw9OslP9RBOOjNncsWuxOldTvkVZT12/4PRYR2BXkEgs7iYh8l0N5fhUvYEo9ioOPIn4QYnLs1dVv1q3gmgJwaQqbPRO7KKb/SxdXcWQ+hsOVaviaPlUi1LmxyKdBFZEPQI6VaDI6SCuhTxKPyDB4x8scieSZZLlHAOL3TEOXApQeS9SoeQqD2RV75Akz+/k0kVILllAEshPjXvXLAj0upWUuq/pDYXbgxbh3rlPP8eZ7xP5sBEAz2xi48gx+J9ym+zTQaWHKRozJaLLh4eRBgi8PnwiwYc+swV3FP0tZcTa43ZZgP/NNQNtwZJLwgqp8Mg9CBOUm75p+q7b0RoCxFcFLhTQCfA7j2SswN13eJjVS1h9v6oYiV2NtTlvnMHK0+LtxRR0RW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(186003)(9686003)(26005)(6506007)(38070700005)(54906003)(55016003)(83380400001)(7696005)(71200400001)(86362001)(2906002)(4326008)(76116006)(41300700001)(64756008)(66446008)(66476007)(66556008)(66946007)(478600001)(122000001)(8676002)(8936002)(7416002)(5660300002)(33656002)(44832011)(52536014)(110136005)(316002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9vBqnXCpF2pc7ELcWrYTy5rdDCj81fS+OHQdfwPWzaKl5v05gvJEN7PuFY14?=
 =?us-ascii?Q?AkBjuR6GbBaxj606IP40ZirxWHIivQuogOYFuawav8IDsOWRYnAc1UedOFrp?=
 =?us-ascii?Q?IDViQFudSHUf4ZqMF5dPn5T5u8GPp+JiNGgQ0qWhGzFHFNx1IBh3GDXbbv2Y?=
 =?us-ascii?Q?LcnNDEA2bYOuGpBRM0JpBjkOu8CO5ErtxyNLYN7lFnxSPdcIeeQV6AV8ysSI?=
 =?us-ascii?Q?iy7ly9Glkk/SsFlzdZRghP52n6Hy4MNmJ9L4bLOOW3ZSCTKAZ1OiQB6TXg/A?=
 =?us-ascii?Q?isUCiSZPQD9GaUOf+ihmhAn8pS34aK15d2suWldQyn4bBzVHJ0g3GwE98rr2?=
 =?us-ascii?Q?OZgLDdABCY/0WRSbJ4qvJ8qKykzJYABaDdlFeJqa3j0jl8oJnS42TzSL0HSl?=
 =?us-ascii?Q?B3OLPJRVAEGKS2Tzwuixv3/2lZIUpjJDXXdm9s4t0kUmidlv/FJIH7SiUP8y?=
 =?us-ascii?Q?CeD1rz1e2j0r3zYUb2sNjnP3tdwRVp7sVVS9yvv+pCIQux4KlTOVt84gcBZ5?=
 =?us-ascii?Q?55f0yMHOeFgGNW9tmSQJohZ0oscuZ9WsMvBvdgkOIfecMqdlM8NhQBUmZRMB?=
 =?us-ascii?Q?z4UFQWSji5wx0bKsWOlSVghLHrq5yD/kc/W+qxJ56cHidMjlJM+rusr9H22s?=
 =?us-ascii?Q?aS23kuCNWZ+BG97ElLt+RqefOU1P0dLbKB4j7S0gnDBV5l/3tsqaftP117Ob?=
 =?us-ascii?Q?+X/363FlPIPpSp3YdLqYakx45AaW3C0eD+WdYx0RBgIpZlb2+kKmpJV5dLE/?=
 =?us-ascii?Q?/33BUXy6OvxDUN9ZoCE6mCLRW5kfAIRKNl2NJRRtFgkU49qXXVqm5pqbap4I?=
 =?us-ascii?Q?eetH74ctaIziUYrHUctUN8u3G8OONyjr2SNy+DcypCzH8tRUNDgzy9VfBCdM?=
 =?us-ascii?Q?pwqyPAnrUCxGc3qweVmiNdl8jqz7bkExlo3NctHGA2GrmgwFCNqPTUQIkGHu?=
 =?us-ascii?Q?X907tRZYnIiPsBqNgt6qTBD7vAB5IEQFrczokC2mamg/MEI7n+FphVXvYv9M?=
 =?us-ascii?Q?scFWVphomskkjg8Lv3RAJdpRmjJKz9q8zazDUvvVL1jz1swCeK9GXTeBz+iy?=
 =?us-ascii?Q?FNwSDoEx/gUKbJ83TRf862F/l6GzETn27UlX2M0tKLNmJNVJIh9Y9OdRXS4C?=
 =?us-ascii?Q?RGDCRR0CBhhsjmEH+eNKENBMkgbiPbpuMd8f24X+uZpVy5yJi4XGxvdTpmWv?=
 =?us-ascii?Q?5qwwBx88pXqEwkE4+zf4chAWxrxPNrkeuv8wmPAidzfHnOTRFDjFI0WZePnr?=
 =?us-ascii?Q?oUr6LgZpdBYdirxdDUbIKbZPyq2dhicJTGLtG4Cz02T9f3TnJMiqd+6lWvyx?=
 =?us-ascii?Q?EFetX0NXOgadILu35A/4h/lluHdevczyK+MfvQt8zSHUo58NEah/VLH77523?=
 =?us-ascii?Q?QSfFtEX8pDpEwqve2SzmJ6lpJFoFMuMB/p1Zi0JEkpahWgp/pvzIJYF6G47w?=
 =?us-ascii?Q?mTKR6hn4795OQOsN6PLqoAAUyZNmBlha/L52QFhJtxvKPRplZ5fU/DXamCKn?=
 =?us-ascii?Q?W1OFNJysq/T1osAuto8cuJsRGtxHdDGwUoBiIqMLwGiGHwfLce3zOXu8LJhs?=
 =?us-ascii?Q?jH6OTOKaIEoMpQr/sOk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c49c9ec-7edd-4843-8333-08db3b5018f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 12:19:00.4681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7rRdP6tUrb2+pZ4uzDe48iEAwxvHqTEkoCKrcq/pKltITfavPFL/uo3qzjokghKKMA8nD6VeohDONyuAYeuRDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7677
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 2/2] input: imx_sc_key: add wakeup support
>=20
> On Thu, Mar 23, 2023 at 05:31:41PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add support for waking up from system wide suspend.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/input/keyboard/imx_sc_key.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/input/keyboard/imx_sc_key.c
> b/drivers/input/keyboard/imx_sc_key.c
> > index d18839f1f4f6..234f23cf9990 100644
> > --- a/drivers/input/keyboard/imx_sc_key.c
> > +++ b/drivers/input/keyboard/imx_sc_key.c
> > @@ -151,6 +151,8 @@ static int imx_sc_key_probe(struct
> platform_device *pdev)
> >  	priv->input =3D input;
> >  	platform_set_drvdata(pdev, priv);
> >
> > +	device_init_wakeup(&pdev->dev,
> device_property_read_bool(&pdev->dev, "wakeup-source"));
> > +
>=20
> I wonder - could we move this to the device core?

I see lots device drivers parse wakeup-source, so I also follow
That. Not sure whether could move this feature to device core,
but anyway I could give a try.

Thanks,
Peng.
>=20
> >  	error =3D imx_scu_irq_group_enable(SC_IRQ_GROUP_WAKE,
> SC_IRQ_BUTTON,
> >  					 true);
> >  	if (error) {
> > --
> > 2.37.1
> >
>=20
> Thanks.
>=20
> --
> Dmitry
