Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68E772246E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjFELTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFELTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:19:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156EFCD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAwPkIRQ8rWoCsegIpe9wu18RDtTVuPuK4LrrXxiA9vXe9rE3+FAgqBUwOZtqFD6kVVLX3XT3WTKvhUoQHeLqNvS2JtawEZW9xU4OUTFucmhUAsnA5iJseP14yEeMpIfwn4qFUKdTWYajGdBSS95KkmeMKAdq94nlzyWOUCN5KLMPR4V3CV12igHxqNh0dt8y12y/qoO08e/Nrac28OFLx6jmgypAFG8pCgWbHleV6ghlyASw/9u5ljEyd7MZwO3HJH/81uReRfCm33s0SuOmU9t7t59lyv68fo+UqSD4qZKgF0KWRNiR8ARlU/Bsy9IYN7+ezoxu0YgMdil2Rqc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BI3gldnpQVaQW7t2KvnCw0oy9m5xP+nGga8I/aPCR+U=;
 b=K05KW6JstmT0TK5mFY44uAuqSUB3bxpGExjx6yOlWy9+jwYB9xNs0IJj2p3vW+tVApg2bW6jZ9UEXLxvsm5UWs5+s5X1InhPb2VZ4akQjMS0rxMlkHYkC8R/Kzy42I/4wDDCgWKkcgucwnESSE8uJJcoMvg/lxIEcmHiUUt3T64d4FzZaMRNYjNyqrva+pwKPXSR8ZSV05vZ1tAvJ5rOBZSk9uJqZ+6uVOTYkoa2Ft/F3VjN5uS7ERePt+qAS0b5GLSuwtGdszXZwiq4/BXiQz7WoIfRCFPgoMilJ20MaS6pY2IwjEo3kpU9DgVlWTtNDOcO89CiM2QbzOL6jqWMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BI3gldnpQVaQW7t2KvnCw0oy9m5xP+nGga8I/aPCR+U=;
 b=d5ois6Cy6GQa2K5cOnCskk1REBqVO/ucJ5noPygzvfyDY0z17YGymcx5dRBdgez180cHMnVdaTYOz8aAXeBWa1dK7+Y46MFIDleCretW44MYDLMfGyvkqVa/yI+4BXRG3yLYJCj8eo4NCIBvdLpnqDl1uDxPCdTmhDrZia0x/LE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 11:19:35 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 11:19:35 +0000
