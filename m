Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A7B747DD2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjGEHFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGEHFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:05:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4CA1712
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:05:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpuMnv/jpPcLODTKgUIRq6bgrNqIlKCevCvOMn76s8JuWRRs2bhfYPZllp6EhwyOjb0RKGgNvyWlSlGw5exn+0OkNJKJqbBnUpCZDqhPQJNv6uCYEP3u3CX5sT/zJFi6DYxIUKsN4B3PLmq1Og2zEQVaxTnQNeQ5FW7y3w2keBLTqZbSGwYXm9Ygag89F7LTBDDhIaZq41HUkGc7DOzUR7WjA5jTqhCNWmh75F36FNzjMNX2wWZnNcJ5l2xCOtfH5b9RdIYt7OnVdRLV3XJGaC8eFzLLn1MwCYd+ZJXWMzScwwumtR61J5RM23ussbbepn7gHs0wZNUbE7AiDVhHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQtzU5X+wC4mtspv1eJpuVS1S5BfsCFcYPNWGGFwIwQ=;
 b=By5PJuZuzQvgQlL+yNnDmc8P/C17tGokhvc1jpnJRk+oZHdnUV6EIID7oFFaj518D8f4nK/q9Nvi8OYfyEzIH8F64lQuZlmkQUgSJ5duZ62xrzSiqvoCSynDIm5keGuouCc5ksmZOJBwU9+ydyepGChUZaRUeYIIih7KSB+rQL7diLijJ1RgHX11tiQXVTemn9BKmpDMEvD8ZZ7YYDWfh/eu9Z0h+0WQ0L+qy3BYyy4u0uGAq7CMesih5W7GWNW12qZngn5kUM77Ub0B78fZPoKRB0ILPb3+Mdep8svJtuQ5BA2z8vzJwk5aKIkM3UxZIZhsrRmDXjphrGO/AWc1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQtzU5X+wC4mtspv1eJpuVS1S5BfsCFcYPNWGGFwIwQ=;
 b=LXhhusLt36g7Hm2p/UdVODyIMAwDYZFabPJYRaaflzWE0npNqu27IHtcS7HqFUjT3+lhUoRcR3PWRJhZ/+38pBDnbcVIv/+bjSXRupDNlj7oWyxmK+sbMgZFEP9Q0SmOosiLeGuA9YA5gJzEISLMBUQyqn2rZzmrTsmUe/gYvpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 07:05:02 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c%2]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 07:05:02 +0000
