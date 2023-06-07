Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997AF725D8A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbjFGLq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbjFGLqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:46:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B4219D;
        Wed,  7 Jun 2023 04:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXG14cNZW93Z8hlVl26XxNi3B5aRV8s8YZV0OyOkmtlIylEW02uBi5kflTaLDD68B7ke5gPfCSqeTrtHMvsKgSVjRepXBi4cANuUL3kf1dLo/ikPKfr9r0Zy+1GpzJwX/tnJJsqdE68t8uSv4mssHjLsv8H2uIMbJg3I0tmNtQj6d1ItQIzZDTA6CLfw6aGDDuWMwLMITKd3fRKuwqKXQSYmDCHaVr0rYXpoA1m0zY5XIweMj1ReZzxlHpODJKWxICn90eLIhOPif1JsyWvhYmndsvE79RLAdatyQjheTy3biigaE3/fKf5yzNWTXO+srYAfGwwpCjC2lTiMhDZ9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpSVSWxtxcp8Zw+xN9C0wGkly02Ma3PR8DxbjICNKRc=;
 b=NtQuUk+vx/agNNKctH0ccRyPRbvS8TKk1rM7SwDRK9nOTL2KBDvCew8VD+DnkcL7b5Q4A6Xy2/h1I9MuQ6gK3CAbMTrJk4Kx7CL4PMB5SM53Llv1EtKLOb+uSPB9agLsuUSl7qgYWjmVsw6Sl3Zmqh5ra6DIgZ4UY26k57TfjkqZXF51xwW4YyZp2E3z8v3LqFOYcwOHryGo3JBB5iOckxc+C9O9To/DzEWyLs+c3KiH478B+SS/P3VYB1Z62ycNaeiplBVVFxAD5vNNAgBoOsjMKKNMrJWRvrFqPyfSP2eWd0Ri2qzBavR1VR0bwtUtKW+V5aDBea/G1vZviPwSBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpSVSWxtxcp8Zw+xN9C0wGkly02Ma3PR8DxbjICNKRc=;
 b=p5iMWE2kyMSaHDuGreR5/KV8YmCgQpZthlUbFVEorx8Jbuc1vcdynJfNTuSX7PT0dOIFqZ47GDSaib8FyYw9M0pETIeHGVpsuTdBt8yxp70t6VK9uT9sQqA9q+7yi28sQaSi6dw83MEXvGb7tCLHvCwTWHXU5j9R0mIY03Rc9kErNTupBR05zqpRpa3jcFvRlGpVvePNAynJjRVVFvtSMallkDUyRNb9prFIw4DYXJWS2xUVhLPBpuRTqGG6VeJnuwlHQrybvg2TUbFSr25d75dDqMn7pxvYaK2ZX0TPdvNnRyY7DvuZ1+32DLQ08n7QTWd7XYSLuJ4zZrilwmiSGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 11:46:49 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8%4]) with mapi id 15.20.6455.037; Wed, 7 Jun 2023
 11:46:49 +0000
Message-ID: <51d00894-301f-6e0f-785e-3ff3a17a635f@nvidia.com>
Date:   Wed, 7 Jun 2023 12:46:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] gpio: tegra186: Check PMC driver status before any
 request
