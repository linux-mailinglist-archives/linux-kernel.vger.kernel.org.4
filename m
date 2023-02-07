Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D592668CD91
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBGDm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBGDm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:42:56 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17AD2CFDA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:42:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9HBSytbHovUZQD7Km3Bh+1lXxN+0G5GWckH1vRKJs8e42HAiZW1Hyp/o93nmuCV86Y/ieFnxhk4v95/aepq/0A2FZjH8/ooolrxcdV2qmWNUlJrmdCg9EKHfgZo5iI1q9LKIIn7rh7tiQCZq/qW/WgOicRImbxXZNgufulLBGPCXM6phmTdlBXOf0os7JbtxDBjjjWQ7HUgQwlvofRpnlAvnvmUeQNyRnpauKXMhCQpfMEk6mQo9RIqPvsAa9lAIU7x/rRnLjZPsU4O5Iau/1w31kvdhjpmPFt5AB0VdSBRSGv89O3w/9QqmIxX4xzOpD37uQrJpSS9IL9U0WiVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMPXiLHExdQ9l4OvqnqNn5bDRmevNdZ9HLw+ck9GFp8=;
 b=A5LaNCdUbzSYdiInrx68ZtrSCMJe2apXyUGEdDww+mDkLQ7hmCQVBJal9wIfegctvQwE9O39UWuzvXPMRbSx5qYTLk3drZcyQcwKSyDkdnlyxNmq6Xq7JiQh2EXhYV6MGw0qbwmQ2s3Yw/mx+R1NpRa0l98q5U6wMsg8qjZsQrk1BDIA8aQ2CnotrPaVogo4BrM7tOHGFiair1CLzCskzFLY+U4+C7t+DE5JdDsqZEQvHEc9smMxg/PmGoLYPpqrkAAMyTPY/w/g9liWQA51OTyg12s5plXrAxJwtXfYZ1TpOidwJ48yBHUPVIpwnqSF+V8DsYT3LCthDoCD4iK+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMPXiLHExdQ9l4OvqnqNn5bDRmevNdZ9HLw+ck9GFp8=;
 b=Jzx+LcaKhP/Bvqbhlv3x8PCmA/gFhC5gmaKIP4c6AK0BSXt06WjlFiziEgUPRBFFQY/ABmETTyxmxFQrMb//nzfrWoWvrRnLlruHYgN6BkM+iaz9D5SL015GXWJG82SSE++a/JG0113NaBkGTml5CWwI9m/5v3sio7qjculX7xY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Tue, 7 Feb
 2023 03:42:43 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3c8d:4028:1920:2b41]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3c8d:4028:1920:2b41%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 03:42:43 +0000
