Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC2260C3DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiJYGgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiJYGgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:36:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8B9147067
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dv9QdUBhK+6PnZrKjE5vEpdsT7efR50RVILIex7pOaXG3t4oW4D73w/aeEnnCaZzOIzHFxKPM58wwFCrnZS5NjnCW9PSDpgIyrirleiqLVGPIbNlBJ0e1fMBxcYqF6czeiKO8QLiq9lMOjGDCbuhKCMqrHR+UEVJ5Di60CRD/V1uz5ccPo0Ub+A5J2zk593sxxyJacOM0XvphnyOoIVr2pYGWOYse1odlUk0jNRs+7iuatYVEHkma6TeJ/u/93aT9GigdWjRkiXTCZHYKgKfWMhp9Yx1jC0KHl+GxIbA3VKZz4kJa+cfPMceUZ6wvfjOdj+IbNqFI0yYes8umotPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djuPwqxzt0q4GJTIV/mVreDkU9Cycwcw4M47OC+lChk=;
 b=WRPusk56iuEcaOOUiabIK0nhvcyqPxTz8tY+EyRqmAqxzF/Q6omEETMPfDDcuUJFVpZV0LR9cqBDC0Ec0j8jzER47fm4akBwzWUHzOa321yiWwJ17jF/RHmq/rbkKo5I9GB9jIHD/jKe1WAait2m/Dp99B57r6s8sSbDihQ46TwtQYbOuJ9lpzzp4hfYs++CiGtWB9zT2itIXrGBbB7eOn/aijWofwKYkqtYypqzHL5rCKDRBubqv67JGpNPNqhO3XjRXOgPRVhnrXPDVaucUyaKIIAJm0eQ0kWSc9gW4AWhCDMhrDd208Oc3wvtz+m7kKj9rKY/x4S/GPNhm0I5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djuPwqxzt0q4GJTIV/mVreDkU9Cycwcw4M47OC+lChk=;
 b=mAzQedQdL7kP6zaCtNVXBcTwTLObdSW//rt/VPCfj60MUPZV1anRB7e8l6zm6CTPe58JiXmhiXALbLlKnipwWzhgE2CL5E9I7VGuVq5UzQWJWLNLJ2jE3YMhWw5Gp5caqg7AcAJj93w0Js7kj4Kgz/4PpFjNO+LregNhCnWzpDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 25 Oct
 2022 06:36:43 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2e7d:cda3:bb38:a1ce]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2e7d:cda3:bb38:a1ce%6]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 06:36:40 +0000
