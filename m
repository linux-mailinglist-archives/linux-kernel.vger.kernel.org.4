Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14B870545D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjEPQuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjEPQuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:50:39 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DF2D07F
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCDDXUN70KFE6Pi6PKQxNHqE+SZ1dJBf64YzH/4Vm8fcru3NBTav1qzomysGSgsJJfXcd1rcaaP9HRZ4DMhyDJTSJ5/o4j8BBegg1kHUwjrjn3vfSHYQVq1PKGoSWFxY0HzLA7kHgZGvi++XqccensWxoeQIBfoyUn4pj5cyOID0wsi7C7I85KJVpa6OUy5IdD7WwOrOwna9T3/LsxmiCq1Z3UM9zG318GUZHL2b91zhn+0zYsjAboOMGv4loNs4xXH+EDVe+Ve3e/DMd5AWs9v6/x0VVN1LKeddHCNxryqfUcgmRrZRjRv/lYsHgGLio931QQUTlJ9X+ttSz8Egxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py6QZ0RvH1fAii+VpZCmjg+ofsnSnM7OYggOFKl8RXw=;
 b=PHTnZLJ24CBxs/Lnp00U75dFm3j+vUi0vvw7L4CVp6fQU+WVluOv5jXtR4QYpBr0pn/SvGpNQpAcXXg0UvpMbggY6SnDn6rDywQXFA2mnvICPy42D/ecM3EhVoILcdfx5WnNIuutiEpx/UOiUPkqicqqN6xz1Y3tKJsCvXJo2ltSlNDvujDhL3nohxq6nEICowwYD0JTu4mXBOweXcVlgrHANbfQ3ANtbUXN2VgpbJX/bb+yA3A2xnbxf8XKueZ9E6pFESTHSYc8naOlrzKvQ5jejAdTbVa0Edn6mWMzqL/xufOkHGKnSNEK0uy4Ksh9WBfKsuQ4aZi6lJsmvqqjtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py6QZ0RvH1fAii+VpZCmjg+ofsnSnM7OYggOFKl8RXw=;
 b=5gM+aZD8KMsRX1r2mgG4PxxVnuQAvsxGHCLqTK2DBeCSnWAtsMr06qhFxgNKRVMsB4pbUQ+edM6xHs/yIj4ucYIj6oKkDJpxPbkPiJ2g+NR0PnyOXdCz7AW+Ny0cZWmpeXH/Ewb7D8EluIeObq/1PYt6dyMAzqaDcaHFfjF75DI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 16:50:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 16:50:25 +0000
