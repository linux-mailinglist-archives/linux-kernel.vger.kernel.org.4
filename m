Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4516958DC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjBNGKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjBNGKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:10:44 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3B9CA26
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:10:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkSHP5qU8D/c+eIQpaxJyo7rEOx/OP185KweQ6sac/Uf9t7MPVe7tel+KQd7BBYHwCQv9rU0kL3AIKqk4uJKXQ8iRb/pbNhSwgD9qNQFnSmgFZfr+p7tO9OGg9DfCKL7qAFpT4a6RVG1hVM6Ws96bvW+HEhntoWnZouGyokYcklayC3v8xUwiN+CIZPPQDhGYem3pRRRdley1Uh1wug2p2cK0qbwg1P/TFaMMG2xB1dTRJVE+JbjpUdg4Q6u6joQw9NC4oekGqNDbQSDvkaHqCeB5k2H0jYYpZeiJXUimHzGeGHWghnYQ+6jDrLLGN/hI4NZbg6gWaoN6EwK9uHj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRuFYJ74r6DKg264oMjqsAd3RviRkOayWaoWTtlgD0o=;
 b=LJGVQCdV9sR+LKYZwmYQmCnkzvh63htKBgXQmKASjS4DGpjlo9GlKT8Sf/Bk/Mah4SZLcvqdX4wtAG4a2k348v0pjr6OlQX2X5wFIZrfc29nG7hSHfEHhGa1hEDMfdXQOruc77lL9JfaMWtILurPUermG3qCOJSSjuws+BpsS2edYIja1qoS8GmqL8RgxTkTlSn2Ip7k3MHlwoM7kYQperJi+SDbSjsOGPzcq6MtxTo88VHtPzOOcq+Zn2yB+sziYZbkFCe9p+W3w4Or/AyUNyb/WWpqJdE90+gFnv+ezlsbey1BYVrmtY4TFlrDBOwyw2qckEQD3RCUTjGqaY4Z5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRuFYJ74r6DKg264oMjqsAd3RviRkOayWaoWTtlgD0o=;
 b=pfKzVy64G21neHehdJZkmNDdWLdd0XNPfs+FLI4rnkTjSJqop6TG0L0+OmgYQwcJyTAbe4xBCh/nN6DYKpdmyeA7N8WOu6VeuSzb8xKqzGM6Ah4RQg8Zei8CX1A3hPU6t2LGSZ73a/LXckAZxfySSi6dPDrDWjqVNcKRO3eJyWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 06:10:39 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 06:10:39 +0000