Message-ID: <89a5eeaa-4c5a-db6d-2c52-6dcb951d3a10@amd.com>
Date:   Tue, 25 Oct 2022 12:06:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 0/7] Add latency priority for CFS class
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <cd48ebbb-9724-985f-28e3-e558dea07827@amd.com>
 <CAKfTPtC-yMUNfnGa8a4HrT-Onf4SZfRHDKyQcDZYnzhpPOk=Xw@mail.gmail.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAKfTPtC-yMUNfnGa8a4HrT-Onf4SZfRHDKyQcDZYnzhpPOk=Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::16) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|BL1PR12MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9a8948-332f-49ab-73d3-08dab65345d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnX4k+eGprXBRf+xaFKtu+waDCBXDhTD4jBfbFXehiCa8jLrR1ZAwIsSDgl9+CHXK6V6BIPOLIm+hbAp1qEBu/nziu0xc4ZrmPDwbmPQy1IyKJdlFJzts6+HWsZsZ8UZEZXL8W3bHYEJnB7/vTCxnn+UEl+XaGDYgbdJwslTG8b4xqxC9uDEuvIcfF+/dIsy12uhCLIf/+ERcWCEyH4y3g8XlI6xm0d5DTnZ62LIvIKQI4d6rMAMj/FFV2YFx6pLRGSkMHkQwF4jg5WRek84LtUIxyPp39TklyXBVy8aKHjvfhxpoJ/8Az3mWMKZ0OkcibPs9vZyZHMYge0wE521M4S6VfLKOu7JIeKUjGGDaW1CK+kl1y3Dk3QHCOR9DQ6FupNsxlIHv+jQiQctph7l4dnZsI65QVKPnyhI/H30pY5en5xH2hMorVpLPo7xNblmEaodlGjigaconePewnA71qDSLeVCzA1KnkThjwNAwXB4jY9hHtsbT+F0dQIcAwfyBrtnS+tG1HVGmiogLWCr3/B4WOAmy6OvxdO+H1HQOiLL2wRwReVaYJ7pns4VOQ7GCLai3mGlQx5wo15fUiQLTbJ97NxSytMn3UY2gRohdv2SROb9ErQB5hB89TvBJOs31JdFL9l5W9SK6fA4SqwTOmUMFlPZyLkcpsrxdpI0NK235ntwW7RJDo9fwCcDd1rUFWW2KgBiNiCY+YLHgjjJ91WdwwDiEWvd4eebLnFtgIkKr38HWtRaCEa7Rkdck4oTz1b0cfhvxNhypbO/det80bCS6Czzeyw00BH/ZTIfH30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199015)(2906002)(186003)(6512007)(2616005)(53546011)(26005)(6666004)(7416002)(6506007)(8936002)(41300700001)(6486002)(66556008)(316002)(478600001)(4326008)(8676002)(6916009)(66476007)(5660300002)(66946007)(36756003)(86362001)(31696002)(38100700002)(40140700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlQ1WkN6SFdhYmNaOVVxQUZPT0VhVVZtU0lzdVRBUS9CUGhuNmUrL2ZtYUdk?=
 =?utf-8?B?VzRjc2thWW5XYVlLK2xESERPYzU3V0FPMWprRThJbjJkUjgrOTd4eCtmVjNS?=
 =?utf-8?B?U0o5ZkgwVks1UEZxRFRyM2FoNUZ6UkdaYTFHdjNoa3JVRUJLVUF4eUlTNGJZ?=
 =?utf-8?B?RHB5TWljbWZQektOVzJ1OGVSL1FRNjVSSUEwQ0RhY1NRbzkzc1ZQYUtiM1FH?=
 =?utf-8?B?UHhvMHl5aHc5OHFFaVhObnR3WUl1T2dGeGtWU0E2ekVWWElSRW9oRHN2elV6?=
 =?utf-8?B?YXhLU09idUFvSkRMM29MYk1tWmFFcnhLNENqbUZwSzBpRFR4YnZpeFFZL05L?=
 =?utf-8?B?MzFuTmdQTnYxbUx6blpTRGlqU2piUExhMkdzNjZmMEtFTnpVZ2dUZ1g3WnN5?=
 =?utf-8?B?anY3eWFydHVLTks3dWxjNzdBa1pPMWNXUTBmWnFkc3VMSkV5eUIrYVo0eFpL?=
 =?utf-8?B?VDZWc0RqVnhRRkVRV0pobVRBK1dsekRuQ243OWUzTmtXM3FPcStSYVgrZHU0?=
 =?utf-8?B?T0FPdjlxVEx6Mk5CSHpHenpIWHRpa3NVV1c5Y3dVWVFaN0ZIKzB6T2dIakhV?=
 =?utf-8?B?SzNPWnYwMkRxNjNIVExXMWQ0WVRDU0t5TFdiaXlxOVdyWWdPTVdnRWdXbVFP?=
 =?utf-8?B?YUpsTk5RL3VQSkFiZ2xxZDRFbnA2WE9QZW12MkhUNHNFaDd6TWgxbS9Bb3Nz?=
 =?utf-8?B?dHZWdkErcGxTa2M2aS8wSG1JK2QyUGNLYlQ1SzFCb2J4b3BEbGVsa0pRbWtM?=
 =?utf-8?B?SG8xTmttaTh2R21lS2NCL01xM1poWmZwZEpwUHFUUkp6Z04rbmpBaTlRMGY4?=
 =?utf-8?B?U2liWG5Lc1dyUE9lNnpkdTlna3FxY29YeWErYnE1elJSY0ZDSkxEdkJvRUFh?=
 =?utf-8?B?WWZubnhGeVlsaTZOZENwdjhwWUlzamN4WW81VE5rM1VEQkFXeE1qU0wybis5?=
 =?utf-8?B?dnkwRTBnSzVCMFEweU83ZEsrNGg5SUZoN1ZYV3FlVEFqWDhDaDhFTjU3RDBZ?=
 =?utf-8?B?cUI1L21ZNHNWb2ZPWm9sNHJPVVN3SGhVbWxITXNtcllxRjlBaWJyWEpnczNo?=
 =?utf-8?B?elFOYTZtb1lCc0Y4YTVWa1Uvc1UzUytUOGo0SWVDaENqTGVSZlRaelcwRkJ6?=
 =?utf-8?B?MC9uYldOSGhNa1lCU3FyanBmaDVueEw0UEcrUWlCUjloR2VJWXpFWjhMYUZP?=
 =?utf-8?B?UnNBaHEyUVhBTnlCZGRqc1J2dVhNNFRBQTZTM21FVWQ5bmllU0ZvcUNGUjh0?=
 =?utf-8?B?MHJqeUErNytRcmFnSHlteVA5OUFJa2Z0SStiU3dhNW54MHM1RWE2OGsxdEVr?=
 =?utf-8?B?MXdRTE9jVHh0Nk5yR3RXTTVuOTV1SXpBajBoM3graC9Db29keWZ3S0pBelFy?=
 =?utf-8?B?cml3OUU2aVJJRUUxTkYyNjF4dldkTlRWRmJ6Y1dyRUVlNEV1dEtBQjNLRzA1?=
 =?utf-8?B?VTNHVkllZHIxdnp2SHdBV0dCcGxnVUNYTldNanQvK1JzRllKTzBNUVlaMUE1?=
 =?utf-8?B?S25sOEcwMlIrVk9nZ0k5SGhVYkpTYThuTmxqRWdJTGtXeTVFVWZHUGpMd3p0?=
 =?utf-8?B?Y3IxODd0YjVtcXBEL2lkeW1UVXNydXlYaVY2NEMzYzdjVXNFUFczRWhGOTRG?=
 =?utf-8?B?ckRlNDRaVnlJNVRoNFllUjRseHMyU21vcTNYdjFMQ3BjV0RSK21idW9UK253?=
 =?utf-8?B?bUNqb281ZXYxc1dkOXhUOHZMd2hjSzFRR1JNMGdJN1h3RjVWaXFGVll6TzFp?=
 =?utf-8?B?SWNvYVZJNTJiUkd1U1dMeDY1M0UzaWpCbW5oTGlJM1JyR0lPbitwS2lkOVVq?=
 =?utf-8?B?RHJnVitRcTM2a2Q3ZEJtUGsvbkhyclQ2MUk4NGVsRE1zbDNlanhvM21qRzFO?=
 =?utf-8?B?ZUk2Mk1BZm5xWG1HTk5NbCtSelBSdmhmZEtuRC9qYzNSTHNQbktBbHRWT2VL?=
 =?utf-8?B?K2I3bU1rVTJBNTFTQTk3TnQzYVN3eGN0d1B4VVlFRENUb3JFU21PeFBUTzFH?=
 =?utf-8?B?OWtoRExJSnYyYk81Qklzbkl2ZEh6V3pDQ2hoejMyUFF5RFo0d1ZkKzI2aitF?=
 =?utf-8?B?SEhidXp5N3R3RzU5NE05aWw1eHRzOU9BV1JjN0drOUptRjQ0M21kOEtzS3Qy?=
 =?utf-8?Q?3HCB3lwrRjRvVsvGHzNyFv1Be?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9a8948-332f-49ab-73d3-08dab65345d4
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:36:40.2219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pdXrZtjhSgo9FbQqICpRODuDtYy1z8w8MLcrXv2Cl8U3unVlqlEYHEo+/HO0af+fZA3FOpsAMLjInX6m7nXcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent,

I've rerun some tests with a different configuration with more
contention for CPU and I can see a linear behavior. Sharing the
results below.

On 10/13/2022 8:54 PM, Vincent Guittot wrote:
>
> [..snip..]
>>
>> o Hackbench and Cyclictest in NPS1 configuration
>>
>> perf bench sched messaging -p -t -l 100000 -g 16&
>> cyclictest --policy other -D 5 -q -n -H 20000
>>
>> -----------------------------------------------------------------------------------------------------------------
>> |Hackbench     |      Cyclictest LN = 19        |         Cyclictest LN = 0       |      Cyclictest LN = -20    |
>> |LN            |--------------------------------|---------------------------------|-----------------------------|
>> |v             |   Min  |   Avg   |  Max        |     Min  |   Avg   |  Max       |     Min  |   Avg   |  Max   |
>> |--------------|--------|---------|-------------|----------|---------|------------|----------|---------|--------|
>> |0             |  54.00 |  117.00 | 3021.67     |    53.67 |  65.33  | 133.00     |    53.67 |  65.00  | 201.33 |  ^
>> |19            |  50.00 |  100.67 | 3099.33     |    41.00 |  64.33  | 1014.33    |    54.00 |  63.67  | 213.33 |
>> |-20           |  53.00 |  169.00 | 11661.67    |    53.67 |  217.33 | 14313.67   |    46.00 |  61.33  | 236.00 |  ^
>> -----------------------------------------------------------------------------------------------------------------
> 
> The latency results look good with Cyclictest LN:0 and hackbench LN:0.
> 133us max latency. This suggests that your system is not overloaded
> and cyclictest doesn't really compete with others to run.

Following is the result of running cyclictest alongside hackbench with 32 groups:

perf bench sched messaging -p -l 100000 -g 32&
cyclictest --policy other -D 5 -q -n -H 20000

----------------------------------------------------------------------------------------------------------
| Hackbench   |      Cyclictest LN = 19      |      Cyclictest LN = 0        |    Cyclictest LN = -20    |
| LN          |------------------------------|-------------------------------|---------------------------|
|             |   Min  |   Avg   |  Max      |   Min  |   Avg   |   Max      |   Min  |  Avg  |   Max    |
|-------------|--------|---------|-----------|--------|---------|------------|--------|-------|----------|
| 0           |  54.00 |  165.00 | 6899.00   |  22.00 |  85.00  |  3294.00   |  23.00 | 64.00 |  276.00  |
| 19          |  53.00 |  173.00 | 3275.00   |  40.00 |  60.00  |  2276.00   |  13.00 | 59.00 |  94.00   |
| -20         |  52.00 |  293.00 | 19980.00  |  52.00 |  280.00 |  14305.00  |  53.00 | 95.00 |  5713.00 |
----------------------------------------------------------------------------------------------------------

I see a spike for Max in (0, 0) configuration and the latency decreases
monotonically with lower latency nice value.

> 
>>
>> o Hackbench and schbench in NPS1 configuration
>>
>> perf bench sched messaging -p -t -l 1000000 -g 16&
>> schebcnh -m 1 -t 64 -s 30s
>>
>> ------------------------------------------------------------------------------------------------------------
>> |Hackbench     |   schbench LN = 19         |        schbench LN = 0         |       schbench LN = -20     |
>> |LN            |----------------------------|--------------------------------|-----------------------------|
>> |v             |  90th  |  95th  |  99th    |   90th  |  95th   |  99th      |   90th  |   95th   | 99th   |
>> |--------------|--------|--------|----------|---------|---------|------------|---------|----------|--------|
>> |0             |  4264  |  6744  |  15664   |   17952 |  32672  |  55488     |   15088 |   25312  | 50112  |
>> |19            |  288   |  613   |  2332    |   274   |  1015   |  3628      |   374   |   1394   | 4424   |
>> |-20           |  35904 |  47680 |  79744   |   87168 |  113536 |  176896    |   13008 |   21216  | 42560  |   ^
>> ------------------------------------------------------------------------------------------------------------
> 
> For the schbench, your test is 30 seconds long which is longer than
> the duration of perf bench sched messaging -p -t -l 1000000 -g 16&
> 
> The duration of the latter varies depending of latency nice value so
> schbench is disturb more time in some cases

I've rerun this with hackbench running 128 groups alongside schbench
with 2 messenger and 1 worker each. With larger worker count, I still
see non-monotonic behavior in 99th percentile latency of schbench.
I also see number of latency samples collected by schbench to vary
over the 30 second run for different latency nice values which could
also pay a part in seeing the unexpected behavior. For lower worker
count, I see the number of samples collected is similar. Following
is the configuration and the latency reported by schbench:

perf bench sched messaging -p -t -l 150000 -g 128&
schbench -m 2 -t 1 -s 30s

Note: In all cases, hackbench runs longer than schbench.

-------------------------------------------------------------------------------------------------
| Hackbench |     schbench LN = 19       |      schbench LN = 0      |     schbench LN = -20    |
| LN        |----------------------------|---------------------------|--------------------------|
|           |  90th  |  95th  |  99th    |  90th  |  95th  |  99th   |  90th  |  95th  |  99th  |
|-----------|--------|--------|----------|--------|--------|---------|--------|--------|--------|
| 0         |  42    |  92    |  2972    |  26    |  49    |  2356   |  9     |  11    |  20    |
| 19        |  35    |  424   |  4984    |  13    |  390   |  5096   |  8     |  10    |  14    | ^
| -19       |  144   |  3516  |  110208  |  61    |  807   |  34880  |  25    |  39    |  295   |
-------------------------------------------------------------------------------------------------

I see 90th and 95th percentile latency decrease monotonically with
latency nice value of schbench (for a fixed latency nice value of
hackbench) but there are cases where 99th percentile latency
reported by schbench may not strictly decrease with lower latency
nice value (Marked with ^)

Note: Only a small number of bad samples can affect the 99th
percentile latency for the above configuration. The monotonic
behavior in 90th and 95th percentile latency is a good data point
to show latency nice is indeed working as expected.

If there is any specific workload you would like me to run on the
test system, or any additional data you would like for above
workloads, please do let me know.

--
Thanks and Regards,
Prateek
