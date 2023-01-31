Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3BB6831F4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjAaP5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjAaP52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:57:28 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397164109D;
        Tue, 31 Jan 2023 07:57:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHV6amiCY0WErRsARDzfoub2afNdwjMByuYPmHTsCI3oVgRLdI0It1YIYEOI19qYJBHgfSo3BGinZTvOD3fCXVGim7OS40FISMdPT+0gQKekcO18nOlS6/NzdOiL4Y5+7//CUCaRzwvxgzsTdgzzj4r8pvrnEXRRqZIRr5TWX2zV/9bQEFx0w0ZGvrEIkZeB+jyfRqzpk1t2SaSe7W7obskQE5sMHQQSSij39QT+wtsL26madwlqjGXlCfbJbIknx0YneEMMSoUniTgaOa+D6B4TweFVVs26qSUunoBzOrJlgeVcRNSgwTZw5EEjhs4xXl9S37xfTWfv6f3i2vcjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAP/R3B2lRMneM5Kg1cciK2Q1RwO27zJY6JSpbVwKvg=;
 b=ZVKcY441zKnSNVpbVCaCYQxsgVLYcZk/xh4yz0pPj394Qd+AaoPP0DUByZtEhj8dnTaLIQfCkzH4RrG3aaFcwFubON2uouRIhq2SQ2nVN0LgzrSt2wcPQslgnUKufx/JPNk4n0qlyEzp7LhS0qgZEW6Nw7c7rkYnCrvGahgBF9v0Gwm3pUykEfsUFaAmgYbwNU3CPvN0J2Ranmyq4DsqHGgbetT0oM9S/JwQIQTliMP4sa/lqTXrCWlAGoHisjBD7hDE7KnfeCgFuvnZXeHZYS/kNYy9+p99489D1F79YBBA/ChersWf7cfhK7HRUwyv6PEXI8sWj6oxQ1ZF6mw4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAP/R3B2lRMneM5Kg1cciK2Q1RwO27zJY6JSpbVwKvg=;
 b=JjXBTNF12CKBv1Vg5Cz1TISc216iIY50rumwzwl0WTKHNCrrZ3ppBIMweH7nrWYrtw3Zcqs6Vi+ImoqEE/BMcTBQpcoomvvvQlqWc10NKM0H6pgOzGta95WTSEOO6h89Pwa8USszLdYJP9s3/AavRY3Qbw17O0YFUWf4fI+x95U=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8513.jpnprd01.prod.outlook.com (2603:1096:604:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 15:57:22 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 15:57:21 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH] xhci: split out rcar/rz support from xhci-plat.c
