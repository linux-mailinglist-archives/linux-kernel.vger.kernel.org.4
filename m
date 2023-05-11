Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BC56FF5DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbjEKPZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbjEKPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:25:37 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2128.outbound.protection.outlook.com [40.107.249.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BB626AE
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F42UOXAtSlHAQoaVK6rEBbRHCj7MQTNLEUWTiceMqxA026BQJAMDCnLUAJuHKMeXI66iTIsZajN0IhSm3x1ZIx6IeRrlRDl4Qa+TwtJHYjMYK2oL99r46j2h2JAqOSmI0YQzwG0jkTUiwMi6wlYzYTwHp8TGhZEbefx6e8tFnQEU56rLY5NCYZnTYDl3A0WeeK8Kwirev/jGO3HV+mgBN8HdL5rRcXBzn8h6FNX7tH3sVi35KLQ4KMOHcmgANwezX4IY+stc0rS4Mdwhs4aXVccsT3QWNkNAEgtIFdloiWzRCRE3x+Y0QOA1JKP5XQC2/fUwcWNoXw2+l0kbDwciAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCfJ0Ze4aJwGse6g062/LUharA11r5FQ0uGpVGliIYc=;
 b=Fa+em7GoVOvC3NPotBCwhwFansEkBujtOCCW+v3tpZIAQ9X3K0Y5+uTz9eY1Hn6y+HsmFlDvMiLiaaVrxhWFZQTliwpsGfJyQh52XkcmX6vhUae1/fHeiSA/UWGUj68Uq71JmLSEogiu9A923/jjwD9BP8ePWHYLOdpBqGARDkYGX39wX42QMNo1eppbKUz2ZCuv1kaaq0JaLSTKkDuEjr5Il/wY58XdXaDt52e6HLYR+kAxWjPqVTaLuSv24Ugi2hp/IKYTZCMc6BgibxyUX/4wumRm5rMxAthp7nlSqL7jyt1gIDhyWhzykMisDJs7x+83FJL3uaOsfGrPJ0YKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCfJ0Ze4aJwGse6g062/LUharA11r5FQ0uGpVGliIYc=;
 b=CahDygKyPna9mRw79aNHSohjWaVx3KjqfpBaM8f65VFd7Ad3JRmXRNQqIWX0Oyh6HiiPIUlWyew4/VX295h45bnPIhJ5nPWv3eDYnuI/Ijjy4BVNj2C6QKIAl+qxEgSpCP3mBxMzehVHSUG3hquHdhMpFJiMIR8wOk3Aa6owT/6RHhdhzaNNSWdza1K3YjEpSeAedvqBT3M8zMcmnOVo89VBsqb7FPuF5aaNmxiiLwnxGfPsN8DRGJ3plclsd0H1mW5A1eBoACFup5vsDphhPgBlPvr4IVgw8RLb5Nmom0J9bhSEX/rc+cZ9NNfnNsEJ8TE1uT51kJnz5Ahbe3MesA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by AS8PR08MB9839.eurprd08.prod.outlook.com (2603:10a6:20b:614::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 15:25:26 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::cc7e:f565:88eb:67af]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::cc7e:f565:88eb:67af%5]) with mapi id 15.20.6387.020; Thu, 11 May 2023
 15:25:26 +0000
Message-ID: <00807b2e-ecba-c133-0c54-065bd6e24156@virtuozzo.com>
Date:   Thu, 11 May 2023 23:25:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFD] posix-timers: CRIU woes
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrey Vagin <avagin@openvz.org>
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
 <cc8aa6a4-a187-f3ad-fec9-05f037a3886d@virtuozzo.com> <87r0rnciqo.ffs@tglx>
 <c25b958d-f843-41d1-7b68-5d069f5c5121@virtuozzo.com> <87ilczc7d9.ffs@tglx>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <87ilczc7d9.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0082.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::22) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4989:EE_|AS8PR08MB9839:EE_
