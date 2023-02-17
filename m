Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C016569B20C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBQRt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBQRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:49:54 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFE454D0C;
        Fri, 17 Feb 2023 09:49:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAcFmiVjUkzXu3Ri4OsMKzxopfYufsct8kfIvPTxcrkU4QZ+9MpV6d+dMt7eD4Bt0xAesBCFIj8aFfxU2ZMHxdeqmx2zKUcUMe/vciJ/JiXvfL3v5NEZFPJde3+RCgyGaYLKbSNAhkUu371TzU3OqJaOntoBhqv22mENl48tV+TnwaYfbyD6B7biDkWZ9+lHkuZaLldAhtI4puqA5JKOkVMpCxPdRV5fuNrtZAM6KA0Mr523QYH5X9ubg3HiSNBharBu42WsmhEdFfxWMTOkbdF5H+sboKRwIihQSNnemRDfdTrrpFO3xZp0CD3hoE+BCAp+KHSUAx20q918nYCjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q4uMKkRgcRtQPSbOOKy4DnqQvJeQBynt+7ByVB9f9s=;
 b=Vj54N2GmWuiBOZfePh3rBTmHxOAx8cheoBLkmNrikLfl2WhY/JOTGJeHh0Jt7r3GV0gVgew7aX0nFw3nim+1+OBVwqc5bVl+vJU+8DYsA0HWVX8c1gbI92tbe7EbxXhG4lHMBcwUp2myxl0XI9KPweHmTM/RoDMadkcgUUcoHU1RwXtieQATKz5GvazERwHYEwXgLd2cqe2WN2yzjKyFJQbaLQ2hWX7LjV8VCXU+tobyldTDa1NJLK11jm9VsyjGRYckRpiYDlcdwTbVcExEdCwqZBCaInVWlEhMARD0HafLEAxFnYNe72fZfsDrxYnA2ivIDlRpOq8GnDqrkNHvqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q4uMKkRgcRtQPSbOOKy4DnqQvJeQBynt+7ByVB9f9s=;
 b=lo8GBV3Y17fma43m2Fb5+45HcuwzKCwknnQB3ufD1xYo8ts+JW5l3v7rOAOACSQpyoq/36O30PGX14auvS3yY3szxnCDDIkWJQBmsf9Q+8HWYc4qR2lojJ1ZqamTcH8y0Lce7RSFb8sB4Mx8hk9ogYd5B2X8frIeqVn9N32M5RE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 17:49:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%7]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 17:49:50 +0000
Message-ID: <6ccc32b9-8cfe-e5b1-7ffb-b8335bbdadbf@amd.com>
Date:   Fri, 17 Feb 2023 11:49:45 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [RFC v2 PATCH 7/7] x86/resctrl: Add debug files when mounted with
 debug option
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        reinette.chatre@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, eranian@google.com,
        peternewman@google.com
