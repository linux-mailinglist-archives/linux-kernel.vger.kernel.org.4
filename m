Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A0B645EE2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiLGQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiLGQ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:27:18 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4CA68C51
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:26:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDF8P0slPQbljO4MnpSe7EuuURzoakdlMGyIrP4KyONZGEzuyvhz5MlHjAdqGccVXC4lVjepBAFH9PdaWZFBDZ7YX9k+uNvPsV+XfdZy6BRKxlwrgRaEMgN58mORT6iedZw1p0syaXzmFdiLyRTfmr4RbvMWnT06I8CjGaUxVNhyMMK0E+kewrEicIwPc5/2QLbt9mmekqmYQfABKKxBGmrSwGlIMQmtYXzsu+g1bkEK6BpdKntXHqce5G2PuCca8yHmdSxRg3CiFJSXcP227zqBwTvGpcSMZ2MnqHlcGsvuVE/xwxmRniUWuF8RShkgZX53uYJKo37RUFn8SLFEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRV2acn4AerihszSxekEWVIlz+TXW1OhEImgPelDKOA=;
 b=I9vLRaU+VwtDdtdGot1nYYGfv9v+IGhi4Zx1slSCUWyCUZRyWt91IixFdjb+5aXYfu77s3hdwtw9jDpoU13/TJK0GifZrBSneY2qg9wDpSYMTYwFtQwvbpz8O4RImLvieQh5fm55ssTuHU+EG2Gcju4V+VZGP2qcb6LR4gznamly0GdOFBt4j7KfGQWX7JDieSqBg2n43q/3sh5Wibv0ZM5TJm299xqZJZ6R8yMTjVV6U9P9ueXpyCZIcHf2zDHnM930hitZ4gvUVXX55+NysH9y3TMr/mwaAEsF5r0rCyNUOBvRlAtr6xvzKlU6V9ObXMGbYCStVRviyC/W9QnwtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRV2acn4AerihszSxekEWVIlz+TXW1OhEImgPelDKOA=;
 b=U/+oEy0W8ztCyajnD7tBwrJ5OCfPf9cqs59z4o4DaWUiBb+2U58xJdXqxW7fYjpMsBN0CbADb8dw8FLRHb0dmeHZA20/1aQuuhbMZTukYNZ/5t7PoWDSSL2HWjjgN2LlejuHLLO6ktiTHVPPvWz/OyJSHqBUs2DBtQ1IRriZqwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 16:26:24 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 16:26:24 +0000
