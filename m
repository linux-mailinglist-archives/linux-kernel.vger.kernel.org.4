Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8701717622
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjEaF0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjEaF0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:26:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C69EE;
        Tue, 30 May 2023 22:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS/qOA17MswulaVv93jon3c/4Eeg7R2cIbpvgGoIZd8Tj1ReywUDm+wAiIav4AoDn+4tS3gvpLrpIOcvalrXVAOImNdD9vgHiWiL1iGPqsg+SDisVd8xdGLNGstMEqruvz2AmMK5Y0moyHJBvnCazAXHwQgXb6HxNMGl2amUQ1TNrwkfQ4TFLwKSJen7+VRLtv10Eq0/Iyw4x7clMOZsZWUA/2WJ4vQJnMztfNJcRBr+8Kga336A5bV7S4zjieujrAUsUsiGal/F1v0zlIyNLwrz+aV3Wf2LTkatDJPddmHgkjoUMQXhswj1IgmiYKd5jBaTXkU9Ql2G6JFuGwtgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/Fx8Z5aOiiqgX7FjcpS8H0+wTPJ0Vc68JAglgSWOCY=;
 b=JFoRe4qHMQWJgnz4fpsZ2OekA+0w4D3zSjG1e2rkWfNILvInjdTNmNp+Cn8GrU5+8MX7mDBkCsKZpjYDiJV5NROL/DKoWHUa9FZJeoY7fYtNSjywTm1TxHU/IxnqwEIiXQWyEU5cWLHRlweLqXYsepvZHJ9JLlD15+5QiungXKb3V/L2H5WtN2t6kqbZ38d7DIqayMy8nS5C8+2yEAv49F4GjQlGJc8UEd/OzOn+QhAjeKTIgI9p0rlnHFvU190xhmCxVgDI/pMuLr0iHlehSz/60uQIU2JPbAO5+U6YGUdYaAl5BGUUiMgQUHdVJ6Az+vEuuUCR+R/qZ4P3qz2+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/Fx8Z5aOiiqgX7FjcpS8H0+wTPJ0Vc68JAglgSWOCY=;
 b=AGHhDoNbQT39noxHL+s21tDv2ppKthh01f+RGhH5Vt9bPWnNHw4qcvtJ9a9bp0xvvNBtT4zz7ExbW6MhxbCoJsrzne9lIwDQkbg8B60m16/7gk8SUDwLw0Z/VPt3TgyJgjb6b0ZSyJagjjUl4YbMOQKBAJTqU5r4UPz8xmNIMh8=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 05:26:47 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::b65d:f33d:c4f:94d0]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::b65d:f33d:c4f:94d0%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 05:26:47 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "sanyog.r.kale@intel.com" <sanyog.r.kale@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v2 5/6] spi: cs42l43: Add SPI controller support
Thread-Topic: [PATCH v2 5/6] spi: cs42l43: Add SPI controller support
Thread-Index: AQHZkvFOxnymbIC5RUqFNdNVbAs5OK9z2k7g
Date:   Wed, 31 May 2023 05:26:46 +0000
Message-ID: <BN7PR12MB28024FF756EFAE44E1713FBDDC489@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20230530122112.1314458-1-ckeepax@opensource.cirrus.com>
 <20230530122112.1314458-6-ckeepax@opensource.cirrus.com>
