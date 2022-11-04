Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93E561A22B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiKDU3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiKDU3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:29:46 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A9D2FC1D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:29:43 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 7so2549930ybp.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 13:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9lN8ClmqA674CDnsqxBY6p6j1UzI10/WvSrphQFuarg=;
        b=V2arLZ4qwc9DOfaPJPZhbjmyn9Lvc4HJj3lXbxTWQGVbFGEUjO5CUDOrH/F/Ygoq8T
         MLzyY3yhqAjRtejxx3oMuFJOyVtKPedTMhxJi0TIc7cPx5IRxmHFTbqfFkNjPSHpGkUE
         Dm+uvPZccR8IS2XwpzvT8OjWe03H+ODyJ3qkkTH0ltyEt+KLl2Gr+nzkc65N1tSc1yn6
         LBt7Wnlgm/+Urj5ENeUPuPaXosM+DpjJGnG6uXpM1H1gVZCf8PsD5hgDi62sNHI9fHf6
         8eD1fYLowhVp2tQ11OPcVwkXSNqNS6YN0CmVFquxMQLQMZrsQ83vPwp9wsh8h9jbYM4h
         JQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lN8ClmqA674CDnsqxBY6p6j1UzI10/WvSrphQFuarg=;
        b=Z7Jbq9iqGUk4kG2nHX0jat3EmQRHzN0yoj3QbpY1Sxccr4Zlqh/WLs7+0rmGPM/czz
         T/WqmhdhdgbHapTV+IcVpYxf0LxWP9+3HaVY0/kfeJuvTIeYnRLlsRhwMgc/VLTvr65y
         YwSVZ6Ji2lA0FtUGU3UdTw0ZVkrikcVhN0EZs9ZlLCZrVj5I425VqnCedZGxDxqcTlMZ
         PRsoelo88ngQ3zm8exx7ZkPIiDGAik8Qs10fnGtwuekKQUVr3iy/QwZzkj6CYKbiSBDr
         FVKE3QLAvM7hvQTTv0rF8nJZMgC1VL6Bmm5DMxUdx1YSaTArUj5GxE/aEWKQAP4gJLGp
         hA8A==
X-Gm-Message-State: ANoB5pnxsohO09nmlFet4AGO4XgCv3vkbEYpfq2OYKfSjy7g24LKXkzO
        jOPYPRiaQnpvvz6ySfmSHXjj44DW1U3jbJUY0Or5qpxA2r4=
X-Google-Smtp-Source: AA0mqf7lkvprPwZ62m6L1tkLFO+gEiKhDLQr6Lxs7sCRqmIUFcUolKdepqdvlq5nA9s9Pv2V5CUSZOBbeDCPaBRKrfs=
X-Received: by 2002:a25:cece:0:b0:6d3:911f:27fd with SMTP id
 x197-20020a25cece000000b006d3911f27fdmr3559330ybe.340.1667593782651; Fri, 04
 Nov 2022 13:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221104054053.431922658@goodmis.org> <20221104054917.543373979@goodmis.org>
 <Y2VyAZkTLj3kasA4@cmpxchg.org>
In-Reply-To: <Y2VyAZkTLj3kasA4@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 4 Nov 2022 13:29:31 -0700
Message-ID: <CAJuCfpHDj3bR6+SGPbfGAxcE2WfWWm-h+sXp6s+Hp4BB2eTj9A@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 31/33] timers: sched/psi: Use timer_shutdown_sync()
 before freeing timer
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 1:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Nov 04, 2022 at 01:41:24AM -0400, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >
> > Before a timer is freed, timer_shutdown_sync() must be called.
> >
> > Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
> >
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Assuming the whole patchset makes it through the reviews, this part LGTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
