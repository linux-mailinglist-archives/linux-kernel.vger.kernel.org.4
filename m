Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F39666DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbjALJPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbjALJND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:13:03 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3788B532A1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:07:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3ZTzzHzQ60eN8JzTNI6WGlKhgoON/XKXvdhmylPOXf+kFOlCOBrZDHNuMiwjdd6W+B5WoBg/Pww+Sqm8b5aEZW6sxUW0zPEmwJmDmpxmWuM2A/kpVs9teJcqu01+5io2T4+k0105CU+Z6NlUmsxsVM60IJwcZTuXXU+pBZfH7/vFAn49Yw16VLEeOxAWY08WAMThSdxusZEzuSj7g2gbwd/Y8q11f1Yk0owSq7PapYWxWzrT/mpocPfN/W1cUWhG1cX0ZOLXgKGpLUCvHIoYaQ6lw1oSADUlZAC2901fdc9C8aPRB5TKZnapI0nLJ8Ils3XTN/p8XM5CEyfc+T5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKT6wRoKTFn4CLyNhDr6ytEbb8ymie4TIn1dKMeLn5w=;
 b=XyHcuCzb8WrfABCVea/OVKVVMPZsSz300i3b+GYylMJbq/lFS90KQ0rY3mVWMC1csWQ3JC1fXikz6VCucWS8qN5oJCnnrjkp02pd24mILnHnwpRqyaY4IvRHNyyH7YxR7VleGKyMOhc2dr600emAgpPxlq6PK2uVcEZx/Ggl7ZOU01pXZUDlJiP90KkBQT9s6P1cimFWz8YrrZrM0F7ALbAPb0vupjQ0K/Qv7BdXBDGFMun4GgcYqqM4RcY5xm4VD9umHuahviUFmI3/95iuC4uUuIPHsSAU3+O2M5Wu4fAF9jilwoqNcXIFHKhZRK1aR4XQB4tFNbmNuaAYQykAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKT6wRoKTFn4CLyNhDr6ytEbb8ymie4TIn1dKMeLn5w=;
 b=AfCw5HdHToOskmdelYGwhLxmu9vqsdu5GRSNCTtlMGY9+VZlX6SD41szYwk4DUirQk2Z5QN/4Xk1pEak22pKeiEAq2kdPU5TDRLwzHYPHjyJtR8BTuORt36/yuds2ckqNIfreIgsyisJRKVWzHfvofnBj6FncGCBmccxF7aZVgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 09:07:17 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%5]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 09:07:17 +0000
