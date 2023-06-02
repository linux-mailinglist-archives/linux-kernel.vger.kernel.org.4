Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D3071F937
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 06:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjFBESM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 00:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjFBESG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 00:18:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE8198;
        Thu,  1 Jun 2023 21:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrCvs10+JcZ4SECjN3FEQfRo1rGQhMJ4n8e3D/LPznExoRPdfG/LiF9mpkczdPGGJIGmxqtZlwei6rafWYLqYBqHmzCDYpU0PCBNAEd2GKdQEZwAM4AYlxDwKQd5tn9Yxn1qgf/XW/jXlg2pthxcs6XMArOO9M5blwtj6si+e3uDuCof80wTIt4v0sBkonZFsFeyJKyWmiUYrotUynTyn6ivCEAW0vBmg7JQYIc6poKtrCGkLriCxlzzrLQ6CrMu70iF+RDcXu9au8FGl1aP4b2Q6/F9WG7KCIsZI/yDRg5Obz0jLC+ixuucZDX1z1EJdU0o/0DpU4b8ackmMubvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViTpHx1qELzSawYG32xBPz6fHjg6oDeurv2aLeX6hQs=;
 b=QXMD1jrg9brwP1pkKgs/8QZV9syjo9D2cXBJNFOSWKop8Dyo3vXP1Y2oyEbtBRuam18tkQ9ULc7o0Bk93xfGYctUeCd5zmsu6wvWntCeXqWFVUeGkmrGsRNl2iWhbLrsc24J3wCI4Jma1wzt38dx5PxK8P1sFUvJt4KFuHFB31OYHyVTR0j/9ZmBmBp9ja/pTrrvDdkIl7MgeLQiCJaFCKSupR00Sa5CXm77WdN95QwZHhnroeAHrBFSC7zHhzyfFrT2JNimF5efVba8oHAtsJ6PtKGj5LPkNZlYmGBJAsgbSvsK0/StMoZ2X0PIIw4znJ2L9UQkbmZIDj3//2jxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViTpHx1qELzSawYG32xBPz6fHjg6oDeurv2aLeX6hQs=;
 b=yqmF6OnnV4zimGcaHrLvJTWpBwxKOLmDGWmZu+Naq40bilrDeVD4kKxmYvviOrXXcuoBxs4dl+JGModThYkwSeYjyoO2Q0tO98Jrowo5wGyiqHS4ElS7U9XPi62dDB22lWv4ULZbDZnzy+4m/TZDbVHmEQlfl4XD73Vgb9noaf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 04:18:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 04:18:01 +0000
