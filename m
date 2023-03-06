Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD0F6AD185
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCFW3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCFW3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:29:23 -0500
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A2C38004;
        Mon,  6 Mar 2023 14:29:22 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id k23so9742871ybk.13;
        Mon, 06 Mar 2023 14:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678141761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6f12142LyUCXv1wqTPt0K0jlFaLpVhCgvJtjTz/YcU=;
        b=FfNTDfUX3CBYUOV8HvY7XXLbJ2YFAGR1ccW9M2jx+/E6lMKSWe91IaCJBUq1O1fBfn
         HajwIKMrPsONsezDckGguMmiP5+ge4Qv/J8UbMPSy51wP2zVRjlddncLVx89MITus0BS
         NoIa0lB1pd8NJR9Pyc9I4VFz6tv8eGOGCTsI76cg2txiOYkAoTOPxcgMgy0G5q3ZbbI/
         Q4iFb0L7ZToU5VRgvcz92RG7mQmEZxBMaOqLMoEk88PVc4682HqKlkEwgSkj9EwGaU1i
         RxiOfrc6UJe6SDU2XbQyXnhGi1yxEwZ0gVed7FSFq6xu8GvowAZJEymWtcockN2cbLwi
         KDeg==
X-Gm-Message-State: AO0yUKWpzNpjBvI1kgBGT94vDM3psYjUoEypII0PrMw7Z1fesiGelXUN
        T9rM10oEcmZZpkMnf3eo3yFJgvWcVTMzsw6lBIA=
X-Google-Smtp-Source: AK7set88+PSiio1FR30WjpA0FzgWVtcBYUiBeYMk+qIe2UpKOodB7VmxKHlJgejXUbTRigoHd4hCL7LcyOK8DKkYluw=
X-Received: by 2002:a25:b206:0:b0:8bd:4ab5:18f4 with SMTP id
 i6-20020a25b206000000b008bd4ab518f4mr10239475ybj.6.1678141761302; Mon, 06 Mar
 2023 14:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20230302092109.367-1-ravi.bangoria@amd.com> <20230302092109.367-2-ravi.bangoria@amd.com>
 <CAM9d7cjEvjcYwjA+HfsDHKDX8FGZCECTZ8vDMPHBUSqfQSCOfA@mail.gmail.com> <c5f1c3c2-6de3-a40d-9cf0-c1c7638acfc3@amd.com>
In-Reply-To: <c5f1c3c2-6de3-a40d-9cf0-c1c7638acfc3@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 6 Mar 2023 14:29:10 -0800
Message-ID: <CAM9d7ch9OsFz9N71QG5DOyygctK+bVAFGQByUGAvy=d29rzWZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/ibs: Fix interface via core pmu events
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
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

On Thu, Mar 2, 2023 at 9:54 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Hi Namhyung,
>
> >> diff --git a/kernel/events/core.c b/kernel/events/core.c
> >> index a5a51dfdd622..c3f59d937280 100644
> >> --- a/kernel/events/core.c
> >> +++ b/kernel/events/core.c
> >> @@ -11633,9 +11633,13 @@ static struct pmu *perf_init_event(struct perf_event *event)
> >>                         goto fail;
> >>
> >>                 ret = perf_try_init_event(pmu, event);
> >> -               if (ret == -ENOENT && event->attr.type != type && !extended_type) {
> >> -                       type = event->attr.type;
> >> -                       goto again;
> >> +               if (ret == -ENOENT) {
> >> +                       if (event->attr.type != type && !extended_type) {
> >> +                               type = event->attr.type;
> >> +                               goto again;
> >> +                       }
> >> +                       if (pmu->capabilities & PERF_PMU_CAP_FORWARD_EVENT)
> >> +                               goto try_all;
> >
> > Wouldn't it be better to use a different error code to indicate
> > it's about precise_ip (or forwarding in general)?  Otherwise
> > other invalid config might cause the forwarding unnecessarily..
>
> That would make things easier and we might not need this new capability.
> Most appropriate error codes seems ENOENT, EOPNOTSUPP and EINVAL but all
> are already used for other purposes. Any other suggestions?

Maybe we can have more liberty for the error code since
it's not returned to the user.  How about ESRCH, EIO or ENXIO?

Thanks,
Namhyung