Message-ID: <e544dc5d-1117-ef72-91ed-4a98b00dca13@amd.com>
Date:   Tue, 16 May 2023 11:50:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/9] ASoC: amd: ps: add soundwire dma driver
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
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
Content-Language: en-US
From:   "Limonciello, Mario" <mlimonci@amd.com>
In-Reply-To: <b8ad1f03-686a-7f2f-baea-b63b12c19df9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0101.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: 127d3bf6-99ce-4652-2ff6-08db562da58e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/+g5m+ZX/ZKcqZ8rz4jVTOy2qrPNFiiKseZ+1CjFEWG5OVmRWwCHDLG1y3Ek/qXxCj9l43r3yyPXtZx1WU4iGqqKbpm6DCxfbUw4jpodEOix9w2RPPjw0dYnpE22bOzciVYpsSN7HcpHI+LdNHy+ranZe20K19o9Wk2jFf4/Gsr2tZOUbLgGrlZBNUic6M7CD6Bx3lPXG3zBg4FMkfUk2ZeEv2b+ZTfnRhDO7xuGdzPU+8ROhdsAbRMgdLORxIS5ywNlLXdbNVZJvEJetzNp7O2/fd1kAdxG9g+WYoczQSJN4MArc/QRuto5DCC4SgApR4PpscJZ/aGtN7FAhFcM68m97by+m37QCWzeRGQolWC4rbnf6Xxq2aCusHgqj1JQWQFjujZ3m+rxQPKZ9Xvb62wi/wG1gTJbKlG5DKsxmdhXN1KY3DTQmV5KTc1dRkS0ke90w5lV6SPxoer4F3+DwVOO/5yc8bw3IZCtfej9Rj5rrconjxZbv4vqFH7T7mHzmlbqVut3MQHFTRc/5RRjO1mzYYHizGPlhprIcJ6V+Rw4dum7BohilvdBXJqWf1ifVrWov5RtuBN4PooXgnJQsWisfdbSXLj0aOgkAAg6fevcGokpqMy82lT/MjeBfEGf8vUBe9vgA4CC2nSKFHdtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(31686004)(110136005)(31696002)(478600001)(54906003)(66476007)(66556008)(66946007)(6486002)(6666004)(36756003)(316002)(4326008)(186003)(2616005)(38100700002)(6506007)(5660300002)(6512007)(2906002)(41300700001)(8676002)(8936002)(26005)(53546011)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJSSXNuSzJWRWU5ZFNnZEVvaC9WblVUK3RkM0VLbjFyUVZSWWtzek91eG5C?=
 =?utf-8?B?N3NJZDd4ZDVVOFE4V0xONHBXaWVpRkh2NzI2V1YydHVTMUJJbVcxYis1SkVm?=
 =?utf-8?B?dms3TDdCbEZpRGxaQzRyYUtSZmhTcTlBb3BjREdsUVBKMHRXcHY1aVNjVDhN?=
 =?utf-8?B?Sm9IZWpJR3VSVkcxWG5LZzJFM05UYXhPM1ZZMkRGRXFFMkRwV3h5cVRWdkJr?=
 =?utf-8?B?N2JGdVpoMzJlbVNjbFdYRlplc040NWY3QlA5RGo1Z05WQTc0bG4zUkcrcTIv?=
 =?utf-8?B?TGlEeW9Fd2VYUHE3OXNmNVJDTG5FdWVJSlAxVFdUZ3JPQ2IrUzBQWHNUek5H?=
 =?utf-8?B?YXREenRWTjZlREtNblF5ZHJuUEQ1MS84blRTZG1MWFk2dGdNek9lOGhNVU5h?=
 =?utf-8?B?YWJRQzBRMTdFZkVydEFXZHo4bmhBWVNadm5oVCtJYXZVZEpTdHc4ZFdZZ0kv?=
 =?utf-8?B?aWJqMGZ1MTFma2JhdkNnYlYxU3M1bFNKSFRlOGxrQU9tLzY0a3k5R1RaRFU4?=
 =?utf-8?B?Sk52bVhpZmNLb0V4VVk3QVcrZ0k3ckxlUTZid2ZmcE01RWhLNXl0MTEyU1pl?=
 =?utf-8?B?TWFwY1MyVGkvK28rZnpWbW9HSURvekpuRlI4UFJiamw5VWtpV2wxb3BRSlRw?=
 =?utf-8?B?K0hjZU5zTWdmRXNSbTdpSG9xbTZqK3o0WFFZYVRPM1o5eUE1cmpBYmRvdXlo?=
 =?utf-8?B?RWlxdDhMTFBTT0RYWkE0bFc4RGRMeGdBYi9GdjFueGxSd0ZYNjBHclVVRFRl?=
 =?utf-8?B?clZjZjNNaUh4TkJhZDJWbWpUVHJQNEFBb3JpYlp1bWRkWmoycmRiTGd5UFBE?=
 =?utf-8?B?VWNnU0o2V1A3QksybHZENjBlNDhSRGljaWh1UkZpdDAzTWR4MTRqbHI5UUtO?=
 =?utf-8?B?UmdCV0N6ZkgrcnZsa0pORXM3aHpIenVKUEh1RFB3TzZ5K25RV09EYWtobGRz?=
 =?utf-8?B?UlVnMXhBR3kyRkhZQ2lnbTV4ZncwL2ZIRDA3TG5oMytaOURIc1NvUWQ0bC9Y?=
 =?utf-8?B?ZG10YjZTRUo4VWFTdytGMDYvT1Z6NnVCL0w4N0hiUWs1eEZhZGc3K2lGb0Zi?=
 =?utf-8?B?TGJvUnMrZHBnbXhQSXFYKzlLNDhHZXFscS9vdDJacjhSbFZxY1Blb3M2bGV4?=
 =?utf-8?B?eUZYUUJsSlJINS9WRjlpbFZEckx5U2c1eGh1eFRjbjJhRW14NWNYSzRzNzR4?=
 =?utf-8?B?bzR2S01KQWkzR0hoMGs5Q2JXTHROb3JCcmxLSmdhUzJ6RitBdnd2enRUVGJh?=
 =?utf-8?B?SzZCcThlQUFPZnE0QjVqWHN2MzVteWZIcDE4TmlQUHNLMUdHdnZLRWVqTTZ4?=
 =?utf-8?B?SGdDSWdNKzROek9ycU1EemkxNElCVmhLZjVHR2FWZUpNeWpBWnZ4LzlyMGZR?=
 =?utf-8?B?L1dkZzdZb3dTcERmUm42RDhKUHBBNzJsSzJXNDJnRkFCRkhKU0J6MFBsOFlz?=
 =?utf-8?B?ajZPV2NUTHF2a0FKU1FoY21INnc5cTU0Z05sTkNyRFNGZzVrUUUvVW1ZZmQ0?=
 =?utf-8?B?eXl5cVVjSG9OdXlrdnQvY0RDNkR6eXRodjgyckY4dVRTVEZldWk4T0Nlc1RI?=
 =?utf-8?B?ZnhQMW42TmtFL0lqTlNPY2NqMEVtUEc2clFNU2Z4L1Y5aEp4U3NnajdkY09V?=
 =?utf-8?B?Y1lqd09uQS8xQThVOE9oL2ljdkljYkJVMU9GYlNPemRSaHRiOE1nZWVQVjYz?=
 =?utf-8?B?NWRHanQ0dDYyS2xzdDdITzZVaXlhRDhNTW9pdVlmMHFyK1Ivd2F6bnIvb1NV?=
 =?utf-8?B?QzV4WWJVVXJoNFBpS3l4WmhoaVoyMGFHeExmQVllUHJudGZTVnUzejdJaExL?=
 =?utf-8?B?cDFwbk1JL0ZUNGQwbTE4a0Q1Z2IxS0RFS2lITEUzSVdsN1VwOHNjMmVoNjFN?=
 =?utf-8?B?QkcrR0xleUJGaUlBazZCa1IwME4zRkF2b084RnBFN3pDRXU3bTc4Z2RkbEdW?=
 =?utf-8?B?SWozZDNJSUl6NmR3MG5pTFo4SlBzbDMrOWxUQzM4ZmdOTmxmWXVFRk5iKzhE?=
 =?utf-8?B?OGpzTnJDd2NVWFJkNUdBa0s3d3pjKzEwd0ZpNFE3eUVkeWllSStHMkh5Sy9s?=
 =?utf-8?B?T1czcE9uQzB1bHdhdWM5eERNLzZNY05rOGtMZVVWUGZCbkFDTkZHQ1I3Nkdj?=
 =?utf-8?Q?hjtoCwdTHc/WWhbdx46ropFc3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 127d3bf6-99ce-4652-2ff6-08db562da58e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 16:50:25.6255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbPqcj+aFe82HLjab2olNAcguF1+Om8LJ/7HpE5SByCPLl438UA0XKRDJRKAqvBLslDD52xGbatFvK+X0TQPXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/16/2023 9:40 AM, Pierre-Louis Bossart wrote:
