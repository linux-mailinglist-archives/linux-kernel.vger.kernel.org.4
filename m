Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835C46BF227
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjCQUJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCQUJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:09:05 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0424C6EC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:09:04 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p203so6959346ybb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679083743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiU63fzKbrxG6OsvAQO5eoTUgRIjxq/dY+rYtWI2V/Y=;
        b=O3zQpVlmOTiLTFQb7Faze4s9B7m1eqRhe730lI97hcfmDpS5kFaaYVf7wsVLD0aYDf
         rSd/6s/VKT7CPe1IeJVBgpT8tLQsol7A4ArTdTMzv2bhmh3Xdg0KscyPUZbPqb05qUSj
         f5RKWldN0/q6mBLZwkECcux9WaVCew76VEE/U74vIHx1DeW20vh2DSFDgub0K5VZJGzC
         D07tSjuff7OBrYvLn+fQQavGN/8qbLLicJANb+fBGCUQWiaaVRGkYc1xrR8hMgXTccMo
         oMdYqXsFdwVAAha750b/5p1/FUQ6R4sE1VtqiYLo/yF7KSrCxd9xH4L1Nd4rVFe0rdzi
         UDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679083743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiU63fzKbrxG6OsvAQO5eoTUgRIjxq/dY+rYtWI2V/Y=;
        b=rm/2IaYdFkr+qKI0XsZp7an7QRCUKyib2QCwf0sXCJ/NFy14MC9Na0Cvqm/iTfPVs7
         iYruEbg35g5bEy/TSLyvS+0Go4SW3C0dT9Ms5UpumeCQqJiH+j/1bLn/GdVKCw/ArfHP
         K6iyfR6pVlt3/wQ6Y97ajS9Z6uMa6rNU0U9lH4hvN2Sgvucl/Ktg74Ri+W5nU+MglY9z
         CRVq3SwtGb0QJFYbNq21FjPxQZAUV4D6XOzpypR0sA77K/xEwZikPpSzOz34pbgveQ/2
         7yGwiJH8C4ys+oVtVkYpoMCAUHrtGcNufCpTB9FgSF/8+hlXZyrXuH4tx0alAZeYTx0X
         ViAA==
X-Gm-Message-State: AO0yUKXla6NfF1pTZYdA+SAJkVlDgpBTxAtlz6mnvFr0ZQr16Jekp/bS
        LH28x2QQjfuirNhza+3fYp5Ve1v/lyLFJX77gBF3WA==
X-Google-Smtp-Source: AK7set+E7kGxOkwB68SQ5anuvVXg2Hon15ymj8sjOl0ixG4OA/sKg7LmyULFkZn+7bUvVxyXp0Lkz+kTTDBtj5oq4jE=
X-Received: by 2002:a25:3486:0:b0:b56:1f24:7e9f with SMTP id
 b128-20020a253486000000b00b561f247e9fmr509657yba.12.1679083743422; Fri, 17
 Mar 2023 13:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230317134448.11082-1-mhocko@kernel.org> <20230317134448.11082-3-mhocko@kernel.org>
In-Reply-To: <20230317134448.11082-3-mhocko@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 Mar 2023 13:08:52 -0700
Message-ID: <CALvZod7z399WdGDuYFOusaTOpG2BwGrnCtN__QxnjCs4sCB+7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg: do not drain charge pcp caches on remote
 isolated cpus
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 6:44=E2=80=AFAM Michal Hocko <mhocko@kernel.org> wr=
ote:
>
> From: Michal Hocko <mhocko@suse.com>
>
> Leonardo Bras has noticed that pcp charge cache draining might be
> disruptive on workloads relying on 'isolated cpus', a feature commonly
> used on workloads that are sensitive to interruption and context
> switching such as vRAN and Industrial Control Systems.
>
> There are essentially two ways how to approach the issue. We can either
> allow the pcp cache to be drained on a different rather than a local cpu
> or avoid remote flushing on isolated cpus.
>
> The current pcp charge cache is really optimized for high performance
> and it always relies to stick with its cpu. That means it only requires
> local_lock (preempt_disable on !RT) and draining is handed over to pcp
> WQ to drain locally again.
>
> The former solution (remote draining) would require to add an additional
> locking to prevent local charges from racing with the draining. This
> adds an atomic operation to otherwise simple arithmetic fast path in the
> try_charge path. Another concern is that the remote draining can cause a
> lock contention for the isolated workloads and therefore interfere with
> it indirectly via user space interfaces.
>
> Another option is to avoid draining scheduling on isolated cpus
> altogether. That means that those remote cpus would keep their charges
> even after drain_all_stock returns. This is certainly not optimal either
> but it shouldn't really cause any major problems. In the worst case
> (many isolated cpus with charges - each of them with MEMCG_CHARGE_BATCH
> i.e 64 page) the memory consumption of a memcg would be artificially
> higher than can be immediately used from other cpus.
>
> Theoretically a memcg OOM killer could be triggered pre-maturely.
> Currently it is not really clear whether this is a practical problem
> though. Tight memcg limit would be really counter productive to cpu
> isolated workloads pretty much by definition because any memory
> reclaimed induced by memcg limit could break user space timing
> expectations as those usually expect execution in the userspace most of
> the time.
>
> Also charges could be left behind on memcg removal. Any future charge on
> those isolated cpus will drain that pcp cache so this won't be a
> permanent leak.
>
> Considering cons and pros of both approaches this patch is implementing
> the second option and simply do not schedule remote draining if the
> target cpu is isolated. This solution is much more simpler. It doesn't
> add any new locking and it is more more predictable from the user space
> POV. Should the pre-mature memcg OOM become a real life problem, we can
> revisit this decision.
>
> Cc: Leonardo Br=C3=A1s <leobras@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Reported-by: Leonardo Bras <leobras@redhat.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Suggested-by: Roman Gushchin <roman.gushchin@linux.dev>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
