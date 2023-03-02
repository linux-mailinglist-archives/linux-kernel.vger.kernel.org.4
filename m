Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285A66A8975
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCBTWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBTWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:22:52 -0500
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B23B850;
        Thu,  2 Mar 2023 11:22:49 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-536b7ffdd34so683807b3.6;
        Thu, 02 Mar 2023 11:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677784969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTlo3xfJXMvp3Qak7Y2RrB5Br31Xvy9Qp0I6AvYWKq4=;
        b=sB+jW5KzO2lg+FSEcC87hRUMCi83JYi2EMAeudXjPonzezVT6cMlDVpu6UO54f3imZ
         AUYADQrtmtkVB9aVd/fHmguSBmLWrPSwiZQhoezneuvHOfeSL4vXqURhwV42CrdQLfrx
         mHC50a21tZFrnE7NVNfBDzg2Qn9IwJ0x5XgcfzZRaCp5FlmZexvYW3S41R9AMIvBS7G6
         aLmkZVyRqwvSDbwm7Abk4uB+CjD4Q+UlAgROi0Gy7dW10mXfOTgpYYvoaTMbTt2WE77W
         G5s53TZkTaM8HebHs9UEHSyPsZzo2fifx1MPdcvn8qMyqt24Yp4CFLkss/9V+TRgOp9q
         I1IA==
X-Gm-Message-State: AO0yUKVTGW428XSVTLux/cqFFTUOuInNxv7OGfFzeSx6i8gFR6rAZqk2
        hRJk3VD5oaXENFUkV4r6kt+g5dXNrMTTS9UhNEk=
X-Google-Smtp-Source: AK7set+27dbJfqQswpMrWUJDjB4FnE9uYHHjGx5P3yMU/3b0TsGrR78vVumKBqHr1V6QaYFMKk9DCe2d9KuoBr0eW74=
X-Received: by 2002:a81:4416:0:b0:533:9ffb:cb13 with SMTP id
 r22-20020a814416000000b005339ffbcb13mr6890950ywa.3.1677784968364; Thu, 02 Mar
 2023 11:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20230302031146.2801588-1-changbin.du@huawei.com>
In-Reply-To: <20230302031146.2801588-1-changbin.du@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 2 Mar 2023 11:22:37 -0800
Message-ID: <CAM9d7cigZ=TRoH8-MNbovUETzsjf+OuX7ykXA9rSyhsOY48dRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf : fix counting when initial delay configured
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hui Wang <hw.huiwang@huawei.com>
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

Hello,

On Wed, Mar 1, 2023 at 7:12 PM Changbin Du <changbin.du@huawei.com> wrote:
>
> The first one fixes the problem that counters are never enabled  when initial
> delay configured.
> The remaining two reuse the common field target::initial_delay for
> record/ftrace/trace subcommands.
>
> v2:
>  - introduce common filed target::initial_delay
>
> Changbin Du (3):
>   perf stat: fix counting when initial delay configured
>   perf record: reuse target::initial_delay
>   perf: ftrace: reuse target::initial_delay

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/perf/builtin-ftrace.c | 10 +++++-----
>  tools/perf/builtin-record.c | 12 ++++++------
>  tools/perf/builtin-stat.c   | 15 +++++----------
>  tools/perf/builtin-trace.c  |  8 ++++----
>  tools/perf/util/evlist.c    |  6 +++---
>  tools/perf/util/evsel.c     |  2 +-
>  tools/perf/util/ftrace.h    |  1 -
>  tools/perf/util/record.h    |  1 -
>  tools/perf/util/stat.c      |  6 +-----
>  tools/perf/util/stat.h      |  1 -
>  tools/perf/util/target.h    | 12 ++++++++++++
>  11 files changed, 37 insertions(+), 37 deletions(-)
>
> --
> 2.25.1
>
