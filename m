Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D3473953B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjFVCHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjFVCHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:07:45 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600A71BDF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 19:07:25 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-763bd31d223so165839785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 19:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687399641; x=1689991641;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fm414ZQs9hckHL/HZAHLxSHPmfm0VdRXO3J4mVGk7as=;
        b=Yh+7zcQKUUs20n43RuH/mnI6UKincOWGapPkVVfkLCI339Rz2Ygw7oxCHLxLu5F1Q5
         8HSlXFWEP2YRuFWbaB2ITm3HLIcYGsUy8GFSlVJFmxVWgNkLh4wWXPwF+CJo8I3NpyNT
         foK6xi2fXHnLWzMjTIdhx6s4L4m+10eCra2UWSKHCjuRmngbdh1Y6DCT8V+DUy7C7hAA
         h9lltxYIgFpspU2byFHZ3oawMHWBwpoqG1RJIIBqV2YiFU9l+HXu+w2YwVIpwqg3flKH
         dH8bPm4EI8WhZ3UJQSIprtYTWZJ20vefxLVI2KW1ulK43+urGvnqG20JXWrhvbFAJgZO
         PmAQ==
X-Gm-Message-State: AC+VfDzXkK3SVMoJWJPk6YadD5KsphKOFQz6TDNf0F2u7WR0IPx+grX4
        B+tH9ZBoqwcIG/74MWYzdB8=
X-Google-Smtp-Source: ACHHUZ5LRCxDWdutcMtRZMgmyvAWy1DDJ31gDm0sipOE92hyuHy/p6zs9RX/wgKPHsw8DXJz3IAmpw==
X-Received: by 2002:a05:620a:3e8b:b0:75b:23a1:8316 with SMTP id tv11-20020a05620a3e8b00b0075b23a18316mr16110104qkn.17.1687399640872;
        Wed, 21 Jun 2023 19:07:20 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:d965])
        by smtp.gmail.com with ESMTPSA id f23-20020a05620a15b700b007623d5d7c59sm1616170qkk.94.2023.06.21.19.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:07:20 -0700 (PDT)
Date:   Wed, 21 Jun 2023 21:07:17 -0500
From:   David Vernet <void@manifault.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com
Subject: Re: [RFC PATCH 1/3] sched: Make migrate_task_to() take any task
Message-ID: <20230622020717.GE15990@maniforge>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-2-void@manifault.com>
 <20230621130439.GF2053369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621130439.GF2053369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 03:04:39PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 12:20:02AM -0500, David Vernet wrote:
> > The migrate_task_to() function exposed from kernel/sched/core.c migrates
> > the current task, which is silently assumed to also be its first
> > argument, to the specified CPU. The function uses stop_one_cpu() to
> > migrate the task to the target CPU, which won't work if @p is not the
> > current task as the stop_one_cpu() callback isn't invoked on remote
> > CPUs.
> > 
> > While this operation is useful for task_numa_migrate() in fair.c, it
> > would be useful if __migrate_task() in core.c was given external
> > linkage, as it actually can be used to migrate any task to a CPU.
> > 
> > This patch therefore:
> > 1. Renames the existing migrate_task_to() be called
> >    numa_migrate_current_task_to().
> > 2. Renames __migrate_task() to migrate_task_to(), gives it global
> >    linkage, and updates all callers accordingly.
> > 
> > A follow-on patch will call the new migrate_task_to() from fair.c when
> > migrating a task in a shared wakequeue to a remote CPU.
> 
> I would suggest simply exposing move_queued_task(). You can actually do
> is_cpu_allowed() before you do the whole lock dance, or even before
> pull.

Good call, I'll make that improvement for v2. Also, ack on exposing
move_queued_task(). That makes more sense.

> And then you don't have to create silly long function names either.

Yeah, the function name I chose is admittedly crap, but IMO it is pretty
unintuitive that p == current. But yeah, it'd probably be better to just
do something like remove the @p parameter and use current directly. That
whole call chain passes p == current around though, so *shrug*.
