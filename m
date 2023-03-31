Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BDB6D279B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjCaSN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjCaSNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:13:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4461B7C3;
        Fri, 31 Mar 2023 11:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CALb/vjxTO58utxaq+7Xna55Fa5MrC/IPqt0bAj+cKxlfgN9SLFjzy/BSQdrHVJ1q9F+SVAopFZJVQ0RSKvA/GQar6SOFZn08nvddBjPopbiWNKX5lMLrAc30l8QaK26SoFXI5ESA5HNSzWcg31QjHIZgdBuw0n/Ml8frVcjSkTRhSXJVinlbNkvYVCnJYI5IRI/eB1/ytX4T514NaCmgYyDGoJo3pxF/5U7bcPLyoSuE1BK0mxWS5IozXd+5yhWmPYbe/6pMumU2ZZ3wFaGRL5g1IddWLXW2mTRNXATU3xdzbIBqTrmoUTlU7EJQdn9SQFdX07YWPGtCQDanwxUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQgobseCj+/wX2umQWPt0m9QKROIJdg2KC/jzsuL0uo=;
 b=EFQB91CTrhfX2foG48D5oQdVzoEN1GjMweCV4nc1PfrT8OIhOP04day9qbjlzFAhBexY0i5l1ULdcquOtPImtSTL028uo7uRPrr5JC1O4Khr6Al27Uo4hIw1fg78Xw2Dtr8uH8Ano1eHiML+NV9HAYWsLiRizaeq+3VSZ5tLJWCKT+TTbLKaUXszANVdqXws5gn9mNc/ijRvhfsMWY4PvNqcN34lQ5VFVgSyQFUqcN86+C4yiP8nD4LMryhT5T9GpZYP1RZEmjz5IizfIg4IdLe3AvDAzFRVTSmNxJsdrVSwNXhFwDXDhfVPPzSpu2xR8jROPAN+GsEUPIFtGvs42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQgobseCj+/wX2umQWPt0m9QKROIJdg2KC/jzsuL0uo=;
 b=dxzNt9RQRTS+XXvjwMjT4CNOXDp6JIBT1CNzIDlufEzr+0iAC5CKdumsPeWmZ59WozNZ1Dg0GExafEpGFtLb2yuezL39u1KSscwtL6DIKkZfJI0Sd3MIv3Z/ikhy4d7QCcIrAjsmlmPD0iXEOcloTuOhtV5Qhx2vJCcjpo1DqnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 18:13:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 18:13:46 +0000
