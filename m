Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F435B4682
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 15:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiIJNfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 09:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJNfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 09:35:19 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2047.outbound.protection.outlook.com [40.107.115.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9787123BE1;
        Sat, 10 Sep 2022 06:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S58+ZHNtzKFSwTyyNUieVmmMKrwB+w4cCLwfL8rZde5yiL71v5vX0krcHYyZnDYXd+RlAponx4Hi0tc2wRW4dYAt08ju6ZR0QlWNe1Pjz+Y2Ygygbollbw4mRYG13DyL8KH/ls44WffyoYnnOV4TfOErUVRDOz5Ai1CA/Pbjwr2Wlpd/RzQI+k9uKkZ7yc0WOOIt7XBE1jgJT+Mrr5qPf9Pye8xACubpi51uDu91TQnbtBuPNgIk5et7o5ktFYDFOO7bVmojusVxT+28/Vrh/HFf58KIkZhgASXRBJrrtXlmMYHkI0BdFUSr5ALCWrVI9uHiHelWrVy7ccNLCzCDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iubittPx8yJtgWk2LqKIZ3xaAnStDCWSt8IdRl+xutE=;
 b=E9TnqzJdD0Kh8YK5clHOa9YJxNrrlw6cXzEUvdDYniH8KitjcRCT5jDCXJWdWB8AbC90R3DtOa5gcvIqQ7pcv4oniVz5KWB0597XYT8WHYq2tITsbdh3Z79B52Xcb4dY5mJSWmFeSYSjtsayK542kdVD8VptInHKnyW3AdoFW0lz6EBfIDv1xF2LDax422PJ1mcOIvV4Y00ubUjdhI2PqxpFWi4Fi+EC+S6GtfAAfFTL3tDt5y/ikZfJwswVvFjGlzuyUlGt3gEtT1bnoXOwmpQk4UOzHEYt0v2brXfEyaLm4Wn04y43RCaDVTwt6SDkrHcElfeC3OTnUEZp1Hp8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iubittPx8yJtgWk2LqKIZ3xaAnStDCWSt8IdRl+xutE=;
 b=urXd+2wQNhUjAGh6XmFTG2NtLlzRKTAjohk++cwp9pCZOZS3XfBLA4QW8cOkCwFPZI4VXdrjChkh4wi7e5cPlIUOGsKQv9CvOqDUqltfqHetSnN1Ct3M9FM4cbRfz9nyGjL4hIZSgyuLq4cujPPr3GB6F5RRZYofn0drHsfa9G3QSQ1SIbse+jJnWlDVLEDWG3WpVL6dPILufiKKnXmGAEP5ETBJi0YvPjvppQBoFJpK7BQaeIP1brYcO00Oouf2EPkBX+FIJrDE3QJ2RadNmfFyP/Y751Pu5MmSBm109MZyz2BY5nEMlKMbQxoRkVRrE9ago5+Tf4CSb4ASp6NV4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8612.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Sat, 10 Sep
 2022 13:35:16 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bc70:d4be:bdc3:4607]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bc70:d4be:bdc3:4607%3]) with mapi id 15.20.5612.018; Sat, 10 Sep 2022
 13:35:15 +0000
