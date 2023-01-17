Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958CE66D71D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbjAQHot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjAQHop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:44:45 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2066.outbound.protection.outlook.com [40.107.241.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C45E23DA9;
        Mon, 16 Jan 2023 23:44:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ud2cUq1NYh2Pazlu6OX1vQxPtbM5ghwVpfWa/MCyz36futMzxPX1ZRGP5ggF83+MatAcMNGl80r1ghVgtu1OxV59kTo4zI0PorIYoRi5bQ0vtzyqpMH1+xOGpYSYgZ1wQ71zBH3VlG7EfheVSj8E68scdBAUGPaOSW6MjjUp9mp+F6aHyFN0z+knhE8mJFj5TmlNhxPRDx6fA41CRFk1ebn3uSrkE97TrNNkwbtp5U3AGmyi9kIEZVsElp6e7SYa5wZtEfa13+d1+TEJaog6aBGCK8F1wawnqqtH0gKcWPJsnphHNc8p2I9eV4YbCa5dotUYpNio5AnQGqxJhAcrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipvaPsAm4l7U/nMKdEE3PdFAxvAKqAqn5VOS2Uc6mS4=;
 b=H6/6LaIsYjiWUnJ//sRIQ2aE5DFh1+Jr7TQt7Z3iAweQfGMTxxZ8UvVzha6wVQk6+8zdyZfezTXc1EqYkmKlAu/pVZX1NTYCOSBaBm9WS5fWzDO/5CL9+9uttUq2hivpV3KYIWBXV41VssUzniMfkOcM3YthT9z49lzkqKV0NLAH3W9HIBZ4uavGZkkBckWgW/P94j0e4qCzgG1/ZdDrhotA/ojud5b5yKBY5tCk7cufqiOFYc+6Li44Z0v82oFy/JdB0HoygrN//H5U6QIVXbpvLU/ba0ZRCPGxBEQque0fnYjtm6JgxL6tgz9JUGctzOiV6ZYjbQRKEV6euI5E8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipvaPsAm4l7U/nMKdEE3PdFAxvAKqAqn5VOS2Uc6mS4=;
 b=RlU2W+BswH/zua2jAe+jaNUlHa0K6mt8BDbR3BLSvlEeisnkqcirFiIaYqRDGsszKopz0F3bVKjMK/wBTqlKve4YFTGOBoPjUHrVNVzxJQUf/peu8EJRUQuUbaCvhypRg8ovuLemzFgvA6DKpo+fNJlawHSCIbu8FVLM9+nBXWBrkvaR+guWX9Ed57oAVS1WIqX7WPWH0UAIJly/E1tuPWtzoazB2mBOj1bSwPzQMOAjd1NMEvwYThGI4EjWrAbFQoMXCOGW+tIe2aZJfcAX9mS+KYChtPNYyJw1G6br5gdxxLnR/juAmYPKpM/0u7fFdgA0wVQYsqRM3ddqYKhtVg==
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB7324.eurprd08.prod.outlook.com (2603:10a6:20b:443::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 07:44:41 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee%5]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 07:44:41 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Eran Matityahu <eran.m@variscite.com>,
        Nate Drude <Nate.D@variscite.com>,
        Francesco Ferraro <francesco.f@variscite.com>,
        "pierluigi.passaro@gmail.com" <pierluigi.passaro@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] gpiolib: fix linker errors when GPIOLIB is disabled
Thread-Topic: [PATCH] gpiolib: fix linker errors when GPIOLIB is disabled
Thread-Index: AQHZKbP8HePARHu89kiREi8q9tdvPK6iJR4AgAALmmk=
Date:   Tue, 17 Jan 2023 07:44:41 +0000
Message-ID: <AM6PR08MB4376F0179AA62C60AA30280BFFC69@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20230116140811.27201-1-pierluigi.p@variscite.com>
 <2403894.jE0xQCEvom@steina-w>
