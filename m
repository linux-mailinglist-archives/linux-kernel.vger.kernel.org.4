Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E00A614D1C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKAOxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiKAOxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:53:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0591610AA;
        Tue,  1 Nov 2022 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667314417; x=1698850417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ftmHzb7R+7Hvrwl0dCG6XqwRUG4BLyEIsZSt/7gDuyQ=;
  b=Hkzi9mGcD41ZWXjOJ5aIQ7GHrQOJKKw0PdDb1PbcfeUQ7/Ecdr6NZpW+
   87gUCy13rrs4Vx0qg9MozA3zpnBuANurf3cAM36OQtK7ExCLc4Us0SOsR
   6uoahCRCYRQHyvOqVPjjnTsvtiu0b9ATJthLLSUgAJyLmAXypSDTbJAsc
   atMn7/eeYFLtnSrnF6UwpbPZN9WHvCkc6Dgp2t6VWRLZcjFCTqI+NXT8h
   KusTnhDYw6i1uNSBDTyJqktMdIzaMIHjfJxGQ9JiTa890o5V74r/JELgF
   zrJ01ST2WIt6Sy3zRT2KB2x+m56C4ofbww9b4bP/A2PtwrIYCIYOgnQIZ
   w==;
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="181429506"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Nov 2022 07:53:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 1 Nov 2022 07:53:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 1 Nov 2022 07:53:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6TeS2ZCWCogVSA6Iu7P9tqsqqpD63p2Ts6F/cuy+2c0DFFFN/z76SvlEefkCet8nZdTc01RS0aCyZ8vMLfZa+f/nTFx3/+xz2PPVFdaZ9TzQX0vI6/2HRNpC7sfNpw8rXX/b8iwQSd7+Nxjrifi4T5YLihpUFdwnDjDO64kKv5t8EaTFwFiP9NBPskSvSFYywg+jv+JpG7pA78XrTAqxmKwEwmm4Ef9F9KkdEqmoSIef6RK0PZxikru9d+bNtWDg3QoR9b879FaLlJbORB5abWZ1Xyckr3MCqMmfPdSD/lMZE8ExTWvcPfruYDf7ejH4hw0oKXRVHAAP3Xp/q7AGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqMtby7HvtCYr58pfoPmwjVXDKegV1PkXn2n0l6Z2qk=;
 b=Vi8+ymaJUdtkoyrHIqUxERqNEf8C7vBCyAVvN8te7CTcDES+eNpIdO96A2UTTvIcWu7KF0pE8voXPCO6RNzccdyBkHWu8Opplxtzt+z6JkohIUaYRn8ofZiI53rgWQWl3uroqPILoyDgbgtOCG6trRtrK4EcBrIhNqWSVCRldlIN2uw4oOsOBHVK+VcfTwRK3sANt41eJKnltCYExskd2DciP+pdACQPKqc520Wk+163Rph8vnyUWboeTDQtbTyEJ+cQieEMoaRKWEFDyalkVuwqFnd7X8zRJ5xe60YNUpO8CaaW0+2KWjsTXS5ihmWK/APtfkVEaTR7lQRpleNRvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqMtby7HvtCYr58pfoPmwjVXDKegV1PkXn2n0l6Z2qk=;
 b=uMV0faUbTLBA7mczDLMszD1sa9kTuXbptMiMqi0S4Hqxcuw1c9p3Ijj/+OaA7xvUAkdimnHM23s/bdMp6FpdCxxGs/aP2aQQb4Dz9yBjkAvZUpCPmBaL8VNaLCP0dG8og8CVkL4X+/vslKpWrsH6kUEg/Z0eovoKw/L1wZY/i9I=
Received: from PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5)
 by DM4PR11MB5504.namprd11.prod.outlook.com (2603:10b6:5:39d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 14:53:25 +0000
Received: from PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::1cfb:5030:3f7c:7add]) by PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::1cfb:5030:3f7c:7add%9]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 14:53:25 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <ilpo.jarvinen@linux.intel.com>,
        <Kumaravel.Thiagarajan@microchip.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andy.shevchenko@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <johan@kernel.org>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
 support to quad-uart driver.
Thread-Topic: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
 support to quad-uart driver.
Thread-Index: AQHY1V0xlQ9ney05Q0yTvysx01RZiK38Y4YAgC3ztyA=
Date:   Tue, 1 Nov 2022 14:53:25 +0000
Message-ID: <PH0PR11MB509668B72B3B85C2966D36909B369@PH0PR11MB5096.namprd11.prod.outlook.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-3-kumaravel.thiagarajan@microchip.com>
 <e433da81-46d5-5aad-4ce9-6d48b2e674e@linux.intel.com>
