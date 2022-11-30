Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7200C63E06A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiK3TF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiK3TFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:05:42 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E5D5444A;
        Wed, 30 Nov 2022 11:05:40 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id bg10so982101wmb.1;
        Wed, 30 Nov 2022 11:05:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfMWcPb5oJ92r+I85xnNHerwsoLysWjlkP0+eY0Z8Gk=;
        b=i8FrLXlC4yGrYGa7RktOSA0SGoDIh/IgFNMXzzhw4XNf0XzpLy9QMkw9I8qGu3tMDX
         unbI5GqU9K+eMMMIh7VwFp5qzVkBLkrLmM9iUnb8Jxgzs0d1PoK7+EcxgNtem+qoOCp8
         br3eAOSZwqpzLh8/Lc5EClCmqtrR4ll8uF1HBfJ37pxPxZXP7gGOY0Q5JuOIUFgD/fe/
         cTJ9mJEKKeaw+kmWw+pJCxEgvPFejxcdjpG/PU5WVVuYfhXwdQsuPP7f7BCtBs9v/4wQ
         4ZxBkxrtaow+8jO5+L+zbgnxkf1PW3WQhWNHnvYn6j27PfaMUe4VvTqe591JB098pOnN
         DhFQ==
X-Gm-Message-State: ANoB5pkXEbIYzXQm3p+Gm5Y5YTjjVdt2nNsdhrqMJy3uj80otyazVSf9
        MyC2Ox275O7PnQ1VU/upNkKIXMe//tt9j/u++yU=
X-Google-Smtp-Source: AA0mqf4xCtbCa7lqZoiTqgMKLIGXYxvTUSoj7/fRfH4mM9B0nYCaML+09YGBiLmZU0SCmyJlfJkmd1iESK9dFY5iboM=
X-Received: by 2002:a05:600c:6885:b0:3cf:a80d:59cd with SMTP id
 fn5-20020a05600c688500b003cfa80d59cdmr39524591wmb.5.1669835139245; Wed, 30
 Nov 2022 11:05:39 -0800 (PST)
MIME-Version: 1.0
References: <20221130062935.2219247-1-irogers@google.com> <20221130062935.2219247-4-irogers@google.com>
In-Reply-To: <20221130062935.2219247-4-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 30 Nov 2022 11:05:27 -0800
Message-ID: <CAM9d7chrsLHoGe=RcU2e5hRL22j=813j3uuEHDOPZrkpWqnSsw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf build: Use libtraceevent from the system
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:30 PM Ian Rogers <irogers@google.com> wrote:
>
> Remove the LIBTRACEEVENT_DYNAMIC and LIBTRACEFS_DYNAMIC. If
> libtraceevent isn't installed or NO_LIBTRACEEVENT=1 is passed to the
> build, don't compile in libtraceevent and libtracefs support. This
> also disables CONFIG_TRACE that controls "perf
> trace". CONFIG_TRACEEVENT is used to control enablement in
> Build/Makefiles, HAVE_LIBTRACEEVENT is used in C code. Without
> HAVE_LIBTRACEEVENT tracepoints are disabled and as such the commands
> kmem, kwork, lock, sched and timechart are removed. The majority of
> commands continue to work including "perf test".

Maybe we can have a different approach.  I guess the trace data
access is isolated then we can make dummy interfaces when there's
no libtraceevent.  This way we don't need to touch every command
and let it fail when it's asked.

The motivation is that we should be able to run the sub-commands
as much as possible.  In fact, we could run 'record' part only on the
target machine and pass the data to the host for analysis with a
full-fledged perf.  Also some commands like 'perf lock contention'
can run with or without libtraceevent (using BPF only).

Thanks,
Namhyung
