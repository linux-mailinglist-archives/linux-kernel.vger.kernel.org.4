Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4386AD18E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCFWbe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Mar 2023 17:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCFWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:31:32 -0500
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5434531E17;
        Mon,  6 Mar 2023 14:31:31 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id c80so2805444ybf.5;
        Mon, 06 Mar 2023 14:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678141890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3EpSG/yIupfU+bIz0Ha+9Xy1hc/gD4iPgGZEOuU6zE=;
        b=FZSZ1rl/UBfax5nv8PsAx+pEwgoNKEbvtLcmaNNLwjrqD2GpFJxrxJax8U1ykrMTy8
         FPeRoDeBUdl04GR5CDV93L6XwmlrirtYb5edS+dATCxm0nlJOjDo+j/yvoAJhYNZkfuQ
         /7sngycLpqURGwTO8rSAtJPnU2kSmTcpKGFjOtZH7cCkq4ifFiw06yuDWBw/zJDDlWmy
         qPREJuZD/12bG5xluLo6nPERIEQPFUL5lJF8s4rCZ9v6jO8PEUVbty95O1/N4pLdEJ7M
         SfZeywTdQHytWzoARnJevDJ+nCG7Xo+fxxgpykYI03b4SdusXj3UpqA6VLFA63fMZMlx
         P2JA==
X-Gm-Message-State: AO0yUKVMWnFRhBh9t6z33HuRTFWvtvJJVF694bQk07H56RqBiSlT/k5X
        ZhNv6WVZ6oWZztwRQ4km/9NNurLT0Xrj6v1Ex4o=
X-Google-Smtp-Source: AK7set8ikc1Xk+h35xt+HqOt8Fnfy0/s4ec8KIh3m31A7iSfo11irY5v6IMUJPoVBTZ9jpaXCFK7kAFtH5XHB+r6FvE=
X-Received: by 2002:a25:8609:0:b0:a09:314f:9f09 with SMTP id
 y9-20020a258609000000b00a09314f9f09mr7626245ybk.6.1678141890435; Mon, 06 Mar
 2023 14:31:30 -0800 (PST)
MIME-Version: 1.0
References: <20230303114637.4015916-1-zangchunxin@lixiang.com>
 <CAM9d7cjnkPduqCLTow1m6U2C7dVM5tsu5k42heh8G568-8Jd8Q@mail.gmail.com> <A6AF90E2-7EA6-4BFC-9749-382F46559DD4@lixiang.com>
In-Reply-To: <A6AF90E2-7EA6-4BFC-9749-382F46559DD4@lixiang.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 6 Mar 2023 14:31:19 -0800
Message-ID: <CAM9d7cipx=ATF7HgpUiOOdLZrq79eX3Eg=7pb-ZytyP=CJWh3w@mail.gmail.com>
Subject: Re: [PATCH] perf sched: Fix sched latency analysis incorrect
To:     Chunxin Zang <zangchunxin@lixiang.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Zhou <zhouchunhua@lixiang.com>
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

On Mon, Mar 6, 2023 at 2:05 AM Chunxin Zang <zangchunxin@lixiang.com> wrote:
>
> > On Mar 4, 2023, at 10:14, Namhyung Kim wrote:
> >
> > Hello,
> >
> > On Fri, Mar 3, 2023 at 3:53 AM Chunxin Zang wrote:
> >>
> >> 'perf sched latency' is incorrect to get process schedule latency
> >> when it used 'sched:sched_wakeup' to analysis perf.data.
> >>
> >> Because 'perf record' prefer use 'sched:sched_waking' to
> >> 'sched:sched_wakeup' since commit d566a9c2d482 ("perf sched: Prefer
> >> sched_waking event when it exists"). It's very reasonable to
> >> evaluate process schedule latency.
> >>
> >> Similarly, update sched latency/map/replay to use sched_waking events.
> >
> > Have you checked if it works ok when data has both wakeup and
> > waking events?
>
>
> Yes, I used 'perf record -e “sched:* "' to record both wakeup and waking events,
> and use fixed perf version to analysis them, the result is correct.
> Because the function "latency_wakeup_event” will change atom->state to THREAD_WAIT_CPU
> at waking event, and judge the 'atom->state != THREAD_SLEEPING’ is false then returned at wakeup event.

Ok, good.

>
> >
> >>
> >> Signed-off-by: Chunxin Zang
> >> Signed-off-by: Jerry Zhou
> >
> > Missing email addresses.
> >
> > Otherwise looks good.
> >
> > Thanks,
> > Namhyung
>
> Maybe the company smtp email server reason, the email address is erased.
> Shall I send v2 patch version to fix it?

Yeah, that'd be nice.

Thanks,
Namhyung