Content-Language: en-US
To:     Prathamesh Shete <pshete@nvidia.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     smangipudi@nvidia.com, Manish Bhardwaj <mbhardwaj@nvidia.com>
References: <496889ff-dd61-51af-c716-b9b9e2300be7@nvidia.com>
 <20230607113104.11761-1-pshete@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230607113104.11761-1-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0535.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 5982cf84-438c-44cc-a079-08db674ce0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5mFMNmSPIi7Y/U+46FqcidnZNmE9Ct44uZAZj1+CzKp3yr/jKxeWGvdKNM/3eRuHqvel/X5BEkOas5+aLMQTl6EVP0SLe8GIspJX39+Cju8584CvpZeDx/w8t3cqL3lWxvIXErRsRsZDolAqtiQb4IKW+4gQZs9HH5RiYaPPJbbhhcjFzBkhrZ4+Dz3ZGvp5wK/exmJ/1kz0Vl7otY//Ya7y5DqJcGtAYMj0NuCObNTe6o1YXXB/bSRaobfBOEIWUDDUjlow5dqLcClRW664/UpxcG6F+Wm2IYGfdaQZPKD2UevItKrN92tjlCTzNC2qNjzpcm2x/HWfPhZ4wHbIJbaLY1Gqx+N23AHHndyWtmnp5MaIwRq9/clIXXTQ9yJcxc05gHHYDp4XpQBqtU3cYqx68rpikJ3TaVCyDWiKNJ/QwvNo29XC37u48mYMuyI8JLizY2yklquhj84b1iOrJB4j12i7v+8sQIsscGTEDBShTDYM0hg4oHZ8USl49fFYoXfl5N6LP/DKGepTDfQm8njOu6w2yHfHXqXkTqkMWCVqh51JRQHXzlKPPR5R7qDBirQEFb2gNNK5sQ21ZsHNhmGb3NKEI7obnbKmB3gri2mJ8TL+WrKtyl/YQZ/YjqpqZdvTCtHGtRelx5XJLYlGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199021)(86362001)(478600001)(6666004)(186003)(2616005)(6512007)(6506007)(53546011)(107886003)(6486002)(36756003)(2906002)(83380400001)(8936002)(38100700002)(4326008)(5660300002)(66476007)(31696002)(66946007)(8676002)(66556008)(41300700001)(31686004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTY1dldabW4wS0NBcDRucUhkY0hLdndBdDEzV1BFWXdXZHZyd1dHVjJrcUFO?=
 =?utf-8?B?em93SHF3dUdLd3RVU0E1RlFPUDBEM0orVW1Zek1ocHgwdGMydklyTEh2cW1v?=
 =?utf-8?B?RVU1VitlMmYzdkpGa0kvNEgzUlFxZVZpSnBXMExFbC82TnQzbDBrSWZ1ZGVH?=
 =?utf-8?B?cndjUTJpanFCWmNmMVEvTEQxWkZOc1Zyb3V1OWhnb0NqOWJtbnJUWTBaTTIx?=
 =?utf-8?B?SEIyRzkydWVsYm9VWXFTK3BhNS9yQ3FEWEtyb3g5ckU1MWpaSDlGTVB3OXBH?=
 =?utf-8?B?c3FHU0cwRnU5UFMzUVdyUms2cjJ6LzJsVEVuU3BFUWdZa3laMlJmelNHRm1a?=
 =?utf-8?B?dmk1Ulc5RDlXWFV1b2xmYVQwR3gzTVJFLzVsOEJaTVBwMmJMd0s2RFBLczBo?=
 =?utf-8?B?eklKaVFmL0s2amdETFQvcCtSc0FOS2JmQUVRcmJORWlKeUp6Ny9KVWE0dWw4?=
 =?utf-8?B?R1IraXhaN0pueXRxMkpYV2ZHTzN6T09KdEhoeC9zNGhvWWNNbDlSSFIyNXlt?=
 =?utf-8?B?NC96Vlc2enNvdVhoU0hJdER4MmZ0bldYd2ozOVlXNVJseGFmMU9NcnhXSHIy?=
 =?utf-8?B?aEdmYTNvVWxPWmdzenN5a0JYb255N3dvdjVFMEtsYnl0WHdjekVCUnJYM0pN?=
 =?utf-8?B?WmdpZHZZYU5YZXgzWUVqYmhhbDhlM09SU3YrNDgrVHdDSVR3a3R1ZjN0YU5n?=
 =?utf-8?B?UjJyaUJGdlN0ZElMVlk4TjVFdTdSbXNCTFBjbWFXdWk2UloyZ0kyVVBjS2hF?=
 =?utf-8?B?bmRUTlFPMlE0ODIyZFJsZitGRzJlRnF0OG91SEtmeG12NTFJeWhmV3J3MVU0?=
 =?utf-8?B?akUxU3VSYWFMOVdSSWR3T1ZlL3Fna0hKNGFNeTkrK3VxdHJKSk0zblpXNTMr?=
 =?utf-8?B?N2ZGODg2RWxOcmZuR2tPc1NGSmlFczlmS3VrNVUrMWtOQjl4R2dyQ2p2bzRl?=
 =?utf-8?B?cm4zbDMxbCtKSkVBaGtFWURkVkJwVi9BbStoVnYwN05vQmh1bWNNK0xPaG1Z?=
 =?utf-8?B?YUdWRzJMWkoyS0EzclF2K0tmOEVMUEpHaWJ5Q0FPUVl0THZ6YWc4K3FmbitD?=
 =?utf-8?B?YTk1MUkrVy84U20rSE5tUGQvNy95TDlWT1ZXcHZGZERrbHJBSHAzc2UrUHlh?=
 =?utf-8?B?c1pqMzNUZ0RBamtWRG5vNk5jbEVrU1V0cGdpNU1CR0NlYU13aXR4Qnp5QjQ2?=
 =?utf-8?B?RVppNzBoazZac3lFWTlFdDUxYm9PSDFZSWF4TTJDV0RvbVBXM2lLUVNRSWhF?=
 =?utf-8?B?WEpEVG9TaHJYQWYrOGRidjhHVTAzWFpBNFRpRGVKOFg2K3NkdUFKcjdTQW9M?=
 =?utf-8?B?ZXJCRE5USEZmSzRoTFVsZEd1ZEt1blNHc05BMFlVeUhvSG1zeUxUV0FWNFFQ?=
 =?utf-8?B?WVdsZ2R5MTBFNEh3NHRvQmpxRlJBdk1Xd1pkRllKQXRzbkk2Wi9kT1BUc1pY?=
 =?utf-8?B?NWZ6VFM4Nkd1RXhBOUViVXlHU2xUM3pscUg0aFZYbzhPWDJOUmt2bW5MdjR0?=
 =?utf-8?B?ODA0Y3Zzb3VPZVNFWVBBZEFHcXo1K1B3eWd3aGhad3dFQ20zdjIxbVoyQkxv?=
 =?utf-8?B?N1lPZDgwbUQ2eWlXRXhwajFZaXpQSFozcWtnSW9ienpQR01JVGFNMjQwTTND?=
 =?utf-8?B?ZlJTTGErVk01T3ZIZHZsVG9VYWEyd1A5UCswNmtBS1FhejZxUDhlYU9rci9i?=
 =?utf-8?B?OHB4bXN1SHpQQ05YR3RqeGtHeGUwdzI2eURqWkZldFhJVlFNZnZqUytOUmVD?=
 =?utf-8?B?TUFzd2dyZml2TElKYzBhbXY4SDhQZEtDbDN4b0FDdTh3NzkvVVRoRmFwY1Rk?=
 =?utf-8?B?b0N3WSt3eUR6eEsvTG1PUE9KT2R1R1hONVlpcmptTUxrQ3U3VUcvL25paXhQ?=
 =?utf-8?B?RXFvcG5LY3czTlpacldQRjk4QTFaQXJRaUZIMjJ1bDk0Q2lVb3hqZHRIaDVi?=
 =?utf-8?B?QzRLNzlLcTNqSldycjd5ck5nbS9PS3ZRcjQxN0U3Qml2SHRiY2tJQ2FWUkEw?=
 =?utf-8?B?MTJYVWJkTEV4Z1BRTGpkSkpCNnRqa3FGQ05ZMEpUbkU2QVZwbUk3Y1VyNDRX?=
 =?utf-8?B?NmRlVDJHaDlaVi83ejZmWmtzMmR1alloUXgzNFoyTzlza1k2ZUZJVW5ldDVT?=
 =?utf-8?B?OWRTRm4xMW9FU00xVjVKTE9POHJFYXRwSndaWG91NEpVZFo0djVObWlUNllG?=
 =?utf-8?B?R3pENXVzYWEvUTZkOXN0UFZES2g2ekllTWhhMnE4MVAzeTk4bFNONndSdjkz?=
 =?utf-8?B?dzVLTmNqcE9rWGJNS0U2M0lIeUZBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5982cf84-438c-44cc-a079-08db674ce0fc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 11:46:49.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyqnKzlgDqRGuG/sVno2fP6VIIRqH4fIGMXwrF6gq/sdZxSucMLW2ucRK2AHDf5qf4usUYRQvhTLMJWzt9zWuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/06/2023 12:31, Prathamesh Shete wrote:
