Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC52B6FEA17
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 05:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbjEKDRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 23:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjEKDRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 23:17:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2102.outbound.protection.outlook.com [40.107.22.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8294EF7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 20:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj/i7A3naMWC3Q9Em3DqSO6B7p6T7XNL9lr0fek7E1ZqMhB9uZl2bhESxb//Xpa/UzYNWNimM39In973q6dtBZPXA0AoiJqSTqSIQy/XG7fnVPpfCnW4uWm2QNx8KESMooADouMQxpiuLSMMQpj2jeSs+gchW3+SsIFfGwzQ3omW+bAqwTaHg0pvPjhCo+i1DGE6MLJzl0GjO4+eprIRwjhIiNS7zvD16ZpStKNd1q6nJEOLB+TzhXLmPkWzafoMDZ5azMjSvSbJ2gmjj1St/SFIUheC0r+G3UO0Oz3fq7r4ZT7n6rgK0nOVDzEGOtMxSl3kKJCBo+xgERmXkxs/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKnc1XEjGO2dd+M2/sy3a+35EH/O1xzx2Cw+uH/nMLo=;
 b=HXHFhqa7TfCNbgab+LuFcQd5XJhmJmFBxE5AKG3CqpUql/pl920sWEz16VXdWbPmqrxxZkeKUDeas/9S/2V/iZivD6uyeWvCjBvS8P2lSeKsj3OqglOcSBx0D9iUmlAmNmb3WC9b3UpNWtuetsvpEwDcN3bI+s6AMK0Imy1+D3pKNx3if7jL2rog0wZeHqzUnZfBnstO07ZJUL88R2783U8Z8uEukbH9BcxxW64VWCnfB9hHnk3Lt5aH71k3hRFqDW++AXz2RNoHSiUtCJFir1bWe77XDTH1R7IJ7XvR0LXmiJq8OZSsR0XbnXgu1Lzja3NkW5RFkWZlF36WXj79LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKnc1XEjGO2dd+M2/sy3a+35EH/O1xzx2Cw+uH/nMLo=;
 b=HElx8I+2K26krXEFz6XSAOV+EIuKB+XYxx0KizKPYrJ5Yy6RuG5PYPN6bEVAyQqmxbnO7hjaNNmxSb5vnjLonjTIZ2cskGgcctQnMoUU8HmGqSIiFFX9CKfWw/TtqCpknwjPtxr40dkC43lzU1aVvxf27wdChWAEdz/f8qUvX0gKPX//mf7rbWdrE/Yy+rWaXzk5dDJ+uBxWLF8nJZozvzFDSALoInXqzlykqlG4JgRkY5fYGAsr2jBns1x2AnLSxeLxEA5/RzNPVflA/02fWEXStPSmWSV5GM4FbuQXngKRKCcs64rJoj+zntNRxwb46YHVUEyoUfmChYtOvwVzXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by DBBPR08MB6043.eurprd08.prod.outlook.com (2603:10a6:10:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 03:17:20 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::cc7e:f565:88eb:67af]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::cc7e:f565:88eb:67af%5]) with mapi id 15.20.6387.020; Thu, 11 May 2023
 03:17:19 +0000
Message-ID: <cc8aa6a4-a187-f3ad-fec9-05f037a3886d@virtuozzo.com>
Date:   Thu, 11 May 2023 11:17:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFD] posix-timers: CRIU woes
Content-Language: en-US
To:     Andrey Vagin <avagin@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Emelyanov <xemul@openvz.org>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <878rdy32ri.ffs@tglx>
 <87v8h126p2.ffs@tglx> <875y911xeg.ffs@tglx> <87ednpyyeo.ffs@tglx>
 <CANaxB-wV9iUT6=Y9nZCWbJhiscMrnAQh4fUXs7Tb8pr=-HwSYQ@mail.gmail.com>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <CANaxB-wV9iUT6=Y9nZCWbJhiscMrnAQh4fUXs7Tb8pr=-HwSYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0080.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::20) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4989:EE_|DBBPR08MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f3243c-1b88-4f5a-07c4-08db51ce3adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCzEZyyQHwPmCmuts4r6BkPUFGxrbNcIl4HBdeh3vyyBb4OkzHxm88TUou+6inc2cTve61vWYRNqwA5x6ma35QNnZoBCEJjd2h5YAMFY4ofJb6TLKUX5pMTtdx3Kn7MCRCG5cRIUPj173eB9Gx6CbQq+6nhAYYxwOspL5Yz70I8uCsdTw5atZSfVhJAcecAzBJnjjuISxEU7rORuWeACBAwuN1R4/5EBhNlpYYB3gv3w55F3bKCrSdErYCYo8ytUmYO7V7NSPt8FGyY3NFt9ftmxasjBxTXM3d5aNQTYTUa8SaMu/RN27EI+uvngyBGBLALMnGhr40m0Agua5e5OBACMWBkX9v8ldMy1E9gOiylDwSmItTo45Ag52n/GoShGvunepPLRsTGYEaXhe65zLuyeawAB6vfp2s5m0x4u7wzaIepQ4hp9th40QKMBXBhGYn+I9U+3MdVhnf5bo3IBVHa9hdORsr39SMrFQUaU/b1QLBBDKuI19ogX3CUhai/6PVr7hxC4e7ltOGsxC2+v15nLYy5q5w3Og2VvVWSuFaYc3FCi9k6QaBwgZU+DDASUaht3NBOh1bbw+4zCJt1zDOZx09l+7eUjjyv8pRsajxySbMSKVN+QUUOcKJJQgi5w6bJmaaA5yrZSgkUNzDGjjgnunMiJC7ZA+JXdcLYK3PGRG7nExrN7X6iXClgV1iAN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(39850400004)(396003)(451199021)(54906003)(110136005)(478600001)(31686004)(7416002)(86362001)(966005)(6486002)(6666004)(31696002)(316002)(66946007)(4326008)(66476007)(66556008)(83380400001)(36756003)(2616005)(8676002)(41300700001)(38100700002)(8936002)(186003)(2906002)(6512007)(5660300002)(6506007)(107886003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1NHN3hqMGdnV0JYalg2Tm1YeXBJN2pqd3FUblprYWdVQUwzT1Y0TU5WL2Nn?=
 =?utf-8?B?YjFuSGhGK3pLZUNzRGV1a0RRZTZ2VkJaRGdTbjY3dEFqODBOcFlnZDUrSzdX?=
 =?utf-8?B?akRyeWUxY2RHOXZUcWJ4bmZBenAvZzVUcEVOSEdLQjFEcCs0QVIxMmUvdThJ?=
 =?utf-8?B?YVRNb2QvVmZrcXZhVVJFclBRdzhPSlBDdU54MERvZTBvLzJBRE5meTZOUHc1?=
 =?utf-8?B?UXdXUU9vVVAxRE1uTFJzeDJ2eXlCWlJobjJQclQvUUtPTnpZUDk4SnI4bWFO?=
 =?utf-8?B?bnp5NjRBT0lycHc4Uk16WXhGTDNWd3htK1pWYkJ2K0o4a1p0c2M4dEFPRXFp?=
 =?utf-8?B?L0NBaW1XS3Q5RXJDSlJjOHpONDVUSHRSSkM3SENDU2dUKzUwUUtPSGVKTitx?=
 =?utf-8?B?cFZaR3BSR2xVMVFwTUJLeEdHSzN2TG1PaFhoemEvcllHWWYrd0hLb0tyeUpv?=
 =?utf-8?B?cFZIc0ZrS1lWaVg3eVBqdXBTYWk4RVo5N2RGRnV4dFlSTXV3cXNzWWViVGwr?=
 =?utf-8?B?eVdCRWZSb3g3T3hraHRCa3VMblhHVm5xMTlmcEdpaG0zc2RZMGFNUnpZYkgz?=
 =?utf-8?B?SWdqU3FNcGhTcWVqSnNNMis2TUxFdXJNUzRQNys0Vk1EWW5VYUhISWhpckdm?=
 =?utf-8?B?VWczKzlFY3JpQ3ZPdkR4eTI1SU9ldmltTUlXQkxlN3pKNGRqdWlvcmRHQjZm?=
 =?utf-8?B?bG5wY2FHbU03QjQ5T2FLaTNHcGhlSHR1Zmd6Qy9QMmNvWDg5d2FsSnB1dGZs?=
 =?utf-8?B?WGF3Y1BGSkVqbGVZVjJ2Q2RwbFp5OVlZb3EzZE5xeUx2aDVDallaYUlGdWI5?=
 =?utf-8?B?eFpBMXh1OWlxaVlPR2R6L3ZyNVZ4VElSMSs2SkI4eitjYXZreWR0QUduUXhl?=
 =?utf-8?B?VkxrT3h6YllVOGIzNzRVQmlUdEJ6SlJBa2NMZnRHTUJ3SE13Zk94RmVubmU4?=
 =?utf-8?B?NFRiZEdOOFJOY2hoK1h0Z3lKZHc4SVVwRyt4a01IWjRySTBuSlJiSEFmQnB2?=
 =?utf-8?B?d1dZOHhpN2I3WTlBSkRCTGhCYWUzYXBuZDRId1NreG1udDFXRUtySzJDQ3hX?=
 =?utf-8?B?ak5ERkE3L3d3TitaWE9sbmFBYlJSRHVoS09vZ0IyLytJL24yRTM3TTZHZXVx?=
 =?utf-8?B?K3R6YUtTSW1sd05rRFhnNWVUNjY3V2tPcE11Yzh2WmgvaXo1QnB1aFBUWVRw?=
 =?utf-8?B?b3lBQVJvMzVNVnNiTGVMZlFVOGw0KzVYTUFRRm8xQ1VETW9BQ1dyYUZSaTlo?=
 =?utf-8?B?RHZSQ2hEcEFKcW1iZXdOQmF1VXlrNmRLTXQrMElUb1MrQVZJaWllRGpMS2NU?=
 =?utf-8?B?a0s4YUhodGdrTnJIM1U1dC9TM2F5MkFQcnJnVnVabUpWQ2VxQU1ibTFoL3dJ?=
 =?utf-8?B?YzJwWDRETHlTOWVBbVIzb0dhcTJYeWRaY0JTanVJQjlHaEFoOC93VjRDd25Q?=
 =?utf-8?B?aWlBUDN5TjZWS0kyODlGZFc4WWJibE00TEZXK1p0Y1ZXRSsybkZPVWRDOCtp?=
 =?utf-8?B?bmczZGwrblVKWGNLbnZDMlYzYWtVVWU0Nk9sbEgzL0NKYXVrbnAybVFaUm1Z?=
 =?utf-8?B?bDNWcVhPWVFIS3djSElKQWZqUW9rbUVYYzJ1RXFTMEp3eWVoUzRGeTJQUDEz?=
 =?utf-8?B?cUJMWXlSVEZZc0lNK3pPWDZhbjFjcGpWVHY1NzZQbVVGL0hRNGRZVGZmVUI1?=
 =?utf-8?B?R01GTUkzT0k2ektwQ05TcytlSXNEUDZYeUZZZmN2NHErb1gxSnNYclpFZE41?=
 =?utf-8?B?Q21RekpobnpQMnVzWlZjWVRLdmpWTGowNG1rTkV2Q1hPR0haOTVPWGErMkVJ?=
 =?utf-8?B?Z1MvREVUYjhCSjhIeGNzSDZLVUs3QWFJMzBKd0JCbnIvc2NVUzBNdnpRbXpD?=
 =?utf-8?B?amJTWFg1ODFubmdUL3EzT2Q2NE5DcWZndUZldFVVRGF6SlZmNGN6NVZFS1dk?=
 =?utf-8?B?OHZwTU8rUElWREtyNXIvS1NiMmtTQnF1eVZxWTd3b0hkKzA2MWtkR0FnYVBM?=
 =?utf-8?B?Qm8zZUFKaE1mZUc3NlF4NXM2M3NvY2JyazV5VU1YK3ZnK1MxU1YxQlZ4S3FC?=
 =?utf-8?B?V0NyMTg3NTRhWUJwV0huNEsvV051Z3VnbHc4anY5dFhvbUovdkszYW9NWFVv?=
 =?utf-8?B?ZGZ6SW5zS1dySGQ0d1VZSW1odlBONGxUNVpIQmdreEt6V1R0NUJJcFVldU5P?=
 =?utf-8?B?WGN6aEtzbnZCbnpuUXlBOGRmcGZNVk9aK1ZSMThoTFU2TmVPRFppMG0xVlhF?=
 =?utf-8?B?T0NTRzBvcGxBYlNrU0JQMXFKODlBPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f3243c-1b88-4f5a-07c4-08db51ce3adb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 03:17:19.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLGzFtJ2wF+xurBWRfLs0yLNePZ5RiFEwm3/ZiX8ur2/pGvbG3OMHwGi3kaiWrbTYZCSjPFnypYhE4KBxTIDHsZF+6qlu4EAnYN9/VmXYxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6043
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.05.2023 16:16, Andrey Vagin wrote:
> On Tue, May 9, 2023 at 2:42 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Hi!
>>
>> This is a summary of several mails so that the CRIU people have the full
>> picture.
>>
>> A recent syzbot report made me look at the timer ID management, which
>> was modified 7 years ago to accomodate CRIU:
>>
>>      5ed67f05f66c ("posix timers: Allocate timer id per process (v2)")
>>
>> and introduced that reported issue along with a bogus loop termination
>> problem. See
>>
>>      https://lore.kernel.org/lkml/000000000000a3723305f9d98fc3@google.com/
>>      https://lore.kernel.org/lkml/20230425183312.932345089@linutronix.de
>>
>> for details.
>>
>> The intent to make the timer IDs per process is definitely correct, but
>> the implementation is beyond suboptimal. I really regret that I did not
>> catch this back then when picking those changes up.
>>
>> The way it works is that each process keeps a 'next_timer_id' which it
>> uses to allocate the next timer. That allows CRIU to reconstruct timers
>> with the same ID by walking the ID space via
>>
>>    do {
>>       timer_create(&timer, ...., &id);
>>       if (id == original_id)
>>          goto success;
>>       timer_delete(&timer);
>>    } while (idspace_not_exhausted());
>>
>> That works by some definition of works, but it is problematic in two ways:
>>
>>   1) As the timer ID space is up to INT_MAX, a process which creates and
>>      deletes timers frequently, can easily move up close to the INT_MAX
>>      id space over time.
>>
>>      If such a process is checkpointed and restored, then the above loop
>>      will run for at least an hour to restore a single timer.
>>
>>      And no, this is not only a hypothetical issue. There are legitimate
>>      scenarios where threads are created and the control thread arms a
>>      posix CPU timer on them. Such threads can be torn down on a regular
>>      base due to thread pool consolidations. As CRIU does not happen
>>      every 5 minutes it's not completely unlikely that such a process
>>      surives quite some time on a particular host and thereby approaches
>>      the ID space limit.
>>
>>      Sure we can restrict the ID space to a way smaller number so the
>>      search wraps around earlier, but what's a sensible limit?
>>
>>      Though restricting the ID space has its own issue vs. backwards
>>      compability. A process which created a timer on an older kernel with
>>      an ID larger than the newer kernels ID limit cannot longer be
>>      restored on that newer kernel.
>>
>>      Aside of that it does not solve the other problem this created:
>>
>>   2) That change created an user space ABI, which means that the kernel
>>      side has to stick with this next ID search mechanism forever.
>>
>>      That prevents to get rid of that global lock and hash table by
>>      sticking an xarray into task::signal which makes a lot of sense in
>>      terms of cache locality and gets rid of the extra timer list
>>      management in task::signal. Making this change would be very useful
>>      to address some other issues in the posix-timer code without
>>      creating yet more duct tape horrors.
>>
>>      Such a change obviously has to aim for a dense ID space to keep the
>>      memory overhead low, but that breaks existing CRIU userspace because
>>      dense ID space and next ID search does not fit together.
>>
>>      Next ID search is obviously creating non-recoverable holes in the
>>      case that timers are deleted afterwards.
>>
>>      A dense ID space approach can create holes too, but they are
>>      recoverable and well within the resource limits, because the process
>>      has to be able to create enough timers in the first place in order
>>      to release those in the middle.
>>
>>      With the next ID search brute force recovery is not possible on a
>>      kernel with dense ID as there is no way to create all intermediate
>>      timers first before reaching the one at the far end due to resource
>>      limits.
>>
>> So because of that half thought out user space ABI we are now up the
>> regression creek without a paddle, unless CRIU can accomodate to a
>> different restore mechanism to lift this restriction from the kernel.
>>
>> Thoughts?
> 
> Hi Thomas,
> 
> If you give us a new API to create timers with specified id-s, we will
> figure out how to live with it. It isn't good to ask users to update
> CRIU to work on new kernels, but here are reasons and event improvements
> for CRIU, so I think it's worth it.

I agree, any API to create timers with specified id-s would work for new 
CRIU versions.

> 
> As for API, we can use one bit of sigevent.sigev_notify to request a
> timer with a specified id.

Yes, I agree, this kind of API is a good option.

> 
> Thanks,
> Andrei



-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.
