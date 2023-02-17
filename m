Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E9269B1C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjBQR3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQR3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:29:50 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC06E676;
        Fri, 17 Feb 2023 09:29:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTAdB8HusSXBtSrZ6gGPb1b9jXSUJt7lZK7xJrewF/y12JnRd2l/DCixKkCcYeaLf5g96O0rqyCH6q1FXmE0OZzTMbqTkaIypJKAHHcB8CHjQgPTDVxbuqnIPuDY4xqjCY5Kp9760rM24T51G+HpBA7y328pFOF98q087HTkMohULCChJj+twJyIu4cI3KojJGWGqosh+xh9UYcm1jQErNp7rOYCn9mb6zo/4Us2orp111IwlQg5+wEV8hIiDaOgs+2xMJV1rWywyYxg6Fs0h/vjF8lejZVTLWwZslp9rKdohTB2iFPva2BZjdBQh2QY8LVGJ8EZvWG4Aw9izKa9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAytwc5MHaTOlPPTUC8gMUBQ2XCcOJ2FKTqr4dsZIrQ=;
 b=gRKLPEHxV9gM7f2KkGGRK9cnTILdgiSFV5Q3NN2hH5xPjL4p5e8I1OW7tQ4f/1NvJx68XyToQt6AX9lFTNif5FA7U3SoVO0yWnOQw9R5e6xIih5zpIREhLRtVCSpA9tH9TBrd20PfYvH5z/LItyu6r0V5BPGGEos0v9XspCn8nQN+FTFvN6r3Z7WmAA38Q7QszWJCzD2aRI1Q4aSi1QA7O+wHrKH7tZO3X13DN0PTyP1XGPMZD6Yt4mI3tbkwFkJjYGmjiNp1SA/3eSp/hxDXgn0k03i1UsmA7zH/dZ1ja5k3s+nfWhjWlfEP6JiO1AceJOnS7p5K51k2IEHo7rUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAytwc5MHaTOlPPTUC8gMUBQ2XCcOJ2FKTqr4dsZIrQ=;
 b=yB3b4WP2JM1aBVw05iL8f/q75GsL+pA7IfdHxbeQY/0f0pMTaz59dSNOa73orZhm2TlX+F4SwkD0oHPS7PKTVu/B39bUv/Iw5E3sjc29wIphN9l1k22iFQMKM3lgi/uTVEcpjSuHk/cLx2NcYJ1h2uNXGPJxJa67fzWRLkheYxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW3PR12MB4540.namprd12.prod.outlook.com (2603:10b6:303:52::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 17:29:43 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%7]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 17:29:43 +0000
Message-ID: <0665a64b-a83f-99d9-02a3-17931b6f0f4d@amd.com>
Date:   Fri, 17 Feb 2023 11:29:39 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [RFC v2 PATCH 5/7] x86/resctrl: Introduce -o debug mount option
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        reinette.chatre@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, eranian@google.com,
        peternewman@google.com
