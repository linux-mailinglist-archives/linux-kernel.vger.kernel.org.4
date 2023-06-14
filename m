Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0224573063C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjFNRpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjFNRpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:45:15 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24B21BF0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:45:13 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-43f55b63ebfso213714137.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686764713; x=1689356713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rlCqyg/Yc+HEJru3BcMV2FLXrQMFTyeLgIEwLJkjWNQ=;
        b=Ozqa/7gOuJsY9IASinCGkUWD/RvzMZZH+rjRKiN1bKGcQKulIzLJdHR3tF1/crO/1w
         ABhrDG/rnmqa6FeHAWg3w0+LKRimq34d+fx9Y8YKraZWXsAYp+824/1FL6SoUkvj7h4P
         QVzjv7b1G1R7MebLEMDcKJAEDo5ha5Jirz3yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764713; x=1689356713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlCqyg/Yc+HEJru3BcMV2FLXrQMFTyeLgIEwLJkjWNQ=;
        b=H95BWEOK5ukq6ADmG/4hllPKrn+88yDURaJPPvZ28kULPPS1g1rS1H+F1Cy/oyB0t4
         l1+t/8l+ft3cjZPhM7bh6+Ypm+t+13HJlfKoPHBk2M03VbvP+sZs2UryNZoFUYxidJN4
         WRKj8NgqztGNoH+nUhV+EvpCDYBikPkCtj39ItdNtyRRG3I1PwEitMJKcokuElNRVPGR
         w9qRkWE0neGGOp7LN91hn+lhNDv+5D77lQChysuvhALXr0CGa1Lqo9hm8B8KQ9hUkfMP
         NLQiuee4jidP1lYapugHiWz6Izv2xiigvW3hyIiLJHGfCssc1H87L0MSD15RV6/5HNSc
         qFfQ==
X-Gm-Message-State: AC+VfDwyYV2EPCi7u2iD++tXfZGwiMJ+T8nwKUcjtdnSIbL4NAk3eZOx
        6QDI9hq3tw0UFw8dE0rIop+d/RLqwOLtau3Rtz7IokOy
X-Google-Smtp-Source: ACHHUZ63MkGnbaabwSnMZKkBkP6rmRvxNHmmBcF4b2AvZPMpU2xjUrJzH1qeRF/wcuxLv4EKy/zQPw==
X-Received: by 2002:a67:b34d:0:b0:43b:3fcd:6923 with SMTP id b13-20020a67b34d000000b0043b3fcd6923mr6979412vsm.7.1686764712819;
        Wed, 14 Jun 2023 10:45:12 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id n8-20020ab05408000000b0077d41de19e3sm2519270uaa.34.2023.06.14.10.45.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 10:45:12 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-78f208ebf29so292360241.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:45:12 -0700 (PDT)
X-Received: by 2002:a67:e913:0:b0:43b:4a1e:b15b with SMTP id
 c19-20020a67e913000000b0043b4a1eb15bmr6906150vso.2.1686764712050; Wed, 14 Jun
 2023 10:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <2392dcb4-71f4-1109-614b-4e2083c0941e@kernel.dk>
 <20230614005449.awc2ncxl5lb2eg6m@zlang-mailbox> <5d5ccbb1-784c-52b3-3748-2cf7b5cf01ef@kernel.dk>
In-Reply-To: <5d5ccbb1-784c-52b3-3748-2cf7b5cf01ef@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Jun 2023 10:44:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiotpcKvBWGneGjNA4eOGUsY+KTMCVsMxsGhXGCg=n=bA@mail.gmail.com>
Message-ID: <CAHk-=wiotpcKvBWGneGjNA4eOGUsY+KTMCVsMxsGhXGCg=n=bA@mail.gmail.com>
Subject: Re: [PATCH] io_uring/io-wq: don't clear PF_IO_WORKER on exit
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Zorro Lang <zlang@redhat.com>, io-uring <io-uring@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 at 18:14, Jens Axboe <axboe@kernel.dk> wrote:
>
> +       preempt_disable();
> +       current->worker_private = NULL;
> +       preempt_enable();

Yeah, that preempt_disable/enable cannot possibly make a difference in
any sane situation.

If you want to make clear that it should be one single write, do it
with WRITE_ONCE().

But realistically, that won't matter either. There's just no way a
sane compiler can make it do anything else, and just the plain

        current->worker_private = NULL;

will be equivalent.

If there are ordering concerns, then neither preemption nor
WRITE_ONCE() matter, but "smp_store_release()" would.

But then any readers should use "smp_load_acquire()" too.

However, in this case, I don't think any of that matters.

The actual backing store is free'd with kfree_rcu(), so any ordering
would be against the RCU grace period anyway. So the only ordering
that matters is, I think, that you set it to NULL *before* that
kfree_rcu() call, so that we know that "if somebody has seen a
non-NULL worker_private, then you still have a full RCU grace period
until it is gone".

Of course, that all still assumes that any read of worker_private
(from outside of 'current') is inside an RCU read-locked region. Which
isn't actually obviously true.

But at least for the case of io_wq_worker_running() and
io_wq_worker_sleeping, the call is always just for the current task.
So there are no ordering constraints at all. Not for preemption, not
for SMP, not for RCU. It's all entirely thread-local.

(That may not be obvious in the source code, since
io_wq_worker_sleeping/running gets a 'tsk' argument, but in the
context of the scheduler, 'tsk' is always just a cached copy of
'current').

End result: just do it as a plain store.  And I don't understand why
the free'ing of that data structure is RCU-delayed at all. There does
not seem to be any non-synchronous users of the worker_private pointer
at all. So I *think* that

        kfree_rcu(worker, rcu);

should just be

        kfree(worker);

and I wonder if that rcu-freeing was there to try to hide the bug.

But maybe I'm missing something.

            Linus
