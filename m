Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F4B61FE47
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiKGTKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiKGTJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:09:50 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2084.outbound.protection.outlook.com [40.107.96.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A8F24953;
        Mon,  7 Nov 2022 11:09:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcrydaXQDsDtFPsPx3BXZUyIM3t72oJ2vbEmSPjGeW6HqUKgvALzt1UMV4Uk5VpP5/l3b2EuDcNnm7YRqM1pLn8kkQZKeHpkgeEzQ4RzV7RzrknaqzNCpYdtsQnMB4NWMHKzyqu6AmRuIKDg1wcGeDJe7ZyqyLnpRifA8jhHyXLo2bW9+QNsIwKYB+TsNxukGZrtezSMex5NcsQesMUvj8KCbyFxvdqqeRJqV90aWIuOz5Qce1FqN9PbHG2XIAeTYkPiHrrbG8jKYSxPPLLB/A2Sy+ay7OB7gTYpSfcAuZRrAMKwNyxZ8cfjIgAfrFq8zbkKu+rUGDowqxRdehoWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQRxkRkbJ0FVsc5Tj+0fnmOzrw1lt1Qay/J8Ju0AJlo=;
 b=K/BBlTNNbwHIwQLNm7x4DxlKLBd3U5QSneDTxx+JqCP1tqiYga24k6Zw6jxk0AlmPaFUVuVB8mS8UfXnXCMAAjQyqLnzXzC+ddCK4zGeupCNC8A0rbyx/PvOWt1Ig+5HnsmS+gstJKPVPcwzZMtcdwf0ZmuiFJuDWyyeIlVJTURfcFWvJwFaTc3r2XCq9012FraoHQTnohLNF2+BNuhYlwa0heNEAC7kj4qcjbY7VoJ3N1GR6iMpd5gNI2RyQTotxkDvXLxwe08Sw8ZZNeA3m6shnDmTRegZmJlw7QWmHaEBmwgIlWomGH6FXFSp55uzv4rtU7Rzlne71m1QMODQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQRxkRkbJ0FVsc5Tj+0fnmOzrw1lt1Qay/J8Ju0AJlo=;
 b=n0HHYJHlBvOilWP6DB5LfAb0hMbsGmf8n3IDZuuLuPwyEQFxertSRRZUaV5Ec0pgLFNiLASaupupgI7cTUzx3zRLseZVXn0JL11CqxNLN2Q0xfRd44V3kcU1Iob662CIMxrmofjlNFthCxQbgkQVR7FRxFkg5qawZ6vZf69i5Ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Mon, 7 Nov 2022 19:09:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 19:09:45 +0000
Message-ID: <caeaf2a6-1156-0649-d8bd-b66ab99b589a@amd.com>
Date:   Mon, 7 Nov 2022 13:09:41 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 7/8] cpufreq: amd-pstate: add frequency dynamic boost
 sysfs control
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wyes.karny@amd.com
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-8-Perry.Yuan@amd.com>
 <1b7a5cd5-6ecf-8529-f10b-4f7f06fc7462@amd.com>