Message-ID: <9f20e168-dea6-8837-a009-5429aac28466@amd.com>
Date:   Mon, 5 Jun 2023 16:54:17 +0530
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
 <017abf89-a1aa-0c85-e244-a56c05b7c6e2@amd.com>
 <af5b0669-2621-7fce-358c-76dca7b521c5@amd.com>
 <5048a207-4ec4-e954-0fe8-88ed25320c1b@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <5048a207-4ec4-e954-0fe8-88ed25320c1b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0239.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::18) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|MW4PR12MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 920c0c26-e445-4b96-71b2-08db65b6bdd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2D3lVV9H3xTxDh3W+mACWcAvlSjQ9qzjfknMXlQ2Cbram36uNU3U+/1pIwbS+MkS4D8HCE2un2iI+HU3ZtrM6M6AfaSgwq9xc1XlOfIlTNFmqQyqLNVbGAterZKQKJcNv5SDltUuldYjpbvy/gN7tE/JWI4ATYue/9buzkqnkWOKhD4AUjMCbNHOTfRQm51ZpGHoErmdCc0o8w5yL1SFUYGPzUYpboKc8j70MyT5lX2N5NVCLWvJDIMr6fCWTZUe8o/x7jUa30b4A+NSRnIQuArBjOTXt/4MqorX0TTW/f96L+cJAQQui0o/OhnKks8OEJtj/ZyWkISO7zD50rbm6Fk875gbrOIrLT6Eva/Xc/bmVzXwGZYK9a2Jxs76U+Pt4hz+nfcSQqGkwQtX3iTHnQIQ50pWsSwEEML+x4wuYCkvby5Vf1Mia2vDvLwlyb6crz/J2a5IX6dwJ6Ts7XgepE+0btfj0ywDPEs1FuDm2eA/i1iIxeHFzmKx7JehCpqcDgnqIhMmq1H5qL/y3k//A4y7nm1x8xq/QruYlbiG15AxomQNOvFrc04NEYYPVlZ5gDPAXsIw/1g/DLHjaF68fB4Fdd3+GcxRdiTLkdpkdbvPI5GouHFJbMA3n4NZKPSYn1m+sqBw07XH8U3oNmxyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(54906003)(478600001)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(6666004)(6486002)(53546011)(6512007)(26005)(6506007)(31696002)(86362001)(5660300002)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3BYMGcvTVo2Nm41U1E2c2RVL1B0TjRBWEM1MGxIT2hLRGlHRVpObWlzQ1l6?=
 =?utf-8?B?ZDMwL0ZQZkVKV21OS28vNThPOU5wVXFjemFYTHZnQVQ4bEFtUis0NHpDbFZm?=
 =?utf-8?B?N3pqbFpFeE1tNEppWVdmbUJMNFJMMVBTS2hXNzVXTEFVU3piSkpaYitUcXVS?=
 =?utf-8?B?b3Z6RjlhaEJLOEdKY0VRd1ZVUldVYld2S1BPL3I0Y0w3dEtNNjE0aDVGanA1?=
 =?utf-8?B?bXFYem44a1NrTm5vYUJJTm1BV0x3c3NpemZDLzlMdGZXN093Ymkyamwvcmt0?=
 =?utf-8?B?eFlYSXZiZlhHbEppRzNHQ3lRbm1mNmtlSU50U3VQQkpaWHF6MjdiNUxTbkpY?=
 =?utf-8?B?ZUxabzJOTmlPVS8rK1JkTlBsSjBpMWpFM2J1NTJKTWJob3ZXdlFSUFNmNTFu?=
 =?utf-8?B?YXQ4a2QvVkVYK2FWRU1WZ3piMnJINGQzc2xmVFJtdUl5RkxzMkExTlRMSEVW?=
 =?utf-8?B?Z1FFOTkwU2NydGlNSWZZV3BYcGRHeGYyM1pncUZuSGs2QVBuKzQ5UWRnVFdJ?=
 =?utf-8?B?aHhiVnJCbEtTUDNhRDZtdG5PUk9zbTNXZURnK2JOeU5veEFlTVJUTTFnSUht?=
 =?utf-8?B?c3NsRVFMa0ZDY1NNWTJoaVZ3WGpwMDZMWXp3VCtIcDFEMlJpdCs2NGlUZGdk?=
 =?utf-8?B?cm1SbmVrR0ZCTlhnTk5OV1lwSFByd0Q4VVk3SG9uVWRyc1BRNWVwUzN6TVFk?=
 =?utf-8?B?OWswUE1YQXowOE1JbE5CYWhiMGdpR3pxcGEwWUlnRS84T1dRb2pTT3VHSlNm?=
 =?utf-8?B?R2dLR2NIU09rOVY2bmovdk5KelJzR21RSnZKNVFPWnVmajZpRTQ1ZzQwUXkx?=
 =?utf-8?B?SkpYNUMySFQxWXkzTVBTR2ZhNCt4cmU4T2tjZnM3d3J5SkRjRlBKOFdaM3NM?=
 =?utf-8?B?aDJmRjJXTGNrME5BQm5XVWI4NGhuaGMxS0ZFaTdtRy9iL3haSzZrdktJMVJM?=
 =?utf-8?B?QlVkdURyRXU3U28va0hOVGF3VnR6VWhVSFdqRlpqWDdqNXMxcmdRNVd5VkIw?=
 =?utf-8?B?b0piWHN1cFFvVFZ2U1F5bEZBMVV1VnVCM3dObkk5WTlxNVZCQkdsYzFCamhD?=
 =?utf-8?B?ZzREMThIRWhJbmtGZmNKVHVRa2pYWG1FZGxDcURnWEd0SXRPcDNPaUkvOEdh?=
 =?utf-8?B?NEh2dmVPaHBEOEtiUVVqK0hlcXY2RGM5RDNtWWJQcFdzMjVVSDhHQVByTkta?=
 =?utf-8?B?SC9sOWdqQzM1ODB0ZENKdE1Ta29oajhZQk83bjh4SjJ4bDd5dXZabDZpb2pH?=
 =?utf-8?B?Q3QyRVN2SG1PSXBqL2tNdWlhUjFrZ0xBeUUwT1l5UnhOUlQ0SUYxdzJZS3RS?=
 =?utf-8?B?VzczTzh2QWFhMk1MV3NxTHRjTDE3WW93aEcyWUxsUUtKLzczV2hkdjRHbEVP?=
 =?utf-8?B?ekYwM3dHMlFaQkZ6YXc4TWliS3R3L3Y3ZEN3WHowai9mQ2VFNjdmLzE1WVN6?=
 =?utf-8?B?b1ltbGNpeXpRZmllTDhOVUpxTXRBM3BYT3diTUJmc0pTMDhjdm4yNU9Lc0hR?=
 =?utf-8?B?VkZLVGRqdFhUTUZCMWgxSURGWWFkdjU5TDlrV0JRbS9BSDlXdytjdzdXWGJT?=
 =?utf-8?B?cVVjOGJXeDJqRUsvODlYMjkvZEJkSi9GdzhJUWZaK2JxYklsRjI1L0xCQzNa?=
 =?utf-8?B?Q0lrc2hrRzJLMVVMWFBJbFBUR1dXdk5kKzFOZVRMMjdMa1NDTVpoVjl1S0Mx?=
 =?utf-8?B?VXVoc0xJMHVkNkk5U0xGOUFyWVF2bDI3NUNYRUNuWDNCMnJmM2RFbVc1N1hY?=
 =?utf-8?B?R05lZnFPK0x1TllXem5McEt6S25Cd1U4YU9FdHJxOUlBN2dOS3piWWl0aGgv?=
 =?utf-8?B?T0Y5L28xRUNYVEtLMGZ4VFhxT1ZiWkxCemZYV0Rnd05MRGxJTW04b1JudDVj?=
 =?utf-8?B?cTR3eDdpd3EwMVZRYUlDNElzdUFxNHBoTlZ1T0lYZ21WN1dyODhSV09SZUsr?=
 =?utf-8?B?OFdycDg1K2pHdWpabUVSR1pERmFSeUp2cU1ucVluOUNWU2JlS3pWa1BPZE56?=
 =?utf-8?B?eXB5WkFmSk84V0ovczVQT29kRlJzQ2E3aXVLbEEwU04wR2NyT3J1REJJTmNZ?=
 =?utf-8?B?Z2xReTJaS1BHZTk0eUx4elM2SUdkTHpZM1NCeVUyRWFickNxak1Nc3diY2Zn?=
 =?utf-8?Q?NGuYDO/p+SY4NE8eg06/kGM+d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920c0c26-e445-4b96-71b2-08db65b6bdd8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 11:19:35.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2t6rpGRm3XXPyn3sw9DaObeB8xPTxtBsYO1rs8NuZk9BWhLU/f8E3k94CpzrAwCNcd31IXDocRGOJF0h0I8GzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/23 19:23, Pierre-Louis Bossart wrote:
>
> On 5/31/23 02:28, Mukunda,Vijendar wrote:
>> On 24/05/23 13:15, Mukunda,Vijendar wrote:
>>> On 23/05/23 20:30, Pierre-Louis Bossart wrote:
>>>> On 5/23/23 02:36, Mukunda,Vijendar wrote:
>>>>> On 22/05/23 23:42, Pierre-Louis Bossart wrote:
>>>>>> On 5/22/23 08:31, Vijendar Mukunda wrote:
>>>>>>> Initialize workqueue for SoundWire DMA interrupts handling.
>>>>>>> Whenever audio data equal to the SoundWire FIFO watermark level
>>>>>>> are produced/consumed, interrupt is generated.
>>>>>>> Acknowledge the interrupt and schedule the workqueue.
>>>>>> It would help to explain why a work queue is needed is the first place,
>>>>>> as opposed to handling periods in the interrupt thread.
>>>>> For SoundWire DAI link, we are setting nonatomic flag to true.
>>>>> If we return period elapsed from hard irq handler instead of workqueue,
>>>>> soft lock up is observed during stream closure.
>>>>>
>>>>> We can use interrupt thread as well. To have a symmetry with
>>>>> SoundWire manager work queues, we have used workqueue for
>>>>> DMA interrupts.
>>>> Oh, I completely missed the model here.
>>>>
>>>> If you are using the bottom half/hard irq handler to read status
>>>> information, the natural thing to do would be to have an irq thread, no?
>>>>
>>>> Not sure I see the benefit of aligning with the manager work queues -
>>>> unless it makes your life simpler to avoid race conditions with
>>>> cancel_work_sync()?
>>> We can implement request_threaded_irq() and move the handling of
>>> DMA interrupts to thread function whereas we need to handle SoundWire
>>> manager interrupts in top half only. Reason as follows.
>>>
>>> As per our design, we are not masking the interrupts in top half and
>>> restoring mask after thread execution like Intel and
>>> our IP supports line based interrupts. If we move SoundWire manager
>>> interrupt handling to thread function, we have observed interrupts are
>>> reported but not handled properly due to thread execution is in progress
>>> sometimes.
>>> we will add comments for this design constraint in the code if we have to
>>> go with threaded_irq implementation.
>>>
>>> @Bossart: we are waiting for your reply.
> I am not sure I get the point about using workqueues v. threads for the
> manager, which in turn makes it difficult to understand why the DMA
> interrupt handling should be aligned with that of the manager interrupt
> handling.
>
> Using the combination of hard irq handler + workqueue feels odd. I may
> very well 'work' but others should chime in since I am far from the most
> knowledgeable reviewer in this area.
Understood your point. We will use irq thread instead of workqueue
for SoundWire DMA interrupts handling.
We will push V3 version.
>
>>>>>>> +static void acp63_sdw_dma_workthread(struct work_struct *work)
>>>>>>> +{
>>>>>>> +	struct acp63_dev_data *adata = container_of(work, struct acp63_dev_data,
>>>>>>> +						    acp_sdw_dma_work);
>>>>>>> +	struct sdw_dma_dev_data *sdw_dma_data;
>>>>>>> +	u32 stream_index;
>>>>>>> +	u16 pdev_index;
>>>>>>> +
>>>>>>> +	pdev_index = adata->sdw_dma_dev_index;
>>>>>>> +	sdw_dma_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>>>>>>> +
>>>>>>> +	for (stream_index = 0; stream_index < ACP63_SDW0_DMA_MAX_STREAMS; stream_index++) {
>>>>>>> +		if (adata->sdw0_dma_intr_stat[stream_index]) {
>>>>>>> +			if (sdw_dma_data->sdw0_dma_stream[stream_index])
>>>>>>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw0_dma_stream[stream_index]);
>>>>>>> +			adata->sdw0_dma_intr_stat[stream_index] = 0;
>>>>>>> +		}
>>>>>>> +	}
>>>>>>> +	for (stream_index = 0; stream_index < ACP63_SDW1_DMA_MAX_STREAMS; stream_index++) {
>>>>>>> +		if (adata->sdw1_dma_intr_stat[stream_index]) {
>>>>>>> +			if (sdw_dma_data->sdw1_dma_stream[stream_index])
>>>>>>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw1_dma_stream[stream_index]);
>>>>>>> +			adata->sdw1_dma_intr_stat[stream_index] = 0;
>>>>>>> +		}
>>>>>>> +	}
>>>>>> I am not clear on the benefits of the workqueue which only tests a flag
>>>>>> that's set ...
>>>>> In top half, we are checking all stream irq mask and setting
>>>>> corresponding stream id index in interrupt status array when dma
>>>>> irq is raised.
>>>>>
>>>>> Our intention is to handle snd_pcm_period_elapsed in process context.
>>>>> if the flag is set, call the period elapsed for the substream based on stream
>>>>> id in work queue.

