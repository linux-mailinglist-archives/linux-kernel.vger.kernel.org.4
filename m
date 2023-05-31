Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E18717806
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjEaHY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbjEaHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:24:09 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399F9192
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:24:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5skxZEoUEbpkXS8+jc96wzFzqMJr6x5eeRLO2mVS0EhuPnrSilxtZbWz0nLW9ozHKM8YgshNucQiXdRlCEu0d/2ArFjL1bSRzoy1soyyE9mEyjup4QdhkTMREHTdf2oRr6lndKVRAcZNvRXOW1LB8jzaw2vNMApw2DQYltLSWXXxvQ89IgH0aGqWR6rR+LWBRC9Zr4WzWuSs0Nu2G+ntI1kT3igwuYWiDoAqgfVh24LGi7zhPWZcUiLmnN1gOsqeE264XbISllXacewtRTxBamPb4SzuNH8mYtMp/wfDyhaAYBkJ9qtUcRdR0xckhxzhUwdPawG4ulM+FUKQlPprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkfzkDis49ejdcSjbdoEXgZCuD7z4UzD9kAkIqc4Ckk=;
 b=UjY6ykrTW0Xa+yUKtGlvIcsUFTHktx6P7KY5HrZMYL46GIIWUXCdtqhurkh8+r2IaZprbkrsMynILamWnhwW8Tt7DoE+DZ2KkezIbcB07OX9SmKNbOy/j7WZ8YbbGILym/a/GQSRNQhqlrUtDboXcDCRLJGPvCRhygDOsGgF+PPlHh61Ov8rPcpK3g9bnNsLt26pdtM6TrkgekDm8c935nhxzAWLbomesPSU6+BLnh8C0siWflaYD3X1wRAPo8NPOdoWGZ3scx9VW8CM6IBvt6pdDH2V+6hNzgSFegIIKZxKJNMm8w2bg35/CVlH5yxck4aFEo/2lu2obia8NpEDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkfzkDis49ejdcSjbdoEXgZCuD7z4UzD9kAkIqc4Ckk=;
 b=5pvwvgqjCq35nheLcWHfzqB08HRsV4e3DyuX17TXgYA5pmBkefpP5t8ML0nOT8GlTY4NXVTzxyp+tyrBvmN15S+45SrAdTm8k8+Y52ikmyIeZdRjjmYbW8tsKn0J4/gZOghSpwI9qQTHcQYLoj2mBYqP3FQQksY3ZlQ206a2IOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 07:23:59 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8700:a051:2ddf:d350]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8700:a051:2ddf:d350%5]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 07:23:58 +0000
Message-ID: <af5b0669-2621-7fce-358c-76dca7b521c5@amd.com>
Date:   Wed, 31 May 2023 12:58:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 5/9] ASoC: amd: ps: add support for SoundWire DMA
 interrupts
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
 <20230522133122.166841-6-Vijendar.Mukunda@amd.com>
 <fea3c862-1470-7911-ff77-5d945b1d77cf@linux.intel.com>
 <2dfeee7c-32bd-c054-22ff-3a2266e62c90@amd.com>
 <f11f3370-0b72-cb1f-21cf-c574ef03fd72@linux.intel.com>
 <017abf89-a1aa-0c85-e244-a56c05b7c6e2@amd.com>
