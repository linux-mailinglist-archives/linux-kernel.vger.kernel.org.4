Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3498E72DA41
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbjFMG4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240241AbjFMG4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:56:18 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838C610F9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTIn7Mh5tBBcf15RUGkbhV25D5pSddfCHIMbaAeN3sc9QxmA/vm1hlOCMHpLY1VwuQxtFvtTMsEm/0EDvJ6ptlNby5hFb4zem7vUKK6i0qAI3meiP5N3iuKdmv1f9dwBIF0nTIPJolelp3PNptb4T/BkeEmvJxc9gSa9GS2GxLgHISAXv8CNCW8cSxfMyuIY7kZ78A832Zgf9liqHk9YL3Yamd4uWKp3u9Rf6gL74Ji8s/MUhCTPJvstmixGknFZHY/PIj+o/nRT6iG4MzUnOec8jvVZXkXe53S524ugGGadDxzAzPMhRTzxj5uM3wwReBaUeziLpP92TaxixtjjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QglIKxU0q2yh5/hnGLoEwIAdBr78LQGd+LG/Y/cAgOA=;
 b=UmmmZYg86eqt3i6qPbIigq4VMjQLknIbXETUlkf3EPVKMgRXL9wg9yuqqFGyv0W3WO/XpsHwx9hByGLlOQMoMmYXk6T+piXhDspctO/skjQSbcN27X/NYz74oOgzU513wnF9s4a2UoX9eTNpMiPE9JsHiapZ3kin7C0skqYpp6ZLSwqFS4vU+SYw3PCJIU4QdkYRzGK5eTmEb4kFNnnd7X5wOgeNtAiH3KMReUFKrUkfsKkOz0BYJV+uBUIRGEEJ6iSgAVhKYE9dOBt/qJFu/b9pN4/UDVmDlGgEFsv7xMGlhTVyxfhtO6bScEGKKeUb334CsqFU9Tqb+OL28u3l9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QglIKxU0q2yh5/hnGLoEwIAdBr78LQGd+LG/Y/cAgOA=;
 b=OGPYr+4sV++0rpq1teERF0DKrJbt+LWqSQ3TlF0mVOwEdVgtTBfauEBynB3ixMzt6H/Cv8teoq39uJvURE0wMUdDGLIfzPcet9irdLQgEpOenyuQMGk9SRN1q2j+f4aCdy8sKZ0oOe0DXciyJB5I9JtPOKNo0MiCZyDpncfGnSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 06:56:13 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 06:56:13 +0000
