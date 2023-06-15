Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182AF731CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbjFOPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239188AbjFOPpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:45:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEFE2728
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuZ65qcqO7yalwvAcTT2N5+bE/2i9KX9SP3BhDSLV1I7HRVvXedcAKUT2qkYeWim6egJrXyAC2gPhNTNyA/njGW4KBS/yaVigjBN+kAp3m1PdjaK94dORNjH1JFlqcY8LGS290PRvZ4TPjBnV9jWlzJeRrpdyjGt/Trc860vuh+JZXk3T929eBLMyO4ISSbiDoxPB4kkpCqgoEEwyd5RfOMlLVSj6wPeuLvaVlYXd+LgeQExXF4MeIqumSWUWUxgm6Qg38L+v1K5tjZPvYcvXwTeSSXE81ADNVCYjS4SIxN9nSsm6GIiVhlr/04vOhmaUHvOiRUx5xbqH3m3X23f7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKxwcxB4lY1N7m/2ok2OQj4EBv46REyDJYjqe7BUVGA=;
 b=bYliNEYXBNpLMes6WCnPY4yMZPxzqrVlptgG+RZ5lyYzbQoimsXHBAreyzVsGXCC8N6WyQZPBRW6Mw8wsih4kwfY+fhlOj8eobAyTSqJE3Tzj1Y/3SHhnz7XnxZRB6INBMwrTcikww2/jGQuFWiJQPWQbWuYJ1UFALgXT7RFSIZ4GZl7eLMp0McERZWd6uEmQcqWi0hUq0M1T5DTkqh7mX8C8oySE1q7EBcY2pXLRzBmf7o4LQxYQ/rV91A/Qrx+UAD2G4VBfcqeRKSo76koEP/0nUDGAZZRZFRAuFDVf3v7Dauw7prcBK9ANn4Rkcnz4fMi50sU/SEa9BfBCUKj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKxwcxB4lY1N7m/2ok2OQj4EBv46REyDJYjqe7BUVGA=;
 b=DZ/RTJK0b1MiiNx2chAEWPBSHkss6cHDuDMoSMbph7/b7zrO/S3w7zqGwZtl8MI9kX5F0EO9RXfeH85gL59rtvyU2oBWax39rmOcHFJdxCRdttaB3G5Iz7E7mktMI3zXGxLpk/G6qsIP7Gdsx3dyIz++xiJpgAccb0ZEYhiI0H0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CH0PR12MB5314.namprd12.prod.outlook.com (2603:10b6:610:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 15:45:35 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 15:45:35 +0000
Message-ID: <2c4fb68a-70f7-6d75-951b-ee7fd209fa8b@amd.com>
Date:   Thu, 15 Jun 2023 21:20:08 +0530
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
In-Reply-To: <36242cca-b20f-03dc-2d3b-62a797291af7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::23) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CH0PR12MB5314:EE_
X-MS-Office365-Filtering-Correlation-Id: 7677b483-b65a-417b-109b-08db6db78f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6zCkYCF8WVe6HcBNGj4Fnofbs2LykRMoIvM8kxWkCEZgvRpXSWCetFXKRI2yrs8WBA0g92LPBFwW1lr679cZGQaFXCJM9sVsN2lOQQtIUfoLS31ySxr+hW4HTjzG+b43i940p1cBxsi+MybBg9nvlhC1K18ahmNDaFqQ5y+GfhF3M8m/vAEs2dXxL6dv1+37P8tvMggodxhfewvdnXnyu27d5/DqfAUAvEBdOuH0C4scvsXWBaojuEBnUdGiw8i5KG+X6cDrLes4b8OEOLBFEgijh4/AaUPkjvdrWLOCmVtmahXMDJNJef3MCnLkas2/KJSg5e8vgUQU4NwzN+weagCFSCQZxaaDNOqJYOgf3qZciOTMKn3I/7+yJByHCho3yIwnQfCrx5BmZN3E+OQhxYcMkr1SXvvE7+2giF9QXI4KKRj9OGSwLekjdInOL69ZtmRK7KrsNF0f8d+kLPUgeeM3tNIpVf2IiSU/V06mvRF6alYvQFAS3n6Lpnjae44ubebsBjKgwgfLNDzt9MA5o8DzuDkSIPZFCTHbFqsyf4/Sd9hVGSK/o0Y4tAsJ3eKs7CGG8o0fd/ss3NsunauSPziyDpIV4WsH+7gcnM/dkafQYEcvKnrml3uI+FiR4EuP3xciEhUEZcYrqxPJ1dWsIxLIyxKtEBE73NBx1itbRtI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(4326008)(6666004)(66946007)(66556008)(316002)(66476007)(6486002)(36756003)(8676002)(5660300002)(31686004)(8936002)(41300700001)(478600001)(966005)(54906003)(31696002)(53546011)(86362001)(186003)(2906002)(38100700002)(83380400001)(6512007)(26005)(6506007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFRCTGI2Z2taaHFCL0tGZEFCRmlDYWJkL0RKRHU5YUM3V09IWnRsZkFidmU2?=
 =?utf-8?B?eXFkaDU2azRIeEluTjBXYy81d0w5cjBHUFd6RlZaR0xpUUtsZUpSYVNlSzlp?=
 =?utf-8?B?WTFPOWdpaS9wb0NSaG5OQXp1dHp4cnZHSVJlaWRUT2dWaDh0MzJRTUNTbXdY?=
 =?utf-8?B?dVI0c0RtUzRjU25pNWNRWFI2VkpueVRvVUo4QXVNN1RRdnhJaDRZZldIbzFT?=
 =?utf-8?B?d1lhQk5PYmNCZFJDY2JETEpuVEJISVVSc0RCYUdkN0x6SEN3RlNISmVlSnUv?=
 =?utf-8?B?dXNieFV1aW9BdjRCM0RSWS9Da0srU2huR21pT2NFQUhVKytQVjM4NXNZWGRG?=
 =?utf-8?B?SWRmSVNUc09zUXY3OFhkZi9GSXErQ0U3V3hhZ1F2cG8yMDJkMmxXSE15Y0VG?=
 =?utf-8?B?a0pYbkhlSDN4TDVsbENvWEp3b1N6SlBMa2NyOTUyOCtBbXJjTmw2NjlxQzBK?=
 =?utf-8?B?UjdtZmhCY3ZSMTgyMis5bkhUZjMrN1psenZkcFpNcUFFZWJ6NDRNTUhvaEE3?=
 =?utf-8?B?V0U5azI0eXYraHo2ZzF0VWxrL0tUUmhzSWIwK1F0eVFiSW04blRCcUp2TkVt?=
 =?utf-8?B?ZkJ4VHlBOGNVS2toajNVYVp1MmxvUERJYWlrdXpHVkE5Sng5alhKaGFtRjRk?=
 =?utf-8?B?UWIxWjJtUXlDaFltRi8zOXhEOVM3blZIWnVIMjhpVE5USXpUKzdhSlFDQy9K?=
 =?utf-8?B?SVhKVnNFbmR6ckl2YThubmlodG5uL0pDYmFoTUdqdVJ3dVNNRTUxbkZXMWZa?=
 =?utf-8?B?b0MwR3B2akovN2JSdjVaT0p2emhzVjZBQTEzQ3U5SXM2SFZwKzkwaXhhV3lF?=
 =?utf-8?B?ZkVkVURYOXQyNFlYN29Fcyttd2NZZ0QwalZGZUc5VkY1b3AvWitzWk9WN2N4?=
 =?utf-8?B?M0pXcC9xSHdzSTZiekdjQ0ZFMjU5ekJiODd5bEZDVXJYK0hGcjFhcFVuWXpN?=
 =?utf-8?B?NWNtTmEwU2NFUUFJTGtyUllJbFJrS1l1OElXQlVVb1NSK0UwUmp2dDRPQVM0?=
 =?utf-8?B?NmNaK1graUZaZW9yUXBJY2prajJVem9WZnFnMmtnR1F6cDEvU2hUdlcvUUcr?=
 =?utf-8?B?dTBJUWdSK2tHaWxQMDJ0NzJNUStXUklyVkxvUmR2N2NSQlNOWmtMYmNVSHJ4?=
 =?utf-8?B?czNrYlZwZytuNWc0djVTMkZxVnFiRVFuMkI4ZXg1K0thMHd5SGNjRmdCSll2?=
 =?utf-8?B?OE9oK0sycUowY2hxWkg1d2h3dS9STllVb1dnelVEY2w1SXNGaERiaXl5Qmd5?=
 =?utf-8?B?allKTjVtZEVyMWc2Mzg1cGhsNWxlRVlmOEhsSGxybUxnQ2VuY01RMUkvV1ZJ?=
 =?utf-8?B?cm9zWGZuZ3JqUEthRXl1VVJHNE91Qm9jZHlydUZGT3cycVlpYTZCeEg2NDEy?=
 =?utf-8?B?cGJoNGRuQWwxM2cxOVRtV1RQR3lGT0czWDAzVVFud0RXV25ianVkeGI5SUN6?=
 =?utf-8?B?WllOSjljanpTbHMyODhNdUk1WG82V0xOVnZMZGE4Ri9HVE16MmdmSGdmMCtD?=
 =?utf-8?B?ZTdGWW14WUt6RzR2aGVYU3pVOC9ZcmF4UnZsOUR6enUrUGVzWk1kRDJGMUJB?=
 =?utf-8?B?bW51TVF5K3FzRkNsZms1ZmVsUW1ZY1oxVDZrblZlL0tzUGpuTFZ3NEROUmRp?=
 =?utf-8?B?bTFZc2xWZFZ6S1dzNGhva245VXpCMnI0elpkcW9hVDY2YmFpZEpWdjNVV2w4?=
 =?utf-8?B?T3Y2cEp1a2FkcmxBbWFFbzRyUHlFZU5ZL05jY0dYNC9RdStWZkpGN3g0YzRw?=
 =?utf-8?B?YkpWSHdBT2JOUHpCTngveTZDSUl5YmJqa3NJWm1VL1JXNTZjeWxSVmpjcGtN?=
 =?utf-8?B?N01zcmdvb0NhZkxLK1IyWTRIL0FSc0dKZ0VuTlpTanNOTVBDTHhKWkVXSkdG?=
 =?utf-8?B?ZndFclROOE5qeE5KbHJrRXF6VFYzRndaR1hVaFB3N0VEL1VnUlBZYkdDSW00?=
 =?utf-8?B?bGtERmdJMlpmQ3hON0NWdDBQbk1sN0dudGwxeDNCaUxCKzc0N0JsNmg1VlVI?=
 =?utf-8?B?K3BqNDFyL0NITjE4Z05MMU9XT3RPZGJRVXhmWDAzeDdKb1hKUFcvSHJHY01o?=
 =?utf-8?B?cVhJQXdFYmljSjZJbU5TQVJRR2lORURVbjJHNnpCdm9LMUhHVXpkMXdZWkMy?=
 =?utf-8?Q?4VHLC8c4dL2NkDgr8Ic4pdnGB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7677b483-b65a-417b-109b-08db6db78f24
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 15:45:35.7686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjnarlGr2vM4OodJTRlSaCC6074nE6pMmjglmuHJ67Es6maC1mP0ADiehFkbE4YV+qP3XBmSXANuBqPDsiuV1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5314
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/23 12:30, Mukunda,Vijendar wrote:
> On 12/06/23 23:36, Pierre-Louis Bossart wrote:
>>> +#define SDW_PLAYBACK_MIN_NUM_PERIODS    2
>>> +#define SDW_PLAYBACK_MAX_NUM_PERIODS    8
>>> +#define SDW_PLAYBACK_MAX_PERIOD_SIZE    8192
>> that's a fairly small max period. That's 21ms for 2ch S32_LE 48kHz.
>>
>> Does this come from specific limitations or is this an arbitrary number?
>>
>> A comment on this wouldn't hurt.
> This is the initial version. We haven't exercised different sample
> rates/bit depth combinations much. Currently, targeted for 2Ch, 48Khz,
> 16bit audio streams only with 64k as buffer size.
>
> We will extend support for different sample rates/bit depths combinations
> in the future.
>>> +static u32 sdw0_dma_enable_reg[ACP63_SDW0_DMA_MAX_STREAMS] = {
>>> +	ACP_SW0_AUDIO0_TX_EN,
>>> +	ACP_SW0_AUDIO1_TX_EN,
>>> +	ACP_SW0_AUDIO2_TX_EN,
>>> +	ACP_SW0_AUDIO0_RX_EN,
>>> +	ACP_SW0_AUDIO1_RX_EN,
>>> +	ACP_SW0_AUDIO2_RX_EN,
>>> +};
>>> +
>>> +static u32 sdw1_dma_enable_reg[ACP63_SDW1_DMA_MAX_STREAMS] = {
>>> +	ACP_SW1_AUDIO1_TX_EN,
>>> +	ACP_SW1_AUDIO1_RX_EN,
>>> +};
>> Still no explanation as to why SDW0 indices start at zero and SDW1
>> indices start at one?
> We have already provided reply in previous thread, i.e. for v3 patch set.
>
> https://lore.kernel.org/alsa-devel/de3c86cc-6cba-0cbd-0e04-43711b4c9bc2@amd.com/
>
>
>
>
>>> +
>>> +static const struct snd_pcm_hardware acp63_sdw_hardware_playback = {
>>> +	.info = SNDRV_PCM_INFO_INTERLEAVED |
>>> +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>>> +		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
>>> +		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
>>> +	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
>>> +		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
>>> +	.channels_min = 2,
>>> +	.channels_max = 2,
>>> +	.rates = SNDRV_PCM_RATE_48000,
>>> +	.rate_min = 48000,
>>> +	.rate_max = 48000,
>>> +	.buffer_bytes_max = SDW_PLAYBACK_MAX_NUM_PERIODS * SDW_PLAYBACK_MAX_PERIOD_SIZE,
>>> +	.period_bytes_min = SDW_PLAYBACK_MIN_PERIOD_SIZE,
>>> +	.period_bytes_max = SDW_PLAYBACK_MAX_PERIOD_SIZE,
>>> +	.periods_min = SDW_PLAYBACK_MIN_NUM_PERIODS,
>>> +	.periods_max = SDW_PLAYBACK_MAX_NUM_PERIODS,
>>> +};
>>> +
>>> +static const struct snd_pcm_hardware acp63_sdw_hardware_capture = {
>>> +	.info = SNDRV_PCM_INFO_INTERLEAVED |
>>> +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>>> +		SNDRV_PCM_INFO_MMAP |
>>> +		SNDRV_PCM_INFO_MMAP_VALID |
>>> +		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
>>> +	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
>>> +		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
>>> +	.channels_min = 2,
>>> +	.channels_max = 2,
>>> +	.rates = SNDRV_PCM_RATE_48000,
>>> +	.rate_min = 48000,
>>> +	.rate_max = 48000,
>>> +	.buffer_bytes_max = SDW_CAPTURE_MAX_NUM_PERIODS * SDW_CAPTURE_MAX_PERIOD_SIZE,
>>> +	.period_bytes_min = SDW_CAPTURE_MIN_PERIOD_SIZE,
>>> +	.period_bytes_max = SDW_CAPTURE_MAX_PERIOD_SIZE,
>>> +	.periods_min = SDW_CAPTURE_MIN_NUM_PERIODS,
>>> +	.periods_max = SDW_CAPTURE_MAX_NUM_PERIODS,
>>> +};
>>> +static int acp63_sdw_dma_open(struct snd_soc_component *component,
>>> +			      struct snd_pcm_substream *substream)
>>> +{
>>> +	struct snd_pcm_runtime *runtime;
>>> +	struct acp_sdw_dma_stream *stream;
>>> +	struct snd_soc_dai *cpu_dai;
>>> +	struct amd_sdw_manager *amd_manager;
>>> +	struct snd_soc_pcm_runtime *prtd = substream->private_data;
>>> +	int ret;
>>> +
>>> +	runtime = substream->runtime;
>>> +	cpu_dai = asoc_rtd_to_cpu(prtd, 0);
>>> +	amd_manager = snd_soc_dai_get_drvdata(cpu_dai);
>>> +	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
>>> +	if (!stream)
>>> +		return -ENOMEM;
>>> +
>>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>> +		runtime->hw = acp63_sdw_hardware_playback;
>>> +	else
>>> +		runtime->hw = acp63_sdw_hardware_capture;
>>> +	ret = snd_pcm_hw_constraint_integer(runtime,
>>> +					    SNDRV_PCM_HW_PARAM_PERIODS);
>>> +	if (ret < 0) {
>>> +		dev_err(component->dev, "set integer constraint failed\n");
>>> +		kfree(stream);
>>> +		return ret;
>>> +	}
>> it's not clear to me why you have to add this specific constraint, isn't
>> this checked already with the sdw_hardware_playback information.
> In above code, first we are assigning runtime->hw structures.
> As per our understanding, we are not assigning any hw_constraints.
>
> This snd_pcm_hw_constraint_integer(runtime,
> SNDRV_PCM_HW_PARAM_PERIODS) constraint assures that the number
> of periods is integer, hence the buffer size is aligned with the period size.
>
>>> +static u64 acp63_sdw_get_byte_count(struct acp_sdw_dma_stream *stream, void __iomem *acp_base)
>>> +{
>>> +	union acp_sdw_dma_count byte_count;
>>> +	u32 pos_low_reg, pos_high_reg;
>>> +
>>> +	byte_count.bytescount = 0;
>>> +	switch (stream->instance) {
>>> +	case ACP_SDW0:
>>> +		pos_low_reg = sdw0_dma_ring_buf_reg[stream->stream_id].pos_low_reg;
>>> +		pos_high_reg = sdw0_dma_ring_buf_reg[stream->stream_id].pos_high_reg;
>>> +		break;
>>> +	case ACP_SDW1:
>>> +		pos_low_reg = sdw1_dma_ring_buf_reg[stream->stream_id].pos_low_reg;
>>> +		pos_high_reg = sdw1_dma_ring_buf_reg[stream->stream_id].pos_high_reg;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>> returning -EINVAL as a u64 doesn't seem quite right to me?
> Agreed. Default case needs to be corrected. In case of invalid
> SDW instance, it should return default byte count which is zero
> instead of returning -EINVAL.
>
> We have identified similar fix has to be implemented in our other
> dma driver as well.
> https://elixir.bootlin.com/linux/v6.4-rc6/source/sound/soc/amd/acp/amd.h#L174
>
> Will push a supplement patch to fix it at one go.
>> @Bossart: Let us know, if have any futher comments for our replies.
>>> +	}
>>> +	if (pos_low_reg) {
>>> +		byte_count.bcount.high = readl(acp_base + pos_high_reg);
>>> +		byte_count.bcount.low = readl(acp_base + pos_low_reg);
>>> +	}
>>> +	return byte_count.bytescount;
>>> +}

