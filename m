Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6AC70EF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbjEXHkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjEXHkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:40:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D039B8F
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvPbv3ksoK7gT+BNFvhWCedNT9yHEPK+GACt8nUNYoe5dhcjAo2424vLwt/AXU9hgKNJz3R6Ej2G776qTvK4ycw4WppC5quqK7LpREhXKgbw4eB+gM7cz2KI9ErKoUAh/ENASZWgdRtP8KbhrW3Rh0hYSn6lBdSlxfg4IBv5R2+o/6it7+kpdPzG9a3gy4Y8kJwTnhm95zHmiBQbzSV616sQNzDmKZCIFzpGVXAYwy3jDeyHkfzzpcee7UmerMwuPWxVR2MCR0XHaAmYJMf4x+rFlmKhUYNFzwSCVFN3yByB2raNcPVQwxmGhE443wer9mf5evD5F+diToY38KAGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78N8cT4/Uxc5Bx/bPB0fc5glJgTP0FkI8uNrKrmvX1Q=;
 b=DblI5sw+hh/ZGtmu5jMHPNS2ykkjzQc+Xqw9WXXdYyreWeQVkK8+iGank1VCJMVe9VI1zE2+FnB6vyj0lepej5+oEM6nWAt/nW3UgZZiiZRX6JwbaNMTf7E+6DevKY+LcUXjoBzaOY14Qab0bVJBzVRuPpKj8r7srRpoMCT2qql9Y67Te9p8oEsj59RBda2Jm1ukJazLqKyNMMrIIL48O52oUrP7HXB6q5BNCSfXMGhFGMEZ/ez1iRsf2Yil4D1IU2bcmZdaMMGEg8sACxrTHiHbfeMia8Lluz68xz1KsJzOYcbM1IKjkUdQ0ZZLtZ+Mqvq6JjFx2JmnvTd6Ue4EbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78N8cT4/Uxc5Bx/bPB0fc5glJgTP0FkI8uNrKrmvX1Q=;
 b=k+QH32ps+JoruUbC7cjAhT0+TuCM6/9ZIolKNQ1OTyJqhynFK3VWK6Z0m07hPQHKCKoRShF2fBHYb3ZT2fqrynH9/yRqU4RYNs0La78zlBCFr9vUYGc9LwRR3vQJvfc5x3J3KdAHItM+N8HaVJDjFWh5ODAFft5uux8Bcl/p2ww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 07:40:16 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8700:a051:2ddf:d350]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8700:a051:2ddf:d350%4]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 07:40:15 +0000
