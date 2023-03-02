Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925136A8B50
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 22:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCBV41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 16:56:27 -0500
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:54933
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229732AbjCBV4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 16:56:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEJfIyUrfHSCszc0I+FDExSkouk9jOYRySsWUuPml0nQwG7titRlzd3aC4gEMWzOkrWwp5OKUy21E9QACr9YTdLfwma9LqlQEj/v6tSUiQhe0SV5vbTBxYiuNWI0r/g28dUYaoDQYxt1Dj3tvg28aFEecsq7Ogt1MjZJAU97HxCvs9fxe7HSdJawDZtQoJzsnLjMTCRYbjPJcR2OHui2QJkgsOjhTQ2zYJm7Qb03HYWU9dMy4KQu16IN8fQQUce78ZoUxVThbgdNusN2tvOru1tbu8MufSsNzYpBq9pR6dcgt8XHXc92wUjkC3h9A40dCb2BCHGo0XduqVVcfX/5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uenbkF+hIyglmZu+JiAxVYzBJvQapganUcr6fOtgUsQ=;
 b=jwXn8uYX4zQman7ZQKxTTVGNFkZ64IdPZl8trZOMFOZPcVAWNsvlP1CvujPdCicXjtwp1g1Fn1GnmyrBvzVHsmSOd+1FQZUgcrh4AHnVzighdh/ALYlsye0xl1ueF4GPwga3mYdO466AbP9xtI3R13WgN5v0vCXgqLAH2vW0ynly55mgG/ZKt44+iUfXS/WdVVnk8IudrPK2Fbo05jz2RuX9JEFdP/v8u0uXmnDaEDY3wkwg3OkPvmuD7uqzl5AK3na1sheSGPjtbToraFsaKX6QUcQgOKBMneknxpWzv9SEKsWAySMlAV+lDI4Q1VrmygaBwVH1sK3L455TkAz3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uenbkF+hIyglmZu+JiAxVYzBJvQapganUcr6fOtgUsQ=;
 b=p5BBfbRyqFlNz5D+cn5Sa10B9Un4Sp2trNZCtP010rVqyYPjicBFgCdZph303LVBRtKg0wAn35vd+IAWzeXZ7kWN6iZXLFjhY1RzXYcVoxJZyCBFH1K9NyPPNBY6xYsDnjGXkcRYd5AW3jo/VgLvAFoupA8oVUNZxy+T438A17c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 21:51:48 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%6]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 21:51:48 +0000
