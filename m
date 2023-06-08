Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E16B7285B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbjFHQr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbjFHQrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:47:25 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB402D7F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:47:06 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5343c3daff0so464384a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686242826; x=1688834826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJsvMRKIa90U27B2LLPA2h9ptE2WW+eeuczb6BgewxM=;
        b=iOBR7D2sFjrEbRKFG0OeEOxkKBZNlx2Fy/pk1NDlvDETBke0MQzcf5kdf5qF8iIeB/
         wr5gEpzbAW6MvX+SDonFRvL1NPRerCQu1vl4f33O1SDkfk54vUKVsGh/uljGluyleX60
         pwTHU8mLxld02HVUhM5lj0AqiPKYjfE/pyxwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242826; x=1688834826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJsvMRKIa90U27B2LLPA2h9ptE2WW+eeuczb6BgewxM=;
        b=KybkDDfC5NCYk9ydLQPP/wlJzGhe+7W/ku2/7CBZJKCVhndMz4RlFzeNR68fHac6y7
         TwnVCrX71sT9nRGPRheT3BgSAHalG9qxMCFw8LOtylARDR9vjtfIJvDbKVGbj3UxDBm5
         wbrbI/iKBOgLXBI/ezQUMS2U7G+61bhlK8/nhdESM3BottKuCMgTELUFtS4WIXuWmVc8
         Gu2bcPksbNwKMTfrJwZLLZ388YZqmo7vPZrmvRZ9HhuXvVUnhCo5uzHny7hABbKgh+Yz
         aCSun2qKesPjWVklAx2D/vfUcZgSaLgosBa69DO1pkPODbgnpBXRPaPzR/FalzTkPiIr
         pPDg==
X-Gm-Message-State: AC+VfDzAq3QVaV80+9fErmd5ze5wP+x53mN6DWqLxoidCQzGIMS1lq4T
        kLQKGPGhYqBaGP4MRyfOyEHEFg==
X-Google-Smtp-Source: ACHHUZ4UbTHVcubFGu4XHpAJIwx+d0InrJnKvc2R0TYuslnc/skpcNPkNC/UBQ03/nHJFZ42/RP/4g==
X-Received: by 2002:a17:902:9a94:b0:1ac:859a:5b5a with SMTP id w20-20020a1709029a9400b001ac859a5b5amr4346093plp.0.1686242825778;
        Thu, 08 Jun 2023 09:47:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w16-20020a170902a71000b001b061dcdb6bsm1670872plq.28.2023.06.08.09.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:47:05 -0700 (PDT)
Date:   Thu, 8 Jun 2023 09:47:04 -0700
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
Message-ID: <202306080917.C0B16C8@keescook>
References: <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net>
 <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net>
 <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net>
 <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
 <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 08:45:53AM -0700, Linus Torvalds wrote:
> So for convenient automatic pointer freeing, you want an interface
> much more akin to
> 
>         struct whatever *ptr __automatic_kfree = kmalloc(...);
> 
> which is much more legible, doesn't have any type mis-use issues, and
> is also just trivially dealt with by a
> 
>   static inline void automatic_kfree_wrapper(void *pp)
>   { void *p = *(void **)pp; if (p) kfree(p); }
>   #define __automatic_kfree \
>         __attribute__((__cleanup__(automatic_kfree_wrapper)))
>   #define no_free_ptr(p) \
>         ({ __auto_type __ptr = (p); (p) = NULL; __ptr; })
> 
> which I just tested generates the sane code even for the "set the ptr
> to NULL and return success" case.
> 
> The above allows you to trivially do things like
> 
>         struct whatever *p __automatic_kfree = kmalloc(..);
> 
>         if (!do_something(p))
>                 return -ENOENT;
> 
>         return no_free_ptr(p);

I am a little worried about how (any version so far of) this API could go
wrong, e.g. if someone uses this and does "return p" instead of "return
no_free_ptr(p)", it'll return a freed pointer. I was hoping we could do
something like this to the end of automatic_kfree_wrapper():

	*(void **)pp = NULL;

i.e. if no_free_ptr() goes missing, "return p" will return NULL, which
is much easier to track down that dealing with later use-after-free bugs,
etc. Unfortunately, the __cleanup ordering is _after_ the compiler stores
the return value...

static inline void cleanup_info(struct info **p)
{
	free(*p);
	*p = NULL; /* this is effectively ignored */
}

struct info *do_something(int f)
{
	struct info *var __attribute__((__cleanup__(cleanup_info))) =
		malloc(1024);

	process(var);

	return var; /* oops, forgot to disable cleanup */
}

compile down to:

do_something:
        pushq   %rbx
        movl    $1024, %edi
        call    malloc
        movq    %rax, %rbx
        movq    %rax, %rdi
        call    process
        movq    %rbx, %rdi
        call    free
        movq    %rbx, %rax	; uses saved copy of malloc return
        popq    %rbx
        ret

The point being, if we can proactively make this hard to shoot ourselves in
the foot, that would be nice. :)

-- 
Kees Cook