Message-ID: <6bdd5698-6a05-a99d-f751-1cf08a59764d@amd.com>
Date:   Thu, 12 Jan 2023 14:40:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 07/19] ASoC: amd: ps: add soundwire dma driver for pink
 sardine platform
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mario.Limonciello@amd.com,
        arungopal.kondaveeti@amd.com,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-8-Vijendar.Mukunda@amd.com>
 <6a0fa6bd-efb0-9363-4c8d-0e919992557f@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <6a0fa6bd-efb0-9363-4c8d-0e919992557f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::8) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 56fcabb9-4413-4bca-2edd-08daf47c671e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQ9e6oI8cQxQaar6nX/kKqzroMDO5DbsdHsSxOgHsU0SqjDF0f4e6EXVzzif5d1XFU+rTku+H76fvmp64DloSP0jp9pY+rVpuA/czRY0CI4hD3IIJX/yfkiN3YrJl1xJc4uZ0vSX8AUd0lsU5+0mLyCkIDQS64thB6CPIH/Rb91ksLnc+EAOdoveg7kO8jwNXpK2xXZ7AnbW/PblyWM+W3FEb3VXFznOxhSesZhrGGoBr096OfUqhkw8geecnbd0MJwHy/8lP2MX09irq82LPLsWGhG0xuBbK48Pu2DIrZ5BRzOHweROinaOyfV+j0whTTIx7K1IgW5DLtXrGanER/VhccEHcFn7JVv5Xp0GPdAusfV6FLgfuxi/1CDLsAqzA0XcKGpndtVkXIuxBkYArgyWsL3yJOR8oQTVFbkugLDYru6jpTrKTSPwmbamnNlUdw0DYiZj4ymvDazpTHgKqzIL3YZaZUgsRYbFLLb2IJz2ZBV7HBfwaHWsH4aPyWCUtZbB5yID28AK/FeUz3TRkLkKsausATwkibu67YNQEDwP0PRW8XONFBWrU8et2ic5itVfqwRbJSCwY4mNrqeQq0MYX8z5FSAyoft1QxWojnvmaRc9mlvJ6coWxb/CU4mPsNiCLY7SmkKnxOZtYOLPDvcefc3I/zE/qtJG3QSJgtQHPA8NL5U1MHet02xrfmGQdzmLbEby24MfIf1ovYGm2vTjJ7ngJ0uj+gNZsmDV8WY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(41300700001)(54906003)(36756003)(4326008)(316002)(66556008)(2616005)(66946007)(8676002)(66476007)(86362001)(31696002)(8936002)(5660300002)(38100700002)(83380400001)(2906002)(6506007)(53546011)(31686004)(6486002)(6512007)(186003)(26005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3o3K2tCaHY5UmcvZ2xkL1VsTm1Yd3ZZVlk1VEJpMnpYQlFrQVIvSnhEMGJy?=
 =?utf-8?B?Nk9VS0REWlIzQ1U4akJHMklHMFpXTElMN1J5NTl3SXRQVnJRWjRJc0Q5N3dv?=
 =?utf-8?B?cTA1MnFXRXBWU1ltL2RZNVFRb0QzbHhBM3FUQ0trYUMrelVNS01iSG5WMS9O?=
 =?utf-8?B?eC93eGtYeDBqTFJaR0ZQRWM5RGpQcEgwUFV3L0VFbUhWZ3drek1IbXJrYzZi?=
 =?utf-8?B?TUV2bHBGVUllRTFMNGk4OGk5R05yV2JjQ2FUT1pDQ2luekJDOEVuV21TUlN6?=
 =?utf-8?B?Rk5TamhXaGU5L2xxbENkOFBzanhNaUEwQUhISG1wR3kvQkl3ZHdUQjdVK0JE?=
 =?utf-8?B?Wkw0bDdZYnVUZmNIam5OdmNMMm9ZQ2tCTDZ2Z3dGMXFkeHFMaU9QTTBZZUhF?=
 =?utf-8?B?elF2M1A1QWtlK1VWdytXdDB2UzdnVFdBTDB5NUN4TjBNa3dhdDFFR1duYjZQ?=
 =?utf-8?B?eEdmTlptVkV5aVNOYVhiVkNkSDdxUFRIOWFqWkpJRjVqQWlraDcrZzVBNGtm?=
 =?utf-8?B?YjV4cjdLdjREc3dsa1ZHWHExSmdtVElZSVhoUlV6dzY5cGlETjBzUTNKUmxJ?=
 =?utf-8?B?Q254ZlVhSlhNaXVQVCtqVXZ0UXNJclZ6WGdSQ01QVzNydnB1Y0syUlg4TUFk?=
 =?utf-8?B?azBWSkhuOWw5S2crRVNhSFVRSlNrQ3VDYnErTXNocVJjUWxqbkFrNXBLNC9V?=
 =?utf-8?B?bXpXaVgyeXpyL1ZNRUlzTEVxN0w2TTFSemVuUzYvcnVGeFZPWjBEQkFJNkY2?=
 =?utf-8?B?UzdYRllzR2xzUTVQVjV4cGwybUMvMzlIY21oU2xrRm9zaGp3bmJoRHUvOURM?=
 =?utf-8?B?VGJFeUYrWlgxV2tjbURzbklwbzBRTDFWOUcxbnlPU1EzanhnYkk0SFRTWkFM?=
 =?utf-8?B?TFVaYzZkblB0M1RJbjcrdDJJYXNIV0wwUkhjSVJmRWRmTmFoWWRZSnQ3RUV0?=
 =?utf-8?B?ajR1VU5hcFVyN3AvY1hZSCt4cCt6QXBqdTloamxBaWRmcGNWWFpiMjVOaFdv?=
 =?utf-8?B?QTFkWnlDdXF5YS8wVm5qckZNNzlhb1BLUldySmtiK3Mzd0xWMjEzQlMxd21s?=
 =?utf-8?B?RHA2NTBZeFdtZ0NCWFVuQWs2WmJ0bmRESnducG9DSXV4U3Fqb21KdmFhTCtT?=
 =?utf-8?B?YmxaaDZqZjhQTDdJa1pLdmtBZ2tpN0xpZ2VOVDFIVDIybEF2alZSNzFNRWQ3?=
 =?utf-8?B?TmxsU3B3NnF5dTFyODMzYWkwWk9qR01HQWIzOFZsb1dXM09LMkcremM0a1dx?=
 =?utf-8?B?M3NhUkI4NDNnUituTDJTYmMrVWlMVjJKb0tqVFdsbCtFRXU2SCtJL2VDczBq?=
 =?utf-8?B?MGJjUHJkS3BtNkt6QWpJQ0N4RUtxN1VSTGhpdWp5UU5tRnFoUldjOVdqaXdu?=
 =?utf-8?B?N0RuUFZuK2ZWajJ5eElvb09ZK2x4MHdUb3I5bmpacVFxcFFPb1ZxNlNMcWcz?=
 =?utf-8?B?RDBLdnE2eUtpVkhrWEpxajBuM00xRFhsTS9hMnFBTGpDUmpXbzNvN3pweEZo?=
 =?utf-8?B?MmFVMnZkbUZmTUlHallXTFQwTHlMVVZqakNkTHduUWNOc3ZIY29ya2FrUmxq?=
 =?utf-8?B?Y0xzVkN6UGp0QUhib2JXcmxwbDZmNS84SkZJSnN3RU5sVHJnbGloWStuN3Qy?=
 =?utf-8?B?VkRTYVUxR2toeHN4a1ViUWdKTGRLejNVZmpEWTVSWTE5eXJGMVdUY1N1Zytr?=
 =?utf-8?B?RkUrTXB1UGJrNHd4emk5UHBQRmRBZnNKMklBOVlmS2ZEWVFXNFc5M25tbEJS?=
 =?utf-8?B?MTZtajdDRmpGRnpvZndnYmh1MVBqeCt6RWRyTkY3Kzc2cDI0eVM5bmZmZ3Bw?=
 =?utf-8?B?QU5FNlNKaVVLWWFkYW40Y1h5NGhYejR5aEQ5cGcrNTd3M0N4UXl3Z3BBelJa?=
 =?utf-8?B?NzRvYjE5Z3VRVTVDaDNXWHgrMkV5aG1pQjNiNFVGM01WbnFUM01tK1dLWGN5?=
 =?utf-8?B?NlNhYWx0YjZ6VkhQdkFwc2ZCRXVTNks3aEh5UDBxb2V2T1doaXZPUVRCZnE2?=
 =?utf-8?B?dzkrRmUzQ0g5MjZMYXdTaDRZMEoyL0RPN3RTQUVQS2dna0NNbDBxMm4ySmRr?=
 =?utf-8?B?Rm4xYTcrM2kyWkJYeXA5K29KVGdhR2ZVbGRxV1B4TEdXRVdLU3huMWVvWHpW?=
 =?utf-8?Q?B+5FFPOW179ItmB4V8Rwyetms?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fcabb9-4413-4bca-2edd-08daf47c671e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 09:07:17.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbiAmYr6ToObkVMtY/YvKTjg4DbZtp8M3zW7B4RRQaoMxCvqEB9ul49A0xJLJVew/2tc0hiCpT14WO2Xs/FjMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/23 20:52, Pierre-Louis Bossart wrote:
>
> On 1/11/23 03:02, Vijendar Mukunda wrote:
>> Soundwire DMA platform driver binds to the platform device created by
>> ACP PCI device. Soundwire DMA driver registers ALSA DMA component
>> with ASoC framework.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  sound/soc/amd/ps/acp63.h      |  5 +++
>>  sound/soc/amd/ps/ps-sdw-dma.c | 72 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 77 insertions(+)
>>  create mode 100644 sound/soc/amd/ps/ps-sdw-dma.c
>>
>> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
>> index 0bd9dc363461..b462320fdf2a 100644
>> --- a/sound/soc/amd/ps/acp63.h
>> +++ b/sound/soc/amd/ps/acp63.h
>> @@ -135,3 +135,8 @@ struct acp63_dev_data {
>>  	bool is_sdw_dev;
>>  	bool acp_sdw_power_off;
>>  };
>> +
>> +struct sdw_dma_dev_data {
>> +	void __iomem *acp_base;
>> +	struct mutex *acp_lock;
>> +};
>> diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
>> new file mode 100644
>> index 000000000000..388a4b7df715
>> --- /dev/null
>> +++ b/sound/soc/amd/ps/ps-sdw-dma.c
>> @@ -0,0 +1,72 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * AMD ALSA SoC Pink Sardine Soundwire DMA Driver
>> + *
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/soc.h>
>> +#include <sound/soc-dai.h>
>> +#include "acp63.h"
>> +
>> +#define DRV_NAME "amd_ps_sdw_dma"
>> +
>> +static const struct snd_soc_component_driver acp63_sdw_component = {
>> +	.name		= DRV_NAME,
>> +};
>> +
>> +static int acp63_sdw_platform_probe(struct platform_device *pdev)
>> +{
>> +	struct resource *res;
>> +	struct sdw_dma_dev_data *sdw_data;
>> +	int status;
>> +
>> +	if (!pdev->dev.platform_data) {
>> +		dev_err(&pdev->dev, "platform_data not retrieved\n");
>> +		return -ENODEV;
>> +	}
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	sdw_data = devm_kzalloc(&pdev->dev, sizeof(*sdw_data), GFP_KERNEL);
>> +	if (!sdw_data)
>> +		return -ENOMEM;
>> +
>> +	sdw_data->acp_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>> +	if (!sdw_data->acp_base)
>> +		return -ENOMEM;
>> +
>> +	sdw_data->acp_lock = pdev->dev.platform_data;
>> +	dev_set_drvdata(&pdev->dev, sdw_data);
>> +	status = devm_snd_soc_register_component(&pdev->dev,
>> +						 &acp63_sdw_component,
>> +						 NULL, 0);
>> +	if (status) {
>> +		dev_err(&pdev->dev, "Fail to register acp pdm dai\n");
> not sure what this means? Are you registering a PDM component or a DMA one?
It's my bad. We will correct the log statement.
>
>> +
>> +		return -ENODEV;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver acp63_sdw_dma_driver = {
>> +	.probe = acp63_sdw_platform_probe,
>> +	.driver = {
>> +		.name = "amd_ps_sdw_dma",
>> +	},
>> +};
>> +
>> +module_platform_driver(acp63_sdw_dma_driver);
>> +
>> +MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
>> +MODULE_DESCRIPTION("AMD ACP6.3 PS SDW DMA Driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:" DRV_NAME);

