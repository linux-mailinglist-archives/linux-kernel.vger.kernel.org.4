Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772D969DA20
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 05:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjBUEhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 23:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjBUEg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 23:36:59 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5969223DA3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 20:36:57 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q5so3697197plh.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 20:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iOetp7KOSbS2oHA8GhFHZWh0mINOTnZj7zT+8oUIWQU=;
        b=LeGzq7wdURi8StllD8CXn4PTHiv8on5YA1SC5gwdZ4SBHsTsWu/1dJTjbhdlo7V0rw
         fgECr/Lb/1yjzNoX9aYkkEtB+I4sQEHv8F+sg4bI7E2IPQSekoJprOzC3eCS+ihbPJWr
         DNNde0Nj0m8b/dgMwPHEJR6yK9mFKKYO7J6iVkrfx6vmXzv10V7R7ibpx9q3a+etJVE8
         Xx7G91M76MaKboniTZt38IN0v3Hm4gtdQfDC0enpGjTqfnJHhF4vmMbpAw8TX3PEUOQ1
         5ddLzG4X2wKO7ivTajzY1AuZdZjHcsUZ22R+y8z+sjRo6S/8oes7rbjG6OzbbQjQ/0C1
         kKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOetp7KOSbS2oHA8GhFHZWh0mINOTnZj7zT+8oUIWQU=;
        b=PoLoDK+SI12YGe43gRlvyLiN8Dtnj/2QRt4K4ZC+n5MP1CCHNvgDD4pLv1Nhpvr3ra
         GnFA/AkD+Ro2aqRjd62VG0Gz9SrIXsvleTT77Zp8cyTzDTKc3N3C6jNJ4DtqFcVS0vYZ
         gkLN9FDoL+yO4u7SSe2kdI47swQ5ErnSMh4qn9zPmqFyxpIlcmZvroN3yzUXIMI0VcyI
         mtd68J27PxkP18hZek5tkjPGIKIm86yqnYXUvz8uh9NAjPreHInNeZnxHNjHEzSBrTri
         F5YOakTnCmmguByT76hS0m2nXYmj5bkPG4h2eaOn0Gmec/WonA5CdxR+jqyYFJn5e8GT
         IRnQ==
X-Gm-Message-State: AO0yUKW5nDNF8mMksxTJGSidWdLuwl27faZ7i+6mTQrP1yiLr4/w2lNl
        h5eEzc6mPnrDf8M8T4Nk7e2NkQ==
X-Google-Smtp-Source: AK7set9AN8D6LRbWqAZjj5540we9C+jh+Tg3R+bard1qHizJkTgty0GMqzWrXdz6oj06C3+bZqzO2g==
X-Received: by 2002:a17:90a:4b4a:b0:234:9fa0:300b with SMTP id o10-20020a17090a4b4a00b002349fa0300bmr3822338pjl.13.1676954216837;
        Mon, 20 Feb 2023 20:36:56 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id 69-20020a17090a0fcb00b00234ba1cfacbsm930680pjz.17.2023.02.20.20.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 20:36:56 -0800 (PST)
Date:   Tue, 21 Feb 2023 10:06:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: make kobj_type structure constant
Message-ID: <20230221043654.6gb454cabnjfg44k@vireshk-i7>
References: <20230220-kobj_type-cpufreq-schedutil-v1-1-7d1c92293457@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230220-kobj_type-cpufreq-schedutil-v1-1-7d1c92293457@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-23, 23:28, Thomas Weiﬂschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  kernel/sched/cpufreq_schedutil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 1207c78f85c1..4c073bd9b001 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -543,7 +543,7 @@ static void sugov_tunables_free(struct kobject *kobj)
>  	kfree(to_sugov_tunables(attr_set));
>  }
>  
> -static struct kobj_type sugov_tunables_ktype = {
> +static const struct kobj_type sugov_tunables_ktype = {
>  	.default_groups = sugov_groups,
>  	.sysfs_ops = &governor_sysfs_ops,
>  	.release = &sugov_tunables_free,
> 
> ---
> base-commit: 5b0ed5964928b0aaf0d644c17c886c7f5ea4bb3f
> change-id: 20230220-kobj_type-cpufreq-schedutil-783c6be6ff14

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
