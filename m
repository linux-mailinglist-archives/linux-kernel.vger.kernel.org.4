Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CF166DAC4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbjAQKSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbjAQKRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:17:54 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F749CC29;
        Tue, 17 Jan 2023 02:17:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g974cFIqb2k/JilqT5hOMSNsSk1I+CxQVtlm2tXP/ajgyxL7CeF+P/4nNn93cwI/iRiVqkwZQcFA9veOswJvJOqV72lsse4uZv1NyokF1IQEO405PYlrrjiarCNnSw0QOL0Bw1HqhIjPMzGjKiK3ZOr4aHIB6K+p+49U5eYwZsZdNs8LAUlGvnQuJu3EkrMr2DcIj3ivco//TbbT0iW7u29EDsEQMRq6xgq779t+MP+tLSOlrB1t7bUv/oz7Ldu+aP14OBzwduh1KRhLVsrExBsQqiFEX71BIQmGH07ChDVhQrqW1ri0ln1B/w46CIlp0WJeHGJFIvGJwEGeCf0XNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ja4cRJqbJnhWJf+gaKgwWjSxwJtKX05z3tBOOCSN5CE=;
 b=LMn3XZwSXBlwygftGN9h/RZKFrqsceuRMbBoDGvhAIZK8y1zy3utKCD6Lkv5xAbV6s8DEYyudMNA2dphJS/BemLaKHqy7fTi5c83uWcGABV16nfCxQr1sn/pI8XYRfgDXBbnqFrZjFV8bqFBcC0ewDMTvCt9nFnnFy1pLMshkRxRQGVvZFAzLMSaTOa99o1e3+7t6xKTSM1mHs0T3i3c+eEeSgugqku8bidQLm+D3grPELZL4yhru92/3VGe0ykSsdHWVib5oImQPWg58YefSjMLcE/xwJS6jZlKNGbSc2LnOlbbBcF+CoyST8BdXOfHA2egQWEitnYSDbpwUXKd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja4cRJqbJnhWJf+gaKgwWjSxwJtKX05z3tBOOCSN5CE=;
 b=duD2VW/Qym7Y2F/8gMfDedhrwne9PhgHibyA9d5S6CjhRHbb5USI2S8/an9eMCLMbB2FFm0lMNTpWjHztKP4aICI2WcnTyZ+oGMhMgosF5FoL7wgI4Y4QjOoDgLnlaJf8mHbdOU/pp5h8bBhcOuXD4knvmNOuXy7EE8UF7aYlYH2yTLrWv+YeBrJSesCfhKs4/DEu4nXMgBxh7CS6xnuCFEb3CKNO5FIPxbV/W3v+Gd4I4os9luE9w0NTxfKq9k4WWebbhHW72/t0IB6BypIGirWShvx8b2drMfDu6J2ptkaKQ5QhXKriuPPOPPOUaUvcoQK2JgxmvgdCsiyBSMZRQ==
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by DB9PR08MB7674.eurprd08.prod.outlook.com (2603:10a6:10:37d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Tue, 17 Jan
 2023 10:17:50 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee%5]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 10:17:50 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eran Matityahu <eran.m@variscite.com>,
        Nate Drude <Nate.D@variscite.com>,
        Francesco Ferraro <francesco.f@variscite.com>,
        "pierluigi.passaro@gmail.com" <pierluigi.passaro@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] gpiolib: fix linker errors when GPIOLIB is disabled
Thread-Topic: [PATCH] gpiolib: fix linker errors when GPIOLIB is disabled
Thread-Index: AQHZKbP8HePARHu89kiREi8q9tdvPK6iWtyAgAALPlM=
Date:   Tue, 17 Jan 2023 10:17:49 +0000
Message-ID: <AM6PR08MB437640AB4B959DD356162F2BFFC69@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20230116140811.27201-1-pierluigi.p@variscite.com>
 <CAMRc=MfeQ_92Vb6inv-1_h=kc1d2as6LLPqJHHtbNk1pK1xRuA@mail.gmail.com>