Message-ID: <36242cca-b20f-03dc-2d3b-62a797291af7@amd.com>
Date:   Tue, 13 Jun 2023 12:30:49 +0530
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
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <0dbd1c24-0006-7956-9b82-780c7f005927@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::23) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM6PR12MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: 220a5dcf-ab94-406b-f2a8-08db6bdb4661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/TWo+fWQozkilqsvjfTkFvcyx/zzZ6hANpZvlxZHcF8qTzxaDBzM5gTn90+eF6zhh7c/JQ9aqcax/ytd3tJ6Y3r+fYvpD0HDZ1M8ZW1ATh3WV5MeE9CqAHkDZxLcAER53h3kUWfNe9ULD+Cb/gnemdyPjFVMgn9EpA4Pmi8rkGmfPFPSkOSVATuBXmlyAuwhwIRPn+cn+iuXLzVOo77ts4eLgGfQwRAeUrijsFFRvABmkEKsZ0uqdMBjtn7zGkp97V0bIgjwxjkYyctk7GwPQZxOS+eET1KjAQupbeyRmnVh7LmJcxyf9aw723opfP27Joyskn2UHS9ZFJD4VT2Ib3wleSmnKZfkq9KUMSqV8VXplwZMHXUAVedNROlIKTSG+AmizY2L3NpSGrYrGZy1MHn3rVJYTrHJwQSZx1qzzv5GltZ+VRz1Bmd/eMMF0qmtTbuHQY6R8UnCZ7RzSUr2nYICYnE4iobweoEls8dvYIoM1sE5NfnYCGfP3Hy9Aoy6SVp0dfO+6OoLkMU+Ak7RlwbQAWmhU/MGzbrsx1uBnIKmBK1yBUKZnVOVRHdglo+F72Qqr0q10dusDa8BMAkD3H3LKDaugr/qejH5CfWNl3HBd+GzqMsghkfrtJymW27O+zG194Yipq5ajTqkKNkhbzU9UVrPErqAK5MJWMMZB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(5660300002)(8676002)(8936002)(2906002)(66946007)(31686004)(66476007)(66556008)(54906003)(6666004)(966005)(6486002)(4326008)(6506007)(26005)(6512007)(53546011)(41300700001)(316002)(186003)(83380400001)(2616005)(478600001)(86362001)(38100700002)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzZzWFJHRXJpemVQTzladlhRSVVOUWNhRWZQaytMcmdjc3RkaHA0cUh4T0FI?=
 =?utf-8?B?VElCZU1VRVFzNVpYbjVlbHJMWnlQblJtc0llcVpnc3R6R3Nhekd5eDhUcXIv?=
 =?utf-8?B?ejR6cENtTGw0YklmQmxzaGVjamxnQ3BJbFl0NURhREc3TzRZOUt5ODB0Yjkz?=
 =?utf-8?B?NHpyTjhSYUVER2pWMFF5RlRUUkRYZnZrK2FORFFybVYvdHZab1NaRUhNQVZw?=
 =?utf-8?B?Q0lzbEYzc3NrbVFNUFhEVWUwNDVEZmRIUlI1bS9vb1NrdlBrMHFzWGRXR2dH?=
 =?utf-8?B?MHY2elRIMnhZVlNYcURXRGs5ZXlQS1NRdnJibGprdkR5OXRrS25jV2xVeWtC?=
 =?utf-8?B?eTVWN25YMUF0YTI4MGw4b3VFbnpWZDduSHlSajVXT2t4Q1FIOCtZaDFDaStn?=
 =?utf-8?B?NmNEeFpWamhvTXplVnZpV3lRNC9FLzhYSnBhL2xYNnd0Qzh4U3pVZDBBVmVw?=
 =?utf-8?B?L0tFUGJjUEF2UWtYZGp3aGR5Vkk1WGlZTXlBVTNsTVZyTDltOTNBZXR1SGwx?=
 =?utf-8?B?R21nYndVNGhIbmluVXozZFhVdTlSbkRBOUwwSlljdzIrd3RxcVhPeitabnBj?=
 =?utf-8?B?TDAxMFBBK3VDendJUDlueFpFT0lYVkR1WXJ2U1FOQjFON3p4UmI2d0dRN2c0?=
 =?utf-8?B?a2JwRjRldlFXV2QxY2lmc0t3SzUrTEFBMU04ZTIvVkl6cldDKzg3RHhrNk1M?=
 =?utf-8?B?dHhVeVMyWlpHZit4U2t0aUoxcGlsSmVQVytNekZZdGJTdDBhVzVLTWduOGYr?=
 =?utf-8?B?Z0xSSHp5QjBLMi9NYzFkM1FoejVkeU1qMTFLKzY1bURYOG5yQktTWFoyOG03?=
 =?utf-8?B?Z01sbTZ5SGVUaHg0VDNFSmRrM051L1R6ckxkQXRjTFhlVWYvRUJLZlh3eVlJ?=
 =?utf-8?B?OGxaK0pBWEJucFZjK3FrVzR2TDI4eGMwZG9uMGxLYXVMN2RhMG8yQ1VYWGV2?=
 =?utf-8?B?ampqa1JOUlF6VzliNXVVKzdPTlh2Z0FBcU54RmJsTjVSU1UxOHdiUXErYlBC?=
 =?utf-8?B?dndMVXhBYlBwS3FSWGtaaDFBalIrY1dpZ1NyTzVrWEkzOE1rM1VEYnRFaHky?=
 =?utf-8?B?bi85VWNYemJQejBqdi9rV1paWW05aWJUaDRWVmd2U3l5ZFBEYjRObHlQNndO?=
 =?utf-8?B?UmpaOEtCSFBjYWR5TkFzZ0N1WEU3Q0lReGRxeEdnbWllV1NiaFRldG9ibDNh?=
 =?utf-8?B?WWp2VkJWbkVZRi9zRytNNkhkNkk1cEY5Uk1URU1MSTkrL1NqYTk3R3RFUUhL?=
 =?utf-8?B?ejF6YjlmTlAvVGxEN1VrUGxCY1I0QUNCUTNnMGlDSi9qNi9oWGhJWFF2c0JP?=
 =?utf-8?B?ZmpCaUF1MGRFS2hVMHFTME1pQmNsekY3UEpyRCtnT3FKaEpCNGVpV3hQNzc5?=
 =?utf-8?B?Yy9XTk0wc3RBUkhoTjc4OGU1SnVrbkRxQXorakdqYWFDd0RrL3VadVRKZGFp?=
 =?utf-8?B?cERGNDZzMHRtaFVWOGMycGZiT01YNUNIZDFGVWdxb0hpK0lNMitYaDlSNUpC?=
 =?utf-8?B?Z25LMWUxU0hzSXhIeGNyME1rbDFPbVRUK2txM0dFS1hHd3Jha1BwbDh5c1hn?=
 =?utf-8?B?SFNmWkZ5aU5HdkkvTDJweHlUVVMvR3FWSU9Bd1NGZGhiVTRPeHdSVkJEWFpk?=
 =?utf-8?B?ZGErcFhvMnE3WTlpMzEvUENuV2F4cC91ZHJOMTJQOFlLSUU0NnlXQjBia0Uz?=
 =?utf-8?B?NVZvM0duTmVVTzlTT0lvOUJnaW9ka1BrWTduMCszZEp5dVpJN0h1K3FJU1J2?=
 =?utf-8?B?ejlsa1VuWGp0Y3M1OHdDOThLdVFlY09UazB4eEV2ZHUvOFJ0ZnlscUloUnRF?=
 =?utf-8?B?V2sxeXpQbWszVzBnSnJFeGpxNVBIUjROd1poWkQ4YXB1ZDZzdjVvQllncFV3?=
 =?utf-8?B?Z0RIenk5VGxiLy9kZ1Y4a0phK2ZBWjFjSkxPSzc2bVQzbklLQTlOSzZ0VG1B?=
 =?utf-8?B?NEkvQTBqaXk0bmpwc243T0xlSTVMMWdya3Q3M3VEMTJsS3cvS2ZUQy9IblN5?=
 =?utf-8?B?Snk2TU9Ycjc2V0NnNDVSaS9XLzZaUHp5ZThTNityRWN5WURiMmJ3M3JZSXZS?=
 =?utf-8?B?ZEdiVjd3WDkzRlFMRE1DaDd0VGI5ZGM2S3RpSnZRbzBwb1AvUUVBeXVtaCtz?=
 =?utf-8?Q?59dPmqZ046M7wjv6EmotIjMcW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220a5dcf-ab94-406b-f2a8-08db6bdb4661
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 06:56:12.9307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: by5AmM3fdHNB6nigru6RFGmsGXtULw6bxjpYwM8qKP1P6C8JgkOfBHmY/5OOVtDk44vjILpae9kExMI7wQCuNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910
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

