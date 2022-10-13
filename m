Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248505FD345
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 04:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJMCeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 22:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJMCef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 22:34:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FF410452D;
        Wed, 12 Oct 2022 19:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZosStZNsu+SlMJi4L5TOMrWpAqPhX1GNdZiKfUGyM9dq4mPkBN/4f0WNsLhLvAqe+cLtNobNf30IWHqbqzX3WG+tmbTSWp+0IZx5RCkiLuMX3fREfJ3/SB1T4Vq2xjmlmQIzsWOyAKV4MBZmms213LGTR4JA0C4oR4mVzydwZW+OT9g0buMYjL9aEgx4Z+J5B+MkycrEfIkGuxhYKd9yME9TbKXIBXnx4cvv5Hq3QIDSHRkglxfZVvh3Xx4BGCLfPZjShBmiMD69wevifRMaxADRRlnCQL1GkXDAJC5WfFNpZu9S8rSQr0BPws3IPW/CPaM1ULv9okgb8hMOcammag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AogD93VDoyXXv+dneBVTo1F5H7chBDP8gT4pPUq3UbA=;
 b=YagcfTYBVV4UBcQuQ4MZzAd5h+QRagT824uM4nxWoad1ssLXUQeUhkec4H2RiTMPTKX/CM3njlKST2/Z0h8iUggaUZC6YZoEwXnHLz8o+mPltfWQn7kuz0K+VXdJPygFMu50wvqWh7qhBSFwtxgFotKBP9yCerYfzIUpqqtPs3zQ+lmMytVXu7Lb34SaTLvcbEHj55GfNSchUT0FSRhTxoT4xxRPfX9vQYq9J6/g9yxZjF5TRqWPnS1/6oMNdYOzYwslZlLsPP18uHP4Bl2Uj+hNL7xS8oPOIt1DIMBluqPo9tBlCM+w9MvGeQ4/rYlFTVGWoCvs66X9DbQTFSwokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AogD93VDoyXXv+dneBVTo1F5H7chBDP8gT4pPUq3UbA=;
 b=I8HU6KcdsDki1REm1dhSssaiHNFQW3Ul60yuQy8rqkjqacPdANxjPeKySZ4uNs00jo+EWMzIoWutCl3LnH/9Ycq8DLyDql2X+0tQKZ65nJjr5Odos8y/pw5FYkmID+iCto0KaCeANUHP+lado+jAVQU1/nOwcw/bmV5sxct04bo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CO2PR0801MB2214.namprd08.prod.outlook.com
 (2603:10b6:102:d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 02:34:30 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::afa7:70e3:c2c9:b680]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::afa7:70e3:c2c9:b680%7]) with mapi id 15.20.5676.028; Thu, 13 Oct 2022
 02:34:30 +0000
Date:   Wed, 12 Oct 2022 21:34:24 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Job Noorman <job@noorman.info>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Input: add driver for Himax hx83112b touchscreen
 devices
Message-ID: <Y0d5MNtieyJSaidq@nixie71>
References: <20221012202341.295351-1-job@noorman.info>
 <20221012202341.295351-3-job@noorman.info>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012202341.295351-3-job@noorman.info>
