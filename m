Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057035F5435
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJEMKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiJEMKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:10:16 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F74E252B1;
        Wed,  5 Oct 2022 05:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyumH5Hf3RyxqNk00+NEsWigdVDzDJ24Mthx3WAGrNavW7FZZIZblZkMy0sPK5PnnsI+ElfDccYn30TsTDw1jMnW2Euuvs61wxOAtsFukL3KJ1gSx1gjN/xqMtQWNvZSH4TqNx27Dh3qbssYPRflXqg+PrAZf45LpjJHWAu5CnOK51lnIkx8XoR9X7AMYqkNkaMpBZ0IrmuU3CzAD5wou704P6Ldjupz6iWgw8RydZKRnKz1FJWctUncytgRuFTC2iEA2Uo7WbiLbJqX/tSItw61Y8U7ogr35Pl/xkYeCJCNfsZeG1+p9HES5cK8i5mLBoOKPazplYfNwDkL2cbvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUbyroNgk6au9DxcQtxnAPtYhztnXSIU2sjVrcIM/9k=;
 b=m2/xfP77YwQ68ohPBpgVdCvLXKRJX1vndEsWCtUq9z5xNC0NQdyDgeLJyjvp7S9p/5F12qaX696k19bJKVpbbwy0Xz08nCTje6kDE9+/QxTsB2ZuyMbCeR5nJLxaW9I/YzBw6w2ZANe+hoRr2vUFtfN+uBwF0bcDqbDztudGBwKflqOKAKKJUWFv92hLggRFOiuMajHko13J+ddI5czjyMzZgKbqTdM9dd6Mmy8Gya8FkvMnP47JV6ouBK75bDHtcmo+KaK8C50cx55LZM4gXuK5jbWvB3ntRniqFG5ysKkID6E90F5mWt48NlyGDhdMdwMixYfyjLZ7rTKESdOHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUbyroNgk6au9DxcQtxnAPtYhztnXSIU2sjVrcIM/9k=;
 b=NWTwZ6sQKZS7gNx/q/8D1oPPphBFIHdIp/sCaWKU/hG7DYLvj+UUdpjTIodElJtwO53r6mGg4NJDAUAAReCfVqj1WaxSShIMLfI42f4I7mehh5YgY3c6+R5DM8JvMHQzPcDp17fQn3/80CVWEhdbmpH0Rpyozh04QCXBFicAOsQUT5fdtqMF+C8Cn5b66bfo1gxZ4mK5DVffr704IKW2sfQon6JiothUjASkECka55UM41WulhThfsFqIp1yZo9pFt9NGiLCf0ZHh2jy5A4noYUqhJTsIVmVH8CAvbJWSxT3haHNKhjyEVfKA8kvPJhseBjo8JawWkC4L91jnuLJ/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Wed, 5 Oct
 2022 12:10:10 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d%5]) with mapi id 15.20.5676.033; Wed, 5 Oct 2022
 12:10:10 +0000
