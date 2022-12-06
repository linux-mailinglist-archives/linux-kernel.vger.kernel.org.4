Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C96643C6C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 05:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiLFEhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 23:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbiLFEg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 23:36:56 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1512656B;
        Mon,  5 Dec 2022 20:36:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbFCsfo1OQ6Rl6y1g1swK7Ij4FzWPAP8kA6Acjr1YEvTAbig9/dMnRZqSTQecxb85TWmMdaA2+HXGnPK9yPaBefzi5JeYH3Z/ZyERL1wKgV7AJNnaB6gkfoe9YAjMyOxEumsRYsG+FPVaMgpnzYcATUv3CrO7VwaKDHZrhNF3r5C24JWLMuHAtiDkfvuoITuwobZl2SGMiLRCGWyfcb8aYDL8qtzYCSWXAzCgoBXOZhk8lXp6ocBR8H4PfKffJbYIIbFc71yl9AZ6q+Hie74mAar0DWD6ZlkMYFkyvtci5ExvdhJMC9S3mem9ZjbcVBO72PwNlXpHq9znr+VGYryIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd8tPKruWk9xOBTl7kmNLxFHGtV11n31w6h0bEq8rxg=;
 b=V9/gHoj/ACZ3gIExmpvZ5gT+XPZKV8i0VCNFS0mZP5s7PILbNdK2kfveMqvlQ0vkabKtlthBk2ZIV3686k9rkvzV+aEm6HIREgM0qAHPHMkpfPD+sUk2lLUd19dj1Cn65DZk2sd5od8yzJJSl36MSXZJLpIKcVCPdErAaR4oliuSzXnljRWGXSJS2+xBD9l4PKfFmhA2HUks4zPrrAIDlQhigp7OjE+kfMcKIJMij/20KQ4c8nUt/bSJXiQsnPxC058bP+nS7RtVHKIfEERYaaCb4yixaSmhM/9Fpnsi0S42GKfp0VQ3nHRWY5Yt4FncneHrY/HQq2EuyxyUASwEnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd8tPKruWk9xOBTl7kmNLxFHGtV11n31w6h0bEq8rxg=;
 b=PqBEoM/g4pxfUazGueelNbJFStXS2xGofxFh0mWCENX1u1q++2EbpK6TGy2wJtfQg3XmfmKHNnqevPeM3HF8ubCA6Or4ovDfAJFBYY0l72gfNw2jAModNe+djnEHFy2aR1DprOQJLFwte3j5T1KxnHBckpD9okDNlz6jJeyMDxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by BL3PR08MB7434.namprd08.prod.outlook.com
 (2603:10b6:208:339::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 04:36:39 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c%4]) with mapi id 15.20.5880.013; Tue, 6 Dec 2022
 04:36:38 +0000
Date:   Mon, 5 Dec 2022 22:36:36 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     ye.xingchen@zte.com.cn
Cc:     oliver.graute@kococonnector.com, u.kleine-koenig@pengutronix.de,
        nick@shmanahar.org, dmitry.torokhov@gmail.com,
        giulio.benetti@benettiengineering.com,
        michael@amarulasolutions.com, dario.binacchi@amarulasolutions.com,
        wsa+renesas@sang-engineering.com, johan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Input: =?iso-8859-1?Q?touch?=
 =?iso-8859-1?Q?screen=3A_use_sysfs=5Femit=28=29_to_instead_of=A0scnprintf?=
 =?iso-8859-1?B?KCk=?=
