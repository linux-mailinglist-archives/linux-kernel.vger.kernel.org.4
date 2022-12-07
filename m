Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDB0645957
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiLGLwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiLGLvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:51:40 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA80A1023;
        Wed,  7 Dec 2022 03:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670413897; x=1701949897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zvQvoWnHKK8GKmWDVFy0JPFBwDEHDuP5ql5tVkzXUI4=;
  b=ZuajStEeRpNFlPZfeo6DIQMNYe6DlHTbJOGTGc/9+2UE1k9Yc2+1zKr/
   PF9EnSl1p0XZq4JHDT5dN8C83boMaA+u6Rv3TtEbmy8ALxV0hBhVu6nPt
   AKeme+Zz1h4ATa938j0j5cjfLe8X/6BzkeptytL1OyA47CnBN995m1qJt
   gXCUV1Jjsq0JRlNPkviA5hU80mXxn04ZGz9K+9XYR9DELgOw7nca0y3ly
   79cpzVZGddLv/cfYoNJz6yTRY5n8H5zYUfoXhLqDN3ValC1HOYy+tlnMf
   GbaiPmwSrocDE2UoWQabPzAYegIbkyFZ8kaYSFG9UzZJoNbv6cgWl7HwE
   g==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="186958748"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2022 04:51:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Dec 2022 04:51:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 7 Dec 2022 04:51:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=defpQsGv6vBibrNrMJ5ggKCQlHpGUhRD0kfnrEfRjm+N5LUs12VQizxSL7KckLR20fCxqogo5aZiSoRUomOy2kfBrS7P6bnflWHVv4DYuG7DzcI50W5fwFxM4UueCekCvecupjk2rbsXfowCwef57xjRQUfSySZGVY7Oyrc+cNjanyWnimxQDDHdEpZbXiGQu4tb68CDztO9TFiPs7wQm7l4ZM52au2b8+ujmnibpj9r6OlDJryzyQwZ7ktBkryLLje0qkm89o89yAux8LIOrYM6VjqfMB2PH+k1XdAWOXpBluzFTiGg9kYcL6kZTe6feciZuYD0uw4DXc88uTUhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn+MrOTtEEsmajVlWOMtniGh8bPwXakBqpZzzGJTD24=;
 b=RJhPfCjRAyUJIysHC4HMvJvg947Mbm6O+378RT2yzrKdtgLgK/9uS95OXCXdOBtRgNZ5YTrDL6Kq7lx+z79ZqbAfNXYws/Zu/yZVeuoB668FyZRe4TrPe/WIvACUL9+4FS4zemcAKarXPrfY6t/E+ESXpd344jsPoSy4mQPUVuf/RTvV8RYy9FqNtRNaVTwdmA9093OVCiuuAbePUBimUNfNfXczlOf5FcO4vr4pNeCJmpFCYHYkKgNiIQZ2r5rfRiJwD8+akxKYPwdrj/O0rCP0Itn05r7YkfPNhsOxJRjH4PbCMnBjruoXgA1czHTs9qi74ZpDkAn30RqnrRGxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn+MrOTtEEsmajVlWOMtniGh8bPwXakBqpZzzGJTD24=;
 b=jQhw6cRIlw8WfSWpM/boD+EpB89aYZQSL/9hPhsjD8YMIHrQ5N/9YtgGyISMbnTsVN/IG0BvEHsBqoXj8gpdK57KsDoTSf67D66AUN4gHYQlitTkJWPd5B+/e8QG3lbXyCFf3OCCeoQnvKrMakd6q+D2BLmZiJfaHH2Yjm/eLms=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by DM4PR11MB5231.namprd11.prod.outlook.com (2603:10b6:5:38a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 11:51:32 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::fecf:d286:328b:747f]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::fecf:d286:328b:747f%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 11:51:32 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <macro@orcam.me.uk>,
        <jay.dolan@accesio.com>, <cang1@live.co.uk>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <biju.das.jz@bp.renesas.com>, <geert+renesas@glider.be>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <UNGLinuxDriver@microchip.com>, <colin.i.king@gmail.com>,
        <Tharunkumar.Pasumarthi@microchip.com>
Subject: RE: [PATCH v6 tty-next 3/4] serial: 8250_pci1xxxx: Add RS485 support
 to quad-uart driver
Thread-Topic: [PATCH v6 tty-next 3/4] serial: 8250_pci1xxxx: Add RS485 support
 to quad-uart driver
Thread-Index: AQHZBUCyVI8Jzgj/vEqV1N6a80ZqLK5YyUOAgAmO8FA=
Date:   Wed, 7 Dec 2022 11:51:31 +0000
Message-ID: <BN8PR11MB36688D417F015D5DB19FA3FFE91A9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com>
 <20221201045146.1055913-4-kumaravel.thiagarajan@microchip.com>
 <b9d2c851-7b16-b0a0-3475-c5ab17a563e@linux.intel.com>
