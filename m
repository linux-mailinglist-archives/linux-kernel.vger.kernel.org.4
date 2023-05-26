Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E60E712B60
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbjEZRFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEZRFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:05:44 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCC4D9
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:05:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d30ab1ef2so933376b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685120742; x=1687712742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxumJGI+OGOCoDB2FXTzXjZjGjRaDHCBUOgVAq+aAxc=;
        b=KK3X5UgtcFObh5PcbJlgv5hNhaSbpvveePahsg/3eYw633NTX716Mb3rHM+txA1YXi
         swZXm0EykOvkEDMYl9MjuGVFmg1ntONmZClOWvG3f6SSzfNrJiG1d5mCcXFMCzsQPYIC
         Gh9qb6SZFxLfVlr9Zyawo8Ve8+SCsLzBmZ5eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685120742; x=1687712742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxumJGI+OGOCoDB2FXTzXjZjGjRaDHCBUOgVAq+aAxc=;
        b=Y2Bcc8zWK8EH2vdhIVtT4gksLJ/GXRSllN++KQLsiBgLme8p7jV7VINKuQDNdv0WdJ
         mdEBTFAj2iecVlD6VJ2B1qxiy51xu3Cnz0npODo6TdyB4DF2JEqvDegDBp7L5SmrRq5h
         s1V+7N6g5jh0qdQLyKuxkYMSZfwi7ySnGpEQ9FYbd/Vt2eYOBTzTL9OkZR+Hxlf8mESr
         ZzEeJdDEXrKuENS2eDirdOE/pSSqIoFGgANm/tgsA/mNZj/JTzmGMABfm9CGOWfyfdzv
         Jw6e5+OzwbZeFGxCwHj4koGr0POxzUblrxfIkOPFxRAM4GWwKrOp7uwf4h0fnrJ3oUP0
         f5yw==
X-Gm-Message-State: AC+VfDxPdBVXDvfAh1gTG3aUofrWHSr72jmhcDkVhhr1rWebh1zc+G2i
        Ik58VsYdMTJCIdgn/XZmU8y/gA==
X-Google-Smtp-Source: ACHHUZ5SULZKaIeSRdX1PzT2iAoQT3NNcr4NmHQUfNdZR5Kx+nii7FssW/i1OAa+4AqpJoxz9SARSQ==
X-Received: by 2002:a05:6a20:8421:b0:10c:7676:73af with SMTP id c33-20020a056a20842100b0010c767673afmr3167678pzd.53.1685120742297;
        Fri, 26 May 2023 10:05:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u15-20020a62ed0f000000b00634b91326a9sm3036477pfh.143.2023.05.26.10.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:05:41 -0700 (PDT)
Date:   Fri, 26 May 2023 10:05:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
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
Subject: Re: [RFC][PATCH 1/2] locking: Introduce __cleanup__ based guards
Message-ID: <202305260939.D33FE435D2@keescook>
References: <20230526150549.250372621@infradead.org>
 <20230526151946.960406324@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526151946.960406324@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 05:05:50PM +0200, Peter Zijlstra wrote:
> Use __attribute__((__cleanup__(func))) to buid various guards:
> 
>  - ptr_guard()
>  - void_guard() / void_scope()
>  - lock_guard() / lock_scope()
>  - double_lock_guard() / double_lock_scope()
> 
> Where the _guard thingies are variables with scope-based cleanup and
> the _scope thingies are basically do-once for-loops with the same.

This makes things much easier to deal with, rather than forcing loops
into separate functions, etc, and hoping to get the cleanup right.

> 
> The CPP is rather impenetrable -- but I'll attempt to write proper
> comments if/when people think this is worth pursuing.

Yes please. Comments would help a lot. I was scratching my head over _G
for a bit before I realized what was happening. :)

> 
> Actual usage in the next patch
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/compiler_attributes.h |    2 
>  include/linux/irqflags.h            |    7 ++
>  include/linux/guards.h          |  118 ++++++++++++++++++++++++++++++++++++
>  include/linux/mutex.h               |    5 +
>  include/linux/preempt.h             |    4 +
>  include/linux/rcupdate.h            |    3 
>  include/linux/sched/task.h          |    2 
>  include/linux/spinlock.h            |   23 +++++++
>  8 files changed, 164 insertions(+)
> 
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -366,4 +366,6 @@
>   */
>  #define __fix_address noinline __noclone
>  
> +#define __cleanup(func)			__attribute__((__cleanup__(func)))
> +
>  #endif /* __LINUX_COMPILER_ATTRIBUTES_H */

nitpick: sorting. This needs to be moved up alphabetically; the comment
at the start of the file says:

 ...
 * This file is meant to be sorted (by actual attribute name,
 * not by #define identifier). ...

> [...]
> +#define DEFINE_VOID_GUARD(_type, _Lock, _Unlock, ...)				\
> +typedef struct {								\
> +	__VA_ARGS__								\
> +} void_guard_##_type##_t;							\
> +										\
> [...]
> +DEFINE_VOID_GUARD(irq, local_irq_disable(), local_irq_enable())
> +DEFINE_VOID_GUARD(irqsave,
> +		  local_irq_save(_G->flags),
> +		  local_irq_restore(_G->flags),
> +		  unsigned long flags;)

Yeah, good trick for defining 0-or-more members to the guard struct. I
expect the common cases to be 0 or 1, so perhaps move the final ";" to
after __VA_ARGS__ to avoid needing it in the DEFINEs? (And even in this
initial patch, there's only 1 non-empty argument...)

> [...]
> --- /dev/null
> +++ b/include/linux/guards.h
> @@ -0,0 +1,118 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_GUARDS_H
> +#define __LINUX_GUARDS_H
> +
> +#include <linux/compiler_attributes.h>
> +
> +/* Pointer Guard */
> +
> +#define DEFINE_PTR_GUARD(_type, _Type, _Put)				\
> +typedef _Type *ptr_guard_##_type##_t;					\
> +static inline void ptr_guard_##_type##_cleanup(_Type **_ptr)		\
> +{									\
> +	_Type *_G = *_ptr;						\
> +	if (_G)								\
> +		_Put(_G);						\
> +}

*loud forehead-smacking noise* __cleanup with inlines! I love it!

> [...]
> +#define void_scope(_type)							\
> +	for (struct { void_guard_##_type##_t guard; bool done; } _scope		\
> +	     __cleanup(void_guard_##_type##_cleanup) =				\
> +	     { .guard = void_guard_##_type##_init() }; !_scope.done;		\
> +	     _scope.done = true)

Heh, yes, that'll work for a forced scope, and I bet compiler
optimizations will collapse a bunch of this into a very clean execution
path.

> [...]
> +DEFINE_VOID_GUARD(preempt, preempt_disable(), preempt_enable())
> +DEFINE_VOID_GUARD(migrate, migrate_disable(), migrate_enable())
> [...]
> +DEFINE_VOID_GUARD(rcu, rcu_read_lock(), rcu_read_unlock())
> [...]
> +DEFINE_PTR_GUARD(put_task, struct task_struct, put_task_struct)
> [...]

It seems like there are some _really_ common code patterns you're
targeting here, and I bet we could do some mechanical treewide changes
with Coccinelle to remove a ton of boilerplate code.

I like this API, and the CPP isn't very obfuscated at all, compared to
some stuff we've already got in the tree. :)

-Kees

-- 
Kees Cook
