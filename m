Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A786B19C3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 04:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCIDFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 22:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCIDFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 22:05:17 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5E36A067;
        Wed,  8 Mar 2023 19:05:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c92WzqoH1V+7NMUXhFTFy0W6TZ+xhxe8EsanB1PSvVjfgpTHH+qqPcAUH6r4DCMFpzBhi5ovVmHw91ZwrtLBfByl1P/0vC9TNEQWnsTeRZ52ZVrnH6xWLwfcSAYNLRCV1T0ylCjfCkO5H6qiNHuFXJGw9zAV4EJWS0ALPsllJPV1obDxvEIWC0Wkn3UbHMebbmijyGikldqc3tRypxrqoL12nned2iXscYTWOJp/gbLHO/nHxfAhXQn/hptRodP90oz9kIs872HwOduiEtj5t8pCtnB9/0miF9kB/XOZHs4S/U6Vitk7jlnjm8obm9AfOnte+wMuUOtIGgRK3CoR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOR6me1aMqw/C11YLazolR7El9JChgxTsDpzI2D6xXw=;
 b=ij1fDqnp/Vdryd5bVy17yCtz4fKgtoVCdvL0u7ZoxzTQMYcufv6g+7JUvCfJcn+2Dy5oDmRnIw9CUmEROAaOhuIDhSyS/i5FJiQkEm345yroT9jN5rc9ZpF027fM/g80uCfFt/fDU6vyyAGcK1Nt20GUQJST/+Cxav9GH3PEBuv3c+7/MnyfQviOd2X3AZ6BU1lqyBpPF/73WxEr2arQBV2Lq34oq/eoOCvfXZ8OrPoUONcCx90SBMXG2jQsFTAy+ogsn6vHDyiH588pNN+Gaj4iUfohdKB0SCKLanOtrF2NbCFCeNi/mmlvugxUlEwVP1y5U8ttel9fngr02tI6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOR6me1aMqw/C11YLazolR7El9JChgxTsDpzI2D6xXw=;
 b=xbfpXiNBBw7Q76TlRjCPow8i3/BF/73nnvoZfQarJ7P7/DiwKhmjMy4d2XDjfedyZKuVwpYTEZ4B0Mh12FikI8MRmLPyrDYdpDrs4QzSB3bb74xlZmqR+dYPnCICZdfsqdt8upir+ruhMk9bzvMzOOro9VppvXWgDGuEOI14mXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SA2PR08MB6523.namprd08.prod.outlook.com
 (2603:10b6:806:110::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 03:05:09 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4e0c:f94b:5d28:66e4]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4e0c:f94b:5d28:66e4%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 03:05:08 +0000
Date:   Wed, 8 Mar 2023 21:04:56 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     fnkl.kernel@gmail.com
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Henrik Rydberg <rydberg@bitmath.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] input: apple_z2: Add a driver for Apple Z2
 touchscreens
Message-ID: <ZAlM2DzMmwzWIZEF@nixie71>
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
 <20230223-z2-for-ml-v1-2-028f2b85dc15@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223-z2-for-ml-v1-2-028f2b85dc15@gmail.com>
