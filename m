Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25A46B88E0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 04:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjCNDNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 23:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCNDNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 23:13:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F934685
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 20:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADxv9V6Aoa64ZnQ2MP8xDHcqkb4Mqu74w92xpA3akUYQKvKHBDjy2P2jZoNerbDAAzEE+5IgGtCRkb+fEGbo1fnesTqO0vo8Vp9qKuaTVzSKIH2m3YzPC/gyU7eOky8ChG7EDA7cppHGqqEjsfhvmcnPY7GjgVbRFXqa0BC94M9VVG91KkrTAyTneyO18pZ644bm09a6r7Nw6FJkJuYttT1LMAr9vec36T1Fb+IrvtbA+qClfTEPe8GDkT2of3kivDtZ0KbGhfa+Ip5hL6X0emnJOdmYKWJmgKwg4GHpE6tfH63bbETt3hvJmxXQxqW66zmX6evJAvdmL/w8GCyl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zVum3YZ3AK3Qx4p3hFPfnI9+WF0EP3GAtOZhgam2uY=;
 b=OaWoghtxY5CbscR9rTggZVKUOQTdrVRbyhGgV9U97SXOYL1W8rBsBDwLRvqaZBPgeYCCElaHbtxMSNWtvhXQ0Te/A4zNAp8OjIAkfgK3RePmFeI9xn67gEeVCFDASduPl3/eZ3klmfOwVHoxGaQAsuBFVsD/Ysr9d8ROyK7tuX25cj6TB1hiAYtOGJQ0J3zy7eTQauy1aFelBUvsJujTQv4ZP3r8wMYYq9plirDX+5n/AqubOK36aUToquM3xhlVJmG0to35CL6fGjIq5cm2+k8VIGFLDpz/lEJYy/aCkuCvuaRQ3hCkaRWQ5VWBd0GeiFTG1CkCINPP2m2DAWL5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zVum3YZ3AK3Qx4p3hFPfnI9+WF0EP3GAtOZhgam2uY=;
 b=qySSzHOnwgd1Mk0VyHJYQMayjJgFLClu7bdUBSZcJX2kVlpca3fhpkAVuGFXO/lkXbaK91Ca1IBpJKe3TpYn1Yk9CbBUNICcB7OGFJkPlFwjH86KB7KwIFqTEkAW3f0X4haJO2pqZ3x3SlSaF5ubd0tezXgQ2TcBGAmv4z7VtmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 03:13:33 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::f2f8:a2b0:8e91:de7]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::f2f8:a2b0:8e91:de7%7]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 03:13:33 +0000
Message-ID: <28659855-c1a4-ab61-433e-a5bccb96fcbd@amd.com>
Date:   Tue, 14 Mar 2023 08:43:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v6 0/2] sched/fair: Wake short task on current CPU
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Hillf Danton <hdanton@sina.com>,
        kernel test robot <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        linux-kernel@vger.kernel.org
