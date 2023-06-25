Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582CA73D332
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 21:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjFYTPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 15:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFYTO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 15:14:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3E4A7;
        Sun, 25 Jun 2023 12:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V73OUGoxJL5VSajRlFIaHZwIhmzq9A/UpLmDdHhzt+mHuRIjilzG9DE85RJk8BLgAAIUP7x7ptXVhZNCYEE1FQJisxrnnD791Tkyw+zaowSbiKioRv2TcFnwnqcurHKyAZuuQ/pkUfQUkwCZNS9DqcsFHUlGS6rTxCmQG8Sr5m/r5HJ80r1koSECtBKfR7AHkiEtG3RcrmXNEicW2AgVHgKbKA5wyuEr2jJnYBP6CeDzajVK58HtEJd4EKkt4K8hYaAe6xa/f7JovwPmoPvEP0Taq6h1TmnQM3iBx8uqvMfF116N5d36XKHa4UNXdQlJYV2dIIROLzbWfAJ9Mlplbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOGzZaI/zfE8K9cbUSJLauosnzbW9aI9rDNuxVxHpa0=;
 b=ECSf4R+WFBwf33Tw49d3QWn3m7oA0oEkWYTV2m0HeOTluIe3uUWJRencOkuamhygjjrYeDBeKxtnQmqFmfibDh8/6ak+KNCPpTzs20YbbGFm1MEQVyBFmM8PCM0scQo5ekFYV5FZtalLgsn/kmuQIltLAIoPOC4kGZuUp5duHT5s17gimxIXeRSRfrRBFN9eIC93SeGbbJJJ3VRKGOecjW9nKvpdYB/7TspqKNc4jg2S4TltpD5GEQOKjWsWA3LxOyvXxDEEA1s8eSJMf2NQYk+7wcqfsG9MDuavdUO4NWexXmnCDV1uUDYieJ1VbnQH/KPv0VZ04YKafvA2iaWc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOGzZaI/zfE8K9cbUSJLauosnzbW9aI9rDNuxVxHpa0=;
 b=mjYn98vSleymidQwh3PYOs5SV4ZNqH4nEqoTRiRIXzR5RcA+qkFMuOqwixomHmRGr/VPZx26gTFd9awRQDMFMoXu/Lwy5YxvsreBTFgI/VRES3luB6YrgsfUGCW+DzmJNGCdSqQbuUauVuHysDuCOTPxzTlQZbERiL787Y0t72A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DS7PR08MB6942.namprd08.prod.outlook.com
 (2603:10b6:5:3ac::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 19:14:51 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2%6]) with mapi id 15.20.6521.024; Sun, 25 Jun 2023
 19:14:50 +0000
Date:   Sun, 25 Jun 2023 14:14:43 -0500
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
Subject: Re: [PATCH v3 2/4] input: touchscreen: add core support for Goodix
 Berlin Touchscreen IC
