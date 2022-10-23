Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2376095FE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiJWUHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJWUHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:07:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6E25D701;
        Sun, 23 Oct 2022 13:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnVcAx1sruzawcZ849fGIQBBbvzs4PQd2bEiDKq+qrfZXUcLas3IqHlrFQCicB8TNECUu1GaKa+UnKZz6yGUegqFwLTTd4Rd5rvHyemDNBZYUj2NSOLG4j5cxeQVVG4/VSiA3nT+OPd2nUhtVd0BLcfq/I1+Ik8GuCeJ37kB6rUelGZ73FovSORHu8JMr0/ubtpAjf8IgUiLoCnaADy5JGp3BtgbKzlHhXnKpElu2/tihibaCTqxcqDXLZGFscwSSFwnd1BsuphDHb8JlhAVrKvAdUa/71ofqIHCLYZnl5RkU7+nng/5a7yDztUWL0N9zqAMeubHM8VEXiqLxrUySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrfQg893LHWiD+sjOjWF9WOy9BWK9t4wONPSMEReyeY=;
 b=i71awkNluA/6gm615/4YmXTOPy4zRALJwb+G8VpQEd5B8jbBcQ+nrjMko6X5mcio+nWXBIf/aoTv4hEds3ftRh2dktIOkL+vE9FOPoOv17X3RzoJATfbdr5qk6nH2WcnArEj0+r/PRLbhuqtbslvtBB2k3wPlZcfyM1Bu7IrQXVnvJ9iDFiam2TkAltQSEUps/sJUk29ppEL4cgSgyUytebJrqF6whULiC5+RPZnjTts8iWTqioVay/INbAy+m2lulH2583KbVVQdbpg3inoI3jDphEUo1BVFi+JvUak75tqJb+EHxAsBtEQSUbXFwPUTOHwu0Y8jbN1eAbRUSK9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrfQg893LHWiD+sjOjWF9WOy9BWK9t4wONPSMEReyeY=;
 b=mphBNtPaCoMorIQNERaR1M3kFi8LqbdeAfBomZXpiVUnALaLl3qXQlwN/KuHu1Tja/nA0M8bcDLV67LaN7qPdRtSOdVGdrQU2Rwp5XVcjpssBRIPynK6FzjraWPLT7NwFiwBPg/OGiRh8D4ChJyzc1P43mc+2dAOjlROlN9m4tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com (2603:10b6:4:7c::37)
 by DM6PR08MB5418.namprd08.prod.outlook.com (2603:10b6:5:19::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Sun, 23 Oct
 2022 20:07:18 +0000
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::4210:5b1f:4678:ed84]) by DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::4210:5b1f:4678:ed84%7]) with mapi id 15.20.5746.021; Sun, 23 Oct 2022
 20:07:18 +0000
Date:   Sun, 23 Oct 2022 15:07:12 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Job Noorman <job@noorman.info>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v5 2/3] Input: add driver for Himax hx83112b touchscreen
 devices
Message-ID: <Y1We8NgutWBbbNpV@nixie71>
References: <20221023163032.144150-1-job@noorman.info>
 <20221023163032.144150-3-job@noorman.info>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023163032.144150-3-job@noorman.info>
