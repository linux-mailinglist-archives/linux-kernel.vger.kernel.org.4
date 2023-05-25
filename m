Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC85710B36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbjEYLjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjEYLjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:39:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00591B4
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBRR4ORHAKEYmamI1erJhh9XReIn7UqFKz/Nlic059XtI7B8neFDQUYX0zZedRZjkUnpyD5UhdbcnhE9zZCO3L1DygfyyHGXVaL7yn/I1lkjTv2kgcMXTWPn73KrYIECLIb/YBZkXJDiFwyJ+iYf/D5JzlulkQwapswEmkCYY58zFGp+gqmFPB2W+dplV522xPwrXTKa6v5h5VB9plX+HYVCt5+3dgrRKdTw4YizqgUnOqQdXIMB27mXPBvegMeDs11k0F9pZKTHhs4kqOzVRs8BAXnn8mWyTJ3GbkIEJPAiwUfK0CrRmZQXAzTW8JWbdhhX6y4hyHregTFKjyozhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdxD7Hvg10xHB3EHvQeUo1+NXfsCPLLF3RgYCdaNJWY=;
 b=MLDjMcPg0EefAg/jyAMcWfSKHSDpLpOpQEo3+Z22aGb83/fl/RnSBN0D9eJA0kEze7lgTusGXBJ8+Jdt6jXdUaSlnRy1BBs8xxo02e3KWGMoB1yAJ3byt5/8tIB7tsSpJBijxsBFhzopYd70ynNrYwY149N4TWI84gltesQcZKUlFRPPryfyKK9u4D1zMXne7m35RlovEJ9IDYHhsw+1Bzg1BVB1m7IdF2kbMNLorUcxYmaBc2QNA4KKubkRUvfPv0ytzDeN0+CBDtTBOf9lxRw47P4MLfoV/mWAt6G0sIUTU3Olevq9ScTS7HNvvk/Ib1LFyRwDrAVOuuTnNR/3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdxD7Hvg10xHB3EHvQeUo1+NXfsCPLLF3RgYCdaNJWY=;
 b=o2ebCav+uUlWJf9w9kK+eR1MFQE/Svjn93n0o6Gl8AFw+OFmQa6nEi5Je3PhVV8qx3T2HX9AUiq65ji1utr3QBmw91uMaasDit6WArdr+s9/hKZVkVVaxJYoSrOfyeetE90J9ejnhdLZYvRSbFUOZfDm4W/lrKddZRPlJEvaq0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Thu, 25 May
 2023 11:38:29 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8700:a051:2ddf:d350]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8700:a051:2ddf:d350%4]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 11:38:29 +0000
Message-ID: <126d632b-1d5d-a86e-3158-b3e18e6a432c@amd.com>
Date:   Thu, 25 May 2023 17:13:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 3/9] ASoC: amd: ps: add SoundWire dma driver
Content-Language: en-US
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
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
 <d5ec5115-b896-c2f4-76c0-18f00e89fbef@amd.com>