Message-ID: <d686347e-f76c-7f9c-3f1a-f4326f5167ca@amd.com>
Date:   Wed, 5 Jul 2023 12:34:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Sandeep Dhavale <dhavale@google.com>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, kernel-team@android.com
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-15-tj@kernel.org>
 <CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com>
 <c307ba94-0d8c-3cbf-19da-44ee31751428@amd.com>
 <ZIEBB-A1arYKSK2P@slm.duckdns.org>
 <fb3461cd-3fc2-189a-a86b-c638816a2440@amd.com>
 <ZIJbMQOu_k07jkFf@slm.duckdns.org>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZIJbMQOu_k07jkFf@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CH3PR12MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 367111c6-5756-4f88-925f-08db7d26272d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifJlkoJ7DVY2NNoyCLAoMLNdYSvkr64aWzfpmAojYtLwUpCsySBcE5/qvOqMuNigTMMEnvXmYHJjQfWI/GOjkeweBVuHPJtAEYyQVoc2pERAdYXbc4WHN9OdnaRyEA4XJagtj19u1JaLAbhspXju17YFKicOmjuOFwXveNqG7R1l0UCALeRkuyTRqJgdXgve2s+nY3xAKYkFYUJL/gceAnUOQIPIEg2CNIJSeNcptd3dkii8oJAo3hcnPr03dCh42uqZRYWv6vyF9Ee1/wYVjQ2GthM80Udq50f8pObB6ZEptzgk9I2ciAcs8N/pUTswvwwLHi3G9Yz7ynuqBZGT+H1PnkQTZDmlLC7FA0rsGVGxRWBKVMq1I4YNmpkMrbxq5L1YTDz/zpbtmKKNwtsGZ88Dm6jdnrEUTUZ3Y+thutgL6YRiy+X7e1je3OuI+gKkkvjtfC/4U0lTI35LKcz/q9of5vqCf6PhtdcVgisp/D5yLOMldxJn+KlFB7PBdmKwcjop4vY3Ji9Oo1I5Yo8WFisMfQowiTRFZu1NyZmdIj2QQisg79Yw4etu5vmypE0kz/Tk5D/YJv7H0aryDDbl/MMsdGGody8WfDGAuA4SP6lTMgYm6dcj3PQwLqCEkHEhpwTIKs/3Mzyp31ukOmLS9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(31686004)(6512007)(6486002)(6666004)(478600001)(83380400001)(2616005)(86362001)(36756003)(31696002)(2906002)(53546011)(6506007)(30864003)(26005)(186003)(4326008)(38100700002)(66946007)(316002)(66476007)(66556008)(8936002)(6916009)(41300700001)(5660300002)(7416002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEFIRWxQckVvdFVRbkYvektUbGFOQU91Mmx6WUJCZEVSSEdvcTB5WWFYM3pE?=
 =?utf-8?B?ZnVaYkZseFNZYTMyaGEyUE8rM0ZEWGFTM3FqUHVvZ28wSDAzNUVzcVRmMEYz?=
 =?utf-8?B?aVdKTXZmc3F2a2ROL2hvTWxJSlFTMVlKQnJtY0laY2lJN3BCNmp4WDdRUVV5?=
 =?utf-8?B?SGZIS0hTdGJkMzlLL3l3N1p4R0lzUXM1UHNSaWZLWGVmUUpMRDhwZjZnNlFK?=
 =?utf-8?B?YzhPalEzVVlaL25WME9IbUlBcVdOYVhaeS83aXFVaEo4YWJ0OTRsb29HTHFG?=
 =?utf-8?B?eWtUYUM2UU1XNk8wNDVGUkFxM1lmRkd2VEhyZExLc2RveWlyay8vdVEyYUJW?=
 =?utf-8?B?OFhaMnhtYzBEend5M1c3Z1BzanhrRjFYQWxMTmJKY3lKd1NFWEsyQUxaZU1X?=
 =?utf-8?B?NUgxRStjODV3dmhVMTN3d3hvak9PNWxEVnRDTW8xbmVUNzN5aVgwUzhPR1Bq?=
 =?utf-8?B?RzBWRTlIRVQ1V2ZzQ1hIS1JPQlUzK2xuZzJ6Y3c2VTNQcDEzWUk3Mm90Rkpa?=
 =?utf-8?B?UWcrT0QwdWxqeHZqWnhmYTd3Tmh5bVpDNWkrUTJnQXJnT2hlSW1xYzJMd21L?=
 =?utf-8?B?OFJUU3lRQmdtTUVNVVNnR3hFMkw1VWtBWktDcExPZm1SQjFISkkzVE8zYTNv?=
 =?utf-8?B?WXJxNUp3NWpPTHN3WHBLN3p0S3dRMnk2djBtV0ZHN0kzdGNYQ3EvelQvK3FS?=
 =?utf-8?B?TndpSlVFdjdzcUFxQ3VvQ3NtOHpQUklQbW5UcUlYUHV2T2xMYk5PSDJJdWE0?=
 =?utf-8?B?bDcyUkd5N2hDV0E4cHd3Tms1aXcvOVR5cUFobW1KUm54NUdGWWpwdVFEdk1o?=
 =?utf-8?B?SHJycTlDQitsWUQvV2ROcklGa2Z3WjVRK2Q3bDhLd3NGRFRrbzRtU1prTzQ2?=
 =?utf-8?B?TkxqeDVVTkpxdXIxeW9VaXl0bk9RYTQ2SXVkdllWNThMRFdoMC9RNExXcTkw?=
 =?utf-8?B?bzcrNDVEOXVtRTh2R2F2Zk1pTllpaTVlaDRZbDEwR2xvMjFwbkJtRm9SZHlm?=
 =?utf-8?B?RHNjWEFUVFRIb0tFRWpkTnlkUjhJTUg0SmtpMHA3ODFNL3dpZS9TOXVPT3BC?=
 =?utf-8?B?QXJrK3A2UTNGbGZhWEYxd01nbi85TDJOUVFJRy9ET3JCN3F2Vyt6NmVqc3hm?=
 =?utf-8?B?MExFbm1ydi9xZ0dONkExSHVrZlNKc1VURnVsa3Vydm9QWFVFeCtTZ2NSQkR1?=
 =?utf-8?B?RjErMFpsQVVxOXo5c2ZRVG4rUHNFbjk0cDVPUENmMk0xSXcrTVdJWGNIaE9D?=
 =?utf-8?B?VHpVRWl6WjI3K1VkVGcya1J4TGp4VWxaQTU0YXhWaWdoYjBESUxwZk5YdGVV?=
 =?utf-8?B?UWJpeVpacG41M1Bzd05NQThmWHhlL01GaUpkaWZaWTVZUkdSYWZFVFJRN2tD?=
 =?utf-8?B?QUVyTG5vV2FEdkxXU1Juc2xvVWVuWlVVNjdKejU1MDFUMnZmY2s5ODdsYkov?=
 =?utf-8?B?WU42WXJJajlhWEp4SkNpS2t0SjR4bE5GWlM3UTI4NHdSQUVqRFNnc1VBbHZJ?=
 =?utf-8?B?RDFKN3crYnE5MXpYK0pMZnl3M2Z3aU1ESWMyK2txWi92d0p0U3dhOGlhSWd5?=
 =?utf-8?B?MU9EOFZNcWlPbHBZL2F2UlZ1THFXTXZ5bWU0Q1g1bnJrajFuby9TMDJOWC9Q?=
 =?utf-8?B?YVJUeWU5Y0dmQ2tDc1lLc2JSLzA0S1FidkFLS2d2QldjN3Y4MDgxT01NeFNp?=
 =?utf-8?B?cHlqamFaeDFRRjhsa0YwVWtESmh5M1hDZXYvb2lQd3pEWmRlWHlBQmlvb3Uw?=
 =?utf-8?B?RVZPeEpReGNqVTVmUnNFWW9MaXRaby9oUHUvQjh3NFF6QmcyaHZ5eHUzc3Zx?=
 =?utf-8?B?dkQyWlk3ZC9TNENZOU85aDQvakZqSklFSEJ6S1U1aURaNGpzZUpqYWxvMGtn?=
 =?utf-8?B?SGN3bmxoNjhtM21id2R4Wml0SzluTlQ0NGR4c285cVJzcVk2VzViS1BIME1n?=
 =?utf-8?B?NjJ6SHNvMXJCUUFYSFg5QUlmbTlJWmhPUnVzQ2oxMVl0MHVwelVvc3VXZHM1?=
 =?utf-8?B?UFFMQk1ndzlzRWN0a2tQZXJSWjdpdWxXUi9WQ3hqTVFEdWtBOWNNT29uTXFO?=
 =?utf-8?B?WW5teFYvaFNWRlQzbzZnR3Zsc3lVeUpFQ2UwSTgrTFlidTNMUUZKcGdCVXho?=
 =?utf-8?Q?scIkYCIABwu9JCaff3kudA+Jy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367111c6-5756-4f88-925f-08db7d26272d
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:05:02.5097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4rmQvOL4/omydDpJof90UZ1yxvnE3/KhLImdwfLqPm1gv4anmImoZtwdPVBldABwH4Fz+w5G7cnsUeBS5Bu+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404
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

Hello Tejun,

On 6/9/2023 4:20 AM, Tejun Heo wrote:
> [..snip..]
> 
> Can you please test the following branch? It should have
> both bugs fixed properly.
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git affinity-scopes-v2
> 
> If that doesn't crash, I'd love to hear how it affects the perf regressions
> reported over that past few months.

Sorry about the delay. I'll leave the detailed results of the testing below,
results are from a dual socket 3rd Generation EPYC system (2 x 64C/128T)

tl;dr

- Apart from tbench and netperf, the rest of the benchmarks show no
  difference out of the box.

- SPECjbb2015 Multi-jVM sees small uplift to max-jOPS with certain
  affinity scopes.

- tbench and netperf seem to be unhappy throughout. None of the affinity
  scopes seem to bring back the performance. I'll dig more into this.

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
- base:             affinity-scopes-v2 branch at
                    commit 18c8ae813156 ("workqueue: Disable per-cpu CPU hog detection when wq_cpu_intensive_thresh_us is 0")

- affinity_scopes:  affinity-scopes-v2 branch at
                    commit a4da9f618d3e ("workqueue: Add "Affinity Scopes and Performance" section to documentation")
                    running with the default affinity scope.

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

o NPS1

Test:			base		   affinity_scopes
 1-groups:	   0.00 (0.00 pct)	   3.68 (0.00 pct)
 2-groups:	   4.41 (0.00 pct)	   4.40 (0.22 pct)
 4-groups:	   4.91 (0.00 pct)	   4.87 (0.81 pct)
 8-groups:	   5.64 (0.00 pct)	   5.74 (-1.77 pct)
16-groups:	   7.72 (0.00 pct)	   7.54 (2.33 pct)

o NPS2

Test:			base		   affinity_scopes
 1-groups:	   3.74 (0.00 pct)	   3.85 (-2.94 pct)
 2-groups:	   4.38 (0.00 pct)	   4.34 (0.91 pct)
 4-groups:	   4.87 (0.00 pct)	   4.80 (1.43 pct)
 8-groups:	   5.42 (0.00 pct)	   5.40 (0.36 pct)
16-groups:	   6.75 (0.00 pct)	   7.02 (-4.00 pct)

o NPS4

Test:			base		   affinity_scopes
 1-groups:	   3.90 (0.00 pct)	   3.84 (1.53 pct)
 2-groups:	   4.40 (0.00 pct)	   4.39 (0.22 pct)
 4-groups:	   4.86 (0.00 pct)	   4.85 (0.20 pct)
 8-groups:	   5.44 (0.00 pct)	   5.44 (0.00 pct)
16-groups:	   7.20 (0.00 pct)	   7.08 (1.66 pct)

~~~~~~~~~~~~
~ schbench ~
~~~~~~~~~~~~

o NPS1

#workers:	base		  affinity_scopes
  1:	  26.00 (0.00 pct)	  26.00 (0.00 pct)
  2:	  26.00 (0.00 pct)	  28.00 (-7.69 pct)
  4:	  31.00 (0.00 pct)	  28.00 (9.67 pct)
  8:	  37.00 (0.00 pct)	  37.00 (0.00 pct)
 16:	  49.00 (0.00 pct)	  47.00 (4.08 pct)
 32:	  78.00 (0.00 pct)	  81.00 (-3.84 pct)
 64:	 170.00 (0.00 pct)	 173.00 (-1.76 pct)
128:	 369.00 (0.00 pct)	 344.00 (6.77 pct)
256:	 49600.00 (0.00 pct)	 48704.00 (1.80 pct)
512:	 93568.00 (0.00 pct)	 93824.00 (-0.27 pct)

o NPS2

#workers:	base		  affinity_scopes
  1:	  24.00 (0.00 pct)	  23.00 (4.16 pct)
  2:	  29.00 (0.00 pct)	  25.00 (13.79 pct)
  4:	  31.00 (0.00 pct)	  32.00 (-3.22 pct)
  8:	  43.00 (0.00 pct)	  39.00 (9.30 pct)
 16:	  52.00 (0.00 pct)	  52.00 (0.00 pct)
 32:	  82.00 (0.00 pct)	  89.00 (-8.53 pct)
 64:	 179.00 (0.00 pct)	 154.00 (13.96 pct)
128:	 400.00 (0.00 pct)	 360.00 (10.00 pct)
256:	 49856.00 (0.00 pct)	 48576.00 (2.56 pct)
512:	 93056.00 (0.00 pct)	 91520.00 (1.65 pct)

o NPS4

#workers:	base		  affinity_scopes
  1:	  25.00 (0.00 pct)	  22.00 (12.00 pct)
  2:	  26.00 (0.00 pct)	  27.00 (-3.84 pct)
  4:	  29.00 (0.00 pct)	  28.00 (3.44 pct)
  8:	  48.00 (0.00 pct)	  44.00 (8.33 pct)
 16:	  55.00 (0.00 pct)	  59.00 (-7.27 pct)
 32:	  88.00 (0.00 pct)	  84.00 (4.54 pct)
 64:	 166.00 (0.00 pct)	 173.00 (-4.21 pct)
128:	 374.00 (0.00 pct)	 368.00 (1.60 pct)
256:	 49600.00 (0.00 pct)	 49856.00 (-0.51 pct)
512:	 93824.00 (0.00 pct)	 93568.00 (0.27 pct)


~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

o NPS1

Clients:	base		  affinity_scopes
    1	 450.40 (0.00 pct)	 456.71 (1.40 pct)
    2	 872.50 (0.00 pct)	 882.38 (1.13 pct)
    4	 1630.13 (0.00 pct)	 1605.48 (-1.51 pct)
    8	 3139.90 (0.00 pct)	 3041.39 (-3.13 pct)
   16	 6113.51 (0.00 pct)	 5449.58 (-10.86 pct)
   32	 11024.64 (0.00 pct)	 9147.71 (-17.02 pct)
   64	 19081.96 (0.00 pct)	 14843.46 (-22.21 pct)
  128	 30956.07 (0.00 pct)	 27493.35 (-11.18 pct)
  256	 42829.46 (0.00 pct)	 36913.54 (-13.81 pct)
  512	 42395.69 (0.00 pct)	 36165.41 (-14.69 pct)
 1024	 41973.51 (0.00 pct)	 38530.57 (-8.20 pct)

o NPS2

Clients:	base		  affinity_scopes
    1	 451.37 (0.00 pct)	 450.97 (-0.08 pct)
    2	 875.07 (0.00 pct)	 874.08 (-0.11 pct)
    4	 1636.31 (0.00 pct)	 1639.60 (0.20 pct)
    8	 3162.48 (0.00 pct)	 3074.73 (-2.77 pct)
   16	 5794.93 (0.00 pct)	 5502.22 (-5.05 pct)
   32	 11205.26 (0.00 pct)	 8979.27 (-19.86 pct)
   64	 20770.79 (0.00 pct)	 17151.10 (-17.42 pct)
  128	 30485.82 (0.00 pct)	 26953.16 (-11.58 pct)
  256	 40161.93 (0.00 pct)	 35892.11 (-10.63 pct)
  512	 44513.43 (0.00 pct)	 38876.31 (-12.66 pct)
 1024	 42781.13 (0.00 pct)	 38313.23 (-10.44 pct)

o NPS4

Clients:	base		  affinity_scopes
    1	 451.25 (0.00 pct)	 447.95 (-0.73 pct)
    2	 877.94 (0.00 pct)	 877.93 (0.00 pct)
    4	 1641.74 (0.00 pct)	 1653.17 (0.69 pct)
    8	 3140.87 (0.00 pct)	 3050.94 (-2.86 pct)
   16	 5878.87 (0.00 pct)	 5291.66 (-9.98 pct)
   32	 10910.11 (0.00 pct)	 9745.45 (-10.67 pct)
   64	 18814.62 (0.00 pct)	 16708.46 (-11.19 pct)
  128	 29238.49 (0.00 pct)	 27598.00 (-5.61 pct)
  256	 42119.54 (0.00 pct)	 38464.91 (-8.67 pct)
  512	 41645.81 (0.00 pct)	 40330.03 (-3.15 pct)
 1024	 41977.06 (0.00 pct)	 39540.55 (-5.80 pct)


~~~~~~~~~~
~ stream ~
~~~~~~~~~~

o NPS1

- 10 Runs:

Test:		base		   affinity_scopes
 Copy:	 245676.59 (0.00 pct)	 333646.71 (35.80 pct)
Scale:	 206545.41 (0.00 pct)	 205706.04 (-0.40 pct)
  Add:	 213506.82 (0.00 pct)	 236739.07 (10.88 pct)
Triad:	 217679.43 (0.00 pct)	 249263.46 (14.50 pct)

- 100 Runs:

Test:		base		   affinity_scopes
 Copy:	 318060.91 (0.00 pct)	 326025.89 (2.50 pct)
Scale:	 213943.40 (0.00 pct)	 207647.37 (-2.94 pct)
  Add:	 237892.53 (0.00 pct)	 232164.59 (-2.40 pct)
Triad:	 245672.84 (0.00 pct)	 246333.21 (0.26 pct)

o NPS2

- 10 Runs:

Test:		base		   affinity_scopes
 Copy:	 296632.20 (0.00 pct)	 291153.63 (-1.84 pct)
Scale:	 206193.90 (0.00 pct)	 216368.42 (4.93 pct)
  Add:	 240363.50 (0.00 pct)	 245954.23 (2.32 pct)
Triad:	 242748.60 (0.00 pct)	 238606.20 (-1.70 pct)

- 100 Runs:

Test:		base		   affinity_scopes
 Copy:	 322535.79 (0.00 pct)	 315020.03 (-2.33 pct)
Scale:	 217723.56 (0.00 pct)	 220172.32 (1.12 pct)
  Add:	 248117.72 (0.00 pct)	 250557.17 (0.98 pct)
Triad:	 257768.66 (0.00 pct)	 248264.00 (-3.68 pct)

o NPS4

- 10 Runs:

Test:		base		   affinity_scopes
 Copy:	 274067.54 (0.00 pct)	 302804.77 (10.48 pct)
Scale:	 224944.53 (0.00 pct)	 230112.39 (2.29 pct)
  Add:	 229318.09 (0.00 pct)	 241939.54 (5.50 pct)
Triad:	 230175.89 (0.00 pct)	 253613.85 (10.18 pct)

- 100 Runs:

Test:		base		   affinity_scopes
 Copy:	 338922.96 (0.00 pct)	 348183.65 (2.73 pct)
Scale:	 240262.45 (0.00 pct)	 245939.67 (2.36 pct)
  Add:	 256968.24 (0.00 pct)	 260657.01 (1.43 pct)
Triad:	 262644.16 (0.00 pct)	 262286.46 (-0.13 pct)

~~~~~~~~~~~
~ netperf ~
~~~~~~~~~~~

o NPS1

Test:			base		   affinity_scopes
 1-clients:	 100910.82 (0.00 pct)	 102553.83 (1.62 pct)
 2-clients:	 99777.76 (0.00 pct)	 99390.14 (-0.38 pct)
 4-clients:	 97676.17 (0.00 pct)	 95856.63 (-1.86 pct)
 8-clients:	 95413.11 (0.00 pct)	 88801.05 (-6.92 pct)
16-clients:	 88961.66 (0.00 pct)	 78807.71 (-11.41 pct)
32-clients:	 82199.83 (0.00 pct)	 73372.46 (-10.73 pct)
64-clients:	 66094.87 (0.00 pct)	 58487.61 (-11.50 pct)
128-clients:	 43833.63 (0.00 pct)	 42005.47 (-4.17 pct)
256-clients:	 38917.58 (0.00 pct)	 22653.73 (-41.79 pct)

o NPS2

Test:			base		   affinity_scopes
 1-clients:	 101745.99 (0.00 pct)	 102703.66 (0.94 pct)
 2-clients:	 100013.62 (0.00 pct)	 99536.20 (-0.47 pct)
 4-clients:	 97124.42 (0.00 pct)	 95261.28 (-1.91 pct)
 8-clients:	 92110.60 (0.00 pct)	 87714.72 (-4.77 pct)
16-clients:	 84578.86 (0.00 pct)	 77329.65 (-8.57 pct)
32-clients:	 78272.91 (0.00 pct)	 72114.77 (-7.86 pct)
64-clients:	 61595.20 (0.00 pct)	 58001.87 (-5.83 pct)
128-clients:	 44119.18 (0.00 pct)	 40057.91 (-9.20 pct)
256-clients:	 36221.03 (0.00 pct)	 21468.40 (-40.72 pct)

o NPS4

Test:			base		   affinity_scopes
 1-clients:	 102711.93 (0.00 pct)	 103244.49 (0.51 pct)
 2-clients:	 101655.11 (0.00 pct)	 98764.88 (-2.84 pct)
 4-clients:	 98519.58 (0.00 pct)	 94439.88 (-4.14 pct)
 8-clients:	 94247.56 (0.00 pct)	 88618.17 (-5.97 pct)
16-clients:	 87515.03 (0.00 pct)	 82392.50 (-5.85 pct)
32-clients:	 81486.07 (0.00 pct)	 74022.13 (-9.15 pct)
64-clients:	 68436.64 (0.00 pct)	 60303.48 (-11.88 pct)
128-clients:	 49393.57 (0.00 pct)	 43924.74 (-11.07 pct)
256-clients:	 41111.27 (0.00 pct)	 27694.64 (-32.63 pct)

~~~~~~~~~~~~~
~ unixbench ~
~~~~~~~~~~~~~

o NPS1

					base		     affinity_scopes
Hmean     unixbench-dhry2reg-1      41194259.44 (   0.00%)    41044431.89 (  -0.36%)
Hmean     unixbench-dhry2reg-512  6252840065.42 (   0.00%)  6244309194.01 (  -0.14%)
Amean     unixbench-syscall-1        2534936.20 (   0.00%)     2517701.13 *   0.68%*
Amean     unixbench-syscall-512      8037812.87 (   0.00%)     7379945.23 *   8.18%*
Hmean     unixbench-pipe-1           2391449.08 (   0.00%)     2392275.16 (   0.03%)
Hmean     unixbench-pipe-512       340010431.31 (   0.00%)   339389300.96 (  -0.18%)
Hmean     unixbench-spawn-1             4471.68 (   0.00%)        4568.80 (   2.17%)
Hmean     unixbench-spawn-512          66246.39 (   0.00%)       62380.27 *  -5.84%*
Hmean     unixbench-execl-1             3695.11 (   0.00%)        3663.75 *  -0.85%*
Hmean     unixbench-execl-512          12526.29 (   0.00%)       11833.41 (  -5.53%)

o NPS2

					base		     affinity_scopes
Hmean     unixbench-dhry2reg-1      40812348.19 (   0.00%)    41044955.13 (   0.57%)
Hmean     unixbench-dhry2reg-512  6248963826.97 (   0.00%)  6244114150.91 (  -0.08%)
Amean     unixbench-syscall-1        2479433.67 (   0.00%)     2498544.70 (  -0.77%)
Amean     unixbench-syscall-512      8064530.47 (   0.00%)     8064139.93 (   0.00%)
Hmean     unixbench-pipe-1           2393194.62 (   0.00%)     2365328.39 (  -1.16%)
Hmean     unixbench-pipe-512       339553534.72 (   0.00%)   340930432.76 (   0.41%)
Hmean     unixbench-spawn-1             4777.52 (   0.00%)        4975.71 (   4.15%)
Hmean     unixbench-spawn-512          67467.26 (   0.00%)       63427.50 *  -5.99%*
Hmean     unixbench-execl-1             3640.89 (   0.00%)        3636.52 (  -0.12%)
Hmean     unixbench-execl-512          14182.44 (   0.00%)       13584.16 (  -4.22%)

o NPS4

					base		     affinity_scopes
Hmean     unixbench-dhry2reg-1      41075499.61 (   0.00%)    41222189.50 (   0.36%)
Hmean     unixbench-dhry2reg-512  6250307266.90 (   0.00%)  6251044709.08 (   0.01%)
Amean     unixbench-syscall-1        2538714.30 (   0.00%)     2521520.87 *   0.68%*
Amean     unixbench-syscall-512      7514126.30 (   0.00%)     7534175.47 (  -0.27%)
Hmean     unixbench-pipe-1           2393641.60 (   0.00%)     2379400.79 (  -0.59%)
Hmean     unixbench-pipe-512       339424173.78 (   0.00%)   341229694.29 *   0.53%*
Hmean     unixbench-spawn-1             5421.34 (   0.00%)        5556.23 (   2.49%)
Hmean     unixbench-spawn-512          64071.52 (   0.00%)       65783.47 *   2.67%*
Hmean     unixbench-execl-1             3629.56 (   0.00%)        3670.13 *   1.12%*
Hmean     unixbench-execl-512          13641.24 (   0.00%)       13848.81 (   1.52%)

~~~~~~~~~~~~~~~~
~ ycsb-mongodb ~
~~~~~~~~~~~~~~~~

o NPS1:

base:			298681.00 (var: 2.31%)
affinity_scopes		295106.33 (var: 2.22%) (-1.19%)

o NPS2:

base:			296570.00 (var: 1.01%)
affinity_scopes		298637.67 (var: 1.50%) (0.70%)

o NPS4:

base			297181.67 (var: 0.46%)
affinity_scopes		294253.33 (var: 0.80%) (-0.99%)

~~~~~~~~~~~~~~~~~~
~ DeathStarBench ~
~~~~~~~~~~~~~~~~~~

o NPS1:

- 1 CCD

base:			1.00 (var: 0.14%)
affinity_scopes:	1.01 (var: 0.51%) (+1.19%)

- 2 CCD

base:			1.00 (var: 0.74%)
affinity_scopes:	0.99 (var: 0.47%) (-1.02%)

- 4 CCD

base:			1.00 (var: 0.33%)
affinity_scopes:	0.99 (var: 0.47%) (-0.95%)

- 8 CCD

base:			1.00 (var: 0.62%)
affinity_scopes:	0.99 (var: 2.30%) (-1.42%)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~ Benchmarks run with multiple affinity scope ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

o NPS1

- tbench

Clients:     base                     cpu                    cache                   numa                    system
    1    450.40 (0.00 pct)       459.44 (2.00 pct)       457.12 (1.49 pct)       456.36 (1.32 pct)       456.75 (1.40 pct)
    2    872.50 (0.00 pct)       869.68 (-0.32 pct)      890.59 (2.07 pct)       878.87 (0.73 pct)       890.14 (2.02 pct)
    4    1630.13 (0.00 pct)      1621.24 (-0.54 pct)     1634.74 (0.28 pct)      1628.62 (-0.09 pct)     1646.57 (1.00 pct)
    8    3139.90 (0.00 pct)      3044.58 (-3.03 pct)     3099.49 (-1.28 pct)     3081.43 (-1.86 pct)     3151.16 (0.35 pct)
   16    6113.51 (0.00 pct)      5555.17 (-9.13 pct)     5465.09 (-10.60 pct)    5661.31 (-7.39 pct)     5742.58 (-6.06 pct)
   32    11024.64 (0.00 pct)     9574.62 (-13.15 pct)    9282.62 (-15.80 pct)    9542.00 (-13.44 pct)    9916.66 (-10.05 pct)
   64    19081.96 (0.00 pct)     15656.53 (-17.95 pct)   15176.12 (-20.46 pct)   16527.77 (-13.38 pct)   15097.97 (-20.87 pct)
  128    30956.07 (0.00 pct)     28277.80 (-8.65 pct)    27662.76 (-10.63 pct)   27817.94 (-10.13 pct)   28925.78 (-6.55 pct)
  256    42829.46 (0.00 pct)     38646.48 (-9.76 pct)    38355.27 (-10.44 pct)   37073.24 (-13.43 pct)   34391.01 (-19.70 pct)
  512    42395.69 (0.00 pct)     36931.34 (-12.88 pct)   39259.49 (-7.39 pct)    36571.62 (-13.73 pct)   36245.55 (-14.50 pct)
 1024    41973.51 (0.00 pct)     38817.07 (-7.52 pct)    38733.15 (-7.72 pct)    38864.45 (-7.40 pct)    35728.70 (-14.87 pct)

- netperf

                        base                    cpu                     cache                   numa                    system
 1-clients:      100910.82 (0.00 pct)    103440.72 (2.50 pct)    102592.36 (1.66 pct)    103199.49 (2.26 pct)    103561.90 (2.62 pct)
 2-clients:      99777.76 (0.00 pct)     100414.00 (0.63 pct)    100305.89 (0.52 pct)    99890.90 (0.11 pct)     101512.46 (1.73 pct)
 4-clients:      97676.17 (0.00 pct)     96624.28 (-1.07 pct)    95966.77 (-1.75 pct)    97105.22 (-0.58 pct)    97972.11 (0.30 pct)
 8-clients:      95413.11 (0.00 pct)     89926.72 (-5.75 pct)    89977.14 (-5.69 pct)    91020.10 (-4.60 pct)    92458.94 (-3.09 pct)
16-clients:      88961.66 (0.00 pct)     81295.02 (-8.61 pct)    79144.83 (-11.03 pct)   80216.42 (-9.83 pct)    85439.68 (-3.95 pct)
32-clients:      82199.83 (0.00 pct)     77914.00 (-5.21 pct)    75055.66 (-8.69 pct)    76813.94 (-6.55 pct)    80768.87 (-1.74 pct)
64-clients:      66094.87 (0.00 pct)     64419.91 (-2.53 pct)    63718.37 (-3.59 pct)    60370.40 (-8.66 pct)    66179.58 (0.12 pct)
128-clients:     43833.63 (0.00 pct)     42936.08 (-2.04 pct)    44554.69 (1.64 pct)     42666.82 (-2.66 pct)    45543.69 (3.90 pct)
256-clients:     38917.58 (0.00 pct)     24807.28 (-36.25 pct)   20517.01 (-47.28 pct)   21651.40 (-44.36 pct)   23778.87 (-38.89 pct)

- SPECjbb2015 Mutli-JVM

	       max-jOPS	     critical-jOPS
base:		 0.00%		 0.00%
smt:            -1.11%		-1.84%
cpu:             2.86%		-1.35%
cache:           2.86%		-1.66%
numa:            1.43%		-1.49%
system:          0.08%		-0.41%


I'll go dig deeper into the tbench and netperf regressions. I'm not sure
why the regression is observed for all the affinity scopes. I'll look
into IBS profile and see if something obvious pops up. Meanwhile if there
is any specific data you would like me to collect or benchmark you would
like me to test, let me know.

--
Thanks and Regards,
Prateek
