Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3963F648E61
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 12:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLJLT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 06:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLJLTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 06:19:24 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEEA1AF2F;
        Sat, 10 Dec 2022 03:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670671163; x=1702207163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YxHEgZn1HZhs/JPyF2L0KNh1PusT4bGvaNfUjfwq3fU=;
  b=1mlaiSbI06TC0v9ZfW88a+uHDsnuDWYObFqcGJZw+0Cgudp3InJu2KID
   WY9reIVSMMwCsdiKe1+9GaTkVnxyAxa/4cnus8rGDwPAwUqvQM4f+oLJa
   3lkUopnIkXdFnsJsfeHkOxucrr9xibGlSCW2R9xohi8u5Dh9IM2lPcInq
   51fUifMtlNCNprJeh5WDGJEuH0LphDFYotY30a/R42pPWZH4UiKxLEtPi
   7U9rhUkHraf+35vaIjTHyii9HgbZOJkTJR0kmcaLYaqF29oz+R8CDK33N
   RCJ9MKEr3dWoiHUKFc3LnQeUETgGOHGkmEB2JVVbsmdBx92vs5i1Hvw5a
   g==;
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="192495902"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Dec 2022 04:19:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 10 Dec 2022 04:19:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 10 Dec 2022 04:19:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3H+KdjrUlTAL4CmWYwtYC6ayo3oM6wL1gZiaTE4cIS4HE4BcnAgZTKlswlLltiBv9+vIsNJP7laJdByttFtjsZ5WWb9Pep5wEvaSXSx7Gx6pM84QJELd0HM36Jv61i5DIT/+trudVFzbWo140iwxyzQjndwC2hTPusKKRLQHQQesaXgdUO2cHZ2rh2OWaKt1KWZit9aa4eo7CKGRlofOPOwt0llKu6L2Ehlc7GD7bbt5CPhIwJfDz6ZIOAolFfDl4sdV++yio/30a5631ZYMukcBYFp7g/rKa8Pvt5fvYH+k0ShvWzcR6M/FBnAs7+8olMVIjdNaFYMVfy70h51Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4GQYmZGbQ6xwxVXgrRCHgy+HJsc+UeLUZQ+iD7SShk=;
 b=RYoEL1A0e+uYuoqF8SWZXf3g9gzs1t/GH/bcDA5aXPIJ6sK/F1AK1/0kRrwO2Vpn0Xdyl5CmLCxgyhHGiTypmg501+TUeE8x7attdaGxyd3fYd3Ue/ZUXEBWH7dA9al6GU/N0jSIZtn4EZFA69dLrB+Mcj8bTjxlMwCicBtRXn59a6VdK93UmehLRh8yRZAg+XCprOYb0C3mt6+1SaFIIm1iZej52AD1Ghzj8/TuaiqfIHWBeLSD8bEY5hRzBwUey2YQl1oKwJw01tQYFjf3YG58p4iq5t3OmcitkywaHf4OK3MasQTOcDNfrR94WBCbi7/NNLgH8+fk1ldh8kblBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4GQYmZGbQ6xwxVXgrRCHgy+HJsc+UeLUZQ+iD7SShk=;
 b=C/XtSv9cyLjQ/XTmonJB24B+rQBOxOtUn8Bno102yCZzyTvVYaXvIyrUcxuntwMQ0sv8y50biY7XzsIsf24zyORVxGG5SV1HKxY9buh593pkkk6MrkTF9MXzSvTLTeSa535p1+jGTTSekwy4gw7Uef/DUR1W+6GC0xByz/0WalE=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by PH8PR11MB6830.namprd11.prod.outlook.com (2603:10b6:510:22e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 10 Dec
 2022 11:19:18 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084%9]) with mapi id 15.20.5880.019; Sat, 10 Dec 2022
 11:19:18 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>,
        <Kumaravel.Thiagarajan@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <macro@orcam.me.uk>,
        <cang1@live.co.uk>, <colin.i.king@gmail.com>,
        <phil.edworthy@renesas.com>, <biju.das.jz@bp.renesas.com>,
        <geert+renesas@glider.be>, <lukas@wunner.de>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>
