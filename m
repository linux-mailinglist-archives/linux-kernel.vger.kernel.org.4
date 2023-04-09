Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91EE6DBE70
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 05:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjDIDo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 23:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDIDo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 23:44:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779E959ED;
        Sat,  8 Apr 2023 20:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEhSjzYmyVRmoQx7OC5Dn5zARb+tPLNZ3Lki5nESVRDcZXc4YW4cTsdmaywNtPHJTplKagBv5AorBeHGdKaidVwKL2Q25ZtTfOSh27OV3i/T60TbhrY6/4CK9ys8hxFW2ZrRMVVuY5Jwn6Hhhv+UDOo01SlgeeUxvM7pFAKX1UWr4/wJmWPlJR0VYGxAKz3J+YRlFZHwKbKghL0+OtRtPNCmogy/bzmcpjJjFTVqu8Er2AMl499IVd/DBuM6ek1jmoKp1bLE5ynx2s4vTvYAx641M4St/q3CWCcyXZquUp4zfu5t9zlF4xslIWTmqkBSxgdwY06fERum13zZBMnOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vXk1S8MwlfkVDq34M71rxQChk3KjQ/Nj19sgcIaWbc=;
 b=jj4VVZPPbVpBGfKwbLPiPQ5N5rXWb4Ba6Hm2pehzxOdRonWqtoHhSURvpRVHWUhX6kM7hwP/72A7um8unL06tca7ZzwYwEnkucAABSKWCsx/25HVophC/xiV7k4ynJRmDHEBarYgeFJlFON58H6pwo1U4Bp6KThuF8iQvSq52IcV4PfUScHPCXF+zd9RD00RJeHmwrnDDLAvsZZ9isUlSpTfCdf3YHyoNHD9PXgb5ikQ+sMNtJN/6nzxyxy0jYceRwMpNVWNilPiUvIRPYuqajoQByQlc5Y6gDgYp08B5ZMd9WkMrvS40TckDfkMPYATU0g3bJaicXDXjj0TcWDEMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vXk1S8MwlfkVDq34M71rxQChk3KjQ/Nj19sgcIaWbc=;
 b=rNE5x166VtQdw41IfUZCvRPn3RcsYq3EuZzxsnTuAOsNrrTRiXC1MKrgYbKTtSahcNJhsqV/yB/+5qgJrCla5pd82dR3sNTiITs1DYfVumw4nHhxXxzUnSoL23lXIx/RlDaN4opDOGhRvQ5SdAS/yddzBKyC43G6E4BVBYYutso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by BL3PR08MB7417.namprd08.prod.outlook.com
 (2603:10b6:208:338::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Sun, 9 Apr
 2023 03:44:47 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::34bc:e51:9ef9:3ab1]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::34bc:e51:9ef9:3ab1%4]) with mapi id 15.20.6277.031; Sun, 9 Apr 2023
 03:44:46 +0000
Date:   Sat, 8 Apr 2023 22:44:39 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Fred Treven <fred.treven@cirrus.com>
Cc:     dmitry.torokhov@gmail.com, ben.bright@cirrus.com,
        james.ogletree@cirrus.com, lee@kernel.org, jdelvare@suse.de,
        joel@jms.id.au, cy_huang@richtek.com, rdunlap@infradead.org,
        eajames@linux.ibm.com, ping.bai@nxp.com, msp@baylibre.com,
        arnd@arndb.de, bartosz.golaszewski@linaro.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] Input: cs40l26: Support for CS40L26 Boosted Haptic
 Amplifier
Message-ID: <ZDI0p5Rkp74SzJCv@nixie71>
References: <SupportforCS40L26BoostedHapticAmplifier>
 <1680819415-28806-1-git-send-email-fred.treven@cirrus.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680819415-28806-1-git-send-email-fred.treven@cirrus.com>
X-ClientProxiedBy: DM6PR02CA0125.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::27) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|BL3PR08MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 49070c3a-db34-4473-4cd8-08db38acc329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ryQcpe+50AoXNQ9MLywLsoqgNpRsAJ5ZUONaVbZXeh1uaJ4L1OBEPfYPtQs8gr33R2ElHur/KAUYAUZ32AMPw7IY5V2/KIOldx/J9KGKaHAgEznnWg/f/iYB+lSv1BHwvwPrt0xNVTdUXoS3y93UzMEL177Cfvfpazj73f1h/pC5rZg3eWB+2miTM3SZJLiboES6KfK6PVF1e1YMhLONdTU9CyTlgutPenhJfsdpL2vksLs8NJyeOjfof7sVW78utiJjgPDeMn4SP9nMTJo/sJCJQaLg151GeyoDEP6265plZWrQ5IIh4RxlnwQHbiPZ5+1aEaQvx8jLqJEi0KR2EhZpftBV69uX0YgFHymHv5bYlSIW6w/JHhVXn/wE7Cu87nhjEg/CBGHy204YUzaAl+K5IhqUp6BaUWIFAr7NqYe00trEeYKDt6abKN2AZFS9ZUewdaPQW7E3dIzCmamN9mZsbD/9hIitVv2OOWaPOUSCAQj7CPBtrLBFkwomeuvBup9F5gf3wmHVCw7P2UTvRoyiGaU6zdo2HlJaISOCt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39830400003)(346002)(376002)(366004)(136003)(396003)(451199021)(478600001)(6666004)(316002)(9686003)(6512007)(6506007)(26005)(186003)(6486002)(966005)(2906002)(30864003)(66476007)(33716001)(66946007)(66556008)(5660300002)(8676002)(6916009)(4326008)(41300700001)(8936002)(7416002)(38100700002)(86362001)(83380400001)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fOcJFdqV98hgMHSed9pSrhTr/dEZ8I3Fbmj7TeXu++xrloOiKiGd4S7tGaB6?=
 =?us-ascii?Q?YiyVmstogYe65kJEKUdT3MqXm2gyqdjYuQZwWJThsybwVkgaLcI/qF2AlpXk?=
 =?us-ascii?Q?1KcHpFZR2A6IpaVTia/pQU5LBNSfcw790/xSPD2dUL+6bB3x+jnK3p8XZ0Eo?=
 =?us-ascii?Q?9fF2Egma3Q6Kl2+g7LCBsdZzG7ewjGu2C30bnlKEJikllZqmjxGyLI+t5SKX?=
 =?us-ascii?Q?aaa7KUjXNX4W3rSj/fti8triKjD2FnzAkBNZnLggOtt5lp8H+17qslXAVyoy?=
 =?us-ascii?Q?SdFmMV1H0eB6Gw0LPuCg8xtg48X2hPHRSwzJSzkqcjEABIQehqUYOASyecJo?=
 =?us-ascii?Q?xqfv8CByZMr2PEgv5xVM/a2i+e96wfEkKy75w7sN1u8B8FfeOrTjAEy5xjwd?=
 =?us-ascii?Q?5JMRVpt9wQmO270rLEDkzHrZY14EKheQYN5gem+YXVAHPEfcpUlik9mzVoZR?=
 =?us-ascii?Q?N7rDX1R+HSWOiyg6usEzU4p2J3Af8TfoSANduR/Lz976FcDnRlzwsLAckjK4?=
 =?us-ascii?Q?gIQjMlUZnFxrKS5FlGatVReuid0e0y3gnykFlnjTxMdBKCgrx2psrIuaarKY?=
 =?us-ascii?Q?1nmjNx5RCJkSxCEGlkIbR8bWc1R4+dalwbw3yCzh/aqMimE8ZenqUjmwl+Xu?=
 =?us-ascii?Q?Nf3Y92a0XQTGE4tuBlGLh28j4OkGSxyfnyq34jt2HBJwc5fqAJVCHcKRlTw2?=
 =?us-ascii?Q?ViBBZtcI0Y7RluFAbsovw9mQqo1wo4cHei27Jhcjp+3AX/PvuYgIf+mcgQ9h?=
 =?us-ascii?Q?rQsjXOVSThagbvI5JI3JGUpPYr+MC6kCy2IPgfPc1jTJ7912uoH2Q9o6Oef2?=
 =?us-ascii?Q?RD6xrFikiCQCJAa+WaX01vwW5tA7wdfZVXGYN5dXeyWeXTe0UwHOu0VYWc86?=
 =?us-ascii?Q?b6WNjvRM7kYQkNd9UFzkc7DdQRP6Eiow9nTbHTq8W0RvTyF98BViUR5NFvIS?=
 =?us-ascii?Q?wOJDZJC0HmdcffNCOR8r1V5TxWZz98uiV67igch70KnsIdVooCYb3ejuOxOr?=
 =?us-ascii?Q?RX5sEfNvGQNMw2GHdzzOcCMFI2didQzvGRr7QhTssef/77rVsVe8JrgaOVGq?=
 =?us-ascii?Q?TN/aaypMy2CgxuOUYz+Tsu95O/ZNlL/WEpUP7huoIz9o74nWwkRJqqvI+sCv?=
 =?us-ascii?Q?f9rdpaZ7nUL2PFQn2u4qm/mk3RHxo0cQtOZri1O2i0OBtdxdHLHQ66dfUxNK?=
 =?us-ascii?Q?hDDgkcQk9waI8g5cfssajrBa65pzRRxRYEzS3ztMihFK4G1kKghhB3vOw4Uw?=
 =?us-ascii?Q?9yu18zhsQBz2m4Gx29wyaNq+CeDMJR8wiYVY8TJi4FynfjKK0tSxC7Gj64QI?=
 =?us-ascii?Q?8N3o2ZN8a7fiA5gmMZFv+2gPHMyKV5s8AGWHNZzCPAOTb3DECglc9WSZAlsQ?=
 =?us-ascii?Q?n4P/2eWXQbVGkTWb7XrUHOqbt25c7DSNvNKV3SJ2lFm5g80fk5UXZ448Vj8T?=
 =?us-ascii?Q?nNTdXFv179u6V1oaVII6c7TMsZBG/E0M4WVVx+MDJm1vtZN7Kn5YGmSFO4xv?=
 =?us-ascii?Q?yGs+v7SkwUdYVczE9VjMjs2cKGx5+vmvdRtvNYqlZLQI8ZyPomXVF6n5B2NJ?=
 =?us-ascii?Q?Mn2//K0yjbpX/Va9irhvAy7Bn+ErKIV7/ZAdR2Uh?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49070c3a-db34-4473-4cd8-08db38acc329
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2023 03:44:46.6966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gELXuYow+m0TvfVjIbF8CD5IPdyH9q4GnbsVqV/zfu6Q70+5uhL96NVY/EAdhLhXINzx9vvImybkYc1pu+0yug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR08MB7417
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fred,

Great work! A lot of high-quality effort obviously went into this
submission. Please find my feedback below.

On Thu, Apr 06, 2023 at 05:16:55PM -0500, Fred Treven wrote:
> Introduce support for Cirrus Logic device CS40L26, a boosted
> haptics driver with integrated DSP and waveform memory with
> advanced closed loop algorithms and LRA protection.
> 
> Signed-off-by: Fred Treven <fred.treven@cirrus.com>
> ---

Please note that bindings must be sent first in a series. This is
because some customers may run each patch through their own CI/CD
in the order received. That CI/CD may include checkpatch, which will
warn that the compatible strings are undefined if the driver comes
before the binding.

>  MAINTAINERS                         |   11 +
>  drivers/input/misc/Kconfig          |   30 +
>  drivers/input/misc/Makefile         |    4 +
>  drivers/input/misc/cs40l26-i2c.c    |   81 ++
>  drivers/input/misc/cs40l26-spi.c    |   81 ++
>  drivers/input/misc/cs40l26-tables.c |  170 +++
>  drivers/input/misc/cs40l26.c        | 2508 +++++++++++++++++++++++++++++++++++
>  include/linux/input/cs40l26.h       |  532 ++++++++
>  8 files changed, 3417 insertions(+)
>  create mode 100644 drivers/input/misc/cs40l26-i2c.c
>  create mode 100644 drivers/input/misc/cs40l26-spi.c
>  create mode 100644 drivers/input/misc/cs40l26-tables.c
>  create mode 100644 drivers/input/misc/cs40l26.c
>  create mode 100644 include/linux/input/cs40l26.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b073facf399..7051386d5a13 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4926,6 +4926,17 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/cirrus/ep93xx_eth.c
>  
> +CIRRUS LOGIC HAPTICS DRIVER
> +M:	Fred Treven <fred.treven@cirrus.com>
> +M:	Ben Bright <ben.bright@cirrus.com>
> +M:	James Ogletree <james.ogletree@cirrus.com>
> +L:	patches@opensource.cirrus.com
> +S:	Supported
> +W:	https://github.com/CirrusLogic/linux-drivers/wiki
> +T:	git https://github.com/CirrusLogic/linux-drivers.git
> +F:	drivers/input/misc/cs40l*
> +F:	include/linux/input/cs40l*
> +
>  CIRRUS LOGIC LOCHNAGAR DRIVER
>  M:	Charles Keepax <ckeepax@opensource.cirrus.com>
>  M:	Richard Fitzgerald <rf@opensource.cirrus.com>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 81a54a59e13c..418e70724d26 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -140,6 +140,36 @@ config INPUT_BMA150
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bma150.
>  
> +config INPUT_CS40L26
> +	tristate "Cirrus Logic CS40L26 Haptic Amplifier support"
> +	select CS_DSP
> +	help
> +	  Say Y here to enable support for CS40L26 boosted haptic
> +	  amplifier.
> +
> +	  To compile the driver as a module choose M here: the module
> +	  will be called cs40l26_core.
> +
> +config INPUT_CS40L26_I2C
> +	tristate "Support I2C bus connection"
> +	depends on INPUT_CS40L26 && I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y if you have CS40L26 hooked to an I2C bus.

Please use more explicit language (e.g. "connected") as "hooked" is slang
that may not be universally understood.

> +
> +	  To compile the driver as a module choose M here: the
> +	  module will be called cs40l26_i2c.
> +
> +config INPUT_CS40L26_SPI
> +	tristate "Support SPI bus connection"
> +	depends on INPUT_CS40L26 && SPI
> +	select REGMAP_SPI
> +	help
> +	  Say Y if you have CS40L26 hooked to a SPI bus.
> +
> +	  To compile the driver as a module choose M here: the
> +	  module will be called cs40l26_spi.
> +
>  config INPUT_E3X0_BUTTON
>  	tristate "NI Ettus Research USRP E3xx Button support."
>  	default n
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 04296a4abe8e..631ef6ebb061 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -28,6 +28,10 @@ obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
>  obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
>  obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
>  obj-$(CONFIG_INPUT_CPCAP_PWRBUTTON)	+= cpcap-pwrbutton.o
> +cs40l26-core-objs := cs40l26.o cs40l26-tables.o
> +obj-$(CONFIG_INPUT_CS40L26)		+= cs40l26-core.o
> +obj-$(CONFIG_INPUT_CS40L26_I2C)		+= cs40l26-i2c.o
> +obj-$(CONFIG_INPUT_CS40L26_SPI)		+= cs40l26-spi.o
>  obj-$(CONFIG_INPUT_DA7280_HAPTICS)	+= da7280.o
>  obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
>  obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
> diff --git a/drivers/input/misc/cs40l26-i2c.c b/drivers/input/misc/cs40l26-i2c.c
> new file mode 100644
> index 000000000000..7d8e7a381681
> --- /dev/null
> +++ b/drivers/input/misc/cs40l26-i2c.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CS40L26 Boosted Haptic Driver with Integrated DSP and
> + * Waveform Memory with Advanced Closed Loop Algorithms and LRA protection
> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + *
> + * Author: Fred Treven <fred.treven@cirrus.com>
> + */
> +
> +#include <linux/i2c.h>
> +

Nit: extraneous NL.

> +#include <linux/input/cs40l26.h>
> +
> +static const struct i2c_device_id cs40l26_id_i2c[] = {
> +	{"cs40l26a", 0},
> +	{"cs40l26b", 1},
> +	{"cs40l27a", 2},
> +	{"cs40l27b", 3},

Nit: please use consistent leading and trailing spacing, as in:

        { "cs40l27b", 3 },

> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, cs40l26_id_i2c);
> +
> +static const struct of_device_id cs40l26_of_match[CS40L26_NUM_DEVS + 1] = {
> +	{ .compatible = "cirrus,cs40l26a" },
> +	{ .compatible = "cirrus,cs40l26b" },
> +	{ .compatible = "cirrus,cs40l27a" },
> +	{ .compatible = "cirrus,cs40l27b" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cs40l26_of_match);
> +
> +static int cs40l26_i2c_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)

Please use the probe_new callback, which does not accept an i2c_device_id.

> +{
> +	struct cs40l26_platform_data *pdata = dev_get_platdata(&client->dev);

We should not be using platform data; more feedback in the core driver.

> +	struct device *dev = &client->dev;
> +	struct cs40l26_private *cs40l26;
> +
> +	cs40l26 = devm_kzalloc(dev, sizeof(struct cs40l26_private), GFP_KERNEL);
> +	if (!cs40l26)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, cs40l26);
> +
> +	cs40l26->regmap = devm_regmap_init_i2c(client, &cs40l26_regmap);
> +	if (IS_ERR(cs40l26->regmap))
> +		return dev_err_probe(dev, PTR_ERR(cs40l26->regmap),
> +				"Failed to allocate register map\n");

Nit: please adopt a more common method of indentation throughout the driver:

	if (...)
		return dev_err_probe(...,
				     ...);

Specifically, add sufficient whitespace to align everything to the right of the
leading parenthesis.

> +
> +	cs40l26->dev = dev;
> +	cs40l26->irq = client->irq;
> +
> +	dev_set_drvdata(dev, cs40l26);

This is redundant; i2c_set_clientdata() does the same thing.

