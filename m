Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE0C6D2781
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjCaSFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCaSFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:05:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837051115F;
        Fri, 31 Mar 2023 11:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOS5nEnmcY/MsVi8UrZ0BF+HzxXlfPrpEK/f6oGdn8GuGRG2r89ONPRkYO3E1BNHFBJMBRC+2KFsBYccebIL+W7+LtWBttk0MkC3DuQdLPDCbsqSI5RK6f3rP+cgCZtmmgw57f1Ao3R22YFROvl3rz9MaegvPMtJrkj4MhMJEC21FagbYP0Bgyh3r9lC+O35uY+jlURTIsCQHdAbRn3RlmR13vRpPeFvtbC7IuxwF50seRYFv+ep06hLruceT36R0E/tfR/r9kuN6kHwEiYL1qYEGn5sOyxOTCmYWT8KfIak+5Mpyl/7Ni/Si/eAQwgR9WPjwNAhFpQMKKBG90W7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LesfnOEdqDTt6TanmE+mE/vMBuOkY6wG+/A3RgvYU6s=;
 b=JMKAgcP6qXNzIZqcgQgGkhZL/oT1zaQmaYjSaodFg9W0arQAnCibM2E+OASTgZ3Cqg6ICBGhsG0lhJShk9OMC7TAbww0O9LVD7xhh/QhpLhhoiET2qVAjTYvW/BlGFdLX6zXq4KXYtbHWoRP0Q2OVG6C7v08mgrMn8bXJM2E61N/RvXsHkvaWzkfeeBIoC+FwH9GBe1dAz67RKTRtBf3NSoqIqSywWg3Fc/lb6F4Icl7P60k3TR+W45B+ny9fsdX4nIp6dNzfLvZ2Bxujhu96hnN8IMQrCfXA4XQOkWKCJs9i1hX+EbncDkRMvfuUOSEk5lqLRoKOZTkeNl3hYg8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LesfnOEdqDTt6TanmE+mE/vMBuOkY6wG+/A3RgvYU6s=;
 b=A/LmNsH55z7Tvje9wMM+zap/2lkfWDWMrX04T1qWq5YCuDQeh9Z+rQtefrPj8Ryyu/laTFDmQnZXZuojiX8z7tmjg0LJ9FKLffrCMw9kkw4NyKfBIidTvSsx/OpY1FY751OSJYgWSvZP6Wrnwkq0sBzWf+egGMqz3zW1KABe750=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 18:05:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 18:05:12 +0000