Message-ID: <017abf89-a1aa-0c85-e244-a56c05b7c6e2@amd.com>
Date:   Wed, 24 May 2023 13:15:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 5/9] ASoC: amd: ps: add support for SoundWire DMA
 interrupts
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
 <20230522133122.166841-6-Vijendar.Mukunda@amd.com>
 <fea3c862-1470-7911-ff77-5d945b1d77cf@linux.intel.com>
 <2dfeee7c-32bd-c054-22ff-3a2266e62c90@amd.com>
 <f11f3370-0b72-cb1f-21cf-c574ef03fd72@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <f11f3370-0b72-cb1f-21cf-c574ef03fd72@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::32) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bbc12b-6f28-40de-1ebf-08db5c2a1d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+1pqUWHt1VrqXeQ/LEpch3jpEv/9eFR616B4TL1Ck1IXeAzHMDc+7AmIA7gMzcZOF+KgGKrbV62gjt86Oj7YADkAchxewx25zVlszlj7iTVoFKRmUsf0/l8t5jI9ihwf6Zk56D7L2wIRTfrDcziUStGefntUlNNVxi2JVQhMCCPQ7DIct3kOBVZwRwDXcWtXcREyRs7IwDNqw6dg9STIDsmtb3vkKRXer5ktH7YeTUZVGUWdLi1zSsj7WLRXAf7hn4doRbWRBOgesw9wkaIo7fBQH2BXgw9XTlLBnQkHdVIQP9ewJ1Lgnek9nxXJWqkhE4pcrCspflN2Mw+R1Cd9tIBArjG6VlONltO2gyzQknLGQIHCtiQMsQqUnIQ271vcWnMav4DYTNeytxj4iZ+DsStRb+Rmp4TFdWo92TV2CneDaBAAXWOxbbw+fl47aWZk0L51WqdNhs9oPG4793apfp+IrV6jj3QGrv+CsNDeXQB+yXgM0uZzF3SMCcOOp7HSmv6YizxZhk6P+I4CD42ge3rF6nuUKRqHknY2hWjY2uJz2OYgGMPf83dS5s+onz41xAQyoB01ScvvcpTJ4/B6rzWZNo6TqyO8E56aUVbiRyyQfuMbrN7Y9tJ/LspmUOO+d0X8ephalRwM6zHggPiQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(53546011)(6512007)(8676002)(8936002)(83380400001)(38100700002)(86362001)(31696002)(36756003)(6506007)(2616005)(2906002)(41300700001)(66946007)(66556008)(66476007)(31686004)(4326008)(6666004)(6486002)(316002)(26005)(5660300002)(54906003)(186003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anVkZk5ORGk5ajc5VVlnVU9WVjZ6MTUzbjJuR01SWVFjOU5XYmJyM0MrWEw4?=
 =?utf-8?B?ZSswRm1tbjFDampFdFlNNnd5eWtJRW1SR1RCYXB5ZGpzWTBLemZMdnRNdjZV?=
 =?utf-8?B?bTR3R3BnTHJNdXE4RnNBVEpyT1RpMWd0UTYyZ3pTcEltSzQzcmZ1SEwyZm9C?=
 =?utf-8?B?WGZJWDErU2tDc3V2WnVwSUx6V0piOTBqMUtTTFJFd0N3S01jaUt5eDl4RDJz?=
 =?utf-8?B?YUdHZ3lrOERsY1Q4NkQrdGdrZlBhNEZCb1VGSC9YcFFLdVNUZldrNDRVNUhD?=
 =?utf-8?B?Y09EMXlqQ25IZjErWWQyOFowaTA1VTdIMHM5UEo3TXRTbHh3MVdkM1V3QUNF?=
 =?utf-8?B?dDNEb3ppNU9XeWVLLzJEVWl4Nk5pY1pBNzhXb0p4cHk2VHp1YkkrMzlVek00?=
 =?utf-8?B?S09VWXEvYUF0ZlZTcU96T25RZjZJMDRtNnhtWWJWazZVYk5TZFR6V0xXZzlI?=
 =?utf-8?B?bWZsdjh0dmVEUGVZT1ZLTDZWMFkzUWJ5RXFJQklSU2FQL01GemVCa21OR01a?=
 =?utf-8?B?QUNiRmhFNytlbDhnclp4VW02Zjk2NmNEZzZkbDk5ZzZhM0hpVFh1V1VzQUw1?=
 =?utf-8?B?TVFGTlFWMnIzeUhVRjFnYW1FR3pYY29XV0duNVllbVpIM2NBVGpwbnlnZm1C?=
 =?utf-8?B?K2lBZmlSaGc3UDdEUFdWOG1jYUVGLzlFUHlCRWhuK2hVK1FXV24rYWFzcEJa?=
 =?utf-8?B?QlZmRHg0N0kwdTBZcm9YcEJCdHIwekFoa3RrZm9MbGxCMWdDS3hGUFFKTGRP?=
 =?utf-8?B?TWlTblRKaWhjdHNzaWUxbUQyNStzaWg5QzF4MmwwMnZLbEtvdVNOYTQ4VVJq?=
 =?utf-8?B?cW85emo1cTNKNFBJSDdOeGJEQ3JUcG82VjltVVN1RFlESHhVaXI4U1lqellC?=
 =?utf-8?B?eHRtMkhTbWhBMUhKQlpxQzd4ZjFUUHBXTmNtM2hCVUFiSXNDRm9CSDlnUFFS?=
 =?utf-8?B?UTg2NDNTNW9OYndCdE1QWGt6SjZiOVlPUmdwSDYwdXVVd2hoQUwxS2lDTWpP?=
 =?utf-8?B?WmxueUg0dDR3WUZhSkZPOFBZSkxkOE9hd2JQRUE1QStCRlNCSXFQQXZTOXFT?=
 =?utf-8?B?aUZ6cGFZYVFZK01wNG5DUXcxZHNaWFJZNlhqQWlqWUFQMktLWmJUUDZmUVpn?=
 =?utf-8?B?RnI2dlVVZ2xTd09peWtvTzdieGoxV2VKMUtZdDROU1JyLzA0UzBGK1ZXMXhj?=
 =?utf-8?B?V3I1SGFmK08zM3YwdVdiWFd4RlhUT2RyWWlXOC9YSEJ3enlqa2o3NGo4ZHg3?=
 =?utf-8?B?dit6Z1MvWmtmYTJidkF2eVZkeWg2c1NrdXM2eDE5UUNReEFyU0ZmaUx0aFNp?=
 =?utf-8?B?Rnh0cHNucmFrcWx2U0kxOUp3bDl0UDVDRVlsb1RRSFhpWjJNVXExUnNpR1d0?=
 =?utf-8?B?T1RxcFQ3dDdZVWJCMGtaVjhucUJ1QTdwMEgyVjVLWHQ0VVFmNzRmTW42Ykk5?=
 =?utf-8?B?dDQ2VmluYjJ4aWdIaUFVSENkYldVd1QzOGhxM1pvajZnTHF2WjFORmJQUGNY?=
 =?utf-8?B?b2tuc3ppNU1mb3FVeldha0p0TEEyeHFlVnlyVUJmaG1WZlVmRk5MQ3NtREpN?=
 =?utf-8?B?V2pYWWIwTkN3ZEsxZ0owWnN0RVM3WHY1dFJKSkJDVWF2S1dxNjdJeVlZa2lH?=
 =?utf-8?B?MTRtcThRNno3bmd4NkVMamwyU0ZFOXY5d2ZlQmlMMElTY2hGSzdmUG9oZkM4?=
 =?utf-8?B?THd5TkhKZ0ZrWW9ZaERnRUxZRUJWeGhyQ0NaclNZVE9Sd25odUR4b2UzT2Nu?=
 =?utf-8?B?bllOV2FWZTkySVVZdGVDSnRpcFMvdzhTNkxDZ1hHQmw1ZHJrWGVYMXdkejVZ?=
 =?utf-8?B?SFZveXZPZkdBYTZIVFFqTFdsZnhpRG9nVUFBUzVnejhrakNyVFlJY0V1Zy9B?=
 =?utf-8?B?RDNjT3JhbVBRUnhlL0tyTmluZWxVUFBzdXB5dHo5N0IyaDA0aTA0T1BGM00v?=
 =?utf-8?B?dERCNW9Gd0wxWHVDb2ZIVnBOVFkzQzVnaGk1enF6aHBSM0pOOVNqYm5ZV05R?=
 =?utf-8?B?NFNtNkZ4Q2lrVkJIZllWZTJaZ2NTQTI3VC91VDNTMGFQTXI5K2toZXpjcnhE?=
 =?utf-8?B?MnkyRkhaRjl0OGFvNjd1NTVQSE9USUZBRVdmcWZUSTBBL2xoQ1dIRy9BcG9L?=
 =?utf-8?Q?OxIN2hPvGCQ7x+L9ddPsSL07l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bbc12b-6f28-40de-1ebf-08db5c2a1d31
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 07:40:15.6088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7MJcZDYq4J14ARf71c6IAlzS6vkUGTMI76buHa6tsE6h9E0/ByUeMiws/CO8uqHsX1JIKfpoOWp9DEb9VVQXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/23 20:30, Pierre-Louis Bossart wrote:
>
> On 5/23/23 02:36, Mukunda,Vijendar wrote:
>> On 22/05/23 23:42, Pierre-Louis Bossart wrote:
>>> On 5/22/23 08:31, Vijendar Mukunda wrote:
>>>> Initialize workqueue for SoundWire DMA interrupts handling.
>>>> Whenever audio data equal to the SoundWire FIFO watermark level
>>>> are produced/consumed, interrupt is generated.
>>>> Acknowledge the interrupt and schedule the workqueue.
>>> It would help to explain why a work queue is needed is the first place,
>>> as opposed to handling periods in the interrupt thread.
>> For SoundWire DAI link, we are setting nonatomic flag to true.
>> If we return period elapsed from hard irq handler instead of workqueue,
>> soft lock up is observed during stream closure.
>>
>> We can use interrupt thread as well. To have a symmetry with
>> SoundWire manager work queues, we have used workqueue for
>> DMA interrupts.
> Oh, I completely missed the model here.
>
> If you are using the bottom half/hard irq handler to read status
> information, the natural thing to do would be to have an irq thread, no?
>
> Not sure I see the benefit of aligning with the manager work queues -
> unless it makes your life simpler to avoid race conditions with
> cancel_work_sync()?
We can implement request_threaded_irq() and move the handling of
DMA interrupts to thread function whereas we need to handle SoundWire
manager interrupts in top half only. Reason as follows.

As per our design, we are not masking the interrupts in top half and
restoring mask after thread execution like Intel and
our IP supports line based interrupts. If we move SoundWire manager
interrupt handling to thread function, we have observed interrupts are
reported but not handled properly due to thread execution is in progress
sometimes.
we will add comments for this design constraint in the code if we have to
go with threaded_irq implementation.
>
>>>> +static void acp63_sdw_dma_workthread(struct work_struct *work)
>>>> +{
>>>> +	struct acp63_dev_data *adata = container_of(work, struct acp63_dev_data,
>>>> +						    acp_sdw_dma_work);
>>>> +	struct sdw_dma_dev_data *sdw_dma_data;
>>>> +	u32 stream_index;
>>>> +	u16 pdev_index;
>>>> +
>>>> +	pdev_index = adata->sdw_dma_dev_index;
>>>> +	sdw_dma_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>>>> +
>>>> +	for (stream_index = 0; stream_index < ACP63_SDW0_DMA_MAX_STREAMS; stream_index++) {
>>>> +		if (adata->sdw0_dma_intr_stat[stream_index]) {
>>>> +			if (sdw_dma_data->sdw0_dma_stream[stream_index])
>>>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw0_dma_stream[stream_index]);
>>>> +			adata->sdw0_dma_intr_stat[stream_index] = 0;
>>>> +		}
>>>> +	}
>>>> +	for (stream_index = 0; stream_index < ACP63_SDW1_DMA_MAX_STREAMS; stream_index++) {
>>>> +		if (adata->sdw1_dma_intr_stat[stream_index]) {
>>>> +			if (sdw_dma_data->sdw1_dma_stream[stream_index])
>>>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw1_dma_stream[stream_index]);
>>>> +			adata->sdw1_dma_intr_stat[stream_index] = 0;
>>>> +		}
>>>> +	}
>>> I am not clear on the benefits of the workqueue which only tests a flag
>>> that's set ...
>> In top half, we are checking all stream irq mask and setting
>> corresponding stream id index in interrupt status array when dma
>> irq is raised.
>>
>> Our intention is to handle snd_pcm_period_elapsed in process context.
>> if the flag is set, call the period elapsed for the substream based on stream
>> id in work queue.