References: <cover.1677069490.git.yu.c.chen@intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <cover.1677069490.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::28) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc4b95a-1b4d-45e0-b371-08db243a17c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4J/hh0gTuqaZpSw0YGw/15bCEtkKCZja5gsACXE++cze2XxJAJ03dnIeJfbrVzt44YWf8TPIz0Ts7Emsrge/s0/mPITVeSA0Fk3zIfBjlhQYapiD9lr440pfQq5r+/8yc9ZSYtRTWx8t0ILVUHHal5fTGJBetns7Z9cbw2K21XzbEopjKo8/GkyTNR7GikdGrcAJA/2I6O9uBTUd8Fj27ssx2YW0hnrWCiJnn69TrdpfyFddZvq2l1veNMxwmcvd3NWUActKDFTIGcVzFexTezfoYofZ1Og5eHveEGDH3wRH6vsnVZDdLcShJ9YJgzNJjJqrBe96Do0z32kZvbWWZsE3yhXdRAuS7Qairc0tYNzeWE6XnysZQUipU9cfpuhZkkIQyCb74k9qya+1+98/Q8TWR0I1ROfjhtCOaQE71BmXXw6ZTRosK+7z0YATFNKvDmGiTQqPcUWG+nngh7I4BnXJ7vZACpp6TcIZgI8BRfy/L+Fgj663HVNsSygjO3TlGxPPzUPiEVStRWMqih2G2fu2PFuoxBQ+EnN9COT+m4AztZ+pU5+CDP6FiLYXHfTcma7yZenGWaMdqQT2MyBHfL8wTUg1JWUVy37UZAdx5yFqpP/mqNc2kFkuqABCOsZXCBRBkeGxIvMQV2ok/JV3rrfZ4M5YmqeGwzfc1ap5/UDaikrc3/K3wnl7DLqMZFvyq4H7ftVc+/c9Q6jh/+eoo+I3CdN8W8bFo7LhTaSg66lA45VrjP8q0IXlgGRZc1+rvMP+ii+6jWIh+2QHOV9oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199018)(36756003)(30864003)(7416002)(5660300002)(83380400001)(186003)(6506007)(26005)(6666004)(966005)(2616005)(6486002)(6512007)(53546011)(4326008)(54906003)(8676002)(66556008)(66946007)(66476007)(8936002)(41300700001)(110136005)(86362001)(31696002)(478600001)(316002)(38100700002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHdmd2g0dDFROWtRN1NCaTVMQURDVzI5Z1dMaUpuTGZSRC9GaktKcWVFVTk5?=
 =?utf-8?B?Ykg3YTBhOXFTUFJDVTVYUkhER1E0Z0Y2SDdVa0F0VTd2ekFBQUMwSzZKcGVz?=
 =?utf-8?B?LzlTUjMzNkZ6STNjMGE5NmxLQVYzc3VwTHhNNmtER2lJanpsQXBpOWVtaDAw?=
 =?utf-8?B?WTFEemxRcW83NDdidThOZ2tpTTZiMUZ0NnJIYXpPRVExNlRWWm1pZDJITlY0?=
 =?utf-8?B?RTNKb2lUeUF6dWRWdkZWOXM0Wis2N0NDSXlobEF3Q0RIRmdlaGpJUXFZVTlE?=
 =?utf-8?B?ZUs3ZTBpZmpyZHBxL1FjRUQ5bXFQMWVpN1labFFQZVNiOWZDdjVPcWlZZTkv?=
 =?utf-8?B?K1Q2c09KN2N1cTlDUFhYY0R0TVc5dDJJM1BUUDQzOVU0V1hVV0tpRWFDZFV3?=
 =?utf-8?B?UFZIdGZjM1FaUG1hb0tFTkluRm5GVjJMMzZZa290QWhKQ3NzTEVrY21GcGY0?=
 =?utf-8?B?WGhQanlKM3JDY1c0Z1VoZXZKZ1hIWm1zYnIyOHJlMlZtcEUwdUFPVkt5c09h?=
 =?utf-8?B?aW90Tll6MmlIcWduWVQxWkxHNC9DK1BNR3laZ3VLcVlMMFpGbzhNU3hxQ3JJ?=
 =?utf-8?B?bktXVjBtdjREVlFmeHlrcVc3UUlqQnVlc1V3UWNORFV4aCtvVGM0c1FwM29I?=
 =?utf-8?B?K3NUV1NsMXRNS29XcUtmb3lFbHVDMHJCMXEwQVgxYXdDalNxanhEN1FGNjd1?=
 =?utf-8?B?a1oyRzZObW1SSnZUbE9HK3pBRHlwblJKK3Axclk0V2RuckEyZXlNUVdwRlRG?=
 =?utf-8?B?UExGa1VjOFRYLzdrZnhITzF4QkNraWY0OHBvdW4rWnNmOHZNODg4b3RIWTl0?=
 =?utf-8?B?eW01cVFwekwwWHFRaWU1ZUZBOVVCbTNrRHg3TENaU3ljQUI4T1I4RElxSnlP?=
 =?utf-8?B?OU9RNGE2VDg5a09LZ0JKcjhYdndnY0JKaThqWStNTHo0VmtOMXJPOWppUEFZ?=
 =?utf-8?B?SndmeHdtSkFZajlGb05Nb01jRjNYL01obVJoUDZkRUhqb0lpb3FHSUxadFFl?=
 =?utf-8?B?eG9rSGZqQm9JWlVEaFRYOFA4Y29aS2dkd0U5K1pPTHltTFJZQW93Y3pmOUR2?=
 =?utf-8?B?YU5nNVFNU2huSHhiS1NHbnNlQ1ZRZVFIV1ZxeTlWQWZvWXowNGN0VHN5akFa?=
 =?utf-8?B?QWFSQ3hGWFp4Z0lnYmV5bVlwdmc0SXVNeFk3VnZEREIvSVd6Z3N1RmxpQ2Fm?=
 =?utf-8?B?VnZUcjJWczdaTkJKV3pZNVVpTmRSclYwMzZFY2JnNDlXVzlpd3JGQTF1L0p4?=
 =?utf-8?B?RW85RkQ1aU40NjlTaEFQL0wyaW5uNHFjbU5JNG5lQWNEbmtBYWtNejYvWlY0?=
 =?utf-8?B?aW1UNjhHcElEV2hCRStzbTB0QXZ5Q2RndGw3cVVBc2ZGTGpreklMTTNhNmt0?=
 =?utf-8?B?MUZrZXlHSnFoWlR0aVZtNzJPcVBKOWtCSGRuVXAwQk9vdHJMU0wyU3pEc082?=
 =?utf-8?B?MlJybEkwZEhRbDZnVDFXOHMyYk1nd3J0dmF5M1doZ0t1ZnNaKzNJSC9TMnhY?=
 =?utf-8?B?ekNXWHZhWFZKZG5Ieit2Q3lKbTVMNFhycDFvSm9QbHJFMS8wT0JDSFc5eHhH?=
 =?utf-8?B?QS9CaDR6N2c1YWxvNk5ZYXpNbHhhUFBXOHFxOTZFNWtDdW53bnIrVzhMSGZy?=
 =?utf-8?B?c3BaR0hKVHIxMmNNZUhWR2lnMGVLNy82d2hQY0RoTlNINy9oTEQ4RG1uaEtZ?=
 =?utf-8?B?UXgvbGxsczNFZ3NmN3JZTitUUXJieWorbzdwS3hDZWUwYzFkMmNIdlZwY00y?=
 =?utf-8?B?L1FOOW5oWG1ubnFrN1BlVmtHWGZOdm5leS9WVGxXTndFL0pjSHpJaEZQK0l4?=
 =?utf-8?B?QWtIeDBGT3B4NmVIWFptM2RpVFBZbmNGY1VhMmI4NU9hOE12aXQ5dXgrNFUv?=
 =?utf-8?B?b1R4UXRkc1RPVjFHTWVNWVM5VC9mVWRQNG1MdFpHTG9XZTBrV1hmVFFJVitB?=
 =?utf-8?B?TU0xU2k0OGFRa3lacWZsWVRqbURFM2hidkp3YmJZbVQ4TGx6VW0wbW9RYTlt?=
 =?utf-8?B?TEVhL2tjSGovVEduM3hMTU1OM1dWeTNCZ2R0dk9Gdy96WFNwT05LUzdJSTNH?=
 =?utf-8?B?Y2JvR2pQb0hhL3ovYmcxNERCdEJTQjNoWFVTVlR4WUdhMzFpZ0k2eTMwUkUx?=
 =?utf-8?Q?7DYOrrwJg/SsPeTxaWciSkg6u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc4b95a-1b4d-45e0-b371-08db243a17c3
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 03:13:33.3148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mXkVtbhctRp9qZwXuxwgKJz25ci/QWCAyOJnKdh23sx6VaFuKI9DVm4Re1iiRvn5xRiOmbLcM/UJDfOquczkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

I did not observe any regression when testing v6 :)
Most of the benchmark results are comparable to the tip with minor
gains in some benchmarks with single sender and single receiver.