In-Reply-To: <1b7a5cd5-6ecf-8529-f10b-4f7f06fc7462@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:610:e6::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 71aa7720-e3ae-42ef-4f72-08dac0f3a1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c5PMwJV0yS5+HHMZvKf8jDCB0CG+hyv9vGPcMrIGzYBGvsYtKkrRPIuXP/gkT29PsCNVDTOiNGLIDRIpz641w9TOt61kS8ADNfv2DsoES73UjfsLCtzYSgmelMzIvAwwuI78myy2x9Kc+dMhPA8e5oxwHICT7RHTC56z7eiYJfteXHQQ8EKtrvl+SCX80ArYolk/u6F3ynWlIElsSvQFvpruUYoI91z7mRUxY9UxFD1ubglh1GJVqrLHJucIBIQfMhEF8yKR7EPFchbOPXQzsAk9KWL8gpQkI0rN6LcR6hruEQX8/Vu9K5CtryibckvRtKyDPdWMQY78GMZEV9mgcWwDfVFsMEuIKKQUnMxj9SJsao5FmoQp6oLjeyolQajyR5BkF+aSRyzagLjOmpKNbAsVvbY1w+4uuCDvtC0VrT5KKudVmJlB9Sr5lppNYLQwsPpxIyFT/pbqiwaTaRtZZxRP23YYes3KCiZD5IZbCLaNYMyGY3+nWtzX4PfxejTvOH/DpdGQ/coZJhHk4oFoPYmba4yemFkeDU85YFAPdER0uSM1XeX6BTpxi9qiQkwwAHrUtnSJfQl4kte0WTcvBQuWRtY4ASOfDamS3wEHolDaeJ5VzRumU+jjFBifdyfVXWSWj8ykuTZHj0VjfXEdIsp7DhhZnjNdj9X4kv1FPX2/TXwDhXFTWgDvPdS9g4MwH2oOmdhP/kwFWfQIVjzB+ilwK/a/1od3TUWPN+m4oXDfdee6+sDZJAy7SRqtU8kMjOQ4ofQ6cg/vMTRuLwVj8zc/awCA3E+D7L580kdGC7IGbGHqOwB9kG9PicUU73MPvb6T4u3qg4YtY1ywFUIg6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(83380400001)(6486002)(38100700002)(36756003)(6506007)(6512007)(6666004)(26005)(53546011)(478600001)(66556008)(66476007)(5660300002)(86362001)(4326008)(66946007)(2906002)(31696002)(8936002)(41300700001)(8676002)(316002)(2616005)(186003)(31686004)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzhrVGpqYjZWVWducUh1WU1SRTZsVXExZnFSRVhiVnkxcjFQZFBRUkdkNWg1?=
 =?utf-8?B?VHUzTDBhNGM5cGxGK1c2SEpidFEzN1AzMGJneFR0V1hTQVVJdHoyUWhUdVVj?=
 =?utf-8?B?VWtXSU9ZbFdKK252YkRCamVSd2xvWFY2QlZxcXExT1VJWktrVUJHb3l0c1Rk?=
 =?utf-8?B?MmdHMS9lMVArR0tLSC9GbUE5U3Rac0tJUUM0ZmVwQ3Bvd3gyWFJVTlJJRVI4?=
 =?utf-8?B?MGtIbTRFQSszMU8zQzJOY0tWSDNUR2pXU0pPcjhOTUN5VnEzY3h2WENENnhD?=
 =?utf-8?B?czNRVjRMbnZqc2thKzYxZTZNOXc1NHpHVEhkUUNyZW5jWUl3WDVjSkEvaTRB?=
 =?utf-8?B?eUpqM0RRTk1NN2pQaEdpZi9JKys2T3F4Z3U1elhobnh5M1NHV0tLc0oxaUF4?=
 =?utf-8?B?allRQ0ttT3VQT2Z4WVBTS1ZJQ01WOWRmcDdUT0Q3V1pPRU43VDhnOVBWaVdk?=
 =?utf-8?B?N2k0M0ZQaytXaFlidVZpYzZDYTc1bFJicVA5TURJTGt2ODUzYVRYVm9TTmln?=
 =?utf-8?B?bGU1Q3orR2Ntd1hwVDZ5WmZFRlRZcUxKOFp0NWVwdElreE5JODl1WXRqZndo?=
 =?utf-8?B?RzBHV29UTzlWalU1aHU5QmlMRnF1YzNGQWZnV1ptZCswejgwLzM1SldDZGhm?=
 =?utf-8?B?cS84a0NkYVZmN3N0NmowcGFZeGNCK1FVVmVwc3pKZ2IwWWN0SDBWSGlrbHdv?=
 =?utf-8?B?Rk9DN3Q5NFU0M2dUcW1Yc0V6cmJrdU0xdkJRL1F5Y3d6Znp1VWpDeXkzbGNi?=
 =?utf-8?B?ckVIQlJZUlFnTnJWYndwSnZYSmpCaDlRTncwZ1BlRis1c2ZaM3QwMGdUZEdh?=
 =?utf-8?B?c29XY2lsZnByWXdXTzlZcEJyaE9HSWlOSzVvdDBaTmNsRVYyaU1Ba09nRzht?=
 =?utf-8?B?Z1JlMmlZaTBrS1dGVmtQRlRFRzhoNEgwb3ZYTnlFWU9ST1ZHU3VoakRoVHZ5?=
 =?utf-8?B?bDMzTGFQdGN3N3FYcTVnMXV6MXVOem9FVWxiZFdKYWY4a1h3WmJBNjNJNlpu?=
 =?utf-8?B?SmFwTmVHcHJieHM3eGIvZnNqQzJSbDJIN2JwamVlNEJOakY4QncycEtqMTdo?=
 =?utf-8?B?RHl6YUNGT3dzZVJnenFkVHBIRjBsTE1lcXRkMy9PU0k2OGxLWW0xRGdvTWkv?=
 =?utf-8?B?aXJjRXV0ejdnMVJuVmdYOHg3bDl3d3oySGlPS1lmY0JRUlhscEErc01RRzFv?=
 =?utf-8?B?eWVvYkRMVUxuUk5XbUdlbmhzZGxiY01UQUwrUHJsVjBmTE5iMUZwMjR5d0lJ?=
 =?utf-8?B?NTlleHhWTno1YXY3Z0hFaEVyRkpwSmxFcFBnWDlubGRxSTdVbVJIRlRBMTZ0?=
 =?utf-8?B?aE14Mms3bVdrRVNXM2I5Y1Y5SDV3UUI2NWZiV3gyZjhDcjhFTGVLdnlsclVX?=
 =?utf-8?B?TFZxcFY2KzA4QnI2b0dydGN3QkszeHQwVlRFUmJTWk1VNzBKY2hFdjBVSmVK?=
 =?utf-8?B?RGpxQ3o1R3h3Q2ZiTlp0VHNtQjVOR0c1N2ZhaTJvd0txR2tqOVFFMU9HUTBE?=
 =?utf-8?B?V0ZTNWtobEovMXo5TmI4K3M3V002d2xqYjl0d1pqcHRYN2t4RktyRDdEdVc4?=
 =?utf-8?B?S29oUXY4NnNkRWFkR3cyQ21ac0oxV0R2S2JJVGhrSEZYVjFLRUhCR2tLUmNT?=
 =?utf-8?B?TzZHTHZlSUp1YWo1dG5vaHNaM1JQRnBBb3B3eXRxQlF3T2h1Zjg4ckwrNEdO?=
 =?utf-8?B?RS9ZODBFdEFjNmtKYnRhdFZKVjZ0QVNWLzgva0ZiQzJORjZMckNRWlRIQUtt?=
 =?utf-8?B?UzVKcS9CUnVRNGxYOXk4dUVwOW5tMythVmp6ampUaHZnWTlqWmdIb25wRG4w?=
 =?utf-8?B?MW1RRFd0UWpRMzcwdCtoenJlc0NjSWxFK0g2SFRzS3VLbzNxTFc2cTRIbENT?=
 =?utf-8?B?SFRWMVoyVGNRZjNXWGVYaWtOcjhXY0RMQkdpMkdwd1NGSFhVYjhDVkY1QWxO?=
 =?utf-8?B?K01JWFUzbjV3S01RK0J0WkJWN0JYVjJZSVk2MUtHZDUxM2FEcW5OMUQzWVZH?=
 =?utf-8?B?dnJSRG4vWHM0SzgrVXJxSzdkKzMvSzNTQlh5SjQ5WS9NSHBSWE1xbVFON0ho?=
 =?utf-8?B?WEpmakVIN1JxVlJvUFpBYzd6Tk1ONWF4VDVNOG9INmliQXRqTEp2bUdvdUFi?=
 =?utf-8?Q?Gs3pOLXrF6UviR7bixvRKpYRm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aa7720-e3ae-42ef-4f72-08dac0f3a1a2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 19:09:44.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ach/kagsG1Acud6K5P5JTUR4I1IeC2myxFUpDms2z0/I20qCfb9BJbB6i1wRARxlpvDIOUYxLKlYeVvPUJjtpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 12:16, Limonciello, Mario wrote:
> +wyes.karny@amd.com
> 
> On 11/7/2022 11:57, Perry Yuan wrote:
>> Add one sysfs entry to control the CPU cores frequency boost state
>> The attribute file can allow user to set max performance boosted or
>> keeping at normal perf level.
>>
>> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 53 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
> 
> Make sure that you update the documentation for this new sysfs file as 
> well.
> 
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 841b1e2383b8..6958c5fd9e1c 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -786,12 +786,46 @@ static ssize_t show_energy_performance_preference(
>>           return  sprintf(buf, "%s\n", energy_perf_strings[preference]);
>>   }
>> +static void amd_pstate_update_policies(void)
>> +{
>> +    int cpu;
>> +
>> +    for_each_possible_cpu(cpu)
>> +        cpufreq_update_policy(cpu);
>> +}
>> +
>> +static ssize_t show_pstate_dynamic_boost(struct kobject *kobj,
>> +                struct kobj_attribute *attr, char *buf)
>> +{
>> +    return sprintf(buf, "%u\n", cppc_boost);
>> +}
>> +
>> +static ssize_t store_pstate_dynamic_boost(struct kobject *a,
>> +                       struct kobj_attribute *b,
>> +                       const char *buf, size_t count)
>> +{
>> +    unsigned int input;
>> +    int ret;
>> +
>> +    ret = kstrtouint(buf, 10, &input);
>> +    if (ret)
>> +        return ret;
> 
> To be more flexible maybe kstrtobool would be better here instead?
> 
>> +
>> +    mutex_lock(&amd_pstate_driver_lock);
>> +    cppc_boost = !!input;
>> +    amd_pstate_update_policies();
>> +    mutex_unlock(&amd_pstate_driver_lock);
>> +
>> +    return count;
>> +}
>> +
>>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>>   cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>>   cpufreq_freq_attr_rw(energy_performance_preference);
>>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>> +define_one_global_rw(pstate_dynamic_boost);
>>   static struct freq_attr *amd_pstate_attr[] = {
>>       &amd_pstate_max_freq,
>> @@ -809,6 +843,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>>       NULL,
>>   };
>> +static struct attribute *pstate_global_attributes[] = {
>> +    &pstate_dynamic_boost.attr,
>> +    NULL
>> +};
>> +
>> +static const struct attribute_group amd_pstate_global_attr_group = {
>> +    .attrs = pstate_global_attributes,
>> +};
>> +
>>   static inline void update_boost_state(void)
>>   {
>>       u64 misc_en;
>> @@ -1416,6 +1459,16 @@ static int __init amd_pstate_init(void)
>>           pr_err("failed to register amd pstate driver with return %d\n",
>>                  ret);
>> +    amd_pstate_kobj = kobject_create_and_add("amd-pstate", 
>> &cpu_subsys.dev_root->kobj);
>> +    if (!amd_pstate_kobj)
>> +        pr_err("amd-pstate: Global sysfs registration failed.\n");
>> +
>> +    ret = sysfs_create_group(amd_pstate_kobj, 
>> &amd_pstate_global_attr_group);
>> +    if (ret) {
>> +        pr_err("amd-pstate: Sysfs attribute export failed with error 
>> %d.\n",
>> +               ret);
> 
> amd-pstate can currently be a module too.  So don't you need the 
> matching cleanup path for this code too?

I noticed your patch 3/8 makes this change, so this specific comment 
might not be as important anymore.

> 
> Also, regarding the error messages you don't need to prefix with 
> "amd-pstate: ", amd-pstate.c already sets `pr_fmt`.

Also, shouldn't failing to make these attributes fail the rest of 
amd-pstate init rather than just showing error messages?

> 
>> +    }
>> +
>>       return ret;
>>   }
>>   device_initcall(amd_pstate_init);
> 

