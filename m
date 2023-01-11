Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923A1665D57
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjAKOKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjAKOKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:10:36 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA54BFC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:10:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKAWjTW/5xO9lTkb8dDHLZhiUvAiIqq8thnHNh/B+o2lK8FuMMCf7R8eAoPxCCE3QLwosBpDChdgZvNssMpIiUS0tzAgEijfcwxcf+kYQ8sa2vyu1r+dO/llNEA+V8h0+2aAf1ak7N9W0/IJFAJ/XOH1ZgBtQg9JMpOVBKseqnvUCdoXiflWcz/XykCVSdlVWJjIJqzGVlmlWVFm4RAFAC42ZAypz1tKf6tYYEi9HrSc2ChTDh/OpR8D/vtMw6rlPEedFNR8KIxKPavr0n9ysj46fD0739nwD6HtpQ7tVdhTdQ6yoKLNnUZ3REdZDqYkA7jODc6+Y4AQoSx+1zKWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/pYDRk5rWNePptkPdKvstlmdIAEa/mAU3M3Rt7NpXw=;
 b=foAnc0ol0pLmFXyKQtuQzv8I5UI12J33c71LfibDky6U1oYMsSIfrpkBTyvRqAVScxCzkSOY9vADKCjrfFgt5m7eAyKohF/N+zZf3b8beg0hucvN+2sJAwWgzrDuN38OhQv51P/ejaA4oo6YR0BB+eCV4CPbZ5k8/qiD7b76iCYbA0A0mVgbeSQYUUWn+5fzeLJDq4iyE6uMD1CFiUulI9NaVSwNoC2DDiHSN9h7FE/wDRio7x/9Y3WPzpA+COqTHEOat46gYLD1LviRfQDHPKsND09GNxzPMIPOh34/yp5LgOh6LosTkkUIg6AoF+OAAgmCCya+I1zWZ/FoVnedpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/pYDRk5rWNePptkPdKvstlmdIAEa/mAU3M3Rt7NpXw=;
 b=QQY+oK/Ikkle0IgIuHsU/Q6cYyCpWRUu6evwn8vsup9PSI4qH+RuMOtdU/XYQ9ouQpNxR8aJJHMHmTESlnKhL47r/WbrgvRbAC3mZZh+0uotiBsoYEe6Acivlz5K95HW4x973EUbtrRV+piIGG2iQSpfLawviZi30Hh/rpVAJdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 14:10:33 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%5]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 14:10:33 +0000
