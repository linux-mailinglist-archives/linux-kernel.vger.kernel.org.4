Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C186958E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjBNGNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjBNGMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:12:55 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C74E5590
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:12:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmbYSb6Q1s9xf1NQH9UYKXPDCbrlF+iEoEvZxqDC8dot3e5tYykPAY8z2NL9JaqaqClq20LxYlD/3kZaisAagDhqLLp4TzYKIGx3G2cKXYtih32Q6FfKjeqd+A3SHAwH4vEiqhTT43dyA+YVg6vWGVvcyuq+MVvyarF3HUvwYNKs29Q5X28fklFc7vRXsOjdMulczXW7Vs8O1e4m58w7j42Lel8fN4wBpqDqPZim47KkbReMnMS9BTNiAoQKD//1eayFls5Nd8oqzj6/vuW9LIykjSvS6KNiXiqa8aXdCoIOBFutqL0oA3878w4wox6zJbCUGLd6ze0MAe9XG2az6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW08WsjsnfXdE/p5NHwBmJEtD8QR8fg3bWqpBfCLS3c=;
 b=oQlwZ3sG+/BPb4v4d7fNum6Br14mdn/ZQDMSv7WNARsquLxVg0IpjUAuhie5myjbYywoNdLgEET60MgCk2z5zHNFRwHBCa+xAJeFAQpSH6HPXnk4xjBQn2k226JBM7/VyfcqPTDDH5iXMUS/+Y1EqwKwzu7Cuk8lrjSdKykn/irDQbVJHMJYhTGheakjqbxaAm43639R1lNHw6PMZQUJVYTl7cKofODu5VgOGyv/NtBjH0veI4u367My32LBHsYauqG9yGVhsRKu4ZRvLloKll6uwJsH+uJyUejXh/EhhRMFu589xko2hMCOPmLk2CRx9hRSbhzewq1UBnWS+KUfWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW08WsjsnfXdE/p5NHwBmJEtD8QR8fg3bWqpBfCLS3c=;
 b=MeqKdofVKNhK1XMk2Gg8ZJHH2KYXiqxN/LP14ldj26V9WrhcVme1Gx1RAvQjtV8sBjdXm1UGYETBFQQxMmrxy4kBN2joMa9wWOEt5vls2RAJQxNVLZQviTWCEStyhluTNHAIbM4ptSRqauL/FBeHegGo8rcpVUQ3oUrXy8pUPaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 06:12:50 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 06:12:50 +0000