In-Reply-To: <CAMRc=MfeQ_92Vb6inv-1_h=kc1d2as6LLPqJHHtbNk1pK1xRuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR08MB4376:EE_|DB9PR08MB7674:EE_
x-ms-office365-filtering-correlation-id: 44a3a380-0a5c-4d1a-a77e-08daf8741641
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZqeoFygPvM8Lwp+R7SdfvDt4/277/vT7FQxRhgClzG+jS1snfg2D+ECbPtxQJe1Krgv+2u7bO2jdUOVaxr+Vw/GmW65I6HakTa6DhB6Y2iU+l+Hed2ybupjsv9YU0mb3tGnh3PIV3rStH9vXdZJIB97mhyJoCrclGQ+R/uvuHOvdryM4wsmSCAk8H0ZY0FCXdELz5BJYtGuNv7Me2r8M+iswx7lrdapauv4bK7bYQcdEe7SQe+JHuj04CkCa+xzxdtRyzvPs068ji7jJTz4AW7qEKu1Wq0s7YfylczQ5wtFY4uaz9CXiFFmXNcu8fyd7+d0h08iaM9us2EVBqHMWhBKTZHz1x45cuMADYyYfKWS3mGE9mgVvuaw/P2ZetsUozbmf3LPnIPMFFt6HH59RBwrFYbv9nsoLtBMQk81efuknw56Afz4V5WwU4MBk7Q6wefOa6pluO8+lsotWozF5GCQeV5sdcD8fux9yT90b605cFgGHkaBulF8w5ZsQdouvqVYWrVpYHZBiUrYkcpTbBNn0Bky6sI+hBtfBlsaluGUVlITn8XhMMVTJHOmhLzkUlTgG0VldTWz6wGFlorLQM6OS+T7nd4/8uGKtUh9TUz2YnUleRQpjhl2y3EX8Q/3g0EfPLjk6dilCDVS7kgg1k0jvPtvawqo81v3TVYa7FHobfCFX+V8nYQnNvYcy8rk/Z6UobW+lbyoJ/1QzkrXSTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39840400004)(346002)(376002)(366004)(451199015)(2906002)(8676002)(64756008)(66446008)(66946007)(76116006)(4326008)(66556008)(5660300002)(41300700001)(83380400001)(33656002)(66476007)(6916009)(52536014)(8936002)(316002)(54906003)(26005)(6506007)(186003)(53546011)(7696005)(71200400001)(55016003)(91956017)(9686003)(478600001)(38100700002)(122000001)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hfutLM+/s158oBv7xNc14ct3t6oeNnYEMY8kM42xhTBlSYbqfEPn2fnWfM?=
 =?iso-8859-1?Q?QSeJDlnRlCyVTaTK7rjGQmlPnTVdjpOkW1mbEpmpZoyU0X7FMd910pJgyj?=
 =?iso-8859-1?Q?HkjgadUn6Ca46QQCfPaVGCoV2hL8flNHX5nk0sM0b7YRk5rCn3zv8i/yCV?=
 =?iso-8859-1?Q?gtE4xOMCYlCZxQiNZNbn2kMByiUxjUdB2aCI1iKCxq3PmzqVfdEtz9Rm76?=
 =?iso-8859-1?Q?i9058j3W0rr/4qXBIxvCUYFhVCBDJ5RGIsuYzxgLhq+aCYd5s0pQI2YraL?=
 =?iso-8859-1?Q?sSwP9UAV4qOPXUjNKEEttk+krPLPjD9cKpLtfwq5zKuX8NaSceZxMSGTYk?=
 =?iso-8859-1?Q?WjpvJJI2h8JWILdqSuZl2BJ0Wm+4NpblJgXTzxcwJT3fR8dVeaFLEH/vw0?=
 =?iso-8859-1?Q?l0PrWmVCVcV0RM/V3OH1VsTxHr3vkLUTi1BrOZlze/nangTJy8Qkoc953N?=
 =?iso-8859-1?Q?cDU6fUJvTeF6LXDmqE3sg3OBxOF5RoAYLqTWRN/5VaTKo3FEUPp0Ic0DMH?=
 =?iso-8859-1?Q?7y/op9mBiqMKjM5UKDuvAbtmBa3jEKK0Hy2sK/3qqTco8FB5J2bGg92t9a?=
 =?iso-8859-1?Q?CEa0xvChJgA4kkOk6aj2NY+nmvTr4Aa0EdtYJXYTIzHjWVkf7dU2Y81tJE?=
 =?iso-8859-1?Q?EC2womQe6r25Mj60hYVfLdn7emH4nJyEYmKHfSR45RIiwkgGFnmIvzsYT+?=
 =?iso-8859-1?Q?eL8iy4EJnVKqeytu51TqlYLme1mYwDrz0zMBGZ9IXVJNNxU1CMu2dSCMsr?=
 =?iso-8859-1?Q?zT1zuEuvBo9jiachbj/yD/k+owG1nUHysJIGcXIJk43kA0ntgSB1k1/AfI?=
 =?iso-8859-1?Q?MWmE/o3eqHt/I4+H3/UiK+qCLY1gUOWCs++L/91PW3p+SSETQKL4zhXbMj?=
 =?iso-8859-1?Q?B95stCPeAww3tPCSvNqi+WSjUowsmzuxQOBJZ3tRd2hVr0i1mePJVKC0el?=
 =?iso-8859-1?Q?+g2qPkN2ppd+HfEukLHbJzLF0JfGN2bokCRwJOMxDR4udLtshQhx1e9m4h?=
 =?iso-8859-1?Q?SXSzmxPf06zs5v66X6DN3INJDj5iLgkjtucr6RLBMmQH/khJHw+xabjLRi?=
 =?iso-8859-1?Q?foN0ndE2YbSEaCrMRosxZsbt/hCfNYb7bOVSC/pRvbyvtJT0vdoX89zNb5?=
 =?iso-8859-1?Q?3cC26H0e5sn63Ne/u/qK68UL7c0XFGzIbFFm+8JSjr8+sDr4QmMqvJ9zyd?=
 =?iso-8859-1?Q?3KJEs8RezCwVtg7RJ7WPiVw3pCi4Wdp1U7VWean5oqk7gIXqnfUucUi8xi?=
 =?iso-8859-1?Q?5z9DB3HEj5BJVU1XIarrhxAoKNHnIZ1QkMv0JFLRQw5DzhnlNYPLzuOJWl?=
 =?iso-8859-1?Q?C1kYb8GULi+b701bA3iOFOMrrhLnjPDVzIaZ/OdNHXgti2xacIzRWVFtkJ?=
 =?iso-8859-1?Q?IvFrwbu1tWzTjbZo3rkDuFBIFSt4xWtxKG3/p1shqPTlUFSlnjjvG9NB9o?=
 =?iso-8859-1?Q?9R6nbaVdExaQe7fdCtI3Tq26IXJgVpXkSzwl0byE7B9ZwjHssYrxZVVTKg?=
 =?iso-8859-1?Q?kumQ/bJd4d/gHhuHGhB+yLSH0GYrsZn/ZsLWPXH6UG3Kr61ivUh6FCihXC?=
 =?iso-8859-1?Q?VU0v1ZsbGyPfVUMqcDNb7yPhLUkm+jH0246rmiwBa5yisQxNHCVTh9bzD7?=
 =?iso-8859-1?Q?nYrKDZfBPAlIcLOmZPO/AzbYX+FyN+Fju5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a3a380-0a5c-4d1a-a77e-08daf8741641
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 10:17:49.9486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7R+er70iZtEuy91IRRMYHREBkav16odhK83AMAyC4ub/Sjmz9X1ZhqKjsRCyYJkAr/gPcrhbl1YxTX1F579EaSiTCXO3SEClB6Cd6kScCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7674
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:36 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:=
=0A=
> On Mon, Jan 16, 2023 at 3:08 PM Pierluigi Passaro=0A=
> <pierluigi.p@variscite.com> wrote:=0A=
> >=0A=
> > Both the functions gpiochip_request_own_desc and=0A=
> > gpiochip_free_own_desc are exported from=0A=
> > =A0 =A0 drivers/gpio/gpiolib.c=0A=
> > but this file is compiled only when CONFIG_GPIOLIB is enabled.=0A=
> > Move the protototypes under "#ifdef CONFIG_GPIOLIB" and provide=0A=
> > reasonable definitions in the "#else" branch.=0A=
> >=0A=
> > Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>=0A=
> > Reported-by: kernel test robot <lkp@intel.com>=0A=
>=0A=
> Please add a Fixes tag.=0A=
>=0A=
I beg your pardon for the question: how can I "add a Fixes tag" ?=0A=
Can you point me to any reference documentation / instructions ?=0A=
Thanks=0A=
>=0A=
> Bart=0A=
>=0A=
> > ---=0A=
> > =A0include/linux/gpio/driver.h | 20 ++++++++++++++++++--=0A=
> > =A01 file changed, 18 insertions(+), 2 deletions(-)=0A=
> >=0A=
> > diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h=
=0A=
> > index 44783fc16125..ed77c6fc0beb 100644=0A=
> > --- a/include/linux/gpio/driver.h=0A=
> > +++ b/include/linux/gpio/driver.h=0A=
> > @@ -758,6 +758,8 @@ gpiochip_remove_pin_ranges(struct gpio_chip *gc)=0A=
> >=0A=
> > =A0#endif /* CONFIG_PINCTRL */=0A=
> >=0A=
> > +#ifdef CONFIG_GPIOLIB=0A=
> > +=0A=
> > =A0struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,=0A=
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 unsigned int hwnum,=0A=
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 const char *label,=0A=
> > @@ -765,8 +767,6 @@ struct gpio_desc *gpiochip_request_own_desc(struct =
gpio_chip *gc,=0A=
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 enum gpiod_flags dflags);=0A=
> > =A0void gpiochip_free_own_desc(struct gpio_desc *desc);=0A=
> >=0A=
> > -#ifdef CONFIG_GPIOLIB=0A=
> > -=0A=
> > =A0/* lock/unlock as IRQ */=0A=
> > =A0int gpiochip_lock_as_irq(struct gpio_chip *gc, unsigned int offset);=
=0A=
> > =A0void gpiochip_unlock_as_irq(struct gpio_chip *gc, unsigned int offse=
t);=0A=
> > @@ -776,6 +776,22 @@ struct gpio_chip *gpiod_to_chip(const struct gpio_=
desc *desc);=0A=
> >=0A=
> > =A0#else /* CONFIG_GPIOLIB */=0A=
> >=0A=
> > +static inline struct gpio_desc *gpiochip_request_own_desc(struct gpio_=
chip *gc,=0A=
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 unsigned int hwnum,=0A=
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 const char *label,=0A=
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 enum gpio_lookup_flags lflags,=0A=
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 enum gpiod_flags dflags)=0A=
> > +{=0A=
> > + =A0 =A0 =A0 /* GPIO can never have been requested */=0A=
> > + =A0 =A0 =A0 WARN_ON(1);=0A=
> > + =A0 =A0 =A0 return ERR_PTR(-ENODEV);=0A=
> > +}=0A=
> > +=0A=
> > +static inline void gpiochip_free_own_desc(struct gpio_desc *desc)=0A=
> > +{=0A=
> > + =A0 =A0 =A0 WARN_ON(1);=0A=
> > +}=0A=
> > +=0A=
> > =A0static inline struct gpio_chip *gpiod_to_chip(const struct gpio_desc=
 *desc)=0A=
> > =A0{=0A=
> > =A0 =A0 =A0 =A0 /* GPIO can never have been requested */=0A=
> > --=0A=
> > 2.37.2=0A=
> >=
