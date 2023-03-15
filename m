Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF646BB7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjCOPfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjCOPfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7C730288
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678894466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pZYIzXTigOBNGXmNQGoS7y/FOK0XC+7mJbcMN7lBlrI=;
        b=TPcTvV+BiLET7HNehsFgGsZKOn4qAU/4MMq2vVa6obMB5Gn3aetcMNI8X25jw1cZfTA2Rx
        v4rIH20ZVARM4LjdPPULrlkEoqRNX250kQecSx2cJXXdvUbD+WYuKmLYd8uwDfMDqdC8eg
        bdmr4u8PrIRVHvuGYBF9kQik2uzP/XE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-Dw__bm74PqejJkJEH7t_RA-1; Wed, 15 Mar 2023 11:34:25 -0400
X-MC-Unique: Dw__bm74PqejJkJEH7t_RA-1
Received: by mail-wm1-f70.google.com with SMTP id m28-20020a05600c3b1c00b003ed307fddadso1159135wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678894463;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZYIzXTigOBNGXmNQGoS7y/FOK0XC+7mJbcMN7lBlrI=;
        b=582JkvnaHIVaetK1BjKRkgAuzRkMEwMc/+5r5a8+BiXKUC1468GMHDlmFIPcQnSiSo
         zNPknHpmWTZWbowQb0vhBDhZorWaC0haqa9rwe5pYz4tgfUV1TAI9WvNBp5t+AWj1ALp
         W5YUOG1w5JSIUWWiHRxUo7a7PoszM3lIalCxJ0g8pyXr6kIXM+ltTuIvfKlxXY/IAp8F
         VMHnQpLZo3/dAbVr6Mg5FC89mWAcKifLNkHVulShqwR0Fw3r+67DWusxG6yGESis7Wnt
         t5H/BA99zj2dZ6+HKwIqexwbh/xfy1RoUZxypnbt83ULlvE5uhYQKtfFYTb6W+1kabGS
         kGfA==
X-Gm-Message-State: AO0yUKV3duv68bb8OHK1jh3IRiUZLlwhgQ2891Jq03bmdb78yU9JjKfU
        8QiSQ52OL7N5CjaES/RTkoOlv89GomVdidDLM4cFnSkayzy5XX9ymnTLOqNLnhFcB3Lh+Lh7N87
        3f0S5bcFPTvf2KuIY7CbYygCvvz9Wo0jQ
X-Received: by 2002:a05:600c:3514:b0:3e2:6c6:31a6 with SMTP id h20-20020a05600c351400b003e206c631a6mr18107935wmq.9.1678894463775;
        Wed, 15 Mar 2023 08:34:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set9u32IFgvP0S2pg4UjT86xfJn6ZoNC8upmS8ZKvGHefx94A/PvVTTZ6dTieublUwOdxPkvoZQ==
X-Received: by 2002:a05:600c:3514:b0:3e2:6c6:31a6 with SMTP id h20-20020a05600c351400b003e206c631a6mr18107917wmq.9.1678894463511;
        Wed, 15 Mar 2023 08:34:23 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id e18-20020a056000121200b002cf1c435afcsm4899164wrx.11.2023.03.15.08.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 08:34:22 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yicong Yang <yangyicong@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linuxarm@huawei.com,
        prime.zeng@huawei.com, wangjie125@huawei.com,
        yangyicong@hisilicon.com
Subject: Re: [PATCH] sched/fair: Don't balance migration disabled tasks
In-Reply-To: <20230313065759.39698-1-yangyicong@huawei.com>
References: <20230313065759.39698-1-yangyicong@huawei.com>
Date:   Wed, 15 Mar 2023 15:34:19 +0000
Message-ID: <xhsmhilf2m3k4.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/23 14:57, Yicong Yang wrote:
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7a1b1f855b96..8fe767362d22 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8433,6 +8433,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>       if (kthread_is_per_cpu(p))
>               return 0;
>
> +	/* Migration disabled tasks need to be kept on their running CPU. */
> +	if (is_migration_disabled(p))
> +		return 0;
> +
>       if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
>               int cpu;

That cpumask check should cover migration_disabled tasks, unless they
haven't gone through migrate_disable_switch() yet
(p->migration_disabled == 1, but the cpus_ptr hasn't been touched yet).

Now, if that's the case, the task has to be src_rq's current (since it
hasn't switched out), which means can_migrate_task() should exit via:

        if (task_on_cpu(env->src_rq, p)) {
                schedstat_inc(p->stats.nr_failed_migrations_running);
                return 0;
        }

and thus not try to detach_task(). With that in mind, I don't get how your
splat can happen, nor how the change change can help (a remote task p could
execute migrate_disable() concurrently with can_migrate_task(p)).

I'm a bit confused here, detach_tasks() happens entirely with src_rq
rq_lock held, so there shouldn't be any surprises.

Can you share any extra context? E.g. exact HEAD of your tree, maybe the
migrate_disable task in question if you have that info.

>
> --
> 2.24.0