Message-ID: <65ec1f29-2ad2-acd6-feff-7d1d6f40ef8b@amd.com>
Date:   Tue, 14 Feb 2023 11:43:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 6/8] soundwire: amd: add runtime pm ops for AMD
 soundwire manager driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     amadeuszx.slawinski@linux.intel.com, Mario.Limonciello@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
 <20230213094031.2231058-7-Vijendar.Mukunda@amd.com>
 <383a8166-bc60-8557-e76b-f6287c967598@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <383a8166-bc60-8557-e76b-f6287c967598@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::21) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: e171d705-f333-4546-aa20-08db0e5231a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BzHG6HsCBvS7b1wd7YloToL7ZiKMlMrUsvKjDZ0xSGDNNiOtJre6j1ZH6tL/NDJ6AvX6fQ+H6U9roPdM++RDahd76e/7EA41PFGgWL36nMRNyM01/2rjx+ejYV/Ree8EYfKlD+RLJf3TjpWZf6GeLq4gEsxWH5yYoEnddQAFaLKkVKgq0Pab410INTEsWl4d6ghh2tkqoyi6QDohQ9VZ9SMq/e6vaX9xPGf4T/qFIA3ZPuJVnymWWZuQoiAcxuHUGLxrxEF4Bd0MJ/11onxnPlBRfSROMN2U5vvWbE4iavDGkZJlBap9I+f653DncVlphd+Y0LRALgaAHoDHNOA/e88wE6NysIsPPhQvjeEH2Q4SNZqi3HhsUvOMdaCYZTsjBwqRR/E3epLCmFKMUnZAv1Kdomd54XQM/cE7W9k0OAwllvBjzQYxToaAHLX11eedfC8IkzahBM+cw3EUkx2Zu76HhErDFQbeJ6cMJaMtN59Ngi5WFM/Zqq0aj1Q9shr3DSY15D5zFar/oRZd1viM+NsZ8watHtD8S9U3ZKT4JZwUtO+TZrcd+9NvABTF6ooRc4YIuOkhEvhLE1+ixoBjsxAGbjPAVtJnn8ZLy8pu8DGM39WFw9w+NbxIY8JtxJYzhXeo1m1zelmnj98Ikm8AG18CbSjc/HqXyqjDQ/lrkEKWt/lb4CBn4daZAi3wvaoYTi+zZcWBTX59Ce8x3sMZvyL1XxafIXKRocfjhEGdUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199018)(2906002)(36756003)(5660300002)(6512007)(83380400001)(26005)(186003)(2616005)(66476007)(38100700002)(8676002)(4326008)(66946007)(8936002)(316002)(54906003)(66556008)(41300700001)(6666004)(478600001)(6506007)(31696002)(53546011)(86362001)(6486002)(66899018)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3VDMEZzWTVickd3NHpJUGM5Rnl0VjNjUnp4OW1iMEprZXN1bVFHVXlSSW1C?=
 =?utf-8?B?SEgwMkVZeGppMzBvMTUvNW5Iejgza2c0RVVxaDVOVWxuVzFsdTFYOG44UDdG?=
 =?utf-8?B?UjU1SkMzVUwvZktuRms5VzJVZnFrTmhzc1I5MXlCVHJNR3JxSnZTdEQ0RFFU?=
 =?utf-8?B?Y1BNMFVIaTJiME9wbkdWdExYbitROVpacGQ3cW5OeTdid0lwTm40ZmVxVVgr?=
 =?utf-8?B?ckIyblBNRXNacndYN0l5TmQ4STJVb3pGTE5naWxOcyt6aXlJT0psTFpYZURK?=
 =?utf-8?B?NDMvTkprYTVBUTA0clBWbUFMdUE4Qm1EbHhIV2k0ZnIwelhaSnRLczlaa2ZR?=
 =?utf-8?B?aXFlSWhJTURsU2pPdU1NMkVLUDVzSUUrVHJVcFk5Ukp3dWQ2UUF4N0R5aStv?=
 =?utf-8?B?NXVQTWdKQ2JCeHhHaXdMdXpEQVN6QVNGOUJJVERhdlpQaUNzMmRpYnVnamhx?=
 =?utf-8?B?YklobEN4bVFRN3lZVXJvVkYzdGw4d2V5NUlWT3U1ZFNyOUZaL0dEc3k2THQ2?=
 =?utf-8?B?ZlVTMktOTmtaTFU3OUdBZ1l5Nk9MeWp2akdSUmZBUDNsS1RJeThSTnhXOEtG?=
 =?utf-8?B?TnBwd0h6MW9KV2ZybFo2UFo2UGdibG5icFdIeUlWZ3dMbHVQbXdnc2g3c2hk?=
 =?utf-8?B?YTVBbHgybFVEUjJwdnplMkZLR2RYbmltcHh6V0tmUFNzTmxqMzdvOEFZNTY4?=
 =?utf-8?B?SHVodTh3bnh4V0J6c1I5L2JRZTNubXZwbmpicW85UDRLOVJiWnFUeVhXWSsw?=
 =?utf-8?B?MGxLMnVScUU4MmhjMkRadEtoeXFCeXk3R29PS0RQVk8wNHhoUjR1T3hJdG9r?=
 =?utf-8?B?b1lQK09hdnJ4amJqdWtIak9sYkFCakxmS2xWTTRVbjIzc2FBYVdwVWp4RTdO?=
 =?utf-8?B?cmJESWpsb1QvM3VtU1RPOG5mUHJ5MldCYTFwNkJVNHVEQ3l4WWp2VmZodS85?=
 =?utf-8?B?UlhjOVJpWDRrMWtzN1FqOVlUUTNiSU05MzhiR3h6eC9zQWZyYWJNMmpPcy96?=
 =?utf-8?B?cWIzQjBwcWNzOENISy8vTDNnbjJSRlhsYW9yZ3o3d1NLSFl6OVMyMVd3Tmds?=
 =?utf-8?B?SjJBSjBQM1ErWTYxQTVtekNFaXlRakl2dGs0dk5EdXI1ZXB1bUt5SHJTdnEw?=
 =?utf-8?B?S3RpdVduQmVlVFRNQTM4TE4vRGdYNC9OYlBrNjNicGs1SkdCS1lJT3hJZE9S?=
 =?utf-8?B?NE9iaHd2L2FzK1hsN3FVVm1kR1JkZFI5TzduUGZ1REE1cmhhdDhwNHRMVmpU?=
 =?utf-8?B?eWM2TzU0eEdWbnh4RlZUSFEra0pSQy9xK1E1RHR5aVVpWWZ3amE0M0FsYUp1?=
 =?utf-8?B?Wkk5ODhMSDZEdUVhcHppNXpqKzBOUjU5bWY0Qk9EU1pGdktSa3RCZTh3QU1D?=
 =?utf-8?B?YmpUWHg2cnUzOExaNHFKUXB2V1l3dFE1aTY1N0ZBNTYzWGlMQmRnTnpVN2ho?=
 =?utf-8?B?emxWZWFCemduT2svaElBWU1jeTN0VS9xZS90S1hUbGRsQmhvdFAvb1YzMlVY?=
 =?utf-8?B?SGI3NHMzcUpHcUZmdCtaMW5DS3d2czZUNXRzU2Z5VjUzb2VOSGJnRitMSGlj?=
 =?utf-8?B?WHJIUkRQejF4OEl5VmFsTEYrQ0JlVkV6eGNUZVRNWGFFYzVRTElqQy91Y0xn?=
 =?utf-8?B?dFIrU0lRODMycHh2NzJ5Q0svSjFGYzh0RFZYS3F1UUUrQStCbytMOHBjenQy?=
 =?utf-8?B?TkZjakpGOVQyd1drdGd3c29UQk1laEpGY1pocEl1Z2lFOTdKdFRSQTE2WDVN?=
 =?utf-8?B?MXQ4UnJVK3I0M2xOQzZnSWkvVldjcGpUT0huTnY2TVBvUjV4WkdzM1ZnbEtX?=
 =?utf-8?B?NHBsUld1L25MWkhXbXdZbUkwaWNkZExOcEtwL0lsWitmMlQ5N3FqdDRmd0Iy?=
 =?utf-8?B?aEh6ZEd0S1A1NU9MTmIvRHBYRWpWR3RLTkhITTNoNVdaQ0J4a3hXVkxSR2RJ?=
 =?utf-8?B?TS9nMXNsK3MzbG11YmRBNnhnalFONFFWdkhCUWdSVndaUVRuVnFWSDlyNjNH?=
 =?utf-8?B?YWNOQ3UxaklxbWFGelVZRjhZUTVYUVBmKzJyTVV4aUIxSlpVVmxqaDlnTVFh?=
 =?utf-8?B?QmhkNFhudTNKQU0xc0tLeDFpNFEwZ1lvNnBXMFZGYzVkT05LU0g4VUZMSzM0?=
 =?utf-8?Q?H55+Sv3vnP+cw4h0binS5Q6rL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e171d705-f333-4546-aa20-08db0e5231a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 06:10:38.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylLClAsM9RInANRp6V6ViHeWUECrWaSl3m28k17UnpIcMHUW11EHvBYODS9Pn8I7taR13PWNxtTAWhSK793JKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/23 23:50, Pierre-Louis Bossart wrote:
>
> On 2/13/23 03:40, Vijendar Mukunda wrote:
>> Add support for runtime pm ops for AMD soundwire manager driver.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
>> ---
>>  drivers/soundwire/amd_manager.c   | 163 ++++++++++++++++++++++++++++++
>>  drivers/soundwire/amd_manager.h   |   3 +
>>  include/linux/soundwire/sdw_amd.h |  16 +++
>>  3 files changed, 182 insertions(+)
>>
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>> index 87f9a987d93a..eced189ba6e0 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/soundwire/sdw.h>
>>  #include <linux/soundwire/sdw_registers.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/wait.h>
>>  #include <sound/pcm_params.h>
>>  #include <sound/soc.h>
>> @@ -185,6 +186,15 @@ static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
>>  	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>>  }
>>  
>> +static int amd_deinit_sdw_manager(struct amd_sdw_manager *amd_manager)
>> +{
>> +	int ret;
>> +
>> +	amd_disable_sdw_interrupts(amd_manager);
>> +	ret = amd_disable_sdw_manager(amd_manager);
>> +	return ret;
>> +}
>> +
>>  static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
>>  {
>>  	u32 frame_size;
>> @@ -1043,6 +1053,12 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
>>  	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
>>  	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
>>  	schedule_work(&amd_manager->probe_work);
>> +	/* Enable runtime PM */
>> +	pm_runtime_set_autosuspend_delay(dev, AMD_SDW_MASTER_SUSPEND_DELAY_MS);
>> +	pm_runtime_use_autosuspend(dev);
>> +	pm_runtime_mark_last_busy(dev);
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
> that doesn't sound good to me, why do this here and not in the work
> function? That creates a racy case where the device might suspend before
> being initialized.
This can be moved to work function.
>
>>  	return 0;
>>  }
>>  
>> @@ -1057,14 +1073,161 @@ static int amd_sdw_manager_remove(struct platform_device *pdev)
>>  	amd_disable_sdw_interrupts(amd_manager);
>>  	sdw_bus_master_delete(&amd_manager->bus);
>>  	ret = amd_disable_sdw_manager(amd_manager);
>> +	pm_runtime_disable(&pdev->dev);
> shouldn't you do the pm_runtime_disable first?
I agree. Will fix it.
>
>>  	return ret;
>>  }
>> +/* AMD pm_runtime quirk definitions */
>> +
>> +/*
>> + * Force the clock to stop(ClockStopMode0) when suspend callback
>> + * is invoked.
>> + */
>> +#define AMD_SDW_CLK_STOP_MODE		1
>> +
>> +/*
>> + * Stop the bus when runtime suspend/system level suspend callback
>> + * is invoked. If set, a complete bus reset and re-enumeration will
>> + * be performed when the bus restarts.
>> + */
>> +#define AMD_SDW_POWER_OFF_MODE		2
> You need to clarify this mode, can you deal with device in-band wakes if
> the power is off?
On the Current platform, in-band wakes are not supported if the power is off.


>
>>  #define ACP_SDW0	0
>>  #define ACP_SDW1	1
>>  
>> @@ -57,6 +71,7 @@ struct sdw_amd_dai_runtime {
>>   * @instance: soundwire manager instance
>>   * @quirks: soundwire manager quirks
>>   * @wake_en_mask: wake enable mask per soundwire manager
>> + * @clk_stopped: flag set to true when clock is stopped
>>   * @power_mode_mask: flag interprets amd soundwire manager power mode
>>   * @dai_runtime_array: dai runtime array
>>   */
>> @@ -86,6 +101,7 @@ struct amd_sdw_manager {
>>  	u32 quirks;
>>  	u32 wake_en_mask;
>>  	u32 power_mode_mask;
>> +	bool clk_stopped;
>>  
>>  	struct sdw_amd_dai_runtime **dai_runtime_array;
>>  };

