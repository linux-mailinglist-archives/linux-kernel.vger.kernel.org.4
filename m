Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1ED6D6D8E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbjDDUFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjDDUFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:05:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C010D3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:05:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j24so34098283wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 13:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1680638739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFPo6vLpdwROFw5FNiJbZtKSQ4a0CmbJfxVbod1mMGg=;
        b=fno1tiY9rBhhOuM2df2ewT0wd3fPnGEDZeT7u2R/9NgBGXE4sBFyZUoEsTJj552o2G
         eBw3h3aQX+R2r9UFRTstZ3pkQO5kG0ZydD18fzZyFwrCk4k58DtKBcFm+oQlRZVOUyQS
         ZZWycYR/GLxiimAq/G77KpUhr6DTOdqsvnzWPxHUlvEX79eQBcT8oGHsBFhRdV9SyTup
         +mRJLBiyBqEMcRF9eqs+Oot7YfHVyg/56WeCk1+tSak91mLav/Dc2dbjkPnFskA0mswW
         a9Nyp3WBw0lFRQ9Zr2n+/g2+B/3US2I7YsD6dQOyfe3swaIM5sH1VtuUdg3c7sZ6P5hw
         zQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680638739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFPo6vLpdwROFw5FNiJbZtKSQ4a0CmbJfxVbod1mMGg=;
        b=X0S4d0bTM5tv3B5JhCzw2w9UU1ebm3CMP+a34fULK+XpYBzxe//0yvkq806kSncl0b
         Yrp7p76weokceWAGN0DcoKRUkpj1kOuqCCbJyKZW6R51rynfuj2XPCPQHSWx6lMbvPlJ
         vBiRAfIcj/aONKdDCeRLblAGWcsvKgzKPZqwZgcVM/sC19iVLysg1xbql0zbVWHgynbJ
         q5cuL/GucxwoEcoHdSNsvEl8jN3k4Syr3i9Hsr262mz3ch1bcSVOfWH1JoQny2xlSJ/U
         dsxvG/WSCsz0gSvUAX8D5CP3RGpgTia6bpbyUd16ttQDE0Uc509ThIuxKwKdKH7BXog2
         h7pg==
X-Gm-Message-State: AAQBX9fj4NcomiXdvUH70SkviYUP4wpvob48U/aZE9TcrKOJ724/2auU
        5O5Smtw/0+9sRaRQvFhGX3sXkw==
X-Google-Smtp-Source: AKy350aLxU7DKfB4/xT8bwUVRJL4VX6+UiDqnaGoqBj+5vNcGvt4cLJNSB6mV3h1BqNAvpOuagttyw==
X-Received: by 2002:a05:6000:1b84:b0:2ce:a758:d6fb with SMTP id r4-20020a0560001b8400b002cea758d6fbmr314105wru.1.1680638739550;
        Tue, 04 Apr 2023 13:05:39 -0700 (PDT)
Received: from airbuntu (host86-163-35-64.range86-163.btcentralplus.com. [86.163.35.64])
        by smtp.gmail.com with ESMTPSA id e38-20020a5d5966000000b002d78a96cf5fsm13171657wri.70.2023.04.04.13.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:05:39 -0700 (PDT)
Date:   Tue, 4 Apr 2023 21:05:37 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/6] cgroup/cpuset: Rename functions dealing with
 DEADLINE accounting
Message-ID: <20230404200537.l57oqyixbneuvxis@airbuntu>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-2-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230329125558.255239-2-juri.lelli@redhat.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/23 14:55, Juri Lelli wrote:
> rebuild_root_domains() and update_tasks_root_domain() have neutral
> names, but actually deal with DEADLINE bandwidth accounting.
> 
> Rename them to use 'dl_' prefix so that intent is more clear.
> 
> No functional change.
> 
> Suggested-by: Qais Yousef <qyousef@layalina.io>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---

Reviewed-by: Qais Yousef <qyousef@layalina.io>
Tested-by: Qais Yousef <qyousef@layalina.io>


Thanks!

--
Qais Yousef

>  kernel/cgroup/cpuset.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 636f1c682ac0..501913bc2805 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1066,7 +1066,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
>  	return ndoms;
>  }
>  
> -static void update_tasks_root_domain(struct cpuset *cs)
> +static void dl_update_tasks_root_domain(struct cpuset *cs)
>  {
>  	struct css_task_iter it;
>  	struct task_struct *task;
> @@ -1079,7 +1079,7 @@ static void update_tasks_root_domain(struct cpuset *cs)
>  	css_task_iter_end(&it);
>  }
>  
> -static void rebuild_root_domains(void)
> +static void dl_rebuild_rd_accounting(void)
>  {
>  	struct cpuset *cs = NULL;
>  	struct cgroup_subsys_state *pos_css;
> @@ -1107,7 +1107,7 @@ static void rebuild_root_domains(void)
>  
>  		rcu_read_unlock();
>  
> -		update_tasks_root_domain(cs);
> +		dl_update_tasks_root_domain(cs);
>  
>  		rcu_read_lock();
>  		css_put(&cs->css);
> @@ -1121,7 +1121,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>  {
>  	mutex_lock(&sched_domains_mutex);
>  	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> -	rebuild_root_domains();
> +	dl_rebuild_rd_accounting();
>  	mutex_unlock(&sched_domains_mutex);
>  }
>  
> -- 
> 2.39.2
> 
