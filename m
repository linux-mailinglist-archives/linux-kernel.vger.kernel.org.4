Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0137285E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbjFHQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjFHQ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:59:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B21730
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:59:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3094910b150so917600f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686243565; x=1688835565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTh/iWKmmyZ+KHSVz7lo3LyFxk+kpCnAqa64Bwwppv8=;
        b=G/IWNkyCbWls8BLTB7WvAvQ+XtovWAGv3Ij5dCyXrEWiagoYb7Si+weEPjL44pMZhK
         NH617bNKNRKkba/IhXPCGrZoovQEOCiJ/dp5RoFOqX0ZoUDkjCNqHLw9UL7ICliVkKUc
         Zeaj97ZFd2A7nB9gaJInITILK0RVFijnm/bqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686243565; x=1688835565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTh/iWKmmyZ+KHSVz7lo3LyFxk+kpCnAqa64Bwwppv8=;
        b=O/r95C4WnN++6uErIxcFeQpA/KurIBIExq4ogOy2NmrpExPhVg5tEPmI9V2LMPtpfX
         SpTvW99a7f3I76F0fUPhS7Bb4qYzo63Wfq2vRs0JnujqY7spHhA2MveA+hmFKFpyXbcz
         oC9iESgFCZflktaxDzv7lwn9wtwVkM5TBJOOkEsLmDs1hSZB6xEDxBBYVbNvuCONyr2a
         0X/CtfXQZh5BHApv1JZuVxkvHok0twff+z6CG6eDB96VwuKxoDwTXWQgQlbIYTPYd4YW
         AhRVqnl04rEKtoDX7gLarYnohJBUdgUzfOU+kmL9ecmJ70qd4G6uzvrlhZUnv52CXy7G
         VoRg==
X-Gm-Message-State: AC+VfDxN2rvU1OAgFjp118j+p5YQwnYhGkDFYHxW2Oo9ph8mEGh6uapz
        oazlyMF7tzKpqcXJbi4P5zjK09OwbTlVPltL8QL5JX2e
X-Google-Smtp-Source: ACHHUZ6qQWYwBBRj4tFM5pYdD2sGskjHQN6pHM1JqyrflrQqrExfTYX+dcDQY6oEJRGktnfPMhIz0w==
X-Received: by 2002:adf:fc82:0:b0:30a:e997:e69c with SMTP id g2-20020adffc82000000b0030ae997e69cmr6954790wrr.53.1686243564979;
        Thu, 08 Jun 2023 09:59:24 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id g16-20020aa7d1d0000000b0050bc4600d38sm749021edp.79.2023.06.08.09.59.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 09:59:24 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so1285959a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:59:23 -0700 (PDT)
X-Received: by 2002:a17:907:c27:b0:966:17b2:5b0b with SMTP id
 ga39-20020a1709070c2700b0096617b25b0bmr364290ejc.49.1686243563225; Thu, 08
 Jun 2023 09:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net> <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net> <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net> <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net> <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
 <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com> <202306080917.C0B16C8@keescook>
In-Reply-To: <202306080917.C0B16C8@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Jun 2023 09:59:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wga3uyr_MZVPt3HmvjKKDJVw1s-PZfDvrVnJDJbBKzqdA@mail.gmail.com>
Message-ID: <CAHk-=wga3uyr_MZVPt3HmvjKKDJVw1s-PZfDvrVnJDJbBKzqdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 9:47=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> I am a little worried about how (any version so far of) this API could go
> wrong, e.g. if someone uses this and does "return p" instead of "return
> no_free_ptr(p)",

Absolutely. I think the whole "don't always cleanup" is quite
dangerous, and maybe not worth it, but it _is_ a fairly common
pattern.

>     I was hoping we could do
> something like this to the end of automatic_kfree_wrapper():
>
>        *(void **)pp =3D NULL;

That would be a lovely thing, but as you found out, it fundamentally
cannot work.

The whole point of "cleanup" is that it is done when the variable -
not trh *value* - goes out of scope.

So when you have that

        return var; /* oops, forgot to disable cleanup */

situation, by definition "var" hasn't gone out of scope until _after_
you read the value and return that value, so pretty much by definition
it cannot make a difference to assign something to 'pp' in the cleanup
code.

> The point being, if we can proactively make this hard to shoot ourselves =
in
> the foot, that would be nice. :)

So the good thing is that things like KASAN would immediately notice,
and since this all happens (presumably) for the success case, it's not
about some unlikely error case.

I also think that -fanalyzer might just catch it (as part of
-Wanalyzer-use-after-free) at compile-time, but I didn't check. So
if/when people start using -fanalyze on the kernel, those things would
be caught early.

So while this "forget to avoid cleanup" is a worry, I think it ends up
likely being one that is fairly easy to avoid with other checks in
place.

Famous last words.

             Linus
