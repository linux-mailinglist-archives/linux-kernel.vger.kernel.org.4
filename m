Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8513E73D339
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 21:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjFYTSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 15:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFYTR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 15:17:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEF8A7;
        Sun, 25 Jun 2023 12:17:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE/2EZIojlgaaOKSasXyZONwkpB6bSGkV39HccEwXrqmHJ/6DqA7GCYYSC9I7l/sijtChWKBWnqp4L7SmLlc7xHJD552XYSVXefGsnKF6nZPrLJ2wuCr39YnzIqm9E9XN5Nj31d7USbYenOdt/XT0MnkZXfMDA6hET4GGu44jNzjBWAxGETIKmsgtJBdYTESlOLZ+bpVb+qfenjNYNbRLFVC+u7tGeETD8DAzlJLluJ6J4I8zeX9soi1DDECiQMu5v4W9wmy6pUr7plI5yQMHd9QzTSVfTC7iWqmcQgFENkq2MKnaBUCZx2y85FLRPR0P157og3qvanlSvqTeUvxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttYjukgHegKyXkiBW8EStTur663LQaCM7pmcktGMN3k=;
 b=OzytsV8nNHova9q/bCJ6qfhltOf+ezSNj9nRy49ePrauqzuELNGPF2QYrDaymBL1cBZfE20a8dTG8mwAg0aTNOPznht5nrX+blAm29L+/0/sz6LaiGWFoM3N/W2AbTNbB5pJtnsstVCP9eDbOZzaAaUGlHwvJoxQDU7DpTXL90VmPRlnOHeDJvjNbJnA1qpDTEQjb8JSRhhglVoHcTIKrK2mn2HXUD6iJ9z9K4sK/3eZK4ThbF02GH6iZm1kTnYLUCI2INHHxOQPStAz3JLt+S23d+b8Ln1NemI82T7P0m6OPQ7ppIaAZsYP2Us4w6SorTp08ld0J6QNE4LABAGECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttYjukgHegKyXkiBW8EStTur663LQaCM7pmcktGMN3k=;
 b=0PRoAZ0+qcyWmHghLksqNqKJB/v3XmuieP6z/VtP8ampvX5gwdWtsEHMtU9smi3GekZHPN3FAdAIOIuY9/+EJiUHhy/Ydhtk97Ig2a4A7RfAYhCxx9OtB+6mGDdmKC07LrR2TNRNRxAvxEOxYL3ubwgeUSdR7CM2NhWYI7n+xZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DS7PR08MB6942.namprd08.prod.outlook.com
 (2603:10b6:5:3ac::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 19:17:54 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2%6]) with mapi id 15.20.6521.024; Sun, 25 Jun 2023
 19:17:54 +0000
Date:   Sun, 25 Jun 2023 14:17:51 -0500
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
Subject: Re: [PATCH v3 3/4] input: touchscreen: add I2C support for Goodix
 Berlin Touchscreen IC