> +
> +	return cs40l26_probe(cs40l26, pdata);
> +}
> +
> +static void cs40l26_i2c_remove(struct i2c_client *client)
> +{
> +	struct cs40l26_private *cs40l26 = i2c_get_clientdata(client);
> +
> +	cs40l26_remove(cs40l26);
> +}
> +
> +static struct i2c_driver cs40l26_i2c_driver = {
> +	.driver = {
> +		.name = "cs40l26",
> +		.of_match_table = cs40l26_of_match,
> +		.pm = &cs40l26_pm_ops,

Please guard this with the new pm_sleep_ptr(), as not all platforms would
define CONFIG_PM. More comments in the core driver.

> +	},
> +	.id_table = cs40l26_id_i2c,
> +	.probe = cs40l26_i2c_probe,
> +	.remove = cs40l26_i2c_remove,
> +};
> +
> +module_i2c_driver(cs40l26_i2c_driver);
> +
> +MODULE_DESCRIPTION("CS40L26 I2C Driver");
> +MODULE_AUTHOR("Fred Treven, Cirrus Logic Inc. <fred.treven@cirrus.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/input/misc/cs40l26-spi.c b/drivers/input/misc/cs40l26-spi.c
> new file mode 100644
> index 000000000000..b53c62eec23f
> --- /dev/null
> +++ b/drivers/input/misc/cs40l26-spi.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CS40L26 Boosted Haptic Driver with Integrated DSP and
> + * Waveform Memory with Advanced Closed Loop Algorithms and LRA protection
> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + *
> + * Author: Fred Treven <fred.treven@cirrus.com>
> + */
> +
> +#include <linux/spi/spi.h>
> +

Nit: extraneous NL.

> +#include <linux/input/cs40l26.h>
> +
> +static const struct spi_device_id cs40l26_id_spi[] = {
> +	{"cs40l26a", 0},
> +	{"cs40l26b", 1},
> +	{"cs40l27a", 2},
> +	{"cs40l27b", 3},

Nit: same comment regarding consistent spacing of const arrays.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, cs40l26_id_spi);
> +
> +static const struct of_device_id cs40l26_of_match[CS40L26_NUM_DEVS + 1] = {
> +	{ .compatible = "cirrus,cs40l26a" },
> +	{ .compatible = "cirrus,cs40l26b" },
> +	{ .compatible = "cirrus,cs40l27a" },
> +	{ .compatible = "cirrus,cs40l27b" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cs40l26_of_match);
> +
> +static int cs40l26_spi_probe(struct spi_device *spi)
> +{
> +	struct cs40l26_platform_data *pdata = dev_get_platdata(&spi->dev);

Same comment with regard to platform data.

> +	struct device *dev = &spi->dev;
> +	struct cs40l26_private *cs40l26;
> +
> +	cs40l26 = devm_kzalloc(dev, sizeof(struct cs40l26_private), GFP_KERNEL);
> +	if (!cs40l26)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(spi, cs40l26);
> +
> +	cs40l26->regmap = devm_regmap_init_spi(spi, &cs40l26_regmap);
> +	if (IS_ERR(cs40l26->regmap))
> +		return dev_err_probe(dev, PTR_ERR(cs40l26->regmap),
> +				"Failed to allocate register map\n");
> +
> +	cs40l26->dev = dev;
> +	cs40l26->irq = spi->irq;
> +
> +	dev_set_drvdata(dev, cs40l26);

Same comment here; dev_set_drvdata() is redundant as spi_set_drvdata() simply
calls it internally.

> +
> +	return cs40l26_probe(cs40l26, pdata);
> +}
> +
> +static void cs40l26_spi_remove(struct spi_device *spi)
> +{
> +	struct cs40l26_private *cs40l26 = spi_get_drvdata(spi);
> +
> +	cs40l26_remove(cs40l26);
> +}
> +
> +static struct spi_driver cs40l26_spi_driver = {
> +	.driver = {
> +		.name = "cs40l26",
> +		.of_match_table = cs40l26_of_match,
> +		.pm = &cs40l26_pm_ops,

Same comment with regard to pm_sleep_ptr().

> +	},
> +
> +	.id_table = cs40l26_id_spi,
> +	.probe = cs40l26_spi_probe,
> +	.remove = cs40l26_spi_remove,
> +};
> +
> +module_spi_driver(cs40l26_spi_driver);
> +
> +MODULE_DESCRIPTION("CS40L26 SPI Driver");
> +MODULE_AUTHOR("Fred Treven, Cirrus Logic Inc. <fred.treven@cirrus.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/input/misc/cs40l26-tables.c b/drivers/input/misc/cs40l26-tables.c
> new file mode 100644
> index 000000000000..4a81eceb724c
> --- /dev/null
> +++ b/drivers/input/misc/cs40l26-tables.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CS40L26 Boosted Haptic Driver with Integrated DSP and
> + * Waveform Memory with Advanced Closed Loop Algorithms and LRA protection
> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + *
> + * Author: Fred Treven <fred.treven@cirrus.com>
> + */
> +
> +#include <linux/regulator/consumer.h>

This #include is unnecessary. Actually, breaking out the contents of this
file separately seems unnecessary as well; it's also not entirely common.
The contents of this file can be dropped or absorbed in cs40l26.c; more
details below.

> +
> +#include <linux/input/cs40l26.h>
> +
> +/* LUT for converting gain percentage to attenuation in dB */
> +const u32 cs40l26_atten_lut_q21_2[CS40L26_NUM_ATTEN_LUT_VALUES] = {
> +	400, /* MUTE */
> +	160, /* 1% */
> +	136,
> +	122,
> +	112,
> +	104,
> +	98,
> +	92,
> +	88,
> +	84,
> +	80,
> +	77,
> +	74,
> +	71,
> +	68,
> +	66,
> +	64,
> +	62,
> +	60,
> +	58,
> +	56,
> +	54,
> +	53,
> +	51,
> +	50,
> +	48, /* 25% */
> +	47,
> +	45,
> +	44,
> +	43,
> +	42,
> +	41,
> +	40,
> +	39,
> +	37,
> +	36,
> +	35,
> +	35,
> +	34,
> +	33,
> +	32,
> +	31,
> +	30,
> +	29,
> +	29,
> +	28,
> +	27,
> +	26,
> +	26,
> +	25,
> +	24, /* 50 % */
> +	23,
> +	23,
> +	22,
> +	21,
> +	21,
> +	20,
> +	20,
> +	19,
> +	18,
> +	18,
> +	17,
> +	17,
> +	16,
> +	16,
> +	15,
> +	14,
> +	14,
> +	13,
> +	13,
> +	12,
> +	12,
> +	11,
> +	11,
> +	10,
> +	10, /* 75% */
> +	10,
> +	9,
> +	9,
> +	8,
> +	8,
> +	7,
> +	7,
> +	6,
> +	6,
> +	6,
> +	5,
> +	5,
> +	4,
> +	4,
> +	4,
> +	3,
> +	3,
> +	3,
> +	2,
> +	2,
> +	1,
> +	1,
> +	1,
> +	0,
> +	0, /* 100% */
> +};

Just throw this in cs40l26.c. You can save some line count by packing several
values on a single line as well.

> +
> +static bool cs40l26_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case CS40L26_DEVID ... CS40L26_REVID:
> +	case CS40L26_TEST_KEY_CTRL:
> +	case CS40L26_GLOBAL_ENABLES:
> +	case CS40L26_ERROR_RELEASE:
> +	case CS40L26_PWRMGT_CTL ... CS40L26_PWRMGT_STS:
> +	case CS40L26_REFCLK_INPUT:
> +	case CS40L26_PLL_REFCLK_DETECT_0:
> +	case CS40L26_VBST_CTL_1 ... CS40L26_BST_IPK_CTL:
> +	case CS40L26_TEST_LBST:
> +	case CS40L26_NGATE1_INPUT:
> +	case CS40L26_DAC_MSM_CONFIG ... CS40L26_TST_DAC_MSM_CONFIG:
> +	case CS40L26_IRQ1_STATUS:
> +	case CS40L26_IRQ1_EINT_1 ... CS40L26_IRQ1_EINT_5:
> +	case CS40L26_IRQ1_STS_1 ... CS40L26_IRQ1_STS_5:
> +	case CS40L26_IRQ1_MASK_1 ... CS40L26_IRQ1_MASK_5:
> +	case CS40L26_MIXER_NGATE_CH1_CFG:
> +	case CS40L26_DSP_MBOX_1 ... CS40L26_DSP_VIRTUAL2_MBOX_8:
> +	case CS40L26_OTP_MEM0 ... CS40L26_OTP_MEM31:
> +	case CS40L26_DSP1_XMEM_PACKED_0 ... CS40L26_DSP1_XMEM_PACKED_6143:
> +	case CS40L26_DSP1_XROM_PACKED_0 ... CS40L26_DSP1_XROM_PACKED_4604:
> +	case CS40L26_DSP1_XMEM_UNPACKED32_0 ... CS40L26_DSP1_XROM_UNPACKED32_3070:
> +	case CS40L26_DSP1_SYS_INFO_ID:
> +	case CS40L26_DSP1_XMEM_UNPACKED24_0 ... CS40L26_DSP1_XMEM_UNPACKED24_8191:
> +	case CS40L26_DSP1_XROM_UNPACKED24_0 ... CS40L26_DSP1_XROM_UNPACKED24_6141:
> +	case CS40L26_DSP1_CCM_CORE_CONTROL:
> +	case CS40L26_DSP1_YMEM_PACKED_0 ... CS40L26_DSP1_YMEM_PACKED_1532:
> +	case CS40L26_DSP1_YMEM_UNPACKED32_0 ... CS40L26_DSP1_YMEM_UNPACKED32_1022:
> +	case CS40L26_DSP1_YMEM_UNPACKED24_0 ... CS40L26_DSP1_YMEM_UNPACKED24_2045:
> +	case CS40L26_DSP1_PMEM_0 ... CS40L26_DSP1_PMEM_5114:
> +	case CS40L26_DSP1_PROM_0 ... CS40L26_DSP1_PROM_30714:
> +		return true;
> +	default:
> +		return false;
> +	}

Is this function necessary? Are there cases throughout the driver that may
attempt to read an illegal register, and you depend on the regmap call to
fail? If not, I think you can just drop this function.

> +}
> +
> +const struct regmap_config cs40l26_regmap = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.reg_format_endian = REGMAP_ENDIAN_BIG,
> +	.val_format_endian = REGMAP_ENDIAN_BIG,
> +	.max_register = CS40L26_LASTREG,
> +	.num_reg_defaults = 0,
> +	.readable_reg = cs40l26_readable_reg,
> +	.cache_type = REGCACHE_NONE,
> +};
> +EXPORT_SYMBOL_GPL(cs40l26_regmap);

Same here, just throw this in cs40l26.c.

> diff --git a/drivers/input/misc/cs40l26.c b/drivers/input/misc/cs40l26.c
> new file mode 100644
> index 000000000000..cfe283840ac7
> --- /dev/null
> +++ b/drivers/input/misc/cs40l26.c
> @@ -0,0 +1,2508 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CS40L26 Boosted Haptic Driver with Integrated DSP and
> + * Waveform Memory with Advanced Closed Loop Algorithms and LRA protection
> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + *
> + * Author: Fred Treven <fred.treven@cirrus.com>
> + */
> +
> +#include <linux/firmware.h>
> +#include <linux/gpio.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/string.h>
> +

Nit: extraneous NL.

> +#include <linux/firmware/cirrus/wmfw.h>
> +#include <linux/input/cs40l26.h>
> +
> +static const struct cs_dsp_region cs40l26_dsp_regions[] = {
> +	{ .type = WMFW_HALO_PM_PACKED,		.base = CS40L26_DSP1_PMEM_0 },
> +	{ .type = WMFW_HALO_XM_PACKED,		.base = CS40L26_DSP1_XMEM_PACKED_0 },
> +	{ .type = WMFW_HALO_YM_PACKED,		.base = CS40L26_DSP1_YMEM_PACKED_0 },
> +	{ .type = WMFW_ADSP2_XM,		.base = CS40L26_DSP1_XMEM_UNPACKED24_0 },
> +	{ .type = WMFW_ADSP2_YM,		.base = CS40L26_DSP1_YMEM_UNPACKED24_0 },

Please use the following more readable alignment:

static const struct ... = {
	{
		.type = ...,
		.base = ...,
	},
	[...],
};

> +};
> +
> +static int cs40l26_mailbox_write(struct cs40l26_private *cs40l26, u32 write_val)
> +{
> +	int i, ret;

In input, return values that are either zero (success) or a negative number
(failure) are named 'error', i.e. error = regmap_write(...). Please update
the driver to use 'error' in place of 'ret' throughout.

> +	u32 ack;
> +
> +	/*
> +	 * Don't use regmap_read_poll_timeout here since the initial transaction could fail
> +	 * with -EIO if the device is hibernating.
> +	 */

This comment does not seem necessary; regmap_read_poll_timeout() does not seem
like it would have been a candidate for this function in the first place since
it seems you must precede each read with a write.

> +	for (i = 0; i < CS40L26_DSP_TIMEOUT_COUNT; i++) {
> +		ret = regmap_write(cs40l26->regmap, CS40L26_DSP_VIRTUAL1_MBOX_1, write_val);
> +		if (ret)
> +			dev_dbg(cs40l26->dev, "Failed to write to mailbox: %d on attempt no. %d\n",
> +					ret, i + 1);
> +
> +		ret = regmap_read(cs40l26->regmap, CS40L26_DSP_VIRTUAL1_MBOX_1, &ack);
> +		if (!ack && !ret)
> +			break;

This must instead be:

		if (!error && !ack)
			break;

Stated another way, do not evaluate the returned data until the register access
itself was determined to be successful.

> +
> +		usleep_range(CS40L26_DSP_TIMEOUT_US_MIN, CS40L26_DSP_TIMEOUT_US_MAX);
> +	}
> +	if (i == CS40L26_DSP_TIMEOUT_COUNT) {
> +		ret = -ETIMEDOUT;

This seems better:

		if (!error)
			error = -ETIMEDOUT;

In theory all 100 attempts could fail due to a hardware problem, and it seems
worthwhile to propagate that error to the caller. Stated another way, only
report -ETIMEDOUT if all register access succeeded, yet returned the wrong
value (which I guess is any nonzero value)?

> +		dev_err(cs40l26->dev, "Mailbox ack. failed with value 0x%X", ack);
> +	}
> +
> +	return ret;
> +}
> +
> +static int cs40l26_fw_ctl_write_raw(struct cs_dsp *dsp, const char * const name,
> +		unsigned int algo_id, unsigned int off_words, size_t len_bytes, u32 *buf)

Same comment here with regard to alignment. The following would be much more
common, and easier to read:

static int cs40l26_fw_ctl_write_raw(struct cs_dsp *dsp, const char * const name,
				    unsigned int algo_id, unsigned int off_words,
				    size_t len_bytes, u32 *buf)

Please note that you seem to mix unsigned int and u32 throughout; just stick with
unsigned int.