X-MS-Office365-Filtering-Correlation-Id: 76143698-41c2-47d2-8305-08db5233f1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qctHZtQO5FRa++oN5T1HA0oxE3FsRk93cLxOW9cbJCxNSsNgI0SHahTdd5bI+I1KAiWbhBLpl3yuTRPvlwsXdDmgOZqalEl6EOfaRhdUwcwORNe11wzwppgAedwhErWAMwBqGmUtw71a5cQAavqaAcHd167+i+yxhSTwNucK2ub8EivpZjBTpFKsV5UEykGe7eFxosVMHZEaBa0dmkIheixOQYDCo7hQboF7QidXGuRBLpUtKMyrbd74aa/jnQ+ht4kodDK01BpQSbsgHh2SxDOgsEqxnkcaPCPdWpiJ5T9sK+OCO5Z1knsOF0yTvjP+fUSVeUNGwzcB5WAbr6qZKcKiOb8JIevuX9HgbqSEYLpKTvp4iRmvXaDvPq9VRxyJYctmfn+Z0MJ0OpNXUa6ETfNVr0Mwbo3quTZskdDJry1HMr1x236DZShPOhB4ZL2IXWAOsvNi4TnMqwz1LSQO4N2OSBSWbeEpedBF/HpAHBOaV6aAUzQGYDpv1ZT8nU19ZTHO/kWyJ29wvkCxjw9w72n5kPgpppXvS9SX/FYSu6P+5l5Sye+3z9xD8QiAIe3krUhRsuJhW2Lrw2QJDx+b2Oj8UOOEl1+LWeQ8PQCupsjy8WxJRwrcjsbqh+MnrjQMmHJPiyHBufMeEHUCeIGGyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(376002)(396003)(366004)(136003)(346002)(451199021)(186003)(31696002)(110136005)(478600001)(86362001)(54906003)(36756003)(6486002)(966005)(6666004)(38100700002)(7416002)(8676002)(5660300002)(66556008)(66946007)(8936002)(66476007)(41300700001)(316002)(4326008)(6506007)(6512007)(53546011)(2906002)(107886003)(31686004)(83380400001)(2616005)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akthcDlXaW1WaTlHck1mQzNOaEJGcjFRVFBnVUlXbU8zaW9QdSsxZWdMN3dy?=
 =?utf-8?B?UzhkWjFUUW54MU9RSUNkT1VTKzF6ZEhtZEpNR0JPbnJ5aU40QVF6akhNZnlU?=
 =?utf-8?B?a0FwVHc4SGphRFZIRXQ0SWJqcWI4dVRlc0RGdlM4czhxRHYxOE9ia1BmVStS?=
 =?utf-8?B?d1JCNURHbFk5cGZod0c5S3RZNVFlWndhQStwMjVZclY4SHNic0VDNmNVNHUw?=
 =?utf-8?B?R0dzTTF1VHhobXNMOTB6cEhINDQzdXRCK0c0UlVubGllU1FKOUF2RVpGa1JG?=
 =?utf-8?B?RFg3SE1wMzUzTGlTNHdCUVRlUERUdmptYmozZ0piSHBkOUtEN0RnY1dmNDJ4?=
 =?utf-8?B?WENscStmeWMzUlNZaDlGckRsbVFrTXdUTUU5TzFpNlJRemZiRzl2S0FOS2Za?=
 =?utf-8?B?ZExUKzZHVWZ6SUJBM0FQKzdPRXNBVENwRk9ybGRxQ2FCODZtalZVL05teElT?=
 =?utf-8?B?ajFlTkJScFc2NXZQLzkzWUFVL3JQdTE5VGlnUlF4VlZCdTdSSUhRZ1h1d0Nn?=
 =?utf-8?B?UG5jU05UNW81dTBoMERnYis3WmRoUHVZRHFiT1M0SG83TGVzQzlaOGkyY2JV?=
 =?utf-8?B?V3FjM05jemN3OG14K3dyZjVJY0J6djNOdFBSdUhTV2F3VFdKNm4vb1JPZWps?=
 =?utf-8?B?dGUxSE14enNrNVFhQ3NOUjBtMmFWVk0xU1ZGSVluV2NUOC93S1pVNEw4dlRk?=
 =?utf-8?B?Y1VxQ3krRWlzWUczaE1ZUVFpZjdKNU5RWDM1U2pEK2twakZpUEdMZlQrN3Vr?=
 =?utf-8?B?KzY1QUZEUDMzYXg2SWNGOG5FR01vZC9ZYXV1Sko5ZGJWMVVtYk1hM2tIMVhO?=
 =?utf-8?B?RXNNVG5jV3RkeU9samxqKzVpVkNucHkwNGtQYzdETjhVbmR2WlRqbXJyZXc2?=
 =?utf-8?B?N3RIUnRxUVpqcXlLWERYU2hYSGpoV2JqWS9EbGFucFRkNERxTVJ6Mnd4emx5?=
 =?utf-8?B?UUJaUEEwQUdPd21mOXNXVld3SGx6bzM4Q0xtQk5IZlY3eVN3a3BFbXFsNFN2?=
 =?utf-8?B?c1M2NUlERTZXTEhhc3ZxRllTVi9rQUpwd3g3UE1jYkZ2Z3crZzZ0cEQ2Ukxl?=
 =?utf-8?B?K2gyM1hjWnBnSThSNTR4NWtxYUtlamgwZU0reVZKbVo0endxa2RmL1pCNFd5?=
 =?utf-8?B?aXVkQ0FORGJSTG4rMktzSmNiT1FBcFZFVEJESHlPaVpvaGdtM3ZUekozeWFR?=
 =?utf-8?B?dWRsUlZLL0xxelVUZUQ1d1I1Nm9mam56V2tjTXZ5Z1Y1TGxreDJLWVZhOUhx?=
 =?utf-8?B?UFFURGhEWnEwSmJhZlFYNTZSekNwVmV5UnBMYWhWa0hrbmxENHZUc2x1OTJm?=
 =?utf-8?B?MXVXUXZOM25PaWphTjB3bzdheXRQaG9sZjhpNHZMS2paRytta1poNmxDWjJX?=
 =?utf-8?B?TnFFdU9qQXE4aWw1YnBEeUNNeFNPUy9UU1hUNVVZY3ZWY2pYSVJHYWZHb0pH?=
 =?utf-8?B?bmF3NlJsbkR2U2VPcERvd3FXK3l0ZzlTS2RmV0ZHajVFQlhKZWZ6MzZ1SC9v?=
 =?utf-8?B?V05PVzBLRWIzSHo1aU5QeVNGanE3R2lLVVBUcHJZZi95K25iakRUcVFjMkpO?=
 =?utf-8?B?eEtVbUNETW5teHpjc1RPeG13MEdLMUIrcTNUUWRLQU91L00yVmx1ekZaYTdY?=
 =?utf-8?B?VUFoWUlvYm1YUDNpYnVYZU1EQW1vVlpRellOcVczLzNTdG80Rkc2bExLOW9o?=
 =?utf-8?B?Uk93QVB2Z1E4TC9uV2NvcTdtRG9CK3ZKWVA2cGoxOVFHODFvOU5CRytaaFhI?=
 =?utf-8?B?NTkyY1hpcjNwZERNVFhWenhkd1dGUTgzSERITFdCaWEvenhZdUc2eHNGSlVy?=
 =?utf-8?B?VnVmQi9tSnBUZVRNdFdSWnlqejhHTk4xMmp0bnlKRkkxZmFtT1VCMjB1bUt1?=
 =?utf-8?B?MVpKVlk4aU1ObVZRRjJJRG1FWmdJaFd4czIxTzROTjNGUDRGQkVyTjhMZlZt?=
 =?utf-8?B?dUdFZlk1WVJhZExsVUh0aDhObnY0UFdJYlVLVFZYbUQ1aDFtc0hYVkRZNWE2?=
 =?utf-8?B?WVlDekozNm1lQVhqVktZaEtWRU1YbHZlYzNwQm1POXVGeEdFMVBnc1VEQVZG?=
 =?utf-8?B?ZlhzbmhRanhRd1ZBRVBYYUhQK3REYS92eGxLSFhyQStJQTJNVG9NUFNCRUFN?=
 =?utf-8?B?eWtwcjhuN3VtQ2REOTlXQ05lWkd1L1Z2eTlhYTFNRUZDSkFqL24rVTlUV0hB?=
 =?utf-8?B?K3g5T3J4NDFmVXlvR3hsTXkxcVc0TktoVzYxZGVLaG1Ca0NyTmFWUkFvVWpz?=
 =?utf-8?B?L0JhVk5RZkVtbm5Qc1hVWC9PWTJBPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76143698-41c2-47d2-8305-08db5233f1e8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 15:25:26.1527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xu4qjeWOsY3+ZN3mNv81G82SIJENpMkdAWZuLkx1aD2YuLFtnUA9mkemgw2Cd6h07bEjjTUX0pQNIoAXDDQHxhAL5PKGtMzGtH+DBrWq8zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9839
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.05.2023 21:42, Thomas Gleixner wrote:
> On Thu, May 11 2023 at 17:52, Pavel Tikhomirov wrote:
>> On 11.05.2023 17:36, Thomas Gleixner wrote:
>>> On Thu, May 11 2023 at 11:17, Pavel Tikhomirov wrote:
>>>> On 10.05.2023 16:16, Andrey Vagin wrote:
>>>>>>
>>>>>> So because of that half thought out user space ABI we are now up the
>>>>>> regression creek without a paddle, unless CRIU can accomodate to a
>>>>>> different restore mechanism to lift this restriction from the kernel.
>>>>>>
>>>>> If you give us a new API to create timers with specified id-s, we will
>>>>> figure out how to live with it. It isn't good to ask users to update
>>>>> CRIU to work on new kernels, but here are reasons and event improvements
>>>>> for CRIU, so I think it's worth it.
>>>>
>>>> I agree, any API to create timers with specified id-s would work for new
>>>> CRIU versions.
>>>
>>> The real question is whether this will cause any upheaval when a new
>>> kernel meets a non-updated CRIU stack.
>>
>> Creation of posix timer would hang forever in this loop
>> https://github.com/checkpoint-restore/criu/blob/33dd66c6fc93c47213aaa0447a94d97ba1fa56ba/criu/pie/restorer.c#L1185
>> if old criu is run on new kernel (without consecutive id allocation) AFAICS.
> 
> Yes, because that "sanity" check
> 
>       if ((long)next_id > args->posix_timers[i].spt.it_id)
> 
> which tries to establish whether the kernel provides timer IDs in strict
> increasing order does not work for that case.
> 
> It "works" to detect the IDR case on older kernels by chance, but not
> under all circumstances. Assume the following case:
> 
>        Global IDR has a free slot at index 1
> 
>        Restore tries to create a timer for index 2
> 
> That will also loop forever, unless some other process creates a timer
> and occupies the free slot at index 1, right?
> 
> So this needs a fix anyway, which should be done so that the new kernel
> case is at least properly detected.
> 
> But even then there is still the problem of "it worked before I upgraded
> the kernel".
> 
> IOW, we are still up a creek without a paddle, unless you would be
> willing to utilize the existing CRIU bug to distribute the 'deal with
> new kernel' mechanics as a bug bounty :)
> 
> Fix for the loop termination below.

