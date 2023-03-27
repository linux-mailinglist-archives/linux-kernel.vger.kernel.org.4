Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02866CAC07
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjC0Rnb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 13:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjC0Rn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:43:29 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42644199F;
        Mon, 27 Mar 2023 10:43:15 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id cn12so39504113edb.4;
        Mon, 27 Mar 2023 10:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679938994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/6QbkEHb4B/BXK0+h2X9zrCNoo1bmDUb4Gn69mm/y8=;
        b=2AfG8+khTMdLcziPL7938DnqzYvtBcVuQ8f2emwA/BTgj9ykX1SNiZH+SvbY7/cv3n
         joMC4YsSCc1b5tZlBOAN9gW3hsoHWs1IcfIctJ4oNGmZS96847R29jZ6NrQBi+/E0eEB
         IbVEDP+nXUG0qsAe/4ltQrCsI1rBMFcLV/KVXGixAJU9st/GzNUW8lflTC33uKg75F7a
         6gLpDMVQK0oG73W6eYzY1qwdHkOM1hK9X24zlligKqX6uF4T4iQScxoTg6ybMR/edbS6
         PzsBSp9nPN9rnGVphqczZNxUoA8733MzjQ4PMezCRvdF6VSwpW/eqncRVwSBqUI3xFMI
         +Xbg==
X-Gm-Message-State: AAQBX9frM55hm7f+ART0ggcUdUF2UnESkltE8gc9zloYUK4IA5/RTSEX
        lcLtzsXdrgX3MJxCTwgCQ96GgiEqAoDVWZfmRC8=
X-Google-Smtp-Source: AKy350aVJX8/CZSaj8yQKpjNWYSfLmfrmTJ9Ofp2ac1yHLIcGHYd0fXXBEpm164oUpi6tJCHXJJl+3F7JAiXlhrqB9A=
X-Received: by 2002:a50:d49e:0:b0:4fc:ebe2:2fc9 with SMTP id
 s30-20020a50d49e000000b004fcebe22fc9mr6249104edi.3.1679938993646; Mon, 27 Mar
 2023 10:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230316074750.289025-1-kazukih0205@gmail.com> <20230316074750.289025-3-kazukih0205@gmail.com>
In-Reply-To: <20230316074750.289025-3-kazukih0205@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 19:43:02 +0200
Message-ID: <CAJZ5v0jncgS6Uh1n3RrTwbwJpEQ+x2Rw5Gr8dcZuVx=W9L8B4Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] PM: s2idle: Fully block the system from entering
 s2idle when cpuidle isn't supported
To:     Kazuki H <kazukih0205@gmail.com>
Cc:     linux-pm@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 8:49 AM Kazuki H <kazukih0205@gmail.com> wrote:
>
> s2idle isn't supported on platforms that don't support cpuidle as of
> 31a3409065d1 ("cpuidle / sleep: Do sanity checks in cpuidle_enter_freeze()
> too").

This simply isn't correct.

As of the above commit, s2idle was still supported without cpuidle as
long as arch_cpu_idle() worked.

> There is a check in the cpuidle subsystem which would prevent the
> system from entering s2idle. However, there is nothing in the suspend
> framework which prevents this, which can cause the suspend subsystem to
> think that the machine is entering s2idle while the cpuidle subsystem is
> not, which can completely break the system.
>
> Block the machine from entering s2idle when cpuidle isn't supported in
> the suspend subsystem as well.

First, please explain why the cpuidle_not_available() check in
cpuidle_idle_call() is not sufficient to avoid the breakage.

> Link: https://lore.kernel.org/all/20230204152747.drte4uitljzngdt6@kazuki-mac
> Fixes: 31a3409065d1 ("cpuidle / sleep: Do sanity checks in cpuidle_enter_freeze() too")
> Signed-off-by: Kazuki H <kazukih0205@gmail.com>
> ---
>  kernel/power/main.c    | 12 +++++++++---
>  kernel/power/suspend.c |  5 +++++
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 31ec4a9b9d70..b14765447989 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -133,6 +133,8 @@ static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
>         for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++) {
>                 if (i >= PM_SUSPEND_MEM && cxl_mem_active())
>                         continue;
> +               if (i == PM_SUSPEND_TO_IDLE && cpuidle_not_available())
> +                       continue;

Not really.

>                 if (mem_sleep_states[i]) {
>                         const char *label = mem_sleep_states[i];
>
> @@ -185,11 +187,15 @@ static ssize_t mem_sleep_store(struct kobject *kobj, struct kobj_attribute *attr
>         }
>
>         state = decode_suspend_state(buf, n);
> -       if (state < PM_SUSPEND_MAX && state > PM_SUSPEND_ON)
> +       if (state == PM_SUSPEND_TO_IDLE && cpuidle_not_available())

And same here.

> +               goto einval;
> +       if (state < PM_SUSPEND_MAX && state > PM_SUSPEND_ON) {
>                 mem_sleep_current = state;
> -       else
> -               error = -EINVAL;
> +               goto out;
> +       }
>
> + einval:
> +       error = -EINVAL;
>   out:
>         pm_autosleep_unlock();
>         return error ? error : n;
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 3f436282547c..55ddf525aaaf 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -556,6 +556,11 @@ static int enter_state(suspend_state_t state)
>
>         trace_suspend_resume(TPS("suspend_enter"), state, true);
>         if (state == PM_SUSPEND_TO_IDLE) {
> +               if (cpuidle_not_available()) {
> +                       pr_warn("s2idle is unsupported when cpuidle is unavailable");
> +                       return -EINVAL;
> +               }
> +
>  #ifdef CONFIG_PM_DEBUG
>                 if (pm_test_level != TEST_NONE && pm_test_level <= TEST_CPUS) {
>                         pr_warn("Unsupported test mode for suspend to idle, please choose none/freezer/devices/platform.\n");
> --

Again, I need to understand what the problem is in the first place.
