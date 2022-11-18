Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269CC63003C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiKRWi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiKRWiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:38:24 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7573E9DBAC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:38:23 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 140so6192108pfz.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uLIc69J31JGIJ/aBXa6ZSl0/CZXar2rrJ96XmUIQjIM=;
        b=Joljq7Y1THOtxViBf/OuSyRR126KFQi0+CiU+DfyJOOBKKwLDnvRne5uwz71uu5R4p
         QZrgG/GQjV/3WUj4e/cy026piVlgxiF4u1sqtdK0kntcXDVrPThIJljoifHwhCu0QxD2
         LpqQ2/Anlq6t3y0EgNUGK1IOld92p1S3V1eYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uLIc69J31JGIJ/aBXa6ZSl0/CZXar2rrJ96XmUIQjIM=;
        b=dd2A3XBECg5p61IgC5TLPSCc7WhZ5QOjMhSWkQ88aUKRBO/ZgK8bwFUdFRLc/bhKtY
         pEcar/AcQYOOf194JeOzOn3IjrkcjXYH1gWMoZUMG8brY7wBYAazzyTYd2j827H77mUm
         bb1OeTnRoiFZJbcaNObCn+HF/l2jpoRzCFe2o2zBrxBoFpsKcWgqAJiqvBFopNs46VAa
         iqIgEos2cMqJVI4GhQXM83reMbzTIeIKVnzZrMiBWOh9qnRHcM5sadev9fc5xL38G4ca
         zc6EgWMdQWUl4Gjfhyc9m8EhyWHlQEPrFjHlqHzX/B1M3Ch1bhY6ekCH937+5XHufv42
         ZJNA==
X-Gm-Message-State: ANoB5pkNHkz2i1O2xXDtE04hvQ4DjuEdnKJbuEd31iyHfE7tlaZe4juh
        qyuJs765GHtqC4uCOvMN8gG+pw==
X-Google-Smtp-Source: AA0mqf7t8I9Y6dgAAFJq6A4bUbI+QorqxSh9RZGzat8xEtI0LxqoAQ24XNFvmfjAFOjOCdd6ml4/ww==
X-Received: by 2002:a63:d48:0:b0:474:6739:6a09 with SMTP id 8-20020a630d48000000b0047467396a09mr8618948pgn.292.1668811102995;
        Fri, 18 Nov 2022 14:38:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b00176ba091cd3sm4304511plx.196.2022.11.18.14.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 14:38:22 -0800 (PST)
Date:   Fri, 18 Nov 2022 14:38:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrei Vagin <avagin@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/5 v3] seccomp: add the synchronous mode for
 seccomp_unotify
Message-ID: <202211181438.7D252CDC10@keescook>
References: <20221111073154.784261-1-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221111073154.784261-1-avagin@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 11:31:49PM -0800, Andrei Vagin wrote:
> From: Andrei Vagin <avagin@gmail.com>
> 
> seccomp_unotify allows more privileged processes do actions on behalf
> of less privileged processes.
> 
> In many cases, the workflow is fully synchronous. It means a target
> process triggers a system call and passes controls to a supervisor
> process that handles the system call and returns controls back to the
> target process. In this context, "synchronous" means that only one
> process is running and another one is waiting.
> 
> The new WF_CURRENT_CPU flag advises the scheduler to move the wakee to
> the current CPU. For such synchronous workflows, it makes context
> switches a few times faster.
> 
> Right now, each interaction takes 12µs. With this patch, it takes about
> 3µs.
> 
> v2: clean up the first patch and add the test.
> v3: update commit messages and a few fixes suggested by Kees Cook.

Thanks for the update! If I can get Acks from the sched folks, I think
this looks good to take.

-Kees

> 
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Peter Oskolkov <posk@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tycho Andersen <tycho@tycho.pizza>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> 
> Andrei Vagin (4):
>   seccomp: don't use semaphore and wait_queue together
>   sched: add a few helpers to wake up tasks on the current cpu
>   seccomp: add the synchronous mode for seccomp_unotify
>   selftest/seccomp: add a new test for the sync mode of
>     seccomp_user_notify
> 
> Peter Oskolkov (1):
>   sched: add WF_CURRENT_CPU and externise ttwu
> 
>  include/linux/completion.h                    |  1 +
>  include/linux/swait.h                         |  1 +
>  include/linux/wait.h                          |  3 +
>  include/uapi/linux/seccomp.h                  |  4 +
>  kernel/sched/completion.c                     | 12 +++
>  kernel/sched/core.c                           |  5 +-
>  kernel/sched/fair.c                           |  4 +
>  kernel/sched/sched.h                          | 13 +--
>  kernel/sched/swait.c                          | 11 +++
>  kernel/sched/wait.c                           |  5 ++
>  kernel/seccomp.c                              | 72 +++++++++++++--
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 88 +++++++++++++++++++
>  12 files changed, 204 insertions(+), 15 deletions(-)
> 
> -- 
> 2.37.2
> 

-- 
Kees Cook
