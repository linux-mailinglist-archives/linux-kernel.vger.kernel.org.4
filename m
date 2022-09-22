Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47425E6B54
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiIVS5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIVS5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:57:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A1FE6A3E;
        Thu, 22 Sep 2022 11:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gvzua48qWobnyVmI5Zne75vKiotLjR7ZaBu1jgAIG5CbUNv305RhITm4n2B3IR9c0dHeWOhdsqbbH33cxmJT9SZ8v/lcZ9Vr0YTxsOLxfeXwiI7QBbRDNX4QYG33tXih/C9TqUQf3RJylzw5Ah+5ypChaXIJoNn52kRPgnIGXc3YDa060pT1YL7wh6+VHll3MFawULndZgUak9Lw0PnT4JP0xtVRihdn41nIWlZRXS/Tmp+K3PIgHa87vc4FNdzqbQqpt5uy0P19Nh+0waZNT1b4a+Yt3YqimiWG+mfiEFStuf/316UDd/O4+Gb0RDgWDyzlkoz/E20H4N+QdAQduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOycvdq1LN5ZPUmO9QCLTxcA1bb95G1KrkHJcbdlQ6g=;
 b=Qi+AL2i2FgZSD+SN4YSq2xChVYwnheP5G1fVW+oPoUO7+BmVZp+gdbHQ+inQ0T9+H5biWSuweQsQfqipwdBxNZRRhhsiuHb2drMaVylpXHOp9Ue9kWOC6qwB/zDrY9OMXWFiq3hIpYwU3VkkhDzfP0d6EnZHaOhuojSX5oKSPi4xWtc952ASy1JGYr9mKi2hbKAsLAOFXTEhY1AZ/XROEjd/is7HwbcWTZ2fq/oOYCi32dbY3cCm/tZbMKUFZTvmj3fLFJAV1t/ZE3KBuRWF3DLyDbSdrPUDJXsaCO//yVud/yGOA//PNcFBEbaa5Gy35ekIzoTJlRNgnRjMXUWNwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOycvdq1LN5ZPUmO9QCLTxcA1bb95G1KrkHJcbdlQ6g=;
 b=ExRioxY30nAqYlzAKQYW3JVoWZmIUXxryJpcwUdmaDbCzg7HYN9tkti+r09e6AIpqYCUUCSwSfAnjJUGc08m1jNUjQH3mc9DTJWBTtj3D8FMj4NJuYeXERTvuIY9Uwpe9k4HqwKnRSIKMnDkT7BSg3rg6spt3oJHvWOz2m1gNoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 18:57:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%7]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 18:57:28 +0000
