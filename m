Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C099A5B6888
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiIMHTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiIMHTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:19:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4979143E54;
        Tue, 13 Sep 2022 00:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQXrPFsYLsiiKgbD9y6Dpf814ACpPpejX4ncU3foMHeG8aTk3gnPk5d4V3q6YbXsIi43tQmFe+fGQDgHRKrMRlJUSQiibtHnbEV6+DA4UTy6csR7qGpSCe/R8cXhNTL7DDtI2MjSu4sRQLHYnvrF4O+OXInosp5UzAJzNQnbzxSBlJTDHS5fROCx27EETsctdF/GBQ/Sk6yA8byoUyQS5iurSNI3x3kQIvTasUf550rx5mmNxrYm2EXvI31ULiH93vkUJL5HNSpsNibTGe0fFqYnLPKG7h4Kuyecaf+nyc6LxZxr4VXF+dXu+1jW9H4mqaww3oxo8YlCEHQmONgQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4m2eIDEtMA5Gv+isYu8GJg2eZT6Cy88G1hjtenl5tM=;
 b=dSZrLzmCXZczClOhYONJ8eTIQ7O6xtwTRbmGvPiOu1TuFoePu8V+3evsVHIBmmC1dFtrNiD1WzE7jf86eRIciRIoCcRttBF1Jcdr07bXdM1oIlcZfyv3iB+f0KLf5NwFpft7bngNOD7C1O/m/XHcIXvVnKQb/xsb/m8eN8Eez9d7ZAB5z7V0aNzpqVbU7XZ09sMbuczP0khL+xInblZdhYBVTW+aDIeSjV4oBsMOUNK39iM/isXf6fF5grATTtpFpa+k7qvC8/OV4ygUQW1GLBmP3BrClKX5EbTqPWKW4HsVykam3LYzEKW8lSpJpf3SqHxQbVapnCFThwOG3DQN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4m2eIDEtMA5Gv+isYu8GJg2eZT6Cy88G1hjtenl5tM=;
 b=Rp8zUpX6/x4IO8M8bZItHPHMevHlhvArKGI81p3FfyLQ3EyLcq8QO1f31sBS/9UUfJbL8k9kD0JtVYpchOtycQZ0E62wbbGBS/3qBtgeRW+0PE/Fb8VlSWJKff2qY4xqVSrWTA32/hN9h/zybcIic0/44vHAhlHoZ83mVBZpxx74eOX1MyIVp+PNv7raLOncA/VH1dolxjrKlxC8V1ygLtb9GHGwVwWQ7NPeNMNu17uxiueVwqoLci9F2g0a35YDfFZonUJfPN13jRXoj7TRaHqturANR0caqb1y9JXI2KK7mTsDecfxFNBTtSJFiMScN//uGh5IovmuVBufD8sekw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Tue, 13 Sep
 2022 07:19:04 +0000
Received: from DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::3dd3:e494:c723:e0cc]) by DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::3dd3:e494:c723:e0cc%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 07:19:04 +0000
Message-ID: <5f7d294a-5040-a7a7-cee2-d62cfef5b48e@nvidia.com>
Date:   Tue, 13 Sep 2022 12:48:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [v2] ALSA: hda: Fix Nvidia dp infoframe
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, perex@perex.cz, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220913065818.13015-1-mkumard@nvidia.com>
 <874jxbhhin.wl-tiwai@suse.de>