In-Reply-To: <2403894.jE0xQCEvom@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR08MB4376:EE_|AS8PR08MB7324:EE_
x-ms-office365-filtering-correlation-id: e8f7dcf1-cba5-4557-7fa2-08daf85eb1a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8a7o5v3fgHoU/4O5S8TBP2tojTBTCO4QCwF5f9ingCP3+N3ZtDG3JlT+Plm+ECoK0bZ8Jh92gF5CWVDxb4iPWTFVLSRXhEq7Qqqix5lOqcoXx4xLaYqhoXEEeruKIDgh6YZ94wLNSDHM2Zu5UmgVgBKAzLjNX8IWOTJp27179CKV2Ov1o2l0EAG8uNl2lM73T8+cfjDpOlw9UtLbMBq6wFYHehLT45yuNBhuLJjGV4SfBDLIUbRp+NAaanwsb09HRK8Yq6LoBEAtaXmI7/NXyNzT+KdrSZFf/2iDGFbdEWQwDTIKYJap9t7xo5E5OpkiAFC4RqhC9SMzORDgSlsDCIcEoLGaK74yIP4m4uiqNHBeSLbsVwYxNJTVQ+eRMgr/qPaDtp0aPMmiK5e/86XpRQL8dRf8axkzSuuIscaLaU5mb368/6f1o6aJ3Yp53VJrD833TlEUkMXJo/shmCDbEtvQpQnpTnEET01bcqwUwe6DcySry5oqn7D9PonZP6KtmMHuTYlthCPTlWZq35dwh4/YY0fW7IogK9AV18kwgojbAdc6fE5h7cWlhwTCeuVA3PkSVhZszghvBPHb4TGz6d+perUH8u0Zf0VuqNoq3zalwM/LRS1Y/Aqt5n1suHoTe0OHb/ehkslsZh6ATGc0kuZRVEXB6F8DbbKl03XvnY/CdpEIF6E3ueeRq7YbyCGtXuqEQNse/zKf51Ub2qOweQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39840400004)(396003)(366004)(376002)(451199015)(55016003)(33656002)(4326008)(66556008)(66446008)(5660300002)(76116006)(66476007)(91956017)(41300700001)(8676002)(64756008)(8936002)(186003)(9686003)(478600001)(83380400001)(26005)(6506007)(52536014)(53546011)(66946007)(54906003)(110136005)(7696005)(71200400001)(316002)(38070700005)(86362001)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rUdVmkyyKd4u2H77O/vcnLK/JuVRwqE7KwftBjtEjWPbIaYR/McB7yzNJu?=
 =?iso-8859-1?Q?QY5ysFcK/P5CcGbRKGkNTuv92VoH9FddTtbW8V2AM4FEsbiUJdoe5MgbCL?=
 =?iso-8859-1?Q?inQVTJau3NiIt/TbTjIt04iqM02u/UlHM+STj9dgfE7Gp8j19Tu5cPJe2P?=
 =?iso-8859-1?Q?DHjjdrQuM30HzHh0j/bou4UHHWlR1Cx+C4p30zI1JbRCYFuOaw9sY7254w?=
 =?iso-8859-1?Q?nR49jyKrVQ4jz3blry+4PsJ3QKRDkgfUBgPYOWZOB+WFdV17yW1M5uvHB6?=
 =?iso-8859-1?Q?YikvrhwiNFYAz+rRW+nVg0al+liy52UTtrQBjT/jwp0NzRT0k1x5dR73rP?=
 =?iso-8859-1?Q?94tLcAkj+w3Mi2IfKCNp2J0RHXDbFtwe8CLXz66recTynVijKaUzQRsLvX?=
 =?iso-8859-1?Q?PZv7J+t693h9VCW2gkzBFfzbWcVRkIPg95NbzPpn5pM3RcRQOBA2s0jjut?=
 =?iso-8859-1?Q?5W+dM18S51JhB5Jwc/h7Zb/xdo5WQRYggVY+vapXNJ5aap/O9I5SeQd/88?=
 =?iso-8859-1?Q?Hkd3gjro8aEyg3UA+ZOSAGOIJEfb+qxynLiEQrTezsbHVJHbw5qNuV4V+9?=
 =?iso-8859-1?Q?eIDRPTd8I3FGW0r5mkbdaz/KaUpHWK131AbFEIReFsBUCGrlCC6JRNrvwt?=
 =?iso-8859-1?Q?+TYF0jcEnAhkqHl5rSjQqxblb0GEbRmcMAT+qmqZ/hbEtA35Xa4n9pijfj?=
 =?iso-8859-1?Q?Qn+aZ55vMssa674M0puBG3Fj5fpUP+PWy4V6WjGzXo4+YTErIr6NDuX3S9?=
 =?iso-8859-1?Q?06yan8MWyAMDCLHOAYB5oxlNITkj0V4SvGflbYmfa+Rln4jlJyOjkBpbQM?=
 =?iso-8859-1?Q?xPse0d94/F548QtaTrDc0eOVo8mKj1cC41yz3mFVgtvUnTDzcxfeSXr4ma?=
 =?iso-8859-1?Q?oJmLX6dy+Yc8ijyFPR5jkvhPs+igRZhhTqyOBbFq26HkAhUHB68nOaDGH+?=
 =?iso-8859-1?Q?L2hlwORl6+yYhRkMp/w737pmYUIANuapUSGxbGxuw5bWLOdkr5P3rC+cYs?=
 =?iso-8859-1?Q?IWRTBqsI2/lHTWpa1f1uqjcVkJTWeHwSbrkVttgLb7bVgJr+hsB96dVPpb?=
 =?iso-8859-1?Q?7OiPt3XiIG78jsDUwJ313CjfcvUnq0plcCxqVSxEUIds01ZfXy0S4NDkn4?=
 =?iso-8859-1?Q?pDv/055NjB+wAeydGHL9Rt7UggEXqOnm6xypgMTIDFTr8iEksWRxGHDD/r?=
 =?iso-8859-1?Q?YQnlm/GqdKuoRN9Vv4XS+NFjCrUQ8mdlprUqDg9TBik2KhBuuDWKZ76VPB?=
 =?iso-8859-1?Q?0wVcFqcoNr/w4pyeOrKxm9h15B3fYir3sQYGgGQgJpgb3e0i9V0mtdIM0b?=
 =?iso-8859-1?Q?6/WEZpPzfyItikX9E9UKdIa/WKA+FUbGSCVI3G6ntLfIA8j60Lr94P6rec?=
 =?iso-8859-1?Q?N2hd99VvV7xmVjHX4rCZ2YSpmnNLkDDDrhoq+x8dQ2Vv7H1erXnu+kzH78?=
 =?iso-8859-1?Q?MlPWrTXFDVqTVJG1hDkwCgtUC2PhVTWf4rhQRnA9OZ5nTyZ7WkHREaIdn+?=
 =?iso-8859-1?Q?wCjsuwwdyRk1ZEPYeM5E5+kJ0nVx3NSwD3pOUzZu0K7BdT1ipIgHn7z2mC?=
 =?iso-8859-1?Q?kgQDqhebH9FqUeMytn8HDOlRDZDwpzc2w2kL2fcel9lN0h0qcPlDr876xK?=
 =?iso-8859-1?Q?eo6asDGKVDScocYfoU2j1cXcvcdm5ns/23?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f7dcf1-cba5-4557-7fa2-08daf85eb1a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 07:44:41.7036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sxb/BqNifi8c8+GYPPwX5Z5LYXTd9RmDDPc+/1uFGdvv1zk1BHmBKWSgWYV4tinNC336r5fnYu9SwWekFq+3sJCBAmFe6kFSPIIozgALFqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7324
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 7:23 AM Alexander Stein <alexander.stein@ew.tq-grou=
p.com> wrote:=0A=
> Hi,=0A=
>=0A=
> Am Montag, 16. Januar 2023, 15:08:11 CET schrieb Pierluigi Passaro:=0A=
> > Both the functions gpiochip_request_own_desc and=0A=
> > gpiochip_free_own_desc are exported from=0A=
> > =A0 =A0 drivers/gpio/gpiolib.c=0A=
> > but this file is compiled only when CONFIG_GPIOLIB is enabled.=0A=
> > Move the protototypes under "#ifdef CONFIG_GPIOLIB" and provide=0A=
> > reasonable definitions in the "#else" branch.=0A=
> >=0A=
> > Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>=0A=
> > Reported-by: kernel test robot <lkp@intel.com>=0A=
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
 =A0 =A0 =A0 unsigned int hwnum,=0A=
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 const char *label,=0A=
> > @@ -765,8 +767,6 @@ struct gpio_desc *gpiochip_request_own_desc(struct=
=0A=
> > gpio_chip *gc, enum gpiod_flags dflags);=0A=
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
desc=0A=
> > *desc);=0A=
> >=0A=
> > =A0#else /* CONFIG_GPIOLIB */=0A=
> >=0A=
> > +static inline struct gpio_desc *gpiochip_request_own_desc(struct gpio_=
chip=0A=
> > *gc, + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0unsigned int hwnum,=0A=
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 const char *label,=0A=
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 enum gpio_lookup_flags=0A=
> lflags,=0A=
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 enum gpiod_flags dflags)=0A=
> > +{=0A=
> > + =A0 =A0 /* GPIO can never have been requested */=0A=
> > + =A0 =A0 WARN_ON(1);=0A=
>=0A=
> This will raise the warning on each invocation. How about using=0A=
> WARN_ON_ONCE(1), or even WARN_ONCE("Kernel compiled without CONFIG_GPIOLI=
B=0A=
> support")?=0A=
>=0A=
No problem on my side, but this would create a misalignment with all other=
=0A=
GPIOLIB "dummy" calls.=0A=
Personally I would prefer WARN_ONCE("Kernel compiled without CONFIG_GPIOLIB=
=0A=
support").=0A=
Please confirm your preferences and I'll provide a patch v2.=0A=
Thanks=0A=
>=0A=
> > + =A0 =A0 return ERR_PTR(-ENODEV);=0A=
> > +}=0A=
> > +=0A=
> > +static inline void gpiochip_free_own_desc(struct gpio_desc *desc)=0A=
> > +{=0A=
> > + =A0 =A0 WARN_ON(1);=0A=
>=0A=
> Same as above.=0A=
>=0A=
> Best regards,=0A=
> Alexander=0A=
>=0A=
> > +}=0A=
> > +=0A=
> > =A0static inline struct gpio_chip *gpiod_to_chip(const struct gpio_desc=
 *desc)=0A=
> > {=0A=
> > =A0 =A0 =A0 /* GPIO can never have been requested */=
