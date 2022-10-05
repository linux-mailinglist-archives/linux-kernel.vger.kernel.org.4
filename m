Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9CD5F55D7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJENwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJENwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:52:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967125D0C6;
        Wed,  5 Oct 2022 06:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foWiIEwyQY9r2kj43iV+/WBuLGIwVMAQlkq4hmRakyi8114n0Z28+tbIlboE7wcY8AUXQW2/2BjUP74dIIpWeGyWa2VVwraJFHm1WhsP3pXuxUuQykDyCaKTvuUdqt/9/Ti3uZpph8EJHpfmm6ilTWYtfWYvDawvgf7vYm65uSVyGPVGi2GaLkHb2PzLPThe9t2XBE5LlQOcPSq1gw32AsAQraJICuVt+jBqWHXiAQHq1lugttUX7FuK5K3AAKGMFYx9IbXYR8E8Dg9dm0IJwdG1tdTJkKYk5JodnKa8h9nb6w3bfiIBjutoFEQ+/DkOYzF7gJ/bVHn5GqfWDEbi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nK6Kiu8eJUGcCBoa9ph3FFFW71ciDkxrDodT6pjxLhk=;
 b=VUV0SgaJquqpkAxPOmlrIYglOmwxG5EhLKc+iHjjUN0SrQlrCLjz+2rim4zSvNYP8/Uc1hy309tR3AXGXwmfYw+uH19qjNzwvUsOC/WCaSegn99wqPuLjca1h2B2a4o/FjGcF8IGn3YXGzLXVPlpzO0sg+J7WqmEzGmJxOu51rArkkZ9ru+YWdM9pND/wy4o6KNWD8tnr98TsJm6F9CBZbMKbxVGsFCk71a3dsdaxrgu87gUwT2LM4GLGDg8E9BiaPLSXGMHDZTTruAV3wwxx952gRpGr0MPzol9KA2nWMfBEGTn7SuU4iWngReY44V81fGBVtIAmPZtFqLWY0Hcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK6Kiu8eJUGcCBoa9ph3FFFW71ciDkxrDodT6pjxLhk=;
 b=R5YJSQe1iNc3jVoipXnGsqg3dP0SwvT65kopsPJoVrGu+o1vDQb4DC9aM3Lj3j97n57BD9L6HvVRBoFKofRjMpnYgnK2hjx9kxVWQl884V27wWEmIcpwNuU00KVarYNragWCNl97X/RXUnLwnugxYrHbc/zOpQvh+xM9g+Wk+9I7YbN30M/+V/kn3PUOVg72kvOLys85mOd2N5N9EpBshSXptgdFIuDmJaNMIJfB9jBIui81oxa4I1LDA3f9q9OGdfDV9ONef+UTgsmr60FUP+P0u+qCAWRHkhzjYMz61y6UcnZ1YmQBUmXWGTJTvznyDF7q7KCzjdkL1WaYIafC8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.31; Wed, 5 Oct 2022 13:52:12 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d%5]) with mapi id 15.20.5676.033; Wed, 5 Oct 2022
 13:52:12 +0000
