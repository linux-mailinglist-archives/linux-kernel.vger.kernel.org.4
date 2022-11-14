Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341196275A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 06:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiKNFq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 00:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbiKNFpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 00:45:49 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F172F18379
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 21:45:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9F14H6mrQ3TzJNP/xz2nq0kHi3og51H68JZ6kdhmBKZ9SM9ruMCVKHRqSEt8opw9MzsJoo9SJjQx44JsOJo3jCYbwRWojeFet0NGe/lFiY1xUzPisq3qovKAxC9sKeTClWneiQDFsXUoDlBVKjmOQQskro0RYrCnpGe594kNgKjNIzseENtBYbX8YGXst6igZErtUcXsgeQLV28TN8w6N4di7SIBP53rX6vc57zBBD8byf480GjZ0MsyR9nXAcstiusaX7gL57WO0a7u5/yuNd603sPeqLtruRnb3mQhpOqFBTjaA+7rNSJOCTzXE0OKVxI1mMwy0aNfW5u/zAk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geWpLn7lBIWSvuXZFskCwpQalKqwP3w2WnxBeB2dyzc=;
 b=NXI6Oa1J05Cc1X5tK3LkM3MTstw1xYFmy2jmBEw2uqNq3+yWrVxIC1gPjjxMj+eabuPAwLEqIkgKrJg/6QHFegBfjfS4eL2Lmi2mhLHSGE1BRlciklsZi9HiYuhVvnO00sE98o60cos1is11m0dHjxuFaYl/l3twpFc8xadMwYeQT4RJazG4jUIwDW8gHLUIipON66XsgS+CycYMdK/dWQ79ZGb3zYgiJC5L19Q756fPcX2n3gCZ2b9rEMsZMAYBjCy/EFBJCiqmrF59eRRS0JGmkRaC9XA0vzXqPRZpJ5uCyrkiO1hlW5Msi1T++Jy0dNqRgH8RCnu8W0SGRnnE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geWpLn7lBIWSvuXZFskCwpQalKqwP3w2WnxBeB2dyzc=;
 b=uJuMOvKXxqxx6OwJBUqhuTxsnJ6bcNbXglUPuPEu6kRoy05QxnEhSF/3QIE5SOpC7WL9A3x+M5aG3Ymzn7hlzV2Hna87n2vtvT2LcZrP0xCx7vADANOboRn7oBMogH3ho+bqUDYrnwjsAvg3gvic+ouMKAt6Yn7XDPXirxdDHGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 05:45:28 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 05:45:28 +0000