In-Reply-To: <017abf89-a1aa-0c85-e244-a56c05b7c6e2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::6) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DS7PR12MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d66883-15f2-40c8-acfc-08db61a7ffd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72aQecFX8/OaTHJ7POHbSUt54xttQTabtk9a04Di5HOejVaTANYDlehtKbQXpAdoNbDzeysUTalGgdquYWUQYDpj58jZjUkNbZNdJye8lE4UzKqF5bfCykRXChY2FqJOOAT4d/RYUDAFr5KGZADQXLs3QKqhaDF0ezjUAd1uXBCU1zAAKG0Y7rdd1ev4GeJHYB0Vqwb/jQKLSwUAOG2pPNmHVf89qfA+qUk80hYbr0q0Y21YIQ1SMi0UvA2A41/W2vngKj3r2jS13Wc0AfVTsXyI/my/pteMix14bsDCbg2aXI4oAR7Zd2jBLjOsg4pNbnhgJ6YwLhA8x7pyflIk/dfG6DzaE/r8rGLWaikcrBFvfh1ZJaGGNKc+rUnPzsRs27YY5JEyXRYagpc+ThM7T8pXITgyhp2FcqC4iE9Y+C77n2dfKKYSXNozapfFWbASYpKQ1UGXfhS+iS7kC8Rl0AFQGBMOaXnD/T2XFoIMIZWFbwfriCyfPBaUQ9/fUccMiiw0HfhNT6Jd06nBMalWIMZcWp+WYGIsSyOcOKQjY5EnCeIR7+YtgGyq9KLksH63bymONp9kdvvTU8uAoR1SZt4ZPl1EDTWw//YTTQKLZf+l0smgjd8PlHBVV8vFv6qlSWmrQu0/kCd26y8gCFzYTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(8676002)(478600001)(8936002)(54906003)(41300700001)(316002)(5660300002)(86362001)(6666004)(6486002)(4326008)(31686004)(66556008)(66946007)(53546011)(6512007)(6506007)(66476007)(31696002)(26005)(186003)(2616005)(83380400001)(2906002)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anFsT2gwb2k3Q1loV3FXYVlicWxPRUh0djlQRWtsR2ovVGZoenhhc2V5L2E3?=
 =?utf-8?B?c0VlQVkvTHVRUmJYYjZSSTNqVDltV3VmMlFGdUVWblFkYldySHlQcG9UdGVk?=
 =?utf-8?B?R0lzV2lkcGE3MEloOGh4Q3BNbGRmM3Y2QmYwdmtZN3ZLTXBWUVFrUGxGTHpJ?=
 =?utf-8?B?MHpxV3NLU2xtSTZTSDBuOU9DTld1d2l5TmpFTTFyUWFLYzAvbFFob3ZtdExn?=
 =?utf-8?B?bEljMHlKaTJqMUFJM0FrWXkyd0hOa0k1enZYbmp1cTdFbkVnTExqSm1pT05y?=
 =?utf-8?B?WHlHQ0REMnRBNlZnRWVwSngwMzR0ZDB4a3VyNGdzRkZMVXExTUpFL1UxVkVu?=
 =?utf-8?B?azhNOXpGWkJzbEt6c2NsMk9FdUduRGJFUzBVc0cxS2tDUTUyYzVMUVZuTnFH?=
 =?utf-8?B?NjA1cENGcEZTK1Z4SEFSMVRPWk9Rbm9HTEY3WXRoUE1sa3BzTFBkVjlrSzRY?=
 =?utf-8?B?MFY4S01nVTdNQTRldTF4RmNDSFU0OGJXL29ZeTh1VnUzWTJya1BMUE8rUnRt?=
 =?utf-8?B?c0hUUjJmQ1lYTEsvU1FVUE85MEJyc2xzQjV0bWdIRy9YdFNMbVRhTXBJWWty?=
 =?utf-8?B?SW8yTlRMZDZkcVpDb1VBbjIrT3IyOFFaeVdLdng1NVM1OE9IeUJ5RzNnWW5Y?=
 =?utf-8?B?SjY4c1cyV3Zyc3Q3bGViekgxVytPWDN2Yk9tQVJoRGVNdlpaTWhxZnVjMkg1?=
 =?utf-8?B?SkxzVk8xcWlIUzhVUGVjU2R0a1c1cGpMamN2bGV1c2NRQjFXdUNsZmUwaHEx?=
 =?utf-8?B?aURSRGRuWDFYdHVSWUYrZ1ArNnI1ZE13TGJPWG1kOUk5SmQ4V1ZGUFk0Y2o2?=
 =?utf-8?B?czNsbFdySng2Uk15QWUxcEFIeWVhYjlqenFHLzhpUkM1N20wZ1VDOStzb1ZI?=
 =?utf-8?B?YWpzY3REV0hmcU1iam9LZ3NyUmQxNDY5T2NIWTdTeHB3ZjN3cGNxR3pWc0xK?=
 =?utf-8?B?b3I1RkIrR0Jkay9WNnEyZEhkYlZ1TVJmVk1SR1VLUEs1ZTVMbVNrcWVtS1Vo?=
 =?utf-8?B?cnhIVjlscXZucEZGWG9ZVFoxZzRDUDF3bkxVMUl0SW5BSTdFN2dwVG8rZndo?=
 =?utf-8?B?WXhlUE1UVUJqbVh2OEthZTlCRDRkMmRFR2o3ZmNyWXRlcFpjNnFsS0lvQ2ZW?=
 =?utf-8?B?aklZejFuZW9vR3JvQ2J2clRIaDJPT2VoYTNmOHdZckJ1OTBlMks4cXd6bTYw?=
 =?utf-8?B?bWJISFN4QnlleVBkNGJaNTBBbzYvYVNpcERYZ21ZQm9MbmZFSFBpbkNHNWJP?=
 =?utf-8?B?UlZ5MUJocjRtZjZkQTJEOWFxM1VNaCtTVU45WkFlNStqMzZPZklndWRub1Jt?=
 =?utf-8?B?cHdXT0loM082V3ZuTytrMDJqL0YxdHhmdFRETUpTZXUwN3JnQ2NiMWRaajYx?=
 =?utf-8?B?b0U5OWN5dXlQUmk0eWVLdVhZaE10eTVET1N5UFRLNzY1TmcrWWd5aUhZbFUv?=
 =?utf-8?B?aUk4VFZSOVVycGl4OG1ib243WVlwUExSYW4wVkdVM1h0T2NEM3pzZlUyWERW?=
 =?utf-8?B?SG5yZHc2N25rczJ3S3VER1h5b2lpcDVUNDAzVVhwNStPYmUxU0htdHhQbHhz?=
 =?utf-8?B?cUM2N3V1ZDlYZGxiYVVoZjZaQmtHQmY1OXpxcDlnRjl1Z2Q0YStKaUdSeHpU?=
 =?utf-8?B?amZKZldJbDF3UGpmZzR4RXFqZWgwdWdyYWQxVWlKQmpHMklpSktqdXAyMG4v?=
 =?utf-8?B?clZxU1lqVFM3Y0FrbGxEVUZzYzdUOHBQRXF3REI3dVlUQ044WXpWc2NsdzhO?=
 =?utf-8?B?UUlGUzczaVhTRVJLbnpHdy9sYU81NGVzc2RjRUNjU2ZBb3ZGbzREbWRJVUp4?=
 =?utf-8?B?NllCRUUwQ1RNNjVNSGtrdlM0M25OQWEwRk1pRkRibGd5ZGxyU2ludndhS1dt?=
 =?utf-8?B?QmNCUUlmOS9UVExjQkUwY3RsOGkrSWlVQ3ZTTDYvbnFRWWVMenBSTjFnYkhS?=
 =?utf-8?B?VmE4amN3aHlPa04xR1JVelBKTzE4RTR2anJUV1NRNThjSmQ1eWVrYmkwNHJj?=
 =?utf-8?B?RnRVTGhpcVBmMzFXemt1VUR5dXJjdnUzc0czdDQrRFlRRE5QcXB1RjJEbEJk?=
 =?utf-8?B?c0dzSVQzeG5JcGk1U1Y3UC95QWVXYlhYR0RhaCttNC9Ga2I2ck1jc3dPR200?=
 =?utf-8?Q?s9aVbBcbY3ccAMFbQ+jJl+w36?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d66883-15f2-40c8-acfc-08db61a7ffd2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 07:23:58.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlVH3QDfmMd5hFVDQDpP1Rk7CsmcFEq9Liv0YM3YhbCaZ/HxWOhADA41kIHr9Rbw8mE5zGxcYvPXqIjML/YXSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
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