Message-ID: <01eb35f2-4a34-7fbc-da48-c9558dca7212@amd.com>
Date:   Tue, 7 Feb 2023 09:12:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v6 0/4] sched/fair: Improve scan efficiency of SIS
Content-Language: en-US
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
References: <20221019122859.18399-1-wuyun.abel@bytedance.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20221019122859.18399-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::27) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b8c3ab-3a70-4384-a6b0-08db08bd5e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gA2zHlni+narMMAvRSvDvYYdp32wsDKAWyR///1PJ/v1JGKT1QM/E7ATkGxQ8vJj1ZXiPgsbpdjlhoBbQ+Wszt78U9VPZCfyEiUdWpfGHm2ox7T9IrLZvLHb1/Fs5i1EO3RFIul/LNbhgpDI0Tnd2zK6QIwDndR8jB1Dl+xsMzNDLUwFIFdjWVdKTEl/t84GZ7yf5HUApPTQ6JQZnLHgU9y/EOMRyf2UfpSZUQrR1V6LEORj/0kJxIjN8pmDEv+zV9rewtxEEJ/LsZJST8huN9N7l92kUIYKZ+Lhmq9u1pCSnuwLraDoAWRGyUjWXxgGnO3tfp96NWt8l+LaHvELVYuB5mZAi03pzko2UVbcjCtFMQwnYjrfaWseo21mPUglvY8RouMfL+OBG1wqwDAbwMKnNsm+Kn/fNW8pWL/bPC/9Yju6woEzHEeclkOkodKV75naxop0iDuRB5HXDesOvN29tPZilsaVP8PVJj4GWoKOYfuHVISGIAiCGNIF1J/PRdoCNPe742u8iIoTRg3yOUZMsZGdnC0E/A2NjaAncJ9O2Z//B2ls8yNM3froMcS7/7N6zqUTdtyxkBHQ6oAF9gu3/eQz3d0BuCNjCQHG8dxNmyVsZ4navI9dzkS99fID4qg/5fTwYR000oHPKxGOTDrCwN6cko6lZ8ZZ5BUWgxaYbUEzPQihFlYa01rQD97hYld4/saL0ZMev7voUazGfzLCdBZBlgXnB5Yfs/IcMi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199018)(36756003)(31696002)(5660300002)(2906002)(66556008)(86362001)(8936002)(7416002)(6486002)(2616005)(478600001)(38100700002)(30864003)(41300700001)(66899018)(31686004)(26005)(66476007)(6512007)(54906003)(4326008)(186003)(110136005)(8676002)(66946007)(6666004)(316002)(53546011)(83380400001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmpYYlNsbHdFUFpUTlNuYjZTbHlUdmpYcXhhaTlLdzBldnVKeEtZNHJlM3JZ?=
 =?utf-8?B?UnlSbXlQaCt2bFJhY1pta04zalYyRDVTNzVyMU9yekFCK1BlR2x4NVN2SlR6?=
 =?utf-8?B?VmVDdDRHV0xaV3FYNGU1ZThHVi9lQlFEODVpaHR6eFJBQlYxeXNTWC9Cbmho?=
 =?utf-8?B?RFFBU0Y5TXUrL1VpVGJSSytWbGZDSjNySnpJRkpaYURWTnNKYlFpVXhpYmFZ?=
 =?utf-8?B?SFZ5azR1SEkzU1c5OU9WY0pXNzNKVXRwRjdSczB4R01jOHZSYnMxekR6L0s4?=
 =?utf-8?B?ZTdpZ25GNmZEU0QyQXdMUHJyeUl3VGdNbzZPT1M5V2kzL2ZkUTNuOE5aMjFF?=
 =?utf-8?B?WXpkdUh5YWdtc051SGlNa1FBRWVxWkNydjlzY1RzRE1oM3Q0dXY2NDJvamlR?=
 =?utf-8?B?K01ZbFZGcFFzTjdWNkNKdGlHSTNEVVp2SUkyZkx6eGM3WDY3cFJXc3JraXdt?=
 =?utf-8?B?SmRtRTJCRURCbU9qbEJuaG1pY2hXOUR0RW1Ed3kwM081QmlZM3NHRkp5SGd1?=
 =?utf-8?B?MExBZUFHdDNjZVpuZStFc2kxT2dhL0k0Z2hqdW9TMWg0WGRwaDJ3QWcvZnFp?=
 =?utf-8?B?bzlxVmVoN3BqajhwUHY3RmJJbWpuaHcxY0ZwZTN0MUlMTWFmUUROTTBDS0RD?=
 =?utf-8?B?S1VJUnlUaUpURnVZa2RhM2J6RTlyd1BqQVNXTlc1VjY5ZFowbFlndWtCWTkx?=
 =?utf-8?B?ZDV6Wmg5R0FiTTJmVHY2d3dnanlwWFFlVG5iZ2dxNFJUN2ZQR284TnZQRUU2?=
 =?utf-8?B?T1o0UXZuYW5tdkpZRkN5SnRxMnpXMTRrejVla1FUTGdDWmpPOE4vcTRrZVJP?=
 =?utf-8?B?MHlsdzJYUHRhamVmS0RIOUc4eHZzUHhFdDdlMHB2R2FWZ0l1REFMRW5vNzNq?=
 =?utf-8?B?YnZ3a204K0JDMGJjWGs0YTFKWngrQjhEWHFMUitJNzFGT1F5SVVGdGRWUW5Z?=
 =?utf-8?B?OXRXTndWa1dlcE02SVZ2bkNZa3F5d01zN0V1aTQrSi94bnpvOGZ0V3lRQlpP?=
 =?utf-8?B?VkxBVUIyMUswZVovbkZxWkZDekMvZW1VK3BvUmlPdUQxdVRjbHZIS1JVMWFt?=
 =?utf-8?B?U1lkd2NuRnp6WnJVd1Ara2YveE41SHFNN2k1SmJYSGxwYkR6NnM0NUNZanNw?=
 =?utf-8?B?UU1XNStzR2VEaERQVVhiTDNscnpmWk16NlBkY3NkREdmbHoyZkRpTkxESFYv?=
 =?utf-8?B?WTNjdGlScTdaZTMyU0x0OEEvTVlqY3ZnVVJHZUVJOXo5MVc4RGtRWHpuV1pv?=
 =?utf-8?B?WkpzR3lDRmtPUnQxNjJJWnBFNWlLUDNsSmZkVUhXYzFrUjJnTEpaRGNBV0Fv?=
 =?utf-8?B?SlpGSEplb3VsVFNhSS9qTUZaZEtmUmMxSlkxeXhqK3ppR2QrbElmUkxmdHBx?=
 =?utf-8?B?VXNtYml5UHZkWDZCMUhzUnNuWTNKQ2VlanV3andvU1pLWlgrTDI1bCtkUjNt?=
 =?utf-8?B?T1o4MGZrc3dZSTZnMWdrOXBiYVB0UUwxV1RMQXdweFlFWXFobHdkWFJ4bDlk?=
 =?utf-8?B?SUE0SXd6MEJyNUpWSForZXFUWTB4VTBLTFZaMHhMTkFBcTNzNnE1c1dnN1VI?=
 =?utf-8?B?UlcxdEQrZjZNVHNIMHBrSWFQQkYwdFNRUFVWKzBCNkxnLzhTK3lWZHh4Qk5i?=
 =?utf-8?B?TU9GNTR1WG5YcnltY2V0L2JvQjRCeEQ3ZzhlR0h2MWxtMnArV1g0M2J4K3p5?=
 =?utf-8?B?WVlVTTVHcTVYSjN4Q213elBJWHRQaWI5T2FyekhsK2VoWTRIM0x4QkVRWmVW?=
 =?utf-8?B?R1Juc0FNZ2pPeU1CWTM3WHZpRDYveUNNTmtTMlYzM0xTVEx0NDcwU3pIbFls?=
 =?utf-8?B?UlQvc0VxMFhxcEU2MEVwL0QraDZ3NHFEdGFRU0YyRm03MGZOVkc2blYzQm9j?=
 =?utf-8?B?ZEMrODFaNTliemxZWjdseXZNbkVZeU9mR3NIVm1HTmNCOXFWN0J6RGZGMnBq?=
 =?utf-8?B?YWc2Vm01T0pNeTZUWlR2L2FBaU5GRjFNL1R5MW16Ty9aMDh5S1ZpNVpGZ0JZ?=
 =?utf-8?B?WDhXR1ZUMlh3b09vaGI4cnU0WHFsUmRTdlZoZWtCYVhDRVJBZ3FmRmN0VlFl?=
 =?utf-8?B?SUlwemtldHd3ekE5T25PT0hmYXMxUjF5UzJzTmUvREFCdEJseGR3cG0rMmQ3?=
 =?utf-8?Q?4DJD07d9/U2/tFyoSLQGEFh8c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b8c3ab-3a70-4384-a6b0-08db08bd5e87
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 03:42:43.5065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjzMZRmV3nqXo/y9O/lLdEk1wQ7i63QpHnEKb13EnFgSf85jwMsY5ViIirlOpxIzKLGBIoXJrdrHIgkBOvO81Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Abel,