Message-ID: <9677f39a-5297-bb1c-d4e3-62484ec1cf25@nvidia.com>
Date:   Wed, 5 Oct 2022 14:52:01 +0100
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
X-ClientProxiedBy: LO4P123CA0421.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::12) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb02c4d-2ace-4708-cb65-08daa6d8cdb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjhQRV98TNUbTvRX69kdjlsxcal7fmoc01Q4SqYLUJIC4Ni18IASNSh36SO/0GPr1BJPp66hOHOsOdhQjCiLsDyJXSR/dYBnXfYeLhvxopGJeoFDMfJL3fEoChJBVNL5AS2l3vXCwftF0fl/CtNmZm7wiQKjMDGvcsY0SsyVm24xYwQL9KOX8TzlM1OkNRhRJ/jO9V6QBfLJr33+sXXK5BIj8OtfebuO/KvAQoBtw10f/yDJlAdOJ6ciR5iuMf/H3yp/wjyIUNPIpfadPJnCRhO+NxwHuuc2sQKRTARkIiCoSkvBYglQQFrfCNR49JNI41lq3vdcAfeoBNcNthMQcuKQ82xouSJpfqn7DwFnB1zGg1sVJo4bxfZCodjDJq1J7FjaZacURXk7kSe25rGhAm86ZNx/HucFir3Xz05rBzOBt32qgnDcbA94KowoR3Gf92NYTs4fp/Dyikp2QQd6ycCY5XjAP3uu72NrJzPnoQX2duZv6X8A4m6FxksM9Sj7X5k3T+HJV67Iesg7Stu51acnWuoh4x47T/w3QGgybzTDjamT7h8jATjNHHKAH4ltyPRd9UOO/9/M1EtIwyHHobZzAYBwqwnyp3/TaH2ZdQ70iIpVPHHNhDi0mTOkxue6goeOqSxgC2Gwi/qlXZf/BuHaqOJgPySU+QZzkMGJ6dqczbyLeuC52hmcWg9coqkisyZ9NQnK6qPW+C8wyOY3NRYQPNzjTjzwlNEs5yP1JO+OoDKKVmUn/J/uYfK9kNC0aZh3oZnFNOZuBwT4Gm6IEBuAHpVwRoR1qPQGBs/oaEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(38100700002)(186003)(36756003)(86362001)(31696002)(4326008)(53546011)(8936002)(41300700001)(5660300002)(66476007)(66556008)(66946007)(107886003)(6506007)(6666004)(6512007)(8676002)(478600001)(316002)(6486002)(54906003)(6916009)(2616005)(2906002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHpSK213b0syKytoSVBYVUsxQ3BnbHVYT0UzazJDQVBIWWVVZHBWVm44RmdL?=
 =?utf-8?B?c1ZwY2NIUGgvc2tWdnlqZFVrdnF5MDRzSW9va0F5VWloMEorS3pQREt6bi8r?=
 =?utf-8?B?SWg4UTRYSnBTdEkzTTVlcVh1czVoeE5uUnpuaEFMYU9UV1JBSzYxbzJOemJq?=
 =?utf-8?B?cW5hWGoxL0xJYUxTS21KdHNOb2xCdkhjVG1hSTEzYVZxTmF1OEhGQWVTRWJW?=
 =?utf-8?B?YXYzeVNTbzd4YUMvL1ZWS3RoQkhBdC8zaHhTV2VPc05peHo4VmxFd3BQYWFs?=
 =?utf-8?B?bXFFTElvL3F5MGZpQ1lLb2tYbUtub3g5bm9pUkx6TFc4VjBhbTVRdUpIeVBv?=
 =?utf-8?B?dnFvMitMb3lLWjhyWE9qTmR3bHZXUCtsOUppd1JTWCs3YzdFek96M0hoMFNs?=
 =?utf-8?B?WWV0ekYyTElweE4wdjN3MTdrcGE4TS9IbTI0dHE3OU82dVZiU3M4TmlDSW9R?=
 =?utf-8?B?R0ZkV1JSaHNSMUxMbGczandKV0kyUHZOU201ZElnNDZjbTJQdDBYRGFrVlBL?=
 =?utf-8?B?azhqYnR6dUZlQktmVWxxWGhvYVorWnN2ZVl0Z0FURUk5ZkNnbXVsZUNIMGZS?=
 =?utf-8?B?TVplWjdkTUZ0K3hTM3dkc3JZM293Vmc3SHdWWlJYbzFVZWRpSnJCSUVwWFhQ?=
 =?utf-8?B?SXFQQW1tZGU3SXJzbmNZSDVjMEtLcE9ucGF4VmR2TERidDhLOUg4azJJTEhE?=
 =?utf-8?B?NEVPNWVlVFB0cXBjM2twRzFJWERQMzhzRHRoZ05MUE1tUmZMZmIzQ0lXajcz?=
 =?utf-8?B?UnEzZXJFWjFFLzQzUkZVZHltNEFNeGQ0WXArZHBMaUo4bWdRbjdPcnAva25k?=
 =?utf-8?B?SndoWWY5b3pKcjhxTkVlV1RHeE55SWdrTHE0c25WMkZ1Tk9oTHA2RnpQNEJp?=
 =?utf-8?B?eHF6Q2xDZjhhL1NmaGpJY3hEMFRXaGQ0WVBwY1V1NkVPdFAwWGFDRmJlV0po?=
 =?utf-8?B?SmpPNytucktCaUtjeldlQUZOcERTUjRmUExBNnVtQlJ5cEozWXRLZlEveno5?=
 =?utf-8?B?ZEhjNmtXb0JIdlpYUnFQcUxOV211U2xjaDc2Szd6dG9YdU9sV0M5Z2YrdVRN?=
 =?utf-8?B?aTcyYUJWWlYwMXQxSTc0Y2JnSFQ1bjZhV1VEVXc4V0lzSFFqano3Qk1WbGNO?=
 =?utf-8?B?WitaVHNTS2ViMGpKbEt0TVA1bHJBSVU3M1o4YzZTMDV6Tlc5NkpsckxZMlp5?=
 =?utf-8?B?N0dpbitpeUY0bmV1Nk9Nc2ZRSmd3RUlZQjVVNXMrVW5ySUxiL09tbExoc3RV?=
 =?utf-8?B?VnpjSWY1NWFGV3lVNEJsZHhlbko0eWIxQjgvZlFYT0tJNTNNTkxram1tVlBn?=
 =?utf-8?B?NThMQTdzdVJKNnhJdGpaYUdZVkxMMGVmQ3BuazBNYUxaUGhIc2VRU0k5K1Ra?=
 =?utf-8?B?RjJMNXFlWFhmdUhDR3d6ZVFBNjJGMXJqQ0FYZjNaU1c0TWxpakxwYjYxV3da?=
 =?utf-8?B?YTloK0Z5WXBpaXA0Yy82YnJyYU9ENmVWMFJHMHVzWEo1U0Z6eW9IR0J5WHRn?=
 =?utf-8?B?anBwMWRNZ1pNUmxwakFOY3ZLWlh5Q0FLQVlUSEpVcTlPcm1JbGtiQ3dtWmVH?=
 =?utf-8?B?WGs3UTRPMnNaQjZrbitSbDJhQktPdjRYUU1EeVB3ak1HdGt3NVZ1ZC80cmlX?=
 =?utf-8?B?SnV1M1prRmRoUGxYakVnYUhhaFVianJmRGRLUjhWbitmRjNzdHNZOFUzemF2?=
 =?utf-8?B?d1BheDkvR3ZuSWIraWFDZzJJK0FFaVdjSnRDajRyY29naVZJby9oMndnWnpm?=
 =?utf-8?B?YlMwVVByU2ZwRG41WjIwWmx3VmdGS3JwNlpLSHRRdVNXYnQwRDQyOGFBazIy?=
 =?utf-8?B?MHE1K2NzRCtBMFJuczRxL2hweDAzcnhTQmpMWWpYalE0RnJqaWNNU081WnFT?=
 =?utf-8?B?OUdZdzZoc043Nys4OEdWTEd3WnRDUzRuK2o1YkVGU0JEeTlkNG5GVVd3eGYx?=
 =?utf-8?B?Q1kvazVnQTNidjFEdDB2Y3NhSFpqUDFSblBBLzAxTXNqUkRSOWZ1WUIzTW9y?=
 =?utf-8?B?QXJXOXgyN1dKd0JTSzJkSElSVUIvdHFsQTBYMEMza0ZtcjUzeEFoYk1QOFJO?=
 =?utf-8?B?NGwyOUJ3QlEwNUcyKyt6OUZ5WWd5eHRsY243M3RjSTIxdzB4K29CSGp6bmw3?=
 =?utf-8?B?a0R1cG1STmdBcDMwZ210ZEMxMnhVeVVDSUdSTHo2b2VVMzgrS0dRb3piU0V6?=
 =?utf-8?B?b2pOazhxd3dQd0VWcW1YbHl6RUc4OWMvSHBia25IUmQvbWdnR0Y5TzNPN0pn?=
 =?utf-8?B?OC93SVNieHMxWTJIWkc2b0V6Wk9nPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb02c4d-2ace-4708-cb65-08daa6d8cdb1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 13:52:12.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFxwP9hNiyW11Ft/eLFmjHg8OXCzatfN4ppKME7pcG2qZel4ELIf9y8ITfsmTXMeRq+LJoAdZB9IWxDOWBT3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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


Amazingly it does not work. I would have thought that would, but it does 
not. I am a bit puzzled by that?

Jon

-- 
nvpublic