In-Reply-To: <d5ec5115-b896-c2f4-76c0-18f00e89fbef@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::10) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: aa26ea68-fc76-4949-9a1a-08db5d148f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yli+b85x27HCx8tOS93W7+kLIf/PGkVLkgsuvVdXZRQuLCuDu63o9ULR3vtpX3+DjNbifs0pJe83DF6/6Hjz8rvtAinydqKlHOcaCZBHk3+YV6Htrlknk+m/UD4M7G4Q9tVGHnL1wdlgzY4tROmgMDbPngPVSxE/MhpnlmFTT+uh+KkVfdlQ19bQImZdBpU0+P9i6UwjYvoX/dGixLAV3rASuKFiAUjC2zwHHNGYvylcMU7UjLxsGIz1qWFJPNyl+EPLz+e1VP7okaRvJVdo2S1S+WmicNumSiGDPtTbSCqVgQJjtvoOMKy0XpUx1x6Ge3CJFHwSNRgop5tsk5i+SY/EVrmABeo1PnoBzvOHu09ZK3RudZqZXo4iB3yMDtXnm1h8EFsTmcW1tLRseeUcPAzJ8cF5yokLi6YwM0wc29yZKtHljZO08c1wPqnU4ft9ljHxQFleA155DcCZ7md1MY0epYGkMiyodWXdtjtvGLh42t7FnEN566CkMR/wXbAfOxP6F8yG3XJ7bfRon1Y1SO2+aXXO/VRo93kR8CZCq83sBGrCtYo34u7233Sj97oODQaLDLb0Rc8FbNXuvrtG4jU96YThq8+4BxAIIBnlWBpOEM+MPH2CDgHTf/yw3JlfiPCIOC3AC5g7XXFnqCOl0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199021)(8936002)(8676002)(5660300002)(83380400001)(186003)(6512007)(53546011)(6506007)(2616005)(26005)(86362001)(31696002)(38100700002)(6486002)(478600001)(66946007)(966005)(36756003)(4326008)(66556008)(54906003)(6666004)(66476007)(316002)(41300700001)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUNydW1ZbEw3UTZpNnh3bnIzVmhuWklvOVQrVmk4MldwUW0vbnNMYXRoUTdY?=
 =?utf-8?B?dU5EWkFYS3cxOWo4QXp6ckUzcno1UmRFVzFQUUIvSUZQVGUveG9CeW1KMlpL?=
 =?utf-8?B?TjZjRk5ZVkxEeEFISkdnSW5WSXNqK084NXNmSkJDS2JMbGM1N013YnVwcUV4?=
 =?utf-8?B?RTJ1R0k3RERLVW1POTM1QXRXTVFGR3czMDNqZFROaWtiV1FtUHE4QVQzdVBk?=
 =?utf-8?B?aEdLeVROSXNQUFNZVVZQMDM5WUV6b0NRTE1kL2VmNHpHWmNkS2U3aEtDV0tw?=
 =?utf-8?B?TjlYY2t6Y3lxdmx1azhkeVZBWTNqSVJPSXF5bHBSV1ZRbGZ1cUdRQWdVeGlY?=
 =?utf-8?B?VStBTmZ0bTQwVFBsbXVsTmt1ekE4UXMzcW8zMCtBU0xPSW5HVlVJbFA1YkZC?=
 =?utf-8?B?OWRuRG5MWitjOUVCRHptVWJscUhyeThldjBpS1QzenF5UE9Ta1VMdnZnQStV?=
 =?utf-8?B?TGtMdGhxWmZ1ckMySm51R3Q1NHBSb3FBWFJLMEl1N01wRGJXSFVrRXpPVUtv?=
 =?utf-8?B?ckhTNGpLdW5obGgrL3ZoQ0VPVjJZdTlnR0hXV2YvclNLZFlQU1E2YTltdWVp?=
 =?utf-8?B?YmE3Rk1RZWlMRjNTczY4MzhvN0NaeTNERkNPbEpNbk5kRmVkYWVnYW0vREcx?=
 =?utf-8?B?RWJqRlNQdUhDYWlEdnRQWkluOGZLMldIZnUycGM1YjBtajdhbTI3L3pGQXJi?=
 =?utf-8?B?aEk3YzFWT2hOWlk3OS9oeEptSGgyRlJla05wNnAra2xQb1FVOStzUGFRL3JC?=
 =?utf-8?B?L0pzUVdGUWkwVnJObXhGc05yOURaOGFMTExSZk5Scys4MG8wVXNKb0lHTXBv?=
 =?utf-8?B?QUQ2SCtSN2pPWjBHZWdvUFpDdmp4MzNuZjNTd09kWStwdGN3UkVaL24yZXU0?=
 =?utf-8?B?ZmxxaUlTa2h6VG4rUWdZYkJxd0tBd2JJRVU1WkZqK3RNWjVLV3piMm5SeFYy?=
 =?utf-8?B?L0RpNFRFVHJNQWcyclhrQUF4d0RzL2JZdHhpOTZaY1FNVTZTTmJHUlFtVHFs?=
 =?utf-8?B?cElUN1JmSEF1NHRLaHpNVFFrU2pySTl5akxEQUR2SzFLZXd6REVIamovVkRU?=
 =?utf-8?B?Wjh6UmpXRGcyTG5lcXdieXg2b29velh6WVZXeWxaajlkckZTU21HU1NiSTBG?=
 =?utf-8?B?TG1taG9wdjdVQUxrR2VPRm9lWGZhNXZPNkRyazIyeC9ZQzZZeXVYdkR4RjNh?=
 =?utf-8?B?ZTlEelhBeHl1TEhoOWR5ZXBBNEllaVFvWDh1d2t4MGdxN1RZcWJFakZZMmdw?=
 =?utf-8?B?cDR3aUlLdlhoMytkZ1N4OUk0RTF0ditmN2xEYkN6NnUwaisvQnRQbVlQL0or?=
 =?utf-8?B?ZGE5TFV2VU9senN2bytyOG81TXRnTCtPamFwcVF0d05Dam1GZS96UUhwYVlW?=
 =?utf-8?B?dkhRRGtJd1RMK1lWckcwVlR0VStaK281bVRDcmZWNVFYNW5ZajhOSFh3RjBI?=
 =?utf-8?B?TGlBZ2Z0Q3dyWUhpWThwZzBDbUMvU3ZNZkdQdzNsQW1XQ0plWXV2OHZqYVJp?=
 =?utf-8?B?SnpVa0lIQnZjdXQ1akM0MVNnZEpvMzJ2UW5rRXpWcElRNzl0cmM1N00xZTZK?=
 =?utf-8?B?dFZFSkVyb0Vwc0VMbmp2UCtXeHJQdDk4RW9VL1hKVUhpVnVSNmF0dkV6MlA3?=
 =?utf-8?B?b2h3OG02Y2JyWk8wZVNUbjhkZFM2aEs0eURwMi9jRDBPSklJcW43MFNQNW5F?=
 =?utf-8?B?TWVnMXMweEdRWlpHWkhrY2U4Mmh0dzVLTUI3QWFTWkJxUnIyOTN2L1REL1VH?=
 =?utf-8?B?OTRQNHJVQUF4WGo3eHdUOEdRY3Q5ak5TajA2TlZwNU1DM0Q5clpzZkdFWmJl?=
 =?utf-8?B?RDl0Y1JjNDc5K3p5OTI1Wm9SY1NydnVmMnBHa3NnZVJ6MHlYSE1JeUVzaGpu?=
 =?utf-8?B?NDErL1JEdlE2a25yY2UySEZaNHpyZXRjT09wNnJweWk5WGVyNnhnYmtLc0Zo?=
 =?utf-8?B?WXI0QU1wV29tS3Uwakt4VGpyUGkvRmtPNXN4eGtzalV5eUducnB0WWJhaWI3?=
 =?utf-8?B?M3cwK3pJcE1Idndmb01IbWdJWlMrcVlwNzJUaUdmT1lDWVdVL3BZYVpUVXpL?=
 =?utf-8?B?ZVYyYkg4eFgwcllGeW9pVTNQaHkxQWRDL2lIZzg2TlQxZ3E2NmxEVDdhNXpV?=
 =?utf-8?Q?ynPeetJGdo4izuFCHwn3ws1Uy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa26ea68-fc76-4949-9a1a-08db5d148f58
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 11:38:29.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vwpt+qYelNJ2+eC4Y7MN2JN4mj4Ypj8PRszyKHTsa91lc1GD12tFodIGTwEmHnInNDLiI4o9tv2ho4OxnCcfCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/23 17:07, Mukunda,Vijendar wrote:
> On 23/05/23 20:18, Pierre-Louis Bossart wrote:
>>
>>>>> +struct sdw_dma_dev_data {
>>>>> +	void __iomem *acp_base;
>>>>> +	struct mutex *acp_lock; /* used to protect acp common register access */
>>>>> +};
>>>>> +
>>>>>  /**
>>>>>   * struct acp63_dev_data - acp pci driver context
>>>>>   * @acp63_base: acp mmio base
>>>>> diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
>>>>> new file mode 100644
>>>>> index 000000000000..f41849fd035c
>>>>> --- /dev/null
>>>>> +++ b/sound/soc/amd/ps/ps-sdw-dma.c
>>>>> @@ -0,0 +1,70 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>> +/*
>>>>> + * AMD ALSA SoC Pink Sardine SoundWire DMA Driver
>>>>> + *
>>>>> + * Copyright 2023 Advanced Micro Devices, Inc.
>>>>> + */
>>>>> +
>>>>> +#include <linux/err.h>
>>>>> +#include <linux/io.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/platform_device.h>
>>>>> +#include <sound/pcm_params.h>
>>>>> +#include <sound/soc.h>
>>>>> +#include <sound/soc-dai.h>
>>>>> +#include "acp63.h"
>>>>> +
>>>>> +#define DRV_NAME "amd_ps_sdw_dma"
>>>>> +
>>>>> +static const struct snd_soc_component_driver acp63_sdw_component = {
>>>>> +	.name		= DRV_NAME,
>>>>> +};
>>>>> +
>>>>> +static int acp63_sdw_platform_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +	struct resource *res;
>>>>> +	struct sdw_dma_dev_data *sdw_data;
>>>>> +	int status;
>>>>> +
>>>>> +	if (!pdev->dev.platform_data) {
>>>>> +		dev_err(&pdev->dev, "platform_data not retrieved\n");
>>>>> +		return -ENODEV;
>>>>> +	}
>>>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>> +	if (!res) {
>>>>> +		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
>>>>> +		return -ENODEV;
>>>>> +	}
>>>>> +
>>>>> +	sdw_data = devm_kzalloc(&pdev->dev, sizeof(*sdw_data), GFP_KERNEL);
>>>>> +	if (!sdw_data)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	sdw_data->acp_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>>>>> +	if (!sdw_data->acp_base)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	sdw_data->acp_lock = pdev->dev.platform_data;
>>>> so you are sharing the same lock between parent and child platform device?
>>> Initially, we thought of sharing the same lock between parent and child
>>> platform devices. Later we have observed, mutex hang issues observed.
>> If the goal is a global lock, then the platform data should contain a
>> pointer to the lock. We used this for Intel, see .e.g. the shim_mask in
>> drivers/soundwire/intel_init.c, where the same pointer is used by all
>> children.
> We want to have common lock for Soundwire manager instances only.
>>> We have avoided critical section code and removed acp_lock from
>>> ACP SoundWire DMA driver while accessing ACP common registers.
>>> We will remove mutex lock from ACP SoundWire DMA driver code.
>>>> Does this work? IIRC the platform_data is copied, you do not point
>>>> directly to the initial data provided by the parent. We had issues with
>>>> SoundWire when we used platform devices, with the 'wrong' pointer used.
>>> Till now, we haven't observed mutex hang issues due to
>>> ACP PDM driver mutex lock changes.
>>> Agreed. We will remove the mutex code from ACP PDM driver as
>>> well and we will refactor code.
>>> In SoundWire manager driver, we are sharing the same copy for two
>>> manager instances. We haven't observed any issue.
>> What's the benefit of passing this lock as platform_data, if the goal is
>> to perform mutual exclusion between the two manager instances? Why not
>> just create the lock as part of the SoundWire probe?
>>
>> If there was no need for a lock, then please remove it :-)
>>
>> If it's needed, please describe what it protects, which agents rely on
>> it and how the lock is shared.
>>
> There is a small correction.
>
> We are passing address of the mutex variable (acp_lock) which is part
> of ACP PCI driver data structure as a platform data to child platform devices
> and accessing it by pointer reference in SoundWire manager driver.
> It's not required to drop code changes specific to SoundWire manager
> platform device resource structure.
>
> Our intention is to have a common lock for different SoundWire
> manager instances, which protects accessing ACP common registers in
> SoundWire manager driver.
>
> Even though platform data creates its own copy for each platform device,
> as we are passing the address of the mutex, and referencing it by pointer
> in SoundWire manager driver, it works as global lock for SoundWire
> manager instances.
>
> We will remove the acp_lock code changes in ACP PDM driver
> and SoundWire DMA driver.