I've retested the patches with on the updated tip and the results
are still promising.

tl;dr

o Hackbench sees improvements when the machine is overloaded.
o tbench shows improvements when the machine is overloaded.
o The unixbench regression seen previously seems to be unrelated
  to the patch as the spawn test scores are vastly different
  after a reboot/kexec for the same kernel.
o Other benchmarks show slight improvements or are comparable to
  the numbers on tip.

Following are the results from running standard benchmarks on a
dual socket Zen3 (2 x 64C/128T) machine configured in different
NPS modes.

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

Following are the Kernel versions:

tip:            6.2.0-rc2 tip:sched/core at
                commit: bbd0b031509b "sched/rseq: Fix concurrency ID handling of usermodehelper kthreads"
sis_short:      tip + series

The patch applied cleanly on the tip.

Benchmark Results:

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

NPS1

Test:			tip			sis_core
 1-groups:	   4.36 (0.00 pct)	   4.17 (4.35 pct)
 2-groups:	   5.17 (0.00 pct)	   5.03 (2.70 pct)
 4-groups:	   4.17 (0.00 pct)	   4.14 (0.71 pct)
 8-groups:	   4.64 (0.00 pct)	   4.63 (0.21 pct)
16-groups:	   5.43 (0.00 pct)	   5.32 (2.02 pct)

