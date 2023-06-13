Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4924E72DF9C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbjFMKdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjFMKcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:32:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BC72135;
        Tue, 13 Jun 2023 03:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0PkSVDCbEA9c+LB8hZNEAvSJzQOtW6uv3DuM2Gb22hvYde+cSxAiQSz2kxj3KhwAkUZC+ns6enECUpCWhOh7haCofwrld5UiGVqBU4l3PoqSGzk78JnkBYkCfDWOQtHS7qYWtAVzXNHB+HF3Ai3rh/kEOPoDGBB4oEdV+YqKmLqOjCmDAPtiv77TnnnDLMk6UHP5L/Pp3L424r/NiWwlVRdrNYU8Uip3Jrk+7Qg804Ta/uiLJLm4G0m4wDKpdjFiz0cJdd8LKBahB8owO+9Ie0/+qkGSzFJUeXQaeE7SzxWJp1qkJBC543gAWSIbe2ubO+HyrQ7i/pu8RzniSHEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+/jYDmu2x9DXZVUDiU3V5JMUoEvcWaOWcXVxSeNGRw=;
 b=mSbQJA73S5yFkiBQ7qlDdXqYG/6TL0N/br9HVm7HaPiQIFVZfqleX3eBXZVUF7/hrT6F7a7bBnfovQgwYVSUiaMGwqNyTwxXMS1ThyqgJL21ngBF1ZLDUBB+uTmd5y+/nSt9zCOVXDtd5ua9FRvHh2b374KEdSVC2bck4xZM8kbgJEvo1fnuTvZbOY+6Zy3UzDCegaP1fzGy3bgGoZkD8J7BK3aeYFmMSisrfsH1ZOtJxLHmC1ixvynW27o9p30My2Invdp68QNaFy+PptUtrMAm86Nj3/OcfKC+jejlLKuo1ads+lV3ipX0GJsnNyXmuQ6lyS3NCgUeTV+GWSR+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+/jYDmu2x9DXZVUDiU3V5JMUoEvcWaOWcXVxSeNGRw=;
 b=A8xueI/iO1Omy74w6hpXCMMFbvhgfsaXVzMBpV4nBasGMC7fqMj0sb9NJbMfLkp/dT42d9wD7CWVMedATeMP2VVnEkLuRzAd59+q/5C9zn+wVvG17XHUTSTy4+bk2qO/GX/AQXDL76JugELk5kEGC6kVWftq3rO363EnlPSrDas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 10:30:50 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c%2]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 10:30:50 +0000
