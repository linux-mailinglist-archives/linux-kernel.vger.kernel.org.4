Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D825B7CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiIMWD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIMWDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:03:43 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C117436D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:03:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s18so7254368plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NYBaVLRrXbe6H9m02gqcPbG6Tfzo/qSbO9657IGVEGU=;
        b=KuISZK38k47UtmNXtHsh4Po1U2TsA0Mq68x0dGj6QlRcjnGjQLfIMVVq5qDWJyXQw8
         WMJholrGNEk4kauKtc3e/KRRBfmQUhO7Ut2oI1J5/tlZh8/c7k61DUishzbTcQ/pIFNR
         PQ8v21RMBDyFDfqYoXGSelP7mhC+hP/KrYq4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NYBaVLRrXbe6H9m02gqcPbG6Tfzo/qSbO9657IGVEGU=;
        b=iaEPvu/wpy6pstJzspy7bQywB/2JtLbd2gqFpE/qqjpQ/YF4bWVGwkOjoORl6UCuOf
         gSqY+ncl554LmMC0A9MKYg0E/ezUEYNGc9qPwm6xg4FZHEc4RmsRfwpm0u4XknVvG/yE
         w9dgDHUpY9zU8nx2mYBjPq+AIvEI0ycZnLRQEz36PVJay3DjjWhlePXjFXHMW7/Yv27a
         279dag93bvNT6t0yQsM7SobhWoBAH75WOC96bHrlfx2rt3//9cDMSkV0IM+dSmw9luDM
         oL2YMMfD0A6gH1+TG40g55mq0J0trdwKTFnE5S+9EJb/YT4d5FAN3ULWC51cfQRNKo/Q
         Nh1g==
X-Gm-Message-State: ACgBeo0PQFyAUwb2YskyvBa89ojilTk2Jo4jH10vQNGCGJXSoVD7/3ko
        AEuHwUzUlcTfjkP4a5lbynp+fg==
X-Google-Smtp-Source: AA6agR6CNtB1UOHoxi9MrDvudnFn/NsbUZVavc+t+Q3VtrPU/A7zGmxMPrGoIyGLcWGhzziD+9R4VA==
X-Received: by 2002:a17:902:e750:b0:176:b0fb:9683 with SMTP id p16-20020a170902e75000b00176b0fb9683mr34012585plf.71.1663106620537;
        Tue, 13 Sep 2022 15:03:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b00177f4ef7970sm9124775plh.11.2022.09.13.15.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 15:03:39 -0700 (PDT)
Date:   Tue, 13 Sep 2022 15:03:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jorge Merlino <jorge.merlino@canonical.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix race condition when exec'ing setuid files
Message-ID: <202209131456.76A13BC5E4@keescook>
References: <20220910211215.140270-1-jorge.merlino@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910211215.140270-1-jorge.merlino@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 06:12:14PM -0300, Jorge Merlino wrote:
> This patch fixes a race condition in check_unsafe_exec when a heavily
> threaded program tries to exec a setuid file. check_unsafe_exec counts the
> number of threads sharing the same fs_struct and compares it to the total
> number of users of the fs_struct by looking at its users counter. If there
> are more users than process threads using it the setuid exec fails with
> LSM_UNSAFE_SHARE. The problem is that, during the kernel_clone code
> execution, the fs_struct users counter is incremented before the new thread
> is added to the thread_group list. So there is a race when the counter has
> been incremented but the thread is not visible to the while_each_tread loop
> in check_unsafe_exec.

Thanks for reporting this and for having a reproducer!

It looks like this is "failing safe", in the sense that the bug causes
an exec of a setuid binary to not actually change the euid. Is that an
accurate understanding here?

> This patch sort of fixes this by setting a process flag to the parent
> process during the time this race is possible. Thus, if a process is
> forking, it counts an extra user fo the fs_struct as the counter might be
> incremented before the thread is visible. But this is not great as this
> could generate the opposite problem as there may be an external process
> sharing the fs_struct that is masked by some thread that is being counted
> twice. I submit this patch just as an idea but mainly I want to introduce
> this issue and see if someone comes up with a better solution.

I'll want to spend some more time studying this race, but yes, it looks
like it should get fixed. I'm curious, though, how did you find this
problem? It seems quite unusual to have a high-load heavily threaded
process decide to exec.

-Kees

-- 
Kees Cook