NPS2

Test:			tip			sis_core
 1-groups:	   4.43 (0.00 pct)	   4.27 (3.61 pct)
 2-groups:	   4.61 (0.00 pct)	   4.92 (-6.72 pct)	*
 2-groups:	   4.52 (0.00 pct)	   4.55 (-0.66 pct)	[Verification Run]
 4-groups:	   4.25 (0.00 pct)	   4.10 (3.52 pct)
 8-groups:	   4.91 (0.00 pct)	   4.53 (7.73 pct)
16-groups:	   5.84 (0.00 pct)	   5.54 (5.13 pct)

NPS4

Test:			tip			sis_core
 1-groups:	   4.34 (0.00 pct)	   4.23 (2.53 pct)
 2-groups:	   4.64 (0.00 pct)	   4.84 (-4.31 pct)
 4-groups:	   4.20 (0.00 pct)	   4.17 (0.71 pct)
 8-groups:	   5.21 (0.00 pct)	   5.06 (2.87 pct)
16-groups:	   6.24 (0.00 pct)	   5.60 (10.25 pct)

~~~~~~~~~~~~
~ schbench ~
~~~~~~~~~~~~

NPS1

#workers:	tip			sis_core
  1:	  36.00 (0.00 pct)	  23.00 (36.11 pct)
  2:	  37.00 (0.00 pct)	  37.00 (0.00 pct)
  4:	  37.00 (0.00 pct)	  38.00 (-2.70 pct)
  8:	  47.00 (0.00 pct)	  52.00 (-10.63 pct)
 16:	  64.00 (0.00 pct)	  65.00 (-1.56 pct)
 32:	 109.00 (0.00 pct)	 111.00 (-1.83 pct)
 64:	 222.00 (0.00 pct)	 215.00 (3.15 pct)
128:	 515.00 (0.00 pct)	 486.00 (5.63 pct)
256:	 39744.00 (0.00 pct)	 47808.00 (-20.28 pct)	* (Machine Overloaded ~ 2 tasks per rq)
256:	 43242.00 (0.00 pct)	 42293.00 (2.19 pct)	[Verification Run]
512:	 81280.00 (0.00 pct)	 76416.00 (5.98 pct)

NPS2

