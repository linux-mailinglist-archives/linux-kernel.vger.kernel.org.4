Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F21678388
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjAWRrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAWRrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:47:03 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065CA2F786;
        Mon, 23 Jan 2023 09:47:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGhTD3TPCyDRQv26S1BSmfe/+pZ9w6GB+XYr+e82sYegK75nCwdEwfE3l7Xi2UZzes9vvefWPDKQFFz3RMyHbDOPcvPg5KnI1G34y2Emselaoaop0nJR+FcmC/ULu/PLwpMKpIAMHhTOElUuKl2IjThWn4L8V/IJ0P4qmbg3t041YGPaQL6Z6PSdUiIl5m2q2J6shiHLqGXyxbUTKx/NQC82o5ysf08WbXI5Bv5o/CxOYDHbMbT76BnA4xFRak8G7xu1cOGxxd+b+e+U9VM39pQFueA+rnkWNrNAOtUX/p//Y/7bWv6l3i8/xQUseT9j7R36LV9lWwirgU2q9lTpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swxwK8URI9TBENWOWdCABfxS2cNTcXDyuj1xF3YlAHs=;
 b=iacLRmDBbjm8Mrf/LHVvYuqcJX0XaiKeoxgHNsJ8qg6sLen7TX5QDhyXU0BAYiOwB2PONeKMRbqWbBUy04DHGqcJMu51VkbLhfaeFC6xgAVA84KDxcT2yf9CHxcBh187Nb4jHDr/byXoCC0USBoFqCAb35Y1smZH53k4qw4tOJo8WdC7SkPoyuC4S7bV338w0fOTbqPR1z/JKHp1jQcJszOnGZIgZnCliyEGSTxaKELfSc3SMrfuKjPYKcmGxXs9SVSsavsBevrW2xIrl4jABwQwQMHPzttQJKvooBnMlwyt7sK/0EU4SgPTtjou8SVplH5pEIjTcZp5G+i9NWILtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swxwK8URI9TBENWOWdCABfxS2cNTcXDyuj1xF3YlAHs=;
 b=Mv7ZYCOLy9128MEr8a2/ZrZkkMV3SoP6FYaxvs5xMFpXQ5OJ1zWXxK9mCLOeRvlhtbDulx4Z6RlcQ5dh80U6R0LuDBu6sX763pIoKYW3UwVZBxjPdbINNdW/cTrobk11lduxXI3L/HszX4MDb23e8h81y8Dxd3scHi5kykh/0fA7te+C+5n5q8GW/WDuiEXi4Yq06HdnP376zPTFrceCEFGioG/shYF//+j75/HyLRJ3SDm8mqSzLkPgJh4MXjgTm3M/C5pnMeFUOB3rZXg0sYhzmZiNn+l8vkUNkAXASAJSZfUQzWHHU7/lwUzcoLwwuX2fv8liCAwbC0lTPaCA/A==
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB6229.eurprd08.prod.outlook.com (2603:10a6:20b:295::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 17:46:58 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee%5]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 17:46:58 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eran Matityahu <eran.m@variscite.com>,
        Nate Drude <Nate.D@variscite.com>,
        Francesco Ferraro <francesco.f@variscite.com>,
        "pierluigi.passaro@gmail.com" <pierluigi.passaro@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] gpiolib: fix linker errors when GPIOLIB is disabled
Thread-Topic: [PATCH v2] gpiolib: fix linker errors when GPIOLIB is disabled
Thread-Index: AQHZLS32afpvhqCZBUeCSggL2+QCU66sH2AAgAAOrgo=
Date:   Mon, 23 Jan 2023 17:46:58 +0000
Message-ID: <AM6PR08MB4376DF77E02FDB5F1E904BA8FFC89@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20230121001845.32592-1-pierluigi.p@variscite.com>
 <CAMRc=MfXDeV7gus97Ba4FeuaP4sKtF87DrV4gCbiBR+rGFY6XA@mail.gmail.com>