Message-ID: <ZJiSIyt1sg8NnPI9@nixie71>
References: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v3-2-f0577cead709@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v3-2-f0577cead709@linaro.org>
X-ClientProxiedBy: DS7PR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:8:56::18) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DS7PR08MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 8574f4b9-fe43-48a8-c975-08db75b072e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSnJ1Y5eN+R9bz4S8RsFxOrezqD6Rm9lTrXcds/rq0CrNfOYFPdOLPoT5BXAiVzewFmbH8rIV8Oouf3eOY2gGlga1rb+yr3pK509sb9u8dE0d3SZGtDcPtSd4gsf9mNnOWbi4QsEJyKojGnVKyE8KtRuyuo0NEpCNQGB1kM4IlQQQeooZTOayEjGdIh8aKP1hQHjMkH4VSbAZvIR8uWWhpnUfUI7zHiFL0QMSq8Bwb5wfck9iXgnKzmugvxTOgJZeQCHvdGQS+84dwytb3WN1/Uhuft6t3xYlQNpsVBPemsQaTHlbWKJxZwBw4uDGhy+JEs4LiyecmQMBHZ2gsOW3gsGj6reuLQDD04EK5QkSOiVDq5Z/UG+k0plY/oWuq41+SlzlDQwxWOw3F5OGC6dSkSA6bp6nejysHeRMuZkPjHwzWDYlKZjG6DwNNxJ+7ILyUOKpkKu/bUvVVGWH1GfSONAAKouumV4/7qyoAfa4pR6fh/yyrqNk2RwAV0AxH9WOuRh/adpXl32YLfa8Q0lrv3tS16GZyaD+qkT8AXQgjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(346002)(366004)(136003)(39830400003)(451199021)(38100700002)(83380400001)(86362001)(478600001)(54906003)(966005)(6486002)(33716001)(6666004)(41300700001)(66476007)(66556008)(66946007)(316002)(8676002)(8936002)(26005)(6512007)(6916009)(4326008)(6506007)(186003)(9686003)(2906002)(30864003)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EjsJx3sUN4ImREpunAvNnI8cl+fqAe/ofAx9jCiR4lV1YZkFASwtAQ9fufUP?=
 =?us-ascii?Q?euhtN7SyvZToROYXaEBAIsc+6n0aLPMg+x0StWOgXRzN1Oe8qKCVAVbMTZ9V?=
 =?us-ascii?Q?CG3yE+3in+XD8eUhQlyzVQv7Hmyli/jMOQ7iegsPiV1I94RrXvT9lewqcl4O?=
 =?us-ascii?Q?J0jJMM6F8PS/HSt5us46LFe83VBbUJaphjQnR6NlE2/Xr5MUzsjhirM4OZtU?=
 =?us-ascii?Q?l/nhcNAXjjPcPZjAIVKftgnikDZfj+jCuhwDCye7jp9um8pewit6pt16Azcw?=
 =?us-ascii?Q?N6lVOXqFTczyJFA/HaNsg7c+7Z+BtsOllLxqSW8H1edzQW0aAGV5T/5K6lrC?=
 =?us-ascii?Q?Yewd+Ss460XAlC5+47eT2OT73JMPf6Cm0+VotWoYbg8YJmyc0arMxojV/lUM?=
 =?us-ascii?Q?8e/GefxmluF1qxrZ77LAEjSLZPaDvn/CSjrpzFMs1kvQICjfi1qYMYvIypuj?=
 =?us-ascii?Q?sfugunwJ+oDMNhXlJXbfMmmQmg9/oTLsh5uReTUdu6ZH8r8pdRDSOmcVjbCb?=
 =?us-ascii?Q?LLnbj4wPmCxkVos52HIjBrG9d7JnfSa2fmZeg6JgGi45bK78xw8k/7uz052L?=
 =?us-ascii?Q?1Lr9APK3hTqreUFn7tur9DtrJcAS9R5Y6t/alPiI0v4TqRTci8CFTLCtuL0C?=
 =?us-ascii?Q?LfG0rmHY7/ffOmc36CbLqyNFbYeq5qyZPohSa5072Bx7NWl8Hpe6cahE1v1B?=
 =?us-ascii?Q?5GzM8QPJJsTk307jUhVixcz+RuhzJDlyqmgo+L5ZYPD6z6ocBC4Ka/LT3hwQ?=
 =?us-ascii?Q?PFUmmFt+w66HMflP4ED1HOv8lFg9ST/5tXf7eJ3zm6JUIqAiNq01l5pixrt/?=
 =?us-ascii?Q?Fdi/KjxrRVREEAITvaNB3+TAIWwuNfVkC6J5/pnmMDY7Zm5WDTzefHyZA3PA?=
 =?us-ascii?Q?qKO3aJoxvNWJWilNHlnkNzqY8Q6FlGdFNkD17XdHb+GX/ak1ns9cusy3Qt9x?=
 =?us-ascii?Q?65O+ugDy5W+VGB+lkbz72mFy0gSxFy0K0uDMOEVyErwdNYXphKtYDADtUXl6?=
 =?us-ascii?Q?VzXzXZ+Ze28ADNsGFj8i7wbmsJgon+3CFZ3YbgObO5Z9+hxc5XOgREOajE5M?=
 =?us-ascii?Q?W7sq0kxL3FcTxymmc0rvm5Bixm4+kYsjdrsIazCYhu6Z5Xr1nAJSAq4fl/Wp?=
 =?us-ascii?Q?ixMkp/rTUppqnbJNggabD9373gwul2fyRlxSsK+oE+qJCKp/YDxynPeDfc5J?=
 =?us-ascii?Q?/X7EmZYAiHaQgt3lRQ0toXiIYW+ZRxMjaTzPNiFdP0SMnWfjhcgxY56DjmRV?=
 =?us-ascii?Q?rYbLnUEiAk3fWdGnFbQErZDSwAMQPrnmCbKpUZUikPPtxipKVPBwf6kBdVik?=
 =?us-ascii?Q?JouYoJ9yH7zoMpNaQFP55OSKwTFN0UANMem0Jop/obeLLTEFGs86WaqX6Ux7?=
 =?us-ascii?Q?T/oG3xNCLk+Ej2F+nqeo9cajNjWJFbpLUJOTlSLeoe8kQfBaFePYjgetJ1Gz?=
 =?us-ascii?Q?H31ocM5242lhqsdrjkq93IK6sqmpdUPIdZ66Dru9egwErhTYrdE0+q+sl9Qi?=
 =?us-ascii?Q?qd4yI+oNGyXnRxHYL0q/i/T8DBKpdCvLVQMUpyXG01pRmU/BPMLH86EyKI2N?=
 =?us-ascii?Q?pqtJQP/lOnC393/vYiccK2nZOcxma8YvUHRnlePu?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8574f4b9-fe43-48a8-c975-08db75b072e5
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 19:14:50.7840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnMRUMPcj9DH7b9xGAUIAraYDo9t/yILQ6wajH3BtEXbV5rmgmmHox/Mij512GJye6m7xNh7SUiE43sEARm7vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR08MB6942
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Jun 22, 2023 at 04:29:00PM +0200, Neil Armstrong wrote:
> Add initial support for the new Goodix "Berlin" touchscreen ICs.
> 
> These touchscreen ICs support SPI, I2C and I3C interface, up to
> 10 finger touch, stylus and gestures events.
> 
> This initial driver is derived from the Goodix goodix_ts_berlin
> available at [1] and [2] and only supports the GT9916 IC
> present on the Qualcomm SM8550 MTP & QRD touch panel.
> 
> The current implementation only supports BerlinD, aka GT9916.
> 
> Support for advanced features like:
> - Firmware & config update
> - Stylus events
> - Gestures events
> - Previous revisions support (BerlinA or BerlinB)
> is not included in current version.
> 
> The current support will work with currently flashed firmware
> and config, and bail out if firmware or config aren't flashed yet.
> 
> [1] https://github.com/goodix/goodix_ts_berlin
> [2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Great work; thank you for the productive discussion. I only had some
minor cosmetic comments this last time; once those are addressed, feel
free to add:

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

>  drivers/input/touchscreen/Kconfig              |   5 +
>  drivers/input/touchscreen/Makefile             |   1 +
>  drivers/input/touchscreen/goodix_berlin.h      | 159 +++++++
>  drivers/input/touchscreen/goodix_berlin_core.c | 584 +++++++++++++++++++++++++
>  4 files changed, 749 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index c2cbd332af1d..1a6f6f6da991 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -416,6 +416,11 @@ config TOUCHSCREEN_GOODIX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called goodix.
>  
> +config TOUCHSCREEN_GOODIX_BERLIN_CORE
> +	depends on GPIOLIB || COMPILE_TEST

My comment seems to have been missed; this driver does not actually depend
on GPIOLIB and the dependency here can be dropped. However, this would leave
the driver to be built only if COMPILE_TEST is set which is obviously not
what we want. Therefore, this line can simply be dropped entirely.

> +	depends on REGMAP

Rather than depending on REGMAP here, you should simply select the appropriate
transport from the I2C or SPI driver (which seems to have been missed in those
patches as well; I will follow up there). In the meantime, this line can just
be dropped.

MFD has several examples of dual I2C/SPI devices that demonstrate the correct
pattern; see any of those for reference.

> +	tristate
> +
>  config TOUCHSCREEN_HIDEEP
>  	tristate "HiDeep Touch IC"
>  	depends on I2C
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 159cd5136fdb..29cdb042e104 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
>  obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
>  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)	+= goodix_berlin_core.o
>  obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
>  obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
>  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
> diff --git a/drivers/input/touchscreen/goodix_berlin.h b/drivers/input/touchscreen/goodix_berlin.h
> new file mode 100644
> index 000000000000..235f44947a28
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix_berlin.h
> @@ -0,0 +1,159 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Goodix Touchscreen Driver
> + * Copyright (C) 2020 - 2021 Goodix, Inc.
> + * Copyright (C) 2023 Linaro Ltd.
> + *
> + * Based on goodix_berlin_berlin driver.
> + */
> +
> +#ifndef __GOODIX_BERLIN_H_
> +#define __GOODIX_BERLIN_H_
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/input.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/sizes.h>
> +
> +#define GOODIX_BERLIN_MAX_TOUCH			10
> +
> +#define GOODIX_BERLIN_NORMAL_RESET_DELAY_MS	100
> +
> +#define GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN	8
> +#define GOODIX_BERLIN_STATUS_OFFSET		0
> +#define GOODIX_BERLIN_REQUEST_TYPE_OFFSET	2
> +
> +#define GOODIX_BERLIN_BYTES_PER_POINT		8
> +#define GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE	2
> +#define GOODIX_BERLIN_COOR_DATA_CHECKSUM_MASK	GENMASK(15, 0)
> +
> +/* Read n finger events */
> +#define GOODIX_BERLIN_IRQ_READ_LEN(n)		(GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN + \
> +						 (GOODIX_BERLIN_BYTES_PER_POINT * (n)) + \
> +						 GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE)
> +
> +#define GOODIX_BERLIN_TOUCH_EVENT		BIT(7)
> +#define GOODIX_BERLIN_REQUEST_EVENT		BIT(6)
> +#define GOODIX_BERLIN_TOUCH_COUNT_MASK		GENMASK(3, 0)
> +
> +#define GOODIX_BERLIN_REQUEST_CODE_RESET	3
> +
> +#define GOODIX_BERLIN_POINT_TYPE_MASK		GENMASK(3, 0)
> +#define GOODIX_BERLIN_POINT_TYPE_STYLUS_HOVER	1
> +#define GOODIX_BERLIN_POINT_TYPE_STYLUS		3
> +
> +#define GOODIX_BERLIN_TOUCH_ID_MASK		GENMASK(7, 4)
> +
> +#define GOODIX_BERLIN_DEV_CONFIRM_VAL		0xAA
> +#define GOODIX_BERLIN_BOOTOPTION_ADDR		0x10000
> +#define GOODIX_BERLIN_FW_VERSION_INFO_ADDR	0x10014
> +
> +#define GOODIX_BERLIN_IC_INFO_MAX_LEN		SZ_1K
> +#define GOODIX_BERLIN_IC_INFO_ADDR		0x10070
> +
> +struct goodix_berlin_fw_version {
> +	u8 rom_pid[6];
> +	u8 rom_vid[3];
> +	u8 rom_vid_reserved;
> +	u8 patch_pid[8];
> +	u8 patch_vid[4];
> +	u8 patch_vid_reserved;
> +	u8 sensor_id;
> +	u8 reserved[2];
> +	__le16 checksum;
> +} __packed;
> +
> +struct goodix_berlin_ic_info_version {
> +	u8 info_customer_id;
> +	u8 info_version_id;
> +	u8 ic_die_id;
> +	u8 ic_version_id;
> +	__le32 config_id;
> +	u8 config_version;
> +	u8 frame_data_customer_id;
> +	u8 frame_data_version_id;
> +	u8 touch_data_customer_id;
> +	u8 touch_data_version_id;
> +	u8 reserved[3];
> +} __packed;
> +
> +struct goodix_berlin_ic_info_feature {
> +	__le16 freqhop_feature;
> +	__le16 calibration_feature;
> +	__le16 gesture_feature;
> +	__le16 side_touch_feature;
> +	__le16 stylus_feature;
> +} __packed;
> +
> +struct goodix_berlin_ic_info_misc {
> +	__le32 cmd_addr;
> +	__le16 cmd_max_len;
> +	__le32 cmd_reply_addr;
> +	__le16 cmd_reply_len;
> +	__le32 fw_state_addr;
> +	__le16 fw_state_len;
> +	__le32 fw_buffer_addr;
> +	__le16 fw_buffer_max_len;
> +	__le32 frame_data_addr;
> +	__le16 frame_data_head_len;
> +	__le16 fw_attr_len;
> +	__le16 fw_log_len;
> +	u8 pack_max_num;
> +	u8 pack_compress_version;
> +	__le16 stylus_struct_len;
> +	__le16 mutual_struct_len;
> +	__le16 self_struct_len;
> +	__le16 noise_struct_len;
> +	__le32 touch_data_addr;
> +	__le16 touch_data_head_len;
> +	__le16 point_struct_len;
> +	__le16 reserved1;
> +	__le16 reserved2;
> +	__le32 mutual_rawdata_addr;
> +	__le32 mutual_diffdata_addr;
> +	__le32 mutual_refdata_addr;
> +	__le32 self_rawdata_addr;
> +	__le32 self_diffdata_addr;
> +	__le32 self_refdata_addr;
> +	__le32 iq_rawdata_addr;
> +	__le32 iq_refdata_addr;
> +	__le32 im_rawdata_addr;
> +	__le16 im_readata_len;
> +	__le32 noise_rawdata_addr;
> +	__le16 noise_rawdata_len;
> +	__le32 stylus_rawdata_addr;
> +	__le16 stylus_rawdata_len;
> +	__le32 noise_data_addr;
> +	__le32 esd_addr;
> +} __packed;
> +
> +struct goodix_berlin_touch_data {
> +	u8 id;
> +	u8 unused;
> +	__le16 x;
> +	__le16 y;
> +	__le16 w;
> +} __packed;
> +
> +struct goodix_berlin_core {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct regulator *avdd;
> +	struct regulator *iovdd;
> +	struct gpio_desc *reset_gpio;
> +	struct touchscreen_properties props;
> +	struct goodix_berlin_fw_version fw_version;
> +	struct input_dev *input_dev;
> +	int irq;
> +
> +	/* Runtime parameters extracted from IC_INFO buffer  */
> +	u32 touch_data_addr;
> +};
> +
> +int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
> +			struct regmap *regmap);
> +
> +extern const struct dev_pm_ops goodix_berlin_pm_ops;
> +
> +#endif
> diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input/touchscreen/goodix_berlin_core.c
> new file mode 100644
> index 000000000000..af3e73bbb3ec
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix_berlin_core.c
> @@ -0,0 +1,584 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Goodix Touchscreen Driver
> + * Copyright (C) 2020 - 2021 Goodix, Inc.
> + * Copyright (C) 2023 Linaro Ltd.
> + *
> + * Based on goodix_ts_berlin driver.
> + */
> +#include <asm/unaligned.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/regmap.h>
> +
> +#include "goodix_berlin.h"
> +
> +/*
> + * Goodix "Berlin" Touchscreen ID driver
> + *
> + * This driver is distinct from goodix.c since hardware interface
> + * is different enough to require a new driver.
> + * None of the register address or data structure are close enough
> + * to the previous generations.
> + *
> + * Currently only handles Multitouch events with already
> + * programmed firmware and "config" for "Revision D" Berlin IC.
> + *
> + * Support is missing for:
> + * - ESD Management
> + * - Firmware update/flashing
> + * - "Config" update/flashing
> + * - Stylus Events
> + * - Gesture Events
> + * - Support for older revisions (A & B)
> + */
> +
> +static bool goodix_berlin_checksum_valid(const u8 *data, int size)
> +{
> +	u32 cal_checksum = 0;
> +	u16 r_checksum;
> +	u32 i;
> +
> +	if (size < GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE)
> +		return false;
> +
> +	for (i = 0; i < size - GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE; i++)
> +		cal_checksum += data[i];
> +
> +	r_checksum = get_unaligned_le16(&data[i]);
> +
> +	return FIELD_GET(GOODIX_BERLIN_COOR_DATA_CHECKSUM_MASK, cal_checksum) == r_checksum;
> +}
> +
> +static bool goodix_berlin_is_dummy_data(struct goodix_berlin_core *cd,
> +					const u8 *data, int size)
> +{
> +	int i;
> +
> +	/*
> +	 * If the device is missing or doesn't respond the buffer
> +	 * could be filled with bus default line state, 0x00 or 0xff,
> +	 * so declare success the first time we encounter neither.
> +	 */
> +	for (i = 0; i < size; i++)
> +		if (data[i] > 0 && data[i] < 0xff)
> +			return false;
> +
> +	return true;
> +}
> +
> +static int goodix_berlin_dev_confirm(struct goodix_berlin_core *cd)
> +{
> +	u8 tx_buf[8], rx_buf[8];
> +	int retry = 3;
> +	int error;
> +
> +	memset(tx_buf, GOODIX_BERLIN_DEV_CONFIRM_VAL, sizeof(tx_buf));
> +	while (retry--) {
> +		error = regmap_raw_write(cd->regmap, GOODIX_BERLIN_BOOTOPTION_ADDR, tx_buf,
> +					 sizeof(tx_buf));
> +		if (error)
> +			return error;
> +
> +		error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_BOOTOPTION_ADDR, rx_buf,
> +					sizeof(rx_buf));
> +		if (error)
> +			return error;
> +
> +		if (!memcmp(tx_buf, rx_buf, sizeof(tx_buf)))
> +			return 0;
> +
> +		usleep_range(5000, 5100);
> +	}
> +
> +	dev_err(cd->dev, "device confirm failed, rx_buf: %*ph\n", 8, rx_buf);
> +
> +	return -EINVAL;
> +}
> +
> +static int goodix_berlin_power_on(struct goodix_berlin_core *cd, bool on)
> +{
> +	int error = 0;
> +
> +	if (on) {
> +		error = regulator_enable(cd->iovdd);
> +		if (error) {
> +			dev_err(cd->dev, "Failed to enable iovdd: %d\n", error);
> +			return error;
> +		}
> +
> +		/* Vendor waits 3ms for IOVDD to settle */
> +		usleep_range(3000, 3100);
> +
> +		error = regulator_enable(cd->avdd);
> +		if (error) {
> +			dev_err(cd->dev, "Failed to enable avdd: %d\n", error);
> +			goto error_avdd_regulator;
> +		}
> +
> +		/* Vendor waits 15ms for IOVDD to settle */
> +		usleep_range(15000, 15100);
> +
> +		gpiod_set_value(cd->reset_gpio, 0);
> +
> +		/* Vendor waits 4ms for Firmware to initialize */
> +		usleep_range(4000, 4100);
> +
> +		error = goodix_berlin_dev_confirm(cd);
> +		if (error)
> +			goto error_dev_confirm;
> +
> +		/* Vendor waits 100ms for Firmware to fully boot */
> +		msleep(GOODIX_BERLIN_NORMAL_RESET_DELAY_MS);
> +
> +		return 0;
> +	}
> +
> +error_dev_confirm:
> +	gpiod_set_value(cd->reset_gpio, 1);

These labels are still confusing in my opinion. Rather than name the label
based on the code that could have gotten us here, it is better for the name
to reflect the action that follows.

How about err_dev_reset and err_iovdd_disable?

> +
> +	regulator_disable(cd->avdd);
> +
> +error_avdd_regulator:
> +	regulator_disable(cd->iovdd);
> +
> +	return error;
> +}
> +
> +static int goodix_berlin_read_version(struct goodix_berlin_core *cd)
> +{
> +	u8 buf[sizeof(struct goodix_berlin_fw_version)];
> +	int error;
> +
> +	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_FW_VERSION_INFO_ADDR, buf, sizeof(buf));
> +	if (error) {
> +		dev_err(cd->dev, "error reading fw version\n");

It's handy to print the return value here as you do elsewhere.

> +		return error;
> +	}
> +
> +	if (!goodix_berlin_checksum_valid(buf, sizeof(buf))) {
> +		dev_err(cd->dev, "invalid fw version: checksum error\n");
> +		return -EINVAL;
> +	}
> +
> +	memcpy(&cd->fw_version, buf, sizeof(cd->fw_version));
> +
> +	return 0;
> +}
> +
> +/* Only extract necessary data for runtime */
> +static int goodix_berlin_convert_ic_info(struct goodix_berlin_core *cd,
> +					 const u8 *data, u16 length)
> +{
> +	struct goodix_berlin_ic_info_misc misc;
> +	unsigned int offset = 0;
> +	u8 param_num;
> +
> +	offset += sizeof(__le16); /* length */
> +	offset += sizeof(struct goodix_berlin_ic_info_version);
> +	offset += sizeof(struct goodix_berlin_ic_info_feature);
> +
> +	/* IC_INFO Parameters, variable width structure */
> +	offset += 4 * sizeof(u8); /* drv_num, sen_num, button_num, force_num */
> +
> +	if (offset >= length)
> +		goto invalid_offset;
> +
> +	param_num = data[offset++]; /* active_scan_rate_num */
> +
> +	offset += param_num * sizeof(__le16);
> +
> +	if (offset >= length)
> +		goto invalid_offset;
> +
> +	param_num = data[offset++]; /* mutual_freq_num*/
> +
> +	offset += param_num * sizeof(__le16);
> +
> +	if (offset >= length)
> +		goto invalid_offset;
> +
> +	param_num = data[offset++]; /* self_tx_freq_num */
> +
> +	offset += param_num * sizeof(__le16);
> +
> +	if (offset >= length)
> +		goto invalid_offset;
> +
> +	param_num = data[offset++]; /* self_rx_freq_num */
> +
> +	offset += param_num * sizeof(__le16);
> +
> +	if (offset >= length)
> +		goto invalid_offset;
> +
> +	param_num = data[offset++]; /* stylus_freq_num */
> +
> +	offset += param_num * sizeof(__le16);
> +
> +	if (offset + sizeof(misc) > length)
> +		goto invalid_offset;
> +
> +	/* goodix_berlin_ic_info_misc */
> +	memcpy(&misc, &data[offset], sizeof(misc));
> +
> +	cd->touch_data_addr = le32_to_cpu(misc.touch_data_addr);
> +
> +	return 0;
> +
> +invalid_offset:
> +	dev_err(cd->dev, "ic_info length is invalid (offset %d length %d)\n",
> +		offset, length);
> +	return -EINVAL;
> +}
> +
> +static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
> +{
> +	u8 afe_data[GOODIX_BERLIN_IC_INFO_MAX_LEN];
> +	__le16 length_raw;
> +	u16 length;
> +	int error;
> +
> +	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
> +				&length_raw, sizeof(length_raw));
> +	if (error) {
> +		dev_info(cd->dev, "failed get ic info length, %d\n", error);
> +		return error;
> +	}
> +
> +	length = le16_to_cpu(length_raw);
> +	if (length >= GOODIX_BERLIN_IC_INFO_MAX_LEN) {
> +		dev_info(cd->dev, "invalid ic info length %d\n", length);
> +		return -EINVAL;
> +	}
> +
> +	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
> +				afe_data, length);
> +	if (error) {
> +		dev_info(cd->dev, "failed get ic info data, %d\n", error);
> +		return error;
> +	}
> +
> +	/* check whether the data is valid (ex. bus default values) */
> +	if (goodix_berlin_is_dummy_data(cd, (const uint8_t *)afe_data, length)) {
> +		dev_err(cd->dev, "fw info data invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!goodix_berlin_checksum_valid((const uint8_t *)afe_data, length)) {
> +		dev_info(cd->dev, "fw info checksum error\n");
> +		return -EINVAL;
> +	}
> +
> +	error = goodix_berlin_convert_ic_info(cd, afe_data, length);
> +	if (error) {
> +		dev_err(cd->dev, "error converting ic info\n");

This function already prints an error message upon failure; consider dropping
one of the two.

> +		return error;
> +	}
> +
> +	/* check some key info */
> +	if (!cd->touch_data_addr) {
> +		dev_err(cd->dev, "touch_data_addr is null\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void goodix_berlin_parse_finger(struct goodix_berlin_core *cd,
> +				       const void *buf, int touch_num)
> +{
> +	const struct goodix_berlin_touch_data *touch_data = buf;
> +	int i;
> +
> +	/* Check for data validity */
> +	for (i = 0; i < touch_num; i++) {
> +		unsigned int id;
> +
> +		id = FIELD_GET(GOODIX_BERLIN_TOUCH_ID_MASK, touch_data[i].id);
> +
> +		if (id >= GOODIX_BERLIN_MAX_TOUCH) {
> +			dev_warn(cd->dev, "invalid finger id %d\n", id);
> +			return;
> +		}
> +	}
> +
> +	/* Report finger touches */
> +	for (i = 0; i < touch_num; i++) {
> +		input_mt_slot(cd->input_dev,
> +			      FIELD_GET(GOODIX_BERLIN_TOUCH_ID_MASK,
> +					touch_data[i].id));
> +		input_mt_report_slot_state(cd->input_dev, MT_TOOL_FINGER, true);
> +
> +		touchscreen_report_pos(cd->input_dev, &cd->props,
> +				       __le16_to_cpu(touch_data[i].x),
> +				       __le16_to_cpu(touch_data[i].y),
> +				       true);
> +		input_report_abs(cd->input_dev, ABS_MT_TOUCH_MAJOR,
> +				 __le16_to_cpu(touch_data[i].w));
> +	}
> +
> +	input_mt_sync_frame(cd->input_dev);
> +	input_sync(cd->input_dev);
> +}
> +
> +static void goodix_berlin_touch_handler(struct goodix_berlin_core *cd,
> +					const void *pre_buf, u32 pre_buf_len)
> +{
> +	static u8 buffer[GOODIX_BERLIN_IRQ_READ_LEN(GOODIX_BERLIN_MAX_TOUCH)];
> +	u8 point_type = 0;
> +	u8 touch_num = 0;
> +	int error = 0;

Nit: some more unnecessary initializations in here. All of this cleaned up
quite nicely however.

> +
> +	/* copy pre-data to buffer */
> +	memcpy(buffer, pre_buf, pre_buf_len);
> +
> +	touch_num = FIELD_GET(GOODIX_BERLIN_TOUCH_COUNT_MASK,
> +			      buffer[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]);
> +
> +	if (touch_num > GOODIX_BERLIN_MAX_TOUCH) {
> +		dev_warn(cd->dev, "invalid touch num %d\n", touch_num);
> +		return;
> +	}
> +
> +	if (touch_num) {
> +		/* read more data if more than 2 touch events */
> +		if (unlikely(touch_num > 2)) {
> +			error = regmap_raw_read(cd->regmap,
> +						cd->touch_data_addr + pre_buf_len,
> +						&buffer[pre_buf_len],
> +						(touch_num - 2) * GOODIX_BERLIN_BYTES_PER_POINT);
> +			if (error) {
> +				dev_err_ratelimited(cd->dev, "failed get touch data\n");

failed to get touch data: %d

(insert the word "to" and print the return value)

> +				return;
> +			}
> +		}
> +
> +		point_type = FIELD_GET(GOODIX_BERLIN_POINT_TYPE_MASK,
> +				       buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN]);
> +
> +		if (point_type == GOODIX_BERLIN_POINT_TYPE_STYLUS ||
> +		    point_type == GOODIX_BERLIN_POINT_TYPE_STYLUS_HOVER) {
> +			dev_warn_once(cd->dev, "Stylus event type not handled\n");
> +			return;
> +		}
> +
> +		if (!goodix_berlin_checksum_valid(&buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN],
> +						  touch_num * GOODIX_BERLIN_BYTES_PER_POINT + 2)) {
> +			dev_dbg(cd->dev, "touch data checksum error\n");
> +			dev_dbg(cd->dev, "data: %*ph\n",
> +				touch_num * GOODIX_BERLIN_BYTES_PER_POINT + 2,
> +				&buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN]);

This case seems worth of a dev_err; the two messages can be combined as well.

> +			return;
> +		}
> +	}
> +
> +	goodix_berlin_parse_finger(cd, &buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN],
> +				   touch_num);
> +}
> +
> +static int goodix_berlin_request_handle_reset(struct goodix_berlin_core *cd)
> +{
> +	gpiod_set_value(cd->reset_gpio, 1);
> +	usleep_range(2000, 2100);
> +	gpiod_set_value(cd->reset_gpio, 0);
> +
> +	msleep(GOODIX_BERLIN_NORMAL_RESET_DELAY_MS);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t goodix_berlin_threadirq_func(int irq, void *data)
> +{
> +	struct goodix_berlin_core *cd = data;
> +	u8 buf[GOODIX_BERLIN_IRQ_READ_LEN(2)];
> +	u8 event_status;
> +	int error;
> +
> +	/* First, read buffer with space for 2 touch events */
> +	error = regmap_raw_read(cd->regmap, cd->touch_data_addr, buf,
> +				GOODIX_BERLIN_IRQ_READ_LEN(2));
> +	if (error) {
> +		dev_err_ratelimited(cd->dev, "failed get event head data\n");

failed to get event head data: %d

(same comment as earlier)

> +		return IRQ_HANDLED;
> +	}
> +
> +	if (buf[GOODIX_BERLIN_STATUS_OFFSET] == 0)
> +		return IRQ_HANDLED;
> +
> +	if (!goodix_berlin_checksum_valid(buf, GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN)) {
> +		dev_warn_ratelimited(cd->dev, "touch head checksum err : %*ph\n",
> +				     GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN, buf);
> +		return IRQ_HANDLED;
> +	}
> +
> +	event_status = buf[GOODIX_BERLIN_STATUS_OFFSET];
> +
> +	if (event_status & GOODIX_BERLIN_TOUCH_EVENT)
> +		goodix_berlin_touch_handler(cd, buf, GOODIX_BERLIN_IRQ_READ_LEN(2));
> +
> +	if (event_status & GOODIX_BERLIN_REQUEST_EVENT) {
> +		switch (buf[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]) {
> +		case GOODIX_BERLIN_REQUEST_CODE_RESET:
> +			goodix_berlin_request_handle_reset(cd);
> +			break;
> +
> +		default:
> +			dev_warn(cd->dev, "unsupported request code 0x%x\n",
> +				 buf[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]);
> +		}
> +	}
> +
> +	/* Clear up status field */
> +	regmap_write(cd->regmap, cd->touch_data_addr, 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int goodix_berlin_input_dev_config(struct goodix_berlin_core *cd,
> +					  const struct input_id *id)
> +{
> +	struct input_dev *input_dev;
> +	int error;
> +
> +	input_dev = devm_input_allocate_device(cd->dev);
> +	if (!input_dev)
> +		return -ENOMEM;
> +
> +	cd->input_dev = input_dev;
> +	input_set_drvdata(input_dev, cd);
> +
> +	input_dev->name = "Goodix Berlin Capacitive TouchScreen";
> +	input_dev->phys = "input/ts";
> +
> +	input_dev->id = *id;
> +
> +	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_X, 0, SZ_64K - 1, 0, 0);
> +	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_Y, 0, SZ_64K - 1, 0, 0);
> +	input_set_abs_params(cd->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +
> +	touchscreen_parse_properties(cd->input_dev, true, &cd->props);
> +
> +	error = input_mt_init_slots(cd->input_dev, GOODIX_BERLIN_MAX_TOUCH,
> +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +	if (error)
> +		return error;
> +
> +	return input_register_device(cd->input_dev);
> +}
> +
> +static int goodix_berlin_pm_suspend(struct device *dev)
> +{
> +	struct goodix_berlin_core *cd = dev_get_drvdata(dev);
> +
> +	disable_irq(cd->irq);
> +
> +	return goodix_berlin_power_on(cd, false);
> +}
> +
> +static int goodix_berlin_pm_resume(struct device *dev)
> +{
> +	struct goodix_berlin_core *cd = dev_get_drvdata(dev);
> +	int error;
> +
> +	error = goodix_berlin_power_on(cd, true);
> +	if (error)
> +		return error;
> +
> +	enable_irq(cd->irq);
> +
> +	return 0;
> +}
> +
> +EXPORT_GPL_SIMPLE_DEV_PM_OPS(goodix_berlin_pm_ops,
> +			     goodix_berlin_pm_suspend,
> +			     goodix_berlin_pm_resume);
> +
> +static void goodix_berlin_power_off(void *data)
> +{
> +	struct goodix_berlin_core *cd = data;
> +
> +	goodix_berlin_power_on(cd, false);
> +}
> +
> +int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
> +			struct regmap *regmap)
> +{
> +	struct goodix_berlin_core *cd;
> +	int error;
> +
> +	if (irq <= 0) {
> +		dev_err(dev, "Missing interrupt number\n");
> +		return -EINVAL;
> +	}
> +
> +	cd = devm_kzalloc(dev, sizeof(*cd), GFP_KERNEL);
> +	if (!cd)
> +		return -ENOMEM;
> +
> +	cd->dev = dev;
> +	cd->regmap = regmap;
> +	cd->irq = irq;
> +
> +	cd->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(cd->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(cd->reset_gpio),
> +				     "Failed to request reset gpio\n");
> +
> +	cd->avdd = devm_regulator_get(dev, "avdd");
> +	if (IS_ERR(cd->avdd))
> +		return dev_err_probe(dev, PTR_ERR(cd->avdd),
> +				     "Failed to request avdd regulator\n");
> +
> +	cd->iovdd = devm_regulator_get(dev, "iovdd");
> +	if (IS_ERR(cd->iovdd))
> +		return dev_err_probe(dev, PTR_ERR(cd->iovdd),
> +				     "Failed to request iovdd regulator\n");
> +
> +	error = goodix_berlin_power_on(cd, true);
> +	if (error) {
> +		dev_err(dev, "failed power on");
> +		return error;
> +	}
> +
> +	error = devm_add_action_or_reset(dev, goodix_berlin_power_off, cd);
> +	if (error)
> +		return error;
> +
> +	error = goodix_berlin_read_version(cd);
> +	if (error) {
> +		dev_err(dev, "failed to get version info");
> +		return error;
> +	}
> +
> +	error = goodix_berlin_get_ic_info(cd);
> +	if (error) {
> +		dev_err(dev, "invalid ic info, abort");
> +		return error;
> +	}
> +
> +	error = goodix_berlin_input_dev_config(cd, id);
> +	if (error) {
> +		dev_err(dev, "failed set input device");
> +		return error;
> +	}
> +
> +	error = devm_request_threaded_irq(dev, irq, NULL,
> +					  goodix_berlin_threadirq_func,
> +					  IRQF_ONESHOT, "goodix-berlin", cd);
> +	if (error) {
> +		dev_err(dev, "request threaded irq failed: %d\n", error);
> +		return error;
> +	}
> +
> +	dev_set_drvdata(dev, cd);
> +
> +	dev_dbg(dev, "Goodix Berlin %s Touchscreen Controller", cd->fw_version.patch_pid);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(goodix_berlin_probe);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Goodix Berlin Core Touchscreen driver");
> +MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
> 
> -- 
> 2.34.1
> 

Kind regards,
Jeff LaBundy