> When the PMC device is disabled, probing of the Tegra186 GPIO driver
> fails because the IRQ domain that is registered by the PMC driver is
> not found. The PMC IRQ domain is only used for wake-up and does not
> impact GPIO functionality in general. Therefore, if the PMC device is
> disabled, skip looking up the PMC IRQ domain to allow the GPIO driver
> to be probed.
> 
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>   drivers/gpio/gpio-tegra186.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
> index 464b0ea3b6f1..80d08ddde40e 100644
> --- a/drivers/gpio/gpio-tegra186.c
> +++ b/drivers/gpio/gpio-tegra186.c
> @@ -964,11 +964,15 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
>   
>   	np = of_find_matching_node(NULL, tegra186_pmc_of_match);
>   	if (np) {
> -		irq->parent_domain = irq_find_host(np);
> -		of_node_put(np);
> -
> -		if (!irq->parent_domain)
> -			return -EPROBE_DEFER;
> +		if (of_device_is_available(np)) {
> +			irq->parent_domain = irq_find_host(np);
> +			of_node_put(np);
> +
> +			if (!irq->parent_domain)
> +				return -EPROBE_DEFER;
> +		} else {
> +			of_node_put(np);
> +		}
>   	}
>   
>   	irq->map = devm_kcalloc(&pdev->dev, gpio->gpio.ngpio,

Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
