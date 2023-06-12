Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC8A72B61E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjFLDcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjFLDb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:31:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E59B;
        Sun, 11 Jun 2023 20:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbJUu1zviVg55VeUSjGELMpA4d7y3oc0swXaBu7DvUcOEauZKlr2jzKVdui1PHzQeuyZKztwramjXdnagStu+ldrF4UmzPFR46mSwOvjyCmDB4puYcwGJWj5h+96C6g0eZRGL4L1Re+JW37IVnEPsTOz4mEVxMjZJZ0ILSoFWb0J293DfO/fS+rILnANE/UrfBQvT4FOL2lRkTuihVzkLCFm6HjbNblCDGPk2Qq1GqxaVPfKHpLrCIb78msVp6nIYMLinQqXvjEdTWA/Uyh77Ov9l/UhvNKX9MCnEM+FI4uKoGZQpGp2voRojnygZN2BAlfJysfLfNI8sQWjCOvdrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkdh45UC0Nh48I8vmWq9FTVMMTe83mnptHELFvaGRkI=;
 b=BHIZUE0Ay1B4GWZrVio/e1PLu3gd7esmudYGEPQK0983XeI17X+J+LhFDkbAjSRZH5OEvGXBFsBTEFr/si1zWXSfyxaKOy/xwgBIyZaBVOWryNa8BNDfcxDmcSTPPv4nt5rbDFsKtxsRgJSwBMi9r/YDskjujQpjc6cdyr/6Goz0fRJHCdsp8CN/KEzb9bjgX7O7F8I3RcvjaszwgkR+CUUbnSWHVrDZEB8tdyEibCrGiPNUfWJoKocbR2gLbK0ppUqxkpvXRPJSS6YdgOebLu2iQrnwbl4XvAVuGDfV6yQloJ4wMRtYgN6DtEJpyUqs7bgVW4hXbyM1GGfBbqOXiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkdh45UC0Nh48I8vmWq9FTVMMTe83mnptHELFvaGRkI=;
 b=ZIbURhe5jmi+ue6rWyvz/vromK5CI2Y373cAf9qlq3+rD1zqwW09RWhV3Ei9mEjjpDHAVpKi4ygd4tqoayjDHgYYhwPvDEk6VKPXVwA37U7cAj45BwPM8te6QPpiakeQlBFH02QcZXFzen/4uGDVyvT+GFuKuU+wdtNExkGLnSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH7PR08MB8819.namprd08.prod.outlook.com
 (2603:10b6:510:2eb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Mon, 12 Jun
 2023 03:31:52 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ca3a:84ac:381c:1506]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ca3a:84ac:381c:1506%4]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 03:31:52 +0000
Date:   Sun, 11 Jun 2023 22:31:45 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] input: touchscreen: add SPI support for Goodix
 Berlin Touchscreen IC