In-Reply-To: <e433da81-46d5-5aad-4ce9-6d48b2e674e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5096:EE_|DM4PR11MB5504:EE_
x-ms-office365-filtering-correlation-id: 50fb7f18-f9f4-43cd-a600-08dabc18d437
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KMM+/fLc1FQVSbhPtEM9eHgPO1kb6Ozho/vSiLRCw8ESf6iSNdsKyGiLCAgu0V8YAhXcnuwVA6i0AMAxH1r+WfjFxhOLC2ksN0BCRbLG+7cmfLw+KL5UydL3duJD0kSpMaizw7cUAYyiT5sn+hfIae+sjyjFTTc/pSOftDw4+WNhfqe3izpg9VoH0F9iEoXeBQQ8uHEwJ7Wp2q5+O3FxEYlKsgDxckkFKP8J1wR5fOb4Xo8cNMa5/sdZEhoo9SNZq7nFXlZZyc47i8/1erV2uv4uHyl4OFeR8HbUo4j7heBYBTRSnNYZCl6PxklNIAGTPeJpD04F436KcrKv2cOMC9zxWt1pspUxUxVpP5xYQYKC7KlAkHvt1n7u5cca17mWmCWwihNFolH5n0Qf/mXxeVwq9Qy84Vyk0iYQWyhHQQwTGStBGzNuotfOoYRkLE8NN5AUjs+7MokDlSNYF7R5XT9/03HT7oAaplYinLHgTcmQnRGrNpwNqN44q+9A8a+/PzYWvIuc3SA7Y4vS5VyFDOG7RS7D8HxC+LvDZzwgrcU1BgjJAioEkIWiOKWfRflZKiyvAzJm2XQ306Z3XBjVcDpMp8OAnPuDTvIFl+CVcoSvK3/Xb6nHNLUN5p7HMC2T1qg5kDLnPjEwLNAhOlWgA+7NNHZfbuZeNQa+IP93hHY1CWOH8E0PiU481acGscFKsRYN4NHichAjYrPpHhkewo7IG4h6Kmz5ySciNOFQTizqfvYXZVFK3bLm5L+QXlYkhp02ptA0eFsZxtF1KET92jrxLxCO/W/nz3Pq2Ru/HUXUjssx3HI7UFoB7pVFniHg3fcjnI0dxuwZ4Ru8rZCc0c7kM+lwrKD1BBXYjHJxfiA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199015)(66574015)(2906002)(83380400001)(38070700005)(33656002)(86362001)(122000001)(38100700002)(7416002)(5660300002)(76116006)(64756008)(52536014)(66556008)(8676002)(4326008)(41300700001)(66946007)(66446008)(8936002)(66476007)(6506007)(7696005)(186003)(53546011)(107886003)(26005)(9686003)(966005)(6636002)(110136005)(316002)(54906003)(478600001)(71200400001)(55016003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QZjLVvV8VOMgrD3WZlxS415Cy4nFsRjWxDeA+T9EwHyli89+0529SLHtFM?=
 =?iso-8859-1?Q?/DgUqq7Sb87zQtdoE4eePJSsS9AMWYme5OsiiZ3EU3r6lgD1vzDrktgAOb?=
 =?iso-8859-1?Q?x7rkr66SFOHvSyTRPzOx1jW7b7uaR/OP+M+vWp8s2Irktq+ioCH6kFHdZO?=
 =?iso-8859-1?Q?csgOvv+z6dOzqgh2EkknviZeCg6t5TUpWd1qqRmJzO6cZIWfPqO68DzTX6?=
 =?iso-8859-1?Q?DXbDmhqJC08AnvAGGoa+JjEYazajzjSIWQfSuH3Wkk3+1ojjPn6U9WspfG?=
 =?iso-8859-1?Q?9/UziclIptMro6ex31VbPea8JEAcJ+dSVkakKGUOQ0i+0Mt/yzqFxlV0Qj?=
 =?iso-8859-1?Q?ugCB2Ujv95Kx+gCvoAoPH1D9pYN7AOc4RrwP91mjNlN49VwmUDPqFO0KjY?=
 =?iso-8859-1?Q?b6NkeCr4WBf2fdbVSg8nw6kPruBmAkTFXCUqQAxkVJEkVBBn1j/rurULm9?=
 =?iso-8859-1?Q?1xGUBM1XTCtRrPr66K8b0XeSTs9ksV2ud8UhuIgIaFhwzPgTF/S/6sm+WJ?=
 =?iso-8859-1?Q?DDdadVE2ksXvISrctC2JBNZauquEE2FzLwGpeph9JYwQSIucZAWeMgUZAO?=
 =?iso-8859-1?Q?aqWRJYoMqvJUtUtGrlBglfINYibjiAzDp4LW1mPkhZQd+oud+kyt5B5xzd?=
 =?iso-8859-1?Q?/vSKAkLMahnGn4SKZcPSDh4oFEeWfS0CMHt5Bj9TIpsGFZbCVOwAzAQcc0?=
 =?iso-8859-1?Q?uwRkB5lmdtyENKIUHUCCYiEE2QZ6iQQgcnW9bvolwpG0hw+bGBJbMkWbiY?=
 =?iso-8859-1?Q?YZ85Mweu819KX/vuwcZkqNdeqEbZu4LdX/Qvj9pLyKnjuASiVzgu7hS0RK?=
 =?iso-8859-1?Q?09njr0SwxlZ9K5ua4Xm7cnWXrQBgbHTNDP51fPWl6gkiV+czunFvmqBF0d?=
 =?iso-8859-1?Q?Juu8g6pjaMa67LCdAbFkeitEmxrv/7Yvf5rigy47ollYs4/d4C34jOpOJO?=
 =?iso-8859-1?Q?kqk0HEr05DmwixbGntaoq5S+x7oRxutBJavxjNsRtwj9xHUMlKrhpz5+we?=
 =?iso-8859-1?Q?TCtmW+AwPEy4a0UsMaXMUAilD1V+UFopTFI+QUH5gGYEC678a6VUEIMKvT?=
 =?iso-8859-1?Q?8M+Z7vCLcW+rbIjqNeKHEvhAbXqY3fe8R5859GIeeNN1z57H/77to/l8x4?=
 =?iso-8859-1?Q?82hecJTPBe16hGr455tJLT18WmTWAZDvy82WdAD+3DMkv22KsRNP1N1yyc?=
 =?iso-8859-1?Q?CwpvCtDWUhvX0IXNKIrDadVRdxlMEuZM5y5QFnuh6jd7zbnaRENUHyHcZH?=
 =?iso-8859-1?Q?xMP6ESSeSM1Ws/nfYRLRy2ZT71k1Rvs4LtfuP2RvsZ7NUlAV+Ijcg/jkWs?=
 =?iso-8859-1?Q?POxUoPQHFw2KH6AgN9I1m4V3pfmRpTkbG2aVHnwbTGlJYDnmQCi5v1dqE0?=
 =?iso-8859-1?Q?PogEt7rYMjdkGr999w6WaL1LEoHDgcZeQU9YSb+Xl/jXcsUqJYzzN+y72s?=
 =?iso-8859-1?Q?tM+dqCLHIeRlqF5uTTTysNw7dnWy2NA3vyeJuJyhoWI/7Lf4uqLN1AsWTg?=
 =?iso-8859-1?Q?yKzMLxd4qscQdHdPmTw+d5npoR0i7r32gCRE3fhLhTQz0l18DCGRdG3db5?=
 =?iso-8859-1?Q?NzyJbmP8hm7ly5zkujl7a4tBtkMD+qTUIT58XJK/mTZbLjOSWkoj9EyGLh?=
 =?iso-8859-1?Q?Ubo0F09Ikdtglpv5kC/FVc3OkpGz4Adrs62p1m5fjCa2EZzhx/PJ68/8NU?=
 =?iso-8859-1?Q?sasM7DbtrZ4eWY6rCzE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5096.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fb7f18-f9f4-43cd-a600-08dabc18d437
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 14:53:25.1687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKmIlAkH7d+XSB8vetuCxvu+pzFzpE8tPu5kxpKY4O7nyOrf9KZSE5N6wTBUxSfK42IoG0KDxKnS86jG3AvrZB7YWCFlrvGvgOtNvvS8r9PpqVxDuaFeYl07bthhy360
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5504
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Monday, October 3, 2022 2:34 PM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>
> Subject: Re: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
> support to quad-uart driver.
>=20
> [Some people who received this message don't often get email from
> ilpo.jarvinen@linux.intel.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > +     if (rs485->flags & SER_RS485_ENABLED) {
> > +             memset(rs485->padding, 0, sizeof(rs485->padding));
>=20
> Core handles this for you.

I went through the code and it seems like this is not taken care by the cor=
e.
Do you suggest calling 'serial8250_em485_config' inside 'pci1xxxx_rs485_con=
fig' callback?
This has not been done since we do not need all the configurations done ins=
ide 'serial8250_em485_config'.

> > +             if (!(rs485->flags & SER_RS485_RTS_ON_SEND)) {
> > +                     data |=3D ADCL_CFG_POL_SEL;
> > +                     rs485->flags |=3D  SER_RS485_RTS_AFTER_SEND;
> > +             } else {
> > +                     rs485->flags &=3D ~SER_RS485_RTS_AFTER_SEND;
> > +             }
>=20
> Core handles that flags sanitization for you.

I went through the code and it seems like this is not taken care by the cor=
e.
Do you suggest calling 'serial8250_em485_config' inside 'pci1xxxx_rs485_con=
fig' callback?
This has not been done since we do not need all the configurations done ins=
ide 'serial8250_em485_config'.

> > +     } else {
> > +             memset(rs485, 0, sizeof(*rs485));
>=20
> Core handles this.

I went through the code and it seems like this is not taken care by the cor=
e.
Do you suggest calling 'serial8250_em485_config' inside 'pci1xxxx_rs485_con=
fig' callback?
This has not been done since we do not need all the configurations done ins=
ide 'serial8250_em485_config'.

> > +     writeb(data, (port->membase + ADCL_CFG_REG));
> > +     port->rs485 =3D *rs485;
>=20
> Core handles this.

I went through the code and it seems like this is not taken care by the cor=
e.
Do you suggest calling 'serial8250_em485_config' inside 'pci1xxxx_rs485_con=
fig' callback?
This has not been done since we do not need all the configurations done ins=
ide 'serial8250_em485_config'.


Thanks,
Tharun Kumar P
