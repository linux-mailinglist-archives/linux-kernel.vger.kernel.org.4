Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7186E6005C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiJQDZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiJQDZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:25:26 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604052935C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:25:25 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id u71so9359536pgd.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G1DD2XBNGLKaNLIewsMLGf4TYhfNwQrPT1Ok1DlSAxA=;
        b=hhNPHyV9RoFSzGUk5/QKd5hBOzwWTfZTbi3pzNoqXBx29+G4lB9KQeppiXLl0RiFWE
         0r0D8trWm32WKcUOiG8nsYYvPm/TzbfLtSchKAEl/wjqg/FeKsKw7SMjPRvU+PhCCW6n
         zzRloA5ShBwPmVCjpvRlSspr7SKox+upqCMa8L153NQE5+ipmS7JWfQv5DITwr4vMOJc
         OI0EHbKhmOW96NWZ+x9+/YOQuDT1RGmV6xsrDX7Kg+gGGvqgoCkhojs8hrX0tk+a33fD
         zCZ4XtNQtZdntXW7Ll4CbolmMA9nOWWNCQUbmgNf6rOCzIxqy+YUCtK6TOQ6LTcuRibM
         Lk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1DD2XBNGLKaNLIewsMLGf4TYhfNwQrPT1Ok1DlSAxA=;
        b=n+9WmqJH+8Ip9ADJWlC5cZrth0UH8YyVqXA9YY+3MyasWBm9BgUo+3t9tGtR2FXSbX
         0SwqbHWmO1z2LdRK3jbY9N/3q6DbHVDAbUPGh4nsEnKVrdwjLjF+2mxK7zYlnrlCN23U
         8DYWVZ1G6hqqFHZqeVyhGxUWCl2yMK5mAKsB1vnU62/rHkQIlw832gL+JaWqjxn9L3jI
         shSTuI51VepdEOIYn+O861hLf/zGhYKE0hMC1wk/BV/sYXHkt8V6tD2gyAyMLP9hxM1I
         a3TsULUJBnbvvd6qTWv8wV/X0wWyNz09Hos/CxELbyymjJM/gzfof+iuXAjJR4tbrSXM
         vb4A==
X-Gm-Message-State: ACrzQf0H+KoKWe31eLP6d1z8Al7Nec0hzqoUzETW+cTOBrz5wvpJYa5y
        9sN69wx42UM5kj/Oe4nLLwsQsQ==
X-Google-Smtp-Source: AMsMyM5tDS2pzthbGLZhctWurPacr+3ipAminTHunMNAwYw1fN556+3SgoJV9af8H2eitb/lzucIeg==
X-Received: by 2002:a63:88c7:0:b0:462:79de:dc75 with SMTP id l190-20020a6388c7000000b0046279dedc75mr8875765pgd.458.1665977124935;
        Sun, 16 Oct 2022 20:25:24 -0700 (PDT)
Received: from [10.4.245.17] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id t2-20020aa79462000000b00540a8074c9dsm5718696pfq.166.2022.10.16.20.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 20:25:24 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
X-Google-Original-From: Chengming Zhou <chengming.zhou@linux.dev>
Message-ID: <d5d72856-417a-0fe7-4b1d-3e27c64c1a85@linux.dev>
Date:   Mon, 17 Oct 2022 11:25:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
Content-Language: en-US
To:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20221003214501.2050087-1-connoro@google.com>
In-Reply-To: <20221003214501.2050087-1-connoro@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2022/10/4 05:44, Connor O'Brien wrote:
> Proxy execution is an approach to implementing priority inheritance
> based on distinguishing between a task's scheduler context (information
> required in order to make scheduling decisions about when the task gets
> to run, such as its scheduler class and priority) and its execution
> context (information required to actually run the task, such as CPU
> affinity). With proxy execution enabled, a task p1 that blocks on a
> mutex remains on the runqueue, but its "blocked" status and the mutex on
> which it blocks are recorded. If p1 is selected to run while still
> blocked, the lock owner p2 can run "on its behalf", inheriting p1's
> scheduler context. Execution context is not inherited, meaning that
> e.g. the CPUs where p2 can run are still determined by its own affinity
> and not p1's.

This is cool. We have a problem (others should have encountered it too) that
priority inversion happened when the rwsem writer is waiting for many readers
which held lock but are throttled by CFS bandwidth control. (In our use case,
the rwsem is the mm_struct->mmap_sem)

So I'm curious if this work can also solve this problem? If we don't dequeue
the rwsem writer when it blocked on the rwsem, then CFS scheduler pick it to
run, we can use blocked chain to find the readers to run?

Thanks!