References: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
 <167537445777.647488.12333202522131465679.stgit@bmoger-ubuntu>
 <6713e2e9-827d-8f3d-0923-a03b6b072383@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <6713e2e9-827d-8f3d-0923-a03b6b072383@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:610:4f::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf83524-b636-404b-73b3-08db110f5de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WB7kDQgxCclJa/MH6IgqfrnFhDTbGCSw8g4jLQOE6+l800oNPmZ5dt7Kokt086/XnQZd+QksDCyGgCkR1z0LS1c/weJzAYpNpM1CDUirK+hz3kGQUYCmKRrENmNsBV0IHrUiSyYg0HBkLO4sNBr+1lsBf6yAZvoTcrFE9NsI9qrgPUuF9jpFClIEosVG/YxkB/XhXH27F4rl+g86oichye/i6qeALOYGlrQnZEpkWBobRi1Pu/VTXAVNOfwoM7xhMupZcO4IPBe4dZAtzqng+9/dqvMoTweZmSdIxnuJ1ry3WaJzRZbkUuxj3kdeSrRF+0IK0zIU7yPyvlTDd6zuZN3oRXiaI7KTVCggpq8paHQZeQ3oI32ARIMTzaoGKocc/uCFqaUpLDu3xv84pSztLbz4i1Mi7C1t27hSqjjbOq5lYKUtojjiWwfWV0QTgvmq2E3z/Zyp3qJS6swOdhAcCBKQ9+Tn7M7856cNqoa52YfVs0gNvPs4s08/WvbGsEvxY2y0ftGmHiR+WXf6Nv5k2iuGP7C9ma4EAmYnLKnzHjQ4ePq8JiIx+G4tj5ntEysBOpwLy8C7J1lCJw1+yqysKhR2XIHuskyYprFp+Z1a5jL4mXm9d93gjiqATIPd+b+KbMs5lP5ias+QMfPmIYN3zjW96pJ0G9xN/1iR/7mZhfE+IP4d5uOwWWe41XifqKkxPjdZFCUN0lLbvBzreVs/bQKl/muuvtzNmwmIG+Swv9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199018)(7416002)(36756003)(5660300002)(31686004)(83380400001)(26005)(6486002)(478600001)(6512007)(186003)(53546011)(2616005)(6506007)(6666004)(66946007)(66476007)(8676002)(4326008)(31696002)(8936002)(41300700001)(66556008)(110136005)(38100700002)(316002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU8xWGk1NzBtSnlVZGNLMno1d0pXMzYvOG5Sc2k5K1pwZmoxM2pKTi9FMFZZ?=
 =?utf-8?B?Y0FaUlpzVXVFNFJaN2x4SWh6azdMTGlFR0JYYlFYNVJYb0lxeUgyZkxpSzF0?=
 =?utf-8?B?UFdqdW8zZXJYM01Od1Rka2ZHbFJUekhXNzlwMjdWN0hxOFMyQnh2MXdHS1li?=
 =?utf-8?B?cFJ1c0Y0S0tSUU1YN0Y0dkY1emRiNVI2bExjYjl6bE1jdDRmMVdkN3ZTbGx6?=
 =?utf-8?B?cGx3MDR2MGUxQU12MGY5cGVINW5yeUowRHFZK2hscU42TmhLbGNXVzBjOUZi?=
 =?utf-8?B?R3dzY01NcmY5VlBhSm1hL0I2T280NWo5UGFtNVBGRElNdnZkWWZ0U01jRTlq?=
 =?utf-8?B?RFpxQ0tmRExWa2JNR3Zuczk2UUtFSGdtbjJPN2ZiUWk1YWx0WEp6WkFIaG1z?=
 =?utf-8?B?aVptYWdNYlVYcDF6ODRNblFZdzUxZmZCcHh0bTI2bUdZU2twY0JrOGVtWGlH?=
 =?utf-8?B?YUw4cXFRYnN6eHJHNThSTkRlN0JWTHRFUUs4bUorWjJUREpHSnhjUlpxZUdu?=
 =?utf-8?B?dFZpTmNyaWllMDI0Rkc4dndNOVFpOFp2ak85ZW5DYzZ2RUc0MmRUYkU5NmNv?=
 =?utf-8?B?WXNJUzBLc0Y2R2c3TGRuYjVTOG5lOXYzdE9PV0lzRGF2UVNhUUNGTWRHbm56?=
 =?utf-8?B?Wk1DcHlMR2VQSms3VkUzYjJjSHZld0FwU1MrNktoOE0rdHJlTGVGNzNiZUd5?=
 =?utf-8?B?c2FLNDJQY2JjUmVMYmc0eDNCRTY1YXluczczT29scE1iZ3Z1SnhBRDA1dzUy?=
 =?utf-8?B?ZG5ZaktvRDRWNys3RzdKcHNvK1ZYcjFWa1kvNHpqUndvenpBU1MrWUxsQWNU?=
 =?utf-8?B?bFozd3U5V01RMXZ5ejYzalZnZGNMcVVDRTd1Yy80cElnYU1QdWMrYmxJZ3Jl?=
 =?utf-8?B?WitadkU1VGxwSzRwTHFOcWRkdXhEZG5mc0lvaTFkOWJNMVR4WHRmVXBtQ3pz?=
 =?utf-8?B?RStFVUpSQW9Hemh4U01kTjYxZ0RrZkU4eXcrSEE2OFh5cCtzTWk4NHdJczdq?=
 =?utf-8?B?VEtwM2JJNmx6ZjlpamRON01yUWU1R3pFWFFqem5kbFE1VGt0bW1LM2Q5VTFQ?=
 =?utf-8?B?OFFEYzREdWRTeVk5Q205dUdUMWlaZmJ4cjdZS2R1VEp6dGx2WkkzZldPaGtC?=
 =?utf-8?B?MHdtdno2c3RRNEh3Y0dMVmpLUmk0ZWxBTlNld2Z3UEZCZ1dHek4zZFVsVHBm?=
 =?utf-8?B?Y2YyakR0Yy9wSWs5T29IYzYrazVVK2c2VjVaZ3draVZWVG1ZN09OZ1ZYaE91?=
 =?utf-8?B?dGo0YldoamVMUE5QaFpGNzlwc1dpM0pISWxXaFB5dDNBdExNNVdjUmp3WXd3?=
 =?utf-8?B?NHNHbDhMOU5vZzFnV291dlZYZ0tPa3BINS9CZW4rV01ySnJ2QnhEemt3bmNq?=
 =?utf-8?B?MU5Da0d5Q3FHYjV1LzhyMVJZR0c1WTF3cUpXd0M1bHFyMThoOEc5bTNOM3p1?=
 =?utf-8?B?MUdrblp1cFFsb0o2NmZHMWtIUG5xZEtBVFhwV0IrbHIwSWUxTUsrVGpZYlZ5?=
 =?utf-8?B?OC8rV1VDT2J1UjVHbkpuaHpxdGZGQm92enFFQmRFZjJucEplTWMwcXk0eTBX?=
 =?utf-8?B?Ly9IRlB4cWZ2YVdoUjVjVW45OWFQMFpiNGdHc0pENjNQMWZKcGdwc2VUbUk1?=
 =?utf-8?B?Z1ZXbmtmMnVLTlhtbTc3aWRsclBjQ2JTYkhwSHNkM1dZYjErWmQ0c0R6d3Ba?=
 =?utf-8?B?bDFJUjRFVDJOeCsrUHJ1VzlWN2NRZXhqa2hTcHZRQUlGOEFEbHRKNFN3eVZ6?=
 =?utf-8?B?TWZZNlo3bDhhU0JveGdkV3ZwaDhFdkxlcWdHVks2UDMyNzI2dlQ1c2kvd3Q3?=
 =?utf-8?B?VmlicWo0ZFFydmQ4TmNjSFEwaWNlRDNEVys0cXhUOFJyNlNudlZySjNjNUIw?=
 =?utf-8?B?RG92NXhydUwrTnNTUkhSdVlsWnFTbUVTZ2lSdzNnK21aSnJuQTBFYkh3TnV1?=
 =?utf-8?B?NUsrcjlYYUduRDVRTFFwcG1KbDhwVUJXVCt2NGFSc3djcTJoZ1RvcVUyVG1p?=
 =?utf-8?B?QWdFZ0sxYUZoSlR0ckg5Vkd6eFdPUFcvdGw0dFF1R1g1Z2tKL213Vm12RjlG?=
 =?utf-8?B?WFE5MTFJa2U1c3l1UXh6OG1wb0JjK3k0SHNBSTZoUVJoV09LMHdtUFdON0tQ?=
 =?utf-8?Q?J3NQFItNPhP9tDvTfo/skseuC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf83524-b636-404b-73b3-08db110f5de7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 17:49:50.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GghnuMSJfegavj3HexZVSg3rFnhvpR1C/v9mo/PGVz8pRJ3vhqighIqi84ZPBkUy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666
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

On 2/16/2023 7:50 PM, Fenghua Yu wrote:
> Hi, Babu,
>
> On 2/2/23 13:47, Babu Moger wrote:
>> Add the debug files to the resctrl hierarchy.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |   27 
>> +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c 
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index c35d91b04de6..b7c72b011264 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2398,6 +2398,31 @@ static int mkdir_mondata_all(struct 
>> kernfs_node *parent_kn,
>>                    struct rdtgroup *prgrp,
>>                    struct kernfs_node **mon_data_kn);
>>   +void resctrl_add_debug_file(struct kernfs_node *parent_kn,
>> +                const char *config, unsigned long fflags,
>> +                bool debug)
>> +{
>> +    struct rftype *rft;
>> +
>> +    rft = rdtgroup_get_rftype_by_name(config);
>> +    if (debug && rft) {
>> +        rft->fflags |= fflags;
>> +        rdtgroup_add_file(parent_kn, rft);
>> +    } else if (rft) {
>> +        rft->fflags &= ~fflags;
>> +        kernfs_remove_by_name(parent_kn, config);
>> +    }
>> +}
>> +
>> +static void resctrl_add_debug_files(bool debug)
>> +{
>> +    resctrl_add_debug_file(rdtgroup_default.kn, "rmid",
>> +                   RFTYPE_BASE, debug);
>> +    resctrl_add_debug_file(rdtgroup_default.kn, "closid",
>> +                   RFTYPE_BASE_CTRL, debug);
>> +    kernfs_activate(rdtgroup_default.kn);
>> +}
>> +
>>   static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>>   {
>>       int ret = 0;
>> @@ -2411,6 +2436,8 @@ static int rdt_enable_ctx(struct rdt_fs_context 
>> *ctx)
>>       if (!ret && ctx->enable_mba_mbps)
>>           ret = set_mba_sc(true);
>>    > +    resctrl_add_debug_files(ctx->debug);
>
> It's better to change to:
> +    if (ctx->debug)
> +        resctrl_add_debug_files();
>
> Then the functions in the call chain can remove 'debug' parameter and 
> can be simpler.

Actually, debug parameter is required in the resctrl_add_debug_file to 
delete the file if it was mounted with debug option last time.

Thanks

Babu


