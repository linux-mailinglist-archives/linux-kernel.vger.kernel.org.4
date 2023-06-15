Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44D1731D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjFOQI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFOQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:08:25 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3D995
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wctf3cR/FQGkSpogFDU1tLlCMDAwxjAoKZ2ZkRHwcFLTsPCuTaBfqcPluL12n3eG/qmfY6IV2mmAY1b39fnIVDIAmOLtjSsEFoO+DwEulL3qD4/Jd9zeloaKbArHlwahzvuT0gOh2tfxj1sbvV7L6gvVdWAPvwKhnsoCDS8sE1J2zQaqsZJZHd81bvWjowrfuKXweMRXi5wOe6LFlWHBJyT6pfLRUeiGuzD6I6uTutqtXB5K0GL9M1t8VKsu9zmtlzDVqS+GBSGCmNuySqDk+NMdw2fFKsXAfxceBZwpxkf71sUjJJk62oMU5mTBg+Cs4GQHKM0emSAE67IB4KI8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9Rh7O7v4oNLlmR3XfknCBHym+RFvAXnclOk9P2i1aw=;
 b=eqAN0R+UQoeVs5dtg8hwF1vzCBIk/0I8dOk4KdgCcLtFFtDaVobQSVxM4rLmUdoJF2IDv97Uv84X4ONMw1BOHOk/a3B7GpN/mwusNsut28E+DhSMHcwZHeBXcIcPurNjWZmMAtreVhKYrBS1deHnh8mUVEgxmhuhKwhC5m29Jaw6F9qEjwdfVlDATyIuzt6Ch4SqmcZBh5uyFHGarK9Kfcejfrzlq320WCGtHzXDK5FWoIptV+SugoC/roiWWdAy9ZR5OJ60yWpK+Jy4V9TT8CuU1pG71kAQgtL9IvdDnNK4j87A5UYY2gNYBcsGIarOBiBHf6kdiEQnbB7nAnVLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9Rh7O7v4oNLlmR3XfknCBHym+RFvAXnclOk9P2i1aw=;
 b=dexYLsfYlX5HFV5LMdSE5XnTKSbU83TXetxA60xv6XWUsV2PmZAheIoYP6IG5TnVJWnHhP8N3Rwrwrxm9noT4i+F2uJOtopYAcuFJ4udUzywaRfnOrTfh4oUMCangQkM4Q5sd3yp8LvGeFPme4dJxFIM4HkkKZOtv+CQXHkPZ3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by BL3PR12MB9051.namprd12.prod.outlook.com (2603:10b6:208:3ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Thu, 15 Jun
 2023 16:08:21 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 16:08:21 +0000
Message-ID: <82904ff2-fee9-15d8-f353-3054e3ff710b@amd.com>
Date:   Thu, 15 Jun 2023 21:42:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 4/9] ASoC: amd: ps: add SoundWire dma driver dma ops
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
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
 <20230612095903.2113464-5-Vijendar.Mukunda@amd.com>
 <0dbd1c24-0006-7956-9b82-780c7f005927@linux.intel.com>
 <36242cca-b20f-03dc-2d3b-62a797291af7@amd.com>
 <2c4fb68a-70f7-6d75-951b-ee7fd209fa8b@amd.com>
