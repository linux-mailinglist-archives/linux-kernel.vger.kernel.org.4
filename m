Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D5B74452E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjF3XXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjF3XXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:23:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A34F46BC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 16:22:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fba5a8af2cso25365365e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1688167360; x=1690759360;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VK1/OtAJXK8/kraYa6/U+8C0ZuqhuzcqNzn9O4FJGas=;
        b=JIyBKNtRrCvh1/J0Aia88RunCnBe34DcvcRR/xqkto9DKiP0CoJsMe9AEsMrcocQXa
         KXzU0xeE8Ynn4vsjVq6S/1cSMppdCM5vHTv6cycRYhKMbtS8osvCknVpybopDo8HlGmS
         2aY3f2gRBCcrD1RClb7o73Cvr+nsmVkDEnhIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688167360; x=1690759360;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VK1/OtAJXK8/kraYa6/U+8C0ZuqhuzcqNzn9O4FJGas=;
        b=Z4GDd4/Hjx/Zu7AQGEYSRRntiZEEyd4kBNjNxERfS+oXB8qTxC2dj3VC3cYb+2ICQv
         8tzgPD683w9/w5qgZ2NncJiWEFhJRUGmAtbLBw1LP3rv3Z4eVASMlurf/jz6AN5QaNfk
         Z0RuyfwIavwdG1cBaYqC0GrrDW8ubWRsATH+SMg5AQztigO53yGV7FQdU7nuKIwrqlzh
         MHxJolQym1dV/xPzrVRNxcfQsdYAlmR8ZWSd0Hc+f0wGkCyl+01PncTYlPvRk1eIRmVj
         aFiAtOpma7Igs+O2ZF+lUGaWfR7k87kyCwEzaymMVgilSz2nMknW6Tcr7f/H4tf08f1l
         9rXg==
X-Gm-Message-State: AC+VfDwUEJSPaaJ9ArBJSQsN0Q15iI38BI+MBoujJ07zC00AvJyZGptW
        lkryduT5LLm7Wj0k0pJJrI7Drzg3fEKZi+A33//jtg==
X-Google-Smtp-Source: ACHHUZ6SNvsiIRzbKttRMIOu9i80rwHHJPSkwI+4sREgWXjA5v7EnjfhxpCc0WUYy7+esb0YOLV26PhKyYmeg8Pfgl4=
X-Received: by 2002:a05:600c:221a:b0:3f4:a09f:1877 with SMTP id
 z26-20020a05600c221a00b003f4a09f1877mr2789670wml.23.1688167360268; Fri, 30
 Jun 2023 16:22:40 -0700 (PDT)
MIME-Version: 1.0
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 30 Jun 2023 16:22:28 -0700
Message-ID: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
Subject: Expensive memory.stat + cpu.stat reads
To:     cgroups@vger.kernel.org
Cc:     Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We're seeing CPU load issues with cgroup stats retrieval. I made a
public gist with all the details, including the repro code (which
unfortunately requires heavily loaded hardware) and some flamegraphs:

* https://gist.github.com/bobrik/5ba58fb75a48620a1965026ad30a0a13

I'll repeat the gist of that gist here. Our repro has the following
output after a warm-up run:

completed:  5.17s [manual / mem-stat + cpu-stat]
completed:  5.59s [manual / cpu-stat + mem-stat]
completed:  0.52s [manual / mem-stat]
completed:  0.04s [manual / cpu-stat]

The first two lines do effectively the following:

for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/memory.stat
/sys/fs/cgroup/system.slice/cpu.stat > /dev/null

The latter two are the same thing, but via two loops:

for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/cpu.stat >
/dev/null; done
for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/memory.stat
> /dev/null; done

As you might've noticed from the output, splitting the loop into two
makes the code run 10x faster. This isn't great, because most
monitoring software likes to get all stats for one service before
reading the stats for the next one, which maps to the slow and
expensive way of doing this.

We're running Linux v6.1 (the output is from v6.1.25) with no patches
that touch the cgroup or mm subsystems, so you can assume vanilla
kernel.

From the flamegraph it just looks like rstat flushing takes longer. I
used the following flags on an AMD EPYC 7642 system (our usual pick
cpu-clock was blaming spinlock irqrestore, which was questionable):

perf -e cycles -g --call-graph fp -F 999 -- /tmp/repro

Naturally, there are two questions that arise:

* Is this expected (I guess not, but good to be sure)?
* What can we do to make this better?

I am happy to try out patches or to do some tracing to help understand
this better.
