Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301136CAE0C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjC0TBI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 15:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjC0TBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:01:06 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC771BDA;
        Mon, 27 Mar 2023 12:01:05 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id o32so5612024wms.1;
        Mon, 27 Mar 2023 12:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679943664; x=1682535664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiM66Pmcbjm8MSalv/BYcG+m8CKuGw0Q1Cn1XbjVjx8=;
        b=vNcitDdTQ5QqAk8XzywxBMQzb8qadtK039hiTWFQGZYWTM07UU+d7ymA5GbJt2+JAO
         iJXZpYos/RzzoTPpsRILVm54XaKaHoTuwjDuXl6ObBcXYabn9tf/YcRoDJ2SFicvMCoc
         CHpoH7kE9JCWiugodMZWMNDzwtDiqaOVJymkpMOa4AzESPyjw1lW9ZYAUmWe5OI/hx0t
         81fOYp3PjjzUc1Mh2A+l+IW8JZFIEC1ZZHN7GL+jdgKIvD4ZEm6zPIHyDHFEtEz9N2wo
         UEFvMa8lI4TWUBEzDlQljRSaD1B9CnjDy2n/wrJxRnPKM7lx6bKguyDsM5zKROxlP4ZO
         T+xQ==
X-Gm-Message-State: AO0yUKWctup3qAUe4qyIy01wRKlOezV2oy7OSP0VToZObfvNbGl5iIOd
        eej6CBdkMRdF/qOyVXfc8cnYEzttixHZFW8Qyn0=
X-Google-Smtp-Source: AK7set/NrZJQbavoOjok5C5aY/T1ueJGr079K7zGe0yNKhUGF7TTi/zg5o/7FBlnrMPk/MSJzQr72XD78ZgzRPmkwvQ=
X-Received: by 2002:a05:600c:4fcc:b0:3ee:136f:bcf4 with SMTP id
 o12-20020a05600c4fcc00b003ee136fbcf4mr13051166wmq.5.1679943663877; Mon, 27
 Mar 2023 12:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230317063246.1128219-1-zangchunxin@lixiang.com>
In-Reply-To: <20230317063246.1128219-1-zangchunxin@lixiang.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 27 Mar 2023 12:00:52 -0700
Message-ID: <CAM9d7chc+eJvPMm3ZhcxcbYUjNzVvBG7N0DvVwMzmOOb+-xiMQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf sched: Fix sched latency analysis incorrect
To:     Chunxin Zang <zangchunxin@lixiang.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Zhou <zhouchunhua@lixiang.com>
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

On Thu, Mar 16, 2023 at 11:33 PM Chunxin Zang <zangchunxin@lixiang.com> wrote:
>
> 'perf sched latency' is incorrect to get process schedule latency
> when it used 'sched:sched_wakeup' to analysis perf.data.
>
> Because 'perf record' prefer use 'sched:sched_waking' to
> 'sched:sched_wakeup' since commit d566a9c2d482 ("perf sched: Prefer
> sched_waking event when it exists"). It's very reasonable to
> evaluate process schedule latency.
>
> Similarly, update sched latency/map/replay to use sched_waking events.

Have you checked perf sched replay (add_sched_event_wakeup)?  I think
it'd make unnecessary sched atoms for sched_wakeup.

Can we check the wakeup and waking events and disable the wakeup
if the waking is found like in perf_sched__timehist?

Thanks,
Namhyung


>
> I used 'perf record -e "sched:* "' to record both wakeup and waking events,
> and use fixed perf version to analysis them, the result is correct.
> Because the function "latency_wakeup_event" will change atom->state to
> THREAD_WAIT_CPU at waking event, and judge the 'atom->state !=
> THREAD_SLEEPING' is false then returned at wakeup event.
>
> Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
> Signed-off-by: Jerry Zhou <zhouchunhua@lixiang.com>
> ---
>
>         changelogs in v3:
>         1) fix non-ASCII characters in commit log.
>
>         changelogs in v2:
>         1) fix email address disappearing in 'signed off by'
>
>  tools/perf/builtin-sched.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 86e18575c9be..1af4ec1ac824 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1819,6 +1819,7 @@ static int perf_sched__read_events(struct perf_sched *sched)
>         const struct evsel_str_handler handlers[] = {
>                 { "sched:sched_switch",       process_sched_switch_event, },
>                 { "sched:sched_stat_runtime", process_sched_runtime_event, },
> +               { "sched:sched_waking",       process_sched_wakeup_event, },
>                 { "sched:sched_wakeup",       process_sched_wakeup_event, },
>                 { "sched:sched_wakeup_new",   process_sched_wakeup_event, },
>                 { "sched:sched_migrate_task", process_sched_migrate_task_event, },
> --
> 2.25.1
>
> 声明：这封邮件只允许文件接收者阅读，有很高的机密性要求。禁止其他人使用、打开、复制或转发里面的任何内容。如果本邮件错误地发给了你，请联系邮件发出者并删除这个文件。机密及法律的特权并不因为误发邮件而放弃或丧失。任何提出的观点或意见只属于作者的个人见解，并不一定代表本公司。