Message-ID: <c7c5a654-8d26-28d9-7b33-e7b2b7bf2401@amd.com>
Date:   Mon, 14 Nov 2022 11:15:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
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
X-ClientProxiedBy: PN2PR01CA0221.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::17) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH8PR12MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: b9207de1-ff28-4470-3c7a-08dac6036f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwlD3odjQTFUqcjUDBslyrv3/xhRxB2PdtT1d5yiuPJKRr62SU4nCXz5euduvR5aWhPvvi6I08CemLQ6EugY/XNpcrk1Upm9SnrgrWml+AvCV9vt2wHGqFQy+yrLtChu+pko4sfrLIl5x7RGwh1lEeg+NhUVoJTl2b5hgkVANeQS0taYsahal3m6roxW5yZVoFvPm4aPjKfRxk0dwm2DwUIR+YfnW5Qg/yXtXiLU3fIPYU6zGcRfv8u/ds3kua94nAt6zhhpBuL8eMPwTh3A5mWU8+xPfrukyK9n9PBZMWVSwhdkFXDnuda2miQfEkNHBCafJH9wZmtDiSFe9BorMuwFHn0dhm2ttrfsirvkuO/v98cXWcFVBbENSO+4EijfbLmhZXUcyGm3RTzOpjJ4UOonj8JeXpzeB9D7yRU9W1Z5B603SDjM3p8EKpwAYriDp+Ddnzm5Q7EoX3xlmr9PusNFwq3ELHxsNUxD57kaKTszED8kgqsTDWv06b7wdAg6/u6A/6/bzFOUQGCVjlhaf6fS5noFyAGwlqCQyjV9XPMqeTmLbwuw5MPBc9lhxUcLrDojmKo/dKJePLPLjEBnU1KE3O1p1U99W1dlIEwzJv/1kQVK/tEj9A6g2L25oRqNZamTPLwR/8ugaEjCEq1zrX2ZmF2+xim79etse4QDSTeSy4huf74xNQUENQW3KhTqkiDc0XlED5QtLIrCue7SOELrRSRmaKKfTExiE/qYqM4QvpqRzjqhOnynZMis3GggcpnMBCoa1BdYa2FDyVnf75WrS4uPJ7i4iYioCNhbXka7VRwdp1YlHwwTZFAwLlNktapsgAB2e2OS6hCgGgIOhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(83380400001)(86362001)(31696002)(38100700002)(2906002)(30864003)(7416002)(316002)(41300700001)(4326008)(8676002)(5660300002)(8936002)(53546011)(6506007)(26005)(6512007)(6666004)(186003)(478600001)(54906003)(2616005)(110136005)(66476007)(66556008)(966005)(66946007)(6486002)(36756003)(31686004)(66899015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2w2c2tzczFYN1ZIMXk1RzlSaHVtVVNTeVRFcVFjTFY2clkyY0puUDk3M3pi?=
 =?utf-8?B?NDMyLzdhb0c2a2FkZEVoRlhnb2JmNnp2UE05SEJRdjNMVUdkeVZRdUl4SHlM?=
 =?utf-8?B?RStTWG5ZTWo5cUtYK3kxZXlVeEQ1eUhLTC9rV3pDVDlMdlJPanh1dVJjREhn?=
 =?utf-8?B?a2JuVnMwaWVCdlJQMEtGUWtVU0VwQ1cvb0IzT3RnMEcxK0FFQ1R2TU1pbWtv?=
 =?utf-8?B?RDBRL1B3U1lMMEtLYzE3ejE3NWZ4d2ErT1RDenB5Z2gzNzNUeXVQVjQ3SVFK?=
 =?utf-8?B?T205WnAwU0g3SFBCaEJBcGFmMWVibEVrM1FlSDZVbFhhNUs2SFRTWGszSDFm?=
 =?utf-8?B?Mmlha0NhekRkWi9nck5DM3FQOWRUZGMzUDVrWEJiYTBmSGJ2dnh5Q3gyYkZF?=
 =?utf-8?B?aElwZEZBeEcrTFh4dDJhSjJXSDVGZDU4VTJzblBpZngvc3lsbWsrSHUrdUhR?=
 =?utf-8?B?U2M2WW5HM2RZeFBzYjRYWmMrTzJZZGcrYVpQN1pBUjkxYmc4Z2ZtQzVycUsv?=
 =?utf-8?B?eEFMa2F6T3dkUno2Qnc4MHNwVy9KeHdvZUV3dHBlTTQyZkxnUUZFTEhiWmJi?=
 =?utf-8?B?RUZNb2NrdlJJd2xPZUVWV2k1TTljUytCMXdFdjNvWENad3h1NkU4TmJtMGov?=
 =?utf-8?B?K2s3ZUNDM256UFNnL1l5Tlp0MTlPTXNrOGZHa0pBYTdOV1N6MFp1YjNnWVR2?=
 =?utf-8?B?WC8yUDdPcG9CaHg1TVVzSlM0dERMemwxamhBWHdmTXJ0Z0VNeVZpT1piQldh?=
 =?utf-8?B?SmEzajN4MkZCKzFTc21NcnQ4YkdwVjVVUTUrcG52V2hlZm15TlhFSmNxTFBs?=
 =?utf-8?B?UU9PSFVNMnI0SzNIaHJDQ0pBdEx1QlZESUhhSnRrbnVjUU1aS3l5c3M4NWRa?=
 =?utf-8?B?RDRPR1lNaG90MkJWcEhqR21CbE1pVElCRmhtSlYvU1FMNGNoa0ZJeVc4NUhL?=
 =?utf-8?B?SlJoRVM3cmFOR1JQbTY2WHIrYURuRVRkenNGVnRHd0RpZTNUOUhubSt4dG9G?=
 =?utf-8?B?eDJ6ZWVjSWt5dEVVYWhsR1B6Z3NyRlUzeFNlQUxtZU56dWp2N2hmRkdNL2FN?=
 =?utf-8?B?bkpTczgrcFhOVkpXSGRYZTl3NzI2RE5mVHorL25vZXhMeloyUjFHZFUxSTNZ?=
 =?utf-8?B?ckNaazZIUlJkellBczY2dDQvNmxpSjBRYmlaR01KVjhJWDdVdnpVMFlzY2l4?=
 =?utf-8?B?ZEVibmhTNFluWEZoUE5ueVFjR004QWNFWmRyMlprTFFuU1VJRnVucmw0RTAz?=
 =?utf-8?B?MmcxUG45R25wNWh6WWdDbzhEY2c3TDN2LzFNNDkxWlc1bUVZQjRKQTJPT1hH?=
 =?utf-8?B?MDNYbEhpUWRXSnZaVlZwNUdqSkxCdzZReHNBMHV3a1ZLTGl4TXlTd1FuRXph?=
 =?utf-8?B?MGd6OGdkaGt1SEd0ZjVxRE0rR0VkUUxScHA0ZlBHZmNmSkpqK1dsRnc0VzdS?=
 =?utf-8?B?bjJMTkhyLzdCS1JaUkpWVzdzTnk1YzBTQ25keDFHQzUxRWkvc1Nud0NYRXB5?=
 =?utf-8?B?eFVNUXQzNU9iUlNmQWFsd1dUOU1HTWhhbzVxV0Uwc3hFNE5iZWxFbnFFUnlD?=
 =?utf-8?B?R3NPcWVuSDlmUXBFU2N3ZmVYeE8zTUlJZjZnU0hNa29NVi9jVDI0Q0w2aVJK?=
 =?utf-8?B?VytHNVBPQVU3aXVocXZ0Ulhic0VJbTNiQUZkcEd5R3lJWitDcHBaalRtQ2dn?=
 =?utf-8?B?QXNXQzJwdGh2NjQ2aTBMRmc1UHhPcjVleXBFN25HSDZyTml4VWdqYklObVhD?=
 =?utf-8?B?ZU1zT2hiRldvZG12SnBFNzl0cW9GTUFKNkl4eHhqQ24yMGpndG5FbmZ0T3pa?=
 =?utf-8?B?dG9EMXk0UnA5dU93WTdjdHdxWnl1MDc5UzdMSWZaSTFvM0ZGdnFmTVBidm5R?=
 =?utf-8?B?bFNQUVlzbkQzTGF0dENYckVjTndzS2I3OWxucWF2N2p5RTFKMi9kU2dZN0hj?=
 =?utf-8?B?OTREQWI2V3VVaHUwb0w4aHZUUDc4UkFRU0d0WFl1QjExVW1pZWhUKzFvdDM5?=
 =?utf-8?B?VWQ4dUQ5dUJDMm55T254ZHo2SDMrR21ZUXE5WnplVkxNdk5hMW9kZy95cHJ1?=
 =?utf-8?B?cUI3Y2VtdFFKM3htaFZmMGo2RndIVDBuRnFYTUIwTWRCZTNkM2VBQ2ZsL2VV?=
 =?utf-8?Q?17Og07tIav6UR0j7QEOYkR90N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9207de1-ff28-4470-3c7a-08dac6036f05
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 05:45:28.0380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OkD8Ra3i/0PBkWXw3Wh29meuVM6SmY+ntD/MWXBDDi/akjVJPHfqCG+A9UoVJqCCEdT6J4Cyo/NFhULfTbMGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6939
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Abel,

Sorry for the delay. I've tested the patch on a dual socket Zen3 system
(2 x 64C/128T)

tl;dr

o I do not notice any regressions with the standard benchmarks.
o schbench sees a nice improvement to the tail latency when the number
  of worker are equal to the number of cores in the system in NPS1 and
  NPS2 mode. (Marked with "^")
o Few data points show improvements in tbench in NPS1 and NPS2 mode.
  (Marked with "^")

I'm still in the process of running larger workloads. If there is any
specific workload you would like me to run on the test system, please
do let me know. Below is the detailed report:

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

Benchmark Results:

Kernel versions:
- tip:          5.19.0 tip sched/core
- sis_core: 	5.19.0 tip sched/core + this series

When we started testing, the tip was at:
commit fdf756f71271 ("sched: Fix more TASK_state comparisons")

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

o NPS1

Test:			tip			sis_core
 1-groups:	   4.06 (0.00 pct)	   4.26 (-4.92 pct)	*
 1-groups:	   4.14 (0.00 pct)	   4.09 (1.20 pct)	[Verification Run]
 2-groups:	   4.76 (0.00 pct)	   4.71 (1.05 pct)
 4-groups:	   5.22 (0.00 pct)	   5.11 (2.10 pct)
 8-groups:	   5.35 (0.00 pct)	   5.31 (0.74 pct)
16-groups:	   7.21 (0.00 pct)	   6.80 (5.68 pct)

o NPS2

Test:			tip			sis_core
 1-groups:	   4.09 (0.00 pct)	   4.08 (0.24 pct)
 2-groups:	   4.70 (0.00 pct)	   4.69 (0.21 pct)
 4-groups:	   5.05 (0.00 pct)	   4.92 (2.57 pct)
 8-groups:	   5.35 (0.00 pct)	   5.26 (1.68 pct)
16-groups:	   6.37 (0.00 pct)	   6.34 (0.47 pct)

o NPS4

Test:			tip			sis_core
 1-groups:	   4.07 (0.00 pct)	   3.99 (1.96 pct)
 2-groups:	   4.65 (0.00 pct)	   4.59 (1.29 pct)
 4-groups:	   5.13 (0.00 pct)	   5.00 (2.53 pct)
 8-groups:	   5.47 (0.00 pct)	   5.43 (0.73 pct)
16-groups:	   6.82 (0.00 pct)	   6.56 (3.81 pct)

~~~~~~~~~~~~
~ schbench ~
~~~~~~~~~~~~

o NPS1

#workers:	tip			sis_core
  1:	  33.00 (0.00 pct)	  33.00 (0.00 pct)
  2:	  35.00 (0.00 pct)	  35.00 (0.00 pct)
  4:	  39.00 (0.00 pct)	  38.00 (2.56 pct)
  8:	  49.00 (0.00 pct)	  48.00 (2.04 pct)
 16:	  63.00 (0.00 pct)	  66.00 (-4.76 pct)
 32:	 109.00 (0.00 pct)	 107.00 (1.83 pct)
 64:	 208.00 (0.00 pct)	 216.00 (-3.84 pct)
128:	 559.00 (0.00 pct)	 469.00 (16.10 pct)     ^
256:	 45888.00 (0.00 pct)	 47552.00 (-3.62 pct)
512:	 80000.00 (0.00 pct)	 79744.00 (0.32 pct)

o NPS2

#workers:	=tip			sis_core
  1:	  30.00 (0.00 pct)	  32.00 (-6.66 pct)
  2:	  37.00 (0.00 pct)	  34.00 (8.10 pct)
  4:	  39.00 (0.00 pct)	  36.00 (7.69 pct)
  8:	  51.00 (0.00 pct)	  49.00 (3.92 pct)
 16:	  67.00 (0.00 pct)	  66.00 (1.49 pct)
 32:	 117.00 (0.00 pct)	 109.00 (6.83 pct)
 64:	 216.00 (0.00 pct)	 213.00 (1.38 pct)
128:	 529.00 (0.00 pct)	 465.00 (12.09 pct)     ^
256:	 47040.00 (0.00 pct)	 46528.00 (1.08 pct)
512:	 84864.00 (0.00 pct)	 83584.00 (1.50 pct)

o NPS4

#workers:	tip			sis_core
  1:	  23.00 (0.00 pct)	  28.00 (-21.73 pct)
  2:	  28.00 (0.00 pct)	  36.00 (-28.57 pct)
  4:	  41.00 (0.00 pct)	  43.00 (-4.87 pct)
  8:	  60.00 (0.00 pct)	  48.00 (20.00 pct)
 16:	  71.00 (0.00 pct)	  69.00 (2.81 pct)
 32:	 117.00 (0.00 pct)	 115.00 (1.70 pct)
 64:	 227.00 (0.00 pct)	 228.00 (-0.44 pct)
128:	 545.00 (0.00 pct)	 545.00 (0.00 pct)
256:	 45632.00 (0.00 pct)	 47680.00 (-4.48 pct)
512:	 81024.00 (0.00 pct)	 76416.00 (5.68 pct)

Note: For lower worker count, schbench can show run to
run variation depending on external factors. Regression
for lower worker count can be ignored. The results are
included to spot any large blow up in the tail latency
for larger worker count.

~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

o NPS1

Clients:	tip			sis_core
    1	 578.37 (0.00 pct)	 582.09 (0.64 pct)
    2	 1062.09 (0.00 pct)	 1063.95 (0.17 pct)
    4	 1800.62 (0.00 pct)	 1879.18 (4.36 pct)
    8	 3211.02 (0.00 pct)	 3220.44 (0.29 pct)
   16	 4848.92 (0.00 pct)	 4890.08 (0.84 pct)
   32	 9091.36 (0.00 pct)	 9721.13 (6.92 pct)     ^
   64	 15454.01 (0.00 pct)	 15124.42 (-2.13 pct)
  128	 3511.33 (0.00 pct)	 14314.79 (307.67 pct)
  128    19910.99 (0.00pct)      19935.61 (0.12 pct)   [Verification Run]
  256	 50019.32 (0.00 pct)	 50708.24 (1.37 pct)
  512	 44317.68 (0.00 pct)	 44787.48 (1.06 pct)
 1024	 41200.85 (0.00 pct)	 42079.29 (2.13 pct)

o NPS2

Clients:	tip			sis_core
    1	 576.05 (0.00 pct)	 579.18 (0.54 pct)
    2	 1037.68 (0.00 pct)	 1070.49 (3.16 pct)
    4	 1818.13 (0.00 pct)	 1860.22 (2.31 pct)
    8	 3004.16 (0.00 pct)	 3087.09 (2.76 pct)
   16	 4520.11 (0.00 pct)	 4789.53 (5.96 pct)
   32	 8624.23 (0.00 pct)	 9439.50 (9.45 pct)     ^
   64	 14886.75 (0.00 pct)	 15004.96 (0.79 pct)
  128	 20602.00 (0.00 pct)	 17730.31 (-13.93 pct) *
  128    20602.00 (0.00 pct)     19585.20 (-4.93 pct)   [Verification Run]
  256	 45566.83 (0.00 pct)	 47922.70 (5.17 pct)
  512	 42717.49 (0.00 pct)	 43809.68 (2.55 pct)
 1024	 40936.61 (0.00 pct)	 40787.71 (-0.36 pct)

o NPS4

Clients:	tip			sis_core
    1	 576.36 (0.00 pct)	 580.83 (0.77 pct)
    2	 1044.26 (0.00 pct)	 1066.50 (2.12 pct)
    4	 1839.77 (0.00 pct)	 1867.56 (1.51 pct)
    8	 3043.53 (0.00 pct)	 3115.17 (2.35 pct)
   16	 5207.54 (0.00 pct)	 4847.53 (-6.91 pct)	*
   16	 4722.56 (0.00 pct)	 4811.29 (1.87 pct)	[Verification Run]
   32	 9263.86 (0.00 pct)	 9478.68 (2.31 pct)
   64	 14959.66 (0.00 pct)	 15267.39 (2.05 pct)
  128	 20698.65 (0.00 pct)	 20432.19 (-1.28 pct)
  256	 46666.21 (0.00 pct)	 46664.81 (0.00 pct)
  512	 41532.80 (0.00 pct)	 44241.12 (6.52 pct)
 1024	 39459.49 (0.00 pct)	 41043.22 (4.01 pct)

Note: On the tested kernel, with 128 clients, tbench can
run into a bottleneck during C2 exit. More details can be
found at:
https://lore.kernel.org/lkml/20220921063638.2489-1-kprateek.nayak@amd.com/
This issue has been fixed in v6.0 but was not part of the
tip kernel when I started testing. This data point has
been rerun with C2 disabled to get representative results.

~~~~~~~~~~
~ Stream ~
~~~~~~~~~~

o NPS1

-> 10 Runs:

Test:		tip			sis_core
 Copy:	 328419.14 (0.00 pct)	 337857.83 (2.87 pct)
Scale:	 206071.21 (0.00 pct)	 212133.82 (2.94 pct)
  Add:	 235271.48 (0.00 pct)	 243811.97 (3.63 pct)
Triad:	 253175.80 (0.00 pct)	 252333.43 (-0.33 pct)

-> 100 Runs:

Test:		tip			sis_core
 Copy:	 328209.61 (0.00 pct)	 339817.27 (3.53 pct)
Scale:	 216310.13 (0.00 pct)	 218635.16 (1.07 pct)
  Add:	 244417.83 (0.00 pct)	 245641.47 (0.50 pct)
Triad:	 237508.83 (0.00 pct)	 255387.28 (7.52 pct)

o NPS2

-> 10 Runs:

Test:		tip			sis_core
 Copy:	 336503.88 (0.00 pct)	 339684.21 (0.94 pct)
Scale:	 218035.23 (0.00 pct)	 217601.11 (-0.19 pct)
  Add:	 257677.42 (0.00 pct)	 258608.34 (0.36 pct)
Triad:	 268872.37 (0.00 pct)	 272548.09 (1.36 pct)

-> 100 Runs:

Test:		tip			sis_core
 Copy:	 332304.34 (0.00 pct)	 341565.75 (2.78 pct)
Scale:	 223421.60 (0.00 pct)	 224267.40 (0.37 pct)
  Add:	 252363.56 (0.00 pct)	 254926.98 (1.01 pct)
Triad:	 266687.56 (0.00 pct)	 270782.81 (1.53 pct)

o NPS4

-> 10 Runs:

Test:		tip			sis_core
 Copy:	 353515.62 (0.00 pct)	 342060.85 (-3.24 pct)
Scale:	 228854.37 (0.00 pct)	 218262.41 (-4.62 pct)
  Add:	 254942.12 (0.00 pct)	 241975.90 (-5.08 pct)
Triad:	 270521.87 (0.00 pct)	 257686.71 (-4.74 pct)

-> 100 Runs:

Test:		tip			sis_core
 Copy:	 374520.81 (0.00 pct)	 369353.13 (-1.37 pct)
Scale:	 246280.23 (0.00 pct)	 253881.69 (3.08 pct)
  Add:	 262772.72 (0.00 pct)	 266484.58 (1.41 pct)
Triad:	 283740.92 (0.00 pct)	 279981.18 (-1.32 pct)

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

I ran pgbench from mmtest but realised there is too much run to run
variation on the system. Planning on running MongoDB benchmark which
is more stable on the system and couple more workloads but the
initial results look good. I'll get back with results later this week
or by early next week. Meanwhile, if you need data for any specific
workload on the test system, please do let me know. 

--
Thanks and Regards,
Prateek