Message-ID: <3402dcc4-d52f-d99f-e6ce-b435478a5a59@amd.com>
Date:   Tue, 13 Jun 2023 16:00:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
 <20230602065438.GB620383@hirez.programming.kicks-ass.net>
 <bd083d8d-023a-698e-701b-725f1b15766e@amd.com>
 <20230613082536.GI83892@hirez.programming.kicks-ass.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230613082536.GI83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::16) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 2154e06b-6065-4a66-fab5-08db6bf94199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xNBWhbzOLuQZr427WnREMI9hCSVOGuqQQET4jpoXdemHLTo1UyyJzg7D0HGjFgnS/QeutUgRRYRdKcZiYADSEUTHBUKnW1d+OPA9gHRMc1raFYFXixbpV0ZAzvBRNXKcHer8Rh2HwXcQV6smGvapbubTizuERL7O/VTwTu7tmcD0Pnn28AF5+8NWiAioQJ/x3I6L3cbtWL6saTPcD8sRoR5NEQENevXnko+Rd/t9Y+YKnEMyZBi9iW1eS2HBma/A1+TUd7ZsoAgzD7kF6fmOvCRf5oUsSgXe9SfUUXCRh0WeITHuyPtA0CmLKNwrGHoEJZrdFgewd0B/rznVipTTWylmpLXH9+wMLKzqE5Jxwu0JrYvn+oLsozI0m/xsUcLpc5AUp2AU5H+av1gORY85TTddQ+JM9kNsexUhSZo+4Ki389JP+t2cG2FJoOydgRSc3EoJV8ExLoacn05x+iQw5P1nK/HpeAUEFDZc+6Um3p4ncRMmn4rxDoMb94I7PM/oYqq34bCE8ak90LlAN4BEHDk+iWNcFww79arz4DNbAqOIB8rYRd2DugSdLKZQgmSgR+VpQN2d6RWNW54Ck2BtZeO7ZyhOQMUR71zHouSrJOq0qsJ0V+a6vgq6OFax7xvXsN2/HPYQ0c18CkHi4fx5eB31Ouqk6zNdIOMA4DBkRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(6666004)(6486002)(478600001)(6506007)(26005)(53546011)(6512007)(83380400001)(186003)(36756003)(2616005)(86362001)(38100700002)(31696002)(4326008)(6916009)(66556008)(66476007)(66946007)(316002)(8676002)(8936002)(31686004)(5660300002)(30864003)(41300700001)(2906002)(54906003)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWdBK1BUSURhajg3S2tHYk5TYzRDZ1U2UzN0SnFnMnlySVRSYnNwRHE1bFoy?=
 =?utf-8?B?Q3V0M0xVRXptNVR4aUxrVUl3NXk1dnZuK29hZzY2UUo1OUFKY0VES0ZOWllu?=
 =?utf-8?B?bGg1c090NE95SGEwaWdoS0ZqVWdFUDF5SGx4b0hFd3Byb3h1aHZpb0NISEg1?=
 =?utf-8?B?V2FtQWppMW1wSTc0Ri8vUzUvVUFyZ0o3UEowai82NTZUNFhqbnJSZXh0WHVl?=
 =?utf-8?B?SVFFWFVhNWVmc0RXRU5VNW9Ua1Q2VVNqWjk2Y09UZlhVamN0alh6ZEZFZGZQ?=
 =?utf-8?B?THNtQnNZSitmaVVOeVhXRnZNWWNyd0VySWdVaU92T2plZXpxNUdKOVFHd2FB?=
 =?utf-8?B?TE44V0VWb3JnSmovdzM3YnRSdzI4VXE3Vmt6WVZJbnpXM3llckFONUhVTnF0?=
 =?utf-8?B?S1d6bUlvK0J4ZEt0Ykg1Q0hwZXExdWgxTTNZMC9aQmNvN2RUeUo1MzU3Rm1E?=
 =?utf-8?B?YWw3aDAzbGtZd2YyQnZ2dk4rc1IrNHhWMnp6Wk5jSjJYRjVyNzBOc0YzTW1k?=
 =?utf-8?B?OFdRWDlzODRUNkQrYWg3L1pSdzlPbHNreWN4QmhJYzhVQ2dpb1huajFUUTNM?=
 =?utf-8?B?Yld4aFAyS3kwWmVpTmVNTGlhRDlTbzNHNUJYM2pvd1ZJMWc1d0wxK3BCRHVh?=
 =?utf-8?B?QnNkUGJkeHFtSFIwWkpxSDNvTVpzTWs3dDdCZHQzMHdudGhxT1JLS3lLNVcz?=
 =?utf-8?B?VkRhTUpkVVJobTZYUWZ2T3c4ZkRFQm5xMHZ6SWJWTHNyajliRlE0dFF1d0Er?=
 =?utf-8?B?YVlYRFRHbTNNU0NOQmVaZk1DMWkwRDJoNmI4OFU3MVFKUGZZcXdXMUNYQnJH?=
 =?utf-8?B?S3JmVXpiRk5RZGJ2QlpvRDhkUGdxb3lMd2JkOXB3U01RY2YzRXJkM2llVGla?=
 =?utf-8?B?Qlg4Y2lwSzVpbkFTQy81UUhPaVRzN1VLSGVZREh3MnFLNjVIRklKTklBdGN4?=
 =?utf-8?B?WXRlcnc0Ny9adjl0cHY1a2x2cURwQ2NEZUphTjlSMGRkMU1VVUc2cG1TZzZQ?=
 =?utf-8?B?U1NQcXRqU1JOb3dxKzRyM3llcTZkczVEM3VEVXE3TjJxZnlvSC9rTVlqZlNY?=
 =?utf-8?B?dGRXdUVnZW9FeklHbkNYeWxXL01XYTB2aTBWSEErZ01OUE1OcVBhUEdZeFdq?=
 =?utf-8?B?RmJaNGhxUU5XL0hSMjc5R2U2KzZpbGZnTGJCNW5kUWJyWUUzTWgrSDZLcnYv?=
 =?utf-8?B?dnJuVHRybnAyallycHh2OEFLTnIxUHpOTlNZNEVjVVJPRVBCbVpVeUxITjVR?=
 =?utf-8?B?ZWlFQWVZa0xSZWpDaWFQRFM5SkVkdDRKRjdNejlGbjBHeS9BVCtWeEFhdkRF?=
 =?utf-8?B?NndjaC9QQi9WNjQvTVZLWUNUQTNPRnJKSHZGc3lqbytzNkFzcFYwdUlFakd0?=
 =?utf-8?B?aU15OXlUWXhtdUZ5emNPS2JTYUVCT3RLMW85aU45cU1XZlBuc1dRRXBJVEM3?=
 =?utf-8?B?Smd5eWl3ZDFXUlVLZnJDY1NJMVk5SjBBUWV5WmlGdUlkQjlqSzFYT0dZTVJr?=
 =?utf-8?B?ZU5ZV3NWK2pXczRyakxNVjBkWHhyRDlFMitObHVzUDI0bmt1MHJvWXBPWm1J?=
 =?utf-8?B?LzhKOVNsc1lJSGROdzhsUTRnQ1pjNjdiMW55MmxhL0x5RnV2Q2k3V21GUU1s?=
 =?utf-8?B?amFyeEN2aGZGeGNJanpxL2lDNG9ld0p3RjRzbVpXT0VzVy9xdk5tbUx2K0hx?=
 =?utf-8?B?cGZjWjRNbTBKL1U2K0ZPVEhzbEdZNTltZlFQNmdTT09WUzc0RzBvRlgvaDQ2?=
 =?utf-8?B?L0trckU3VjR1aDhGT1J2aE5RSENTSVBlK25Ha3Qwb2xLK0RleHZZNTRSOFVr?=
 =?utf-8?B?Ym1Da1pvSVNLRTMyT0ZrRzh6UW9HM2hrM0RQblMzNU1HVHRuRVZvVG9hWU5h?=
 =?utf-8?B?WlZpaGVPZzJGS2ZYNDFEN2R6MEZ5TkpLeWdRakdNcnRMc1ZXK3h1MG9YQlp6?=
 =?utf-8?B?a1ZSVGwwUURIRnphaXMwV0pXMkgzM2F1cnNVbUdTbEp3QXNkUEU5TFNpc1I0?=
 =?utf-8?B?UlZBV0RWTmZPaHNqUkZYSlFHYVhDNjRwcnlMdzVsQ3ZNWDhKbXE0TkwwZUtZ?=
 =?utf-8?B?U2g0NFBZYnVwblpNSDU0ZnVXeUMyalFtWUxKNWl4b2pBN0Z3NmNwNTBXSGMy?=
 =?utf-8?Q?oHY79Yp4YhXtT/pfPkHAf1bcA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2154e06b-6065-4a66-fab5-08db6bf94199
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:30:49.8467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flU6bRw6eu17daf0aNXCYN5IHZtw2NH1/7LL+o2XhLn3j2RykHZVZg3ckiesX1BvwTbEQTqTbI29KFiD+KyVWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

On 6/13/2023 1:55 PM, Peter Zijlstra wrote:
> On Thu, Jun 08, 2023 at 12:02:15AM +0530, K Prateek Nayak wrote:
>> Hello Peter,
>>
>> Below are the benchmark results on different NPS modes for SIS_NODE
>> and SIS_NODE + additional suggested changes. None of them give a
>> total win. Limit helps but there are cases where it still leads to
>> regression. I'll leave full details below.
>>
>> On 6/2/2023 12:24 PM, Peter Zijlstra wrote:
>>> On Fri, Jun 02, 2023 at 10:43:37AM +0530, K Prateek Nayak wrote:
>>>> Grouping near-CCX for the offerings that do not have 2CCX per CCD will
>>>> prevent degenration and limit the search scope yes. Here is what I'll
>>>> do, let me check if limiting search scope helps first, and then start
>>>> fiddling with the topology. How does that sound?
>>>
>>> So my preference would be the topology based solution, since the search
>>> limit is random magic numbers that happen to work for 'your' machine but
>>> who knows what it'll do for some other poor architecture that happens to
>>> trip this.
>>>
>>> That said; verifying the limit helps at all is of course a good start,
>>> because if it doesn't then the topology thing will likely also not help
>>> much.
>>
>> o NPS Modes
>>
>> NPS Modes are used to logically divide single socket into
>> multiple NUMA region.
>> Following is the NUMA configuration for each NPS mode on the system:
>>
>> NPS1: Each socket is a NUMA node.
>>     Total 2 NUMA nodes in the dual socket machine.
>>
>>     Node 0: 0-63,   128-191
>>     Node 1: 64-127, 192-255
>>
>>     - 8CCX per node
> 
> Ok, so this is a dual-socket Zen3 with 64 cores per socket, right?