#workers:	tip			sis_core
  1:	  27.00 (0.00 pct)	  27.00 (0.00 pct)
  2:	  31.00 (0.00 pct)	  30.00 (3.22 pct)
  4:	  38.00 (0.00 pct)	  37.00 (2.63 pct)
  8:	  50.00 (0.00 pct)	  46.00 (8.00 pct)
 16:	  66.00 (0.00 pct)	  68.00 (-3.03 pct)
 32:	 116.00 (0.00 pct)	 113.00 (2.58 pct)
 64:	 210.00 (0.00 pct)	 228.00 (-8.57 pct)	*
 64:	 206.00 (0.00 pct)	 219.00 (-6.31 pct)	[Verification Run]
128:	 523.00 (0.00 pct)	 559.00 (-6.88 pct)	*
128:	 474.00 (0.00 pct)	 497.00 (-4.85 pct)	[Verification Run]
256:	 44864.00 (0.00 pct)	 47040.00 (-4.85 pct)
512:	 78464.00 (0.00 pct)	 81280.00 (-3.58 pct)

NPS4

#workers:	tip			sis_core
  1:	  32.00 (0.00 pct)	  27.00 (15.62 pct)
  2:	  32.00 (0.00 pct)	  35.00 (-9.37 pct)
  4:	  34.00 (0.00 pct)	  41.00 (-20.58 pct)
  8:	  58.00 (0.00 pct)	  58.00 (0.00 pct)
 16:	  67.00 (0.00 pct)	  69.00 (-2.98 pct)
 32:	 118.00 (0.00 pct)	 112.00 (5.08 pct)
 64:	 224.00 (0.00 pct)	 209.00 (6.69 pct)
128:	 533.00 (0.00 pct)	 519.00 (2.62 pct)
256:	 43456.00 (0.00 pct)	 45248.00 (-4.12 pct)
512:	 78976.00 (0.00 pct)	 76160.00 (3.56 pct)


~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

NPS1

Clients:	tip			sis_core
    1	 539.96 (0.00 pct)	 538.19 (-0.32 pct)
    2	 1068.21 (0.00 pct)	 1063.04 (-0.48 pct)
    4	 1994.76 (0.00 pct)	 1990.47 (-0.21 pct)
    8	 3602.30 (0.00 pct)	 3496.07 (-2.94 pct)
   16	 6075.49 (0.00 pct)	 6061.74 (-0.22 pct)
   32	 11641.07 (0.00 pct)	 11904.58 (2.26 pct)
   64	 21529.16 (0.00 pct)	 22124.81 (2.76 pct)
  128	 30852.92 (0.00 pct)	 31258.56 (1.31 pct)
  256	 51901.20 (0.00 pct)	 53249.69 (2.59 pct)
  512	 46797.40 (0.00 pct)	 54477.79 (16.41 pct)
 1024	 46057.28 (0.00 pct)	 53676.58 (16.54 pct)

NPS2

Clients:	tip			sis_core
    1	 536.11 (0.00 pct)	 541.18 (0.94 pct)
    2	 1044.58 (0.00 pct)	 1064.16 (1.87 pct)
    4	 2043.92 (0.00 pct)	 2017.84 (-1.27 pct)
    8	 3572.50 (0.00 pct)	 3494.83 (-2.17 pct)
   16	 6040.97 (0.00 pct)	 5530.10 (-8.45 pct)	*
   16	 5814.03 (0.00 pct)	 6012.33 (-8.45 pct)	[Verification Run]
   32	 10794.10 (0.00 pct)	 10841.68 (0.44 pct)
   64	 20905.89 (0.00 pct)	 21438.82 (2.54 pct)
  128	 30885.39 (0.00 pct)	 30064.78 (-2.65 pct)
  256	 48901.25 (0.00 pct)	 51395.08 (5.09 pct)
  512	 49673.91 (0.00 pct)	 51725.89 (4.13 pct)
 1024	 47626.34 (0.00 pct)	 52662.01 (10.57 pct)

NPS4