Message-ID: <67871ad9-d3d9-51f0-a93a-81e4d6e44eea@amd.com>
Date:   Thu, 1 Jun 2023 23:17:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] ACPI: x86: Adjust Microsoft LPS0 _DSM handling sequence
Content-Language: en-US
To:     david.e.box@linux.intel.com, rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230601233953.1332-1-mario.limonciello@amd.com>
 <d1e0d5fc837753c292f78a5357fd9ba4531f06d2.camel@linux.intel.com>
 <b0e0abc0-26ba-d104-ff73-b89745510be8@amd.com>
 <05162d36a009a1669870a2c82bd0b2b65458b244.camel@linux.intel.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <05162d36a009a1669870a2c82bd0b2b65458b244.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0071.namprd12.prod.outlook.com
 (2603:10b6:802:20::42) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: e70f5ebe-64f0-43d9-25c6-08db63205aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oP8cs16eMzFBiTVjXowBxGYZ6zsbGxoEMRI7WuzAExQNlk47SBDxI8fgsz00HsGqDxjnyHNWYNgVn6pNNIF7PedaBBHmWUVGvs74YMmaRDif0D5euRGYtWBGc6WqOC3M/On0h7sItlWC8BWazgz05izYKxhQK6GUmUKck49MP8XSeepEQMyaAo7+x6D1qfYg+UBlbXFF+sNdXt6B/lcm/8aNJoVvVG1lnpqIgECpxyq74h4+k7eGWsZYDSpQCUKJsgY/cJqQU8H6lCl+xTcrboPLODT0RipQ6m4i74Twzz7o9oSf/YhIUUYSNv+Y7A5oryxwad7h640XtDikquk4jYduGq+kkX1BADBuF6rkpKRDylAjlk/eBbRM024N3p5HJE/0PbGaADtvUvGwgpsrWTA7sMb5tu4+7JRyfTAAFULcm+SerqqCCQBbiTiEMAJcp6AQh0Zb7/ekvJKWgNFgSKMtmpCc0SDhvAQElUq8/aI0S6aOPj9wixeIFt/1xHZfbYOEvjo1+TPXI+po/vw09+FuQomP+vViluHHiV/FLtXKNTL0z8cWVIHfQ9J3ds8eeMVMJJrT3erTZwgyKwnXywV3VRoH0CzKT4Kl+oYaYTF/1JtyVipPUdc2jd6MnmG5xccxk5/I8AfKqPoZa7TNWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(47530400004)(451199021)(83380400001)(66556008)(66476007)(6486002)(6506007)(53546011)(6512007)(966005)(2616005)(478600001)(45080400002)(52230400001)(186003)(86362001)(2906002)(5660300002)(31696002)(8936002)(8676002)(36756003)(41300700001)(4326008)(66946007)(38100700002)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTZmKzFWNFYwT0RNK3pZdzl2VW4vSnVJYTY3Q1pjZW9veHp0SlBpNHB6OEVo?=
 =?utf-8?B?Yks4Y09jZ2xpUVdLYVgzNHFJZkZOTWtaTHhmSVlwUkh3ay8rZ0F0N1lEOFFk?=
 =?utf-8?B?VnBBby9yTlQydlNLY0w1dFRYNFhtRENxbFdLRFZTTUZxN0NrUENJRFlGZENz?=
 =?utf-8?B?NVkyN3hjeW5VV0I2S1d5SDdxTnp1ODRicjJudGdrSVZBSlhoNzVEQVFYdGIx?=
 =?utf-8?B?ekFTdkZkL0dEa1MwMUV0QTQ0czVWcnJRM2VFcXY4Tm56bVBoaUVrcjRBb1lP?=
 =?utf-8?B?cnhJRXVPTDV1RGtKU0diZkZ2S1NmMkhQTnZXNmNBQWR0VDhpM0ZKUk9obGlr?=
 =?utf-8?B?M215TU1XbERuK1ZETVcrTGhTbzBTSG9KNDZzSExxZ2RzaTlFTFpxSnVEelox?=
 =?utf-8?B?T3VpK1BHTjB5b3VDamdQQS9IM3N0SEs0Nm9BclArUnBzSDgrNTVwelJYZ0Zx?=
 =?utf-8?B?b0ZJdGxvM29lalJFZGttdWtaR1RORUI0S2E5NktDMXduRUMzT0kvTjRDTWFT?=
 =?utf-8?B?RmJ0REIvNndkQ2p3VTdLVUZya0cxbXUrTytGWm5FT3hKYjZ4M2pLcU1Fb1lF?=
 =?utf-8?B?YS9KalVBL09vYzFPUFZrYTZRbFRKWUtmVjE3VDJ2NmNJelZUZHVzcjd2bjE0?=
 =?utf-8?B?RjZkZ3cwRExvbWNJVmQ0aTNlNUc1TTgxdmE3Y1F1WXNlZFhJYkxKNUhMcTlT?=
 =?utf-8?B?cmhPMWZVUStoTTVGVTRCaklsMUx2WjVONzYyM2Z6TlhWb0VyOEJ5cDlkYjVh?=
 =?utf-8?B?Tlc1b0NTVVRZeTd0QnRHVzlRcGFNdmFORVNRSUZWcHJwbFJPWlJNR3k2Z3lE?=
 =?utf-8?B?UjVybnZyZW54RUxKdURkR3ZSRnNTSjh5cGh1ZlFqZ0pyOVFZQm8yMHRaRlVF?=
 =?utf-8?B?N0JZYVlHbkxUN0hPM212NkFpMW85Q1p4UlBBdXNHUHBLOVJLM2hyd3hIWmNo?=
 =?utf-8?B?L1hLeUxQVnlQT1VpeFRSSi9YbDlRcElkN1ZYaEQ2S1R5eW5VbVBUeWtXYnAz?=
 =?utf-8?B?TmdzdGRqZCtFdkJxY0dEUUxkNjJGSGJOMy9nVGN4bUozOHJkN3Q1MTZZSUpv?=
 =?utf-8?B?Y1NQZmRwVUppRWVMVGx0K2NlSUNrY0pLSnhFMko5SW4zLzZOaFBlTjcvanVs?=
 =?utf-8?B?RE5zTm4zeVhOc2k1TlJaeU5HMFM2SEtQc2dLNVZ0N2V6dC9vSGp0bzJITFpJ?=
 =?utf-8?B?U0oxTEJpNUdkVjFBRVU1ZXJXdDBqRGgyZXkrMDcvSGR4Y2pxd0xHM2VONWlV?=
 =?utf-8?B?VW9VQ3g2azlPUUtpc25TbENPbVJkTVIzSUtvc1lvS3ZXUm1JZ2tBQldaTEdx?=
 =?utf-8?B?NVYxajhsMXUrdThZK0xrOERtc2xtWDJYL1A1Qm1zNlNhSDZhcThPLzhCNlZR?=
 =?utf-8?B?U1JFL2RRaVBWWm0xUHFLNW43TVJNL1B0N2JrVEsrU2NyK2dzYXRqOWJNTUpD?=
 =?utf-8?B?R2dLMnVQSDA0RWlxeGpWbzVnMTZOcDZ3MVpjQkh2S2MxemdhSUswclVLVUh3?=
 =?utf-8?B?SXRlRC85dTRnTUJ2Q3pIK3kvaEhiWnlKSHRWbUJaUVRoM0Rjcm42YXFmRG1X?=
 =?utf-8?B?ejhKSEs4V3BUSUpIWTYzbjNJQU5yMDV0NE50Qm44NlNlRG4zYlBEZHRKYVBm?=
 =?utf-8?B?bkhSM3h6d3poZnpocXdpS0JpY0F3M2dZZ2V0K2pNbGpxT1ZUYXhsYlBFRGRr?=
 =?utf-8?B?cGM4M1BpcWFES0h4SzdXUksvR3doUS83NStZMzdaMWFyQk1xUm04SmJhMHlF?=
 =?utf-8?B?UExvMlhZM28xMTh5UnhWd0o4RlU2MW9EYU5DZHA0RnNScGlCbG15aktZek0x?=
 =?utf-8?B?Z2RueXI4QkF4ek80QnViOWxDQXBqMnlRbnpoY3pKakQ4aWxDVWVCc3ExYm5n?=
 =?utf-8?B?aG9rbk1wUjhOSUxwYUJqc3NtSG1leTJ6THNOeU44TEhwL21ObmYyL1A2cGFh?=
 =?utf-8?B?QkN3ZmpRNHo0RDhOTEFqbCtoY1ByN1c1N2VpbXZmWFpTdmVXR0hZL0hpVUdl?=
 =?utf-8?B?T1IwdmhnT0JLTjZSUkQ3UW95dVFSSDQ4OFV5OUpIUHZBRmsxKytkMkJTakxK?=
 =?utf-8?B?NFVZeDJ6VnRiR0VyK0s4c1h4SDhETENpVVc3d0tWeHB2WkRjNTFYaFJTd0N1?=
 =?utf-8?B?RTdhR0hWNmdmb253VXFOWXY4U3FncGx5M2djTDlwaDBOdnRqMGJzMzNGWVVV?=
 =?utf-8?Q?20ut868Zeqf77I+Xs4j9uYUyFO2o1TrXYwKUNa2VH1ik?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70f5ebe-64f0-43d9-25c6-08db63205aa6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 04:18:01.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WneLIkw7iHymuTCYStqsef7kVtmhX78Y5SMmnqeQNHCP5jfghv9WVnWTq4qBSFedAV6Q9yg8yq2kWxhToLB+/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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


