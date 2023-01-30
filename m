Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB768137A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbjA3Ohg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjA3Ohf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:37:35 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1351AF;
        Mon, 30 Jan 2023 06:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SG9hDITvLtNPgKgQ7AUbj7D/fy/aCFPWia1sJ0jxsBNxbbii6gkeVWTCo+PZJU2WTzlRIfROlKK4K/aSDEPnFe889Hmohv7WMo7X31qWzwLtjFLOdv48aTx1/nZ4qrzxI8EvkTPs0Vc8ea0ChPFnPNmi2tNrkDNWPpEGGC+30fTndzS1K8XuKelKvU13Ok2fmn+ERL1RXaK2I8FwyDcJJnr61CYMJU7esoCV5SX82t274I+2f0b0j1V82r4huG7s884s1xK4PJP/Mmo386AeWtVGtPK/m+U0l3TNfE2luG8wjo1nmKLwfU0Ma0GCstfPYAv4uhY7ia1C691J+JNQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvn/xcYgPT0SfzaBSDbKjZfZxVwhUWu7kCGV29T+08M=;
 b=eNtJ6sMwrmfxjlcAv48QPFgmEQJdmrs7MGzgQ3s5tsg0PWPme73SXKNu9SBbVEQtezQNnDaph6xxV55LunQgruT7E8I42VumXvVVU3eBpky8HHM0M6Frd8PyNGDDo7pU82TPDyMy8Be43I6aubHCdcD6sumj9KTAirEmuCZVdfeAsxauLOSE6OcuxRWig35GVjzwh8Vsm1UeKgeIPQ1Pbwwl186tx/W97+c3HRdcUnH3zeMwl0kUI7PwZmEubwQUYmuU+pZyafw+fFqQq9C9HlVlc031ncyV4BHrkGekb8L1kgU3b/pKj6w1jU3DgdrGYGMwfUGR1ESlkrVEifXZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvn/xcYgPT0SfzaBSDbKjZfZxVwhUWu7kCGV29T+08M=;
 b=LwxHQmPLNDTU7IfblIBz1bBArDUT0++LiKn/SsGDwSL6ZtwALYlgDsUFKmn3u5huzEUYGrr4yGNTOboLGr12+gZcjqLoNBzkXy4yxTjeGyZvJKbYSXz80HFMgwk9at1qREC49BkXOQ2XZdbvaPa1g8JiboWoBwvjEFs5OzLfpm4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8677.jpnprd01.prod.outlook.com (2603:1096:400:13b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 14:37:30 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 14:37:30 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH] xhci: host: renesas: drop excessive Kconfig selects
