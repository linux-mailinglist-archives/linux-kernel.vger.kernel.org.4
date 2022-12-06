Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E632643B8B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 03:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiLFCt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLFCtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:49:55 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9520C32D;
        Mon,  5 Dec 2022 18:49:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxoodnM1Fwf/PnNdhTywAaI5Igahh0AaEQDZoQc9uIdV7COirYmSngrfUJ+LtJa/N7s3qGs+Lj10IvvJI8jpvniA63nI6gqZ0XyzEyI3pd121XLP3yUnjP1vnN6JHKz8DCrrVqPRG8dS+oCozTt/uDxgrTDfNZcREPYmqWJujDISdXzUL+5A0eZDgA9vO+FBfkrFbT/xrET0bbwW3EDMJKdoLeAn4RnJkMIjw+IPOFWzLPBoIKasd+pZDPcslmecHvq1TUvkuj7IbvAzI0M1rdBEoKzK6PgJPl78N0xSpz2/JOXCoqV1LGNdLpeOugKzASvq4e8JYZVxp3EnKPHh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/DHdxGbvEHpfwnlX4U2xreDCIW3OVCakYUxuuYAIqo=;
 b=jDbbTkuppgMG5MFG8IhaZLRxuOMeDsvfcqtzLKq3vfEmUZjINVms34gY4fqabS51i3i433HlezIjNker7GW0w+taAQdlqJmFg6rSyET0pOvYXPdj1irFHGQ1F6/aL8eFFhFv58WoDghBEz/lyjjj/wPpgqSzciA1CiNHM0GMpwqnvjiiEx4pCBBmpLWC1gqrrALaQo6BbDn9J4AxgdIym1vfpLS87/eVK4Q3mEosMMTSr5lHSohww4+HMpHuIHY3MUBjm4GUrDdmmw4Ww1uQiKiFmsuZ0B11cazQnK/5+Wta2mKaGl/8YHsx2lCV/1PwY7nSynu2CniD21rbOatEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/DHdxGbvEHpfwnlX4U2xreDCIW3OVCakYUxuuYAIqo=;
 b=L27U+Qpyu9Mdt5BIzHULZJLa4265wxsqFYtylMrwDbQf7zNuJ45Q74ZPXq3PY6oTsb7oubwoE5VQ9kHjIOtoqIqyT8qWoXmidMBluf6rT9w+ZqFe6Nxs3gnipJjPJYm6Mob6ll62c2LO/0onQhs7lL2YzqRvk7pyX3S0qL0XRtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SA2PR08MB6443.namprd08.prod.outlook.com
 (2603:10b6:806:114::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Tue, 6 Dec
 2022 02:49:51 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c%4]) with mapi id 15.20.5880.013; Tue, 6 Dec 2022
 02:49:51 +0000
Date:   Mon, 5 Dec 2022 20:49:49 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     ye.xingchen@zte.com.cn
Cc:     nick@shmanahar.org, dmitry.torokhov@gmail.com,
        giulio.benetti@benettiengineering.com,
        dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
        oliver.graute@kococonnector.com, wsa+renesas@sang-engineering.com,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: =?iso-8859-1?Q?touch?=
 =?iso-8859-1?Q?screen=3A_use_sysfs=5Femit=28=29_to_instead_of=A0scnprintf?=
 =?iso-8859-1?B?KCk=?=
