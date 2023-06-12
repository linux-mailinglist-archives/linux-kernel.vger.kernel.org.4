Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528B172D0DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjFLUpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbjFLUpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:45:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7D61996
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:44:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b3e3f33e33so49755ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686602617; x=1689194617;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fgw46zt6MDtrMTwsEX7n0XbeWzAiTod4HTnQ2U8CWyw=;
        b=ccJ6qsGRMdSTlWMjwgNgFX4kU9bit8RFNsijJshd0RVmP/hgqqXQ5Py4jiZMneKnaM
         bp8fOfOZC+YCwJFMiRrn6vnb3LnVabfDpmdtl6IdEz2VY3FBHS9lbTPAmY2I7DU9Phfu
         MHCVWA76F6QPxE8MnTJMAbKvOzkvwv2i2C3tTxwWu/XBpYPseShsJypqRT2vrGIFjEQ4
         1xKenFZ9YGRn7mYMHbdwnwez/OgUfZ0GLVUmjqYHcKm2ZdQqCuqqHr3gr6/mEHUiRJre
         v4T9riFyikJtE3xCHWotIon5A0NqHg8swJt5+m1aDVX56N8n0BBov/msh52teEBGRkV5
         8H2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602617; x=1689194617;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fgw46zt6MDtrMTwsEX7n0XbeWzAiTod4HTnQ2U8CWyw=;
        b=RMUtAfbmNbVysMd34bKetaSmMtZJ62ZLsqA4NXzr/bkQbOgTssNdlotIfPJrebUt3G
         Kxwh4VWnIMC4tZzGExS+1vVJpnN1wcSiJ5G+YVQiWarp+VWTEzsusH0xVlW8o1HI4ZOw
         qacab797akgvyT3ohhJjg4h2WFPmSeATeNfAViXkxgKVICuMToGBKMvbJXZ7xs1gY9x8
         BevTv0iiu9uYyDPy0RB6jrAYIF1tnFBq+FbXwXJ0j2hNlnGlLvLkhV+5TM/pFmWJIQ3L
         P8xNA1JwI5U+t88psH/F19fFtnZWiAAbR38zkWfYoBE6lZmBxF6ns1nikYfvFYR4hZQY
         ipMw==
X-Gm-Message-State: AC+VfDybl2Zo6MNeOAlmTgme3QtfNZXAhlbsa4UZYybb6MQtyhen2Sef
        qjR1coW1xQyudYeplFmF7vbMsQ==
X-Google-Smtp-Source: ACHHUZ7JjK58Ghj9H4t56BS27flJsAm8fZkoRR6zo8G0WA9M62S8hWNx3JRHfrl2jD8ZhBC9O2XUUw==
X-Received: by 2002:a17:902:ec8c:b0:1b2:421b:28fa with SMTP id x12-20020a170902ec8c00b001b2421b28famr39246plg.21.1686602617176;
        Mon, 12 Jun 2023 13:43:37 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id bi8-20020a170902bf0800b001b3d7205401sm1893699plb.303.2023.06.12.13.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:43:36 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v2] sched/nohz: Add HRTICK_BW for using cfs bandwidth
 with nohz_full
References: <20230608125228.56097-1-pauld@redhat.com>
Date:   Mon, 12 Jun 2023 13:43:35 -0700
In-Reply-To: <20230608125228.56097-1-pauld@redhat.com> (Phil Auld's message of
        "Thu, 8 Jun 2023 08:52:28 -0400")
Message-ID: <xm26fs6w9zt4.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

> CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> can easily run well past their quotas before a remote tick does
> accounting.  This leads to long, multi-period stalls before such
> tasks can run again.  Use the hrtick mechanism to set a sched
> tick to fire at remaining_runtime in the future if we are on
> a nohz full cpu, if the task has quota and if we are likely to
> disable the tick (nr_running == 1).  This allows for bandwidth
> accounting before tasks go too far over quota.
>
> A number of container workloads use a dynamic number of real
> nohz tasks but also have other work that is limited which ends
> up running on the "spare" nohz cpus.  This is an artifact of
> having to specify nohz_full cpus at boot. Adding this hrtick
> resolves the issue of long stalls on these tasks. Currently
> the scheduler, when faced with these conflicting requirements
> choosed to favor nohz_full even though that is already best
> effort. Here we make it favor respecting the bandwidth
> limitations which are not supposed to be best effort.
>
> Add the sched_feat HRTICK_BW off by default to allow users to
> enable this only when needed.
>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Suggested-by: Juri Lelli <jlelli@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Ben Segall <bsegall@google.com>
> ---
>
> v2: Clean up building issues with various related CONFIG changes. Add a
> check to start the hrtick in __account_cfs_rq_runtime() for when the
> task gets more runtime.

This starts the hrtick before/without going through schedule, but the
fact that it's still the standard hrtick()->task_tick(queued=1) means it
will still set need_resched even if it succeeds at getting runtime.
