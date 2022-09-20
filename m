Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C240E5BDCCF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiITGB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiITGBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:01:21 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2095.outbound.protection.outlook.com [40.107.114.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59C215731;
        Mon, 19 Sep 2022 23:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuBVCisNDC0kWPSXuBCie47AiDXEvfEnl+/z7yX/e+i+6oVzTvIsw0dlhnVrFce5f+DVdKuIUOh+ibtycDZz1xtKLfxK4PM5EPUWIrKPByqW2ik3u/Ge0vvqWwQC1U5SuTOktm7ZRK/V3ryLofTIZgTUUmfKZDMUqKBKPefw+FuCaRR3g9lHH4KhMewI1ZoaeYtbxSwB9L0SIWUaqr52CmrBB+yX/NpolWA7P3io/yOA7D+7sD9Npw1T1ykpMY40FPA+6zuWcMPiQlH9SPi7G012y88yFKeetgT4O+igBWbpeRv2bHzU8+P0MC6iKCSgZc0mgzOcrvlr3woYdrCA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH0oGbZ+RjlWbAR22Fw25N9IFt4VeOXb+xeG4aQuvWc=;
 b=CLz6Y+7xoV0al4o8BvgEi/7X5ISNTd5tFASJc5FhGYN+JjQqYEP6Lgmvc/v4dExRSsyymzGAmDRvomzwHsag3oKFeKCURHpEgxP97wcvN4Z+6+K2FZ8rNTFgqWgQ8mPbFyWMCi0G7xBrubk0iH/qgtbEwkA+GQr4TH98aUdsYAY0W7j+rL653N1iHUg8EUdKr7+hhksYVnUpmptnZS0h8CKyuR5RlQ2gkugVjrjKq+FhJ43N0TImixlQlMRsf6DW+KeNdXaKqZPTSZlGLDzHAHRfD6RvX8WvVOaOlqAbrhNbkON+YSKXXxkwI6ZI0s2sEw976TeJBD/M7fXs0boSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH0oGbZ+RjlWbAR22Fw25N9IFt4VeOXb+xeG4aQuvWc=;
 b=BgWkJD8smWkvSQdp8fcSCDmyoWHJXx7nMnMDhx1bSbWd+0m43zZgvTNC6w5WS4erIZ7BF71BPLzZmhiRnxA3lLzEprcTFiVb3TO0BdMBh33Mxzu1Rs21prCX4STvAwY0rsscUM33U6CirSShtSzsJahwyELXvb+9MsF6Z46qMYE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB6220.jpnprd01.prod.outlook.com (2603:1096:400:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Tue, 20 Sep
 2022 06:01:16 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 06:01:16 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>
Subject: RE: [PATCH] gpiolib: fix OOB access in quirk callbacks
Thread-Topic: [PATCH] gpiolib: fix OOB access in quirk callbacks
Thread-Index: AQHYzE0eCole2NyqQk+pDdYLxQQsuK3n02Ow
Date:   Tue, 20 Sep 2022 06:01:16 +0000
Message-ID: <OS0PR01MB59228A8B66C1EC28FCA9B8A9864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <960a9d86-7814-3b2f-d5a0-9bc2b316d12b@microchip.com>
 <1041bfe5-6515-feea-36d6-47f8f28938b6@samsung.com> (raw)
In-Reply-To: <1041bfe5-6515-feea-36d6-47f8f28938b6@samsung.com> (raw)
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB6220:EE_
x-ms-office365-filtering-correlation-id: bee06081-3d55-4b53-c6fa-08da9acd87ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ByUSa1iHZ+jl4DmO3+Zhl86LjhOstGCGcxAwqlIxcpxL77g7qlTmCOlWmjhC7nWfPuxMVRF2uw4enqt9pp8ghMc2SZ3eB6vH2Z2KSNVpn9nenFuRRS9L5ko5uagXE3LhbJ968V+7m1aZkh4y3+2FqVLsVYvSPKwXZFUpZwfrMq8grGy1/WnQmXAUsYyN3ypzbnmmUy8zcpgUFNEq1zf1q9fhFrYVMTSaXyHNdQaJqfaMgDXqls7CEdbVZj6iiSLVKeCYwofetPv05u3doKlA/v7DqWAkrHcHnYCu/B+89CGcU8Tv8sxr7Sj9xYkfEx0npVFcf8Dzd/gKTqx1+yxFxc+WW9ngHOvdwc8FJtE5S3LeYAbxdCo82e6C465ZI+mmZHVRm0KXKgNcFVvj4Rn7FgKqyIlUEHibsLBfPG80dm0hZF1d0SRmNgu+Upno1ckAl96N/HJu/u5e+Kf/EwDG6rthgIpIaLECZz9PUKkE5D+0sI0RNVxHcA2FyXKrLd0TIRA1PMYx/xKxPdIWEaqsJ9vUYxu2RyqlBbsaOP7/Flt1nUw4+4loMtPnHugI4LqjYonaNXTQ6e8mtvxMubK37XuQhIUmbX6ryoTBLdJFV8lYdlY9IOA/+o2UX5/bFNfg0RUS+guMda0JP7mVfhAT+Vrn9BAlCar/DtSbcLCYL6uyJrr5ITnnfKBGpOAjryQg3yca8mA9RTJ5ze5TMU1TcZdyAZx3BOPIDFFwHf8VZ2knXUjKNNGiaLh0McXzZbto1PS4knu0eu6DdbgIPUwGhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(4326008)(5660300002)(66476007)(66446008)(66946007)(8676002)(64756008)(86362001)(8936002)(66556008)(45080400002)(83380400001)(54906003)(6916009)(316002)(33656002)(122000001)(38100700002)(52536014)(53546011)(7696005)(41300700001)(71200400001)(6506007)(478600001)(26005)(186003)(76116006)(9686003)(38070700005)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KEod/7PKf80gN+A46HoNi4xdejFnlMsmFaeHcmqyGiSZJJARrlxhll67lKWj?=
 =?us-ascii?Q?Kotk9wxcDCj4T8KvUY/vJrggS8y3GL0Mey6w3Jo2Rsmdr6rF2/BGdDyzEwQz?=
 =?us-ascii?Q?IDaczRznM2wAZAPASomBuEn7Adp+g1Nbsoi9afRy1opC/aHqrsj51SgT9SON?=
 =?us-ascii?Q?dkfykxo0H7vOa/QVzDbecSSa/5xtK4JpEtLggNL2y93FsKSqeaqnAP4ChK0I?=
 =?us-ascii?Q?VxE71tRxtoGuwMCQ8QZGIkBUOsOL5T47qUyMgyA1MDNu/rCSfT135HxM2rjV?=
 =?us-ascii?Q?AS+sdE43hgyw/4AMnCORhFYCNGUf08Z9iZRm+u3+EDwjx42WYI5FalrstJjN?=
 =?us-ascii?Q?xGya+fdFmQZBF8GOO1R/euWoSnDjALJlklTWsVDFXH+YZwyhFumBe+/AHKpr?=
 =?us-ascii?Q?x9B9OS0I4eRvs7dF+TQIRuN2OHJRY/YUwipzm46qDtkD4N4PdFsHHqMq842L?=
 =?us-ascii?Q?Y5Ynl2fMN0JRecDQB1AXlImtiZ9n1cybD0JiP2GPJjc8pnIGmRRALbGc76mO?=
 =?us-ascii?Q?wtKJ/Zz/ibZKI6gEAFvdd/HJD8AmNMaUGqMRdotnu6JimjBWP+pWhblH7S2B?=
 =?us-ascii?Q?UzUzYpXvlhPpKLbT0XJq9PKkK3A+k05Cqph7Z8XgcZctA+cZvyEPNzfBMFrQ?=
 =?us-ascii?Q?W9JV7pB2akU8JxI5tm6afdRbB3T12YwEQ7TX6AVayWCarp7ABAyl8mNNoq6v?=
 =?us-ascii?Q?+QuVUK2ogMmzC6195m1a7hD0QNGut+ZINzecezEo/b/rt3CrtR9X5JecX/MO?=
 =?us-ascii?Q?2Prp0/lgC408cBoXfNWPamcC2kd4toqvtDGKKYvx3XmwHQkqwMaHmExU/Rlo?=
 =?us-ascii?Q?UX1m5fQR5xJ+C/xFLKQWmdb4QhnjoWwIXHXsWMIzFsWbUI2nBzhd6VRgxGvC?=
 =?us-ascii?Q?pNBgufR+MsA904UTlpg9SDL0ZYlCSEuMn+toPpaVmwdxFhZ9MfNkZojwE2mG?=
 =?us-ascii?Q?ER+izI4BrM494LV34DC3ER/4CqvYNwk+5RHFHuhRnEPJ8ImWOK0TADFqNNMN?=
 =?us-ascii?Q?nTnH/uOysfgT8g6CV0QqNqNMtlKTY8BSJE5Ch+E4bcWD27vJCNN8keC53S9y?=
 =?us-ascii?Q?jG3CqiIm5zatWMjKccrlB2YUM7un1mVxRf8l7mJiK2loPiWU9rHGaRTYbVLn?=
 =?us-ascii?Q?NKGbWapSbFaQWodcKRxUQ5Q77NU/qm8iUfrDnxHiFILXBmnJYQUJO+wWt5au?=
 =?us-ascii?Q?UDcCSMrEXwIu36t0KierS+8fmwzZ3O+U83v6MLdF1pWQ6w8lKn504zwqIV5W?=
 =?us-ascii?Q?7icF8LTDRw+sgrBqimGtYDKuBwpMWfEUJ2OBSpMepubzq+iisUr4Hjjr4iwh?=
 =?us-ascii?Q?QNl+ORFwYCnZwx4XqdCRSallnkvrWbvTqkiK6ZhGDQZTGZ7kxHvjbvBsXObf?=
 =?us-ascii?Q?YRtvsNbhxq3dLWCZXPxfRrM2xMXaUdIy4r/zkQbNuXWZ8Ba+otFD6WbkMpHz?=
 =?us-ascii?Q?CqpKtwUfJcdvJBNy0OsLkEKbNPj7/DJHYyWVuybzbzeyYVcrZ+rXt0zRFImq?=
 =?us-ascii?Q?nNsZHziG7opUEGsIXvA/HS9huHOBXJ47NVPXVBlZwqkEgUaR3nPwe2bGb1ZF?=
 =?us-ascii?Q?IBQZmCNDnaH96WfSANPDDmf96/rB2kHEDercmDvh74GhYOCOwQT1+0AH6DBW?=
 =?us-ascii?Q?hA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee06081-3d55-4b53-c6fa-08da9acd87ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 06:01:16.3377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /N3pPirtVj0CJco9CzHtRtVuhae9jrp8AKgM43s/M0TSXYgUxbQMaSrkVGXCRPiBb+8rh6kLx1Ss9xYUpTOnkEwD8yawVfqiR+HVTEg8dVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> Subject: Re: [PATCH] gpiolib: fix OOB access in quirk callbacks
>=20
> On 16.09.2022 13:01, Michael Walle wrote:
> > Commit a2b5e207cade ("gpiolib: rework quirk handling in
> > of_find_gpio()") introduced an array of quirk functions which get
> > iterated over. But a sentinal value is missing. Add it.
> >
> > Fixes: a2b5e207cade ("gpiolib: rework quirk handling in
> > of_find_gpio()")
> > Signed-off-by: Michael Walle <michael@walle.cc>
>=20
> This fixes the boot issue on RZ/G2L board since next-20220916.
>=20
> Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> > ---
> > FWIW here is the kernel oops backtrace:
> > [    4.108706] Internal error: SP/PC alignment exception: 8a000000
> [#1] SMP
> > [    4.115470] Modules linked in:
> > [    4.118549] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc5-
> next-20220916-00091-g6cae0fcbd5e7 #1821
> > [    4.128033] Hardware name: Kontron KBox A-230-LS (DT)
> > [    4.133127] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> > [    4.140154] pc : 0x61722d6f697067
> > [    4.143495] lr : of_find_gpio+0x138/0x174
> > [    4.147546] sp : ffff80000a24b680
> > [    4.150884] x29: ffff80000a24b680 x28: 0000000000000000 x27:
> ffff80000996044c
> > [    4.158090] x26: 0000000000000001 x25: ffff80000970f588 x24:
> ffff800009297968
> > [    4.165295] x23: ffff80000a24b770 x22: 0000000000000000 x21:
> ffff0020009a7010
> > [    4.172500] x20: ffff8000097752f8 x19: fffffffffffffffe x18:
> 0000000000000000
> > [    4.179703] x17: ffff8000085fb9d0 x16: ffff8000085fb264 x15:
> ffff8000085f96ac
> > [    4.186907] x14: 0000000000000000 x13: ffff80000884b3e8 x12:
> ffff80000884ab04
> > [    4.194111] x11: ffff80000884aa54 x10: 0000000000025080 x9 :
> ffff8000085fce78
> > [    4.201316] x8 : 0101010101010101 x7 : ffff800009750268 x6 :
> 051f521459491b57
> > [    4.208520] x5 : 571b495914521f05 x4 : 6e61722d6f697067 x3 :
> ffff80000a24b6d4
> > [    4.215724] x2 : 0000000000000000 x1 : ffff8000097752f8 x0 :
> ffff00207f7e4b20
> > [    4.222928] Call trace:
> > [    4.225389]  0x61722d6f697067
> > [    4.228377]  gpiod_get_index+0x12c/0x440
> > [    4.232334]  devm_gpiod_get_index+0x34/0xf0
> > [    4.236553]  devm_gpiod_get_optional+0x20/0x40
> > [    4.241036]  uart_get_rs485_mode+0x104/0x180
> > [    4.245345]  serial8250_register_8250_port+0x198/0x484
> > [    4.250532]  of_platform_serial_probe+0x358/0x640
> > [    4.255279]  platform_probe+0x70/0xe0
> > [    4.258973]  really_probe+0xc4/0x2e4
> > [    4.262577]  __driver_probe_device+0x80/0xec
> > [    4.266882]  driver_probe_device+0x44/0x150
> > [    4.271100]  __driver_attach+0x88/0x1a0
> > [    4.274967]  bus_for_each_dev+0x78/0xdc
> > [    4.278833]  driver_attach+0x2c/0x40
> > [    4.282437]  bus_add_driver+0x15c/0x210
> > [    4.286303]  driver_register+0x80/0x13c
> > [    4.290170]  __platform_driver_register+0x30/0x3c
> > [    4.294915]  of_platform_serial_driver_init+0x24/0x30
> > [    4.300013]  do_one_initcall+0x4c/0x240
> > [    4.303882]  kernel_init_freeable+0x29c/0x30c
> > [    4.308276]  kernel_init+0x2c/0x140
> > [    4.311793]  ret_from_fork+0x10/0x20
> > [    4.315401] Code: bad PC value
> >
> >   drivers/gpio/gpiolib-of.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> > index 95be5f0d2623..0e4e1291604d 100644
> > --- a/drivers/gpio/gpiolib-of.c
> > +++ b/drivers/gpio/gpiolib-of.c
> > @@ -498,6 +498,7 @@ static const of_find_gpio_quirk
> of_find_gpio_quirks[] =3D {
> >   	of_find_regulator_gpio,
> >   	of_find_arizona_gpio,
> >   	of_find_usb_gpio,
> > +	NULL
> >   };
> >
> >   struct gpio_desc *of_find_gpio(struct device *dev, const char
> > *con_id,
>=20

Can we revert the offending patch? or apply this patch

As the boards are not booting with Linux next since=20
next-20220916 tag.

Cheers,
Biju