Message-ID: <ZJiS37RV4ApshVxs@nixie71>
References: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v3-3-f0577cead709@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v3-3-f0577cead709@linaro.org>
X-ClientProxiedBy: DS7PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:8:2f::33) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DS7PR08MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 221eadbe-f0f3-48bf-6a79-08db75b0e08d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Akhorc/cE/dA7N6gK9h+ZNyN2+TyKtzSR2MwjwJwPMnu+XCcDerqGaAFEzawbVkyaR/onWJZBtvZkEfuSO+fUlGafMjuzM2fl2vtXyQfPQAky19Y0wYGNhRHyLolrm69ItPtLMOgGK+jt3iO+14Yi+mM+2VlavYwSBvEM4RQtW6RbjbIwnfcs/3ywKFFrlxxatAFfjSfwK465lGAbu9LV9f1ViSfFUV1KYDCHG4pby5IoDs0BVjg757VkebMu96wMVjSRC2NMUDdm9HonxCm4PV+UhkeCulsi3IGle+o4Lm4u/EtBVQ7h4SdFicKwWNAQl/Tc0kj5edfH0BQ0WDr3o3i/e8gqyznziiZzqZXOtYg9K68BUQ+nOBBOmcZOZc0vdJZkW0YNW0VqE2IJsRoZWYxIwoMV2n6+C9R6syAQcADcmZC5frchL7opMW4vZ8zcyl1QwyZpfRYHa7pWL+wuQUx6D7dA2OlhZ1HLEnZ+rB0paWBXbhFmlLnL8aQlkr8x3QwWL+bk5qcOuTOhFaObSvIMv5ILOpl2ZPXl6GqxEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(346002)(366004)(136003)(39830400003)(451199021)(38100700002)(83380400001)(86362001)(478600001)(54906003)(966005)(6486002)(33716001)(6666004)(41300700001)(66476007)(66556008)(66946007)(316002)(8676002)(8936002)(26005)(6512007)(6916009)(4326008)(6506007)(186003)(9686003)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?efRWuCMPq0v/2ysACmHmES0OqbXhKl7FCZBMG781kc2j4ygcUtJP3dk03RS6?=
 =?us-ascii?Q?vudkv4uIb1bkM3TQSiBl3fce3ghE7VbV/40E1W4w2NoMuv6twSsOTq8oSz4d?=
 =?us-ascii?Q?F3UyPU/GaQOISa/BGuHAnKL5YTRLEm7p2JYcHbMdbqq3L8j7Fnefoc7sTDlj?=
 =?us-ascii?Q?SI56A8MaEHH7BxAuQcouo8cWcUj6Pf5KciIFGaS3gXZTyVBtV4ldg+2e5pVk?=
 =?us-ascii?Q?FbuOhSzWCUnuNWWGsq4T/FBdrjVfWS8LFcCPQCxOKf89cuhfKkOPlD72yFkN?=
 =?us-ascii?Q?dyp0dPaYn7Wkdvnd442Gc+G5XoVHG/7wVyylfV2/VRdQ8Yl9zlN5VjykyPy2?=
 =?us-ascii?Q?EzmYYlY4+13yiW6J1r6FxPPko3hZHpwfJc0cTZUGUkuRJDhEnMfOGA6FdFFd?=
 =?us-ascii?Q?YmDWUQJugCz1eiM5AMGjs+rmByiS9j6cG0azc45Ro4eaffsn/0/aM9qsJ/oz?=
 =?us-ascii?Q?l0c+6uhSubvwR+jywcVWgzCsx8hGPJQyBBckskFKCexAqoroKPbzPLMZc2OW?=
 =?us-ascii?Q?6PElUt+iIKILT4/leWCHP/vJA2IPm9+JK2bhh69NTJ+Y0f55uGFt1nfawdgp?=
 =?us-ascii?Q?0xzvba6OHM0MdFSs9XHXRBpgToB8PNlaU84cO+YMBgPdze3MAAOYpFRmzLkY?=
 =?us-ascii?Q?qo1zHConFQBftYnZHPfKcrn1cNV72YWRvBtoZeD4K5AS9AWW1/ZHxBBaZzQg?=
 =?us-ascii?Q?z6WaPT9MEvD0ZjEs9kPle4PosSAWP/UTgHpf01YajoGtGdzNy4Bcr16Z7me8?=
 =?us-ascii?Q?cbDYoUTo4im9UY56MhHyVLnPZBi7+dgR12E9nGzJFhCXA8eH0dstl6nJMNeH?=
 =?us-ascii?Q?qhXFyWhZcIdwbsaXWJw138Ckmu2i3mcFyOSuV8DzhTdTdiZ0+fExHU7sg9jU?=
 =?us-ascii?Q?jLI2HGW4OqW8Gg2aefAmzTIGz9J+mNi6IcVwPQxuL09kp4H2LYnJkD1or4BT?=
 =?us-ascii?Q?Un2mUaAoo2wKlCHBPPpCa5QO9oYX1FXbSAwaDDpWY7eA7YMX7zEMBZ7/TEpQ?=
 =?us-ascii?Q?pfFLW++YXf53hR6LKT6en/Rwpyofwxthlt4lwwu61pGLuiaAFaQz13GhaP8r?=
 =?us-ascii?Q?Kv3+rb2UM1LcFpqJKpDvBl5Mdk/hlhmLnLaCZhgWEx0fNTH8k0eVp+xvGws3?=
 =?us-ascii?Q?NCm1u/0f2+dPJF/qmgP9vwP0Ucg9tNI0yw5/4rBicVCrp6oaGD5Ll4CYWYGQ?=
 =?us-ascii?Q?O9yPxU4utQEo1wYzRuY+NPIcnvWxlyRLA9iEZPTBuQtjwRwCFKB69u/8gUFC?=
 =?us-ascii?Q?4dlcH1jrBxBw4MZwhjzv/h1Ty5kGH8+Hih8jEhP0HTbufRUDcyByZ4cjU195?=
 =?us-ascii?Q?PqC19m67WCz3Fwgj+viQOuFtQxTmDYAOneMKDeOBFo90l01/JOkZ/9dzvbnw?=
 =?us-ascii?Q?oCSuH65Y77EOE+JNlHmvcmINT2/vadV4zVWyL7cT36B96OIi1RQRjbayKg7B?=
 =?us-ascii?Q?WkbEIDCEy1CBuZWqC1j49BpnaDmEPdbfkdi4qWmJzwNwahDUZ4j+VN3YHM2P?=
 =?us-ascii?Q?2w+JjzkPcqnIyv22xidm0ASWF2B/NqI3ypX5AXFKloRWcRGGsktlrra9/nj/?=
 =?us-ascii?Q?LnjEti4zKnEvbzArkCGcySbaoWoWZAo4iKTbXiem?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221eadbe-f0f3-48bf-6a79-08db75b0e08d
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 19:17:54.6693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fh8GUnSv4NYTazCYFKAQlyGO+zM2zTVarOkEcWsN39rgxgMbKCobzTUSsObPSOEhf2ntPl/X2jfdNcZSp7a1sA==
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

