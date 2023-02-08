Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359CD68F7E9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjBHTUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjBHTUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:20:15 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004734FC3A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:20:13 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id w3so22110213qts.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 11:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tVsdwV9x8pCvaFEYs78XN22msEhvwisTMcb5e9dXsII=;
        b=O6kVaBh7GObE5POHa29gOoPjHf+yuXp5oQfpBtiUifMGcHJWuXDxiiTxbvtaCgcrH+
         JXah2sFTsfCPU48pxZ5bMHLg1HMXFgMfqHMpM/cWWqCsKhLgqTUGkOp4cb6aLR8jGhNu
         ejbQJvhMQVJtuHlCo/RkjRqmjK9nUqyHtkdyQ+GT0BECHGXdE9GnfvG04xJT/5sHEPSY
         aNUDDcNjFBPUWOsM025Xuh2orriC0VYUsNcI2pp58m6lCEfDCRvhjRumUPlFr6G7HpjM
         xr1y7eZHQ/cyiD6xk5TPzxQmypGL31511zZg1leyx2uj5f8C3IloDdW2aznZiueZKmIl
         5vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVsdwV9x8pCvaFEYs78XN22msEhvwisTMcb5e9dXsII=;
        b=k4fCJl5sLmwFSDV1QOKhdt8uWLYxLoLkuD6SiaKzIXdvVNEY4Ey1jbW8pGC4i0GPbI
         Bd+pIGT2h5arnYyKunQVXcxgBU/uYNNN2NmFU8H/isq+bfeT3Gs18WqzLL8+oOfGJQK0
         yEqSJHqLP7PLLOMzmyhjUvnMOCPjQqqqGa8WWbAKkXfzgVsDSjXeKDmqLRgriV7jxaXN
         ly2+XjxP1ScoIayFHzE46QaDap5BWYhDVxkX8FgJu/jdWDJr9ymsOK8EAdPjJksH6lYR
         07JUbDWKLknXyN6Be308maMJ0LIJicyrkDa9MCojbJxeCd3wqpukWzdH63PBF98Yg8da
         acSg==
X-Gm-Message-State: AO0yUKXBGjT4M7JnDx1Psi6EDG1X4mfYa+TfaV89XTOEM7m/PueVVqCu
        rycMHqTAsE9ijxjjfCeT/A8jwZsthZVoHrZc
X-Google-Smtp-Source: AK7set9lzFjqgGwoXDxheN/3g248yO9nOKJnVC3Cq4KAL1FLQNtSVpDunVhGiS4AAbt55CObJUPm7w==
X-Received: by 2002:ac8:5f83:0:b0:3bb:7702:97f5 with SMTP id j3-20020ac85f83000000b003bb770297f5mr5925842qta.15.1675884013159;
        Wed, 08 Feb 2023 11:20:13 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id cr17-20020a05622a429100b003b63238615fsm11927364qtb.46.2023.02.08.11.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:20:12 -0800 (PST)
Date:   Wed, 8 Feb 2023 14:20:12 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Kairui Song <kasong@tencent.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH 2/2] sched/psi: iterate through cgroups directly
Message-ID: <Y+P17OVZZWVpYIb0@cmpxchg.org>
References: <20230208161654.99556-1-ryncsn@gmail.com>
 <20230208161654.99556-3-ryncsn@gmail.com>
 <20230208172956.GF24523@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208172956.GF24523@blackbody.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 06:29:56PM +0100, Michal Koutn� wrote:
> On Thu, Feb 09, 2023 at 12:16:54AM +0800, Kairui Song <ryncsn@gmail.com> wrote:
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Signed-off-by: Kairui Song <ryncsn@gmail.com>
> 
> Typo?
> 
> > -static inline struct psi_group *task_psi_group(struct task_struct *task)
> > +static inline struct psi_group *psi_iter_first(struct task_struct *task, void **iter)
> >  {
> >  #ifdef CONFIG_CGROUPS
> > -	if (static_branch_likely(&psi_cgroups_enabled))
> > -		return cgroup_psi(task_dfl_cgroup(task));
> > +	if (static_branch_likely(&psi_cgroups_enabled)) {
> > +		struct cgroup *cgroup = task_dfl_cgroup(task);
> > +
> > +		*iter = cgroup_parent(cgroup);
> 
> This seems to skip a cgroup level -- maybe that's the observed
> performance gain?

Hm, I don't think it does. It sets up *iter to point to the parent for
the _next() call, but it returns task_dfl_cgroup()->psi. The next call
does the same: cgroup = *iter, *iter = parent, return cgroup->psi.

It could be a bit more readable to have *iter always point to the
current cgroup - but no strong preference either way from me:

psi_groups_first(task, iter)
{
#ifdef CONFIG_CGROUPS
	if (static_branch_likely(&psi_cgroups_enabled)) {
		struct cgroup *cgroup = task_dfl_cgroup(task);

		*iter = cgroup;
		return cgroup_psi(cgroup);
	}
#endif
	return &psi_system;
}

psi_groups_next(iter)
{
#ifdef CONFIG_CGROUPS
	if (static_branch_likely(&psi_cgroups_enabled)) {
		struct cgroup *cgroup = *iter;

		if (cgroup) {
			*iter = cgroup_parent(cgroup);
			return cgroup_psi(cgroup);
		}
	}
	return NULL;
#endif
}
