Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F646E9CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjDTUC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjDTUCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:02:55 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149E1B2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 13:02:54 -0700 (PDT)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E10784427C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 20:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682020971;
        bh=me8sddkqoHhu+o5UNk1o5ZrBbxC2BLK+Qjl7lsAFmIU=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=Fe4WNe9yJI+lM6JLXnuV28PpWe4sTNd8JDYPJHOEbksZ6hIfiaUUGMSuDi0swDsW3
         G6wxunKSAeuf5pKqJZDFN6GPFxAMVF/csG7R53LJMJU3thZu1+QUmLJYKFFHoGs/zU
         NIsI96DF/I9J/7e2VumPpImR5e3YpAu/L2+cHzr76WuuH2Xp4FweRZLwrQgkErov6v
         0SQ1CFJERIlxXbLtZaeZUNOmulxj+eXgX4oxOFeM6BQbL6TlEEJlVgyMdCs5cPkTrU
         B2UrRHllgw64pxBkV/07bhyuAzq5UW7rXNOsPTe/MGGluMhwnwRIIWaFQibjcyXej0
         3Ia3vHZtOGkzg==
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2a8bca8b2efso3684401fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 13:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682020969; x=1684612969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me8sddkqoHhu+o5UNk1o5ZrBbxC2BLK+Qjl7lsAFmIU=;
        b=DgaDLb6DjGeaoX94W9dc6AL36VIx1/ychiAEE/SqXiFv0rv6SnEq/Xt6CSM//RyPKi
         V+g/ZJCQHTQlCyJPcF6b52YQkJ0htOeGW8V1Mqsht14CLIMYxhZcHvFVGnpgbNyy2sGq
         ziZsSVvqF/W95bWfQzThBlLgICzsIKiPu0KvjtP19/8SP8gpCNzE/pD7xLbmaW/8uawP
         hqquf68yNrvv+5lAfUNWoLYihElQjoiuHueqY/fO9CYVwmum7rBIUvxk7zNyPBJHtJTI
         XD2FfnaI5CuiB3JeyDsX9AEK0qcDCWwLmMfszSn2ODTCtprLhlf/KxatkCaewGjIFeVZ
         ke9A==
X-Gm-Message-State: AAQBX9exGVclJeMTwuKONseUoF5poive+TLdE70Tv8SxlZYJotpn3qCW
        UDWHOQgmTRNAWZ4myssFlrAWfpW/G+Fd8pJgZDrnLdcMRbYoKmhllGJ8L1xnxHpaLtWyk89VJOp
        b6KlCkhuxKFme+Iqetq8uP8DEZfzn00yKFbuR6sT7xQ==
X-Received: by 2002:a2e:3019:0:b0:2a8:b2e5:4f65 with SMTP id w25-20020a2e3019000000b002a8b2e54f65mr30953ljw.14.1682020968898;
        Thu, 20 Apr 2023 13:02:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350bXpwHlruy+jf2ptQ1Zd/wR8j5qrYfqh/7n1iiCVd2ep1fw4ngmPsqejAh0saIE98fHvnXdew==
X-Received: by 2002:a2e:3019:0:b0:2a8:b2e5:4f65 with SMTP id w25-20020a2e3019000000b002a8b2e54f65mr30918ljw.14.1682020968577;
        Thu, 20 Apr 2023 13:02:48 -0700 (PDT)
Received: from localhost (uk.sesame.canonical.com. [185.125.190.60])
        by smtp.gmail.com with ESMTPSA id e2-20020a2e9302000000b002aa399f6ec5sm72602ljh.132.2023.04.20.13.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:02:48 -0700 (PDT)
Date:   Thu, 20 Apr 2023 22:02:47 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 24/32] sched_ext: Add cgroup support
Message-ID: <ZEGaZ+lQL7pHpmY5@righiandr-XPS-13-7390>
References: <20230317213333.2174969-1-tj@kernel.org>
 <20230317213333.2174969-25-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317213333.2174969-25-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 11:33:25AM -1000, Tejun Heo wrote:
...
> +/**
> + * scx_bpf_task_cgroup - Return the sched cgroup of a task
> + * @p: task of interest
> + *
> + * @p->sched_task_group->css.cgroup represents the cgroup @p is associated with
> + * from the scheduler's POV. SCX operations should use this function to
> + * determine @p's current cgroup as, unlike following @p->cgroups,
> + * @p->sched_task_group is protected by @p's rq lock and thus atomic w.r.t. all
> + * rq-locked operations. Can be called on the parameter tasks of rq-locked
> + * operations. The restriction guarantees that @p's rq is locked by the caller.
> + */
> +struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
> +{
> +	struct task_group *tg = p->sched_task_group;
> +	struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
> +
> +	if (!scx_kf_allowed_on_arg_tasks(__SCX_KF_RQ_LOCKED, p))
> +		goto out;
> +
> +	/*
> +	 * A task_group may either be a cgroup or an autogroup. In the latter
> +	 * case, @tg->css.cgroup is %NULL. A task_group can't become the other
> +	 * kind once created.
> +	 */
> +	if (tg && tg->css.cgroup)
> +		cgrp = tg->css.cgroup;
> +	else
> +		cgrp = &cgrp_dfl_root.cgrp;
> +out:
> +	cgroup_get(cgrp);
> +	return cgrp;
> +}

^ #ifdef CONFIG_CGROUP_SCHED, otherwise we may get build errors, like:

kernel/sched/ext.c:4251:34: error: 'struct task_struct' has no member named 'sched_task_group'

> +
>  BTF_SET8_START(scx_kfunc_ids_any)
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
> @@ -3431,6 +3803,7 @@ BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
>  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)

Ditto.

-Andrea
