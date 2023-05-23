Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4CF70DADA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjEWKvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjEWKug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:50:36 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186571A1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hey97kc6xUfdmVC/oJNBLu6zcapo7BPXg2hqQDWwLs8vmCKZ7d9oxT+n+mNtWHN87pDfFgEHToRfNQrorG8F/MzEsBdfRzFT3Wd85Y5czPQzh6NnoqwAmHKRUWOqmkAmvwrdBZbMVmurgnN5sIn21DNBl2jZNc2wqbsr0MW61N+0VKL+xayzqmm/ycz9hOGvXPxA2aytqXZBaIZMcvlz2caWWS0y8ggppAr7RYqr1hBqzyRM13yL/TZxFc1yGishOBfyKna3NuihPA0RoaWk4wwht0Q/CvU0hT0agvMkC5bO+vCcmRq2wc8oHlsywRWvk81l/4c92XMs3DnrCQtBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UaAVRtHGZmYyt0X+l+T2OGGxw/mgcjHBcL5u92lBdQ=;
 b=OjKGqtYBjMbe9tBiwhRyytk7kKY8tqwGNlH98NjDHn2tSt2tfreepkwzMeXCyHN1qQvH8rcez4KAg3MdnFlCqqmQdrT0Hjn0ZWmQaMi7eOlbEUBNKiJR4AY56wnVBAu6REda+EXbdcoTWyonvlVF6MsaldNOdoIlI7SQAepX7JN9K4+dPEm/J3OZLy1viK8JNpj1I41TmtyOGYwS3f9BFUHjyAji37FRz0OH+j8+xld5S78OvIbRFQeqfF9v/lUCz3If+bG8Gj0+ixTQRDkmfzAb80CJeRsEsXxMt2KXm4BGhVAlIbA1Mu5G7sYzSOVnN5xqi0NGPtze00FKpzKusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UaAVRtHGZmYyt0X+l+T2OGGxw/mgcjHBcL5u92lBdQ=;
 b=v32ai+MqvJdGco1EOwlT1jJJDLusI1+AhaqQD6Ao/AGOO3Hv5zb0sFJ7zleqAIt9p72v4FEdFFewu50N8sNJLBQArCGKoQ2+EO2SpYDhoiluA1L8u55Tj5gp0zGymfRLYbpo289H5wfxf0GOFaiU1ZutSbzEnf0g26xtrusiDBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 10:48:58 +0000