X-ClientProxiedBy: SN7P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::16) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CO2PR0801MB2214:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea0b909-5bae-4080-eb4b-08daacc37463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZnTHtPhjhOfotgG7ybObbLtTl5KAl4p+z4XZSWeiD7DXfXFJrYL6hNDYLRNII3H+TuDCeT1nnLQu/Y9TxTzIN+kW0gmQwYmtfwbCrnzCd8pL68ZYgsZcYxttVle7zRqR8rIWuAYLi+FCwc5kCZ8UGM2xq+cN8S6xNsyFWfDadnFIJ3L0G0Web5XiG7QFf5EgF3SZbyoVmSrs+xSP1kIcbJ8MIhBztcD54EQoKCTsBMNsMSCswAk7FUQWWXGKi9dFlCNYgtXMxaFmBMf0/j0xH0hPv0FllVLdZ7SeSPCWSQDFbP4S009V2TBqT6kcep1OE+dYSzSYWvxc+JjS8fgokTTw6FY1rv3E1UvfgEDYn3BptB0yW7kLt76/0iZgIekp/FmYgJt7a7e+p7WuNzlhNMR7En0kwBVmF0sR/iozlI/xU7jwVRszdpKNNoaN2u0tR2MLszuKf3LVwFYHC5OrTPiOXb7y344G5/k4mc9fKwF/051Iqzm0QMg+fxHZNt+BRiLD4QGhcVYKSHrzUaF0ONnWLAzrivymh7bXBLsaKxf5EXLmwhB/w4AtD5eWrrG2Pv4cidqziMaBBzUZdv+B+yaIkbAQ0C9dTuxxvrhMeLRCIQ1VgysHI6lKu3MWbruFue09tPZjrinpFM8f62M3VApnCc60sonBA2Y5aOTsigb33Qpk0g56pvLA+EYNFzcw2dXFXvK4gPVONC7ybczJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39830400003)(136003)(396003)(346002)(376002)(451199015)(54906003)(33716001)(83380400001)(316002)(86362001)(2906002)(38100700002)(8936002)(66946007)(8676002)(66556008)(66476007)(6486002)(4326008)(41300700001)(5660300002)(6512007)(6916009)(30864003)(6666004)(9686003)(26005)(186003)(478600001)(6506007)(66899015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7yNZlFvOjZ4VvRw45QvB7MUe4T1rUrIEWD3BR4C6DEyO7Zcu4mEvLwpZ/v0k?=
 =?us-ascii?Q?UkvI/F+7tmt4K4CXfCX6P6FtCEVKC8cocX8HOJPs56fqLgdB8LHPTYHc9Nxy?=
 =?us-ascii?Q?4T5SK5X//rTlsoUkFJMUQJRGab8rw1tUwyWhE+7rRNCL7Onuy4c13ECa/XqS?=
 =?us-ascii?Q?6P4rp3oizbhLa3VK3nxXAYW+pWjie4RiWstDll97OL40fueEYb5n9VlRhTGC?=
 =?us-ascii?Q?Sg30BpABQy+PMSXgF2bapLiVAOzMJBvMBpNWLHQ+R36BqHZ42KLZjsfFDrrp?=
 =?us-ascii?Q?nfdZOEdjqCGDq8yYF3NcLFAcc5LaMAB1+9HH6orSo565h1UwdJoPkvLCcYJn?=
 =?us-ascii?Q?fsFjVRFqKDBOSHZP3QrqLq1IioGH4NcmolyetYnQiC5ifbVeItTsxonM1Vlz?=
 =?us-ascii?Q?GOpPVJIre6jynDwcEbbDj9FsNk22iPWXMD08uZYuOEVYkxY7K7rWQ0gJdU56?=
 =?us-ascii?Q?7iePGhTuBrYlb/LngKwZRY7tawjD+HkrDFXuzMnb859lPk1E3LQBCJXaD8z/?=
 =?us-ascii?Q?ddrY52+7fYCkf7k/o3GORCC+Efc4OVDFzZqkrv2J0H2G28OBmwE0ywxqGHmJ?=
 =?us-ascii?Q?jpZAGoq3v9FzwYKHyP/urZtR+S8/hJwECRRJQawmBHMdki/UF8ebRgVSgsgp?=
 =?us-ascii?Q?roLGkhtfaIUzbepXu09+MCLli88wcfsdq1abZX21ggW7PZN9m89ZcJTiyQoN?=
 =?us-ascii?Q?yS9mBmCbECqLP3xN0I1UNAZGBNuoq8IksRneE2GzW0iBmKvbNjp/CCaIh5D1?=
 =?us-ascii?Q?PR6NCwc325A68IB1X6dJPXFTZZKfA0A9Y/OyTQIghdI7MQ2ywGEy29/rlTpY?=
 =?us-ascii?Q?5YdcTa5U+wpj9YCdEB+pMQ8IGE5Cyb9mxmPgGuP5zSlJoPAFztuvKAA/iQYW?=
 =?us-ascii?Q?eM4NZeBuA8EASkrTjbqBudCPxSDJEKIjosV0OUuMcNwmggiUs87pcBUaCfho?=
 =?us-ascii?Q?nBZWKmQkHUO0MJxuzx/ZbnAbclIgbz/lAuw6cBk2xQUBtjLet4cLPkYwAkEy?=
 =?us-ascii?Q?efAkafXHUm2HrEMPoZPKZkW0IhjUpeT5kUx7LHaIGRjFtd3ydJazF8rfxNRm?=
 =?us-ascii?Q?HJnSywy/i7OHUs9AejEusXStCCciahnQp5Fx3ru7nTT3Gxz5VvG9bazs27xJ?=
 =?us-ascii?Q?0WxhUaSlyabmWloS2h2FTBQ1seEyjRRoz6oLgnStSvDq7AzEO4XNHNj9zcbO?=
 =?us-ascii?Q?zO/m43YlFKJ6LHu/WRwoKBnsJ487k6thdQMfPke7ZO4DYBwcezWo8sJ7nDCn?=
 =?us-ascii?Q?QTs9Ea5hTwXoxym/WCrV8EBQpDA1BVwZexnRuXo4holDy7Qud0Q5n2k5GiAR?=
 =?us-ascii?Q?ZqTeJavlkbc7Vfc2MvdncTe8Jku7CWHVdjziqsGDmY0q8+jTbabDkIclQlcU?=
 =?us-ascii?Q?5V3khx1Yd9B/5Xzcx0w6nCoy6II5bI5W+un6bUznZ2eZiGTFldtG3PFlNU9s?=
 =?us-ascii?Q?/X1UJslxs07hJg/WIpFtZOdGs6adrlgNtGMSQmw4/coc6BJvkSBAkxoJx9Nz?=
 =?us-ascii?Q?CPGbFDDHpQ8OyneJQLqbhnEClaRwsmJUbP4nyntLr+PiMPSMmm367bUcMt8k?=
 =?us-ascii?Q?bm5FWlmol/UMcmLhN91ybtqhXpTQI2khwxsIQLz0?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea0b909-5bae-4080-eb4b-08daacc37463
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 02:34:30.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0+lo3fZHxhK6rJVk8FR5qJOUVXv8VDMf2jjFuXIYJOf9s6N2BP9zTizrXaQdSkZKsyUZTg4qFRf6xMakAM1Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0801MB2214
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Job,

Nicely done, just a few comments throughout.

On Wed, Oct 12, 2022 at 08:24:17PM +0000, Job Noorman wrote:
> This patch adds support for Himax hx83112b touchscreen devices. As there
> are no publicly available data sheets for these devices, the
> implementation is based on the driver of the downstream Android kernel
> used in the Fairphone 3. This patch is a complete rewrite, though, and
> the code bears no resemblence to the original implementation.
> 
> The driver has been tested on the aforementioned phone.
> 
> Signed-off-by: Job Noorman <job@noorman.info>
> ---
>  MAINTAINERS                                |   1 +
>  drivers/input/touchscreen/Kconfig          |  11 +
>  drivers/input/touchscreen/Makefile         |   1 +
>  drivers/input/touchscreen/himax_hx83112b.c | 377 +++++++++++++++++++++
>  4 files changed, 390 insertions(+)
>  create mode 100644 drivers/input/touchscreen/himax_hx83112b.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2418bffe9187..51a03f9586f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9099,6 +9099,7 @@ M:	Job Noorman <job@noorman.info>
>  L:	linux-input@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
> +F:	drivers/input/touchscreen/himax_hx83112b.c
> 
>  HIPPI
>  M:	Jes Sorensen <jes@trained-monkey.org>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index dc90a3ea51ee..fd710fd8cd53 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1379,4 +1379,15 @@ config TOUCHSCREEN_ZINITIX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called zinitix.
> 
> +config TOUCHSCREEN_HIMAX_HX83112B
> +	tristate "Himax hx83112b touchscreen driver"
> +	depends on I2C

Because regmap is used here, we must select REGMAP_I2C.

> +	help
> +	  Say Y here to enable support for Himax hx83112b touchscreens.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called himax_hx83112b.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 557f84fd2075..0f8bf79e01fe 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -116,3 +116,4 @@ obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
>  obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FW)	+= raspberrypi-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
>  obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
> +obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)	+= himax_hx83112b.o
> diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/touchscreen/himax_hx83112b.c
> new file mode 100644
> index 000000000000..a7afea795dd5
> --- /dev/null
> +++ b/drivers/input/touchscreen/himax_hx83112b.c
> @@ -0,0 +1,377 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Himax hx83112b touchscreens
> + *
> + * Copyright (C) 2022 Job Noorman <job@noorman.info>
> + *
> + * This code is based on "Himax Android Driver Sample Code for QCT platform":
> + *
> + * Copyright (C) 2017 Himax Corporation.
> + */
> +
> +#include <asm/byteorder.h>

