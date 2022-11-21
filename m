Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97721632CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiKUTTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiKUTS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:18:56 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03C613DD1;
        Mon, 21 Nov 2022 11:18:53 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id df6so6436067qvb.0;
        Mon, 21 Nov 2022 11:18:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNAiL7GtA1WBt+BkHFGHuULkAkKvbYHFnVpk3923atI=;
        b=3P6I+ntXmu4qthWFKbSMEy7vsR752oIf8wVgxeUp+rQ8KdML8kZf4suQf+WANKT7gb
         A6xQ2AHGXCyUzjWURed/icxFwkORJgqtyjppe0mKRbveAuQ/Xha/3JZCRIgwKwyHRm9s
         kbgqT3VvK2lQTXXvIBPFmqkF+I5+AWB7G4eE87O15JA8/NdigZJ12rCES1WPfRbrk8JL
         ruLMna4JaL1YiE45LuX3Et2qzWjOVytTnjjrd0qbV6gixVHLouIv/6M8zq30fSn8oCdb
         4ZZijVZb3p+7B3rc+lLvQtv4G0d/f6GA1Wkn01t51R56I05F8cIEHCforXlNxTUYOFux
         hSxw==
X-Gm-Message-State: ANoB5pliaTndG4Kw6J/Lq2jWBbQIShFL5qt6l3TIrlJ+6GUIu3jRG7by
        16brzWlfD36phI03LrI62UVf04IfbwFbY9FHuzA=
X-Google-Smtp-Source: AA0mqf7ZEXQmcbAWV6wu8t13pwcBcGe7f50Iohz07FB/6Nh1Vr2GMqLcKS6mbVlav8zjXuwB7ylqI3uIaHOCTxxVRCo=
X-Received: by 2002:a0c:c589:0:b0:4b1:a9ac:21de with SMTP id
 a9-20020a0cc589000000b004b1a9ac21demr489868qvj.119.1669058332574; Mon, 21 Nov
 2022 11:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20221110195732.1382314-1-wusamuel@google.com> <CAGETcx_aAynvykDSL4aue3zf5Pv7+hELUHQ=MWOzBbyZBPySDA@mail.gmail.com>
 <880b7332-562c-4934-4e92-493b112568c9@arm.com> <CAG2Kctp_VwryYTYMoqe6EBKFs-FZuNcB94e_MzLgBN9jJ5tpQA@mail.gmail.com>
In-Reply-To: <CAG2Kctp_VwryYTYMoqe6EBKFs-FZuNcB94e_MzLgBN9jJ5tpQA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Nov 2022 20:18:41 +0100
Message-ID: <CAJZ5v0iNjPAAn0-uygpJe0ya_LW7pfF4C8OHd+8EMLg+Ws=02Q@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to sugov_policy"
To:     Sam Wu <wusamuel@google.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 2:00 AM Sam Wu <wusamuel@google.com> wrote:
>
> On Wed, Nov 16, 2022 at 3:35 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> > Which mainline kernel version you use in pixel6?
> I am using kernel version 6.1-rc5.
> >
> > Could you elaborate a bit how is it possible?
> > Do you have the sg_policy setup properly (and at right time)?
> > Do you have the cpu capacity from arch_scale_cpu_capacity()
> > set correctly and at the right time during this cpufreq
> > governor setup?
> >
> > IIRC in Android there is a different code for setting up the
> > cpufreq sched governor clones. In mainline we don't have to do
> > those tricks, so this might be the main difference.
> This behavior is seen on the mainline kernel. There isn't any vendor code
> modifying the behavior, and the schedutil governor is being used.
> >
> > Could you trace the value that is read from
> > arch_scale_cpu_capacity() and share it with us?
> > I suspect this value changes in time in your kernel.
> There's an additional CPU capacity normalization step during
> init_cpu_capacity_callback() that does not happen until all the CPUs come
> online. However, the sugov_start() function can be called for a subset of
> CPUs before all the CPUs are brought up and before the normalization of
> the CPU capacity values, so there could be a stale value stored
> in sugov_policy.max field.

OK, the revert has been applied as 6.1-rc material, thanks!
