Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B65705FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjEQGZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjEQGYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:24:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FF61FE7
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaICkbGeFsOBHgjFBc7/v426R6ZsUFz66LqwFLRtnxgbwlB7chTZjjnURzn3955nhD4WczroR9lvAgvY2yNF6cfxX7QNrYArmspk99GLrF050SqpZgHNQv9tLdd8Oe2W6eeSWlEYJb3HRTXIluTJfF0o1exGPnwa25uBi6cx9C1wEUJy0SsTJX55m0Ailw0YKc9jpINg0TC8nSzC7olfNj4PRdUsLVfXFEBc41Yi5qTtn+42z+ixU+G+bGjAkFxjOU5gM3446CKC9YRZp+7rCTobe6ZHHI0rmjcuVQxbC6IfWo2P4Xc7Z40ZtsyeALiYVuRiqqU1rHjvewLWJyzdVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTbcCH24z1+mfcRVLvEPPUU4gB2/kGGJeOAWNPZhFs4=;
 b=QQe4gYWZrWKr9HLrnJrBjZJUe2QAZi4egOrGzvZopKg2lDA+bvLA7qkTeiv7Epndod5FHUYPAPrcpWjqblQNSFYvE1Jv0q5chUveSoK2zVyfta+uPjEVAU9oWd+OgzKU16POHWVLCW/dbyG7nOO9Z/619tn+oRpCmq5rOUUNVlOmhcPTtOpXdUXlS+e/gbsPilNhroZS+kyvNCpc+P0o42Ma8IcqfZk2SFiG73RT8JgFXAM2/zgnpKBqS9qVZU8RKDv+C6PCeQIqIzQX3H6QFZzwF8TTn9FmmLc2w2sHGSk2uVrfj52Q+gmFH7w5TAQGEF0eGExFV0eYVf/ViLlY9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTbcCH24z1+mfcRVLvEPPUU4gB2/kGGJeOAWNPZhFs4=;
 b=iNMQaCNThpavxNEk1RqFx0agWsYOw7qytubjioF7KDA6ciKKZ/b+3ShG0sHyh1q27uT0Fd3dOAqiZdim1bRqENAuu33GfaF66pwiyaF/zMSjGEJjPAb0g7itdLDPtkrkNw72regLzXwcd/xmCKnBJbnuqXS6moUZWIwsq+OEDX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 06:24:37 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7c50:6c99:76d:f952]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7c50:6c99:76d:f952%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 06:24:37 +0000