> +{
> +	size_t len_words = len_bytes / sizeof(__be32);
> +	struct cs_dsp_coeff_ctl *ctl;
> +	__be32 *val;
> +	int i, ret;
> +
> +	ctl = cs_dsp_get_ctl(dsp, name, WMFW_ADSP2_XM, algo_id);
> +	if (IS_ERR_OR_NULL(ctl)) {
> +		dev_err(dsp->dev, "Failed to find fw ctl %s\n", name);
> +		return -ENOENT;
> +	}
> +
> +	val = kzalloc(len_bytes, GFP_KERNEL);
> +	if (!val)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < len_words; i++)
> +		val[i] = cpu_to_be32(buf[i]);
> +
> +	ret = cs_dsp_coeff_write_ctrl(ctl, off_words, val, len_bytes);
> +	if (ret)
> +		dev_err(dsp->dev, "Failed to write fw ctl %s: %d\n", name, ret);
> +
> +	kfree(val);
> +
> +	return ret;
> +}
> +
> +static inline int cs40l26_fw_ctl_write(struct cs_dsp *dsp, const char * const name,
> +		unsigned int algo_id, u32 val)
> +{
> +	return cs40l26_fw_ctl_write_raw(dsp, name, algo_id, 0, sizeof(u32), &val);
> +}
> +
> +static int cs40l26_fw_ctl_read_raw(struct cs_dsp *dsp, const char * const name,
> +		unsigned int algo_id, unsigned int off_words, size_t len_bytes, u32 *buf)
> +{
> +	size_t len_words = len_bytes / sizeof(u32);
> +	struct cs_dsp_coeff_ctl *ctl;
> +	int i, ret;
> +
> +	ctl = cs_dsp_get_ctl(dsp, name, WMFW_ADSP2_XM, algo_id);
> +	if (IS_ERR_OR_NULL(ctl)) {
> +		dev_err(dsp->dev, "Failed to find fw ctl %s\n", name);
> +		return -ENOENT;
> +	}
> +
> +	ret = cs_dsp_coeff_read_ctrl(ctl, off_words, buf, len_bytes);
> +	if (ret) {
> +		dev_err(dsp->dev, "Failed to read fw ctl %s: %d\n", name, ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < len_words; i++)
> +		buf[i] = be32_to_cpu(buf[i]);
> +
> +	return 0;
> +}
> +
> +static inline int cs40l26_fw_ctl_read(struct cs_dsp *dsp, const char * const name,
> +		unsigned int algo_id, u32 *buf)
> +{
> +	return cs40l26_fw_ctl_read_raw(dsp, name, algo_id, 0, sizeof(u32), buf);
> +}

None of these four functions seem particularly specific to L26; is there any
reason they don't belong in cs_dsp or wm_adsp? In fact, some of the functions
throughout those drivers seem to be doing similar work.

Maybe out of scope for this particular submission, but is there not any room
for re-use here?

> +
> +static const struct cs40l26_pseq_params cs40l26_pseq_params_write_full = {
> +	.num_op_words		= CS40L26_PSEQ_OP_WRITE_FULL_WORDS,
> +	.op_mask		= CS40L26_PSEQ_WRITE_FULL_OP_MASK,
> +	.low_addr_shift		= CS40L26_PSEQ_WRITE_FULL_LOWER_ADDR_SHIFT,
> +	.low_addr_mask		= CS40L26_PSEQ_WRITE_FULL_LOWER_ADDR_MASK,
> +	.low_data_mask		= CS40L26_PSEQ_WRITE_FULL_LOWER_DATA_MASK,
> +	.up_addr_shift		= CS40L26_PSEQ_WRITE_FULL_UPPER_ADDR_SHIFT,
> +	.up_addr_mask		= CS40L26_PSEQ_WRITE_FULL_UPPER_ADDR_MASK,
> +	.up_data_mask		= CS40L26_PSEQ_WRITE_FULL_UPPER_DATA_MASK,
> +	.up_data_shift		= CS40L26_PSEQ_WRITE_FULL_UPPER_DATA_SHIFT,
> +};
> +
> +static const struct cs40l26_pseq_params cs40l26_pseq_params_write_x16 = {
> +	.num_op_words		= CS40L26_PSEQ_OP_WRITE_X16_WORDS,
> +	.op_mask		= CS40L26_PSEQ_WRITE_X16_OP_MASK,
> +	.low_addr_shift		= CS40L26_PSEQ_WRITE_X16_LOWER_ADDR_SHIFT,
> +	.low_addr_mask		= CS40L26_PSEQ_WRITE_X16_LOWER_ADDR_MASK,
> +	.low_data_mask		= 0,
> +	.up_addr_shift		= CS40L26_PSEQ_WRITE_X16_UPPER_ADDR_SHIFT,
> +	.up_addr_mask		= CS40L26_PSEQ_WRITE_X16_UPPER_ADDR_MASK,
> +	.up_data_mask		= CS40L26_PSEQ_WRITE_X16_UPPER_DATA_MASK,
> +	.up_data_shift		= CS40L26_PSEQ_WRITE_X16_UPPER_DATA_SHIFT,
> +};
> +
> +static int cs40l26_pseq_find_end(struct cs40l26_private *cs40l26, struct cs40l26_pseq_op **op_end)
> +{
> +	struct cs40l26_pseq_op *op;
> +
> +	list_for_each_entry(op, &cs40l26->pseq_op_head, list) {
> +		if (op->operation == CS40L26_PSEQ_OP_END)
> +			break;
> +	}
> +
> +	if (op->operation != CS40L26_PSEQ_OP_END) {
> +		dev_err(cs40l26->dev, "Failed to find PSEQ list terminator\n");
> +		return -ENOENT;
> +	}
> +
> +	*op_end = op;
> +
> +	return 0;
> +}
> +
> +static int cs40l26_pseq_write(struct cs40l26_private *cs40l26, u32 addr, u32 data, bool update,
> +		u8 op_code)
> +{
> +	struct device *dev = cs40l26->dev;
> +	bool is_new = true;
> +	struct cs40l26_pseq_op *op, *op_new, *op_end;
> +	const struct cs40l26_pseq_params *params;
> +	int ret;
> +
> +	switch (op_code) {
> +	case CS40L26_PSEQ_OP_WRITE_FULL:
> +		/*
> +		 * The DSP sign-extends bit 23 to bits[31:24].
> +		 * Warn if POWER_ON_SEQUENCE will not function as expected.
> +		 */
> +		if ((data & BIT(23)) && (((data & GENMASK(31, 24)) >> 24) != 0xFF))
> +			dev_warn(dev, "PSEQ will sign extend: %08X @ %08X", data, addr);

Assuming I am browsing dmesg to debug an L26 issue, what do I do with this
information as a customer? Perhaps you should block this operation altogether?

If there is a compelling reason to allow this operation with a warning, please
add more details as to what "not function as expected" means. If this path is
never expected to happen in real life but is left open for debug purposes, add
some comments to explain.

> +
> +		params = &cs40l26_pseq_params_write_full;
> +		break;
> +	case CS40L26_PSEQ_OP_WRITE_L16:
> +	case CS40L26_PSEQ_OP_WRITE_H16:
> +		if (addr & CS40L26_PSEQ_INVALID_ADDR) {
> +			dev_err(dev, "Invalid PSEQ address: 0x%08X\n", addr);
> +			return -EINVAL;
> +		}
> +
> +		params = &cs40l26_pseq_params_write_x16;
> +		break;
> +	default:
> +		dev_err(dev, "Invalid PSEQ OP code: 0x%02X\n", op_code);
> +		return -EINVAL;
> +	}
> +
> +	op_new = devm_kzalloc(dev, sizeof(struct cs40l26_pseq_op), GFP_KERNEL);
> +	if (!op_new)
> +		return -ENOMEM;
> +
> +	op_new->size = params->num_op_words;
> +	op_new->operation = op_code;
> +	op_new->words[0] = (op_code << CS40L26_PSEQ_OP_SHIFT);
> +	op_new->words[0] |= (addr & params->up_addr_mask) >> params->up_addr_shift;
> +	op_new->words[1] = (addr & params->low_addr_mask) << params->low_addr_shift;
> +	op_new->words[1] |= (data & params->up_data_mask) >> params->up_data_shift;
> +	if (op_code == CS40L26_PSEQ_OP_WRITE_FULL)
> +		op_new->words[2] = data & params->low_data_mask;
> +
> +	list_for_each_entry(op, &cs40l26->pseq_op_head, list) {
> +		if (op->words[0] == op_new->words[0] && (op->words[1] & params->op_mask) ==
> +				(op_new->words[1] & params->op_mask) && update) {
> +			if (op->size != params->num_op_words) {
> +				dev_err(dev, "Failed to replace PSEQ op.\n");
> +				ret = -EINVAL;
> +				goto op_new_free;
> +			}
> +			is_new = false;
> +			break;
> +		}
> +	}
> +
> +	ret = cs40l26_pseq_find_end(cs40l26, &op_end);
> +	if (ret)
> +		goto op_new_free;
> +
> +	if (((CS40L26_PSEQ_MAX_WORDS * sizeof(u32)) - op_end->offset) <
> +			(op_new->size * sizeof(u32))) {
> +		dev_err(dev, "Not enough space in pseq to add op\n");
> +		ret = -ENOMEM;
> +		goto op_new_free;
> +	}
> +
> +	if (is_new) {
> +		op_new->offset = op_end->offset;
> +		op_end->offset += (op_new->size * sizeof(u32));
> +	} else {
> +		op_new->offset = op->offset;
> +	}
> +
> +	ret = cs40l26_fw_ctl_write_raw(&cs40l26->dsp, "POWER_ON_SEQUENCE", CS40L26_PM_ALGO_ID,
> +			op_new->offset / sizeof(u32), op_new->size * sizeof(u32), op_new->words);
> +	if (ret)
> +		goto op_new_free;
> +
> +	if (is_new) {
> +		ret = cs40l26_fw_ctl_write_raw(&cs40l26->dsp, "POWER_ON_SEQUENCE",
> +				CS40L26_PM_ALGO_ID, op_end->offset / sizeof(u32),
> +				op_end->size * sizeof(u32), op_end->words);
> +		if (ret)
> +			goto op_new_free;
> +
> +		list_add(&op_new->list, &cs40l26->pseq_op_head);
> +		cs40l26->pseq_num_ops++;
> +	} else {
> +		list_replace(&op->list, &op_new->list);
> +	}
> +
> +	return 0;
> +
> +op_new_free:
> +	devm_kfree(dev, op_new);
> +
> +	return ret;
> +}
> +
> +static int cs40l26_pseq_multi_write(struct cs40l26_private *cs40l26,
> +		const struct reg_sequence *reg_seq, int num_regs, bool update, u8 op_code)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < num_regs; i++) {
> +		ret = cs40l26_pseq_write(cs40l26, reg_seq[i].reg, reg_seq[i].def, update, op_code);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cs40l26_update_reg_defaults_via_pseq(struct cs40l26_private *cs40l26)
> +{
> +	int ret;
> +
> +	ret = cs40l26_pseq_write(cs40l26, CS40L26_NGATE1_INPUT, CS40L26_DATA_SRC_DSP1TX4, true,
> +			CS40L26_PSEQ_OP_WRITE_L16);

This driver makes quite liberal use of the recently introduced 100-column
line limit and as a result, may be difficult to fit in some editors.

Opinions vary of course, but I still find it best to stick with 80 columns
where possible, especially for cases like this where you need to line-break
anyway. Creeping into columns 80-100 should really only be done in cases
where doing otherwise would make the code difficult to read.

> +	if (ret)
> +		return ret;
> +
> +	ret = cs40l26_pseq_write(cs40l26, CS40L26_MIXER_NGATE_CH1_CFG,
> +			CS40L26_MIXER_NGATE_CH1_CFG_DEFAULT, true, CS40L26_PSEQ_OP_WRITE_FULL);
> +	if (ret)
> +		return ret;
> +
> +	return cs40l26_pseq_write(cs40l26, CS40L26_TST_DAC_MSM_CONFIG,
> +			CS40L26_TST_DAC_MSM_CFG_DFLT_CHG_VAL_H16, true, CS40L26_PSEQ_OP_WRITE_H16);
> +}
> +
> +static int cs40l26_pseq_init(struct cs40l26_private *cs40l26)
> +{
> +	struct cs40l26_pseq_op *pseq_op;
> +	int ret, i, num_words;
> +	u8 operation;
> +	u32 *words;
> +
> +	INIT_LIST_HEAD(&cs40l26->pseq_op_head);
> +	cs40l26->pseq_num_ops = 0;
> +
> +	words = kcalloc(CS40L26_PSEQ_MAX_WORDS, sizeof(u32), GFP_KERNEL);
> +	if (IS_ERR_OR_NULL(words))
> +		return -ENOMEM;
> +
> +	ret = cs40l26_fw_ctl_read_raw(&cs40l26->dsp, "POWER_ON_SEQUENCE", CS40L26_PM_ALGO_ID, 0,
> +			CS40L26_PSEQ_MAX_WORDS * sizeof(u32), words);
> +	if (ret)
> +		goto err_free;
> +
> +	for (i = 0; i < CS40L26_PSEQ_MAX_WORDS; i += num_words) {
> +		operation = (words[i] & CS40L26_PSEQ_OP_MASK) >> CS40L26_PSEQ_OP_SHIFT;
> +
> +		switch (operation) {
> +		case CS40L26_PSEQ_OP_END:
> +			num_words = CS40L26_PSEQ_OP_END_WORDS;
> +			break;
> +		case CS40L26_PSEQ_OP_WRITE_ADDR8:
> +		case CS40L26_PSEQ_OP_WRITE_H16:
> +		case CS40L26_PSEQ_OP_WRITE_L16:
> +			num_words = CS40L26_PSEQ_OP_WRITE_X16_WORDS;
> +			break;
> +		case CS40L26_PSEQ_OP_WRITE_FULL:
> +			num_words = CS40L26_PSEQ_OP_WRITE_FULL_WORDS;
> +			break;
> +		default:
> +			dev_err(cs40l26->dev, "Invalid OP code 0x%02X\n", operation);
> +			ret = -EINVAL;
> +			goto err_free;
> +		}
> +
> +		pseq_op = devm_kzalloc(cs40l26->dev, sizeof(struct cs40l26_pseq_op), GFP_KERNEL);
> +		if (!pseq_op) {
> +			ret = -ENOMEM;
> +			goto err_free;
> +		}
> +
> +		memcpy(pseq_op->words, &words[i], num_words * sizeof(u32));
> +		pseq_op->size = num_words;
> +		pseq_op->offset = i * sizeof(u32);
> +		pseq_op->operation = operation;
> +		list_add(&pseq_op->list, &cs40l26->pseq_op_head);
> +
> +		cs40l26->pseq_num_ops++;
> +
> +		if (operation == CS40L26_PSEQ_OP_END)
> +			break;
> +	}
> +
> +	if (operation != CS40L26_PSEQ_OP_END) {
> +		dev_err(cs40l26->dev, "PSEQ_END_OF_SCRIPT not found\n");
> +		ret = -ENOENT;
> +		goto err_free;
> +	}
> +
> +	ret = cs40l26_update_reg_defaults_via_pseq(cs40l26);
> +
> +err_free:
> +	kfree(words);
> +
> +	return ret;
> +}
> +
> +static inline void cs40l26_pm_exit(struct device *dev)
> +{
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +}
> +
> +static inline int cs40l26_pm_enter(struct device *dev)
> +{
> +	return pm_runtime_resume_and_get(dev);
> +}
> +
> +static inline int cs40l26_pm_timeout_ms_set(struct cs40l26_private *cs40l26,
> +		unsigned int dsp_state, u32 timeout_ms)
> +{
> +	return regmap_write(cs40l26->regmap,
> +			(dsp_state == CS40L26_DSP_STATE_STANDBY) ?
> +			CS40L26_A1_PM_STDBY_TICKS_STATIC_REG :
> +			CS40L26_A1_PM_ACTIVE_TICKS_STATIC_REG,
> +			timeout_ms * CS40L26_PM_TICKS_PER_MS);
> +}
> +
> +static inline int cs40l26_pm_timeout_ms_get(struct cs40l26_private *cs40l26,
> +		unsigned int dsp_state, u32 *timeout_ms)
> +{
> +	u32 timeout_ticks;
> +	int ret;
> +
> +	ret = regmap_read(cs40l26->regmap, (dsp_state == CS40L26_DSP_STATE_STANDBY) ?
> +			CS40L26_A1_PM_STDBY_TICKS_STATIC_REG :
> +			CS40L26_A1_PM_ACTIVE_TICKS_STATIC_REG, &timeout_ticks);
> +	if (ret)
> +		return ret;
> +
> +	*timeout_ms = timeout_ticks / CS40L26_PM_TICKS_PER_MS;
> +
> +	return 0;
> +}
> +
> +static inline void cs40l26_pm_runtime_setup(struct cs40l26_private *cs40l26)
> +{
> +	pm_runtime_mark_last_busy(cs40l26->dev);
> +	pm_runtime_use_autosuspend(cs40l26->dev);
> +	pm_runtime_set_autosuspend_delay(cs40l26->dev, CS40L26_AUTOSUSPEND_DELAY_MS);
> +	pm_runtime_enable(cs40l26->dev);

My first impression was that this driver is doing an uncommonly large
amount of PM-related housekeeping. In fact, not a single haptic driver
in mainline is calling any of these. What is unique about this device
that calls for this much overhead?

Can the device wake up from hibernation (AoH?) from both control port
and GPIO triggers? If so, why not to simply allow the device to hibernate
at its own discretion and avoid all PM-related housekeeping? Stated
another way, it seems some of the DSP's job is unnecessarily duplicated
in the kernel.

In case I have misunderstood, please let me know.

> +}
> +
> +static inline void cs40l26_pm_runtime_teardown(struct cs40l26_private *cs40l26)
> +{
> +	pm_runtime_disable(cs40l26->dev);
> +	pm_runtime_dont_use_autosuspend(cs40l26->dev);
> +}
> +
> +static int cs40l26_irq_update_mask(struct cs40l26_private *cs40l26, u32 reg, u32 val, u32 bit_mask)
> +{
> +	u32 eint_reg, cur_mask, new_mask;
> +	int ret;
> +
> +	if (reg == CS40L26_IRQ1_MASK_1) {
> +		eint_reg = CS40L26_IRQ1_EINT_1;
> +	} else if (reg == CS40L26_IRQ1_MASK_2) {
> +		eint_reg = CS40L26_IRQ1_EINT_2;
> +	} else {
> +		dev_err(cs40l26->dev, "Invalid IRQ mask reg: 0x%08X\n", reg);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(cs40l26->regmap, reg, &cur_mask);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to get IRQ mask\n");

Having a custom error message for every possible failed register read
does not ultimately aid in debugging and unnecessarily grows the size
of the driver.

If a specific message is absolutely necessary, then add wrappers around
regmap_read/write and print the failed address. However, this does not
seem necessary either. Simply propagate the error code all the way up
to the caller, whether it is probe or a sysfs attribute.

Stated another way:

error = regmap_...(...);
if (error)
	return error;

> +		return ret;
> +	}
> +
> +	new_mask = (cur_mask & ~bit_mask) | val;
> +
> +	ret = regmap_write(cs40l26->regmap, eint_reg, bit_mask);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to clear IRQ\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_write(cs40l26->regmap, reg, new_mask);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to update IRQ mask\n");
> +		return ret;
> +	}
> +
> +	if (bit_mask & GENMASK(31, 16)) {
> +		ret = cs40l26_pseq_write(cs40l26, reg, (new_mask & GENMASK(31, 16)) >> 16,
> +				true, CS40L26_PSEQ_OP_WRITE_H16);
> +		if (ret) {
> +			dev_err(cs40l26->dev, "Failed to update IRQ mask H16");
> +			return ret;
> +		}
> +	}
> +
> +	if (bit_mask & GENMASK(15, 0)) {
> +		ret = cs40l26_pseq_write(cs40l26, reg, (new_mask & GENMASK(15, 0)), true,
> +				CS40L26_PSEQ_OP_WRITE_L16);
> +		if (ret) {
> +			dev_err(cs40l26->dev, "Failed to update IRQ mask L16");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static inline int cs40l26_gpio_timeout_ms_set(struct cs40l26_private *cs40l26, u32 timeout_ms)
> +{
> +	return cs40l26_fw_ctl_write(&cs40l26->dsp, "TIMEOUT_GPI_MS", CS40L26_VIBEGEN_ALGO_ID,
> +			timeout_ms);
> +}
> +
> +static int cs40l26_erase_gpio_mapping(struct cs40l26_private *cs40l26,
> +		enum cs40l26_gpio_map mapping)
> +{
> +	u32 disable = CS40L26_EVENT_MAP_GPI_DISABLE;
> +	u32 offset;
> +	int ret;
> +
> +	switch (mapping) {
> +	case CS40L26_GPIO_MAP_A_PRESS:
> +		offset = 0;
> +		break;
> +	case CS40L26_GPIO_MAP_A_RELEASE:
> +		offset = 1;
> +		break;
> +	default:
> +		dev_err(cs40l26->dev, "Invalid GPIO mapping: %u\n", mapping);
> +		return -EINVAL;
> +	}
> +
> +	if (cs40l26->dsp.running) {
> +		mutex_lock(&cs40l26->dsp.pwr_lock);
> +
> +		ret = cs40l26_fw_ctl_write_raw(&cs40l26->dsp, "ENT_MAP_TABLE_EVENT_DATA_PACKED",
> +				CS40L26_EVENT_HANDLER_ALGO_ID, offset, sizeof(u32), &disable);

Is there any reason not to simply pass 'mapping' as the 'off_words' parameter?

> +		if (ret) {
> +			mutex_unlock(&cs40l26->dsp.pwr_lock);
> +			return ret;
> +		}
> +
> +		ret = cs40l26_gpio_timeout_ms_set(cs40l26, 0);
> +
> +		mutex_unlock(&cs40l26->dsp.pwr_lock);
> +	} else {
> +		ret = regmap_write(cs40l26->regmap, CS40L26_A1_EVENT_MAP_1, disable);
> +		if (ret)
> +			dev_err(cs40l26->dev, "Failed to erase GPIO mapping: %d\n", ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int cs40l26_gpio_config(struct cs40l26_private *cs40l26)
> +{
> +	u32 defaults[2], mask, val;
> +	int ret;
> +
> +	defaults[0] = cs40l26->gpio_release_default;
> +	defaults[1] = cs40l26->gpio_press_default;
> +
> +	ret = cs40l26_fw_ctl_write_raw(&cs40l26->dsp, "ENT_MAP_TABLE_EVENT_DATA_PACKED",
> +			CS40L26_EVENT_HANDLER_ALGO_ID, 0, 2 * sizeof(u32), defaults);
> +	if (ret)
> +		return ret;
> +
> +	switch (cs40l26->devid) {
> +	case CS40L26_DEVID_A:
> +	case CS40L26_DEVID_L27_A:
> +		val = (u32) GENMASK(CS40L26_IRQ1_GPIO4_FALL, CS40L26_IRQ1_GPIO2_RISE);
> +		break;
> +	default:
> +		val = 0;
> +	}
> +
> +	mask = (u32) GENMASK(CS40L26_IRQ1_GPIO4_FALL, CS40L26_IRQ1_GPIO1_RISE);

There is no need to type-cast this, as the result is less than 32 bits wide
anyway. Please note the space would not be necessary after (u32) either.

> +
> +	return cs40l26_irq_update_mask(cs40l26, CS40L26_IRQ1_MASK_1, val, mask);
> +}
> +
> +static int cs40l26_map_effect_to_gpio(struct cs40l26_private *cs40l26, struct ff_effect *effect,
> +		struct cs40l26_uploaded_effect *ueffect)
> +{
> +	u16 button = effect->trigger.button;
> +	u8 edge, ev_handler_bank_ram, gpio;
> +	unsigned int offset;
> +	u32 write_val;
> +	int ret;
> +
> +	gpio = (button & CS40L26_BTN_NUM_MASK) >> CS40L26_BTN_NUM_SHIFT;
> +	edge = (button & CS40L26_BTN_EDGE_MASK) >> CS40L26_BTN_EDGE_SHIFT;
> +
> +	if (gpio != 1) {
> +		dev_err(cs40l26->dev, "GPIO%u not supported on 0x%02X\n", gpio, cs40l26->revid);
> +		return -EINVAL;
> +	}
> +
> +	ev_handler_bank_ram = (ueffect->wvfrm_bank == CS40L26_WVFRM_BANK_RAM ||
> +			ueffect->wvfrm_bank == CS40L26_WVFRM_BANK_BUZ) ? 1 : 0;
> +
> +	offset = edge ? 0 : 1;
> +
> +	write_val = (ueffect->trigger_index & CS40L26_BTN_INDEX_MASK) |
> +			(ev_handler_bank_ram << CS40L26_BTN_BANK_SHIFT);
> +
> +	mutex_lock(&cs40l26->dsp.pwr_lock);
> +
> +	ret = cs40l26_fw_ctl_write_raw(&cs40l26->dsp, "ENT_MAP_TABLE_EVENT_DATA_PACKED",
> +			CS40L26_EVENT_HANDLER_ALGO_ID, offset, sizeof(u32), &write_val);
> +	if (ret)
> +		goto err_pwr_lock;
> +
> +	ret = cs40l26_gpio_timeout_ms_set(cs40l26, effect->replay.length);
> +
> +err_pwr_lock:
> +	mutex_unlock(&cs40l26->dsp.pwr_lock);
> +	if (ret)
> +		return ret;
> +
> +	ueffect->mapping = edge ? CS40L26_GPIO_MAP_A_PRESS : CS40L26_GPIO_MAP_A_RELEASE;
> +
> +	return 0;
> +}
> +
> +static inline int cs40l26_num_waves_get(struct cs40l26_private *cs40l26,
> +					u32 *num_waves)
> +{
> +	return cs40l26_fw_ctl_read(&cs40l26->dsp, "NUM_OF_WAVES", CS40L26_VIBEGEN_ALGO_ID,
> +			num_waves);
> +}
> +
> +static struct cs40l26_uploaded_effect *cs40l26_uploaded_effect_find(struct cs40l26_private *cs40l26,
> +		int id)
> +{
> +	struct cs40l26_uploaded_effect *ueffect;
> +
> +	if (list_empty(&cs40l26->effect_head)) {
> +		dev_dbg(cs40l26->dev, "Effect list is empty\n");
> +		return ERR_PTR(-ENODATA);
> +	}
> +
> +	list_for_each_entry(ueffect, &cs40l26->effect_head, list) {
> +		if (ueffect->id == id)
> +			return ueffect;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct cs40l26_buzzgen_config cs40l26_buzzgen_configs[] = {
> +	{ .duration_name = "BUZZ_EFFECTS2_BUZZ_DURATION",
> +	  .freq_name = "BUZZ_EFFECTS2_BUZZ_FREQ",
> +	  .level_name = "BUZZ_EFFECTS2_BUZZ_LEVEL",
> +	  .effect_id = -1 },
> +
> +	{ .duration_name = "BUZZ_EFFECTS3_BUZZ_DURATION",
> +	  .freq_name = "BUZZ_EFFECTS3_BUZZ_FREQ",
> +	  .level_name = "BUZZ_EFFECTS3_BUZZ_LEVEL",
> +	  .effect_id = -1 },
> +
> +	{ .duration_name = "BUZZ_EFFECTS4_BUZZ_DURATION",
> +	  .freq_name = "BUZZ_EFFECTS4_BUZZ_FREQ",
> +	  .level_name = "BUZZ_EFFECTS4_BUZZ_LEVEL",
> +	  .effect_id = -1 },
> +
> +	{ .duration_name = "BUZZ_EFFECTS5_BUZZ_DURATION",
> +	  .freq_name = "BUZZ_EFFECTS5_BUZZ_FREQ",
> +	  .level_name = "BUZZ_EFFECTS5_BUZZ_LEVEL",
> +	  .effect_id = -1 },
> +
> +	{ .duration_name = "BUZZ_EFFECTS6_BUZZ_DURATION",
> +	  .freq_name = "BUZZ_EFFECTS6_BUZZ_FREQ",
> +	  .level_name = "BUZZ_EFFECTS6_BUZZ_LEVEL",
> +	  .effect_id = -1 },

Please format these as follows:

	{
		.duration_name = ...,
		.freq_name = ...,
		.level_name = ...,
		.effect_id = ...,
	},
	[...]

> +};
> +
> +static int cs40l26_buzzgen_find_slot(struct cs40l26_private *cs40l26, int id)
> +{
> +	int i, slot = -1;
> +
> +	for (i = CS40L26_BUZZGEN_NUM_CONFIGS - 1; i >= 0; i--) {
> +		if (cs40l26_buzzgen_configs[i].effect_id == id) {
> +			slot = i;
> +			break;
> +		} else if (cs40l26_buzzgen_configs[i].effect_id == -1) {
> +			slot = i;
> +		}
> +	}
> +
> +	return slot;
> +}
> +
> +static int cs40l26_erase_buzzgen(struct cs40l26_private *cs40l26, int id)
> +{
> +	int slot = cs40l26_buzzgen_find_slot(cs40l26, id);
> +
> +	if (slot == -1) {
> +		dev_err(cs40l26->dev, "Failed to erase BUZZGEN config for id %d\n", id);
> +		return -EINVAL;
> +	}
> +
> +	cs40l26_buzzgen_configs[slot].effect_id = -1;
> +
> +	return 0;
> +}
> +
> +static int cs40l26_sine_upload(struct cs40l26_private *cs40l26, struct ff_effect *effect,
> +		struct cs40l26_uploaded_effect *ueffect)
> +{
> +	u32 freq, level, duration;
> +	int ret, slot;
> +
> +	slot = cs40l26_buzzgen_find_slot(cs40l26, effect->id);
> +	if (slot == -1) {
> +		dev_err(cs40l26->dev, "No free BUZZGEN slot available\n");
> +		return -ENOSPC;
> +	}
> +
> +	cs40l26_buzzgen_configs[slot].effect_id = effect->id;
> +
> +	/* Divide by 4 to match firmware's formatting expectation */
> +	duration = (u32) (effect->replay.length / 4);
> +
> +	if (effect->u.periodic.period < CS40L26_BUZZGEN_PERIOD_MS_MIN)
> +		freq = 1000 / CS40L26_BUZZGEN_PERIOD_MS_MIN;
> +	else if (effect->u.periodic.period > CS40L26_BUZZGEN_PERIOD_MS_MAX)
> +		freq = 1000 / CS40L26_BUZZGEN_PERIOD_MS_MAX;
> +	else
> +		freq = 1000 / effect->u.periodic.period;
> +
> +	if (effect->u.periodic.magnitude < CS40L26_BUZZGEN_LEVEL_MIN)
> +		level = CS40L26_BUZZGEN_LEVEL_MIN;
> +	else if (effect->u.periodic.magnitude > CS40L26_BUZZGEN_LEVEL_MAX)
> +		level = CS40L26_BUZZGEN_LEVEL_MAX;
> +	else
> +		level = effect->u.periodic.magnitude;
> +
> +	mutex_lock(&cs40l26->dsp.pwr_lock);
> +
> +	ret = cs40l26_fw_ctl_write(&cs40l26->dsp, cs40l26_buzzgen_configs[slot].duration_name,
> +			CS40L26_BUZZGEN_ALGO_ID, duration);
> +	if (ret)
> +		goto err_pwr_lock;
> +
> +	ret = cs40l26_fw_ctl_write(&cs40l26->dsp, cs40l26_buzzgen_configs[slot].freq_name,
> +			CS40L26_BUZZGEN_ALGO_ID, freq);
> +	if (ret)
> +		goto err_pwr_lock;
> +
> +	ret = cs40l26_fw_ctl_write(&cs40l26->dsp, cs40l26_buzzgen_configs[slot].level_name,
> +			CS40L26_BUZZGEN_ALGO_ID, level);
> +err_pwr_lock:
> +	mutex_unlock(&cs40l26->dsp.pwr_lock);
> +	if (ret)
> +		return ret;
> +
> +	ueffect->id = effect->id;
> +	ueffect->wvfrm_bank = CS40L26_WVFRM_BANK_BUZ;
> +	/*
> +	 * BUZZGEN 1 is reserved for OTP buzz; BUZZGEN 2 - BUZZGEN 6 are valid.
> +	 * Add an offset of 1 for this reason.
> +	 */
> +	ueffect->trigger_index = CS40L26_BUZZGEN_INDEX_START + slot + 1;
> +
> +	return 0;
> +}
> +
> +static int cs40l26_custom_upload(struct cs40l26_private *cs40l26, struct ff_effect *effect,
> +		struct cs40l26_uploaded_effect *ueffect)
> +{
> +	struct device *dev = cs40l26->dev;
> +	u32 nwaves, min_index, max_index, trigger_index;
> +	u16 bank, index;
> +	int ret;
> +
> +	mutex_lock(&cs40l26->dsp.pwr_lock);
> +	ret = cs40l26_num_waves_get(cs40l26, &nwaves);
> +	mutex_unlock(&cs40l26->dsp.pwr_lock);
> +	if (ret)
> +		return ret;
> +
> +	bank = (u16) (cs40l26->raw_custom_data[0] & 0xffffu);
> +	index = (u16) (cs40l26->raw_custom_data[1] & 0xffffu);
> +
> +	if (bank == CS40L26_WVFRM_BANK_RAM) {
> +		if (nwaves == 0) {
> +			dev_err(dev, "No waveforms in RAM\n");
> +			return -ENODATA;
> +		}
> +
> +		min_index = CS40L26_RAM_INDEX_START;
> +		max_index = min_index + nwaves - 1;
> +	} else if (bank == CS40L26_WVFRM_BANK_ROM) {
> +		min_index = CS40L26_ROM_INDEX_START;
> +		max_index = CS40L26_ROM_INDEX_END;
> +	} else {
> +		dev_err(dev, "Invalid custom waveform bank: %u\n", bank);
> +		return -EINVAL;
> +	}
> +
> +	trigger_index = index + min_index;
> +	if (trigger_index > max_index) {
> +		dev_err(dev, "RAM index 0x%X out of bounds\n", trigger_index);
> +		return -EINVAL;
> +	}
> +	dev_dbg(dev, "%s: Trigger Index = 0x%08X\n", __func__, trigger_index);
> +
> +	ueffect->id = effect->id;
> +	ueffect->wvfrm_bank = bank;
> +	ueffect->trigger_index = trigger_index;
> +
> +	return 0;
> +}
> +
> +static int cs40l26_uploaded_effect_add(struct cs40l26_private *cs40l26)
> +{
> +	struct ff_effect *effect = &cs40l26->upload_effect;
> +	struct device *dev = cs40l26->dev;
> +	bool is_new = false;
> +	struct cs40l26_uploaded_effect *ueffect;
> +	int ret;
> +
> +	ueffect = cs40l26_uploaded_effect_find(cs40l26, cs40l26->upload_effect.id);
> +	if (IS_ERR_OR_NULL(ueffect)) {
> +		is_new = true;
> +		ueffect = kzalloc(sizeof(struct cs40l26_uploaded_effect), GFP_KERNEL);

Where does this memory get freed when the driver is torn down? Did you mean to
use devm_kzalloc() here?

> +		if (IS_ERR_OR_NULL(ueffect))
> +			return -ENOMEM;
> +	}
> +
> +	if (effect->u.periodic.waveform == FF_CUSTOM) {
> +		ret = cs40l26_custom_upload(cs40l26, effect, ueffect);
> +	} else if (effect->u.periodic.waveform == FF_SINE) {
> +		ret = cs40l26_sine_upload(cs40l26, effect, ueffect);
> +	} else {
> +		dev_err(dev, "Invalid periodic waveform type: 0x%X\n", effect->u.periodic.waveform);
> +		ret = -EINVAL;
> +	}
> +	if (ret)
> +		goto err_free;
> +
> +	if (effect->trigger.button) {
> +		ret = cs40l26_map_effect_to_gpio(cs40l26, effect, ueffect);
> +		if (ret)
> +			goto err_free;
> +	} else {
> +		ueffect->mapping = CS40L26_GPIO_MAP_INVALID;
> +	}
> +
> +	if (is_new)
> +		list_add(&ueffect->list, &cs40l26->effect_head);
> +
> +	return 0;
> +
> +err_free:
> +	if (is_new)
> +		kfree(ueffect);
> +
> +	return ret;
> +}
> +
> +static void cs40l26_upload_worker(struct work_struct *work)
> +{
> +	struct cs40l26_private *cs40l26 = container_of(work, struct cs40l26_private, upload_work);
> +	struct device *dev = cs40l26->dev;
> +
> +	cs40l26->upload_ret = cs40l26_pm_enter(dev);
> +	if (cs40l26->upload_ret)
> +		return;
> +
> +	mutex_lock(&cs40l26->lock);
> +
> +	cs40l26->upload_ret =  cs40l26_uploaded_effect_add(cs40l26);
> +
> +	mutex_unlock(&cs40l26->lock);
> +
> +	cs40l26_pm_exit(dev);
> +}
> +
> +static void cs40l26_vibe_start_worker(struct work_struct *work)
> +{
> +	struct cs40l26_uploaded_effect *ueffect;
> +	struct cs40l26_private *cs40l26;
> +	struct ff_effect *effect;
> +	struct device *dev;
> +	u32 invert;
> +	int ret;
> +
> +	cs40l26 = container_of(work, struct cs40l26_private, vibe_start_work);
> +	dev = cs40l26->dev;
> +
> +	ret = cs40l26_pm_enter(dev);
> +	if (ret)
> +		return;
> +
> +	mutex_lock(&cs40l26->lock);
> +
> +	effect = cs40l26->trigger_effect;
> +
> +	ueffect = cs40l26_uploaded_effect_find(cs40l26, effect->id);
> +	if (IS_ERR_OR_NULL(ueffect)) {
> +		dev_err(dev, "No such effect (ID = %d)\n", effect->id);
> +		goto err_mutex;
> +	}
> +
> +	mutex_lock(&cs40l26->dsp.pwr_lock);
> +
> +	ret = cs40l26_fw_ctl_write(&cs40l26->dsp, "TIMEOUT_MS", CS40L26_VIBEGEN_ALGO_ID,
> +			effect->replay.length);
> +	if (ret)
> +		goto err_pwr_lock;
> +
> +	switch (effect->direction) {
> +	case 0x0000:
> +		invert = 0;
> +		break;
> +	case 0x8000:
> +		invert = 1;
> +		break;
> +	default:
> +		dev_err(dev, "Invalid direction 0x%X\n", effect->direction);
> +		goto err_pwr_lock;
> +	}
> +
> +	ret = cs40l26_fw_ctl_write(&cs40l26->dsp, "SOURCE_INVERT", CS40L26_EXT_ALGO_ID, invert);
> +	if (ret)
> +		goto err_pwr_lock;
> +
> +	ret = cs40l26_mailbox_write(cs40l26, ueffect->trigger_index);
> +	if (ret)
> +		goto err_pwr_lock;
> +
> +	reinit_completion(&cs40l26->erase);
> +
> +err_pwr_lock:
> +	mutex_unlock(&cs40l26->dsp.pwr_lock);
> +err_mutex:
> +	mutex_unlock(&cs40l26->lock);
> +
> +	cs40l26_pm_exit(dev);
> +}
> +
> +static void cs40l26_vibe_stop_worker(struct work_struct *work)
> +{
> +	struct cs40l26_private *cs40l26;
> +	int ret;
> +
> +	cs40l26 = container_of(work, struct cs40l26_private, vibe_stop_work);
> +
> +	ret = cs40l26_pm_enter(cs40l26->dev);
> +	if (ret)
> +		return;
> +
> +	mutex_lock(&cs40l26->lock);
> +
> +	ret = cs40l26_mailbox_write(cs40l26, CS40L26_DSP_MBOX_CMD_STOP_PLAYBACK);
> +	if (ret)
> +		dev_err(cs40l26->dev, "Failed to stop playback\n");
> +
> +	mutex_unlock(&cs40l26->lock);
> +	cs40l26_pm_exit(cs40l26->dev);
> +}
> +
> +static void cs40l26_erase_worker(struct work_struct *work)
> +{
> +	struct cs40l26_uploaded_effect *ueffect;
> +	struct cs40l26_private *cs40l26;
> +	u16 duration, replay_len;
> +	int id;
> +
> +	cs40l26 = container_of(work, struct cs40l26_private, erase_work);
> +
> +	cs40l26->erase_ret = cs40l26_pm_enter(cs40l26->dev);
> +	if (cs40l26->erase_ret)
> +		return;
> +
> +	mutex_lock(&cs40l26->lock);
> +
> +	id = cs40l26->erase_effect->id;
> +	ueffect = cs40l26_uploaded_effect_find(cs40l26, id);
> +	if (IS_ERR_OR_NULL(ueffect)) {
> +		dev_err(cs40l26->dev, "Failed to erase nonexistent effect (%d)\n", id);
> +		cs40l26->erase_ret = PTR_ERR(ueffect);
> +		goto err_mutex;
> +	}
> +
> +	/* Wait for any ongoing playback to stop */
> +	replay_len = cs40l26->erase_effect->replay.length;
> +	duration = replay_len ? replay_len + 500 : CS40L26_VIBEGEN_MAX_TIME_MS;
> +
> +	mutex_unlock(&cs40l26->lock);
> +
> +	if (!wait_for_completion_timeout(&cs40l26->erase, msecs_to_jiffies(duration))) {
> +		cs40l26->erase_ret = -ETIME;
> +		dev_err(cs40l26->dev, "Timed out waiting for playback stop\n");
> +		goto err_pm;
> +	}
> +	mutex_lock(&cs40l26->lock);
> +
> +	if (ueffect->wvfrm_bank == CS40L26_WVFRM_BANK_BUZ) {
> +		cs40l26->erase_ret = cs40l26_erase_buzzgen(cs40l26, ueffect->id);
> +		if (cs40l26->erase_ret)
> +			goto err_mutex;
> +	}
> +
> +	if (ueffect->mapping != CS40L26_GPIO_MAP_INVALID) {
> +		cs40l26->erase_ret = cs40l26_erase_gpio_mapping(cs40l26, ueffect->mapping);
> +		if (cs40l26->erase_ret)
> +			goto err_mutex;
> +	}
> +
> +	list_del(&ueffect->list);
> +	kfree(ueffect);
> +
> +err_mutex:
> +	mutex_unlock(&cs40l26->lock);
> +err_pm:
> +	cs40l26_pm_exit(cs40l26->dev);
> +}
> +
> +static void cs40l26_set_gain_worker(struct work_struct *work)
> +{
> +	struct cs40l26_private *cs40l26 = container_of(work, struct cs40l26_private, set_gain_work);
> +
> +	if (cs40l26_pm_enter(cs40l26->dev))
> +		return;
> +
> +	mutex_lock(&cs40l26->lock);
> +	mutex_lock(&cs40l26->dsp.pwr_lock);
> +
> +	cs40l26_fw_ctl_write(&cs40l26->dsp, "SOURCE_ATTENUATION", CS40L26_EXT_ALGO_ID,
> +			cs40l26_atten_lut_q21_2[cs40l26->gain_pct]);
> +
> +	mutex_unlock(&cs40l26->dsp.pwr_lock);
> +	mutex_unlock(&cs40l26->lock);
> +	cs40l26_pm_exit(cs40l26->dev);
> +}
> +
> +static int cs40l26_upload_effect(struct input_dev *dev, struct ff_effect *effect,
> +		struct ff_effect *old)
> +{
> +	struct cs40l26_private *cs40l26 = input_get_drvdata(dev);
> +	u32 len = effect->u.periodic.custom_len;
> +	int ret;
> +
> +	if (effect->type != FF_PERIODIC) {
> +		dev_err(cs40l26->dev, "Effect type 0x%X not supported\n", effect->type);
> +		return -EINVAL;
> +	}
> +
> +	memcpy(&cs40l26->upload_effect, effect, sizeof(struct ff_effect));
> +
> +	if (effect->u.periodic.waveform == FF_CUSTOM) {
> +		cs40l26->raw_custom_data = kcalloc(len, sizeof(s16), GFP_KERNEL);
> +		if (IS_ERR_OR_NULL(cs40l26->raw_custom_data))
> +			return -ENOMEM;
> +
> +		if (copy_from_user(cs40l26->raw_custom_data, effect->u.periodic.custom_data,
> +				sizeof(s16) * len)) {
> +			dev_err(cs40l26->dev, "Failed to get user data\n");
> +			ret = -EFAULT;
> +			goto out_free;
> +		}
> +	}
> +
> +	/*
> +	 * The no-sleep nature of Input FF callbacks requires usage of
> +	 * worker functions in order to properly utilize the PM runtime
> +	 * framework.
> +	 */
> +	queue_work(cs40l26->vibe_workqueue, &cs40l26->upload_work);
> +	flush_work(&cs40l26->upload_work);
> +	ret = cs40l26->upload_ret;
> +
> +out_free:
> +	if (effect->u.periodic.waveform == FF_CUSTOM)
> +		kfree(cs40l26->raw_custom_data);
> +	cs40l26->raw_custom_data = NULL;
> +	memset(&cs40l26->upload_effect, 0, sizeof(struct ff_effect));
> +
> +	return ret;
> +}
> +
> +static int cs40l26_playback_effect(struct input_dev *dev, int effect_id, int val)
> +{
> +	struct cs40l26_private *cs40l26 = input_get_drvdata(dev);
> +
> +	cs40l26->trigger_effect = &dev->ff->effects[effect_id];
> +	if (IS_ERR_OR_NULL(cs40l26->trigger_effect)) {
> +		dev_err(cs40l26->dev, "No such effect (ID = %d)\n", effect_id);
> +		return -ENOENT;
> +	}
> +
> +	if (val > 0)
> +		queue_work(cs40l26->vibe_workqueue, &cs40l26->vibe_start_work);
> +	else
> +		queue_work(cs40l26->vibe_workqueue, &cs40l26->vibe_stop_work);
> +
> +	return 0;
> +}
> +
> +static int cs40l26_erase_effect(struct input_dev *dev, int effect_id)
> +{
> +	struct cs40l26_private *cs40l26 = input_get_drvdata(dev);
> +	struct ff_effect *effect;
> +
> +	effect = &dev->ff->effects[effect_id];
> +	if (IS_ERR_OR_NULL(effect)) {
> +		dev_err(cs40l26->dev, "Could not erase nonexistent effect\n");
> +		return -ENOENT;
> +	}
> +
> +	cs40l26->erase_effect = effect;
> +
> +	queue_work(cs40l26->vibe_workqueue, &cs40l26->erase_work);
> +	flush_work(&cs40l26->erase_work);
> +
> +	return cs40l26->erase_ret;
> +}
> +
> +static void cs40l26_set_gain(struct input_dev *dev, u16 gain)
> +{
> +	struct cs40l26_private *cs40l26 = input_get_drvdata(dev);
> +
> +	if (gain >= CS40L26_NUM_ATTEN_LUT_VALUES) {
> +		dev_err(cs40l26->dev, "Gain %u%% out of bounds\n", gain);
> +		return;
> +	}
> +
> +	cs40l26->gain_pct = gain;
> +	queue_work(cs40l26->vibe_workqueue, &cs40l26->set_gain_work);
> +}
> +
> +static int cs40l26_input_init(struct cs40l26_private *cs40l26)
> +{
> +	struct device *dev = cs40l26->dev;
> +	int ret;
> +
> +	cs40l26->input = devm_input_allocate_device(dev);
> +	if (IS_ERR_OR_NULL(cs40l26->input))
> +		return -ENOMEM;

devm_input_allocate_device() in the worst case only returns NULL, so:

if (!cs40l26->input)
	return -ENOMEM;

> +
> +	cs40l26->input->name = "cs40l26_input";
> +	cs40l26->input->id.product = cs40l26->devid;
> +	cs40l26->input->id.version = cs40l26->revid;
> +
> +	input_set_drvdata(cs40l26->input, cs40l26);
> +	input_set_capability(cs40l26->input, EV_FF, FF_PERIODIC);
> +	input_set_capability(cs40l26->input, EV_FF, FF_CUSTOM);
> +	input_set_capability(cs40l26->input, EV_FF, FF_SINE);
> +	input_set_capability(cs40l26->input, EV_FF, FF_GAIN);
> +
> +	ret = input_ff_create(cs40l26->input, FF_MAX_EFFECTS);
> +	if (ret) {
> +		dev_err(dev, "Failed to create FF device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * input_ff_create() automatically sets FF_RUMBLE capabilities;
> +	 * we want to restrtict this to only FF_PERIODIC
> +	 */
> +	__clear_bit(FF_RUMBLE, cs40l26->input->ffbit);
> +
> +	cs40l26->input->ff->upload = cs40l26_upload_effect;
> +	cs40l26->input->ff->playback = cs40l26_playback_effect;
> +	cs40l26->input->ff->erase = cs40l26_erase_effect;
> +	cs40l26->input->ff->set_gain = cs40l26_set_gain;
> +
> +	ret = input_register_device(cs40l26->input);
> +	if (ret) {
> +		dev_err(dev, "Cannot register input device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	INIT_LIST_HEAD(&cs40l26->effect_head);
> +
> +	return ret;
> +}
> +
> +static int cs40l26_bst_config(struct cs40l26_private *cs40l26)
> +{
> +	u32 bst_ipk_ma, bst_ipk_ctl, vbst_mv, vbst_ctl, vbst_cfg;
> +	int ret;
> +
> +	vbst_mv = cs40l26->pdata.vbst_uv / 1000;
> +	if (vbst_mv < CS40L26_VBST_MILLIVOLT_MIN || vbst_mv > CS40L26_VBST_MILLIVOLT_MAX)
> +		vbst_ctl = CS40L26_BST_CTL_VP;
> +	else
> +		vbst_ctl = ((vbst_mv - CS40L26_VBST_MILLIVOLT_MIN) / CS40L26_VBST_MILLIVOLT_STEP);
> +
> +	ret = regmap_write(cs40l26->regmap, CS40L26_VBST_CTL_1, vbst_ctl);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to update boost voltage: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = cs40l26_pseq_write(cs40l26, CS40L26_VBST_CTL_1, vbst_ctl, true,
> +			CS40L26_PSEQ_OP_WRITE_L16);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(cs40l26->regmap, CS40L26_VBST_CTL_2, &vbst_cfg);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to get boost control config: %d\n", ret);
> +		return ret;
> +	}
> +	vbst_cfg |= (1 << CS40L26_BST_CTL_LIM_EN_SHIFT);
> +
> +	ret = regmap_write(cs40l26->regmap, CS40L26_VBST_CTL_2, vbst_cfg);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to update boost control config: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = cs40l26_pseq_write(cs40l26, CS40L26_VBST_CTL_2, vbst_cfg, true,
> +			CS40L26_PSEQ_OP_WRITE_FULL);
> +	if (ret)
> +		return ret;
> +
> +	bst_ipk_ma = cs40l26->pdata.bst_ipk_ua / 1000;
> +	if (bst_ipk_ma < CS40L26_BST_IPK_MILLIAMP_MIN || bst_ipk_ma > CS40L26_BST_IPK_MILLIAMP_MAX)
> +		bst_ipk_ctl = CS40L26_BST_IPK_MILLIAMP_DEFAULT;
> +	else
> +		bst_ipk_ctl = (bst_ipk_ma / CS40L26_BST_IPK_MILLIAMP_STEP) -
> +				CS40L26_BST_IPK_CTL_RESERVED;
> +
> +	ret = regmap_write(cs40l26->regmap, CS40L26_BST_IPK_CTL, bst_ipk_ctl);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to update boost peak current: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = cs40l26_pseq_write(cs40l26, CS40L26_BST_IPK_CTL, bst_ipk_ctl, true,
> +			CS40L26_PSEQ_OP_WRITE_L16);
> +	if (ret)
> +		return ret;
> +
> +	return cs40l26_irq_update_mask(cs40l26, CS40L26_IRQ1_MASK_1, 0,
> +			BIT(CS40L26_IRQ1_BST_IPK_FLAG));
> +}
> +
> +static int cs40l26_wksrc_config(struct cs40l26_private *cs40l26)
> +{
> +	u8 mask_wksrc;
> +	u32 val, mask;
> +
> +	if (cs40l26->devid == CS40L26_DEVID_A || cs40l26->devid == CS40L26_DEVID_L27_A)
> +		mask_wksrc = 1;
> +	else
> +		mask_wksrc = 0;
> +
> +	val = BIT(CS40L26_IRQ1_WKSRC_STS_SPI) | (mask_wksrc << CS40L26_IRQ1_WKSRC_STS_GPIO2) |
> +			(mask_wksrc << CS40L26_IRQ1_WKSRC_STS_GPIO3) |
> +			(mask_wksrc << CS40L26_IRQ1_WKSRC_STS_GPIO4);
> +
> +	mask = BIT(CS40L26_IRQ1_WKSRC_STS_ANY) | BIT(CS40L26_IRQ1_WKSRC_STS_GPIO1) |
> +			BIT(CS40L26_IRQ1_WKSRC_STS_I2C) | BIT(CS40L26_IRQ1_WKSRC_STS_SPI) |
> +			BIT(CS40L26_IRQ1_WKSRC_STS_GPIO2) | BIT(CS40L26_IRQ1_WKSRC_STS_GPIO3) |
> +			BIT(CS40L26_IRQ1_WKSRC_STS_GPIO4);
> +
> +	return cs40l26_irq_update_mask(cs40l26, CS40L26_IRQ1_MASK_1, val, mask);
> +}
> +
> +static int cs40l26_hw_init(struct cs40l26_private *cs40l26)
> +{
> +	int ret;
> +
> +	ret = cs40l26_irq_update_mask(cs40l26, CS40L26_IRQ1_MASK_1, 0, BIT(CS40L26_IRQ1_AMP_ERR) |
> +			BIT(CS40L26_IRQ1_TEMP_ERR) | BIT(CS40L26_IRQ1_BST_SHORT_ERR) |
> +			BIT(CS40L26_IRQ1_BST_DCM_UVP_ERR) | BIT(CS40L26_IRQ1_BST_OVP_ERR) |
> +			BIT(CS40L26_IRQ1_VIRTUAL2_MBOX_WR));
> +	if (ret)
> +		return ret;
> +
> +	ret = cs40l26_irq_update_mask(cs40l26, CS40L26_IRQ1_MASK_2, 0, BIT(CS40L26_IRQ2_PLL_LOCK) |
> +			BIT(CS40L26_IRQ2_PLL_READY));
> +	if (ret)
> +		return ret;
> +
> +	ret = cs40l26_wksrc_config(cs40l26);
> +	if (ret)
> +		return ret;
> +
> +	ret = cs40l26_gpio_config(cs40l26);
> +	if (ret)
> +		return ret;
> +
> +	return cs40l26_bst_config(cs40l26);
> +}
> +
> +static int cs40l26_lbst_short_test(struct cs40l26_private *cs40l26)
> +{
> +	struct regmap *regmap = cs40l26->regmap;
> +	struct device *dev = cs40l26->dev;
> +	unsigned int err;
> +	int ret;
> +
> +	ret = regmap_update_bits(regmap, CS40L26_VBST_CTL_2, CS40L26_BST_CTL_SEL_MASK,
> +			CS40L26_BST_CTL_SEL_FIXED);
> +	if (ret) {
> +		dev_err(dev, "Failed to set VBST_CTL_2\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(regmap, CS40L26_VBST_CTL_1, CS40L26_BST_CTL_MASK,
> +			CS40L26_BST_CTL_VP);
> +	if (ret) {
> +		dev_err(dev, "Failed to set VBST_CTL_1\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(regmap, CS40L26_GLOBAL_ENABLES, CS40L26_GLOBAL_EN_MASK, 1);
> +	if (ret) {
> +		dev_err(dev, "Failed to set GLOBAL_EN\n");
> +		return ret;
> +	}
> +
> +	/* Wait until boost converter is guranteed to be powered up */
> +	usleep_range(CS40L26_BST_TIME_US_MIN, CS40L26_BST_TIME_US_MAX);
> +
> +	ret = regmap_read(regmap, CS40L26_ERROR_RELEASE, &err);
> +	if (ret) {
> +		dev_err(dev, "Failed to get ERROR_RELEASE contents\n");
> +		return ret;
> +	}
> +
> +	if (err & BIT(CS40L26_BST_SHORT_ERR_RLS)) {
> +		dev_err(dev, "FATAL: Boost shorted at startup\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(regmap, CS40L26_GLOBAL_ENABLES, CS40L26_GLOBAL_EN_MASK, 0);
> +	if (ret) {
> +		dev_err(dev, "Failed to clear GLOBAL_EN\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(regmap, CS40L26_VBST_CTL_2, CS40L26_BST_CTL_SEL_MASK,
> +			CS40L26_BST_CTL_SEL_CLASS_H);
> +	if (ret) {
> +		dev_err(dev, "Failed to set VBST_CTL_2\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(regmap, CS40L26_VBST_CTL_1, CS40L26_BST_CTL_MASK,
> +			CS40L26_BST_CTL_VP);
> +	if (ret)
> +		dev_err(dev, "Failed to set VBST_CTL_1\n");
> +
> +	return ret;
> +}
> +
> +static int cs40l26_part_num_resolve(struct cs40l26_private *cs40l26)
> +{
> +	u32 devid, revid;
> +	int ret;
> +
> +	ret = regmap_read(cs40l26->regmap, CS40L26_DEVID, &devid);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to read device ID: %d\n", ret);
> +		return ret;
> +	}
> +	devid &= CS40L26_DEVID_MASK;
> +
> +	switch (devid) {
> +	case CS40L26_DEVID_A:
> +	case CS40L26_DEVID_B:
> +	case CS40L26_DEVID_L27_A:
> +	case CS40L26_DEVID_L27_B:
> +		cs40l26->devid = devid;
> +		break;
> +	default:
> +		dev_err(cs40l26->dev, "Invalid device ID: 0x%06X\n", devid);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(cs40l26->regmap, CS40L26_REVID, &revid);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to read revision ID\n");
> +		return ret;
> +	}
> +	revid &= CS40L26_REVID_MASK;
> +
> +	if (revid == CS40L26_REVID_A1 || revid == CS40L26_REVID_B0) {
> +		cs40l26->revid = revid;
> +	} else {
> +		dev_err(cs40l26->dev, "Invalid device revision: 0x%02X\n", revid);
> +		return -EINVAL;
> +	}
> +
> +	dev_info(cs40l26->dev, "Cirrus Logic CS40L26 ID: 0x%06X, Revision: 0x%02X\n",
> +			cs40l26->devid, cs40l26->revid);
> +
> +	return 0;
> +}
> +
> +static int cs40l26_handle_platform_data(struct cs40l26_private *cs40l26)
> +{
> +	struct device *dev = cs40l26->dev;
> +	u32 val;
> +
> +	if (!device_property_read_u32(dev, "cirrus,bst-ctl-microvolt", &val))
> +		cs40l26->pdata.vbst_uv = val;
> +	else
> +		cs40l26->pdata.vbst_uv = 0;

Please evaluate the return value as follows:

	error = device_property_read_u32(..., &cs40l26->vbst_uv);
	if (error && error != -EINVAL)
		return error;

Notice the following:

1. There is no longer an unnecessary nested platform_data struct.
2. 'ret' has been changed to 'error'.
3. The property is assumed to be optional. If the property is required, do
   not check for -EINVAL and simply return if error is nonzero.

> +
> +	if (!device_property_read_u32(dev, "cirrus,bst-ipk-microamp", &val))
> +		cs40l26->pdata.bst_ipk_ua = val;
> +	else
> +		cs40l26->pdata.bst_ipk_ua = 0;
> +
> +	if (!device_property_read_bool(dev, "cirrus,bst-exploratory-mode-disable"))
> +		cs40l26->pdata.exploratory_mode_enabled = false;
> +	else
> +		cs40l26->pdata.exploratory_mode_enabled = true;

cs40l26->exploratory_mode = device_property_present(...);

> +
> +	return 0;
> +}
> +
> +static int cs40l26_dsp_state_get(struct cs40l26_private *cs40l26, u8 *state)
> +{
> +	bool mutex_available = !mutex_is_locked(&cs40l26->dsp.pwr_lock);

This is dangerous and a sign that locks are not properly managed. What would
be a case where you do not know the state of the lock upon entering this function?
If you do not know whether the mutex is locked inside this function, it is not the
proper place to grab it.

> +	u32 dsp_state = CS40L26_DSP_STATE_NONE;
> +	int i, ret = 0;
> +
> +	if (cs40l26->dsp.running) {
> +		for (i = 0; i < CS40L26_DSP_TIMEOUT_COUNT; i++) {
> +			if (mutex_available)
> +				mutex_lock(&cs40l26->dsp.pwr_lock);
> +
> +			ret = cs40l26_fw_ctl_read(&cs40l26->dsp, "PM_CUR_STATE",
> +					CS40L26_PM_ALGO_ID, &dsp_state);
> +
> +			if (mutex_available)
> +				mutex_unlock(&cs40l26->dsp.pwr_lock);
> +
> +			if (ret)
> +				return ret;
> +
> +			if (dsp_state != CS40L26_DSP_STATE_NONE)
> +				break;
> +
> +			usleep_range(CS40L26_DSP_TIMEOUT_US_MIN, CS40L26_DSP_TIMEOUT_US_MAX);
> +		}
> +		if (i == CS40L26_DSP_TIMEOUT_COUNT) {
> +			dev_err(cs40l26->dev, "Timed out reading PM_CUR_STATE\n");
> +			return -ETIMEDOUT;
> +		}
> +	} else {
> +		ret = regmap_read_poll_timeout(cs40l26->regmap, CS40L26_A1_PM_CUR_STATE_STATIC_REG,
> +				dsp_state, dsp_state != CS40L26_DSP_STATE_NONE,
> +				CS40L26_DSP_TIMEOUT_US_MAX, CS40L26_DSP_TIMEOUT_US_MAX *
> +				CS40L26_DSP_TIMEOUT_COUNT);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	switch (dsp_state) {
> +	case CS40L26_DSP_STATE_HIBERNATE:
> +	case CS40L26_DSP_STATE_SHUTDOWN:
> +	case CS40L26_DSP_STATE_STANDBY:
> +	case CS40L26_DSP_STATE_ACTIVE:
> +		*state = CS40L26_DSP_STATE_MASK & dsp_state;
> +		break;
> +	default:
> +		dev_err(cs40l26->dev, "DSP state %u is invalid\n", dsp_state);
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static bool cs40l26_dsp_can_run(struct cs40l26_private *cs40l26)
> +{
> +	bool mutex_available = !mutex_is_locked(&cs40l26->dsp.pwr_lock);

Same concern here with regard to locking.

> +	u32 pm_state_locks;
> +	u8 state;
> +	int ret;
> +
> +	ret = cs40l26_dsp_state_get(cs40l26, &state);
> +	if (ret)
> +		return false;
> +
> +	if (state == CS40L26_DSP_STATE_ACTIVE)
> +		return true;
> +
> +	if (state != CS40L26_DSP_STATE_STANDBY) {
> +		dev_err(cs40l26->dev, "DSP in bad state: %u\n", state);
> +		return false;
> +	}
> +
> +	if (cs40l26->dsp.running) {
> +		if (mutex_available)
> +			mutex_lock(&cs40l26->dsp.pwr_lock);
> +
> +		ret = cs40l26_fw_ctl_read_raw(&cs40l26->dsp, "PM_STATE_LOCKS", CS40L26_PM_ALGO_ID,
> +				CS40L26_DSP_LOCK3_OFFSET / sizeof(u32), sizeof(u32),
> +				&pm_state_locks);
> +
> +		if (mutex_available)
> +			mutex_unlock(&cs40l26->dsp.pwr_lock);
> +
> +		if (ret)
> +			return false;
> +	} else {
> +		ret = regmap_read(cs40l26->regmap, CS40L26_A1_PM_STATE_LOCKS3_STATIC_REG,
> +				&pm_state_locks);
> +		if (ret)
> +			return false;
> +	}
> +
> +	return (pm_state_locks & CS40L26_DSP_LOCK3_MASK) == CS40L26_DSP_LOCK3_MASK;
> +}
> +
> +static int cs40l26_mbox_buffer_read(struct cs40l26_private *cs40l26, u32 *val)
> +{
> +	u32 q_rd, q_wt, status;
> +	int ret;
> +
> +	mutex_lock(&cs40l26->dsp.pwr_lock);
> +	ret = cs40l26_fw_ctl_read(&cs40l26->dsp, "QUEUE_WT", CS40L26_MAILBOX_ALGO_ID, &q_wt);
> +	if (ret)
> +		goto exit_pwr_lock;
> +
> +	ret = cs40l26_fw_ctl_read(&cs40l26->dsp, "QUEUE_RD", CS40L26_MAILBOX_ALGO_ID, &q_rd);
> +	if (ret)
> +		goto exit_pwr_lock;
> +
> +	if (q_rd - sizeof(u32) == q_wt) {
> +		ret = cs40l26_fw_ctl_read(&cs40l26->dsp, "MAILBOX_STATUS",
> +				CS40L26_MAILBOX_ALGO_ID, &status);
> +		if (ret)
> +			goto exit_pwr_lock;
> +
> +		if (status) {
> +			dev_err(cs40l26->dev, "Mailbox buffer is full, info missing\n");
> +			ret = -ENOSPC;
> +			goto exit_pwr_lock;
> +		}
> +	}
> +
> +	if (q_rd == q_wt) {
> +		dev_dbg(cs40l26->dev, "Reached end of queue\n");
> +		ret = 1;
> +		goto exit_pwr_lock;
> +	}
> +
> +	ret = regmap_read(cs40l26->regmap, q_rd, val);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to read from mailbox buffer\n");
> +		goto exit_pwr_lock;
> +	}
> +
> +	q_rd = (q_rd == cs40l26->mbox_q_last) ? cs40l26->mbox_q_base : q_rd + sizeof(u32);
> +
> +	ret = cs40l26_fw_ctl_write(&cs40l26->dsp, "QUEUE_RD", CS40L26_MAILBOX_ALGO_ID, q_rd);
> +
> +exit_pwr_lock:
> +	mutex_unlock(&cs40l26->dsp.pwr_lock);
> +
> +	return ret;
> +}
> +
> +static int cs40l26_handle_mbox_buffer(struct cs40l26_private *cs40l26)
> +{
> +	struct device *dev = cs40l26->dev;
> +	u32 val;
> +
> +	while (!cs40l26_mbox_buffer_read(cs40l26, &val)) {
> +		if ((val & CS40L26_DSP_MBOX_CMD_INDEX_MASK) == CS40L26_DSP_MBOX_PANIC) {
> +			dev_err(dev, "DSP PANIC! Error condition: 0x%06X\n",
> +					(u32)(val & CS40L26_DSP_MBOX_CMD_PAYLOAD_MASK));
> +			return -ENOTRECOVERABLE;
> +		}
> +
> +		switch (val) {
> +		case CS40L26_DSP_MBOX_COMPLETE_MBOX:
> +			dev_dbg(dev, "Mailbox: COMPLETE_MBOX\n");
> +			complete_all(&cs40l26->erase);
> +			break;
> +		case CS40L26_DSP_MBOX_COMPLETE_GPIO:
> +			dev_dbg(dev, "Mailbox: COMPLETE_GPIO\n");
> +			break;
> +		case CS40L26_DSP_MBOX_TRIGGER_CP:
> +			dev_dbg(dev, "Mailbox: TRIGGER_CP\n");
> +			break;
> +		case CS40L26_DSP_MBOX_TRIGGER_GPIO:
> +			dev_dbg(dev, "Mailbox: TRIGGER_GPIO\n");
> +			break;
> +		case CS40L26_DSP_MBOX_PM_AWAKE:
> +			cs40l26->wksrc_sts |= CS40L26_WKSRC_STS_EN;
> +			dev_dbg(dev, "Mailbox: AWAKE\n");
> +			break;
> +		case CS40L26_DSP_MBOX_SYS_ACK:
> +			dev_err(dev, "Mailbox: ACK\n");
> +			return -EPERM;
> +		default:
> +			dev_err(dev, "MBOX buffer value (0x%X) is invalid\n", val);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int cs40l26_error_release(struct cs40l26_private *cs40l26, unsigned int err_rls)
> +{
> +	struct regmap *regmap = cs40l26->regmap;
> +	struct device *dev = cs40l26->dev;
> +	u32 err_sts, err_cfg;
> +	int ret;
> +
> +	ret = regmap_read(regmap, CS40L26_ERROR_RELEASE, &err_sts);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to get error status\n");
> +		return ret;
> +	}
> +
> +	err_cfg = err_sts & ~BIT(err_rls);
> +
> +	ret = regmap_write(cs40l26->regmap, CS40L26_ERROR_RELEASE, err_cfg);
> +	if (ret) {
> +		dev_err(dev, "Actuator Safe Mode release sequence failed\n");
> +		return ret;
> +	}
> +
> +	err_cfg |= BIT(err_rls);
> +
> +	ret = regmap_write(regmap, CS40L26_ERROR_RELEASE, err_cfg);
> +	if (ret) {
> +		dev_err(dev, "Actuator Safe Mode release sequence failed\n");
> +		return ret;
> +	}
> +
> +	err_cfg &= ~BIT(err_rls);
> +
> +	ret = regmap_write(cs40l26->regmap, CS40L26_ERROR_RELEASE, err_cfg);
> +	if (ret)
> +		dev_err(dev, "Actuator Safe Mode release sequence failed\n");
> +
> +	return ret;
> +}
> +
> +static int cs40l26_handle_irq1(struct cs40l26_private *cs40l26, enum cs40l26_irq1 irq1)
> +{
> +	struct device *dev = cs40l26->dev;
> +	u32 err_rls = 0;
> +	int ret = 0;
> +	u32 pwrmgt_sts, last_wksrc;
> +
> +	switch (irq1) {
> +	case CS40L26_IRQ1_GPIO1_RISE:
> +	case CS40L26_IRQ1_GPIO1_FALL:
> +	case CS40L26_IRQ1_GPIO2_RISE:
> +	case CS40L26_IRQ1_GPIO2_FALL:
> +	case CS40L26_IRQ1_GPIO3_RISE:
> +	case CS40L26_IRQ1_GPIO3_FALL:
> +	case CS40L26_IRQ1_GPIO4_RISE:
> +	case CS40L26_IRQ1_GPIO4_FALL:
> +		dev_dbg(dev, "GPIO%u %s edge detected\n", (irq1 / 2) + 1,
> +				(irq1 % 2) ? "falling" : "rising");
> +
> +		cs40l26->wksrc_sts |= CS40L26_WKSRC_STS_EN;
> +		break;
> +	case CS40L26_IRQ1_WKSRC_STS_ANY:
> +		dev_dbg(dev, "Wakesource detected (ANY)\n");
> +
> +		ret = regmap_read(cs40l26->regmap, CS40L26_PWRMGT_STS, &pwrmgt_sts);
> +		if (ret) {
> +			dev_err(dev, "Failed to get Power Management Status\n");
> +			goto err;
> +		}
> +
> +		cs40l26->wksrc_sts = (u8)((pwrmgt_sts & CS40L26_WKSRC_STS_MASK) >>
> +				CS40L26_WKSRC_STS_SHIFT);
> +
> +		mutex_lock(&cs40l26->dsp.pwr_lock);
> +		ret = cs40l26_fw_ctl_read(&cs40l26->dsp, "LAST_WAKESRC_CTL", cs40l26->dsp.fw_id,
> +				&last_wksrc);
> +		mutex_unlock(&cs40l26->dsp.pwr_lock);
> +		if (ret)
> +			goto err;
> +
> +		cs40l26->last_wksrc_pol = (u8) (last_wksrc & CS40L26_WKSRC_GPIO_POL_MASK);
> +		break;
> +	case CS40L26_IRQ1_WKSRC_STS_GPIO1:
> +	case CS40L26_IRQ1_WKSRC_STS_GPIO2:
> +	case CS40L26_IRQ1_WKSRC_STS_GPIO3:
> +	case CS40L26_IRQ1_WKSRC_STS_GPIO4:
> +		dev_dbg(dev, "GPIO%u event woke device from hibernate\n",
> +				irq1 - CS40L26_IRQ1_WKSRC_STS_GPIO1 + 1);
> +
> +		if (cs40l26->wksrc_sts & cs40l26->last_wksrc_pol) {
> +			dev_dbg(dev, "GPIO%u falling edge detected\n", irq1 - 8);
> +			cs40l26->wksrc_sts |= CS40L26_WKSRC_STS_EN;
> +		} else {
> +			dev_dbg(dev, "GPIO%u rising edge detected\n", irq1 - 8);
> +		}
> +		break;
> +	case CS40L26_IRQ1_WKSRC_STS_SPI:
> +		dev_dbg(dev, "SPI event woke device from hibernate\n");
> +		break;
> +	case CS40L26_IRQ1_WKSRC_STS_I2C:
> +		dev_dbg(dev, "I2C event woke device from hibernate\n");
> +		break;
> +	case CS40L26_IRQ1_GLOBAL_EN_ASSERT:
> +		dev_dbg(dev, "Started power up seq. (GLOBAL_EN asserted)\n");
> +		break;
> +	case CS40L26_IRQ1_PDN_DONE:
> +		dev_dbg(dev, "Completed power down seq. (GLOBAL_EN cleared)\n");
> +		break;
> +	case CS40L26_IRQ1_PUP_DONE:
> +		dev_dbg(dev, "Completed power up seq. (GLOBAL_EN asserted)\n");
> +		break;
> +	case CS40L26_IRQ1_BST_OVP_FLAG_RISE:
> +		dev_warn(dev, "BST overvoltage warning\n");
> +		break;
> +	case CS40L26_IRQ1_BST_OVP_FLAG_FALL:
> +		dev_warn(dev, "BST voltage returned below warning threshold\n");
> +		break;
> +	case CS40L26_IRQ1_BST_OVP_ERR:
> +		dev_err(dev, "BST overvolt. error\n");
> +		err_rls = CS40L26_BST_OVP_ERR_RLS;
> +		break;
> +	case CS40L26_IRQ1_BST_DCM_UVP_ERR:
> +		dev_err(dev, "BST undervolt. error\n");
> +		err_rls = CS40L26_BST_UVP_ERR_RLS;
> +		break;
> +	case CS40L26_IRQ1_BST_SHORT_ERR:
> +		dev_err(dev, "LBST short detected\n");
> +		err_rls = CS40L26_BST_SHORT_ERR_RLS;
> +		break;
> +	case CS40L26_IRQ1_BST_IPK_FLAG:
> +		dev_dbg(dev, "Current is being limited by LBST inductor\n");
> +		break;
> +	case CS40L26_IRQ1_TEMP_WARN_RISE:
> +		dev_err(dev, "Die overtemperature warning\n");
> +		err_rls = CS40L26_TEMP_WARN_ERR_RLS;
> +		break;
> +	case CS40L26_IRQ1_TEMP_WARN_FALL:
> +		dev_warn(dev, "Die temperature returned below threshold\n");
> +		break;
> +	case CS40L26_IRQ1_TEMP_ERR:
> +		dev_err(dev, "Die overtemperature error\n");
> +		err_rls = CS40L26_TEMP_ERR_RLS;
> +		break;
> +	case CS40L26_IRQ1_AMP_ERR:
> +		dev_err(dev, "AMP short detected\n");
> +		err_rls = CS40L26_AMP_SHORT_ERR_RLS;
> +		break;
> +	case CS40L26_IRQ1_DC_WATCHDOG_RISE:
> +		dev_err(dev, "DC level detected\n");
> +		break;
> +	case CS40L26_IRQ1_DC_WATCHDOG_FALL:
> +		dev_warn(dev, "Previously detected DC level removed\n");
> +		break;
> +	case CS40L26_IRQ1_VIRTUAL1_MBOX_WR:
> +		dev_dbg(dev, "Virtual 1 MBOX write occurred\n");
> +		break;
> +	case CS40L26_IRQ1_VIRTUAL2_MBOX_WR:
> +		ret = regmap_write(cs40l26->regmap, CS40L26_IRQ1_EINT_1, BIT(irq1));
> +		if (ret) {
> +			dev_err(dev, "Failed to clear Mailbox IRQ\n");
> +			return ret;
> +		}
> +
> +		return cs40l26_handle_mbox_buffer(cs40l26);
> +	default:
> +		dev_err(dev, "Unrecognized IRQ1 EINT1 status\n");
> +		return -EINVAL;
> +	}
> +
> +	if (err_rls)
> +		ret = cs40l26_error_release(cs40l26, err_rls);
> +
> +err:
> +	regmap_write(cs40l26->regmap, CS40L26_IRQ1_EINT_1, BIT(irq1));
> +
> +	return ret;
> +}
> +
> +static int cs40l26_handle_irq2(struct cs40l26_private *cs40l26, enum cs40l26_irq2 irq2)
> +{
> +	struct device *dev = cs40l26->dev;
> +	int ret;
> +
> +	switch (irq2) {
> +	case CS40L26_IRQ2_PLL_LOCK:
> +		dev_dbg(dev, "PLL achieved lock\n");
> +		break;
> +	case CS40L26_IRQ2_PLL_PHASE_LOCK:
> +		dev_dbg(dev, "PLL achieved phase lock\n");
> +		break;
> +	case CS40L26_IRQ2_PLL_FREQ_LOCK:
> +		dev_dbg(dev, "PLL achieved frequency lock\n");
> +		break;
> +	case CS40L26_IRQ2_PLL_UNLOCK_RISE:
> +		dev_err(dev, "PLL has lost lock\n");
> +		break;
> +	case CS40L26_IRQ2_PLL_UNLOCK_FALL:
> +		dev_warn(dev, "PLL has regained lock\n");
> +		break;
> +	case CS40L26_IRQ2_PLL_READY:
> +		dev_dbg(dev, "PLL ready\n");
> +		break;
> +	case CS40L26_IRQ2_PLL_REFCLK_PRESENT:
> +		dev_warn(dev, "REFCLK present for PLL\n");
> +		break;
> +	case CS40L26_IRQ2_REFCLK_MISSING_RISE:
> +		dev_err(dev, "REFCLK input for PLL is missing\n");
> +		break;
> +	case CS40L26_IRQ2_REFCLK_MISSING_FALL:
> +		dev_warn(dev, "REFCLK reported missing is now present\n");
> +		break;
> +	case CS40L26_IRQ2_ASP_RXSLOT_CFG_ERR:
> +		dev_err(dev, "Misconfig. of ASP_RX 1 2 or 3 SLOT fields\n");
> +		break;
> +	case CS40L26_IRQ2_AUX_NG_CH1_ENTRY:
> +		dev_warn(dev,
> +			 "CH1 data of noise gate has fallen below threshold\n");
> +		break;
> +	case CS40L26_IRQ2_AUX_NG_CH1_EXIT:
> +		dev_err(dev,
> +			"CH1 data of noise gate has risen above threshold\n");
> +		break;
> +	case CS40L26_IRQ2_AUX_NG_CH2_ENTRY:
> +		dev_warn(dev,
> +			 "CH2 data of noise gate has fallen below threshold\n");
> +		break;
> +	case CS40L26_IRQ2_AUX_NG_CH2_EXIT:
> +		dev_err(dev,
> +			"CH2 data of noise gate has risen above threshold\n");
> +		break;
> +	case CS40L26_IRQ2_AMP_NG_ON_RISE:
> +		dev_warn(dev, "Amplifier entered noise-gated state\n");
> +		break;
> +	case CS40L26_IRQ2_AMP_NG_ON_FALL:
> +		dev_warn(dev, "Amplifier exited noise-gated state\n");
> +		break;
> +	case CS40L26_IRQ2_VPBR_FLAG:
> +		dev_err(dev, "VP Brownout Prevent not supported\n");
> +		break;
> +	case CS40L26_IRQ2_VPBR_ATT_CLR:
> +		dev_warn(dev,
> +			 "Cleared attenuation applied by VP brownout event\n");
> +		break;
> +	case CS40L26_IRQ2_VBBR_FLAG:
> +		dev_err(dev, "VBST Brownout Prevent not supported\n");
> +		break;
> +	case CS40L26_IRQ2_VBBR_ATT_CLR:
> +		dev_warn(dev, "Cleared attenuation caused by VBST brownout\n");
> +		break;
> +	case CS40L26_IRQ2_I2C_NACK_ERR:
> +		dev_err(dev, "I2C interface NACK during Broadcast Mode\n");
> +		break;
> +	case CS40L26_IRQ2_VPMON_CLIPPED:
> +		dev_err(dev, "Input larger than full-scale value (VPMON)\n");
> +		break;
> +	case CS40L26_IRQ2_VBSTMON_CLIPPED:
> +		dev_err(dev, "Input larger than full-scale value (VBSTMON)\n");
> +		break;
> +	case CS40L26_IRQ2_VMON_CLIPPED:
> +		dev_err(dev, "Input larger than full-scale value (VMON)\n");
> +		break;
> +	case CS40L26_IRQ2_IMON_CLIPPED:
> +		dev_err(dev, "Input larger than full-scale value (IMON)\n");
> +		break;
> +	default:
> +		dev_err(dev, "Unrecognized IRQ1 EINT2 status\n");
> +		return -EINVAL;
> +	}

Are all of these error messages necessary? Many of the blocks which would
elicit such errors are not even enabled.

> +
> +	ret = regmap_write(cs40l26->regmap, CS40L26_IRQ1_EINT_2, BIT(irq2));
> +	if (ret)
> +		dev_err(dev, "Failed to clear IRQ1 EINT2 %u\n", irq2);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t cs40l26_irq(int irq, void *data)
> +{
> +	struct cs40l26_private *cs40l26 = (struct cs40l26_private *)data;
> +	struct regmap *regmap = cs40l26->regmap;
> +	int irq1_count = 0, irq2_count = 0;
> +	struct device *dev = cs40l26->dev;
> +	unsigned int eint, mask, sts;
> +	unsigned long val;
> +	int i, ret;
> +
> +	if (cs40l26_pm_enter(dev)) {
> +		dev_err(dev, "Interrupts missed\n");
> +		return IRQ_NONE;
> +	}
> +

Nit: extraneous NL.

> +
> +	mutex_lock(&cs40l26->lock);
> +
> +	if (regmap_read(regmap, CS40L26_IRQ1_STATUS, &sts)) {
> +		dev_err(dev, "Failed to read IRQ1 Status\n");
> +		ret = IRQ_NONE;
> +		goto err;
> +	}
> +
> +	if (sts != CS40L26_IRQ_STATUS_ASSERT) {
> +		dev_err(dev, "IRQ1 asserted with no pending interrupts\n");
> +		ret = IRQ_NONE;
> +		goto err;
> +	}
> +
> +	ret = regmap_read(regmap, CS40L26_IRQ1_EINT_1, &eint);
> +	if (ret) {
> +		dev_err(dev, "Failed to read interrupts status 1\n");
> +		goto err;
> +	}
> +
> +	ret = regmap_read(regmap, CS40L26_IRQ1_MASK_1, &mask);
> +	if (ret) {
> +		dev_err(dev, "Failed to get interrupts mask 1\n");
> +		goto err;
> +	}

If the driver is in control of the mask, why to read it back instead
of storing what has been set?

That being said, why to mask the raw status returned by the device?
If you are not interested in a specific status field, simply do not
take any action on its behalf.

It seems below you only want to return IRQ_HANDLED if the driver has
encountered an unmasked interrupt, but why would the interrupt pin be
asserted in response to an unmasked interrupt in the first place?

Is this logic perhaps to handle shared IRQs? I know this is sometimes
done for stereo audio amplifiers but is that actually a use-case for
haptics? I ask in case we are unnecessarily carrying over complexity
from audio use-cases.

> +
> +	val = eint & ~mask;
> +	for_each_set_bit(i, &val, CS40L26_IRQ1_NUM_IRQS) {
> +		ret = cs40l26_handle_irq1(cs40l26, i);
> +		if (ret)
> +			goto err;
> +
> +		irq1_count++;
> +	}
> +
> +	ret = regmap_read(regmap, CS40L26_IRQ1_EINT_2, &eint);
> +	if (ret) {
> +		dev_err(dev, "Failed to read interrupts status 2\n");
> +		goto err;
> +	}
> +
> +	ret = regmap_read(regmap, CS40L26_IRQ1_MASK_2, &mask);
> +	if (ret) {
> +		dev_err(dev, "Failed to get interrupts mask 2\n");
> +		goto err;
> +	}
> +
> +	val = eint & ~mask;
> +	for_each_set_bit(i, &val, CS40L26_IRQ2_NUM_IRQS) {
> +		ret = cs40l26_handle_irq2(cs40l26, i);
> +		if (ret)
> +			goto err;
> +
> +		irq2_count++;
> +	}
> +
> +err:
> +	mutex_unlock(&cs40l26->lock);
> +
> +	cs40l26_pm_exit(dev);
> +
> +	/*
> +	 * IRQ_HANDLED is returned if at least one interrupt request generated
> +	 * by the device was handled successfully.
> +	 */
> +	if (ret)
> +		dev_err(dev, "Failed to process IRQ (%d): %d\n", irq, ret);
> +
> +	return (irq1_count + irq2_count) ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +static int cs40l26_prevent_hiber(struct cs40l26_private *cs40l26)
> +{
> +
> +	int i, ret;
> +
> +	for (i = 0; i < CS40L26_DSP_TIMEOUT_COUNT; i++) {
> +		ret = cs40l26_mailbox_write(cs40l26, CS40L26_DSP_MBOX_CMD_PREVENT_HIBER);
> +		if (ret)
> +			return ret;
> +
> +		usleep_range(CS40L26_DSP_TIMEOUT_US_MIN, CS40L26_DSP_TIMEOUT_US_MAX);
> +
> +		if (cs40l26_dsp_can_run(cs40l26))
> +			break;
> +	}
> +
> +	if (i == CS40L26_DSP_TIMEOUT_COUNT) {
> +		dev_err(cs40l26->dev, "Failed to prevent hibernation\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cs40l26_allow_hiber(struct cs40l26_private *cs40l26)
> +{
> +	int ret;
> +
> +	cs40l26->wksrc_sts = 0x00;
> +
> +	/* Don't perform mailbox write since reading for acknowledgment will wake the device */
> +	ret = regmap_write(cs40l26->regmap, CS40L26_DSP_VIRTUAL1_MBOX_1,
> +			   CS40L26_DSP_MBOX_CMD_ALLOW_HIBER);
> +	if (ret)
> +		dev_err(cs40l26->dev, "Failed to allow hibernate: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int cs40l26_dsp_pre_config(struct cs40l26_private *cs40l26)
> +{
> +	u32 halo_state, timeout_ms;
> +	u8 dsp_state;
> +	int ret, i;
> +
> +	ret = cs40l26_prevent_hiber(cs40l26);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(cs40l26->regmap, CS40L26_A1_DSP_HALO_STATE_REG, &halo_state);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to get HALO state\n");
> +		return ret;
> +	}
> +
> +	if (halo_state != CS40L26_DSP_HALO_STATE_RUN) {
> +		dev_err(cs40l26->dev, "DSP not Ready: HALO_STATE: %08X\n", halo_state);
> +		return -EINVAL;
> +	}
> +
> +	ret = cs40l26_pm_timeout_ms_get(cs40l26, CS40L26_DSP_STATE_ACTIVE, &timeout_ms);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to get active->standby timeout: %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < 10; i++) {
> +		ret = cs40l26_dsp_state_get(cs40l26, &dsp_state);
> +		if (ret)
> +			return ret;
> +
> +		if (dsp_state != CS40L26_DSP_STATE_SHUTDOWN &&
> +				dsp_state != CS40L26_DSP_STATE_STANDBY)
> +			dev_warn(cs40l26->dev, "DSP core not safe to kill\n");
> +		else
> +			break;
> +
> +		usleep_range(timeout_ms * 1000, (timeout_ms * 1000) + 100);
> +	}
> +
> +	if (i == 10) {

Please #define 10 so that it does not need to be hard-coded in two places.

> +		dev_err(cs40l26->dev, "DSP Core could not be shut down\n");
> +		return -EINVAL;

This seems like -ETIMEDOUT.

> +	}
> +
> +	ret = regmap_write(cs40l26->regmap, CS40L26_DSP1_CCM_CORE_CONTROL,
> +			CS40L26_DSP_CCM_CORE_KILL);
> +	if (ret)
> +		dev_err(cs40l26->dev, "Failed to kill DSP core\n");
> +
> +	return ret;
> +}
> +
> +static const struct reg_sequence cs40l26_a1_errata[] = {
> +	{ CS40L26_PLL_REFCLK_DETECT_0, 0x00000000 },
> +	{ CS40L26_TEST_KEY_CTRL, 0x00000055 },
> +	{ CS40L26_TEST_KEY_CTRL, 0x000000AA },
> +	{ CS40L26_TEST_LBST, CS40L26_DISABLE_EXPLORATORY_MODE },
> +};
> +
> +static int cs40l26_handle_errata(struct cs40l26_private *cs40l26)
> +{
> +	int num_writes = 1, ret;
> +
> +	if (!cs40l26->pdata.exploratory_mode_enabled) {
> +		ret = cs40l26_lbst_short_test(cs40l26);
> +		if (ret)
> +			return ret;
> +
> +		num_writes = ARRAY_SIZE(cs40l26_a1_errata);
> +	}
> +
> +	return cs40l26_pseq_multi_write(cs40l26, cs40l26_a1_errata, num_writes, false,
> +			CS40L26_PSEQ_OP_WRITE_FULL);
> +}
> +
> +static int cs40l26_cs_dsp_pre_run(struct cs_dsp *dsp)
> +{
> +	struct cs40l26_private *cs40l26 = container_of(dsp, struct cs40l26_private, dsp);
> +	int ret;
> +
> +	ret = cs40l26_pm_timeout_ms_set(cs40l26, CS40L26_DSP_STATE_STANDBY,
> +			CS40L26_PM_STDBY_TIMEOUT_MS_DEFAULT);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to set standby->hibernate timeout: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = cs40l26_pm_timeout_ms_set(cs40l26, CS40L26_DSP_STATE_ACTIVE,
> +			CS40L26_PM_ACTIVE_TIMEOUT_MS_DEFAULT);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to set active->standby timeout: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(cs40l26->regmap, CS40L26_PWRMGT_CTL, CS40L26_MEM_RDY_MASK,
> +			1 << CS40L26_MEM_RDY_SHIFT);
> +	if (ret) {
> +		dev_err(dsp->dev, "Failed to set MEM_RDY to initialize RAM");
> +		return ret;
> +	}
> +
> +	ret = cs40l26_fw_ctl_read(dsp, "QUEUE_BASE", CS40L26_MAILBOX_ALGO_ID,
> +			&cs40l26->mbox_q_base);
> +	if (ret)
> +		return ret;
> +
> +	ret = cs40l26_fw_ctl_read(dsp, "QUEUE_LEN", CS40L26_MAILBOX_ALGO_ID, &cs40l26->mbox_q_len);
> +	if (ret)
> +		return ret;
> +
> +	cs40l26->mbox_q_last = cs40l26->mbox_q_base + ((cs40l26->mbox_q_len - 1) * sizeof(u32));
> +
> +	ret = cs40l26_fw_ctl_write(dsp, "CALL_RAM_INIT", dsp->fw_id, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = cs40l26_pseq_init(cs40l26);
> +	if (ret)
> +		return ret;
> +
> +	return cs40l26_handle_errata(cs40l26);
> +}
> +
> +static int cs40l26_cs_dsp_post_run(struct cs_dsp *dsp)
> +{
> +	struct cs40l26_private *cs40l26 = container_of(dsp, struct cs40l26_private, dsp);
> +	u32 halo_state, nwaves;
> +	int ret;
> +
> +	ret = cs40l26_prevent_hiber(cs40l26);
> +	if (ret)
> +		return ret;
> +
> +	ret = cs40l26_fw_ctl_read(&cs40l26->dsp, "HALO_STATE", dsp->fw_id, &halo_state);
> +	if (ret)
> +		return ret;
> +
> +	if (halo_state != CS40L26_DSP_HALO_STATE_RUN) {
> +		dev_err(dsp->dev, "Firmware in unexpected state: 0x%X\n", halo_state);
> +		return -EINVAL;
> +	}
> +
> +	ret = cs40l26_hw_init(cs40l26);
> +	if (ret)
> +		return ret;
> +
> +	cs40l26_pm_runtime_setup(cs40l26);
> +
> +	ret = cs40l26_allow_hiber(cs40l26);
> +	if (ret)
> +		return ret;
> +
> +	ret = cs40l26_pm_enter(dsp->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = cs40l26_fw_ctl_write(&cs40l26->dsp, "TIMEOUT_MS", CS40L26_VIBEGEN_ALGO_ID, 0);
> +	if (ret)
> +		goto pm_err;
> +
> +	ret = cs40l26_num_waves_get(cs40l26, &nwaves);
> +	if (ret)
> +		goto pm_err;
> +
> +	dev_info(dsp->dev, "%s loaded with %u RAM waveforms\n", "CS40L26", nwaves);
> +
> +pm_err:
> +	cs40l26_pm_exit(dsp->dev);
> +
> +	return ret;
> +}
> +
> +static const struct cs_dsp_client_ops cs40l26_cs_dsp_client_ops = {
> +	.pre_run		= cs40l26_cs_dsp_pre_run,
> +	.post_run		= cs40l26_cs_dsp_post_run,
> +};
> +
> +static int cs40l26_cs_dsp_init(struct cs40l26_private *cs40l26)
> +{
> +	int ret;
> +
> +	cs40l26->dsp.num = 1;
> +	cs40l26->dsp.type = WMFW_HALO;
> +	cs40l26->dsp.dev = cs40l26->dev;
> +	cs40l26->dsp.regmap = cs40l26->regmap;
> +	cs40l26->dsp.base = CS40L26_DSP_CTRL_BASE;
> +	cs40l26->dsp.base_sysinfo = CS40L26_DSP1_SYS_INFO_ID;
> +	cs40l26->dsp.mem = cs40l26_dsp_regions;
> +	cs40l26->dsp.num_mems = CS40L26_DSP_NUM_REGIONS;
> +	cs40l26->dsp.lock_regions = 0xFFFFFFFF;
> +	cs40l26->dsp.client_ops = &cs40l26_cs_dsp_client_ops;
> +
> +	ret = cs_dsp_halo_init(&cs40l26->dsp);
> +	if (ret)
> +		dev_err(cs40l26->dev, "Failed to initialize HALO core\n");
> +
> +	return ret;
> +}
> +
> +static int cs40l26_fw_upload(struct cs40l26_private *cs40l26)
> +{
> +	struct device *dev = cs40l26->dev;
> +	const struct firmware *wmfw, *bin;
> +	int ret;
> +
> +	ret = cs40l26_cs_dsp_init(cs40l26);
> +	if (ret)
> +		return ret;
> +
> +	ret = request_firmware(&wmfw, "cs40l26.wmfw", dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to load firmware: %d\n", ret);
> +		return ret;
> +	}

While built-in drivers are becoming less common, it is dangerous to call
request_firmware() from probe() in a generic driver that might not always
be built as a module and loaded after the filesystem is available.

In the worst case, request_firmware() can immediately return -ENOENT or
deadlock the system. For devices with no nonvolatile memory that require
firmware to be loaded each time they come out of reset, you must use
request_firmware_nowait() and defer all post-firmware work to its callback.

> +
> +	ret = request_firmware(&bin, "cs40l26.bin", dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to load tuning: %d\n", ret);
> +		goto err_fw_rls;
> +	}
> +
> +	ret = cs40l26_dsp_pre_config(cs40l26);
> +	if (ret)
> +		goto err_bin_rls;
> +
> +	mutex_lock(&cs40l26->lock);
> +
> +	ret = cs_dsp_power_up(&cs40l26->dsp, wmfw, "cs40l26.wmfw", bin,
> +			"cs40l26.bin", "cs40l26");
> +	if (ret)
> +		goto err_mutex;
> +
> +	if (cs40l26->dsp.fw_id != CS40L26_FW_ID) {
> +		dev_err(dev, "Invalid firmware ID: 0x%X\n", cs40l26->dsp.fw_id);
> +		ret = -EINVAL;
> +		goto err_mutex;
> +	}
> +
> +	if (cs40l26->dsp.fw_id_version < CS40L26_FW_ID_VERSION_MIN) {
> +		dev_err(dev, "Invalid firmware version 0x%X\n", cs40l26->dsp.fw_id_version);
> +		ret = -EINVAL;
> +		goto err_mutex;
> +	}
> +
> +	ret = cs_dsp_run(&cs40l26->dsp);
> +	if (ret)
> +		dev_err(cs40l26->dev, "Failed to run DSP\n");
> +
> +err_mutex:
> +	mutex_unlock(&cs40l26->lock);
> +err_bin_rls:
> +	release_firmware(bin);
> +err_fw_rls:
> +	release_firmware(wmfw);
> +
> +	return ret;
> +}
> +
> +static inline int cs40l26_worker_init(struct cs40l26_private *cs40l26)
> +{
> +	cs40l26->vibe_workqueue =
> +		alloc_ordered_workqueue("cs40l26_workqueue", WQ_HIGHPRI);
> +	if (IS_ERR_OR_NULL(cs40l26->vibe_workqueue)) {
> +		dev_err(cs40l26->dev, "Failed to allocate workqueue\n");
> +		return -ENOMEM;
> +	}
> +
> +	INIT_WORK(&cs40l26->erase_work, cs40l26_erase_worker);
> +	INIT_WORK(&cs40l26->set_gain_work, cs40l26_set_gain_worker);
> +	INIT_WORK(&cs40l26->upload_work, cs40l26_upload_worker);
> +	INIT_WORK(&cs40l26->vibe_start_work, cs40l26_vibe_start_worker);
> +	INIT_WORK(&cs40l26->vibe_stop_work, cs40l26_vibe_stop_worker);
> +
> +	return 0;
> +}
> +
> +static struct regulator_bulk_data cs40l26_supplies[] = {
> +	{ .supply = "VP" },
> +	{ .supply = "VA" },
> +};
> +
> +int cs40l26_probe(struct cs40l26_private *cs40l26, struct cs40l26_platform_data *pdata)
> +{
> +	struct device *dev = cs40l26->dev;
> +	int ret;
> +
> +	ret = devm_regulator_bulk_get(dev, CS40L26_NUM_SUPPLIES, cs40l26_supplies);
> +	if (ret) {
> +		dev_err(dev, "Failed to request core supplies: %d\n", ret);
> +		goto err;
> +	}
> +
> +	if (pdata) {
> +		cs40l26->pdata = *pdata;
> +	} else if (cs40l26->dev->of_node) {
> +		ret = cs40l26_handle_platform_data(cs40l26);
> +		if (ret)
> +			goto err;
> +	} else {
> +		dev_err(dev, "No platform data found\n");
> +		ret = -ENODATA;
> +		goto err;
> +	}

The idea of platform data is antiquated and almost certainly not going to
be used on any customer platforms. Throughout this driver, you are correctly
using the device property API to parse properties, but then unnecessarily
restricting it to OF platforms here which defeats the purpose.

There is no need for a separate platform_data struct; just include any
necessarily variables as part of the cs40l26_private definition. Then, rename
cs40l26_handle_platform_data() to something like 'cs40l26_parse_props()' and
call it unconditionally. The idea is that there should be very little work
required to adopt ACPI at a later time.

> +
> +	ret = regulator_bulk_enable(CS40L26_NUM_SUPPLIES, cs40l26_supplies);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable core supplies: %d\n", ret);
> +		goto err;
> +	}
> +
> +	cs40l26->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR_OR_NULL(cs40l26->reset_gpio)) {
> +		dev_err(dev, "Failed to get reset GPIO: %d\n", (int) PTR_ERR(cs40l26->reset_gpio));
> +		ret = -ENOENT;
> +		goto err;
> +	}
> +
> +	usleep_range(CS40L26_MIN_RESET_PULSE_WIDTH_US, CS40L26_MIN_RESET_PULSE_WIDTH_US + 100);
> +
> +	gpiod_set_value_cansleep(cs40l26->reset_gpio, 1);

This is backwards, which means your dts must be backwards as well. gpiod is
a logical API, so you should actually declare the GPIO as GPIOD_OUT_HIGH, i.e.
asserted, and then call gpiod_set_value_cansleep() with 0, i.e. de-asserted.
The definition of "asserted" then comes from the polarity defined in dts.

By the way, did you test this driver without a reset GPIO defined in dts? It's
an optional GPIO, rightfully so, but you need to check whether reset_gpio is
NULL prior to acting upon it.

> +
> +	usleep_range(CS40L26_CP_READY_DELAY_US, CS40L26_CP_READY_DELAY_US + 100);

In other instances of usleep_range(), the min/max are defined separately; here
there is a single definition with the math written in place. In the interest of
consistency, pick one method.

> +
> +	mutex_init(&cs40l26->lock);
> +
> +	ret = cs40l26_worker_init(cs40l26);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize worker threads\n");
> +		goto err;
> +	}
> +
> +	init_completion(&cs40l26->erase);
> +	complete_all(&cs40l26->erase);

Can you add some comments as to why the completion is immediately completed?

> +
> +	ret = cs40l26_part_num_resolve(cs40l26);
> +	if (ret)
> +		goto err;
> +
> +	/*
> +	 * The DSP may lock up if a haptic effect is triggered via GPI
> +	 * event or control port and the PLL is set to closed-loop.
> +	 *
> +	 * Set the PLL to open-loop and remove default GPI mappings
> +	 * to prevent this while the driver is loading and configuring
> +	 * RAM firmware.
> +	 *
> +	 * The firmware will set the PLL back to closed-loop when it is loaded
> +	 * and the DSP has been started.
> +	 */
> +	ret = regmap_update_bits(cs40l26->regmap, CS40L26_REFCLK_INPUT,
> +			CS40L26_PLL_REFCLK_LOOP_MASK, 1 << CS40L26_PLL_REFCLK_LOOP_SHIFT);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to set PLL to open-loop: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = regmap_read(cs40l26->regmap, CS40L26_A1_EVENT_MAP_1, &cs40l26->gpio_press_default);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to read GPIO mapping 1\n");
> +		goto err;
> +	}
> +
> +	ret = regmap_read(cs40l26->regmap, CS40L26_A1_EVENT_MAP_2, &cs40l26->gpio_release_default);
> +	if (ret) {
> +		dev_err(cs40l26->dev, "Failed to read GPIO mapping 2\n");
> +		goto err;
> +	}
> +
> +	ret = cs40l26_erase_gpio_mapping(cs40l26, CS40L26_GPIO_MAP_A_PRESS);
> +	if (ret)
> +		goto err;
> +
> +	ret = cs40l26_erase_gpio_mapping(cs40l26, CS40L26_GPIO_MAP_A_RELEASE);
> +	if (ret)
> +		goto err;
> +
> +	/* Set LRA to HI-Z in order to avoid fault conditions */
> +	ret = regmap_update_bits(cs40l26->regmap, CS40L26_TST_DAC_MSM_CONFIG,
> +			CS40L26_SPK_DEFAULT_HIZ_MASK, 1 << CS40L26_SPK_DEFAULT_HIZ_SHIFT);
> +	if (ret) {
> +		dev_err(dev, "Failed to set LRA to HI-Z\n");
> +		goto err;
> +	}

Food for thought: consider how much re-work would be involved if a customer
asks for the device to be re-initialized in response to some kind of system-
level problem (e.g. ESD strike, reset glitch, etc.).

Currently, it seems some device initialization is done only in probe and
cannot be easily repeated. A much more scalable solution is to encapsulate
all of this work in a function that you can easily call from other contexts.

For example, perhaps in the future you must read a known register prior to
triggering an effect and then re-initialize the device if the register value
does not match the expected value.

It will be much easier to accommodate such a workaround if all of this logic
is in a central place that you can call anywhere, as opposed to some of it
being limited to probe. Let me know if that makes sense.

> +
> +	ret = cs40l26_fw_upload(cs40l26);
> +	if (ret)
> +		goto err;
> +
> +	ret = devm_request_threaded_irq(dev, cs40l26->irq, NULL, cs40l26_irq, IRQF_ONESHOT |
> +			IRQF_SHARED | IRQF_TRIGGER_LOW, "cs40l26", cs40l26);

Do not override polarity in the driver; that's up to dts to define.

> +	if (ret) {
> +		dev_err(dev, "Failed to request threaded IRQ\n");
> +		goto err;
> +	}
> +
> +	ret = cs40l26_input_init(cs40l26);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err:
> +	cs40l26_remove(cs40l26);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cs40l26_probe);
> +
> +int cs40l26_remove(struct cs40l26_private *cs40l26)
> +{
> +	struct regulator *vp_consumer = cs40l26_supplies[CS40L26_VP_SUPPLY].consumer;
> +	struct regulator *va_consumer = cs40l26_supplies[CS40L26_VA_SUPPLY].consumer;
> +
> +	if (cs40l26->input)
> +		input_unregister_device(cs40l26->input);

This is unnecessary. Since you have allocated 'input' with a device-managed
function, input_register_device() is automatically device-managed as well.

> +
> +	cs40l26_pm_runtime_teardown(cs40l26);
> +
> +	if (cs40l26->dsp.running)
> +		cs_dsp_stop(&cs40l26->dsp);
> +	if (cs40l26->dsp.booted)
> +		cs_dsp_power_down(&cs40l26->dsp);
> +	if (&cs40l26->dsp)
> +		cs_dsp_remove(&cs40l26->dsp);
> +
> +	if (cs40l26->vibe_workqueue) {
> +		cancel_work_sync(&cs40l26->erase_work);
> +		cancel_work_sync(&cs40l26->set_gain_work);
> +		cancel_work_sync(&cs40l26->upload_work);
> +		cancel_work_sync(&cs40l26->vibe_start_work);
> +		cancel_work_sync(&cs40l26->vibe_stop_work);
> +		destroy_workqueue(cs40l26->vibe_workqueue);
> +	}
> +
> +	mutex_destroy(&cs40l26->lock);

This ultimately does nothing.

> +
> +	if (!IS_ERR_OR_NULL(cs40l26->reset_gpio))
> +		gpiod_set_value_cansleep(cs40l26->reset_gpio, 0);

This is also backwards. Assuming you meant to put the device into reset at
teardown, you want to call gpiod_set_value_cansleep() with '1' (asserted).

> +
> +	if (vp_consumer)
> +		regulator_disable(vp_consumer);
> +
> +	if (va_consumer)
> +		regulator_disable(va_consumer);

Is this order correct? Normally VP is last to go.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cs40l26_remove);
> +
> +static int cs40l26_suspend(struct device *dev)
> +{
> +	struct cs40l26_private *cs40l26 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	mutex_lock(&cs40l26->lock);
> +	dev_dbg(dev, "%s: Enabling hibernation\n", __func__);
> +
> +	ret = cs40l26_allow_hiber(cs40l26);
> +
> +	mutex_unlock(&cs40l26->lock);
> +
> +	return ret;
> +}
> +
> +static int cs40l26_sys_suspend(struct device *dev)
> +{
> +	struct i2c_client *i2c_client = to_i2c_client(dev);
> +
> +	dev_dbg(dev, "System suspend, disabling IRQ\n");
> +
> +	disable_irq(i2c_client->irq);
> +
> +	return 0;
> +}
> +
> +static int cs40l26_sys_suspend_noirq(struct device *dev)
> +{
> +	struct i2c_client *i2c_client = to_i2c_client(dev);
> +
> +	dev_dbg(dev, "Late system suspend, re-enabling IRQ\n");
> +	enable_irq(i2c_client->irq);
> +
> +	return 0;
> +}
> +
> +static int cs40l26_resume(struct device *dev)
> +{
> +	dev_dbg(dev, "%s: Disabling hibernation\n", __func__);
> +
> +	return cs40l26_prevent_hiber(dev_get_drvdata(dev));
> +}
> +
> +static int cs40l26_sys_resume(struct device *dev)
> +{
> +	struct i2c_client *i2c_client = to_i2c_client(dev);
> +
> +	dev_dbg(dev, "System resume, re-enabling IRQ\n");
> +
> +	enable_irq(i2c_client->irq);
> +
> +	return 0;
> +}
> +
> +static int cs40l26_sys_resume_noirq(struct device *dev)
> +{
> +	struct i2c_client *i2c_client = to_i2c_client(dev);
> +
> +	dev_dbg(dev, "Early system resume, disabling IRQ\n");
> +
> +	disable_irq(i2c_client->irq);
> +
> +	return 0;
> +}
> +
> +const struct dev_pm_ops cs40l26_pm_ops = {
> +	SET_RUNTIME_PM_OPS(cs40l26_suspend, cs40l26_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(cs40l26_sys_suspend, cs40l26_sys_resume)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cs40l26_sys_suspend_noirq, cs40l26_sys_resume_noirq)
> +};
> +EXPORT_SYMBOL_GPL(cs40l26_pm_ops);

Please use latest macros (e.g. DEFINE_SIMPLE_DEV_PM_OPS).

> +
> +MODULE_DESCRIPTION("CS40L26 Boosted Mono Class D Amplifier for Haptics");

Nit: "mono" does not necessarily have any meaning in a haptic application.

> +MODULE_AUTHOR("Fred Treven, Cirrus Logic Inc. <fred.treven@cirrus.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/input/cs40l26.h b/include/linux/input/cs40l26.h
> new file mode 100644
> index 000000000000..5a878b9bc363
> --- /dev/null
> +++ b/include/linux/input/cs40l26.h
> @@ -0,0 +1,532 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * CS40L26 Boosted Haptic Driver with Integrated DSP and
> + * Waveform Memory with Advanced Closed Loop Algorithms and LRA protection
> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + *
> + * Author: Fred Treven <fred.treven@cirrus.com>
> + */
> +
> +#ifndef __CS40L26_H__
> +#define __CS40L26_H__
> +
> +#include <linux/bitops.h>
> +#include <linux/completion.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/input.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/firmware/cirrus/cs_dsp.h>
> +#include <linux/firmware/cirrus/wmfw.h>
> +
> +#define CS40L26_FIRSTREG				0x0
> +#define CS40L26_LASTREG					0x3C7DFE8
> +
> +#define CS40L26_DEVID					0x0
> +#define CS40L26_REVID					0x4
> +#define CS40L26_TEST_KEY_CTRL				0x40
> +#define CS40L26_GLOBAL_ENABLES				0x2014
> +#define CS40L26_ERROR_RELEASE				0x2034
> +#define CS40L26_PWRMGT_CTL				0x2900
> +#define CS40L26_PWRMGT_STS				0x290C
> +#define CS40L26_REFCLK_INPUT				0x2C04
> +#define CS40L26_PLL_REFCLK_DETECT_0			0x2C28
> +#define CS40L26_VBST_CTL_1				0x3800
> +#define CS40L26_VBST_CTL_2				0x3804
> +#define CS40L26_BST_IPK_CTL				0x3808
> +#define CS40L26_TEST_LBST				0x391C
> +#define CS40L26_NGATE1_INPUT				0x4C60
> +#define CS40L26_DAC_MSM_CONFIG				0x7400
> +#define CS40L26_TST_DAC_MSM_CONFIG			0x7404
> +#define CS40L26_IRQ1_STATUS				0x10004
> +#define CS40L26_IRQ1_EINT_1				0x10010
> +#define CS40L26_IRQ1_EINT_2				0x10014
> +#define CS40L26_IRQ1_EINT_3				0x10018
> +#define CS40L26_IRQ1_EINT_4				0x1001C
> +#define CS40L26_IRQ1_EINT_5				0x10020
> +#define CS40L26_IRQ1_STS_1				0x10090
> +#define CS40L26_IRQ1_STS_2				0x10094
> +#define CS40L26_IRQ1_STS_3				0x10098
> +#define CS40L26_IRQ1_STS_4				0x1009C
> +#define CS40L26_IRQ1_STS_5				0x100A0
> +#define CS40L26_IRQ1_MASK_1				0x10110
> +#define CS40L26_IRQ1_MASK_2				0x10114
> +#define CS40L26_IRQ1_MASK_3				0x10118
> +#define CS40L26_IRQ1_MASK_4				0x1011C
> +#define CS40L26_IRQ1_MASK_5				0x10120
> +#define CS40L26_MIXER_NGATE_CH1_CFG			0x12004
> +#define CS40L26_DSP_MBOX_1				0x13000
> +#define CS40L26_DSP_MBOX_2				0x13004
> +#define CS40L26_DSP_MBOX_3				0x13008
> +#define CS40L26_DSP_MBOX_4				0x1300C
> +#define CS40L26_DSP_MBOX_5				0x13010
> +#define CS40L26_DSP_MBOX_6				0x13014
> +#define CS40L26_DSP_MBOX_7				0x13018
> +#define CS40L26_DSP_MBOX_8				0x1301C
> +#define CS40L26_DSP_VIRTUAL1_MBOX_1			0x13020
> +#define CS40L26_DSP_VIRTUAL1_MBOX_2			0x13024
> +#define CS40L26_DSP_VIRTUAL1_MBOX_3			0x13028
> +#define CS40L26_DSP_VIRTUAL1_MBOX_4			0x1302C
> +#define CS40L26_DSP_VIRTUAL1_MBOX_5			0x13030
> +#define CS40L26_DSP_VIRTUAL1_MBOX_6			0x13034
> +#define CS40L26_DSP_VIRTUAL1_MBOX_7			0x13038
> +#define CS40L26_DSP_VIRTUAL1_MBOX_8			0x1303C
> +#define CS40L26_DSP_VIRTUAL2_MBOX_1			0x13040
> +#define CS40L26_DSP_VIRTUAL2_MBOX_2			0x13044
> +#define CS40L26_DSP_VIRTUAL2_MBOX_3			0x13048
> +#define CS40L26_DSP_VIRTUAL2_MBOX_4			0x1304C
> +#define CS40L26_DSP_VIRTUAL2_MBOX_5			0x13050
> +#define CS40L26_DSP_VIRTUAL2_MBOX_6			0x13054
> +#define CS40L26_DSP_VIRTUAL2_MBOX_7			0x13058
> +#define CS40L26_DSP_VIRTUAL2_MBOX_8			0x1305C
> +#define CS40L26_OTP_MEM0				0x30000
> +#define CS40L26_OTP_MEM31				0x3007C
> +#define CS40L26_DSP1_XMEM_PACKED_0			0x2000000
> +#define CS40L26_DSP1_XMEM_PACKED_6143			0x2005FFC
> +#define CS40L26_DSP1_XROM_PACKED_0			0x2006000
> +#define CS40L26_DSP1_XROM_PACKED_4604			0x200A7F0
> +#define CS40L26_DSP1_XMEM_UNPACKED32_0			0x2400000
> +#define CS40L26_DSP1_XMEM_UNPACKED32_4095		0x2403FFC
> +#define CS40L26_DSP1_XROM_UNPACKED32_0			0x2404000
> +#define CS40L26_DSP1_XROM_UNPACKED32_3070		0x2406FF8
> +#define CS40L26_DSP1_SYS_INFO_ID			0x25E0000
> +#define CS40L26_DSP1_XMEM_UNPACKED24_0			0x2800000
> +#define CS40L26_DSP1_XMEM_UNPACKED24_8191		0x2807FFC
> +#define CS40L26_DSP1_XROM_UNPACKED24_0			0x2808000
> +#define CS40L26_DSP1_XROM_UNPACKED24_6141		0x280DFF4
> +#define CS40L26_DSP1_CCM_CORE_CONTROL			0x2BC1000
> +#define CS40L26_DSP1_YMEM_PACKED_0			0x2C00000
> +#define CS40L26_DSP1_YMEM_PACKED_1532			0x2C017F0
> +#define CS40L26_DSP1_YMEM_UNPACKED32_0			0x3000000
> +#define CS40L26_DSP1_YMEM_UNPACKED32_1022		0x3000FF8
> +#define CS40L26_DSP1_YMEM_UNPACKED24_0			0x3400000
> +#define CS40L26_DSP1_YMEM_UNPACKED24_2045		0x3401FF4
> +#define CS40L26_DSP1_PMEM_0				0x3800000
> +#define CS40L26_DSP1_PMEM_5114				0x3804FE8
> +#define CS40L26_DSP1_PROM_0				0x3C60000
> +#define CS40L26_DSP1_PROM_30714				0x3C7DFE8
> +
> +/* Device */
> +#define CS40L26_DEVID_A				0x40A260
> +#define CS40L26_DEVID_B				0x40A26B
> +#define CS40L26_DEVID_L27_A			0x40A270
> +#define CS40L26_DEVID_L27_B			0x40A27B
> +#define CS40L26_NUM_DEVS			4
> +#define CS40L26_DEVID_MASK			GENMASK(23, 0)
> +#define CS40L26_REVID_A1			0xA1
> +#define CS40L26_REVID_B0			0xB0
> +#define CS40L26_REVID_MASK			GENMASK(7, 0)
> +
> +#define CS40L26_MIN_RESET_PULSE_WIDTH_US	1500
> +#define CS40L26_CP_READY_DELAY_US		6000
> +
> +#define CS40L26_DATA_SRC_DSP1TX4		0x35
> +#define CS40L26_MIXER_NGATE_CH1_CFG_DEFAULT	0x00010003
> +#define CS40L26_TST_DAC_MSM_CFG_DFLT_CHG_VAL_H16 0x1133
> +
> +#define CS40L26_SPK_DEFAULT_HIZ_MASK		BIT(28)
> +#define CS40L26_SPK_DEFAULT_HIZ_SHIFT		28
> +
> +#define CS40L26_DSP_CCM_CORE_KILL		0x00000080
> +#define CS40L26_DSP_CCM_CORE_RESET		0x00000281
> +
> +#define CS40L26_MEM_RDY_MASK			BIT(1)
> +#define CS40L26_MEM_RDY_SHIFT			1
> +
> +/* Errata */
> +#define CS40L26_DISABLE_EXPLORATORY_MODE	0x014DC080
> +
> +/* Boost Converter Control */
> +#define CS40L26_GLOBAL_EN_MASK			BIT(0)
> +
> +#define CS40L26_BST_IPK_MILLIAMP_MAX		4800
> +#define CS40L26_BST_IPK_MILLIAMP_MIN		1600
> +#define CS40L26_BST_IPK_MILLIAMP_DEFAULT	0x4A
> +#define CS40L26_BST_IPK_MILLIAMP_STEP		50
> +#define CS40L26_BST_IPK_CTL_RESERVED		16
> +
> +#define CS40L26_VBST_MILLIVOLT_MIN		2500
> +#define CS40L26_VBST_MILLIVOLT_MAX		11000
> +#define CS40L26_VBST_MILLIVOLT_STEP		50
> +
> +#define CS40L26_BST_CTL_VP			0x00
> +#define CS40L26_BST_CTL_MASK			GENMASK(7, 0)
> +#define CS40L26_BST_CTL_SHIFT			0
> +#define CS40L26_BST_CTL_SEL_MASK		GENMASK(1, 0)
> +#define CS40L26_BST_CTL_SEL_FIXED		0x0
> +#define CS40L26_BST_CTL_SEL_CLASS_H		0x1
> +#define CS40L26_BST_CTL_LIM_EN_MASK		BIT(2)
> +#define CS40L26_BST_CTL_LIM_EN_SHIFT		2
> +
> +#define CS40L26_BST_TIME_US_MIN			10000
> +#define CS40L26_BST_TIME_US_MAX			10100
> +
> +/* Phase Locked Loop */
> +#define CS40L26_PLL_OL				1
> +#define CS40L26_PLL_CL				0
> +
> +#define CS40L26_PLL_REFCLK_LOOP_MASK		BIT(11)
> +#define CS40L26_PLL_REFCLK_LOOP_SHIFT		11
> +
> +/* Haptic Triggering */
> +
> +#define CS40L26_RAM_INDEX_START			0x01000000
> +#define CS40L26_RAM_INDEX_END			0x0100007F
> +
> +#define CS40L26_ROM_INDEX_START			0x01800000
> +#define CS40L26_ROM_INDEX_END			0x01800026
> +
> +#define CS40L26_BUZZGEN_INDEX_START		0x01800080
> +#define CS40L26_BUZZGEN_INDEX_END		0x01800085
> +
> +#define CS40L26_BUZZGEN_NUM_CONFIGS		5
> +
> +#define CS40L26_BUZZGEN_PERIOD_MS_MAX		10
> +#define CS40L26_BUZZGEN_PERIOD_MS_MIN		4
> +
> +#define CS40L26_BUZZGEN_DURATION_OFFSET		8
> +#define CS40L26_BUZZGEN_DURATION_DIV_STEP	4
> +
> +#define CS40L26_BUZZGEN_LEVEL_MIN		0x00
> +#define CS40L26_BUZZGEN_LEVEL_MAX		0xFF
> +
> +#define CS40L26_VIBEGEN_MAX_TIME_MS		10000
> +
> +#define CS40L26_NUM_ATTEN_LUT_VALUES		101
> +
> +/* GPIO */
> +#define CS40L26_EVENT_MAP_GPI_DISABLE		0x1FF
> +
> +#define CS40L26_BTN_INDEX_MASK			GENMASK(7, 0)
> +#define CS40L26_BTN_BUZZ_MASK			BIT(7)
> +#define CS40L26_BTN_BUZZ_SHIFT			7
> +#define CS40L26_BTN_BANK_MASK			BIT(8)
> +#define CS40L26_BTN_BANK_SHIFT			8
> +#define CS40L26_BTN_NUM_MASK			GENMASK(14, 12)
> +#define CS40L26_BTN_NUM_SHIFT			12
> +#define CS40L26_BTN_EDGE_MASK			BIT(15)
> +#define CS40L26_BTN_EDGE_SHIFT			15
> +
> +/* A1 ROM Controls */
> +#define CS40L26_A1_PM_CUR_STATE_STATIC_REG	0x02800370
> +#define CS40L26_A1_PM_STATE_LOCKS_STATIC_REG	0x02800378
> +#define CS40L26_A1_PM_STATE_LOCKS3_STATIC_REG	(CS40L26_A1_PM_STATE_LOCKS_STATIC_REG + \
> +								CS40L26_DSP_LOCK3_OFFSET)
> +#define	CS40L26_A1_PM_TIMEOUT_TICKS_STATIC_REG	0x02800350
> +#define CS40L26_A1_PM_STDBY_TICKS_STATIC_REG	0x02800360
> +#define CS40L26_A1_PM_ACTIVE_TICKS_STATIC_REG	0x02800368
> +#define CS40L26_A1_DSP_HALO_STATE_REG		0x02800fa8
> +#define CS40L26_A1_DSP_REQ_ACTIVE_REG		0x02800c08
> +#define CS40L26_A1_EVENT_MAP_1			0x02806FC4
> +#define CS40L26_A1_EVENT_MAP_2			0x02806FC8
> +
> +/* Interrupts */
> +#define CS40L26_IRQ_STATUS_ASSERT		0x1
> +
> +#define CS40L26_IRQ_EINT1_ALL_MASK		0xFFDC7FFF
> +#define CS40L26_IRQ_EINT2_ALL_MASK		0x07DE0400
> +
> +/* Firmware Handling */
> +#define CS40L26_FW_ID				0x1800D4
> +#define CS40L26_FW_ID_VERSION_MIN		0x070237
> +
> +/* Algorithms */
> +#define CS40L26_BUZZGEN_ALGO_ID			0x0004F202
> +#define CS40L26_EVENT_HANDLER_ALGO_ID		0x0004F200
> +#define CS40L26_GPIO_ALGO_ID			0x0004F201
> +#define CS40L26_MAILBOX_ALGO_ID			0x0004F203
> +#define CS40L26_PM_ALGO_ID			0x0004F206
> +#define CS40L26_VIBEGEN_ALGO_ID			0x000400BD
> +#define CS40L26_EXT_ALGO_ID			0x0004013C
> +
> +/* DSP */
> +#define CS40L26_DSP_STATE_HIBERNATE		0
> +#define CS40L26_DSP_STATE_SHUTDOWN		1
> +#define CS40L26_DSP_STATE_STANDBY		2
> +#define CS40L26_DSP_STATE_ACTIVE		3
> +#define CS40L26_DSP_STATE_NONE			4
> +#define CS40L26_DSP_STATE_MASK			GENMASK(7, 0)
> +
> +#define CS40L26_DSP_LOCK3_OFFSET		8
> +#define CS40L26_DSP_LOCK3_MASK			BIT(1)
> +#define CS40L26_DSP_PM_ACTIVE			BIT(0)
> +
> +#define CS40L26_DSP_HALO_STATE_RUN		2
> +
> +#define CS40L26_DSP_CTRL_BASE			0x2B80000
> +#define CS40L26_DSP_NUM_REGIONS			5
> +
> +#define CS40L26_DSP_TIMEOUT_US_MIN		1000
> +#define CS40L26_DSP_TIMEOUT_US_MAX		1100
> +#define CS40L26_DSP_TIMEOUT_COUNT		100
> +
> +#define CS40L26_PM_LOCKS_TIMEOUT_COUNT		10
> +
> +/* Mailbox Controls */
> +#define CS40L26_DSP_MBOX_RESET			0x0
> +
> +#define CS40L26_DSP_MBOX_CMD_HIBER		0x02000001
> +#define CS40L26_DSP_MBOX_CMD_WAKEUP		0x02000002
> +#define CS40L26_DSP_MBOX_CMD_PREVENT_HIBER	0x02000003
> +#define CS40L26_DSP_MBOX_CMD_ALLOW_HIBER	0x02000004
> +#define CS40L26_DSP_MBOX_CMD_SHUTDOWN		0x02000005
> +#define CS40L26_DSP_MBOX_PM_CMD_BASE		CS40L26_DSP_MBOX_CMD_HIBER
> +
> +#define CS40L26_DSP_MBOX_CMD_INDEX_MASK		GENMASK(28, 24)
> +#define CS40L26_DSP_MBOX_CMD_INDEX_SHIFT	24
> +#define CS40L26_DSP_MBOX_CMD_PAYLOAD_MASK	GENMASK(23, 0)
> +
> +#define CS40L26_DSP_MBOX_CMD_STOP_PLAYBACK	0x05000000
> +
> +#define CS40L26_DSP_MBOX_COMPLETE_MBOX		0x01000000
> +#define CS40L26_DSP_MBOX_COMPLETE_GPIO		0x01000001
> +#define CS40L26_DSP_MBOX_TRIGGER_CP		0x01000010
> +#define CS40L26_DSP_MBOX_TRIGGER_GPIO		0x01000011
> +#define CS40L26_DSP_MBOX_PM_AWAKE		0x02000002
> +#define CS40L26_DSP_MBOX_SYS_ACK		0x0A000000
> +#define CS40L26_DSP_MBOX_PANIC			0x0C000000
> +
> +#define CS40L26_DSP_MBOX_QUEUE_SIZE_BYTES	16
> +
> +/* Power Management */
> +#define CS40L26_PM_STDBY_TIMEOUT_LOWER_OFFSET	16
> +#define CS40L26_PM_STDBY_TIMEOUT_UPPER_OFFSET	20
> +#define CS40L26_PM_STDBY_TIMEOUT_MS_DEFAULT	100
> +#define CS40L26_PM_ACTIVE_TIMEOUT_LOWER_OFFSET	24
> +#define CS40L26_PM_ACTIVE_TIMEOUT_UPPER_OFFSET	28
> +#define CS40L26_PM_ACTIVE_TIMEOUT_MS_DEFAULT	250
> +#define CS40L26_PM_TIMEOUT_TICKS_LOWER_MASK	GENMASK(23, 0)
> +#define CS40L26_PM_TIMEOUT_TICKS_UPPER_MASK	GENMASK(7, 0)
> +#define CS40L26_PM_TIMEOUT_TICKS_UPPER_SHIFT	24
> +#define CS40L26_PM_TICKS_PER_MS			32
> +
> +#define CS40L26_AUTOSUSPEND_DELAY_MS		2000
> +
> +#define CS40L26_PSEQ_MAX_WORDS			129
> +#define CS40L26_PSEQ_NUM_OPS			8
> +#define CS40L26_PSEQ_OP_MASK			GENMASK(23, 16)
> +#define CS40L26_PSEQ_OP_SHIFT			16
> +#define CS40L26_PSEQ_OP_WRITE_FULL		0x00
> +#define CS40L26_PSEQ_OP_WRITE_FULL_WORDS	3
> +#define CS40L26_PSEQ_OP_WRITE_ADDR8		0x02
> +#define CS40L26_PSEQ_OP_WRITE_L16		0x04
> +#define CS40L26_PSEQ_OP_WRITE_H16		0x05
> +#define CS40L26_PSEQ_OP_WRITE_X16_WORDS		2
> +#define CS40L26_PSEQ_OP_END			0xFF
> +#define CS40L26_PSEQ_OP_END_WORDS		1
> +#define CS40L26_PSEQ_INVALID_ADDR		0xFF000000
> +#define CS40L26_PSEQ_WRITE_FULL_LOWER_ADDR_SHIFT	8
> +#define CS40L26_PSEQ_WRITE_FULL_UPPER_ADDR_SHIFT	16
> +#define CS40L26_PSEQ_WRITE_FULL_LOWER_ADDR_MASK	GENMASK(15, 0)
> +#define CS40L26_PSEQ_WRITE_FULL_UPPER_ADDR_MASK	GENMASK(31, 0)
> +#define CS40L26_PSEQ_WRITE_FULL_UPPER_DATA_SHIFT	24
> +#define CS40L26_PSEQ_WRITE_FULL_LOWER_DATA_MASK	GENMASK(23, 0)
> +#define CS40L26_PSEQ_WRITE_FULL_UPPER_DATA_MASK	GENMASK(31, 24)
> +#define CS40L26_PSEQ_WRITE_FULL_OP_MASK		GENMASK(31, 8)
> +#define CS40L26_PSEQ_WRITE_X16_LOWER_ADDR_SHIFT	16
> +#define CS40L26_PSEQ_WRITE_X16_LOWER_ADDR_MASK	GENMASK(7, 0)
> +#define CS40L26_PSEQ_WRITE_X16_UPPER_ADDR_SHIFT	8
> +#define CS40L26_PSEQ_WRITE_X16_UPPER_ADDR_MASK	GENMASK(23, 8)
> +#define CS40L26_PSEQ_WRITE_X16_UPPER_DATA_SHIFT	0
> +#define CS40L26_PSEQ_WRITE_X16_UPPER_DATA_MASK	GENMASK(31, 0)
> +#define CS40L26_PSEQ_WRITE_X16_OP_MASK		GENMASK(23, 16)
> +
> +/* Wake Sources */
> +#define CS40L26_WKSRC_STS_MASK			GENMASK(9, 4)
> +#define CS40L26_WKSRC_STS_SHIFT			4
> +#define CS40L26_WKSRC_STS_EN			BIT(7)
> +#define CS40L26_WKSRC_GPIO_POL_MASK		GENMASK(3, 0)
> +
> +#define CS40L26_IRQ1_WKSRC_MASK			GENMASK(14, 9)
> +#define CS40L26_IRQ1_WKSRC_SHIFT		9
> +#define CS40L26_IRQ1_WKSRC_GPIO_MASK		GENMASK(3, 0)
> +
> +/* enums */

This comment is unnecessary.

> +enum cs40l26_power_supply {
> +	CS40L26_VP_SUPPLY,
> +	CS40L26_VA_SUPPLY,
> +	CS40L26_NUM_SUPPLIES,
> +};
> +
> +enum cs40l26_wvfrm_bank {
> +	CS40L26_WVFRM_BANK_RAM,
> +	CS40L26_WVFRM_BANK_ROM,
> +	CS40L26_WVFRM_BANK_OWT,
> +	CS40L26_WVFRM_BANK_BUZ,
> +	CS40L26_WVFRM_BANK_NUM,
> +};
> +
> +enum cs40l26_gpio_map {
> +	CS40L26_GPIO_MAP_A_PRESS,
> +	CS40L26_GPIO_MAP_A_RELEASE,
> +	CS40L26_GPIO_MAP_NUM_AVAILABLE,
> +	CS40L26_GPIO_MAP_INVALID,
> +};
> +
> +enum cs40l26_err_rls {
> +	CS40L26_RSRVD_ERR_RLS, /* 0 */
> +	CS40L26_AMP_SHORT_ERR_RLS, /* 1 */
> +	CS40L26_BST_SHORT_ERR_RLS, /* 2 */
> +	CS40L26_BST_OVP_ERR_RLS, /* 3 */
> +	CS40L26_BST_UVP_ERR_RLS, /* 4 */
> +	CS40L26_TEMP_WARN_ERR_RLS, /* 5 */
> +	CS40L26_TEMP_ERR_RLS, /* 6 */
> +};
> +
> +enum cs40l26_irq1 {
> +	CS40L26_IRQ1_GPIO1_RISE,/* 0 */
> +	CS40L26_IRQ1_GPIO1_FALL,/* 1 */
> +	CS40L26_IRQ1_GPIO2_RISE,/* 2 */
> +	CS40L26_IRQ1_GPIO2_FALL,/* 3 */
> +	CS40L26_IRQ1_GPIO3_RISE,/* 4 */
> +	CS40L26_IRQ1_GPIO3_FALL,/* 5 */
> +	CS40L26_IRQ1_GPIO4_RISE,/* 6 */
> +	CS40L26_IRQ1_GPIO4_FALL,/* 7 */
> +	CS40L26_IRQ1_WKSRC_STS_ANY,/* 8 */
> +	CS40L26_IRQ1_WKSRC_STS_GPIO1,/* 9 */
> +	CS40L26_IRQ1_WKSRC_STS_GPIO2,/* 10 */
> +	CS40L26_IRQ1_WKSRC_STS_GPIO3,/* 11 */
> +	CS40L26_IRQ1_WKSRC_STS_GPIO4,/* 12 */
> +	CS40L26_IRQ1_WKSRC_STS_SPI,/* 13 */
> +	CS40L26_IRQ1_WKSRC_STS_I2C,/* 14 */
> +	CS40L26_IRQ1_GLOBAL_EN_ASSERT,/* 15 */
> +	CS40L26_IRQ1_PDN_DONE,/* 16 */
> +	CS40L26_IRQ1_PUP_DONE,/* 17 */
> +	CS40L26_IRQ1_BST_OVP_FLAG_RISE,/* 18 */
> +	CS40L26_IRQ1_BST_OVP_FLAG_FALL,/* 19 */
> +	CS40L26_IRQ1_BST_OVP_ERR,/* 20 */
> +	CS40L26_IRQ1_BST_DCM_UVP_ERR,/* 21 */
> +	CS40L26_IRQ1_BST_SHORT_ERR,/* 22 */
> +	CS40L26_IRQ1_BST_IPK_FLAG,/* 23 */
> +	CS40L26_IRQ1_TEMP_WARN_RISE,/* 24 */
> +	CS40L26_IRQ1_TEMP_WARN_FALL,/* 25 */
> +	CS40L26_IRQ1_TEMP_ERR,/* 26 */
> +	CS40L26_IRQ1_AMP_ERR,/* 27 */
> +	CS40L26_IRQ1_DC_WATCHDOG_RISE,/* 28 */
> +	CS40L26_IRQ1_DC_WATCHDOG_FALL,/* 29 */
> +	CS40L26_IRQ1_VIRTUAL1_MBOX_WR,/* 30 */
> +	CS40L26_IRQ1_VIRTUAL2_MBOX_WR,/* 31 */
> +	CS40L26_IRQ1_NUM_IRQS,
> +};
> +
> +enum cs40l26_irq2 {
> +	CS40L26_IRQ2_PLL_LOCK,/* 0 */
> +	CS40L26_IRQ2_PLL_PHASE_LOCK,/* 1 */
> +	CS40L26_IRQ2_PLL_FREQ_LOCK,/* 2 */
> +	CS40L26_IRQ2_PLL_UNLOCK_RISE,/* 3 */
> +	CS40L26_IRQ2_PLL_UNLOCK_FALL,/* 4 */
> +	CS40L26_IRQ2_PLL_READY,/* 5 */
> +	CS40L26_IRQ2_PLL_REFCLK_PRESENT,/* 6 */
> +	CS40L26_IRQ2_REFCLK_MISSING_RISE,/* 7 */
> +	CS40L26_IRQ2_REFCLK_MISSING_FALL,/* 8 */
> +	CS40L26_IRQ2_RESERVED,/* 9 */
> +	CS40L26_IRQ2_ASP_RXSLOT_CFG_ERR,/* 10 */
> +	CS40L26_IRQ2_AUX_NG_CH1_ENTRY,/* 11 */
> +	CS40L26_IRQ2_AUX_NG_CH1_EXIT,/* 12 */
> +	CS40L26_IRQ2_AUX_NG_CH2_ENTRY,/* 13 */
> +	CS40L26_IRQ2_AUX_NG_CH2_EXIT,/* 14 */
> +	CS40L26_IRQ2_AMP_NG_ON_RISE,/* 15 */
> +	CS40L26_IRQ2_AMP_NG_ON_FALL,/* 16 */
> +	CS40L26_IRQ2_VPBR_FLAG,/* 17 */
> +	CS40L26_IRQ2_VPBR_ATT_CLR,/* 18 */
> +	CS40L26_IRQ2_VBBR_FLAG,/* 19 */
> +	CS40L26_IRQ2_VBBR_ATT_CLR,/* 20 */
> +	CS40L26_IRQ2_RESERVED2,/* 21 */
> +	CS40L26_IRQ2_I2C_NACK_ERR,/* 22 */
> +	CS40L26_IRQ2_VPMON_CLIPPED,/* 23 */
> +	CS40L26_IRQ2_VBSTMON_CLIPPED,/* 24 */
> +	CS40L26_IRQ2_VMON_CLIPPED,/* 25 */
> +	CS40L26_IRQ2_IMON_CLIPPED,/* 26 */
> +	CS40L26_IRQ2_NUM_IRQS,
> +};
> +
> +/* structs */

As is this one.

> +struct cs40l26_platform_data {
> +	u32 bst_ipk_ua;
> +	u32 vbst_uv;
> +	bool exploratory_mode_enabled;
> +};
> +
> +struct cs40l26_pseq_op {
> +	u8 size;
> +	u16 offset; /* offset in bytes from pseq_base */
> +	u8 operation;
> +	u32 words[3];
> +	struct list_head list;
> +};
> +
> +struct cs40l26_pseq_params {
> +	int num_op_words;
> +	unsigned int op_mask;
> +	unsigned int low_addr_shift;
> +	unsigned int low_addr_mask;
> +	unsigned int low_data_mask;
> +	unsigned int up_addr_shift;
> +	unsigned int up_addr_mask;
> +	unsigned int up_data_mask;
> +	unsigned int up_data_shift;
> +};
> +
> +struct cs40l26_buzzgen_config {
> +	char *duration_name;
> +	char *freq_name;
> +	char *level_name;
> +	int effect_id;
> +};
> +
> +struct cs40l26_uploaded_effect {
> +	int id;
> +	u32 trigger_index;
> +	u16 wvfrm_bank;
> +	enum cs40l26_gpio_map mapping;
> +	struct list_head list;
> +};
> +
> +struct cs40l26_private {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct cs_dsp dsp;
> +	int irq;
> +	struct mutex lock;
> +	struct gpio_desc *reset_gpio;
> +	struct cs40l26_platform_data pdata;
> +	u32 devid;
> +	u8 revid;
> +	struct input_dev *input;
> +	struct ff_effect *erase_effect;
> +	struct ff_effect *trigger_effect;
> +	struct ff_effect upload_effect;
> +	s16 *raw_custom_data;
> +	struct list_head effect_head;
> +	struct work_struct erase_work;
> +	struct work_struct set_gain_work;
> +	struct work_struct upload_work;
> +	struct work_struct vibe_start_work;
> +	struct work_struct vibe_stop_work;
> +	struct workqueue_struct *vibe_workqueue;
> +	struct completion erase;
> +	int erase_ret;
> +	int upload_ret;
> +	u16 gain_pct;
> +	u8 wksrc_sts;
> +	u8 last_wksrc_pol;
> +	int pseq_num_ops;
> +	struct list_head pseq_op_head;
> +	u32 gpio_press_default;
> +	u32 gpio_release_default;
> +	u32 mbox_q_base;
> +	u32 mbox_q_len;
> +	u32 mbox_q_last;
> +};
> +
> +/* Exports */
> +int cs40l26_probe(struct cs40l26_private *cs40l26, struct cs40l26_platform_data *pdata);
> +int cs40l26_remove(struct cs40l26_private *cs40l26);
> +
> +extern const struct regmap_config cs40l26_regmap;
> +extern const struct dev_pm_ops cs40l26_pm_ops;
> +extern const u32 cs40l26_atten_lut_q21_2[CS40L26_NUM_ATTEN_LUT_VALUES];
> +
> +#endif /* __CS40L26_H__ */
> -- 
> 2.7.4
> 

Kind regards,
Jeff LaBundy