>
> On 5/16/23 05:35, Vijendar Mukunda wrote:
>> Soundwire DMA platform driver binds to the platform device created by
>> ACP PCI device. Soundwire DMA driver registers ALSA DMA component
>> with ASoC framework.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>   sound/soc/amd/ps/acp63.h      |  5 +++
>>   sound/soc/amd/ps/ps-sdw-dma.c | 71 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 76 insertions(+)
>>   create mode 100644 sound/soc/amd/ps/ps-sdw-dma.c
>>
>> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
>> index faf7be4d77c2..f86c60cd1565 100644
>> --- a/sound/soc/amd/ps/acp63.h
>> +++ b/sound/soc/amd/ps/acp63.h
>> @@ -111,6 +111,11 @@ struct pdm_dev_data {
>>   	struct snd_pcm_substream *capture_stream;
>>   };
>>   
>> +struct sdw_dma_dev_data {
>> +	void __iomem *acp_base;
>> +	struct mutex *acp_lock; /* used to protect acp common register access */
>> +};
>> +
>>   /**
>>    * struct acp63_dev_data - acp pci driver context
>>    * @acp63_base: acp mmio base
>> diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
>> new file mode 100644
>> index 000000000000..0d0889842413
>> --- /dev/null
>> +++ b/sound/soc/amd/ps/ps-sdw-dma.c
>> @@ -0,0 +1,71 @@
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
>> +		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
>> +		return -ENODEV;
> return status;

Remove the other return 0 too.

IE:

if (status)

     dev_err(...)

return status;

>
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
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:" DRV_NAME);
