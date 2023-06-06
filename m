Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB4F724879
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbjFFQGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjFFQGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:06:43 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188F510FB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 09:06:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-652426346bbso3220781b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686067601; x=1688659601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jXVTDSdMiB3zR+OG3uqHC+1FYr882xcnuexC20tqUf4=;
        b=OTV/d/3V9GKnT/dcqqO8flI4mpv1dP4tP9CFIaVB6G0rytjsEJgQTuPWtyXzNbNwgS
         E1Ho9sMMXWiaFpl8kcvxnvxMf0yFUKnQc980CQFmA8t/7Rechuy1hwp09WtJK7iu6/db
         PBAjm1AWrfoBCxxhEWbn15NVpEo7vUM4fBm5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686067601; x=1688659601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXVTDSdMiB3zR+OG3uqHC+1FYr882xcnuexC20tqUf4=;
        b=BYaAA6xs5HcCx2bEG7ohxgd4z4viwXTCD2utDrc0s0MJxxOPV0fM0HzrlU3+h6U9hj
         vxvqMqswIzzGIXJ4fndqspPzR6RHuaQRpGfjW4EQu9Kbunvx7pHiAbRt+DcHyKSz7q7H
         3cZxqXqdZoACq9qHnZX/nBQWZlBCtHAP1jiALYM25UWlnVXgf5qOGZ2J49hzzwH0Z0W0
         yMMUzq/hzhJjV0brGJSeTmLT/hmHAa02FonsbCWLiCzSRfU9PM9oABUKB/AUHCoNY691
         syuZXH0KLSlyEN2VMhIuDdVy/RQ9nhV+TOIgax6KS8AQCA+6Xaf54mwAUZgaCOES/Hyu
         5ibg==
X-Gm-Message-State: AC+VfDw2YIGRtXrWgmDOaYyMvb/viJZsUoilxHZbhBnKoxpkctBje2sl
        QvIvVIkjyJ5ALqHow2C/4b/1Qw==
X-Google-Smtp-Source: ACHHUZ6cYdmDBapnKOceAX0mWmnjv+B38a56qd7Z1gqNRVORPZxwME6q3J5Iovn641WlwRY1BVEmaw==
X-Received: by 2002:a05:6a00:1994:b0:643:59ed:5dc9 with SMTP id d20-20020a056a00199400b0064359ed5dc9mr1249055pfl.12.1686067601499;
        Tue, 06 Jun 2023 09:06:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a000bea00b0064fd8b3dd10sm7037375pfu.109.2023.06.06.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 09:06:41 -0700 (PDT)
Date:   Tue, 6 Jun 2023 09:06:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
Message-ID: <202306060835.51CE77CCC@keescook>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net>
 <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 07:50:47AM -0700, Linus Torvalds wrote:
> So you could have something like
> 
>   #define RAII(type, var, init, exit) \
>         __RAII(type, var, init, exit, __UNIQUE_ID(fn)
> 
>   #define __RAII(type, var, init, exit, exitname) \
>         void exitname(type *p) { exit } \
>         type var __attribute__((__cleanup__(exitname))) = (init)
> 
> and do all of the above with
> 
>     RAII(struct fd, fd, fdget(f), fdput(fd));

"fdput(fd)" needs to be "fdput(*p)", since otherwise "fdput(fd)" is
referencing "fd" before it has been declared.

But regardless, yes, Clang is angry about the nested function. Also,
while my toy[1] example doesn't show it, GCC may also generate code
that requires an executable stack for some instances (or at least it
did historically) that need trampolines.

[1] https://godbolt.org/z/WTjx6Gs7x

Also, more nits on naming: isn't this more accurately called Scope-based
Resource Management (SBRM) not RAII? (RAII is technically object lifetime,
and SBRM is scope entry/exit.)

-- 
Kees Cook
