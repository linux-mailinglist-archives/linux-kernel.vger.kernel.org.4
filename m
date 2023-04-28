Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC146F133A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345508AbjD1I0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjD1I00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:26:26 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931131BE4;
        Fri, 28 Apr 2023 01:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNXcv/vKzgUvEmDAerumkZQgQJ2BaMeVKvm/urv60aGRpuF/2MEuTy9jHbNPpHSx6GqzlCH7lbir7TUUPKJ053RdwV6+vAwobgzk1NXEkSlX5Q5w2mwhvufYcrlKfKda7CcBPBbj4WnAK4ZvgulwKT/qWtD/FA538/PeumARJazgy0vgWdnybnVA5fKTYO0tEzZpTJ8bi/JxEj0t0MlLn6E58AkIeLiBb/EjiKbg+8BYeWADuGGRtbfAcN9DAWyw+8rIw7jqnEN4Dk+XB5J0zRsGdvH0IJnio7Y3ovDC8Gml1KoOnCvMeDiNlMuCGDzV+KuAoUL+oPBfJcxdyvpk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O56iz4bl4TB0/z/3gbnUzmhx1dIhF85FVOfYloWrsis=;
 b=iWlNtTq1WKvbYTSL4PPajiPNzko7UW+TyAXU+kIcQzd3wQaAMy+BFc5mLXwsrL4zdIDbTAh/F0QrBoiKMuOdc6+kv2LBNnYrUWcUskDMlP0b4uLee0fnt0OIO54pz2O2VQL1uXUyY4sy/sZCUQaf1oyZ6vGy5Pibq0AKQFp3VjwGERPZxFNwJ4I/FV1x64AMle55Y0J3+mYGHr8x2yiy0bW+EwBjsp8m4yYoZkYyJo1P2UgIy0zQCqWcKWAedXE5ZMIrzFFWHGnTWDBuwJ5XhA9av7lsltkJu/fcM7RaCtU7f++dEcVG+6tE6xv9wpYOIcjrdcr/S4GfUq5MZHGGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=sequanux.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O56iz4bl4TB0/z/3gbnUzmhx1dIhF85FVOfYloWrsis=;
 b=Q6aSyMH/szoomfUCBVY4JjNyx+qTCVFw2BXRNSuZEWU6pghAgrQBEJHrbb3zyUU1JRLmZXlvuRRIID5PJwo20LthJJYm3Ei9gR7JoJf9FGTe+84C+OVKZiUCEQekUQES+vnesHUF/VFyoc4UIjPjzuPXvx6mUMCmw8+YZxn44Zijprhd+Qtk7AetcKejsPKkNCPOmB9pFgW924q0FpZsfuzOpoWMcrteBqm7wWXwC8uVnxQevOS7FqjKfY0oLqzSXadINxjJ8XlMwJsBIbh2VYBHIVlrCKOZg14HIn2hXn8eKpcKNypKbBhk+Q+hU5QT+X38fWneFyyKjT/OtW0WQA==
Received: from DBBPR09CA0001.eurprd09.prod.outlook.com (2603:10a6:10:c0::13)
 by DB8PR10MB3308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 08:26:22 +0000
