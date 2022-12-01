Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC1863F589
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLAQov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLAQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:44:49 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A0EAE4DC;
        Thu,  1 Dec 2022 08:44:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmpXmx2BtzKP4RlVV6GOWFF1zO/uSTJBc5rAasIR1XZUMRpuQOC68jvpvQ/1kYKKwPjBWJQTFUkWPgxwpXBhywMfQ7NJQTXFWEm+vycEfRlRNdj6Uq+ee7Vtu5eP/Hz/CudCDhO3iI+6yqHMUA8jtedZiHq9QpwMUQCiDsGBkY+7kGAcfARNy+vSeAZGIalb5YnFup2PutJb/8OSpJcXgHrRUaMBgRcYObiG/Oec5ORkt/ZntSAw/zvsU9HvvTpWaPj274wB56znZE66tiRyEy8JB1cUm8XZtO8bdo2DZ+INMG1QOjQh0CxxssvxlPmwC/Y+KpjqasB428lGt+euRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7ndHdwbBmCMWKrxJ7Y9KBgRBJoupOSoaR04mXGBoTU=;
 b=N//zvxEK6InbklIm3nfTmr9u+DSnp7zkadMQDuS4ZL16nZJK1NyXyGL9PBmJ4d2rG4U5mut4iaJtaokszgurXNyBKBwoSuGa29Std1nmlrH0Fnns0ZiE/FdUgmbqR6i4xVQc97I0W5TSoI4CaPoBnax+58F080biaMHTqjT0LLxJ4D/j1c+P3dwtpoWYm8eb0VyjIXGx61AYu5MjPhpsplpgpF+hlw28K0UOldh6NFvFDpRh/3WHvAAmwbUOVBUWLkdC5xjsP4COdxymFjWMEQplyu2KyOaf8Xzm3kJJgF1Ln2CACHT1+57eD+U0YlgrFpnlPqCRvWa6pR9a8OFrHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7ndHdwbBmCMWKrxJ7Y9KBgRBJoupOSoaR04mXGBoTU=;
 b=tgj1wazDBezMZqRJe7RAyh4GzdAqjD+N+0KDYR63TPpKwXDbnaLRZm5A+TPwCuG4w5sC5wdzhCtj0T+h+iiimGgFME2/mYEtnfE/4w442xOVIlBQRKp5PdhA3kG4eCNtg9P7SuSQ8BbsA+kk3azBWYqeqV9ZrFPRF2L14zzmhs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CO1PR08MB6497.namprd08.prod.outlook.com
 (2603:10b6:303:96::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 16:44:44 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c%4]) with mapi id 15.20.5813.019; Thu, 1 Dec 2022
 16:44:44 +0000
Date:   Thu, 1 Dec 2022 10:44:41 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     ye.xingchen@zte.com.cn
Cc:     dmitry.torokhov@gmail.com, nick@shmanahar.org,
        giulio.benetti@benettiengineering.com,
        dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
        oliver.graute@kococonnector.com, wsa+renesas@sang-engineering.com,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: =?iso-8859-1?Q?touch?=
 =?iso-8859-1?Q?screen=3A_use_sysfs=5Femit=28=29_to_instead_of=A0scnprintf?=
 =?iso-8859-1?B?KCk=?=
