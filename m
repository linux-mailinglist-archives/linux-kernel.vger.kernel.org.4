Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DF769EDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjBVE3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBVE3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:29:17 -0500
Received: from out-19.mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B06305F7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 20:29:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677040152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agkz/dw00xpvUW6PmRfKGKixPZl6EYXBqJcJo64tae0=;
        b=f3UyW+J62PHHOarnl8O+wCHF0aIInW6NlFPb8dwINoncYkl4ums5NRBaHLl+EASGomYtDE
        ZNtXWHGyeOQeVIqZEcW4WBjgFGxmyfROD8Fp8fsOmkIwudYaz6oSIUwkxLcIxf8K1GoFZk
        5ptGn25a5BNuFe8dxPC8XxrIghLVpAU=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
Date:   Tue, 21 Feb 2023 20:28:59 -0800
Message-Id: <2A9C80B2-27B9-483C-B5ED-8195CD6169D5@linux.dev>
References: <20230222003759.GO2948950@paulmck-ThinkPad-P17-Gen-1>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marco Elver <elver@google.com>, Yue Zhao <findns94@gmail.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230222003759.GO2948950@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 21, 2023, at 4:38 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Tue, Feb 21, 2023 at 03:57:58PM -0800, Roman Gushchin wrote:
>>> On Tue, Feb 21, 2023 at 03:38:24PM -0800, Paul E. McKenney wrote:
>>> On Tue, Feb 21, 2023 at 03:13:36PM -0800, Shakeel Butt wrote:
>>>> On Tue, Feb 21, 2023 at 2:38 PM Paul E. McKenney <paulmck@kernel.org> w=
rote:
>>>>>=20
>>>>> On Tue, Feb 21, 2023 at 02:23:31PM -0800, Roman Gushchin wrote:
>>>>>> On Tue, Feb 21, 2023 at 10:23:59AM -0800, Paul E. McKenney wrote:
>>>>>>> On Tue, Feb 21, 2023 at 08:56:59AM -0800, Shakeel Butt wrote:
>>>>>>>> +Paul & Marco
>>>>>>>>=20
>>>>>>>> On Tue, Feb 21, 2023 at 5:51 AM Matthew Wilcox <willy@infradead.org=
> wrote:
>>>>>>>>>=20
>>>>>>>>> On Mon, Feb 20, 2023 at 10:52:10PM -0800, Shakeel Butt wrote:
>>>>>>>>>> On Mon, Feb 20, 2023 at 9:17 PM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
>>>>>>>>>>>> On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.com>=
 wrote:
>>>>>>>>>>>>=20
>>>>>>>>>>>> =EF=BB=BFOn Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushch=
in wrote:
>>>>>>>>>>>>>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
>>>>>>>>>>>>>> The knob for cgroup v2 memory controller: memory.oom.group
>>>>>>>>>>>>>> will be read and written simultaneously by user space
>>>>>>>>>>>>>> programs, thus we'd better change memcg->oom_group access
>>>>>>>>>>>>>> with atomic operations to avoid concurrency problems.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> Signed-off-by: Yue Zhao <findns94@gmail.com>
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Hi Yue!
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> I'm curious, have any seen any real issues which your patch is=
 solving?
>>>>>>>>>>>>> Can you, please, provide a bit more details.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>=20
>>>>>>>>>>>> IMHO such details are not needed. oom_group is being accessed
>>>>>>>>>>>> concurrently and one of them can be a write access. At least
>>>>>>>>>>>> READ_ONCE/WRITE_ONCE is needed here.
>>>>>>>>>>>=20
>>>>>>>>>>> Needed for what?
>>>>>>>>>>=20
>>>>>>>>>> For this particular case, documenting such an access. Though I do=
n't
>>>>>>>>>> think there are any architectures which may tear a one byte read/=
write
>>>>>>>>>> and merging/refetching is not an issue for this.
>>>>>>>>>=20
>>>>>>>>> Wouldn't a compiler be within its rights to implement a one byte s=
tore as:
>>>>>>>>>=20
>>>>>>>>>        load-word
>>>>>>>>>        modify-byte-in-word
>>>>>>>>>        store-word
>>>>>>>>>=20
>>>>>>>>> and if this is a lockless store to a word which has an adjacent by=
te also
>>>>>>>>> being modified by another CPU, one of those CPUs can lose its stor=
e?
>>>>>>>>> And WRITE_ONCE would prevent the compiler from implementing the st=
ore
>>>>>>>>> in that way.
>>>>>>>>=20
>>>>>>>> Thanks Willy for pointing this out. If the compiler can really do t=
his
>>>>>>>> then [READ|WRITE]_ONCE are required here. I always have big bad
>>>>>>>> compiler lwn article open in a tab. I couldn't map this transformat=
ion
>>>>>>>> to ones mentioned in that article. Do we have name of this one?
>>>>>>>=20
>>>>>>> No, recent compilers are absolutely forbidden from doing this sort o=
f
>>>>>>> thing except under very special circumstances.
>>>>>>>=20
>>>>>>> Before C11, compilers could and in fact did do things like this.  Th=
is is
>>>>>>> after all a great way to keep the CPU's vector unit from getting bor=
ed.
>>>>>>> Unfortunately for those who prize optimization above all else, doing=