Message-ID: <657d2418-0c3e-296f-8f4a-dc10ced2dffe@nvidia.com>
Date:   Wed, 5 Oct 2022 13:10:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] ALSA: hda: Rework snd_hdac_stream_reset() to use
 macros
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Mohan Kumar D <mkumard@nvidia.com>
References: <20220818141517.109280-1-amadeuszx.slawinski@linux.intel.com>
 <20220818141517.109280-3-amadeuszx.slawinski@linux.intel.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220818141517.109280-3-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0678.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::18) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c7f6a8f-2a9d-4ac8-e31c-08daa6ca8cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnarfzMRpCikC4Yf6N61Ao3FshWW0Z29M03bHyNYgBzIEHT35RL38Ts5lET5pMKXgPRIGNM3SBUHRcny2mPd0dTjQSkmiIHhkt1RJBnuZq5mhOLMsCQ2Tas1oISNx7LO1AtzTCLmd4X5BzQ3FZSesqGGvPV3WC1/XPWfFNhUtkpognoRVdSOSepN1wWvbskc5u1oMiIPxxdXYaseBE24T00LgkLIH59d10Fqind0rUS7xT0/0feBmcUPScnI1xou5c1KeEDDOS2h91nPL12zYz50nDEj+Y6TCUHVpHjKh5vUHYGmJsoRWdPczaEB6y6QvL2mIK4t8kr1qZdqVCbsSLvJow6SzjT7+CaI34l/Vxe61DSVEjsWlCSK212UYfAXIsKJnu1VsTMDFDFg6KbNRPHmAaaPVZKzXOFIWI7fCDN4qKex0Hq1ANLDO/s2tqgfXRk43UoKgoW3VAp+Q18/jBIyq4HoHCTFIT7MkQ74wWmg1OzCszKetUzht8JUkv0jjpsGYvBJFCDHHJPshAKC0Es7N5TJeJmN0CgGbHaYiTjphcpJ/RU8q3bfRvtx99ZAvokHZOzD3J7DaljLKEet2mHP0S+QgnZkaypEzDhC4HEnPYsRKLrvOr4ofmI+2DYl7/lE4RczUNpsooiTxwSlM2po9Gpp6aS1U6KLjzIvlOY1vQQJ8N/yJ9tCeP7ffmjCVfKC9Sbig8QYu8qnDDymMklJ2Ef2Uc59bV69mCJJ1bajSW33WamOzVh5zCR/wXlUlBcQOPkLsjFp7DXJLtqFv3OHQ87M3SXtjsOLzlDd0FU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(6666004)(107886003)(6506007)(53546011)(478600001)(6486002)(8676002)(4326008)(66556008)(66946007)(66476007)(36756003)(316002)(54906003)(86362001)(38100700002)(31696002)(6512007)(66574015)(186003)(2616005)(83380400001)(41300700001)(5660300002)(110136005)(2906002)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFMzRjkzVTlOL3NkS1BFZ1l2RG96blQ2MXhxZ1hNRXMwd0c5allYc3RQTFZU?=
 =?utf-8?B?eDExOXZMTE5CVmxuT1lzUjNsTFlkdE9uaXl0cGg5TmE1L1d6RDNNNmhnaGJN?=
 =?utf-8?B?eS9yUXBpNmVweEVvbFptSzB0d1NFUlJtRk0wK1RONFN5bTR1c2U1REZHR291?=
 =?utf-8?B?Y0JRbmFRblhBZ3o2N09STWFGanZtZS9vREJuUW5RQ1YrMHhFaXNuS0dta1dF?=
 =?utf-8?B?UFh3SER3aVJ1R0hUcTZxZHBkYTg5N25FWmpxOGJHNWZRbmthOXEzWGpaV2c5?=
 =?utf-8?B?SmlLbE4rUlRNa2ZyY1dhVDRRVk5iY1JUdWtSTU9CbDFaQVQ3L1JmRnlvbnIw?=
 =?utf-8?B?KzdkT2RkZDR2STRuY3kyRjJlQ1ZxKzQ5NzhjZ3NWOUhyYXc1TmdCM0NiT3Fv?=
 =?utf-8?B?QzhrMkIzZzVPc1NqVDhpd3Eyd1dSaFNjSEhRWlFzelk2aGoybWM2aGpjcHYw?=
 =?utf-8?B?RG9xc1JuMXJYbHlkK1plTU1yNlpHdFJKUERIdUZRWGFQYk5MblN1NTBGY0JY?=
 =?utf-8?B?b2J3KzhWWjNtSytMc2h4THdHZ3grcEJkZVBsOFFKYWprWjNTOVl1UzRxc2Uv?=
 =?utf-8?B?dVZZZ3ZkbXhvZFIzODFZT01YMGpTUlNCYTZhaWtsaXpLY3JxWVI2OG1XSkFw?=
 =?utf-8?B?Sy9mYkJjSWdNM2xJYlR0MnhZbWJvY2gxaXl4V1JnTlZyNjE3TmhYWEp4NkpW?=
 =?utf-8?B?VVloNWVtNzZTNXpNMzJYaGZrKzFHRXlpS1BzendnamozS1FGZXRXZHVDQ0Uw?=
 =?utf-8?B?VVlXUTUzTC9KWTJvYXpRQkdWNGEwOHhFZEYvQnBnK2tud0N6WmxCbVRmbDMv?=
 =?utf-8?B?eVN3bDZJdndlLzVuWjV3SkFjb1U4M3JPQnJVOWxlRnJmdldxMmViaDEzOEtW?=
 =?utf-8?B?ZlIySC8yZ1E1M2hYN2M0MXg1S0pSV3oyczN6ZlU1RjFPSFY4YU55eEdwSEg4?=
 =?utf-8?B?Y0pSRHlrSUxEMHRmNk5HdnlaVW9VRE1FWGdiUGYraHdnNXRFZXYza24zUW9x?=
 =?utf-8?B?cXVMa0FFa2wrZ003SjFBOU9CMm5mOHRPWmRmNGFjd0pkMVlYamRaSEc3NFNa?=
 =?utf-8?B?NzZCRTY5azFlTTZyeTZ4UnlQa3oxSUIyVEZFQTJXMFFvMzFIekdkOGdHL2Vj?=
 =?utf-8?B?WE1abjFFMm80ek5UVnBaTnBOcDB6Y0dUYzkwOXBMUHZhcGJYdXEzZDc4NVZE?=
 =?utf-8?B?L0hJTXpIS2hVOGd1UkpvS1Bxb2w0ZzdMODE2YlRCZ2RrYWk5SFEyTTR1c0Vy?=
 =?utf-8?B?dlM1NUxEcDllTC9iYUdZUEVqTTRJRzh6VldUYmpZaFN4YjBiUWRMYzcrL1gz?=
 =?utf-8?B?TVJoT0E5WVI4R2x5MUpTWm5YNEhLK2RFRk5kYkxib2tTTlZsS1ZjU3U3bmxs?=
 =?utf-8?B?S2hsYjdTTWxvYzVkbVk1YXhVWnJVOS9veFg2aVJKWVRQT01xUkRoZUZzMFY1?=
 =?utf-8?B?WGJubWhYTEVQd2ttVFB1aUh0Si82YUdySjBSZXhUdzFUMktqNTV0NUI3cFpw?=
 =?utf-8?B?RzZuSnl0SkJyTnVTK2Z5S2xsZ1kyUGJKSmt3SXE4REJtc3BxdFBPdVFWNW5h?=
 =?utf-8?B?UGFhZ3VXaWkrQk1vZXNCSkY1Q3dqY1FzZFZ1cVJCc3lZRjM3bU5zKzcyTGZF?=
 =?utf-8?B?SjJwTlYwenM1eWZTRXo1a1dZaXprNHh2TzBDQ1FGNlZWbHM5TS9WYzUva0tu?=
 =?utf-8?B?bW96MlhXVnBHRzVMMlBYbDR5UXd6SklWalBKNWdrSU9FeHBBKzg4a2RLU1lj?=
 =?utf-8?B?VjFaemV0K1Y2V01MRGd3YmFwb1o4ajNaMTFFeVFTNFhZQVU5S3NFNEFrZ2pP?=
 =?utf-8?B?NnlqVW1YTFI4NW9PTkp5Z2xhcjh4aHdtNG43TlRRZWRFTEk3OE9URUc4V1pK?=
 =?utf-8?B?L3kvc281NXowSUxobERyR0lEQWJOa0Z0QXkyM0pweFdrQWorZWdTcVFtMkxR?=
 =?utf-8?B?TXZZSXZtRFdrNUVOTUtpaW41RlgxSG4zc2ZmeWo2NGxwbWk4SGltbmpibjd1?=
 =?utf-8?B?SVRybzR4R2JIdiswR2xSeFdjZVRkUE5JY01nbWt0TVhjQkFQcGN0ZE9mbE5I?=
 =?utf-8?B?MklqTWV0S3FSNmY1RXpyei93RnRLSDk3NXlvMjE2bzcwTnRPbVl0djJaUXBa?=
 =?utf-8?B?NFlwUXpzVndZU2xVUTVqaCs4SWgzVU1nWmFtU0M4c011eEJuYjVLWU9Lcytp?=
 =?utf-8?Q?u06TNnbPhUbF9ebcFnLizK4ZGkJS/vekB9raN/Cs3186?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7f6a8f-2a9d-4ac8-e31c-08daa6ca8cd5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 12:10:10.6371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZsoIpKwRJkybg1WkC6fjb3pLNxq5MhVEsLRAaJOrVADwCi8+bMHwLVGVjNViEOnQkmJH16RYrpXNxykpHWOWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/08/2022 15:15, Amadeusz Sławiński wrote:
> We can use existing macros to poll and update register values instead of
> open coding the functionality.
> 
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>   sound/hda/hdac_stream.c | 26 ++++++--------------------
>   1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
> index f3582012d22f..bdf6d4db6769 100644
> --- a/sound/hda/hdac_stream.c
> +++ b/sound/hda/hdac_stream.c
> @@ -165,7 +165,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_stop_streams_and_chip);
>   void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
>   {
>   	unsigned char val;
> -	int timeout;
>   	int dma_run_state;
>   
>   	snd_hdac_stream_clear(azx_dev);
> @@ -173,30 +172,17 @@ void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
>   	dma_run_state = snd_hdac_stream_readb(azx_dev, SD_CTL) & SD_CTL_DMA_START;
>   
>   	snd_hdac_stream_updateb(azx_dev, SD_CTL, 0, SD_CTL_STREAM_RESET);
> -	udelay(3);
> -	timeout = 300;
> -	do {
> -		val = snd_hdac_stream_readb(azx_dev, SD_CTL) &
> -			SD_CTL_STREAM_RESET;
> -		if (val)
> -			break;
> -	} while (--timeout);
> +
> +	/* wait for hardware to report that the stream entered reset */
> +	snd_hdac_stream_readb_poll(azx_dev, SD_CTL, val, (val & SD_CTL_STREAM_RESET), 3, 300);
>   
>   	if (azx_dev->bus->dma_stop_delay && dma_run_state)
>   		udelay(azx_dev->bus->dma_stop_delay);
>   
> -	val &= ~SD_CTL_STREAM_RESET;
> -	snd_hdac_stream_writeb(azx_dev, SD_CTL, val);
> -	udelay(3);
> +	snd_hdac_stream_updateb(azx_dev, SD_CTL, SD_CTL_STREAM_RESET, 0);
>   
> -	timeout = 300;
> -	/* waiting for hardware to report that the stream is out of reset */
> -	do {
> -		val = snd_hdac_stream_readb(azx_dev, SD_CTL) &
> -			SD_CTL_STREAM_RESET;
> -		if (!val)
> -			break;
> -	} while (--timeout);
> +	/* wait for hardware to report that the stream is out of reset */
> +	snd_hdac_stream_readb_poll(azx_dev, SD_CTL, val, !(val & SD_CTL_STREAM_RESET), 3, 300);
>   
>   	/* reset first position - may not be synced with hw at this time */
>   	if (azx_dev->posbuf)


HDA playback is failing on -next for various Tegra boards. Bisect is 
point to this commit and reverting it fixes the problem. I was a bit 
puzzled why this change is causing a problem, but looking closer there 
is a difference between the previous code that was calling 
snd_hdac_stream_readb() and the new code that is calling 
snd_hdac_stream_readb_poll(). The function snd_hdac_stream_readb() calls 
snd_hdac_aligned_mmio() is see if the device has an aligned MMIO which 
Tegra does and then would call snd_hdac_aligned_read(). However, now the 
code always call readb() and this is breaking Tegra.

So it is either necessary to update snd_hdac_stream_readb_poll() to 
handle this or revert this change.

Cheers
Jon

-- 
nvpublic