X-ClientProxiedBy: SA1P222CA0054.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::29) To DM5PR0801MB3767.namprd08.prod.outlook.com
 (2603:10b6:4:7c::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0801MB3767:EE_|DM6PR08MB5418:EE_
X-MS-Office365-Filtering-Correlation-Id: d795180e-c68a-4d2f-ba51-08dab5322fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8YnyKsQqR9knEQHmuT0QnGo7hTs5oQz33CBbwM31HFe3957dbh79Y110dRB79BWQIdiR4iXwm4M6xRqGIs24gSI0HyPsKRnozYE9t3QdxWmzvKh04F2Q7N8RBjuzbHE5Gcrv1r3Qvg1nJWLewg/AnON4KfkG3faeh1uAWLiISoXA83oVqJ6ZpEl5eMtBZzcmuutobC7WQnv82CCTN82tPNQTgwqmereTq4wQPLfs9zoQ5mGHi2v1gg0Z1YzAyOuiwgu9X6+g52SVaTN0ij1ym86zHOn6JY75mqk88zZEefHaoFNmWKo6XvSe4no2ezZph9pRp1eCOdMiBIWKp2nb6MhYPD3cPOVr778PNsmvs7tzs4c7uCgkmvZYJjTNR9WmXerT4LLK5WpWafqfG0cXCkrPIIKlgowBhYPDUQ5r552RKHH7JG3VFA99MVXxxi2MXiL1FuCY7GXaD6zbAXXkHofIOiWLVop/fKkYKZLXXi3sRELvJ3UNWjJw66TxfKifAD2D4BT9p2hNQ5kVrdc9SJMiZH5vM5XwGwfhiWVTT07RbeSmRkZODFhOO1i/8YfD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0801MB3767.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39830400003)(346002)(366004)(376002)(396003)(136003)(451199015)(478600001)(83380400001)(86362001)(6486002)(6512007)(66946007)(8936002)(6506007)(6666004)(33716001)(6916009)(54906003)(9686003)(26005)(38100700002)(5660300002)(8676002)(316002)(2906002)(186003)(41300700001)(4326008)(66476007)(66556008)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jd7VJN2XEhzR+Wf8IL4CIoHzJtgWN8NPUXpFNeTWFnu6rLy9l1HYrPN/51Xs?=
 =?us-ascii?Q?HXowVRNdC7HMY0ViXXHE8sF2MKEXYDj5LRgeMhVBGn6lyWHrTK/8vgHEwazv?=
 =?us-ascii?Q?8yaybW6M94hzH7FtZdTbvQ4Ybm9rTSonqVZSPb9n9Hg/AoPFHTksTAYuZ4RK?=
 =?us-ascii?Q?pHWRO7VfDJgFTANRgAP/NMU7oAWGPurt0wjjvub5SHe4KyL9xy+eVuC3RBMz?=
 =?us-ascii?Q?3uyec5rDjldc5sW6Haysr9tP06/i41qQ+v2uuABOSUcssRnhl337yK9FHq1G?=
 =?us-ascii?Q?CyKZ/dtRzMyWW+yOQs/ntFFBfPJMUfqHfHgp80cmQggMWwucXYqJ8lfvV/w+?=
 =?us-ascii?Q?gjehj62cEEBQBuuompieKtV4wWsICPE2i8YEl1sSmZ1i+EX9M5yazpbIcR67?=
 =?us-ascii?Q?3X1GmkJN46N6Q2Cvkq2k2VGKwjeFqVWn+FzbNede4zdoUWV1SlP6Pvr3YaOI?=
 =?us-ascii?Q?cdIdYFm+541mmIVEKgf+HNHFB2LJwOKxfRsU6CCNQDY+8CqzaDI919Thrv07?=
 =?us-ascii?Q?9s19m3Acean3H1xAkrn62Dq+i5jO9ZKUTFLEXb0sT246+DeMRQpg5QRL3Se/?=
 =?us-ascii?Q?IxNZek1b2a+5XBNwEPhCnPgow0plpAwS+QjqGTDAHhIfrVuioUt1WMKRzVxV?=
 =?us-ascii?Q?ksX+UX7/Lxk/HE7SPzJM/lLWdGRu/ctW5vf59xkmiiClx43jKnU37EKqxFY1?=
 =?us-ascii?Q?rbte2aZ0nkvonQfKq3WP2Uv4VEUrb/qMbEN54tgiFut9c4HTgRJbq1SGMrCp?=
 =?us-ascii?Q?0y43uliPYi778KPeC6gYedIplSXZGGXO+1fZXOo0wPsaTBB/YpehY9W2I06i?=
 =?us-ascii?Q?iCYzLnLH1rHwY8FO1+j0WiCgIR5mjuioqpCsQ6LeL51N3+I4vgcf4y2WGH9n?=
 =?us-ascii?Q?xUxIu2A2tg0bCq1FZP5nw4F/RCGRBNa4gj5TP/iKwGTXqSzVmpChnG9SlIXx?=
 =?us-ascii?Q?snH/r5TNeiwAeEsmAtUde7SMp5zk8xmSvJeJ6aGpW6nC2dYZgLCBtckm+PfO?=
 =?us-ascii?Q?e4ZZEMJM3MjjuPqopYQwDZWrQMPPQmfxo6A8nzJjIQ1MI7sk6giIhQG43j5j?=
 =?us-ascii?Q?KFhNSQcIp1uh4vovi7iMgTFDh3VmsFdzp9+F9gSGIZd4T+V1r6hvwKkiM0H8?=
 =?us-ascii?Q?qGvMm8ZDk929og+ErZXnOFiL5iYP4XC2tk/f2zx8yWzcOiFf2p6b4/ffFGne?=
 =?us-ascii?Q?GXvY4f8K7fEGP/mII+r/iW93TFTVkG117R1zOfF/XJIFKhNVGalDvtPVUljM?=
 =?us-ascii?Q?Y/XSGEvU7+sbu3u9ll0+pBytISx2WiQmyCUN6mTuisUFGKcxI0q8slHgo4b6?=
 =?us-ascii?Q?awqA/JEcOKoYxXpZgNPn8Eyti+25gW5liLftz0SAAJEoHCm03yciafrkiVC0?=
 =?us-ascii?Q?qKnoyS7LNwELXy9pRNS9eRxbdor91L/IWLgiwe6yqYI/kqHZlm533ZhScD29?=
 =?us-ascii?Q?HsqvVocVmRxz6J44ux1YwCAy5uR/ikHFVYQW30Cx7TXJgDu3aIu9gyolShaf?=
 =?us-ascii?Q?5/mmBui2u7Wa0hAbWPB1ZZTYqZXjauG4uu84dIt1002nankWfWR5Pii1ryfO?=
 =?us-ascii?Q?4z1pW23XPrn1X7/pWrj6bQ0xv/IbdYvoSUKAWd9+?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d795180e-c68a-4d2f-ba51-08dab5322fb5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0801MB3767.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2022 20:07:18.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RixrvoTBvGsVEiIncjzyApCNK8PBw7WEbEmSTOie3D1iGslHLGSiLUdqzIgE+umeo4UXM6wD5jAJG+NkCOnjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5418
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Job,