>>>>>>> this can introduce data races, for example:
>>>>>>>=20
>>>>>>>    char a;
>>>>>>>    char b;
>>>>>>>    spin_lock la;
>>>>>>>    spin_lock lb;
>>>>>>>=20
>>>>>>>    void change_a(char new_a)
>>>>>>>    {
>>>>>>>            spin_lock(&la);
>>>>>>>            a =3D new_a;
>>>>>>>            spin_unlock(&la);
>>>>>>>    }
>>>>>>>=20
>>>>>>>    void change_b(char new_b)
>>>>>>>    {
>>>>>>>            spin_lock(&lb);
>>>>>>>            b =3D new_b;
>>>>>>>            spin_unlock(&lb);
>>>>>>>    }
>>>>>>>=20
>>>>>>> If the compiler "optimized" that "a =3D new_a" so as to produce a no=
n-atomic
>>>>>>> read-modify-write sequence, it would be introducing a data race.
>>>>>>> And since C11, the compiler is absolutely forbidden from introducing=

>>>>>>> data races.  So, again, no, the compiler cannot invent writes to
>>>>>>> variables.
>>>>>>>=20
>>>>>>> What are those very special circumstances?
>>>>>>>=20
>>>>>>> 1.  The other variables were going to be written to anyway, and
>>>>>>>    none of the writes was non-volatile and there was no ordering
>>>>>>>    directive between any of those writes.
>>>>>>>=20
>>>>>>> 2.  The other variables are dead, as in there are no subsequent
>>>>>>>    reads from them anywhere in the program.  Of course in that case,=

>>>>>>>    there is no need to read the prior values of those variables.
>>>>>>>=20
>>>>>>> 3.  All accesses to all of the variables are visible to the compiler=
,
>>>>>>>    and the compiler can prove that there are no concurrent accesses
>>>>>>>    to any of them.  For example, all of the variables are on-stack
>>>>>>>    variables whose addresses are never taken.
>>>>>>>=20
>>>>>>> Does that help, or am I misunderstanding the question?
>>>>>>=20
>>>>>> Thank you, Paul!
>>>>>>=20
>>>>>> So it seems like READ_ONCE()/WRITE_ONCE() are totally useless here.
>>>>>> Or I still miss something?
>>>>>=20
>>>>> Yes, given that the compiler will already avoid inventing data-race-pr=
one
>>>>> C-language accesses to shared variables, so if that was the only reaso=
n
>>>>> that you were using READ_ONCE() or WRITE_ONCE(), then READ_ONCE() and
>>>>> WRITE_ONCE() won't be helping you.
>>>>>=20
>>>>> Or perhaps better to put it a different way...  The fact that the comp=
iler
>>>>> is not permitted to invent data-racy reads and writes is exactly why
>>>>> you do not normally need READ_ONCE() and WRITE_ONCE() for accesses in
>>>>> lock-based critical sections.  Instead, you only need READ_ONCE() and
>>>>> WRITE_ONCE() when you have lockless accesses to the same shared variab=
les.
>>>>=20
>>>> This is lockless access to memcg->oom_group potentially from multiple
>>>> CPUs, so, READ_ONCE() and WRITE_ONCE() are needed, right?
>>>=20
>>> Agreed, lockless concurrent accesses should use READ_ONCE() and WRITE_ON=
CE().
>>> And if either conflicting access is lockless, it is lockless.  ;-)
>>=20
>> Now I'm confused, why we should use it here?
>> Writing is happening from a separate syscall (a single write from a sysca=
ll),
>> reading is happening from a oom context. The variable is boolean, it's ei=
ther
>> 0 or 1. What difference READ_ONCE()/WRITE_ONCE() will make here?
>> Thanks!
>=20
> In practice, not much difference other than documenting shared accesses.
> Which can be valuable.
>=20
> In theory, when you do a normal C-language store, the compiler is within
> its rights to use the variable for temporary storage between the time
> of the last read from that variable and the next write to that variable.
> Back to practice, I have not heard of this happening for shared variables.=

> On the other hand, compilers really do this for on-stack variables whose
> addresses are not taken, which is one of the reasons that gdb might say
> that the variable is optimized out when you try to look at its value.
>=20
> So the potential is there, and if it was my code, I would therefore use
> READ_ONCE() and WRITE_ONCE().

Got it, Paul, thank you for the explanation!

It seems like the resolution is that putting READ_ONCE()/WRITE_ONCE() across=
 knobs in mm/memcontrol.c is generally a good idea, but mostly for cosmetic r=
easons.

Yue, can you, please, update the patch?

Btw, what a thread! Apparently writing & reading a single boolean is not tha=
t simple=E2=80=A6 :)
Thanks for all participants!

Roman=
