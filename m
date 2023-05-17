Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2097072BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjEQUJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjEQUJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:09:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066706E8B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:09:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so1857504a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684354157; x=1686946157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUJuL+2WvYBnwuI2AxMqbxeUZxgtHjH0G/Zm8si7raQ=;
        b=FswP8g2FI3659/s/93gVCGsv3xZZtGIZfyfW2LeNfXS8vk7ZVBjKBV5EubqxsPWC4B
         DTiSzYAVTqlLfpqatXRUYC2ud7ZZO/vsf5e6eQGX32M+kzCJw+W5bHv1BObk06wK2Nh+
         YyCLeqhvFzPSmMK/EQYkoCJ95VGK9AkRl/KJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684354157; x=1686946157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUJuL+2WvYBnwuI2AxMqbxeUZxgtHjH0G/Zm8si7raQ=;
        b=efikaB8+A6N2UdeoZECoqy+hyktb2rFsuOLq7RNS4zHczTJDmDI5+D+GQ9TxbJJkKq
         ITmXV4tUh1TaBZytp42jQBd4vUNkvGGGmsqIJd7bQ41KqgxBmkOwBv/CBNZdBDwcI3R3
         S4maX4mH0XHplL+hwvgDuEQvTTjzNWEi+nZZuZS2Ib7627DqviaifgTDLNJRTWysDX2h
         fWHRHBL8lJweHRvzizsZP1YKybxkK7n+Iv9JKvZ903TQq9rtASmMvKfT56rSYZ8rjO4Z
         R7B9sbHRXur+cu1TrWGrkZ21joP2xqq+CjBTh++ZW9gDNDS4Q7l6tK51RPyCLQ/8JVO7
         +JSg==
X-Gm-Message-State: AC+VfDzCpmlpbWfELQ/Tbz9zEZlLHN2l2bC1BGuOpFLp1LQ5ZdUZf1hp
        DL74Ynhv8TQwd94JtJWj1MMX+e77gvjqf6LNpRCWdpvN
X-Google-Smtp-Source: ACHHUZ7O+OjYioFm19aPCEtHg9oKXbir9ZRpJR5R0nsctyqL9NjUKlZzio9qpJEeNqei3+e9oReAYQ==
X-Received: by 2002:aa7:df0d:0:b0:50b:c9d7:8b24 with SMTP id c13-20020aa7df0d000000b0050bc9d78b24mr3270574edy.6.1684354157288;
        Wed, 17 May 2023 13:09:17 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id u24-20020a056402111800b0050bc4eb9846sm9583584edv.1.2023.05.17.13.09.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 13:09:16 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9659c5b14d8so189325666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:09:16 -0700 (PDT)
X-Received: by 2002:a17:907:7291:b0:96a:717:d452 with SMTP id
 dt17-20020a170907729100b0096a0717d452mr29868922ejc.19.1684354155799; Wed, 17
 May 2023 13:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230509163050.127d5123@rorschach.local.home> <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain> <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
 <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
In-Reply-To: <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 13:08:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicngggxVpbnrYHjRTwGE0WYscPRM+L2HO2BF8ia1EXgQ@mail.gmail.com>
Message-ID: <CAHk-=wicngggxVpbnrYHjRTwGE0WYscPRM+L2HO2BF8ia1EXgQ@mail.gmail.com>
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

On Wed, May 17, 2023 at 12:36=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> .. this is the patch that I think should go on top of it to fix the
> misleading "safe" and the incorrect RCU walk.
>
> NOTE! This adds that
>
>         lockdep_assert_held(&event_mutex);
>
> to user_event_enabler_update() too.

One more note: I think it would be really good to use different names
for the "links".

We have "mm->link", that is the list of mm's on the 'user_event_mms'
list, protected by the 'user_event_mms_lock' and RCU-walked.

And then we have 'enabler->link', which is the list of enables on the
'user_mm->enablers' list, protected by event_mutex, and _also_
occasionally RCU-walked.

And then we have 'validator->link', which isn't RCU-walked, and seems
to also be protected by the event_mutex (?).

This is all very confusing when looking at it as an outsider.
Particularly when you sometimes just see

        list_del_rcu(&mm->link);

and you have to figure "which 'link' are we talking about again?".

Also, I have to say, I found "mm->next" *really* confusing at first.

It turns out that "mm->next" is this list that is dynamically built up
by user_event_mm_get_all(), and is only a one-shot list that is valid
only as long as 'event_mutex' is held. But the only lock the code
*talks* about is the RCU lock, which does *not* protect that list, and
only exists as a way to walk that user_event_mms list without taking
any locks.

So user_event_enabler_update() actually relies on that 'event_mutex'
lock in another way than the obvious one that is about the
mm->enablers list that it *also* walks.

Again, that all seems to work, but it's *really* confusing how
"mm->next" always exists as a field, but is only usable and valid
while you hold that event_mutex and have called
user_event_mm_get_all() to gather the list.

I think both user_event_enabler_update() and user_event_mm_get_all()
should have a mention of how they require event_mutex and how that
->next list works.

Anyway, I still *think* the two patches I sent out are right, but I'm
just mentioning this confusion I had to deal with when trying to
decode what the rules were. Maybe all the above is obvious to
everybody else, but it took me a while to decipher (and maybe I
misread something).

             Linus