X-ClientProxiedBy: SN6PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:805:de::42) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SA2PR08MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a662b5-11dd-474d-981c-08db204b16d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VyhMJ4UywXBpPQ/q40jdUBeDL4D0OJq31qx+VLtrwbrbRQyxMHA2C9067+e6IkUGrOwbGDbI8YDARZlllC1OF89uYJGsvGOrdUM+4GWcpp2f/8nzjuewXFlW913+90abiqWxecSqSEnxNtdiWD5JK22aI5ERHwE8cdNOiDy+/Q+C3SNEvhZCM0VYN4p8aoTnlLx/KOChB2Fj8OOSCa1DN+lpI+pblcC6NNV6svgrKKxpK9EnFMxkqNvFprkh9yhDJuKinuUSFaS0mgA6kHfRC0BjB14k358FnqP/Z5fFfmyTc0AMMqQxTPozWYjbsjg19M7/0cjwoIzhZ/igjdeXSVTv9X90nDa6xrZ/Zdez4PH//sEOeXGEHKVAawFM3trJPsJkLpVFxSs1YAqCkYa+b+PVsSrNljFUnkT9u2x37KDu88HX/+cTJLxzKdkan4V4LdS4On3uHQuJJB4gtbp4onGPAulXYPBLpJp9nlaqC5sDLOXd59YEY8U9jQSx+1xHE4FVdlDze3qtj2nUbSh4Ocr3U8jKomlxYQgaN+8ATtmAo30o0IbHDG5qrtni9U/Azu7N78sLiuZmO9ri6K5Hcp2yb6/ZHsjvQ63zyT7+HODU0gAwcHY3ecizy31J29sF4tV/hDFGkt4QozZI2D91I9S0hrsMSmdx2CAyPkFxUozrhYFleTHPtHMMy0+hlwHKYAIvNzKf2YGnqWZ2nAOqXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(376002)(136003)(396003)(39830400003)(346002)(47660400002)(451199018)(7416002)(5660300002)(83380400001)(478600001)(6506007)(6666004)(6512007)(2906002)(9686003)(30864003)(26005)(186003)(33716001)(38100700002)(66476007)(8676002)(66556008)(66946007)(4326008)(6916009)(6486002)(8936002)(86362001)(41300700001)(54906003)(316002)(46800400005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ODesT0I+m3buec6+gfPQXAE69LcwslH47/UiM4lbHUrkzviXomz0VvqFuK8W?=
 =?us-ascii?Q?xF1WJgYX1PCBoc95y7T+Ici+IjWI/pACUjnzT9GMQprHfx6Gjh1nSIjizptZ?=
 =?us-ascii?Q?FkKdDiKLwbEHdIB9oX7VIiNfRIYlhEPVfJzbN973YmnyqDHRFwTCyXYSFxBI?=
 =?us-ascii?Q?/auhDmginPbiGNlk7liuEXlypsZ9cb7ChJmiuhrPxEo0/vCykffOl90v1apG?=
 =?us-ascii?Q?tzhwKoK9GswttivoOSxloMjcfJ/1rwsrfbD12OJhETrSnL7V+rni5duFhCtD?=
 =?us-ascii?Q?v9z9dO5gA/Lr9G1XFrmAAfhwnuhwl1S98E+O0t4AqFmM6F2xLyweUTBalik1?=
 =?us-ascii?Q?a3cbjzPqXj0o7RbddKKxJmCYyFK/LsYdgu/iIsCiSORuHmlOFH6FluLZvyhn?=
 =?us-ascii?Q?CiI3teim5D7WLwfsbUDMdlKvl7QGFU/DmLQZ5ciLis5LxXhWcrO7vyRdD6IW?=
 =?us-ascii?Q?Vf9OpqPspjm4NGx053APdxPiES1a1UfA0VaCSeOqvKbASienw24YbdZT5czf?=
 =?us-ascii?Q?0CEz5+dGcAhhEv+jC1ruTzcjUF79iWcyKZ1G2MF9zIyyQ54PnrMMYsOAfHQl?=
 =?us-ascii?Q?GbQtszE2GVEy1Eo6BWXpJ/nHjxT9i7yLehooc1JewKqiLcOf//ZpjbAVRdD+?=
 =?us-ascii?Q?0F4RhR1rzIVJ5+wNeMghBGgWP21hc1trSDbjdmDGvhKKHfMds9c0wLBPtYc4?=
 =?us-ascii?Q?n2YOZtvfeVAR1Sin/1ypYbbJGtxbo/doC+JvhjcJQcHb9qzjwCkEDm+lROq/?=
 =?us-ascii?Q?26P2b2VgFY5g8sspp3X1IB4pTecOmKafxZtFDwntI3Kgt4nV+0SX0BNtbE/h?=
 =?us-ascii?Q?yegucYZHEznRa1AwL/FwuBexFXoDCdHvmwVhIybcIlhyo7Wz9ym7yWoP7Hym?=
 =?us-ascii?Q?ThrIwDLDtBKgNGK03xYxdw5JUGc4kC0VDTv/MNoseVnSUFMrxoQ3M6pDP0pS?=
 =?us-ascii?Q?/vN+S1JQyeypPtEoEGs3idxfB6nSKwYk0Z6tMKBHVyW9K9OcmkkwhUKzAk8m?=
 =?us-ascii?Q?QkcLDwkP7Uuv64fhDeFAZd6QiBXtf0ioWCwSNbT6G7gU/oY2y3QXp+m4sCot?=
 =?us-ascii?Q?utj8yLmdHiqBK4ya/7H+cYBQcL9y5HrKkYg5JmjN6r3DS4V5mfuRSTBmbizj?=
 =?us-ascii?Q?bMYZ7HMqQ6Uu0SbxMfti3gM8ruIG1ssWmCMrFjO23tvc4U9nEUTGvcj3jNFZ?=
 =?us-ascii?Q?N/yd1ADXr/GwY7YlBnqu8r1mfTqetKiCy1N8EvfNzsSyudEvaYgNWoKqTf30?=
 =?us-ascii?Q?Xvx8W8zhGusIe9twBdEw+PJOu/wOKNp4vgT/BNcyAGnlk5OKDDTVUMn0Oe7I?=
 =?us-ascii?Q?LEGqpVzqVHBOMbFDODAmzjrToxiAfmqD1qzbyGDwhEo8W3GHSTDbfdPiuGMd?=
 =?us-ascii?Q?4zboLZfFYyrHLxpNi/itBuqoFodbgm/z39gzMuYOd75M1/R51HeiBsEaOapU?=
 =?us-ascii?Q?eQEfJUS0xBogj7VtQNVxRSoJpOlodbUyBaobn4WnOoAf65hRKwC4WWm8mkDT?=
 =?us-ascii?Q?6/IuqNIPCIjqKQ97QSdfbNCpTuZzc3KFd39SYoCZmnzUXig+FQStMr4X54HQ?=
 =?us-ascii?Q?gokgikLTLSAjhm6kD6pNnMdenwVJuQ/gy33rjVnz?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a662b5-11dd-474d-981c-08db204b16d1
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 03:05:08.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rm5uqvENMISk02gNHaghdTkCy6rHRBgCzJca47niWkEDoq+fOJcBaZdWvX8sD9FloBzM0zsEBy/IFSPABnVqfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6523
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

