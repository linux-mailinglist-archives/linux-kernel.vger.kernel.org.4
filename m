Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2705F6304
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiJFIpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiJFIp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:45:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9B08321A;
        Thu,  6 Oct 2022 01:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdGmR/pe+jOR55alSjoGZf6+OQ8ShlSzmF0P2uWmMuQUuS+LuXA04WerfUf6ly74uraRJpYq0RYTmxSUERPBNNHzBOpq8qWGflWM5cUUd/mwvVMSwj99Ge2vf5+F4U0VhOoC/vi0cZhznjF9APytTLNuD/TbQAXUSFdWtQ/+3ee+Y4r2vaqWE6RmM+e9VrBPh2UCaxa5aXApYoUAYPDCeUoKThJzZ04XHw0k/7XfpLPq3/2evsIskATqXRTsz1LZqxfJjy7iMFvTkn0drcS46LZIycyExMSjjuX4/5PAl29eao7jxEScFMKOeqC8g9h7CnVhLQKd7alxbVysWkeOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPKSxLE5UNVQMZTsRQUC/h7MRgLcCOiihMAeHUBMHxk=;
 b=KTvZNC01G4ozHxSwFIAUmCQwgKRa+5vERI3EquHybuPPINiRu1c5tWL1lCA5arYjhOW1QVk0PQ3lw3AsAJpyRHmmfeaez2nxfmBaeduULSOK+ZPsdwFN3Kl5hZhapkG7TPp2/ZF59Wk0c1fF9ACnmHkxXrjrOQghYrqa/Cpdg4CNA/QBNfeOROAR7nRE4bez4Ifdssk29oaYfa5auxD7OKboFWD/7mVjrVRQJw7fAWxTBVSbhyWZZBdB4h7/6RhTadX73CM92VdTB0xHzIbGXABK5I/5rXfEWT9p7nkzPhVgogo3c5OZhVsnWAeh09eqwzveL3c7BRcTtu4wo482aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPKSxLE5UNVQMZTsRQUC/h7MRgLcCOiihMAeHUBMHxk=;
 b=MDOzKKfJEZG45uhzdg3RqZa2X1+81+BAbWUdfOQfYMypDFBCbmthQg7bJoQi1nj/9IlR83g3f4lcRCgKOK+461TSehlIIFGK1NG8j91PchoWUYVvRlIjR3ksbUuDKpEx4ehOtInqJeqPJ5h5NEDr48URLickMtxtvSMAAo7KN22bhDRgZE6S/wQ0qNA6kxv0+WqsubGhaHlIqlVKKACcs0D/fjNFER1PZy0MHS2zHODQGT1ScudavpNgwbEgJ6KxFcwPxYZF56JFrSgA+QX+T+k+IMicHsZkCKkYikbj3YO8SiUJAj6LFCwxyQM2EEiFMcnmghDaz4+O7eOL+JxV6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.36; Thu, 6 Oct 2022 08:45:24 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d%5]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 08:45:23 +0000
