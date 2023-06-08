Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5C972866D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjFHRhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjFHRhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:37:03 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8CC270B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:37:02 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-258b62c7a6bso768221a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686245822; x=1688837822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5HMiXJj25/0cs+VQWx8wtIMazP9D7ttY2YMsSjDM3k=;
        b=e/c15UQDeZn5gVYdCP1WTVUOnES+ksevPkbz0RqG+FbeFuOa1OmqHpbYb7HMmwiBRg
         L01Vbb2O2AvFXQNR4FCyB+Z9OG6phe8RA0XyHjgmByAbCi+XN/GT+5GoOPENmUEqQ122
         wLZw9SzLsBYt5PhJrdVvPfUKM1q/jzBTj0qfx05ZbA51cuJVlTrlAzxLvd3cXcCoostm
         fRzqaAmJ0T5a6qVQ105CVZGLjDrGqZY/q2PRL0OUW+aI4txyNqqaD+yZKOHf//MKVbxZ
         ARC/YEkAmMSg7PjqR6YxTFdSm6Z6wuz8A1ZipIaSzu5kP5otynNe2Uu40jpWpEI/v2TP
         OiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686245822; x=1688837822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5HMiXJj25/0cs+VQWx8wtIMazP9D7ttY2YMsSjDM3k=;
        b=Y/kv9J8bBqZIoZTMVNhtgQbHk5qE/1a0W1/1CAW1pnnHPXQLkV7J3yETI1EuckOwpf
         aQly66V/RTeP+cSyT6hMt5I8E20kFvUIOpLPVNe/GXg6XD2N4q4dudrzsDce1g9sto7f
         xflFS7Lw4l3EYKIuWcl7kUxFf9aHLNjEZ5Faia7Z6FGPk11d1rfSYtmTJHGE/Zmc+W4A
         pLX3O9YrvIb4W3fkMmjP5iEpsNh+qEVSJESOAdwufTY3P4SXrKJqMc+BATRerkw9jK+R
         69gxY117XGlWvUvNhMDuocw4Bm89XCe5ZP7VK+zwvz8qApjMnJTcAvyyPMwUIBVVIrS5
         PQhg==
X-Gm-Message-State: AC+VfDxQyfaB0uf0B6xXCLFNdTORnVhVXdOi2i06Jq78L/cC7DdN8V/c
        yENE0EC0uLdVsgDuU7YLL+FDKGZLvGPpJA==
X-Google-Smtp-Source: ACHHUZ74G/VJbIfySxv6uBggTimaPqijqNP4UNpTFxQCf/GcIiJkljU1WVA4BLSOA08kPiDEVcYA+854RqbX2Q==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:f95:b0:256:b9d1:4e34 with SMTP id
 ft21-20020a17090b0f9500b00256b9d14e34mr2339447pjb.5.1686245822177; Thu, 08
 Jun 2023 10:37:02 -0700 (PDT)
Date:   Thu, 8 Jun 2023 17:37:00 +0000
In-Reply-To: <20230608111408.s2minsenlcjow7q3@quack3>
Mime-Version: 1.0
References: <20221024052841.3291983-1-shakeelb@google.com> <20230608111408.s2minsenlcjow7q3@quack3>
Message-ID: <20230608173700.wafw5tyw52gwoicu@google.com>
Subject: Re: [PATCH] mm: convert mm's rss stats into percpu_counter
From:   Shakeel Butt <shakeelb@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.cz, vbabka@suse.cz,
        regressions@lists.linux.dev, Yu Ma <yu.ma@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 01:14:08PM +0200, Jan Kara wrote:
[...]
> 
> Somewhat late to the game but our performance testing grid has noticed this
> commit causes a performance regression on shell-heavy workloads. For
> example running 'make test' in git sources on our test machine with 192
> CPUs takes about 4% longer, system time is increased by about 9%:
> 
>                        before (9cd6ffa6025)  after (f1a7941243c1)
> Amean     User         471.12 *   0.30%*     481.77 *  -1.96%*
> Amean     System       244.47 *   0.90%*     269.13 *  -9.09%*
> Amean     Elapsed      709.22 *   0.45%*     742.27 *  -4.19%*
> Amean     CPU          100.00 (   0.20%)     101.00 *  -0.80%*
> 
> Essentially this workload spawns in sequence a lot of short-lived tasks and
> the task startup + teardown cost is what this patch increases. To
> demonstrate this more clearly, I've written trivial (and somewhat stupid)
> benchmark shell_bench.sh:
> 
> for (( i = 0; i < 20000; i++ )); do
> 	/bin/true
> done
> 
> And when run like:
> 
> numactl -C 1 ./shell_bench.sh
> 
> (I've forced physical CPU binding to avoid task migrating over the machine
> and cpu frequency scaling interfering which makes the numbers much more
> noisy) I get the following elapsed times:
> 
>          9cd6ffa6025    f1a7941243c1
> Avg      6.807429       7.631571
> Stddev   0.021797       0.016483
> 
> So some 12% regression in elapsed time. Just to be sure I've verified that
> per-cpu allocator patch [1] does not improve these numbers in any
> significant way.
> 
> Where do we go from here? I think in principle the problem could be fixed
> by being clever and when the task has only a single thread, we don't bother
> with allocating pcpu counter (and summing it at the end) and just account
> directly in mm_struct. When the second thread is spawned, we bite the
> bullet, allocate pcpu counter and start with more scalable accounting.
> These shortlived tasks in shell workloads or similar don't spawn any
> threads so this should fix the regression. But this is obviously easier
> said than done...
> 

Thanks Jan for the report. I wanted to improve the percpu allocation to
eliminate this regression as it was reported by intel test bot as well.
However your suggestion seems seems targetted and reasonable as well. At
the moment I am travelling, so not sure when I will get to this. Do you
want to take a stab at it or you want me to do it? Also how urgent and
sensitive this regression is for you?

thanks,
Shakeel

