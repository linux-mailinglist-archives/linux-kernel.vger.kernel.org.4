Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311DD629D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiKOPRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiKOPRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:17:45 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783BC2D767;
        Tue, 15 Nov 2022 07:17:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9xPBBQ3wtiozzqGjppy+LFsbSN6QxIPmxddQ5lXk8GDxJrfMiBl0OE+7Atnc7Q+gEoqCHXRoiQuH2V1SL3DAVvavQiveyKxz5uXUOzu+fOeU8tfGHNM/4XTQU+jpvb7kgbG2CI/wxfrRGCeytsuSMww8QVNkUdu2tvYLD2hfKcLZp7an3Oq2MLz4i7dY83uuqkygVvXKM7auKnMA8+GXPCJkHcd6xs0u4Er+XyikQkK2ZkKMRUvKfPnNPBFWj2e9sYrMhj9CtYKblPIVgyyMsmkByfT5sZdJyBklxSXXvjA+znEE8xlLecIf6dPe/ZQgcM7AB2yZbHGdJjQOYfdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGU/k6MfaC6F5kPxiLFoBP44VQGlLAH+SgE8oUXo6rQ=;
 b=aX2O/0JHj1QCyfxjLJa1DTI0bFmTUmOnr1MYDHB9d6aglB0nAmzBsGx0gW3lnl4PmVFnl3XiA2Z4/lZjch+lLjgNzaGdS3liM0Aj5ee7A6I495QHjErU8H8s49J+ajrJmMSebcF5Z5f3PRxmT1/w0LOuC98JZbbRQ3+srfKSiUusTouo2FzD0YL/0wXBD6BY1ZQ08SeAp8cBnBfpSmSD/lvZRW3+d0Oni66WNPKbOlD+eBcYUeUL4otzmK8ipo3Lwbj9gzVC2UxGzac8G2NKcA24WH8LCzUBugBmmU3sZZ6awdL23XxlmxWRyaKiqJmEoLN+D0FHHW4O485NsWR2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGU/k6MfaC6F5kPxiLFoBP44VQGlLAH+SgE8oUXo6rQ=;
 b=iCD69+s6gW6vHHcpaj9WoeQEo0bYpaMHn3ZNdtKpbcZFNI5IcR86INZ7j7zLF0xoERulMdO9awVIR2x+SU4fhw6lLxeU1QuJwtmTKblJNSgf+GhrG+iUT42otY0Vubu2Fay7hfvB+gEBxxxN7sus+JkSDWAE38pZe/MlQB1a0RM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 15:17:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 15:17:38 +0000
