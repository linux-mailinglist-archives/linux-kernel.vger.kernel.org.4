Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FA372B5C4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjFLDL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjFLDKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:10:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2061730;
        Sun, 11 Jun 2023 20:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4wH3vqqEsnIytGHa75/5l+8tx9ugHHj2bRUeb5h5oZ5EYRyOmy7YFFtGJWmRnsmnuIbDBBRy6oKF1iohEOEVhV8/cnEFran3/J59Rfqt5TXlofRt+eALpHC3F4mjeKdOpWpdprJA7meNR8xCAubBGhMvnbNGwUhuN1xS8XYNTcSd0tEGSmGz5dGE4StklanRmttYCQxLaGV500BfZJYr7aNOg0AetypDvciISjyD2UXA0DsAD4qvdft3CMsVp5/Hhny2of9pJUyp/9sJVROxnz7UELT3YCvPmbUHq3OCTEF2thWTjQELyI18ZABNtrpOPoBsvUmlGTiySrcWig+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVJTx+fjiFGpzllsNLnnWS63Pb+XxmTyuWNx665jsLw=;
 b=IWFnSELr4eEvLrbLoeBKuZ0Uat/u01mmFzReSYvMLjhaRHpZlnKtOqh3D6DO/h78EIl12qEFtkNL7nDUULfPcxagR/z0fWjSVnJSd/yxNToqUuQE7rnJ/b6J8B24Qjny6lQorhTkET2rSczWKiJQbyNmSLQ1/Q7E/EpoIarWCW9VplR9P2QuoRYPzwMkuS5YF8vv3qktNlhrmedDwIRSFqkIMSkSBLjXRQCFqHCvY670ofw++NSJCarEbqXZdicDsSTP5wXBHkRCSPSWhBGLyFDQ3LyaEUIoFrrVl/9Pz+cj2ALt/lJzb27s1UWeATLLtAE1BWSQHC2E5vxDICuMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVJTx+fjiFGpzllsNLnnWS63Pb+XxmTyuWNx665jsLw=;
 b=fHTQN+XXp/XlcDA3CLwheFtNSz0nc68LGWYNbsoxn5m91FOMOg3iECyNnFEY6H5XYvQ6RsmqroMckvYam8fTEm29MEh8sOqEgqHi5ijSlPjLEJELPjojXnoPB+IAQRhOgg2IOwxccsMNhNCjNAPyk13HG3ws1C5QCPvv3AQNmKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH0PR08MB7700.namprd08.prod.outlook.com
 (2603:10b6:510:db::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 03:09:09 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ca3a:84ac:381c:1506]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ca3a:84ac:381c:1506%4]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 03:09:09 +0000
Date:   Sun, 11 Jun 2023 22:09:03 -0500
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
Subject: Re: [PATCH RFC 3/4] input: touchscreen: add I2C support for Goodix
 Berlin Touchscreen IC