References: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
 <167537444491.647488.11815488030989406143.stgit@bmoger-ubuntu>
 <04a598d8-eeee-9512-7db9-cfeae33999a7@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <04a598d8-eeee-9512-7db9-cfeae33999a7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0314.namprd03.prod.outlook.com
 (2603:10b6:610:118::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW3PR12MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e9a6aa-b6b5-4dde-c5fc-08db110c8e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: biB42GIXqsFU8XsmZ8QzDsW6XpA29R3vmW4UXZgUSW8HshwEjwnNsxMq9++jlBLvbS+x8xNF2whkONbWN4KBp61F0mbanqL1Gx3YSbhCzpyjpaD4i1/B0+c0gBv4Hs2HjZyIwna8IOtwbnglnRdpLgPT6Mw4At04esWecvvfmrLHf2YTxHbbhqAuLNUMlYl326vNnfbs1QRSZEH7aaxAo5dK0qx2A9FsIjk4bdoSTooSg+FZL5HOfMkQaiNs15AwcH8ndZrITJb0o+XYyNJr34fp2McjpDYABSq+9R+9n27HsfSt0qI6Qv9t1tAK9PZtA3smZIQxU40DNIk82QFbtBemdhCJpyENyGzdf0oTJVhkbGFIYtCUFwqi35vbhgP1kA9W/xbvXDklQ9FyVMpmhpuGgRJI03ggL4W21wInP4hfz/p0lBMmNXqjdUX4gZANIO0sQ4RKewMoOlfFDUtwgcC3uWhhqMAxGUg8e8/enATtf2P5ZalgQJbZjHQ9Sg63jpxn52XNidlbh7bG+Y15GNuiQ7JKBuF8tKhf+Ro6Cvvb20cBdwfAk8vYWzAto50PfprVoZ23UOt1alTrcoSJ/tQ47I/Oxm/BLoLgu+zjSMeBG0m/iG8U/y7HFKFAp5LQpwlBAVMkbfc3HpubPNHHq/TojY6rz/un4hOFF4O2MkMuPcb+AZSJya8cPJjxBE3eRxvRhoxVtlfV0+fZtFy6xTeQ8SJSL5PGCKRtbo9oNRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199018)(5660300002)(8936002)(53546011)(31686004)(7416002)(41300700001)(66476007)(4326008)(2906002)(66556008)(66946007)(316002)(8676002)(110136005)(26005)(186003)(6512007)(478600001)(6486002)(6506007)(36756003)(2616005)(6666004)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2J3YmlrQUZwTnVsWXAvZ0tXalN0blJVMlZuaGV6Z3hHY08rajUzejFKZWtM?=
 =?utf-8?B?bnN0ei9BaGYvOVVrb0t5VHdnckZyOGRwVC9GZEhRNEx5dllqQm52TmlTMU9U?=
 =?utf-8?B?QUNWaXkvcmxvSXNUOEtWYnlhc2l3dWw2NU9YNjR0QkprVmVQYXZoSG1UQ2VC?=
 =?utf-8?B?MGd4V0N6MVFIMzQ3Umo5Qi9QY3I1SW1RaUZJdDVub0RMdVQ3eUFiWHREZEhR?=
 =?utf-8?B?d2ZWdkZZVURWeXhaMGpnQVl2NDB0S0F2UFVXMkJibzZyZjZmWmVDb2JxeEpQ?=
 =?utf-8?B?TmhIUGlud1AzVVZ3VDJ2L0RlUUY1MmNWTnVKcVZyQnlMT2JtTjNFMzR4aWNs?=
 =?utf-8?B?VEtZME45RmdtYi9rRGJ5eUhxYkJhRzYzc05ickhHOTJkdGpLZE51N2IrNzBX?=
 =?utf-8?B?NlF3a2tpL3BweHhiYnBWQ2Q2d0pPNHNNNnFJUUtGbGx6MHhFRTV3bkpscFRj?=
 =?utf-8?B?MlMwSkpVaFlPZkhHNUI5KzVPV1NXbWdZR2xJN29ZYUNUY0owUjlCYU9uQ3Qr?=
 =?utf-8?B?bVdOc3JibC93NjJQK1hwVkY0cW9KVUxuRVA3bDd6ZlYyT3JtdjJDOVJEUURt?=
 =?utf-8?B?cUF0UDFtanUwNVhHZzlLR2JqdFk4RGQxTE8vZ1pvZ2lYcmxoVVZ0N1pGQTB4?=
 =?utf-8?B?QlhkUXYvRTZaZlY2bEVjSEx5ZzdPaGtlNU1CQk8raGpVMzZJcXJxalR4OXlE?=
 =?utf-8?B?QWZTcHIzUmduV3FmdmVOVFl2WE5mUGJEa1ltK0hRMFphK1lwZGdFVjJ4M3p3?=
 =?utf-8?B?MUpyRWdkTjdGSjE2NThDZVc0cklVQ3h1M0YyVGw1L3ZPK2YySmVZdExBZkRQ?=
 =?utf-8?B?T0o4TEI2anRJT1c5RmJGWGhobUVQQXlHT1ZDN3hVT2VYNGk0UmFUSTErMm5P?=
 =?utf-8?B?MS9nL29WLzM4OHNSaEc2QWNlVkRMNlJtbHdCMXJCUjZaUjRYb3ZEVE15VGwr?=
 =?utf-8?B?ZTJjVkp2Z0plaFpaZVVNR3pINVd5SlgrWTdsT1gzanlKc3d6WUtLWitja1dI?=
 =?utf-8?B?SE9kSG01VVNYNmdSMXRaSjVHMndyTlpHeTFWYU1vRDBmeHI4Y2x3MUxvODRz?=
 =?utf-8?B?cG1CcndwTGNIRlBsUEF1WlBPWFcwRmhMZU0zNVJFRDh2aTZIdWhKeTUvYzJv?=
 =?utf-8?B?VlB1Z0xXb012MW5UOUFqZjd4V3lEbHBsU3kyS3VrOHY5ZTBUZXBvWklFSXlC?=
 =?utf-8?B?MXJCWkprSlF6am1IaW92R1dKSWFXT0g4aTBkL2tCWEViSzIvbmlHcUwwbGxY?=
 =?utf-8?B?RXhBcWlsUTRGSm5rYnkxS0tnQ2d4bEk3TUlTTHBuM1JTUEZibWxkc20vQjhv?=
 =?utf-8?B?Z2V4bHQvNk92Q2hGTWEyYXErdy9kWWZTZzJoN21maGZ4V3JTZzBtVmo1ODRQ?=
 =?utf-8?B?dUNobkJ0Z0dwNUZsWkprdlFWRG1FYkpHRCtGdVk5VFJ4NnRIZDN2T2s5NFlH?=
 =?utf-8?B?ZStRNWx1UEtjb2FLZnJqMTlRNWNHbFVxaURmRkcvTXBnREdjQ05LZnUvNTdY?=
 =?utf-8?B?MytLS2x3QkJLWEgvdFJIdGlWR0Y3ZVhyU2oxanBUVW1WNi93U0FBZW5Jd1dO?=
 =?utf-8?B?SEl4bE1sVXZFME9jRE1TZzJ5N3FIaUh6SXBFMko3S29rUnZoSzJJNkxjUHU3?=
 =?utf-8?B?UVhVUUgzLzNMd2p3Z3R4eUZGd0MxN3VlR2RxUGtIMzhjU3VXT0N5cEVDSU5X?=
 =?utf-8?B?dTRLSzh1UVA3K0swUVhicHgvaWJrdi8rMXNKcHlOL2xBNThPT01tRDdYNzBI?=
 =?utf-8?B?MWowL21ONXl0Q2x4S0tYQkpHdVM0bDh3bmhTZW5xSXBtSnpKSWpuK1E4Z1BJ?=
 =?utf-8?B?TW90Wm4yQUEyRWdBWWtIcS8vWlc1QzdtZXdBWnZqcEtBd0l4RGI2TWc1Y1Ur?=
 =?utf-8?B?Yzl0N1FwRURnTkFreEY4TmZlZGNGMHJOUENpQy9wQ1E5a3J2K3RncW9DdE85?=
 =?utf-8?B?ZEVYdzBqL2RSeDBhc09lTUd1NTk3bE9SYXI0Sks0a1NqRjRtVk81dlcyVHpv?=
 =?utf-8?B?ZkpuRnNyNDdiem5QOU03MmNqaEZWdURUN2dEeXlrRm45cGd0Wjl2RFIvdU9K?=
 =?utf-8?B?Q2FjMDJ5S3grUy8xV3NpRHJwUDVLNmE3R3hUL05DU09STnM5RFFMVmhyWG12?=
 =?utf-8?Q?T5X+NkBp0qdACIfcvsSCgtQww?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e9a6aa-b6b5-4dde-c5fc-08db110c8e99
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 17:29:43.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCTZ3ptNE5uVYwXg0n24oTWrSTNaICKixA8PEHcl2LSGTbDZS038jR0FU+4Cf0y8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4540
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 2/16/2023 7:42 PM, Fenghua Yu wrote:
> Hi, Babu,
>
> On 2/2/23 13:47, Babu Moger wrote:
>> Add -o debug option to mount resctrl filesystem in debug mode. Debug
>> option adds the files for debug purposes.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   Documentation/x86/resctrl.rst          |    2 ++
>>   arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |    7 +++++++
>>   3 files changed, 10 insertions(+)
>>
>> diff --git a/Documentation/x86/resctrl.rst 
>> b/Documentation/x86/resctrl.rst
>> index 58b76fc75cb7..2c013c5d45fd 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -46,6 +46,8 @@ mount options are:
>>   "mba_MBps":
>>       Enable the MBA Software Controller(mba_sc) to specify MBA
>>       bandwidth in MBps
>> +"debug":
>> +    Lists the debug files in resctrl interface
>>     L2 and L3 CDP are controlled separately.
>>   diff --git a/arch/x86/kernel/cpu/resctrl/internal.h 
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 6767c85b9699..35a9ee343fe0 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -59,6 +59,7 @@ struct rdt_fs_context {
>>       bool                enable_cdpl2;
>>       bool                enable_cdpl3;
>>       bool                enable_mba_mbps;
>> +    bool                debug;
>>   };
>>     static inline struct rdt_fs_context *rdt_fc2context(struct 
>> fs_context *fc)
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c 
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 18d458a3cba6..9b7813aa6baf 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2555,6 +2555,7 @@ enum rdt_param {
>>       Opt_cdp,
>>       Opt_cdpl2,
>>       Opt_mba_mbps,
>> +    Opt_debug,
>>       nr__rdt_params
>>   };
>>   @@ -2562,6 +2563,7 @@ static const struct fs_parameter_spec 
>> rdt_fs_parameters[] = {
>>       fsparam_flag("cdp",        Opt_cdp),
>>       fsparam_flag("cdpl2",        Opt_cdpl2),
>>       fsparam_flag("mba_MBps",    Opt_mba_mbps),
>> +    fsparam_flag("debug",        Opt_debug),
>>       {}
>>   };
>>   @@ -2587,6 +2589,9 @@ static int rdt_parse_param(struct fs_context 
>> *fc, struct fs_parameter *param)
>>               return -EINVAL;
>>           ctx->enable_mba_mbps = true;
>>           return 0;
>> +    case Opt_debug:
>> +        ctx->debug = true;
>> +        return 0;
>>       }
>>         return -EINVAL;
>> @@ -3525,6 +3530,8 @@ static int rdtgroup_show_options(struct 
>> seq_file *seq, struct kernfs_root *kf)
>>       if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
>>           seq_puts(seq, ",mba_MBps");
>>   +    seq_puts(seq, ",debug");
>
> Need to add a check here otherwise ",debug" will be always shown 
> regardless "-o debug" is given or not:
> +    if (ctx->debug)
> +        seq_puts(seq, ",debug");
>
> But I don't know a good way to get ctx->debug in this function yet. I 
> think somehow ctx can be retrieved from kf but not sure.

Yes. Make sense. May be i will have to save it in rdt_hw_resource then I 
can add that check.

Thanks

Babu


>
>> +
>>       return 0;
>>   }
>>
>>
> Thanks.
>
> -Fenghua