Following are the results from testing the series on a dual socket
Zen3 machine (2 x 64C/128T):

NPS Modes are used to logically divide single socket into
multiple NUMA region.
Following is the NUMA configuration for each NPS mode on the system:

NPS1: Each socket is a NUMA node.
    Total 2 NUMA nodes in the dual socket machine.

    Node 0: 0-63,   128-191
    Node 1: 64-127, 192-255

NPS2: Each socket is further logically divided into 2 NUMA regions.
    Total 4 NUMA nodes exist over 2 socket.
   
    Node 0: 0-31,   128-159
    Node 1: 32-63,  160-191
    Node 2: 64-95,  192-223
    Node 3: 96-127, 223-255

NPS4: Each socket is logically divided into 4 NUMA regions.
    Total 8 NUMA nodes exist over 2 socket.
   
    Node 0: 0-15,    128-143
    Node 1: 16-31,   144-159
    Node 2: 32-47,   160-175
    Node 3: 48-63,   176-191
    Node 4: 64-79,   192-207
    Node 5: 80-95,   208-223
    Node 6: 96-111,  223-231
    Node 7: 112-127, 232-255

Benchmark Results:

Kernel versions:
- tip:          6.2.0-rc6 tip sched/core
- sis_short: 	6.2.0-rc6 tip sched/core + this series

When the testing started, the tip was at:
commit 7c4a5b89a0b5 "sched/rt: pick_next_rt_entity(): check list_entry"

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

