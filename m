Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F5D61546F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiKAVuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKAVuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:50:00 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC8D2ADC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:49:58 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b29so14645901pfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 14:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G47ufFWCEHkEOl+rpDEPV/WtoyVq/lMFXIhhpklwHVM=;
        b=qeTjhXRSrqE2D98uNzCkHhl5QCRXDZvgR9wiRp0VE7ps8gZHaT8lQ4rfvhrqNlNvsS
         d+VuzED3S1NKdYumslPTE0VwQIDuhgS/TZ92J18nazEJcWP0n5k0dR9Uin8184Y5Xa3p
         oaX5sq2fldrXJZ55ZVMuDLaR+sYXGzaAXGz8thIR+PsRFrYglgwt/yDcSmN1+V0HYdx3
         8NcHdPR+i3n1Mc//DvnnYHPjkWsGUxTGa6B4nMRn+MvzUbXTBSNhZhlZZ7kLHR30ramq
         NspyZme4+QnlvyfrgQDdXLLeU4yanTDZGk9x6s7JQQVam9icibuwXAXIvC07JCLqU3lW
         cXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G47ufFWCEHkEOl+rpDEPV/WtoyVq/lMFXIhhpklwHVM=;
        b=cnYwl/uV8rss+L1j7qkW9vWfSldBnvSzsEtEOFLWDk9SRMzCY/WhvJxN1ok6nbkU7Q
         JbB3HmcCafb3YjzT2/Aj+izJxmZN6rOMYpBwkYGAPQ3UU6rKhBp91BKSo+n2zKXysAqv
         OjeMxcPb9HxQOnCgXg8dTKcdjNCSTFgCymCJN893yjXexkSCM4x071+22AIN/T4N4Dnf
         u0J7ddc7+IDbK4bc7t67SLqyffN2lyJ+dT3gaD130FKD/SMdUCgj71vrjPy+4x1mLyjg
         SqhDu1WFEom/udCiujqeo0MxFrblmltVLcr2uZSW+OVQoeldJNqnr8Ssx+xgp6edGVfB
         SW+g==
X-Gm-Message-State: ACrzQf1COLct9qMkenGU6f2QYPbEQday7YaMLqDgv3ODcbAFoyrzvlkq
        X37tkqeREZIDfNhu2Bx3vOM0QWonIT0=
X-Google-Smtp-Source: AMsMyM7+Xl1r7RD8I5XmNiS+L9JKX9qRSXNqMPGD/GV8eS5fmiN/nl+I3hBAz7TFGBXHKpt3fRpHtg==
X-Received: by 2002:a05:6a00:2409:b0:54e:a3ad:d32d with SMTP id z9-20020a056a00240900b0054ea3add32dmr21622632pfh.70.1667339397956;
        Tue, 01 Nov 2022 14:49:57 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f37f])
        by smtp.gmail.com with ESMTPSA id v18-20020a170902ca9200b00186e8526790sm6783423pld.127.2022.11.01.14.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:49:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 1 Nov 2022 11:49:55 -1000
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
Message-ID: <Y2GUg8CiI68ZBznr@slm.duckdns.org>
References: <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
 <CABk29Nu=XcjwRxnGBtKHfknxnDPpspghou06+W0fufnkGF6NkA@mail.gmail.com>
 <Y2BDFNpkSawKnE9S@slm.duckdns.org>
 <CABk29Nta-RJpTcybgOk9u4DH=1mwQFZsOxFuQ-UpCcTwzjzAuA@mail.gmail.com>
 <Y2Bf+CeQ8x2jKQ3S@slm.duckdns.org>
 <CABk29Nvqv-T1JuAq2cf9=AwRu=y1+YOR4xS2qnVo6+XpWd2UNQ@mail.gmail.com>
 <Y2B6V1PPuCcTXGp6@slm.duckdns.org>
 <CABk29Ns1VWEVRYENud4CW3JQPrcr79i_F2PBTANqt3t-LaYCfQ@mail.gmail.com>
 <Y2FwVX42LIKXSTz3@slm.duckdns.org>
 <CABk29Nua8ZsDfhY+x+VfYDkbkjfXLXTZ5JMVR9uiBygraxDM+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nua8ZsDfhY+x+VfYDkbkjfXLXTZ5JMVR9uiBygraxDM+g@mail.gmail.com>
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

On Tue, Nov 01, 2022 at 01:56:29PM -0700, Josh Don wrote:
> Maybe walking through an example would be helpful? I don't know if
> there's anything super specific. For cgroup_mutex for example, the
> same global mutex is being taken for things like cgroup mkdir and
> cgroup proc attach, regardless of which part of the hierarchy is being
> modified. So, we end up sharing that mutex between random job threads
> (ie. that may be manipulating their own cgroup sub-hierarchy), and
> control plane threads, which are attempting to manage root-level
> cgroups. Bad things happen when the cgroup_mutex (or similar) is held
> by a random thread which blocks and is of low scheduling priority,
> since when it wakes back up it may take quite a while for it to run
> again (whether that low priority be due to CFS bandwidth, sched_idle,
> or even just O(hundreds) of threads on a cpu). Starving out the
> control plane causes us significant issues, since that affects machine
> health. cgroup manipulation is not a hot path operation, but the
> control plane tends to hit it fairly often, and so those things
> combine at our scale to produce this rare problem.

I keep asking because I'm curious about the specific details of the
contentions. Control plane locking up is obviously bad but they can usually
tolerate some latencies - stalling out multiple seconds (or longer) can be
catastrophic but tens or hundreds or millisecs occasionally usually isn't.

The only times we've seen latency spikes from CPU side which is enough to
cause system-level failures were when there were severe restrictions through
bw control. Other cases sure are possible but unless you grab these mutexes
while IDLE inside a heavily contended cgroup (which is a bit silly) you
gotta push *really* hard.

If most of the problems were with cpu bw control, fixing that should do for
the time being. Otherwise, we'll have to think about finishing kernfs
locking granularity improvements and doing something similar to cgroup
locking too.

Thanks.

-- 
tejun