Message-ID: <Y46tzRGA/sbkzx7N@nixie71>
References: <202212021104265067026@zte.com.cn>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202212021104265067026@zte.com.cn>
X-ClientProxiedBy: SN7PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:806:f2::33) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SA2PR08MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f216db0-9f2c-4d7a-244e-08dad7348bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zto7tOuUkKKSDV5oDYKDgkCAm1HhFbBfkFzBElQ0sCLJxfcgun3JokwC1ErkoctXC16oOVCOqDADN6b39JnEV/AM/sqYukf+HZUnZZHBmP1cVHUZ6y7RZ+G0FbKpLfAQ60wQU7OAficzx0CGgNBEgyIn4j/l/7eyBqa6hfgqZmdmtzVMBa+fFLVWTmmLOnz9bzx/5m89YFiGEftAbLbvupwI166YZJKqQgccmAtmGU19+GkZ7YRU8tCRGEpIF/6lxpXVD0KUQN7JUIuWqUFTGVh/S+sTfcmOjMSPes4qVpQk+7oODI4W55XNanzc6Of7oKwLoyM1iv6OYsCR6Tv8Y/Jr+e9SiSg8cZwpUlTg2OicqSkkuX18+5hSlbTqYC6LD7XxXbzI6jnB4CeCQitblZpTQhLyygtkeB2xgcPrWEbMxYzD/m4svupL0ryP0ZVp73jybi2PEiPkTIB9+APNADdVxB3o47IIC3ayCWs9GbbUIDW55wcYeMU0Ad/thREEZwt5+WP4QFifrCssNxf0VQVxMTb5i2HDW/MnbL8p6MQuDDXN7JlpKMyN4tBVbvVA46E05eN0xYGO3Lyquoul+6c+kN7Ug82H8xSCfuZ7DGsNOysuCR0x8BcJTnaHRd1n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39830400003)(136003)(346002)(366004)(396003)(376002)(451199015)(5660300002)(316002)(7416002)(6916009)(33716001)(41300700001)(38100700002)(66574015)(83380400001)(6506007)(186003)(86362001)(8936002)(478600001)(6512007)(26005)(9686003)(2906002)(4326008)(66556008)(66476007)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wY7dQq42pQPy3bxq8KJWEjOzbFLK9tVBl0r39KM6O4bBRudTx/c5f6OBDm?=
 =?iso-8859-1?Q?8A6z4uXX6YhalSeDXcvC98k/Rz+8zOzsSsF7E3cuWQ94ewdjPlwPpoF+iQ?=
 =?iso-8859-1?Q?bFRuMQ0Tr+N/x6pO9BzJo33IQh5KydUve8Hx3ir6mVkHZrt/7tdxaBXSS3?=
 =?iso-8859-1?Q?FQy4K3DOf4J3n5DUE5BAEEeFvPvsL7lFpBPtTD3fWwXUtXMlKNzB+ARDhR?=
 =?iso-8859-1?Q?3jVb/kYn7r1XUlRoembmX1IYsmH0Q/2Rb33pab0jfE70+JK515HeuZEeFJ?=
 =?iso-8859-1?Q?+rbGUn2GlWArNXg7Exf40xiOEeWFM01E8GmCtTeIPJQQz/RSdf6AudP80j?=
 =?iso-8859-1?Q?gyoImoQhjbkQeKnCu8O2k/lF17pyqYlgqkE9UKL+WtujmTkMkPmMPuN3vi?=
 =?iso-8859-1?Q?MemHW+QUyrfpgP8i3rcsNJP4JhaZd4elT8ViV5vFbgccUG1dfh2WcJ84Om?=
 =?iso-8859-1?Q?FuGcwrHHtaxGN+Kc6EFPVMnxUeuasvBNhQwy5VUgaxa6Ks4u1aewIya1lo?=
 =?iso-8859-1?Q?9OnWZQOGn3BVw53JCuCM5k0M4aDWbJ4YjOoWskQ8pOn82l2PXY6hbpAfpl?=
 =?iso-8859-1?Q?yXdp9kYPuXKTq7c9pK7ZLpPieDwMNjG8R54PRGiUNmkSRZTTapoYHeJFwX?=
 =?iso-8859-1?Q?Qq5yiKAsddPVOaPH8JPaDzWh4CXkBafA7hYTojaU2wkwZZxR/0Y5/onP+J?=
 =?iso-8859-1?Q?//akISIWPOeLSShJguDcS+tO+udL477ZzPRKzdMOBlL25IEAyFTM4aaoAZ?=
 =?iso-8859-1?Q?FoqHmTVp3huKIfqbxV2iVoVp8Zsxfpq5istE4gxuy3JwZSUFrb335c+RNz?=
 =?iso-8859-1?Q?JwTfKb5HrFwbFQ/qzgzM0+9cO+Z9gdFYJaYOa3iPH8Dj3EEUPQtjzKMJC5?=
 =?iso-8859-1?Q?Lqt7cmacUj/OfxxMr9znATTqpYgCLQlVzSzCLXwniOvcgB/+QSmheXKu72?=
 =?iso-8859-1?Q?wHY0P5+y5iPtmtFUycs7J9L10603HPY1JGW/2B+7EyYu6LURXJtm8V5514?=
 =?iso-8859-1?Q?YBvXzCLBOOosUzlPY8YpLm4sercp22Fz77j1EGokLPEgIbhILe51Mma478?=
 =?iso-8859-1?Q?mo+15q0xDoBJw4g/q99pbhYYblMcWUcDQw4kJbNcRGHFuMM+p2XqTcrfP5?=
 =?iso-8859-1?Q?xo1BtxEikUCB6iabk54zVyVHsX8zXcCab9/qhtPMaJpBbgH4vqRf6Rxa7z?=
 =?iso-8859-1?Q?XFGmTWsSDI+kUECJ3iuJlNE5bgH4Xt/7Asy9xC9Cc7v+1vwJqJyplSY6+U?=
 =?iso-8859-1?Q?K4TNg9QBy24x44nYplgxXK9Fnz0sm81jyQ9bRHaqHsUq6T/0UuSlqq0H8h?=
 =?iso-8859-1?Q?gNp2d6l9TRL0l0zSO1JufuHBkg1bQcfnylH1CAub5HpITMba2Cz9TcnHZk?=
 =?iso-8859-1?Q?vIaeA5konY1O5ReEnPHm9LRf2NH/InsZqRKdFceP2lnPW+LQC8dgpeppm+?=
 =?iso-8859-1?Q?EU6vYMrf/AAlZy2OlEGCvrCx0De+4G5WZfo6xSbZLIL+dFJeotNRBNkM4h?=
 =?iso-8859-1?Q?7NQPLNmQCF76gCp+A2pwjdZQpXy/9xnj7B9FFQ0+m+T6+vC3EDgtvvaeaL?=
 =?iso-8859-1?Q?xLBct76VLekmyNhE6zsnjieQ+wSyymiGQqwmyz0Jlo0L2jUM5go+ax+Ha3?=
 =?iso-8859-1?Q?l/SyJoPMWKYcOnyCU6kok2FhVaj94Bk7l6?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f216db0-9f2c-4d7a-244e-08dad7348bfb
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 02:49:51.4984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AC8bQKRf9ikmwBmEYosPMghdEAg3wszZtZw4qGvIjc+CB14RIF8jYkn7jy4kGIQM/l/eEcTBmSDwDBOHpiP3+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6443
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ye,