Received: from CH2PR12MB4120.namprd12.prod.outlook.com
 ([fe80::3539:5ea5:e23b:7e17]) by CH2PR12MB4120.namprd12.prod.outlook.com
 ([fe80::3539:5ea5:e23b:7e17%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:48:58 +0000
Message-ID: <f69b31e4-79f0-b7f5-097b-0e11699867b9@amd.com>
Date:   Tue, 23 May 2023 16:23:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 6/9] ASoC: amd: ps: add pm ops support for SoundWire
 dma driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
 <20230522133122.166841-7-Vijendar.Mukunda@amd.com>
 <b3812c08-96fe-f125-66c6-a7db518a37ba@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <b3812c08-96fe-f125-66c6-a7db518a37ba@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0238.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::8) To CH2PR12MB4120.namprd12.prod.outlook.com
 (2603:10b6:610:7b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4120:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8359ee-debd-4ef4-9220-08db5b7b4f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+KGKN4SP6UwoviB3cH1XDjIQghIvbpL5Or8r2alnWXVTFmPKMfo6KSSsTYDTTuCF6AZ36A2z9+/OpTzOg3sqEkT4G385WDlv1N+1Mu9IRG5KwasB523itd7zOXFu2R2u9z1u5v6fIjUA9d81PFE3j4Aba+6NJHSREGueDZE4oFdg7dCuyElQoGdGeIjDfSQwnBJt3fvh2IZ1Z1i3MN9EhciVFQvvrUsOseB45Kx4ZsbS8ZJT9ud8om0U9sZ8D6ODhrSSDJbF3vJWc6rHjcbVuDRqkxhi9S/Ka7ft0+nRyTYJ3lb70KvdV6R2PaHz55iHzb6YSBpoVDzx184m4xtxy22d+gD+dFraXLNGzL/6kpwHD11XBCItRQXIF+AYciVvbjaa0vpOMJmrbzlTOnUOlHURisZUEC+nPfU0x4O2tVdXlkEbE8IlCl/QxmWTUl2+gyn4NM9I/ztU2CjM4v33esAP+GDds5CTV/udcS3Wg6g+nLxGPLUcCSpeXMebYFnXbBwIWHHwOXX0naAzbBTmSl3bIMlhT65ayNnpmCybA9R1P+bT2tmES9Ub0d+8uZiZ31JulJOplQ7EouV6+qi2p2RX/WfVJfiz1nYO2dGF7FASFn+c4ysUVp5xiODlzL7Xh4V5wM8vm84NmY6FYlmUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(6506007)(6512007)(26005)(186003)(53546011)(38100700002)(2616005)(36756003)(83380400001)(2906002)(6486002)(41300700001)(316002)(54906003)(478600001)(31686004)(66556008)(66476007)(66946007)(31696002)(4326008)(86362001)(8676002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmFJU3hieXNXVnNlYzVBN0xTZnYyZkdHV05ib2w3N3Y1SmVuMFhYT3JFRU0z?=
 =?utf-8?B?TUFLUHY2amdwR0hFT29IcTJjQzNya3QwSWpKbmhVb2NQdXl5RmppMUVpM3Rh?=
 =?utf-8?B?SENYQXVCVFIvenVOZEQyeTY5T2gySHlwZkppS2w3SjNmdkd3bmoyVXhHVWNo?=
 =?utf-8?B?WDVTZ2xNN1NjdC8yd3R1dTFzL2FuNXZSSitrTytUcUdWSk1kd0FiY2xLUzZv?=
 =?utf-8?B?ajR4UXJaV2dWSTJUZzY5TGkyNDFEbXdiaWcxSzZtdnNvU0UzUWlzOHliRFZs?=
 =?utf-8?B?VjY5ZXYyL2hEb2lRWjlTcWp3SVRnSndxMHJSZXdmTEFndDFtUzJCdHpQTkVZ?=
 =?utf-8?B?SnJqS3dIaS9CZVFpdEVLVUp1QVdHcnl3SWc4TXJBeVNJMlNhVU5zYlBNYUh4?=
 =?utf-8?B?eE5Yd2ZTcGRGU2E4MWtBRlptVG9VVml0R0R5S1k5bDU2ZlllNXAyUmxodjZV?=
 =?utf-8?B?SmpUdjIvM2xXTEZpMjF4dHE2ZGtTOEtQeHFKRVdXazdBTGRRRkVzZnRtU09Z?=
 =?utf-8?B?ek9nMkpTOGVlNHlpVEhTVHpTMUl3aWhMWmRteDNXbFhBV1BEemhuRllYS3ps?=
 =?utf-8?B?Q3RwTWoyTnViZmJ2ZnlQN0ROK3IrUnhlRWliSXZSZ0hLNVJzWlFPSUFVSXlC?=
 =?utf-8?B?bUdSeTAyNHFwa1ZicHY0UnlIR0tWVys2clJPYm1xS1IwSFFnZ2puTXpaRCtp?=
 =?utf-8?B?SEIwQzQ1R1lXbEdHRTZUa3dFbWxpUFQxM1JSRDU5bEpTcmpVd1ZCVGhFR2Jy?=
 =?utf-8?B?T09WU1prMS9yQVNtQzdVZmRWM1ZSZkU1ZjRCZExVYUw3Q0J1UFNCVUhGRjY0?=
 =?utf-8?B?NnZIb29FMWR2Z3hwRlQzbUE1TzY4RjZVcVhrWnV0b2xLY0Z3Y1o4MUtCM1pG?=
 =?utf-8?B?NFcrSjZMaldUMFgyU293ZUFVWEEvSkRpMDRZSlRiVGJxUXhMZ0N5NHJrNlVS?=
 =?utf-8?B?Q1VMTVFoTXNoZnZMSFJ2TndtTjhUMkNJeWNkQ2c5d0Jlb0JtTDFKWG9uYkJN?=
 =?utf-8?B?a3hyakQyenU3RFJLcmorZXpVQ2NkblVST0Y4dXdFdFdLMmdRQ1VrTkRGZXkr?=
 =?utf-8?B?aTBUcVJ1WEdxcjBCWm5OY3U4OWI0aWhweUJDaUtERXRFRDNYdWJnVkZuMUpR?=
 =?utf-8?B?c3dSbHhhenNHaEdDWnNyU3RuMk5JdmxIM1poMkdsNUErdlgyeWRJNGJReEZw?=
 =?utf-8?B?VXpQMnlPdWJaZElrdVFSTldrNmQ0SkZDcyttRk5UWG0zUk5YdkU2RHV1ZjNm?=
 =?utf-8?B?bEpCa1VHUDkydXc0SjQzNzBGYjYxMjg3VlpjYTZuSSt1RkNONVlqMUpvTHpq?=
 =?utf-8?B?R2k1T1RkdnF1N041bkozVy9MUTgzRVBzL0hTR3NTRzhSOUlkNDUxa2F5NDdj?=
 =?utf-8?B?TFMwN28zOHY2Y2poc1JOTUZZVnVrak94MmIxK2pUYXFXM0xiY0pZTDkyUXZl?=
 =?utf-8?B?Z1pUVGo1TnEwM0V2Tlg1VUJtdmdjNUdhR0NpZU00N3F4V2JsMnhRU1EwWE5x?=
 =?utf-8?B?MGdHc2Y0b1pxRkNwTGFtUld3OXExS2dxWndTYnpkcWhpRElMWXJWL3Raak0w?=
 =?utf-8?B?WGM0ci9aQ0xCUDdKd1l1Njk4REVGcUc3c2FKN1dnd2k0RVFYMzREWWZuU1Jl?=
 =?utf-8?B?b1Qzc1VJQWpnZmNPeFd5QTc5MEtpNDBiNTNFYnFucGo1d3k3eWRWQ3N4cGxy?=
 =?utf-8?B?S1FQNnRzV25qQnNWSXhiNWVmdHUwdmxITXRFZzBzZXd6dkpGc2FtU0RqbmpY?=
 =?utf-8?B?SVdKbldHa0xTSkJUTXRzd0pIaFVvN2JGTmRnRWdBSGlYUzZCQy9DZHVaNDli?=
 =?utf-8?B?K1VMNGFVLzJJTitFQ3hnQ1J1eFYvblczVjRJTUU5a3FUbUJGZzZzdGN2dWZD?=
 =?utf-8?B?MlBtdFM2c1JvM0hOcUx1ZmdPbklXYjJuci92TjFHZWFOZWFvaGNmd3FmdGNs?=
 =?utf-8?B?c2U2TDNKM0VYWGNndEJZbjFPc01rdERSZGlqbyt0K1dsV3QxQmlBdkdCaC9j?=
 =?utf-8?B?OGVIckJObEJvdU9NRzlpck9LcVFseGZYZkNaZXFra2ZMNEQwOGdCM1JnUVQ0?=
 =?utf-8?B?a3BpNzdCRW05bis1R1R5MldJcUhLblpWVXpKTmp0UzFHM0NBUnpQaHRnYTNM?=
 =?utf-8?Q?RMtYGMeG6P9o7yo2c8SKXBG+v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8359ee-debd-4ef4-9220-08db5b7b4f8e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:48:58.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uem6J+o50HA8ShDa9a40S9vqJdalTbrNQ1DU+Rk+iReJPIkXDbN6P/I2ckVb4W/VBHu1W+pbcIHz7OHIYHXTSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
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

On 22/05/23 23:50, Pierre-Louis Bossart wrote:
>> @@ -464,16 +488,79 @@ static int acp63_sdw_platform_probe(struct platform_device *pdev)
>>  	status = devm_snd_soc_register_component(&pdev->dev,
>>  						 &acp63_sdw_component,
>>  						 NULL, 0);
>> -	if (status)
>> +	if (status) {
>>  		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
>> +		return status;
>> +	}
>> +	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
>> +	pm_runtime_use_autosuspend(&pdev->dev);
>> +	pm_runtime_enable(&pdev->dev);
>> +	pm_runtime_allow(&pdev->dev);
> Can you remind me why you need the pm_runtime_allow()? I can't recall
> where the _forbid() is done.
We have used pm_runtime_allow() to allow the device immediately
enter runtime suspend state. Yes you are correct. If we use pm_runtime_allow(),
then in remove sequence we should use pm_runtime_forbid call.
> Also is there not a pm_runtime_set_active() missing?


We will change the sequence as mentioned below.

in probe sequence , we will use

    pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
    pm_runtime_use_autosuspend(&pdev->dev);
    pm_runtime_mark_last_busy(&pdev->dev);
    pm_runtime_set_active(&pdev->dev);
    pm_runtime_enable(&pdev->dev);

In remove sequence

pm_runtime_disable(&pdev->dev);
>
>> +	return 0;
>> +}
>>  
>> -	return status;
>> +static int acp63_sdw_platform_remove(struct platform_device *pdev)
>> +{
>> +	pm_runtime_disable(&pdev->dev);
>> +	return 0;
>>  }
>>  
>> +static int __maybe_unused acp63_sdw_pcm_resume(struct device *dev)
>> +{
>> +	struct sdw_dma_dev_data *sdw_data;
>> +	struct acp_sdw_dma_stream *stream;
>> +	struct snd_pcm_runtime *runtime;
>> +	u32 period_bytes, buf_size, water_mark_size_reg;
>> +	int ret;
>> +	int index;
>> +
>> +	sdw_data = dev_get_drvdata(dev);
>> +	for (index = 0; index < ACP63_SDW0_DMA_MAX_STREAMS; index++) {
>> +		if (sdw_data->sdw0_dma_stream[index] &&
>> +		    sdw_data->sdw0_dma_stream[index]->runtime) {
>> +			water_mark_size_reg = sdw0_dma_ring_buf_reg[index].water_mark_size_reg;
>> +			runtime = sdw_data->sdw0_dma_stream[index]->runtime;
>> +			stream = runtime->private_data;
>> +			period_bytes = frames_to_bytes(runtime, runtime->period_size);
>> +			buf_size = frames_to_bytes(runtime, runtime->buffer_size);
>> +			acp63_config_dma(stream, sdw_data->acp_base, index);
>> +			ret = acp63_configure_sdw_ringbuffer(sdw_data->acp_base, index,
>> +							     buf_size, ACP_SDW0);
>> +			if (ret)
>> +				return ret;
>> +			writel(period_bytes, sdw_data->acp_base + water_mark_size_reg);
>> +		}
>> +	}
>> +	for (index = 0; index < ACP63_SDW1_DMA_MAX_STREAMS; index++) {
>> +		if (sdw_data->sdw1_dma_stream[index] &&
>> +		    sdw_data->sdw1_dma_stream[index]->runtime) {
>> +			water_mark_size_reg = sdw1_dma_ring_buf_reg[index].water_mark_size_reg;
>> +			runtime = sdw_data->sdw1_dma_stream[index]->runtime;
>> +			stream = runtime->private_data;
>> +			period_bytes = frames_to_bytes(runtime, runtime->period_size);
>> +			buf_size = frames_to_bytes(runtime, runtime->buffer_size);
>> +			acp63_config_dma(stream, sdw_data->acp_base, index);
>> +			ret = acp63_configure_sdw_ringbuffer(sdw_data->acp_base, index,
>> +							     buf_size, ACP_SDW1);
>> +			if (ret)
>> +				return ret;
>> +			writel(period_bytes, sdw_data->acp_base + water_mark_size_reg);
>> +		}
>> +	}
> Isn't this set of configurations something that needs to be done already
> somewhere else, i.e. could there be a common helper?
In hw_params() callback, we are setting period_bytes and buf_size from
params structure. We are extracting same variables from runtime structures
in resume() callback.
We can implement a helper function to further simplify above logic
instead of having two separate loops.
>
>> +	acp63_enable_disable_sdw_dma_interrupts(sdw_data->acp_base, true);
>> +	return 0;
>> +}
>> +
>> +static const struct dev_pm_ops acp63_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, acp63_sdw_pcm_resume)
>> +};
>> +
>>  static struct platform_driver acp63_sdw_dma_driver = {
>>  	.probe = acp63_sdw_platform_probe,
>> +	.remove = acp63_sdw_platform_remove,
>>  	.driver = {
>>  		.name = "amd_ps_sdw_dma",
>> +		.pm = &acp63_pm_ops,
>>  	},
>>  };
>>  

