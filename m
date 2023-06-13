Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF8672D809
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 05:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbjFMDON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 23:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjFMDNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 23:13:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC843A8D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai2yvLrkeqR199d3eo52HT4LWOwLX3LojhIJKGnLn3pzluTkEPqImNdpBLhslcVtUbxeWVq7jaUdaHz0Fbx7Y8Jq8D8ESLWUJKAeQgsDWFZhywgaCfqvNr0NYJlnGRDORVkWSFawRpDSbI4B2A2GydwAIQIz/LMZjUKoufyRS/UlFZBY+iDryeyYCQIJyTo/AlMDfX1Mu1U3OSg+C0peS/8hzmz7UN5OeVbPGx7PU0EMQn8t/pnZseeROUm/wDuAVsnWaOU7PjrQqy2vKuwPr6+vjkGY//tLWU11I25kBPtJanwfVEEKI+vTQGk3DjiAnYGw2EpZCIn7qQ46WLQp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jFMgSL4KshmssNyRoV2bUAoy6uUa8IPS07VsrIc6nM=;
 b=f0frwWZwtBDS9S/VsHVxVYcn4IhC68a5Pc2lLM3SLVbhg1Y+PZMqwJ5sghD1haaz24FFdyNW1/+AjcRU4bzC9H57esNm87jFwg6kJjoNyMmu3Prc5firYuZlcdQ4NTuGOECUWoWp+0ReqNDcx1edfwj6qTxws7fOtAVDxBhekWmBghjckjMOLvT0my8xwx96biA5BitW/EyynyX5Q+OjcdGwMeZXIXrZorKvodcOVLKQajRZ5czKwOa5NQhrrkT5k2q/Iz7Vbxxd+4A4SBHKYx5JD7HDmMMs6wTHbyqwHlOJbl6OznFoPrxUfdqfW65fjEoxWMspd1GUrJHY6HxuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jFMgSL4KshmssNyRoV2bUAoy6uUa8IPS07VsrIc6nM=;
 b=RB6N1YTcLU9vnYNWboI3p9e5s4hZ/szAORYQ0yv71C2Ia9YCL7wtz3Rxv+aTl/wC3uctJLt4Usr5jAUfjKxIP9wk/rihRKY8E4uJpn1f3HCEIqvRK/Vc3pjxNCXoMqD+VVXLNyP3pDmNrALJ6poKHK8NKHv8gDFRdNKaI5+G/kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 03:12:02 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c%2]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 03:12:01 +0000
Message-ID: <206791ae-db73-dd00-9fb3-4c642638dd85@amd.com>
Date:   Tue, 13 Jun 2023 08:41:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 00/13] Generalized Priority Inheritance via Proxy
 Execution v3