o NPS1

Test:			tip			sis-short
 1-groups:	   4.63 (0.00 pct)	   4.47 (3.45 pct)
 2-groups:	   4.42 (0.00 pct)	   4.41 (0.22 pct)
 4-groups:	   4.21 (0.00 pct)	   4.24 (-0.71 pct)
 8-groups:	   4.95 (0.00 pct)	   5.06 (-2.22 pct)
16-groups:	   5.43 (0.00 pct)	   5.36 (1.28 pct)

o NPS2

Test:			tip			sis-short
 1-groups:	   4.68 (0.00 pct)	   4.58 (2.13 pct)
 2-groups:	   4.45 (0.00 pct)	   4.37 (1.79 pct)
 4-groups:	   4.19 (0.00 pct)	   4.30 (-2.62 pct)
 8-groups:	   4.80 (0.00 pct)	   5.22 (-8.75 pct)	*
  8-groups:	   4.91 (0.00 pct)	   5.01 (-2.03 pct)	[Verification Run]
16-groups:	   5.60 (0.00 pct)	   5.66 (-1.07 pct)

o NPS4

Test:			tip			sis-short
 1-groups:	   4.68 (0.00 pct)	   4.66 (0.42 pct)
 2-groups:	   4.56 (0.00 pct)	   4.52 (0.87 pct)
 4-groups:	   4.50 (0.00 pct)	   4.62 (-2.66 pct)
 8-groups:	   5.76 (0.00 pct)	   5.64 (2.08 pct)
16-groups:	   5.60 (0.00 pct)	   5.79 (-3.39 pct)

~~~~~~~~~~~~
~ schbench ~
~~~~~~~~~~~~

o NPS1

#workers:	tip			sis-short
  1:	  36.00 (0.00 pct)	  34.00 (5.55 pct)
  2:	  37.00 (0.00 pct)	  36.00 (2.70 pct)
  4:	  38.00 (0.00 pct)	  40.00 (-5.26 pct)
  8:	  52.00 (0.00 pct)	  46.00 (11.53 pct)
 16:	  66.00 (0.00 pct)	  68.00 (-3.03 pct)
 32:	 111.00 (0.00 pct)	 111.00 (0.00 pct)
 64:	 213.00 (0.00 pct)	 214.00 (-0.46 pct)
128:	 502.00 (0.00 pct)	 497.00 (0.99 pct)
256:	 45632.00 (0.00 pct)	 46784.00 (-2.52 pct)
512:	 78720.00 (0.00 pct)	 75136.00 (4.55 pct)

o NPS2

#workers:	tip			sis-short
  1:	  31.00 (0.00 pct)	  31.00 (0.00 pct)
  2:	  32.00 (0.00 pct)	  32.00 (0.00 pct)
  4:	  39.00 (0.00 pct)	  39.00 (0.00 pct)
  8:	  52.00 (0.00 pct)	  47.00 (9.61 pct)
 16:	  67.00 (0.00 pct)	  69.00 (-2.98 pct)
 32:	 113.00 (0.00 pct)	 118.00 (-4.42 pct)
 64:	 213.00 (0.00 pct)	 231.00 (-8.45 pct)	*
 64:	 225.00 (0.00 pct)	 214.00 (4.88 pct)	[Verification Run]
128:	 508.00 (0.00 pct)	 513.00 (-0.98 pct)
256:	 46912.00 (0.00 pct)	 45888.00 (2.18 pct)
512:	 76672.00 (0.00 pct)	 79232.00 (-3.33 pct)

o NPS4

#workers:	tip			sis-short
  1:	  33.00 (0.00 pct)	  29.00 (12.12 pct)
  2:	  40.00 (0.00 pct)	  35.00 (12.50 pct)
  4:	  44.00 (0.00 pct)	  40.00 (9.09 pct)
  8:	  73.00 (0.00 pct)	  60.00 (17.80 pct)
 16:	  71.00 (0.00 pct)	  69.00 (2.81 pct)
 32:	 111.00 (0.00 pct)	 119.00 (-7.20 pct)
 64:	 217.00 (0.00 pct)	 208.00 (4.14 pct)
128:	 509.00 (0.00 pct)	 889.00 (-74.65 pct)	*
128:	 525.90 (0.00 pct)	 542.00 (-3.23 pct)	[Verification Run]
256:	 44352.00 (0.00 pct)	 46528.00 (-4.90 pct)
512:	 75392.00 (0.00 pct)	 78720.00 (-4.41 pct)