Clients:	tip			sis_core
    1	 544.91 (0.00 pct)	 544.66 (-0.04 pct)
    2	 1046.49 (0.00 pct)	 1072.42 (2.47 pct)
    4	 2007.11 (0.00 pct)	 1970.05 (-1.84 pct)
    8	 3590.66 (0.00 pct)	 3670.45 (2.22 pct)
   16	 5956.60 (0.00 pct)	 6045.07 (1.48 pct)
   32	 10431.73 (0.00 pct)	 10439.40 (0.07 pct)
   64	 21563.37 (0.00 pct)	 19344.05 (-10.29 pct)	*
   64	 19387.71 (0.00 pct)	 19050.47 (-1.73 pct)	[Verification Run]
  128	 30352.16 (0.00 pct)	 26998.85 (-11.04 pct)	*
  128	 29110.99 (0.00 pct)	 29690.37 (1.99 pct)	[Verification Run]
  256	 49504.51 (0.00 pct)	 50921.66 (2.86 pct)
  512	 44916.61 (0.00 pct)	 52176.11 (16.16 pct)
 1024	 49986.21 (0.00 pct)	 51639.91 (3.30 pct)


~~~~~~~~~~
~ stream ~
~~~~~~~~~~

NPS1

10 Runs:

Test:		tip			sis_core
 Copy:	 339390.30 (0.00 pct)	 324656.88 (-4.34 pct)
Scale:	 212472.78 (0.00 pct)	 210641.39 (-0.86 pct)
  Add:	 247598.48 (0.00 pct)	 241669.10 (-2.39 pct)
Triad:	 261852.07 (0.00 pct)	 252088.55 (-3.72 pct)

100 Runs:

Test:		tip			sis_core
 Copy:	 335938.02 (0.00 pct)	 331491.32 (-1.32 pct)
Scale:	 212597.92 (0.00 pct)	 218705.84 (2.87 pct)
  Add:	 248294.62 (0.00 pct)	 243830.42 (-1.79 pct)
Triad:	 258400.88 (0.00 pct)	 248178.42 (-3.95 pct)

NPS2

10 Runs:

Test:		tip			sis_core
 Copy:	 334500.32 (0.00 pct)	 335317.70 (0.24 pct)
Scale:	 216804.76 (0.00 pct)	 217862.71 (0.48 pct)
  Add:	 250787.33 (0.00 pct)	 258839.00 (3.21 pct)
Triad:	 259451.40 (0.00 pct)	 264847.88 (2.07 pct)

100 Runs:

Test:		tip			sis_core
 Copy:	 326385.13 (0.00 pct)	 338030.70 (3.56 pct)
Scale:	 216440.37 (0.00 pct)	 230053.24 (6.28 pct)
  Add:	 255062.22 (0.00 pct)	 259197.23 (1.62 pct)
Triad:	 265442.03 (0.00 pct)	 271365.65 (2.23 pct)

NPS4

10 Runs:

Test:		tip			sis_core
 Copy:   363927.86 (0.00 pct)    361014.15 (-0.80 pct)
Scale:   238190.49 (0.00 pct)    242176.02 (1.67 pct)
  Add:   262806.49 (0.00 pct)    266348.50 (1.34 pct)
Triad:   276492.33 (0.00 pct)    276769.10 (0.10 pct)

100 Runs:

Test:		tip			sis_core
 Copy:   365041.37 (0.00 pct)    349299.35 (-4.31 pct)
Scale:   239295.27 (0.00 pct)    229944.85 (-3.90 pct)
  Add:   264085.21 (0.00 pct)    252651.56 (-4.32 pct)
Triad:   279664.56 (0.00 pct)    274254.22 (-1.93 pct)

~~~~~~~~~~~~~~~~
~ ycsb-mongodb ~
~~~~~~~~~~~~~~~~

o NPS1

tip:                    131328.67 (var: 2.97%)
sis_core:               131702.33 (var: 3.61%)	(0.28%)

o NPS2:

tip:			132482.33 (var: 2.06%)
sis_core:		132338.33 (var: 0.97%)  (-0.11%)

o NPS4:

tip:                    134130.00 (var: 4.12%)
sis_core:               133224.33 (var: 4.13%)	(-0.67%)

