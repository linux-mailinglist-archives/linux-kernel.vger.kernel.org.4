Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C69667F91
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjALTqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbjALTpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:45:00 -0500
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2061.outbound.protection.outlook.com [40.107.115.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91E7EA;
        Thu, 12 Jan 2023 11:39:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEOWPnIE+M7yp/DjKZnpX2QWs+mCZdrUm2rMbUnUsGt6HulkxhckUkCFIWH851heaMSAX+rC1EhJgtnfYRF4z7vrQSHc1nes3wnkLAUjIuas549mrWQDkX4sG6o13lhPvni6tvNRESqxz401wfw5Af2NQVE2wuNUTvtf8D7i/8g30/vD04qwGNLRBnzXgYn/80zgpZ9+78ITkuI2Pp1BVN4vyNDM/08br77RbDBLumY9oIDdPWpBVboLePdpWfy0KSY5tPudXbeBRqdFNwGIydwP+YsVIxN5Qqx+3acFFwYCIvYId2PONApVTM6MmPEWaoLxSMZqHYXyyKuYgbmWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkfMUdhca+AfMLn3dv79IZpocfk8MhJnJrlPozLgPo0=;
 b=OMWpUAi1678ufR5+V1SIfRBk60Q+GvUZpHB9ueVK0cZN7HbDk2IE5NiY+/mQwsybl67n6IgZD+qi0O3jZQBOJrgAViEfgrMGt7YpFYoINKTcxVND4uXD9wj8sDKB09HqQGxHkNK4zVgDqM/4x9MElhd0S7P0YYOCf2zw6YxGrdFGqCCm7P+4QnJ9YxE6wJTzD7lAsqesa4rMGFM/mKQKyeQNuxse+Oq4kiqzc3JTFnSkv4D1GcsiOuVKJSPqRzn1ZWoAy3fI4GV+SEzOtr/pNBprDIVua0mPCbqCRjhEelLDJsFkmhSjHszCVMstxyWconBuYuUxUmemDeVi5dubPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dimonoff.com; dmarc=pass action=none header.from=dimonoff.com;
 dkim=pass header.d=dimonoff.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dimonoff.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkfMUdhca+AfMLn3dv79IZpocfk8MhJnJrlPozLgPo0=;
 b=hFwqwLVL/fsdfGDkageAnk5iCQG57TOZfu7bTJVbXdv/PEJE0aojKDqXH4HAN6vzDPuAdBXpAgmEPg2szAmRLnOst9lUqDK1UebXek9TZNVodSlB+GU/GBFGr55JCobnIGOp6w4XscRNk8QcksN7JX+HTyQ+Ddf8Q5Y2co08PuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dimonoff.com;
Received: from YQBPR0101MB8925.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:59::21) by YT3PR01MB5230.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:62::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 19:39:02 +0000
Received: from YQBPR0101MB8925.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::8105:e0d:bd2f:7f2a]) by YQBPR0101MB8925.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::8105:e0d:bd2f:7f2a%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 19:39:01 +0000
Date:   Thu, 12 Jan 2023 14:39:01 -0500
From:   Hugo Villeneuve <hvilleneuve@dimonoff.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads7924: add Texas Instruments
 ADS7924 driver
Message-Id: <20230112143901.71543b8d6ff4cff8cf33099e@dimonoff.com>
In-Reply-To: <20230110160124.3853593-2-hugo@hugovil.com>
References: <20230110160124.3853593-1-hugo@hugovil.com>
        <20230110160124.3853593-2-hugo@hugovil.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0291.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::6) To YQBPR0101MB8925.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:59::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB8925:EE_|YT3PR01MB5230:EE_