~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

o NPS1

Clients:	tip			sis-short
    1	 483.10 (0.00 pct)	 479.99 (-0.64 pct)
    2	 956.03 (0.00 pct)	 961.15 (0.53 pct)
    4	 1786.36 (0.00 pct)	 1793.16 (0.38 pct)
    8	 3304.47 (0.00 pct)	 3224.76 (-2.41 pct)
   16	 5440.44 (0.00 pct)	 5584.12 (2.64 pct)
   32	 10462.02 (0.00 pct)	 10667.21 (1.96 pct)
   64	 18995.99 (0.00 pct)	 19802.51 (4.24 pct)
  128	 27896.44 (0.00 pct)	 28509.96 (2.19 pct)
  256	 49742.89 (0.00 pct)	 50404.44 (1.32 pct)
  512	 49583.01 (0.00 pct)	 49362.40 (-0.44 pct)
 1024	 48467.75 (0.00 pct)	 49393.34 (1.90 pct)

o NPS2

Clients:	tip			sis-short
    1	 472.57 (0.00 pct)	 491.88 (4.08 pct)
    2	 938.27 (0.00 pct)	 962.87 (2.62 pct)
    4	 1764.34 (0.00 pct)	 1782.85 (1.04 pct)
    8	 3043.57 (0.00 pct)	 3275.90 (7.63 pct)
   16	 5103.53 (0.00 pct)	 5098.77 (-0.09 pct)
   32	 9767.22 (0.00 pct)	 9730.51 (-0.37 pct)
   64	 18712.65 (0.00 pct)	 19153.47 (2.35 pct)
  128	 27691.95 (0.00 pct)	 28738.51 (3.77 pct)
  256	 47939.24 (0.00 pct)	 48571.73 (1.31 pct)
  512	 47843.70 (0.00 pct)	 49224.01 (2.88 pct)
 1024	 48412.05 (0.00 pct)	 48662.85 (0.51 pct)

o NPS4

Clients:	tip			sis-short
    1	 486.74 (0.00 pct)	 487.21 (0.09 pct)
    2	 950.50 (0.00 pct)	 944.87 (-0.59 pct)
    4	 1778.58 (0.00 pct)	 1785.67 (0.39 pct)
    8	 3106.36 (0.00 pct)	 3269.40 (5.24 pct)
   16	 5139.81 (0.00 pct)	 5346.01 (4.01 pct)
   32	 9911.04 (0.00 pct)	 9961.37 (0.50 pct)
   64	 18201.46 (0.00 pct)	 18755.21 (3.04 pct)
  128	 27284.67 (0.00 pct)	 27372.54 (0.32 pct)
  256	 46793.72 (0.00 pct)	 47277.47 (1.03 pct)
  512	 48841.96 (0.00 pct)	 47736.63 (-2.26 pct)
 1024	 48811.99 (0.00 pct)	 48066.96 (-1.52 pct)


~~~~~~~~~~
~ stream ~
~~~~~~~~~~

o NPS1

- 10 Runs:

Test:		tip			sis-short
 Copy:	 321229.54 (0.00 pct)	 332046.15 (3.36 pct)
Scale:	 207471.32 (0.00 pct)	 209724.40 (1.08 pct)
  Add:	 234962.15 (0.00 pct)	 238593.38 (1.54 pct)
Triad:	 246256.00 (0.00 pct)	 259065.38 (5.20 pct)

- 100 Runs:

Test:		tip			sis-short
 Copy:	 332714.94 (0.00 pct)	 330868.23 (-0.55 pct)
Scale:	 216140.84 (0.00 pct)	 218881.39 (1.26 pct)
  Add:	 239605.00 (0.00 pct)	 243423.22 (1.59 pct)
Triad:	 258580.84 (0.00 pct)	 257857.39 (-0.27 pct)

o NPS2

- 10 Runs:

Test:		tip			sis-short
 Copy:	 324423.92 (0.00 pct)	 314693.42 (-2.99 pct)
Scale:	 215993.56 (0.00 pct)	 216081.04 (0.04 pct)
  Add:	 250590.28 (0.00 pct)	 250786.87 (0.07 pct)
Triad:	 261284.44 (0.00 pct)	 258434.05 (-1.09 pct)

- 100 Runs:

Test:		tip			sis-short
 Copy:	 325993.72 (0.00 pct)	 321152.67 (-1.48 pct)
Scale:	 227201.27 (0.00 pct)	 224454.35 (-1.20 pct)
  Add:	 256601.84 (0.00 pct)	 253548.96 (-1.18 pct)
