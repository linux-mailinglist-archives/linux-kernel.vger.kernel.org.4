Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7083E712C61
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbjEZSXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjEZSW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:22:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DD8BC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:22:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51480d3e161so525243a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685125375; x=1687717375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/M/UpOX/uPrVbeWrxnNFy2PEHqrEHRxe05fCpZOsMs=;
        b=afY8YIYvE6Fbwpz5pdVexlVBp/XoD+ftfHd0Ht0RnarmhFLYY43GcFasoLkoBNspby
         4DO2IVbhY/wbeLil1ar8J4WTdT3TvHcsAhYiijZ6vC0dsvI+afE4ygPHJSn9UPZ/8QDF
         1kJVo+Badhw2iCcHc3KQS3qXxJkJYYd7vTr8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685125375; x=1687717375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/M/UpOX/uPrVbeWrxnNFy2PEHqrEHRxe05fCpZOsMs=;
        b=lbgBqvyv/ZRj/L+AVPgKeHWhmtDyJUYOfGFco22CXeAllwaI2nxhM0sv5WjfSykjik
         rq9jwKnmozphPYWG/gA0jd/el5Zo3lFFPLjUgdCnyA9/fXqkxMownLZ92SjIBHB8h3wy
         pabSvmlv15IiBfbxiCX4XFIOC4UM9cjn4NXDDphEhWaPI+cmGrGpYa3CYEGYJRNeWuwd
         YUxNp1bV7SWM02+GDLIS/YudTGQ02BhidHCVu1jZn53PSGMdwuZBx6/dyzzO+oyE5ElG
         CFhlYECeY0qf/GVa/qDmtRQ97f/mIcNqQ2BcRn1LIxfHKZuj5y9JzL8PfdCKX0tSMHYI
         +Leg==
X-Gm-Message-State: AC+VfDy/3Cvyb/WDC1g8U4zlKvAM4EA1UB1toQuYre4c91ZytAx6Dvfs
        TvF8KGcWjZPEfGbtLqNxDqruXG/sn8fvAtYHbVFANkXz
X-Google-Smtp-Source: ACHHUZ7cGqJvArn7lcyaXh8+aiVb/BGX9e0jbB8Qg52xB+ejQGAONY2VM+I8/Qpw60Zv1iGD/Cpo0g==
X-Received: by 2002:a17:907:7ea8:b0:965:8edf:8028 with SMTP id qb40-20020a1709077ea800b009658edf8028mr3826950ejc.42.1685125375167;
        Fri, 26 May 2023 11:22:55 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id j23-20020a17090643d700b0095850aef138sm2440031ejn.6.2023.05.26.11.22.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 11:22:54 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-96fa4a6a79bso155399466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:22:53 -0700 (PDT)
X-Received: by 2002:a17:907:9620:b0:96a:2acf:61e1 with SMTP id
 gb32-20020a170907962000b0096a2acf61e1mr3395121ejc.64.1685125373395; Fri, 26
 May 2023 11:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230526150549.250372621@infradead.org> <20230526151946.960406324@infradead.org>
In-Reply-To: <20230526151946.960406324@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 May 2023 11:22:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYL6JaL79EmOBV=vge7jWGkph73JnJgU9U3jeXa6b2=Q@mail.gmail.com>
Message-ID: <CAHk-=wgYL6JaL79EmOBV=vge7jWGkph73JnJgU9U3jeXa6b2=Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] locking: Introduce __cleanup__ based guards
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, rcu@vger.kernel.org, tj@kernel.org,
        tglx@linutronix.de
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

On Fri, May 26, 2023 at 8:23=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> The CPP is rather impenetrable -- but I'll attempt to write proper
> comments if/when people think this is worth pursuing.

Ugh.

It's not only impenetrable, it seems _unnecessarily_ so.

Yes, yes, 'for()' loops can only declare one type, and if you want
multiple typed variables you declare a struct that contains all the
types.

But you don't actually *need* multiple types.

Yes, you think you do, because you want to use that 'bool done' to
make the for-loop only execute once. Nasty limitation of the for
syntax.

But you can actually do the 'bool done' using the exact same type you
have for the guard - just make it a pointer instead, and use NULL for
"not done" and non-NULL for "done". It ends up acting exactly like a
boolean.

But that extra structure is only a detail. The real ugliness comes
from using different scoping macros.

And I think you don't actually need to have those different forms of
"scoped()" macros for different cases. I think you can just use
variable macro arguments.

IOW, something like this:

  #define variable_scope(type, enter, exit) \
        for (type *_done =3D NULL, _scope __cleanup(exit) =3D enter;
!_done; _done =3D (void *)8)

  #define scoped(type, init...) \
        variable_scope(scope_##type##_t, scope_##type##_init(init),
scope_##type##_cleanup)

and then you can do

        scoped (rcu) {
                ...
        }

and it will call "scope_rcu_init()" on entry, and
"scope_rcu_exit(_scope)" on exit.

And just doing

        scoped (mutex, mymutex) { ... }

will call "scope_mytex_init(mymutex)" on entry, and
"scope_mytex_exit(_scope)" on exit.

And if you just make the scope_##type##_init() functions return the
right values, it all works very naturally.

I think you can also do things like

        scoped(irqsave) { ... }
        scoped(irqoff) { ... }
        scoped(preempt) { ... }

very naturally. No need for that odd "one scope for 'void', one scope
for 'lock'" nonsense.

I dunno. I didn't *test* the above. Maybe you already tried something
like the above, and there's a reason why it doesn't work.

             Linus