Message-ID: <b036edca-1694-bc21-0fb1-82b1dc5f0c22@amd.com>
Date:   Wed, 11 Jan 2023 19:43:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 01/19] ASoC: amd: ps: create platform devices based on acp
 config
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Mario.Limonciello@amd.com, arungopal.kondaveeti@amd.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-2-Vijendar.Mukunda@amd.com>
 <f7ca6b33-19b2-7a59-da0c-c34e441e0063@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <f7ca6b33-19b2-7a59-da0c-c34e441e0063@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0225.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::20) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7ec366-beea-481d-a263-08daf3dd9a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z9B3qIhhW45PnaM9QH9BrxKkM0xAFpIiSlPtovyAIto6SS7AfDnTp9HZDHNQi2HEmYzWRDj9kWEibF9EDiUUswTGnNXItm40cdns0O+CEQ/46qNnPxKZmJQ0+guLckzZq8pqGyneEMsvOwqvCmsuzkK9RZhpdT1h3hc0mqk1VffJFOokT3WF+VcOKXBso9o6AQS4IttAdGRyNr92cCzzLHQd2ewq77dxlaLOtobO945yDuRPhQgJ4Umwu47jq6c2JUDPEuE8ka5bLcxK21osFnOoFArXnWfBJ5gT8T4nVy4l43e0QaGjboA4D9Ey92rVG42Xw7IsDi27Z4kCnRd+eVZRKbkvMweS7zHGIu0AcMQv5aMc5Jnsp/UaJZKVwU00RSzfRDawXGkarIZpgp6DTn62735TVtotMhrAyHtLaM8nCHgykd31KGHqI1XhrA/YNRP2ZFhDE+hd9gxmCtPb+wVkSkMLteGVxNQwV0+RNvOhea+2C64wuyIKDyXlqptsSlKf0cF7JaYH5QgEJcCTdOdGVwWMQfqduwmOFFLK1SGRuZsb6Cvv8ohyTRq9XpSOI68pjWY5n1s5Zrl/zGu25kxklFRtqdX/8Kdoftz0dMMK1+W+6jhZVp/7cURBt3b2cGTHtSNwLbMz5lXLVjo4GR6ebJrF0E8k4AXEPfbRhK7VQLrTYx14BxYIlReKajtPGurmz9VRVcA7GmMuy17MeId88bGSzbIOQUmq99nOa3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(53546011)(31686004)(2906002)(6506007)(6486002)(26005)(6512007)(478600001)(6666004)(186003)(8676002)(83380400001)(2616005)(36756003)(316002)(66946007)(66476007)(54906003)(66556008)(4326008)(41300700001)(5660300002)(38100700002)(31696002)(7416002)(86362001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUx5ZWZBcjZ1VngySU5jSjB4RXF6aElTRzVNbUJBSnQxL0t5dnFxRlhRSTMw?=
 =?utf-8?B?QVpmckpCTWNVOC9KekZOcTlDaGdkV2VtMFVxQ21vRmMydGM5MDdEWDUyWGp2?=
 =?utf-8?B?S1dCbjBXdEVMVVRyWkRweDB3Y2pWdlo3ZlRRb1duVm1hVlNWQm5oTmRNTGpV?=
 =?utf-8?B?by9USFBZUkhpVllCU0JoSGtNdXFYVHhXUThlamdOSEc2MmhvNkJzSmkrQXZS?=
 =?utf-8?B?Vkt4czhYcGhJMUtyS2VHbm9FNXd3U0dOU1YwSzN4ZWdEQmJFSmJxdllmbWdU?=
 =?utf-8?B?MHl4Nzk2Z0M0QVVWc2cyK0gyY3FBRWdsUUh1UlpPenVxS1pudzdLdFhkZmdP?=
 =?utf-8?B?aEVrTjdDai92U1E1eU5HeVhEdGRHVW80eHVCKzZIWXdiYzk3WEowZGUraHFu?=
 =?utf-8?B?UVdodFJlMklBL1pmbm5BeU95clY5aUIvRGtnUDFqb0ZqN3dnOEtqWGl0RDdt?=
 =?utf-8?B?eW0valU1ZG50NEwrWW5NK0lWa1pscGFqTXdFNmZOSkQvV3RaY3FNZW41WkJo?=
 =?utf-8?B?ajdVZzRTT3A4LzRTN05IZGFjTDVvT3Axc2U0TnhGdFRLaHhpNk9NOXV4eE1M?=
 =?utf-8?B?R3lIVnQ2Q2dsNDBBb1FPLzJ3enF1RmVHSElnTXM3RW1pNlJBTldEQTl1K1o0?=
 =?utf-8?B?RnhjelJ6MmlEZEoySWpwelVjeEFqRHFxaWFqL200dzU4eTBtRXlUN05WQTFN?=
 =?utf-8?B?Qm9XdUxQWWFEdnlyTjBBTnJoUlFjMUFpS0ZvL1Q1dlhtSnpZbzBQNktQL1lQ?=
 =?utf-8?B?Qm1QRHRtQ3VyM1pmREpzc01HUWo3UnVJOG9lM1RCZ1lBcG5rZWw0bS9HeTJD?=
 =?utf-8?B?dWpTbUpMUjcwNEpZS0ViWkxzTDQ4WmY5OGc3WGdKR2R5TTA3Smh1Y2lBRHh0?=
 =?utf-8?B?RW5GVFJab2ZjSEdMUTU4M1BvYXcrOERGUGoxbXJ6c0RrdEdvQ2JOMTZXeW55?=
 =?utf-8?B?dWcwQnpaSE02QUV5ZUx1VlhtR0JjOS9VS3FMRG1wdE50cngwaEszQzE4QzVv?=
 =?utf-8?B?bldYSFZmTFFFbjNqakZVcktHcmF0Y2lBNlpUZVFaMndYd1FEUy9Hei9SUWp1?=
 =?utf-8?B?cnNHZ1h5cExBaEFPMWlqWmg4cHBlOGlXbGVXbzBMTDdoZ0ZLOWkvbzRsS2c2?=
 =?utf-8?B?VGVZUHRUWXA5VGJuVFQyNFhINCsxZXRsVUw5WnZZaWxwYjkxeVJ1OUJ6Sjh4?=
 =?utf-8?B?TmVST0NNbUY5Mk8rVE1EWFFHM1Z2bkRNVWhlQXJLQkFvREM3eE1pbnBtK0lI?=
 =?utf-8?B?aU1lYzYzNTdSNnoxVkYya3VDRS9qV29FU0JBTTdYMFpzekc4SW04SU9PQkJ0?=
 =?utf-8?B?K2UyRXF5RW5pUUZnRXhMbjJqRjdXMTJYVDROMkhQTndRTW9RSnRpTVBJOEF1?=
 =?utf-8?B?Vmc2S0RwbTA5dVNiSHdTY0hlS25QUmkwRHU1WUpWeENSWE5RYnlrNEdBaEs5?=
 =?utf-8?B?ZzJWVVlvVmhRc3FaMkYxTFZxbDdVU3l5WnhUZndxeVBlM1FhZ2FQZEpUTUxs?=
 =?utf-8?B?cGdic25RN1BrZ2xtSFlZWnliSDlEYmxTYkc2NVppN05HM3UrOXBMaXA3RXda?=
 =?utf-8?B?VzIyQlA1eWpMby9naENUMjZIdU5uQ1NsNzVDMFdOV0F1QTQ5eU11dTlGbXJv?=
 =?utf-8?B?V2JaYzIrZlQ5a0Rvei9YcTA5UGpaeVhZNjAyTmZRT3MxOURJQitOQnlTTUJI?=
 =?utf-8?B?V2x1Rmd2S1VOWGQxOVVzQ2JqZmxramtlYVhDM2JLU0RDWVdMQTYzcEQvVHhZ?=
 =?utf-8?B?UU4xNFNpWVRxN01naHRWRzJ4TU0vVnk1VUppVXlodC9mcmd1TWx2QWV1RjV2?=
 =?utf-8?B?dnlwQUhMTkpuVTdwSE1wTzQ1ck1DbitqSlYxT2E0TW5WWUVxMWF4Vk5KaFdi?=
 =?utf-8?B?WmtHUlcrSHZEL2pLNFdUWUVxeDV4NWVqU3pRUVBtVDhQWlVQRFFvQUx3c0Rv?=
 =?utf-8?B?d2k0UmxCR2ZHOHZQTHVNbGhkQmJUYTdabXB3L3NscHdoRWFaeFlYa2E5TDBQ?=
 =?utf-8?B?TkZ3eGUvbjdaaXZlQUJLdzREdFYwZnVVUEE2WUVqUVJYR1RhMGl5VmRQMjlL?=
 =?utf-8?B?V3ZqK0h2L0RUdUFJRHZkQkh0K2VCd01VbHo1amkyL1hMMmd2MUdUVEU1dmJG?=
 =?utf-8?Q?F5SacCvUlQWcuQS+ZW+xi7IkQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7ec366-beea-481d-a263-08daf3dd9a85
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 14:10:33.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnjg7Jis6U/Dgq68FTiKfsGqeqW1JQvnAOPZD/LNiy9v3/fbi3fHhnh3XW4SQTcJeu3BzS9vEiI2dquQIZwJDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/23 18:57, Amadeusz Sławiński wrote:
> On 1/11/2023 10:02 AM, Vijendar Mukunda wrote:
>> Create platform devices for sdw controllers and PDM controller
>> based on ACP pin config selection and ACPI fw handle for
>> pink sardine platform.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
>> ---
>>   include/linux/soundwire/sdw_amd.h |  18 +++
>>   sound/soc/amd/ps/acp63.h          |  24 ++-
>>   sound/soc/amd/ps/pci-ps.c         | 248 ++++++++++++++++++++++++++++--
>>   3 files changed, 277 insertions(+), 13 deletions(-)
>>   create mode 100644 include/linux/soundwire/sdw_amd.h
>>
>
> ...
>
>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>> index e86f23d97584..85154cf0b2a2 100644
>> --- a/sound/soc/amd/ps/pci-ps.c
>> +++ b/sound/soc/amd/ps/pci-ps.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/interrupt.h>
>>   #include <sound/pcm_params.h>
>>   #include <linux/pm_runtime.h>
>> +#include <linux/soundwire/sdw_amd.h>
>>     #include "acp63.h"
>>   @@ -134,12 +135,68 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>>       return IRQ_NONE;
>>   }
>>   -static void get_acp63_device_config(u32 config, struct pci_dev *pci,
>> -                    struct acp63_dev_data *acp_data)
>> +static int sdw_amd_scan_controller(struct device *dev)
>> +{
>> +    struct acp63_dev_data *acp_data;
>> +    struct fwnode_handle *link;
>> +    char name[32];
>> +    u8 count = 0;
>> +    u32 acp_sdw_power_mode = 0;
>> +    int index;
>> +    int ret;
>> +
>> +    acp_data = dev_get_drvdata(dev);
>> +    acp_data->acp_sdw_power_off = true;
>> +    /* Found controller, find links supported */
>> +    ret = fwnode_property_read_u8_array((acp_data->sdw_fw_node),
>> +                        "mipi-sdw-master-count", &count, 1);
>> +
>> +    if (ret) {
>> +        dev_err(dev,
>> +            "Failed to read mipi-sdw-master-count: %d\n", ret);
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Check count is within bounds */
>> +    if (count > AMD_SDW_MAX_CONTROLLERS) {
>> +        dev_err(dev, "Controller count %d exceeds max %d\n",
>> +            count, AMD_SDW_MAX_CONTROLLERS);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!count) {
>> +        dev_warn(dev, "No SoundWire controllers detected\n");
>> +        return -EINVAL;
>> +    }
>> +    dev_dbg(dev, "ACPI reports %d Soundwire Controller devices\n", count);
>> +    acp_data->sdw_master_count  = count;
>
> Double space before '='.
> will fix it.
>> +    for (index = 0; index < count; index++) {
>> +        snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
>> +        link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
>> +        if (!link) {
>> +            dev_err(dev, "Master node %s not found\n", name);
>> +            return -EIO;
>> +        }
>> +
>> +        fwnode_property_read_u32(link, "amd-sdw-power-mode",
>> +                     &acp_sdw_power_mode);
>> +        if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE)
>> +            acp_data->acp_sdw_power_off = false;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
>>   {
>>       struct acpi_device *dmic_dev;
>> +    struct acpi_device *sdw_dev;
>> +    struct device *dev;
>>       const union acpi_object *obj;
>>       bool is_dmic_dev = false;
>> +    bool is_sdw_dev = false;
>> +    int ret;
>> +
>> +    dev = &pci->dev;
>>         dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
>
> If you set dev above, you might as well use it throughout the function context? Like above in ACPI_COMPANION? 

> will use pci->dev throughtout the function context.
>>       if (dmic_dev) {
>> @@ -149,22 +206,84 @@ static void get_acp63_device_config(u32 config, struct pci_dev *pci,
>>               is_dmic_dev = true;
>>       }
>>   +    sdw_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_SDW_ADDR, 0);
>> +    if (sdw_dev) {
>> +        is_sdw_dev = true;
>> +        acp_data->sdw_fw_node = acpi_fwnode_handle(sdw_dev);
>> +        ret = sdw_amd_scan_controller(dev);
>
> Or just use &pci->dev here, so there is no need for separate variable?

> will remove the "dev" local variable.
>
>

