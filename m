Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FF472442C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbjFFNSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjFFNR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:17:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA009F3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:17:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977c72b116fso499393666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686057473; x=1688649473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4m4td7TsrrilSTR7j+gHheVoaRExoQsmOFwSbyWIUo=;
        b=DY7rGVtAaWLwVUgmwFZLJZYI3PPxhWaRAQRrNjTUUSmIR017i55dGv+30XXnWPXI1D
         TFfyMWWcbdAi33jLUGtB0Dv3ZXCBLKYMFyQY+biI2BG8oAK5l8GpLMzOK3zMKfbEY65S
         mqMVkueVV6C2yNeIbyqxU7eSIYkWPZd7q20AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686057473; x=1688649473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4m4td7TsrrilSTR7j+gHheVoaRExoQsmOFwSbyWIUo=;
        b=Qhz7tLcI71H8e/dlrwnWgUJ6+mMz+xdT0Hjp8Iz/dVWFJF5JVKPS1bYTxopszZqFUk
         vzlKYybO47iDN63H1Ll8FMP68S/vioiVSzV1mbhDVYGh4/pFN0Ydqnvkatp8/YU8pw7t
         uamw0YfXxNkNXUPSl/uZWQy4BQtp0dv2VjMElIp8tAwPLwxmkAIirSRIDLARDfwU2xqs
         jBra0DmBw49DFH4uo53MVuU/+5UItDOFjUgyQ7BrcEbEuetGjfMT9UcIdLM4xIWsOXH6
         zw6YuQAQ4lrBH5CiA9j0FeaBh6hVJrIHN2Z5z5AVEEK1/nZLOPyU9k06sXV/ychYf1sY
         WBMA==
X-Gm-Message-State: AC+VfDyi8G/DUM1Ly144UDI5IDkBz8EN+9zcekolazN6XAZAN0JtAiJj
        DICshsPzrt5abGlFZyGCYnFb27/SGqFGnaCBEGpY6zhZ
X-Google-Smtp-Source: ACHHUZ4cfVqEOvEK0HfFh7rKE2MUYV5uCUwJpvUZELId456aLlSO+ClC9M163AnYUzAqj2oBwbWfEA==
X-Received: by 2002:a17:906:d54f:b0:96a:1c2a:5a38 with SMTP id cr15-20020a170906d54f00b0096a1c2a5a38mr2800176ejc.11.1686057473260;
        Tue, 06 Jun 2023 06:17:53 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id sd17-20020a170906ce3100b0095fbb1b72c2sm5560865ejb.63.2023.06.06.06.17.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 06:17:52 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51492ae66a4so8553160a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 06:17:51 -0700 (PDT)
X-Received: by 2002:aa7:d605:0:b0:514:92d7:7d69 with SMTP id
 c5-20020aa7d605000000b0051492d77d69mr1793652edr.27.1686057471469; Tue, 06 Jun
 2023 06:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net> <20230606094251.GA907347@hirez.programming.kicks-ass.net>
In-Reply-To: <20230606094251.GA907347@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Jun 2023 06:17:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
Message-ID: <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
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
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
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

On Tue, Jun 6, 2023 at 2:43=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> ( GCC refuses to accept _Pragma() inside an expression.

If we really want this all, I think we'd just stop using
-Wdeclaration-after-statement entirely.

There are other uses for it, and people have asked for mixing
declarations and code before.

I think that particular straightjacket has been a good thing, but I
also think that it's ok to just let it go as a hard rule, and just try
to make it a coding style issue for the common case, but allow mixed
declarations and code when it makes sense.

For the whole "automatic release case it definitely makes sense, but
it's not like it isn't possible useful elsewhere. I just don't want
for it to become some global pattern for everything.

That said, I still don't understand why you lke the name "guard" for
this.  I understand not liking "auto", but "guard" doesn't seem any
better. In fact, much worse. Guarded expressions means something
completely different both in real life and in computer science.

I'm assuming there's some history there, but it makes no sense to me
as a name here.

              Linus