Message-ID: <5b3bfd60-c44e-2cee-34fe-cb6661ccbe51@amd.com>
Date:   Thu, 22 Sep 2022 13:57:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] ACPI: processor idle: Practically limit "Dummy wait"
 workaround to old Intel systems
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-acpi@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
References: <20220922184745.3252932-1-dave.hansen@intel.com>
 <78d13a19-2806-c8af-573e-7f2625edfab8@intel.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <78d13a19-2806-c8af-573e-7f2625edfab8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:335::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 6edaf293-96d4-4c8b-fd09-08da9ccc4bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBSCAShsM8h1Hmj5WFsdBTEBw1Ri6fJPjAJ24OZe2rWgmvgsJfrujfzyGIdvLBqIIurkoUoF1X7onZZFmFjI05JIOHmdyDlh7fv1KNszzLPUEdO4GaGvrCiIJkG8pQTOjvZyh1valfJKgYnMVIdxoOSGjcuueCp6ADJIvNHTQ1eijqn8EVKQt0fl7bPXamcC3cizRYCVYH5ITruvgZ2kHYwORRDPLkLUzhHjN8vBVk0rjSITJYkkuwz5Lzu5w2aBAWEQO/JzFBVl1g06TMNEP0pCwpEIMVthk/TvCsO6KgIZ/D1/dYYZrivMghrrj9petLMav0rPuq3ed2fQ3xethR+3+kD7QfvsbsjKjDetrdQbTmwtGP+X+N0au92meaf+B2c4CM/0oMSnVES5rAW5E9SCeJLlzNuQEqgokwqbAPhH/Z6c7QV0Hdt3D1sGin3N1qlFTVhPnKYBHIx/bernJpxe0TmYF7dXKFDYyxygxFwY1edM3ZJu6HOeU43deRsxXbCm1OSpEONUa9ZeOZ6IZEvXb2U1Tioh9aLsnNYcyT3cAi1YD0uhlHYve/nWgGIZHj1+EwBndeZcoAp2HHsPNQvw9jAHeonKpyBaoIV3cETsBwIh9blDHauchKuZr9O4dQIR2bth0J1WhDYV8uYzdkRFZEK4yV9wB6ZnIKt7OEfA/f+0q6j6ps58Bknje/CWubiI5oEhvkzGZSSkmXcs8LYoY8SBk/TzHzlYY8B7unBeyCayCNJ6bmHjeGEQgwfUUA1z4pgwWZGKPzEWouDlcu7BPc7139Z8AVZlWkdDV6gRDTRYlLTmK3ToF6bTP2YRcwK3fB5CihYpzmiIftRdcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199015)(6666004)(6486002)(31686004)(478600001)(45080400002)(41300700001)(53546011)(6506007)(6512007)(26005)(316002)(186003)(8676002)(2616005)(54906003)(110136005)(5660300002)(2906002)(66476007)(86362001)(31696002)(66946007)(4326008)(66556008)(83380400001)(36756003)(966005)(38100700002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3MvYjgwN1BnVkNlbzd6c1ZjNG5jOXQwUTlaV0hMQ1l4UkJFSVdDVHBXci9l?=
 =?utf-8?B?eXFtY0NYS0NLRmhMR01EZUhtb3FncEg4V1laMkE1bURiSklya2FodVdEUGZJ?=
 =?utf-8?B?ZWw1VWo4SFRYS050ODF1a216UHBuZjdoMXNCZS81Q0ZSVEM0R3dYaDVBdnpq?=
 =?utf-8?B?eHpzOUxVbDB4MzRCa294bEY3cHNjU1hoUkR1TDMzMHJDKzlCTGV3U0dpK2kx?=
 =?utf-8?B?YnB3d1E4OHF0dEJPRTc3b2w2Zmp5ZkE1MnhVRmNlVVE3a3hyRTl2eHBzKzV2?=
 =?utf-8?B?Lyt1Ym1IczFWMWNpeEZFUWEvYTQzVVdhc21uQ1pyNTg3L2lHN2w1cTczc1d6?=
 =?utf-8?B?eHlnZUNGa0hWUWJzd2lCVlVyNnJIL1N1S25Ob2N6L2gxc25qei80VFRwKzZV?=
 =?utf-8?B?dDdXayt2anJmVlNFVWZYMnpJZXluTU9nbnJYMmV5VVVQazRaYUdUN2JWSjlX?=
 =?utf-8?B?YW5VNko1WTNVcnM2TUtzMDVkQmRTQXJlcEp6a1Vra2pYSkM5WFMvc2FtS2dS?=
 =?utf-8?B?WlFkak5HaXk5Q1ZwRjVVMGl1MnhtTll2RU9VYWNoZDJ2R2Z2cUhJWVAwRUpp?=
 =?utf-8?B?ekZMd1V5SW9yczB4eUNuNjVnL2JNa0x2YzR0VTVHanVaWlowNVlqSXVTVU5L?=
 =?utf-8?B?QmRWRHlGalZBUEVpM0JGNmRkVXFITVVEQ2x3RkxoNEFCcEE2ZFBtWjhaeVMy?=
 =?utf-8?B?S3N3UWxqK2FSZm0yVll5ZGl5WlVWMWZXSVozMlk1R3lETmZrczhodGpvWnlQ?=
 =?utf-8?B?MjVCVTRGVEZ0NnpzUDMzcTFpQksycWxlRU52clNoQ3RBcHlrSkpCbmREdlNK?=
 =?utf-8?B?ODc2NnA4dnRtWVJ1MU84NHp0ZFVpRnRiZHd1L1hna3lYOHNvK2dQMnN1YXlj?=
 =?utf-8?B?TlV6TkxMOElsOXdIMTFEaVd0TEZGZVpwdmRQRVdpSEpROHJGY3czbUduQXhO?=
 =?utf-8?B?L1JWdXl1VUFDcUt0dWUreHozVDVZTVY4RE9YWW1KbEhRcjNsQitndVQ4YWZP?=
 =?utf-8?B?a2oxcmpHVXNiaUtHMUhqcmg5WkhKVnAzdmxrTUMzLzd2aEROUFMzQVRCZ1dz?=
 =?utf-8?B?Q2xTUjRNMWo5cHpHOFVGTFhMMExiS3dFTll5bmt0Tzd1cmY0YTJNYTVZd29X?=
 =?utf-8?B?Wmh5VkxiZ1VNVVFNdkdqWk1EemgwZXZOZm9YUVErRzMyT2MrVUxzckpabkdZ?=
 =?utf-8?B?b29tS0xRZDNFVUt4aEpoSTAzdW9uMUdNNmlKMVlPOU1NMEVqM3NjZHp4UC9X?=
 =?utf-8?B?TXladEIyT3ZvWDZMbVFWOXRSc0pHZE1tMUFsYUJmMUIvOXFhL2dSWXppbFY5?=
 =?utf-8?B?d3QvRlNJVXBTZFhOUGs4ajJJWUpZVVpvYnl2ejl1TGxkeU5uNVBNL3ZpRUNO?=
 =?utf-8?B?Q0ZzYmlmWHFVWDZLcWlnUW90ZEtFcTVBRU10TTBJYWNYRzNzdlFtUlhaQURy?=
 =?utf-8?B?V21BK0E4dktpN3IzbnlRelNMdUtHU0d2U1JnWnVnaWlRTklFWmdhaUNvcWVr?=
 =?utf-8?B?MCtmNlVpNUlVUkZITXVrSk5BaUIyUU5rZWZIMURHWEl1TXhXSlY2Rmp1RGVx?=
 =?utf-8?B?amMvcFRWWHczT2V3dUwrMHk5WUV2cEl0V2lSc3Mva2VlUmVkSDduQWZoeWNM?=
 =?utf-8?B?ME1PLzNoeXFwNmJZckIzd2lUdzhVTy9EYjhTVFA3UCtOV05BSURWTzVuSXFs?=
 =?utf-8?B?Y2gzc3pCVzhpOW9tZVoyOEdhaG94dkdsTHZqM1hIa3JvNFBpcFhrdjdYM1VQ?=
 =?utf-8?B?SDl6YUo0SGVyVzdNamJiZzBXQ3o0cmI0MlJTR2VzL2RieGtWUjRkK3FaM1dH?=
 =?utf-8?B?Rlg3ejNsSENSelA4MFByS0lsRGVsa1VMbTZwOFZPMldoQzI0SXpiemRlWDY4?=
 =?utf-8?B?WmdmRkxLbWpURFJiWnRFaHdSb0RZcFlXdS9qZllZN3dwQmhGbmtYbFVYSk9z?=
 =?utf-8?B?Mno2RDJDWWlYaXBiSE5FdjJJTisySzZpNE0wS2JEaEhXQmkrUTQ5UUt6dGRC?=
 =?utf-8?B?UzRmeUxsSElUU0VrM3pyRG03aXc1bTJUOVBNY2NNRnhQMDBzSlZhaElVV1ZP?=
 =?utf-8?B?K2l3WVY0cmpuRjZzS1dtbE1CT2pOT0loOU9jcVhmT1lhbUd5dnNXaDl0aGpF?=
 =?utf-8?Q?M0FflYxJTqM2qpY9HMJZrIcr4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edaf293-96d4-4c8b-fd09-08da9ccc4bb1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 18:57:28.4188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqLa4/4cToahppD718/Z4Mb3w1i/X/Mu+Qj8AUmXbnxljzdIxTaFTRV60eIAG1NM/3o+2qGoKh3u1HG4a4z0hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/2022 13:53, Rafael J. Wysocki wrote:
> On 9/22/2022 8:47 PM, Dave Hansen wrote:
>> Old, circa 2002 chipsets have a bug: they don't go idle when they are
>> supposed to.  So, a workaround was added to slow the CPU down and
>> ensure that the CPU waits a bit for the chipset to actually go idle.
>> This workaround is ancient and has been in place in some form since
>> the original kernel ACPI implementation.
>>
>> But, this workaround is very painful on modern systems.  The "inl()"
>> can take thousands of cycles (see Link: for some more detailed
>> numbers and some fun kernel archaeology).
>>
>> First and foremost, modern systems should not be using this code.
>> Typical Intel systems have not used it in over a decade because it is
>> horribly inferior to MWAIT-based idle.
>>
>> Despite this, people do seem to be tripping over this workaround on
>> AMD system today.
>>
>> Limit the "dummy wait" workaround to Intel systems.  Keep Modern AMD
>> systems from tripping over the workaround.  Remotely modern Intel
>> systems use intel_idle instead of this code and will, in practice,
>> remain unaffected by the dummy wait.
>>
>> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: Mario Limonciello <Mario.Limonciello@amd.com>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> Link: 
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20220921063638.2489-1-kprateek.nayak%40amd.com%2F&amp;data=05%7C01%7CMario.Limonciello%40amd.com%7C8460d9ef3add45bf571408da9ccbc58a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637994696248641733%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=23k2wKPZaBrgOTtcHw8ByNzfsus1RSsdXMlCACjl%2Bmc%3D&amp;reserved=0 

If agreeable, I think this should be @stable too.

Either way:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

>>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> or do you want me to pick this up?
> 
> 
>> ---
>>   drivers/acpi/processor_idle.c | 23 ++++++++++++++++++++---
>>   1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c 
>> b/drivers/acpi/processor_idle.c
>> index 16a1663d02d4..9f40917c49ef 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -531,10 +531,27 @@ static void wait_for_freeze(void)
>>       /* No delay is needed if we are in guest */
>>       if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>           return;
>> +    /*
>> +     * Modern (>=Nehalem) Intel systems use ACPI via intel_idle,
>> +     * not this code.  Assume that any Intel systems using this
>> +     * are ancient and may need the dummy wait.  This also assumes
>> +     * that the motivating chipset issue was Intel-only.
>> +     */
>> +    if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
>> +        return;
>>   #endif
>> -    /* Dummy wait op - must do something useless after P_LVL2 read
>> -       because chipsets cannot guarantee that STPCLK# signal
>> -       gets asserted in time to freeze execution properly. */
>> +    /*
>> +     * Dummy wait op - must do something useless after P_LVL2 read
>> +     * because chipsets cannot guarantee that STPCLK# signal gets
>> +     * asserted in time to freeze execution properly
>> +     *
>> +     * This workaround has been in place since the original ACPI
>> +     * implementation was merged, circa 2002.
>> +     *
>> +     * If a profile is pointing to this instruction, please first
>> +     * consider moving your system to a more modern idle
>> +     * mechanism.
>> +     */
>>       inl(acpi_gbl_FADT.xpm_timer_block.address);
>>   }
> 
> 

