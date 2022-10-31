Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72137613FDC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJaVW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJaVW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:22:57 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADF81163
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:22:55 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id d3so18360743ljl.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DFK676x3FEk6RbPboSTijjACbO8bnzzHJh+h7Usxze4=;
        b=rIVWeYtEcrMCgiUEgkdpn86mpWaJ1JVEaBwh5Zhvs+WQIiqoVYjYsYKE5Cq1vKGbHa
         nMrTlJxn0ZiKau/FxUWo3QNTYjktFHPW1NYG20d6TCdoz4cUHjiCe0kgaCxjqdYHQfF5
         KfmNb6OWOnPyU1vRsYjsoO5Tf/9/PsXeY4/g6aUOgMxmZEm4pQ+xXOmu20YHf3FD2RZj
         WbaMx2JbbuuzELJhuHLieIZx8HYHPdEtLit+d6s4iVLOryZFW2T5cM34jNIywyH86iuO
         rqn1dFfNXUoLpLbfb4Yw3amLw1hfYvCqLVfGmmioHLeoRbrLKrkNdqfYT1cs2a0EyzrA
         rfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFK676x3FEk6RbPboSTijjACbO8bnzzHJh+h7Usxze4=;
        b=ufa5VItwR5jJnD125ewRRKSIax8Ngw9Ei2POGYVpHzzGSf8LBTShfulgCU0NX80QWO
         3YBMy6WnGKn2JqIJ8UAQEAPcHaCdoHsxCdXrsZiBsvvFiKFIOnBvRXwi8nsjvXnvgxdG
         NJ1sDXYp7Jzx19xoNS9R0nUVHNyIdYD2nlZLkE9QFX+8XA5LZkdyaraNC02Q4/iALOwN
         r2DACf2pbCwiNhtaHtUKqD4lZfvh4+9CWpwgkQgU5ud/ADUkdMM3FyeraoCAj6nwy3lV
         vpM+KPfII7b8uVdtOmEa614mZRNqKWuiGzJIQCPOpeMl/y4lPaAg0eR92RR+5zLAnQwl
         JaHg==
X-Gm-Message-State: ACrzQf37oZDlR/Y6yR9NNfiHmwE+Y9D5uwMWZzEjlqYEmu6Wvi1+02XN
        MisMAHdwoRVcglE0gzppyOCbwwiwGbEWabqJklCXgA==
X-Google-Smtp-Source: AMsMyM7PtHElb6XApUa/IYc91bMcM9jgeSMXvtWkNR+YmWU23wt6uW0EPAuCXNRUiMv+9GF5LBsiJHS5cmldf2FRMBI=
X-Received: by 2002:a05:651c:1073:b0:277:35ca:5eef with SMTP id
 y19-20020a05651c107300b0027735ca5eefmr6154643ljm.150.1667251373957; Mon, 31
 Oct 2022 14:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221026224449.214839-1-joshdon@google.com> <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 31 Oct 2022 14:22:42 -0700
Message-ID: <CABk29Nu=XcjwRxnGBtKHfknxnDPpspghou06+W0fufnkGF6NkA@mail.gmail.com>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
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

Hey Peter,


On Mon, Oct 31, 2022 at 6:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 26, 2022 at 03:44:49PM -0700, Josh Don wrote:
> > CFS bandwidth currently distributes new runtime and unthrottles cfs_rq's
> > inline in an hrtimer callback. Runtime distribution is a per-cpu
> > operation, and unthrottling is a per-cgroup operation, since a tg walk
> > is required. On machines with a large number of cpus and large cgroup
> > hierarchies, this cpus*cgroups work can be too much to do in a single
> > hrtimer callback: since IRQ are disabled, hard lockups may easily occur.
> > Specifically, we've found this scalability issue on configurations with
> > 256 cpus, O(1000) cgroups in the hierarchy being throttled, and high
> > memory bandwidth usage.
> >
> > To fix this, we can instead unthrottle cfs_rq's asynchronously via a
> > CSD. Each cpu is responsible for unthrottling itself, thus sharding the
> > total work more fairly across the system, and avoiding hard lockups.
>
> So, TJ has been complaining about us throttling in kernel-space, causing
> grief when we also happen to hold a mutex or some other resource and has
> been prodding us to only throttle at the return-to-user boundary.

Yea, we've been having similar priority inversion issues. It isn't
limited to CFS bandwidth though, such problems are also pretty easy to
hit with configurations of shares, cpumasks, and SCHED_IDLE. I've
chatted with the folks working on the proxy execution patch series,
and it seems like that could be a better generic solution to these
types of issues.

Throttle at return-to-user seems only mildly beneficial, and then only
really with preemptive kernels. Still pretty easy to get inversion
issues, e.g. a thread holding a kernel mutex wake back up into a
hierarchy that is currently throttled, or a thread holding a kernel
mutex exists in the hierarchy being throttled but is currently waiting
to run.

> Would this be an opportune moment to do this? That is, what if we
> replace this CSD with a task_work that's ran on the return-to-user path
> instead?

The above comment is about when we throttle, whereas this patch is
about the unthrottle case. I think you're asking why don't we
unthrottle using e.g. task_work assigned to whatever the current task
is? That would work around the issue of keeping IRQ disabled for long
periods, but still forces one cpu to process everything, which can
take quite a while.

Thanks,
Josh