Received: from DB5EUR01FT053.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:c0:cafe::ab) by DBBPR09CA0001.outlook.office365.com
 (2603:10a6:10:c0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 08:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT053.mail.protection.outlook.com (10.152.5.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.23 via Frontend Transport; Fri, 28 Apr 2023 08:26:21 +0000
Received: from CNPEK01M04MSX.ad011.siemens.net (139.24.237.221) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.25; Fri, 28 Apr 2023 10:26:21 +0200
Received: from CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) by
 CNPEK01M04MSX.ad011.siemens.net (139.24.237.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 16:26:18 +0800
Received: from CNPEK01M09MSX.ad011.siemens.net ([139.24.237.227]) by
 CNPEK01M09MSX.ad011.siemens.net ([139.24.237.227]) with mapi id
 15.01.2507.023; Fri, 28 Apr 2023 16:26:18 +0800
From:   "Wu, Xing Tong" <XingTong.Wu@siemens.com>
To:     'Simon Guinot' <simon.guinot@sequanux.org>,
        "Schild, Henning" <henning.schild@siemens.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v2 1/1] gpio-f7188x: fix chip name and pin count on
 Nuvoton chip
Thread-Topic: [PATCH v2 1/1] gpio-f7188x: fix chip name and pin count on
 Nuvoton chip
Thread-Index: AQHZeRvl0AD5D1IKf0epIRcVNiVl2q8/24YAgACHyyA=
Date:   Fri, 28 Apr 2023 08:26:18 +0000
Message-ID: <759b2df004e2445e850a01b33e748972@siemens.com>
References: <20230427152055.18380-1-henning.schild@siemens.com>
 <20230427152055.18380-2-henning.schild@siemens.com>
 <ZEuBMCxeWAx9OilV@76cbfcf04d45>
In-Reply-To: <ZEuBMCxeWAx9OilV@76cbfcf04d45>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-28T08:26:14Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=4a168f95-aeb4-44f6-a3a1-36209d9d507c;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
x-originating-ip: [140.231.151.68]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT053:EE_|DB8PR10MB3308:EE_
X-MS-Office365-Filtering-Correlation-Id: b452ec2e-a1ac-4801-733f-08db47c23f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 067NV6/Rm3bxVZgfUCHiWNZ/lVpoy7O7gRdHlX7IB3pVMwRMjjV0w9YATqyVl4YQBt/teXFzZ/hkWOuMBNKYAHb5sOqUMN4HzIw3Lycp8pqeR++jy3UMavs03sYsYPtRaLtuJN/dCAa2QEFUF22EaDGHj4COJEQAxhTC/KjtseO7ff3DwO7YlVO+T+OEohVUFUvizJiTlBin87a0x6AuLv/d06xwsgtocuRrJx3FATgPggWFIxqNGxS2ftmlCZw0xg6hzU2nutIXWibjUM4vP6vTRo+oSkWTkReGnF1Ywu7gCDeBg9j6pCZN0/71s7kpAi7NJ5OMj1o0tsZTYPZznOwfFXZ8ka7o3Bs4YfodqFmuEK34kAesT4KUEWPkTjSDPDbD2gXYTZxFHVRBb/lKfr9sEM2Ywvf7aCRWcPb8+Fur7AVl4UpdDPh7vltnuC8SfBg7YO8/ShVso+DTyJ+CQ4Tx/IrzwNkV/U6OG7P2k91G6fDVc6T/87PqZ6rHfETQXBPbQpSEdlK0Rdr4FzHjrGAI/INjCZNVaBLtoqOJHFvMgmEcGRKaLYrZqXR5oCcRN1JbH8gbyUBSwc3w4pJ2x4acEJGBes2JlMgiYgzwB6tcJ1uYI+JxTVpPe3u18bplQ0xtovu/p1kVWatVwp9ZaVNlwPguBLOAytb5hbODu2F3als/EFEdIbJxR/gl2a88Ac1fV3q/6u68XpXFwUCjmdZU2cxjwKnXGkeLWbPh+ww=
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(8936002)(5660300002)(8676002)(40460700003)(70586007)(4326008)(86362001)(70206006)(81166007)(41300700001)(316002)(356005)(82740400003)(82960400001)(40480700001)(2906002)(53546011)(186003)(26005)(36756003)(24736004)(108616005)(83380400001)(36860700001)(336012)(82310400005)(956004)(2616005)(110136005)(47076005)(54906003)(478600001)(6636002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 08:26:21.8786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b452ec2e-a1ac-4801-733f-08db47c23f9d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT053.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3308
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

The chip id of NCT6116D is 0XD281, you can refer to NCT6116D_Datasheet_V1_0=
.pdf, Page 291

BRS
Xing Tong Wu

-----Original Message-----
From: Simon Guinot <simon.guinot@sequanux.org>=20
Sent: Friday, April 28, 2023 4:18 PM
To: Schild, Henning (T CED SES-DE) <henning.schild@siemens.com>
Cc: Linus Walleij <linus.walleij@linaro.org>; Bartosz Golaszewski <brgl@bgd=
ev.pl>; linux-gpio@vger.kernel.org; linux-kernel@vger.kernel.org; Hans de G=
oede <hdegoede@redhat.com>; Andy Shevchenko <andriy.shevchenko@linux.intel.=
com>; Wu, Xing Tong (DI FA CTR IPC CN PRC4) <XingTong.Wu@siemens.com>
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix chip name and pin count on Nuv=
oton chip

On Thu, Apr 27, 2023 at 05:20:55PM +0200, Henning Schild wrote:
> In fact the device with chip id 0xD283 is called NCT6126D, and that is=20
> the chip id the Nuvoton code was written for. Correct that name to=20
> avoid confusion, because a NCT6116D in fact exists as well but has=20
> another chip id, and is currently not supported.
>=20
> The look at the spec also revealed that GPIO group7 in fact has 8=20
> pins, so correct the pin count in that group as well.
>=20
> Fixes: d0918a84aff0 ("gpio-f7188x: Add GPIO support for Nuvoton=20
> NCT6116")
> Reported-by: Xing Tong Wu <xingtong.wu@siemens.com>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

Acked-by: Simon Guinot <simon.guinot@sequanux.org>

> ---
>  drivers/gpio/Kconfig       |  2 +-
>  drivers/gpio/gpio-f7188x.c | 28 ++++++++++++++--------------
>  2 files changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig index=20
> badbe0582318..14b655411aa0 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -879,7 +879,7 @@ config GPIO_F7188X
>  	help
>  	  This option enables support for GPIOs found on Fintek Super-I/O
>  	  chips F71869, F71869A, F71882FG, F71889F and F81866.
> -	  As well as Nuvoton Super-I/O chip NCT6116D.
> +	  As well as Nuvoton Super-I/O chip NCT6126D.
> =20
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called f7188x-gpio.
> diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c=20
> index 9effa7769bef..f54ca5a1775e 100644
> --- a/drivers/gpio/gpio-f7188x.c
> +++ b/drivers/gpio/gpio-f7188x.c
> @@ -48,7 +48,7 @@
>  /*
>   * Nuvoton devices.
>   */
> -#define SIO_NCT6116D_ID		0xD283  /* NCT6116D chipset ID */
> +#define SIO_NCT6126D_ID		0xD283  /* NCT6126D chipset ID */
> =20
>  #define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO logical device */
> =20
> @@ -62,7 +62,7 @@ enum chips {
>  	f81866,
>  	f81804,
>  	f81865,
> -	nct6116d,
> +	nct6126d,
>  };
> =20
>  static const char * const f7188x_names[] =3D { @@ -74,7 +74,7 @@ static=
=20
> const char * const f7188x_names[] =3D {
>  	"f81866",
>  	"f81804",
>  	"f81865",
> -	"nct6116d",
> +	"nct6126d",
>  };
> =20
>  struct f7188x_sio {
> @@ -187,8 +187,8 @@ static int f7188x_gpio_set_config(struct gpio_chip=20
> *chip, unsigned offset,
>  /* Output mode register (0:open drain 1:push-pull). */  #define=20
> f7188x_gpio_out_mode(base) ((base) + 3)
> =20
> -#define f7188x_gpio_dir_invert(type)	((type) =3D=3D nct6116d)
> -#define f7188x_gpio_data_single(type)	((type) =3D=3D nct6116d)
> +#define f7188x_gpio_dir_invert(type)	((type) =3D=3D nct6126d)
> +#define f7188x_gpio_data_single(type)	((type) =3D=3D nct6126d)
> =20
>  static struct f7188x_gpio_bank f71869_gpio_bank[] =3D {
>  	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"), @@ -274,7 +274,7 @@=20
> static struct f7188x_gpio_bank f81865_gpio_bank[] =3D {
>  	F7188X_GPIO_BANK(60, 5, 0x90, DRVNAME "-6"),  };
> =20
> -static struct f7188x_gpio_bank nct6116d_gpio_bank[] =3D {
> +static struct f7188x_gpio_bank nct6126d_gpio_bank[] =3D {
>  	F7188X_GPIO_BANK(0, 8, 0xE0, DRVNAME "-0"),
>  	F7188X_GPIO_BANK(10, 8, 0xE4, DRVNAME "-1"),
>  	F7188X_GPIO_BANK(20, 8, 0xE8, DRVNAME "-2"), @@ -282,7 +282,7 @@=20
> static struct f7188x_gpio_bank nct6116d_gpio_bank[] =3D {
>  	F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
>  	F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
>  	F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
> -	F7188X_GPIO_BANK(70, 1, 0xFC, DRVNAME "-7"),
> +	F7188X_GPIO_BANK(70, 8, 0xFC, DRVNAME "-7"),
>  };
> =20
>  static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned=20
> offset) @@ -490,9 +490,9 @@ static int f7188x_gpio_probe(struct platform_=
device *pdev)
>  		data->nr_bank =3D ARRAY_SIZE(f81865_gpio_bank);
>  		data->bank =3D f81865_gpio_bank;
>  		break;
> -	case nct6116d:
> -		data->nr_bank =3D ARRAY_SIZE(nct6116d_gpio_bank);
> -		data->bank =3D nct6116d_gpio_bank;
> +	case nct6126d:
> +		data->nr_bank =3D ARRAY_SIZE(nct6126d_gpio_bank);
> +		data->bank =3D nct6126d_gpio_bank;
>  		break;
>  	default:
>  		return -ENODEV;
> @@ -559,9 +559,9 @@ static int __init f7188x_find(int addr, struct f7188x=
_sio *sio)
>  	case SIO_F81865_ID:
>  		sio->type =3D f81865;
>  		break;
> -	case SIO_NCT6116D_ID:
> +	case SIO_NCT6126D_ID:
>  		sio->device =3D SIO_LD_GPIO_NUVOTON;
> -		sio->type =3D nct6116d;
> +		sio->type =3D nct6126d;
>  		break;
>  	default:
>  		pr_info("Unsupported Fintek device 0x%04x\n", devid); @@ -569,7=20
> +569,7 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
>  	}
> =20
>  	/* double check manufacturer where possible */
> -	if (sio->type !=3D nct6116d) {
> +	if (sio->type !=3D nct6126d) {
>  		manid =3D superio_inw(addr, SIO_FINTEK_MANID);
>  		if (manid !=3D SIO_FINTEK_ID) {
>  			pr_debug("Not a Fintek device at 0x%08x\n", addr); @@ -581,7=20
> +581,7 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
>  	err =3D 0;
> =20
>  	pr_info("Found %s at %#x\n", f7188x_names[sio->type], (unsigned int)add=
r);
> -	if (sio->type !=3D nct6116d)
> +	if (sio->type !=3D nct6126d)
>  		pr_info("   revision %d\n", superio_inb(addr, SIO_FINTEK_DEVREV));
> =20
>  err:
> --
> 2.39.2
