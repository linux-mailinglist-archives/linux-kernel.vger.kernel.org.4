Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EC570D482
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjEWHHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjEWHHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:07:02 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEF8109
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAWS/LW3As6FIxnDSFtajeV5Uu+3Givi7WRTDoE/cvh4gp/HsymDN80il7P/mjtb4rljv6MPUTp1cjgxmpLyypoOPECAZatSmOBElwV/b4RgMsdYAYPLIgauDKH7zoU7T8rX328bKIAvLZ8wGAdxiZal7gpcaVJyKzLUqUZYyrWCpiLbBoCnsdpGJdI+wwCq/Bco537Xt6/xqmtK8VHmoc63jFBaSUCpAH8KA5QcyceY6th+/Z1Vmx/vvCj5ROxkiTby23g/aUsl4llNRl2fgh3fGLggOpG/OMAFBQcxuz+G8IhZC2BRCBlwHNwPEaG4FUs/U2EcCgU7bK6z5ztCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4ui9QfPfGuc9xxktGvBvU23yWhpL+UBGEa4E/rLrsU=;
 b=PnAT8xmhXp5Ix6IiZ72VA8IR//cpvNJDbBsTy70x9Mic19ZuHBClooPGw5o/5BsHfBTsRlbePCtEyCFscX0uKU2iadLZXT8yvv2KeEojIKQNWgXcFav6qauIR6RK0pI1x8DYpPkl88u+sXnu0RkAcvKriEkFIDFQTzPYXRyCAwuLQsSVPgARzQ+efojmVfkp7FA+us8AULSJxm9fwrwFpIOjW/l6si5nn6YnZ4fUs2GsTbRQNMpcKerjpyGL2siSbLwPffQdk4FQamWVHixPGkr3/O+6NpxR+/GuDBSSJHi2PjgF6R3w3s4h9WUjgRnr39V1i1DdksptY260PZZUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4ui9QfPfGuc9xxktGvBvU23yWhpL+UBGEa4E/rLrsU=;
 b=RQU/fw+wIomYAbP+whlabjfeLve0cLIAfhpEi4cTl3hH+A2bU6ov/NlQh8oB5ro1H1WMXpIEVb7auA1nFhkwM1xTnwozLPeUlrbpgLDC+OnNZwopJgvNwFMRCUxS9l8gUNUIZWKgeekjwEHbxg8PdBDyN6adt2tA/H9gE0OKgbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 07:06:45 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7c50:6c99:76d:f952]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7c50:6c99:76d:f952%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 07:06:45 +0000
