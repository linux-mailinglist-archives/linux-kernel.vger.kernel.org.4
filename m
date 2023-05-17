Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6760770708B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjEQSPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjEQSPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:15:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E347EF9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:15:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96622bca286so204086766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684347332; x=1686939332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glKf7NIJxMjvHArJbyFniLngVqkquHliX4T2ECqtZCU=;
        b=T2vuGTQjWXtk4JymfRQdQR63Qqmk/mFrHv47AJoiaEC2RSrZoIpR3m0zIZmnYjLy66
         G62ZCX8ZUqHaOdxqCZAdGSSmpl1bzDTXknLyOEf6nLQ+/Lalv3ZRuxtYOI5i6r/Kq9W1
         HZqQ8aaOc1L+nY6lDtT4nr6vlDJfymDBpsWBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684347332; x=1686939332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glKf7NIJxMjvHArJbyFniLngVqkquHliX4T2ECqtZCU=;
        b=CtkhE0bOEA+U8tzkadn4SqvlAUgy4Rw0q+JPJuY87JfJq+Vdq62NPSwLljToULdEFn
         RMo8HW+r77nH7HxhToYBd1DwJ6HvLcTPoGh0s29NmiLW1epStVnpN41dpgu/31LjT7iK
         85yYUpNI4QlfhDW7Pw23Dsv0/XntwL6yuF2zkfAaynyQv5FrJYGYZwSTB1VQd/YInMdH
         KSvlz7QVA2o60FH8oqNDg2yXPGjEODEZm+eo/0oSGZ4DuGzNIOVIdZArAPH4mRo5Rtdc
         8NYay9bemICuECIw5pRQkA6ECq9m+Yhp9BGjBEbryRzQW7/y16UyzbecpkL07wVhmbTA
         nXXw==
X-Gm-Message-State: AC+VfDzlLsBAbQnn7+KDEqi6B8nJDnVg10HQOGVeb51YRD7q1X+UqA0C
        fPnqpuEKfh/Otfqc92czpMtJcq8dE9BgiUCovkmWUm9n
X-Google-Smtp-Source: ACHHUZ5HJJj50DmKS47Bw3bw1prwwqpywrudoNJylHgJxwOTy/eLJ5cNMwL7rimcDQJpbPbAM+Qf7w==
X-Received: by 2002:a17:906:eec5:b0:965:bdd1:1d22 with SMTP id wu5-20020a170906eec500b00965bdd11d22mr37180202ejb.68.1684347332610;
        Wed, 17 May 2023 11:15:32 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id gx8-20020a1709068a4800b00965ab02b42csm12521510ejc.102.2023.05.17.11.15.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 11:15:32 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-96622bca286so204083366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:15:32 -0700 (PDT)
X-Received: by 2002:a17:906:dacb:b0:966:53b1:b32a with SMTP id
 xi11-20020a170906dacb00b0096653b1b32amr31032871ejb.53.1684347331694; Wed, 17
 May 2023 11:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local> <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain>
In-Reply-To: <20230517172243.GA152@W11-BEAU-MD.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 11:15:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
Message-ID: <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>, dthaler@microsoft.com,
        brauner@kernel.org, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 10:22=E2=80=AFAM Beau Belgrave
<beaub@linux.microsoft.com> wrote:
>
> On Tue, May 16, 2023 at 08:03:09PM -0700, Linus Torvalds wrote:
> > So what is it that could even race and change the list that is the
> > cause of that rcu-ness?
>
> Processes that fork() with previous user_events need to be duplicated.

BS.

Really. Stop making stuff up.

The above statement is clearly not true - just LOOK AT THE CODE.

Here's the loop in question:

                list_for_each_entry_rcu(enabler, &mm->enablers, link) {
                        if (enabler->event =3D=3D user) {
                                attempt =3D 0;
                                user_event_enabler_write(mm, enabler,
true, &attempt);
                        }
                }

and AT THE VERY TOP OF user_event_enabler_write() we have this:

        lockdep_assert_held(&event_mutex);

so either nobody has ever tested this code with lockdep enabled, or we
hold that lock.

And if nobody has ever tested the code, then it's broken anyway. That
code N#EEDS the mutex lock. It needs to stop thinking it's RCU-safe,
when it clearly isn't.

So I ask again: why is that code using RCU list traversal, when it
already holds the lock that makes the RCU'ness COMPLETELY POINTLESS.

And again, that pointless RCU locking around this all seems to be the
*only* reason for all these issues with pin_user_pages_remote().

So I claim that this code is garbage.  Somebody didn't think about locking.

Now, it's true that during fork, we have *another* RCU loop, but that
one is harmless: that's not the one that does all this page pinning.

Now, that one *does* do

        list_add_rcu(&enabler->link, &mm->enablers);

without actually holding any locks, but in this case 'mm' is a newly
allocated private thing of a task that hasn't even been exposed to the
world yet, so nobody should be able to even see it. So that code lacks
the proper locking for the new list, but it does so because there is
nothing that can race with the new list (and the old list is
read-only, so RCU traversal of the old list works).

So that "list_add_rcu()" there could probably be just a "list_add()",
with a comment saying "this is new, nobody can see it".

And if something *can* race it it and can see the new list, then it
had damn well needs that mutex lock anyway, because that "something"
could be actually modifying it. But that's separate from the page
pinning situation.

So again, I claim that the RCU'ness of the pin_user_pages part is
broken and should simply not exist.

> > Other code in that file happily just does
> >
> >         mutex_lock(&event_mutex);
> >
> >         list_for_each_entry_safe(enabler, next, &mm->enablers, link)
> >
> > with no RCU anywhere. Why does user_event_enabler_update() not do that?
>
> This is due to the fork() case above without taking the event_mutex.

See above. Your thinking is confused, and the code is broken.

If somebody can see the new list while it is created during fork(),
then you need the event_mutex to protect the creation of it.

And if nobody can see it, then you don't need any RCU protection against it=
.

Those are the two choices. You can't have it both ways.

> > Oh, and even those other loops are a bit strange. Why do they use the
> > "_safe" variant, even when they just traverse the list without
> > changing it? Look at user_event_enabler_exists(), for example.
>
> The other places in the code that do this either will remove the event
> depending on the situation during the for_each, or they only hold the
> register lock and don't hold the event_mutex.

So?

That "safe" variant doesn't imply any locking. It does *not* protect
against events being removed. It *purely* protects against the loop
itself removing entries.

So this code:

        list_for_each_entry_safe(enabler, next, &mm->enablers, link) {
                if (enabler->addr =3D=3D uaddr &&
                    (enabler->values & ENABLE_VAL_BIT_MASK) =3D=3D bit)
                        return true;
        }

is simply nonsensical. There is no reason for the "safe". It does not
make anything safer.

The above loop is only safe under the mutex (it would need to be the
"rcu" variant to be safe to traverse without locking), and since it
isn't modifying the list, there's no reason for the safe.

End result: the "safe" part is simply wrong.

If the intention is "rcu" because of lack of locking, then the code needs t=
o
 (a) get the rcu read lock
 (b) use the _rcu variant of the list traversal

And if the intention is that it's done under the proper 'event_mutex'
lock, then the "safe" part should simply be dropped.

               Linus