In-Reply-To: <b9d2c851-7b16-b0a0-3475-c5ab17a563e@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|DM4PR11MB5231:EE_
x-ms-office365-filtering-correlation-id: 62befd3b-085b-4d20-1540-08dad849625c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7x6Nz3Nnkg6+ZmgVLsJThAsolGYU7r1RtMByhxBOL6fldIqFshOr8TBwH4evvkify5Olq4z5U8Knys43hVCxxtX5bMGrnNGw2s+QmwaDjuZllwthXzUU/W547PM59HTrz4qgpt6xDRIQ2LKFUNPNSm4lIVCRuDK+kDPrJQsVjnV/uGCRlJhJYzHofsLsbYOWcwtADWBRBus4ri/7kz/PYWGmwHwXZypml/iMXgzgP+2+aNgMWbHfmiTr09eXtod7da4+uhQwVaee2aaOZkiR4jC9XD0B1pGUrG0uNk18ppaJGi/96GnY5GrftAPHrq5P7MjEtI4yd8t0beF88NQfJ3rij2ELnY8bRRWfbxe61RnHYF+9RQe+jYaSOg+HfFouTcLqJ9G9UzyPVsdz4PSRshj6IVSqmaeJRXIP4b4XslYZgRqvHMTnF2aJ8KGFaVMX6LWknitlt7MFF5kgbGQPRd+CAviAF+5rCLFkrkJHvroVeSw4IYsyxO/UVbfEWCLYsmmlC/ZUdyWdVZpOqr0376ZO/tqsxUuKlly4EZN8rspgRvln3nNY/aRmeCFYqEAIDbGQVa4muJ9Bwmp/mMmVIgLQ1qQuZH9p8X1shCzKwwRS+MMdzo8s4cYof84BguiRQTh4Yl+gMtHT0eQ0mHgX5o5raxLMpeI+lp4hlu09VljAvmXjSr/9CXMSkUZI7rVeWPqj+t/DKwqabE6HCy8qOwTL4oumwBZY9w4Bm9Pu4REQis5WjMGxdAZVrs1dJKHN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(38100700002)(38070700005)(2906002)(41300700001)(186003)(83380400001)(5660300002)(122000001)(8936002)(478600001)(52536014)(7416002)(107886003)(53546011)(6506007)(7696005)(71200400001)(66556008)(86362001)(8676002)(66446008)(76116006)(64756008)(66476007)(66946007)(26005)(54906003)(9686003)(4326008)(6916009)(316002)(55016003)(33656002)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Nm0YoMhMkkRHNXBp9zulcCMWTkVzrRcHa7WkLdEiFZiA/v0RNJCg1LkJHg?=
 =?iso-8859-1?Q?cfdcH1wlkYHRoUToZdtsDFMFpNYw9Qbs3fTjpM1A+Op4QgjVunuC8T/8Be?=
 =?iso-8859-1?Q?eef2m8FfqgoVpeBWIP9dU3tExBubqpgkOJ36CJyLyLFrqDdSjcjEp3kgYz?=
 =?iso-8859-1?Q?T4YS4H7nSJBMK9ToXs8rxGbaDIrTozX8Ooi2M+xVu0ec41Tkd/9SE6p9UV?=
 =?iso-8859-1?Q?RJPAsFHCUmmciyABUxxk11swNOob66T2C6oySwxfuBVRpB6RvLOkqXSYO9?=
 =?iso-8859-1?Q?gm/ET9sOOFNLJJOTAVYAcRQXpzr5uHps7O3wHPeELfs+lruDZ6z5WucEEt?=
 =?iso-8859-1?Q?R+vE0nvzGrv803brK6wL5fDVSqHO91G08cKUmH2mSpbMecKJaeFMAoikC4?=
 =?iso-8859-1?Q?UCA4zLqK6zhin9ovFEYVSudnwPtHmIoy6Dd1jitPI9Kqewh3aLNP5YEP1z?=
 =?iso-8859-1?Q?ocfzKExbvQCDblWGNzmf6B8YCfUCP5gkhMcAglv9We2UqCiOQOgt7Ym34E?=
 =?iso-8859-1?Q?o/dcNC2X9jd+lK7PAU9MZYDKdexs/sZ1RN4lW3n66jpU/Tq5UjW6A62DnA?=
 =?iso-8859-1?Q?rrhH1xjbKTf72ZNAT5WUb4YgClG1nnH3JyakvVNnK06c9W60/isnh+lcyb?=
 =?iso-8859-1?Q?BDD7tSEDcgNHj4pnUFSMM4xKccRYmsKoI+y8XODDvCR0qWhxjpQYGXrF5O?=
 =?iso-8859-1?Q?2vlyQkR3jhneiJQXf8mOViD0pHnkBNqyC1Forwmq9FthybQM7/ZsBHKlCN?=
 =?iso-8859-1?Q?VLGASvdd87duEbUEGLiFNvyfoTtdbr2iTRgZVYn6QF3t/Nm+jWI+kBVy6J?=
 =?iso-8859-1?Q?GXVoZbvjdPIUgh1/z5gxA2zAVu5E/2SnD0rvBFAWMAQ9VcBxJzd+JEz3vS?=
 =?iso-8859-1?Q?ojmZQaUbIRSYYw8JvNh2YaiTN1PvuSZGm1upEQ7NKgRHqXwU1DFlrOO+2c?=
 =?iso-8859-1?Q?AG+w2OYqRspHKx/7RIALhwdqwvzccwMgDejt3ZCsdC1P++UJuHe9ycrzw+?=
 =?iso-8859-1?Q?W2PqtHthmHC9v3MGy6+v/zz4uew5NQBz/XWY5C7S9dvAuGSbCkJMUQAkgd?=
 =?iso-8859-1?Q?vZ5uhgYTsixy7mZa7/JzerkRWVw9CleLYBfTuwjeBFzp7v10T1qtgOUpU9?=
 =?iso-8859-1?Q?+okl4H5qbfdtiQt0/L+e6p+P7+X00X3WikGN0gcTSScPR3QQO8H+ErO3dY?=
 =?iso-8859-1?Q?Ufyj/pxC6AaGD2iuCvL3U7ix8aatJaIfIN9JTZfRkilGyhSqpIm7LDXxTC?=
 =?iso-8859-1?Q?xHzk+Av/KhPEagJjhdeYfEfJG+uQQtyhTxl8Ds8Q2iOxbqYrSoNwhKokJ8?=
 =?iso-8859-1?Q?uiRu8D0qJEC91QgBtbSROTJTFTNqjpYTmITRFa4km1fFb1tzbBUNv/OSUN?=
 =?iso-8859-1?Q?parpAss/ieE13jGo0Rsw7LqWHDovQknhC25M0mWh9WzXBFSnoFWRoThv2V?=
 =?iso-8859-1?Q?GTHBD1n2A+orktZiAEHZYBQATRhMgpOcp0nrrVGiRu2MebTW3k84fv8CHU?=
 =?iso-8859-1?Q?bV1Tf0DlnUQOcZP4RvngwdQFA1F+aUuTPrM5xubGek89dDBfRwmtgvUm1d?=
 =?iso-8859-1?Q?dSbOujZWGwuVgYUDYPpeQFedRNLH8A3dVFNt9+yUGuGkq1VUGYMaZCaNzP?=
 =?iso-8859-1?Q?Rriv/8r8rZj+Rssx8vCJ711nPOpux3cY5zKKvsrPQdQCtpUeoFldLbP9Vj?=
 =?iso-8859-1?Q?yQ01oYAsvKzWfhy/jfs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62befd3b-085b-4d20-1540-08dad849625c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 11:51:32.0448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9l1JS97UG9+iLrcSHdL6BAAg5akoGJK2krVsxYw6DCb51YHAh+8UbUmX7GyEXrOE6EHJ38IiSkiZh6YGmticW9DXzCBzeDAtyRPVhRocjcaUS7daZqyzrmhzzlrafmT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5231
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Thursday, December 1, 2022 3:17 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Subject: Re: [PATCH v6 tty-next 3/4] serial: 8250_pci1xxxx: Add RS485
> support to quad-uart driver
>=20
> On Thu, 1 Dec 2022, Kumaravel Thiagarajan wrote:
>=20
> > pci1xxxx uart supports RS485 mode of operation in the hardware with
> > auto-direction control with configurable delay for releasing RTS after
> > the transmission. This patch adds support for the RS485 mode.
> >
> >
> > +static int pci1xxxx_rs485_config(struct uart_port *port,
> > +                              struct ktermios *termios,
> > +                              struct serial_rs485 *rs485) {
> > +     u32 clock_div =3D readl(port->membase +
> > +UART_BAUD_CLK_DIVISOR_REG);
>=20
> Maybe move this into the block where it's needed?
>=20
> > +     u64 delay_in_baud_periods;
> > +     u32 baud_period_in_ns;
> > +     u32 data =3D 0;
>=20
> data seems a bit too generic name for a variable? At minimum I'd suggest
> using cfg or mode_cfg (I couldn't guess where ADCL comes from, perhaps it
> has some component which would make the variable name better).

Hi Ilpo,

We just noticed after submitting v7 that this email of yours got forwarded =
to spam folder by our IT infrastructure automatically and we missed it.
We will take care of this in v8.

Thank You.

Regards,
Kumar