In-Reply-To: <CAMRc=MfXDeV7gus97Ba4FeuaP4sKtF87DrV4gCbiBR+rGFY6XA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR08MB4376:EE_|AS8PR08MB6229:EE_
x-ms-office365-filtering-correlation-id: f7e4aa7a-2934-4183-fa3b-08dafd69d366
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mgrIQRI5T734+0Hxk/ZS+beh/Td2C0YxSfo7DPxJoZCfhKkquuxGJjdbcbjpCC6VdofVXA6n/O3hX/O3146YRVcdv/QRR+fjvsQ3EzrKZR90AAa5/AcOzRhnJTsc592tt84O7OWxPcCxlSySVGNi+2TzVGZvzUAfjEZDeBsn2cdicI3utHqy22Gh5oG6SLCdhLoxpkVSg4DIlD/mYwpxTKZHX1vaknEuhVI0rxKJ3Ozkoroc0DFsFc7l1EwjCZICvQBY340DqkQ7G5le3fyC2IiFtxNZCumlK+m75/kDomap57/yUjXK1Q7tJEwiecHo/y71xM8VgapNiQ1N5xda/ZoEG+qh9gqt8hqYXoRh/03g5Ssz/lP/W7xZsx066zN5308sIFyR8yIf1wj434Zsy9tSymXj2gF/EZFtLGNSvdqE9NnVAYkGSce+zTCix/k3SgXY5AX2Eofko00SN4D0yw3xoeQlpBmMBFwyBxzDLGYeZWqk7MU0iV4XTlfBClI3LYNEjPjW/NtFZfgYp8n0QsfS242HqEvfd6OoZPwuqCfuRG+s+FZgPb0IqAqI7MoJr3XkPkMeFGZACA2lOQS0yb0R/cX6KjCcOzGSUYJu/f1pKqYY9NSJ91OH4oW94B7RQFCe/YW2ldhppFlAWzNKuuJpNXcG2rstdYcV9v36rmOEQ2zwidUQJriz6K8Ozcaero2/MRP7/WGVyATMxPEGZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(39840400004)(346002)(376002)(451199015)(91956017)(4326008)(8676002)(54906003)(6916009)(316002)(64756008)(66446008)(66556008)(66476007)(66946007)(2906002)(53546011)(41300700001)(8936002)(6506007)(5660300002)(83380400001)(55016003)(7696005)(33656002)(71200400001)(76116006)(9686003)(26005)(186003)(52536014)(122000001)(38070700005)(86362001)(38100700002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tO+vqXhHfqNfOckoblRBuFTy1HLereZJmoVb6xiW4MLZwtadq7+0s55Nu+?=
 =?iso-8859-1?Q?yqzbWrSxQN8Qiukx5F/2h4vn7MJ3+auLcvQs0EtTqnHeSgEoT9HOHYoSgL?=
 =?iso-8859-1?Q?cjs2060QqcjwyOta9wsyrAcDnS1WxrIRQNiB/xiA/NYh8yGVhbyYfm2oRP?=
 =?iso-8859-1?Q?hlYow8Q4DPFrTA8pwYyTrv/F1HB38pr7etTq88LlWMFjoHyzhfVzkAvbiw?=
 =?iso-8859-1?Q?sHne2gSIqjaK3ZljPAN0gsbKNpn885dxaePh94w5U42ja/26E6Ed3Xddlu?=
 =?iso-8859-1?Q?lvPaO5nSMWXwewg3H60ggYZVR+OGxwB1GcvSMT5vCZ5izFdyP7BtdMbnAK?=
 =?iso-8859-1?Q?nfo2PblDqUKaIwSaFUgjNWLelBZu7gEO3ZFmP8nyjO5nh14q5IH8MIwQv3?=
 =?iso-8859-1?Q?pr3eQHzTYGM4LTCc77p49PSADOUiEe+nR/AHKQ+AsmYe6WlWNGpGVAewsL?=
 =?iso-8859-1?Q?wja6PXiZAZ4N93su/xbFzQBNEK2nrij17+kARrOD6ozKOcI37de5dOuFQf?=
 =?iso-8859-1?Q?yntbhFSrOhmnCX1e7k2tijUMnX5zsOZ/SyD/O5fPLgeRl3Da35eCp7WLBD?=
 =?iso-8859-1?Q?pJmi1wIJ9vcypMLXfKzGJ4QY5rVSmFXGv1OhA3MUQndoHiKgHly14h/YeF?=
 =?iso-8859-1?Q?PpAK7fhiILXnHO/F9A0hjF18flNPjTrAKHrmYmgyw8yEpK7hD8LQ3E/U3g?=
 =?iso-8859-1?Q?YI7Qj6+hPD9FZobpXTu0oOofUfUlGX3bkZPJaFx84gAv1TXKAgv+jMB97X?=
 =?iso-8859-1?Q?NbRT8bgPOt59/MXdBu4mx3gCGdyf3iGUO7g8xflltI1I34YAwlSHJSZfXe?=
 =?iso-8859-1?Q?eOF8gyAOkOTZimLwte9OAFVe7TXzYjP218i/0MJ88VrHWBnKCG/1E3eY1G?=
 =?iso-8859-1?Q?4tvwJLVAKCV4WWi492x2mfmo3BpF3zuyGjlqYe0YI8pBM6V6YyTEhuTAl0?=
 =?iso-8859-1?Q?EtuVvJVCNwW8ezb6JxlDgDgWnsnFBkVjcejJXvpoAC+Hvn2DrmNkaEkv+b?=
 =?iso-8859-1?Q?MIUY3PMpEgtSO7zBt5Bosx0IGqZaIemvbFrqzIx4iDnPzQvbzQUQ9gX8Xe?=
 =?iso-8859-1?Q?rdk4YN0aUbe2covg53rrDHk4H3fdX517285lcxqrMZmTHzlludQNj1zdIe?=
 =?iso-8859-1?Q?vZLS4T86PWIMWo7M8CZYUZhqXqLC64f3dLUtigV77hggNC/FHUE9YQNpA9?=
 =?iso-8859-1?Q?W5uBdd551rG8w/qeLebncOi7lZ5hbajPBgS0zi7cvD0x8LyvxiI6WX/lMN?=
 =?iso-8859-1?Q?WLIB47+5QeL/dR66OIINP9KT2OGDunHMieJ/XL62dDgfvkWc1QCPSGz1ff?=
 =?iso-8859-1?Q?kG2jPxUz2D5tqIADkhUXMQcOOCZ/4+husMbQYgPQ0VlWHTbPc5yXY80Gzd?=
 =?iso-8859-1?Q?kWIE3mlQn13elDc8vegrnKR0rXX51NzMxDqUXPazilpG1BuhfoVn7ZM5u2?=
 =?iso-8859-1?Q?0N8azqUbbiBWzmZoWXxa7C0skBDFemH0NNUCOvijhDYyOC+k5g7S+K3J4r?=
 =?iso-8859-1?Q?DULC3RbdThAwzczjhsVUQmfGHrmA1akAdW341oYB7+ahmgoHQ4HENz3QhT?=
 =?iso-8859-1?Q?3NzboihLyNPQdGzi41+25rgPXzcQAAJNQrgelco9n/VoZMqc+ymaJ5x5Cf?=
 =?iso-8859-1?Q?nvswjmuKUwdi/mThj3ozPiqXWIGU88kJUS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e4aa7a-2934-4183-fa3b-08dafd69d366
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 17:46:58.6168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuT+g/N2R5Yq6e8IBy4gAs8FERMICc5PsxCo8NGAju+8jEfX/CvjMO3QOU7Cjy3eol0vRqttTeGiJVnKXbnvrYHqlA1CH7CWPcKYG0KmiXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6229
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 4:10 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:=
=0A=
> On Sat, Jan 21, 2023 at 1:19 AM Pierluigi Passaro=0A=
> <pierluigi.p@variscite.com> wrote:=0A=
> >=0A=
> > Both the functions gpiochip_request_own_desc and=0A=
> > gpiochip_free_own_desc are exported from=0A=
> > =A0 =A0 drivers/gpio/gpiolib.c=0A=
> > but this file is compiled only when CONFIG_GPIOLIB is enabled.=0A=
> > Move the protototypes under "#ifdef CONFIG_GPIOLIB" and provide=0A=
> > reasonable definitions in the "#else" branch.=0A=
> >=0A=
> > Fixes: 9091373ab7ea ("gpio: remove less important #ifdef around declara=
tions")=0A=
> > Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>=0A=
> > Reported-by: kernel test robot <lkp@intel.com>=0A=
> > ---=0A=
>=0A=
> Applied, thanks. In the future please list changes between patch=0A=
> versions when submitting new iterations.=0A=
>=0A=
> Bart=0A=
>=0A=
Thanks for the remark.=0A=
>=0A=
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