On Thu, Jun 22, 2023 at 04:29:01PM +0200, Neil Armstrong wrote:
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

Just one comment below, then feel free to add:

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

>  drivers/input/touchscreen/Kconfig             | 14 ++++++
>  drivers/input/touchscreen/Makefile            |  1 +
>  drivers/input/touchscreen/goodix_berlin_i2c.c | 69 +++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 1a6f6f6da991..5e21cca6025d 100644
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

select REGMAP_I2C

(keep "depends on I2C")

> +	select TOUCHSCREEN_GOODIX_BERLIN_CORE
> +	help
> +	  Say Y here if you have a Goodix Berlin IC connected to
> +	  your system via I2C.
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
> index 000000000000..6407b2258eb1
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix_berlin_i2c.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Goodix Berlin Touchscreen Driver
> + *
> + * Copyright (C) 2020 - 2021 Goodix, Inc.
> + * Copyright (C) 2023 Linaro Ltd.
> + *
> + * Based on goodix_ts_berlin driver.
> + */
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
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
> +/* vendor & product left unassigned here, should probably be updated from fw info */
> +static const struct input_id goodix_berlin_i2c_input_id = {
> +	.bustype = BUS_I2C,
> +};
> +
> +static int goodix_berlin_i2c_probe(struct i2c_client *client)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(client, &goodix_berlin_i2c_regmap_conf);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return goodix_berlin_probe(&client->dev, client->irq,
> +				   &goodix_berlin_i2c_input_id, regmap);
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
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, goodix_berlin_i2c_of_match);
> +
> +static struct i2c_driver goodix_berlin_i2c_driver = {
> +	.driver = {
> +		.name = "goodix-berlin-i2c",
> +		.of_match_table = goodix_berlin_i2c_of_match,
> +		.pm = pm_sleep_ptr(&goodix_berlin_pm_ops),
> +	},
> +	.probe = goodix_berlin_i2c_probe,
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