Great work; this is an interesting driver. I have left some comments
throughout.

On Fri, Feb 24, 2023 at 11:20:07AM +0100, Sasha Finkelstein via B4 Relay wrote:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> 
> Adds a driver for Apple touchscreens using the Z2 protocol.
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  drivers/input/touchscreen/Kconfig    |  13 +
>  drivers/input/touchscreen/Makefile   |   1 +
>  drivers/input/touchscreen/apple_z2.c | 465 +++++++++++++++++++++++++++++++++++
>  3 files changed, 479 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 68d99a112e14..76aeea837ab9 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -103,6 +103,19 @@ config TOUCHSCREEN_ADC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called resistive-adc-touch.ko.
>  
> +config TOUCHSCREEN_APPLE_Z2
> +	tristate "Apple Z2 touchscreens"
> +	default ARCH_APPLE
> +	depends on SPI && INPUT && OF

There is no need to depend on INPUT; the build will not enter TOUCHSCREEN_*
without it.

I also do not see any need to depend on OF as you are (correctly) using the
device property API. The of_device_id struct toward the end is not gated by
OF either.

> +	help
> +	  Say Y here if you have an Apple device with
> +	  a touchscreen or a touchbar.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called apple_z2.
> +
>  config TOUCHSCREEN_AR1021_I2C
>  	tristate "Microchip AR1020/1021 i2c touchscreen"
>  	depends on I2C && OF
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 4968c370479a..d885b2c4e3a6 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_TOUCHSCREEN_AD7879_I2C)	+= ad7879-i2c.o
>  obj-$(CONFIG_TOUCHSCREEN_AD7879_SPI)	+= ad7879-spi.o
>  obj-$(CONFIG_TOUCHSCREEN_ADC)		+= resistive-adc-touch.o
>  obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
> +obj-$(CONFIG_TOUCHSCREEN_APPLE_Z2)	+= apple_z2.o
>  obj-$(CONFIG_TOUCHSCREEN_AR1021_I2C)	+= ar1021_i2c.o
>  obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)	+= atmel_mxt_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_AUO_PIXCIR)	+= auo-pixcir-ts.o
> diff --git a/drivers/input/touchscreen/apple_z2.c b/drivers/input/touchscreen/apple_z2.c
> new file mode 100644
> index 000000000000..06f1d864a137
> --- /dev/null
> +++ b/drivers/input/touchscreen/apple_z2.c
> @@ -0,0 +1,465 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Apple Z2 touchscreen driver
> + *
> + * Copyright (C) The Asahi Linux Contributors
> + */
> +
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>

Please sort these #includes alphabetically.