Message-ID: <460b23ee-16ed-f1e3-0e14-35051c908671@amd.com>
Date:   Tue, 15 Nov 2022 09:17:34 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC v2 1/3] PM: Add a sysfs files to represent sleep duration
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sven van Ashbrook <svenva@chromium.org>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        rrangel@chromium.org, Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20221110064723.8882-1-mario.limonciello@amd.com>
 <20221110064723.8882-2-mario.limonciello@amd.com>
 <CAJZ5v0iwpSkd_8CS1dq6+rkszeKGygBbeifvugAEEKqA0w1s7w@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0iwpSkd_8CS1dq6+rkszeKGygBbeifvugAEEKqA0w1s7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:5:40::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: b215cb71-d75a-4bb1-7394-08dac71c881b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MujolNoI9Ng94+k9DVGt4oEau1g+MUwdB5RH7hVIPj/rV8tyVY8HfCCVIWDAmNHJl03zxorTMIe0LgE5A36atwDFCyAVz92AE+4kBkSCJ3lgCTEQHcbdImAXroqxw3Etd2coguR/qoA8b6UIYMwxyxaOmnHUvdI/P7l3uLw2lkJ9T8YRCWAm8zWbqq0N9BL3L5ffvit/T3RRwz02YXP8NqiMMUKb4lPIA/M/utzltROMaG13zAtiFL4+c8Xfv+UxG3aVEN4d1j3loW7OC9Dfz5FqgFGmoFDJ9BS17gLq3zqMgv7i0falcEQwtLgcpkDb1LARFVPg2+jMpnxaw9NubwOwwmye2dKAzR86g4PDjvVPabYRqZWetfY+xhh9gZTrxvPnDCrvQd3Jy21+wk6mOk7W+mUgA+4FAXNibK1TDMe+wSSWAeeJTpMQO3my0U0E1rU9Wez3VCYRL1LPvVrbD5TdpPS85dR/mGOK2UAOWdB1FhDhBVIvEqk3qmDkwdaNhQ2m4F/m78cioDziDn1MkNZNblGCpZ62/S2Xv5772O2xJrJ0PwGsSq9hlOd0tV43ea6Yk06PXSAw8R9LcBoJeWtW5LskvdHtvPIhDtFq7VpztB4i4T/dhTzvUF9XkbP9x1lqHNE3Bsk3rLS4mBt/7daoKGMIw09J12cWb32T2nD/4m/k+DkLZx3pPtMxyzI160RE8Gn5OZkQFfansURgvwAa1DN4DMM8EWDpM+auYLw5B1VMWuRSTEyYVi5IslDcr5EeGCBXrVaWhH/W+wY1WjgJqiT1JDwBoe8BO1UM8wE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199015)(8676002)(186003)(66476007)(316002)(66946007)(4326008)(66556008)(41300700001)(2616005)(6512007)(7416002)(53546011)(8936002)(36756003)(5660300002)(31696002)(38100700002)(86362001)(83380400001)(2906002)(6666004)(6486002)(478600001)(6916009)(31686004)(66899015)(54906003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajAwWDNheEQ0WUdZTzREOXhmUWFVQ1pWUjZpU3lNRWNKQ3F4aFlPbVVFNXRt?=
 =?utf-8?B?UjFoNkFIcGVmb05OQitMZHNEQnA1eTF0NVhHY0ExaVhMWDViQXF1SkxhZnBL?=
 =?utf-8?B?emdOSVo2dklRWDFRenVYQzZ2WUNUc0tPMVlxUEtSTWpHWXNMV1dNNGZ0dWta?=
 =?utf-8?B?M0lJVm43V1lkVVd0S0Z3UlNaKzVFOXBkbEx4R05ZM2xSVWcxMlA3NTg3dE9B?=
 =?utf-8?B?SVZQTlc2b3FycEh0YXJSQjdJTjhWZEtNaGp5aXU3c0pFZ1RZOEZpUjdzcGE1?=
 =?utf-8?B?VjdldE05Rng2TGJMSHFqMWpzSk1JUW9qN05vRlBNM01tdlRNdHNaQXpwZ0Fn?=
 =?utf-8?B?UXh6SURPdzkzVDhOdFF2am1JenlXcEtjbW16aXJlOEUweFlOYUdhem9paW9h?=
 =?utf-8?B?MlBKbUlxMk9Fck1RY3JCOG9iQlpQYm1VT2l6YWlFQTVkQmxOenNINWpLcFhK?=
 =?utf-8?B?dmduTmdXQUhBWFBKQ1B6ZGpQMWxiVWZKNEZkWGZzazBVckcyNWtMZkQ5aXQ0?=
 =?utf-8?B?bUQ5ZkFXb1ZFVzZwaTNocmVWVzZFTnFObm9HaWN2Sll1QUxQNjlybjA4TytK?=
 =?utf-8?B?WExEbklOZzhCMDBzUXhJK05USlgyZjFWbC9CbGh4dXVReUtETGdKZ2laSTRI?=
 =?utf-8?B?bUZ6SjZ4amxXQVNNK1pwRlNTOU5VczQ4QUZuQlE2V1RSQTNxQ1hWa0Q1WGtr?=
 =?utf-8?B?ck5HZ2NheWxmUjJyUXBYYTB3Sk50dyt1akRJbjFiTEQ3bkVtUUhvQmNEWVZo?=
 =?utf-8?B?TnBueU5ONGVyTUdta3NiS1pURXJ1K2IrYlBEeitwNVpXOHZTKzZNb3ZEOGlV?=
 =?utf-8?B?ODQ3S2laZzh2MUNyZHM4VXZ5eXpVLzhpd213TXdERk5HZVJwZGJUVVc3NGZN?=
 =?utf-8?B?OG9hZ1d6RVJ1dWk4YjVNd1NZWGNKS25Zb0RRWUJpNWdka1BNUFM5QS90bi8v?=
 =?utf-8?B?Vk16Y0U2MzA4ZGRwQmZndHhudlVUU0h1T3IxSytid0MyMmJHbU9lNk9wclYx?=
 =?utf-8?B?YXRlUHFTUWRwWnp0L3hORmRrclo5Q1B1eWhmMjlEM0NXeEVleDQyZWpML0wz?=
 =?utf-8?B?L2xUdU4reGRhT2dzQ1J2NE0ybDFHUXkvUmZyK3J1aTZxWXRmWVRwNFVXcVNl?=
 =?utf-8?B?RjkrOTFDVVdDMFJCY2F2a2F4Rkl6THpXLzNwNm55SExrS1lPN0x4MWtjTUNS?=
 =?utf-8?B?c0JjMkZLb3BvQjRvd3hmWkN3WTZLWnBIQmc0VEI5eDlVY3ZIQkE1T1dTcXB0?=
 =?utf-8?B?aGg1NWN6U3Z0UTZWQUFqeHkwRnBHSldmSkVndXJnMFlSODRrdVpZVEp5U2lS?=
 =?utf-8?B?TCthL2VwSTc2SG9HSlVSUG1FNm13ODJOS1hFN0dLT2Exd3NEMmxCQXB3dUJF?=
 =?utf-8?B?bis5dTBEY090d2grM0RsOWxtRmtkcVYvL29QSnZRYWNDcXkwUXQ1THZpbDZD?=
 =?utf-8?B?cVZVcHl0VWNNL1V1dEY2Q2ZZQTIvRUJjalJUMU1GNzBGclRGSEZBNEV3N3RC?=
 =?utf-8?B?ZXkwMk5RRk5tamJXbUdic0t1SU1Vc0d4cHJOSmJOdThDL0MrdFRJVXVFWHhT?=
 =?utf-8?B?UU84eXgrdlJVS2NQSENjajFJTHJRb0tienVwbFhQRDJJOXNaVnYweDhUd084?=
 =?utf-8?B?THV0NW1hdUdDZGRzTVIvd1lRUWk2K00vVGhOeHp4Wm5vODBYQ0tqM0tkU3Ev?=
 =?utf-8?B?TDR0UlRYR2NIcFlIRlpLZGJvQUYvblpUVTFGNW90WjdLeWcray8zTzRScGdK?=
 =?utf-8?B?SndseVEzSnYyd3o1cEpkcEpvTGRzS1JPekNFbUUzREJZVzlnYklxWEJtS1pT?=
 =?utf-8?B?TzRTdVNRaEZOZDl1Ym5tVENjc3dSVEJIZzU4bW9BNkpRdy9QaFJsZHZCYVVO?=
 =?utf-8?B?bzdPYWd6ZUVPdnVORDEzMlFoYUlHYyt4Qkd5MDBZbHE2YTM1Vk9zTHFJdzlY?=
 =?utf-8?B?K1A3N2lzdDlxdjBTd1ppamJMZ0I0TXIxNVRiUGFLK05Nb1RxRjJQeWQrSng4?=
 =?utf-8?B?UVVqT2NCa2VVeGZLY0g5dTZhK01SZUc1cmE2RHdvY0NOWHJkNTN0UXd6Yzdt?=
 =?utf-8?B?aldpSXozbXJrMTBnc3krNjByZlpkeFBScGpTaUZpYXZ3cnJIUUtSc01RRWtX?=
 =?utf-8?B?NjhmUDk2UWRKaDRweGNCbXFhZjhpRjlmN2JnOGpuN0xHSGtaVWhPeVRVWnM3?=
 =?utf-8?Q?8ulD1rutxbHQcGUri2yc0uNgu11DapxsfPkLAM+Igj47?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b215cb71-d75a-4bb1-7394-08dac71c881b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 15:17:38.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoQ+aFCDKEs52f6shHKYplgTJ9lUIdhFV7LVzrctvjBT/RaKco9nOhnxM0bNbBw2kIcJ8TrVG/at3r1tum5ZhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/2022 08:45, Rafael J. Wysocki wrote:
> On Thu, Nov 10, 2022 at 7:49 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Both AMD and Intel SoCs have a concept of reporting whether the hardware
>> reached a hardware sleep state over s2idle as well as how much
>> time was spent in such a state.
>>
>> This information is valuable to both chip designers and system designers
>> as it helps to identify when there are problems with power consumption
>> over an s2idle cycle.
>>
>> To make the information discoverable, create a new sysfs file and a symbol
>> that drivers from supported manufacturers can use to advertise this
>> information. This file will only be exported when the system supports low
>> power idle in the ACPI table.
>>
>> In order to effectively use this information you will ideally want to
>> compare against the total duration of sleep, so export a second sysfs file
>> that will show total time. This file will be exported on all systems and
>> used both for s2idle and s3.
> 
> Well, my first question would be how this is related to
> 
> /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
> 

This has a dependency on the platform firmware offering an ACPI LPIT 
table.  I don't know how common that is.  As this series started from 
the needs on ChromeOS I would ask is that typically populated by coreboot?

I would hope it's the same number that is populated in that file on 
supported systems though.

> and
> 
> /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> 

No relation to this one for what's in the series.

>> Suggested-by: David E Box <david.e.box@intel.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   Documentation/ABI/testing/sysfs-power | 17 +++++++++++
>>   include/linux/suspend.h               |  4 +++
>>   kernel/power/main.c                   | 42 +++++++++++++++++++++++++++
>>   kernel/power/suspend.c                |  2 ++
>>   kernel/time/timekeeping.c             |  2 ++
>>   5 files changed, 67 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
>> index f99d433ff311..5b47cbb4dc9e 100644
>> --- a/Documentation/ABI/testing/sysfs-power
>> +++ b/Documentation/ABI/testing/sysfs-power
>> @@ -413,6 +413,23 @@ Description:
>>                  The /sys/power/suspend_stats/last_failed_step file contains
>>                  the last failed step in the suspend/resume path.
>>
>> +What:          /sys/power/suspend_stats/last_hw_state_residency
>> +Date:          December 2022
>> +Contact:       Mario Limonciello <mario.limonciello@amd.com>
>> +Description:
>> +               The /sys/power/suspend_stats/last_hw_state_residency file contains
>> +               the amount of time spent in a hardware sleep state.
>> +               This attribute is only available if the system supports
>> +               low power idle.  This is measured in microseconds.
>> +
>> +What:          /sys/power/suspend_stats/last_suspend_total
>> +Date:          December 2022
>> +Contact:       Mario Limonciello <mario.limonciello@amd.com>
>> +Description:
>> +               The /sys/power/suspend_stats/last_suspend_total file contains
>> +               the total duration of the sleep cycle.
>> +               This is measured in microseconds.
>> +
>>   What:          /sys/power/sync_on_suspend
>>   Date:          October 2019
>>   Contact:       Jonas Meurer <jonas@freesources.org>
>> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>> index cfe19a028918..af343c3f8198 100644
>> --- a/include/linux/suspend.h
>> +++ b/include/linux/suspend.h
>> @@ -68,6 +68,8 @@ struct suspend_stats {
>>          int     last_failed_errno;
>>          int     errno[REC_FAILED_NUM];
>>          int     last_failed_step;
>> +       u64     last_hw_state_residency;
>> +       u64     last_suspend_total;
>>          enum suspend_stat_step  failed_steps[REC_FAILED_NUM];
>>   };
>>
>> @@ -489,6 +491,8 @@ void restore_processor_state(void);
>>   extern int register_pm_notifier(struct notifier_block *nb);
>>   extern int unregister_pm_notifier(struct notifier_block *nb);
>>   extern void ksys_sync_helper(void);
>> +extern void pm_set_hw_state_residency(u64 duration);
>> +extern void pm_account_suspend_type(const struct timespec64 *t);
>>
>>   #define pm_notifier(fn, pri) {                         \
>>          static struct notifier_block fn##_nb =                  \
>> diff --git a/kernel/power/main.c b/kernel/power/main.c
>> index 31ec4a9b9d70..11bd658583b0 100644
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
>> @@ -54,6 +55,19 @@ void unlock_system_sleep(unsigned int flags)
>>   }
>>   EXPORT_SYMBOL_GPL(unlock_system_sleep);
>>
>> +void pm_set_hw_state_residency(u64 duration)
>> +{
>> +       suspend_stats.last_hw_state_residency = duration;
>> +}
>> +EXPORT_SYMBOL_GPL(pm_set_hw_state_residency);
>> +
>> +void pm_account_suspend_type(const struct timespec64 *t)
>> +{
>> +       suspend_stats.last_suspend_total += (s64)t->tv_sec * USEC_PER_SEC +
>> +                                                t->tv_nsec / NSEC_PER_USEC;
>> +}
>> +EXPORT_SYMBOL_GPL(pm_account_suspend_type);
>> +
>>   void ksys_sync_helper(void)
>>   {
>>          ktime_t start;
>> @@ -377,6 +391,20 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
>>   }
>>   static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
>>
>> +static ssize_t last_hw_state_residency_show(struct kobject *kobj,
>> +               struct kobj_attribute *attr, char *buf)
>> +{
>> +       return sprintf(buf, "%llu\n", suspend_stats.last_hw_state_residency);
>> +}
>> +static struct kobj_attribute last_hw_state_residency = __ATTR_RO(last_hw_state_residency);
>> +
>> +static ssize_t last_suspend_total_show(struct kobject *kobj,
>> +               struct kobj_attribute *attr, char *buf)
>> +{
>> +       return sprintf(buf, "%llu\n", suspend_stats.last_suspend_total);
>> +}
>> +static struct kobj_attribute last_suspend_total = __ATTR_RO(last_suspend_total);
>> +
>>   static struct attribute *suspend_attrs[] = {
>>          &success.attr,
>>          &fail.attr,
>> @@ -391,12 +419,26 @@ static struct attribute *suspend_attrs[] = {
>>          &last_failed_dev.attr,
>>          &last_failed_errno.attr,
>>          &last_failed_step.attr,
>> +       &last_hw_state_residency.attr,
>> +       &last_suspend_total.attr,
>>          NULL,
>>   };
>>
>> +static umode_t suspend_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
>> +{
>> +       if (attr != &last_hw_state_residency.attr)
>> +               return 0444;
>> +#ifdef CONFIG_ACPI
>> +       if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
>> +               return 0444;
>> +#endif
>> +       return 0;
>> +}
>> +
>>   static const struct attribute_group suspend_attr_group = {
>>          .name = "suspend_stats",
>>          .attrs = suspend_attrs,
>> +       .is_visible = suspend_attr_is_visible,
>>   };
>>
>>   #ifdef CONFIG_DEBUG_FS
>> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
>> index fa3bf161d13f..b6c4a3733212 100644
>> --- a/kernel/power/suspend.c
>> +++ b/kernel/power/suspend.c
>> @@ -423,6 +423,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
>>          if (suspend_test(TEST_PLATFORM))
>>                  goto Platform_wake;
>>
>> +       suspend_stats.last_suspend_total = 0;
>> +
>>          if (state == PM_SUSPEND_TO_IDLE) {
>>                  s2idle_loop();
>>                  goto Platform_wake;
>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>> index f72b9f1de178..e1b356787e53 100644
>> --- a/kernel/time/timekeeping.c
>> +++ b/kernel/time/timekeeping.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/compiler.h>
>>   #include <linux/audit.h>
>>   #include <linux/random.h>
>> +#include <linux/suspend.h>
>>
>>   #include "tick-internal.h"
>>   #include "ntp_internal.h"
>> @@ -1698,6 +1699,7 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
>>          tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *delta));
>>          tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
>>          tk_debug_account_sleep_time(delta);
>> +       pm_account_suspend_type(delta);
>>   }
>>
>>   #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_RTC_HCTOSYS_DEVICE)
>> --
>> 2.34.1
>>