Yup!

> 
> 
>> o Kernel Versions
>>
>> - tip              - tip:sched/core at commit e2a1f85bf9f5 "sched/psi:
>>                      Avoid resetting the min update period when it is
>>                      unnecessary")
>>
>> - SIS_NODE         - tip:sched/core + this patch
>>
>> - SIS_NODE_LIMIT   - tip:sched/core + this patch + nr=4 limit for SIS_NODE
>> 		     (https://lore.kernel.org/all/20230601111326.GV4253@hirez.programming.kicks-ass.net/)
>>
>> - SIS_NODE_TOPOEXT - tip:sched/core + this patch
>>                      + new sched domain (Multi-Multi-Core or MMC)
>> 		     (https://lore.kernel.org/all/20230601153522.GB559993@hirez.programming.kicks-ass.net/)
>> 		     MMC domain groups 2 nearby CCX.
> 
> OK, so you managed to get the NPS4 topology in NPS1 mode?

Yup! But it is a hack. I'll leave the patch at the end.

> 
>> o Benchmark Results
>>
>> Note: All benchmarks were run with boost enabled and C2 disabled.
>>
>> ~~~~~~~~~~~~~
>> ~ hackbench ~
>> ~~~~~~~~~~~~~
>>
>> o NPS1
>>
>> Test:                   tip                     SIS_NODE           SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
>>  1-groups:         3.92 (0.00 pct)         4.05 (-3.31 pct)        3.78 (3.57 pct)         3.77 (3.82 pct)
>>  2-groups:         4.58 (0.00 pct)         3.84 (16.15 pct)        4.50 (1.74 pct)         4.34 (5.24 pct)
>>  4-groups:         4.99 (0.00 pct)         3.98 (20.24 pct)        4.93 (1.20 pct)         5.01 (-0.40 pct)
>>  8-groups:         5.67 (0.00 pct)         6.05 (-6.70 pct)        5.73 (-1.05 pct)        5.95 (-4.93 pct)
>> 16-groups:         7.88 (0.00 pct)        10.56 (-34.01 pct)       7.83 (0.63 pct)         8.04 (-2.03 pct)
>>
>> o NPS2
>>
>> Test:                   tip                     SIS_NODE           SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
>>  1-groups:         3.82 (0.00 pct)         3.68 (3.66 pct)         3.87 (-1.30 pct)        3.74 (2.09 pct)
>>  2-groups:         4.40 (0.00 pct)         3.61 (17.95 pct)        4.45 (-1.13 pct)        4.30 (2.27 pct)
>>  4-groups:         4.84 (0.00 pct)         3.62 (25.20 pct)        4.84 (0.00 pct)         4.97 (-2.68 pct)
>>  8-groups:         5.45 (0.00 pct)         6.14 (-12.66 pct)       5.40 (0.91 pct)         5.68 (-4.22 pct)
>> 16-groups:         6.94 (0.00 pct)         8.77 (-26.36 pct)       6.57 (5.33 pct)         7.87 (-13.40 pct)
>>
>> o NPS4
>>
>> Test:                   tip                     SIS_NODE           SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
>>  1-groups:         3.82 (0.00 pct)         3.84 (-0.52 pct)        3.83 (-0.26 pct)        3.85 (-0.78 pct)
>>  2-groups:         4.44 (0.00 pct)         4.15 (6.53 pct)         4.43 (0.22 pct)         4.18 (5.85 pct)
>>  4-groups:         4.86 (0.00 pct)         4.95 (-1.85 pct)        4.88 (-0.41 pct)        4.79 (1.44 pct)
>>  8-groups:         5.42 (0.00 pct)         5.80 (-7.01 pct)        5.41 (0.18 pct)         5.75 (-6.08 pct)
>> 16-groups:         6.68 (0.00 pct)         9.07 (-35.77 pct)       6.72 (-0.59 pct)        8.66 (-29.64 pct)
> 
> Win for NODE_LIMIT for having the least regressions, but also no real
> gains.
> 
> Given NODE_TOPO does NPS4 that should be roughtly similar to limit=2 it
> should do 'better' but it doesn't, it's markedly worse... weird.
> 
> In fact, none of the NPS4 numbers make any sense, if you've already
> split the whole thing into 4, you remain with 2 CCXs per node and
> NODE should be NODE_LIMIT should be NODE_TOPO.
> 
> All the NODE variants should end up scanning both CCXs and performance
> should really be the same.
> 
> Something's wrong there.

Yup! I'm rerunning SIS_NODE_LIMIT because the numbers are completely off.
Possibly an error on my part when applying the patch.

> 
> 
>> ~~~~~~~~~~
>> ~ tbench ~
>> ~~~~~~~~~~
>>
>> o NPS1
>>
>> Clients:      tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
>>     1    452.49 (0.00 pct)       457.94 (1.20 pct)       458.13 (1.24 pct)       447.69 (-1.06 pct)
>>     2    862.44 (0.00 pct)       879.99 (2.03 pct)       881.19 (2.17 pct)       855.91 (-0.75 pct)
>>     4    1604.27 (0.00 pct)      1618.87 (0.91 pct)      1628.00 (1.47 pct)      1627.14 (1.42 pct)
>>     8    2966.77 (0.00 pct)      3040.90 (2.49 pct)      3037.70 (2.39 pct)      2957.91 (-0.29 pct)
>>    16    5176.70 (0.00 pct)      5292.29 (2.23 pct)      5445.15 (5.18 pct)      5241.61 (1.25 pct)
>>    32    8205.24 (0.00 pct)      8949.12 (9.06 pct)      8716.02 (6.22 pct)      8494.17 (3.52 pct)
>>    64    13956.71 (0.00 pct)     14461.42 (3.61 pct)     13620.04 (-2.41 pct)    15045.43 (7.80 pct)
>>   128    24005.50 (0.00 pct)     26052.75 (8.52 pct)     24975.03 (4.03 pct)     24008.73 (0.01 pct)
>>   256    32457.61 (0.00 pct)     21999.41 (-32.22 pct)   30810.93 (-5.07 pct)    31060.12 (-4.30 pct)
>>   512    34345.24 (0.00 pct)     41166.39 (19.86 pct)    30982.94 (-9.78 pct)    31864.14 (-7.22 pct)
>>  1024    33432.92 (0.00 pct)     40900.84 (22.33 pct)    30953.61 (-7.41 pct)    32006.81 (-4.26 pct)
>>
>> o NPS2
>>
>> Clients:      tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
>>     1    453.73 (0.00 pct)       451.63 (-0.46 pct)      455.97 (0.49 pct)       453.79 (0.01 pct)
>>     2    861.71 (0.00 pct)       857.85 (-0.44 pct)      868.30 (0.76 pct)       850.14 (-1.34 pct)
>>     4    1599.14 (0.00 pct)      1609.30 (0.63 pct)      1656.08 (3.56 pct)      1619.10 (1.24 pct)
>>     8    2951.03 (0.00 pct)      2944.71 (-0.21 pct)     3034.38 (2.82 pct)      2973.52 (0.76 pct)
>>    16    5080.32 (0.00 pct)      5160.39 (1.57 pct)      5173.32 (1.83 pct)      5150.99 (1.39 pct)
>>    32    7900.41 (0.00 pct)      8039.13 (1.75 pct)      8105.69 (2.59 pct)      7956.45 (0.70 pct)
>>    64    14629.65 (0.00 pct)     15391.08 (5.20 pct)     14546.09 (-0.57 pct)    15410.41 (5.33 pct)
>>   128    23155.88 (0.00 pct)     24015.45 (3.71 pct)     24263.82 (4.78 pct)     23351.35 (0.84 pct)
>>   256    33449.57 (0.00 pct)     33571.08 (0.36 pct)     32048.20 (-4.18 pct)    32869.85 (-1.73 pct)
>>   512    33757.47 (0.00 pct)     39872.69 (18.11 pct)    32945.66 (-2.40 pct)    34526.17 (2.27 pct)
>>  1024    34823.14 (0.00 pct)     41090.15 (17.99 pct)    32404.40 (-6.94 pct)    34522.97 (-0.86 pct)
>>
>> o NPS4
>>
>> Clients:      tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
>>     1    450.14 (0.00 pct)       454.46 (0.95 pct)       454.53 (0.97 pct)       451.43 (0.28 pct)
>>     2    863.26 (0.00 pct)       868.94 (0.65 pct)       891.89 (3.31 pct)       866.74 (0.40 pct)
>>     4    1618.71 (0.00 pct)      1599.13 (-1.20 pct)     1630.29 (0.71 pct)      1610.08 (-0.53 pct)
>>     8    2929.35 (0.00 pct)      3065.12 (4.63 pct)      3064.15 (4.60 pct)      3004.74 (2.57 pct)
>>    16    5114.04 (0.00 pct)      5261.40 (2.88 pct)      5238.04 (2.42 pct)      5108.53 (-0.10 pct)
>>    32    7912.18 (0.00 pct)      8926.77 (12.82 pct)     8382.51 (5.94 pct)      8214.73 (3.82 pct)
>>    64    14424.72 (0.00 pct)     14853.61 (2.97 pct)     14273.54 (-1.04 pct)    14430.17 (0.03 pct)
>>   128    23614.97 (0.00 pct)     24506.73 (3.77 pct)     24517.76 (3.82 pct)     23296.38 (-1.34 pct)
>>   256    34365.13 (0.00 pct)     35538.42 (3.41 pct)     31909.66 (-7.14 pct)    31009.12 (-9.76 pct)
>>   512    34215.50 (0.00 pct)     36017.49 (5.26 pct)     32696.70 (-4.43 pct)    33262.55 (-2.78 pct)
>>  1024    35421.90 (0.00 pct)     35193.81 (-0.64 pct)    32611.10 (-7.93 pct)    32795.86 (-7.41 pct)
> 
> tbench likes NODE
> 
>> ~~~~~~~~~~
>> ~ stream ~
>> ~~~~~~~~~~
>>
>> - 10 Runs
>>
>> o NPS1
>>
>> Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
>>  Copy:   271317.35 (0.00 pct)    292440.22 (7.78 pct)    302540.26 (11.50 pct)   287277.25 (5.88 pct)
>> Scale:   205533.77 (0.00 pct)    203362.60 (-1.05 pct)   207750.30 (1.07 pct)    205206.26 (-0.15 pct)
>>   Add:   221624.62 (0.00 pct)    225850.83 (1.90 pct)    233782.14 (5.48 pct)    229774.48 (3.67 pct)
>> Triad:   228500.68 (0.00 pct)    225885.25 (-1.14 pct)   238331.69 (4.30 pct)    240041.53 (5.05 pct)
>>
>> o NPS2
>>
>> Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
>>  Copy:   277761.29 (0.00 pct)    301816.34 (8.66 pct)    293563.58 (5.68 pct)    308218.80 (10.96 pct)
>> Scale:   215193.83 (0.00 pct)    212522.72 (-1.24 pct)   215758.66 (0.26 pct)    205678.94 (-4.42 pct)
>>   Add:   242725.75 (0.00 pct)    242695.13 (-0.01 pct)   246472.20 (1.54 pct)    238089.46 (-1.91 pct)
>> Triad:   237253.44 (0.00 pct)    250618.57 (5.63 pct)    239405.55 (0.90 pct)    249652.73 (5.22 pct)
>>
>> o NPS4
>>
>> Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
>>  Copy:   273307.14 (0.00 pct)    255091.78 (-6.66 pct)   301926.68 (10.47 pct)   262007.26 (-4.13 pct)
>> Scale:   235715.23 (0.00 pct)    222018.36 (-5.81 pct)   224881.52 (-4.59 pct)   222282.64 (-5.69 pct)
>>   Add:   244500.40 (0.00 pct)    230468.21 (-5.73 pct)   242625.18 (-0.76 pct)   227146.80 (-7.09 pct)
>> Triad:   250600.04 (0.00 pct)    236229.50 (-5.73 pct)   258064.49 (2.97 pct)    231772.02 (-7.51 pct)
>>
>> - 100 Runs
>>
>> Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
>>  Copy:   317381.65 (0.00 pct)    318827.08 (0.45 pct)    320898.32 (1.10 pct)    318922.96 (0.48 pct)
>> Scale:   214145.00 (0.00 pct)    206213.69 (-3.70 pct)   211019.12 (-1.45 pct)   210384.47 (-1.75 pct)
>>   Add:   239243.29 (0.00 pct)    229791.67 (-3.95 pct)   233827.11 (-2.26 pct)   236659.48 (-1.07 pct)
>> Triad:   249477.76 (0.00 pct)    236843.06 (-5.06 pct)   244688.91 (-1.91 pct)   235990.67 (-5.40 pct)
>>
>> o NPS2
>>
>> Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
>>  Copy:   318082.10 (0.00 pct)    322844.91 (1.49 pct)    310350.21 (-2.43 pct)   322495.84 (1.38 pct)
>> Scale:   219338.56 (0.00 pct)    218139.90 (-0.54 pct)   212288.47 (-3.21 pct)   221040.27 (0.77 pct)
>>   Add:   248118.20 (0.00 pct)    249826.98 (0.68 pct)    239682.55 (-3.39 pct)   253006.79 (1.97 pct)
>> Triad:   247088.55 (0.00 pct)    260488.38 (5.42 pct)    247892.42 (0.32 pct)    249081.33 (0.80 pct)
>>
>> o NPS4
>>
>> Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
>>  Copy:   345396.19 (0.00 pct)    343675.74 (-0.49 pct)   346990.96 (0.46 pct)    334677.55 (-3.10 pct)
>> Scale:   241521.63 (0.00 pct)    231494.70 (-4.15 pct)   236233.18 (-2.18 pct)   229159.01 (-5.11 pct)
>>   Add:   261157.86 (0.00 pct)    249663.86 (-4.40 pct)   253402.85 (-2.96 pct)   242257.98 (-7.23 pct)
>> Triad:   267804.99 (0.00 pct)    263071.00 (-1.76 pct)   264208.15 (-1.34 pct)   256978.50 (-4.04 pct)
> 
> Again, the NPS4 reults are weird.

NPS4 numbers are more or less within the run to run variation window.
I think the couple of drops for SIS_NODE_TOPOEXT is just a bad run.
Will rerun.

> 
>> ~~~~~~~~~~~
>> ~ netperf ~
>> ~~~~~~~~~~~
>>
>> o NPS1
>>
>>                         tip                  SIS_NODE              SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
>> 1-clients:       102839.97 (0.00 pct)    103540.33 (0.68 pct)    103769.74 (0.90 pct)    103271.77 (0.41 pct)
>> 2-clients:       98428.08 (0.00 pct)     100431.67 (2.03 pct)    100555.62 (2.16 pct)    100417.11 (2.02 pct)
>> 4-clients:       92298.45 (0.00 pct)     94800.51 (2.71 pct)     93706.09 (1.52 pct)     94981.10 (2.90 pct)
>> 8-clients:       85618.41 (0.00 pct)     89130.14 (4.10 pct)     87677.84 (2.40 pct)     88284.61 (3.11 pct)
>> 16-clients:      78722.18 (0.00 pct)     79715.38 (1.26 pct)     80488.76 (2.24 pct)     78980.88 (0.32 pct)
>> 32-clients:      73610.75 (0.00 pct)     72801.41 (-1.09 pct)    72167.43 (-1.96 pct)    75077.55 (1.99 pct)
>> 64-clients:      55285.07 (0.00 pct)     56184.38 (1.62 pct)     56443.79 (2.09 pct)     60689.05 (9.77 pct)
>> 128-clients:     31176.92 (0.00 pct)     32830.06 (5.30 pct)     35511.93 (13.90 pct)    35638.50 (14.31 pct)
>> 256-clients:     20011.44 (0.00 pct)     15135.39 (-24.36 pct)   17599.21 (-12.05 pct)   18219.29 (-8.95 pct)
>>
>> o NPS2
>>
>>                         tip                  SIS_NODE              SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
>> 1-clients:       103105.55 (0.00 pct)    101582.75 (-1.47 pct)   103077.22 (-0.02 pct)   102233.63 (-0.84 pct)
>> 2-clients:       98720.29 (0.00 pct)     98537.46 (-0.18 pct)    100761.54 (2.06 pct)    99211.39 (0.49 pct)
>> 4-clients:       92289.39 (0.00 pct)     94332.45 (2.21 pct)     93622.46 (1.44 pct)     93321.77 (1.11 pct)
>> 8-clients:       84998.63 (0.00 pct)     87180.90 (2.56 pct)     86970.84 (2.32 pct)     86076.75 (1.26 pct)
>> 16-clients:      76395.81 (0.00 pct)     80017.06 (4.74 pct)     77937.29 (2.01 pct)     75090.85 (-1.70 pct)
>> 32-clients:      71110.89 (0.00 pct)     69445.86 (-2.34 pct)    69273.81 (-2.58 pct)    66885.99 (-5.94 pct)
>> 64-clients:      49526.21 (0.00 pct)     50004.13 (0.96 pct)     51649.09 (4.28 pct)     51100.52 (3.17 pct)
>> 128-clients:     27917.51 (0.00 pct)     30581.70 (9.54 pct)     31587.40 (13.14 pct)    33477.65 (19.91 pct)
>> 256-clients:     20067.17 (0.00 pct)     26002.42 (29.57 pct)    18681.28 (-6.90 pct)    18144.96 (-9.57 pct)
>>
>> o NPS4
>>
>>                         tip                  SIS_NODE              SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
>> 1-clients:       102139.49 (0.00 pct)    103578.02 (1.40 pct)    103633.90 (1.46 pct)    101656.07 (-0.47 pct)
>> 2-clients:       98259.53 (0.00 pct)     99336.70 (1.09 pct)     99720.37 (1.48 pct)     98812.86 (0.56 pct)
>> 4-clients:       91576.79 (0.00 pct)     95278.30 (4.04 pct)     93688.37 (2.30 pct)     93848.94 (2.48 pct)
>> 8-clients:       84742.30 (0.00 pct)     89005.65 (5.03 pct)     87703.04 (3.49 pct)     86709.29 (2.32 pct)
>> 16-clients:      79540.75 (0.00 pct)     85478.97 (7.46 pct)     83195.92 (4.59 pct)     81016.24 (1.85 pct)
>> 32-clients:      71166.14 (0.00 pct)     74254.01 (4.33 pct)     72422.76 (1.76 pct)     71391.62 (0.31 pct)
>> 64-clients:      51763.24 (0.00 pct)     52565.56 (1.54 pct)     55159.65 (6.56 pct)     52472.91 (1.37 pct)
>> 128-clients:     27829.29 (0.00 pct)     35774.61 (28.55 pct)    33738.97 (21.23 pct)    34564.10 (24.20 pct)
>> 256-clients:     24185.37 (0.00 pct)     27215.35 (12.52 pct)    17675.87 (-26.91 pct)   24937.66 (3.11 pct)
> 
> NPS4 is weird again, but mostly wins.
> 
> Based on the NPS1 results I'd say this one goes to TOPO
> 
>> ~~~~~~~~~~~~~~~~
>> ~ ycsb-mongodb ~
>> ~~~~~~~~~~~~~~~~
>>
>> o NPS1
>>
>> tip:			131070.33 (var: 2.84%)
>> SIS_NODE:		131070.33 (var: 2.84%) (0.00%)
>> SIS_NODE_LIMIT:		137227.00 (var: 4.97%) (4.69%)
>> SIS_NODE_TOPOEXT:	133529.67 (var: 0.98%) (1.87%)
>>
>> o NPS2
>>
>> tip:			133693.67 (var: 1.69%)
>> SIS_NODE:		134173.00 (var: 4.07%) (0.35%)
>> SIS_NODE_LIMIT:		134124.67 (var: 2.20%) (0.32%)
>> SIS_NODE_TOPOEXT:	133747.33 (var: 2.49%) (0.04%)
>>
>> o NPS4
>>
>> tip:			132913.67 (var: 1.97%)
>> SIS_NODE:		133697.33 (var: 1.69%) (0.58%)
>> SIS_NODE_LIMIT:		133307.33 (var: 1.03%) (0.29%)
>> SIS_NODE_TOPOEXT:	133426.67 (var: 3.60%) (0.38%)
>>
>> ~~~~~~~~~~~~~
>> ~ unixbench ~
>> ~~~~~~~~~~~~~
>>
>> o NPS1
>>
>> kernel                        			tip                  SIS_NODE               SIS_NODE_LIMIT            SIS_NODE_TOPOEXT
>> Hmean     unixbench-dhry2reg-1   	  41322625.19 (   0.00%)    41224388.33 (  -0.24%)    41142898.66 (  -0.43%)    41222168.97 (  -0.24%)
>> Hmean     unixbench-dhry2reg-512	6252491108.60 (   0.00%)  6240160851.68 (  -0.20%)  6262714194.10 (   0.16%)  6259553403.67 (   0.11%)
>> Amean     unixbench-syscall-1    	   2501398.27 (   0.00%)    2577323.43 *  -3.04%*      2498697.20 (   0.11%)     2541279.77 *  -1.59%*
>> Amean     unixbench-syscall-512  	   8120524.00 (   0.00%)    7512955.87 *   7.48%*      7447849.67 *   8.28%*     7477129.17 *   7.92%*
>> Hmean     unixbench-pipe-1    		   2359346.02 (   0.00%)    2392308.62 *   1.40%*      2407625.04 *   2.05%*     2334146.94 *  -1.07%*
>> Hmean     unixbench-pipe-512		 338790322.61 (   0.00%)  337711432.92 (  -0.32%)    340399941.24 (   0.48%)   339008490.26 (   0.06%)
>> Hmean     unixbench-spawn-1       	      4261.52 (   0.00%)       4164.90 (  -2.27%)         4929.26 *  15.67%*        5111.16 *  19.94%*
>> Hmean     unixbench-spawn-512    	     64328.93 (   0.00%)      62257.64 *  -3.22%*        63740.04 *  -0.92%*       63291.18 *  -1.61%*
>> Hmean     unixbench-execl-1       	      3677.73 (   0.00%)       3652.08 (  -0.70%)         3642.56 *  -0.96%*        3671.98 (  -0.16%)
>> Hmean     unixbench-execl-512    	     11984.83 (   0.00%)      13585.65 *  13.36%*        12496.80 (   4.27%)       12306.01 (   2.68%)
>>
>> o NPS2
>>
>> kernel                        			tip                  SIS_NODE               SIS_NODE_LIMIT            SIS_NODE_TOPOEXT
>> Hmean     unixbench-dhry2reg-1   	  41311787.29 (   0.00%)    41412946.27 (   0.24%)    41035150.98 (  -0.67%)    41371003.93 (   0.14%)
>> Hmean     unixbench-dhry2reg-512	6243873272.76 (   0.00%)  6256893083.32 (   0.21%)  6236751880.89 (  -0.11%)  6235047089.83 (  -0.14%)
>> Amean     unixbench-syscall-1    	   2503190.70 (   0.00%)     2576854.30 *  -2.94%*     2496464.80 *   0.27%*     2540298.77 *  -1.48%*
>> Amean     unixbench-syscall-512  	   8012388.13 (   0.00%)     7503196.87 *   6.36%*     7493284.60 *   6.48%*     7495117.73 *   6.46%*
>> Hmean     unixbench-pipe-1    		   2340486.25 (   0.00%)     2388946.63 (   2.07%)     2412344.33 *   3.07%*     2360277.30 (   0.85%)
>> Hmean     unixbench-pipe-512		 338965319.79 (   0.00%)   337225630.07 (  -0.51%)   339053027.04 (   0.03%)   336939353.18 *  -0.60%*
>> Hmean     unixbench-spawn-1      	      5241.83 (   0.00%)        5246.00 (   0.08%)        4718.45 *  -9.98%*        4967.96 *  -5.22%*
>> Hmean     unixbench-spawn-512    	     65799.86 (   0.00%)       64817.15 *  -1.49%*       66418.37 (   0.94%)       66820.63 *   1.55%*
>> Hmean     unixbench-execl-1       	      3670.65 (   0.00%)        3622.36 *  -1.32%*        3661.04 (  -0.26%)        3660.08 (  -0.29%)
>> Hmean     unixbench-execl-512    	     13682.00 (   0.00%)       13699.90 (   0.13%)       14103.91 (   3.08%)       12960.11 (  -5.28%)
>>
>> o NPS4
>>
>> kernel                        			tip                  SIS_NODE               SIS_NODE_LIMIT            SIS_NODE_TOPOEXT
>> Hmean     unixbench-dhry2reg-1   	  41025577.99 (   0.00%)    40879469.78 (  -0.36%)    41082700.61 (   0.14%)    41260407.54 (   0.57%)
>> Hmean     unixbench-dhry2reg-512	6255568261.91 (   0.00%)  6258326086.80 (   0.04%)  6252223940.32 (  -0.05%)  6259088809.43 (   0.06%)
>> Amean     unixbench-syscall-1    	   2507165.37 (   0.00%)    2579108.77 *  -2.87%*      2488617.40 *   0.74%*     2517574.40 (  -0.42%)
>> Amean     unixbench-syscall-512  	   7458476.50 (   0.00%)    7502528.67 *  -0.59%*      7978379.53 *  -6.97%*     7580369.27 *  -1.63%*
>> Hmean     unixbench-pipe-1    		   2369301.21 (   0.00%)    2392905.29 *   1.00%*      2410432.93 *   1.74%*     2347814.20 (  -0.91%)
>> Hmean     unixbench-pipe-512		 340299405.72 (   0.00%)  339139980.01 *  -0.34%*    340403992.95 (   0.03%)   338708678.82 *  -0.47%*
>> Hmean     unixbench-spawn-1      	      5571.78 (   0.00%)       5423.03 (  -2.67%)         5462.82 (  -1.96%)        5543.08 (  -0.52%)
>> Hmean     unixbench-spawn-512   	     63999.96 (   0.00%)      63485.41 (  -0.80%)        64730.98 *   1.14%*       67486.34 *   5.45%*
>> Hmean     unixbench-execl-1       	      3587.15 (   0.00%)       3624.44 *   1.04%*         3638.74 *   1.44%*        3639.57 *   1.46%*
>> Hmean     unixbench-execl-512    	     14184.17 (   0.00%)      13784.17 (  -2.82%)        13104.71 *  -7.61%*       13598.22 (  -4.13%)
>>
>> ~~~~~~~~~~~~~~~~~~
>> ~ DeathStarBench ~
>> ~~~~~~~~~~~~~~~~~~
>>
>> o NPS1
>> CCD	Scaling	       tip    SIS_NODE 		SIS_NODE_LIMIT 		SIS_NODE_TOPOEXT
>> 1	1		0%      0.30%  		 	0.83%  		 	0.79%
>> 1	1		0%      0.17%  		 	2.53%  		 	0.91%
>> 1	1		0%      -0.40% 		 	2.90%  		 	1.61%
>> 1	1		0%      -7.95% 		 	1.19%  		 	-1.56%
>>
>> o NPS2
>>
>> CCD	Scaling	       tip    SIS_NODE 		SIS_NODE_LIMIT 		SIS_NODE_TOPOEXT
>> 1	1		0%      0.34%  		 	-0.73% 		 	-0.62%
>> 1	1		0%      -0.02% 		 	0.14%  		 	-1.15%
>> 1	1		0%      -12.34%		 	-9.64% 		 	-7.80%
>> 1	1		0%      -12.41%		 	-1.03% 		 	-9.85%
>>
>> Note: In NPS2, 8 CCD case shows 10% run to run variation.
>>
>> o NPS4
>>
>> CCD	Scaling	       tip    SIS_NODE 		SIS_NODE_LIMIT 		SIS_NODE_TOPOEXT
>> 1	1		0%      -1.32% 		 	-0.71% 		 	-1.09%
>> 1	1		0%      -1.53% 		 	-1.11% 		 	-1.73%
>> 1	1		0%      7.19%  		 	-3.47% 		 	5.75%
>> 1	1		0%      -4.66% 		 	-1.91% 		 	-7.52%
> 
> LIMIT seems to do well for the NPS1 case, but how come it falls apart
> for NPS2 ?!? that doesn't realy make sense, does it?
> 
> And again NPS4 is all over the place :/

Yup! I'm doing a full rerun for SIS_NODE_LIMIT. 

> 
>>
>> --
>> If you would like me to collect any more information during any of the
>> above benchmark runs, please let me know.
> 
> dizzy with numbers ....
> 
> Perhaps see if you can figure out why NPS4 is so weird, there's only 2
> CCXs to go around per node on that thing, the various results should not
> be all over the map.
> 
> Perhaps pick hackbenc since it shows the problem and is easy and quick
> to run?

I've ran hackbench on NPS2 and the results from SIS_NODE_LIMIT_RE is
similar to SIS_NODE.

Test:                   tip                    SIS_NODE             SIS_NODE_LIMIT        SIS_NODE_LIMIT_RE       SIS_NODE_TOPOEXT
 1-groups:         3.82 (0.00 pct)         3.68 (3.66 pct)         3.87 (-1.30 pct)        3.80 (0.52 pct)         3.74 (2.09 pct)
 2-groups:         4.40 (0.00 pct)         3.61 (17.95 pct)        4.45 (-1.13 pct)        3.90 (11.36 pct)        4.30 (2.27 pct)
 4-groups:         4.84 (0.00 pct)         3.62 (25.20 pct)        4.84 (0.00 pct)         4.11 (15.08 pct)        4.97 (-2.68 pct)
 8-groups:         5.45 (0.00 pct)         6.14 (-12.66 pct)       5.40 (0.91 pct)         6.15 (-12.84 pct)       5.68 (-4.22 pct)
16-groups:         6.94 (0.00 pct)         8.77 (-26.36 pct)       6.57 (5.33 pct)         9.51 (-37.03 pct)       7.87 (-13.40 pct)

Since I've messed something up for SIS_NODE_LIMIT I'll give it a full
rerun.

> 
> Also, can you share the TOPOEXT code?

Here you go. It is not pretty and assigning the mmc_id is a hack.
Below diff should apply cleanly on top of commit e2a1f85bf9f5
("sched/psi: Avoid resetting the min update period when it is
unnecessary") with the SIS_NODE patch.

---
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4e91054c84be..cca5d147d8e1 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -16,8 +16,10 @@ DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
 /* cpus sharing the last level cache: */
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
+DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_mc_shared_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
 DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id);
+DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_mc_id);
 DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id);
 
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
@@ -166,6 +168,11 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 	return per_cpu(cpu_llc_shared_map, cpu);
 }
 
