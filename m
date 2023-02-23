Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299456A0FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBWS6t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Feb 2023 13:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjBWS6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:58:47 -0500
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA74D2735;
        Thu, 23 Feb 2023 10:58:46 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id d30so4622211eda.4;
        Thu, 23 Feb 2023 10:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwc4X+1F9/TAvKcqjr/9cfQ8o6wUCynxpVaY44cLuWI=;
        b=ISe2x56PnOGo0L1M81BHy1qFJP0AldtOcIROVPVLngGY5POjj0hjh2VHI7osCga2B6
         yslJRAtMtk6oxpxn9RPhqgiCdRHzSoB+BH+8CZZLeMQwiYNZDQgN3nRhnyAaENeneTub
         DNaT+qbRYwVBCFr6f8lXfkPNIjhqKRm5BDTU4mxnBdwdaQ0cY21mzZlmOOYZzS03LnPQ
         sOBqVqSvFEXgDo+9iF6xK2YarGCN3BBB3o4vnK2t+g/GWKe7ISr2oQJzlowTFvT2GYZm
         PEtbbYjGZfx9pZaMNLorkBazz/41wiZtuAdoP0jFJuOHsVWSIJ+ewVbUtn4LPrKkX3lr
         93rw==
X-Gm-Message-State: AO0yUKWAbhPBXhbFn1QwQt2eeieHDIYgeV8FQ+OnIBmS53+JYlcrtghG
        cXdahJDwANPiv/6yOn/+8VfPfDU8f6S4fFeCav0=
X-Google-Smtp-Source: AK7set8hqqCq8CmD2NpTOYT7jGhjE4Fxg0wS54FoNgb3JpQr0kn60zL1pTPJb6BR+1zvEvWivHIbe+GB5r/0/SG808Q=
X-Received: by 2002:a50:c00a:0:b0:4af:69e2:52f9 with SMTP id
 r10-20020a50c00a000000b004af69e252f9mr1827055edb.6.1677178725424; Thu, 23 Feb
 2023 10:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20230220-kobj_type-cpufreq-schedutil-v1-1-7d1c92293457@weissschuh.net>
 <20230221043654.6gb454cabnjfg44k@vireshk-i7>
In-Reply-To: <20230221043654.6gb454cabnjfg44k@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Feb 2023 19:58:34 +0100
Message-ID: <CAJZ5v0jBMtDq5jkWxxDDGyv=vZMFecD3u5WrGUasTtChpA2QOg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: make kobj_type structure constant
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 5:37 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 20-02-23, 23:28, Thomas Weißschuh wrote:
> > Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> > the driver core allows the usage of const struct kobj_type.
> >
> > Take advantage of this to constify the structure definition to prevent
> > modification at runtime.
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 1207c78f85c1..4c073bd9b001 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -543,7 +543,7 @@ static void sugov_tunables_free(struct kobject *kobj)
> >       kfree(to_sugov_tunables(attr_set));
> >  }
> >
> > -static struct kobj_type sugov_tunables_ktype = {
> > +static const struct kobj_type sugov_tunables_ktype = {
> >       .default_groups = sugov_groups,
> >       .sysfs_ops = &governor_sysfs_ops,
> >       .release = &sugov_tunables_free,
> >
> > ---
> > base-commit: 5b0ed5964928b0aaf0d644c17c886c7f5ea4bb3f
> > change-id: 20230220-kobj_type-cpufreq-schedutil-783c6be6ff14
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.3-rc material, thanks!