This is already included by linux/kernel.h; no need to explicitly include
it here.

> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/regmap.h>
> +
> +#define HIMAX_ID_83112B 0x83112b
> +
> +#define HIMAX_MAX_POINTS 10
> +
> +#define HIMAX_REG_CFG_SET_ADDR 0x00
> +#define HIMAX_REG_CFG_INIT_READ 0x0c
> +#define HIMAX_REG_CFG_READ_VALUE 0x08
> +#define HIMAX_REG_READ_EVENT 0x30
> +
> +#define HIMAX_CFG_PRODUCT_ID 0x900000d0

Please align these values for better readability.

> +
> +struct himax_event_point {
> +	__be16 x;
> +	__be16 y;
> +} __packed;
> +
> +struct himax_event {
> +	struct himax_event_point points[HIMAX_MAX_POINTS];
> +	u8 majors[HIMAX_MAX_POINTS];
> +	u8 pad0[2];
> +	u8 num_points;
> +	u8 pad1[2];
> +	u8 checksum_fix;
> +} __packed;
> +
> +static_assert(sizeof(struct himax_event) == 56);
> +
> +struct himax_ts_data {
> +	struct gpio_desc *gpiod_rst;
> +	struct input_dev *input_dev;
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct touchscreen_properties props;
> +};
> +
> +static const struct regmap_config himax_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 32,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +static int himax_read_config(struct himax_ts_data *ts, u32 address, u32 *dst)
> +{
> +	int error = 0;
> +
> +	error = regmap_write(ts->regmap, HIMAX_REG_CFG_SET_ADDR, address);
> +	if (error)
> +		return error;
> +
> +	error = regmap_write(ts->regmap, HIMAX_REG_CFG_INIT_READ, 0x0);
> +	if (error)
> +		return error;
> +
> +	return regmap_read(ts->regmap, HIMAX_REG_CFG_READ_VALUE, dst);
> +}
> +
> +static int himax_read_input_event(struct himax_ts_data *ts,
> +				  struct himax_event *event)
> +{
> +	return regmap_raw_read(ts->regmap, HIMAX_REG_READ_EVENT, event,
> +			       sizeof(*event));
> +}
> +
> +static void himax_reset(struct himax_ts_data *ts)
> +{
> +	gpiod_set_value(ts->gpiod_rst, 1);
> +	msleep(20);
> +	gpiod_set_value(ts->gpiod_rst, 0);
> +}
> +
> +static int himax_read_product_id(struct himax_ts_data *ts, u32 *product_id)
> +{
> +	int error = himax_read_config(ts, HIMAX_CFG_PRODUCT_ID, product_id);
> +
> +	if (error)
> +		return error;
> +
> +	*product_id >>= 8;
> +	return 0;
> +}
> +
> +static int himax_check_product_id(struct himax_ts_data *ts)
> +{
> +	int error;
> +	u32 product_id;
> +
> +	error = himax_read_product_id(ts, &product_id);
> +	if (error)
> +		return error;
> +
> +	dev_dbg(&ts->client->dev, "Product id: %x\n", product_id);
> +
> +	switch (product_id) {
> +	case HIMAX_ID_83112B:
> +		return 0;
> +
> +	default:
> +		return dev_err_probe(&ts->client->dev, -ENODEV,
> +				     "Unknown product id: %x\n", product_id);

Aside from the existing arguments against dev_err_probe(), there is
no point in using it here as the error is fixed and never equal to
-EPROBE_DEFER. I know the documentation specifically offers this but
doing so seems unnecessarily convoluted; just my $.02.

Also note that -ENODEV is not really the appropriate error code to
use here. It is not that there was no device at this address, rather
the device did not return a valid product ID. Therefore I think that
-EINVAL is more appropriate; again this is just my $.02.

> +	}
> +}
> +
> +static int himax_setup_gpio(struct himax_ts_data *ts)
> +{
> +	ts->gpiod_rst =
> +		devm_gpiod_get(&ts->client->dev, "reset", GPIOD_OUT_HIGH);

This line break is hard to read. This would be better:

        ts->gpiod_rst = devm_gpiod_get(...,
                                       ...);

> +	if (IS_ERR(ts->gpiod_rst)) {
> +		return dev_err_probe(&ts->client->dev, PTR_ERR(ts->gpiod_rst),
> +				     "Failed to get reset GPIO\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int himax_input_register(struct himax_ts_data *ts)
> +{
> +	int error;
> +
> +	ts->input_dev = devm_input_allocate_device(&ts->client->dev);
> +	if (!ts->input_dev) {
> +		return dev_err_probe(&ts->client->dev, -ENOMEM,
> +				     "Failed to allocate input device\n");
> +	}

Same here, this call to dev_err_probe() really just becomes dev_err()
followed by a return.

That being said, use of dev_err_probe() is generally frowned upon in
the input subsystem and I tend to agree. The argument against it is
that resources that may not be ready in time should be responsible for
the housekeeping done in dev_err_probe() rather than every possible
consumer doing so through every possible error path.

I only mention this because you will likely be asked to change even
the "valid" calls to dev_err_probe().

> +
> +	ts->input_dev->name = "Himax Touchscreen";
> +
> +	input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_X);
> +	input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_Y);
> +	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 200, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 200, 0, 0);
> +
> +	touchscreen_parse_properties(ts->input_dev, true, &ts->props);

Since the driver is not reading any default resolution values from the
device, it seems you are expecting touchscreen-size-x/y to be provided
as in your example.

Unless I have misunderstood, please consider promoting these properties
to 'required' in the binding.

> +
> +	error = input_mt_init_slots(ts->input_dev, HIMAX_MAX_POINTS,
> +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +	if (error) {
> +		return dev_err_probe(&ts->client->dev, error,
> +				     "Failed to initialize MT slots");
> +	}
> +
> +	error = input_register_device(ts->input_dev);
> +	if (error) {
> +		return dev_err_probe(&ts->client->dev, error,
> +				     "Failed to register input device");
> +	}
> +
> +	return 0;
> +}
> +
> +static u8 himax_event_get_num_points(const struct himax_event *event)
> +{
> +	if (event->num_points == 0xff)
> +		return 0;
> +	else
> +		return event->num_points & 0x0f;
> +}
> +
> +static u16 himax_event_point_get_x(const struct himax_event_point *point)
> +{
> +	return be16_to_cpu(point->x);
> +}
> +
> +static u16 himax_event_point_get_y(const struct himax_event_point *point)
> +{
> +	return be16_to_cpu(point->y);
> +}

These two functions seem to add an unnecessary layer and probably get
inlined anyway; I think it is cleaner to simply call be16_to_cpu(...)
directly.

> +
> +static bool himax_event_point_is_valid(const struct himax_event_point *point)
> +{
> +	return himax_event_point_get_x(point) != 0xffff &&
> +	       himax_event_point_get_y(point) != 0xffff;
> +}

How about U16_MAX?

> +
> +static bool himax_process_event_point(struct himax_ts_data *ts,
> +				      const struct himax_event *event,
> +				      int point_index)
> +{
> +	const struct himax_event_point *point = &event->points[point_index];
> +	u16 x = himax_event_point_get_x(point);
> +	u16 y = himax_event_point_get_y(point);
> +	u8 w = event->majors[point_index];
> +
> +	if (!himax_event_point_is_valid(point))
> +		return false;
> +
> +	input_mt_slot(ts->input_dev, point_index);
> +	input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, true);
> +	touchscreen_report_pos(ts->input_dev, &ts->props, x, y, true);
> +	input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, w);
> +	input_report_abs(ts->input_dev, ABS_MT_WIDTH_MAJOR, w);
> +	return true;
> +}
> +
> +static void himax_process_event(struct himax_ts_data *ts,
> +				const struct himax_event *event)
> +{
> +	int i;
> +	int num_points_left = himax_event_get_num_points(event);
> +
> +	for (i = 0; i < HIMAX_MAX_POINTS && num_points_left > 0; i++) {
> +		if (himax_process_event_point(ts, event, i))
> +			num_points_left--;
> +	}
> +
> +	input_mt_sync_frame(ts->input_dev);
> +	input_sync(ts->input_dev);
> +}
> +
> +static bool himax_verify_checksum(struct himax_ts_data *ts,
> +				  const struct himax_event *event)
> +{
> +	u8 *data = (u8 *)event;
> +	int i;
> +	u16 checksum = 0;
> +
> +	for (i = 0; i < sizeof(*event); i++)
> +		checksum += data[i];
> +
> +	if ((checksum & 0x00ff) != 0) {
> +		dev_err(&ts->client->dev, "Wrong event checksum: %04x\n",
> +			checksum);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void himax_handle_input(struct himax_ts_data *ts)
> +{
> +	int error;
> +	struct himax_event event;
> +
> +	error = himax_read_input_event(ts, &event);
> +	if (error) {
> +		dev_err(&ts->client->dev, "Failed to read input event: %d\n",
> +			error);
> +		return;
> +	}
> +
> +	if (!himax_verify_checksum(ts, &event))
> +		return;
> +
> +	himax_process_event(ts, &event);
> +}
> +
> +static irqreturn_t himax_irq_handler(int irq, void *dev_id)
> +{
> +	struct himax_ts_data *ts = dev_id;
> +
> +	himax_handle_input(ts);

Is it accurate to assume that the act of reading the event status
register(s) is what acknowledges the interrupt and de-asserts the
interrupt pin?

If so, I think it is safer to define himax_handle_input() with an
integer return type, then return IRQ_NONE upon failure. If the I2C
adapter goes south such that reads are never initiated and the pin
is stuck low causing an interrupt storm, the handler would get cut
off quickly.

Just for my own understanding, _when_ does the pin get de-asserted?
Is it early in the I2C read, or after the stop condition? In case
of the latter, consider a delay to prevent the interrupt from being
immediately triggered once more after the handler has returned, but
the pin hasn't quite returned to a logic-high level.

> +	return IRQ_HANDLED;
> +}
> +
> +static int himax_request_irq(struct himax_ts_data *ts)
> +{
> +	struct i2c_client *client = ts->client;
> +
> +	return devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					 himax_irq_handler, IRQF_ONESHOT,
> +					 client->name, ts);
> +}

This wrapper seems unnecessary.

> +
> +static int himax_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *id)
> +{
> +	int error;
> +	struct device *dev = &client->dev;
> +	struct himax_ts_data *ts;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		return dev_err_probe(dev, -ENODEV,
> +				     "I2C check functionality failed\n");
> +	}

