Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99B572EE47
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjFMVwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFMVwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:52:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0161BCD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:52:32 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b4fe2139a8so7305ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686693151; x=1689285151;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owxsvARooF1JqiUzQa0XlavPkJWvuoPCrCJNEJeKH7A=;
        b=7Jt/0cS/OlG9EwR1ok+8kcFfNu/QXf81oVdNiJeOVa6yKczspQ5cw74P/ZgG003fpX
         Q5VpUG2clUTrd+fq3QAzo/sPONTAmZa9Q6CZqeGvcnkED2zpB51L32bhdZYpcYo3MDAb
         52xLJw8NNmaphcwB2c7rpzP8VivKsx2ybtvDLuiuZSb/FU3Bf+al4427vwJXG26vxie8
         wCIC5s/1vxIuhK3HzNvm22SKbhk3ArKX88tZIwtAm3VM677uIrc1QCaatS7LpkJ9kuLq
         t7tdM8nTo62BcSvIkhuWlbN4vWi2ZKRp6e3gHXtP2niCoZ1HJuqWfRNuqdEiZoF7BRN4
         /rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686693151; x=1689285151;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owxsvARooF1JqiUzQa0XlavPkJWvuoPCrCJNEJeKH7A=;
        b=W2mOxsNA+KRkLlzedS1ihf1NSSOXa7yR2VwrRgMqlL7BxSnaqw3d/6T6+jogC7PWUy
         fV4NdSt/f6NY3UingsBJppzjHUJuvNnwfjTXG4kJIAaXV9mqTlT4mJGE3nl8zHu+6PTp
         5gi+R/tDadw8fRcOvLA/L8q3j+hnO6eSzXBoojNmaB9/P72tWoVQ7eYhe1dA/ArxWi6i
         iwKZchRvHXlh31PYEpLDd2CsZV65CuwaKHA4ARJUNXr6GzDK75DZP1zMxd+dWHFB4H1Y
         cfXOoxX2PQ9RStstcMNJXQNy3X0c8KN70OujP0h39YpvvDnhYe2Fy6RaZTR3kPVQbaN9
         YzIA==
X-Gm-Message-State: AC+VfDytycVYnMJazOUBO5H1zDPnUyo/kCCuIBp1dXmd/WZxHyJI8Sj8
        QtnXogza+FXbmlhhwoHuGU5R+L6Xg8qL+RmtclT7rKKT/Ps=
X-Google-Smtp-Source: ACHHUZ7gEkJcXVOFGylA8S8/qzQFhnt1SJjpJ8j6LNrIe278qor7Oz1gRXP4N+quspgfmp+OeH5XAw==
X-Received: by 2002:a17:903:280f:b0:1b0:4687:ba19 with SMTP id kp15-20020a170903280f00b001b04687ba19mr24421plb.10.1686693150637;
        Tue, 13 Jun 2023 14:52:30 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id 26-20020aa7911a000000b0065440a07294sm9314800pfh.95.2023.06.13.14.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 14:52:29 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] sched/core: Avoid multiple calling
 update_rq_clock() in unthrottle_offline_cfs_rqs()
References: <20230613082012.49615-1-jiahao.os@bytedance.com>
        <20230613082012.49615-5-jiahao.os@bytedance.com>
Date:   Tue, 13 Jun 2023 14:52:27 -0700
In-Reply-To: <20230613082012.49615-5-jiahao.os@bytedance.com> (Hao Jia's
        message of "Tue, 13 Jun 2023 16:20:12 +0800")
Message-ID: <xm268rcn9gis.fsf@google.com>
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

Hao Jia <jiahao.os@bytedance.com> writes:

> This WARN_DOUBLE_CLOCK warning is triggered during cpu offline.
> ------------[ cut here ]------------
> rq->clock_update_flags & RQCF_UPDATED
> WARNING: CPU: 0 PID: 3323 at kernel/sched/core.c:741
> update_rq_clock+0xaf/0x180
> Call Trace:
>  <TASK>
>  unthrottle_cfs_rq+0x4b/0x300
>  rq_offline_fair+0x89/0x90
>  set_rq_offline.part.118+0x28/0x60
>  rq_attach_root+0xc4/0xd0
>  cpu_attach_domain+0x3dc/0x7f0
>  partition_sched_domains_locked+0x2a5/0x3c0
>  rebuild_sched_domains_locked+0x477/0x830
>  rebuild_sched_domains+0x1b/0x30
>  cpuset_hotplug_workfn+0x2ca/0xc90
>  ? balance_push+0x56/0xf0
>  ? _raw_spin_unlock+0x15/0x30
>  ? finish_task_switch+0x98/0x2f0
>  ? __switch_to+0x291/0x410
>  ? __schedule+0x65e/0x1310
>  process_one_work+0x1bc/0x3d0
>  worker_thread+0x4c/0x380
>  ? preempt_count_add+0x92/0xa0
>  ? rescuer_thread+0x310/0x310
>  kthread+0xe6/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
>
> The rq clock has been updated in the set_rq_offline(),
> so we don't need to call update_rq_clock() in
> unthrottle_offline_cfs_rqs().
> We only need to call rq_clock_start_loop_update() before the
> loop starts and rq_clock_stop_loop_update() after the loop
> to avoid this warning.
>

Both of these cfsb patches look sensible to me.

Reviewed-By: Ben Segall <bsegall@google.com>
