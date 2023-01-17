Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B8566DEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjAQNan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjAQNag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:30:36 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E35134C2C;
        Tue, 17 Jan 2023 05:30:35 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id x36so10403530ede.13;
        Tue, 17 Jan 2023 05:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBwIoMBPyxUVrndCKlTiGJI/DLVDR0WmkczeSTQwFd4=;
        b=beWkEeyZZuJ+yMBXEOznjupxkcQSbVFWkQ6pYjwk8tfO1hSG10YiU0TKZP595fH0fP
         C8gqgYqdldl+o3S/Ybu/DSwVM+Fh/GDNtZc++Jci2d2+nc4YlggHgnQz2avZ+cMmVwJy
         merKJ8oYzfpvAxDG7gpXYTyPgLyFr8xVUXFaPPv7nkDe1EpPhV0E9V02JuscCyqCODc+
         1AN+juj3ymMz0aYN3yNEQpauo8CM1JqKiesVg8LKNBb2nmSBXxrctL0Zt4WcSlJgAf0Y
         tdDWDHpTKCUflAQWjAsXZI/UJBVhpqMT1A/MPEln1yxhmB2JaWd5ccuTi9EaduFqHDQP
         YWgQ==
X-Gm-Message-State: AFqh2kr16LTEIaV+jkOqqbfK4lQPlWRR/UbHUD2YUUksorwObIVowL2h
        pYr/Yp3OvvAze7n7DjxPhaa+yk/Bh1gCrjLEU/k=
X-Google-Smtp-Source: AMrXdXu3alUkSln2qykUNLTegOZ+xdifU8V3d9czapg5aFnIMArXmnakmgYKdtZVESamFhXZnir11ffTh5InSFRkNZY=
X-Received: by 2002:aa7:dd41:0:b0:47e:4f0b:7ad9 with SMTP id
 o1-20020aa7dd41000000b0047e4f0b7ad9mr238376edw.239.1673962233779; Tue, 17 Jan
 2023 05:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20230115235202.24695-1-bhuwz@163.com>
In-Reply-To: <20230115235202.24695-1-bhuwz@163.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jan 2023 14:30:17 +0100
Message-ID: <CAJZ5v0iobEEpOY-ww6GqBbKk-MKmyWFSLi8akVUM9fZT7foSUw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Send CPUFREQ_CREATE_POLICY notification after
 the perf domain creation.
To:     Vincent Wang <bhuwz@163.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Wang <vincentwang3@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 12:52 AM Vincent Wang <bhuwz@163.com> wrote:
>
> From: Vincent Wang <vincentwang3@lenovo.com>
>
> We found the following issue during kernel boot on android phone:
>
> [    1.325272][    T1] cpu cpu0: EM: created perf domain
> [    1.329317][    T1] cpu cpu4: EM: created perf domain
> [    1.337597][   T76] pd_init: no EM found for CPU7
> [    1.350849][    T1] cpu cpu7: EM: created perf domain
>
> pd init for cluster2 is executed in a kworker thread and
> is earlier than the perf domain creation for cluster2.
>
> pd_init() is called from the cpufreq notification of
> CPUFREQ_CREATE_POLICY in cpufreq_online(), which is earlier
> than that cpufreq_driver->register_em() is called.
>
> To avoid this issue, cpufreq notification should be sent after
> the perf domain creation.
>
> Signed-off-by: Vincent Wang <vincentwang3@lenovo.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7e56a42750ea..af8836069398 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1430,9 +1430,6 @@ static int cpufreq_online(unsigned int cpu)
>                         policy->max_freq_req = NULL;
>                         goto out_destroy_policy;
>                 }
> -
> -               blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> -                               CPUFREQ_CREATE_POLICY, policy);
>         }

AFAICS, in some cases, this may cause cpufreq_online() to send
CPUFREQ_REMOVE_POLICY without sending CPUFREQ_CREATE_POLICY which is
generally confusing to its callers.

I'm wondering if you can reorder the EM registration before the
initialization of frequency QoS for the policy?

>
>         if (cpufreq_driver->get && has_target()) {
> @@ -1506,6 +1503,9 @@ static int cpufreq_online(unsigned int cpu)
>                  */
>                 if (cpufreq_driver->register_em)
>                         cpufreq_driver->register_em(policy);
> +
> +               blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> +                               CPUFREQ_CREATE_POLICY, policy);
>         }
>
>         ret = cpufreq_init_policy(policy);
> --