Message-ID: <ZIaMT0ALwAoasSvu@nixie71>
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v1-3-4a0741b8aefd@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v1-3-4a0741b8aefd@linaro.org>
X-ClientProxiedBy: SN6PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:805:66::29) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH0PR08MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a3e4c8-3aea-4380-a611-08db6af26394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EuAW6RPrM3HNWzOCoAeiFQt12mOKJIp2jeE50Lyd5ozzmZv9/tPKAEFYz1Ap6IXIP/YFl5HMkl0+/+HGCkVOiKrh4wUKm38PMzBUJBNH0tF1S72vreLT1f4lkDE7A7WlxdI3v8s78iALwMQnvtQySdAdlH1sJj3xc8023vD2crODmwKyTlV8YGiecGHBcNnIlXEJ+cLZCfiincYduoynncKNgkA/DY9aPbXv3xSMCsn6qmmCwyS5UwQpaZV1HjCTjHKig5iyidzP7dPLBSuC39AIz7p09sm4ng1lOtBO6xJFeIaAIsv1Dg+wnUl+1At7t72WzDpFew8KcMyCrzpGhr6FUY6R6ImTnQEN061J7BEFbgtB1xFCIIAjsz0+E+ifuhir3afuS7t88mybkPLEqXLXrqpAYmaZEXLSkISp8PugqshSCiSLUBMsJhn8y9qlYY/ins2yhSVilQAYqAbA/Ffo60dEYvd5bEo/xEioLKRhkrK8CB2xHPzVuBhPWeFnbmMMU4GRr5D4EhjKn6+VD5QP21uJOcIBooaVRCcipAA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(39830400003)(136003)(366004)(376002)(451199021)(5660300002)(7416002)(66946007)(66556008)(66476007)(4326008)(6916009)(2906002)(316002)(41300700001)(6666004)(54906003)(8676002)(966005)(8936002)(9686003)(186003)(26005)(6512007)(6506007)(83380400001)(33716001)(86362001)(478600001)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RMZzxrddVvkNMyBr8qDLWJemrK02DQaORYD6iXUIIzs9PP9z5kCV+YIeEE9h?=
 =?us-ascii?Q?pRr55zvyjF+lq7nFoscXaU3XIYN4UFUdFhzzZV9OpOFbaG6i9vZ+cmberLx4?=
 =?us-ascii?Q?VTU5Mli0FL9Q+ziTvBeZNGq7H9/Tg1zGN1UaFaPWITdV1QXv0dy3OjISwmvS?=
 =?us-ascii?Q?j55mX4HaRlFYOI9qh287e49vL/jYzsylf2kTkOuJGRe+EpAoBBhGmx+6fvgI?=
 =?us-ascii?Q?Cij86r5EEUxxOC6qsvYE+9hqpeM1wdQkpZljphDpSJs3+IbLdFBCkW72u4jR?=
 =?us-ascii?Q?uTHvx3g7yIElAXMDQukcHfqfEBq4SsqO/WalfuIPGmSvCFn4cTrzbH2qX7Y2?=
 =?us-ascii?Q?NsZgrxZCy+31jwo3gejqVVPA/lDvcCH7Wo9iMbZHDdEEdK5Jsz1XRJVFVz2v?=
 =?us-ascii?Q?49Wo9q3GPHau/cSlSzb4lysZpN53I2lBMzqoAv2K2Iq2yv9vq326JSWUJ27C?=
 =?us-ascii?Q?34RFKDKyGLiXut96tIWVu5CJPiRC/F7GT2k1Idu9fT9kK6ZzlUxzscTXlp7G?=
 =?us-ascii?Q?CQb44Jd/66uISfSlgTzCXhqG5WBff5GSme/q94BBwAMvy11C3WCowYsGRZIP?=
 =?us-ascii?Q?+KF2YK9J7YypG2kfXWvsttufGVocsJAKC2cHuXPrYEKvw6O4rqOr6A7ETZfp?=
 =?us-ascii?Q?RImngUFujOoNUIJCQeMS9yvip9casY3yAT2xPM2RVjiyR3wXj+AcOOTbfrHN?=
 =?us-ascii?Q?2wpPg2mqLJzZW/INoI5SxGq2KnSJvyIvFDZziCXoxkfAdlaXVBv0cZ5ZBhE5?=
 =?us-ascii?Q?0Lo9Z2JeQ06Hrul7frFOzXfFRIA42Zemu6gWYH5FTiux+xU1RTf454+Qblh9?=
 =?us-ascii?Q?YcNdY8wxDF7CyoZgSWcmixp/aNNHw1HasThPiM6f5mUPbbZKWvTkKngBiQ1v?=
 =?us-ascii?Q?GB7idQhpcpIJe1D0zC1ZuPEt1IO3ynN4u65JwTUKqFMtZJxXDauMkAWlTZXy?=
 =?us-ascii?Q?Taifet3tUt+0Zlku6jAppfMqFfyzIk1G+SBYrkG6ZYX37V6fVoXeQggKCI1S?=
 =?us-ascii?Q?oKJylWDVvERV8o+vIqNUeSI0+qP2jV5Ny5mndG2VoL8QrXYupB6DHmkTJ93e?=
 =?us-ascii?Q?ptAvKY3U+gLuCUKpNJfzyZHinepJQaL425oQgbBzWUt7ZAcC0UIBXfYkPcv3?=
 =?us-ascii?Q?2P7EWRB9loxgAXgcQuI8sLTeBqNzqBIJXuXgz4tqzaJSEMhT7tCyNYtKVwy8?=
 =?us-ascii?Q?koCSYiZN9p08UzZ7sGI1R2V1O5ciU1BJaGqygHuh0WJuPL8KZhLIg5qJb9Us?=
 =?us-ascii?Q?6FI33ItI75CN2pkDuV7xXG2AXCCbl93qOZAbOaA66ckwM5LfVK/sReWZPR8F?=
 =?us-ascii?Q?5320BZYsecz6ggo7p8yFtVJr6e3lGK5PGrzLVL7iF7PRa1ErIENI8NoZG9DE?=
 =?us-ascii?Q?wSsr7atTxKzhwhJ8iCgJMFr9bj7dGX6PZfPLKCCRw0q8uXq4osZRuOWkMOMB?=
 =?us-ascii?Q?F74AwgHDw8Pv2O2whlRhRd9nlOeHI2aczIfvt1qr8y9KJA1OQfGAZGkDGTQk?=
 =?us-ascii?Q?klyj1kQWGQqqfcZ/pHDFo32not9ipPjYjk6M7wvxXbx5XgENmFMjUirXTRyi?=
 =?us-ascii?Q?PnK8x1LXGRrGRSNcdbaT5rDEkJyIGKRFVeVRBhbu?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a3e4c8-3aea-4380-a611-08db6af26394
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 03:09:09.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FA7Xpc06mC3vSLi039gGNM+HY9sIQBhU8c3J54hpFFvYOpXl/obqgUNo6JnFJ7nHxvV6ErEpElPyOe1babWMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB7700
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Excellent work; just a few nits on this particular instance.