Message-ID: <586a9f58-f660-1ac0-0506-91362b25f75d@amd.com>
Date:   Tue, 14 Feb 2023 11:45:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 7/8] soundwire: amd: handle soundwire wake enable
 interrupt
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
 <20230213094031.2231058-8-Vijendar.Mukunda@amd.com>
 <cd70a91c-231e-1bca-b0ac-4041cba0daad@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <cd70a91c-231e-1bca-b0ac-4041cba0daad@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::35) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e345be9-cae2-4b03-f611-08db0e527fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1CDuYtTURMfu3AJxvwknjZ0Z0d6CeFuevyGtco8nH9u5Qg6ytrCl7940oA/MjPvyUEq46cyqdVF59Buxl6RV75m98cCthcMCwp+J+rMsKhGt75qMAQEE4ddCh5qeB4fe5MInIVMcgugXJnBoPfV1rmsa7VejCrNP0ejf2hBj1OpR/JCVyzksEtXlR6xqVe8k58w6Dt3+Z9TIuZNEabMW5ek0b0XxkOZZe3cX5b0GvrtzLJ27nh79bo4fR8NXWaedSsskN6FTG86RbnXzXH1GT/f0SkdPnjcqOdHYaAa2viuVDgyfmHMVRmwBaJ65ysfytgREPAht7Wr52Q5de7x/GbV9yFkUl5i3z75A/+UUgv1xbftqsDSBaQgrXy9NWdndyyDntySUv8T9LoHPAc6oPzyG8Dh3WB4bTf7CsdTDCZ9zEr50ichsIDZ+fknveIJMDzlrFkkS/ABLg9LGgu7FfloDPT75wFUpjnhnLuWEq9b7oHhk1eo3Bft1AGGoxia4hJBxdMKy/Hrsfpu6bxY6baDS9mTTu0zVuOLZlRfx6g0BHq9i8h0ENoPCX4EJpxN10XTgFCh9QJuPXvqNxOV+Zf1lmb9j5xtZCXY2QMEcmbbLVYwswwXRAa1179Ddj6cEvZ9VXpw1wDGYtniYiLjnD0VOmc51hHD+sX/KLY8Ep/Yoh6aNZTgDsExlUn40w7Wbn73FN4g029Tl/ceXnoXVS6CgrT4enGeNkGD6D6Sezhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199018)(2906002)(36756003)(5660300002)(6512007)(83380400001)(26005)(186003)(2616005)(66476007)(38100700002)(8676002)(4326008)(66946007)(8936002)(316002)(54906003)(66556008)(41300700001)(6666004)(478600001)(6506007)(31696002)(53546011)(86362001)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDI5Um9BZGpxUndtdWJvZ2JCMXVvWEhVelNPSDFyWUFEbFNLV2RtVXBRV0dN?=
 =?utf-8?B?MUxrUVErNmY1a3Eyb1g4TmN6eHI4cXVEZnhmYld1SmhCZzlOM0JaMDJBZE5B?=
 =?utf-8?B?SUdMbkNMRTY1OEV6UnhabkxaRis1WkVEWStXSlArWUpMcU12MUdVZXhDOXlq?=
 =?utf-8?B?VzVGMlVHMzV6NE9PNGcvS3BQZ0daa2tYZmkxMWtIc2V2WUozRTRJWUhMV1Aw?=
 =?utf-8?B?bGlYaHYydlRVM1NYOGVNY2ZkeXFoMTBUZitWTjl5aXZTSElRRTdZaXl3a3hl?=
 =?utf-8?B?K1EwTHFjMjhUTGFyc2xRRzhSM0hSc3FEbW1jZ3R0dUJyN0orYkczNUYzWTVl?=
 =?utf-8?B?MUJQQitTQzdJR2Z0MHRIcFExQk9WREVlYXJXNk4vcjlndy9iMkdYOThsdFhK?=
 =?utf-8?B?WGNybzJicjBzek9ZN3dXK2s1YkxFZnp6eWJzelZvMnFLTTNQMWM5akNkclpX?=
 =?utf-8?B?R0haeEVoQnNWNzF2REFYdGRQYmRHRUMyVDRkU1lqbjhsZHVVcG1rRWNFblVD?=
 =?utf-8?B?YXYrQlBJZHl6ZHNYZXVLT1RnWjdYcTVkOXA1QkxGOHpXY01aeDFHUExrTjds?=
 =?utf-8?B?Q2cyWmFOcU9odnhyUmJ0cTVjMHJNc3RsbDQwNnBIWk5obzZobExOVXR1MGhW?=
 =?utf-8?B?d1grNW5WYk9KSW8veEVFZkczbS9oRG9Nc2tJUGtkYVlqWWc2U1ZjMC9Rc1FJ?=
 =?utf-8?B?cklHU0tnajhOUHFwNkI1MUV4c1U5L2dUN0VYV05kQVZ0aHE0WVZrVmUvdE1X?=
 =?utf-8?B?UWVPMUJXZERZSTY5NTRDb3JKdm9ta0tYSGtiU3M1OU0wMDFHbWFWbXZvYzY1?=
 =?utf-8?B?cUdVRktjc2hlU2FaY0hvdXRRNU5VdHRZVEtZZ1dlZlZ6eXExcHYvY3FUOXMx?=
 =?utf-8?B?RkRHU1dITVN4b1ArQXhNMmw5NmRPYTgxZGFjSnRCS3lPaU1wbGliek9UUzBw?=
 =?utf-8?B?SXpXa3RhSjFtTUpUQlZGckFqcGR6SzVJaWhCc2tjbDlZckY3em9iVS9LMGNI?=
 =?utf-8?B?TThyMnNQRStOM1JNU0JzSGk2N2xqRFdPeUVIa2VRTG54VDU4SVJWTDFjZHJy?=
 =?utf-8?B?UVlTSDFSWkkvek9sSVJibGdHRzJBcnFIYmZqbGtzeVZ3SnJGUmVOWkV3K3FN?=
 =?utf-8?B?Q1dNOHNIMmE0N3J5L091dytLc1lyVkViY2gxc1prQnhEbzIvRUM4MHNubGZl?=
 =?utf-8?B?cHRpSnZXeFd2MXowcmk1M2ZLaUJwVk5KZDVBTmN6V1Q0UUFQUmNpS1RETTQ4?=
 =?utf-8?B?azR4NVBzYWlJYUppYlA3VHQ2dGVPMHJXMzFVRGZlNDc4UE5BQ1VkSUhDby9m?=
 =?utf-8?B?TmJpcFBwTjBNaFErYVFuSk5QNzZEMS9MZ1NuN01GNGtIWjZ5czZZRUNIL1Er?=
 =?utf-8?B?cjI4SUYwSzU4eTNVbFZkNEpEUEFRdC9zS2RzU0ZlZkZOcjVLYU5PQTQ0Wkgz?=
 =?utf-8?B?VGtIZzluSWdkOFhyRmNMdkRTRlhxZUg1eUdQMlZmSVMzRThHVEE2SnlnR3Rl?=
 =?utf-8?B?TWdoL3E0VVhFSWc0UXA0ZVFTU1F6UzdBc2NseDkrNjRQUnNvakE2UVhrS1pC?=
 =?utf-8?B?ZEVSNjRKSm1ROEV3a2ZqTDU5WWhlaVNoMk1qL2xGZ21jTmFrdkVKaFQwUU4x?=
 =?utf-8?B?Zzd3SHNLNzNpb0J4MnQ3S0s1OWM2YVU5WXM0T2hWZTFVZVNyRTBIR3F5SENO?=
 =?utf-8?B?ODJFUW1UcTVDNXd5Ym84VUg1V3NVdUdiMFRSaVdybEoza3JHemN5c0tTSGhI?=
 =?utf-8?B?dC94MHBwMDJxR3FjYjRENmdVdkVMNDVUaFBVYVNqR213M1FCbG5IeVlWRms4?=
 =?utf-8?B?eGFFT1FVdzdraHpHN3JGSGJMcmJxeTlpZksyMFlxZGpzQXJqUmh0UW4zV3Ju?=
 =?utf-8?B?UFVOcy81RU1tcEdHZlhGZDZVajRTSzNXUk45UWhteXhRRXREckdoanpSQis4?=
 =?utf-8?B?K2p4SE14bEVFSzBsSmlvV2pqdFFvTDdSYlp5RkhnbEhLRDg4VEMvU2JGdytX?=
 =?utf-8?B?ZGIwdTVyc01ZT2hHY1J4czJCTFR1d0dPUytTNmVwamNrdVFoZ0YybW9Fdll3?=
 =?utf-8?B?NGdRZEhqUHU0U3owR0NMa2p6T3VQVlA2YTByZm83WENXQlR0OEpKQ2lIUVJS?=
 =?utf-8?Q?zHzXFh9Ro0mfoKgcrXWzvlqKd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e345be9-cae2-4b03-f611-08db0e527fc7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 06:12:50.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnUkcCY4/8Yps/CLXCSh2u6uSEk45TEPToAkv6Tg71MKCQeRyEAv0JBh1c5m9U+ve+kRhF5ApCl+LcuyplIMMA==
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