> +
> +#define Z2_NUM_FINGERS_OFFSET 16
> +#define Z2_FINGERS_OFFSET 24
> +#define Z2_TOUCH_STARTED 3
> +#define Z2_TOUCH_MOVED 4
> +#define Z2_CMD_READ_INTERRUPT_DATA 0xEB
> +#define Z2_HBPP_CMD_BLOB 0x3001
> +#define Z2_FW_MAGIC 0x5746325A
> +#define LOAD_COMMAND_INIT_PAYLOAD 0
> +#define LOAD_COMMAND_SEND_BLOB 1
> +#define LOAD_COMMAND_SEND_CALIBRATION 2

In my opinion, #defines are easier to read if the values are aligned vertically.

> +
> +struct apple_z2 {
> +	struct spi_device *spidev;
> +	struct gpio_desc *cs_gpio;
> +	struct gpio_desc *reset_gpio;
> +	struct input_dev *input_dev;
> +	struct completion boot_irq;
> +	int booted;
> +	int counter;
> +	int y_size;
> +	const char *fw_name;
> +	const char *cal_blob;
> +	int cal_size;
> +};
> +
> +struct z2_finger {
> +	u8 finger;
> +	u8 state;
> +	__le16 unknown2;
> +	__le16 abs_x;
> +	__le16 abs_y;
> +	__le16 rel_x;
> +	__le16 rel_y;
> +	__le16 tool_major;
> +	__le16 tool_minor;
> +	__le16 orientation;
> +	__le16 touch_major;
> +	__le16 touch_minor;
> +	__le16 unused[2];
> +	__le16 pressure;
> +	__le16 multi;
> +} __packed;

Please pick one namespace (i.e. apple_z2 or z2) and use it consistently throughout.

> +
> +struct z2_hbpp_blob_hdr {
> +	u16 cmd;
> +	u16 len;
> +	u32 addr;
> +	u16 checksum;
> +} __packed;
> +
> +struct z2_fw_hdr {
> +	u32 magic;
> +	u32 version;
> +} __packed;
> +
> +struct z2_read_interrupt_cmd {
> +	u8 cmd;
> +	u8 counter;
> +	u8 unused[12];
> +	__le16 checksum;
> +} __packed;
> +
> +static void apple_z2_parse_touches(struct apple_z2 *z2, char *msg, size_t msg_len)
> +{
> +	int i;
> +	int nfingers;
> +	int slot;
> +	int slot_valid;
> +	struct z2_finger *fingers;
> +
> +	if (msg_len <= Z2_NUM_FINGERS_OFFSET)
> +		return;
> +	nfingers = msg[Z2_NUM_FINGERS_OFFSET];
> +	fingers = (struct z2_finger *)(msg + Z2_FINGERS_OFFSET);
> +	for (i = 0; i < nfingers; i++) {
> +		slot = input_mt_get_slot_by_key(z2->input_dev, fingers[i].finger);
> +		if (slot < 0) {
> +			dev_warn(&z2->spidev->dev, "unable to get slot for finger");

We need an '\n' at the end of this string.

> +			continue;
> +		}
> +		slot_valid = fingers[i].state == Z2_TOUCH_STARTED ||
> +			fingers[i].state == Z2_TOUCH_MOVED;

This logic was initially a bit hard to parse; I think it would be easier
to read if aligned as follows:

        slot_valid = fingers[i].state == Z2_TOUCH_STARTED ||
                     fingers[i].state == Z2_TOUCH_MOVED;

> +		input_mt_slot(z2->input_dev, slot);
> +		input_mt_report_slot_state(z2->input_dev, MT_TOOL_FINGER, slot_valid);
> +		if (!slot_valid)
> +			continue;
> +		input_report_abs(z2->input_dev, ABS_MT_POSITION_X,
> +				 le16_to_cpu(fingers[i].abs_x));
> +		input_report_abs(z2->input_dev, ABS_MT_POSITION_Y,
> +				 z2->y_size - le16_to_cpu(fingers[i].abs_y));
> +		input_report_abs(z2->input_dev, ABS_MT_WIDTH_MAJOR,
> +				 le16_to_cpu(fingers[i].tool_major));
> +		input_report_abs(z2->input_dev, ABS_MT_WIDTH_MINOR,
> +				 le16_to_cpu(fingers[i].tool_minor));
> +		input_report_abs(z2->input_dev, ABS_MT_ORIENTATION,
> +				 le16_to_cpu(fingers[i].orientation));
> +		input_report_abs(z2->input_dev, ABS_MT_TOUCH_MAJOR,
> +				 le16_to_cpu(fingers[i].touch_major));
> +		input_report_abs(z2->input_dev, ABS_MT_TOUCH_MINOR,
> +				 le16_to_cpu(fingers[i].touch_minor));
> +	}
> +	input_mt_sync_frame(z2->input_dev);
> +	input_sync(z2->input_dev);
> +}
> +
> +static int apple_z2_spi_sync(struct apple_z2 *z2, struct spi_message *msg)
> +{
> +	int err;

Did you not get a compiler warning about there not being a newline between
the declaration and subsequent code?

At any rate, please consider spacing this function out as follows:

        int err;

        gpiod_direction_output(...);
        usleep_range(....);

        err = ...;
        usleep_range(...);

        gpiod_direction_output(...);

        return err;

As it stands, it's difficult to read.

> +	gpiod_direction_output(z2->cs_gpio, 0);
> +	usleep_range(1000, 2000);
> +	err = spi_sync(z2->spidev, msg);
> +	usleep_range(1000, 2000);
> +	gpiod_direction_output(z2->cs_gpio, 1);
> +	return err;
> +}
> +

