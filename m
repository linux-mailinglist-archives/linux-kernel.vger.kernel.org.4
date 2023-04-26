Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9346EF7D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbjDZPkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241393AbjDZPkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:40:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BC96EAD;
        Wed, 26 Apr 2023 08:40:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXE+kqGdge+tdcaFF6UOjQDTY7KMY1EY+5jVINh9svzT+PwFMhuUt/e1dZEcREc678MZyd4LeiGp4nqbIouDymWzlHKtwCFHNWbBHXX8goedq7D/0D62rWTfIPaU/XlkwmleSPx6KKymQ+B1quQ8+iSLpFAHr8tY8GaPh2OUWu0w/lIujnK6958ggRm0CyDzI2zvfLt6RXszk6ta/+qtY0s20XavSxhb1sHDCIXI6+TEBeTzQfkAeE70bsVn3a9LfGj73RTKE2zDvPGpUvowqwHzVDp8Ij8JVwAaLjseRO8YtJPYISyWW3HjbLZ/CTgsh31ZzNpm2uKXGm8wZkjKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOAf+WLlB8jpJSg1eGPGo/nio8zoogLlOiYGm55tl0Y=;
 b=Y9hWdGo0rBm7sr6DlL+qwLfgIMMbeRQpl/5atMOf4sud6bfYsvCGg1HkrK/FEzGZ6Nur+iwB9ZRR0j0UBVRWFFGXF5TKqMKOfsp8wsXql1+HEDS7l4RvvM5daXqqY1WSo4laXEHFp7qoWS+MMjtCIKt8rybFH+UKcdYekUTI4aDUmrLXtZO6yiZOmTSPDgCCmtytZvRr98/S7VugtirmE1YPAm68iTSZ9zbWxPnA1hpGvsmIj6hgCSEYSCOHTXjhq1gqxgBvFjCbKAhOyPP5fjctjPn1/sql10LnrPOf+TH/1e/FUxB1gepfN24DuJkqZqun3pw6oZylahrDpbZVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOAf+WLlB8jpJSg1eGPGo/nio8zoogLlOiYGm55tl0Y=;
 b=fZ901oTJ7JqPHaYIf2ecGOkHtpFZJ/f0iNN5KhQjLfN99F95SNv7Z/najsbZYcsKHtznU9UVtOx9qh4Cl2yihKq1JZz5AcWqKYMefZoYWtN9zrSf/9WUTpNK9n7lTtOD+Zs2RJxzR4sL7S2FyueVhNZGkuPcMVfi0QM9rrTq8Jw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 15:40:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 15:40:25 +0000
Message-ID: <ae3a6a20-c7e7-563f-baf4-2e744fbc5798@amd.com>
Date:   Wed, 26 Apr 2023 10:40:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] platform/x86: hp-wmi: Add HP Envy special key
 support