On Tue, Jun 06, 2023 at 04:31:58PM +0200, Neil Armstrong wrote:
> Add initial support for the new Goodix "Berlin" touchscreen ICs
> over the I2C interface.
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
>  drivers/input/touchscreen/Kconfig             | 14 +++++
>  drivers/input/touchscreen/Makefile            |  1 +
>  drivers/input/touchscreen/goodix_berlin_i2c.c | 76 +++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 1a6f6f6da991..da6d5d75c42d 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -421,6 +421,20 @@ config TOUCHSCREEN_GOODIX_BERLIN_CORE
>  	depends on REGMAP
>  	tristate
>  
> +config TOUCHSCREEN_GOODIX_BERLIN_I2C
> +	tristate "Goodix Berlin I2C touchscreen"
> +	depends on I2C
> +	depends on REGMAP_I2C

As you already depend upon REGMAP, I think you can simply select REGMAP_I2C
here instead of depending upon it as well.

> +	select TOUCHSCREEN_GOODIX_BERLIN_CORE
> +	help
> +	  Say Y here if you have the a touchscreen connected to your
> +	  system using the Goodix Berlin IC connection via I2C.

This language was a bit of a tongue-twister; perhaps it is better to say
"...if you have a Goodix Berlin IC connected to your system via I2C."

> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called goodix_berlin_i2c.
> +
>  config TOUCHSCREEN_HIDEEP
>  	tristate "HiDeep Touch IC"
>  	depends on I2C
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 29cdb042e104..921a2da0c2be 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
>  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)	+= goodix_berlin_core.o
> +obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C)	+= goodix_berlin_i2c.o
>  obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
>  obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
>  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
> diff --git a/drivers/input/touchscreen/goodix_berlin_i2c.c b/drivers/input/touchscreen/goodix_berlin_i2c.c
> new file mode 100644
> index 000000000000..fc32b8077287
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix_berlin_i2c.c
> @@ -0,0 +1,76 @@
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
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <asm/unaligned.h>

This last include does not seem to provide anything.

> +
> +#include "goodix_berlin.h"
> +
> +#define I2C_MAX_TRANSFER_SIZE		256
> +
> +static const struct regmap_config goodix_berlin_i2c_regmap_conf = {
> +	.reg_bits = 32,
> +	.val_bits = 8,
> +	.max_raw_read = I2C_MAX_TRANSFER_SIZE,
> +	.max_raw_write = I2C_MAX_TRANSFER_SIZE,
> +};
> +
> +static const struct input_id goodix_berlin_i2c_input_id = {
> +	.bustype = BUS_I2C,
> +	.vendor = 0x0416,
> +	.product = 0x1001,
> +};
> +
> +static int goodix_berlin_i2c_probe(struct i2c_client *client)
> +{
> +	struct regmap *map;

'regmap' tends to be more common than simply 'map'.

> +
> +	map = devm_regmap_init_i2c(client, &goodix_berlin_i2c_regmap_conf);
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	return goodix_berlin_probe(&client->dev, client->irq,
> +				   &goodix_berlin_i2c_input_id, map);
> +}
> +
> +static void goodix_berlin_i2c_remove(struct i2c_client *client)
> +{
> +	goodix_berlin_remove(&client->dev);
> +}
> +
> +static const struct i2c_device_id goodix_berlin_i2c_id[] = {
> +	{ "gt9916", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, goodix_berlin_i2c_id);
> +
> +static const struct of_device_id goodix_berlin_i2c_of_match[] = {
> +	{ .compatible = "goodix,gt9916", },
> +	{ },

No need for a trailing comma following the sentinel.

> +};
> +
> +static struct i2c_driver goodix_berlin_i2c_driver = {
> +	.driver = {
> +		.name = "goodix-berlin-i2c",
> +		.of_match_table = goodix_berlin_i2c_of_match,
> +		.pm = pm_sleep_ptr(&goodix_berlin_pm_ops),
> +	},
> +	.probe = goodix_berlin_i2c_probe,
> +	.remove = goodix_berlin_i2c_remove,
> +	.id_table = goodix_berlin_i2c_id,
> +};
> +module_i2c_driver(goodix_berlin_i2c_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Goodix Berlin I2C Touchscreen driver");
> +MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
> 
> -- 
> 2.34.1
> 

Kind regards,
Jeff LaBundy