No need for curly braces around if () blocks that only have one expression.

> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, ts);
> +	ts->client = client;
> +
> +	ts->regmap = devm_regmap_init_i2c(client, &himax_regmap_config);
> +	if (IS_ERR(ts->regmap)) {
> +		return dev_err_probe(&client->dev, PTR_ERR(ts->regmap),
> +				     "Failed to initialize regmap");
> +	}

And here.

> +
> +	error = himax_setup_gpio(ts);
> +	if (error)
> +		return error;
> +
> +	himax_reset(ts);

It looks like we're expecting an I2C read to occur directly after reset
is de-asserted. Understanding that no datasheet is available to specify
how much time the device takes to exit reset, does the downstream driver
at least include some delay?

> +
> +	error = himax_check_product_id(ts);
> +	if (error)
> +		return error;
> +
> +	error = himax_input_register(ts);
> +	if (error)
> +		return error;
> +
> +	error = himax_request_irq(ts);
> +	if (error)
> +		return error;
> +
> +	return 0;

Nit: I think it is cleaner to simply return himax_request_irq(ts) here,
or actually just devm_request_threaded_irq().

> +}
> +
> +static int himax_suspend(struct device *dev)
> +{
> +	struct himax_ts_data *ts = dev_get_drvdata(dev);
> +
> +	disable_irq(ts->client->irq);
> +	return 0;
> +}
> +
> +static int himax_resume(struct device *dev)
> +{
> +	struct himax_ts_data *ts = dev_get_drvdata(dev);
> +
> +	enable_irq(ts->client->irq);
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(himax_pm_ops, himax_suspend, himax_resume);
> +
> +static const struct i2c_device_id himax_ts_id[] = {
> +	{ "hx83112b", 0 },
> +	{ /* sentinel */ },

Nit: no need for a trailing comma after the sentinel because no patch
would ever add a line below it.

> +};
> +MODULE_DEVICE_TABLE(i2c, himax_ts_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id himax_of_match[] = {
> +	{ .compatible = "himax,hx83112b" },
> +	{ /* sentinel */ },

And here.

> +};
> +MODULE_DEVICE_TABLE(of, himax_of_match);
> +#endif
> +
> +static struct i2c_driver himax_ts_driver = {
> +	.probe = himax_probe,
> +	.id_table = himax_ts_id,
> +	.driver = {
> +		.name = "Himax-hx83112b-TS",
> +		.of_match_table = of_match_ptr(himax_of_match),
> +		.pm = &himax_pm_ops,
> +	},
> +};
> +module_i2c_driver(himax_ts_driver);
> +
> +MODULE_AUTHOR("Job Noorman <job@noorman.info>");
> +MODULE_DESCRIPTION("Himax hx83112b touchscreen driver");
> +MODULE_LICENSE("GPL");
> --
> 2.38.0
> 
> 
