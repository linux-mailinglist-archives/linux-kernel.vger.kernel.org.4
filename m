Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ECA68F9F4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjBHV4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjBHV4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:56:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F128228D36
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 13:56:00 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m2-20020a17090a414200b00231173c006fso3267401pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WrzQdBMb984GoLwSermZKSUJHb2Pj08MtfAszXlgQ/k=;
        b=X3Q+qaLof/eu0DFR89m7gQn/6gT+BTyfg6uW5GUTN9076Tc/H7WEg3Rn9nCbIYk9to
         sFk8ItAXccaAM10ROnONd4cmr4F88/N/PKhJCEuuN9EngNYzN+wCkhiXHHzrGbjsOj5c
         Fg/zSiwQZc1Cmg5B1mowGhhJdKsrlLIIiw04r+NUiQpcTf70tDIcsvZo1+IibxXFTIoO
         KITAEPIX3cfaqDGsEv9ZT1g8yQ0DzXX01fusCwzAB58px3qFyBiOcYoSAo4QBTjxdgE9
         Yd6KmjOmsP61c2aSSvYd/3vLMvRKxtMs2KdH2Z3v/xZQWAiBS5fNRul6faGsMl5rMtTY
         /WHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrzQdBMb984GoLwSermZKSUJHb2Pj08MtfAszXlgQ/k=;
        b=2otXmcKSrBHbKmdLZ0yeQZrTz8uA3r9tXBu5+trO9G6ELME16W8aO4sYhGn7qjOYdv
         llrpGtpbtZVF55bAVeS/Kgn+daerlS9zsqIzQtxa6GRMkFawJknPv1Ntcnigsl4SBgbs
         uQPj2bifx0aW0dJCu2OiJzV8cLOS8W2OsTFlBBscQqTY+eUiXWHfgVdJJDrfKDfJ7Qi/
         izPr8XwD2Ia8sl6B0UWiwcgt5U6qDaEZOrIZuhMcv8RukFAr0W6R/4c7U91uRi44S9dC
         MHXOrdoeKNp62DD5kkVyigJQ395rBhY7YIClCe+hpzrt2R+d8bd6+4p018QJ8NClTdGG
         yhWQ==
X-Gm-Message-State: AO0yUKVye6xp7nLKb0oXL0NKqh/goJflJxl/f9Y+vmEvUheIe7tprn8F
        LYjJv+v1TEH+MfP6+ZZcvHmw
X-Google-Smtp-Source: AK7set94ohGg+ZPN8FmhK2vwun0FMjWaJ4yRKKML6EHTABq5z5LP5TMYNz3fYPfypqrE+agTNEfmnw==
X-Received: by 2002:a17:902:a604:b0:198:d5cc:44a8 with SMTP id u4-20020a170902a60400b00198d5cc44a8mr352677plq.19.1675893360186;
        Wed, 08 Feb 2023 13:56:00 -0800 (PST)
Received: from google.com (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with ESMTPSA id 25-20020aa79119000000b0058d8f23af26sm3938910pfh.157.2023.02.08.13.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:55:59 -0800 (PST)
Date:   Wed, 8 Feb 2023 21:55:50 +0000
From:   John Stultz <jstultz@google.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com, lkp@intel.com,
        Andrii Nakryiko <andrii@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@google.com>,
        Daniele Di Proietto <ddiproietto@google.com>
Subject: Re: [PATCH v2 7/7] tools/testing/selftests/bpf: replace open-coded
 16 with TASK_COMM_LEN
Message-ID: <Y+QaZtz55LIirsUO@google.com>
References: <20211120112738.45980-1-laoar.shao@gmail.com>
 <20211120112738.45980-8-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120112738.45980-8-laoar.shao@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 11:27:38AM +0000, Yafang Shao wrote:
> As the sched:sched_switch tracepoint args are derived from the kernel,
> we'd better make it same with the kernel. So the macro TASK_COMM_LEN is
> converted to type enum, then all the BPF programs can get it through BTF.
> 
> The BPF program which wants to use TASK_COMM_LEN should include the header
> vmlinux.h. Regarding the test_stacktrace_map and test_tracepoint, as the
> type defined in linux/bpf.h are also defined in vmlinux.h, so we don't
> need to include linux/bpf.h again.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/sched.h                                   | 9 +++++++--
>  tools/testing/selftests/bpf/progs/test_stacktrace_map.c | 6 +++---
>  tools/testing/selftests/bpf/progs/test_tracepoint.c     | 6 +++---
>  3 files changed, 13 insertions(+), 8 deletions(-)

Hey all,
  I know this is a little late, but I recently got a report that
this change was causiing older versions of perfetto to stop
working. 

Apparently newer versions of perfetto has worked around this
via the following changes:
  https://android.googlesource.com/platform/external/perfetto/+/c717c93131b1b6e3705a11092a70ac47c78b731d%5E%21/
  https://android.googlesource.com/platform/external/perfetto/+/160a504ad5c91a227e55f84d3e5d3fe22af7c2bb%5E%21/

But for older versions of perfetto, reverting upstream commit
3087c61ed2c4 ("tools/testing/selftests/bpf: replace open-coded 16
with TASK_COMM_LEN") is necessary to get it back to working.

I haven't dug very far into the details, and obviously this doesn't
break with the updated perfetto, but from a high level this does
seem to be a breaking-userland regression.

So I wanted to reach out to see if there was more context for this
breakage? I don't want to raise a unnecessary stink if this was
an unfortuante but forced situation.

thanks
-john