In-Reply-To: <2c4fb68a-70f7-6d75-951b-ee7fd209fa8b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::11) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|BL3PR12MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 46634cfb-e993-49b8-b080-08db6dbabd4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftynzBNAYTZ6Jt1mPEh+cTIXGvuHSG3SrgWN15IuytAIbGY6VJVT0/TQy/mPOu6oWX3ppjcIm/xzy53Pf35ShC5b7ah8zRK+wZAnMdS+/vMdIrF48cAybSAm6+9tw8iELV08LYWd413B5mSxdiJdyq+l3500TJ2Fx8ah6pPrWaBHWE1AlIBoOmrgD9QIlFLmyNgwfKdZklblUt7tqx3vn6uURumWfB/6/5/XwEFnKMEUcMWD7DhtnaEpp7RHzJJmeGAhTT6K7Eyb95MT5DewNGoCbnlmKB/x2qifyDmErWQLqA3bguM8mOB9QgFKCg3aqMNWgyD+zO/7Tq5s+uUtSLtZvNn+RrV9xfBLJgcJXOTTYkheLDgY1AESPpRaUv/RYtgyaRSgMBc8tTyRf7+nX2elfulaVvTKUmmGgduOVWXp/EP62kyPPXCS+a0JSQqh32tW7+fJ0ysgNcdWdQqUXyvT9rI3SbMPtyw39SAe3GWTAfsdT8pmogC8Jokve6Lb8b/ilZRSjuymEkdR2/rQV4nnpjSAvcRzZI8wW17TNlj3jJmYUD8fKROdY6uBvnxTKd+bTEP82VmYjcPh71MrgaHVbyBHQdrnYFcr+6EXIlCwQ86a7fGkpcPINVhqY8AAkPd8Bvsf75aV39CP9naAa6t18GQ156+V75cjPepW1ko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(31686004)(86362001)(31696002)(38100700002)(5660300002)(316002)(8936002)(8676002)(41300700001)(66556008)(4326008)(66476007)(66946007)(83380400001)(54906003)(2616005)(186003)(36756003)(478600001)(6512007)(53546011)(26005)(6506007)(2906002)(6486002)(966005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2I5Y1NvcUtjanMyYW4vVWN3WlpiVEZWVW5ONVBkSmJWaDVPMzVRNmsrdEJB?=
 =?utf-8?B?eVBmam9VMXRJRDZVVS9FZHFhRWdYSWxtUVk3STZLK1BqNmREUGVwT0NLYW11?=
 =?utf-8?B?R21GM09vcVN4NmcvRjgxbEdJSFpNUFBzTkxpT3F3SW1UY2NNSDZ2NkFONEFX?=
 =?utf-8?B?bmcxZ0duVW5HQVltNEJoNjVJRWUxV05NRjhSMmV0N3N0bkFOa3BDV2gvMDRR?=
 =?utf-8?B?UTQzZ3pFZW9XYVhlUnYrODF5K0VBWW42QnFCNS9qL3NJS2YyWlVLSDNsR1hx?=
 =?utf-8?B?Ny9tYkhTRE9za2VYdjRSVmNHa2RTSnc1Mml2MnoraDd2RUhqdU5XQWQxdng4?=
 =?utf-8?B?a3dQc3J2UFdIWlk0YW1NR2JyT01EUUNrNlNjQ0JFUS94dXhvU1VjdlU5YjB2?=
 =?utf-8?B?dVdxak5oQ1loMXZOYjlPTSt6a01BaEtVZzVXTGNHZXRIOHhhYjVqZFV0QWV3?=
 =?utf-8?B?b2YwT2RkaVU1OFNDSDdSQ3ZyQ1U2VWZ6TExod0todmhBb051TEg2NjVkTC9z?=
 =?utf-8?B?b1pGUHQxb2lHUTQ0RzlidXdnb3duVHFybHVxV0F4YThPWG5kMEF0aVRoQTRK?=
 =?utf-8?B?UGNkTnNQdHppQjdseTY2UHp5WDhqcTlDSVB5Yk5vSTFhcmFrZ1JMV3NXeE41?=
 =?utf-8?B?eHBvVjNneDhCSmIreW9xbmo3V0FValk2WnF0SEViYURUUnZSZEl5TEZMdldM?=
 =?utf-8?B?Q1Q4REt1MElKOEdZbzYrWWJRdUpuZWw1UkhNVURTVWY3enNxcGRob2FzNmtS?=
 =?utf-8?B?MlNLbGlJN0t5ekRDdnhDUXVoaXQrT2VialV5aE5FMFhJdWtjb3RHVTJxSHlx?=
 =?utf-8?B?a1RNVVlybFZmQnJuQlZHdjNLbzhCREJXOFlZTHROQ1JjNlJtVlNGYXFrcDFM?=
 =?utf-8?B?cFZTUjlMZzgySXFBNC9yeFlOemduOHd3aWU1OXRXeXQyaGUwcStBaGF0T2Fk?=
 =?utf-8?B?d1JqSXRPSmZFRE9HSUo2RHNaWXNxTlM5OWVjVVl0UmxURDZTQ2JTQkF5dXV4?=
 =?utf-8?B?d2RjV0RHUTRrTWlUYXBxRVR3ZnRka1dTV1FnbHZPNHhSWGtxZ3YzbG05emsx?=
 =?utf-8?B?SkhFcFdaYWFZRGYyamRzVHNPRDB5NUc5OWdPS0Zkc3VyME55ZThGd1phWkpq?=
 =?utf-8?B?NnFuV1VQcWNuWFRpd1ZnZTZPelFwdk80R3o3ODZjU3F1eHV2QUpxY1BtazZk?=
 =?utf-8?B?WmRXVVNlem93VzFwUGpEN0xyci9uVFlCcERrdk9INEFmRDhTaGQ4YlVyY01l?=
 =?utf-8?B?OHVYa1ljaExwQ2dMbzN2dldVSjRLaXB0YkR4YnVIWFIvZmZRUlpBYi9Naytm?=
 =?utf-8?B?VEczNkRndVhGYmllSkNCWllNRk9aYVQ0Y3ZqM3ZkQ2liL3ZwVTVFcWRYTlZt?=
 =?utf-8?B?eEllSEQ3T3g2SFV2dE5teEhVbDNSY0g2L2tIaTVvd0x1MzZObDc3bHFPR2la?=
 =?utf-8?B?NUlvUElkd1V6WE1aODVYTGJPYXcxdjIrMEhGem1od21WUkNKSHBJU2ZzcElk?=
 =?utf-8?B?TTdZby9meEJwa2RNZ0lLcGk4WGw4SmN4L2x6aldqalZZcXdITmt0L2YzMWpC?=
 =?utf-8?B?S3h0TnBDaHdpVnMxMjlVSnVyRE03NXRxUUg5WWVrcGF2NDJsOEdQTUw1QlI3?=
 =?utf-8?B?K0ZJd0ZsWXhoejRxUEI0UVE1V21sUDVFOTlpMHhHZkNKbHhlK2cxcUJwWGpC?=
 =?utf-8?B?Y0ZqeXR6UUJaTk9ZNkFKUmM0Z0ZiLzZ4N2NyUXlsYzVpdHVMQ3lqMWt6a204?=
 =?utf-8?B?bE9CdHBnL1dOelcraTZBRDVYT3ZoWW9rbXNnRUNGN01kZW5DQlJ0L0J5TDhx?=
 =?utf-8?B?YVNaR3h5WkR0WFgvbFRaQlNFYXhhZTNxNklvUGFibDljenlTZWlLbStFUy9Q?=
 =?utf-8?B?L2N3NU1EMEFhWEYxRjlFeE5OOEVVcVJ1YVN2ditiUkk0VnZRVVkyNi9zQmQ3?=
 =?utf-8?B?Z1d0U1hKM3JFaUZIY2J2eE9mcHZacU1Xd2l5MVFyaXU4UnVUVmtJeGxKdkZ1?=
 =?utf-8?B?OFhsN3pPRUJ4VFA2N1hNSVJoc1ZmcHpZaFYvSEtmWENqejZMTGhsZmpRbmhZ?=
 =?utf-8?B?SG5FMFhVZ0tyMDhjQjA0T3ZXUzNSbkh6UC9lbThhQjkwTUFxak9nYyt0b1Av?=
 =?utf-8?Q?1aJRysbTfA40yU4Bp17v7ybwM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46634cfb-e993-49b8-b080-08db6dbabd4c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:08:21.3724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5S9tNLWxR5k2hzLVu/H2+WrJMhYOw+bbRbIGD2ss/RYlTiwrRnFiqcDAi1QgTpADDJdmz4x0/AbSQ4NPDrTfFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/23 21:20, Mukunda,Vijendar wrote:
> On 13/06/23 12:30, Mukunda,Vijendar wrote:
>> On 12/06/23 23:36, Pierre-Louis Bossart wrote:
>>>> +#define SDW_PLAYBACK_MIN_NUM_PERIODS    2
>>>> +#define SDW_PLAYBACK_MAX_NUM_PERIODS    8
>>>> +#define SDW_PLAYBACK_MAX_PERIOD_SIZE    8192
>>> that's a fairly small max period. That's 21ms for 2ch S32_LE 48kHz.
>>>
>>> Does this come from specific limitations or is this an arbitrary number?
>>>
>>> A comment on this wouldn't hurt.
>> This is the initial version. We haven't exercised different sample
>> rates/bit depth combinations much. Currently, targeted for 2Ch, 48Khz,
>> 16bit audio streams only with 64k as buffer size.
>>
>> We will extend support for different sample rates/bit depths combinations
>> in the future.
>>>> +static u32 sdw0_dma_enable_reg[ACP63_SDW0_DMA_MAX_STREAMS] = {
>>>> +	ACP_SW0_AUDIO0_TX_EN,
>>>> +	ACP_SW0_AUDIO1_TX_EN,
>>>> +	ACP_SW0_AUDIO2_TX_EN,
>>>> +	ACP_SW0_AUDIO0_RX_EN,
>>>> +	ACP_SW0_AUDIO1_RX_EN,
>>>> +	ACP_SW0_AUDIO2_RX_EN,
>>>> +};
>>>> +
>>>> +static u32 sdw1_dma_enable_reg[ACP63_SDW1_DMA_MAX_STREAMS] = {
>>>> +	ACP_SW1_AUDIO1_TX_EN,
>>>> +	ACP_SW1_AUDIO1_RX_EN,
>>>> +};
>>> Still no explanation as to why SDW0 indices start at zero and SDW1
>>> indices start at one?
>> We have already provided reply in previous thread, i.e. for v3 patch set.
>>
>> https://lore.kernel.org/alsa-devel/de3c86cc-6cba-0cbd-0e04-43711b4c9bc2@amd.com/
>>
>>
>>
>>
>>>> +
>>>> +static const struct snd_pcm_hardware acp63_sdw_hardware_playback = {
>>>> +	.info = SNDRV_PCM_INFO_INTERLEAVED |
>>>> +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>>>> +		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
>>>> +		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
>>>> +	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
>>>> +		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
>>>> +	.channels_min = 2,
>>>> +	.channels_max = 2,
>>>> +	.rates = SNDRV_PCM_RATE_48000,
>>>> +	.rate_min = 48000,
>>>> +	.rate_max = 48000,
>>>> +	.buffer_bytes_max = SDW_PLAYBACK_MAX_NUM_PERIODS * SDW_PLAYBACK_MAX_PERIOD_SIZE,
>>>> +	.period_bytes_min = SDW_PLAYBACK_MIN_PERIOD_SIZE,
>>>> +	.period_bytes_max = SDW_PLAYBACK_MAX_PERIOD_SIZE,
>>>> +	.periods_min = SDW_PLAYBACK_MIN_NUM_PERIODS,
>>>> +	.periods_max = SDW_PLAYBACK_MAX_NUM_PERIODS,
>>>> +};
>>>> +
>>>> +static const struct snd_pcm_hardware acp63_sdw_hardware_capture = {
>>>> +	.info = SNDRV_PCM_INFO_INTERLEAVED |
>>>> +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>>>> +		SNDRV_PCM_INFO_MMAP |
>>>> +		SNDRV_PCM_INFO_MMAP_VALID |
>>>> +		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
>>>> +	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
>>>> +		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
>>>> +	.channels_min = 2,
>>>> +	.channels_max = 2,
>>>> +	.rates = SNDRV_PCM_RATE_48000,
>>>> +	.rate_min = 48000,
>>>> +	.rate_max = 48000,
>>>> +	.buffer_bytes_max = SDW_CAPTURE_MAX_NUM_PERIODS * SDW_CAPTURE_MAX_PERIOD_SIZE,
>>>> +	.period_bytes_min = SDW_CAPTURE_MIN_PERIOD_SIZE,
>>>> +	.period_bytes_max = SDW_CAPTURE_MAX_PERIOD_SIZE,
>>>> +	.periods_min = SDW_CAPTURE_MIN_NUM_PERIODS,
>>>> +	.periods_max = SDW_CAPTURE_MAX_NUM_PERIODS,
>>>> +};
>>>> +static int acp63_sdw_dma_open(struct snd_soc_component *component,
>>>> +			      struct snd_pcm_substream *substream)
>>>> +{
>>>> +	struct snd_pcm_runtime *runtime;
>>>> +	struct acp_sdw_dma_stream *stream;
>>>> +	struct snd_soc_dai *cpu_dai;
>>>> +	struct amd_sdw_manager *amd_manager;
>>>> +	struct snd_soc_pcm_runtime *prtd = substream->private_data;
>>>> +	int ret;
>>>> +
>>>> +	runtime = substream->runtime;
>>>> +	cpu_dai = asoc_rtd_to_cpu(prtd, 0);
>>>> +	amd_manager = snd_soc_dai_get_drvdata(cpu_dai);
>>>> +	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
>>>> +	if (!stream)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>>> +		runtime->hw = acp63_sdw_hardware_playback;
>>>> +	else
>>>> +		runtime->hw = acp63_sdw_hardware_capture;
>>>> +	ret = snd_pcm_hw_constraint_integer(runtime,
>>>> +					    SNDRV_PCM_HW_PARAM_PERIODS);
>>>> +	if (ret < 0) {
>>>> +		dev_err(component->dev, "set integer constraint failed\n");
>>>> +		kfree(stream);
>>>> +		return ret;
>>>> +	}
>>> it's not clear to me why you have to add this specific constraint, isn't
>>> this checked already with the sdw_hardware_playback information.
>> In above code, first we are assigning runtime->hw structures.
>> As per our understanding, we are not assigning any hw_constraints.
>>
>> This snd_pcm_hw_constraint_integer(runtime,
>> SNDRV_PCM_HW_PARAM_PERIODS) constraint assures that the number
>> of periods is integer, hence the buffer size is aligned with the period size.
>>
>>>> +static u64 acp63_sdw_get_byte_count(struct acp_sdw_dma_stream *stream, void __iomem *acp_base)
>>>> +{
>>>> +	union acp_sdw_dma_count byte_count;
>>>> +	u32 pos_low_reg, pos_high_reg;
>>>> +
>>>> +	byte_count.bytescount = 0;
>>>> +	switch (stream->instance) {
>>>> +	case ACP_SDW0:
>>>> +		pos_low_reg = sdw0_dma_ring_buf_reg[stream->stream_id].pos_low_reg;
>>>> +		pos_high_reg = sdw0_dma_ring_buf_reg[stream->stream_id].pos_high_reg;
>>>> +		break;
>>>> +	case ACP_SDW1:
>>>> +		pos_low_reg = sdw1_dma_ring_buf_reg[stream->stream_id].pos_low_reg;
>>>> +		pos_high_reg = sdw1_dma_ring_buf_reg[stream->stream_id].pos_high_reg;
>>>> +		break;
>>>> +	default:
>>>> +		return -EINVAL;
>>> returning -EINVAL as a u64 doesn't seem quite right to me?
>> Agreed. Default case needs to be corrected. In case of invalid
>> SDW instance, it should return default byte count which is zero
>> instead of returning -EINVAL.
>>
>> We have identified similar fix has to be implemented in our other
>> dma driver as well.
>> https://elixir.bootlin.com/linux/v6.4-rc6/source/sound/soc/amd/acp/amd.h#L174
>>
>> Will push a supplement patch to fix it at one go.
    @Bossart: Let us know if you have any further comments for our replies.
>>> .
>>>> +	}
>>>> +	if (pos_low_reg) {
>>>> +		byte_count.bcount.high = readl(acp_base + pos_high_reg);
>>>> +		byte_count.bcount.low = readl(acp_base + pos_low_reg);
>>>> +	}
>>>> +	return byte_count.bytescount;
>>>> +}