On 12/06/23 23:36, Pierre-Louis Bossart wrote:
>> +#define SDW_PLAYBACK_MIN_NUM_PERIODS    2
>> +#define SDW_PLAYBACK_MAX_NUM_PERIODS    8
>> +#define SDW_PLAYBACK_MAX_PERIOD_SIZE    8192
> that's a fairly small max period. That's 21ms for 2ch S32_LE 48kHz.
>
> Does this come from specific limitations or is this an arbitrary number?
>
> A comment on this wouldn't hurt.
This is the initial version. We haven't exercised different sample
rates/bit depth combinations much. Currently, targeted for 2Ch, 48Khz,
16bit audio streams only with 64k as buffer size.

We will extend support for different sample rates/bit depths combinations
in the future.
>> +static u32 sdw0_dma_enable_reg[ACP63_SDW0_DMA_MAX_STREAMS] = {
>> +	ACP_SW0_AUDIO0_TX_EN,
>> +	ACP_SW0_AUDIO1_TX_EN,
>> +	ACP_SW0_AUDIO2_TX_EN,
>> +	ACP_SW0_AUDIO0_RX_EN,
>> +	ACP_SW0_AUDIO1_RX_EN,
>> +	ACP_SW0_AUDIO2_RX_EN,
>> +};
>> +
>> +static u32 sdw1_dma_enable_reg[ACP63_SDW1_DMA_MAX_STREAMS] = {
>> +	ACP_SW1_AUDIO1_TX_EN,
>> +	ACP_SW1_AUDIO1_RX_EN,
>> +};
> Still no explanation as to why SDW0 indices start at zero and SDW1
> indices start at one?
We have already provided reply in previous thread, i.e. for v3 patch set.

https://lore.kernel.org/alsa-devel/de3c86cc-6cba-0cbd-0e04-43711b4c9bc2@amd.com/




