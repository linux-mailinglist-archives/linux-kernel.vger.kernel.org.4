Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158A46F7D54
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjEEG6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjEEG62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:58:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB021AD20
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:58:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24e2b2a27ebso1361942a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683269906; x=1685861906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZDZ1+PjAiEZQtoPwEy9pwtEVxFqufFD3zBczSh3kD0=;
        b=StEakw9a6lVCtkkEDv+4BvHR6Wxf2jL87YZFGjZTg8SLV7DE4N46KkWbEKPf4uwZAt
         HCa1BPcXKaZhaEW8+73m04vnLkvuSEl6BXzAph2jE7xGC727EywReRr63soA21KEw9P7
         PzCf1n51YIDbT3i0eLwu/sJxZYDOxqFr1fjg0IRUxqJF8bz8aipGOqkA6gzuKx88fh4r
         vcyb5VL/BJBJWkbyPfgMLVpQ3VL7I2FGfaQKslLoJd1UXiCW2xOsHUgA9afEBOtWRnvY
         oujpFKRrLeopu4RIEJONocyherWKTyiUh/+G/pvjPnl31dBJTRRWGgiQSHt+ENpuX+DW
         xqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683269906; x=1685861906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZDZ1+PjAiEZQtoPwEy9pwtEVxFqufFD3zBczSh3kD0=;
        b=Lc03Zv4n+R0b2xpy1E8xHCji9Yd/DefkBvKW2S1chxFqMd97tqRBGGEgqK/wPTMKl8
         h4IK713AlEYFVaQfPSXjGjFziIoA5NJlj9ybz3eJ53vSJPsutvHmnGzqFAvjzsoHgbin
         5axQ/2t6u2FZafvYFhC3fquKCtD48nUvc5PPGWWcUU8DfeUFNXv9SBlBigLl3I0uFRh9
         q+V2ueiuzj3NY4Ckrwe69o4vxdTLxtjc3/TPsN/Ex7KZqbyf0+fyH4i6r65I87N02cKW
         qdskGEgmYgV/AQUIB4BkdXamL0i6/ywkT1xlcF/BmwS4nrCyeA6sh9VDqd/dfbMGyIF1
         rQ8Q==
X-Gm-Message-State: AC+VfDxgYG9h3dnySGoww1JVbinSyb2+y00wN9ZsI8eGDDLjcKPH7UPh
        wcdlJare5vm9YWRu0Y63WG0/NtDalkKDD0WCKKZB6A==
X-Google-Smtp-Source: ACHHUZ4SWTqEC3IZtUTnvtU12URfI9P+BglBCPYWIN5VCnI4J1XVYn4ycqypNKlFeDZEtmxQ2wltXFiQol+b2xk4IO8=
X-Received: by 2002:a17:90b:390e:b0:24e:3254:5d94 with SMTP id
 ob14-20020a17090b390e00b0024e32545d94mr426092pjb.40.1683269905994; Thu, 04
 May 2023 23:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230505060818.60037-1-zhoufeng.zf@bytedance.com> <20230505060818.60037-2-zhoufeng.zf@bytedance.com>
In-Reply-To: <20230505060818.60037-2-zhoufeng.zf@bytedance.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 4 May 2023 23:58:14 -0700
Message-ID: <CA+khW7g_gq1N=cNHC-5WG2nZ8a-wHSpwg_fc5=dQpkweGvROqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Add bpf_task_under_cgroup() kfunc
To:     Feng zhou <zhoufeng.zf@bytedance.com>
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, yangzhenze@bytedance.com,
        wangdongdong.6@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 11:08=E2=80=AFPM Feng zhou <zhoufeng.zf@bytedance.co=
m> wrote:
>
<...>
> ---
>  kernel/bpf/helpers.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index bb6b4637ebf2..453cbd312366 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2149,6 +2149,25 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 =
cgid)
>                 return NULL;
>         return cgrp;
>  }
> +
> +/**
> + * bpf_task_under_cgroup - wrap task_under_cgroup_hierarchy() as a kfunc=
, test
> + * task's membership of cgroup ancestry.
> + * @task: the task to be tested
> + * @ancestor: possible ancestor of @task's cgroup
> + *
> + * Tests whether @task's default cgroup hierarchy is a descendant of @an=
cestor.
> + * It follows all the same rules as cgroup_is_descendant, and only appli=
es
> + * to the default hierarchy.
> + */
> +__bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
> +                                      struct cgroup *ancestor)
> +{
> +       if (unlikely(!ancestor || !task))
> +               return -EINVAL;
> +
> +       return task_under_cgroup_hierarchy(task, ancestor);
> +}
>  #endif /* CONFIG_CGROUPS */
>

I wonder in what situation a null 'task' or 'ancestor' can be passed.
Please call out in the comment that the returned value can be a
negative error, so that writing if(bpf_task_under_cgroup()) may cause
surprising results.

Hao
