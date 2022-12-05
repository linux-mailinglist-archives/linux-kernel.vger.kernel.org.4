Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCFA642363
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiLEHHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiLEHG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:06:58 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EF613F85;
        Sun,  4 Dec 2022 23:06:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux07qHJ24nJf/kyA7yqaydN0OuADLZ+Jg+mIwUuA0p87rFgktWiHf+KAN3FEgshNLVxP52OCo9jTZBKcwUNUqRA4nQ13TXopMxzE42TlRwqiB/TnjHXng7MpIKsGaLTxfYEitLp4aXoogIVdC5+q70dkWQs7HiR3MlAprX//+YiESGuVuNOvLZw5JSVIdbOWVsK2HQPISAw4t16o+UbcBVdWK/Z2DeCrcwMu32EDP18Np844TBUkWUhx5wgADv7iYbNPLYCV9rALzw8nuwFGel+z+iJbAXriAjA88xPPss0AHTpqJWgDNAQIjPNGz3SF7An1kdlJCuH5VnSe1YkOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duhkwZewnwYk9FTaHxFEtwulhnTFJK9HdIs0fQG8WaM=;
 b=Pny5IyrAOebh+qhuLsVmnRgUpgfcM2O9hnQATX2VzpEfJZMEwlqX0GKoPeCbImZMPk75p2vTVRxFKelg4RXaFK/iXEwZX1SzomET29b1C2m9Sg8jxb6oDgaYR7FFrsKqJdV+XZVy9mf0hP/bLXaDpxo0xYzsE4Am0iIF5imCSe6ywMYSLMdWKIReDx4MzZBGxwbLW3c5PUDsRLt2AhJdLx+YOPjUqGv+98qsdPohOOFegN243rnl28gdtm4gokVyVzsvTch4UckdEEYlwoSuH0E3GrpxpLCEFJ/+YjjVlzAaPsUnTx8iwmpK7YewbMNkbNRsghksUNmkLcyffvea7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duhkwZewnwYk9FTaHxFEtwulhnTFJK9HdIs0fQG8WaM=;
 b=CjQFOlg5L7iqVXwStl6+Jv+J7nU20gJDJyYLdR9Mb66MfCHBvpyw3DjIHFUBYJuCYP/ur9WoeKtgSX5VgHuhtODyBXMIdrP/854cQAL0S09RjpZPqNuRXQcRaMIoOe9p6og6eKw/m0iNxGcoHXapJdZZOKmUjktLW8Zf6C6Z+HfvAUlWerVHYfArGirGyBKmHXvpu1Gra9ZvWosKf02a6pW4h50+uyeFYv51imaBO0vFd/BLdSlyKwcP2ImvYRhuZF29n54730ICSxgZqXo2SflxviRVXHm8O6uQ1CaEc9bQ7rVZU+scyDk0xVMHCSEQCytChSA6p5LXdUJ7iFjSUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM0PR04MB7010.eurprd04.prod.outlook.com (2603:10a6:208:199::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Mon, 5 Dec
 2022 07:06:47 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::28d6:1b8:94d9:89f5]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::28d6:1b8:94d9:89f5%7]) with mapi id 15.20.5880.011; Mon, 5 Dec 2022
 07:06:46 +0000
Date:   Mon, 5 Dec 2022 15:06:28 +0800
From:   Chester Lin <clin@suse.com>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH v2 2/2] pinctrl: add NXP S32 SoC family support
Message-ID: <Y42YdF5A/GsufTej@linux-8mug>
References: <20221128054820.1771-1-clin@suse.com>
 <20221128054820.1771-3-clin@suse.com>
 <3276c36e-7dfe-ce2d-14d3-20dab732bd76@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3276c36e-7dfe-ce2d-14d3-20dab732bd76@suse.de>