Message-ID: <32422d2a-993e-c351-5f0e-788e28b09335@efficios.com>
Date:   Sat, 10 Sep 2022 09:35:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 2/2] Revert "csky: Add support for restartable
 sequence"
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>
References: <20210723161600.19688-1-mathieu.desnoyers@efficios.com>
 <20210723161600.19688-2-mathieu.desnoyers@efficios.com>
 <CAJF2gTR9_SzAm2kPXyP+xJDVmdvM=XSm7kJn_eNq-wQmhLqTeg@mail.gmail.com>
 <2070284546.6496.1627316900287.JavaMail.zimbra@efficios.com>
 <cbd08ae8-4558-60e3-17e4-988e625984a1@efficios.com>
 <CAJF2gTRbn-JiUMiX_s52geJSiTs7qYV3oEkW1+NC8Vwp1YAKvg@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAJF2gTRbn-JiUMiX_s52geJSiTs7qYV3oEkW1+NC8Vwp1YAKvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0428.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::32) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e462ed-cce9-49c6-f5b1-08da93314b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfvYQ1tJjiBx3qV5aPnc8mdWMTRLQWihT+dwTba4woB3FhUe3RrGjVtN8tWRNxwfnP/u+ZVZgaWARLKryhV/494hTgujzhDd8roBnIisq9NanYbce30M1kb6cpBUsu7HTdwqfiWIhL3ICOIyh1u9ce+H94ND0ti5JXJBvtIjLzHz70OGyVQTq/ZTV1M/p+fzco4XJojcHHOUXo/DdhGSwfJuGJjd8ZFAUcq6r9bzNRszyoR4TUn4TrOio4MxJHK8i5GDg0xb7r/lbTQFiPd30nKqZn0hzEHM6C85e/x/KvCtUf5ROtYX9EH5lLp58zoH7po1k0KLSZlQUqnU/WRenuFYuTrQHg+wK/ccuhSF56NKYkpWa4nlvNxeiE19oHgCetrU6uoe/HChxuaahtNadKt2FNfhdbzoggHnbD3JeLS+ZkhyHkalu4r9po847whyCl7tQGAtNev+6F6TiZySQld46FdctZx3R6NhPW/CHeKEx5UwN2nfkYboUk5YUriROjGBEeMoGLr89Nj7vPsMwKyzepJseJj89JWFcKb3ip/ybzop26EdSJ5r47S2f2N6hAapD94R0FuVBd/Yb1+oj7fSivup1roz/hvlOEJcwW1S2zD+OT4mC7UNWlvvMbTbygSZYe6TPR6c0xlpkzu1RcX9x7X/4VnEM6S4NUHUFAUgmXXWRmM46gLs2LymiFIw2SKfWoCC+IW4mHfwSHNkeY3rgWxNYfPrBbA+YDNWCB9G7xbyiOw9NgqP5DHVBCTW3fwYdvog/829hLkT4IGbIA9lf0nNOB0OHOzwgl5skiYEgh73vEumx91+LUCCmrJi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(346002)(396003)(34096005)(376002)(136003)(34036004)(366004)(966005)(586005)(6486002)(86362001)(31686004)(31696002)(498600001)(2906002)(2616005)(186003)(83380400001)(54906003)(38100700002)(36756003)(26005)(66476007)(44832011)(8676002)(66556008)(66946007)(6512007)(6506007)(6916009)(53546011)(8936002)(6666004)(41300700001)(4326008)(41320700001)(38610400001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmRwN0lkeVh0MjRFclp1aXlzcldoUE1WWStuNVh3akgrMXBGVXl6bHRCQUVn?=
 =?utf-8?B?N0JVTUxKL3VBSVliSlZ2bnpuNGFQeUN2ZHptSFZKYW5xay9reHVrRUdLQnVs?=
 =?utf-8?B?WFdscUhnQWYwdjYydWtXYlE2N0NuWmFpQmpBNTRsdkFwYlYrN1daeFRQQlBM?=
 =?utf-8?B?Slg0MUF5SEFEdWFud2J5L2Y3WGMvb1FmdHdTQTZ2MDcyekRwZm95dEZSRGsz?=
 =?utf-8?B?UWh6amx6VHFhSW5NVWpiWGtmM1lmME1wcCtneXFaMWxLRjhtZFZwOW96cGRM?=
 =?utf-8?B?QUdERzNrOXB6TVNCNG5xRkdWaUNSaDBmaVZxUDJmczM3cUJwcVpuYjVMQm1z?=
 =?utf-8?B?bDRKL1JaWlFkQkh6Qmh0WGpBbUdFZE1TbHplMlpJQnVmcWpUem9WM09IQ3o4?=
 =?utf-8?B?cE9sQWRFbXZ2YTB1TE5kSzdhSzZpOS9TYlBQa0x6OVhXRWFtK293VGxFcS9U?=
 =?utf-8?B?TGsvMVhpbzQxS3ZmL01uRjdVNWd6YmVrcHFvUkR0azVIQVJtSEVLeWNmWlor?=
 =?utf-8?B?TCtBU2kwV0tDWi8rOWFyU3pFYlMxZW9Vcys4RFNDcDg5QkFibjBsRTQvakhy?=
 =?utf-8?B?VUZuNXl1dDRWWTlvc3Q4SnpwYVRibXJwRmhJR1E3Z3FWcGgrTmVGdkxTb3Rs?=
 =?utf-8?B?TnFXeWE4S2N1MXBRcndSd21hckJObGd6alZaV0QvNXF2ZjcxOHAxUENVL1JR?=
 =?utf-8?B?ZnYyRjU1NmU3WVpNajc5dnQ0SnluWk02UlkzYmp4amFEbGhMTTB1T25oRWZ3?=
 =?utf-8?B?Z01kK1Mwc1diU3c4T0U3R0h6YWtNU3hpMkl4UnVQUjRaYTNWSCtjYlFVaFhV?=
 =?utf-8?B?UWdVTVhKNFJDb1EyV1FmUjJWNHBPcTFZM2pVcFZveWZ3WnJWU1dwOXNJbUJZ?=
 =?utf-8?B?UFRTbVVGVURRYmcyYzJXVHlaV1o5Tkd5R25GMjROZWxsNnFVQTVGRVFkM1Qw?=
 =?utf-8?B?WGZSSzhlQjNNMFZxTDVVT0xvaFNvekg0Q2VONGUza1dzK3BobXdGajRuaGNK?=
 =?utf-8?B?UythdW9TYkJGbGVOMVc1OHhiVzk3dktPKzhZU2NYaTB2emVaT3pOMHpkWkZP?=
 =?utf-8?B?VExWTlpZUldCTGRUZ3V5Y1FycTlYcENWUWpIWkk1ZDloQlFjeGtPWW1haGxt?=
 =?utf-8?B?dXB2NTFUSFJYQWlsYW04cW9nOXpqeDVUejR6Tmxudkl4TXlIQ0E3aGljdmwv?=
 =?utf-8?B?Q3M1NXdpYldGSEovQVpKWVVKaGJtekF0cEkyZVAzQ3dvNSs3Si9CNzFrSytV?=
 =?utf-8?B?MHNLakhuVEF3YTB4b0NHY04rUVJNelFxWW5nRzdVQnNUVFpTY05ySFBVUURJ?=
 =?utf-8?B?S1lyRm1zaDNNSlFJZ0o2ZDdoQ0hhRUNPMVl1Nkh2MURBY3JVZGNKVGNhd1Zr?=
 =?utf-8?B?L2czdmF1ZWxteW92M2FPbE5yUnVlaGtUYTdhR2RCZ0thZGVrYkxYTDlwN29H?=
 =?utf-8?B?Unk2NXVHcVdVbTNJV1BsUEpTWGo0dWNtYzA3bElzL0ZBU1RnYlB3a3d5OFQ1?=
 =?utf-8?B?bXZHclgvOFlBaG5wRktzUjQ4alorSDJQOGxZT3ZtRVozV0hQQm5FczFlNHBt?=
 =?utf-8?B?R05lMVFEeHk2d3M3c203alE4UFJDVDk1elYra1hCTmFxcVJUMCtCZldNeGtu?=
 =?utf-8?B?a05jUlhPZkViNzdMNHFuWnBYWmNyRVdjTmZ2S1V4cGtlWlh6d0FhMmxwOW1E?=
 =?utf-8?B?bGNmd0dZUkxwY2hwNGg5YWJlQmlYSkZ6RlJ0dmRGSDFmSDdWMGZBOTExUy9B?=
 =?utf-8?B?cjdyVFF0WXgrbGY4N2tqRlpPdkN0eDFWZUFMWFhJVGZuOXplU1ZOVmRsQSt0?=
 =?utf-8?B?RzgyL2dUd3pTSVJlVUV6ZEphbUNYQkJIWUwwemdrUFpTd2JSY05Bb3JPT1NH?=
 =?utf-8?B?dEYxZVJxYXRDREk1alVGUmhMSVZqUTFhNmdrNm4xYUg3dFFjS3BNNk5qUjFq?=
 =?utf-8?B?cmtIc1NjVEt1MEdmampiV0F6ZUJMZTlTOHR5d0lINjd1b1hZRHY0eEs5QlNX?=
 =?utf-8?B?WTdJVFBZaGdJcmt2QWhQTnBORWY3U3Z2bkRtN2hQczh3SDQzR1V3M3dsSGRv?=
 =?utf-8?B?UG5nVUtTNnhKK2t4c2p0UE0yaGhraWNaUXpmR2c1b1JWdll1SlNZc0VKclll?=
 =?utf-8?B?bndUbk9WV3V1d2V0VGI3OFFQUndBbWxHUnlCdHRjcXVhQWVHOUc3VEQxNG0y?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e462ed-cce9-49c6-f5b1-08da93314b90
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2022 13:35:15.8849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6ulb4Dz56LF4dq8LhkTnbpRZ1cB6KwgMRvY4d/3dMUOhiAYsE+0HOXKMZkjKzZLo76gHbIKizODYiesZNLrpaCDAC7wHGO50Jyr8t/QcX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8612
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-09 22:35, Guo Ren wrote:
> On Sat, Sep 10, 2022 at 4:01 AM Mathieu Desnoyers
[
>> A friendly ping after 1.5 year about the fact that the selftests code is
>> still missing for the csky architecture. So there is no way to validate
>> that the kernel pieces that were merged actually work on that architecture.
>>
>> What is the timeline for contribution of the missing bits needed to enable
>> those tests ?
> I would send the 1st version of patchset before 2022/10/30, or just
> revert it from csky.

OK. I can help by answering questions or with code review. I'm not 
fluent in csky assembly, but I'll try to learn as I go.

> 
> 1. a patch for fixup the bug:
> diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
> index b7b3685283d7..434dcf2e8e37 100644
> --- a/arch/csky/kernel/signal.c
> +++ b/arch/csky/kernel/signal.c
> @@ -179,8 +179,6 @@ static void handle_signal(struct ksignal *ksig,
> struct pt_regs *regs)
>          sigset_t *oldset = sigmask_to_save();
>          int ret;
> 
> -       rseq_signal_deliver(ksig, regs);
> -
>          /* Are we from a system call? */
>          if (in_syscall(regs)) {
>                  /* Avoid additional syscall restarting via ret_from_exception */
> @@ -206,6 +204,8 @@ static void handle_signal(struct ksignal *ksig,
> struct pt_regs *regs)
>                  }
>          }
> 
> +       rseq_signal_deliver(ksig, regs);
> +
>          /* Set up the stack frame */
>          ret = setup_rt_frame(ksig, oldset, regs);

Yes, this fix is really needed.

> 
> 2. Add tools/testing/selftests/rseq/rseq-csky* codes.

It looks like a good plan,

Thanks,

Mathieu


> 
> 
> 
>>
>> Here are the required header files:
>>
>> tools/testing/selftests/rseq/rseq-csky.h
>> tools/testing/selftests/rseq/rseq-csky-thread-pointer.h (only if __builtin_thread_pointer is not implemented by gcc)
>>
>> I'm open to suggestions from other rseq co-maintainers on how to best address
>> this situation.
>>
>> Thanks,
>>
>> Mathieu
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
> 
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