Message-ID: <ZIaRoTHar/s5yZAh@nixie71>
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v1-4-4a0741b8aefd@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v1-4-4a0741b8aefd@linaro.org>
X-ClientProxiedBy: SA9PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:806:22::29) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH7PR08MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: f1100fcf-4eeb-4eda-2345-08db6af59067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3y3FFfs48PUTZyjpktueU41uUPlxzKuh3zPaOaVQS7aVpWKcTRfcVh3tbNV8cZ30PcgkLgGEpuGA8EJMgXRSaOUU6dU5RwIW6NCDw7tIIvMSpXpzTFcrbWFNO4vS5e3ZkNXXRvAnePJ+VF9paB5q/kJ6VhFTDNV4y6VPsweaoZx7lNw1uCzIEQIsUsdHwQvSUQ4gsEefj2qHr11nWGwvbVvz9pah8v5XBte9Spl3PKb5iAdwaghn45VdwqVrqKmb7DKrwZZAzuVUV2sXQrcqCZ7dbusX3TQnPq8yYY9Ob+gxTHr3JK2HufEw+em5wYw2zA28Tx5EwIg3v6w8pi6JY3iNmDXEDmqKwwmnEAi5zfDeZ/l7eT87MbwmKnZok2+IASRZfOwLTh47JT6wTSUofa4p2obzeUuVu/PKlLcUbe8bKRl3kKaUUcH+8tMmu+V8v7THVsZaAyAwXl3HYmHmciwu0FnT1RX9GeAqDQYkzlc3i1sL3sZGw9GEh+p4wPBoRTLcoWdKoNzujG7fnSp/g5ari1kQOyMiaifOgUSVvxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(136003)(346002)(366004)(39830400003)(451199021)(5660300002)(83380400001)(316002)(4326008)(66556008)(54906003)(66476007)(6916009)(38100700002)(33716001)(7416002)(66946007)(86362001)(6512007)(478600001)(6506007)(9686003)(26005)(8936002)(8676002)(966005)(41300700001)(6666004)(6486002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CpUOffZip4IlymWqkRa3KmuvH3RH9wgXup86e+rah46raOlOonlQ/CDDWdAS?=
 =?us-ascii?Q?hviMcDGN6lrJ2CjqOXI4sBoIcY+VJObU+tNIsGw+drNLBX1vHuUGNN3q2G8r?=
 =?us-ascii?Q?RxdcThgCxkm/io+z0objT5lyI8dtxqZGI0CXxaeq+1Lkn1sNODroYhTI8pOa?=
 =?us-ascii?Q?dNPfXMOdhkLbFoONOs3B3EQbJq/dahwKZTC8syod/0MyAe9m6dSgfwSlFod5?=
 =?us-ascii?Q?HG36Zo1Y332mOknK+ahpBmqOnaBLmxVHhnudEbsgdofk4WKAEt+AYOrZqIQj?=
 =?us-ascii?Q?/WBKZSa2/2UfkLvTjyvO3wrjUstmmC6oU8VDW0YCQBaUu+Qw8UmLLsgV71SK?=
 =?us-ascii?Q?ZwJFBJxgKfdWTxXp1TOJa4frXmrxUfBVovNnL+/JmwkkTctSzTWl3fIt3k1E?=
 =?us-ascii?Q?2LoVpchkri+brpcQHRYs7+3IaNh3WvVicbLPaVbf8biDhNals266Gsq/1FqF?=
 =?us-ascii?Q?XpxinmQPHknHnFOaBwsF8RFWIZqdRZfFJY2EC6MlV55HYDkoPsCnVcXb+clm?=
 =?us-ascii?Q?8HtjgE0u+T9hlMnS83K6i7R1JKXhL40X+4LVawhMDpbcka9Jg2xvj4ErOOmV?=
 =?us-ascii?Q?XmWdMS/7YZQcphs5Wk3i7aqVAt7TxIQasHIr9+7OrTBVOmZO5G6UGH2k4Bqf?=
 =?us-ascii?Q?fA9h9LZo3J4+hmy8CZkVvCSdMm/XwuGg5RMffEJqrsgq/SVn1+bTnqFbhKSJ?=
 =?us-ascii?Q?vKnXz9M3tLqv23K4EmT8HqXVAhm+kSOuzOcUF/EhWjwydWagQvUCtUo8CNgJ?=
 =?us-ascii?Q?DA601KjI5xWHoqRlOb1alZVQgxmSWK7e4evQdHS5u/butenl+5RESR35/lFj?=
 =?us-ascii?Q?Kej/yLwaNnbGweJUA6DP6G078RGhnA7D7kjHT/OFNSNWWXq3i/5Uj+cKqeTz?=
 =?us-ascii?Q?KmSehFT9QE0qmH5gQc3oUu3Vn27AIUOyUNc+tvcbU5/6NwGv+5M4bD+2HcyH?=
 =?us-ascii?Q?5fPdXY7n3+pzQhT7uD1/g9EXIy+yWniZtOK0fHgKY+IRnj8kJkNLsLFGA2nf?=
 =?us-ascii?Q?q2WAx129qhT0jL5inzk/e2H5L+uYOAsTSlB702lKar2xT53tc65P4TREioUq?=
 =?us-ascii?Q?SrFegCMV+WxSI7/dCJum2t08hyzGuq5smoSz7Z1O/s8heahDHlD5GYVb6Ml6?=
 =?us-ascii?Q?6kX/fKwLXA5MZO+Xiaq1nMei+nb0urFBNJC1P1DVD7rbqQ+iqfelZzqldD/W?=
 =?us-ascii?Q?7c1ivdbQldZyzsiOWA6s3XgU81IrrEMAbWbW590y+YcuBgrz36KY44cDbuq7?=
 =?us-ascii?Q?UJVypayEF7HXEuKc0N1yvYmC0h2kBdyZvw6LwFokOGPisYz5eOD2FC0fmest?=
 =?us-ascii?Q?6H5Xhr9Pa+uIuMWhve9uHo8ym39FUrA2UE3K0LIaR9g1NgJV1I1BAvy8l4ZX?=
 =?us-ascii?Q?g0D9B3VKbseg6Td9GuaHzuIuVbN9AN/45S5yUVYMpDxaS9DSc6aKy2XUH87f?=
 =?us-ascii?Q?axMPHCs5ETpUixTdUyhLrVOIel/8wyfutoKXNvBT9yeYIvZqUPwKcw5Jd3Vv?=
 =?us-ascii?Q?5i9iUGe2BUxebZMaJikY6kPMQRdGNAbpMbSSoDhxlWnxj3mqX0u9kyOSh/DE?=
 =?us-ascii?Q?CCx7SiLRoYyjCVZusi08xlJkhD61cEDN1IKNTJt3?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1100fcf-4eeb-4eda-2345-08db6af59067
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 03:31:52.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iC2FfhHvuS3fQasvl20dO+vk9ovNkvEfLwuYuVzKT2vLz82wak9rtxfENV5KtW1OsS+MVkNpfKrsiZB9+/EzAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR08MB8819
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Jun 06, 2023 at 04:31:59PM +0200, Neil Armstrong wrote:
> Add initial support for the new Goodix "Berlin" touchscreen ICs
> over the SPI interface.
> 
> The driver doesn't use the regmap_spi code since the SPI messages
> needs to be prefixed, thus this custom regmap code.
> 
> This initial driver is derived from the Goodix goodix_ts_berlin
> available at [1] and [2] and only supports the GT9916 IC
> present on the Qualcomm SM8550 MTP & QRD touch panel.
> 
> The current implementation only supports BerlinD, aka GT9916.
> 
> [1] https://github.com/goodix/goodix_ts_berlin
> [2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/input/touchscreen/Kconfig             |  14 ++
>  drivers/input/touchscreen/Makefile            |   1 +
>  drivers/input/touchscreen/goodix_berlin_spi.c | 183 ++++++++++++++++++++++++++
>  3 files changed, 198 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index da6d5d75c42d..ffe0c0a4cd15 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -435,6 +435,20 @@ config TOUCHSCREEN_GOODIX_BERLIN_I2C
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called goodix_berlin_i2c.
>  
> +config TOUCHSCREEN_GOODIX_BERLIN_SPI
> +	tristate "Goodix Berlin SPI touchscreen"
> +	depends on SPI_MASTER
> +	depends on REGMAP

As TOUCHSCREEN_GOODIX_BERLIN_CORE already depends on REGMAP; is this
line necessary?

I was about to ask why not to select REGMAP_SPI; thank you for the
additional information in the commit message.

> +	select TOUCHSCREEN_GOODIX_BERLIN_CORE
> +	help
> +	  Say Y here if you have the a touchscreen connected to your
> +	  system using the Goodix Berlin IC connection via SPI.

Same comment here with regard to diction.

> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called goodix_berlin_spi.
> +
>  config TOUCHSCREEN_HIDEEP
>  	tristate "HiDeep Touch IC"
>  	depends on I2C
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 921a2da0c2be..29524e8a83db 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)	+= goodix_berlin_core.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C)	+= goodix_berlin_i2c.o
> +obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI)	+= goodix_berlin_spi.o
>  obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
>  obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
>  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
> diff --git a/drivers/input/touchscreen/goodix_berlin_spi.c b/drivers/input/touchscreen/goodix_berlin_spi.c
> new file mode 100644
> index 000000000000..0f4f650fdf3f
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix_berlin_spi.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Goodix Berlin Touchscreen Driver
> + *
> + * Copyright (C) 2020 - 2021 Goodix, Inc.
> + * Copyright (C) 2023 Linaro Ltd.
> + *
> + * Based on goodix_ts_berlin driver.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>