X-ClientProxiedBy: TYAPR01CA0179.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::23) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM0PR04MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 929bb466-16f1-45af-8575-08dad68f45d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5Gt6HAk1o7JUoIB3ZK/Zqn32EEGiHqE0KJ7eZinWM8yU7npZyEj+zdgalheoanlj35pJCovh+P6GQW8iOT3ob3QEPd4HfgDyOqC/yrmCpyd2ZjaZe8IZMUVTpaU6PywLvLcoD7mU24lpWwuEqNFIGBw/PCD3TrB9wrmliHpIPH8x/mq57vikuqYTJPXSo8qhqtCxyZbbHXUqOW81NrXa/17a/w1tAwN2ezkVu3al9vteWkjMTUnaqCjTqYDzws0cRcK+LuEowxMqf3TauM+aGKpL46J86fyCNcm7M2Aypyv5iskhOJrdzVQrFAYMtEUMZFhdTwwtlvAdpT0AGnfqY/Dr82ibkJS+JeFr1Yu2UYZlg1nN9VZlc9d1ENkgYnITMIjJYWk5DRfnM05BJoCQDCfVSEBSkGOD2m0+0NBVCtWUqERSlr27KGlbeISNy8b/nGBzCnHr/SCVBsrMhW+3wcQciEMnSaJb1gG6UHEPkCId1nyqz1U7bdjxVAoQ8iPh26pR47yI0zimIPS2W+OlCrQ/w7sKzd43ae8PJOSAJGl+LIF5ayXJo4a/48HGOBVauvAvEdwFhD7QEWWxTmZXz/6ndYoWNLAk7b/oOB3jC3+pcIHe4HA7I2A5imd8rG3JhNiOKDvgEqGzBNNVJB5C6HF7smXt15i6oOl4USBAdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(33716001)(86362001)(6486002)(6506007)(478600001)(966005)(83380400001)(186003)(38100700002)(26005)(8936002)(8676002)(41300700001)(4326008)(6666004)(6512007)(5660300002)(9686003)(7416002)(66946007)(54906003)(66476007)(66556008)(2906002)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yVa4UQgadLq85TyrND1c9UXaS0B7FTFiZasRNG/5NPXbMQndcixzcM6mPN?=
 =?iso-8859-1?Q?mfQEzZ2MVLQpkQtclYLrp7QT0Fp4SMQQckyFuSlsu3U4N0db45gEO6jz/R?=
 =?iso-8859-1?Q?QNggU+TmXUy2VhD/5IBAPVa/VS2YJH1I+mjUUtcmwjdoBp5kuYCyEw8Vro?=
 =?iso-8859-1?Q?oilj1GLcefwXy2lvmmxrK8y5VizA1GTh6nlknwJwP8kFF4vmElBwGWqZXn?=
 =?iso-8859-1?Q?4eE2eHPIExXaU8USXRLwjx1P5W4mndLiyRn+szfHnuFTKRAo61LSkPFnqR?=
 =?iso-8859-1?Q?lJJ/IZ12R0Z4ZqXU4ymCqsVh0INTTH9wD4BvnjqZs+KATtW+rHivW6A3eI?=
 =?iso-8859-1?Q?hOjBBNbncWdsiZJdSina8JIVHjTRkl9JTyDsVMMVGTgSzJyvM1qXBu3usL?=
 =?iso-8859-1?Q?lQTg+9/FHBp9yzfmBLHU2MQ90oDaMlo0HJFuytQDftXHXNEY4bL4VsdunN?=
 =?iso-8859-1?Q?mO3S2WUw9cbaDldutlx+HxmJ19k0n2Fmlncl1us00op3ttehD+HZvDW/4v?=
 =?iso-8859-1?Q?bJmL204iyaBJ+m7Y/xkNZvZYb4oP1KiXQTiKhBNfxBXXaJYThLSbbn8wpn?=
 =?iso-8859-1?Q?pUyWuwlzrPRZ5lw46YI3umvhrDMYDiFlOPAi3N5wOfIQDodesmqJEmrX/l?=
 =?iso-8859-1?Q?bXgmuANRHiKn3h6F51VLlSjr5si6Rhz5TWNgPI0zghxohJv8T9K5E1yttU?=
 =?iso-8859-1?Q?0TEQq/4Lm+KzjQaZiu2kXgSoxIPsz9O4I18W4V74NkkgzEqvqPVA7Yb+vk?=
 =?iso-8859-1?Q?VOlXXCgb/z8E41Aq9FUE9YO2mO6QSu9v3oxvSE9mwJ1iTAWGMYWMMF9JpE?=
 =?iso-8859-1?Q?VD+xbA6W1JCjuCYebSkX7N3YYIlNypuWeEVSr7RPptd0x2OQ6/rf59Ap4n?=
 =?iso-8859-1?Q?Ey9C34N8ESJbIa4yBuZj1hVAb+lMiqtZz+vyrl86LoDMY1vc6fLFP859l0?=
 =?iso-8859-1?Q?1EZ8Fk63yftPBUi2V5JwPZW+UledgiQUSTQC1n+ZTb7FhqgdDGTd2bkinp?=
 =?iso-8859-1?Q?mbFhy7FkVNgUsJxIPkquOvg0/4kMH2FsWXx6cJB1r40ezMesBZzr/329wd?=
 =?iso-8859-1?Q?t3i5FPvvj3TUsJuVNHBidfw/sw3qYxHhXknz0iU7UW524IQO5VVWXQDu04?=
 =?iso-8859-1?Q?l7VUqYgzdWmEH3R9K3RRqTYCdMjEmr9kNEjV4520rx9u4db40aQAQOVUZ+?=
 =?iso-8859-1?Q?qpzLFhOCmkKMUxd/AG7jgBdb2pi4iD7v7yF173C3+GYt9FxH8Rhote6FBK?=
 =?iso-8859-1?Q?Cc85m5IQ3Aa5apMwSsZ1UtlQgbQOd38G0E+Zt1lP79cFYqtm9wKH/47fY/?=
 =?iso-8859-1?Q?QNf/0OBeYtg4q1js7B50JMQmP62d765cnuqJy5v0IDgyuJw/PFyC+0PIdG?=
 =?iso-8859-1?Q?izo/ncZMx4aws8jXQSvqYXfPH9HK38kBHso5+RnwdYzOlfS1ppOwsAI5RM?=
 =?iso-8859-1?Q?Vx+ei7+q1hQm/oRvd7IXkKCzoZ/vhBdMOhVJiSIIQxdi9t6WSuoXiX/4zv?=
 =?iso-8859-1?Q?ObEqN6RuVnezhKXz/WRuOiPZp7sceDGx9GrOkmUVggE00bn1XLUQs1mLhh?=
 =?iso-8859-1?Q?b73U17iPOc/6j6V4mfm0eAisU/bU7tYAccXgDaJxjtkxCr30BjhHkFwT4j?=
 =?iso-8859-1?Q?uD9iFr2eqDDBg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929bb466-16f1-45af-8575-08dad68f45d7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 07:06:46.8797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vrb4WEABO1IN8WPemxubyxvyoL35zMgsaqPGzTdQYa5Shw8Ek/rtXWamHpVssMzh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7010
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Tue, Nov 29, 2022 at 02:40:34PM +0100, Andreas Färber wrote:
> Hi Chester,
> 
> Am 28.11.22 um 06:48 schrieb Chester Lin:
> > Add the pinctrl driver for NXP S32 SoC family. This driver is mainly based
> > on NXP's downstream implementation on CodeAurora[1].
> > 
> > [1] https://source.codeaurora.org/external/autobsps32/linux/tree/drivers/pinctrl/freescale?h=bsp34.0-5.10.120-rt
> > 
> > Signed-off-by: Matthew Nunez <matthew.nunez@nxp.com>
> > Signed-off-by: Phu Luu An <phu.luuan@nxp.com>
> > Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
> > Signed-off-by: Radu Pirea <radu-nicolae.pirea@nxp.com>
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> > 
> > Changes in v2:
> > - Create a s32_pin_range matrix in the driver for replacing the "nxp,pins"
> >    property in DT.
> > - Refine the compatible name to "nxp,s32g2-siul2-pinctrl".
> 
> Thanks.
> 
> > - Fix the copyright requested by NXP.
> > - Remove a few recipients from the Cc list since these email addresses are no
> >    longer available.
> > 
> >   drivers/pinctrl/freescale/Kconfig         |   16 +
> >   drivers/pinctrl/freescale/Makefile        |    2 +
> >   drivers/pinctrl/freescale/pinctrl-s32.h   |   77 ++
> >   drivers/pinctrl/freescale/pinctrl-s32cc.c | 1003 +++++++++++++++++++++
> >   drivers/pinctrl/freescale/pinctrl-s32g.c  |  773 ++++++++++++++++
> >   5 files changed, 1871 insertions(+)
> >   create mode 100644 drivers/pinctrl/freescale/pinctrl-s32.h
> >   create mode 100644 drivers/pinctrl/freescale/pinctrl-s32cc.c
> >   create mode 100644 drivers/pinctrl/freescale/pinctrl-s32g.c
> > 
> > diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
> > index 7a32f77792d9..fdd8f5492830 100644
> > --- a/drivers/pinctrl/freescale/Kconfig
> > +++ b/drivers/pinctrl/freescale/Kconfig
> > @@ -217,3 +217,19 @@ config PINCTRL_IMXRT1170
> >   	select PINCTRL_IMX
> >   	help
> >   	  Say Y here to enable the imxrt1170 pinctrl driver
> > +
> > +config PINCTRL_S32CC
> > +	bool "NXP S32 Common Chassis pinctrl driver core"
> > +	depends on ARCH_S32 && OF
> > +	select GENERIC_PINCTRL_GROUPS
> > +	select GENERIC_PINMUX_FUNCTIONS
> > +	select GENERIC_PINCONF
> > +	help
> > +	  Say Y here to enable the NXP S32CC pinctrl driver core
> 
> Does this driver core make any sense without a specific driver?
> 