I've prepared a PR with your patch (with minimal change) and added you 
Signed-off-by:, hope it's ok:
https://github.com/checkpoint-restore/criu/pull/2174

> 
> Thanks,
> 
>          tglx
> ---
>   criu/pie/restorer.c |   24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> --- a/criu/pie/restorer.c
> +++ b/criu/pie/restorer.c
> @@ -1169,10 +1169,10 @@ static int timerfd_arm(struct task_resto
>   static int create_posix_timers(struct task_restore_args *args)
>   {
>   	int ret, i;
> -	kernel_timer_t next_id;
> +	kernel_timer_t next_id, timer_id;
>   	struct sigevent sev;
>   
> -	for (i = 0; i < args->posix_timers_n; i++) {
> +	for (i = 0, next_id = 0; i < args->posix_timers_n; i++) {
>   		sev.sigev_notify = args->posix_timers[i].spt.it_sigev_notify;
>   		sev.sigev_signo = args->posix_timers[i].spt.si_signo;
>   #ifdef __GLIBC__
> @@ -1183,25 +1183,27 @@ static int create_posix_timers(struct ta
>   		sev.sigev_value.sival_ptr = args->posix_timers[i].spt.sival_ptr;
>   
>   		while (1) {
> -			ret = sys_timer_create(args->posix_timers[i].spt.clock_id, &sev, &next_id);
> +			ret = sys_timer_create(args->posix_timers[i].spt.clock_id, &sev, &timer_id);
>   			if (ret < 0) {
>   				pr_err("Can't create posix timer - %d\n", i);
>   				return ret;
>   			}
>   
> -			if (next_id == args->posix_timers[i].spt.it_id)
> +			if (timer_id != next_id) {
> +				pr_err("Can't create timers, kernel don't give them consequently\n");
> +				return -1;
> +			}
> +
> +			next_id++;
> +
> +			if (timer_id == args->posix_timers[i].spt.it_id)
>   				break;
>   
> -			ret = sys_timer_delete(next_id);
> +			ret = sys_timer_delete(timer_id);
>   			if (ret < 0) {
> -				pr_err("Can't remove temporaty posix timer 0x%x\n", next_id);
> +				pr_err("Can't remove temporaty posix timer 0x%x\n", timer_id);
>   				return ret;
>   			}
> -
> -			if ((long)next_id > args->posix_timers[i].spt.it_id) {
> -				pr_err("Can't create timers, kernel don't give them consequently\n");
> -				return -1;
> -			}
>   		}
>   	}
>   
> 
> 

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.