~~~~~~~~~~~~~
~ unixbench ~
~~~~~~~~~~~~~

o NPS1

Test			Metric	  Parallelism			tip		      sis_core
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      48770555.20 (   0.00%)    49025161.73 (   0.52%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6268185467.60 (   0.00%)  6266351964.20 (  -0.03%)
unixbench-syscall       Amean     unixbench-syscall-1        2685321.17 (   0.00%)     2694468.30 *  -0.34%*
unixbench-syscall       Amean     unixbench-syscall-512      7291476.20 (   0.00%)     7295087.67 (  -0.05%)
unixbench-pipe          Hmean     unixbench-pipe-1           2480858.53 (   0.00%)     2536923.44 *   2.26%*
unixbench-pipe          Hmean     unixbench-pipe-512       300739256.62 (   0.00%)   303470605.93 *   0.91%*
unixbench-spawn         Hmean     unixbench-spawn-1             4358.14 (   0.00%)        4104.88 (  -5.81%)	* (Known to be unstable)
unixbench-spawn         Hmean     unixbench-spawn-1             4711.00 (   0.00%)        4006.20 ( -14.96%)	[Verification Run]
unixbench-spawn         Hmean     unixbench-spawn-512          76497.32 (   0.00%)       75555.94 *  -1.23%*
unixbench-execl         Hmean     unixbench-execl-1             4147.12 (   0.00%)        4157.33 (   0.25%)
unixbench-execl         Hmean     unixbench-execl-512          12435.26 (   0.00%)       11992.43 (  -3.56%)

o NPS2

Test			Metric	  Parallelism			tip		      sis_core
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      48872335.50 (   0.00%)    48902553.70 (   0.06%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6264134378.20 (   0.00%)  6260631689.40 (  -0.06%)
unixbench-syscall       Amean     unixbench-syscall-1        2683903.13 (   0.00%)     2694829.17 *  -0.41%*
unixbench-syscall       Amean     unixbench-syscall-512      7746773.60 (   0.00%)     7493782.67 *   3.27%*
unixbench-pipe          Hmean     unixbench-pipe-1           2476724.23 (   0.00%)     2537127.96 *   2.44%*
unixbench-pipe          Hmean     unixbench-pipe-512       300277350.41 (   0.00%)   302979776.19 *   0.90%*
unixbench-spawn         Hmean     unixbench-spawn-1             5026.50 (   0.00%)        4680.63 (  -6.88%)	*
unixbench-spawn         Hmean     unixbench-spawn-1             5421.70 (   0.00%)        5311.50 (  -2.03%)	[Verification Run]
unixbench-spawn         Hmean     unixbench-spawn-512          80549.70 (   0.00%)       78888.60 (  -2.06%)
unixbench-execl         Hmean     unixbench-execl-1             4151.70 (   0.00%)        3913.76 *  -5.73%*	*
unixbench-execl         Hmean     unixbench-execl-1             4304.30 (   0.00%)        4303.20 (  -0.02%)	[Verification run]
unixbench-execl         Hmean     unixbench-execl-512          13605.15 (   0.00%)       13129.23 (  -3.50%)

o NPS4

Test			Metric	  Parallelism			tip		      sis_core
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-1      48506771.20 (   0.00%)    48894866.70 (   0.80%)
unixbench-dhry2reg      Hmean     unixbench-dhry2reg-512  6280954362.50 (   0.00%)  6282759876.40 (   0.03%)
unixbench-syscall       Amean     unixbench-syscall-1        2687259.30 (   0.00%)     2695379.93 *  -0.30%*
unixbench-syscall       Amean     unixbench-syscall-512      7350275.67 (   0.00%)     7366923.73 (  -0.23%)
unixbench-pipe          Hmean     unixbench-pipe-1           2478893.01 (   0.00%)     2540015.88 *   2.47%*
unixbench-pipe          Hmean     unixbench-pipe-512       301830155.61 (   0.00%)   304305539.27 *   0.82%*
unixbench-spawn         Hmean     unixbench-spawn-1             5208.55 (   0.00%)        5273.11 (   1.24%)
unixbench-spawn         Hmean     unixbench-spawn-512          80745.79 (   0.00%)       81940.71 *   1.48%*
unixbench-execl         Hmean     unixbench-execl-1             4072.72 (   0.00%)        4126.13 *   1.31%*
unixbench-execl         Hmean     unixbench-execl-512          13746.56 (   0.00%)       12848.77 (  -6.53%)	*
unixbench-execl         Hmean     unixbench-execl-512          13898.30 (   0.00%)       13959.70 (   0.44%)	[Verification Run]

On 10/19/2022 5:58 PM, Abel Wu wrote:
> This patchset tries to improve SIS scan efficiency by recording idle
> cpus in a cpumask for each LLC which will be used as a target cpuset
> in the domain scan. The cpus are recorded at CORE granule to avoid
> tasks being stack on same core.
> 
> v5 -> v6:
>  - Rename SIS_FILTER to SIS_CORE as it can only be activated when
>    SMT is enabled and better describes the behavior of CORE granule
>    update & load delivery.
>  - Removed the part of limited scan for idle cores since it might be
>    better to open another thread to discuss the strategies such as
>    limited or scaled depth. But keep the part of full scan for idle
>    cores when LLC is overloaded because SIS_CORE can greatly reduce
>    the overhead of full scan in such case.
>  - Removed the state of sd_is_busy which indicates an LLC is fully
>    busy and we can safely skip the SIS domain scan. I would prefer
>    leave this to SIS_UTIL.
>  - The filter generation mechanism is replaced by in-place updates
>    during domain scan to better deal with partial scan failures.
>  - Collect Reviewed-bys from Tim Chen
> 
> v4 -> v5:
>  - Add limited scan for idle cores when overloaded, suggested by Mel
>  - Split out several patches since they are irrelevant to this scope
>  - Add quick check on ttwu_pending before core update
>  - Wrap the filter into SIS_FILTER feature, suggested by Chen Yu
>  - Move the main filter logic to the idle path, because the newidle
>    balance can bail out early if rq->avg_idle is small enough and
>    lose chances to update the filter.
> 
> v3 -> v4:
>  - Update filter in load_balance rather than in the tick
>  - Now the filter contains unoccupied cpus rather than overloaded ones
>  - Added mechanisms to deal with the false positive cases
> 
> v2 -> v3:
>  - Removed sched-idle balance feature and focus on SIS
>  - Take non-CFS tasks into consideration
>  - Several fixes/improvement suggested by Josh Don
> 
> v1 -> v2:
>  - Several optimizations on sched-idle balancing
>  - Ignore asym topos in can_migrate_task
>  - Add more benchmarks including SIS efficiency
>  - Re-organize patch as suggested by Mel Gorman
> 
> Abel Wu (4):
>   sched/fair: Skip core update if task pending
>   sched/fair: Ignore SIS_UTIL when has_idle_core
>   sched/fair: Introduce SIS_CORE
>   sched/fair: Deal with SIS scan failures
> 
>  include/linux/sched/topology.h |  15 ++++
>  kernel/sched/fair.c            | 122 +++++++++++++++++++++++++++++----
>  kernel/sched/features.h        |   7 ++
>  kernel/sched/sched.h           |   3 +
>  kernel/sched/topology.c        |   8 ++-
>  5 files changed, 141 insertions(+), 14 deletions(-)
> 

Testing with couple of larger workloads like SpecJBB are still underway.
I'll update the thread with the results once they are done. The idea
is promising. I'll also try to run schbench / hackbench pinned in a
manner such that all wakeups happen on an external LLC to spot any
impact of rapid changes to the idle cpu mask of an external LLC.
Please let me know if you would like me to test or get data for any
particular benchmark from my test setup.

--
Thanks and Regards,
Prateek
