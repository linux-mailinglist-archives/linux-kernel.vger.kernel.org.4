Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06390735614
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjFSLqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjFSLqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:46:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3EE137;
        Mon, 19 Jun 2023 04:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXN2Hxgx/LItOPexyNj74fs+V4y+GBRlwcKOSjNEOkk9jP94XhWCr5CLd2Wz8jBlYfx1X6bu/8tkgXI0bebXAjMLYdaCMnV8GtNQGJWWx2Sw+60HZQcmnLQLj+EPa+msjiSfzrP1fQCCtTueScUQbi8X6TxH6EmqYyK2A7SfWlYsL46GOdXgOjsd33+EsASeZR4ZZ/j7yiALM9U87ceMr3Q973hSEOZMXQe84jvUWAD+D7aVGJ39mDUvIx/GD81eqt3ndCNiYjvGk+Y1Y6viiWzF3HIlWByav3jSmn5ADq11ZGzGazZD3jG9ORwiTlgLmfpuRqeCbhq+DzkwYWD9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=af1ghpKobEtHqKNjBUQDFwlRyMUyJVKVL21ySo1vaHo=;
 b=Cf+PwtEwKK0LL847QB30tkiRu9qxT1jB6BYw3cHWspRTkR4IKLxmpgERE0NmSqNfIUmUy6WhsEQD3rywYy6p/GV0XiSuMdMzL+qxpzbOQdc4epEKniiwUA2fjFiIKKs6UfZ2NNXLk11s9Y1GmdVO6nyb4jzTMW45HRGYq02LV70N3jfS2yz4faFY0Nf2F4Dd76ka4ZWoCQYp1HWSpfxoP9SmlSNaeYsI5DvbIP8BnQoW126CDXs2HHK+GqzT0EinY6brfUsshOD0UZ+WrVxOd4qyRgE0fHqBnTZD5c+0bPOJpXqMc6S5qZ9p//31V94SfzvbI5ImHi9mEYTZKO4VFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=af1ghpKobEtHqKNjBUQDFwlRyMUyJVKVL21ySo1vaHo=;
 b=VqpprNLqC3qu0Ue2aHLq2YP32uaBC/ZPHjl2sPCtI1HqqQD+LbLkzyI7gMEMf3qxkbmPsQactZ/rpAm0JSMoeYP8zjlC+b/JDL7cnhvSEZGEZtbMthGvj1e1XTjDQlsfw+5tlqjPSlPtYyEZBclOR6V3NjV8yJm4HhdVnkGbiD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 11:46:39 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::9c4d:b56:ce20:d723]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::9c4d:b56:ce20:d723%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 11:46:38 +0000
