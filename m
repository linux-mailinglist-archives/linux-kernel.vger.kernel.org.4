Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D35C65280A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiLTUpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiLTUo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:44:56 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DAA1B9D1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:44:55 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-45c1b233dd7so17929607b3.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cBjT4mczGAcRKDxekCfUuigKoWGhE5GXVDzxsCw5lgg=;
        b=OA4QXKd1zWYDWeOzVIH4Wrq5hlCeBDbXDJWgpzsHk99f4TlV6VjTbZnrGQYSmZIzsp
         wptYRnLPhR0gqxp6ulCpkDMq4n+DAEbCNTd3W0705Vi6ViIVRHozFSAG+Vc6ud9u5XhJ
         F5VLTAa2nRkAY7dVYZRbEMWZa/goOubpR+k1LSoQbHiO5GM9jHhaKxbwsa2aV8VlXoeR
         jFUSkhVqK9NZ2OPbp4t4azw2rU6IQebrmbydwjbXgx5eoblFkjy+GCT+hEIHq3tympjp
         q+b4x3p+FN60peVEBp+HM4OAlUwig2nY1Sko9FzvcUKknWf9/EiHSSDMAk385v5U20aR
         HrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBjT4mczGAcRKDxekCfUuigKoWGhE5GXVDzxsCw5lgg=;
        b=jf7H7i6Nj5Mj6b43R1iii0d/0Gnj50f7WKTrYPPGw9mhk1pZiKFuLX+pioiwpL/pDU
         R1CtMQtf4F9GNgTOqr6os5v/1bsPK2iH56AqgrCWi+GFoQvA9GQ+TeKLQd7YRUHhM/af
         JxEAtlbzI0QH2x1q+E6zYCCTye+vCT3rtE6Y1b7WSn1zJqlpxbOUerM35vkOJ4Pe9Eb6
         tK/luhVQn1XOQXdKyady37mQv9OG2/4wjqJJvhoeVEV86dwhtP2T3771WH6KycyEmWhc
         1uWSDnrzhj4pMvmkJ2bsnOj02bGMkNYZh5H/hsFK3AGy+0v4SQKl7xyzFSZ1GPlCuekB
         FfGA==
X-Gm-Message-State: ANoB5pnbs/MeFPcvj+Z3Mq58YSNuYWH4OA1gRRo84mZ3ouZTEk6BbppT
        7+36Fv5iDs1gqOah02cch2HZEcReF0EtUA==
X-Google-Smtp-Source: AA0mqf6q4KkdILzROX+6s6HGH0tYbSQJMSxDCqi4MHeQm1aNhPJEzlJ9ngPFtJxoZwYj7Jm7hNmp0WB9B/C9SA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:bcd:0:b0:6fc:4d8a:f401 with SMTP id
 196-20020a250bcd000000b006fc4d8af401mr33434506ybl.170.1671569094462; Tue, 20
 Dec 2022 12:44:54 -0800 (PST)
Date:   Tue, 20 Dec 2022 20:44:51 +0000
In-Reply-To: <20221220182745.1903540-3-roman.gushchin@linux.dev>
Mime-Version: 1.0
References: <20221220182745.1903540-1-roman.gushchin@linux.dev> <20221220182745.1903540-3-roman.gushchin@linux.dev>
Message-ID: <20221220204451.gm5d3pdbfvd5ki6b@google.com>
Subject: Re: [PATCH RFC 2/2] mm: kmem: add direct objcg pointer to task_struct
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 10:27:45AM -0800, Roman Gushchin wrote:
> To charge a freshly allocated kernel object to a memory cgroup, the
> kernel needs to obtain an objcg pointer. Currently it does it
> indirectly by obtaining the memcg pointer first and then calling to
> __get_obj_cgroup_from_memcg().
> 
> Usually tasks spend their entire life belonging to the same object
> cgroup. So it makes sense to save the objcg pointer on task_struct
> directly, so it can be obtained faster. It requires some work on fork,
> exit and cgroup migrate paths, but these paths are way colder.
> 
> The old indirect way is still used for remote memcg charging.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

This looks good too. Few comments below:

[...]
> +
> +#ifdef CONFIG_MEMCG_KMEM
> +static void mem_cgroup_kmem_attach(struct cgroup_taskset *tset)
> +{
> +	struct task_struct *task;
> +	struct cgroup_subsys_state *css;
> +
> +	cgroup_taskset_for_each(task, css, tset) {
> +		struct mem_cgroup *memcg;
> +
> +		if (task->objcg)
> +			obj_cgroup_put(task->objcg);
> +
> +		rcu_read_lock();
> +		memcg = container_of(css, struct mem_cgroup, css);
> +		task->objcg = __get_obj_cgroup_from_memcg(memcg);
> +		rcu_read_unlock();
> +	}
> +}
> +#else
> +static void mem_cgroup_kmem_attach(struct cgroup_taskset *tset) {}
> +#endif /* CONFIG_MEMCG_KMEM */
> +
> +#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MEMCG_KMEM)

I think you want CONFIG_LRU_GEN in the above check.

>  static void mem_cgroup_attach(struct cgroup_taskset *tset)
>  {
> +	mem_cgroup_lru_gen_attach(tset);
> +	mem_cgroup_kmem_attach(tset);
>  }
> -#endif /* CONFIG_LRU_GEN */
> +#endif
>  
>  static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long value)
>  {
> @@ -6816,9 +6872,15 @@ struct cgroup_subsys memory_cgrp_subsys = {
>  	.css_reset = mem_cgroup_css_reset,
>  	.css_rstat_flush = mem_cgroup_css_rstat_flush,
>  	.can_attach = mem_cgroup_can_attach,
> +#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MEMCG_KMEM)

Same here.

>  	.attach = mem_cgroup_attach,
> +#endif
>  	.cancel_attach = mem_cgroup_cancel_attach,
>  	.post_attach = mem_cgroup_move_task,
> +#ifdef CONFIG_MEMCG_KMEM
> +	.fork = mem_cgroup_fork,
> +	.exit = mem_cgroup_exit,
> +#endif
>  	.dfl_cftypes = memory_files,
>  	.legacy_cftypes = mem_cgroup_legacy_files,
>  	.early_init = 0,
> -- 
> 2.39.0
> 
