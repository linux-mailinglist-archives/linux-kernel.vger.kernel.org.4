Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1725C728EA8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 05:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbjFIDnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 23:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjFIDnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:43:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADEDF5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 20:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDFirqgCATtiGyz5kXHl3mgmPJrgYODkA+RHkNJuhT6kI6dgv62XTHa6dNKuMXvqkofOUxAvhCtvIAKC7LtAJ/4vnM5jBSEaRoaewZocTgGQCER6p3xTffLo/6eJsH2RVCRZKKNhZ3HY6ycrDUBJOQAAg2b3e4zcJTquHjmV93nsH0rlMNQbWwNxVzfFlLvBhXHWD/VRCkrYoPOUvx8ZklGTzFB3wRREerUzJiSplj6hbdPSSHXnKdsyWfyged8/1kKuqj2snuS+vahgUAUoD/CtcNeMddHfShD0cqMI+LvQN52Ikm9THjTob0zE+e64atPQUx4J3HoFUxV5uTbCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUxkXGFX2qxvWMjCIwpPPmHLmL5o3EtrE0zQDpPERss=;
 b=KRvBAVHItg9D2Y16c11ouVjUsn2mg+jE9mYNSOIIykBIJfO2ypkFxt5gUYFoiyD+hR6FTpy92JDBpZ8C4Mbz1bZVzRVpoVYddjvAczDaCZgrr85BG60z+Xo+wNHcyQ6CQpZZBlFa/FYG3ZrjZZsZI6lH2SxWE9m8AYozxeJniQs9CIh7XUDFpCjymOsdOjvcTyUwaWhZovp5339EhNFgBWdfvrT+EBwzkkZOyfsYRyvXON7zjDVHnz1+gAaYEe6DNzzsmWPz2e0YUp/exZPLty33wH3RNq5XAJSm1B78UB6Z6Z7DCyS5mPkctO7xBxTGbzNHfWevuY1P7CrVRXxDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUxkXGFX2qxvWMjCIwpPPmHLmL5o3EtrE0zQDpPERss=;
 b=DiRR9M32qP9jRvxb3MoiwxHwI+kgUlgXp2W8xQO/B4IKxxqBy3u+CsfPtJFp6W/om1Z/sVIEY8s9HuOiErgNE4OieGeSLKf3wvGGzis+epLpSZZ0x+rqk61fATOwEeurz2E2mfF3lJDpLI+Xa/SyFgTYURTeQCtbxFHl2w99Rbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Fri, 9 Jun
 2023 03:43:30 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c%2]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 03:43:30 +0000
