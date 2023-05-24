Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E18E70EBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbjEXDnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjEXDnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:43:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CA1C1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1BsMDFZjCsB5KoBMTEyZbexGO6zJqnPWz+roF+NPsF1JSqQLElwG6MJtmnRoS67ZZ4rzmS0MN3MDs+eWY8MEvGkI8sQcc07z990JvXsGbvaREkQG6jw26c0gDKV+j+LpZsHNvg7RiEv7lrpgz6zx4fqgrjgUZgpOFtzZd2jn9PDYkNO1dnVEM1MjpRqPq6sLEF0r+jfSp7dn+UHIQXhPwIfTLGnD6CPiBw0YMmyIqP/1N38aPwAx/wS7g0+kWghV1AERe6rJE821TFywjZILFwEJrlbXbuwaFwKPAaeVdfOPPq9AEcUsYayExBlWNTSB7GGMSChyvzo3rOuVE5BXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go8rm9nsLOfTaj75EdlYmB4QPwnbKS52X8x6VsPHmCI=;
 b=k0jt6ZqTLFVOvlCVwc1LoH3ezjtAdMd0PHWsT3K//zhoB1JjK0i9KYL12JaEEEmtoXG1l62AM7poEYdT1tePTJ9WMPGLzmL2ZXeer8sanHqpGWBgzWUg37+yVJqw33CNnRJAw4hQjtVh7QirON25LFnmzNCOse9aMrPz3stGhGIfTmFOqbYAoEtNl1yqzpCxzywzSrln+o3g2UoQj7Wb9H6KWl7pdAstJG5NJwq6KqHE6bB7pZrscQpmRO9ixMyZDbS9+dDQRr9A9kNTnPqDmhK23ob0P4ytGFiDbKVT9g7GgWHmj8JQQVvZt2pkM1zn6e4i+03k/WWRlIykbf/Cnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go8rm9nsLOfTaj75EdlYmB4QPwnbKS52X8x6VsPHmCI=;
 b=dmo7eytZbG0tASMBuHIWWvHKHm9jWn9bU1sgiyQQxNYp+oHTAypoP9eq0B79n4eMx2D5vONM/+jWEHQg6Il1Id6mEa9Rv7dXcRSxJmGG//wRdJeIoVB4Yhx4K3/N6m5/9UUNQt2S6FdJ3oUc3eSoi1VdkyiCmxyZx/ABRsi+TYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 03:43:39 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 03:43:38 +0000
Message-ID: <31f30fb6-5988-ab19-b155-1b598025c049@amd.com>
Date:   Wed, 24 May 2023 09:13:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] drivers: base: cacheinfo: Update cpu_map_populated
 during CPU Hotplug
Content-Language: en-US
To:     Yicong Yang <yangyicong@huawei.com>, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com
Cc:     yangyicong@hisilicon.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, yongxuan.wang@sifive.com,
        pierre.gondois@arm.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, prime.zeng@hisilicon.com,
        palmer@rivosinc.com, puwen@hygon.cn