Message-ID: <268afbc2-4e65-0f31-a023-aff4823dd8e8@amd.com>
Date:   Mon, 19 Jun 2023 17:16:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] perf test: Retry without grouping for all metrics test
To:     Ian Rogers <irogers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kjain@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        barnali@linux.ibm.com, ayush.jain3@amd.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
References: <20230614090710.680330-1-sandipan.das@amd.com>
 <CAP-5=fV9Fx99QmKWSqqDK23vF0dcTS+g-r-9zr6q0A2ZXWmCBw@mail.gmail.com>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fV9Fx99QmKWSqqDK23vF0dcTS+g-r-9zr6q0A2ZXWmCBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: d92db463-b5af-4f11-afe0-08db70bad774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8FdJqhvbTMDcf9YSiD9QJ4FWfyIOIZcwJr7tLFqn1p2r8KOAxwDSi6PKor6hZ5cinVqfeO+cmx2+DO0myOR/zlULM6qwaM6pzqN7zUZNnkZeoM41mVq5/HX5AeCEas2TNko/xtf0r9xgqg8wNXEAjQ+NqUyzBCHyN89zG2Vom8KXJRtfs6vhfzrqwVhULCMCyAeIw+6o1ny02qMqXmHT4QC22yvznGhXKnCB7oTmUSZZWHHTt1MgiiLkHQLXgXgnCPPIQCIUNZs2SAprqPgRJzW2tjCl21+8bVp3AJ3JNzaoAEqUWWbgS3z4rO78HEbmc+no999VVC3PpIk7Kk2v/26HjsUZiHgn0DJqhJnHIeU6czWGQqxlTuvvMMvEeQ53XiYJpMLboKQ37TtHVLgP5J4PNVMu3LHhHzdoApU3hnJKT9YsPLd+NwoBiBRi4USr5sgDK8z4DLvbDoO3+OjgWbZemUio4P1I6ea7B8iWF/GnaJ6mSvidDq8c2+6b7sFiXIv4Tz4USx+fy72cMVqloCQVQMFkZKLc27d8Zalqm3AYjDVqr6Lxba20VplaR75/Wu+4R5N79C0TaJKeTjyUJ7cojvdwtWgon4NcU6ShODZDE75CsgNNobU5Nh0ffNEiPAQszGo6mzy1FRd8cDsgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(7416002)(44832011)(31696002)(86362001)(41300700001)(8676002)(8936002)(5660300002)(66556008)(66476007)(66946007)(316002)(6916009)(31686004)(2616005)(38100700002)(83380400001)(186003)(36756003)(26005)(6512007)(6486002)(6666004)(6506007)(53546011)(4326008)(478600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFJnTnNVbUQzZXBnSkh6NlNkRTFvTUNCb2ZTa0MxZGNXK3BRc2paemEwUGJu?=
 =?utf-8?B?bm83VXg5TlEyRk5sNWhNN00ybFprQXZHc2IyQ1grM1k0MDBGWHhFRGZZY3B1?=
 =?utf-8?B?MWFKMm0wbjNNWGM3ZDRhTnFTQlNuQjVVdkNKU3E5bjB3a2ZwTG94QVR2aHMy?=
 =?utf-8?B?cmNhR2lGRmR0NXJYZFEwR0thYWJxNkd4RXJqSldKcE5DNXg4TEpTd0tOOGJv?=
 =?utf-8?B?QytiZ2svQWt2czNYV2Z1K3IzaGVyWlRHOXJUUFBzc3hWVyt4S2dXaW1KZ2pi?=
 =?utf-8?B?dkR0NGJBc2syOXcwSzlxUFlqQTlVNmJxL29jL21vRGFBbHNhMTBTY1lvMGJh?=
 =?utf-8?B?NUdoMEFneU92UExYb2VIeFJwSWpPTzQ4c2hVaEJhYjRaK1RldXU2WUFpZ3VI?=
 =?utf-8?B?K2NaWmwvNTBEM2ZtUW5mMTlUVEdGNVgyVFpLQnIzeFhnU1JEQmZwRk9vZ3ZB?=
 =?utf-8?B?Mi9BSDJVdEFrN216Q01zUWpyVVduMWk4T1YwZ05YdGFjYi9lR2tJRHEwUERY?=
 =?utf-8?B?clAyMHhxZUVQVVlJb2pCVkpjRWVLU0hiQ2Y2M05KTXg3ZnVSS1ZINWFEVy9V?=
 =?utf-8?B?V3h5MG9Xa2FpVkIzNGlKVEw1QTRmNkd1UUl6dXRlcDlOTnIyb254VzJVa2RT?=
 =?utf-8?B?Vyt6eUgrVDVPTzdmVDNLejZzTENIN3I0bnpsQzdLbHNSdHk0cHNXNGJaQzI0?=
 =?utf-8?B?QW1TOGNpY2RLNCtPL2tTQXNMeFlLTnROWHZOMFZvRDZJeC9LaWZQWTY3M212?=
 =?utf-8?B?TEJncGV3NDRPNHlwdFdjalc2aDdhNlNiOHp6RTBOSHhjQnVVajR6clQ0WnV5?=
 =?utf-8?B?WFo0dS8wQUxmVmxab2ZScmpEcU5iVjdOZ1lEQkxiRDZKN3lWam9WNG80Rjd0?=
 =?utf-8?B?Y1FoWWxsM0NwUlRsTXQwbWJQc0FXamI0bG1GbFZGYllJWktlVFJWUXEzZ08v?=
 =?utf-8?B?OGtBM1FBM1llTkQ5a09iTU9YelpVSlpYUHVhZHVyTTBlWURvVTRJU1FjT2k5?=
 =?utf-8?B?ZlFYbjVKWENzZFZFK2JoZ1RIcXZ5RzZ2UVc2SEFGSUc3aTlsM21FUnNJSU5u?=
 =?utf-8?B?RnRlR2lDVUNlVkFGTTBsV3YrMVdzc2ZyRWd2K1Rpck8zcnBFUjVRKzFMZ2Vw?=
 =?utf-8?B?Q29STXkzdVR3elo4ZEFhb0dZSVNwREhtYVdERjJMZWJ3SmxNbGlHQm12YUpm?=
 =?utf-8?B?ZUtDcnc2YWZVMVJJZU1NK0I5TXRsbkVDQWlCTHlBRnpXK0d4MVBIY2dKN2FN?=
 =?utf-8?B?cjN3WVpNVnA1K3dvbnM1QmF4QjB3NjVYM2ppeFVwL1FocFFpajlJelRnYXdK?=
 =?utf-8?B?ZDZtd1lkZ3N0UjdnZ1ZDbXl6TE1IUWhxYUd2UXlwQUFnSXdJRlpNd3FGeGY3?=
 =?utf-8?B?S1pVTC9yWm1mejJBVlVybGp2b2huRmRaQitNWTFuMlhnMkFFVjByOUN4K1NZ?=
 =?utf-8?B?U29vSUZVZjFnWFBnMENLcHBBUXBFUlhRbXJ3T0ZoWUxGVU5NQm1sN2NBWXJD?=
 =?utf-8?B?eGVxdHo5dnpzMC9qYTRWVktEb1cwUVUxOFlvWHFySnFacVN2ZDlCZ1pCVUwy?=
 =?utf-8?B?ME91Y1IxZ0IzdnRHZ2IycThCa1Q2RFBFbGJBeEoxMTlRMDZmTzNNbEdBOGI4?=
 =?utf-8?B?M2pxWXF5cWxkbWpjS3ZvOUMyOEV4SFBoY3pBZmdWa3pUN21rcVJQNlRYdEV2?=
 =?utf-8?B?SmZNR1hvM21CQUNlZzZFbklMcDdjeU9PM2N0OHBJRUFRSU1SRzl6Z1JzM0tH?=
 =?utf-8?B?ckZuSW80UnlUV3BvWHV6V1ZZcmRubEZYNEQyZkN0OGhIbEZDUnI2ejFvaXhh?=
 =?utf-8?B?UFp4UmVVMzBOZDFGUHdCRE9hb2VQNW1RU3lZTUo5Z0RFQTRkVlM3VWRPS1Fu?=
 =?utf-8?B?T3BEK2MyU3NFdlRBbmp0bG45VHF5dFFNTEZPckhxcVA4aStxMzlhQWFENjll?=
 =?utf-8?B?Y3JYYWZYU0NUaGswV1BXT1c5THNTcUlpV1dWNVNTeUI3eGpWbDAyckRQallH?=
 =?utf-8?B?UlNDK3RENmptRXpCMTZyNW1BYW90UFBNSzc4bllwOE9RRlN2NjFoaHBKZ3RN?=
 =?utf-8?B?Vk5ieThYQWFWQ1JtUEM3V29ORFNrNkVFVU91NmpPaE14cEI5Ly9BdTBpMlpq?=
 =?utf-8?Q?NqJUCvowPTuRHSpmIpMra9ekN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92db463-b5af-4f11-afe0-08db70bad774
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 11:46:38.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uy6MH++ExzddBiQ2xghw12amSkeTOdYc0dbMbmtdjhHRfkNDjOU6Jbx3npURkEDA03cRdxxbVLHLjo+4jM+Q6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On 6/14/2023 10:10 PM, Ian Rogers wrote:
> On Wed, Jun 14, 2023 at 2:07 AM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> There are cases where a metric uses more events than the number of
>> counters. E.g. AMD Zen, Zen 2 and Zen 3 processors have four data fabric
>> counters but the "nps1_die_to_dram" metric has eight events. By default,
>> the constituent events are placed in a group. Since the events cannot be
>> scheduled at the same time, the metric is not computed. The all metrics
>> test also fails because of this.
> 
> Thanks Sandipan. So this is exposing a bug in the AMD data fabric PMU
> driver. When the events are added the driver should create a fake PMU,
> check that adding the group is valid and if not fail. The failure is
> picked up by the tool and it will remove the group.
> 
> I appreciate the need for a time machine to make such a fix work. To
> workaround the issue with the metrics add:
> "MetricConstraint": "NO_GROUP_EVENTS",
> to each metric in the json.
> 

Thanks for the suggestions. The amd_uncore driver is indeed missing group
validation checks during event init. Will send out a fix with the
"NO_GROUP_EVENTS" workaround.

>> Before announcing failure, the test can try multiple options for each
>> available metric. After system-wide mode fails, retry once again with
>> the "--metric-no-group" option.
>>
>> E.g.
>>
>>   $ sudo perf test -v 100
>>
>> Before:
>>
>>   100: perf all metrics test                                           :
>>   --- start ---
>>   test child forked, pid 672731
>>   Testing branch_misprediction_ratio
>>   Testing all_remote_links_outbound
>>   Testing nps1_die_to_dram
>>   Metric 'nps1_die_to_dram' not printed in:
>>   Error:
>>   Invalid event (dram_channel_data_controller_4) in per-thread mode, enable system wide with '-a'.
> 
> This error doesn't relate to grouping, so I'm confused about having it
> in the commit message, aside from the test failure.
> 

Agreed. That's the error message from the last attempt where the test
tries to use a longer running workload (perf bench).

- Sandipan