Message-ID: <8a04da89-1c98-8b29-bf96-1e8d0ed47e58@amd.com>
Date:   Fri, 31 Mar 2023 13:13:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 1/4] PM: Add a sysfs file to represent time spent in
 hardware sleep state
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
 <2676888c-e93f-53aa-a4f7-e85b66f351c8@amd.com>
 <CAJZ5v0iia9__-jWmawvsxninoTM5ZRtqhyUJme=noZMZJdUBrA@mail.gmail.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0iia9__-jWmawvsxninoTM5ZRtqhyUJme=noZMZJdUBrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:610:118::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ea1f90-6b91-4926-bebc-08db3213ab19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5kunakuwhNDuUSBfKquexwE/xdjdtxXvXzYfA8GzBl1Gv8wJ81nHdNHBcLk76bERVQZIpc3+67plgwyFRXSsVGeDY3gvg2Bk/ruEPVHyVZ0u0pRO6rMUqs5BtgHnkWz+TgUaDNsVxfpM/ai3wYg2UIxSs/6XUpveha69AM9SP8OI6SROuEKDKMLFWr4swvZCjb9yDjLDsMBTkI2/Ds62aCy5JmegQpuQuO9+hJzKI0/SQsj0DRw/kJl00QSadnbGozg37zGSjGKxTydUUWaIAw+xVpHdAcqoIJ5hcxazQd7VlxODwnQKVfZpyMQf+dCXJTbS7KdulhilKcVKNNYMNYSQTFof0V3n5ZSghKhZwy5ZPmu47nftAIxi37HaFiL/05jLqZM0k3h2rmGNS4cDc8BBA1hj+LGHPv/AeIHphinV1WUAoVpG+aeptpNMjfFbkvjruQ/WPkpGfDLBSUAjdZdY+NK6MxlX6ljNqsQ7iyZwDeT7r/t2qTpDJoxdnyWolQpt3WXqLP1+bSraUxwfG93Ia3DA33zE5PefEeGCwKoT33mZHo618NXvD09uYLMUlBVMz8/bFTcXmcCYQffF+AubevvMXEgu90RoUHJsCufyW0x6fRCPGTRwEmlWdORFyqH5CpNnmd7fvnmfjnExA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(31686004)(6916009)(316002)(54906003)(4326008)(6486002)(66556008)(66476007)(66946007)(8676002)(36756003)(53546011)(6506007)(6666004)(26005)(6512007)(38100700002)(2616005)(186003)(83380400001)(5660300002)(41300700001)(8936002)(478600001)(31696002)(86362001)(7416002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJCZmhaTzVZTm1VMlMwZjVkR3lVVTdUcldreHpHT1IyUk9aWmhMd3ZuVzFR?=
 =?utf-8?B?ZkxqZFQ5bTNKVGt6TndUUXp6Q2pnQmNWQ1kxS2k0WTJxbHg2WGRFRmMyalp4?=
 =?utf-8?B?a1IyYm51djhUa0haSTZlWU8xcW4wOVNpL0QvYnZVa2FzdHpWb2JHQ2ZVV1lh?=
 =?utf-8?B?UGtEdWF3NnhyZVBqaUxHWkN0MVMxUHZnbi9kUnFCZGFvdFF6anduek85MUow?=
 =?utf-8?B?Mzh6dmtOMjE4RlBTL2YyN01XanladTR6M1ZROThXdXdSNm0reUZmWlNyeUZz?=
 =?utf-8?B?VVFtSEoyeUtUdHFqMkEwY0ZqNXlsMmg0aWpwQkFOWlpZMWIzWEdJRTFFNlZr?=
 =?utf-8?B?bGpBbjZDZlRLTDhMOXBwZkg3ZUNnS3JnRmhWa1VTVzV0NnA1eU00OWl3cFF4?=
 =?utf-8?B?QmVTZUczSDJOTENVdndCeElGL1NmREhKWWUySWY5aU5WU0k2Y0tyN3kyRUhO?=
 =?utf-8?B?ekxmbFk5Z0Z6ZVRIbzNOWkJ6WEd0RUR4S0xKUENEcHIwbWhWbDhwQ1YvZi81?=
 =?utf-8?B?clpWY0hqWlZxMSsrRjVZSXJBT2FtcFNKdjg5YytCTklNdWpldHlJWEpjVWll?=
 =?utf-8?B?c2FqTHNXWWR2RGtzMlRLdnU2QWxxOWcyeTNldGQvVTN4em1Zc21zdTJIczVZ?=
 =?utf-8?B?RWlOUHFVVXdpS2MvTy9EdCtSZDgwMHNmN25qVUZsbVF3L3owR1UwUnlYN3lC?=
 =?utf-8?B?SzIybWt2OTVOUVVUbVNuM012dUFxbVJuV1M4SmZBTHIxbGtMNlhlQ3QySnRt?=
 =?utf-8?B?NUZYTlVEeUptRlNCNUhZbVcwOWlrcnV5eVRJWVJiekxJcTFvUGxBWnBUeWky?=
 =?utf-8?B?Um5sSTFhMVl2ZjNEWUNZTHFhaHMvN0UySzYrL1AzaW96aU4wVUlEbjB5Vzds?=
 =?utf-8?B?MExTVWpobithS3VGa2RaM0l1STI0NkUvSlExRXh0YUQvakRKOUdXTmN4a01O?=
 =?utf-8?B?aUJ0WDZJVzFBZHUrZkZJbGRvSi9la25LRFNKM0lQYnJtdGcrdUFHVWFyVys3?=
 =?utf-8?B?U0tKN2hCKzI5YkpUUy9zRnRMcnIxQmV2VThJZys5MUoxcUkvcUFmeXdtLzNJ?=
 =?utf-8?B?eHplSllmT250ZHlwWVdYSW1xNGhwWXNrU25uaE5nNmVyMWwwQjdTNWlaZzEx?=
 =?utf-8?B?NnZWQ3hMaUlRc2NIYlBuVzZVODR6U1JKdk51R20rQjJVNlQ4bmpqQXdWR0t1?=
 =?utf-8?B?SWZnb29xNmRwSGd0T2RVUzJPb1NIOEMyQmlKSjBoREpUY2xCSllrVm00eXh6?=
 =?utf-8?B?QkJ6UGFVSXErNG10WjFXOTAvSkJLYVdqWlQzM255S25LdGRQS081NDg1bHBR?=
 =?utf-8?B?TGhGQWJMMUtUbFVjczl6VFMwZnpIL3Z0eGJOY1JMb3ZDdWFDd0xFUmp0Q003?=
 =?utf-8?B?RHF4QmF4VFhCNEllYVlPWmdmUmpmQ09Pd0dXazM4czN1T0R0KzZLdE5DaFlY?=
 =?utf-8?B?SlYzYyt0WVM5ZWJoaEFXK3RjbWdWbkFjOVM4aVBnRHBFbHI3akhsNVJ0VUJG?=
 =?utf-8?B?VjFmUWZJWlE3OUtPd3Zxc09VcDdmdS91c3E2ci9GdVhZdk1sbFpER1RTV1F6?=
 =?utf-8?B?c2p5NlA5Z3E2NGhrdHZ0dC8vc3JCUm9OVXp5TkNFeXZzQUd1eHIrQ1VBQnZr?=
 =?utf-8?B?ejhmcXQvSG9sTzZ4QjRlSWFWMnpGMEc2M3JnSG1hb1VLS3lxTWtmdWk0cFdU?=
 =?utf-8?B?S3ZQbmhxS0tQclhPRWkwR0ZCa2dpWEx1Q0kvanBlTHBnU3lYbURqa0YyazJQ?=
 =?utf-8?B?TGx3Tnh1d2Y2aFdTa1ViRjRWY1prZkhXcExBYUdTQTB2WUVhZEZxQ05yUUU3?=
 =?utf-8?B?RlY4Mm5KMXBqZk0rOXpOVkdDUlo3NHk0UVcwUWlPeC9jcEo5Qmd5UEF5YnZE?=
 =?utf-8?B?c0lHR3JnaGU4OHRCMjE5TFVRNFBiQTRQYmZiU2sxd2g5cGpaTjdkN1J4RHd3?=
 =?utf-8?B?MkFJK3JkSURCQStQT3Q4OER4eit1akF1VXhwZlZ2WDlkUVdYM0FsTnoweHlI?=
 =?utf-8?B?UzlkT21kUTdtVXNTZWd5S09HSjVuNnRJZDdQU290Qnc0dmVvdS9uZURvNmRL?=
 =?utf-8?B?THRKRmxLaUtYb01jWHBHRHB4MzNiajRwUHpTTkJ0QWtKbTVxQ2h3QWtaSXNR?=
 =?utf-8?Q?XOt7cfSpqJipqsOY0KenRxrBL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ea1f90-6b91-4926-bebc-08db3213ab19
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 18:13:46.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYMVKwA+IUzQhLH6E1PDXOi2WMPjkPMRSjDjdD0j7JUP0YTYNfZ6y9a23eSQoQj7+eJh9rRbOwVZ3zAjI1or8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/2023 13:07, Rafael J. Wysocki wrote:
> On Fri, Mar 31, 2023 at 8:05 PM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
>>
>> On 3/31/2023 13:01, Rafael J. Wysocki wrote:
>>> On Thu, Mar 30, 2023 at 9:45 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> Userspace can't easily discover how much of a sleep cycle was spent in a
>>>> hardware sleep state without using kernel tracing and vendor specific sysfs
>>>> or debugfs files.
>>>>
>>>> To make this information more discoverable, introduce a new sysfs file
>>>> to represent the time spent in a sleep state.
>>>
>>> This is only in the most recent suspend-resume cycle, isn't it?
>>
>> Yes; that's correct.
>>
>>>
>>> Wouldn't it be useful to have another attribute printing the
>>> accumulated total HW sleep time?
>>>
>>
>> I had considered this; but I didn't think it was actually very useful
>> because userspace will get control at the end of every cycle and can
>> accumulate those numbers if desirable.
> 
> Unless "user space" in question is actually a human, that is.

This is what I envisioned:

* In traditional Linux some software like systemd could capture this and 
log it.
It could subtract at the time the suspend started from the time it ended 
and use that to calculate a percentage of time in hardware sleep state 
and then put that percentage in the system journal.

* In ChromeOS something like powerd would be the only thing reading this 
number and it could be adding it up during dark resume until the system 
gets to a full resume.

* If a human is manually capturing these values they'll be most 
interested in whether an individual cycle reached hardware sleep.
If it didn't they'll want to look at debug data from that cycle.
The aggregate will be noise.

Do you think of another use case?
