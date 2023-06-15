Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB8D731EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbjFORIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjFORIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:08:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E79123
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXKXcj1p2OXYObZrP8ZjYTlZGuraabojK1q+Lbh+ZpUtrYRRUWgyPdyXbKEK29PcppwoXNYfoqgKiI0snskDHDa6u+nyPHuOQIimhVwXXuAGojT5Zzdrizp2CP+Ul4tJT0aq/ZMD6mGy9MZu5GTCPaQQ5NLU/iWhdBQsJ4iJSOCeVIfBXVkon7bWL2yaSkk0lQUsVVuX2MISMhs5t9t8eCeNxjuxWCSiAsM1eAkSC7ZZTG1ufkjck2I9vI1TvunSjHJaSTgTRdyooKtPooLPo2Ep+vwef0XcKkwlLJbD3oSn8yHCl2UR/Q6MKVeHXI5+B/SdwJaLJ1uYKts1b9V7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkmQ6jhRz+1IWenpsOqooye3nRFWUVdCC0OG8fNWKAY=;
 b=m5jLCWd2knozykqwC/bfaW8SqCFqjoXBxLkkT8IRG5XX43HRzt7QVLM79mSTP0uSzR/e2sHGzr463EWXnie/YBV/nrwAQdU9+HfsllPVTUH6gK39FSyiCxWkbDHFMLUivml89igTvS2Q3pUncEOebyisvSQLl8xJlOAO9AefkRB854WuQxCQQavhYx2HQeQTKlSlSvX0OndhrbrMow1IPo/07Sjv7bI+wUVTZK29lQxH1vJFb76Q0CM8O6zInM0NbPUIgY6FH5mUWJFxL7BxGV2Nvptarry9flm/JKs536k5vPsW37UOIw+Q/jeMtA9b5GfTFwfyknc1EltGaHvQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkmQ6jhRz+1IWenpsOqooye3nRFWUVdCC0OG8fNWKAY=;
 b=NQXp7hnVngBwAFBalKWnKqKQ2RI7RcPsY5zR6P8QK6Njt17Z3H6QP+FKCL8GyZ1QJ2RDyGjXGqN2B48qRGi7YyuN6C2dRKyL2Bk1jcQew9hhHvMastqPcGVM0+tcZVeDcRwaVu7qE3UXR+B/wBdNRfZ9Mry2tWp6Vnj5HjF9Kyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CH0PR12MB5332.namprd12.prod.outlook.com (2603:10b6:610:d7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 17:08:43 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 17:08:43 +0000
Message-ID: <be428e32-f0c2-bddd-5003-987f5bab0cad@amd.com>
Date:   Thu, 15 Jun 2023 22:43:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 4/9] ASoC: amd: ps: add SoundWire dma driver dma ops
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
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
 <20230612095903.2113464-5-Vijendar.Mukunda@amd.com>
 <0dbd1c24-0006-7956-9b82-780c7f005927@linux.intel.com>
 <36242cca-b20f-03dc-2d3b-62a797291af7@amd.com>
 <45ede657-f715-e38a-fdc6-130cdf74b604@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <45ede657-f715-e38a-fdc6-130cdf74b604@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::10) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CH0PR12MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c5e17e-3de2-46af-6dee-08db6dc32c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XAeH+aYOUVBbb722IT1f5gDRJtYkWlM0ZBjge0O1HagdZcN8OgiJkd8+BkJx7nVYMoE4bmH0Skq9q38b2gEK71+J2u+46FDBzRGWGZypo/T1pzQZ4nD59YQzk8b8TBq7iAO+TYZhvOqosQ5AIeZjUcQKuPWblBxJIktXzMTLz8dgsrE5qJ5CLuKlrFHwQkfjshHfkCXBUJZOck6U+A5kIrTr5fMHJHWOaLCKx+Qv/RyR+A0jhAXFk/Wl/j5iosFbYjMPPe0LIL00uw3GcqqwfcummUzRIxkUZSzFRE2OrecCwN1Kkolvq9FpnvlMPSjbkRx/DmiC3EMY+ElT4aAHattwOgDGIEKJ46u1MtmzLbR0vztzVRxrPkLlAIlZFZsrMlsaYl5/p943Q8NXXvwr4bbs9z4CGeRUYG9RgD5jU6cYKxii2W/5GNHUyhSkm6l8jDt/HJPfiLzbLeF0PBTC23/v1etBsTqDCpxCc7nTYml8XmouPMQgl4j9dYKac2Bmr8faUvJayXRG6PeOrqrud4tqZ+W63YO8Rig9KTx4xxpIR4vJHAQT4qyMNw5YTDwJvBBfTmdQeJoqnk2fGy1k6GH0Y3cCgcyRK4HnFV1ZN1ImKB7ZSbCWYpxDhs3SKQYGIbuw+FwfmYYYCnDp1BhULiIuXHFLC7tWKv9aiGaSbyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(2906002)(26005)(6512007)(186003)(83380400001)(2616005)(66476007)(66556008)(66946007)(31686004)(4326008)(41300700001)(8936002)(8676002)(6486002)(316002)(6666004)(54906003)(31696002)(86362001)(36756003)(38100700002)(478600001)(53546011)(6506007)(966005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHR1YjBod2VSdTdHOVlGYVlxY0hKNUJHMHprdHFOcGJTM3lUVkNYTXZaT3lR?=
 =?utf-8?B?QjQ3OW50UWJZaEdxQyt1TFZLaHFhVW9iRGJ3c0JoSmdqbFdwQjZqUWl2OEps?=
 =?utf-8?B?Sm53K1RHZjQ4TExLMEJOVnhXTTFsV0laTHRiN2thMXE2SWJQN3prNW1YaW1h?=
 =?utf-8?B?enFLQ2hEVSthb1Nxcnpad20vNE1OUmRoVmxQV3BpVVgyYWdsdDNRVlNMTlcz?=
 =?utf-8?B?Zy9jMEdEWEZpdVhlOFBPZHYvU2gvUERzQWtEbElxbWxSSVFlVDhFMEFORkFP?=
 =?utf-8?B?Q2JtTlRMd0hkMUZMOTR6b1NVM0FWdEVvWllQc3FMM0xld05tbGN5d0xodWRa?=
 =?utf-8?B?MFo4UXh1dEZwR25sOWV2Y1FCZ2ZTUG4xT3psR3BXNFZjWnN4UmZkYWdibmhY?=
 =?utf-8?B?QVZka0xXSEJNUVFSTUsyZG5iZEdTcGV6dkVGVS9OUUxrdi9DZXV6NGw4RXVo?=
 =?utf-8?B?OEhQZXo1MUNDVXVMdnc5Y3lOVElzajROM3AvdjdLUy9janJPUVdpMGlGVEFs?=
 =?utf-8?B?dTJZMXJ1d0FTRGtDNHZwd0ZFbmFmVjJwV2pxVmxqYkk0Ry9zVFpYNnl5SlZC?=
 =?utf-8?B?VUdxNUtyekIwYmduTkhGcWVGcHlmWEdQbms1T1djd1R1TFhrcklSK2VzRzJr?=
 =?utf-8?B?SklRYmQwZTlnYUtPVGlIcHdvdEtuSFZ6b0hzRzY0UGdDVGlDSXpmdUxSbnlV?=
 =?utf-8?B?RWlqZnFTeVB3eFVSVEtsSlh0cWM4TkNVVGxON1k0MnNEeEZEc295VzhOZXNJ?=
 =?utf-8?B?QkIzYjZyeTVoM1VEL3NqOTAvb2Z3dDNZT2J6RDNsWkZIZnZjR3hxWGJ6YkRE?=
 =?utf-8?B?Q05qY3VRaWdnZ0FGUTZzM3BOUFVOQnhFRTlvY3Z0SWJzUHg3VTBlVFV4azR2?=
 =?utf-8?B?aHI3dTlLeHRUYjQrUStqYVhRREtyVnhVWXRON2ZReEdjRHhJWVIzVmlkUEpp?=
 =?utf-8?B?eGJpSUVnemIxdmt0aVQxRzJRVXVZc3F1YThrR2JsMjZuaHp1YWk2Ri81NW9W?=
 =?utf-8?B?dldFMkJZN2FZcmFteXFJdU1QL0djb1Q0SkdCOTRVUUtMbmlLaWgrOEovK0Vs?=
 =?utf-8?B?S0pyOEU4YkNqWW83cDBOMENEZTNtNUlGdWlXaGk3c2JoWkRQOVB3UEtqL0hh?=
 =?utf-8?B?dnNCMjJFWFY5WDlISmp0MlhJcTBFdDFYb2FEUW9jd3VNSU1Qd2dBS3hRTUEy?=
 =?utf-8?B?ZDlJbmFQRWE1blk5cmNSdlBMOEpnaGNYM1VPSGlqUjNsQ3ZuNjZneEFRUmpk?=
 =?utf-8?B?RUJHcmEyQ1ZOUDhYRUtUOXNVdURONWRMdVhVeGV0VkZhMkVBTkY2aWI0ZjNp?=
 =?utf-8?B?SVhoNW5tL0RKT3RhREd1elAyQk56ZW9rVC9QSXBTNHduMkVvWUZYNXZFNjBj?=
 =?utf-8?B?QkpTTFNLMVd1cVpqVC9ZV0pPbHhEOXJzeWRJMWF3UzZPWVNSL1JMTXJlODVU?=
 =?utf-8?B?ajdwRFVLb0IwcWtab0Jndy85Rk1BVkZQQlkzZlZhcFVlMDFSemxya25sNnV4?=
 =?utf-8?B?V1FwK05tS2ZpeDlZVHh4dDBSSjg5V3pqeHM0NGJUVVNPSlRpWDAxZ1JYaHpy?=
 =?utf-8?B?b2dYV1ozem01QnB0a2lVOTVSZUhnc1FXdTdBdHlaRDh0cllvVmZtWFV6UWN2?=
 =?utf-8?B?bEZwc1puaGhrS2daS1pRSXNuWWNWZlBGdDlXVVA0cEJLTVFpTWtKaTFVd2o0?=
 =?utf-8?B?UHJnYmtwVndYSWV3RzEwMXZUZ1dtREVON2lFOFNHTXhLVzVIZC9kOWlvN2M0?=
 =?utf-8?B?V3NhOVpWT0hydFRwQjcrZVVDV2NJdURYMXM4NCtORG9PM2tpMWN5WkkwU3U2?=
 =?utf-8?B?RGpBZ1o1Wm1CY3RQeDJwTnVrMkRpcTZ5UEEzUk1jTkM3NlJMaUV1TllkYy8z?=
 =?utf-8?B?MkZUMmVCREJyNWNOc2tOc0VUQUl5bzAyVVp5b2JUYUc5THRYdjVGam1sKy9x?=
 =?utf-8?B?MXk4ZC85cFZSbXBKdnlZZ0JzTHYwcDVPWk1OVXdNNTBrYTM4VHJmYmlCQVVU?=
 =?utf-8?B?b0FIMzZ6MW45RzBTSHBYY1Vpemt6TUFYQ1pGbUlheWhQWG5hczA2QVpKNDhQ?=
 =?utf-8?B?S3hIT2h2U1k5ZVpoR21qaGxOS2NjeC9uajhhUFZYd1RCL3pSQktuRkYrUDJp?=
 =?utf-8?Q?PqwKZ9+RM38+wtpcvAJbRbIW3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c5e17e-3de2-46af-6dee-08db6dc32c41
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 17:08:43.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMHoR4K/6oQ9V8VO9DjASkze7/siUK/HCDnsiymyAWwx8pX5nEAbNmqXSUrRYHlVdcRelM8e/joox21FJB4puA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5332
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/23 21:51, Pierre-Louis Bossart wrote:
>
> On 6/13/23 09:00, Mukunda,Vijendar wrote:
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
> That reply was
>
> "
> Currently, SDW0 instance uses 3 TX, 3 RX  ports whereas SDW1 instance
> uses 1 TX, 1 RX ports.
>
> For SDW1 instance, It uses AUDIO1 register set as per our register spec.
> We have mantained similar mapping convention here for enums as well.
> "
>
> It wouldn't hurt to add a comment in the code to remind the reviewer
> that this is intentional and aligned with the hardware documentation.
>
>
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
> This is surprising, I thought this was already ensured by the hw_info stuff?
As per our understanding, we are populating period size range,
to ensure always, buffer size should be multiples of period size use the
constraint. Reject the buffer size if it's not multiples of period size.

snd_pcm_hw structure will only list out period_bytes_min, period_bytes_max
and buffer_size. It doesn't do any check.

Similar implementation has been observed in most of the DMA drivers open
callback () including Intel.

Failed to understand your point.
Could you please elaborate, if we miss anything?

 
>
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
> ok