No, it does not. This driver core must be associated with a specific platform
driver, such as PINCTL_S32G.

> I.e., could this just be a menu-invisible internal option if S32G is the one
> the user needs to select anyway?

If you mean making the option invisible in menuconfig, it can be done by simply
removing the prompt message "NXP S32 Common .." from the bool type line. Although
it will disappear from menuconfig but it can be automatically selected once the
config PINCTRL_S32G is set to "y" due to its "select" option.

> The alternative would be to leave it and have S32G depend on it, creating a
> submenu structure, but that would then still allow to build the driver core
> without any users.
> 
> > +
> > +config PINCTRL_S32G
> > +	depends on ARCH_S32 && OF
> > +	bool "NXP S32G pinctrl driver"
> > +	select PINCTRL_S32CC
> > +	help
> > +	  Say Y here to enable the pinctrl driver for NXP 32G family SoCs
> 
> s/32G/S32G/
> 

Will fix it in v3. Thanks!

> > diff --git a/drivers/pinctrl/freescale/Makefile b/drivers/pinctrl/freescale/Makefile
> > index 647dff060477..ceb0f61c6215 100644
> > --- a/drivers/pinctrl/freescale/Makefile
> > +++ b/drivers/pinctrl/freescale/Makefile
> > @@ -33,3 +33,5 @@ obj-$(CONFIG_PINCTRL_IMX25)	+= pinctrl-imx25.o
> >   obj-$(CONFIG_PINCTRL_IMX28)	+= pinctrl-imx28.o
> >   obj-$(CONFIG_PINCTRL_IMXRT1050)	+= pinctrl-imxrt1050.o
> >   obj-$(CONFIG_PINCTRL_IMXRT1170)	+= pinctrl-imxrt1170.o
> > +obj-$(CONFIG_PINCTRL_S32CC)	+= pinctrl-s32cc.o
> > +obj-$(CONFIG_PINCTRL_S32G)	+= pinctrl-s32g.o
> [snip]
> 
> Regards,
> Andreas
> 
> -- 
> SUSE Software Solutions Germany GmbH
> Frankenstraße 146, 90461 Nürnberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nürnberg)