From:   Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <874jxbhhin.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::16) To DM6PR12MB4435.namprd12.prod.outlook.com
 (2603:10b6:5:2a6::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb5aa7e-bf83-46ba-e0d5-08da95583d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0a2Rd0vHa7tjz0RwO97U0S3JZmAA3j7yqnykbBNX5RW7Z9m9KmkiJsCwPfe0m2I3FkTRNfE7ZW/Dgs9oYt5t1JC3KIyynqi69zRmXTF6DG2K7U82+8nwuYW1k2SRCbalLwExtCYCb7jX19XwdZw66/ZwdW/E001LAu5h2xN/2M9xMknhGrwq2xQGb5JAukYVnD3E7XHNNZ2MXfenKMs4L3JvwAuH1+YpQaW9cCFm3JHJ9LHZuaQAWJl1MGs1vq0LbX9zk40cGc10rmfkXOx6RTmwX2PyD9eGmaukZ/AX97c3C7P+Bagmj3ZF2AvA+WXY3TVL1Otpqdu3wvekDmTvUVEX+MQysl7Mq7WC/DgpD8tAqC+hOlB8aTPJ4VEQYRtMXYe/77x+LSnOyJC9EZA5NhucznnEj2SWAC+L+Zyyi1nHbN7+S7aLyIFqn7U3/ZGBIvpt6jqkoiKxhTCcIaHkgVgM5sKW2BOcv8uq0i7KRoMoxKEHe4pF4TavRFPHH8y1TZL0J1cYcyacZBxWGJyAnssAr10suvlrLOw/tQ/2OU/RVSQ/HzJ8vOxmPD1mx9CtQK0T4uAPcveYmW9YIRwWQRffXcKrUoVq4zufchlnnX7zPCvDFMig9Mf115KbeFnlV/aczqMKOyQFMpzQmsPPXP+/2IGdDj1d38+bHPe1ih5viAynZSfAFCGpnYYeTkcqNEDbChoN/B6hOWK6YBxZW8Ex079Y1sRUfMDhYmOcZ+YvKtCojcNzxPH5OMALOLy5gpJCNsiju2v3qA6y0grv5Tvpe0V568avceyZIGzFKgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199015)(66946007)(6486002)(66556008)(86362001)(186003)(316002)(478600001)(6916009)(38100700002)(31696002)(6666004)(6506007)(66476007)(36756003)(31686004)(5660300002)(83380400001)(8676002)(6512007)(26005)(53546011)(2906002)(41300700001)(8936002)(4326008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJNS0txVUV1S0J0VkxDcmFvQkJOTFRROHpFYjhoTkZKdllmeW5rdGhEVUhY?=
 =?utf-8?B?WXpLSmM4RVpYNVVuT3g1cVlYUGdQeHNudTNXZnpWUnpLL3ZLZnRsS05aUzdh?=
 =?utf-8?B?Y3FoOWN2Y25qNk5TeUZDNUhHbnVYbGxmcmRSOE80SHJZTlZhM2tlUzR4WXZx?=
 =?utf-8?B?SzNhUS8zdWdLWEZoeS93dVYvRUZRTFRUZzd2VjdwV3Y1Y01MWnpSR2VPaDl1?=
 =?utf-8?B?N3BYVjVqbkpncFo2dG05SGFQeVJxbHZaaDFIMmNRL0E5ZS81bnBkTlFDR3RB?=
 =?utf-8?B?UEllTysyTnVTYTJrcU1ybFBOVWd5MitaM3FBVGRJOVYrYWc3S016c1JQMmt5?=
 =?utf-8?B?cFhuWktsR0lJT09DZGQ1UlBuMG55cEg0eG5KYitiSXhMalpOcGpWbVBLZ0lO?=
 =?utf-8?B?OGRhY2pQN0FJQk5LQVlmV2NGdkI3eVFGWmpBek1JT1NLVWxvN1RNdXl6M3NS?=
 =?utf-8?B?Tnhpc1Iwd1dZNmN1NDd3VzU0MEJSRzFocjFucTFjZjR1cU5rQnVTYzFDUGtv?=
 =?utf-8?B?OUtaR2FDQ1RMVWN6bHFLdGI5cFB1clpra1ZlYmVPVFV4VUlpS0p6R0x6SWls?=
 =?utf-8?B?M29qcFE0SUd4WVl3Vi9UZGRaNWJGeEl5UXlUMkovMmY0cDFFT3NoUjc1Y2JB?=
 =?utf-8?B?SHlDaHd0RWVJOFJlQ0U3KzlhV3pOcmJIL2h4eDAwUGF5M1R4Z2tDd2UveExZ?=
 =?utf-8?B?QkdmbWJVRkhJU2tnOUYyRjhQN0lxNWNiMUdBWnZxbTc5R1RYVUdvS2E5TWZt?=
 =?utf-8?B?SnBqelU4VUNublVFVzZsZmVvYTVJSEFlTHc3MkJiQkt2Zmh6ZDVSU1h3Nnhk?=
 =?utf-8?B?V3pUanlvU3YrVFIxRzVXY1F3UE1IVEdJemJIVnBmQTdtMkJ4b3JiZjZDTmZl?=
 =?utf-8?B?L0VmSko2dWdST28zYk5uQWJ2WmZlakJKdXBjOXRJU2xSZzlwM1lRbjZ2L3ZB?=
 =?utf-8?B?dlpKWnpXdWpQYSs5R2M3Y0JrY1YxaWx6eHhMZUNjaXJEazZrRHNVR0RsUWVE?=
 =?utf-8?B?bTZ3ZDBSckNiNFB4L0VneXhEaDV3WGdURUN2S3IxRVlPMm54RWFJSWNSbHZw?=
 =?utf-8?B?MG45MTBHTTY2NWNweXZNc2xwcDcra2RLdXZ1YlVOQUJEeWdrMGJnaVh4Z04v?=
 =?utf-8?B?RExrdzJHYU1kTlRrY2N6UXByQ29WR0NOeVlQTGIrRkt3QkowbU9EZEFoZ1FE?=
 =?utf-8?B?cHg4T2x2OVlMZjNpMmxrdEM0cHhEbzBQSmRnYjlpdkthNTk3NTZyQkVVWDJI?=
 =?utf-8?B?U0krUEIvS3JZSFVscXcwSk11V1U3LzdVZHp6clpZbkMyR0lIQlB2Q2xlZi9H?=
 =?utf-8?B?VVdPMEp0ZElyUnUzelRxZFZ6bXAwNVp0R0ZiZHYwbHAzbWVMWGRWVFE0OWVq?=
 =?utf-8?B?d21QNTg2VStkUVNvYU5jZzdTRE5kUmlkd1diYmFSSGNmcTlVeldIZlJxc3NQ?=
 =?utf-8?B?emZFeUJ5VDJ4TllSTm80QWFzNHgvR1QwS1dIak1zRW5JRzVHdTdpMmFNR3Rv?=
 =?utf-8?B?dGt6dHlLWkd6K21lZFZJR2hUK1dlZTRSWHVTa1pHZlpYMjlKRmFqVVh6VVlu?=
 =?utf-8?B?NnJ0OWxZam9SRElTVER3cExjbXNLM2E5SG5VdVJreHZSLzl5SXVkRmJGRFU4?=
 =?utf-8?B?TjJ0aTJJeisxRWFaVGxWc2NaRmFmU2xRYlgvMEpZVzhFdWFNZTBGcDRCR2xz?=
 =?utf-8?B?aTNTU2ZCWGgxSGRya0hpdUhocDRUK3gzMzIzQksrdjVLL24yOGpRa2cvRk9k?=
 =?utf-8?B?ZlVJYmx5QUljVXQ3Mjk3cVZKU2pkb25EbWFlQnVtcFZlYmtuamR5clN3Yzd2?=
 =?utf-8?B?Zkt0dlhQL0xqZHJncSt3aXdFaDg5RGxBK0NwVWZQM2hGMUhBU0UwMGYvMStr?=
 =?utf-8?B?RzY4QUVwNUpTY0lSckYzamVXaHBPY2tNYXUxSGlRcUtYRVFvbHZ1bjIrNmhm?=
 =?utf-8?B?M1ZlYVBJcUtPUHM2NDN5QnlTSHlxeXlURUR2TWs0SFFCNXV6YXA4TktaeEJL?=
 =?utf-8?B?WThPMG5hN1ZlMnRJam9UNndDMnJ6L2dGa1pKSCtncTB6QlBES3lhZlJjaTRN?=
 =?utf-8?B?VytYK09kS0QzVzNjbk1DZDhRSVVXRExldWZjNGwxSTJvcEpNQWkwZlpMazhH?=
 =?utf-8?Q?sf5QyVIoui1m21SnGN2m4/Y+v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb5aa7e-bf83-46ba-e0d5-08da95583d1c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 07:19:04.4915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvZtrTdwOM7bmoCZKB5Z19XEZytpIgkwiRL9po8IubYe6iJPwq00TiH0GSXMfgZVfZwTqUfW43wcW2RjY8Xp5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/13/2022 12:45 PM, Takashi Iwai wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, 13 Sep 2022 08:58:18 +0200,
> Mohan Kumar wrote:
>> Nvidia HDA HW expects infoframe data bytes order same for both
>> HDMI and DP i.e infoframe data starts from 5th bytes offset. As
>> dp infoframe structure has 4th byte as valid infoframe data, use
>> hdmi infoframe structure for nvidia dp infoframe to match HW behvaior.
>>
>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> Aha, so this affects on all Nvidia devices, not only on Tegra, but
> also on PC?  Then we should put cc-to-stable definitely.
Yes, The HDA HW design was common for dGPU and Tegra.
>
> (No need to resend, I can put it locally.)
Thanks!.
>
>
> Takashi
>
>> ---
>>   sound/pci/hda/patch_hdmi.c | 23 +++++++++++++++++++----
>>   1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>> index 6c209cd26c0c..9127dd1b1a9c 100644
>> --- a/sound/pci/hda/patch_hdmi.c
>> +++ b/sound/pci/hda/patch_hdmi.c
>> @@ -170,6 +170,8 @@ struct hdmi_spec {
>>        bool dyn_pcm_no_legacy;
>>        /* hdmi interrupt trigger control flag for Nvidia codec */
>>        bool hdmi_intr_trig_ctrl;
>> +     bool nv_dp_workaround; /* workaround DP audio infoframe for Nvidia */
>> +
>>        bool intel_hsw_fixup;   /* apply Intel platform-specific fixups */
>>        /*
>>         * Non-generic VIA/NVIDIA specific
>> @@ -679,15 +681,24 @@ static void hdmi_pin_setup_infoframe(struct hda_codec *codec,
>>                                     int ca, int active_channels,
>>                                     int conn_type)
>>   {
>> +     struct hdmi_spec *spec = codec->spec;
>>        union audio_infoframe ai;
>>
>>        memset(&ai, 0, sizeof(ai));
>> -     if (conn_type == 0) { /* HDMI */
>> +     if ((conn_type == 0) || /* HDMI */
>> +             /* Nvidia DisplayPort: Nvidia HW expects same layout as HDMI */
>> +             (conn_type == 1 && spec->nv_dp_workaround)) {
>>                struct hdmi_audio_infoframe *hdmi_ai = &ai.hdmi;
>>
>> -             hdmi_ai->type           = 0x84;
>> -             hdmi_ai->ver            = 0x01;
>> -             hdmi_ai->len            = 0x0a;
>> +             if (conn_type == 0) { /* HDMI */
>> +                     hdmi_ai->type           = 0x84;
>> +                     hdmi_ai->ver            = 0x01;
>> +                     hdmi_ai->len            = 0x0a;
>> +             } else {/* Nvidia DP */
>> +                     hdmi_ai->type           = 0x84;
>> +                     hdmi_ai->ver            = 0x1b;
>> +                     hdmi_ai->len            = 0x11 << 2;
>> +             }
>>                hdmi_ai->CC02_CT47      = active_channels - 1;
>>                hdmi_ai->CA             = ca;
>>                hdmi_checksum_audio_infoframe(hdmi_ai);
>> @@ -3617,6 +3628,7 @@ static int patch_nvhdmi_2ch(struct hda_codec *codec)
>>        spec->pcm_playback.rates = SUPPORTED_RATES;
>>        spec->pcm_playback.maxbps = SUPPORTED_MAXBPS;
>>        spec->pcm_playback.formats = SUPPORTED_FORMATS;
>> +     spec->nv_dp_workaround = true;
>>        return 0;
>>   }
>>
>> @@ -3756,6 +3768,7 @@ static int patch_nvhdmi(struct hda_codec *codec)
>>        spec->chmap.ops.chmap_cea_alloc_validate_get_type =
>>                nvhdmi_chmap_cea_alloc_validate_get_type;
>>        spec->chmap.ops.chmap_validate = nvhdmi_chmap_validate;
>> +     spec->nv_dp_workaround = true;
>>
>>        codec->link_down_at_suspend = 1;
>>
>> @@ -3779,6 +3792,7 @@ static int patch_nvhdmi_legacy(struct hda_codec *codec)
>>        spec->chmap.ops.chmap_cea_alloc_validate_get_type =
>>                nvhdmi_chmap_cea_alloc_validate_get_type;
>>        spec->chmap.ops.chmap_validate = nvhdmi_chmap_validate;
>> +     spec->nv_dp_workaround = true;
>>
>>        codec->link_down_at_suspend = 1;
>>
>> @@ -3992,6 +4006,7 @@ static int tegra_hdmi_init(struct hda_codec *codec)
>>        spec->chmap.ops.chmap_cea_alloc_validate_get_type =
>>                nvhdmi_chmap_cea_alloc_validate_get_type;
>>        spec->chmap.ops.chmap_validate = nvhdmi_chmap_validate;
>> +     spec->nv_dp_workaround = true;
>>
>>        return 0;
>>   }
>> --
>> 2.17.1
>>