Please alphabetize these to aid readability.

> +#include <asm/unaligned.h>
> +
> +#include "goodix_berlin.h"
> +
> +#define SPI_TRANS_PREFIX_LEN	1
> +#define REGISTER_WIDTH		4
> +#define SPI_READ_DUMMY_LEN	3
> +#define SPI_READ_PREFIX_LEN	(SPI_TRANS_PREFIX_LEN + REGISTER_WIDTH + SPI_READ_DUMMY_LEN)
> +#define SPI_WRITE_PREFIX_LEN	(SPI_TRANS_PREFIX_LEN + REGISTER_WIDTH)
> +
> +#define SPI_WRITE_FLAG		0xF0
> +#define SPI_READ_FLAG		0xF1
> +
> +static int goodix_berlin_spi_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
> +{
> +	struct spi_device *spi = context;
> +	struct spi_transfer xfers;
> +	struct spi_message spi_msg;
> +	const u32 *reg = reg_buf; /* reg is stored as native u32 at start of buffer */
> +	u8 *buf = NULL;
> +	int ret = 0;

No need to initialize these, only to forcibly assign them later.

> +
> +	if (reg_size != REGISTER_WIDTH)
> +		return -EINVAL;
> +
> +	buf = kzalloc(SPI_READ_PREFIX_LEN + val_size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	spi_message_init(&spi_msg);
> +	memset(&xfers, 0, sizeof(xfers));
> +
> +	/* buffer format: 0xF1 + addr(4bytes) + dummy(3bytes) + data */
> +	buf[0] = SPI_READ_FLAG;
> +	put_unaligned_be32(*reg, buf + SPI_TRANS_PREFIX_LEN);
> +	memset(buf + SPI_TRANS_PREFIX_LEN + REGISTER_WIDTH, 0xff,
> +	       SPI_READ_DUMMY_LEN);
> +
> +	xfers.tx_buf = buf;
> +	xfers.rx_buf = buf;
> +	xfers.len = SPI_READ_PREFIX_LEN + val_size;
> +	xfers.cs_change = 0;
> +	spi_message_add_tail(&xfers, &spi_msg);
> +
> +	ret = spi_sync(spi, &spi_msg);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "transfer error:%d", ret);
> +		goto exit;
> +	}