References: <20230508084115.1157-1-kprateek.nayak@amd.com>
 <20230508084115.1157-3-kprateek.nayak@amd.com>
 <32bd2ca8-30f1-204e-898f-fc93bbdd2e14@huawei.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <32bd2ca8-30f1-204e-898f-fc93bbdd2e14@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::10) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 715cc723-b29b-461f-7c92-08db5c090f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgB93rWUFsCWn1nvqEACkLmwNoOQLdUHL/pIoQ1FE8fdmniluQfaEalem+3HQj1Sifqj7YOMeqmuM4aA5rWPhZHOMd6JYIOwdFS+XGhZlsuMAQA2hibZTVI0/OTZ5pMMP7/Bv5U5RlzchIDrS7RJZ9DlRgXOIYI2B6mgsgBkFxkHuowqO+RFNCgygst8YcKR+kurm6t3wrFxHZHa/GiJoUzylDWf3QlRagZ9P0dS7uKWGKmpSRqp+D5MfbosuXLR26kZRNZx5+dH9w3SPWNXu32aFzvc/TrTPmwWim9zQmnBJr4+2VZxlKafd6+euqbnRsN10Ja1FrZzwrEWs2XgsRVOQ0tm9m969ejYlQdy5JV+VH1IqFL7fHLocYS4XuJCpaCiN3yrh5s+Fm6raEOweGHjIK71Ptk6TEkrY2ahxxW0FMLe1cAzqB0q+OVRT9A8kCfn6SG9V3IQM5vInJpcfhkMNzfyygQgXhE91Dnvw1F12CxwV2+pKwl2oXjNwfVkkT7f3Nn0Qv4T4nXk8dwa+z9o4FWp8lWO8msg79hWFB6iCqM6jSGdTkSiXvOmKm9C462lh8ZjDyiMRNUoze2r5SiGXfQJHQOhsTIRPamQCKYg/YaxiGa7meEIT3NEMBgP2sRwUYABWkYxRyrkoC0T9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(15650500001)(53546011)(107886003)(6512007)(8936002)(8676002)(7416002)(83380400001)(38100700002)(86362001)(31696002)(36756003)(6506007)(2616005)(2906002)(41300700001)(66946007)(66556008)(66476007)(31686004)(4326008)(6666004)(6486002)(316002)(5660300002)(186003)(26005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTV2b000S1F2RTdwVG83TVJ5YjNWK2lCcytwbUVFZERCbVZKbis3aWZQblph?=
 =?utf-8?B?M25pS3FoRXNJa2E2VGFQNkxpQUg2eEgzQ3RhZ2FpNDFhU0w3cEloKzROSDNr?=
 =?utf-8?B?bmNGbTY4ZmhwaGU3cHZXRG9Cb2x5U3V0R2I3SzdtOCtyRGg3UXhoaGNKQ044?=
 =?utf-8?B?N013SjVZWUE5bG1uczFMT2kyVDFDWnI1S2IxRGdHUk5QNnJNbHZqdkg2cW9V?=
 =?utf-8?B?bEl2NWg1NW9hOUpnWUpvU2QyU2FBWUplUk5SN1ZXQjJvSEVNTWN0ZFJUdzB6?=
 =?utf-8?B?MFN0STJReDR6WDdyU285cnIrY2ZSMGUranFWV24rZHJuSWpqNTR4Nkgydmdr?=
 =?utf-8?B?b1dRQ3pJdmVVSnlOWldzSENJSWxZUjVKT0FvL0l0alFmaVRlenNpR2o5NHRK?=
 =?utf-8?B?Q0YrRlhNR0dCVXVMd0Q1MjZhTDhZdERpYVJnd1NFSGVkcjVDbjdGQUlqOVFs?=
 =?utf-8?B?ZDdDOFB2T05yNEdZNlM3a1hEVGVub2l5SmRwTlZSUGl4QSswQlllbHpiN3lP?=
 =?utf-8?B?Y3VFMVIrYU8zWjNwQXJMdWNhMG43R0JJczFFUEJ1amloeUhCK1FEcStVNERB?=
 =?utf-8?B?b0hUV3RQT1ZaczB3UTFNNVArOXNPZDh0K1AxUFRoZFcrL01UVXVrSTlsTUpE?=
 =?utf-8?B?OFQ2ZnY3NlhXSHJOMUhBMFJlczh5d1BybzNHVVRvZlZsY1Rvd1RZamo1Y3ox?=
 =?utf-8?B?WVUxamZ0QXBoVEZZM3lITFpRcGMzUFBCRUxwNHp2ejQzamFkWnNmNFBrazRs?=
 =?utf-8?B?WHE1dGgyNlFUeGxWWWhnYVdsWFJPbXlTeDI1QTJDOElCUGxWeG1jclRGT2tk?=
 =?utf-8?B?Ni9aclFVakVseHZQdEVqWkFneVZMc3RVME9kcHc5YjFtMjZMem1kN05LUSsw?=
 =?utf-8?B?WjA3c3l2bnpibFZONzRsbnkxeEpoL3ZvT1ZFNlIwcWtLbnRkK0ZmMVRwL2xY?=
 =?utf-8?B?VlhGZ01FWHVyYVF3ejFOZ29UYnRzM1dlRXJqYU5VWXJDbXdreEtrM3BDMGRS?=
 =?utf-8?B?c1piVk1rRlJhVm5Qcng4eWhuakRnYnl5bm0yM1hENFRXTnNGQXRXSi9lVmRi?=
 =?utf-8?B?WUVMUFdaeFFmazlyY0QyeDhaNGI1WGxIZmg5R0gxbEZEQlZEY2UrUStuaTdC?=
 =?utf-8?B?VWwwbFRkZjlWYmxuVjZaUEZSckJ4WWZKQXc5VHFGc1R5TTlXNGlZb0Nmc21I?=
 =?utf-8?B?d0VDMWVGMGN4anFTQkpOUlF4NWFVYmhIYW0vYXdOK1oxZ2R0UkFINkJITGJU?=
 =?utf-8?B?SVc3WlVDZjFHbG5jZGxzR3cwZEFRWWdOZnhmRVVDcVVHWWN6cjZBYWtQYUFv?=
 =?utf-8?B?WkorcGlRcTBJMFI0c05IQzVjT3ZEZlhiVzFaTkI0VDdNUlkrOEx6a0VFcVQ3?=
 =?utf-8?B?TFF6blZYblhkaWQ0RHByd1VwSzE1QmljM1NjdTlJbUdzaFRBMzQrYlMxSHBG?=
 =?utf-8?B?WDlvbzdsanowaFlVcDlzbWQwajB5UkRwNU1VMWFIUFhOQnNNWFhsNDhDdmRl?=
 =?utf-8?B?RU5YdlUweW5VaGVUdTNmYnpjbXF1bVc2eEQxM25tNk9hMVNpU1dqSjNkWW8r?=
 =?utf-8?B?aGExckEvTGdNZmFjR2dHS205MEg1TG9vM1Y1RWVKVXduWVlERVdDQTYza0dZ?=
 =?utf-8?B?SmYvVUltaitob3FXZ09BcFh1VnJGTVc5WTdwdHpBWVZRS3ViNEYrM3hYSVho?=
 =?utf-8?B?N0JPM2RvaG5vQUpnZ2g1VHZsRGYrc2ZrWDY5YzBHU0F5WUcyd0ExZjdoTlAv?=
 =?utf-8?B?OCtRKzZZekpiUXJvaHAyWnRkOVhUMW8zWTMxTURHMG9xV0tHemdMNVVFb2ZY?=
 =?utf-8?B?ZlRtWU5RdGM3Q0Y1WlMxSVNIVzdiMzNZL1Ywb2ZrTEx0UmN2WTdmT1ZXWTcw?=
 =?utf-8?B?alpxNzFyNW5MY1NMRTZYZVBjcm5vd29VUVM4RXQxcldoTW1wc2diakpiZ1dN?=
 =?utf-8?B?ZUZYR0hPNGhxdUQwZXlUMkhZYUNUUmI2azloR3NjZG1zU3Y4UjVBNDFpbVk4?=
 =?utf-8?B?VE1oRTVKLzlnQzdZdlROendBdWdEN2VtMXJpL0ErdUNuUGl0S1dCVFdheFU4?=
 =?utf-8?B?dmRKemJtdkIrZm05cXJwblQ2alBjUWRyMU85aGM1SlRFOVFmMHE5QXBVNU4z?=
 =?utf-8?Q?c4vzf14RH3AJZrQdyfKjSXas+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715cc723-b29b-461f-7c92-08db5c090f07
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 03:43:38.4524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpHK13Ns3C4Mko7iTZexomyjVqMNbLD/DTPsKhlGQBQTLOJ3XC2ZZd6ZAgoQ0mckRKN3kTTnd95t5+6SRsU64A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yicong,

On 5/20/2023 12:26 PM, Yicong Yang wrote:
> Hi Prateek,
> 
> On 2023/5/8 16:41, K Prateek Nayak wrote:
>> Until commit 5c2712387d48 ("cacheinfo: Fix LLC is not exported through
>> sysfs"), cacheinfo called populate_cache_leaves() for CPU coming online
>> which let the arch specific functions handle (at least on x86)
>> populating the shared_cpu_map. However, with the changes in the
>> aforementioned commit, populate_cache_leaves() is not called when a CPU
>> comes online as a result of hotplug since last_level_cache_is_valid()
>> returns true as the cacheinfo data is not discarded. The CPU coming
> 
> Yes in free_cache_attributes() we only update the shared_cpu_map but make
> other attributes remained. From my feelings we should do all the work
> opposite to detect_cache_attributes(), including free the memory allocated.

In fact, when free_cache_attributes() was first added in
commit 246246cbde5e ("drivers: base: support cpu cache information
interface to userspace via sysfs"), it did exactly that. It was later
changed in commit 5944ce092b97 ("arch_topology: Build cacheinfo from
primary CPU")

> 
>> online is not present in shared_cpu_map, however, it will not be added
>> since the cpu_cacheinfo->cpu_map_populated flag is set (it is set in
>> populate_cache_leaves() when cacheinfo is first populated for x86)
>>
>> This can lead to inconsistencies in the shared_cpu_map when an offlined
>> CPU comes online again. Example below depicts the inconsistency in the
>> shared_cpu_list in cacheinfo when CPU8 is offlined and onlined again on
>> a 3rd Generation EPYC processor:
>>
>>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
>>
>>   # echo 0 > /sys/devices/system/cpu/cpu8/online
>>   # echo 1 > /sys/devices/system/cpu/cpu8/online
>>
>>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8
>>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8
>>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8
>>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8
>>
>>   # cat /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list
>>     136
>>
>>   # cat /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list
>>     9-15,136-143
>>
>> Clear the flag when the CPU is removed from shared_cpu_map when
>> cache_shared_cpu_map_remove() is called during CPU hotplug. This will
>> allow cache_shared_cpu_map_setup() to add the CPU coming back online in
>> the shared_cpu_map. Set the flag again when the shared_cpu_map is setup.
>> Following are results of performing the same test as described above with
>> the changes:
>>
>>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
>>
>>   # echo 0 > /sys/devices/system/cpu/cpu8/online
>>   # echo 1 > /sys/devices/system/cpu/cpu8/online
>>
>>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
>>
>>   # cat /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list
>>     8,136
>>
>>   # cat /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list
>>     8-15,136-143
>>
>> Fixes: 5c2712387d48 ("cacheinfo: Fix LLC is not exported through sysfs")
> 
> It's ok for me to have this tag but I don't think this is the root cause,
> the commit happens to expose the problem. Other arthitectures like arm64
> never updates the this_cpu_ci->cpu_map_populated even after the cpumap is
> populated.

I agree. I added the tag to indicate where the behavior changed for x86.
Fun fact, "cpu_map_populated" was added specifically for x86 in commit
fac51482577d5 ("drivers: base: cacheinfo: fix x86 with CONFIG_OF
enabled") back in 2016. There seems to be a long history between the
cacheinfo driver and the arch specific methods :)

> 
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> Thanks for fixing this!
> 
> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

Thank you for reviewing the changes.

> 
>> ---
>>  drivers/base/cacheinfo.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>> index d1ae443fd7a0..cbae8be1fe52 100644
>> --- a/drivers/base/cacheinfo.c
>> +++ b/drivers/base/cacheinfo.c
>> @@ -410,11 +410,14 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
>>  			coherency_max_size = this_leaf->coherency_line_size;
>>  	}
>>  
>> +	/* shared_cpu_map is now populated for the cpu */
>> +	this_cpu_ci->cpu_map_populated = true;
>>  	return 0;
>>  }
>>  
>>  static void cache_shared_cpu_map_remove(unsigned int cpu)
>>  {
>> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>>  	struct cacheinfo *this_leaf, *sib_leaf;
>>  	unsigned int sibling, index, sib_index;
>>  
>> @@ -447,6 +450,9 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
>>  			}
>>  		}
>>  	}
>> +
>> +	/* cpu is no longer populated in the shared map */
>> +	this_cpu_ci->cpu_map_populated = false;
>>  }
>>  
>>  static void free_cache_attributes(unsigned int cpu)
>>
 
--
Thanks and Regards,
Prateek