Message-ID: <9f587ced-3fb0-a257-bf94-051efbda8b77@amd.com>
Date:   Wed, 17 May 2023 11:59:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/9] ASoC: amd: ps: add soundwire dma driver
Content-Language: en-US
To:     "Limonciello, Mario" <mlimonci@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        --to=broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
 <20230516103543.2515097-4-Vijendar.Mukunda@amd.com>
 <b8ad1f03-686a-7f2f-baea-b63b12c19df9@linux.intel.com>
 <e544dc5d-1117-ef72-91ed-4a98b00dca13@amd.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <e544dc5d-1117-ef72-91ed-4a98b00dca13@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::9) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 643d5914-79e5-4a37-ef86-08db569f6338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PeK/OXab4sQWPidojtXDtrRY9xZEcQAjD0LVYHVEbpuPDRsdDrbqspBdevs2SvhO0U5W84sNoruSTWLdMFpo7Gr8pT+VttLhi1NjUGU5NgUiDZVftjfOvgojDIzJazdtdVr50D+Ofx0OCXIPyEN8As1CixW21OsC/HYKR/oswmkkPlXBQyFNVcIJ5QbMfRAHEKgyzZlaoJfN8aaZvq3jgmcIyJ6D/E3yGhcY2JpzczX+6s8V1TXwwvmbqfXGVnnJNqUwiRRpZwpjU59Sd0m76X3gjMg31QP3u9JjdZgF/kvqsH+9KHm3dZ5+bTmh7a7ZnxcNkQju6VBVe6OMi/zajvqBEtNqTemaPU7o+UtdkGifKU9iJ9k4Mv2HOdcX6QjcNMYrwveMb3VS8DEFWkh6ao8h64UfaMeWwI1X6znpCDc4FWkWGCPnt7OOEAoLAoQnxLspmdxJZesSrolyzobfzsx3WSIESe4XOdY9aQZN5YocrfP/LPNqZMsoLYDGb+3FXjX++i4FHBg+BG9gnT3Wenn1HM8VIIF/jNd5hO6r4oOsOrjR+2mfRHiDx6SWs9SUQRqSDHP3LmL7BuV/GWSxhvqOCESYm1gUSjI9ZTtLvLM8AJMMJtk5Rv4041rj8ggVwNR0Bi28SBzYMGfwvR/i/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(83380400001)(53546011)(110136005)(478600001)(6486002)(54906003)(2616005)(6506007)(26005)(186003)(6512007)(2906002)(36756003)(4326008)(38100700002)(66946007)(66476007)(66556008)(41300700001)(5660300002)(316002)(8676002)(8936002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFNpbS9MRVNJOTFPUFJaZTJ1eHdkTXNVbkxaV1NzbUFzejBsd2pQWFdmMUZF?=
 =?utf-8?B?U3JHQUVjTVAyamN0K2VLQ2RpUVh5dWtFODR0b0VtZFdkdDRKejJKTUZsTVc5?=
 =?utf-8?B?aU53V1htUkJpSXhRSzhOUy9xSUdiSjdldzR5MmFPcy96YnIrOEhQbnV1bUx4?=
 =?utf-8?B?MGlNWEZVR2M1Rk1xWGJiTWR1VDFjSkdWSVdpR1piTER0N0hVU0N3TndrSkpo?=
 =?utf-8?B?LzMrUzR3QWtJbXkzOWxxUDFsZ0pSMjFBcUE2RldscHdyY1FSVDVuREkySHVJ?=
 =?utf-8?B?cDRORTc3OTI0a1c3WTVEM3hOWlQ5WEMwbFl4cXZNclNZRWZSV2xyU2dudlUz?=
 =?utf-8?B?bHc0cjZhS0VLQVBWZElxZWZXNWRTSFdxbTBKZ3YvUHluYlRnQ3MyMlNtN0Rx?=
 =?utf-8?B?Nm1OVnI1VkpsTVNVNXBtTVp6dVVjRHdWMVpRK0JEUDAzaS9RL1ZMYlFPNUh2?=
 =?utf-8?B?QnQwZTczaTI0OFJHbWhqb043TDhIVk5Tc0hSdXJHV1YvdEFWYUhUZ2MweEdB?=
 =?utf-8?B?Q24yTW1WZ3RHVFlSZ09FcmdRVE5YNGRvdU1OSk1KTnlSTGJLR2lKbUw4YUZt?=
 =?utf-8?B?NEdNZGJ0TjVEVHZ1cm9QU0dPcGZUSnczVEhPbEpndUc0TWFUR0dDc0JGNmRH?=
 =?utf-8?B?VE5pOUNJZGhEU3ZkTTl0MldFZXhQYllXOGdNbkV5OWhlT2Jya0plSE1kUGtU?=
 =?utf-8?B?WmUxOVU4M1lhVDNXOHJxbGdrWVlFbjFDY3YxSmdnUU5kcW9uU1ZhczN3VkN4?=
 =?utf-8?B?MjZvUU13elRsNFE2NExDakt3b09Bam1PVnNjTnIwTFIvbFJhTXJ4bDh4dmlo?=
 =?utf-8?B?Mnhlak0rVzd3aWRRdXFtbjdJV2I3RUYxSnRwK3lJZjJXSHRTaTRCcW5pUmd4?=
 =?utf-8?B?SmYrR202YXAzY0I2NHV2cGQ2S1NvWkdvOUpqbEhwRzVxK21VMU1RY2dMeDA4?=
 =?utf-8?B?VWcvVitaUDh6ak9VL1FQWnhSRkJvZlBmNi9xYjZuOFdsd2MraVQ0blRqYlM2?=
 =?utf-8?B?ZFF2bm1mTi92bWFtelZIdm1jYjBwR0Fic01JZkJ4cnZPMEJZaXNLUERsUGRs?=
 =?utf-8?B?S2t3WmJweWxXVzlMWXJMbU1SK2VzTjVOMU8vd05zVVdUQ1lsZlNDU1VnOEZ3?=
 =?utf-8?B?aE8xWEZMUEJWb09jQ2VRL3U0dXozK2xleXNvU0xnZElNMHdLUG1Mc000UDQv?=
 =?utf-8?B?dHV4SzRvM0hxa3h2bit3YnBOZnpDTG1XRGZEeGZJRTZZSUpaUE5heGoyVExm?=
 =?utf-8?B?a05yTFU4YmRsWUtiOVBMWTBseXV3c2pnRW5mQmJOWVlHempXL2dITzlsSFRU?=
 =?utf-8?B?bzBnM0lNM2ZUaTR2d3laa0RNMnUyRnA2ZTlYUFNYbC8vU3BOTE5JeDZ0UG9S?=
 =?utf-8?B?cmhHcFNKZDVwTmdKaUVCelovWS9rUWQ4T0VZTTZXNEZZdFNmeTJtZi9obCs3?=
 =?utf-8?B?MHlaTGZISmxnVVp2WU4vM0ZSYUxoais2bHRTSHdpYjgzM0xUVzh5YjZ1SGh1?=
 =?utf-8?B?QmNnbk5BUXNUQ0M3L3RuY2NNK2hyM1VyNUZvcm85cWRRTnc0dHhhZlZPU3Aw?=
 =?utf-8?B?d2NkNzkyTVpkcnJhYlBhdzBWQTBROW4wWThjTFFlK09qZkt6S1BjaFlHcWhL?=
 =?utf-8?B?ZW5iNmpTNjFOR1dLNnYvcERYVTIzaDlLVGRTWFV0eHFBVjFLaE00elljMFNI?=
 =?utf-8?B?aFNSSEYwaVl0ZzJoRUFkY29WOTAyU0trcndDSCtrcW1KUUR1TnNIcFh2bEcz?=
 =?utf-8?B?MFJPemFmT3lEWVd1UTdISmpZTzNNUk1BYkFCMlR5US9UWnc0NEhvYURSREVD?=
 =?utf-8?B?WDJDT1lqSzQ4c29VcFRIc3grZCtnTitDaGw2TzlQdEk4aXg0enZOMUgrZXNa?=
 =?utf-8?B?Z0QwQkJhSGp0ejh2dmVUanRaTFd0V1N1N0oyeXZHNUZ4TkRwT3E5OG4rQ3lS?=
 =?utf-8?B?ckxHaCs0NXZsT0svQ2dTNk5CUjBtTjZYdHREVFlRWTdKcXBkRzY3bzdoWkta?=
 =?utf-8?B?NEp5VEdQN1FJWlpVeVFLaFpTc3p4VzBwQVdiNnZqdnYyTTg2VGErbnpSVFNN?=
 =?utf-8?B?MUxwZEc4TE9VbjFqaWUzaDJ6OHFOMksyR21wL3ZjM1BoRWtjbzR3UGZNM3hR?=
 =?utf-8?Q?47bIECfECBX3TkVsulY3QUbRX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643d5914-79e5-4a37-ef86-08db569f6338
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 06:24:37.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVOeNjew99fNAs0FiLndBCchLBQcItp1amwV8HiPdNTtTMz1sMML39Xn5LP/YRsXtRRfCgpGEF/EAe8ndhiJEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/23 22:20, Limonciello, Mario wrote:
>
> On 5/16/2023 9:40 AM, Pierre-Louis Bossart wrote:
>>
>> On 5/16/23 05:35, Vijendar Mukunda wrote:
>>> Soundwire DMA platform driver binds to the platform device created by
>>> ACP PCI device. Soundwire DMA driver registers ALSA DMA component
>>> with ASoC framework.
>>>
>>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>>> ---
>>>   sound/soc/amd/ps/acp63.h      |  5 +++
>>>   sound/soc/amd/ps/ps-sdw-dma.c | 71 +++++++++++++++++++++++++++++++++++
>>>   2 files changed, 76 insertions(+)
>>>   create mode 100644 sound/soc/amd/ps/ps-sdw-dma.c
>>>
>>> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
>>> index faf7be4d77c2..f86c60cd1565 100644
>>> --- a/sound/soc/amd/ps/acp63.h
>>> +++ b/sound/soc/amd/ps/acp63.h
>>> @@ -111,6 +111,11 @@ struct pdm_dev_data {
>>>       struct snd_pcm_substream *capture_stream;
>>>   };
>>>   +struct sdw_dma_dev_data {
>>> +    void __iomem *acp_base;
>>> +    struct mutex *acp_lock; /* used to protect acp common register access */
>>> +};
>>> +
>>>   /**
>>>    * struct acp63_dev_data - acp pci driver context
>>>    * @acp63_base: acp mmio base
>>> diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
>>> new file mode 100644
>>> index 000000000000..0d0889842413
>>> --- /dev/null
>>> +++ b/sound/soc/amd/ps/ps-sdw-dma.c
>>> @@ -0,0 +1,71 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * AMD ALSA SoC Pink Sardine Soundwire DMA Driver
>>> + *
>>> + * Copyright 2023 Advanced Micro Devices, Inc.
>>> + */
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <sound/pcm_params.h>
>>> +#include <sound/soc.h>
>>> +#include <sound/soc-dai.h>
>>> +#include "acp63.h"
>>> +
>>> +#define DRV_NAME "amd_ps_sdw_dma"
>>> +
>>> +static const struct snd_soc_component_driver acp63_sdw_component = {
>>> +    .name        = DRV_NAME,
>>> +};
>>> +
>>> +static int acp63_sdw_platform_probe(struct platform_device *pdev)
>>> +{
>>> +    struct resource *res;
>>> +    struct sdw_dma_dev_data *sdw_data;
>>> +    int status;
>>> +
>>> +    if (!pdev->dev.platform_data) {
>>> +        dev_err(&pdev->dev, "platform_data not retrieved\n");
>>> +        return -ENODEV;
>>> +    }
>>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +    if (!res) {
>>> +        dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    sdw_data = devm_kzalloc(&pdev->dev, sizeof(*sdw_data), GFP_KERNEL);
>>> +    if (!sdw_data)
>>> +        return -ENOMEM;
>>> +
>>> +    sdw_data->acp_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>>> +    if (!sdw_data->acp_base)
>>> +        return -ENOMEM;
>>> +
>>> +    sdw_data->acp_lock = pdev->dev.platform_data;
>>> +    dev_set_drvdata(&pdev->dev, sdw_data);
>>> +    status = devm_snd_soc_register_component(&pdev->dev,
>>> +                         &acp63_sdw_component,
>>> +                         NULL, 0);
>>> +    if (status) {
>>> +        dev_err(&pdev->dev, "Fail to register sdw dma component\n");
>>> +        return -ENODEV;
>> return status;
>
> Remove the other return 0 too.
>
> IE:
>
> if (status)
>
>     dev_err(...)
>
> return status;

will fix it.
>
>>
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +static struct platform_driver acp63_sdw_dma_driver = {
>>> +    .probe = acp63_sdw_platform_probe,
>>> +    .driver = {
>>> +        .name = "amd_ps_sdw_dma",
>>> +    },
>>> +};
>>> +
>>> +module_platform_driver(acp63_sdw_dma_driver);
>>> +
>>> +MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
>>> +MODULE_DESCRIPTION("AMD ACP6.3 PS SDW DMA Driver");
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_ALIAS("platform:" DRV_NAME);