Looks great; just a few tiny nits that I missed last time. Sorry
about that!

On Sun, Oct 23, 2022 at 06:30:30PM +0200, Job Noorman wrote:
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
>  drivers/input/touchscreen/Kconfig          |  12 +
>  drivers/input/touchscreen/Makefile         |   1 +
>  drivers/input/touchscreen/himax_hx83112b.c | 364 +++++++++++++++++++++
>  4 files changed, 378 insertions(+)
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
> index dc90a3ea51ee..8cdb16a811e6 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1379,4 +1379,16 @@ config TOUCHSCREEN_ZINITIX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called zinitix.
>  
> +config TOUCHSCREEN_HIMAX_HX83112B
> +	tristate "Himax hx83112b touchscreen driver"
> +	depends on I2C
> +	select REGMAP_I2C
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
> index 000000000000..b671c8148e39
> --- /dev/null
> +++ b/drivers/input/touchscreen/himax_hx83112b.c
> @@ -0,0 +1,364 @@
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
> +#define HIMAX_ID_83112B			0x83112b
> +
> +#define HIMAX_MAX_POINTS		10
> +
> +#define HIMAX_REG_CFG_SET_ADDR		0x00
> +#define HIMAX_REG_CFG_INIT_READ		0x0c
> +#define HIMAX_REG_CFG_READ_VALUE	0x08
> +#define HIMAX_REG_READ_EVENT		0x30
> +
> +#define HIMAX_CFG_PRODUCT_ID		0x900000d0
> +
> +#define HIMAX_INVALID_COORD		0xffff
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
> +	int error;
> +
> +	error = regmap_write(ts->regmap, HIMAX_REG_CFG_SET_ADDR, address);
> +	if (error)
> +		return error;
> +
> +	error = regmap_write(ts->regmap, HIMAX_REG_CFG_INIT_READ, 0x0);
> +	if (error)
> +		return error;
> +
> +	error = regmap_read(ts->regmap, HIMAX_REG_CFG_READ_VALUE, dst);
> +	if (error)
> +		return error;
> +
> +	return 0;
> +}
> +
> +static void himax_reset(struct himax_ts_data *ts)
> +{
> +	gpiod_set_value_cansleep(ts->gpiod_rst, 1);
> +
> +	/* Delay copied from downstream driver */
> +	msleep(20);
> +	gpiod_set_value_cansleep(ts->gpiod_rst, 0);
> +
> +	/*
> +	 * The downstream driver doesn't contain this delay but is seems safer
> +	 * to include it. The range is just a guess that seems to work well.
> +	 */
> +	usleep_range(1000, 1100);
> +}
> +
> +static int himax_read_product_id(struct himax_ts_data *ts, u32 *product_id)
> +{
> +	int error;
> +
> +	error = himax_read_config(ts, HIMAX_CFG_PRODUCT_ID, product_id);
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
> +		dev_err(&ts->client->dev,
> +			"Unknown product id: %x\n", product_id);
> +		return -EINVAL;
> +	}
> +}
> +
> +static int himax_input_register(struct himax_ts_data *ts)
> +{
> +	int error;
> +
> +	ts->input_dev = devm_input_allocate_device(&ts->client->dev);
> +	if (!ts->input_dev) {
> +		dev_err(&ts->client->dev, "Failed to allocate input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	ts->input_dev->name = "Himax Touchscreen";
> +
> +	input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_X);
> +	input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_Y);
> +	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 200, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 200, 0, 0);
> +
> +	touchscreen_parse_properties(ts->input_dev, true, &ts->props);
> +
> +	error = input_mt_init_slots(ts->input_dev, HIMAX_MAX_POINTS,
> +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"Failed to initialize MT slots: %d\n", error);
> +		return error;
> +	}
> +
> +	error = input_register_device(ts->input_dev);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"Failed to register input device: %d\n", error);
> +		return error;
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
> +static bool himax_process_event_point(struct himax_ts_data *ts,
> +				      const struct himax_event *event,
> +				      int point_index)
> +{
> +	const struct himax_event_point *point = &event->points[point_index];
> +	u16 x = be16_to_cpu(point->x);
> +	u16 y = be16_to_cpu(point->y);
> +	u8 w = event->majors[point_index];
> +
> +	if (x == HIMAX_INVALID_COORD || y == HIMAX_INVALID_COORD)
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
> +static int himax_handle_input(struct himax_ts_data *ts)
> +{
> +	int error;
> +	struct himax_event event;
> +
> +	error = regmap_raw_read(ts->regmap, HIMAX_REG_READ_EVENT, &event,
> +				sizeof(event));
> +	if (error) {
> +		dev_err(&ts->client->dev, "Failed to read input event: %d\n",
> +			error);
> +		return error;
> +	}
> +
> +	/*
> +	 * Only process the current event when it has a valid checksum but
> +	 * don't consider it a fatal error when it doesn't.
> +	 */
> +	if (himax_verify_checksum(ts, &event))
> +		himax_process_event(ts, &event);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t himax_irq_handler(int irq, void *dev_id)
> +{
> +	int error;
> +	struct himax_ts_data *ts = dev_id;
> +
> +	error = himax_handle_input(ts);
> +	if (error)
> +		return IRQ_NONE;
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int himax_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *id)
> +{
> +	int error;
> +	struct device *dev = &client->dev;
> +	struct himax_ts_data *ts;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(dev, "I2C check functionality failed\n");
> +		return -ENXIO;
> +	}
> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, ts);
> +	ts->client = client;
> +
> +	ts->regmap = devm_regmap_init_i2c(client, &himax_regmap_config);
> +	error = PTR_ERR_OR_ZERO(ts->regmap);
> +	if (error) {
> +		dev_err(&client->dev,

We already have a locally declared dev pointer which at this point is
equal to &client->dev as well as &ts->client->dev, so we can just use
that here instead.

> +			"Failed to initialize regmap: %d\n", error);
> +		return error;
> +	}
> +
> +	ts->gpiod_rst = devm_gpiod_get(&ts->client->dev, "reset",
> +				       GPIOD_OUT_HIGH);

Same thing here. Using the local variable will also let you avoid the
line break.

> +	error = PTR_ERR_OR_ZERO(ts->gpiod_rst);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"Failed to get reset GPIO: %d\n", error);

Also here...

> +		return error;
> +	}
> +
> +	himax_reset(ts);
> +
> +	error = himax_check_product_id(ts);
> +	if (error)
> +		return error;
> +
> +	error = himax_input_register(ts);
> +	if (error)
> +		return error;
> +
> +	return devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					 himax_irq_handler, IRQF_ONESHOT,
> +					 client->name, ts);

And finally here.

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
> +static DEFINE_SIMPLE_DEV_PM_OPS(himax_pm_ops, himax_suspend, himax_resume);
> +
> +static const struct i2c_device_id himax_ts_id[] = {
> +	{ "hx83112b", 0 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, himax_ts_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id himax_of_match[] = {
> +	{ .compatible = "himax,hx83112b" },
> +	{ /* sentinel */ }
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
> +		.pm = pm_sleep_ptr(&himax_pm_ops),
> +	},
> +};
> +module_i2c_driver(himax_ts_driver);
> +
> +MODULE_AUTHOR("Job Noorman <job@noorman.info>");
> +MODULE_DESCRIPTION("Himax hx83112b touchscreen driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.38.1
> 

With those remaining points resolved:

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

Kind regards,
Jeff LaBundy