On 6/1/2023 10:06 PM, David E. Box wrote:
> On Thu, 2023-06-01 at 20:46 -0500, Limonciello, Mario wrote:
>> On 6/1/2023 8:31 PM, David E. Box wrote:
>>> On Thu, 2023-06-01 at 18:39 -0500, Mario Limonciello wrote:
>>>> In Windows the Microsoft _DSM doesn't call functions 3->5->7 for suspend
>>>> and 8->6->4 for resume like Linux currently does.
>>>>
>>>> Rather it calls 3->7->5 for suspend and 6->8->4 for resume.
>>>> Align this calling order for Linux as well.
>>>>
>>>> Link:
>>>> https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-states
>>> I didn't catch the ordering in the link.
>> Yeah it's tough to interpret from the link, because the picture at the
>> bottom
>> is missing annotations.
>>
>> Basically if you look at the picture the blue part is the screen on/off.
>>
>> The green part is "modern standby" and then the little "humps" are LPS0
>> enter/exit.
>>
>>> Was there any issue that prompted this
>>> change?
>>
>> We were debugging an unrelated problem and noticed the difference
>> comparing the
>>
>> BIOS debugging log from Windows and Linux.
>>
>> If an OEM depends on this call order in that code used in LPS0 phase
>> requires
>> changes from MS phase I could hypothesize this fixes it.
>>
>>
>>> David
>> BTW - is there interest in supporting the Microsoft _DSM GUID for Intel
>> side too?
>>
>> It's an incongruity today that we run both AMD GUID and Microsoft GUID
>> for AMD systems
>> but only run Intel GUID for Intel systems.
> There hasn't been a need yet. Rafael have you look at it?
>
> David