Thread-Topic: [PATCH] xhci: host: renesas: drop excessive Kconfig selects
Thread-Index: AQHZNKtnQ0HXj9mKKUmvHjl/Dm7Wq6628aiQ
Date:   Mon, 30 Jan 2023 14:37:30 +0000
Message-ID: <OS0PR01MB592264B5D8BB98A1B2F759C086D39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230130130425.310410-1-arnd@kernel.org>
In-Reply-To: <20230130130425.310410-1-arnd@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8677:EE_
x-ms-office365-filtering-correlation-id: 2a91514b-e18a-40c5-0d2a-08db02cf8427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v/q3zeIIb5MLkZQnBjTh0XMHI3mQbcf29jD5q9vyjFYJhxl6KtOwrCLVXF21PChJhdms/KQ5DmiHWhaeFkEXXK7XGphekfOu1xwtDw3T6ZeaeVmIcbgTWySSq09u5kPU7pYbLhjn0ciDxWzxr8WhdUtyzOLBbHTYgjDHs7V1chdTaZG9RaAqKN81XMRvIug9b4StfJ+HMjPLuvNr5m0s1aFz6tA0yR/KiYsBFuco9JH7RYhJHwTGV5pSBEIWvgyYyKhR8aVszgixnq1UAD5rGUCxOaxvtr96ptDR63/OfzlMFcvPhViKH4rK5KiNZs9oICM1uydhZN5Exed1Q6z4+VIiRHybutSLJidWpA43ewVa1LHVjd8k4K0Qq2KPIyRj5/kg1hCWzx9BbBFWshImR0P9fXUmZ2ngMocMvSN185VnewI973fhQeAI6PEVtOyGjmoQYFag6kXsdcjl4iXjJM4ZIieVrWwCOF9Vq1wTjKrrvtwAwxwWu7E6wZDbRiteQYo82NuUqHCqMWidP1PD3UCJjAqehQVUcVQEb+R87kdrKzjEOSe8Ve6Y7LwgqOhVYUgHe6mpdggZbBwQUmX+g2g6sQqFwHuAbp0WosjVTER20dfe3X5AtwVlAqngUCCgSzHbLmb/8bf+Y04w0kl2IIhROUJCgKrqy7DaZlPkeLCKMcdkEc9+1mvUwbh1Bk5fGXx2GJz+/f6qs6FR6VtIdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199018)(52536014)(5660300002)(7416002)(8936002)(41300700001)(38100700002)(122000001)(38070700005)(55016003)(33656002)(86362001)(2906002)(110136005)(54906003)(186003)(478600001)(26005)(9686003)(7696005)(71200400001)(6506007)(316002)(76116006)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(83380400001)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UDbNypZdUemAAZ1yLEIuAvmbaBzCJZj51kLVn6UkUtkF9vMvN5qAMmaQ0Vq1?=
 =?us-ascii?Q?jUg0XHo9tXWKk9rPs0bLvFFffM+PovPk/3jpmvEPJyqh4LffkoJomuW5H0za?=
 =?us-ascii?Q?1NyDrheq48jhKMfNwoGQ1bx/yMOkneGlK8rXQhuvDKEq/OyBm4PMRCuqZS92?=
 =?us-ascii?Q?L2irnh+90GrERTO5Uu5B985kdMYZ2WklfcRYPvLmZHSvFDUATPw9wJ5SUrBz?=
 =?us-ascii?Q?zO8ZQm+HOxdfR270bAEFVrrsFSGm/MSM0d0xzOkO68Y9UN0rNXBW7svElWYX?=
 =?us-ascii?Q?lUGu5k0HdyGAt3vTv68dWxHYU3n3TLDDJadfSYKxhDYS+jcGT09TAlxNhyHs?=
 =?us-ascii?Q?9MR3YnopPY+sR9JWlyWRLI77GFLdSRFkYIzzhNgz+0aebSnYp/x4XVMK2XPD?=
 =?us-ascii?Q?JZSWm7OfnQPrk+vzIa3z3DZ/2aTGviBAZgRpJ1EuCYjdE8NxwjODUNUmBdx/?=
 =?us-ascii?Q?XGkV1fiiL1oKdjWxJ03Nd45UQ7CkchitqQIoKxz4uN/s56W5fbsH8GoOqGPz?=
 =?us-ascii?Q?wcn+vtNrj4t3lnmQltBRe+YwzN3CwQw8D/yV8j5My12s6hSqApF7IiYiwsty?=
 =?us-ascii?Q?/fNjKN5vq5vv0s8t5h292IsRGXx2ezAGMerFNFBRwXvtRaToxJtjALb/2YDU?=
 =?us-ascii?Q?DxnHDMr/YznLX4w7I1fdQB9TBnPR0G9AlPMD2Y9G+aYCK95NV/1WktuaM42d?=
 =?us-ascii?Q?rlgZ6HWu//V1ERuk6L+g5cTWl01ngb0qhCys5Yo+0FpoO9NcHAujRPJ8ccib?=
 =?us-ascii?Q?2ZB+JUjYA/EUTocXRbUXeHrRvWTP5c4n2JYviDbH95e9sAK/5aDCdlxm2BZd?=
 =?us-ascii?Q?oehD6siYK4nMLtLo0Eg7CUwqS4LUg2n7lUwt8SfRTCZlLQKCqdouU0IGcrpC?=
 =?us-ascii?Q?wA/H/0uTyl3Kq8pzGojfBjD3Uezq0qUtZKDneOMVP3R32pm13jIMcF9HpShj?=
 =?us-ascii?Q?c4FHH5ZTZocKpyOOsgdKLMq9jogFTti6IiLwEbBoecqyUPTlIA7oLNapv0la?=
 =?us-ascii?Q?hTri0zJ9ji1Q4m0DDkOnT6St8uzMLSz7d79WyODcGgGHJ1H81CGAJIpgngjr?=
 =?us-ascii?Q?atkuNsvHY+zPft721F8ONcIx5Q6OTpw3AIeQ8kVOV3u/4lk8PQ87vrcnNust?=
 =?us-ascii?Q?gHpJ9JvQRmtvy9QN0JKDCpl0qBNILRBc3wXPd/oe2goePthTmGG4lCpjzdzA?=
 =?us-ascii?Q?E17bnsBdkrA08GJV94SsP6SOQNmje6OBJ7lGgU34Dxdw3fEdJWCzBtIWiIZX?=
 =?us-ascii?Q?C1D/UBAtgq5BokinATsmGVv+xRPwLckFTkeQpCZXNqLKnjJPzmNFmXi4OD6f?=
 =?us-ascii?Q?asUyqf87BZfzoxdhMaYYOC2UKBbXjQQUDgvDCJLLRxBGN/dXzaO5+FqWsiVD?=
 =?us-ascii?Q?ZBOc9K88jeIWR0Cuu+mhZS6IgX5IKI2EyHfssh7Y7Odu5BgCbx3PrcHhysDF?=
 =?us-ascii?Q?gEer/2LGq8wmyUDpaFGFT/C11rEvWklc6llZgD83m6F/6bW7HeaYR6x+Zaku?=
 =?us-ascii?Q?BL3i0618K27kmsk4Imwdc7IukBeQvmagQthUEQWONoF5KGGHOj/Uvx+wXHA6?=
 =?us-ascii?Q?oLqSs5nDqjcKKbyz9Ho/Md3HfnGeNFW+Onb3D+h4GfpL5N7ARyEXZaR8HUVa?=
 =?us-ascii?Q?mQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a91514b-e18a-40c5-0d2a-08db02cf8427
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 14:37:30.1538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 914X9qYnuyMQO8Kw0FaKhxCWMiWSxsY/VY/7hNeQCrghgT9DmsZmjRgKu2Q66owPtEymg6USgMdg9v8vQEiQGW/Cbt+s4nprwfI04pv2XlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8677
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd Bergmann,