Message-ID: <b52c68e6-2501-67c8-1fbd-60a35537c1f2@amd.com>
Date:   Thu, 2 Mar 2023 15:51:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 7/9] crypto: ccp: Add support for ringing a platform
 doorbell
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>, Rijo-john.Thomas@amd.com,
        herbert@gondor.apana.org.au, John Allen <john.allen@amd.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230302194235.1724-1-mario.limonciello@amd.com>
 <20230302194235.1724-8-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230302194235.1724-8-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0008.prod.exchangelabs.com (2603:10b6:805:b6::21)
 To DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1cacb3-0f85-49eb-9e8b-08db1b6852e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KeRC4DRUOj8IodvxzQHqfzLEm3cqOLp8FjjcWmYTJfur6VRDoeKCYPUT54erqlxomIZhKRHJzwT+HooyUuUBT0I6z9zjc8xaYE5Swi4iQDdUhjhd1LzKAgeaSDxNQN/nQ9qW5dDYZOyRqrnKAQ6VstNl/FCotmH4p0gDynRJAMm6c3UqQ7xtW93WUXouDNaeRmn7HiKJFnfN0EnvS7ntiAlZygSTQhVNvdA4A5YWZ7QrHvfXl0cSIkpeI/1PKaehcbw7VzE0fCvUUQU6f11oUhLDsD6BcIOzgTP9+xvFIqAZjICQW0q8QrX38HX5zU4GDy6vMROVub8QurlZmNO1V2CNLAQT7CZV6rSfS0LEVnO/KgbWLhEM2sthEf04t8m4rkPxBX6hcljKyc/P6mTtMy/0uW+Lawz1Fh/U8/AmHYrjcLWo8FJrCnD4bFMJWpgVcV76jv/JYV09RwmaREs0HA9icaFHXHf0Y0ffgRj1w0b9WgMbSdPiqDrSvqU3LkwwWiF4zyD14azB71WyaP8U1MQvcW+t2a/285AKTLtJ6wM4+s4A5FZQIIrJhcge1IK/XxBxRY4S9AN+fU2Z0Enk8lEf7VeoV0kagRN/DRzMGDaLlNOSSK1vpbPRQ+eeGflkpqUV0r0cUYm2BUBayFXPrPKkRr99uqVxPbTLvBhoT+tyftlWGpsC5B6b1XOL30tZyDWeTQZuv472s0JssFXYeUH4j0NAAksYE4rd5tZYX20Byu+KsoRoj5oNSv4gSoEl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199018)(86362001)(31696002)(38100700002)(36756003)(2906002)(66476007)(66946007)(41300700001)(8676002)(4326008)(8936002)(66556008)(5660300002)(53546011)(6506007)(186003)(6512007)(83380400001)(2616005)(26005)(110136005)(6636002)(316002)(478600001)(966005)(6486002)(31686004)(43740500002)(45980500001)(134885004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekMxVmU4RzhsTk16ZDFVbUdydlZ2RHEra0dGM2tzS2VHSnkycjZBZmdDLy8r?=
 =?utf-8?B?VE15V1V0UVFCSFFOQ3ozdmFxY29jdm0xWk5nb3ZUbmNTUmJuT0Y2dFBhWlRR?=
 =?utf-8?B?RXBRVFhOZTlRVlc4UE5VL1psUFhHUUI3TWxKalVVZFBFR3RvRUQrMnE4TCtW?=
 =?utf-8?B?akczYUtWREhnKzU1MDdsMmp4U0gxczdMc3VrWFBheTRrQXlPUzVjelFPd2FU?=
 =?utf-8?B?Q3phUnN5WTVZN0ViSGxvUStoQjV0M1Q5TG5FUVY4c2doOVh0MVF1akdTY0dL?=
 =?utf-8?B?UzVyZEU5TE5wcExRc1ZVUUNjNlpDYldBZTVPbXpxTzh6bkJmYmZoQm9JNitv?=
 =?utf-8?B?aWorbjJUOVhsNEJSUTZPa2lFUjV6L3l3K2R1UVZudms2aHlhSk5pT2xnR2tI?=
 =?utf-8?B?cXFnY242QlBtcmEzMGtUMU1UMG4zZGxpZHIxVi9zeGNQNEVuMjlSWGJoVE1m?=
 =?utf-8?B?NVlOYzg3SzFFQ1BVS05tTldhcXFYdGFWQVc2d0dkYW14OUFLWG9Wcy9xcUtU?=
 =?utf-8?B?WjVEVUk2TENKcDBNcUkvTDY2WVV2Z1ZhdHlkakdyOVJPNDg5bytyWjNtRWhR?=
 =?utf-8?B?VEFaL0pDTUR4S0VpcDBWVzBxUXhjRmdvVlpvNWRGZ0pvM0d2ZjlnYk9pM1hi?=
 =?utf-8?B?aC90ZzdiRWt1N2c1bEF0SjluUHJjOWVkTGV1TjF1SGx0R001bDV6N0JSMlRP?=
 =?utf-8?B?ZFdEcUlsbkFGS3JaSTJrVU9lYnp5VWhmZkx0bHB6ZmgvbFZJZjFTMHJJMXh0?=
 =?utf-8?B?MFdsV0o4cDB2R25GbnBQZksrRk5KUjA2OG1LaXlTV29jR1plZnUrb2JmeDdv?=
 =?utf-8?B?Qkl5V2lUaEpMTXBpay96VDl3SFlyK3U1dWhGMGFwUXhPNGp0VGpEbFJjUlIx?=
 =?utf-8?B?bmhFa2h1bktTRS9nSTV1MWZKMUR3aUhpLzBRQkdZMlA5VERISk1TNUw3Y21s?=
 =?utf-8?B?b3Y2UGlFTDFoYS94Zk5NTktGd21YeFBxMUZRWGdjb2JRZjdKaHdxU3Q3Qy9W?=
 =?utf-8?B?amVMaXU3V2VFci9JeE5oeHpyVStzcHBxS2laYzVMMi9yRHFmdE95S3Y4T29M?=
 =?utf-8?B?ampFVFNKU0pITlNta2Q2emdOSnU3RHlwb0dPQUxYYUNuSFhyam5OSVNCZGIr?=
 =?utf-8?B?cXlTdTlYVTZ3ZXZRRlp4R2FkSjh3WkJ4VUtHNDZrcG9nYnlJd0Q3V2Q3WVV1?=
 =?utf-8?B?WXNrd2xyL3hkbEYyVGRqTlJpR3lrZkZPQVVzRUE3RG1nNHRkdC82VmplcDAz?=
 =?utf-8?B?WjBIS0V4WTBacE9Fd3A2TG9Ma1dHc1BvRVFWU1hsRnBRYkFnRVpiZDIxclM3?=
 =?utf-8?B?NjQrVWRXU0tJLzdrOG4zRkNBa2wxcldiUElFV0VScmxZMDl0QWl1anpMa3By?=
 =?utf-8?B?SHQ2QUtGV3FjcnNlQ0RPaGlzbDNwYnhmMDZJMjFldDI0YzRRT3JOU0dRdzVo?=
 =?utf-8?B?a29lTm1wMkh3Y2JvcXl2eHF4TWp2ZU9ZZkF6dDJKcG9mNGFQc3hJd0VwTUl3?=
 =?utf-8?B?d3E0dHF2TlNyWjBOV21yRW1EaGtOYThUME1OLzRybnpEWDE4d2hDb1JoaUps?=
 =?utf-8?B?K1A4a05sN285b2gwYXJTQndkSk13REp1cDlkNXQ2V0RTWEw5Uld3bEFWUkxn?=
 =?utf-8?B?TnhGREE1QXloQmsxR3FLeTdiV2ViRmJjWWRyb05MTDBpa0trNkM5WHc1OURv?=
 =?utf-8?B?Y1krWmRnOS9WcU5lclEvbTljeVJ2UzFrT0t6UjI5VDAwMTcwWjd2c3VKYVN4?=
 =?utf-8?B?eDNEbXBYQnc0c2VneUl1eVJiMEJKR0ZnRVU2UXdIbXMyWFRwbEcwMmxnbEpK?=
 =?utf-8?B?QTBGWTNhdkFpR3BLSVQvZjVKL2JXdFZlTERmQWxYNG1wU2xHTG9iQTVwWXEw?=
 =?utf-8?B?azFCUmUvSWNwRm9jc3B0U1dlUjR6TzU3MVFDZ1AxS3MzeWtKVGwzTmVtUlFs?=
 =?utf-8?B?V1loWDlnaXg4UGY2cU1NWVZuUFltU1BmbGJjdVVEV1NSODZpYzMxd2JpdW5O?=
 =?utf-8?B?ODhpZGh0M2dWclVqMGdhYjRqTm5GWHF6SW92UGQvSVdFeFQwcUFwS0Z1QWxU?=
 =?utf-8?B?ZGVCbmpsTW9zNlorZWR4UjQ4blAvOHZqaWxVNFIzUlErSDFNVHpKdmlWY0cv?=
 =?utf-8?Q?I2oYcj5YB3CEJOMuTPajpLzKp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1cacb3-0f85-49eb-9e8b-08db1b6852e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:51:48.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpOym5HmDF5heN4qo0hpZIfxM4tyrcMg6AjQMIlILDjBH984n7FhnPmizO/i1Qawe0EDQhYBjCsTh5oegbmYfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/23 13:42, Mario Limonciello wrote:
> Some platforms support using a doorbell to communicate. Export
> this feature for other drivers to utilize as well.
> 
> Link: https://lore.kernel.org/linux-i2c/20220916131854.687371-3-jsd@semihalf.com/
> Suggested-by: Jan Dabros <jsd@semihalf.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * New patch
> ---
>   drivers/crypto/ccp/platform-access.c | 47 ++++++++++++++++++++++++++++
>   drivers/crypto/ccp/sp-dev.h          |  1 +
>   include/linux/psp-platform-access.h  | 15 +++++++++
>   include/linux/psp.h                  |  3 ++
>   4 files changed, 66 insertions(+)
> 
> diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
> index af3a1e97abfe..0763389a2814 100644
> --- a/drivers/crypto/ccp/platform-access.c
> +++ b/drivers/crypto/ccp/platform-access.c
> @@ -135,6 +135,53 @@ int psp_send_platform_access_msg(enum psp_platform_access_msg msg,
>   }
>   EXPORT_SYMBOL_GPL(psp_send_platform_access_msg);
>   
> +int psp_ring_platform_doorbell(enum psp_platform_access_msg msg)
> +{
> +	struct psp_device *psp = psp_get_master_device();
> +	struct psp_platform_access_device *pa_dev;
> +	u32 __iomem *drbl;
> +	u32 drbl_reg;

Lets spell out doorbell for these two variable names.

> +	int ret;
> +
> +	if (!psp || !psp->platform_access_data)
> +		return -ENODEV;
> +
> +	pa_dev = psp->platform_access_data;
> +	drbl = psp->io_regs + pa_dev->vdata->doorbell_reg;
> +
> +	if (!drbl)
> +		return -ENODEV;

This will be non-zero because psp->io_regs will always be non-zero. Maybe 
you meant to check the actual pa_dev->vdata->doorbell_reg value?

I think you should squash this and patch #9 together so that patch #8 just 
works right away.

> +
> +	mutex_lock(&pa_dev->mutex);

Does the doorbell register operate independently from the other registers 
(C2PMSG_28 - C2PMSG_30)? If it does, you could probably just introduce a 
doorbell mutex.

> +
> +	if (check_recovery(drbl)) {
> +		dev_dbg(psp->dev, "in recovery\n");

Maybe a bit more info as to what is "in recovery" (that goes for patch #4, 
too) or just prefix it with "doorbell" (and "platform" in #4) since you 
now have duplicated messages.

> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	if (wait_cmd(drbl)) {
> +		dev_dbg(psp->dev, "not done processing command\n");

Ditto.

Thanks,
Tom

> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	drbl_reg = FIELD_PREP(PSP_DRBL_MSG, msg) | PSP_DRBL_RING;
> +	iowrite32(drbl_reg, drbl);
> +
> +	if (wait_cmd(drbl)) {
> +		ret = -ETIMEDOUT;
> +		goto unlock;
> +	}
> +
> +	ret = 0;
> +unlock:
> +	mutex_unlock(&pa_dev->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(psp_ring_platform_doorbell);
> +
>   void platform_access_dev_destroy(struct psp_device *psp)
>   {
>   	struct psp_platform_access_device *pa_dev = psp->platform_access_data;
> diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
> index 5ec6c219a731..87c0b9350bc2 100644
> --- a/drivers/crypto/ccp/sp-dev.h
> +++ b/drivers/crypto/ccp/sp-dev.h
> @@ -54,6 +54,7 @@ struct tee_vdata {
>   };
>   
>   struct platform_access_vdata {
> +	const unsigned int doorbell_reg;
>   	const unsigned int cmdresp_reg;
>   	const unsigned int cmdbuff_addr_lo_reg;
>   	const unsigned int cmdbuff_addr_hi_reg;
> diff --git a/include/linux/psp-platform-access.h b/include/linux/psp-platform-access.h
> index f5a03cd11f10..1e1d0e077cec 100644
> --- a/include/linux/psp-platform-access.h
> +++ b/include/linux/psp-platform-access.h
> @@ -35,6 +35,21 @@ struct psp_request {
>    */
>   int psp_send_platform_access_msg(enum psp_platform_access_msg, struct psp_request *req);
>   
> +/**
> + * psp_ring_platform_doorbell() - Ring platform doorbell
> + *
> + * This function is intended to be used by drivers outside of ccp to ring the
> + * platform doorbell with a message.
> + *
> + * Returns:
> + *  0:           success
> + *  -%EBUSY:     mailbox in recovery or in use
> + *  -%ENODEV:    driver not bound with PSP device
> + *  -%ETIMEDOUT: request timed out
> + *  -%EIO:       unknown error (see kernel log)
> + */
> +int psp_ring_platform_doorbell(enum psp_platform_access_msg);
> +
>   /**
>    * psp_check_platform_access_status() - Checks whether platform features is ready
>    *
> diff --git a/include/linux/psp.h b/include/linux/psp.h
> index d3424790a70e..92e60aeef21e 100644
> --- a/include/linux/psp.h
> +++ b/include/linux/psp.h
> @@ -23,4 +23,7 @@
>   #define PSP_CMDRESP_RECOVERY	BIT(30)
>   #define PSP_CMDRESP_RESP	BIT(31)
>   
> +#define PSP_DRBL_MSG		PSP_CMDRESP_CMD
> +#define PSP_DRBL_RING		BIT(0)
> +
>   #endif /* __PSP_H */