AFAICT from Linux side it should be a one line patch to drop:

         lps0_dsm_func_mask_microsoft = -EINVAL;

>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/acpi/x86/s2idle.c | 14 +++++++-------
>>>>    1 file changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>>>> index e499c60c4579..7214197c15a0 100644
>>>> --- a/drivers/acpi/x86/s2idle.c
>>>> +++ b/drivers/acpi/x86/s2idle.c
>>>> @@ -485,11 +485,11 @@ int acpi_s2idle_prepare_late(void)
>>>>                                           ACPI_LPS0_ENTRY,
>>>>                                           lps0_dsm_func_mask,
>>>> lps0_dsm_guid);
>>>>           if (lps0_dsm_func_mask_microsoft > 0) {
>>>> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
>>>> -                               lps0_dsm_func_mask_microsoft,
>>>> lps0_dsm_guid_microsoft);
>>>>                   /* modern standby entry */
>>>>                   acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
>>>>                                   lps0_dsm_func_mask_microsoft,
>>>> lps0_dsm_guid_microsoft);
>>>> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
>>>> +                               lps0_dsm_func_mask_microsoft,
>>>> lps0_dsm_guid_microsoft);
>>>>           }
>>>>    
>>>>           list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node)
>>>> {
>>>> @@ -524,11 +524,6 @@ void acpi_s2idle_restore_early(void)
>>>>                   if (handler->restore)
>>>>                           handler->restore();
>>>>    
>>>> -       /* Modern standby exit */
>>>> -       if (lps0_dsm_func_mask_microsoft > 0)
>>>> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
>>>> -                               lps0_dsm_func_mask_microsoft,
>>>> lps0_dsm_guid_microsoft);
>>>> -
>>>>           /* LPS0 exit */
>>>>           if (lps0_dsm_func_mask > 0)
>>>>                   acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
>>>> @@ -539,6 +534,11 @@ void acpi_s2idle_restore_early(void)
>>>>                   acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
>>>>                                   lps0_dsm_func_mask_microsoft,
>>>> lps0_dsm_guid_microsoft);
>>>>    
>>>> +       /* Modern standby exit */
>>>> +       if (lps0_dsm_func_mask_microsoft > 0)
>>>> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
>>>> +                               lps0_dsm_func_mask_microsoft,
>>>> lps0_dsm_guid_microsoft);
>>>> +
>>>>           /* Screen on */
>>>>           if (lps0_dsm_func_mask_microsoft > 0)
>>>>                   acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