Message-ID: <129df804-a05e-47a6-cfa3-cc36282955d1@amd.com>
Date:   Tue, 23 May 2023 12:41:41 +0530
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
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <0bf45d6e-72bc-d31a-fec5-b52859b8dcae@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::15) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH8PR12MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 120d4449-fb03-48cb-e97d-08db5b5c4471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ni06oPbeGlU9f1hMvUu00tN/LRZD76ii7XRt7bbgoi+rMV3AN4qtUVQ32pr4wxkcIqiN4Q9JuGS6PRDxLHvyBmpoGnYtjFZD3BfPlyhp2qvI/fA+om8vFlYmeX7uK4VPoAdJUSvL6hHgPoiZk1vVXSaNXNjx09sztEZeu+qWW/RTpB7/zf+KvyBfFVmAuZNOIjBl7K1bAzg7NM8CZ54llYWv5ZTUI/P1AAKrrCb/dLUp8sMLL0JhVmDWiUaGZivhHIRDHaVKuYrO2Qes7wL3U7ahDB8fzz0gHdKcivqWHpYbiGKAshpBmx8+tz9ImmiRX0YUV96GNSl+tFrZ2UCvNIOT1fwqm3sWZGhII/cQGjFivcOIlsZm+0nMMK1RiCnxXUtI0EJyqQ3C3gpRbSVLNBthJsqCsFfxcCSFhJnQ0MZwgbLDoCYK469yfQv4+OG4sMYQVN+nqOV76+DEwYTw6KCj/S3UuAt5LYlDTcus6WgywsET7+FvJartDTwVLlsTye+UmekexRLbstFb/6jEfAHugwxc/E+o1u9wz5L173vGDMYal0J2ta5DYuIWymak3V5BFRtJgAcYhPUSh4t65/ICTeY4pTX2tULUx81r2y5rqYyvFBYzET4+pHvViPzco2m24r5iplXGToyTaDqelQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(8676002)(8936002)(5660300002)(186003)(53546011)(6512007)(6506007)(31696002)(2616005)(86362001)(26005)(38100700002)(83380400001)(6666004)(41300700001)(6486002)(66476007)(66556008)(66946007)(316002)(478600001)(36756003)(4326008)(54906003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGJUcHlyU2IvRHVoRnBUNjZXU1BNT1JyL2hLTFJZSFZORllMWkQ3MXlic3k1?=
 =?utf-8?B?SktSeW5aNzcyQ1orNVZHZFRSYUVnczFDZHB2aUdkL1orQ1pRdExBOC85Z0lQ?=
 =?utf-8?B?T292cmk3NlRQZzBMNTd3QU9iaTYvTWpBYytWQVRNK1N1VXkwSVpuRW1GbWQ1?=
 =?utf-8?B?M2JsTXRwaGxjVE92QytDcEt6TzVoNm1UWXF2Um9nRlhOTW9URFYvMUJJMks5?=
 =?utf-8?B?UExRdkxheWVTNWNSeCsyOGJXWjNSbUFMM0lVVXBNK1FqZ1ExdmN5Wi9SOHRk?=
 =?utf-8?B?YllkNVYvc1owSUVmVG9MaTdsT1BqNlNrak9NT2NsYko3dW1uaVVRVUZJdVpQ?=
 =?utf-8?B?bmdMMHNMKzhJOGFiaDZrSkhmdlJCYUw5bmYyT3NYRHpicnJLcXQ5Q2pQdEli?=
 =?utf-8?B?Q0craiswYXVBK1FXRWpwRG0ydnJwKzhIak9qVHZoN2pzdUI1T0VhVHdwUjFy?=
 =?utf-8?B?dis1Mm1QQ08ydUc1RzJ6VnZldEF1S0MyTXpTdEY2MTJjc3VxeXFqdmRVb2sy?=
 =?utf-8?B?RkJDZWVqL2ttamU1MlVTRmhVMVlZVnBXaGpOYkVLYk13eGhCOVNaUWZJVFg3?=
 =?utf-8?B?UkowbkdqNTFYaTFmdHYzdHN5OFBHRElRUWhqV1VjOEFMbTNDMG9XRHhKLzdS?=
 =?utf-8?B?QjA0ZUdaV3hjMjVYbTNQeDZaU1Rjd0F3U2M4MUVMNDZrN1lmOXcrbTRGemdB?=
 =?utf-8?B?ZVY4VDdFR01keUdta3VMc2hBcHB4SmZSRjc5ZVo2YkJKTzJFNUhNTUVIRGdM?=
 =?utf-8?B?V21SOFFCMWlaSjEwV1JaNjYzeUIrZEpkSGRMdDIvNHF5S0FFc1doUHdHS05r?=
 =?utf-8?B?eUVyd2ZxWFdKeEU2WkFaRmd6MXl2NHFSVHdBV3h4Yzl5VXlPTXVVT0RFazMr?=
 =?utf-8?B?YlRqbW5zejNyYWpjU0lsaElZTDlUVE0xOTNEQTZJWjUyNnN4c0ZIc2p0MnY0?=
 =?utf-8?B?c3Rsby91RXFhc0llNldERFNFZyttcG5EVVdzNkF6SmE5OThFSlBLb0hIZ1Rn?=
 =?utf-8?B?bERiSG5UMTlFbjJQYmkyWnE4SkxJYzY0T09BQ0tBUU9wQ0pwQjZ2MjF1RjU3?=
 =?utf-8?B?SThSL1hqVlR3N2tWTWFxMExXalY4dnROUU02cExsYWk0Q3R0NEJ2dTlFTFBl?=
 =?utf-8?B?SExUdzZ2allSeTlVeEJuSFdLOSswZ21hd3diNmF6b3hFZkllY1l1bWNZSGxW?=
 =?utf-8?B?VjNSZUYxVUFRNFpDd2RLeHkvRGVNbUlIZWNBeEJSSG1BSlVYMHBkMXJJUzFS?=
 =?utf-8?B?STB6cG4xNm5uaFVCNUVQWHRacmF0RzRuVkw0MUtwQkhlOFBCc294MGd6VW8w?=
 =?utf-8?B?WkVVOWVSbExmU01uaC82aFRkbEY2dXhjSmFudmNpbjB3YmxuWmRpTFdWLzR6?=
 =?utf-8?B?NU9pNGIwWUVPQXhtaHF0UlB1STN6a21nT25UY0JvQ3FjYnAvTjBvc1Fxei9J?=
 =?utf-8?B?MzViaVlxQytzYmNmRHhJMGd5SDJ6Z0hyek0vV3FCRTFZczVvRkRyYzRMZUJC?=
 =?utf-8?B?Q1lqR1ZkdmlDTXFUWGc0QWg2RkJDVTNkWXdycjQxTllhWE1SWXEvY1FoaHFq?=
 =?utf-8?B?eGROQWNyNWZNbUlZZFRSYkpsb09nazBNOFZhUmVSSm9yQUh2ZTB4cUgwZklw?=
 =?utf-8?B?OFBRWDFlZmdHcDJIa2l4bXJoM3cydU8rNGFmb3JaZytHMW9TSTBQS3BQN04r?=
 =?utf-8?B?TjhhS05zWDZOUlRVZ0dyTFZzMTZGVmluMEVsakRLZE85TWhoK3JTdDlWTEY1?=
 =?utf-8?B?eEd6VytLQ0lnMlJWQlpETUxJTWpjaThRcWROdWREVVVsVUc4T1dnQUcxRG1P?=
 =?utf-8?B?eDl5VWFzdG5NOC81c1Q1UVFma2tNVFhWZHQ5Uk4rWml3VHJ1N24wVWFZdHNl?=
 =?utf-8?B?THg3MWlTMDhWNHc4VmxzMGRLWHVQYkhhMHRrVVBwN0pzUlMvYXY2djZZZ3JE?=
 =?utf-8?B?b1dLd0MvWHkrQW1NZGJyTWFDMkxFZjhUNEFjUVpLOXVxVGRYVFNxWjQrais3?=
 =?utf-8?B?T2tEbjdjOEZ3enlSVzFpSjJoZW5nbGVBc2xTSzlySzZQYkdESHo4ZUIrNkFR?=
 =?utf-8?B?UlFJK1dWMk9HUkgweEdBbHhNU0w2NFdzcFNGVlU1WDZiQndsdVhMUWZaMXFY?=
 =?utf-8?Q?6HYqSoZek/3Guu6kS+q0jHVyJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120d4449-fb03-48cb-e97d-08db5b5c4471
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 07:06:44.7959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ycMn87nA5a9YzIG559LJVJa3aWSWS6TGaN4ov34SbpJOakXAC+Qp5ClmE57CNL1PeMHxaA8+cxQ+KDgOQJnag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/23 22:04, Pierre-Louis Bossart wrote:
>
> On 5/22/23 08:31, Vijendar Mukunda wrote:
>> SoundWire DMA platform driver binds to the platform device created by
>> ACP PCI device. SoundWire DMA driver registers ALSA DMA component
>> with ASoC framework.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  sound/soc/amd/ps/acp63.h      |  5 +++
>>  sound/soc/amd/ps/ps-sdw-dma.c | 70 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 75 insertions(+)
>>  create mode 100644 sound/soc/amd/ps/ps-sdw-dma.c
>>
>> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
>> index d296059be4f0..eec58da7ec8b 100644
>> --- a/sound/soc/amd/ps/acp63.h
>> +++ b/sound/soc/amd/ps/acp63.h
>> @@ -148,6 +148,11 @@ struct pdm_dev_data {
>>  	struct snd_pcm_substream *capture_stream;
>>  };
>>  
>> +struct sdw_dma_dev_data {
>> +	void __iomem *acp_base;
>> +	struct mutex *acp_lock; /* used to protect acp common register access */
>> +};
>> +
>>  /**
>>   * struct acp63_dev_data - acp pci driver context
>>   * @acp63_base: acp mmio base
>> diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
>> new file mode 100644
>> index 000000000000..f41849fd035c
>> --- /dev/null
>> +++ b/sound/soc/amd/ps/ps-sdw-dma.c
>> @@ -0,0 +1,70 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * AMD ALSA SoC Pink Sardine SoundWire DMA Driver
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
> so you are sharing the same lock between parent and child platform device?
Initially, we thought of sharing the same lock between parent and child
platform devices. Later we have observed, mutex hang issues observed.

We have avoided critical section code and removed acp_lock from
ACP SoundWire DMA driver while accessing ACP common registers.
We will remove mutex lock from ACP SoundWire DMA driver code.
> Does this work? IIRC the platform_data is copied, you do not point
> directly to the initial data provided by the parent. We had issues with
> SoundWire when we used platform devices, with the 'wrong' pointer used.
Till now, we haven't observed mutex hang issues due to
ACP PDM driver mutex lock changes.
Agreed. We will remove the mutex code from ACP PDM driver as
well and we will refactor code.
In SoundWire manager driver, we are sharing the same copy for two
manager instances. We haven't observed any issue.
>
> The documentation does make mention of a copy....
>
> /**
>  * platform_device_add_data - add platform-specific data to a platform
> device
>  * @pdev: platform device allocated by platform_device_alloc to add
> resources to
>  * @data: platform specific data for this platform device
>  * @size: size of platform specific data
>  *
>  * Add a copy of platform specific data to the platform device's
>  * platform_data pointer.  The memory associated with the platform data
>  * will be freed when the platform device is released.
>  */
>> +	dev_set_drvdata(&pdev->dev, sdw_data);
>> +	status = devm_snd_soc_register_component(&pdev->dev,
>> +						 &acp63_sdw_component,
>> +						 NULL, 0);
>> +	if (status)
>> +		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
>> +
>> +	return status;
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
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:" DRV_NAME);