Subject: RE: [PATCH v7 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Thread-Topic: [PATCH v7 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Thread-Index: AQHZCi23nlvhMmG2bkuZfoGyMpcz2K5i2P8AgAQklKA=
Date:   Sat, 10 Dec 2022 11:19:18 +0000
Message-ID: <PH7PR11MB595857123B23F27D1E9DE2D39B1F9@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20221207235305.695541-1-kumaravel.thiagarajan@microchip.com>
 <20221207235305.695541-3-kumaravel.thiagarajan@microchip.com>
 <Y5DxEszrq0rXVqvl@smile.fi.intel.com>
In-Reply-To: <Y5DxEszrq0rXVqvl@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|PH8PR11MB6830:EE_
x-ms-office365-filtering-correlation-id: 910726af-eafa-4502-65af-08dadaa06113
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d8BQ0T5QrOG2ZO8d36rSbuLZrN34WU44S+d40olw9+406sMBBG//GZ6t8A7N446fLiUd4EpmRr+mXA9ahOTpm+fRLN6RKJgK4rw9WkMHbDg+htjVybCSHOGRQIyWepySyr+6imcuc59wafEWsjmPbyYK9oQnCugyJ3mENS2X8DwhXbWbsmq+3ZC0tRxV+zPu5MoR9mKBWLlyQX6RkQEG170fDhAprxZtMeSMwZVGD32UIizhG4JpowtdJcWashlasiVxCXCKEh64Zw6jr/tsZpuumqSEx1W7mxLaIyUFxAep9Ow/99sdfxifZwGdJcYvt55dOIT5WFbbE1linA9c6NWgS5TYKLZsoHyF4ECTXmqSDxHs68Tk1cXsHJ5JnbUYKjCGWO/gM6XI0G+cFCr3cRT+dN0JpwiF5i1Rde2ZOaNKhdNO3xOV78Ie3rDAtv2CclH1NlLSt6kfNsHN4VhQOKHkS12LJgYmkm8VnZYGUQa/Qog+xYqAZX3qD/FEJi8B9KJdz6//rxGzEphirHWUFOlyUgZCjCe7rKROisXuAYOT4Eb7z2n4aHz2c0Zz8Bp6dDubVLv1aQLDDyiCqcGmufyh9lQig74nW56MCzqDXcrqSND0OtCJ6x9763UPPMcCrLN+UL2qOhc2CLiH3zwkVWjmFkV7QCi90YJa+qaCU2ycyfpXQyUvVne8URsb45Wd+8snBtJP3iT6bm1maFe8xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199015)(6636002)(71200400001)(38100700002)(122000001)(6506007)(53546011)(26005)(9686003)(7696005)(83380400001)(186003)(33656002)(478600001)(66946007)(52536014)(66446008)(66476007)(66556008)(64756008)(55016003)(5660300002)(41300700001)(8936002)(2906002)(316002)(110136005)(54906003)(7416002)(4744005)(38070700005)(86362001)(4326008)(76116006)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pnAPJ/kNFzx566INF11WWbqdNLa2VBzFqJ+xj9yfvbxwG++yez1/b1+c6WdK?=
 =?us-ascii?Q?hV4KoPhcgRLs3EvcTFrVmbiq86apY+f5nrjcsDhkcLiscY88MmM3CL2u3eoT?=
 =?us-ascii?Q?/0oaFC8sSW+sixF+j2wJxsJ/JCMzhMlEJ0DHd7mieXj5BkcEwAB3P4rkCO4H?=
 =?us-ascii?Q?9K7JwK8xkyWUK9XuwNHGi2b2FBEoWf/LPzay5qOYLXyO4XOG3c6EEZ8S/934?=
 =?us-ascii?Q?tNMZymV+YFckB4BvQ5KPeOdqmijElsUrdoJ/Cgv0pLnIetr2Fxu1QxDmwxMC?=
 =?us-ascii?Q?AOu8GQKedvGUpcySgW2n7nkLC0bK7hw8uOX9OlOZKIfxbtQ8uRUwyLrKTRtZ?=
 =?us-ascii?Q?9km7ZwRn2IxBdfx3EDPtb41iAQxhju7zTFOvmW0PbkO3oMFK1lUachXVd83j?=
 =?us-ascii?Q?A2ymoIgIIzSX1s/9gaZV/1fqKTobuQOexS1YIlIXyrVF8Xq95/rwT4KK+VcV?=
 =?us-ascii?Q?vnfERD4/rvo3JV/H3/fZjx77VbDM/t2h8YeNyMsfjVSMJuadfv7VQIRnqa6N?=
 =?us-ascii?Q?1EO/ERrCBHPg4l7hTYOHgKf6RrCdahqTv6hR6Juw40czgIaPRDvVTv+Roj6o?=
 =?us-ascii?Q?6vn6kk79HDoe8B55D4l9xqBRQrVJaySkpqaMXx1bGDitnBVHzqUxPqi4rLr+?=
 =?us-ascii?Q?Kv3WeBUxTEdoPr9j0GGvT9kwZkC+uvrGHzjKyv9mm1vyqENvETu302SIjciu?=
 =?us-ascii?Q?PSAy8nq1gjFVJ2H3qv3/H78BgIl0ihfHgglfA9xlsPhH/s6CMG5neoR/Hs6m?=
 =?us-ascii?Q?gbyNDpglbNSdTL1ongZDDShiHR1L8RnJ3oF3H4Babq/TFvm9RIDVN2nyi1qg?=
 =?us-ascii?Q?GCAdwPT6GX0Pyov/jNt2LDrxw5xNI5CTZ36EGT5DhLg/+YNiZzl9jAIJoKNt?=
 =?us-ascii?Q?Q4zt4z401ur9mvkKWFUwrsImcd7goqXz3wupUjsEQPVIqdSFVKYQgCc1qy+R?=
 =?us-ascii?Q?nf+N5AmIL75J1gI+AO2jcLkC1Lyuk+IWsAdQCwHc9iJeUDpZgf70BuKY0T8e?=
 =?us-ascii?Q?GHQ4L76mVA19Z92xZBcxr+k55RJTsc3BWacWwX5YyAwdt7O1tmpS2zG+4jOl?=
 =?us-ascii?Q?sX3e50jE4Som59rInHs5h3LJkxyswlLjisUw/DK9qSOO1Km1U9Sk6umRE8nF?=
 =?us-ascii?Q?neDI7GMHYl+QPWFNMM2Nc+WI+960aHpzcZ7zVJBdT2v9wfOHjmTq+GxaRnKL?=
 =?us-ascii?Q?9uj4aQFOnZ3XhZ+p24dSNmDRcenjfJPlo3mgGP6kXcJRAKs/Qb6OSwtk5dvq?=
 =?us-ascii?Q?/5d2yhE5fBlqnTNN+UW+vB7ISSFN0PWCbubIa7KVrZMFWmLhHciu4WkN0lvE?=
 =?us-ascii?Q?NchmzfeFhB8u8AL39gjOeFxF9O8ZdRERPdloVLaE676gnTic2jzkeEZEenI+?=
 =?us-ascii?Q?Vem8s4v5ndR2WSA+k9mfJddn3PyL5Fwe7Zhj05yWsBe2JBjmaQ03hebUJcpw?=
 =?us-ascii?Q?YxeKWGCcDKsXg5BOr3fwQcdhqSZaBhEXYFf9zawVQrepIabSzPDRDUckMzKi?=
 =?us-ascii?Q?mb6+c0F7Vn1/XVojVOIf02qLnafRUuZFn+PTs/7paKXfkDY8CkN5Xd90susS?=
 =?us-ascii?Q?6ULn1Y/6zBz6FQCJ6f2AbkfrEj8y3gx46mAVm6nAXaf7CzxjTLUnosXSRfya?=
 =?us-ascii?Q?mEl/yrGpG/AVNi5ESxvl8bg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910726af-eafa-4502-65af-08dadaa06113
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2022 11:19:18.4473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2bMgEjjokq3kK/8EJqJggoBavNr4kPZAHFWDD0oXDRDff9WkQCcQLKCi0ROJpdMY3Sq8WmEcYMUPXBGMS7mBfmvGkKc20g7JcQE2dyz2tUeW8ovl6bJXp4RON+/vDh4J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6830
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, December 8, 2022 1:31 AM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>
> Subject: Re: [PATCH v7 tty-next 2/4] serial: 8250_pci1xxxx: Add driver fo=
r
> quad-uart support
>=20
> > +     priv->membase =3D pcim_iomap(pdev, 0, 0);
>=20
> Is any of those card can have an IO bar (instead of MEM)?

No Andy

> > +     if (num_vectors =3D=3D 4)
> > +             writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI,
> > +                    priv->membase + UART_PCI_CTRL_REG);
>=20
> If you set this unconditionally when num_vectors < 4, would it still work=
?

UART_PCI_CTRL_SET_MULTIPLE_MSI must be set only when all the requested inte=
rrupt vectors   =20
are allocated by the pci_alloc_irq_vectors API. Number of interrupt vectors=
 requested was always
4 previously and that logic will be modified to request only which is requi=
red in V8 patch.=20


Thanks,
Tharun Kumar P
