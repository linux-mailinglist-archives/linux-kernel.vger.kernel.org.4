Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E93614026
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJaVuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaVuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:50:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E23110FD3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:50:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p3so11911990pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1xYWQhEOetE1UWjkft/KCrJ0U86urDet3ZNm0FcuuU=;
        b=XucucEttMFSGKGNpgn4+HpGJhxrGqFtSlstdOScwKv5QY7MUMGimhqOe7dGThcs1Ze
         Pavbvi1EkR44lJNuCkXMK7MBbvUpX1Z0RKJzwKMkAdrJjpJSyM2Lbw8PtbO+MmcMzAWS
         WrYxEKWHPyAnGU6TnyNF+4TjT5j32/QVh22xtpHIawLntSrB3SJbKgxxh8kp6oUWJKND
         wFPTKBqtc2rJsiR0Jn1PMX8HUC31gbazfFJGvrwFyYDFR11a1MEOibPIC5LN3OEmcKkT
         l8f/IJxC3/uxF2v3CyVZbl0XBpdmAoWDlqT7e4mmrdOCh6RS63LfP0PKXwmyfoeMiYyN
         RlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1xYWQhEOetE1UWjkft/KCrJ0U86urDet3ZNm0FcuuU=;
        b=P8zw2ztylTEsxTSqVkbNZzdlzZiGqXGyDy7ckJGUJe4ZfZAkdPydHNTzzlE7DDzE3H
         Fdp7J44qFYZUVMgdbETFDsxcQqwwzaTEdsJSRBm0omaUAXd54WCiM/OHfwpJnP6VDr2o
         uinX2bgslp+vRwTpyxCzIo65jT7vVZA5EZXaP41LwqfNLHkI+yicDlTEUMArt2GYKFaj
         igYBwh8em8j73JPfMezQzgEThJW9HyNfQADYjxUhBSJX46Mp+ZjigRWlRMET+MzRf4qm
         m0ovXEP7QpPwq1dmOP17QWQRt1M8YhMHxxoXIqTOkM4SVaIhY+DwQXhyzFj0yP5+KxuF
         wAyg==
X-Gm-Message-State: ACrzQf15mliOXDwYlQYZtmIHnIzGRbH/wEYbLF2N+3hXbSr6pUWxyAme
        lkM84jQcVmCzTIde1SNZAbkdt/fTPGs=
X-Google-Smtp-Source: AMsMyM7BCOHpFxHg9oEc7ZMhFMgxHi+2dV44iwbt1Yheah81TQFamC1jHZFJEiq4rO4s2xgL+fDcyA==
X-Received: by 2002:a17:902:f78a:b0:184:f2e2:a5fa with SMTP id q10-20020a170902f78a00b00184f2e2a5famr16307133pln.161.1667253016509;
        Mon, 31 Oct 2022 14:50:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ba13])
        by smtp.gmail.com with ESMTPSA id nk21-20020a17090b195500b0020af2bab83fsm4720330pjb.23.2022.10.31.14.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:50:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Oct 2022 11:50:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
Message-ID: <Y2BDFNpkSawKnE9S@slm.duckdns.org>
References: <20221026224449.214839-1-joshdon@google.com>
 <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
 <CABk29Nu=XcjwRxnGBtKHfknxnDPpspghou06+W0fufnkGF6NkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nu=XcjwRxnGBtKHfknxnDPpspghou06+W0fufnkGF6NkA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Oct 31, 2022 at 02:22:42PM -0700, Josh Don wrote:
> > So, TJ has been complaining about us throttling in kernel-space, causing
> > grief when we also happen to hold a mutex or some other resource and has
> > been prodding us to only throttle at the return-to-user boundary.
> 
> Yea, we've been having similar priority inversion issues. It isn't
> limited to CFS bandwidth though, such problems are also pretty easy to
> hit with configurations of shares, cpumasks, and SCHED_IDLE. I've

We need to distinguish between work-conserving and non-work-conserving
control schemes. Work-conserving ones - such as shares and idle - shouldn't
affect the aggregate amount of work the system can perform. There may be
local and temporary priority inversions but they shouldn't affect the
throughput of the system and the scheduler should be able to make the
eventual resource distribution conform to the configured targtes.

CPU affinity and bw control are not work conserving and thus cause a
different class of problems. While it is possible to slow down a system with
overly restrictive CPU affinities, it's a lot harder to do so severely
compared to BW control because no matter what you do, there's still at least
one CPU which can make full forward progress. BW control, it's really easy
to stall the entire system almost completely because we're giving userspace
the ability to stall tasks for an arbitrary amount of time at random places
in the kernel. This is what cgroup1 freezer did which had exactly the same
problems.

> chatted with the folks working on the proxy execution patch series,
> and it seems like that could be a better generic solution to these
> types of issues.

Care to elaborate?

> Throttle at return-to-user seems only mildly beneficial, and then only
> really with preemptive kernels. Still pretty easy to get inversion
> issues, e.g. a thread holding a kernel mutex wake back up into a
> hierarchy that is currently throttled, or a thread holding a kernel
> mutex exists in the hierarchy being throttled but is currently waiting
> to run.

I don't follow. If you only throttle at predefined safe spots, the easiest
place being the kernel-user boundary, you cannot get system-wide stalls from
BW restrictions, which is something the kernel shouldn't allow userspace to
cause. In your example, a thread holding a kernel mutex waking back up into
a hierarchy that is currently throttled should keep running in the kernel
until it encounters such safe throttling point where it would have released
the kernel mutex and then throttle.

Thanks.

-- 
tejun