In-Reply-To: <20230530122112.1314458-6-ckeepax@opensource.cirrus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|CY5PR12MB9055:EE_
x-ms-office365-filtering-correlation-id: 48ef444d-6b3f-4572-f9b7-08db6197a0cc
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0QRxbK6zw9UGy/bRObHY6RgPhTPglES3Phs/Ihzlj/M0AHMc3LLbJwINwXomMjiRqn7N3oHO/xYIR+WtwlcAygT7E8KPYlmK+CZKFHCdcC/DCiI6bAzpk1FONckEx5obghZNMDOsstQ3wqPZ+wgDMVGKT2Z1oBk5qbPtDd4ZlN/urfzl9tZNuIHgEKPAApoWhbyEma7R/R+VTJudse6EEpp6zJ2Rn94rk7GC6oaW3VH7K9FQUiVFwOAXPoujdkfTEB4hEIIekQ69pMxD/Nuhh1H1uMB0D0XEpSZOD0TcQuQVXM6oklmwoqv35aHziSUknFkUlqXuss+cTR0iIp6slL1MUDsHGoS4m3oZ5tmQzdSg5jbkTugxne0xeRXjuadXU5sLSElXOSZFs+GKG3lChcOn2D7VCdHJetNwKMNitqT/bScZ6LQXmu0A5dtMYZELiiju9WLuloodC7KuhpTl26Zg6LsfY/FWsaNoxnfk3KBkWNuoYpOalyQFU4dsHeqZTappvA697T38WIa8u9FgOs9f/L4NgtHqK75k+ezMbD9T5XUhJCGsJVvT+Wwb4L9T2aWg+KrBX4oa/62L8UvcfkTsHe6VE4bIWLkcj8OFtI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(2906002)(30864003)(83380400001)(86362001)(33656002)(38070700005)(38100700002)(122000001)(55016003)(8936002)(8676002)(7416002)(5660300002)(52536014)(4326008)(316002)(71200400001)(76116006)(66946007)(66556008)(66476007)(64756008)(66446008)(966005)(41300700001)(7696005)(6506007)(26005)(186003)(9686003)(54906003)(110136005)(53546011)(478600001)(19627235002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?89tTptEP87A/XEimLjX4Lnv2+lzmKKQctPTKAg2qoQTGNlizRHRysLtoO2HJ?=
 =?us-ascii?Q?ATjeP8hOhXzB4YwgiOR3zb3rhESP2sajJWGA5NDqFRKrlqkmehbTXGCqKvnu?=
 =?us-ascii?Q?+E4pENfeGpBPQi7g1gLZlRd1dtEYR8EPn/bW3Nwwn2F5VO1ZBR2cvGnT7BS/?=
 =?us-ascii?Q?s02pAtXny0sPmHTlDefoFLu116wzK5UOkGd1+FUt2nXThCtLY4VCW5xGqqQq?=
 =?us-ascii?Q?Pm0pR4uMN6Cm4vY6SbxIvpKfQ/mzCLwffQvo3+tTLDnjhN+o+CGx5OOFvvsh?=
 =?us-ascii?Q?j4dLXfRwdEnNHaX9pu/0RtXphaeuM4HiSYmfBO7Pdc36pVkf7VWUL3VFPduX?=
 =?us-ascii?Q?JqtQyVMYKHUH5tulVF5Eg4ujtj+0zJ9VOKI+Vs2/93X1APJfmGwB5srAZwuY?=
 =?us-ascii?Q?wgpZOMrC1sJhCL8+/3Ub5oRafyZte2Q8GexHjAAZ/5Gt7/3ZZXJHEBgySmrq?=
 =?us-ascii?Q?MaC3Wk/DGa9tfRVralNNjyDaXim9fjNePHl4UseWZxctJVzi8yCmNsGyqu8g?=
 =?us-ascii?Q?rn2fJrZjxf+1cv8zNfjpcmkgy+Kd4j0dxTL+o7S8tt2euZB+KaxKbvhA1HCp?=
 =?us-ascii?Q?Xje74kfhCyXWqH9zZCMP8IFrT1bUvPyxo91/0ysAN+RqfFHl7MB2sAH8VPxk?=
 =?us-ascii?Q?LUMy8zp7Wo+Bl7x6UzduuHyoOQCG+tdHq0T3GVRryq7XSlLQ0LFMFuCH9nfy?=
 =?us-ascii?Q?9i1HNX29Li/LPl5ISIw3khZT8rGkBSYe/KWD4fQEs8AWB0yBrpJed1cQtlIh?=
 =?us-ascii?Q?Va6+ZufqVLrEtJ0bcfY5z/JW+KfiE9nCFzLGz2gdDvyYtCf82Hpw36wlR1xe?=
 =?us-ascii?Q?9CgxFMe9RS5JFEDvaTKohuktEjrdgAHEJ0aKUFNBZRaEM5zryoXPkqhdyP9D?=
 =?us-ascii?Q?VphnqN6fQbByKwU6pfxENlT+RBrWDaELZB4SKfgCzyYOZqN+NJjipymf7pJf?=
 =?us-ascii?Q?Hy1gGxYtDV7eTKwQQX61RBlwNjoDCGjHGJpGx0rf/5l24hIqVHrhKAIZ5t5e?=
 =?us-ascii?Q?zBpj5n4Qw/BmK2LV1t1h7MmsrRYHt4LNA0A2cV9N+UlHT9LEGq5IqGe/SMgP?=
 =?us-ascii?Q?nw1sv0STGZv9mswBh0KyvcxWen1jHqBmo9c7KpZJoGOZraWDvloJJ3o4+ppJ?=
 =?us-ascii?Q?1Qv/vc4BV0d6xHtU+yPEzTr/GircB4OHkqhdt+TxVU5tTl2TVhqCHft3B+8W?=
 =?us-ascii?Q?d9F3du52UafS95eQPtUxTj80mHdjgq3de1ZKr+MJC8WUbiYtzSgJGUTbF1FO?=
 =?us-ascii?Q?nEXc/ZWTKDpb1Cxa64apkzjk3n1zVRw6XPQxFf9C47k5dsxNWqVzW4ql5c75?=
 =?us-ascii?Q?Qma3An6S+rYRq+WXM6kHK0U2EwVz6JrJOtcBbAiTn4/ClfWmOyBBxGGNooWR?=
 =?us-ascii?Q?8eVQoBcnsoBfk4XeL63LOlm9hy3syQ4jz33G6Jaz6mX3NAgc64hnXrnEB5g3?=
 =?us-ascii?Q?UgpyTUbmaOLoCa4HfQtuX+90aHYnLR0j58AieeNUWROU3wC7STtOYkxPODBl?=
 =?us-ascii?Q?676dY/DMyZMMaIC6gBTl+Br+Vu0lslkfXXalBZJG1VUlN1M9/m3Se8jQWibf?=
 =?us-ascii?Q?O3go+xHwYvQ89lh42B0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ef444d-6b3f-4572-f9b7-08db6197a0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 05:26:46.8595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sFz6yLWYEg7RNFYo8aTWSlDlQH4r/rmkkw78Gm49Nc2gWI/V0jqvtDjM3b/YC2fwv4m04NK8Yppshbwioh9cWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


> -----Original Message-----
> From: Charles Keepax <ckeepax@opensource.cirrus.com>
> Sent: Tuesday, May 30, 2023 5:51 PM
> To: broonie@kernel.org; lee@kernel.org; krzysztof.kozlowski+dt@linaro.org=
;
> linus.walleij@linaro.org; vkoul@kernel.org
> Cc: robh+dt@kernel.org; conor+dt@kernel.org; lgirdwood@gmail.com; yung-
> chuan.liao@linux.intel.com; sanyog.r.kale@intel.com; pierre-
> louis.bossart@linux.intel.com; alsa-devel@alsa-project.org;
> patches@opensource.cirrus.com; devicetree@vger.kernel.org; linux-
> gpio@vger.kernel.org; linux-spi@vger.kernel.org; linux-kernel@vger.kernel=
.org
> Subject: [PATCH v2 5/6] spi: cs42l43: Add SPI controller support
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>=20
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed for
> portable applications. It provides a high dynamic range, stereo DAC for
> headphone output, two integrated Class D amplifiers for loudspeakers, and
> two ADCs for wired headset microphone input or stereo line input. PDM
> inputs are provided for digital microphones.
>=20
> The SPI component incorporates a SPI controller interface for communicati=
on
> with other peripheral components.
>=20
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>=20
> Changes since v1:
>  - Use HZ_PER_MHZ
>  - Return ret in un/prepare_transfer_hardware
>  - Use SPI_MODE_X_MASK
>  - Use devm_pm_runtime_enable
>  - Switch to using a platform_device_id table
>  - Use device_set_node
>  - Use min rather than min_t, and updating some consts to make it work
>=20
> Thanks,
> Charles
>=20
>  MAINTAINERS               |   1 +
>  drivers/spi/Kconfig       |   7 +
>  drivers/spi/Makefile      |   1 +
>  drivers/spi/spi-cs42l43.c | 279 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 288 insertions(+)
>  create mode 100644 drivers/spi/spi-cs42l43.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ed26f63087342..a30dfbeb4f57a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4930,6 +4930,7 @@ F:
> Documentation/devicetree/bindings/mfd/cirrus,cs*
>  F:     Documentation/devicetree/bindings/sound/cirrus,cs*
>  F:     drivers/mfd/cs42l43*
>  F:     drivers/pinctrl/cirrus/pinctrl-cs42l43*
> +F:     drivers/spi/spi-cs42l43*
>  F:     include/dt-bindings/sound/cs*
>  F:     include/linux/mfd/cs42l43*
>  F:     include/sound/cs*
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig index
> 3de2ebe8294aa..f6ce06de41051 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -281,6 +281,13 @@ config SPI_COLDFIRE_QSPI
>           This enables support for the Coldfire QSPI controller in master
>           mode.
>=20
> +config SPI_CS42L43
> +       tristate "Cirrus Logic CS42L43 SPI controller"
> +       depends on MFD_CS42L43 && PINCTRL_CS42L43
> +       help
> +         This enables support for the SPI controller inside the Cirrus L=
ogic
> +         CS42L43 audio codec.
> +
>  config SPI_DAVINCI
>         tristate "Texas Instruments DaVinci/DA8x/OMAP-L/AM1x SoC SPI
> controller"
>         depends on ARCH_DAVINCI || ARCH_KEYSTONE || COMPILE_TEST diff --
> git a/drivers/spi/Makefile b/drivers/spi/Makefile index
> 28c4817a8a74a..49937ea0d73d0 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_SPI_CADENCE_QUADSPI)     +=3D spi-
> cadence-quadspi.o
>  obj-$(CONFIG_SPI_CADENCE_XSPI)         +=3D spi-cadence-xspi.o
>  obj-$(CONFIG_SPI_CLPS711X)             +=3D spi-clps711x.o
>  obj-$(CONFIG_SPI_COLDFIRE_QSPI)                +=3D spi-coldfire-qspi.o
> +obj-$(CONFIG_SPI_CS42L43)              +=3D spi-cs42l43.o
>  obj-$(CONFIG_SPI_DAVINCI)              +=3D spi-davinci.o
>  obj-$(CONFIG_SPI_DLN2)                 +=3D spi-dln2.o
>  obj-$(CONFIG_SPI_DESIGNWARE)           +=3D spi-dw.o
> diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c new fi=
le mode
> 100644 index 0000000000000..5f86f4feb22c8
> --- /dev/null
> +++ b/drivers/spi/spi-cs42l43.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// CS42L43 SPI Controller Driver
> +//
> +// Copyright (C) 2022-2023 Cirrus Logic, Inc. and
> +//                         Cirrus Logic International Semiconductor Ltd.
> +
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/mfd/cs42l43.h>
> +#include <linux/mfd/cs42l43-regs.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +
> +#define CS42L43_FIFO_SIZE              16
> +#define CS42L43_SPI_ROOT_HZ            (4 * HZ_PER_MHZ)
> +#define CS42L43_SPI_MAX_LENGTH         65532
> +
> +enum cs42l43_spi_cmd {
> +       CS42L43_WRITE,
> +       CS42L43_READ
> +};
> +
> +struct cs42l43_spi {
> +       struct device *dev;
> +       struct regmap *regmap;
> +       struct spi_controller *ctlr;
> +};
> +
> +static unsigned int cs42l43_clock_divs[16] =3D {
> +       2, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
> +
> +static int cs42l43_spi_tx(struct regmap *regmap, const u8 *buf,
> +unsigned int len) {
> +       const u8 *end =3D buf + len;
> +       u32 val;
> +       int ret;
> +
> +       while (buf < end) {
> +               const u8 *block =3D min(buf + CS42L43_FIFO_SIZE, end);
> +
> +               for (; buf < block - (sizeof(u32) - 1); buf +=3D sizeof(u=
32))
> +                       regmap_write(regmap, CS42L43_TX_DATA, *(const
> + u32 *)buf);
> +
> +               if (buf < block) {
> +                       unsigned int residue =3D end - buf;
> +
> +                       memcpy(&val, buf, residue);
> +                       regmap_write(regmap, CS42L43_TX_DATA, val);
> +                       buf +=3D residue;
> +               }
> +
> +               regmap_write(regmap, CS42L43_TRAN_CONFIG8,
> + CS42L43_SPI_TX_DONE_MASK);
> +
> +               ret =3D regmap_read_poll_timeout(regmap, CS42L43_TRAN_STA=
TUS1,
> +                                              val, (val & CS42L43_SPI_TX=
_REQUEST_MASK),
> +                                              1000, 5000);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cs42l43_spi_rx(struct regmap *regmap, u8 *buf, unsigned int
> +len) {
> +       u8 *end =3D buf + len;
> +       u32 val;
> +       int ret;
> +
> +       while (buf < end) {
> +               const u8 *block =3D min(buf + CS42L43_FIFO_SIZE, end);
> +
> +               ret =3D regmap_read_poll_timeout(regmap, CS42L43_TRAN_STA=
TUS1,
> +                                              val, (val & CS42L43_SPI_RX=
_REQUEST_MASK),
> +                                              1000, 5000);
> +               if (ret)
> +                       return ret;
> +
> +               for (; buf < block - (sizeof(u32) - 1); buf +=3D sizeof(u=
32)) {
> +                       ret =3D regmap_read(regmap, CS42L43_RX_DATA, (u32=
 *)buf);
> +                       if (ret)
> +                               return ret;
> +               }
> +
> +               if (buf < block) {
> +                       unsigned int residue =3D end - buf;
> +
> +                       ret =3D regmap_read(regmap, CS42L43_RX_DATA, &val=
);
> +                       if (ret)
> +                               return ret;
> +
> +                       memcpy(buf, &val, residue);
> +                       buf +=3D residue;
> +               }
> +
> +               regmap_write(regmap, CS42L43_TRAN_CONFIG8,
> CS42L43_SPI_RX_DONE_MASK);
> +       }
> +
> +       return 0;
> +}
> +
> +static int cs42l43_transfer_one(struct spi_controller *ctlr, struct spi_=
device
> *spi,
> +                               struct spi_transfer *tfr) {
> +       struct cs42l43_spi *priv =3D spi_controller_get_devdata(spi->cont=
roller);
> +       int i, ret =3D -EINVAL;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(cs42l43_clock_divs); i++) {
> +               if (CS42L43_SPI_ROOT_HZ / cs42l43_clock_divs[i] <=3D tfr-=
>speed_hz)
> +                       break;
> +       }
> +
> +       if (i =3D=3D ARRAY_SIZE(cs42l43_clock_divs))
> +               return -EINVAL;
> +
> +       regmap_write(priv->regmap, CS42L43_SPI_CLK_CONFIG1, i);
> +
> +       if (tfr->tx_buf) {
> +               regmap_write(priv->regmap, CS42L43_TRAN_CONFIG3,
> CS42L43_WRITE);
> +               regmap_write(priv->regmap, CS42L43_TRAN_CONFIG4, tfr->len=
 - 1);
> +       } else if (tfr->rx_buf) {
> +               regmap_write(priv->regmap, CS42L43_TRAN_CONFIG3,
> CS42L43_READ);
> +               regmap_write(priv->regmap, CS42L43_TRAN_CONFIG5, tfr->len=
 - 1);
> +       }
> +
> +       regmap_write(priv->regmap, CS42L43_TRAN_CONFIG1,
> + CS42L43_SPI_START_MASK);
> +
> +       if (tfr->tx_buf)
> +               ret =3D cs42l43_spi_tx(priv->regmap, (const u8 *)tfr->tx_=
buf, tfr->len);
> +       else if (tfr->rx_buf)
> +               ret =3D cs42l43_spi_rx(priv->regmap, (u8 *)tfr->rx_buf,
> + tfr->len);
> +
> +       return ret;
> +}
> +
> +static void cs42l43_set_cs(struct spi_device *spi, bool is_high) {
> +       struct cs42l43_spi *priv =3D
> +spi_controller_get_devdata(spi->controller);
> +
> +       if (spi->chip_select =3D=3D 0)

New set/get APIs for accessing spi->chip_select were introduced by
https://github.com/torvalds/linux/commit/303feb3cc06ac0665d0ee9c1414941200e=
60e8a3
please use these APIs instead of accessing spi->chip_select directly.

> +               regmap_write(priv->regmap, CS42L43_SPI_CONFIG2,
> +!is_high); }
> +
> +static int cs42l43_prepare_message(struct spi_controller *ctlr, struct
> +spi_message *msg) {
> +       struct cs42l43_spi *priv =3D spi_controller_get_devdata(ctlr);
> +       struct spi_device *spi =3D msg->spi;
> +       unsigned int spi_config1 =3D 0;
> +
> +       /* select another internal CS, which doesn't exist, so CS 0 is no=
t used */
> +       if (spi->cs_gpiod)

Same here for spi->cs_gpio

Regards,
Amit
> +               spi_config1 |=3D 1 << CS42L43_SPI_SS_SEL_SHIFT;
> +       if (spi->mode & SPI_CPOL)
> +               spi_config1 |=3D CS42L43_SPI_CPOL_MASK;
> +       if (spi->mode & SPI_CPHA)
> +               spi_config1 |=3D CS42L43_SPI_CPHA_MASK;
> +       if (spi->mode & SPI_3WIRE)
> +               spi_config1 |=3D CS42L43_SPI_THREE_WIRE_MASK;
> +
> +       regmap_write(priv->regmap, CS42L43_SPI_CONFIG1, spi_config1);
> +
> +       return 0;
> +}
> +
> +static int cs42l43_prepare_transfer_hardware(struct spi_controller
> +*ctlr) {
> +       struct cs42l43_spi *priv =3D spi_controller_get_devdata(ctlr);
> +       int ret;
> +
> +       ret =3D regmap_write(priv->regmap, CS42L43_BLOCK_EN2,
> CS42L43_SPI_MSTR_EN_MASK);
> +       if (ret)
> +               dev_err(priv->dev, "Failed to enable SPI controller:
> + %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int cs42l43_unprepare_transfer_hardware(struct spi_controller
> +*ctlr) {
> +       struct cs42l43_spi *priv =3D spi_controller_get_devdata(ctlr);
> +       int ret;
> +
> +       ret =3D regmap_write(priv->regmap, CS42L43_BLOCK_EN2, 0);
> +       if (ret)
> +               dev_err(priv->dev, "Failed to disable SPI controller:
> + %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static size_t cs42l43_spi_max_length(struct spi_device *spi) {
> +       return CS42L43_SPI_MAX_LENGTH;
> +}
> +
> +static int cs42l43_spi_probe(struct platform_device *pdev) {
> +       struct cs42l43 *cs42l43 =3D dev_get_drvdata(pdev->dev.parent);
> +       struct cs42l43_spi *priv;
> +       struct fwnode_handle *fwnode =3D dev_fwnode(cs42l43->dev);
> +       int ret;
> +
> +       priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->ctlr =3D devm_spi_alloc_master(&pdev->dev, sizeof(*priv->ct=
lr));
> +       if (!priv->ctlr)
> +               return -ENOMEM;
> +
> +       spi_controller_set_devdata(priv->ctlr, priv);
> +
> +       priv->dev =3D &pdev->dev;
> +       priv->regmap =3D cs42l43->regmap;
> +
> +       priv->ctlr->prepare_message =3D cs42l43_prepare_message;
> +       priv->ctlr->prepare_transfer_hardware =3D
> cs42l43_prepare_transfer_hardware;
> +       priv->ctlr->unprepare_transfer_hardware =3D
> cs42l43_unprepare_transfer_hardware;
> +       priv->ctlr->transfer_one =3D cs42l43_transfer_one;
> +       priv->ctlr->set_cs =3D cs42l43_set_cs;
> +       priv->ctlr->max_transfer_size =3D cs42l43_spi_max_length;
> +
> +       if (is_of_node(fwnode))
> +               fwnode =3D fwnode_get_named_child_node(fwnode, "spi");
> +
> +       device_set_node(&priv->ctlr->dev, fwnode);
> +
> +       priv->ctlr->mode_bits =3D SPI_3WIRE | SPI_MODE_X_MASK;
> +       priv->ctlr->flags =3D SPI_CONTROLLER_HALF_DUPLEX;
> +       priv->ctlr->bits_per_word_mask =3D SPI_BPW_MASK(8) |
> SPI_BPW_MASK(16) |
> +                                        SPI_BPW_MASK(32);
> +       priv->ctlr->min_speed_hz =3D CS42L43_SPI_ROOT_HZ /
> +                                  cs42l43_clock_divs[ARRAY_SIZE(cs42l43_=
clock_divs) - 1];
> +       priv->ctlr->max_speed_hz =3D CS42L43_SPI_ROOT_HZ /
> cs42l43_clock_divs[0];
> +       priv->ctlr->use_gpio_descriptors =3D true;
> +       priv->ctlr->auto_runtime_pm =3D true;
> +
> +       devm_pm_runtime_enable(priv->dev);
> +       pm_runtime_idle(priv->dev);
> +
> +       regmap_write(priv->regmap, CS42L43_TRAN_CONFIG6,
> CS42L43_FIFO_SIZE - 1);
> +       regmap_write(priv->regmap, CS42L43_TRAN_CONFIG7,
> + CS42L43_FIFO_SIZE - 1);
> +
> +       // Disable Watchdog timer and enable stall
> +       regmap_write(priv->regmap, CS42L43_SPI_CONFIG3, 0);
> +       regmap_write(priv->regmap, CS42L43_SPI_CONFIG4,
> + CS42L43_SPI_STALL_ENA_MASK);
> +
> +       ret =3D devm_spi_register_controller(priv->dev, priv->ctlr);
> +       if (ret) {
> +               pm_runtime_disable(priv->dev);
> +               dev_err(priv->dev, "Failed to register SPI controller: %d=
\n", ret);
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct platform_device_id cs42l43_spi_id_table[] =3D {
> +       { "cs42l43-spi", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(platform, cs42l43_spi_id_table);
> +
> +static struct platform_driver cs42l43_spi_driver =3D {
> +       .driver =3D {
> +               .name   =3D "cs42l43-spi",
> +       },
> +       .probe          =3D cs42l43_spi_probe,
> +       .id_table       =3D cs42l43_spi_id_table,
> +};
> +module_platform_driver(cs42l43_spi_driver);
> +
> +MODULE_DESCRIPTION("CS42L43 SPI Driver"); MODULE_AUTHOR("Lucas
> Tanure
> +<tanureal@opensource.cirrus.com>");
> +MODULE_AUTHOR("Maciej Strozek <mstrozek@opensource.cirrus.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.30.2