+static inline struct cpumask *cpu_mc_shared_mask(int cpu)
+{
+	return per_cpu(cpu_mc_shared_map, cpu);
+}
+
 static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
 {
 	return per_cpu(cpu_l2c_shared_map, cpu);
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 458c891a8273..b3519d2d0b56 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -102,6 +102,7 @@ static inline void setup_node_to_cpumask_map(void) { }
 
 #include <asm-generic/topology.h>
 
+extern const struct cpumask *cpu_mcgroup_mask(int cpu);
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 4063e8991211..f6e3be6f2512 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -35,6 +35,7 @@
 
 /* Shared last level cache maps */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
+DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_mc_shared_map);
 
 /* Shared L2 cache maps */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
@@ -677,6 +678,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu)
 		 * Core complex ID is ApicId[3] for these processors.
 		 */
 		per_cpu(cpu_llc_id, cpu) = c->apicid >> 3;
+		per_cpu(cpu_mc_id, cpu) = c->apicid >> 4;
 	} else {
 		/*
 		 * LLC ID is calculated from the number of threads sharing the
@@ -693,6 +695,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu)
 			int bits = get_count_order(num_sharing_cache);
 
 			per_cpu(cpu_llc_id, cpu) = c->apicid >> bits;
+			per_cpu(cpu_mc_id, cpu) = (c->apicid >> bits) >> 1;
 		}
 	}
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 80710a68ef7d..a320516bf767 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -81,6 +81,7 @@ EXPORT_SYMBOL(smp_num_siblings);
 
 /* Last level cache ID of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
+DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_mc_id) = BAD_APICID;
 
 u16 get_llc_id(unsigned int cpu)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 28fcd292f5fd..dedf86b9e8cb 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -536,6 +536,23 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return topology_sane(c, o, "llc");
 }
 
+static bool match_mc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
+{
+	int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
+
+	/*
+	 * Do not match if we do not have a valid APICID for cpu.
+	 * TODO: For non AMD processors, return topology_same_node(c, o)?
+	 */
+	if (per_cpu(cpu_mc_id, cpu1) == BAD_APICID)
+		return false;
+
+	/* Do not match if LLC id does not match: */
+	if (per_cpu(cpu_mc_id, cpu1) != per_cpu(cpu_mc_id, cpu2))
+		return false;
+
+	return topology_sane(c, o, "mmc");
+}
 
 #if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_CLUSTER) || defined(CONFIG_SCHED_MC)
 static inline int x86_sched_itmt_flags(void)