On Fri, Dec 02, 2022 at 11:04:26AM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
> v2 -> v3
> Fix the code style.

NAK, this is the opposite of what I suggested. Before, you had this:

	return sysfs_emit(buf, "%u.%u.%u.%u:%u.%u\n",
			 be16_to_cpu(iqs5xx->dev_id_info.prod_num),

Now, you have this (worse):

	return sysfs_emit(buf, "%u.%u.%u.%u:%u.%u\n",
			be16_to_cpu(iqs5xx->dev_id_info.prod_num),

We went from one column off to two columns off. We want:

	return sysfs_emit(buf, "%u.%u.%u.%u:%u.%u\n",
			  be16_to_cpu(iqs5xx->dev_id_info.prod_num),

Please maintain the vertical alignment that was previously set forth
in these drivers.

>  drivers/input/touchscreen/atmel_mxt_ts.c   |  7 +++----
>  drivers/input/touchscreen/edt-ft5x06.c     |  2 +-
>  drivers/input/touchscreen/hideep.c         |  6 ++----
>  drivers/input/touchscreen/hycon-hy46xx.c   |  2 +-
>  drivers/input/touchscreen/ilitek_ts_i2c.c  | 15 +++++++--------
>  drivers/input/touchscreen/iqs5xx.c         | 12 ++++++------
>  drivers/input/touchscreen/usbtouchscreen.c |  4 ++--
>  drivers/input/touchscreen/wdt87xx_i2c.c    |  6 +++---
>  8 files changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index ccecd1441f0b..ea43caf20791 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -2761,8 +2761,8 @@ static ssize_t mxt_fw_version_show(struct device *dev,
>  {
>  	struct mxt_data *data = dev_get_drvdata(dev);
>  	struct mxt_info *info = data->info;
> -	return scnprintf(buf, PAGE_SIZE, "%u.%u.%02X\n",
> -			 info->version >> 4, info->version & 0xf, info->build);
> +	return sysfs_emit(buf, "%u.%u.%02X\n",
> +			info->version >> 4, info->version & 0xf, info->build);
>  }
> 
>  /* Hardware Version is returned as FamilyID.VariantID */
> @@ -2771,8 +2771,7 @@ static ssize_t mxt_hw_version_show(struct device *dev,
>  {
>  	struct mxt_data *data = dev_get_drvdata(dev);
>  	struct mxt_info *info = data->info;
> -	return scnprintf(buf, PAGE_SIZE, "%u.%u\n",
> -			 info->family_id, info->variant_id);
> +	return sysfs_emit(buf, "%u.%u\n", info->family_id, info->variant_id);
>  }
> 
>  static ssize_t mxt_show_instance(char *buf, int count,
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
> index e9547ee29756..a9f8ca923586 100644
> --- a/drivers/input/touchscreen/hideep.c
> +++ b/drivers/input/touchscreen/hideep.c
> @@ -922,8 +922,7 @@ static ssize_t hideep_fw_version_show(struct device *dev,
>  	ssize_t len;
> 
>  	mutex_lock(&ts->dev_mutex);
> -	len = scnprintf(buf, PAGE_SIZE, "%04x\n",
> -			be16_to_cpu(ts->dwz_info.release_ver));
> +	len = sysfs_emit(buf, "%04x\n", be16_to_cpu(ts->dwz_info.release_ver));
>  	mutex_unlock(&ts->dev_mutex);
> 
>  	return len;
> @@ -937,8 +936,7 @@ static ssize_t hideep_product_id_show(struct device *dev,
>  	ssize_t len;
> 
>  	mutex_lock(&ts->dev_mutex);
> -	len = scnprintf(buf, PAGE_SIZE, "%04x\n",
> -			be16_to_cpu(ts->dwz_info.product_id));
> +	len = sysfs_emit(buf, "%04x\n", be16_to_cpu(ts->dwz_info.product_id));
>  	mutex_unlock(&ts->dev_mutex);
> 
>  	return len;
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
> index c5d259c76adc..f4f4fbd5be97 100644
> --- a/drivers/input/touchscreen/ilitek_ts_i2c.c
> +++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
> @@ -512,12 +512,11 @@ static ssize_t firmware_version_show(struct device *dev,
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct ilitek_ts_data *ts = i2c_get_clientdata(client);
> 
> -	return scnprintf(buf, PAGE_SIZE,
> -			 "fw version: [%02X%02X.%02X%02X.%02X%02X.%02X%02X]\n",
> -			 ts->firmware_ver[0], ts->firmware_ver[1],
> -			 ts->firmware_ver[2], ts->firmware_ver[3],
> -			 ts->firmware_ver[4], ts->firmware_ver[5],
> -			 ts->firmware_ver[6], ts->firmware_ver[7]);
> +	return sysfs_emit(buf, "fw version: [%02X%02X.%02X%02X.%02X%02X.%02X%02X]\n",
> +			ts->firmware_ver[0], ts->firmware_ver[1],
> +			ts->firmware_ver[2], ts->firmware_ver[3],
> +			ts->firmware_ver[4], ts->firmware_ver[5],
> +			ts->firmware_ver[6], ts->firmware_ver[7]);
>  }
>  static DEVICE_ATTR_RO(firmware_version);
> 
> @@ -527,8 +526,8 @@ static ssize_t product_id_show(struct device *dev,
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct ilitek_ts_data *ts = i2c_get_clientdata(client);
> 
> -	return scnprintf(buf, PAGE_SIZE, "product id: [%04X], module: [%s]\n",
> -			 ts->mcu_ver, ts->product_id);
> +	return sysfs_emit(buf, "product id: [%04X], module: [%s]\n",
> +			ts->mcu_ver, ts->product_id);
>  }
>  static DEVICE_ATTR_RO(product_id);
> 
> diff --git a/drivers/input/touchscreen/iqs5xx.c b/drivers/input/touchscreen/iqs5xx.c
> index 34c4cca57d13..7ace2aacdd5b 100644
> --- a/drivers/input/touchscreen/iqs5xx.c
> +++ b/drivers/input/touchscreen/iqs5xx.c
> @@ -943,12 +943,12 @@ static ssize_t fw_info_show(struct device *dev,
>  	if (!iqs5xx->dev_id_info.bl_status)
>  		return -ENODATA;
> 
> -	return scnprintf(buf, PAGE_SIZE, "%u.%u.%u.%u:%u.%u\n",
> -			 be16_to_cpu(iqs5xx->dev_id_info.prod_num),
> -			 be16_to_cpu(iqs5xx->dev_id_info.proj_num),
> -			 iqs5xx->dev_id_info.major_ver,
> -			 iqs5xx->dev_id_info.minor_ver,
> -			 iqs5xx->exp_file[0], iqs5xx->exp_file[1]);
> +	return sysfs_emit(buf, "%u.%u.%u.%u:%u.%u\n",
> +			be16_to_cpu(iqs5xx->dev_id_info.prod_num),
> +			be16_to_cpu(iqs5xx->dev_id_info.proj_num),
> +			iqs5xx->dev_id_info.major_ver,
> +			iqs5xx->dev_id_info.minor_ver,
> +			iqs5xx->exp_file[0], iqs5xx->exp_file[1]);
>  }
> 
>  static DEVICE_ATTR_WO(fw_file);
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
> index d6d04b9f04fc..fde420e1ee73 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -456,8 +456,8 @@ static ssize_t mtouch_firmware_rev_show(struct device *dev,
>  	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
>  	struct mtouch_priv *priv = usbtouch->priv;
> 
> -	return scnprintf(output, PAGE_SIZE, "%1x.%1x\n",
> -			 priv->fw_rev_major, priv->fw_rev_minor);
> +	return sysfs_emit(output, "%1x.%1x\n",
> +			priv->fw_rev_major, priv->fw_rev_minor);
>  }
>  static DEVICE_ATTR(firmware_rev, 0444, mtouch_firmware_rev_show, NULL);
> 
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