Thinking about this more, why is the touchscreen driver responsible for
managing its own chip select? Shouldn't the SPI controller driver figure
out on its own if the chosen GPIO can be toggled by the native hardware
peripheral, or bit banged?

It seems the touchscreen driver is absorbing work that is missing in the
SPI controller driver. Please let me know in case I have misunderstood.

> +static int apple_z2_read_packet(struct apple_z2 *z2)
> +{
> +	struct spi_message msg;
> +	struct spi_transfer xfer;
> +	struct z2_read_interrupt_cmd len_cmd;
> +	char len_rx[16];
> +	size_t pkt_len;
> +	char *pkt_rx;
> +	int err = 0;

No need to initialize this to zero.

> +
> +	spi_message_init(&msg);
> +	memset(&xfer, 0, sizeof(xfer));
> +	memset(&len_cmd, 0, sizeof(len_cmd));
> +	len_cmd.cmd = Z2_CMD_READ_INTERRUPT_DATA;
> +	len_cmd.counter = z2->counter + 1;
> +	len_cmd.checksum = cpu_to_le16(Z2_CMD_READ_INTERRUPT_DATA + 1 + z2->counter);
> +	z2->counter = 1 - z2->counter;
> +	xfer.tx_buf = &len_cmd;
> +	xfer.rx_buf = len_rx;
> +	xfer.len = sizeof(len_cmd);
> +	spi_message_add_tail(&xfer, &msg);
> +	err = apple_z2_spi_sync(z2, &msg);
> +	if (err)
> +		return err;

Again, please consider adding some newlines to spread out functionally
separate segments of code.

> +
> +	pkt_len = ((len_rx[1] | len_rx[2] << 8) + 8) & (-4);

We can reduce some of this math with get_unaligned_le16().

> +	pkt_rx = kzalloc(pkt_len, GFP_KERNEL);
> +	if (!pkt_rx)
> +		return -ENOMEM;
> +
> +	spi_message_init(&msg);
> +	xfer.rx_buf = pkt_rx;
> +	xfer.len = pkt_len;
> +	spi_message_add_tail(&xfer, &msg);
> +	err = apple_z2_spi_sync(z2, &msg);
> +
> +	if (!err)
> +		apple_z2_parse_touches(z2, pkt_rx + 5, pkt_len - 5);
> +
> +	kfree(pkt_rx);
> +	return err;
> +}
> +
> +static irqreturn_t apple_z2_irq(int irq, void *data)
> +{
> +	struct spi_device *spi = data;
> +	struct apple_z2 *z2 = spi_get_drvdata(spi);
> +
> +	if (!z2->booted)
> +		complete(&z2->boot_irq);
> +	else
> +		apple_z2_read_packet(z2);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
> +// Return value must be freed with kfree

If not already, please run checkpatch; it should have barked about
C99-style comments.

That being said, I think it is dangerous to expect the caller to free
the return value; it is ripe for bugs being introduced later in case
others contribute to this driver.

Stated another way, a better method of encapsulation is to limit this
function to working on the data, with the caller being responsible to
manage the memory which holds the data.

> +static char *apple_z2_build_cal_blob(struct apple_z2 *z2, u32 address, u32 *size)
> +{
> +	u16 len_words = (z2->cal_size + 3) / 4;
> +	u32 checksum = 0;
> +	u16 checksum_hdr = 0;
> +	char *data;
> +	int i;
> +	struct z2_hbpp_blob_hdr *hdr;
> +
> +	*size = z2->cal_size + sizeof(struct z2_hbpp_blob_hdr) + 4;
> +
> +	data = kzalloc(*size, GFP_KERNEL);
> +	hdr = (struct z2_hbpp_blob_hdr *)data;
> +	hdr->cmd = Z2_HBPP_CMD_BLOB;
> +	hdr->len = len_words;
> +	hdr->addr = address;
> +
> +	for (i = 2; i < 8; i++)
> +		checksum_hdr += data[i];
> +
> +	hdr->checksum = checksum_hdr;
> +	memcpy(data + 10, z2->cal_blob, z2->cal_size);
> +
> +	for (i = 0; i < z2->cal_size; i++)
> +		checksum += z2->cal_blob[i];
> +
> +	*(u32 *)(data + z2->cal_size + 10) = checksum;
> +
> +	return data;
> +}
> +
> +static int apple_z2_send_firmware_blob(struct apple_z2 *z2, const char *data, u32 size, u8 bpw)
> +{
> +	struct spi_message msg;
> +	struct spi_transfer blob_xfer, ack_xfer;
> +	char int_ack[] = {0x1a, 0xa1};
> +	char ack_rsp[] = {0, 0};
> +	int err;
> +
> +	spi_message_init(&msg);
> +	memset(&blob_xfer, 0, sizeof(blob_xfer));
> +	memset(&ack_xfer, 0, sizeof(ack_xfer));
> +	blob_xfer.tx_buf = data;
> +	blob_xfer.len = size;
> +	blob_xfer.bits_per_word = bpw;
> +	spi_message_add_tail(&blob_xfer, &msg);
> +	ack_xfer.tx_buf = int_ack;
> +	ack_xfer.rx_buf = ack_rsp;
> +	ack_xfer.len = 2;
> +	spi_message_add_tail(&ack_xfer, &msg);
> +	reinit_completion(&z2->boot_irq);
> +	err = apple_z2_spi_sync(z2, &msg);
> +	if (err)
> +		return err;
> +	wait_for_completion_timeout(&z2->boot_irq, msecs_to_jiffies(20));
> +	return 0;
> +}

Same comments with regard to whitespace here; this function is difficult
to read and hence review.

> +
> +static int apple_z2_upload_firmware(struct apple_z2 *z2)
> +{
> +	const struct firmware *fw;
> +	struct z2_fw_hdr *fw_hdr;
> +	size_t fw_idx = sizeof(struct z2_fw_hdr);
> +	int err;
> +	u32 load_cmd;
> +	u32 size;
> +	u32 address;
> +	char *data;
> +
> +	err = request_firmware(&fw, z2->fw_name, &z2->spidev->dev);
> +	if (err)
> +		return dev_err_probe(&z2->spidev->dev, err, "unable to load firmware");

In my experience, calling request_firmware() from probe is dangerous
especially if the driver is built-in and not a module. The reason is
the filesystem may not be ready; depending on the platform, you may
get -ENOENT or a deadlock.

If the device has no nonvolatile memory and firmware loading _must_
be kicked off from probe, request_firmware_nowait() with the rest
of the work offloaded to its callback is safer.

> +
> +	fw_hdr = (struct z2_fw_hdr *)fw->data;
> +	if (fw_hdr->magic != Z2_FW_MAGIC || fw_hdr->version != 1)
> +		return dev_err_probe(&z2->spidev->dev, -EINVAL, "invalid firmware header");
> +
> +	while (fw_idx < fw->size) {
> +		if (fw->size - fw_idx < 8) {
> +			err = dev_err_probe(&z2->spidev->dev, -EINVAL, "firmware malformed");
> +			goto error;
> +		}
> +
> +		load_cmd = *(u32 *)(fw->data + fw_idx);
> +		fw_idx += 4;
> +		if (load_cmd == LOAD_COMMAND_INIT_PAYLOAD || load_cmd == LOAD_COMMAND_SEND_BLOB) {
> +			size = *(u32 *)(fw->data + fw_idx);
> +			fw_idx += 4;
> +			if (fw->size - fw_idx < size) {
> +				err = dev_err_probe(&z2->spidev->dev,
> +						     -EINVAL, "firmware malformed");
> +				goto error;
> +			}
> +			err = apple_z2_send_firmware_blob(z2, fw->data + fw_idx,
> +							  size, load_cmd == LOAD_COMMAND_SEND_BLOB ? 16 : 8);
> +			if (err)
> +				goto error;
> +			fw_idx += size;
> +		} else if (load_cmd == 2) {
> +			address = *(u32 *)(fw->data + fw_idx);
> +			fw_idx += 4;
> +			data = apple_z2_build_cal_blob(z2, address, &size);
> +			err = apple_z2_send_firmware_blob(z2, data, size, 16);
> +			kfree(data);
> +			if (err)
> +				goto error;
> +		} else {
> +			err = dev_err_probe(&z2->spidev->dev, -EINVAL, "firmware malformed");
> +			goto error;
> +		}
> +		if (fw_idx % 4 != 0)
> +			fw_idx += 4 - (fw_idx % 4);
> +	}
> +
> +
> +	z2->booted = 1;
> +	apple_z2_read_packet(z2);
> + error:
> +	release_firmware(fw);
> +	return err;
> +}
> +
> +static int apple_z2_boot(struct apple_z2 *z2)
> +{
> +	int err;
> +	enable_irq(z2->spidev->irq);
> +	gpiod_direction_output(z2->reset_gpio, 1);
> +	wait_for_completion_timeout(&z2->boot_irq, msecs_to_jiffies(20));
> +	err = apple_z2_upload_firmware(z2);
> +	if (err) { // Boot failed, let's put the device into reset just in case.
> +		gpiod_direction_output(z2->reset_gpio, 0);
> +		disable_irq(z2->spidev->irq);
> +	}
> +	return err;
> +}
> +
> +static int apple_z2_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct apple_z2 *z2;
> +	int err;

In input, return values for functions that only return zero on success tend to
be named 'error'.

> +	int x_size;
> +	const char *device_name;
> +
> +	z2 = devm_kzalloc(dev, sizeof(*z2), GFP_KERNEL);
> +	if (!z2)
> +		return -ENOMEM;
> +
> +	z2->spidev = spi;
> +	init_completion(&z2->boot_irq);
> +	spi_set_drvdata(spi, z2);
> +
> +	z2->cs_gpio = devm_gpiod_get_index(dev, "cs", 0, 0);
> +	if (IS_ERR(z2->cs_gpio))
> +		return dev_err_probe(dev, PTR_ERR(z2->cs_gpio), "unable to get cs");

dev_err_probe() tends not to be accepted in input, the argument being
that the callers who can return -EPROBE_DEFER be responsible for setting
the reason as opposed to every driver calling a separate function that
does so.

> +
> +	z2->reset_gpio = devm_gpiod_get_index(dev, "reset", 0, 0);
> +	if (IS_ERR(z2->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(z2->reset_gpio), "unable to get reset");
> +
> +	err = devm_request_threaded_irq(dev, z2->spidev->irq, NULL,
> +					apple_z2_irq, IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					"apple-z2-irq", spi);
> +	if (err < 0)
> +		return dev_err_probe(dev, z2->spidev->irq, "unable to request irq");
> +
> +	err = device_property_read_u32(dev, "touchscreen-size-x", &x_size);
> +	if (err)
> +		return dev_err_probe(dev, err, "unable to get touchscreen size");
> +
> +	err = device_property_read_u32(dev, "touchscreen-size-y", &z2->y_size);
> +	if (err)
> +		return dev_err_probe(dev, err, "unable to get touchscreen size");

Please use touchscreen_parse_properties() instead of hard-coding these.

> +
> +	err = device_property_read_string(dev, "apple,z2-device-name", &device_name);
> +	if (err)
> +		return dev_err_probe(dev, err, "unable to get device name");
> +
> +	err = device_property_read_string(dev, "firmware-name", &z2->fw_name);
> +	if (err)
> +		return dev_err_probe(dev, err, "unable to get firmware name");
> +
> +	z2->cal_blob = of_get_property(dev->of_node, "apple,z2-cal-blob", &z2->cal_size);
> +	if (!z2->cal_blob)
> +		return dev_err_probe(dev, -EINVAL, "unable to get calibration");
> +
> +	z2->input_dev = devm_input_allocate_device(dev);
> +	if (!z2->input_dev)
> +		return -ENOMEM;
> +	z2->input_dev->name = device_name;
> +	z2->input_dev->phys = "apple_z2";
> +	z2->input_dev->dev.parent = dev;
> +	z2->input_dev->id.bustype = BUS_SPI;
> +	input_set_abs_params(z2->input_dev, ABS_MT_POSITION_X, 0, x_size, 0, 0);
> +	input_abs_set_res(z2->input_dev, ABS_MT_POSITION_X, 1);
> +	input_set_abs_params(z2->input_dev, ABS_MT_POSITION_Y, 0, z2->y_size, 0, 0);
> +	input_abs_set_res(z2->input_dev, ABS_MT_POSITION_Y, 1);
> +	input_set_abs_params(z2->input_dev, ABS_MT_WIDTH_MAJOR, 0, 65535, 0, 0);
> +	input_set_abs_params(z2->input_dev, ABS_MT_WIDTH_MINOR, 0, 65535, 0, 0);
> +	input_set_abs_params(z2->input_dev, ABS_MT_TOUCH_MAJOR, 0, 65535, 0, 0);
> +	input_set_abs_params(z2->input_dev, ABS_MT_TOUCH_MINOR, 0, 65535, 0, 0);
> +	input_set_abs_params(z2->input_dev, ABS_MT_ORIENTATION, -32768, 32767, 0, 0);
> +	input_mt_init_slots(z2->input_dev, 256, INPUT_MT_DIRECT);

Please check the return value of input_mt_init_slots().

> +
> +	err = input_register_device(z2->input_dev);
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "unable to register input device");
> +
> +
> +	// Reset the device on probe
> +	gpiod_direction_output(z2->reset_gpio, 0);

Technically you are de-asserting reset here, because gpiod is a logical API. A
'0' means take _out_ of reset. This means the reset GPIO's polarity in the dts
is backwards as well.

That being said, this specific call doesn't seem to be necessary since the value
matches the initial value in devm_gpiod_get_index(). So this call can be dropped,
and the polarity needs to be fixed in the call to devm_gpiod_get_index().

> +	usleep_range(5000, 10000);
> +	return apple_z2_boot(z2);
> +}
> +
> +static void apple_z2_remove(struct spi_device *spi)
> +{
> +	struct apple_z2 *z2 = spi_get_drvdata(spi);
> +
> +	disable_irq(z2->spidev->irq);
> +	gpiod_direction_output(z2->reset_gpio, 0);

Same here; the polarity is wrong here. This should be set to 1, with the polarity
corrected in dts.

> +}
> +
> +static void apple_z2_shutdown(struct spi_device *spi)
> +{
> +	struct apple_z2 *z2 = spi_get_drvdata(spi);
> +
> +	disable_irq(z2->spidev->irq);
> +	gpiod_direction_output(z2->reset_gpio, 0);

And here.

> +}
> +
> +static int apple_z2_suspend(struct device *dev)
> +{
> +	apple_z2_shutdown(to_spi_device(dev));
> +	return 0;
> +}
> +
> +static int apple_z2_resume(struct device *dev)
> +{
> +	struct apple_z2 *z2 = spi_get_drvdata(to_spi_device(dev));
> +
> +	return apple_z2_boot(z2);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(apple_z2_pm, apple_z2_suspend, apple_z2_resume);
> +
> +static const struct of_device_id apple_z2_of_match[] = {
> +	{ .compatible = "apple,z2-touchscreen" },
> +	{},

No need for a comma after the sentinel because we would never add a line
below it.

> +};
> +MODULE_DEVICE_TABLE(of, apple_z2_of_match);
> +
> +static struct spi_device_id apple_z2_of_id[] = {
> +	{ .name = "z2-touchscreen" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, apple_z2_of_id);
> +
> +static struct spi_driver apple_z2_driver = {
> +	.driver = {
> +		.name	= "apple-z2",
> +		.pm	= pm_sleep_ptr(&apple_z2_pm),
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(apple_z2_of_match),
> +	},
> +

Nit: extraneous newline.

> +	.id_table       = apple_z2_of_id,
> +	.probe		= apple_z2_probe,
> +	.remove		= apple_z2_remove,
> +	.shutdown	= apple_z2_shutdown,
> +};
> +
> +module_spi_driver(apple_z2_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_FIRMWARE("apple/mtfw-*.bin");
> 
> -- 
> Git-137.1)
> 

Kind regards,
Jeff LaBundy