Thanks for the patch.

+ renesas-soc.

> Subject: [PATCH] xhci: host: renesas: drop excessive Kconfig selects
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The USB_XHCI_RZV2M and USB_RENESAS_USB3 select other drivers based on the
> enabled SoC types, which leads to build failures when the dependencies ar=
e
> not met:
>=20
> WARNING: unmet direct dependencies detected for USB_RZV2M_USB3DRD
>   Depends on [n]: USB_SUPPORT [=3Dy] && USB_GADGET [=3Dn] && (ARCH_R9A09G=
011
> [=3Dn] || COMPILE_TEST [=3Dy])
>   Selected by [m]:
>   - USB_XHCI_RZV2M [=3Dm] && USB_SUPPORT [=3Dy] && USB [=3Dy] && USB_XHCI=
_HCD [=3Dm]
> && USB_XHCI_PLATFORM [=3Dm] && (ARCH_R9A09G011 [=3Dn] || COMPILE_TEST [=
=3Dy])
> ERROR: modpost: "rzv2m_usb3drd_reset" [drivers/usb/host/xhci-plat-hcd.ko]
> undefined!
>=20
> All the selected symbols are actually user visible, so the correct approa=
ch
> here is to drop the incorrect 'select' statements and have users turn on
> those drivers during kernel configuration as they would for any other
> driver.

Both Host and device controller need USB3DRD driver to work.
ie, the reason, added select statement to explicitly enable "USB_RZV2M_USB3=
DRD"
by default.

I have tested this patch with below configurations in ARM64 defconfig.

+CONFIG_USB_XHCI_RZV2M=3Dy
+CONFIG_USB_RZV2M_USB3DRD=3Dy

>=20
> Fixes: c52c9acc415e ("xhci: host: Add Renesas RZ/V2M SoC support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/gadget/udc/Kconfig | 1 -
>  drivers/usb/host/Kconfig       | 3 ---
>  2 files changed, 4 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kcon=
fig
> index 9b7a1681550f..1821004dd325 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -195,7 +195,6 @@ config USB_RENESAS_USB3
>  	tristate 'Renesas USB3.0 Peripheral controller'
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on EXTCON
> -	select USB_RZV2M_USB3DRD if ARCH_R9A09G011
>  	select USB_ROLE_SWITCH
>  	help
>  	   Renesas USB3.0 Peripheral controller is a USB peripheral controller
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig index
> 4b5c5b1feb40..b975178b38bf 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -53,8 +53,6 @@ config USB_XHCI_PCI_RENESAS
>=20
>  config USB_XHCI_PLATFORM
>  	tristate "Generic xHCI driver for a platform device"
> -	select USB_XHCI_RCAR if ARCH_RENESAS

This change has nothing to do with RZ/V2M fixes. Currently USB_XHCI_RCAR is=
 enabled
by default, with this change user has to enable it separately.

Maybe keep it here or add a separate patch for dropping it here and add it =
to the defconfig??

Cheers,
Biju

> -	select USB_XHCI_RZV2M if ARCH_R9A09G011
>  	help
>  	  Adds an xHCI host driver for a generic platform device, which
>  	  provides a memory space and an irq.
> @@ -100,7 +98,6 @@ config USB_XHCI_RZV2M
>  	tristate "xHCI support for Renesas RZ/V2M SoC"
>  	depends on USB_XHCI_PLATFORM
>  	depends on ARCH_R9A09G011 || COMPILE_TEST
> -	select USB_RZV2M_USB3DRD
>  	help
>  	  Say 'Y' to enable the support for the xHCI host controller
>  	  found in Renesas RZ/V2M SoC.
> --
> 2.39.0