Thread-Topic: [PATCH] xhci: split out rcar/rz support from xhci-plat.c
Thread-Index: AQHZNYWHpM+vXY/vhUmieXErEh+nuK64rO/A
Date:   Tue, 31 Jan 2023 15:57:21 +0000
Message-ID: <OS0PR01MB59227F6D1B7C28E6316A5E3986D09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230131150531.12347-1-arnd@kernel.org>
In-Reply-To: <20230131150531.12347-1-arnd@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8513:EE_
x-ms-office365-filtering-correlation-id: 835beb81-ea9f-419e-fa62-08db03a3d690
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WeRx8z8kst3Rk8K9vG9R2lFV94D299OENt9D7X7gXsSgH8bfiB/IGokyzyGeCnWF3tRMWr7dRKYSUENRCnMc4hqAgbE00SfCneNQUbD0W5G6e6ie7eniDh3u71SWqN905B37UDwbL0pHMZNFjb2uyYPw44fFlAk5twPDSOIJ9YxfuOON+zXQiP4XyWuDyooAJK7KSGQfH51yHLeAjPEQgj2O0wUszhbESIIsFFnV30/bgyDgqOrEuwxSBHaR2l4EaJ+1X1L/i+LgUhN8c47huD7iSxOVfTOVCyqYFSJkT7SmcILTeUJkht9stbZlmsi7ZmOkZjYlvjxzS8m6gWlOxFmxgNnABQBR5YYS3U/sRTxesSvDbxnlIJyPjhsYNBYFDkCN98rqkT7KJNYPT5ZHnRkzPVuFv0QMHEpXPEugFEgZNMOHCYj/LPgqxZQ3Gdspd57l75HpGa6dbWLAaB1Ovuy9u82NMu1NOxFIfuCw2BkOqI40GGghYRXmHR+HOnu77JSTaMZoKKOC1SDKAQpf3a4wJvQX3tY2X54DBLiLjsRSK+3RvDqHLc+0yjqCRbCA/jStZEYN5LcBjQK0C3GNS/xBiaL3dHG1a4/1QbY3dWqLsN4Yk0c7l11WvH2yoWEMqbwaEQoXqEMYKlB1UK7AxYtPTDH/LqHNqy/aniVc+NENGig+RsPOtbN2iEWQt7d9u/RrA4i5TKp3ksljm/ZSTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199018)(52536014)(2906002)(316002)(122000001)(38070700005)(186003)(53546011)(6506007)(30864003)(5660300002)(26005)(110136005)(54906003)(38100700002)(107886003)(9686003)(55016003)(7696005)(33656002)(71200400001)(66556008)(83380400001)(86362001)(478600001)(66946007)(76116006)(4326008)(66476007)(8936002)(66446008)(64756008)(8676002)(66574015)(41300700001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k4v6JNNdLhnbT6X4dRIR49+0WVanYCCrRYXLW0nk7uy4mafckniPJPWspf?=
 =?iso-8859-1?Q?1x48q/ax6v/m+O3+5L23F8WKS1deVAdZrB79VFHbu+Wn/+DYtFekxUr7n1?=
 =?iso-8859-1?Q?7LY1HX39XzMdw9fdV7qU0K1cBeLOPu1M8mYrz6tNLDsCC1KuT5J8K1SpbN?=
 =?iso-8859-1?Q?DZg3o8QvbadvVZIRvxI35tpHkoKSwcVp0WAqdsQ7PNE8l/A2kgBIgrK/vP?=
 =?iso-8859-1?Q?Q9zDXDGQtBU0RXSB5osjd04hPnp3bs4stIyFGKPg/TXd1n9yc+X/xIVENB?=
 =?iso-8859-1?Q?+VM0OLqlJqQSGlGqIC0gpgAmYO3BWH5eTrv1vbivgi4kr7m91oCtTz7jdD?=
 =?iso-8859-1?Q?BWvqAxevCanMWOahaFV1S4sUewpHe+uDT5XlfdH8u4zuXvW9+LF6DmdjUE?=
 =?iso-8859-1?Q?acNi5cn2GaVQT3Eid9ORWrtgwx57G1+b4p8apXtPzjs99bajSogzy002Du?=
 =?iso-8859-1?Q?aP3id3nb0kXMEVq1q0cmOTq410sI6XJkJbIDgaeCacl5UJS23fAAyqxI9P?=
 =?iso-8859-1?Q?Z7nTQRODH8iySkscHhku5rYN4HpmmhaN8+VUAvWAfTQzioo3woQZjH4VXM?=
 =?iso-8859-1?Q?1JmNjyODkqa8Co1ZN3rzb2e0fH2QFLRhRDKgLs8lycXrkw/O6a+vwZYfO1?=
 =?iso-8859-1?Q?28ZYngE/sCSkxHy2rurJ3bSlQDBzIlgiJOFeFqxXLa/0P6BYOKH18OCMEH?=
 =?iso-8859-1?Q?At9NYcX5u+DTge9YDhBHVS/idh2J7XGBZafsD2H1bPFqHCNEIS2Sfqc5b0?=
 =?iso-8859-1?Q?EiP7Epzqk8mDDTxL9yEtq+U9E0FGKjAs2KdsFu7R8madFIg3LinQkw//VF?=
 =?iso-8859-1?Q?lsAtwkoRgYoSRVrKE2rtKBAZHk62fjcb1bXicBuAciR35cR9TAkGjAJgPC?=
 =?iso-8859-1?Q?Rctxg4IutK//LsoS0GrBzyf3umklEJcvi4KaQl4C3ZNbut03gZuxQXwwbG?=
 =?iso-8859-1?Q?+rZU5S79Q45PtAlD9XNypEo+KKDUinA1PK9eq5S21IzVy/DlnPZC7i1Jgm?=
 =?iso-8859-1?Q?yyuxlppIT9+RUr9DkRylnTmy/hKdvtWW2tOT1lHsjcoSPUpxrL+1SVZpPH?=
 =?iso-8859-1?Q?ISOtlyZh+6brofvBeLAbrHtgl/qeHJwr5Wx+Q6Zos944XYOy3czz5RuTLE?=
 =?iso-8859-1?Q?CFeA1zjR0kqqWUtA9IxHrdaNw7XWggk3+QfmQ0nqcftj0jwnDUN4XFbZ3X?=
 =?iso-8859-1?Q?YX7zDdg1RDoN1IKU+q4bAOgtogsNhbWzYCjmLKJ/Zs/jiUzwhvFvMKl+1l?=
 =?iso-8859-1?Q?mpVNiQlHxo+/F22SkLGD0io0A7YiEECX9ICvKuhoiOUNEOKOYn2u4s/G/u?=
 =?iso-8859-1?Q?E6xtwSS2z02Bqu+AJJlIj0VgQi1BWXhwEsJBwD6z8Egy3ZTW7oOx1KYzGf?=
 =?iso-8859-1?Q?2RdfXfczl6/U3c2JDr70+/Da0DrTCXO/VgwjDy/bPMYc7p5b7K10gQKg9K?=
 =?iso-8859-1?Q?iSyFRZVzI9LP9zG4brkGSsQL+f7xUbI6e4swdv9U7juo3u8ZbAoykml4yh?=
 =?iso-8859-1?Q?coVw8MbbBaA7gen8QkvJ4KRCewWx8LCNmhK2maiC709Wfgt4SZY1Lf67Zo?=
 =?iso-8859-1?Q?u5PL3+81Rz/kjB100lU+aK0YvTPZXQFhvXxb5BbHKEhwsVXcsT/2pUlBAa?=
 =?iso-8859-1?Q?3+XntPUo1A0cXT7ELxc/GsT5QRQARIZoChVdUYzOhp88JeW0LkA/nBkQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835beb81-ea9f-419e-fa62-08db03a3d690
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 15:57:21.7122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbPonx0jk2so+CDZsBG9sRxi45DK18dUN/0Cqb74iS8D8fcjxHQXxG4F6Ozvqv1AoVp9SAXdGp59SnGTZwSYtuhJhzj/2u2LGMgfdDROCQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8513
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for the patch.

> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Tuesday, January 31, 2023 3:05 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Mathias Nyman
> <mathias.nyman@intel.com>; Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Pali Roh=E1r <pali@kernel.org>; Geert
> Uytterhoeven <geert+renesas@glider.be>; linux-kernel@vger.kernel.org; lin=
ux-
> usb@vger.kernel.org
> Subject: [PATCH] xhci: split out rcar/rz support from xhci-plat.c
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
> The xhci-rcar driver has a reverse dependency with the xhci core, and it
> depends on the UDC driver in turn. To untangle this, make the xhci-rcar.k=
o
> driver a standalone module that just calls into the xhci-plat.ko module l=
ike
> other drivers do.
>=20
> This allows handling the dependency on the USB_RZV2M_USB3DRD driver to on=
ly
> affect the xhci-rcar module and simplify the xhci-plat module.
>=20
> It also allows leaving out the hacks for broken dma mask and nested devic=
es
> from the rcar side and keep that only in the generic xhci driver.
>=20
> As a future cleanup, the marvell and dwc3 specific bits of xhci-plat.c co=
uld
> be moved out as well, but that is not required for this bugfix.
>=20
> Fixes: c52c9acc415e ("xhci: host: Add Renesas RZ/V2M SoC support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have tested this patch. So,

Tested-by: Biju Das <biju.das.jz@bp.renesas.com>

Both RZ/G2M and RZ/V2M host functionality verified by read/write test on US=
B mass storage
device.

RZ/V2M USB3function tested by ping command on host machine.

RZ/G2M USB3 function tested by connecting to RZ/V2M as host machine:

echo ee000000.usb > /sys/bus/platform/drivers/xhci-renesas-hcd/unbind  -> r=
emove host driver
modprobe g_serial-> binding to USB2.0 port
modprobe g_mass_storage file=3D/backing_file--> binding to USB3.0 port
echo 1 > /sys/kernel/debug/usb/ee020000.usb/b_device -> emulate USB3 functi=
on as it uses USB3.0 host port.

RZ/G2M USB3 function logs :
root@rzv2m:~# [ 1744.276259] usb 2-1: new SuperSpeed USB device number 3 us=
ing xhci-renesas-hcd
[ 1744.303389] usb-storage 2-1:1.0: USB Mass Storage device detected
[ 1744.310182] usb-storage 2-1:1.0: Quirks match for vid 0525 pid a4a5: 100=
00
[ 1744.320098] scsi host0: usb-storage 2-1:1.0
[ 1745.349349] scsi 0:0:0:0: Direct-Access     Linux    File-Stor Gadget 06=
02 PQ: 0 ANSI: 2
[ 1745.365588] sd 0:0:0:0: Power-on or device reset occurred
[ 1745.374441] sd 0:0:0:0: [sda] 2048 512-byte logical blocks: (1.05 MB/1.0=
0 MiB)
[ 1745.497264] sd 0:0:0:0: [sda] Write Protect is off
[ 1745.609251] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[ 1745.840594]  sda: sda1
[ 1745.849103] sd 0:0:0:0: [sda] Attached SCSI disk

Cheers,
Biju

> ---
>  drivers/usb/gadget/udc/Kconfig |   4 +-
>  drivers/usb/host/Kconfig       |   9 ++-
>  drivers/usb/host/Makefile      |  11 ++-
>  drivers/usb/host/xhci-plat.c   | 127 +++++++++++++--------------------
>  drivers/usb/host/xhci-plat.h   |   7 ++
>  drivers/usb/host/xhci-rcar.c   | 102 ++++++++++++++++++++++++--
>  drivers/usb/host/xhci-rcar.h   |  55 --------------
>  7 files changed, 164 insertions(+), 151 deletions(-)  delete mode 100644
> drivers/usb/host/xhci-rcar.h
>=20
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kcon=
fig
> index 9b7a1681550f..20b477b2a080 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -182,8 +182,6 @@ config USB_RENESAS_USBHS_UDC  config USB_RZV2M_USB3DR=
D
>  	tristate 'Renesas USB3.1 DRD controller'
>  	depends on ARCH_R9A09G011 || COMPILE_TEST
> -	default USB_XHCI_RZV2M
> -	default USB_RENESAS_USB3
>  	help
>  	   Renesas USB3.1 DRD controller is a USB DRD controller
>  	   that supports both host and device switching.
> @@ -194,8 +192,8 @@ config USB_RZV2M_USB3DRD  config USB_RENESAS_USB3
>  	tristate 'Renesas USB3.0 Peripheral controller'
>  	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on USB_RZV2M_USB3DRD || !USB_RZV2M_USB3DRD
>  	depends on EXTCON
> -	select USB_RZV2M_USB3DRD if ARCH_R9A09G011
>  	select USB_ROLE_SWITCH
>  	help
>  	   Renesas USB3.0 Peripheral controller is a USB peripheral controller
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig index
> 4b5c5b1feb40..cfcc0685b650 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -53,8 +53,6 @@ config USB_XHCI_PCI_RENESAS
>=20
>  config USB_XHCI_PLATFORM
>  	tristate "Generic xHCI driver for a platform device"
> -	select USB_XHCI_RCAR if ARCH_RENESAS
> -	select USB_XHCI_RZV2M if ARCH_R9A09G011
>  	help
>  	  Adds an xHCI host driver for a generic platform device, which
>  	  provides a memory space and an irq.
> @@ -92,15 +90,16 @@ config USB_XHCI_RCAR
>  	tristate "xHCI support for Renesas R-Car SoCs"
>  	depends on USB_XHCI_PLATFORM
>  	depends on ARCH_RENESAS || COMPILE_TEST
> +	default ARCH_RENESAS
>  	help
>  	  Say 'Y' to enable the support for the xHCI host controller
>  	  found in Renesas R-Car ARM SoCs.
>=20
>  config USB_XHCI_RZV2M
> -	tristate "xHCI support for Renesas RZ/V2M SoC"
> -	depends on USB_XHCI_PLATFORM
> +	bool "xHCI support for Renesas RZ/V2M SoC"
> +	depends on USB_XHCI_RCAR
>  	depends on ARCH_R9A09G011 || COMPILE_TEST
> -	select USB_RZV2M_USB3DRD
> +	depends on USB_RZV2M_USB3DRD=3Dy || (USB_RZV2M_USB3DRD=3DUSB_XHCI_RCAR)
>  	help
>  	  Say 'Y' to enable the support for the xHCI host controller
>  	  found in Renesas RZ/V2M SoC.
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile index
> 6b1f9317f116..5a13712f367d 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -25,17 +25,13 @@ xhci-plat-hcd-y :=3D xhci-plat.o  ifneq
> ($(CONFIG_USB_XHCI_MVEBU), )
>  	xhci-plat-hcd-y		+=3D xhci-mvebu.o
>  endif
> -ifneq ($(CONFIG_USB_XHCI_RCAR), )
> -	xhci-plat-hcd-y		+=3D xhci-rcar.o
> -endif
> -ifneq ($(CONFIG_USB_XHCI_RZV2M), )
> -	xhci-plat-hcd-y		+=3D xhci-rzv2m.o
> -endif
> -
>  ifneq ($(CONFIG_DEBUG_FS),)
>  	xhci-hcd-y		+=3D xhci-debugfs.o
>  endif
>=20
> +xhci-rcar-hcd-y				+=3D xhci-rcar.o
> +xhci-rcar-hcd-$(CONFIG_USB_XHCI_RZV2M)	+=3D xhci-rzv2m.o
> +
>  obj-$(CONFIG_USB_PCI)	+=3D pci-quirks.o
>=20
>  obj-$(CONFIG_USB_EHCI_HCD)	+=3D ehci-hcd.o
> @@ -75,6 +71,7 @@ obj-$(CONFIG_USB_XHCI_PCI)	+=3D xhci-pci.o
>  obj-$(CONFIG_USB_XHCI_PCI_RENESAS)	+=3D xhci-pci-renesas.o
>  obj-$(CONFIG_USB_XHCI_PLATFORM) +=3D xhci-plat-hcd.o
>  obj-$(CONFIG_USB_XHCI_HISTB)	+=3D xhci-histb.o
> +obj-$(CONFIG_USB_XHCI_RCAR)	+=3D xhci-rcar-hcd.o
>  obj-$(CONFIG_USB_XHCI_MTK)	+=3D xhci-mtk-hcd.o
>  obj-$(CONFIG_USB_XHCI_TEGRA)	+=3D xhci-tegra.o
>  obj-$(CONFIG_USB_SL811_HCD)	+=3D sl811-hcd.o
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 57269f1f318e..cd17ccab6e00 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -24,8 +24,6 @@
>  #include "xhci.h"
>  #include "xhci-plat.h"
>  #include "xhci-mvebu.h"
> -#include "xhci-rcar.h"
> -#include "xhci-rzv2m.h"
>=20
>  static struct hc_driver __read_mostly xhci_plat_hc_driver;
>=20
> @@ -116,21 +114,6 @@ static const struct xhci_plat_priv
> xhci_plat_marvell_armada3700 =3D {
>  	.init_quirk =3D xhci_mvebu_a3700_init_quirk,  };
>=20
> -static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 =3D {
> -	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V1)
> -};
> -
> -static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 =3D {
> -	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V3)
> -};
> -
> -static const struct xhci_plat_priv xhci_plat_renesas_rzv2m =3D {
> -	.quirks =3D XHCI_NO_64BIT_SUPPORT | XHCI_TRUST_TX_LENGTH |
> -		  XHCI_SLOW_SUSPEND,
> -	.init_quirk =3D xhci_rzv2m_init_quirk,
> -	.plat_start =3D xhci_rzv2m_start,
> -};
> -
>  static const struct xhci_plat_priv xhci_plat_brcm =3D {
>  	.quirks =3D XHCI_RESET_ON_RESUME | XHCI_SUSPEND_RESUME_CLKS,  }; @@ -
> 149,30 +132,6 @@ static const struct of_device_id usb_xhci_of_match[] =3D=
 {
>  	}, {
>  		.compatible =3D "marvell,armada3700-xhci",
>  		.data =3D &xhci_plat_marvell_armada3700,
> -	}, {
> -		.compatible =3D "renesas,xhci-r8a7790",
> -		.data =3D &xhci_plat_renesas_rcar_gen2,
> -	}, {
> -		.compatible =3D "renesas,xhci-r8a7791",
> -		.data =3D &xhci_plat_renesas_rcar_gen2,
> -	}, {
> -		.compatible =3D "renesas,xhci-r8a7793",
> -		.data =3D &xhci_plat_renesas_rcar_gen2,
> -	}, {
> -		.compatible =3D "renesas,xhci-r8a7795",
> -		.data =3D &xhci_plat_renesas_rcar_gen3,
> -	}, {
> -		.compatible =3D "renesas,xhci-r8a7796",
> -		.data =3D &xhci_plat_renesas_rcar_gen3,
> -	}, {
> -		.compatible =3D "renesas,rcar-gen2-xhci",
> -		.data =3D &xhci_plat_renesas_rcar_gen2,
> -	}, {
> -		.compatible =3D "renesas,rcar-gen3-xhci",
> -		.data =3D &xhci_plat_renesas_rcar_gen3,
> -	}, {
> -		.compatible =3D "renesas,rzv2m-xhci",
> -		.data =3D &xhci_plat_renesas_rzv2m,
>  	}, {
>  		.compatible =3D "brcm,xhci-brcm-v2",
>  		.data =3D &xhci_plat_brcm,
> @@ -185,11 +144,10 @@ static const struct of_device_id usb_xhci_of_match[=
] =3D
> {  MODULE_DEVICE_TABLE(of, usb_xhci_of_match);  #endif
>=20
> -static int xhci_plat_probe(struct platform_device *pdev)
> +int xhci_plat_probe(struct platform_device *pdev, struct device
> +*sysdev, const struct xhci_plat_priv *priv_match)
>  {
> -	const struct xhci_plat_priv *priv_match;
>  	const struct hc_driver	*driver;
> -	struct device		*sysdev, *tmpdev;
> +	struct device		*tmpdev;
>  	struct xhci_hcd		*xhci;
>  	struct resource         *res;
>  	struct usb_hcd		*hcd, *usb3_hcd;
> @@ -207,31 +165,10 @@ static int xhci_plat_probe(struct platform_device
> *pdev)
>  	if (irq < 0)
>  		return irq;
>=20
> -	/*
> -	 * sysdev must point to a device that is known to the system firmware
> -	 * or PCI hardware. We handle these three cases here:
> -	 * 1. xhci_plat comes from firmware
> -	 * 2. xhci_plat is child of a device from firmware (dwc3-plat)
> -	 * 3. xhci_plat is grandchild of a pci device (dwc3-pci)
> -	 */
> -	for (sysdev =3D &pdev->dev; sysdev; sysdev =3D sysdev->parent) {
> -		if (is_of_node(sysdev->fwnode) ||
> -			is_acpi_device_node(sysdev->fwnode))
> -			break;
> -#ifdef CONFIG_PCI
> -		else if (sysdev->bus =3D=3D &pci_bus_type)
> -			break;
> -#endif
> -	}
> -
>  	if (!sysdev)
>  		sysdev =3D &pdev->dev;
>=20
> -	if (WARN_ON(!sysdev->dma_mask))
> -		/* Platform did not initialize dma_mask */
> -		ret =3D dma_coerce_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
> -	else
> -		ret =3D dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
> +	ret =3D dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
>  	if (ret)
>  		return ret;
>=20
> @@ -293,11 +230,6 @@ static int xhci_plat_probe(struct platform_device
> *pdev)
>  	if (ret)
>  		goto disable_reg_clk;
>=20
> -	if (pdev->dev.of_node)
> -		priv_match =3D of_device_get_match_data(&pdev->dev);
> -	else
> -		priv_match =3D dev_get_platdata(&pdev->dev);
> -
>  	if (priv_match) {
>  		priv =3D hcd_to_xhci_priv(hcd);
>  		/* Just copy data for now */
> @@ -411,8 +343,47 @@ static int xhci_plat_probe(struct platform_device
> *pdev)
>=20
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(xhci_plat_probe);
> +
> +static int xhci_generic_plat_probe(struct platform_device *pdev) {
> +	const struct xhci_plat_priv *priv_match;
> +	struct device *sysdev;
> +	int ret;
> +
> +	/*
> +	 * sysdev must point to a device that is known to the system firmware
> +	 * or PCI hardware. We handle these three cases here:
> +	 * 1. xhci_plat comes from firmware
> +	 * 2. xhci_plat is child of a device from firmware (dwc3-plat)
> +	 * 3. xhci_plat is grandchild of a pci device (dwc3-pci)
> +	 */
> +	for (sysdev =3D &pdev->dev; sysdev; sysdev =3D sysdev->parent) {
> +		if (is_of_node(sysdev->fwnode) ||
> +			is_acpi_device_node(sysdev->fwnode))
> +			break;
> +#ifdef CONFIG_PCI
> +		else if (sysdev->bus =3D=3D &pci_bus_type)
> +			break;
> +#endif
> +	}
> +
> +	if (WARN_ON(!sysdev->dma_mask)) {
> +		/* Platform did not initialize dma_mask */
> +		ret =3D dma_coerce_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (pdev->dev.of_node)
> +		priv_match =3D of_device_get_match_data(&pdev->dev);
> +	else
> +		priv_match =3D dev_get_platdata(&pdev->dev);
> +
> +	return xhci_plat_probe(pdev, sysdev, priv_match); }
>=20
> -static int xhci_plat_remove(struct platform_device *dev)
> +int xhci_plat_remove(struct platform_device *dev)
>  {
>  	struct usb_hcd	*hcd =3D platform_get_drvdata(dev);
>  	struct xhci_hcd	*xhci =3D hcd_to_xhci(hcd);
> @@ -446,6 +417,7 @@ static int xhci_plat_remove(struct platform_device *d=
ev)
>=20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(xhci_plat_remove);
>=20
>  static int __maybe_unused xhci_plat_suspend(struct device *dev)  { @@ -
> 522,13 +494,14 @@ static int __maybe_unused xhci_plat_runtime_resume(stru=
ct
> device *dev)
>  	return xhci_resume(xhci, 0);
>  }
>=20
> -static const struct dev_pm_ops xhci_plat_pm_ops =3D {
> +const struct dev_pm_ops xhci_plat_pm_ops =3D {
>  	SET_SYSTEM_SLEEP_PM_OPS(xhci_plat_suspend, xhci_plat_resume)
>=20
>  	SET_RUNTIME_PM_OPS(xhci_plat_runtime_suspend,
>  			   xhci_plat_runtime_resume,
>  			   NULL)
>  };
> +EXPORT_SYMBOL_GPL(xhci_plat_pm_ops);
>=20
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id usb_xhci_acpi_match[] =3D { @@ -539,8
> +512,8 @@ static const struct acpi_device_id usb_xhci_acpi_match[] =3D {
> MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_match);  #endif
>=20
> -static struct platform_driver usb_xhci_driver =3D {
> -	.probe	=3D xhci_plat_probe,
> +static struct platform_driver usb_generic_xhci_driver =3D {
> +	.probe	=3D xhci_generic_plat_probe,
>  	.remove	=3D xhci_plat_remove,
>  	.shutdown =3D usb_hcd_platform_shutdown,
>  	.driver	=3D {
> @@ -555,13 +528,13 @@ MODULE_ALIAS("platform:xhci-hcd");
>  static int __init xhci_plat_init(void)
>  {
>  	xhci_init_driver(&xhci_plat_hc_driver, &xhci_plat_overrides);
> -	return platform_driver_register(&usb_xhci_driver);
> +	return platform_driver_register(&usb_generic_xhci_driver);
>  }
>  module_init(xhci_plat_init);
>=20
>  static void __exit xhci_plat_exit(void)  {
> -	platform_driver_unregister(&usb_xhci_driver);
> +	platform_driver_unregister(&usb_generic_xhci_driver);
>  }
>  module_exit(xhci_plat_exit);
>=20
> diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
> index 1fb149d1fbce..83b5b5aa9f8e 100644
> --- a/drivers/usb/host/xhci-plat.h
> +++ b/drivers/usb/host/xhci-plat.h
> @@ -21,4 +21,11 @@ struct xhci_plat_priv {
>=20
>  #define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->pr=
iv)
> #define xhci_to_priv(x) ((struct xhci_plat_priv *)(x)->priv)
> +
> +int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev,
> +		    const struct xhci_plat_priv *priv_match);
> +
> +int xhci_plat_remove(struct platform_device *dev); extern const struct
> +dev_pm_ops xhci_plat_pm_ops;
> +
>  #endif	/* _XHCI_PLAT_H */
> diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
> index aef0258a7160..7f18509a1d39 100644
> --- a/drivers/usb/host/xhci-rcar.c
> +++ b/drivers/usb/host/xhci-rcar.c
> @@ -10,12 +10,17 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/usb/phy.h>
>  #include <linux/sys_soc.h>
>=20
>  #include "xhci.h"
>  #include "xhci-plat.h"
> -#include "xhci-rcar.h"
> +#include "xhci-rzv2m.h"
> +
> +#define XHCI_RCAR_FIRMWARE_NAME_V1	"r8a779x_usb3_v1.dlmem"
> +#define XHCI_RCAR_FIRMWARE_NAME_V2	"r8a779x_usb3_v2.dlmem"
> +#define XHCI_RCAR_FIRMWARE_NAME_V3	"r8a779x_usb3_v3.dlmem"
>=20
>  /*
>  * - The V3 firmware is for almost all R-Car Gen3 (except r8a7795 ES1.x) =
@@
> -108,7 +113,7 @@ static int xhci_rcar_is_gen2(struct device *dev)
>  		of_device_is_compatible(node, "renesas,rcar-gen2-xhci");  }
>=20
> -void xhci_rcar_start(struct usb_hcd *hcd)
> +static void xhci_rcar_start(struct usb_hcd *hcd)
>  {
>  	u32 temp;
>=20
> @@ -203,7 +208,7 @@ static bool xhci_rcar_wait_for_pll_active(struct usb_=
hcd
> *hcd)  }
>=20
>  /* This function needs to initialize a "phy" of usb before */ -int
> xhci_rcar_init_quirk(struct usb_hcd *hcd)
> +static int xhci_rcar_init_quirk(struct usb_hcd *hcd)
>  {
>  	/* If hcd->regs is NULL, we don't just call the following function */
>  	if (!hcd->regs)
> @@ -215,7 +220,7 @@ int xhci_rcar_init_quirk(struct usb_hcd *hcd)
>  	return xhci_rcar_download_firmware(hcd);  }
>=20
> -int xhci_rcar_resume_quirk(struct usb_hcd *hcd)
> +static int xhci_rcar_resume_quirk(struct usb_hcd *hcd)
>  {
>  	int ret;
>=20
> @@ -225,3 +230,92 @@ int xhci_rcar_resume_quirk(struct usb_hcd *hcd)
>=20
>  	return ret;
>  }
> +
> +/*
> + * On R-Car Gen2 and Gen3, the AC64 bit (bit 0) of HCCPARAMS1 is set
> + * to 1. However, these SoCs don't support 64-bit address memory
> + * pointers. So, this driver clears the AC64 bit of xhci->hcc_params
> + * to call dma_set_coherent_mask(dev, DMA_BIT_MASK(32)) in
> + * xhci_gen_setup() by using the XHCI_NO_64BIT_SUPPORT quirk.
> + *
> + * And, since the firmware/internal CPU control the USBSTS.STS_HALT
> + * and the process speed is down when the roothub port enters U3,
> + * long delay for the handshake of STS_HALT is neeed in xhci_suspend()
> + * by using the XHCI_SLOW_SUSPEND quirk.
> + */
> +#define SET_XHCI_PLAT_PRIV_FOR_RCAR(firmware)				\
> +	.firmware_name =3D firmware,					\
> +	.quirks =3D XHCI_NO_64BIT_SUPPORT | XHCI_TRUST_TX_LENGTH |	\
> +		  XHCI_SLOW_SUSPEND,					\
> +	.init_quirk =3D xhci_rcar_init_quirk,				\
> +	.plat_start =3D xhci_rcar_start,					\
> +	.resume_quirk =3D xhci_rcar_resume_quirk,
> +
> +static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 =3D {
> +	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V1)
> +};
> +
> +static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 =3D {
> +	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V3)
> +};
> +
> +static const struct xhci_plat_priv xhci_plat_renesas_rzv2m =3D {
> +	.quirks =3D XHCI_NO_64BIT_SUPPORT | XHCI_TRUST_TX_LENGTH |
> +		  XHCI_SLOW_SUSPEND,
> +	.init_quirk =3D xhci_rzv2m_init_quirk,
> +	.plat_start =3D xhci_rzv2m_start,
> +};
> +
> +static const struct of_device_id usb_xhci_of_match[] =3D {
> +	{
> +		.compatible =3D "renesas,xhci-r8a7790",
> +		.data =3D &xhci_plat_renesas_rcar_gen2,
> +	}, {
> +		.compatible =3D "renesas,xhci-r8a7791",
> +		.data =3D &xhci_plat_renesas_rcar_gen2,
> +	}, {
> +		.compatible =3D "renesas,xhci-r8a7793",
> +		.data =3D &xhci_plat_renesas_rcar_gen2,
> +	}, {
> +		.compatible =3D "renesas,xhci-r8a7795",
> +		.data =3D &xhci_plat_renesas_rcar_gen3,
> +	}, {
> +		.compatible =3D "renesas,xhci-r8a7796",
> +		.data =3D &xhci_plat_renesas_rcar_gen3,
> +	}, {
> +		.compatible =3D "renesas,rcar-gen2-xhci",
> +		.data =3D &xhci_plat_renesas_rcar_gen2,
> +	}, {
> +		.compatible =3D "renesas,rcar-gen3-xhci",
> +		.data =3D &xhci_plat_renesas_rcar_gen3,
> +	}, {
> +		.compatible =3D "renesas,rzv2m-xhci",
> +		.data =3D &xhci_plat_renesas_rzv2m,
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
> +
> +static int xhci_renesas_probe(struct platform_device *pdev) {
> +	const struct xhci_plat_priv *priv_match;
> +
> +	priv_match =3D of_device_get_match_data(&pdev->dev);
> +
> +	return xhci_plat_probe(pdev, NULL, priv_match); }
> +
> +static struct platform_driver usb_xhci_renesas_driver =3D {
> +	.probe	=3D xhci_renesas_probe,
> +	.remove	=3D xhci_plat_remove,
> +	.shutdown =3D usb_hcd_platform_shutdown,
> +	.driver	=3D {
> +		.name =3D "xhci-renesas-hcd",
> +		.pm =3D &xhci_plat_pm_ops,
> +		.of_match_table =3D of_match_ptr(usb_xhci_of_match),
> +	},
> +};
> +module_platform_driver(usb_xhci_renesas_driver);
> +
> +MODULE_DESCRIPTION("xHCI Platform Host Controller Driver for Renesas
> +R-Car and RZ"); MODULE_LICENSE("GPL");
> diff --git a/drivers/usb/host/xhci-rcar.h b/drivers/usb/host/xhci-rcar.h
> deleted file mode 100644 index 048ad3b8a6c7..000000000000
> --- a/drivers/usb/host/xhci-rcar.h
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * drivers/usb/host/xhci-rcar.h
> - *
> - * Copyright (C) 2014 Renesas Electronics Corporation
> - */
> -
> -#ifndef _XHCI_RCAR_H
> -#define _XHCI_RCAR_H
> -
> -#define XHCI_RCAR_FIRMWARE_NAME_V1	"r8a779x_usb3_v1.dlmem"
> -#define XHCI_RCAR_FIRMWARE_NAME_V2	"r8a779x_usb3_v2.dlmem"
> -#define XHCI_RCAR_FIRMWARE_NAME_V3	"r8a779x_usb3_v3.dlmem"
> -
> -#if IS_ENABLED(CONFIG_USB_XHCI_RCAR)
> -void xhci_rcar_start(struct usb_hcd *hcd); -int xhci_rcar_init_quirk(str=
uct
> usb_hcd *hcd); -int xhci_rcar_resume_quirk(struct usb_hcd *hcd); -#else -
> static inline void xhci_rcar_start(struct usb_hcd *hcd) -{ -}
> -
> -static inline int xhci_rcar_init_quirk(struct usb_hcd *hcd) -{
> -	return 0;
> -}
> -
> -static inline int xhci_rcar_resume_quirk(struct usb_hcd *hcd) -{
> -	return 0;
> -}
> -#endif
> -
> -/*
> - * On R-Car Gen2 and Gen3, the AC64 bit (bit 0) of HCCPARAMS1 is set
> - * to 1. However, these SoCs don't support 64-bit address memory
> - * pointers. So, this driver clears the AC64 bit of xhci->hcc_params
> - * to call dma_set_coherent_mask(dev, DMA_BIT_MASK(32)) in
> - * xhci_gen_setup() by using the XHCI_NO_64BIT_SUPPORT quirk.
> - *
> - * And, since the firmware/internal CPU control the USBSTS.STS_HALT
> - * and the process speed is down when the roothub port enters U3,
> - * long delay for the handshake of STS_HALT is neeed in xhci_suspend()
> - * by using the XHCI_SLOW_SUSPEND quirk.
> - */
> -#define SET_XHCI_PLAT_PRIV_FOR_RCAR(firmware)				\
> -	.firmware_name =3D firmware,					\
> -	.quirks =3D XHCI_NO_64BIT_SUPPORT | XHCI_TRUST_TX_LENGTH |	\
> -		  XHCI_SLOW_SUSPEND,					\
> -	.init_quirk =3D xhci_rcar_init_quirk,				\
> -	.plat_start =3D xhci_rcar_start,					\
> -	.resume_quirk =3D xhci_rcar_resume_quirk,
> -
> -#endif /* _XHCI_RCAR_H */
> --
> 2.39.0