Message-ID: <fd5a27de-c8a9-892c-f413-66ea41221fdd@amd.com>
Date:   Fri, 9 Jun 2023 09:13:15 +0530
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
        void@manifault.com, kernel-team@android.com,
        Swapnil Sapkal <swapnil.sapkal@amd.com>
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
X-ClientProxiedBy: PN3PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::9) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: fab74375-770b-406a-d2a2-08db689bb0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0GWanmNFhbQOpQmPRD4uTp3EyxPWEMT+gnfhN04evPdIMfJ5ZhiItc1L6teni5ekVjXwHj7n5IOIn8bCQVuIhlNvMPZmD0RoEOPn1wO54VDHYySZgrHOwomBapC/4Syt55O5D6peJONO71CWGQ272XxS/pS4Wdf5TWYYqxcaSgwGu94PrzmkQtxLp2I1dYga2oaxlfz1D7BPRD4bdohLTKg8aKW7GASupbBq5V2JziYTPYACeV8USXpngftKKf4G7iopilrKdpUT2PPysuUKoVJwfsb74te+cm1x+cLTB/8GmcFHSNVHOSZF5k6WhKzErLvuFkFogI2ZnVzC3cuvlt7BkRVLU4EEJ8n9Pfhu28pz9EVMgjdCeCNW70wFEXFIF3A9x9j5E2KQoP6/wTgLs+TZMDOJ8YMWTDlNPmW3fih+gtFKnSDlBhjVE0qFegIRLptz3110acMVo03sVKmGcHhvgjf4V8jOGaWewqugwWiS4rAJUEutwKUBeyvjfxRG4K1grIvS+4ro2ebL6BEoIb0vRu0ciTqDn98uTyGQndenMdalXKRj2KF6Xj2G2ds2aGbxF6k4x6+0UnDYWmnll8EgZ2g+bb1xbqK8xPfxLm/dcv597mP4v6D022J9eLyMIPje3NuFswHHXUUBQGv5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(83380400001)(7416002)(478600001)(8676002)(8936002)(4326008)(86362001)(66476007)(66946007)(66556008)(31696002)(6916009)(5660300002)(38100700002)(41300700001)(316002)(6666004)(6486002)(36756003)(2906002)(54906003)(6512007)(186003)(26005)(6506007)(53546011)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzFPc3Q3STluOENaWlBDTnB2bFUwSXIvU2xNb3pldnBVWStXdTZ3YlFXQVlI?=
 =?utf-8?B?YVlROFJ1b05FKzc5R2t5TkIyVmJzK3V1TlUwR1NxWWVGZlJMRDdMUStncTdW?=
 =?utf-8?B?Z0cybGl0RDN1M0JVUmxnVkNPSHNGRkkzSkNlLzUzVzZUeEU1b3BHL05VRW1h?=
 =?utf-8?B?WUZjaGRTc2hwcnBBWjZock5LMzF5V0VQSEk0bEIxanVlSzM3RVRBczFmRWpw?=
 =?utf-8?B?OWpkQk9Jdm81WUl0ZXI0dFdpMTdKOHdLc1RzY2V3RkJVNlYxcFA0RndZWW1x?=
 =?utf-8?B?dE9hL2syckZ3amtNVlczbndZRklySE5FTVZpWXRyMm84eVc5OGJ2MlZGZFQ4?=
 =?utf-8?B?SEtUdjE0UktNdEhLeWN5UWlYSmdGaGpBQ1ZwQkVaeVdNQkVMR2tjVzBBNzR4?=
 =?utf-8?B?UXZpWnR2a1RFeWh6Vmx5WERRak1oRU9PNTNob2hOa1NITXJubkpnVHRKQ0My?=
 =?utf-8?B?bkVUemMxUHY3Qy9tUE5EZUVIUTlyditLYlNSUEt0RGNUSkNEQU84c1FJZzQv?=
 =?utf-8?B?RUtkRnJ3MHcwcW1jdjIwNmIwOFVzR2N2eTFmOFVTOEtVTDE3NzZjclNzcmxr?=
 =?utf-8?B?cUdNdGd6c1UrRE5sM3RJZDQ5aHlsNHRFUzFQZUNDQjJOOHFlbWNsVGlvd0w4?=
 =?utf-8?B?RU0reUpXS3VpVk5oOTBiN3FBRTErazQ4c1dvV1NaQ0hPZ3BkZWZKUEx4MU5E?=
 =?utf-8?B?NTBhM3I5cHBBT1RnTGhKQ09OK1RSZFhlcEJzcmIvYjFLVHl0QndyVnIrb3NX?=
 =?utf-8?B?U1Btc1pyZ3grQUFlRlArcUE4aFRFNWJSZlJlVXdPYW5XY1lnMkpZS1l1UGZh?=
 =?utf-8?B?V2pwS3pEamFpVlBUZFZDTW9zQlJMaVhGdU1iR1NGN2xWNElRSWJJK05tMkpj?=
 =?utf-8?B?dkdSelNnMVFYNFFMVUQ5UWc3M1lyeGxQRngrRWk5UHBneTk0ZTRFTTZ3dElS?=
 =?utf-8?B?L3hNUnBCUnNBWWhzL3NzL2RYanlUbmkwKzJYS3lFV1pHVGhDZ3FCdlVBbXRs?=
 =?utf-8?B?VEQ4THRBNndtTWZZMlFpb1dYKytPdDduOExuWDlpTkVGMXpRYnFvUExkNHZU?=
 =?utf-8?B?a3RFeVlvamlPUXk2UGVsZmlkYnJMVExRV2xGdTduRWsvK1ZEMjc0NE0xWjlt?=
 =?utf-8?B?SVZYTnI3NDJKSys1YUZyZVh2MndzMEpjalQ1SzFsVk5nUWhlbGNZSklKOE5l?=
 =?utf-8?B?RTQwZTRQSlBEYnM0R04yMWRFM1poTUlmVFFjZHNWQllWQUF1RWxjZlVJNDVs?=
 =?utf-8?B?N25aVzNwZTQxQ25PaG9YSHdWTVQ5SzRwOThMVVNIZkJxWDhjZGVlTk53bXZF?=
 =?utf-8?B?WFh2ZmtNT2ppbGszU1BXcHJCWngrRG4rakIrKzMxNHNkNWdMVEJXazdGdXpI?=
 =?utf-8?B?TTdHYkEzUkorUDNGVnpEcnBZYkZrKzJOanVYOXhrSHJvMHprMUZQdFkrZDVz?=
 =?utf-8?B?YlV3OWFsN2UzNzRmbW1ZbkZvT1dPcDd4RjNKVit5R2h0a00vdWRSd3FNVzg4?=
 =?utf-8?B?WlMzMFBtc0pBbkI5c3ExallWbGZqdmpneW85a0pYbytGa2RxWTFKQStJMnRE?=
 =?utf-8?B?cXhYOEhLcEhma0FEWjNSVHBuTnFSUDZ6N0JQSHpzUFROU3lweXp4bHkyNVlo?=
 =?utf-8?B?b1JYOG9vUkduVFFKVGQ0cDVUMG9uNWp5dXhISGgxeExTNWtiNGZxaCtmQURm?=
 =?utf-8?B?Z3p3UCtYWFRjYmJhSkdZQk9YQmFNSkgvS2xmWTJ4ZUZHcW1YZXM0bmxHbzN0?=
 =?utf-8?B?cnlFYWVsWWZtU1MxQjJyS0svZEtrcVZiV293dkw4bVIrc3R4Zk9rZ2E0U0o0?=
 =?utf-8?B?MXdWOGd4d0picTcwQ2dITUNGTERuNG5RSjdmMWtWaGk3U1VvSkJsd0ZmTlN4?=
 =?utf-8?B?WnVwcDU2QTNoeGZKd0M4VG40ZitqSld5Q0tyZUFTRS9rd2poOWhqWUlxQWtP?=
 =?utf-8?B?dktUUGUvTG81UjZLbFdTRW1EREduKzdZaXh2MTh2alMzNGYySFdXRllkcm04?=
 =?utf-8?B?R29Cc3hIU0hYS1llZEFjZDBCZVNUUlk5YUVGRVUxKzd6U0k4TnAvR1VuMnRa?=
 =?utf-8?B?eHlaU3lERERndDdrK0Z0bHBUQnllOXdyL0FQNEVXM2E2clRNbmpxSERlZ0cx?=
 =?utf-8?Q?100cjzvGl6xBYKin4UQMopLi5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab74375-770b-406a-d2a2-08db689bb0b7
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 03:43:30.1094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SaqQTljDjopJYHuz/E9fhRYto+snop2bsRt3mngd9WVuwu4Gsdv9Yk8/hQO/YIQVzqicOgTwZUc75D3rADSJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
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
> Hello,
> 
> On Thu, Jun 08, 2023 at 08:31:34AM +0530, K Prateek Nayak wrote:
>> [..snip..]
>> o I consistently see a WARN_ON_ONCE() in kick_pool() being hit when I
>>   run "sudo ./stress-ng --iomix 96 --timeout 1m". I've seen few
>>   different stack traces so far. Including all below just in case:
> ...
>> This is the same WARN_ON_ONCE() you had added in the HEAD commit:
>>
>>     $ scripts/faddr2line vmlinux kick_pool+0xdb
>>     kick_pool+0xdb/0xe0:
>>     kick_pool at kernel/workqueue.c:1130 (discriminator 1)
>>
>>     $ sed -n 1130,1132p kernel/workqueue.c
>>     if (!WARN_ON_ONCE(wake_cpu >= nr_cpu_ids))
>>         p->wake_cpu = wake_cpu;
>>     get_work_pwq(work)->stats[PWQ_STAT_REPATRIATED]++;
>>
>> Let me know if you need any more data from my test setup.
>> P.S. The kernel is still up and running (~30min) despite hitting this
>> WARN_ON_ONCE() in my case :)
> 
> Okay, that was me being stupid and not initializing the new fields for
> per-cpu workqueues. Can you please test the following branch? It should have
> both bugs fixed properly.
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git affinity-scopes-v2

I've not run into any panics or warnings with this one. Kernel has been
stable for ~30min while running stress-ng iomix. We'll resume the testing
with v2 :)

> 
> If that doesn't crash, I'd love to hear how it affects the perf regressions
> reported over that past few months.> 
> Thanks.
> 

--
Thanks and Regards,
Prateek