Message-ID: <Y4jZ+RPZqvo1gyW/@nixie71>
References: <202212011904193038898@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212011904193038898@zte.com.cn>
X-ClientProxiedBy: SN7PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:806:f2::11) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CO1PR08MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a5793a-7c69-456a-7e25-08dad3bb597a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzz2k3Z3RfKJQ/tRwq1XfHSL6DpfvBYH1b0+TjzJt7XQFs/Ni6YDek2n6Xr9/Tg8KU1I+nVyCg3HyB0k1ZZs6hSEEGU7CKsWW5blCYp+pVd7lk627/z+UF+jH6bJLK8R8aFWZ/1FNZd23pgFqv0ICsOU70LW/zHjz5gKKyzU8WLJXY6ZJP5o8wY2eJtd/Q0Pm7zgsl5U8TpQBDhK19ljvj/4pEAuvKCLkdroZwUjU0sfPYZKW5ZKFkCo2HjtjKjbWLn0j2y77DZZpoRqnwcQ698NtWxys+dHaSVax0tpC0wmAn3g4Yd1QOEO9A/36OvGZhNP1tffsBR2CAUtVXb1G3Fnxq9OGnnJbbqknby6hsYHN6hpEugOR/+J92wDmODyB1p5VXcXfaGnwcRgJkfdwR4wNjB+b86mgbBGm8dR1pePnDORQU6Zcm75yGTTJYOAAvpOswyG1GBIICusJQsuFDSxeA9M1D2Hs4qOPpP8GgR9mBfVMKR9FVom+688f9olWtGK0ohBELDyyoGRorBlthPAS2ZDLkXfvcX8iwalsAVhzsx7y0rauGPNkZ6uOyKBJpM8TSeA5VCB6tE1IXPR6cFWbfL3TJF31EHo9zuTg4Sr0dBfGI0Ax1Tnz2GpUTpv7dOTOjtYjoRPQNoRpryTXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39830400003)(136003)(376002)(346002)(366004)(396003)(451199015)(66946007)(66556008)(5660300002)(2906002)(41300700001)(66476007)(4326008)(8936002)(186003)(7416002)(6916009)(33716001)(6506007)(38100700002)(26005)(478600001)(6486002)(86362001)(6666004)(316002)(9686003)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HQA/e/p96Be4AqRh8Am5AygfNOn0BZrQdNXqO8OoBk4SYARsNnzCWeg/cTxI?=
 =?us-ascii?Q?2w+t3Xh59Iff+VqFgBJsoexGUeTbCXqAW63lpkRuNHLU4PJaZskUlFatwrET?=
 =?us-ascii?Q?ZT+lvAAC9qYqf9/sCp7a++vkjnkQyIKJOGKXERucSy4Ged57gFzmBN9eVGKK?=
 =?us-ascii?Q?3cSMd20ktaPAcP9Ahg2FpbPjl2kc8U1IvvPDWlkFwqE2t+3jY4qhC7Rtmw6h?=
 =?us-ascii?Q?UEY3Jj324g5qG6CndNhoPsNfbDwYMF0VT/+GhgmsehrxSjCGaZogeWmL81a/?=
 =?us-ascii?Q?CDdH2+LMNcy3NYRcRDQGvpxc4eFZ7fpAeE3SGpNKqhZl0WYA3/1yrXkGGtH1?=
 =?us-ascii?Q?MLG8Td1OuLmh/5JxPzNnWwVpCZQpRJ1a6BHzM6VCa3SARTwMPXf7mJ0sSpKL?=
 =?us-ascii?Q?G4L+Qgokbd1lOzhH++wwk84FGWyWIBD7b17hB1KZk0kKJE+OMAVTk+5ZlxEa?=
 =?us-ascii?Q?gRhLewLsmznMM3SN+SRLP6x9R6H1d7qorvw5J4rTf1G3QJbPrvfskt900Lsz?=
 =?us-ascii?Q?AqnQtDi1orRs2QxaSJ7pqNz1MVniNR22bowbZdYjaNhdgyuNPioeRGozGvIA?=
 =?us-ascii?Q?WeL0jBxJLt6nBuQEa3dbK6uh3UoF8yZdff8HPQ1Gf4BbDqjm0qs1Xj+AeQ4M?=
 =?us-ascii?Q?3n+Dr+ciWVTduZ06ltFgEkJwEunAe+2+vpXHUtF9gjqAUIM89vc8/29FKQc5?=
 =?us-ascii?Q?NT/wTsMBm4UFDJHVoFZRiTcV645VKBKDd3mdpjZ5sAMnW70Vwy7WPmewPLhw?=
 =?us-ascii?Q?rtpM8AGXjDC3+I8MNbwrpUug9dCVUQ9BdN4B0Gg6lHMrjLBj8L8Xq2Cqh+Ew?=
 =?us-ascii?Q?vcglQ1BYqpZj1TTUcZOlh96WF6/4AShhQDdzih6nCnWq2TTZGBklE7zO2GUI?=
 =?us-ascii?Q?srrKQGsARj3CsycVk9J+zi2YxDhyiiezt80D8XhU6vtuuKg5nzadfDFxj3MX?=
 =?us-ascii?Q?UFSL8/J0Jym3nbCOccHhRfbW4jvpbLdl6WLtxaZE+Xnft5RwtIqUb+fu//Ii?=
 =?us-ascii?Q?0KW71+UE4zvNkkeL39aXi0d33o0aVBs9jyLRqhrxrS0UFm7BpwOVfPYy7r5l?=
 =?us-ascii?Q?Ox9V40DGEnPUasFfCKQH/tMq1Oz0U3uTvkPQZE+fVbsBHmVanuUAFKMRzmQf?=
 =?us-ascii?Q?RP5fc5ZevbeWAxBxT7JFt+H7sWROQxXHpxmILZJU+44YIcSt90RbmhAb4maM?=
 =?us-ascii?Q?47P3oElHUg6c4gV2emZTw401FnLoSHPi+GTelwWM8g2jr+x3zq61MZZ4WbjF?=
 =?us-ascii?Q?taEWqLQXU6CLTJ1c3gvwEdZKg8PxH02a1vqT+R+0ZlVYrFTeIMXw14AZwKDi?=
 =?us-ascii?Q?gKnd9hr5X/zYhrGkGC1M4fJ0UGgAur/zwJPtY7tB4sjL0TK+KHtltbobuI8z?=
 =?us-ascii?Q?vHUoHP1ZOOIj/GaO3aKcEwMsIm3nEQ4XW5HlhgX8liq3LYeoT1m+b6b1MRPS?=
 =?us-ascii?Q?bKYRQ4j+mlSPPy9zTcLJb01yluHAdBI6FzO0Ey1jTQocsGlkQ4hFB7B9qGs4?=
 =?us-ascii?Q?Wg4l2xldIcAWJCGUT6AVQKE5aJrNGFg8a/hHQDUU+5WMmXWnh27Qow7bL5WT?=
 =?us-ascii?Q?Y7ztepOhOBvIOd8Pk2Yj8hdcVbakO/PBAO0OGATI?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a5793a-7c69-456a-7e25-08dad3bb597a
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 16:44:44.2235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtYX8bSx/plUNfXYM88tQZhpbhPf4kCNjFJjgdygdTyg/99RKG/PgItj1MngxQ4ZyG96oCBOHeRg3AefAyLfUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB6497
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ye,