@@ -570,7 +587,7 @@ static int x86_cluster_flags(void)
  */
 static bool x86_has_numa_in_package;
 
-static struct sched_domain_topology_level x86_topology[6];
+static struct sched_domain_topology_level x86_topology[7];
 
 static void __init build_sched_topology(void)
 {
@@ -596,6 +613,16 @@ static void __init build_sched_topology(void)
 		cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC)
 	};
 #endif
+
+	/*
+	 * Multi-Multi-Core Domain Experimentation
+	 */
+	if (static_cpu_has(X86_FEATURE_ZEN)) {
+		x86_topology[i++] = (struct sched_domain_topology_level){
+			cpu_mcgroup_mask, SD_INIT_NAME(MMC)
+		};
+	}
+
 	/*
 	 * When there is NUMA topology inside the package skip the DIE domain
 	 * since the NUMA domains will auto-magically create the right spanning
@@ -628,6 +655,7 @@ void set_cpu_sibling_map(int cpu)
 	if (!has_mp) {
 		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
 		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
+		cpumask_set_cpu(cpu, cpu_mc_shared_mask(cpu));
 		cpumask_set_cpu(cpu, cpu_l2c_shared_mask(cpu));
 		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
 		cpumask_set_cpu(cpu, topology_die_cpumask(cpu));
@@ -647,6 +675,9 @@ void set_cpu_sibling_map(int cpu)
 		if ((i == cpu) || (has_mp && match_llc(c, o)))
 			link_mask(cpu_llc_shared_mask, cpu, i);
 
+		if ((i == cpu) || (has_mp && match_mc(c, o)))
+			link_mask(cpu_mc_shared_mask, cpu, i);
+
 		if ((i == cpu) || (has_mp && match_l2c(c, o)))
 			link_mask(cpu_l2c_shared_mask, cpu, i);
 
@@ -700,6 +731,12 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 	return cpu_llc_shared_mask(cpu);
 }
 
+/* maps the cpu to the sched domain representing multi-multi-core */
+const struct cpumask *cpu_mcgroup_mask(int cpu)
+{
+	return cpu_mc_shared_mask(cpu);
+}
+
 const struct cpumask *cpu_clustergroup_mask(int cpu)
 {
 	return cpu_l2c_shared_mask(cpu);
@@ -1393,6 +1430,7 @@ void __init smp_prepare_cpus_common(void)
 		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
+		zalloc_cpumask_var(&per_cpu(cpu_mc_shared_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL);
 	}
@@ -1626,9 +1664,12 @@ static void remove_siblinginfo(int cpu)
 
 	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
 		cpumask_clear_cpu(cpu, cpu_llc_shared_mask(sibling));
+	for_each_cpu(sibling, cpu_mc_shared_mask(cpu))
+		cpumask_clear_cpu(cpu, cpu_mc_shared_mask(sibling));
 	for_each_cpu(sibling, cpu_l2c_shared_mask(cpu))
 		cpumask_clear_cpu(cpu, cpu_l2c_shared_mask(sibling));
 	cpumask_clear(cpu_llc_shared_mask(cpu));
+	cpumask_clear(cpu_mc_shared_mask(cpu));
 	cpumask_clear(cpu_l2c_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
--

I'll share the data from the reruns of SIS_NODE_LIMIT soon. In the
meantime, if there is anything you would like more data on, please do let
me know.

--
Thanks and Regards,
Prateek
