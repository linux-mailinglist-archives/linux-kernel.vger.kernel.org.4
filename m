Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FC068D617
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjBGL73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjBGL71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:59:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4751C336
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675771120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rRLNgCZg6aYRN6xn9+boV6EQE4Kq4pgHIUbO7Kac8ww=;
        b=eaE+kHCnh6qWd8Ha2BOR+11vj86VaveAyPoUbo/RBzj8x/cw7cDbMSr8S8Euh+RNPBRpIy
        /SPbS0q2F0DByIxWWh8FEUvxT4/mgdks/PJEI6tFblrF+sb0ExQjGS8zgyswjTR9PZCb8j
        9OrihT5zp6lxO8QiYTYvrgDfkZ5pGZs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-S_ABWPCOPHKw0VBlAF2TLg-1; Tue, 07 Feb 2023 06:58:38 -0500
X-MC-Unique: S_ABWPCOPHKw0VBlAF2TLg-1
Received: by mail-qv1-f69.google.com with SMTP id lw11-20020a05621457cb00b005376b828c22so7405081qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 03:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRLNgCZg6aYRN6xn9+boV6EQE4Kq4pgHIUbO7Kac8ww=;
        b=z9pgaujjUI/wX4ee+35jeLLKGdM7RnjG6xfdOEsKmItBGJ3e/gXYgIldGT4epF80TM
         tM19uPLl9l6qSmrFaklQCw4kRyJitz7+0U8ulGjPhUs8N90FftXaD1frcci4xmkU2n71
         YyKA6wM3CSAkiQFubuGjbmr0g3hSoiFzHafapu3M5gqVD9eWV+iVQkVVPU5CnceWnFE8
         NjdYOwRlwP9DOyX+HOgXlr1RzZmmrZj1JoUCWiNG9eT0FlqPbH0Y7lq50kVkRrX4OrIb
         licdNWmDJQcgdjdh54HnK+/p3glv1y8hTgLdW0kBlvdJkgX46MISlaVtMdGsHnDxBvjN
         onZw==
X-Gm-Message-State: AO0yUKV9saOWwd+iGmEFLE5+e+NdE3kg2NGH5q9JyLA/UqxHdhUUyqoj
        gY1YMQ6FfaJ90zG8Rtn1q0GX5be3IQD2PRFXUiVhwR6s0Cs+QTkvg7ReehEe3L3JrRtoHk4TSFx
        wbzcDCNduCqKfYVuGQNa7Gdth
X-Received: by 2002:a05:622a:118d:b0:3b8:2ce4:3e9 with SMTP id m13-20020a05622a118d00b003b82ce403e9mr4924307qtk.32.1675771118240;
        Tue, 07 Feb 2023 03:58:38 -0800 (PST)
X-Google-Smtp-Source: AK7set/PMOoOqpsIOjZx215xrBJzxJ4wQ3sDL/4QeoTXh+0Me+lZiwPwA+1Kc6h/5/fdLnw7CiZV2Q==
X-Received: by 2002:a05:622a:118d:b0:3b8:2ce4:3e9 with SMTP id m13-20020a05622a118d00b003b82ce403e9mr4924278qtk.32.1675771117968;
        Tue, 07 Feb 2023 03:58:37 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c6:4a21:6f01:ac73:9611:643a:5397])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a12aa00b0071d57a0eb17sm9127281qki.136.2023.02.07.03.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 03:58:37 -0800 (PST)
Date:   Tue, 7 Feb 2023 11:58:34 +0000
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Eder Zulian <ezulian@redhat.com>
Subject: Re: [RFC PATCH v2] sched/deadline: Add more reschedule cases to
 prio_changed_dl()
Message-ID: <Y+I86kr73LlKVmW/@localhost.localdomain>
References: <20230206140612.701871-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206140612.701871-1-vschneid@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/02/23 14:06, Valentin Schneider wrote:
> I've been tracking down an issue on a ~5.17ish kernel where:
> 
>   CPUx                           CPUy
> 
>   <DL task p0 owns an rtmutex M>
>   <p0 depletes its runtime, gets throttled>
>   <rq switches to the idle task>
> 				 <DL task p1 blocks on M, boost/replenish p0>
> 				 <No call to resched_curr() happens here>
> 
>   [idle task keeps running here until *something*
>    accidentally sets TIF_NEED_RESCHED]
> 
> On that kernel, it is quite easy to trigger using rt-tests's deadline_test
> [1] with the test running on isolated CPUs (this reduces the chance of
> something unrelated setting TIF_NEED_RESCHED on the idle tasks, making the
> issue even more obvious as the hung task detector chimes in).
> 
> I haven't been able to reproduce this using a mainline kernel, even if I
> revert
> 
>   2972e3050e35 ("tracing: Make trace_marker{,_raw} stream-like")
> 
> which gets rid of the lock involved in the above test, *but* I cannot
> convince myself the issue isn't there from looking at the code.
> 
> Make prio_changed_dl() issue a reschedule if the current task isn't a
> deadline one. While at it, ensure a reschedule is emitted when a
> queued-but-not-current task gets boosted with an earlier deadline that
> current's.
> 
> [1]: https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---

This looks now good to me, thanks!

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