Content-Language: en-US
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
References: <20230601055846.2349566-1-jstultz@google.com>
 <c12889cf-d57e-90be-54a5-0329183817fb@amd.com>
 <CANDhNCo5yiHzyFaJO6Aks=sCiS2PekPscwWa-8Zbw2bQaVtTeA@mail.gmail.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCo5yiHzyFaJO6Aks=sCiS2PekPscwWa-8Zbw2bQaVtTeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::21) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM4PR12MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: 05efa9b5-e6a4-41f1-dba5-08db6bbbf46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xm/yJ9dzVXXtNys8cVvgb0jCAfxCqmdEAl/+FCDOCwk3+3L5YHDHgx4vwXo9B7JdZ3Tt/8+9HtKFhQT5j7g8x4darBwTiXUAKoVv6LhkApdwGvQ1vCLYZ0YKigQDqKx/ctV5Hazrtm2csYMdLMjoUh7Q8xa+aFlOrc3Rpqko92Ck+aEH0Jb+li1GxqzcVNTbZefC2e8yh2bwTzQUvxJfdr9KViO7l9eFe8LnB5OAEtZ6mJ0K2hsg+pkkGrEb3IsvZTig/9wJuv7AxWSHdxQH4zrF9YojOJ4xTMLsoJVayBOmX4okRr4paEOAQFOMqaHUsWOfmBxgK/gqiYik6/aU4iRVxGu/dO9Slp0DJjOU13F94Ro85EGZP/h3VcBJsem+hXydgHXEAXPn+gYG3K5lzFS4g+BmhNb9SqseoOe8ANwGleyCYvx+oID67+s6b94MxSvfzEHv6v2s7UVLXEeV/qDFIpoOyyxNWSw6gtHy9lr9arzq++mWYupPUs06Uvw7xFYUiQyzyc/T4LV9xs9mRoXxkJIgaVOuxd5C4x1Ht9vlwPiNWeVs+Y22jvu11aoRuI+l3S1TPcttz18M1Sj4XVWmBUIEzkjXI8utmJYueEkGlickVJ/CjHI3gcb6PnLlnlVfOvRyIfiY59A0cg+93lgzbGWV1rEB5WO+HKTI8gE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(5660300002)(54906003)(2906002)(31686004)(66946007)(66556008)(4326008)(6916009)(8936002)(316002)(8676002)(41300700001)(7416002)(186003)(66476007)(478600001)(45080400002)(6666004)(966005)(6486002)(26005)(53546011)(6512007)(83380400001)(36756003)(6506007)(2616005)(86362001)(38100700002)(31696002)(218113003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVYzcUEzTHRkMGI0MHphZHJQT3ZHaE85azEvYzhyNWg1QXN0Q25ZUDNKNDMx?=
 =?utf-8?B?bFpsYjlkejJiYzFGdjNXSmovNjNqbWlJdW9rZ2FaMGEzRFcrUnc0M28wbHE0?=
 =?utf-8?B?cDN1aEd6MU9adVdvMkExcTVBNkhYNkRweVlhbU9ZTUh5NlNtVUI2KytmMm4x?=
 =?utf-8?B?dFhoU3UyNW5sVGt0QTZvQmlCSGUvRTRxTFRxck1tRjJ5MFV5R3BtSEE5bkwv?=
 =?utf-8?B?c0pEWjI2RWU5T3U0bnhyZDlVVXV4RVIySHpRV3VMRzlIVHkyNzJvWFpCUS84?=
 =?utf-8?B?dnhyWFdUN200VjVXV2VoNzMrSzR4MVFndWRGL25QS3loWlpJZG5EYzdMcmxx?=
 =?utf-8?B?ejdvNVRDQ0hHNnh1MTI2bS82WHl4a3ZFZFBFVnNZcFA0NHVmalVDYnh1L3hm?=
 =?utf-8?B?cHd6OGxzT2ZsSHY2cW9nYTNzTnYwMml5NHU3MUdqOWVncEMzcjdtTlJlbFlo?=
 =?utf-8?B?NjQwYncxejA3RU5sTHpXVElSbWFMc2c5bERaYTkwVytvWHg0SGxvak1vUll6?=
 =?utf-8?B?ZkxTNDBQNWNLbmgzaGIrVFE2QWllZjJmY09pYlBBM3BJZ1gzOWlJaCt6c0c0?=
 =?utf-8?B?cmxiNnRadHUzdFRBSFRXajc4NnQwY050TUNySENQelRLc2kxTlIwaEZaRGEw?=
 =?utf-8?B?dWluRVhsclB0K3grMUo1V093WE0wbXdrK2dHS3VDZ0ZRdVkyRE9RQXFTcVNu?=
 =?utf-8?B?YlRjcHNKTXFzWlV0R3lYN3QwTFdsd0dmT2lzQS9lcEhIWjlpNEgzaURweXkx?=
 =?utf-8?B?bE0vTFEwUDY5czdmQ3M0cGt4WENQNDYzUVpDZzRMckNId2p1cVZKM0FkSzJq?=
 =?utf-8?B?TlNuRXRzanFOdUJDenNEWGpCQ0NuY0U4M3FSNUpoZnp6Q0dnWURTYWJNTkMr?=
 =?utf-8?B?ZWFPM3lSRTBhMjM1dDVwUUkyK2ZOZFpRWE5xRXlxNVJGQTE1cFY1ejc2Wi9u?=
 =?utf-8?B?RHJ6RzVzNFZldFAvc0k4cHozWDI2SmVrY05seUdGMWM2dyt2ZCsxRjJNK1RH?=
 =?utf-8?B?a3FBNkZneVczM01GSklLdURBV3BwOFJTbmtGR09SV25na1JWQmdxR2NMQ0tp?=
 =?utf-8?B?dFZVbkRwU1czR3BjZGMyQmVYU1dQUlJKY0Z1cWIrbEp0Uk9hZWl5R2hLVnFQ?=
 =?utf-8?B?VitOUWFMcFVXMHA5WmVPejZSZklDa3N4ZytwQW1menVHMTZsazl2ME1sZ2Nt?=
 =?utf-8?B?WDA2dm8yUE5ZWU1JTCt1M05CSjFQR0ZBT050VjhscEJDd3Q4Ykt6SG5iVGJ3?=
 =?utf-8?B?aW5RbDBVaFoxOWlJdGQ3R3BxU2N6ZTl4dVVLNlpMQWFZM0VaMkNpTEUzQ3ds?=
 =?utf-8?B?a1I3NVhLQ1VYclQ0d21rcjJtaG9NbUZQMDBSY1JDZG5vMjdtL09DWnVFdUZ0?=
 =?utf-8?B?Kzh2QlppbStlcTBqbURxYVJCU1BWRkpzTHpWYjdYaFNtOXZkUWc5RTkyVkFp?=
 =?utf-8?B?V2pxRldqNEZ0czNiM2R0c2dDNlF3Y09TWFRWQ2VUc0tHdHI4V0NaNzdMNUo0?=
 =?utf-8?B?ZnFNWGZVVCtCSEloYXdSTHBqUjV6TmpkNk1qdFRNazdjVU1tSlpNNEcvd0x1?=
 =?utf-8?B?OTNzTlJZZWxYdk9MMkxOWldqT2FKSDE1V1R2ek9NMnVKTXNTK3FkbVVuS1ZB?=
 =?utf-8?B?L3haRjJhSy9nMUo5TU42TGlvWmoyRndGMUErU24zR2c3MFdsUVhOWDNGRk5G?=
 =?utf-8?B?RTY3YmFPenplUDRZa2t2a1BhN0dnd3QwdWVmdm82QmJobG5lQnRucFpuZUdV?=
 =?utf-8?B?R1lKSDBrL1NWRURjV1hqYVlOYWFNT0JpcVUrWU11a2Z5V2s4OXFCY0x4UWJI?=
 =?utf-8?B?YUh3d1pYSUw0UXQ3WC9WOHliYlV0TjdaMnlOM1FEMC9VSis2NjgvTFc3V2lp?=
 =?utf-8?B?cHNzMS9FWkhyMTJmNTJZU2haUWFyczdlKytZcUZ6eEVRL0JGZCtSZWZ2M2ZK?=
 =?utf-8?B?dDdvT0VrWlNiR0JWZ2FBYWlwUzVkWlJmbUpjQ3ZYNU5sTWFsVHN1WGx1U1lU?=
 =?utf-8?B?amJQTldlRVhmd3R1WnZ3T2tRZXNWUjh2anArNVAzSVRvb1NKVVZIY0dFNjRm?=
 =?utf-8?B?aVVmOGlTY1B3MHA4Z1JQUkwyeFJqWnBzQ3d4djduOHE1ZkZHU2M4dXF6TGFv?=
 =?utf-8?Q?3lzAnrLmFTzcx9RaddruLVneK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05efa9b5-e6a4-41f1-dba5-08db6bbbf46e
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 03:12:01.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbavV2fQ/rMFYoLbL0OgCzApyh4PDz+vy+oYCCHejKXTOzYZjCriVOhBwV+gUvKN1Ey5WYojwQCBj6I5qR4JNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5038
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

Hello John,

On 6/13/2023 12:22 AM, John Stultz wrote:
> On Mon, Jun 12, 2023 at 10:21 AM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>> On 6/1/2023 11:28 AM, John Stultz wrote:
>>> [..snip..]
>>>
>>> Issues still to address:
>>> —----------
>>> * Occasional getting null scheduler entities from pick_next_entity() in
>>>   CFS. I’m a little stumped as to where this is going awry just yet, and
>>>   delayed sending this out, but figured it was worth getting it out for
>>>   review on the other issues while I chase this down.
>>
>> I'm consistently hitting the above issue early during the boot when I was
>> trying to test the series on a dual socket 3rd Generation EPYC platform
>> (2 x 64C/128T). Sharing the trace below:
>>
>>     [   20.821808] ------------[ cut here ]------------
>>     [   20.826432] kernel BUG at kernel/sched/core.c:7462!
>>     [   20.831322] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>>     [   20.836545] CPU: 250 PID: 0 Comm: swapper/250 Not tainted 6.4.0-rc4-proxy-execution-v4+ #474
>>     [   20.844976] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
>>     [   20.852544] RIP: 0010:__schedule+0x18b6/0x20a0
>>     [   20.856998] Code: 0f 85 51 04 00 00 83 ad 50 ff ff ff 01 0f 85 05 e9 ff ff f3 0f 1e fa 48 8b 35 0e 0c fe 00 48 c7 c7 33 a1 c1 85 e8 ca 37 23 ff <0f> 0b 4c 89 ff 4c 8b 6d 98 e8 1c 82 00 00 4c 89 f7 e8 14 82 00 00
>>     [   20.875744] RSP: 0018:ffffbd1e4d1d7dd0 EFLAGS: 00010082
>>     [   20.880970] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000005
>>     [   20.888104] RDX: ffff9d4d0006b000 RSI: 0000000000000200 RDI: ffff9d4d0004d400
>>     [   20.895235] RBP: ffffbd1e4d1d7e98 R08: 0000000000000024 R09: ffffffffff7edbd0
>>     [   20.902369] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9d4d12e25a20
>>     [   20.909501] R13: ffff9dcbffab3840 R14: ffffbd1e4d1d7e50 R15: ffff9dcbff2b3840
>>     [   20.916632] FS:  0000000000000000(0000) GS:ffff9dcbffa80000(0000) knlGS:0000000000000000
>>     [   20.924709] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>     [   20.930449] CR2: 00007f92120c4800 CR3: 000000011477a002 CR4: 0000000000770ee0
>>     [   20.937581] PKRU: 55555554
>>     [   20.940292] Call Trace:
>>     [   20.942741]  <TASK>
>>     [   20.944845]  ? show_regs+0x6e/0x80
>>     [   20.948259]  ? die+0x3c/0xa0
>>     [   20.951146]  ? do_trap+0xd4/0xf0
>>     [   20.954377]  ? do_error_trap+0x75/0xa0
>>     [   20.958129]  ? __schedule+0x18b6/0x20a0
>>     [   20.961971]  ? exc_invalid_op+0x57/0x80
>>     [   20.965808]  ? __schedule+0x18b6/0x20a0
>>     [   20.969648]  ? asm_exc_invalid_op+0x1f/0x30
>>     [   20.973835]  ? __schedule+0x18b6/0x20a0
>>     [   20.977672]  ? cpuidle_enter_state+0xde/0x710
>>     [   20.982033]  schedule_idle+0x2e/0x50
>>     [   20.985614]  do_idle+0x15d/0x240
>>     [   20.988845]  cpu_startup_entry+0x24/0x30
>>     [   20.992772]  start_secondary+0x126/0x160
>>     [   20.996695]  secondary_startup_64_no_verify+0x10b/0x10b
>>     [   21.001924]  </TASK>
>>     [   21.004117] Modules linked in: sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua ipmi_devintf ipmi_msghandler msr ramoops reed_solomon pstore_blk pstore_zone efi_pstore
>>     ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear mgag200
>>     i2c_algo_bit drm_shmem_helper drm_kms_helper ghash_clmulni_intel syscopyarea sysfillrect aesni_intel sysimgblt crypto_simd crc32_pclmul cryptd crct10dif_pclmul sha512_ssse3 xhci_pci tg3 drm
>>     xhci_pci_renesas megaraid_sas wmi
>>     [   21.055707] Dumping ftrace buffer:
>>     [   21.059291] ---------------------------------
>>     [   21.063697]   <idle>-0       250dn.2. 21175635us : __schedule: JDB: BUG!!! pick next retry_count > 50
>>     [   21.072915] ---------------------------------
>>     [   21.077282] ---[ end trace 0000000000000000 ]---
>>
>>     $ sed -n 7460,7462p kernel/sched/core.c
>>       if (retry_count++ > 50) {
>>               trace_printk("JDB: BUG!!! pick next retry_count > 50\n");
>>               BUG();
>>
>> Hope it helps during the debug. If you have a fix in mind that you
>> would like me to test, please do let me know.
> 
> Thank you for the testing and feedback here! I really appreciate it!
> And my apologies that you're hitting trouble here!

No worries! Better to hit the snags now than later :)

> 
>>> * Better deadlock handling in proxy(): With the ww_mutex issues
>>>   resolved, we shouldn’t see circular blocked_on references, but a
>>>   number of the bugs I’ve been chasing recently come from getting stuck
>>>   with proxy() returning null forcing a reselection over and over. These
>>>   are still bugs to address, but my current thinking is that if we get
>>>   stuck like this, we can start to remove the selected mutex blocked
>>>   tasks from the rq, and let them be woken from the mutex waiters list
>>>   as is done currently? Thoughts here would be appreciated.
>>>
>>> * More work on migration correctness (RT/DL load balancing,etc). I’m
>>>   still seeing occasional trouble as cpu counts go up which seems to be
>>>   due to a bunch of tasks being proxy migrated to a cpu, then having to
>>>   migrate them all away at once (seeing lots of pick again iterations).
>>>   This may actually be correct, due to chain migration, but it ends up
>>>   looking similar to a deadlock.
> 
> So I suspect what you're seeing is a combination of the two items
> above. With 128 threads, my deadlock detection BUG() at 50 is probably
> far too low, as migration chains can get pretty long.
> Clearly BUG'ing at a fixed count is the wrong approach (but was
> helpful for quickly catching problems and debugging in my
> environment).

Ah! I see. Thank you for clarifying. Let me check if going to commit
259a8134aa27 ("sched: Potential fixup, not sure why rq_selected() is used
here") helps.

> 
> My main priority is trying to get the null se crashes resolved (almost
> have my hands around it, but took a little break from it end of last
> week), and once I have something there I'll update and share my WIP
> tree:
>   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-WIP

I'll keep an eye out for any updates on the branch.

> 
> To include some extra trace logging and I'll reach out to see if you
> can capture the issue again.
> 
> Thanks so much again for your interest and help in testing!
> -john

 
--
Thanks and Regards,
Prateek