Message-ID: <Y47G1LWM8FtJKo/g@nixie71>
References: <202212061148163560976@zte.com.cn>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202212061148163560976@zte.com.cn>
X-ClientProxiedBy: SA0PR11CA0118.namprd11.prod.outlook.com
 (2603:10b6:806:d1::33) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|BL3PR08MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbd67c4-e5c4-4275-0c6c-08dad743770f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOiZFOjaGbfEuwpzJZ7CPrUqonVdll3Xu+P/4fOQiYt1waX8/2fhzrbfHeHSL11U/pOEgraZzTd6cjIfrU8AVPlZwNk98Od0U/X5oHWj90mkC6M4jMNSClQyJ7XPsTOZcXgko41Ncc7fH+oh35SKw5dzJwYYzy3OdfTxHIdSlnEVfLRB8noTmtxGXX2LvoOcnmCvuoL3bV/JKJzMHDkZdwBMAK3CCs7UZpDkDRsfD6Jo2b99Yhb5kHhIk2zJCcEvmR7ZkJqkjXh1CwTRpHfFSRDEtVKQnw9TKNszSAgFwJeToHaL/CbMqw5LsvcJFFj7zkF1lKutq1JtLdEUToYesa7oR5YW2YNR045RdFGoiM2fe6z7A3rESCsvYQQaiHbV7iHyxqmc2LhZ4PAvdsk6IFO4FajfEE6s/buEKLlpAy4GQYF/ChkZStCLkG/t7zbtlUI5lkLTBoqEMDSfXTNErrbejFQyf3FOn8sU96DZmlSYWs43+uqA9G2WIdjEIJhvzsuySFSB507XRyy1oinHHP2a97uwILXIuuByVm4clLWwtEfm4AtIC0Rak1G4L5bnTtY0KdumTxWXSsOu7dy3jFN9K2kTXKOLtDqVDwAZyf9iEPyg8wXBDhx+XABRvlq85Vh80c537ash8RnxknUbsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(346002)(39830400003)(376002)(136003)(451199015)(66574015)(86362001)(478600001)(6506007)(6486002)(38100700002)(83380400001)(33716001)(186003)(6512007)(5660300002)(41300700001)(7416002)(9686003)(26005)(4326008)(66556008)(66946007)(66476007)(8936002)(316002)(2906002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nMAR0IvT5ZzoNDzzjdxLLNBLKv+8e9/jwl1E687ZKLyhZGFWZgsTAHxLVh?=
 =?iso-8859-1?Q?aVZ/9gKmocPlvmqs2eew3z/cPU5PIgZ3PRLFvryzcOx8WM+u21jxVtUzAS?=
 =?iso-8859-1?Q?MI+B4miKoejnbiSGWo+CpYAHmD897ihZFke0FIQ8TbqiaWytVZRo96iwX5?=
 =?iso-8859-1?Q?jEPHrqdbf95wAa+L6BVb3qLrJmuHvF+uNdHxVygiZXfJKSRa8fSTWPJ9B3?=
 =?iso-8859-1?Q?mf1bBzljg/aWaa2rSUfYUDufrGXQ8xiFn2BdJrUV7N0tXK0qJSeEbhuwhw?=
 =?iso-8859-1?Q?XA8HML0J0kRfzkvwSGcztL7SnWYQwwBK0vonZ7JZuoH6di+LCIEIUZmXoQ?=
 =?iso-8859-1?Q?TFiV4Qtx50XrSHrmA77MZpIK/RZ5aHbIVhRIJL/3/noCpB+1cquhvWkPkv?=
 =?iso-8859-1?Q?zndlD//qy2SEXgIgj0Az8eZhvA4mDcXVx1uLqreV1UfdlHtbYGZNr1aMf9?=
 =?iso-8859-1?Q?zVLtcSJNHTTHLzFp3J35/KK57Gz08a7IqhYSZhBOfnq5P55VYp7r0FQZZW?=
 =?iso-8859-1?Q?TTBJmdq5pQnYWqT4ItEjwzwvbnSyZm4Ki7sUOGiQvaTKQxhJOL2g1gBSq5?=
 =?iso-8859-1?Q?enlQt2Qk00e7DpRFpYYc+fQghLE2USnnhJfPpVCrZLxWVVPx87xVtbvdrV?=
 =?iso-8859-1?Q?W/OWK0t/vnvIIfC+3XsZagHJ/txFMj1NHrVb1y+H6s/MDyq0x0n+nIwyKo?=
 =?iso-8859-1?Q?7LV7hITQdGwa/tHjvI72M3760u20JBlPMn9IE5Eglt+cdGjK3UTyYk5k1w?=
 =?iso-8859-1?Q?hp1UDik4JKyIKJRZ7aKlGH3szJyYTQFFuDAxEuZSDEZT+DdgBSWAcz/D/X?=
 =?iso-8859-1?Q?WKzAI+SvmciySFl2pioeq1Ub7PzwG2vwnGM2kyUDtDo8LZvbmro0XsUlko?=
 =?iso-8859-1?Q?0mgj6ePfVlrfLveB8eLDU/l9AL/b2XYosqOa5Yly4zFzVcdh9Ypvgw6GIm?=
 =?iso-8859-1?Q?RSwIpAfGYHjt3UumQO2AeuE/rQTZ7vW8D6fcGolqBhLEip4qxgTIKq0IRa?=
 =?iso-8859-1?Q?7Elf+DLNmGG6uZPmIJW+rllXaS1T5GqqOQcFPLG4DNNbO3f6yTlKRX0DMV?=
 =?iso-8859-1?Q?Iwj3AMSEOIHoXWo7dxceJYeD595ErBff+3PjqLVOugzhf+/9chTg79+zEw?=
 =?iso-8859-1?Q?9V5lH/25cydrE2ie0TPMaYmQrN+9PqRaKIAq6WnT3cpAnqNUHSWJULTPaD?=
 =?iso-8859-1?Q?0BTG1G6L0BpiFn6mnnAYII3zGsALng55+KjwyTlp+JJX/Na5tCeO6i323Q?=
 =?iso-8859-1?Q?XMiIcueQsBkb+LrTrfgv1SoDdQoHIkreEwztzTEABzdzM6g/tVAQHHJPuC?=
 =?iso-8859-1?Q?rp7qOrPzaM1PGnOf8Zihse0AGqOLBRyBTFrPN03vDBzQv86EGktBU+VZGd?=
 =?iso-8859-1?Q?Z0HZldYXcULs6ESWPRDZK2u2MLOT7T+WSCuueunvtRXLfWIqg/Uau/1fji?=
 =?iso-8859-1?Q?ziAHfDE0Lcu53NQfSb10Nq81oYPQyDnADRdHswNv2IrwRzMLGn9+2NEvqL?=
 =?iso-8859-1?Q?zqMB9kkkRjq0+4QONVE8EAuDJExj/ImfEecbmma4ZuVYGsEbFTkQhC/4VR?=
 =?iso-8859-1?Q?8D5WYAXB7qif2ZywQLdfEjE43x7WeA84cWjcY3bHaxcuKCTk0HZOQmavw8?=
 =?iso-8859-1?Q?xt8q27fYeRBPafyRYLBWZtpUkbvgF6EzN3?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbd67c4-e5c4-4275-0c6c-08dad743770f
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 04:36:38.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: td8qK/kAE9XUPbMI57u+elm5Vo+iKjkthkxStnwmpBsSQ9PFZVjpPkl4/+zdw9MjrvUc3rkCv8GOO8zjH19gJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR08MB7434
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ye,

Thank you for seeing this one through.

On Tue, Dec 06, 2022 at 11:48:16AM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Acked-by: Oliver Graute <oliver.graute@kococonnector.com>

Acked-by: Jeff LaBundy <jeff@labundy.com>

> ---
> v3 -> v4
> Fix the code style.
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
> index 39ef2664b852..e44643a70601 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -2761,8 +2761,8 @@ static ssize_t mxt_fw_version_show(struct device *dev,
>  {
>  	struct mxt_data *data = dev_get_drvdata(dev);
>  	struct mxt_info *info = data->info;
> -	return scnprintf(buf, PAGE_SIZE, "%u.%u.%02X\n",
> -			 info->version >> 4, info->version & 0xf, info->build);
> +	return sysfs_emit(buf, "%u.%u.%02X\n",
> +			  info->version >> 4, info->version & 0xf, info->build);
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
> index ddd0f1f62458..8df2152edeb6 100644
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
> index ff4bb4c14898..ef0f6a436f78 100644
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
> index 8f4989aba9a4..bc03fd5d01a4 100644
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
> index e6ade3775a8a..c63d5d7b9c99 100644
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
> +			  ts->firmware_ver[0], ts->firmware_ver[1],
> +			  ts->firmware_ver[2], ts->firmware_ver[3],
> +			  ts->firmware_ver[4], ts->firmware_ver[5],
> +			  ts->firmware_ver[6], ts->firmware_ver[7]);
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
> +			  ts->mcu_ver, ts->product_id);
>  }
>  static DEVICE_ATTR_RO(product_id);
> 
> diff --git a/drivers/input/touchscreen/iqs5xx.c b/drivers/input/touchscreen/iqs5xx.c
> index dc3137a34f35..227a635f4778 100644
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
> +			  be16_to_cpu(iqs5xx->dev_id_info.prod_num),
> +			  be16_to_cpu(iqs5xx->dev_id_info.proj_num),
> +			  iqs5xx->dev_id_info.major_ver,
> +			  iqs5xx->dev_id_info.minor_ver,
> +			  iqs5xx->exp_file[0], iqs5xx->exp_file[1]);
>  }
> 
>  static DEVICE_ATTR_WO(fw_file);
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
> index d6d04b9f04fc..60354ebc7242 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -456,8 +456,8 @@ static ssize_t mtouch_firmware_rev_show(struct device *dev,
>  	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
>  	struct mtouch_priv *priv = usbtouch->priv;
> 
> -	return scnprintf(output, PAGE_SIZE, "%1x.%1x\n",
> -			 priv->fw_rev_major, priv->fw_rev_minor);
> +	return sysfs_emit(output, "%1x.%1x\n",
> +			  priv->fw_rev_major, priv->fw_rev_minor);
>  }
>  static DEVICE_ATTR(firmware_rev, 0444, mtouch_firmware_rev_show, NULL);
> 
> diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
> index 3f87db5cdca4..e89b5f449cbe 100644
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
