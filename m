Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B23370F550
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjEXLct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjEXLcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:32:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7985612E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne1KIKgf8+wNjK0GRVicAGlK6RxaV8u0gbt+sHU7xZwoKOz2hVdvySXUfxZUWMToaeFvY36XRzKYHmDVJrLmAV5UgdblpwIP6fZuA4UE6ixXL6wRIJxLdI2FpREqX4CSq1SCo6MLHWWpivjzo+UslwXVe+LggJU4EvDsCn0D5angyDyuVLbJ1hyXwlGYTHaJ//aOo4ZMMpuLiPI9NjChf8wcXaoiRRTvxn1KCuXTD11vv1Inkgc/IYaXxScLssCtaA3jfldbRn0GUE7h1NglWdVN00VYu7bZt+m7Ez6aw2U3At4JV1uGo2F/1AX6OCgTr8Az2z8uYGHJF0oE2oHzPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqhIyns+dE1SjsAKv/683FeMvtGUrHJ/Vs4luHV9wIA=;
 b=jg0QnmCaNhfTSXbgXjoq7aZbu9KfaEYr0SvjmfQZoo7xmCeVCIz2HqcvHF4lgM2oXRm+UYmwk8NgfKS1yO+fUqwbsaFXoVCPVKwtXv1fUNbWy1bxnP7ar9rEg3w7uPv7tigDpLDfM1zBDoirIumFFBo6QCbdMZaB5HgKSXv3P7yki9mMDC/APodiMidvMPqnnu+Yc8pyDM2093+7mYo7b87clVyyrTSyie2YYUCoY1H4msJVTPhf3bw0nl3A//S7lWkM1JnNcOfOJbuvlogvAvIUBKDVkJwxMbX71/lLUxaeChNCSGvnNXwts8VimwP+RySldnmtDsZ1mBCdtzaGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqhIyns+dE1SjsAKv/683FeMvtGUrHJ/Vs4luHV9wIA=;
 b=aJkK/1+lsU4X8bFBmP/glV3L8o1oWupHBoPjwgmI5+2rlux4prL++hLe6GLloUrbik2ASN298JFoUPg3uzZJvshaXOf6xvlVWKcphfZRnZblivDI1bvA1FPxCcZnratqZLPF5Y62PoipDF4nq3EU0/tD0F6cW2c7ayyM985Jpsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Wed, 24 May
 2023 11:32:42 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8700:a051:2ddf:d350]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8700:a051:2ddf:d350%4]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 11:32:42 +0000