On 24/05/23 13:15, Mukunda,Vijendar wrote:
> On 23/05/23 20:30, Pierre-Louis Bossart wrote:
>> On 5/23/23 02:36, Mukunda,Vijendar wrote:
>>> On 22/05/23 23:42, Pierre-Louis Bossart wrote:
>>>> On 5/22/23 08:31, Vijendar Mukunda wrote:
>>>>> Initialize workqueue for SoundWire DMA interrupts handling.
>>>>> Whenever audio data equal to the SoundWire FIFO watermark level
>>>>> are produced/consumed, interrupt is generated.
>>>>> Acknowledge the interrupt and schedule the workqueue.
>>>> It would help to explain why a work queue is needed is the first place,
>>>> as opposed to handling periods in the interrupt thread.
>>> For SoundWire DAI link, we are setting nonatomic flag to true.
>>> If we return period elapsed from hard irq handler instead of workqueue,
>>> soft lock up is observed during stream closure.
>>>
>>> We can use interrupt thread as well. To have a symmetry with
>>> SoundWire manager work queues, we have used workqueue for
>>> DMA interrupts.
>> Oh, I completely missed the model here.
>>
>> If you are using the bottom half/hard irq handler to read status
>> information, the natural thing to do would be to have an irq thread, no?
>>
>> Not sure I see the benefit of aligning with the manager work queues -
>> unless it makes your life simpler to avoid race conditions with
>> cancel_work_sync()?
> We can implement request_threaded_irq() and move the handling of
> DMA interrupts to thread function whereas we need to handle SoundWire
> manager interrupts in top half only. Reason as follows.
>
> As per our design, we are not masking the interrupts in top half and
> restoring mask after thread execution like Intel and
> our IP supports line based interrupts. If we move SoundWire manager
> interrupt handling to thread function, we have observed interrupts are
> reported but not handled properly due to thread execution is in progress
> sometimes.
> we will add comments for this design constraint in the code if we have to
> go with threaded_irq implementation.
>
> @Bossart: we are waiting for your reply.
>>>>> +static void acp63_sdw_dma_workthread(struct work_struct *work)
>>>>> +{
>>>>> +	struct acp63_dev_data *adata = container_of(work, struct acp63_dev_data,
>>>>> +						    acp_sdw_dma_work);
>>>>> +	struct sdw_dma_dev_data *sdw_dma_data;
>>>>> +	u32 stream_index;
>>>>> +	u16 pdev_index;
>>>>> +
>>>>> +	pdev_index = adata->sdw_dma_dev_index;
>>>>> +	sdw_dma_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>>>>> +
>>>>> +	for (stream_index = 0; stream_index < ACP63_SDW0_DMA_MAX_STREAMS; stream_index++) {
>>>>> +		if (adata->sdw0_dma_intr_stat[stream_index]) {
>>>>> +			if (sdw_dma_data->sdw0_dma_stream[stream_index])
>>>>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw0_dma_stream[stream_index]);
>>>>> +			adata->sdw0_dma_intr_stat[stream_index] = 0;
>>>>> +		}
>>>>> +	}
>>>>> +	for (stream_index = 0; stream_index < ACP63_SDW1_DMA_MAX_STREAMS; stream_index++) {
>>>>> +		if (adata->sdw1_dma_intr_stat[stream_index]) {
>>>>> +			if (sdw_dma_data->sdw1_dma_stream[stream_index])
>>>>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw1_dma_stream[stream_index]);
>>>>> +			adata->sdw1_dma_intr_stat[stream_index] = 0;
>>>>> +		}
>>>>> +	}
>>>> I am not clear on the benefits of the workqueue which only tests a flag
>>>> that's set ...
>>> In top half, we are checking all stream irq mask and setting
>>> corresponding stream id index in interrupt status array when dma
>>> irq is raised.
>>>
>>> Our intention is to handle snd_pcm_period_elapsed in process context.
>>> if the flag is set, call the period elapsed for the substream based on stream
>>> id in work queue.

