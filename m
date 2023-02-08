Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B906C68F785
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjBHSzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHSzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:55:04 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F311A54564
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:54:56 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id g18so19674871qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h8wnkAyp+UT+1C4mbuuq7uAJNtmK6LABMEs9ejaKbmU=;
        b=D6besAl+jnXs8HL2wgkgbCj2qj3xJ9fr/H/QmgZCQOBl/ILNdsAnYnJz5z/T00IMUS
         0LjcTtS5QnJ0TqPgeMn3odKFuB1k7RURDlftGvJvo+M0cbC8W/TgfGGWUivhjQ02WfAL
         hH75lKyYjyXVvWK2I9cGrN8jkuWCEJxrLFUCUo6h3+mPqU280HNWG2VzpHjmXqrErVPu
         Dvuhm6cqJup7Slw5HCYXzdphjvFgXJpe5kkkWwrtB1WN9BwLThsX9bBAvaqbN9Rjn+Jw
         f/6Y7vKq4zhEWwPwKJou0IwNH/fOmSvBArEMpJLpctVxM0xtJhSKz1GfOfQpL+/c/kB1
         srYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8wnkAyp+UT+1C4mbuuq7uAJNtmK6LABMEs9ejaKbmU=;
        b=WSwgTmuDjOLH/2i4fVkYierxLRbEKFL9Epn9J+rfJY3pP0T4th/MdvLW52B4ZtA3hf
         bTomDO7sbb6cBBrB2yc5HxcTmWcv4EFFYZvGpgH/7YvflHRYpJziP2h2GYQkYzkF6A0d
         0Tk+Cw23Y8o1oIpkYyZJZrOvcMkf9RXNjFxDBETWeaqhYm9eu7Q/Jw8jCU0h+eIg5Jxl
         n/QqieOd654DGSXnN8V8E1sdEpOOTyMXvVZXbE7frNlJihbpk76up4+mpZ9gaoznmO1Z
         zDzxuoinLBDv2iasDSppFrqkXYSYV4qNzXMJNYGk/wf0td1kVIxfUELhQWLduOXKwTBd
         VLxg==
X-Gm-Message-State: AO0yUKWGlKtPRecd7cz8B4rywjSuPg3Pnsp1OBqBpDakUq42E56kXyXl
        CvVx1/Zn3JYts3AiSvGwxZ3jSw==
X-Google-Smtp-Source: AK7set/3d3WjKLDEH63J39MH2EzXa4p4t7KNEr1YnbanF9W+SN2fvmo/W5CBEP2v8Cnt+LVKQ1ro2g==
X-Received: by 2002:a05:622a:1044:b0:3ba:1696:87cf with SMTP id f4-20020a05622a104400b003ba169687cfmr15758385qte.44.1675882496039;
        Wed, 08 Feb 2023 10:54:56 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id l23-20020ac84597000000b003b85ed59fa2sm11887320qtn.50.2023.02.08.10.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:54:55 -0800 (PST)
Date:   Wed, 8 Feb 2023 13:54:54 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 1/2] sched/psi: simplify cgroup psi retrieving
Message-ID: <Y+Pv/kIkUz/YlvNi@cmpxchg.org>
References: <20230208161654.99556-1-ryncsn@gmail.com>
 <20230208161654.99556-2-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208161654.99556-2-ryncsn@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kairui,

On Thu, Feb 09, 2023 at 12:16:53AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Since the only case where cgroup_psi should return psi_system instead of
> the cgroup's psi_group is the root cgroup, just set root cgroup's psi to
> point to psi_system to remove the if branch.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Thanks for the patches. They overall look good, and the numbers even
better.

>  include/linux/psi.h    | 2 +-
>  kernel/cgroup/cgroup.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/psi.h b/include/linux/psi.h
> index b029a847def1..9c3a1638b618 100644
> --- a/include/linux/psi.h
> +++ b/include/linux/psi.h
> @@ -33,7 +33,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
>  #ifdef CONFIG_CGROUPS
>  static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
>  {
> -	return cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
> +	return cgrp->psi;
>  }
>  
>  int psi_cgroup_alloc(struct cgroup *cgrp);
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index c099cf3fa02d..1491d63b06b6 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -163,7 +163,12 @@ static struct static_key_true *cgroup_subsys_on_dfl_key[] = {
>  static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);
>  
>  /* the default hierarchy */
> -struct cgroup_root cgrp_dfl_root = { .cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
> +struct cgroup_root cgrp_dfl_root = {
> +	.cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu,
> +#ifdef CONFIG_PSI
> +	.cgrp.psi = &psi_system
> +#endif

Nitpick: customary coding style is to keep a comma even after the last
entry in the struct. Somebody appending new things won't need to touch
the previous last line, which adds diff noise.

With that, please add:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