On 13/02/23 23:54, Pierre-Louis Bossart wrote:
>
> On 2/13/23 03:40, Vijendar Mukunda wrote:
>> Add wake enable interrupt support for both the soundwire manager
>> instances.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
>> ---
>>  drivers/soundwire/amd_manager.c | 10 ++++++++++
>>  drivers/soundwire/amd_manager.h |  1 +
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>> index eced189ba6e0..e53dc67f8529 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -934,6 +934,13 @@ static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_chang
>>  	}
>>  }
>>  
>> +static void amd_sdw_process_wake_event(struct amd_sdw_manager *amd_manager)
>> +{
>> +	pm_request_resume(amd_manager->dev);
>> +	acp_reg_writel(0x00, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
>> +}
>> +
>>  static void amd_sdw_irq_thread(struct work_struct *work)
>>  {
>>  	struct amd_sdw_manager *amd_manager =
>> @@ -945,6 +952,9 @@ static void amd_sdw_irq_thread(struct work_struct *work)
>>  	status_change_0to7 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
>>  	dev_dbg(amd_manager->dev, "%s [SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
>>  		__func__, amd_manager->instance, status_change_0to7, status_change_8to11);
>> +	if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK)
>> +		return amd_sdw_process_wake_event(amd_manager);
>> +
> it's not clear what 8to11 might have to do with the wake enable?
>
> Can't you have a wake for devices 1..7?
It can wake any device from 1..11 .
SoundWire Wake interrupt status bit is part of 8to11 register.
>
>
>>  	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
>>  		amd_sdw_read_and_process_ping_status(amd_manager);
>>  	} else {
>> diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
>> index 6ec37612ae4e..86bc6d4f48bf 100644
>> --- a/drivers/soundwire/amd_manager.h
>> +++ b/drivers/soundwire/amd_manager.h
>> @@ -190,6 +190,7 @@
>>  #define AMD_SDW_CLK_STOP_DONE				1
>>  #define AMD_SDW_CLK_RESUME_REQ				2
>>  #define AMD_SDW_CLK_RESUME_DONE				3
>> +#define AMD_SDW_WAKE_STAT_MASK				BIT(16)
>>  
>>  enum amd_sdw_cmd_type {
>>  	AMD_SDW_CMD_PING = 0,