On Thu, Dec 01, 2022 at 07:04:19PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

My comment is arguably cosmetic, but this patch distorts all of the
vertical alignment in these drivers. Example below.

> ---
> v1 -> v2
> fix the Subject.
>  drivers/input/touchscreen/atmel_mxt_ts.c   | 4 ++--
>  drivers/input/touchscreen/edt-ft5x06.c     | 2 +-
>  drivers/input/touchscreen/hideep.c         | 4 ++--
>  drivers/input/touchscreen/hycon-hy46xx.c   | 2 +-
>  drivers/input/touchscreen/ilitek_ts_i2c.c  | 4 ++--
>  drivers/input/touchscreen/iqs5xx.c         | 2 +-
>  drivers/input/touchscreen/usbtouchscreen.c | 2 +-
>  drivers/input/touchscreen/wdt87xx_i2c.c    | 6 +++---
>  8 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index ccecd1441f0b..daad47c7823f 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -2761,7 +2761,7 @@ static ssize_t mxt_fw_version_show(struct device *dev,
>  {
>  	struct mxt_data *data = dev_get_drvdata(dev);
>  	struct mxt_info *info = data->info;
> -	return scnprintf(buf, PAGE_SIZE, "%u.%u.%02X\n",
> +	return sysfs_emit(buf, "%u.%u.%02X\n",
>  			 info->version >> 4, info->version & 0xf, info->build);

When applied locally, this apperas as:

        return sysfs_emit(buf, ...
                        info->family_id,...

The original authors, myself included, spaced the second line over
just enough to be aligned and hence more readable. Please maintain
the same here.

In some cases, you may also be able to avoid a line break now that
PAGE_SIZE is no longer taking up space.

>  }
> 
> @@ -2771,7 +2771,7 @@ static ssize_t mxt_hw_version_show(struct device *dev,
>  {
>  	struct mxt_data *data = dev_get_drvdata(dev);
>  	struct mxt_info *info = data->info;
> -	return scnprintf(buf, PAGE_SIZE, "%u.%u\n",
> +	return sysfs_emit(buf, "%u.%u\n",
>  			 info->family_id, info->variant_id);
>  }
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 9ac1378610bc..b2ec2e04f943 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -445,7 +445,7 @@ static ssize_t edt_ft5x06_setting_show(struct device *dev,
>  		*field = val;
>  	}
> 
> -	count = scnprintf(buf, PAGE_SIZE, "%d\n", val);
> +	count = sysfs_emit(buf, "%d\n", val);
>  out:
>  	mutex_unlock(&tsdata->mutex);
>  	return error ?: count;
> diff --git a/drivers/input/touchscreen/hideep.c b/drivers/input/touchscreen/hideep.c
> index e9547ee29756..c0d72ba3c44a 100644
> --- a/drivers/input/touchscreen/hideep.c
> +++ b/drivers/input/touchscreen/hideep.c
> @@ -922,7 +922,7 @@ static ssize_t hideep_fw_version_show(struct device *dev,
>  	ssize_t len;
> 
>  	mutex_lock(&ts->dev_mutex);
> -	len = scnprintf(buf, PAGE_SIZE, "%04x\n",
> +	len = sysfs_emit(buf, "%04x\n",
>  			be16_to_cpu(ts->dwz_info.release_ver));
>  	mutex_unlock(&ts->dev_mutex);
> 
> @@ -937,7 +937,7 @@ static ssize_t hideep_product_id_show(struct device *dev,
>  	ssize_t len;
> 
>  	mutex_lock(&ts->dev_mutex);
> -	len = scnprintf(buf, PAGE_SIZE, "%04x\n",
> +	len = sysfs_emit(buf, "%04x\n",
>  			be16_to_cpu(ts->dwz_info.product_id));
>  	mutex_unlock(&ts->dev_mutex);
> 
> diff --git a/drivers/input/touchscreen/hycon-hy46xx.c b/drivers/input/touchscreen/hycon-hy46xx.c
> index 891d0430083e..2d34959cb510 100644
> --- a/drivers/input/touchscreen/hycon-hy46xx.c
> +++ b/drivers/input/touchscreen/hycon-hy46xx.c
> @@ -202,7 +202,7 @@ static ssize_t hycon_hy46xx_setting_show(struct device *dev,
>  		*field = val;
>  	}
> 
> -	count = scnprintf(buf, PAGE_SIZE, "%d\n", val);
> +	count = sysfs_emit(buf, "%d\n", val);
> 
>  out:
>  	mutex_unlock(&tsdata->mutex);
> diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
> index c5d259c76adc..114dceb13b77 100644
> --- a/drivers/input/touchscreen/ilitek_ts_i2c.c
> +++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
> @@ -512,7 +512,7 @@ static ssize_t firmware_version_show(struct device *dev,
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct ilitek_ts_data *ts = i2c_get_clientdata(client);
> 
> -	return scnprintf(buf, PAGE_SIZE,
> +	return sysfs_emit(buf,
>  			 "fw version: [%02X%02X.%02X%02X.%02X%02X.%02X%02X]\n",
>  			 ts->firmware_ver[0], ts->firmware_ver[1],
>  			 ts->firmware_ver[2], ts->firmware_ver[3],
> @@ -527,7 +527,7 @@ static ssize_t product_id_show(struct device *dev,
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct ilitek_ts_data *ts = i2c_get_clientdata(client);
> 
> -	return scnprintf(buf, PAGE_SIZE, "product id: [%04X], module: [%s]\n",
> +	return sysfs_emit(buf, "product id: [%04X], module: [%s]\n",
>  			 ts->mcu_ver, ts->product_id);
>  }
>  static DEVICE_ATTR_RO(product_id);
> diff --git a/drivers/input/touchscreen/iqs5xx.c b/drivers/input/touchscreen/iqs5xx.c
> index 34c4cca57d13..9119e6b5c44f 100644
> --- a/drivers/input/touchscreen/iqs5xx.c
> +++ b/drivers/input/touchscreen/iqs5xx.c
> @@ -943,7 +943,7 @@ static ssize_t fw_info_show(struct device *dev,
>  	if (!iqs5xx->dev_id_info.bl_status)
>  		return -ENODATA;
> 
> -	return scnprintf(buf, PAGE_SIZE, "%u.%u.%u.%u:%u.%u\n",
> +	return sysfs_emit(buf, "%u.%u.%u.%u:%u.%u\n",
>  			 be16_to_cpu(iqs5xx->dev_id_info.prod_num),
>  			 be16_to_cpu(iqs5xx->dev_id_info.proj_num),
>  			 iqs5xx->dev_id_info.major_ver,
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
> index d6d04b9f04fc..4b2606805240 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -456,7 +456,7 @@ static ssize_t mtouch_firmware_rev_show(struct device *dev,
>  	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
>  	struct mtouch_priv *priv = usbtouch->priv;
> 
> -	return scnprintf(output, PAGE_SIZE, "%1x.%1x\n",
> +	return sysfs_emit(output, "%1x.%1x\n",
>  			 priv->fw_rev_major, priv->fw_rev_minor);
>  }
>  static DEVICE_ATTR(firmware_rev, 0444, mtouch_firmware_rev_show, NULL);
> diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
> index 166edeb77776..8f1b45ec2618 100644
> --- a/drivers/input/touchscreen/wdt87xx_i2c.c
> +++ b/drivers/input/touchscreen/wdt87xx_i2c.c
> @@ -887,7 +887,7 @@ static ssize_t config_csum_show(struct device *dev,
>  	cfg_csum = wdt->param.xmls_id1;
>  	cfg_csum = (cfg_csum << 16) | wdt->param.xmls_id2;
> 
> -	return scnprintf(buf, PAGE_SIZE, "%x\n", cfg_csum);
> +	return sysfs_emit(buf, "%x\n", cfg_csum);
>  }
> 
>  static ssize_t fw_version_show(struct device *dev,
> @@ -896,7 +896,7 @@ static ssize_t fw_version_show(struct device *dev,
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct wdt87xx_data *wdt = i2c_get_clientdata(client);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%x\n", wdt->param.fw_id);
> +	return sysfs_emit(buf, "%x\n", wdt->param.fw_id);
>  }
> 
>  static ssize_t plat_id_show(struct device *dev,
> @@ -905,7 +905,7 @@ static ssize_t plat_id_show(struct device *dev,
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct wdt87xx_data *wdt = i2c_get_clientdata(client);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%x\n", wdt->param.plat_id);
> +	return sysfs_emit(buf, "%x\n", wdt->param.plat_id);
>  }
> 
>  static ssize_t update_config_store(struct device *dev,
> -- 
> 2.25.1

Kind regards,
Jeff LaBundy