Content-Language: en-US
To:     Jonathan Singer <jes965@nyu.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20230426152139.1692-1-jes965@nyu.edu>
 <20230426152139.1692-2-jes965@nyu.edu>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230426152139.1692-2-jes965@nyu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:408:fe::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 3399f357-ebb7-4982-dc86-08db466c8d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLY8HukjD/lXTxSgOgybztUyQB3fuoh8YBvJn6jB0euweJNLsVrDIfNIdoGB3kQibtj+W+6hjC29WJHuHqNAq8S2p3290LT+pDdjlpG4HRBhkxDdxK8OpYev7sctQ0vFDC3Wm52ebHRjM4doSXHuU0jGeyvfGsdACiXrgdhYKNiHGpsN7PjueGiOXpHcAdxhFxWG/eZQ93i0w3ItA0zfpRK7qrLA1AzT3RMp8cshMXLHNhaduPW2K4yhdM4RUKTSClsicJUDsnKRX1SykZxbYybmkfn/+ocGfQFKzVs9f3pJFmdfnQQbjFG2+6Lbo1gbSjZ4HCzqDbgtIwbQLkxt/cl7jyDDdL9kHuT3W9Zny3DsVCH5e03H7zWsskj1d4+i4YTRW+hFPUpgMuxnntpIgK9sBB1mDH4YqlWMtTWi1h2XloultXO/BzXCIc2rl2tUgITK1TeY0Yre1Izxk98SJn3lguOi84jWqyya0TiyvtcojPKsNZrzyb+9o7kUXiYkTFYnT4igavCSXidaMJufl98pChlLVkKZr6Y/MlKInPb/uEcnOcQwQWlCU93vLGzp5J/Y3uwWJlvWklnEfg7LJlcd6g/qFGJb23SQ5vtMZYaXPM1ADzMn8PzVxMOtp8ArdSdEJVaPrBT4UK7z5r4nEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(83380400001)(478600001)(6486002)(2616005)(110136005)(54906003)(6506007)(186003)(53546011)(6512007)(44832011)(5660300002)(36756003)(66946007)(31696002)(38100700002)(2906002)(66556008)(66476007)(4326008)(41300700001)(86362001)(8676002)(8936002)(316002)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEtwUUNnNTZaT29icmgyZndCQ25WOGFYbnBqQXVMalpIaSt0RmRyMmpmV3h1?=
 =?utf-8?B?L1JSVWJ3b3ZhMEVVN3VURkMwV2tzc2JEZThFQXV6Y0dVV3lrd29iN3NPSzJY?=
 =?utf-8?B?M0FuZWlyNHBxNUFzNkZ5ZWtQakpDM0Y3SDB4T0pBWklFbTFFREdRbXZKRks2?=
 =?utf-8?B?SFpIZk5iU0kvVFV2dEJrYjc5aVZkQUYyMDIyMGN0MjV0a2lRcmEzcjBNZUc0?=
 =?utf-8?B?bmllREdheWcrQzN0NVdQQ2VWNGlPeDJvRS9TZjA2N2twY2tERytQSit1VHU1?=
 =?utf-8?B?MEQ5Nlh5VTVwMEJ3UWJwNjFGdUIzV1BWMUtDdCtZUXJpdTdRN2FVeTRGSlpy?=
 =?utf-8?B?NmJEUExNTXZxT2tDTWc4Y2ZzMVBWZm5oSXBNMjc3UEM1SmRzRUJocGJlSFph?=
 =?utf-8?B?NEpGN0pyMnN1ckdyZVorYlFNaGY5cTZTcWhUbTlhRjVYWTh1QkEvWTI0dGdS?=
 =?utf-8?B?QzUyUDFMMEYwREpjZUdlRk9PYW41S2VBZzl5c0VKV2l3b0M4NlhPeExQS3NU?=
 =?utf-8?B?RmxYdmVxV1M4eXB2TG1sNlVza0NPcEpXMEp3SlhIL3podno2YTFXSEJQcVFL?=
 =?utf-8?B?Y1VoTDFweUpIeFVnbGFZQVQra0l2MzJ2SjJyQWVQNE9UcjhzSWhPLzQyaWwz?=
 =?utf-8?B?VEVQdVpzNGNnT3ZURlZOTWY3QUtCSnR3RUFvMVMvVFh3WVJZeTEyMHBsa0lD?=
 =?utf-8?B?QW1pRnN0NHluL1JUNzVEVnkrbW43M2x3TWVJZ0xXN2lacDlDNGRuQ09zSjhj?=
 =?utf-8?B?S3pGSUg3MzJDUXIwa2RaKzBNRUE0cEY2TGMxdDhzK2VUdFByc0hMOU1TUkNl?=
 =?utf-8?B?c1NKODlpay9SWGszUEVPcmdTSGdhbEY0WU12d2FWTVdLNWlYUVh0eUhGZGdH?=
 =?utf-8?B?b01jcFJHU293UWlVZkVKYXErK3V2bm0vcGdBMmhCNzczNmNZMUxuR2dZamNy?=
 =?utf-8?B?ajkzbHNKUFZjcEdVdmVvNDMxY1NiOE5taUppNUFJMFBLNTJZS3haaHhwTXJU?=
 =?utf-8?B?SFZKMi9WMEZ1c0Frb1NUVUpNVU9mcXFqZGxRV0RFT3VHcGIrTS8yRnB4RkpK?=
 =?utf-8?B?T251TkdYQVc3ZlRXaGJPc09uSks4YUFTQmdVcGpyNVlJeWtlcHJ6NzhNVzNj?=
 =?utf-8?B?a0E1U0ZZdUFIUGhUREkzS2VmS2cxUDh1aGdtODdtd2lCRUMvS0luSm1rbHRX?=
 =?utf-8?B?b2lTWG5uMzh2RzlaazQ3bk5abmx1L1dCNUlTdlhrWmpSQnZyMXRiK3pBMjNj?=
 =?utf-8?B?U0RLOFpZakNFOURKM0RRaSs1MmRuL0NGTzZZWDVNcTVMb0h2YTVxcVZhUDRh?=
 =?utf-8?B?VEFmU3FMTE5xNUppb2RWUmI4ODI3ck1DNUE5R0pKUW04ZklYQkZEVU9UenZJ?=
 =?utf-8?B?blhZWGtMa1lRdW1VdGtIRENpelk2SlozQytiV3piQVZIRXJvaUR0cDRCcGRu?=
 =?utf-8?B?M1AyWGgvdTB1azJCa2V1YXdxM2wrMEQ3MzhPR1UvODdCQ2dGZHkrMU9WRks1?=
 =?utf-8?B?b2tjRVprK1A0RDRsUVlpZyszRjhhY2hJWEk0T3lhSG9qWEpRY0FhU2dzMlcv?=
 =?utf-8?B?TEdJN081Y00yNzFNdm42dWgxVFFaK0hGK1VyS3BxWW4rS0NJLzg0WjJGSkZH?=
 =?utf-8?B?b1MvOE5CMjhHM3JjV2FNbE1JajduU0luc2IyK3dDYmp1TTNDSUlFWC81Nlpx?=
 =?utf-8?B?TCtnVGIvTFRVUG84RWF3NXdQNFZ1M3V3ZjFxNFVzc0tvekJIRGFQSm9rQ0g3?=
 =?utf-8?B?cTBUdTFvT3Y2UGh5Uk9vejY3dldLZld6cUhxd2t1NDdWV00rSVREaDBqS25G?=
 =?utf-8?B?bmVkNCtSL0xFZUVGaUN2YTlNelpoT2hGRzBUdmYxRVVmbi8wR0VWdGVnZmky?=
 =?utf-8?B?OGJGcjlLckNlb05kN3Y0NFl4MXcwNk55OVo0RGNjVU9XKy8rc2h6YVRKL0Ez?=
 =?utf-8?B?QUZoclNOWU93UjFiU3ArV1NGTnRFdTRHdE5LVVlPWmkyK1NVVDRNby9lMHVz?=
 =?utf-8?B?TDVhSm9wM0I2UTl0dTVtazRGMEtESzlCV0dtWVVmOUUrMFFjVmErTmVabDcr?=
 =?utf-8?B?dnkwYVJpNmo1MjJIUEpFNWpuMittbm9SbE4vRFdwMXJVQXBnSzRwTkVJMEsy?=
 =?utf-8?B?bjRMemd1VFZXaVg5WlRKUHFNSmdVOE1wNlpTdWVPUzZ4SlQxeUdBMmlaeW5B?=
 =?utf-8?Q?Gym7YqH7VrlNKRNdokp4Vm2klQRYGKdLRRelq9Yy5eei?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3399f357-ebb7-4982-dc86-08db466c8d99
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 15:40:25.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dT1Pa5cVSQnv2LWMtuCCGFA3WX+efMMSt0zj4RrcIkS3q2YJNbWILoYLjk0EuhhP3Rluwo4YP+ZwFHXD1/NTHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/26/23 10:21, Jonathan Singer wrote:
> Previously, some support for certain keys on the HP keyboard has been
> added already in commit 3ee5447b2048 ("platform/x86: hp-wmi: Handle Omen
> Key event"), however this as tested did not allow even the fn+esc key on
> my HP Envy which uses the same keycode on my HP Envy x360 laptop to work
> --the keycode rather than being passed in as a separate int from WMI, was
> being passed in as the event_data for the HPWMI_OMEN_KEY event.
>
> This patch, as tested was able to properly get the keycode for fn+esc,
> and for fn+f12 which is supposed to be a programmable key according to
> HP's keyboard diagram and is thus mapped to KEY_PROG2. The fn+f8 key
> combination (mute microphone) was a standard HPWMI_BEZEL_BUTTON key,
> however it did not previously have an entry in the sparse keymap. This
> patch preserves the original HPWMI_OMEN_KEY behavior for laptops that
> use it by only taking the keycode from the event_data only when the
> event_data is nonzero.
>
> Signed-off-by: Jonathan Singer <jes965@nyu.edu>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/x86/hp/hp-wmi.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index a7fb33ac49b8..399163b4aca0 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -212,6 +212,7 @@ struct bios_rfkill2_state {
>   static const struct key_entry hp_wmi_keymap[] = {
>   	{ KE_KEY, 0x02,    { KEY_BRIGHTNESSUP } },
>   	{ KE_KEY, 0x03,    { KEY_BRIGHTNESSDOWN } },
> +	{ KE_KEY, 0x270,   { KEY_MICMUTE } },
>   	{ KE_KEY, 0x20e6,  { KEY_PROG1 } },
>   	{ KE_KEY, 0x20e8,  { KEY_MEDIA } },
>   	{ KE_KEY, 0x2142,  { KEY_MEDIA } },
> @@ -222,6 +223,7 @@ static const struct key_entry hp_wmi_keymap[] = {
>   	{ KE_IGNORE, 0x121a4, }, /* Win Lock Off */
>   	{ KE_KEY, 0x21a5,  { KEY_PROG2 } }, /* HP Omen Key */
>   	{ KE_KEY, 0x21a7,  { KEY_FN_ESC } },
> +	{ KE_KEY, 0x21a8,  { KEY_PROG2 } }, /* HP Envy x360 programmable key */
>   	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
>   	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
>   	{ KE_KEY, 0x231b,  { KEY_HELP } },
> @@ -847,11 +849,20 @@ static void hp_wmi_notify(u32 value, void *context)
>   	case HPWMI_SMART_ADAPTER:
>   		break;
>   	case HPWMI_BEZEL_BUTTON:
> -	case HPWMI_OMEN_KEY:
>   		key_code = hp_wmi_read_int(HPWMI_HOTKEY_QUERY);
>   		if (key_code < 0)
>   			break;
>   
> +		if (!sparse_keymap_report_event(hp_wmi_input_dev,
> +						key_code, 1, true))
> +			pr_info("Unknown key code - 0x%x\n", key_code);
> +		break;
> +	case HPWMI_OMEN_KEY:
> +		if (event_data) /* Only should be true for HP Omen */
> +			key_code = event_data;
> +		else
> +			key_code = hp_wmi_read_int(HPWMI_HOTKEY_QUERY);
> +
>   		if (!sparse_keymap_report_event(hp_wmi_input_dev,
>   						key_code, 1, true))
>   			pr_info("Unknown key code - 0x%x\n", key_code);