>
>> +
>> +static const struct snd_pcm_hardware acp63_sdw_hardware_playback = {
>> +	.info = SNDRV_PCM_INFO_INTERLEAVED |
>> +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>> +		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
>> +		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
>> +	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
>> +		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
>> +	.channels_min = 2,
>> +	.channels_max = 2,
>> +	.rates = SNDRV_PCM_RATE_48000,
>> +	.rate_min = 48000,
>> +	.rate_max = 48000,
>> +	.buffer_bytes_max = SDW_PLAYBACK_MAX_NUM_PERIODS * SDW_PLAYBACK_MAX_PERIOD_SIZE,
>> +	.period_bytes_min = SDW_PLAYBACK_MIN_PERIOD_SIZE,
>> +	.period_bytes_max = SDW_PLAYBACK_MAX_PERIOD_SIZE,
>> +	.periods_min = SDW_PLAYBACK_MIN_NUM_PERIODS,
>> +	.periods_max = SDW_PLAYBACK_MAX_NUM_PERIODS,
>> +};
>> +
>> +static const struct snd_pcm_hardware acp63_sdw_hardware_capture = {
>> +	.info = SNDRV_PCM_INFO_INTERLEAVED |
>> +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>> +		SNDRV_PCM_INFO_MMAP |
>> +		SNDRV_PCM_INFO_MMAP_VALID |
>> +		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
>> +	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
>> +		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
>> +	.channels_min = 2,
>> +	.channels_max = 2,
>> +	.rates = SNDRV_PCM_RATE_48000,
>> +	.rate_min = 48000,
>> +	.rate_max = 48000,
>> +	.buffer_bytes_max = SDW_CAPTURE_MAX_NUM_PERIODS * SDW_CAPTURE_MAX_PERIOD_SIZE,
>> +	.period_bytes_min = SDW_CAPTURE_MIN_PERIOD_SIZE,
>> +	.period_bytes_max = SDW_CAPTURE_MAX_PERIOD_SIZE,
>> +	.periods_min = SDW_CAPTURE_MIN_NUM_PERIODS,
>> +	.periods_max = SDW_CAPTURE_MAX_NUM_PERIODS,
>> +};
>> +static int acp63_sdw_dma_open(struct snd_soc_component *component,
>> +			      struct snd_pcm_substream *substream)
>> +{
>> +	struct snd_pcm_runtime *runtime;
>> +	struct acp_sdw_dma_stream *stream;
>> +	struct snd_soc_dai *cpu_dai;
>> +	struct amd_sdw_manager *amd_manager;
>> +	struct snd_soc_pcm_runtime *prtd = substream->private_data;
>> +	int ret;
>> +
>> +	runtime = substream->runtime;
>> +	cpu_dai = asoc_rtd_to_cpu(prtd, 0);
>> +	amd_manager = snd_soc_dai_get_drvdata(cpu_dai);
>> +	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
>> +	if (!stream)
>> +		return -ENOMEM;
>> +
>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +		runtime->hw = acp63_sdw_hardware_playback;
>> +	else
>> +		runtime->hw = acp63_sdw_hardware_capture;
>> +	ret = snd_pcm_hw_constraint_integer(runtime,
>> +					    SNDRV_PCM_HW_PARAM_PERIODS);
>> +	if (ret < 0) {
>> +		dev_err(component->dev, "set integer constraint failed\n");
>> +		kfree(stream);
>> +		return ret;
>> +	}
> it's not clear to me why you have to add this specific constraint, isn't
> this checked already with the sdw_hardware_playback information.
In above code, first we are assigning runtime->hw structures.
As per our understanding, we are not assigning any hw_constraints.

This snd_pcm_hw_constraint_integer(runtime,
SNDRV_PCM_HW_PARAM_PERIODS) constraint assures that the number
of periods is integer, hence the buffer size is aligned with the period size.

>
>> +static u64 acp63_sdw_get_byte_count(struct acp_sdw_dma_stream *stream, void __iomem *acp_base)
>> +{
>> +	union acp_sdw_dma_count byte_count;
>> +	u32 pos_low_reg, pos_high_reg;
>> +
>> +	byte_count.bytescount = 0;
>> +	switch (stream->instance) {
>> +	case ACP_SDW0:
>> +		pos_low_reg = sdw0_dma_ring_buf_reg[stream->stream_id].pos_low_reg;
>> +		pos_high_reg = sdw0_dma_ring_buf_reg[stream->stream_id].pos_high_reg;
>> +		break;
>> +	case ACP_SDW1:
>> +		pos_low_reg = sdw1_dma_ring_buf_reg[stream->stream_id].pos_low_reg;
>> +		pos_high_reg = sdw1_dma_ring_buf_reg[stream->stream_id].pos_high_reg;
>> +		break;
>> +	default:
>> +		return -EINVAL;
> returning -EINVAL as a u64 doesn't seem quite right to me?
Agreed. Default case needs to be corrected. In case of invalid
SDW instance, it should return default byte count which is zero
instead of returning -EINVAL.

We have identified similar fix has to be implemented in our other
dma driver as well.
https://elixir.bootlin.com/linux/v6.4-rc6/source/sound/soc/amd/acp/amd.h#L174

Will push a supplement patch to fix it at one go.
>
>> +	}
>> +	if (pos_low_reg) {
>> +		byte_count.bcount.high = readl(acp_base + pos_high_reg);
>> +		byte_count.bcount.low = readl(acp_base + pos_low_reg);
>> +	}
>> +	return byte_count.bytescount;
>> +}