Message-ID: <e3fdc51b-19aa-c85d-f51e-16ff9cf64e2a@amd.com>
Date:   Wed, 7 Dec 2022 21:56:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v9 0/9] Add latency priority for CFS class
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
References: <20221115171851.835-1-vincent.guittot@linaro.org>
 <03d429a0-ce55-fe75-5698-c6cfdc1ed4b0@amd.com>
 <CAKfTPtDgVT8mGhDbh9Z40769Ju1DMFpL+zu+rEqnYyJRYetmfg@mail.gmail.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAKfTPtDgVT8mGhDbh9Z40769Ju1DMFpL+zu+rEqnYyJRYetmfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::10) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: b37af090-fcf6-4ee7-baff-08dad86fc866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kV7l3FSI4/O1TUq4b+WgWdGYwpKOsTINpAaqvFj26kU41Q7+MNwsXyUuWglmskTf0Bx9bmtRU5+iSGJ+YUxy2MMVPM3E4JSRlrAnxEjvNIKLDV6Ur3y3vF4OfliYNTy/uXTPWRxhoCEXst4NNUyO4GCy0V3V6N13s63KQScnncxUJyQrzb/tgQA9+NFq6Jw8NBjkEl+5H5JYGeF3aTjTdI1f47a83v384qWGBuzMP305yl0iGiBIaJMQD9R3lptnkQTUHD3QJFrdPwjY7g8gGTBtnGtF+VQTp8k9q+ycJp/sP/32q1pnjmKr5CDehtgBjfR2HZZl80WHnIbirlzY/LyGFF1tw4gDqnsgIRtMKBKY8jao0q5Hn0xuff3MufveCNNQf3H6R5g/1cijOJWNgokaZix7GdLvb5W/NTNfNI1KF17uVW+ooHTLZguYtfV0kVl0xFjQ7ATsa8COa1bdR8BpylNfmGYoYh0k0MhxNJQ2q17cxlQ13HExToKN8j68qqboOeIL3xyBy0dEpXRM+5jCyke3EX1m4RReLlADFNSyrH7+yf6jGoa6zzRYjATeszbvtqhoCJ6qV7h+FcDC5c6m7A4g5rJfUNt7xvOjQuxR/e8wh8umapPj0iIwEKBxI+xuiLYLYzHbzUGpoK1mac4GkB1bSEebB4zXbBQuQvgBZlQUdkIzo9f+4DGuti2MocBMlHR+qq+rTWzRE4MBaDqszT0UMavFztAPDlzrgCaJfiLj2mFENO860wfIotsl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(83380400001)(38100700002)(6486002)(7416002)(86362001)(4326008)(31696002)(2906002)(41300700001)(66476007)(66556008)(8936002)(8676002)(66946007)(5660300002)(26005)(6506007)(6512007)(6666004)(53546011)(186003)(316002)(6916009)(478600001)(2616005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkYvTmxvWHBZR3JzS1BnQXVIbDIwd3ZQWXN1c3pDVkFpTTh1d0Q3K0NuQlk0?=
 =?utf-8?B?YkhGc1JmT085cFlsTHM2cHA5QmFqV0U1MmlHUGdrbFhmK1d6OVNxU3d5U2Fu?=
 =?utf-8?B?ZWNORVl4L3NDQWhJVUNVNnRrd29MNTJzN3dqQVFjYm0zRFR1VjBiNXhPbk53?=
 =?utf-8?B?b1JKak0zN3ZNYmVVejJZa1JWRUNUMXpOUnNLb0U3ZzRHMHprNUFMVFFmTFVP?=
 =?utf-8?B?NVlWWGx0dTNEdnNuYW5Fd3QvUU1PWFFGaTlLWnpQZ3doMUw3SnFnSzBadHU5?=
 =?utf-8?B?dGE3ZUZLSkhyKzNSbDVJWHBYazhpdUlnZ1BMNzk1RGJhdFhuTk5Bbjg4TFBq?=
 =?utf-8?B?QURYSlNlbEdjaHkzNU5yc0I4a2NrMHdaS1liOGFPZS8vNlRDWEJSMjVETnlM?=
 =?utf-8?B?TFRGdTh4NnIwWmhsM0p4SmJRVGlxSlV4dC9ZR0VLTnBnTlMrOEFZUkhNajIw?=
 =?utf-8?B?eHBQUWM3aTJQYU9TalZlQzlsNHFFcFBURTdLZzNEenF5VmJzaklHS29sZUV5?=
 =?utf-8?B?b3VQSlZKY1NsTU1wbHpselVQUWo0NnVzNitLNnh1WFNzMVdsd3E0Y0h6OXM2?=
 =?utf-8?B?dWpjVW93L1NuOGJkb0F6NS9FWWlDZy9KNzc1U1FnL1VkdERKNENkSHJaQnFX?=
 =?utf-8?B?S2gvdUY3TVk3Q25IT0RXOXE3VHlVNTUyUzlpcDEvZjlUSDJtK2JldEUxQVBq?=
 =?utf-8?B?QXVZbDFNY2ttUm9GY1RaOFhSZnJ5dC9sclRwNjh4T21GUXJUSllDUjBiV05y?=
 =?utf-8?B?OHVybXlQZXhtaEQ0bDcvOUZaQnp4czlMc0kzVkFXRmh2RVFaajZGaGNPMXBV?=
 =?utf-8?B?aDNXQ3NmSDFEQnJRQklMZUtSMjFmODg4dTNDRFFFam5EVFNIdEphdnNmc0x2?=
 =?utf-8?B?cEZ6RUEyV3NmeGlEbi93aHpxTHh4bG1CaHZFMVdPUGNJSGd0VHVxWjllTG85?=
 =?utf-8?B?U2dBN1gxZ2ZVVWlHc0lyemNMZXlMcGtXVHh1MGF2RDNIKzJpUjZHejFLTmp3?=
 =?utf-8?B?T3drZ2ZYVlZ0Ylltam1VaXVrSlNhQTFPRUtubUlEKy81ZEFnVXdEVWtJVWxk?=
 =?utf-8?B?NndoTklWNG1nZDBmVE81bUtDSk5WVm1qRnllUVZ5MFF4QkVLWUEyd0cxRHRE?=
 =?utf-8?B?cFNwVkgzY0Q4L2xzWE44N0dSN3lhQ01KUkJjMXdYSk9JWVEzbzk5RWludkFr?=
 =?utf-8?B?dGhqUDJVUEx2SWt3ODhzcG5NeDFiSis3QXduNUpJaTJSc1RMNWZQRkVpbEJM?=
 =?utf-8?B?bi9LNTJ0bklrQmQ0UFY5UWVFV2s1RlJMSVg1TXJESmxNRGlqUWk0b29NZDJz?=
 =?utf-8?B?WkhFRkt6bEtSQ0JmcmJ2aXFzM2hkRHUwa1dsRnFZQ1dGK0tTbk15OGZ1cTVi?=
 =?utf-8?B?amtWc1BIek9OdUlCUHFVR2R0TnQ2d0c4QlF5ZUtlYmsyaERhRTAwTGJ3ZEVY?=
 =?utf-8?B?REQwNTBCUzdTWk5jY3B5UXFyUW1ja0NpemErZ0kzWjVlb2RlN1B6NmxaNDJx?=
 =?utf-8?B?RzRkMXZYdUlFNW5FNXplRStabnlxNUdzZG5TTUJxbUx3ZGRBV0EwK0UvUzcw?=
 =?utf-8?B?SkozTytUTnVjTnlGVU5tSzFRK2x0YlNzNmhLeFZrNVhnam54OUxERDMvZ2Y4?=
 =?utf-8?B?NXRFRWxla3lwWGVQSjRwa3dxRTJhQ3ZDb1ozUGFPYlZLMGlrS2k3eVZkd0tv?=
 =?utf-8?B?U2pvYWZRZU80bCtwaWRJVmdVYURMUVdrK3FnTENlbGQ0cEUyN1dRVXJ3WUJY?=
 =?utf-8?B?TzNCVFlIYk1sNjlsYXJJYk5RenZheFZFcTRoMTdRNmdlSjc1YkdmVlBrZnpx?=
 =?utf-8?B?dkMyaXk3TVI4Uzh1Q3E5WjZMSTJtZXpZczFDYnpodHcveklOQVp5Z1hrMm1S?=
 =?utf-8?B?dHo1T29xM2JhSWVLRjFWZWs0dzhHOUFqdlpTMnJFU3B1K0YxcXAvTjM4Y3hQ?=
 =?utf-8?B?aElBRTZvZVdxejB5YTVJVEtxOUNwRXNFTEpMSUdtQW9QdXRuajhRTjh5N24r?=
 =?utf-8?B?cjdXZVRRMHQ0TWExVEFReXQ3eDNPTzcvUFV6eHVwZURSYmJIOTRWV2lobmpJ?=
 =?utf-8?B?aVo1R2VBdmJqZ3ZIekxoZk9aeTdpRjJKeFBFczNoZmliU245K3dNWWl2YzhX?=
 =?utf-8?Q?HGERoQNt1hyWfgsI1KZWPfts1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37af090-fcf6-4ee7-baff-08dad86fc866
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 16:26:24.6022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Knz9JcevZ41UWLimmHaZ+sJa45nJljsamT0YnUIwx2qRMLkVLelQZkMPWrdCbeh70JzQhc0IcR7+fITofCt9Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent,

Thank you for taking a look at the report.

On 11/28/2022 10:49 PM, Vincent Guittot wrote:
> Hi Prateek,
> 
> On Mon, 28 Nov 2022 at 12:52, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> Hello Vincent,
>>
>> Following are the test results on dual socket Zen3 machine (2 x 64C/128T)
>>
>> tl;dr
>>
>> o All benchmarks with DEFAULT_LATENCY_NICE value are comparable to tip.
>>   There is, however, a noticeable dip for unixbench-spawn test case.
>>
>> o With the 2 rbtree approach, I do not see much difference in the
>>   hackbench results with varying latency nice value. Tests on v5 did
>>   yield noticeable improvements for hackbench.
>>   (https://lore.kernel.org/lkml/cd48ebbb-9724-985f-28e3-e558dea07827@amd.com/)
> 
> The 2 rbtree approach is the one that was already used in v5. I just
> rerun hackbench tests with latest tip and v6.2-rc7 and I can see large
> performance improvement for pipe tests on my system (8 cores system).
> Could you try witha larger number of group ? like 64, 128 and 256
> groups

Ah! My bad. I've rerun hackbench with larger number of groups and I see a
clear win for pipes with latency nice 19. Hackbench with sockets too see a
small win.

o pipes

$ perf bench sched messaging -p -l 50000 -g <groups>

latency_nice:           0                       19                      -20
32-groups:         9.43 (0.00 pct)         6.42 (31.91 pct)        9.75 (-3.39 pct)
64-groups:        21.55 (0.00 pct)        12.97 (39.81 pct)       21.48 (0.32 pct)
128-groups:       41.15 (0.00 pct)        24.18 (41.23 pct)       46.69 (-13.46 pct)
256-groups:       78.87 (0.00 pct)        43.65 (44.65 pct)       78.84 (0.03 pct)
512-groups:      125.48 (0.00 pct)        78.91 (37.11 pct)      136.21 (-8.55 pct)
1024-groups:     292.81 (0.00 pct)       151.36 (48.30 pct)      323.57 (-10.50 pct)

o sockets

$ perf bench sched messaging  -l 100000 -g <groups>

latency_nice:           0                       19                      -20
32-groups:        27.23 (0.00 pct)        27.00 (0.84 pct)        26.92 (1.13 pct)
64-groups:        45.71 (0.00 pct)        44.58 (2.47 pct)        45.86 (-0.32 pct)
128-groups:       79.55 (0.00 pct)        78.22 (1.67 pct)        80.01 (-0.57 pct)
256-groups:      161.41 (0.00 pct)       164.04 (-1.62 pct)      169.57 (-5.05 pct)
512-groups:      326.41 (0.00 pct)       310.00 (5.02 pct)       342.17 (-4.82 pct)
1024-groups:     634.36 (0.00 pct)       633.59 (0.12 pct)       640.05 (-0.89 pct)

Note: All tests were done in NPS1 mode.

> 
>>
>> [..snip..]
>>
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ~ Unixbench - DEFAULT_LATENCY_NICE ~
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> o NPS1
>>
>> Test                    Metric    Parallelism                   tip                   latency_nice
>> unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      48929419.48 (   0.00%)    49137039.06 (   0.42%)
>> unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6275526953.25 (   0.00%)  6265580479.15 (  -0.16%)
>> unixbench-syscall       Amean     unixbench-syscall-1        2994319.73 (   0.00%)     3008596.83 *  -0.48%*
>> unixbench-syscall       Amean     unixbench-syscall-512      7349715.87 (   0.00%)     7420994.50 *  -0.97%*
>> unixbench-pipe          Hmean     unixbench-pipe-1           2830206.03 (   0.00%)     2854405.99 *   0.86%*
>> unixbench-pipe          Hmean     unixbench-pipe-512       326207828.01 (   0.00%)   328997804.52 *   0.86%*
>> unixbench-spawn         Hmean     unixbench-spawn-1             6394.21 (   0.00%)        6367.75 (  -0.41%)
>> unixbench-spawn         Hmean     unixbench-spawn-512          72700.64 (   0.00%)       71454.19 *  -1.71%*
>> unixbench-execl         Hmean     unixbench-execl-1             4723.61 (   0.00%)        4750.59 (   0.57%)
>> unixbench-execl         Hmean     unixbench-execl-512          11212.05 (   0.00%)       11262.13 (   0.45%)
>>
>> o NPS2
>>
>> Test                    Metric    Parallelism                   tip                   latency_nice
>> unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      49271512.85 (   0.00%)    49245260.43 (  -0.05%)
>> unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6267992483.03 (   0.00%)  6264951100.67 (  -0.05%)
>> unixbench-syscall       Amean     unixbench-syscall-1        2995885.93 (   0.00%)     3005975.10 *  -0.34%*
>> unixbench-syscall       Amean     unixbench-syscall-512      7388865.77 (   0.00%)     7276275.63 *   1.52%*
>> unixbench-pipe          Hmean     unixbench-pipe-1           2828971.95 (   0.00%)     2856578.72 *   0.98%*
>> unixbench-pipe          Hmean     unixbench-pipe-512       326225385.37 (   0.00%)   328941270.81 *   0.83%*
>> unixbench-spawn         Hmean     unixbench-spawn-1             6958.71 (   0.00%)        6954.21 (  -0.06%)
>> unixbench-spawn         Hmean     unixbench-spawn-512          85443.56 (   0.00%)       70536.42 * -17.45%* (0.67% vs 0.93% - CoEff var)
> 
> I don't expect any perf improvement or regression when the latency
> nice is not changed

This regression can be ignored. Although the results from back to
back runs are very stable, I see the results vary when I rebuild
the unixbench binaries on my test setup.

			  tip	      latency_nice
unixbench-spawn-512	73489.0		78260.4		(kexec)
unixbench-spawn-512 	73332.7		77821.2		(reboot)
unixbench-spawn-512	86207.4		82281.2		(rebuilt + reboot)

I'll go back and look more into the spawn test because there is
something else at play there but other Unixbench results seem to
be stable looking at the rerun.

> 
>> unixbench-execl         Hmean     unixbench-execl-1             4767.99 (   0.00%)        4752.63 *  -0.32%*
>> unixbench-execl         Hmean     unixbench-execl-512          11250.72 (   0.00%)       11320.97 (   0.62%)
>>
>> o NPS4
>>
>> Test                    Metric    Parallelism                   tip                   latency_nice
>> unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      49041932.68 (   0.00%)    49156671.05 (   0.23%)
>> unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6286981589.85 (   0.00%)  6285248711.40 (  -0.03%)
>> unixbench-syscall       Amean     unixbench-syscall-1        2992405.60 (   0.00%)     3008933.03 *  -0.55%*
>> unixbench-syscall       Amean     unixbench-syscall-512      7971789.70 (   0.00%)     7814622.23 *   1.97%*
>> unixbench-pipe          Hmean     unixbench-pipe-1           2822892.54 (   0.00%)     2852615.11 *   1.05%*
>> unixbench-pipe          Hmean     unixbench-pipe-512       326408309.83 (   0.00%)   329617202.56 *   0.98%*
>> unixbench-spawn         Hmean     unixbench-spawn-1             7685.31 (   0.00%)        7243.54 (  -5.75%)
>> unixbench-spawn         Hmean     unixbench-spawn-512          72245.56 (   0.00%)       77000.81 *   6.58%*
>> unixbench-execl         Hmean     unixbench-execl-1             4761.42 (   0.00%)        4733.12 *  -0.59%*
>> unixbench-execl         Hmean     unixbench-execl-512          11533.53 (   0.00%)       11660.17 (   1.10%)
>>
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ~ Hackbench - Various Latency Nice Values ~
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> o 100000 loops
>>
>> - pipe (process)
>>
>> Test:                   LN: 0                   LN: 19                  LN: -20
>>  1-groups:         3.91 (0.00 pct)         3.91 (0.00 pct)         3.81 (2.55 pct)
>>  2-groups:         4.48 (0.00 pct)         4.52 (-0.89 pct)        4.53 (-1.11 pct)
>>  4-groups:         4.83 (0.00 pct)         4.83 (0.00 pct)         4.87 (-0.82 pct)
>>  8-groups:         5.09 (0.00 pct)         5.00 (1.76 pct)         5.07 (0.39 pct)
>> 16-groups:         6.92 (0.00 pct)         6.79 (1.87 pct)         6.96 (-0.57 pct)
>>
>> - pipe (thread)
>>
>>  1-groups:         4.13 (0.00 pct)         4.08 (1.21 pct)         4.11 (0.48 pct)
>>  2-groups:         4.78 (0.00 pct)         4.90 (-2.51 pct)        4.79 (-0.20 pct)
>>  4-groups:         5.12 (0.00 pct)         5.08 (0.78 pct)         5.16 (-0.78 pct)
>>  8-groups:         5.31 (0.00 pct)         5.28 (0.56 pct)         5.33 (-0.37 pct)
>> 16-groups:         7.34 (0.00 pct)         7.27 (0.95 pct)         7.33 (0.13 pct)
>>
>> - socket (process)
>>
>> Test:                   LN: 0                   LN: 19                  LN: -20
>>  1-groups:         6.61 (0.00 pct)         6.38 (3.47 pct)         6.54 (1.05 pct)
>>  2-groups:         6.59 (0.00 pct)         6.67 (-1.21 pct)        6.11 (7.28 pct)
>>  4-groups:         6.77 (0.00 pct)         6.78 (-0.14 pct)        6.79 (-0.29 pct)
>>  8-groups:         8.29 (0.00 pct)         8.39 (-1.20 pct)        8.36 (-0.84 pct)
>> 16-groups:        12.21 (0.00 pct)        12.03 (1.47 pct)        12.35 (-1.14 pct)
>>
>> - socket (thread)
>>
>> Test:                   LN: 0                   LN: 19                  LN: -20
>>  1-groups:         6.50 (0.00 pct)         5.99 (7.84 pct)         6.02 (7.38 pct)      ^
>>  2-groups:         6.07 (0.00 pct)         6.20 (-2.14 pct)        6.23 (-2.63 pct)
>>  4-groups:         6.61 (0.00 pct)         6.64 (-0.45 pct)        6.63 (-0.30 pct)
>>  8-groups:         8.87 (0.00 pct)         8.67 (2.25 pct)         8.78 (1.01 pct)
>> 16-groups:        12.63 (0.00 pct)        12.54 (0.71 pct)        12.59 (0.31 pct)
>>
>>> [..snip..]
>>>
>>
>> Apart from couple of anomalies, latency nice reduces wait time, especially
>> when the system is heavily loaded. If there is any data, or any specific
>> workload you would like me to run on the test system, please do let me know.
>> Meanwhile, I'll try to get some numbers for larger workloads like SpecJBB
>> that did see improvements with latency nice on v5.

Following are results for SpecJBB in NPS1 mode:

+----------------------------------------------+
|                |   Latency Nice    |         |
|     Metric     |-------------------|   tip   |
|                |    0    |    19   |         |
|----------------|-------------------|---------|
|    Max jOPS    | 100.00% | 102.19% | 101.02% |
| Criritcal jOPS | 100.00% | 122.41% | 100.41% |
+----------------------------------------------+

SpecJBB throughput for Max-jOPS is similar across the board
but Critical-jOPS throughput sees a good uplift again with
latency nice 19.

> 
> [..snip..]
>

If there is any specific workload you would like me to test,
please do let me know. I'll try to test more workloads I come
across with different latency nice values and update you
with the results on this thread.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
--
Thanks and Regards,
Prateek