Message-ID: <86947512-33c8-4e22-5329-a41735c6b1ef@nvidia.com>
Date:   Thu, 6 Oct 2022 09:45:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] ALSA: hda: Rework snd_hdac_stream_reset() to use
 macros
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Mohan Kumar D <mkumard@nvidia.com>
References: <20220818141517.109280-1-amadeuszx.slawinski@linux.intel.com>
 <20220818141517.109280-3-amadeuszx.slawinski@linux.intel.com>
 <657d2418-0c3e-296f-8f4a-dc10ced2dffe@nvidia.com>
 <87a66av4gk.wl-tiwai@suse.de>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <87a66av4gk.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0440.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: e1aaa6f4-8d71-483f-4d1e-08daa7771bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gth/3k39PWZ0sBvZa5ZW2bKjwTiaA7aL1YCVHDBw3t0Kino25hSNkiCRjIQbmcKV/JoIU11BdXODNv5M5SvuoqANGFuCRfUkqqs4nDEu1PGhORCtWUyF5kV4+lgp9CQQ1kt4Bu/EVDC0M6QObL9OqSTjpt2P4n6rDZg/rICuJROuuBKx1iW05R2ffgfENAdnEvy+AtkqUNN8WdRTpcfCAsASkrGhXRBrd5d5OwC5KqcUbkIgyZGeWjcLxEup7wccP/+uTdCzpjPwwcdYTxbGwHklsKYbPbfN72IZJFDI/8kxx5tIXOG9aEcXcT7MusKcGCz/vcW29/H7sYpIAmkWquSYLM6Zujqu2bI37vsKahPDSTSx1tZFC7JMSkaGI4nVvvnFNcb3ly7ewEc6+W/dZ2vGG737oAMyEyZDlMCavPT7bHEg2IdKbr/PVBgbx3ZMAUy1vCC01GWZNKHo+DXFy4dwKgV3U/tfaZO7HKSxdTriT+/Ti8mDOU9dEgMHcPWIwafI+uVTOzD8SVAXw2Q7lJk6zHw1ttA4CVPa55J7WtNrgPs9h3lPbGJl2WDuy/sLhydVIy8i/Ijeuh3hwVl0FGlne/Trd9z+y3BkkY4bhqaoI0i9B7CcB+bwdTii8TZxgBkBZoRRzQEeiTO08hi6tLKvT4PNAFB6/StawRjPSrAFB2Un8DDEQ8VAaAPfGNFFH37RVtmTCvMSObNEb0OniqU3XXTYoIQn0TLQeJxOugZSDDrfoqax44dH+ul+Wrk5jV3w8Fui8biYK0ZXu4QLLp/OI+Mm0WX246FsWuq4E/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(2906002)(66946007)(41300700001)(66556008)(66476007)(8936002)(5660300002)(4326008)(8676002)(36756003)(31696002)(86362001)(38100700002)(6512007)(53546011)(6506007)(54906003)(186003)(2616005)(6486002)(6666004)(107886003)(478600001)(6916009)(83380400001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnVyUUJ3QWJtTENaWXcwT2ZnOHZGdXltZmxpblE5dEZvVldHbVh6aW84ME5a?=
 =?utf-8?B?QTdVQ0poR1FhazZ2SEVJYlR5VU9JWjEzZXFEZE9wZlBpei8yeDQvbVQwbjl3?=
 =?utf-8?B?NUlZalh3Q3dqVlg0SmV3QXQvUUpLNlVmUmFwV0g1UWRXNWZtSnBkUFN4RHpv?=
 =?utf-8?B?ZENZSmpocUhBd3MyZ05zWVN4cU8xU1kxZUVoQUxjWThUVmhHeUE1YkxBMVZM?=
 =?utf-8?B?ckdSWjV2SkNibDEvRHc0ejdiQkRmNExVbkpqdWZJaWVVdWlHc3ljdnRaQURC?=
 =?utf-8?B?MEkxSEw5YVlrbGxLYWVWUEVDMGx6Zm80UmVEcnlZVGp2VDVKdllib0ZuQTR3?=
 =?utf-8?B?QnovM3R4U1ptS3IxbEFCSk1KOEw1Q0h2eEo1c1FjY0F3WkJadG1wRkIvYkdt?=
 =?utf-8?B?K0RYQWVzTlhZMDBDVnYrVUI5N3AzM09VU3l2eHk2YVJ5RWY3YkR3RWoxQ3VP?=
 =?utf-8?B?TENQMUJRL3crUHRQYzE3cjdtTHR6OTFDZytCVDRSL1BwWkpmS2VoRXNNMUk4?=
 =?utf-8?B?Nm5CbkVYNkxXZm9pNlVpMEluRGVsVzR4RUJLY3pxdnU2ZlhwdlVERUJzVlFS?=
 =?utf-8?B?K3Vkbnp5YVNOYUF0UE56TmhqMEh3T2N1aWpmSzBtZEhxQkF5d1pLQ3dhNnpN?=
 =?utf-8?B?RGFWSzdHekpJMHBCampIMVQxTDJTeVRXSUxPYzRXeTZCWUhTV3NJeURtak44?=
 =?utf-8?B?clNWTEk4NGJaRldNYUkwTyt2bUFHZFZac1lxTm5yM3kxcUFMWXFtOCtaV1JR?=
 =?utf-8?B?U1JvcGVjV0JuQ1YybEY0ekMxNDdNYVVrcnhGbllmRTVnOUQ3SmFITlgyVDhS?=
 =?utf-8?B?NDhsODVPUTZEZi9FbFFFVWFJUDdCcjY3bmtKcHlnMEpidHphTGhIRGR3RnJD?=
 =?utf-8?B?YUJJV1c5d0hIYVB6bmZqdzRESDNneWViYncyeXRCTmNvc2xBOEZwUHZXckd5?=
 =?utf-8?B?cHdUKzlkUG93eGhNU3pRdnVHTHhucWZ1WTV2R3RtNFJrNUgzZlNPQVZoMWlj?=
 =?utf-8?B?clpCc21YaGhDYTJOTnA3UjlCNGwwa2tjN1lwOUZLMEMzblB0ZjdCYmRTa2Zl?=
 =?utf-8?B?aVdJc3FuemFjcHRPY01yRGVMVXJVRkxxUUVGc2FZS3k1Mnh3RlBYUmJ6QXRh?=
 =?utf-8?B?akVYYWxoczNaVnN2VmNkVGU3SlNTUVliQkRvUHZxNk5NNVFtdjBNTmhXa2pt?=
 =?utf-8?B?QkI0R2R1VjIydlF1WjYxaWdCSEhnKzFRZGZyVTZicDU5d0ZleEdOVGgvVzZy?=
 =?utf-8?B?cXVDTWpNSHZCZGZ0cDJZaEg0Q2s0MU9kZUxDN2hDUjN2dU5BaTNCNk5ZQXBa?=
 =?utf-8?B?dkN2KzRaVHVpUHYvNTN2ck9YOHJJY2xockJQN3l3amNyMjJJb2FBcEJ5S0tH?=
 =?utf-8?B?aTJEa0MzYzFJdVhFNmx3bzllbXlKQjJ6RkJxNkZqL2FpUjRxWDAyVk50M1hE?=
 =?utf-8?B?U1hFSVJzM3AvVURUbnI4SDJnUjVod2xVY2NQcGJ1L3EvVUN5djVOb0JqUWZn?=
 =?utf-8?B?cFpHZGNEV3lPcDBMQkdXRW1kVTh6bXp2Qk1Sa0JnVGZRclY2bWdFL2VhVGZw?=
 =?utf-8?B?ZHNFN0NGbUxYZHFncmppMm1ENWs2aHhqWThmN0o5VWVyMmt4cmdwSGxIZlRW?=
 =?utf-8?B?ZUwzdVd5aWloek9yOUhra1Zvb21pbTNBU1loUWRYSk9Qa0lWdS85Y096aDFI?=
 =?utf-8?B?MmJIL1dCeXVrSkFRZDJQV3NwSytlSnhhRjlzajFTU2xxOCtzTUVwaExVVEVy?=
 =?utf-8?B?NTlGcXhvbU4yWjJqN2Rjd3pPd1pBWWdBeFY3Tm5wcnkzb1hRWjEvYnpZTTly?=
 =?utf-8?B?REM1WE03NTFsbjdaVmRocHhPVnJ0MkovWk5tNG15dE5VT1JlNExNb25vbDRP?=
 =?utf-8?B?TlVaQ3h0cEFCdDlmWlZadlRNU3NQaGNUQjh5cmtaclJpZnNxbHFUQndCSHow?=
 =?utf-8?B?S244bjBuTHNBMnVpT05iZlZNTkppK3VzSWpsME1rQ1ZUMk15QytpdTI0YVkr?=
 =?utf-8?B?dkl0SUduYTBUQlEzL25SQStFTURkWkhiU1NvaitQS1JzL1lOM2JKbTRCSjZ4?=
 =?utf-8?B?cGtyempud0liSDdwbEZmSjdxSzJOUVU2V0NZMFJyVStHNDdWSTVaVUpLQ3BH?=
 =?utf-8?B?ay9iMXYrV1MzVTdFbVUvLzF4T2VDamI2MUg2K0l4Q0w5YjJxN2tZNEVjanZn?=
 =?utf-8?B?WlhrcWUySGNTZHI4TUVKNm5ERkpMdkc2elFSeHU3eUQ3Q0dxZDhVN2trUFlX?=
 =?utf-8?B?K1dIelkrZ25wYnRjeFlwL3dQL2tRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1aaa6f4-8d71-483f-4d1e-08daa7771bcd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 08:45:23.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jn2crou3WUuZ7A+kJJaoGhLb7gSlOY8oyi9/vQi3ySgNQ64JgWvp8UySQX9iAeRFqt2fvr+O2P6Hx5vx5owU1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/10/2022 13:29, Takashi Iwai wrote:

...

>> HDA playback is failing on -next for various Tegra boards. Bisect is
>> point to this commit and reverting it fixes the problem. I was a bit
>> puzzled why this change is causing a problem, but looking closer there
>> is a difference between the previous code that was calling
>> snd_hdac_stream_readb() and the new code that is calling
>> snd_hdac_stream_readb_poll(). The function snd_hdac_stream_readb()
>> calls snd_hdac_aligned_mmio() is see if the device has an aligned MMIO
>> which Tegra does and then would call snd_hdac_aligned_read(). However,
>> now the code always call readb() and this is breaking Tegra.
>>
>> So it is either necessary to update snd_hdac_stream_readb_poll() to
>> handle this or revert this change.
> 
> Does the patch below work?
> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> --- a/include/sound/hdaudio.h
> +++ b/include/sound/hdaudio.h
> @@ -592,8 +592,8 @@ int snd_hdac_get_stream_stripe_ctl(struct hdac_bus *bus,
>   #define snd_hdac_stream_readb(dev, reg) \
>   	snd_hdac_reg_readb((dev)->bus, (dev)->sd_addr + AZX_REG_ ## reg)
>   #define snd_hdac_stream_readb_poll(dev, reg, val, cond, delay_us, timeout_us) \
> -	readb_poll_timeout((dev)->sd_addr + AZX_REG_ ## reg, val, cond, \
> -			   delay_us, timeout_us)
> +	read_poll_timeout(snd_hdac_reg_readb, val, cond, delay_us, timeout_us,\
> +			  false, (dev)->bus, (dev)->sd_addr + AZX_REG_ ## reg)
>   #define snd_hdac_stream_readl_poll(dev, reg, val, cond, delay_us, timeout_us) \
>   	readl_poll_timeout((dev)->sd_addr + AZX_REG_ ## reg, val, cond, \
>   			   delay_us, timeout_us)


So looking at this a bit more I see ...

[  199.422773] bad: scheduling from the idle thread!
[  199.427610] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D  C         6.0.0-rc7-next-20220930-00007-gd6ae4ed0a78f-dirty #23
[  199.438880] Hardware name: NVIDIA Jetson Nano Developer Kit (DT)
[  199.444899] Call trace:
[  199.447357]  dump_backtrace.part.7+0xe8/0xf8
[  199.451680]  show_stack+0x14/0x38
[  199.455024]  dump_stack_lvl+0x64/0x7c
[  199.458715]  dump_stack+0x14/0x2c
[  199.462067]  dequeue_task_idle+0x2c/0x58
[  199.466038]  dequeue_task+0x38/0x98
[  199.469565]  __schedule+0x4a4/0x6d8
[  199.473104]  schedule+0x58/0xc0
[  199.476292]  schedule_hrtimeout_range_clock+0x98/0x108
[  199.481472]  schedule_hrtimeout_range+0x10/0x18
[  199.486039]  usleep_range_state+0x7c/0xb0
[  199.490084]  snd_hdac_stream_reset+0xe8/0x328 [snd_hda_core]
[  199.495913]  snd_hdac_stream_sync+0xe4/0x190 [snd_hda_core]
[  199.501627]  azx_pcm_trigger+0x1d8/0x250 [snd_hda_codec]
[  199.507109]  snd_pcm_do_stop+0x54/0x70
[  199.510904]  snd_pcm_action_single+0x44/0xa0
[  199.515215]  snd_pcm_drain_done+0x20/0x28
[  199.519267]  snd_pcm_update_state+0x114/0x128
[  199.523670]  snd_pcm_update_hw_ptr0+0x22c/0x3a0
[  199.528246]  snd_pcm_period_elapsed_under_stream_lock+0x44/0x88
[  199.534216]  snd_pcm_period_elapsed+0x24/0x48
[  199.538617]  stream_update+0x3c/0x50 [snd_hda_codec]
[  199.543737]  snd_hdac_bus_handle_stream_irq+0xe8/0x150 [snd_hda_core]
[  199.550320]  azx_interrupt+0xb4/0x1b0 [snd_hda_codec]
[  199.555524]  __handle_irq_event_percpu+0x74/0x140
[  199.560281]  handle_irq_event_percpu+0x14/0x48
[  199.564772]  handle_irq_event+0x44/0x88
[  199.568653]  handle_fasteoi_irq+0xa8/0x130
[  199.572788]  generic_handle_domain_irq+0x28/0x40
[  199.577452]  gic_handle_irq+0x9c/0xb8
[  199.581168]  call_on_irq_stack+0x2c/0x40
[  199.585129]  do_interrupt_handler+0x7c/0x80
[  199.589355]  el1_interrupt+0x34/0x68
[  199.592969]  el1h_64_irq_handler+0x14/0x20
[  199.597107]  el1h_64_irq+0x64/0x68
[  199.600540]  cpuidle_enter_state+0x130/0x2f8
[  199.604853]  cpuidle_enter+0x38/0x50
[  199.608463]  call_cpuidle+0x18/0x38
[  199.611991]  do_idle+0x1f8/0x248
[  199.615259]  cpu_startup_entry+0x20/0x28
[  199.619224]  kernel_init+0x0/0x128
[  199.622669]  arch_post_acpi_subsys_init+0x0/0x8
[  199.627240]  start_kernel+0x630/0x668
[  199.630933]  __primary_switched+0xb4/0xbc


If I change your patch to be read_poll_timeout_atomic, then it works \o/

Can we make that update?

Jon

-- 
nvpublic