My comment is purely idiomatic, but this seems cleaner:

	ret = ...
	if (ret)
		dev_err(...);
	else
		memcpy(...);

	kfree(...);
	return ret;

> +
> +	memcpy(val_buf, buf + SPI_READ_PREFIX_LEN, val_size);
> +exit:
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static int goodix_berlin_spi_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	unsigned int len = count - REGISTER_WIDTH;
> +	struct spi_device *spi = context;
> +	struct spi_transfer xfers;
> +	struct spi_message spi_msg;
> +	const u32 *reg = data; /* reg is stored as native u32 at start of buffer */
> +	u8 *buf = NULL;
> +	int ret = 0;

Same comment here with regard to initialization.

> +
> +	buf = kzalloc(SPI_WRITE_PREFIX_LEN + len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	spi_message_init(&spi_msg);
> +	memset(&xfers, 0, sizeof(xfers));
> +
> +	buf[0] = SPI_WRITE_FLAG;
> +	put_unaligned_be32(*reg, buf + SPI_TRANS_PREFIX_LEN);
> +	memcpy(buf + SPI_WRITE_PREFIX_LEN, data + REGISTER_WIDTH, len);
> +
> +	xfers.tx_buf = buf;
> +	xfers.len = SPI_WRITE_PREFIX_LEN + len;
> +	xfers.cs_change = 0;
> +	spi_message_add_tail(&xfers, &spi_msg);
> +
> +	ret = spi_sync(spi, &spi_msg);
> +	if (ret < 0)
> +		dev_err(&spi->dev, "transfer error:%d", ret);
> +
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static const struct regmap_config goodix_berlin_spi_regmap_conf = {
> +	.reg_bits = 32,
> +	.val_bits = 8,
> +	.read = goodix_berlin_spi_read,
> +	.write = goodix_berlin_spi_write,
> +};
> +
> +static const struct input_id goodix_berlin_spi_input_id = {
> +	.bustype = BUS_SPI,
> +	.vendor = 0x0416,
> +	.product = 0x1001,

After having seen these in the I2C counterpart; consider defining them
in goodix_berlin.h.

> +};
> +
> +static int goodix_berlin_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap_config *cfg;

regmap_config

> +	struct regmap *map;

regmap

(see more examples in MFD where such dual-mode devices are common).

> +	size_t max_size;
> +	int ret = 0;
> +
> +	cfg = devm_kmemdup(&spi->dev, &goodix_berlin_spi_regmap_conf,
> +			   sizeof(*cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return -ENOMEM;
> +
> +	spi->mode = SPI_MODE_0;
> +	spi->bits_per_word = 8;
> +	ret = spi_setup(spi);
> +	if (ret)
> +		return ret;
> +
> +	max_size = spi_max_transfer_size(spi);
> +	cfg->max_raw_read = max_size - SPI_READ_PREFIX_LEN;
> +	cfg->max_raw_write = max_size - SPI_WRITE_PREFIX_LEN;
> +
> +	map = devm_regmap_init(&spi->dev, NULL, spi, cfg);
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	return goodix_berlin_probe(&spi->dev, spi->irq,
> +				   &goodix_berlin_spi_input_id, map);
> +}
> +
> +static void goodix_berlin_spi_remove(struct spi_device *spi)
> +{
> +	goodix_berlin_remove(&spi->dev);
> +}
> +
> +static const struct of_device_id goodix_berlin_spi_of_match[] = {
> +	{
> +		.compatible = "goodix,gt9916",
> +	},

This format is different than its I2C counterpart.

> +	{ },

Nit: same comment with regards to trailing commas.

> +};
> +MODULE_DEVICE_TABLE(of, goodix_berlin_spi_of_match);
> +
> +static const struct spi_device_id goodix_berlin_spi_ids[] = {
> +	{ "gt9916" },
> +	{ },

And here.

> +};
> +MODULE_DEVICE_TABLE(spi, goodix_berlin_spi_ids);
> +
> +static struct spi_driver goodix_berlin_spi_driver = {
> +	.driver = {
> +		.name = "goodix-berlin-spi",
> +		.of_match_table = goodix_berlin_spi_of_match,
> +		.pm = pm_sleep_ptr(&goodix_berlin_pm_ops),
> +	},
> +	.id_table = goodix_berlin_spi_ids,
> +	.probe = goodix_berlin_spi_probe,
> +	.remove = goodix_berlin_spi_remove,
> +};
> +module_spi_driver(goodix_berlin_spi_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Goodix Berlin SPI Touchscreen driver");
> +MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
> 
> -- 
> 2.34.1
> 

Kind regards,
Jeff LaBundy