X-MS-Office365-Filtering-Correlation-Id: db9b99e4-3217-4e89-7d3e-08daf4d4a82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPy/1QVnSZUl55b+xcQnEKtZq1xM8IDmZd8v2HDEutNrZk57Djz6We0uqkI0ShtopJv1uhaPA5BY9IVcBayQsrKY+Qa6J15WWo7V4pHraS8dG5DomC3aAjdJlAXCdb07pZEHuRuuG52ZoGj/E5/1KgGqzYrUgF/mIfgH5n5NkDoD33rmois07RGH5jnMdqPSCStK/Ot+VopBTg/Sar4jfMMi7MoCj4ggWP6tR9dZ++hflaxYhRwMcVONS0ajIWbzLkQNyIyFExf/SSrVUJYDuAj4xnPiU01OQY9Q4GJkLNzy8wIIJTxIF7Z8689t93FFAmx/veAaByeXqyqg7LDIiE/gmQUmorPmYmBp5xCezcv+teLfm0Eo8Wcr3NHdb95XriYWryJWCMiaMI3/MHxXo9f489YIQn9fEH/B/ikvSXpFS3V832Q1U2JPRf01R+py2jUn3qA885WXFDhris4yN1Gt19CamAC0y32dBM1xDRSsMr9tffiqjNWYLc9ueGEMAeZmOaVKDznQ/bQOkxzvhaXnEQHBf7/DcaanS0NKZRct73PRDQUpAK4WhHZtaREMqQnsnmBLPlzPU3MvbuqG8LFN+v6SUufpn4o5RnEHXNr19TDpFXteneroQI71oBE5i5Iq+SsE/NkUkT9EFx45hezO0UAo4kM9Lsakfgry2g5tObVx9wWl1LugTWPjzSbMR2020FsoVA/gdcAP+FjwgxU4TaSo3gDBeav5lRqj8WE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB8925.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(39840400004)(346002)(136003)(451199015)(1076003)(86362001)(2616005)(316002)(8676002)(6916009)(66556008)(66946007)(66476007)(478600001)(186003)(6486002)(966005)(26005)(6512007)(52116002)(6506007)(38350700002)(38100700002)(36756003)(83380400001)(41300700001)(4326008)(30864003)(8936002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjRRYkZUei8vZUNrczRESGliRzdvQWlhbCt4QjVMdVNJcGMrREtseGo1UTVo?=
 =?utf-8?B?UlE4aFFibFFMNld0bllwTG5jZmFoMld4N1FCTnVCR1JHM21HNHJmVm0wSDRT?=
 =?utf-8?B?bTFucHhmdzhoRzFUK1duR3pLQXBKU1ZDcnM1Tk4wUjQzOGlPMmM0SzY0d09p?=
 =?utf-8?B?WEFXQ3BlTUZMR21zSmowZCszb0xKZFFSQXFmQXY2dlhyVFRjMU5HMHlsMUhW?=
 =?utf-8?B?WHlrL1FhL1phajZLM3lXcG1VTE9YWjZEZHpORWN0QThZbnpFVERZNDRtYjdU?=
 =?utf-8?B?d2s5cFNFbHhyNVZZamYwOHQvY3plTUdtWTgrZTQ3Q1NpWWF4UjFmSXJtWGw3?=
 =?utf-8?B?NDZrckxqQzlqcTlsWllYS1pxMzd3SlNDc0dxQnlPdTVZWS9GaEVsS1hlbzdz?=
 =?utf-8?B?ZHIvL2toazFJamplanhwaEV2d3JWbUlhY1lxeG96QzIreEtMMDRydWwwcGJu?=
 =?utf-8?B?VytCdFp3UDFSUnlpbThyc0tWNktiS0FQakVNckNnejJ2SkVqQVhHS0xHcitX?=
 =?utf-8?B?UjFVYURndk9VcS8va0ducmdySTdhdFBNUE8wb0VlV0RRZy9mK20xMkFabFlC?=
 =?utf-8?B?R0g5MDFpbUVYZmw1QWVoQnZYRHRFRkszdEQyUy8zcXd5dDVVQTVPT2c5aXJ4?=
 =?utf-8?B?ZW5TNkFycWdhMUFtaE42bmZYZW9QL2QwZ0hHKzlZRU5iMlNKaFA5bTdzMWc2?=
 =?utf-8?B?QTRvcVc4KzJvdnhyKzBabXpKcWNxUVlBelRnYmRZVkVXaExTeTFYbUVWdWE4?=
 =?utf-8?B?R3JpTDM5YVdXY2VHb2NtdHNtRWFTL1JEelkrcTl2OWk1azBxNHJSVlc1ZnJ5?=
 =?utf-8?B?SThYeGgxL21KeDFMc2daK2RVV3VRSll5ajh5VXZORWNsNisvMExNaWthVS93?=
 =?utf-8?B?V2tMdS9HOGNweVZPQkR4Q2xqcVc3TzB4MTlhNjM3SStuenlGRXBlZS9jNGRs?=
 =?utf-8?B?N2JJMmNZeFlmSnVEWnlaT3dTaUtGN0pISFg3MDRJUG1qa2FVb1RCbnNaNzRz?=
 =?utf-8?B?eVl4NUpvOFRNU1A0QWpoZFB2MDh4Vm5JZkxXd3BZbXdScllHK2F6UUY5U0Vj?=
 =?utf-8?B?VmtzanIzL00yVzNRK0dIRi9PVVJiMGxkUTdraWhjZkJvU09Wb1BaSytNc0Er?=
 =?utf-8?B?RVZlY1EwRzlOYjFpNnNZTFZpWGFGYkNNcy9aNk1BT1FYSG4xY1dpMUhueHQy?=
 =?utf-8?B?UkxOM3BiR2VsNGp0WkI4SFUzMGlkZngwaFlOTDgwVUZwSUd0RGlWdjdVTVoz?=
 =?utf-8?B?YmxCWkY0RVlXQmNwUEtWQmw1U3RaT3o1WVJLKzNtRVRDdEdMOWlKWVFhMmlW?=
 =?utf-8?B?amtvQXFHNUtWVUV3b2QzWEJoMEJ1MXJ3aWp0di9yOThNOHlHZU1lSkJYOFh1?=
 =?utf-8?B?WGNVQndJQUlnekRSekpPMXVKN1NFYkJoMytCTHZHTVhRY3I1QW1qVWZycFdS?=
 =?utf-8?B?REtuTTJvWVFTV3BDRW9zWm9IUEJWZ3VLSjc2bC80RkQ1aURNbCtkSmRCdmVF?=
 =?utf-8?B?ZjVkTlRiSHB5ejVzUEtVa0JjckFTZWh6bDc4Uzc4dFkrcjFGeXZBbTJPalRi?=
 =?utf-8?B?SmVQblBneGNuazRVYjhLRVRDbkREaHZlMkNiTm1VcmhiRy96Y3ZTdWc2TzN4?=
 =?utf-8?B?WUNqUGxhS1ZMWk9uZnlqWHdQWXNNUFVWeFVNeXlGeCtTWkF4MTlETk00dEpH?=
 =?utf-8?B?WXQxd3E1T1dYR2JyQTgzdXErVDBZMzg1MXRLL1lxdG5jM3FlRUJuMm5DVEtP?=
 =?utf-8?B?Q3NJTE4xWkJFd0NUdWYwb2hUWnBJOVJoRU5kVmZkNEVLUzJST3pEbERCSzBQ?=
 =?utf-8?B?UFRiaU5Famh3RVN2YnF5RVdTSGpETWJ0bDBlSzZEaVpZNW9RMnpacE1WTGxS?=
 =?utf-8?B?NndJMjJMK0p4cHZwbFduTXNFazdob1FFdjlrM3J2SU5UZGlLSnJzQ09pVkIr?=
 =?utf-8?B?ZnZOeXE2QmVSYzBnbFNBVzBGbzY1YlorNHVqU1Bva3BlTGtSZk0reCtXYTRu?=
 =?utf-8?B?UlpCUHVDOVA0dm5qN3ZKdUVUcG1hK1VBRlZPenB2T3NVbjNZZW9rWmZPTkdk?=
 =?utf-8?B?b1lMYmh6dnB6Witzd2h0aElzRzhhNENVTU5tdUtjcDdrQ1JoZldJSXlJOTV0?=
 =?utf-8?B?WGZjVWdIVW5ML3BlaURMcUhzc3BpbWhOb2x0UXQrV0dUcG00V3Z2Tk91WS9H?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: dimonoff.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9b99e4-3217-4e89-7d3e-08daf4d4a82b
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB8925.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 19:39:01.9106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c4063547-e5e6-4866-a386-58c3965da102
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z51mfb7NfPEVj2QYT7FjiNXn5B+joU1jPluFfq0ToJKcUxsU0ITuS+Hw3YyYCNHw2jw7V6u+Tsc58hoqGVMZucwZic8uFS0p9G3AdNWequY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5230
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 11:01:23 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The Texas Instruments ADS7924 is a 4 channels, 12-bit analog to
> digital converter (ADC) with an I2C interface.
> 
> Datasheet: https://www.ti.com/lit/gpn/ads7924
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  MAINTAINERS                  |   7 +
>  drivers/iio/adc/Kconfig      |  11 +
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ti-ads7924.c | 492 +++++++++++++++++++++++++++++++++++
>  4 files changed, 511 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads7924.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ff472ca1244..94eb68076f0c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20776,6 +20776,13 @@ M:	Robert Richter <rric@kernel.org>
>  S:	Odd Fixes
>  F:	drivers/gpio/gpio-thunderx.c
>  
> +TI ADS7924 ADC DRIVER
> +M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> +F:	drivers/iio/adc/ti-ads7924.c
> +
>  TI AM437X VPFE DRIVER
>  M:	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7d6e74189a2d..99468c64daf9 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1208,6 +1208,17 @@ config TI_ADS1015
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-ads1015.
>  
> +config TI_ADS7924
> +	tristate "Texas Instruments ADS7924 ADC"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for Texas Instruments ADS7924
> +	  4 channels, 12-bit I2C ADC chip.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-ads7924.
> +
>  config TI_ADS7950
>  	tristate "Texas Instruments ADS7950 ADC driver"
>  	depends on SPI && GPIOLIB
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 6e08415c3f3a..1e5bdf47a091 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -107,6 +107,7 @@ obj-$(CONFIG_TI_ADC108S102) += ti-adc108s102.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>  obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
> +obj-$(CONFIG_TI_ADS7924) += ti-ads7924.o
>  obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
>  obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
> diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
> new file mode 100644
> index 000000000000..8384f3451236
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads7924.c
> @@ -0,0 +1,492 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IIO driver for Texas Instruments ADS7924 ADC, 12-bit, 4-Channels, I2C
> + *
> + * iio/adc/ti-ads7924.c
> + * Author: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> + * Copyright 2022 DimOnOff
> + *
> + * based on iio/adc/ti-ads1015.c
> + * Copyright (c) 2016, Intel Corporation.
> + *
> + * Datasheet: https://www.ti.com/lit/gpn/ads7924
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +
> +#define ADS7924_CHANNELS	 4
> +#define ADS7924_BITS		12
> +#define ADS7924_DATA_SHIFT	 4
> +
> +/* Registers. */
> +#define ADS7924_MODECNTRL_REG	0x00
> +#define ADS7924_INTCNTRL_REG	0x01
> +#define ADS7924_DATA0_U_REG	0x02
> +#define ADS7924_DATA0_L_REG	0x03
> +#define ADS7924_DATA1_U_REG	0x04
> +#define ADS7924_DATA1_L_REG	0x05
> +#define ADS7924_DATA2_U_REG	0x06
> +#define ADS7924_DATA2_L_REG	0x07
> +#define ADS7924_DATA3_U_REG	0x08
> +#define ADS7924_DATA3_L_REG	0x09
> +#define ADS7924_ULR0_REG	0x0A
> +#define ADS7924_LLR0_REG	0x0B
> +#define ADS7924_ULR1_REG	0x0C
> +#define ADS7924_LLR1_REG	0x0D
> +#define ADS7924_ULR2_REG	0x0E
> +#define ADS7924_LLR2_REG	0x0F
> +#define ADS7924_ULR3_REG	0x10
> +#define ADS7924_LLR3_REG	0x11
> +#define ADS7924_INTCONFIG_REG	0x12
> +#define ADS7924_SLPCONFIG_REG	0x13
> +#define ADS7924_ACQCONFIG_REG	0x14
> +#define ADS7924_PWRCONFIG_REG	0x15
> +#define ADS7924_RESET_REG	0x16
> +
> +/*
> + * Register address INC bit: when set to '1', the register address is
> + * automatically incremented after every register read which allows convenient
> + * reading of multiple registers. Set INC to '0' when reading a single register.
> + */
> +#define ADS7924_AUTO_INCREMENT_BIT	BIT(7)
> +
> +#define ADS7924_MODECNTRL_MODE_MASK	GENMASK(7, 2)
> +
> +#define ADS7924_MODECNTRL_SEL_MASK	GENMASK(1, 0)
> +
> +#define ADS7924_CFG_INTPOL_BIT		1
> +#define ADS7924_CFG_INTTRIG_BIT		0
> +
> +#define ADS7924_CFG_INTPOL_MASK		BIT(ADS7924_CFG_INTPOL_BIT)
> +#define ADS7924_CFG_INTTRIG_MASK	BIT(ADS7924_CFG_INTTRIG_BIT)
> +
> +/* Interrupt pin polarity */
> +#define ADS7924_CFG_INTPOL_LOW		0
> +#define ADS7924_CFG_INTPOL_HIGH		1
> +
> +/* Interrupt pin signaling */
> +#define ADS7924_CFG_INTTRIG_LEVEL	0
> +#define ADS7924_CFG_INTTRIG_EDGE	1
> +
> +/* Mode control values */
> +#define ADS7924_MODECNTRL_IDLE			0x00
> +#define ADS7924_MODECNTRL_AWAKE			0x20
> +#define ADS7924_MODECNTRL_MANUAL_SINGLE		0x30
> +#define ADS7924_MODECNTRL_MANUAL_SCAN		0x32
> +#define ADS7924_MODECNTRL_AUTO_SINGLE		0x31
> +#define ADS7924_MODECNTRL_AUTO_SCAN		0x33
> +#define ADS7924_MODECNTRL_AUTO_SINGLE_SLEEP	0x39
> +#define ADS7924_MODECNTRL_AUTO_SCAN_SLEEP	0x3B
> +#define ADS7924_MODECNTRL_AUTO_BURST_SLEEP	0x3F
> +
> +#define ADS7924_ACQTIME_MASK	GENMASK(4, 0)
> +
> +#define ADS7924_PWRUPTIME_MASK	GENMASK(4, 0)
> +
> +/*
> + * The power-up time is allowed to elapse whenever the device has been shutdown
> + * in idle mode. Power-up time can allow external circuits, such as an
> + * operational amplifier, between the MUXOUT and ADCIN pins to turn on.
> + * The nominal time programmed by the PUTIME[4:0] register bits is given by:
> + *     t PU = PWRUPTIME[4:0] × 2 μs
> + * If a power-up time is not required, set the bits to '0' to effectively bypass.
> + */
> +#define ADS7924_PWRUPTIME_US 0 /* Bypass (0us). */
> +
> +/*
> + * Acquisition Time according to ACQTIME[4:0] register bits.
> + * The Acquisition Time is given by:
> + *     t ACQ = (ACQTIME[4:0] × 2 μs) + 6 μs
> + * Using default value of 0 for ACQTIME[4:0] results in a minimum acquisition
> + * time of 6us.
> + */
> +#define ADS7924_ACQTIME_US 6
> +
> +/* The conversion time is always 4μs and cannot be programmed by the user. */
> +#define ADS7924_CONVTIME_US 4
> +
> +#define ADS7924_TOTAL_CONVTIME_US (ADS7924_PWRUPTIME_US + ADS7924_ACQTIME_US + \
> +				   ADS7924_CONVTIME_US)
> +
> +#define ADS7924_SLEEP_DELAY_MS		2000
> +
> +#define ADS7924_V_CHAN(_chan, _addr) {				\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = _chan,					\
> +	.address = _addr,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), 		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.datasheet_name = "AIN"#_chan,				\
> +}
> +
> +struct ads7924_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct regulator *vref_reg;
> +
> +	/* GPIO descriptor for device hard-reset pin. */
> +	struct gpio_desc *reset_gpio;
> +
> +	/*
> +	 * Protects ADC ops, e.g: concurrent sysfs/buffered
> +	 * data reads, configuration updates
> +	 */
> +	struct mutex lock;
> +
> +	/*
> +	 * Set to true when the ADC is switched to the continuous-conversion
> +	 * mode and exits from a power-down state. This flag is used to avoid
> +	 * getting the stale result from the conversion register.
> +	 */
> +	bool conv_invalid;
> +};
> +
> +static bool ads7924_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case ADS7924_MODECNTRL_REG:
> +	case ADS7924_INTCNTRL_REG:
> +	case ADS7924_ULR0_REG:
> +	case ADS7924_LLR0_REG:
> +	case ADS7924_ULR1_REG:
> +	case ADS7924_LLR1_REG:
> +	case ADS7924_ULR2_REG:
> +	case ADS7924_LLR2_REG:
> +	case ADS7924_ULR3_REG:
> +	case ADS7924_LLR3_REG:
> +	case ADS7924_INTCONFIG_REG:
> +	case ADS7924_SLPCONFIG_REG:
> +	case ADS7924_ACQCONFIG_REG:
> +	case ADS7924_PWRCONFIG_REG:
> +	case ADS7924_RESET_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config ads7924_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = ADS7924_RESET_REG,
> +	.writeable_reg = ads7924_is_writeable_reg,
> +};
> +
> +static const struct iio_chan_spec ads7924_channels[] = {
> +	ADS7924_V_CHAN(0, ADS7924_DATA0_U_REG),
> +	ADS7924_V_CHAN(1, ADS7924_DATA1_U_REG),
> +	ADS7924_V_CHAN(2, ADS7924_DATA2_U_REG),
> +	ADS7924_V_CHAN(3, ADS7924_DATA3_U_REG),
> +};
> +
> +static
> +int ads7924_get_adc_result(struct ads7924_data *data,
> +			   struct iio_chan_spec const *chan, int *val)
> +{
> +	int ret;
> +	__be16 be_val;
> +
> +	if (chan->channel < 0 || chan->channel >= ADS7924_CHANNELS)
> +		return -EINVAL;
> +
> +	if (data->conv_invalid) {
> +		int conv_time;
> +
> +		conv_time = ADS7924_TOTAL_CONVTIME_US;
> +		/* Allow 10% for internal clock inaccuracy. */
> +		conv_time += conv_time / 10;
> +		usleep_range(conv_time, conv_time + 1);
> +		data->conv_invalid = false;
> +	}
> +
> +	ret = regmap_raw_read(data->regmap, ADS7924_AUTO_INCREMENT_BIT |
> +			      chan->address, &be_val, sizeof(be_val));
> +	if (ret)
> +		return ret;
> +
> +	*val = be16_to_cpu(be_val);
> +	*val = *val >> ADS7924_DATA_SHIFT;
> +
> +	return ret;
> +}
> +
> +static int ads7924_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	int ret, vref_uv;
> +	struct ads7924_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		mutex_lock(&data->lock);
> +		ret = ads7924_get_adc_result(data, chan, val);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			dev_dbg(data->dev, "%s error1\n", __func__);
> +		else
> +			ret = IIO_VAL_INT;
> +		break;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		vref_uv = regulator_get_voltage(data->vref_reg);
> +		if (vref_uv < 0) {
> +			/* dummy regulator "get_voltage" returns -EINVAL */
> +			ret = -EINVAL;
> +		} else {
> +			*val =  vref_uv / 1000; /* Convert reg voltage to mV */
> +			*val2 = ADS7924_BITS;
> +			ret = IIO_VAL_FRACTIONAL_LOG2;
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_info ads7924_info = {
> +	.read_raw	= ads7924_read_raw,
> +};
> +
> +static int ads7924_get_channels_config(struct i2c_client *client,
> +				       struct iio_dev *indio_dev)
> +{
> +	struct ads7924_data *priv = iio_priv(indio_dev);
> +	struct device *dev = priv->dev;
> +	struct fwnode_handle *node;
> +	int num_channels = 0;
> +
> +	device_for_each_child_node(dev, node) {
> +		u32 pval;
> +		unsigned int channel;
> +
> +		if (fwnode_property_read_u32(node, "reg", &pval)) {
> +			dev_err(dev, "invalid reg on %pfw\n", node);
> +			continue;
> +		}
> +
> +		channel = pval;
> +		if (channel >= ADS7924_CHANNELS) {
> +			dev_err(dev, "invalid channel index %d on %pfw\n",
> +				channel, node);
> +			continue;
> +		}
> +
> +		num_channels++;
> +	}
> +
> +	if (num_channels > 0) {
> +		dev_dbg(dev, "found %d ADC channels\n", num_channels);
> +		return 0;
> +	} else {
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ads7924_set_conv_mode(struct ads7924_data *data, int mode)
> +{
> +	int ret;
> +	unsigned int mode_field;
> +	struct device *dev = data->dev;
> +
> +	/*
> +	 * When switching between modes, be sure to first select the Awake mode
> +	 * and then switch to the desired mode. This procedure ensures the
> +	 * internal control logic is properly synchronized.
> +	 */
> +	if (mode != ADS7924_MODECNTRL_IDLE) {
> +		mode_field = FIELD_PREP(ADS7924_MODECNTRL_MODE_MASK,
> +					ADS7924_MODECNTRL_AWAKE);
> +
> +		ret = regmap_update_bits(data->regmap, ADS7924_MODECNTRL_REG,
> +					 ADS7924_MODECNTRL_MODE_MASK,
> +					 mode_field);
> +		if (ret) {
> +			dev_warn(dev, "failed to set awake mode (%pe)\n",
> +				 ERR_PTR(ret));
> +			return ret;
> +		}
> +	}
> +
> +	mode_field = FIELD_PREP(ADS7924_MODECNTRL_MODE_MASK, mode);
> +
> +	ret = regmap_update_bits(data->regmap, ADS7924_MODECNTRL_REG,
> +				 ADS7924_MODECNTRL_MODE_MASK, mode_field);
> +	if (ret)
> +		dev_warn(dev, "failed to set mode %d (%pe)\n", mode,
> +			 ERR_PTR(ret));
> +
> +	return ret;
> +}
> +
> +static int ads7924_reset(struct iio_dev *indio_dev)
> +{
> +	struct ads7924_data *data = iio_priv(indio_dev);
> +
> +	if (data->reset_gpio) {
> +		gpiod_set_value(data->reset_gpio, 1); /* Assert. */
> +		/* Educated guess: assert time not specified in datasheet... */
> +		mdelay(100);
> +		gpiod_set_value(data->reset_gpio, 0); /* Deassert. */
> +	} else {
> +		int ret;
> +
> +		/*
> +		 * A write of 10101010 to this register will generate a
> +		 * software reset of the ADS7924.
> +		 */
> +		ret = regmap_write(data->regmap, ADS7924_RESET_REG, 0b10101010);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +};
> +
> +static void ads7924_reg_disable(void *data)
> +{
> +	regulator_disable(data);
> +}
> +
> +static void ads7924_set_idle_mode(void *data)
> +{
> +	ads7924_set_conv_mode(data, ADS7924_MODECNTRL_IDLE);
> +}
> +
> +static int ads7924_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ads7924_data *data;
> +	struct device *dev = &client->dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;

Would it be a good idea to also use dev_err_probe() here?

Hugo.


> +
> +	data = iio_priv(indio_dev);
> +
> +	data->dev = dev;
> +
> +	/* Initialize the reset GPIO as output with an initial value of 0. */
> +	data->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(data->reset_gpio),
> +				     "failed to get request reset GPIO\n");
> +
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name = "ads7924";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	indio_dev->channels = ads7924_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads7924_channels);
> +	indio_dev->info = &ads7924_info;
> +
> +	ret = ads7924_get_channels_config(client, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "failed to get channels configuration\n");
> +
> +	data->regmap = devm_regmap_init_i2c(client, &ads7924_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "failed to init regmap\n");
> +
> +	data->vref_reg = devm_regulator_get(dev, "vref");
> +	if (IS_ERR(data->vref_reg))
> +		return dev_err_probe(dev, PTR_ERR(data->vref_reg),
> +				     "failed to get vref regulator\n");
> +
> +	ret = regulator_enable(data->vref_reg);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to enable regulator\n");
> +
> +	ret = devm_add_action_or_reset(dev, ads7924_reg_disable, data->vref_reg);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to add regulator disable action\n");
> +
> +	ret = ads7924_reset(indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "failed to reset device\n");
> +
> +	ret = devm_add_action_or_reset(dev, ads7924_set_idle_mode, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to add idle mode action\n");
> +
> +	ret = ads7924_set_conv_mode(data, ADS7924_MODECNTRL_AUTO_SCAN);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to set conversion mode\n");
> +
> +	/* Use minimum signal acquire time. */
> +	ret = regmap_update_bits(data->regmap, ADS7924_ACQCONFIG_REG,
> +				 ADS7924_ACQTIME_MASK,
> +				 FIELD_PREP(ADS7924_ACQTIME_MASK, 0));
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "failed to configure signal acquire time\n");
> +
> +	/* Disable power-up time. */
> +	ret = regmap_update_bits(data->regmap, ADS7924_PWRCONFIG_REG,
> +				 ADS7924_PWRUPTIME_MASK,
> +				 FIELD_PREP(ADS7924_PWRUPTIME_MASK, 0));
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "failed to configure power-up time\n");
> +
> +	data->conv_invalid = true;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "failed to register IIO device\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ads7924_id[] = {
> +	{ "ads7924", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ads7924_id);
> +
> +static const struct of_device_id ads7924_of_match[] = {
> +	{ .compatible = "ti,ads7924", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ads7924_of_match);
> +
> +static struct i2c_driver ads7924_driver = {
> +	.driver = {
> +		.name = "ads7924",
> +		.of_match_table = ads7924_of_match,
> +	},
> +	.probe_new	= ads7924_probe,
> +	.id_table	= ads7924_id,
> +};
> +
> +module_i2c_driver(ads7924_driver);
> +
> +MODULE_AUTHOR("Hugo Villeneuve <hvilleneuve@dimonoff.com>");
> +MODULE_DESCRIPTION("Texas Instruments ADS7924 ADC I2C driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.30.2
> 
> 


-- 
Hugo Villeneuve <hvilleneuve@dimonoff.com>