Triad:	 260222.19 (0.00 pct)	 259141.98 (-0.41 pct)

o NPS4

- 10 Runs:

Test:		tip			sis-short
 Copy:	 356850.80 (0.00 pct)	 355198.15 (-0.46 pct)
Scale:	 247219.39 (0.00 pct)	 240196.59 (-2.84 pct)
  Add:	 268588.78 (0.00 pct)	 265259.51 (-1.23 pct)
Triad:	 272932.59 (0.00 pct)	 275791.62 (1.04 pct)

- 100 Runs:

Test:		tip			sis-short
 Copy:	 365965.18 (0.00 pct)	 364556.47 (-0.38 pct)
Scale:	 246068.58 (0.00 pct)	 249613.08 (1.44 pct)
  Add:	 263677.73 (0.00 pct)	 267118.22 (1.30 pct)
Triad:	 273701.36 (0.00 pct)	 275324.29 (0.59 pct)

~~~~~~~~~~~~~
~ unixbench ~
~~~~~~~~~~~~~

o NPS1

Test			Metric	  Parallelism			tip		      sis_short
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      49077561.21 (   0.00%)    48958154.65 (  -0.24%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6276672225.10 (   0.00%)  6282377092.30 (   0.09%)
unixbench-syscall       Amean     unixbench-syscall-1        2664815.40 (   0.00%)     2682364.37 *  -0.66%*
unixbench-syscall       Amean     unixbench-syscall-512      7848462.70 (   0.00%)     7935735.97 *  -1.11%*
unixbench-pipe          Hmean     unixbench-pipe-1           2531131.89 (   0.00%)     2510761.89 *  -0.80%*
unixbench-pipe          Hmean     unixbench-pipe-512       305244521.98 (   0.00%)   302210856.64 *  -0.99%*
unixbench-spawn         Hmean     unixbench-spawn-1             4058.05 (   0.00%)        4060.15 (   0.05%)
unixbench-spawn         Hmean     unixbench-spawn-512          80162.90 (   0.00%)       80337.40 (   0.22%)
unixbench-execl         Hmean     unixbench-execl-1             4148.64 (   0.00%)        4150.92 (   0.05%)
unixbench-execl         Hmean     unixbench-execl-512          11077.20 (   0.00%)       11124.06 (   0.42%)

o NPS2

Test			Metric	  Parallelism			tip		      sis_short
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      49394822.56 (   0.00%)    49562225.47 (   0.34%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6262917314.00 (   0.00%)  6270269390.20 (   0.12%)
unixbench-syscall       Amean     unixbench-syscall-1        2663675.03 (   0.00%)     2685044.77 *  -0.80%*
unixbench-syscall       Amean     unixbench-syscall-512      7342392.90 (   0.00%)     7369717.10 *  -0.37%*
unixbench-pipe          Hmean     unixbench-pipe-1           2533194.04 (   0.00%)     2508985.37 *  -0.96%*
unixbench-pipe          Hmean     unixbench-pipe-512       303588239.03 (   0.00%)   301439936.90 *  -0.71%*
unixbench-spawn         Hmean     unixbench-spawn-1             5141.40 (   0.00%)        4840.60 (  -5.85%)	*
unixbench-spawn         Hmean     unixbench-spawn-1             4780.20 (   0.00%)        5235.90 *   9.53%*	[Verification Run]
unixbench-spawn         Hmean     unixbench-spawn-512          82993.79 (   0.00%)       77573.59 *  -6.53%*	*
unixbench-spawn         Hmean     unixbench-spawn-512          79664.40 (   0.00%)       81747.60 *   2.61%*	[Verification Run]
unixbench-execl         Hmean     unixbench-execl-1             4140.15 (   0.00%)        4134.94 (  -0.13%)
unixbench-execl         Hmean     unixbench-execl-512          12229.25 (   0.00%)       12392.40 (   1.33%)

o NPS4

Test			Metric	  Parallelism			tip		      sis_short
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      48970677.27 (   0.00%)    48906123.72 (  -0.13%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6294483486.30 (   0.00%)  6284127003.20 (  -0.16%)
unixbench-syscall       Amean     unixbench-syscall-1        2664715.13 (   0.00%)     2685194.30 *  -0.77%*
unixbench-syscall       Amean     unixbench-syscall-512      7938670.70 (   0.00%)     7824901.77 *   1.43%*
unixbench-pipe          Hmean     unixbench-pipe-1           2527605.54 (   0.00%)     2503782.85 *  -0.94%*
unixbench-pipe          Hmean     unixbench-pipe-512       305068507.23 (   0.00%)   302815020.95 *  -0.74%*
unixbench-spawn         Hmean     unixbench-spawn-1             5207.34 (   0.00%)        5221.99 (   0.28%)
unixbench-spawn         Hmean     unixbench-spawn-512          81352.38 (   0.00%)       82374.89 *   1.26%*
unixbench-execl         Hmean     unixbench-execl-1             4131.37 (   0.00%)        4130.76 (  -0.01%)
unixbench-execl         Hmean     unixbench-execl-512          13025.56 (   0.00%)       12816.98 (  -1.60%)

~~~~~~~~~~~~~~~~
~ ycsb-mongodb ~
~~~~~~~~~~~~~~~~

0 NPS1

tip		: 130249.00 (var: 1.16%)
sis_short	: 133626.00 (var: 1.09%)  (2.59%)

o NPS2

tip		: 131100.00 (var: 1.07%)
sis_short	: 133713.00 (var: 3.17%)  (1.99%)

o NPS4

tip		: 136446.00 (var: 1.97%)
sis_short	: 136700.00 (var: 3.16%)  (0.18%)

~~~~~~~~~~~~~~~~~
~ SpecJBB & DSB ~
~~~~~~~~~~~~~~~~~

- SpecJBB numbers see small improvements of ~2%.
- DeathStarBench numbers remain similar to tip.

~~~~~~~~~~~
~ netperf ~
~~~~~~~~~~~

o NPS1

                        tip                     sis_short
 1-clients:      107932.22 (0.00 pct)    110175.53 (2.07 pct)
 2-clients:      106887.99 (0.00 pct)    108626.93 (1.62 pct)
 4-clients:      106676.11 (0.00 pct)    107736.87 (0.99 pct)
 8-clients:      98645.45 (0.00 pct)     97700.99 (-0.95 pct)
16-clients:      88881.23 (0.00 pct)     88800.03 (-0.09 pct)
32-clients:      86654.28 (0.00 pct)     87252.74 (0.69 pct)
64-clients:      81431.90 (0.00 pct)     79703.33 (-2.12 pct)
128-clients:     55993.77 (0.00 pct)     55681.20 (-0.55 pct)
256-clients:     43865.59 (0.00 pct)     42588.18 (-2.91 pct)

o NPS4

                        tip                     sis_short
 1-clients:      106711.81 (0.00 pct)    109905.29 (2.99 pct)
 2-clients:      106987.79 (0.00 pct)    108469.16 (1.38 pct)
 4-clients:      105275.37 (0.00 pct)    106707.13 (1.36 pct)
 8-clients:      103028.31 (0.00 pct)    103106.39 (0.07 pct)
16-clients:      87382.43 (0.00 pct)     88974.74 (1.82 pct)
32-clients:      86578.14 (0.00 pct)     87616.81 (1.19 pct)
64-clients:      81470.63 (0.00 pct)     81519.56 (0.06 pct)
128-clients:     54803.35 (0.00 pct)     55102.65 (0.54 pct)
256-clients:     42910.29 (0.00 pct)     41887.09 (-2.38 pct)


On 2/22/2023 7:39 PM, Chen Yu wrote:
> The main purpose is to avoid too many cross CPU wake up when it is
> unnecessary. The frequent cross CPU wake up brings significant damage
> to some workloads, especially on high core count systems.
> 
> Inhibits the cross CPU wake-up by placing the wakee on waking CPU,
> if both the waker and wakee are short-duration tasks. The short
> duration task could become a trouble maker on high-load system,
> because it could bring frequent context switch. This strategy
> only takes effect when the system is busy. Because it is unreasonable
> to inhibit the idle CPU scan when there are still idle CPUs.
> 
> First, introduce the definition of a short-duration task. Then
> leverages the first patch to choose a local CPU for wakee.
> 
> Overall there is performance improvement on some overloaded case.
> Such as will-it-scale, netperf. And no noticeable impact on
> schbench, hackbench, tbench and a OLTP workload with a commercial
> RDBMS, tested on a Intel Xeon 2 x 56C machine.
> 
> Per the test on Zen3 from Prateek, most benchmarks result saw small
> wins or are comparable to sched:tip. SpecJBB Critical-jOps improved while
> Max-jOPS saw a small hit, but it might be in the expected range.
> ycsb-mongodb saw small uplift in NPS1 mode.
> 
> Throughput improvement of netperf(localhost) was observed on a
> Rome 2 x 64C machine, when the number of clients equals the CPUs.
> 
> Abel reported against a latency regression from Redis on an overloaded
> system. Inspired by his description, v5 added the check of wakee_flips
> to mitigate task stacking.
> 
> Changes since v5:
> 1. Check the wakee_flips of the waker/wakee. If the wakee_flips
>    of waker/wakee are both 0, it indicates that the waker and the wakee
>    are waking up each other. In this case, put them together on the
>    same CPU. This is to avoid that too many wakees are stacked on
>    one CPU, which might cause regression on redis.
> 
> Changes since v4:
> 1. Dietmar has commented on the task duration calculation. So refined
>    the commit log to reduce confusion.
> 2. Change [PATCH 1/2] to only record the average duration of a task.
>    So this change could benefit UTIL_EST_FASTER[1].
> 3. As v4 reported regression on Zen3 and Kunpeng Arm64, add back
>    the system average utilization restriction that, if the system
>    is not busy, do not enable the short wake up. Above logic has
>    shown improvment on Zen3[2].
> 4. Restrict the wakeup target to be current CPU, rather than both
>    current CPU and task's previous CPU. This could also benefit
>    wakeup optimization from interrupt in the future, which is
>    suggested by Yicong.
> 
> Changes since v3:
> 1. Honglei and Josh have concern that the threshold of short
>    task duration could be too long. Decreased the threshold from
>    sysctl_sched_min_granularity to (sysctl_sched_min_granularity / 8),
>    and the '8' comes from get_update_sysctl_factor().
> 2. Export p->se.dur_avg to /proc/{pid}/sched per Yicong's suggestion.
> 3. Move the calculation of average duration from put_prev_task_fair()
>    to dequeue_task_fair(). Because there is an issue in v3 that,
>    put_prev_task_fair() will not be invoked by pick_next_task_fair()
>    in fast path, thus the dur_avg could not be updated timely.
> 4. Fix the comment in PATCH 2/2, that "WRITE_ONCE(CPU1->ttwu_pending, 1);"
>    on CPU0 is earlier than CPU1 getting "ttwu_list->p0", per Tianchen.
> 5. Move the scan for CPU with short duration task from select_idle_cpu()
>    to select_idle_siblings(), because there is no CPU scan involved, per
>    Yicong.
> 
> Changes since v2:
> 
> 1. Peter suggested comparing the duration of waker and the cost to
>    scan for an idle CPU: If the cost is higher than the task duration,
>    do not waste time finding an idle CPU, choose the local or previous
>    CPU directly. A prototype was created based on this suggestion.
>    However, according to the test result, this prototype does not inhibit
>    the cross CPU wakeup and did not bring improvement. Because the cost
>    to find an idle CPU is small in the problematic scenario. The root
>    cause of the problem is a race condition between scanning for an idle
>    CPU and task enqueue(please refer to the commit log in PATCH 2/2).
>    So v3 does not change the core logic of v2, with some refinement based
>    on Peter's suggestion.
> 
> 2. Simplify the logic to record the task duration per Peter and Abel's suggestion.
> 
> 
> [1] https://lore.kernel.org/lkml/c56855a7-14fd-4737-fc8b-8ea21487c5f6@arm.com/
> [2] https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/
> 
> v5: https://lore.kernel.org/lkml/cover.1675361144.git.yu.c.chen@intel.com/
> v4: https://lore.kernel.org/lkml/cover.1671158588.git.yu.c.chen@intel.com/
> v3: https://lore.kernel.org/lkml/cover.1669862147.git.yu.c.chen@intel.com/
> v2: https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/
> v1: https://lore.kernel.org/lkml/20220915165407.1776363-1-yu.c.chen@intel.com/
> 
> Chen Yu (2):
>   sched/fair: Record the average duration of a task
>   sched/fair: Introduce SIS_SHORT to wake up short task on current CPU
> 
>  include/linux/sched.h   |  3 +++
>  kernel/sched/core.c     |  2 ++
>  kernel/sched/debug.c    |  1 +
>  kernel/sched/fair.c     | 49 +++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/features.h |  1 +
>  5 files changed, 56 insertions(+)
> 

With the introduction of wakee_flips condition in is_short_task(),
most benchmarks that have multiple tasks interacting are now
comparable to tip. There may be other avenues for optimization
using SIS_SHORT as Abel pointed but this series is a good start in
that direction. 

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
--
Thanks and Regards,
Prateek
