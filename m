Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C1D72A543
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjFIVSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjFIVSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:18:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D960C3A89;
        Fri,  9 Jun 2023 14:18:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77B4865C48;
        Fri,  9 Jun 2023 21:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CEBC433D2;
        Fri,  9 Jun 2023 21:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686345494;
        bh=A7ZSNdpgt4TEUjGBBbEBvk5Z6M9RP45arMggWse/pRA=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Z8MkxbLUfCweTaqIx586AdDWCT3qLUVR2gR0OiEnGM6fMovsTxdOphf2Zu7zOS0mk
         e0kIXKno996Kq3kZ5e7FznrbzRAL9deyMks1zFJ6GYeMykMpERzyRb+yEwH1W6wQ2e
         /nQvvP93UCklBJ7Bk7PphF0YEUQ0r/Int3/XLAiaPY431dvKvk50N5GuAIvImM0e3+
         2RZqNe1y9Mzf9f8b4wtC3pzg4idFOwvU6D9TG6OfO2IR3oeldCq12o/60ZhtkizKrB
         foyuU3TytX5R4tU63QlceDWYGKHI52jJL5f9v+gI9Hsl11Q+X8LZaxlfS4UPD0Ws6R
         YAARXD8HurcUQ==
Date:   Fri, 09 Jun 2023 14:18:13 -0700
From:   Kees Cook <kees@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     keescook@chromium.org, gregkh@linuxfoundation.org,
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
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wjcXuZ91WkKv0fuBcm+w7y=y=fNzW9EXfnYYSCFvuyhdA@mail.gmail.com>
References: <20230530092342.GA149947@hirez.programming.kicks-ass.net> <20230606094251.GA907347@hirez.programming.kicks-ass.net> <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com> <20230606134005.GE905437@hirez.programming.kicks-ass.net> <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com> <20230606180806.GA942082@hirez.programming.kicks-ass.net> <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com> <20230607094101.GA964354@hirez.programming.kicks-ass.net> <20230608085248.GA1002251@hirez.programming.kicks-ass.net> <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com> <20230608200618.GA1020752@hirez.programming.kicks-ass.net> <CAHk-=wjcXuZ91WkKv0fuBcm+w7y=y=fNzW9EXfnYYSCFvuyhdA@mail.gmail.com>
Message-ID: <008C18B3-519A-40AF-B35C-1AA8BF1EF4FF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 8, 2023 7:25:27 PM PDT, Linus Torvalds <torvalds@linux-foundation=
=2Eorg> wrote:
>On Thu, Jun 8, 2023 at 1:06=E2=80=AFPM Peter Zijlstra <peterz@infradead=
=2Eorg> wrote:
>>
>>         struct obj *p __free(kfree) =3D kmalloc(=2E=2E=2E);
>
>Yeah, the above actually looks really good to me - I like the naming
>here, and the use looks very logical to me=2E
>
>Of course, maybe once I see the patches that use this I go "uhh", but
>at least for now I think you've hit on a rather legible syntax=2E
>
>I'm still a bit unsure of the "no_free_ptr(p)" naming, but at least
>it's pretty clear about what it does=2E
>
>So my only worry is that it's not pretty and to the point like your
>"__free(kfree)" syntax=2E
>
>But it feels workable and not misleading, so unless somebody can come
>up with a better name, I think it's ok=2E

I like the proposed "take" naming, and before reading that reply I was goi=
ng to suggest "keep"=2E *shrug*


--=20
Kees Cook
