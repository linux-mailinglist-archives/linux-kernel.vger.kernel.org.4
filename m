Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0868F714F88
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjE2TE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjE2TE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:04:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BAED9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:04:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5148e4a2f17so5171919a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685387059; x=1687979059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5zBwPFXpBZ+0YOoFtMUsfZzhL5fV2k18YHtphZDnq0=;
        b=EQybvHHJ8q5OI8VekF8gA0xBFhAYW6NXsGdMhCaSEtAV09vsBrlhYeArdGD2TOA2ZE
         gaohhUnoBBO9en6G7zemX1f7k5+Devjzs1byIB/MDNz0PCC8mpmlNkSXHlROV96r76Dd
         TXuXyvQqExhxSG1ezaBlmaCZJ7hpr9MA9nRjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685387059; x=1687979059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5zBwPFXpBZ+0YOoFtMUsfZzhL5fV2k18YHtphZDnq0=;
        b=jOXfzhHadsLzI7SUzXoQ1cR9DchtFieB8xfFv4qqRRPA2Nrx/3jCpiEL4rGqid0M/0
         y7K87I/S/TwkCRLsd0cFdYMBMHDmeYYpCrW6rCofgfUfEshx2/gjNuoEXYMAsZu3AnPG
         Sq4InozTJCm+aTl7sr5yRdtG0Ad5ywjYxPtR1R9zbLqjoNDov8U9z7mQvrSXv8pQEe62
         eK+jnehnCAlZLawpEEV28bvKVnTIs74/UMsqkvciBeWLU5QWhJz+sLUVWM1U2C0lPot/
         G7tI8s+albpGiDeV0upQjodDisFaVadCYgizej9hGY/qothzNnfm/cxowg6oglAdmZ5T
         BxJA==
X-Gm-Message-State: AC+VfDwq7hGO5dVwksb4qHXc3Mck9pJcmuQ9VqNp8vCyVivkysIHkAzX
        SyGsnw7+QSJfZ44oPfOrPPbK1JOo/bUdTMYBZXwuz8eK
X-Google-Smtp-Source: ACHHUZ4lJTR7gkjfNK2ayUrlOaqh4gWtKSIsAu64zqwTC+Ex+PVQyLckjwGAx88df92l1NXN/F08ng==
X-Received: by 2002:a17:907:1688:b0:973:ea73:b85d with SMTP id hc8-20020a170907168800b00973ea73b85dmr105378ejc.68.1685387059315;
        Mon, 29 May 2023 12:04:19 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id b13-20020a1709065e4d00b00965e9b435dfsm6203974eju.65.2023.05.29.12.04.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 12:04:18 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so4033738a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:04:18 -0700 (PDT)
X-Received: by 2002:a17:907:c29:b0:965:6075:d100 with SMTP id
 ga41-20020a1709070c2900b009656075d100mr181880ejc.39.1685387057821; Mon, 29
 May 2023 12:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <CABgObfbhvOnqKQs9r2+3apg0UK3ub03Nf2SfGpe1=NcL9ewSSg@mail.gmail.com>
In-Reply-To: <CABgObfbhvOnqKQs9r2+3apg0UK3ub03Nf2SfGpe1=NcL9ewSSg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 May 2023 15:04:00 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjF4n=bEk-MDCWmOzyrm_zGsjP4RVkK72S3m4Oppg7F3Q@mail.gmail.com>
Message-ID: <CAHk-=wjF4n=bEk-MDCWmOzyrm_zGsjP4RVkK72S3m4Oppg7F3Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ian Lance Taylor <iant@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
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

On Mon, May 29, 2023 at 8:09=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Sat, May 27, 2023 at 9:18=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > It's also an example of something people need to be aware of: the
> > auto-releasing is not ordered. That may or may not be a problem. It's
> > not a problem for two identical locks, but it very much *can* be a
> > problem if you mix different locks.
>
> It is guaranteed. It would be nice to have it documented, but if you
> look at the intermediate representation of this simple example:

Well, I can see that it might be doing that reverse ordering in
practice, but for the life of me, I can't actually find anything that
says it is guaranteed.

Google did find me one blog post by Ian Lance Taylor from 2008 that
said that yes, each __cleanup__ attribute basically creates its own
little scope, and that the cleanup in reverse declaration order is
thus guaranteed.

Let's add Ian to the cc, partly to confirm it wasn't just a random
implementation detail, but also partly to perhaps ask him to get
somebody to document it.

Because if it's not documented, how do we know that the clang
implementation of that attribute then ends up also guaranteeing the
reverse order cleanup, even if gcc might guarantee it?

I *suspect* - but cannot find any guarantees - that it's going to
match C++ destructors, and you probably end up pretty much always
having to deal with these cleanup functions in reverse order, so it
all sounds very likely to me.

And maybe it's even documented somewhere that neither of us could find.

Anyway, I do like the option to use cleanup functions, but I think
we'd better make sure, since we really may require nesting for locks
(even if in many cases it won't matter).

Ian? Any chance you can either point us at documentation, or maybe
just confirm it, and hopefully make said documentation happen?

            Linus