Message-ID: <2676888c-e93f-53aa-a4f7-e85b66f351c8@amd.com>
Date:   Fri, 31 Mar 2023 13:05:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 1/4] PM: Add a sysfs file to represent time spent in
 hardware sleep state
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sven van Ashbrook <svenva@chromium.org>,
        John Stultz <jstultz@google.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Raul Rangel <rrangel@chromium.org>,
        David E Box <david.e.box@intel.com>,
        Rajat Jain <rajatja@google.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230330194439.14361-1-mario.limonciello@amd.com>
 <20230330194439.14361-2-mario.limonciello@amd.com>
 <CAJZ5v0jbMXk5k_KG19bQnffhCkGnu=MQXjGrBPipZxA_Cg8O9w@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jbMXk5k_KG19bQnffhCkGnu=MQXjGrBPipZxA_Cg8O9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:806:d2::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f666fe4-479b-47d2-5d9f-08db321278a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcFgb7a+vSmgHgPT9GzSSKint+HWr6uRe7WEtU+48MkfTNa+B2hbKo+q61AmaBtUgDMvfZQbWF9P4oIldLcg3JB5HCnrl8TJATf5ViW98E4GvBZFEEPmr5Fz/yOXBVmHJx6SWk4tfA39adCI/+gJdFLOX4RitSwpkehi57/Z5J/FFiKlXe8tKqCY2m11vjNkXj2zNwlDdEERbNWmKyNC7Z7o5VEMCX62a36WiuTVVdNDlS6MGiegT7jqJqVLN+1ApFoT3cDohLlheuU7LBHn6ZHIb7TQo2j86mzdy44XYNwwoluECFse6KFbe4KkZkLCaBTDnPaPrP3tCmzdtyfCOLed6lxzgoTk6fwmmZol/gtw0DzdCCUHX1GwiGdxVfsOkliM8yN9p9h41A7MOWkkCZ8MY4LCJ8/pmjEaqIHKc9UhUXZKc3KKZSIojLwmnhb+d9YnS1JQ5z+fDLpg3tT8tm0KQUMkHw3H6OxH6h8u+ox2tb8mmPuq20nfDKS9rzOUVW65+X3VYXwe2ZBsI0nW3DaLpP9ZdFOTaAMrzS1Hpkphy/WcyJCDGBj/+pxNKjhT7dz5D+C33sDsUIrTRmdO5wetbRCLYhIIaypomMOt+b2ojckW+YUg14/lBmrpVPXaV/p9fn31NQy+KdP5gCo8zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(8936002)(7416002)(5660300002)(41300700001)(38100700002)(31696002)(86362001)(2906002)(6666004)(53546011)(6512007)(6506007)(26005)(6486002)(66476007)(83380400001)(36756003)(186003)(31686004)(2616005)(316002)(66556008)(4326008)(8676002)(6916009)(66946007)(478600001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkorN1EvS2w2dis3clJtUzNUUCtwUENlY0Znd0VXVmpjK20wWU5GcUxlSXQv?=
 =?utf-8?B?NWZ2cTNsYlh3YmxGVlVrYWVPOEwzUENjODVtZzRscVBYSzVKMTh0YkRvRis1?=
 =?utf-8?B?QmNhaWxDekh0N0R6cXc2MFNldUpZelVuR1BYNUQ2cHM3LzlrZHNqSTd3dVRS?=
 =?utf-8?B?Wm4yVW5FenhjdmpLWWtlMW4xaTBVNjhFelMzbmRndmF1WHhOc1V5M2JyM3hI?=
 =?utf-8?B?SzlnYWtmRnRFUTkzbVlLLzI3L0FzV3lTRFE5Nk03OHlONm5xR2Q2aGNFNTVv?=
 =?utf-8?B?aDQ1Vk9xYllSRDl4c0xZN1dpVC9mOHM3K2llakZvVTZaQWNQMktMU3JNS21j?=
 =?utf-8?B?eEJPTjIrUnN4Sjl5NjgrWGZqRHJIaVBXOCtSVG5MbzNEYmthbDdLNVVieTNa?=
 =?utf-8?B?MXZFYXo5YjJMWG9jTVVUWHZyMlZrSVhhVkhTZlhvWTRCeWRiVzJFOUpTVHha?=
 =?utf-8?B?K0FBR3ZMYmd3TFFlT0lYb2NpK296Q0FBeTBibStqYU5wVGRJUVhZRlpHa25C?=
 =?utf-8?B?eW9iQ0ZnZXNTRVBVcWNsTGl1d25nY3ZiWTdDL0YzSSt3YnZiR0EvYWlJTFNx?=
 =?utf-8?B?NjRwZmZHQ2ZVcDFWamZaZDZzSmVhZzlVZTE0RjZqZFAvYitobTJicWEydzdp?=
 =?utf-8?B?RnlaZGtUK1NaR0lUOEpNVTZ5M29WOVJBTXpNWVVFb2x5VUFDYmdLZFIyaW9J?=
 =?utf-8?B?SXNmbE1rOXMrMnFDVHRHZC8yazg2d3NNYUp6bTBpaXFqdmZwTTdLcnpkcnBs?=
 =?utf-8?B?RkdwRy9qczV5aTBnSTNWbm0vR1BuTjF4VktEWG93d09KekhabE83VzFIaWth?=
 =?utf-8?B?cTY3K2dGb2hkdnFtTFR5OEdqYnRQZmRLOHZuR21hZ0Q1UHZsUnMrc0FLZzFS?=
 =?utf-8?B?SHZjSEh1UDgyMlVUM0lpSHdQREtHZnZZWkEveXgzQmJzQkpCK0IyNysrczh2?=
 =?utf-8?B?UGVHYzJxNjd6ZTRHQnRLSU5RenJITk11eW9aU3hmRExSYWFZYzZhRlRJRTIz?=
 =?utf-8?B?VUt6Y1BjMmtmSGRPcHRnWHZibXMyQTcxZmt3N1pZR05hQkdUV216eW1BZEI5?=
 =?utf-8?B?Nmw1QWJnM2NpOWZXeUtaa3JaWitXdmxsc2dTaGxpSHNUam8zaDh0cjdSNmpM?=
 =?utf-8?B?bG1aMzU3WnVrRGdFUUtTQ0JmVm9DVnpFenBiZWZMQzJqMURJM0NTWDdFSkMr?=
 =?utf-8?B?dzEvQjNwc1dUSDdTa0NhTDNTQXp6ZlcrNnVHZTJlc1ZUd3cxdFArM2xXZDRi?=
 =?utf-8?B?NG15Z2JSNDRmRjc4YUdBbEY2QWtPTVV5dXNlRHUyd3ZuUkNnTEwzK3dvQ1dP?=
 =?utf-8?B?TW5mL1NvWmozek4vdUxWdC9iNXZVbFV0eGRyMEM4YzZEdU56MzY3cUNXZUVm?=
 =?utf-8?B?TU0vZGZmYzZSUWxvSi81UWRyNHR6QWlqa3NsMFVmeHZhd3RadHZsTytSOGVS?=
 =?utf-8?B?Y2pNVDlqQTV5bi9FL1NVcTBtR3BUaWl3SXp0RGRKMytwYVVmZEYzL056VkFE?=
 =?utf-8?B?VDU5aHB6dWp1dmdheEY4SGdoY3JCazlDTTF3S085SG5ld2t3WHlnV0FzKzF1?=
 =?utf-8?B?TFMySE9lVnFTUnNQbjZBdUZ5V0tSb2xYY3RQYlFuY1FWUjVCU3M3Y0N6ZkZI?=
 =?utf-8?B?VHNqMDFyZ2JGUWdsd2cxNGpjbk05K3UvVGduY0xHVmVEcnkwcWZLbTdlOUNG?=
 =?utf-8?B?ODFkZGQ3Qis4NUovVXpZYTc0enQ5Y2l6TzVGaUx3RHRvK2VWMG10SHlQYy8w?=
 =?utf-8?B?SzN4MjY4bnRkbXF2UkRyM0JaQUdFUXJkRUZMVGNSMHpiMWlab1FEcDFUKzNp?=
 =?utf-8?B?UGZ3NUo2UzRqZ2dYSnowaWNqYzdOTlY1YWRxM3BCWldVc0k3NVVzSy9ma0hE?=
 =?utf-8?B?WG9hSm1WWTNsUUIxSXZxVnViNlpkT1piY3FLZElHU3FuaXMyVGtzeUtGUjFs?=
 =?utf-8?B?YjFWRE4wTk9LT1R5TzBXVVBkZWFMQUtzZ3FWcWdzNkl2YXdVQWs3ZmV6eDBS?=
 =?utf-8?B?OXRNWUpQUHQvamJiSTB3M2szK0hLaVNmNFIrZmNVaDBWT0ViK1RuMTJ3U3FE?=
 =?utf-8?B?UnBHMHVVUXZXT0tLZ3VkK1Y2b3VHY3A3RzNsZUI5Z0NYZ1hKaktBVjlTSGcz?=
 =?utf-8?Q?2DPb0v195/dJF5jwp/SeX9uN6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f666fe4-479b-47d2-5d9f-08db321278a3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 18:05:12.0056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TXztOVDAw++2h54E61zE0HhUD1UVdSOAacytALUxADOlx/Ydv1ZudZGCBd7MhDeRCIhSwCG+gRfT4jmB+3z4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/2023 13:01, Rafael J. Wysocki wrote:
> On Thu, Mar 30, 2023 at 9:45 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Userspace can't easily discover how much of a sleep cycle was spent in a
>> hardware sleep state without using kernel tracing and vendor specific sysfs
>> or debugfs files.
>>
>> To make this information more discoverable, introduce a new sysfs file
>> to represent the time spent in a sleep state.
> 
> This is only in the most recent suspend-resume cycle, isn't it?

Yes; that's correct.

> 
> Wouldn't it be useful to have another attribute printing the
> accumulated total HW sleep time?
> 

I had considered this; but I didn't think it was actually very useful 
because userspace will get control at the end of every cycle and can 
accumulate those numbers if desirable.

>> This file will be present only if the system supports s2idle.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v4->v5:
>>   * Provide time in microseconds instead of percent. Userspace can convert
>>     this if desirable.
>> ---
>>   Documentation/ABI/testing/sysfs-power |  9 +++++++++
>>   include/linux/suspend.h               |  2 ++
>>   kernel/power/main.c                   | 29 +++++++++++++++++++++++++++
>>   3 files changed, 40 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
>> index f99d433ff311..9e0c31b9ce85 100644
>> --- a/Documentation/ABI/testing/sysfs-power
>> +++ b/Documentation/ABI/testing/sysfs-power
>> @@ -413,6 +413,15 @@ Description:
>>                  The /sys/power/suspend_stats/last_failed_step file contains
>>                  the last failed step in the suspend/resume path.
>>
>> +What:          /sys/power/suspend_stats/last_hw_sleep
>> +Date:          June 2023
>> +Contact:       Mario Limonciello <mario.limonciello@amd.com>
>> +Description:
>> +               The /sys/power/suspend_stats/last_hw_sleep file
>> +               contains the duration of time spent in a hardware sleep
>> +               state during from the previous suspend cycle. This number
> 
> "during from"?
> 
> I would say "in the most recent system suspend-resume cycle".

Ack, thanks.

> 
>> +               is measured in microseconds.
>> +
>>   What:          /sys/power/sync_on_suspend
>>   Date:          October 2019
>>   Contact:       Jonas Meurer <jonas@freesources.org>
>> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>> index cfe19a028918..e0f2ac5f4406 100644
>> --- a/include/linux/suspend.h
>> +++ b/include/linux/suspend.h
>> @@ -68,6 +68,7 @@ struct suspend_stats {
>>          int     last_failed_errno;
>>          int     errno[REC_FAILED_NUM];
>>          int     last_failed_step;
>> +       u64     last_hw_sleep;
>>          enum suspend_stat_step  failed_steps[REC_FAILED_NUM];
>>   };
>>
>> @@ -489,6 +490,7 @@ void restore_processor_state(void);
>>   extern int register_pm_notifier(struct notifier_block *nb);
>>   extern int unregister_pm_notifier(struct notifier_block *nb);
>>   extern void ksys_sync_helper(void);
>> +extern void pm_set_hw_sleep_time(u64 t);
>>
>>   #define pm_notifier(fn, pri) {                         \
>>          static struct notifier_block fn##_nb =                  \
>> diff --git a/kernel/power/main.c b/kernel/power/main.c
>> index 31ec4a9b9d70..6a2bf8784ce8 100644
>> --- a/kernel/power/main.c
>> +++ b/kernel/power/main.c
>> @@ -6,6 +6,7 @@
>>    * Copyright (c) 2003 Open Source Development Lab
>>    */
>>
>> +#include <linux/acpi.h>
>>   #include <linux/export.h>
>>   #include <linux/kobject.h>
>>   #include <linux/string.h>
>> @@ -83,6 +84,12 @@ int unregister_pm_notifier(struct notifier_block *nb)
>>   }
>>   EXPORT_SYMBOL_GPL(unregister_pm_notifier);
>>
>> +void pm_set_hw_sleep_time(u64 t)
>> +{
>> +       suspend_stats.last_hw_sleep = t;
>> +}
>> +EXPORT_SYMBOL_GPL(pm_set_hw_sleep_time);
>> +
>>   int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down)
>>   {
>>          int ret;
>> @@ -377,6 +384,13 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
>>   }
>>   static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
>>
>> +static ssize_t last_hw_sleep_show(struct kobject *kobj,
>> +               struct kobj_attribute *attr, char *buf)
>> +{
>> +       return sysfs_emit(buf, "%llu\n", suspend_stats.last_hw_sleep);
>> +}
>> +static struct kobj_attribute last_hw_sleep = __ATTR_RO(last_hw_sleep);
>> +
>>   static struct attribute *suspend_attrs[] = {
>>          &success.attr,
>>          &fail.attr,
>> @@ -391,12 +405,27 @@ static struct attribute *suspend_attrs[] = {
>>          &last_failed_dev.attr,
>>          &last_failed_errno.attr,
>>          &last_failed_step.attr,
>> +       &last_hw_sleep.attr,
>>          NULL,
>>   };
>>
>> +static umode_t suspend_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
>> +{
>> +       if (attr == &last_hw_sleep.attr) {
>> +#ifdef CONFIG_ACPI
>> +               if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
>> +                       return 0444;
>> +#endif
>> +               return 0;
>> +       }
>> +
>> +       return 0444;
> 
> if (attr != &last_hw_sleep.attr)
>          return 0444;
> 
> #ifdef CONFIG_ACPI
> if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
>          return 0444;
> #endif
> 
> return 0;
> 

Ack, thanks.

>> +}
>> +
>>   static const struct attribute_group suspend_attr_group = {
>>          .name = "suspend_stats",
>>          .attrs = suspend_attrs,
>> +       .is_visible = suspend_attr_is_visible,
>>   };
>>
>>   #ifdef CONFIG_DEBUG_FS
>> --