Message-ID: <d5ec5115-b896-c2f4-76c0-18f00e89fbef@amd.com>
Date:   Wed, 24 May 2023 17:07:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 3/9] ASoC: amd: ps: add SoundWire dma driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
 <20230522133122.166841-4-Vijendar.Mukunda@amd.com>
 <0bf45d6e-72bc-d31a-fec5-b52859b8dcae@linux.intel.com>
 <129df804-a05e-47a6-cfa3-cc36282955d1@amd.com>
 <904f47b6-46f4-039c-2019-4ee60ac6d9da@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <904f47b6-46f4-039c-2019-4ee60ac6d9da@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::14) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CH0PR12MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b5525c-35fd-42e8-427f-08db5c4a95f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: genau5M8y8jbkkN2ftpuJbIYLtYHCqt6OH9+iNnShKH3eAyUd4vP/YGK32uVhrjDrln+nGuagut5pg880rxkgw+mrLK95dGmyzPzmqaFN6/DdmzNL83Wcfcn4YT5PfJLx/k7AairJF5C5/Bsg1jrziE/uLjTPr9rb+QDG9D5/WoTQ43pi9KOf8a5KkMRYbLJZ9vKyaetUh7UAmrjsKt5S1vWImBpeJWEzWGISFLT+L/S3uH4amcoDiFm5GNGyyaxK//pLQH+nKPE+lOIG/PcDZiLqP5m1CXmpw7m9Mtf7/3wGzySDOQ504Zm8a5TUqWys8iu+A/3hwJ04YDr+pxod7hpiXt5zsZwI/r6mc6mK3PtdRpjZ72QtzCazdD19xQjiIAMFNkC71HNLX5xS05blGhVWH07L23OvqmPvGThIsGMvq5LpVYX1Hq+thHL/+RC1mE7c8Tj8Dfo+460k1tIX3e8A0Cg1ms0hzLybDkITfWhqXxUV0n+EPS7vPJkDrJ4+0aTBVSh58sdyz5CZZFZWUfh8MjpZzgt5aMXNiAv2ahNHHRIvDIMFOvGYR9M0YrCtJS5dEPSsbqMyGVwvPDrK7u0ykX4E/X/td8Kr8//2vQH/AdqJcJZfEXIrinkLMmN9CfFdZ7TzVDLP3BbPPUi3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(6486002)(6666004)(478600001)(6506007)(6512007)(2616005)(53546011)(26005)(5660300002)(8936002)(8676002)(186003)(2906002)(66476007)(41300700001)(54906003)(66556008)(66946007)(4326008)(316002)(38100700002)(86362001)(36756003)(31696002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHoxUzdNMHJrdDlkQmVzRnl6ZVRCNVpCWkQzV1BSamZYK0d1ejdlRDRLUnMy?=
 =?utf-8?B?TG9FUDY1b3ViUmI3alBId3VBbDNnMzJtTkRNcHB5eTMyY0htRk02dk80U0Mw?=
 =?utf-8?B?OWwzSm4wOWY1WHNBZEJ4RnRIZDk3US9KdTh3L1hUelJpcXBOQ3U3NmhQV1hy?=
 =?utf-8?B?KzI0NmZkdlN6SWVxNTNaNm9vY1dYbURKTFg2UEhvMEVIYWo1cmtHOUF1Zk96?=
 =?utf-8?B?K0N5UFRGVDZoUk5UMEMxSmFMTmlFeFdMWEMwTnFIUzhOWmpBTENNSGNiWEg3?=
 =?utf-8?B?NEFDUWh5bWJYRnErZFhsWjBxbkh3bk5Bb05kaEdXY1c5Y2NZbno5OXVaSHp3?=
 =?utf-8?B?NUVTWHZMYzBGYkZZVHAxSEpPdEEzSGpQbHpqQWxUQVE2RkVxR0tra0t4SXY4?=
 =?utf-8?B?cGswK21XNDhUNVFQSkg1TFZENFkyVUE5K0hoTHdyaEViaXo5Rm1adFAyRldw?=
 =?utf-8?B?UVBqYUpWTFNqVnRlbkVJb3ZPd3BvSWhmV0UxM1Q3ajZYYWpVYUJ4WVQ4aHpj?=
 =?utf-8?B?aWROMTJMTjlBZUl4NVhRcWhpbTJoZGFUMUdIcXIzNVk0TXl5RnVtS01UZkY3?=
 =?utf-8?B?RlhpNkRXNVlYZWUySllHQW03dGFReXZkMjlSZzltdU9wWEdkTXVwV3F4QW1i?=
 =?utf-8?B?RDB1TzFBMjgyTmp3S3l1aENvWERubjU5RTM5dlZicERudnFoTkloaHhuTENa?=
 =?utf-8?B?dDNMZFloL0dPU3k4WCtTNUpVakw1alNVYXFPeEt2WUxRS0hyd0VrWU5YeEJK?=
 =?utf-8?B?TVNmQXdRUUhQV0Y2NDlkU3hsajVzOVptNGd2T0ZBQmhuUE9VNkVhTlQzU3Bl?=
 =?utf-8?B?Q3FhUkNPeDd4VWE1QmozS0gvWFdkancxRnUzYjQwN1FxOWY4Yy9ueEdmNnh2?=
 =?utf-8?B?SnFnbTFOcTRuV0NGcHlQWTZZNmpTU0Z4b21LRWtNdGEwKzBTbXpXcGdHNGdJ?=
 =?utf-8?B?bXIzeEFzOTU2NERBdHlKbHBja0xIUERjNmxTcVFGVzZDUFF2Qk5sOTlwdzNh?=
 =?utf-8?B?LzZvKzQrZ2pOcFM1SVd3WEQ3SlJGb0J2Slpod2d6MTZITmxDN1FZbVhPaVNC?=
 =?utf-8?B?LzBoMHdwTlZsTzhqM3pPU04xNGQzYWtVeTU2UEY2ZlZXcU5NdHlMWWFZQUJC?=
 =?utf-8?B?U3NVZ1htUnZVKzlBREYrUGs1ZFpPN1dXWXlQb3EzM0dFSHQ4bWZzWUtESU9a?=
 =?utf-8?B?cGZldXRSS2kxRGlETWhsaDRUTllrdXRRZ0JoNksvUkJBNnczRFhyMlkxWnQ4?=
 =?utf-8?B?TzZLYXRxK21TcjdHSzl4SW5qQ3dBSG5QclM5NzloeTZLR0pBL05DYnNhRDJi?=
 =?utf-8?B?MDdVeCtqcTVSUjBaTnNYb2laMFoxeFFCczNGRjVETWhjOXlaYUZQcTNXdEhq?=
 =?utf-8?B?S1poV0NvcFpsYnZhUXBkRGhyeS9ZVlVzV1FWbk9Wb3h3QTJPbW1LUWRsVFNm?=
 =?utf-8?B?U29TK2pWbGtjYzJCUzB6QS9Qa3h4WFF1UlViaEJ5dGZLSjk4cytDbFJqVGZw?=
 =?utf-8?B?MGo5aU9tbDM0ZVdNcHYvZGliUGU3NTRWQVpxOFh0MVNoZ1ZtTm1ad1ZGbU0r?=
 =?utf-8?B?U050eVluS3lTM3ZTK3VZOUg1QnRQcWlCeWNRV2lrNTlxSi9rcXJhUitveWNm?=
 =?utf-8?B?TzJzVG1NdXJ6WGFvS3A4YWdLNzJHcXQ1Vy9id2V2L09MUEpFcnJJRm9UQThp?=
 =?utf-8?B?MCsrd3VxTEw3NWZUQjF1eFJRUXhSTGwzZVp4R2RubWwwRzcwSFlTTmo2eDhE?=
 =?utf-8?B?bjFvMlpYbHZHakdldEgrZ2NPakhNTXdwOEtiNjRtSVVKbFJBdTFCR0ZCZGxD?=
 =?utf-8?B?Zm9RUkp0NFRTeEhVVzZlbEt5S2UyYWx1Y2pvOXZOTmIvMFJEMERVUUd6V0F1?=
 =?utf-8?B?TkUvK3RPUzQ3eWJHam1URkkyTVB2U1Nsdlc3c2l5UXVvYVVkVlVaNENWSFZx?=
 =?utf-8?B?Qnc0NU90dVFpVmhYY2Q3bExlQ1BKMHd0K2ZJYmQ5dHZIeFFmZTFONHJmRkxV?=
 =?utf-8?B?ekRVbzVSVVUzL2lFNW5CcFh6M3ZGVXRaSzMwVzJvTEplOTIwWkswa0pTb1NN?=
 =?utf-8?B?aDBDTURkMUZiQW1xUlMzQThHSTBtVzBPck1VT2dWUmV5SnhEeDB1L1hKY09J?=
 =?utf-8?Q?oszqjnblvca6ojKs0eEuInkCb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b5525c-35fd-42e8-427f-08db5c4a95f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 11:32:42.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STT5C/uVOMq4jHDcvc9HNQ8P1pxeEzUdetQOr82cYRarThE9tNbXZnDR/AYjv2kUH4ZfEQwyrjPBIFb2O3OUqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5330
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/23 20:18, Pierre-Louis Bossart wrote:
>
>
>>>> +struct sdw_dma_dev_data {
>>>> +	void __iomem *acp_base;
>>>> +	struct mutex *acp_lock; /* used to protect acp common register access */
>>>> +};
>>>> +
>>>>  /**
>>>>   * struct acp63_dev_data - acp pci driver context
>>>>   * @acp63_base: acp mmio base
>>>> diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
>>>> new file mode 100644
>>>> index 000000000000..f41849fd035c
>>>> --- /dev/null
>>>> +++ b/sound/soc/amd/ps/ps-sdw-dma.c
>>>> @@ -0,0 +1,70 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * AMD ALSA SoC Pink Sardine SoundWire DMA Driver
>>>> + *
>>>> + * Copyright 2023 Advanced Micro Devices, Inc.
>>>> + */
>>>> +
>>>> +#include <linux/err.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <sound/pcm_params.h>
>>>> +#include <sound/soc.h>
>>>> +#include <sound/soc-dai.h>
>>>> +#include "acp63.h"
>>>> +
>>>> +#define DRV_NAME "amd_ps_sdw_dma"
>>>> +
>>>> +static const struct snd_soc_component_driver acp63_sdw_component = {
>>>> +	.name		= DRV_NAME,
>>>> +};
>>>> +
>>>> +static int acp63_sdw_platform_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct resource *res;
>>>> +	struct sdw_dma_dev_data *sdw_data;
>>>> +	int status;
>>>> +
>>>> +	if (!pdev->dev.platform_data) {
>>>> +		dev_err(&pdev->dev, "platform_data not retrieved\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +	if (!res) {
>>>> +		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	sdw_data = devm_kzalloc(&pdev->dev, sizeof(*sdw_data), GFP_KERNEL);
>>>> +	if (!sdw_data)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	sdw_data->acp_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>>>> +	if (!sdw_data->acp_base)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	sdw_data->acp_lock = pdev->dev.platform_data;
>>> so you are sharing the same lock between parent and child platform device?
>> Initially, we thought of sharing the same lock between parent and child
>> platform devices. Later we have observed, mutex hang issues observed.
> If the goal is a global lock, then the platform data should contain a
> pointer to the lock. We used this for Intel, see .e.g. the shim_mask in
> drivers/soundwire/intel_init.c, where the same pointer is used by all
> children.
We want to have common lock for Soundwire manager instances only.
>> We have avoided critical section code and removed acp_lock from
>> ACP SoundWire DMA driver while accessing ACP common registers.
>> We will remove mutex lock from ACP SoundWire DMA driver code.
>>> Does this work? IIRC the platform_data is copied, you do not point
>>> directly to the initial data provided by the parent. We had issues with
>>> SoundWire when we used platform devices, with the 'wrong' pointer used.
>> Till now, we haven't observed mutex hang issues due to
>> ACP PDM driver mutex lock changes.
>> Agreed. We will remove the mutex code from ACP PDM driver as
>> well and we will refactor code.
>> In SoundWire manager driver, we are sharing the same copy for two
>> manager instances. We haven't observed any issue.
> What's the benefit of passing this lock as platform_data, if the goal is
> to perform mutual exclusion between the two manager instances? Why not
> just create the lock as part of the SoundWire probe?
>
> If there was no need for a lock, then please remove it :-)
>
> If it's needed, please describe what it protects, which agents rely on
> it and how the lock is shared.
>
There is a small correction.

We are passing address of the mutex variable (acp_lock) which is part
of ACP PCI driver data structure as a platform data to child platform devices
and accessing it by pointer reference in SoundWire manager driver.
It's not required to drop code changes specific to SoundWire manager
platform device resource structure.

Our intention is to have a common lock for different SoundWire
manager instances, which protects accessing ACP common registers in
SoundWire manager driver.

Even though platform data creates its own copy for each platform device,
as we are passing the address of the mutex, and referencing it by pointer
in SoundWire manager driver, it works as global lock for SoundWire
manager instances.

We will remove the acp_lock code changes in ACP PDM driver
and SoundWire DMA driver.
>>> The documentation does make mention of a copy....
>>>
>>> /**
>>>  * platform_device_add_data - add platform-specific data to a platform
>>> device
>>>  * @pdev: platform device allocated by platform_device_alloc to add
>>> resources to
>>>  * @data: platform specific data for this platform device
>>>  * @size: size of platform specific data
>>>  *
>>>  * Add a copy of platform specific data to the platform device's
>>>  * platform_data pointer.  The memory associated with the platform data
>>>  * will be freed when the platform device is released.
>>>  */
>>>> +	dev_set_drvdata(&pdev->dev, sdw_data);
>>>> +	status = devm_snd_soc_register_component(&pdev->dev,
>>>> +						 &acp63_sdw_component,
>>>> +						 NULL, 0);
>>>> +	if (status)
>>>> +		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
>>>> +
>>>> +	return status;
>>>> +}