We have further tried few experiments in ACP PDM driver and
ACP SoundWire DMA driver. Instead of sending mutex lock as platform
data, we have directly referencing the mutex in child platform driver.

After making these changes, we are no longer observing mutex hang
issues. The reason for mutex hang issue is, from ACP PCI driver we are
sending mutex address directly as platform data, which results in incorrect
reference to the common lock.

We have already posted ACP PDM driver fix for upstream review.
Link: https://lore.kernel.org/alsa-devel/20230525113000.1290758-1-Vijendar.Mukunda@amd.com

We will implement similar changes for ACP SoundWire DMA driver as well.



>>>> The documentation does make mention of a copy....
>>>>
>>>> /**
>>>>  * platform_device_add_data - add platform-specific data to a platform
>>>> device
>>>>  * @pdev: platform device allocated by platform_device_alloc to add
>>>> resources to
>>>>  * @data: platform specific data for this platform device
>>>>  * @size: size of platform specific data
>>>>  *
>>>>  * Add a copy of platform specific data to the platform device's
>>>>  * platform_data pointer.  The memory associated with the platform data
>>>>  * will be freed when the platform device is released.
>>>>  */
>>>>> +	dev_set_drvdata(&pdev->dev, sdw_data);
>>>>> +	status = devm_snd_soc_register_component(&pdev->dev,
>>>>> +						 &acp63_sdw_component,
>>>>> +						 NULL, 0);
>>>>> +	if (status)
>>>>> +		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
>>>>> +
>>>>> +	return status;
>>>>> +}

