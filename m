Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0566068AEE3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 09:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjBEIw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 03:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBEIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 03:52:26 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2134.outbound.protection.outlook.com [40.107.117.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB95912F36;
        Sun,  5 Feb 2023 00:52:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZshNc+5zN0KOB33EKUl1IWLZOCjEe3Th6lzG9iX3IXp/kzIiwEb4rcEsH0Ye0u5YIGO1kd0Te4CIiUBzawdNQRNuMiInx1WQv7zburMCQvNJSt2wLsFn48FvmvjnQO7l1wDmTDvUB68aEntrIA0gITIkhtOO1jYienivDuSlesYjavwbd9uLMA9m9iArsNRVsh+L5rXaId596KDdyg0PVotq0sLNHF7f6DOvb60BwqnGJAVrDegUIpe0qsy8tNLZRfqLi0Nq3im0t0Dlb/J3qTbxgGBwsf82cgBAXX9U79QVcVuEUTbsLsJEivEFwJf/MGLRXXDq+10l4vqhTRulYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs2IcBwdhUlQxyXEpmotHzoABw2uMMWIYZsHkMSpsIw=;
 b=jf0nKEto8iGI4RYvPsxH4qtmexwZnF5K7tkT5wjEN5mn8LVw5TE7xThIJV9ILyrU1KdmMR3LKilQg2xdeZXoqApRAnyhHqf+Bt3HV06csr7XMF+R9RoeAzJqEUhqJV73nhYh5B+rD7cj3pspT6t9kBO3T27FrTTXCpi3AsD6kD3e1FujMrI7GY6e/yCQx0/RvaQsg9SGJXkqqMzMapVNlwSFQjc2eSBjB8vI3VCErNuyNALo7W2hB32RS18ksYwsAqx7yzdz0klaDYyBUgbyem4f3P68MhaL+tYwm0LgnwwWK6kONs6HkhkRi4fwdA97ZdOWg69F/7vaNT5dceGY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs2IcBwdhUlQxyXEpmotHzoABw2uMMWIYZsHkMSpsIw=;
 b=umHIB6jLyH7IaUDpQkKE/BmRoGdc2/YZ/bxHB9y7AwhwlmZjTTXzmo1rL50yzZaoadtfbWmPJ6hDvWfry+en9SFr291k8q3QArhQqQFXMO29bXzr20G6XasZo0Nt4H/W/DLn0SO02Y4Lc0QmulF5Z+8C3OT2QMkIrOkXuzFt/m0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9332.jpnprd01.prod.outlook.com (2603:1096:604:1cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Sun, 5 Feb
 2023 08:52:19 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6064.034; Sun, 5 Feb 2023
 08:52:17 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Tom Rix <trix@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "artur.bujdoso@gmail.com" <artur.bujdoso@gmail.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
        "tmaimon77@gmail.com" <tmaimon77@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: host: USB_XHCI_RZV2M depends on USB_GADGET
Thread-Topic: [PATCH] usb: host: USB_XHCI_RZV2M depends on USB_GADGET
Thread-Index: AQHZOQdWwDzUIKP5+kGb2XowdjuQpq7ACmZg
Date:   Sun, 5 Feb 2023 08:52:17 +0000
Message-ID: <OS0PR01MB592285E3E3B9AA7FD8C291A286D59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230205021227.3017634-1-trix@redhat.com>
In-Reply-To: <20230205021227.3017634-1-trix@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB9332:EE_
x-ms-office365-filtering-correlation-id: 73feb726-d164-421d-8f99-08db075648c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MXVp7rYPoIajG2h1SV0eLvIGPGoY5OOZJyls8ysGw0aj/nIIvL8ZPLcHXp8La88VrtiWvxdRXrPtaAuGAf9kkkEg2QyZ0UZVPGwJgNIl97tJeV4hQoo2kI9ymk0oWeiaprmsU6ZATctgQqzIjPrIzaT0E1l/trURmOdUz1z3V5M9w2Ui1Pit9nKHJc1FVCDmBgvd/bLxgceQtRo1By26E0cFhezb/sspVmL9DNMhYE1fh36tot4/eBqgZVmVvKPH3DVdY2mbWUndDp8WbP9Xgh5xcTS929TbsHjSyuLMdyWgGQIyeUUxfT5c6eCrSgwpNBxLpQ69QKIvLZQf5LqzH7koFBHnSIbtcopWWcETIVUBYIoYNxmf45MtIsZrulO4dl49lRHhRHkHNzmk4AGbwY+IUX2j3D18uo/uTDvwCQrUJU0z+rcaOtlH02F457Z3ECREncGnCOZjdhHktp5rztHHHI7prpoUEU835cWbFWtEUsaqn9VQDVfAhQQHpv3+1OfRbWo30unenOxGY5Sk9Fwhh8xeSdXfg76BatCIoHP39RJ7drc9EZNR3Sf8DiqEMXTf2yjFwsHq1RDraAlE9gaygIkKPelvMSTF6QXPuSBKdL38T+ZGAXkXL0KhdHR4M6P1SMCqtMscof3RzAunVmsAETW9oXl2esOuofDb4fkZq7ScQYhKP/+i/cBCS1RBcVSyN2lpkkrmC7TEdYgdAAmiHgBHs1Mh1q2vAqwQufk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199018)(186003)(26005)(9686003)(53546011)(6506007)(71200400001)(7696005)(38070700005)(966005)(478600001)(83380400001)(122000001)(38100700002)(33656002)(55016003)(86362001)(66446008)(64756008)(66556008)(66476007)(8936002)(41300700001)(66946007)(110136005)(54906003)(316002)(8676002)(4326008)(76116006)(2906002)(5660300002)(52536014)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tpQ+PorPmBrOxvkxlNBL1vgRw3PKdhdKXA0XJWncJ6HAAslq85hAjSu0iJve?=
 =?us-ascii?Q?2FCrQ8GMEg/jgURL2bKAMhabfaaCabEZlwJ6OD3EqWw4fgYoadX7S8vvOoI2?=
 =?us-ascii?Q?hw2w0SopRTIPq3JMIyQgBTy1AXx6+WIng/quQpklz8T7vgkBqCrlyO/OspSc?=
 =?us-ascii?Q?hcZO1RShfyjNsfRAjA+h0sSvkXj1zEV0DFkTbsda+XfR/g3VktwXKWuNMzyr?=
 =?us-ascii?Q?2kMmLA/HVd8RxWwk77QibMRLZNB3aVDSL8yOvRC9dTUakflzgRVy20u1aSP9?=
 =?us-ascii?Q?uJpsPUb2czM6A9gj23VeGkwpC0tVYfS3kMhrBhCgP/tR9Sm0F0MO/dYyaHNL?=
 =?us-ascii?Q?L0m/ze/lg6Hdu1XFsm6qJ03p/pPQ+oyQk+Xqx3NOWn7SfO7yT4NQYUObVviH?=
 =?us-ascii?Q?RhehhS0kvuhTjnGYbXGHv6u02QtSip9E36GInnKg2sVyLnmfBJNh/w5hSc58?=
 =?us-ascii?Q?SGr43TXz54bGMdTBDv6wSt9QMEZheZJI0Wo8wCT2Pi0T+AvZAmv0/UyT6/HA?=
 =?us-ascii?Q?LbFcGLzw/v4XSjPt/Q3gNR/KlMcBksM83vc2x23ny1FmfSGcUeHVaoizHefy?=
 =?us-ascii?Q?58NiwC8XNGP/ZNksGMqswfqAhXDvq6QSnIJG65cRK9r3OSmR0IvWUy/o5Of6?=
 =?us-ascii?Q?6HRjRCUB1UqQafbLROsirqipj5zhKCITK4QwGEhheD4ucMY15odOacA/PuTd?=
 =?us-ascii?Q?r/d0rl4K7U+4gQyOmZInCGom75yszBv9ZK8S7wpmfLdAw8JrnRFLwW807YlE?=
 =?us-ascii?Q?wdCBDUqFnOIUqcyZqfX8DrgjL1XqmRaHYPk2SgMEwFw7rfsEzaYlKnf0ZPd6?=
 =?us-ascii?Q?XdFBQNOPcjkT5JmTTxoGZsXLw0CAAW6rv56va5A0rvHJCZRdLecPBb2qyvgu?=
 =?us-ascii?Q?foZpirIryin9diRqzvPb/6cDUdjoMyM/kftmeXJpm7MRECjAMejlUUo7/G9H?=
 =?us-ascii?Q?UlMY4b9g4xspcvIKhEPUZaYo7nus5tW7SB1BcMBbPgQL7ZN2A1hgxvRjfbTn?=
 =?us-ascii?Q?8/HfYmkP5Tjyvqr7UqM66yQXkA7N5O3zgWN0OBxOov9GJ6AQsdbA5zj4qynh?=
 =?us-ascii?Q?tG1WDTr1aZwFLlioaG7qelwjB3P7rnsgJfaJZ8hwcivqOjc0+vFv6B0v93DT?=
 =?us-ascii?Q?zIqQEMxJdXUXAlS0REOI7CAZNGeP4/+LlWz76JKagaHhHCHB/Cc0M+I42STv?=
 =?us-ascii?Q?27b9pXq6iNxp2gBPIZgN0vH9QmWbpk/PifjMRtAuGtMDT+09i2LoMixXmR+i?=
 =?us-ascii?Q?RXfiOxpoOtZ/lFtYlr6teej+YAuPxygwa+SoEW3J6Jgue3bWnjgv3u08qifj?=
 =?us-ascii?Q?cna6K8lYFzxRcqDaD+ZJ3bgxpyehxCeLphKidXQGBazULWzOjFXHEYUP0ow0?=
 =?us-ascii?Q?6SZN6L2Js3RbHB1eAlveseyyw9AYY1h+4XEyW6si6IrOzsrd7PLDDYvJ89ca?=
 =?us-ascii?Q?nIyfHXqwh/d+1PlYMYoy+LHdOqAKq8Iz9aAq/hmukBeoabGph+AEpKbv7CVG?=
 =?us-ascii?Q?Fh4LoNZk2IoC5NmEn19nSmchSPXSSfKZu/6zej3UdPoSXOFksLlt93gWfGVk?=
 =?us-ascii?Q?9+B2/VSIygMDCWJJp7Q34NjbpSBI7N/26nL06jUvzbm6cwkKo/6FuFlYF5LA?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73feb726-d164-421d-8f99-08db075648c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2023 08:52:17.1880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETvQtsrjCUWigfHa9tql+uw7NsrLtdXIw56nO/UHuWdjRKAH7S2kaewRCZegOcn+Heb2h4Q1jZixDT5DlUAc8E3YNc7QFgpEkLxvBivS3kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9332
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

Thanks for the patch.

Arnd send a patch for refactoring the USB_XHCI_RZV2M KConfig dependencies r=
elated to USB_GADGET on [1] and
is in usb-next. Do you see this issue after applying[1]?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?=
h=3Dusb-next&id=3Dec5499d338ece9db9b7590649d3cfcc4d7f9603d

Cheers,
Biju

> -----Original Message-----
> From: Tom Rix <trix@redhat.com>
> Sent: Sunday, February 5, 2023 2:12 AM
> To: gregkh@linuxfoundation.org; arnd@arndb.de; linus.walleij@linaro.org;
> artur.bujdoso@gmail.com; miquel.raynal@bootlin.com; colin.i.king@gmail.co=
m;
> Biju Das <biju.das.jz@bp.renesas.com>; tmaimon77@gmail.com
> Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; Tom Rix
> <trix@redhat.com>
> Subject: [PATCH] usb: host: USB_XHCI_RZV2M depends on USB_GADGET
>=20
> A rand config causes this link error
> ld: drivers/usb/host/xhci-rzv2m.o: in function `xhci_rzv2m_init_quirk':
> xhci-rzv2m.c:(.text+0x13): undefined reference to `rzv2m_usb3drd_reset'
>=20
> xhci_rzv2m_init_quirk build is controlled by USB_XHCI_RZV2M
> rzv2m_usb3drd_reset build is controlled by USB_RZV2M_USB3DRD
>=20
> USE_XHCI_RZV2M does select USB_RZV2M_USB3DRD, but USB_RZV2M_USB3DRD depen=
ds
> on USB_GADGET, so now does USE_XHCI_RZV2M.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/usb/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig index
> 2b80ce9587c1..2dd9e95a5b86 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -100,6 +100,7 @@ config USB_XHCI_RZV2M
>  	tristate "xHCI support for Renesas RZ/V2M SoC"
>  	depends on USB_XHCI_PLATFORM
>  	depends on ARCH_R9A09G011 || COMPILE_TEST
> +	depends on USB_GADGET
>  	select USB_RZV2M_USB3DRD
>  	help
>  	  Say 'Y' to enable the support for the xHCI host controller
> --
> 2.27.0

