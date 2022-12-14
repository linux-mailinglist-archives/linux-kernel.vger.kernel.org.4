Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7AD64C653
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiLNJu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiLNJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:50:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00D61262D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671011392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ga5KrA5XwC9JyNvv3KaymLHWK3RH/pgWC02frF6jqTw=;
        b=MehzFNKPLqQFHDp/LVkRIaoYO4eUJfL0FWae+jPSkZ6mDTuvlp7G1TS6IQwThcpft8P1tA
        oC6wcUQmpQy/dx6sLGsuMmw9WkvJMpIyhNZ3Bf/DV1fYhjmVSmlPH8ZVfmFgAcwGVvqKEr
        0pXVV+tTDWRUUl4vN2Utp6BWsyw+c4E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-362-4B7wvFzYNVGug2-OW4TlVw-1; Wed, 14 Dec 2022 04:49:50 -0500
X-MC-Unique: 4B7wvFzYNVGug2-OW4TlVw-1
Received: by mail-wm1-f70.google.com with SMTP id f20-20020a7bc8d4000000b003d1cda5bd6fso3939563wml.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ga5KrA5XwC9JyNvv3KaymLHWK3RH/pgWC02frF6jqTw=;
        b=kI1Smagtgc0qTWBa1CZXfePm9DPYcPnUtjifQGnqVzd+lL80VlBCP2yD+lOEcxGzlG
         mBxFb42s8z4X+cz8FoifR79nIAPrAvR7xilVE4GCa2pq9KK3QcgHic9EOvZxWrHKYjMl
         YvodiUKUezsPVteLo/mlvkMqYdlEhchMlrxYxd8MeDGTQrstAV5wN8hWv13FcnPQzPHc
         YZ29Arp0vTdrdSIibWgaLwg2Hh7BBThDLzb2WJW+7rRT4VnObsF9fmc5JvbYiWhOV7tO
         BgGOImrhS1dKe54EnW//89RM0bI7p9D9FQjG1hE4on+200N8YWdokdFnxI6t+gFCj5oT
         YO/g==
X-Gm-Message-State: ANoB5pm3gJm9kzUFt+3boWEP03/0hu62yRByqlg2BSET8UpragzpT5m1
        UG3aQ7YyGxBBXSD1VV8eT4SRYdPLn4yD/EiuoHeOcplKUFnhLZA+l45Z+EA1LWZYXQrifMJ/0Ka
        6ytYtztWl5SE5q2ZqoexTv+IW
X-Received: by 2002:a05:600c:4f14:b0:3cf:e91d:f263 with SMTP id l20-20020a05600c4f1400b003cfe91df263mr17847846wmq.4.1671011389321;
        Wed, 14 Dec 2022 01:49:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6G0SJtqNi5mvWQrl5W2pXjGfCMguDy9fDLJY0Y3LeAFxp5Ast2stEAUVGdn72NJYesCTacHw==
X-Received: by 2002:a05:600c:4f14:b0:3cf:e91d:f263 with SMTP id l20-20020a05600c4f1400b003cfe91df263mr17847827wmq.4.1671011389118;
        Wed, 14 Dec 2022 01:49:49 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id q1-20020a1c4301000000b003d04e4ed873sm1884869wma.22.2022.12.14.01.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 01:49:48 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yair Podemsky <ypodemsk@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, rafael.j.wysocki@intel.com,
        ggherdovich@suse.cz, jlelli@redhat.com, mtosatti@redhat.com,
        nsaenz@kernel.org, linux-kernel@vger.kernel.org
Cc:     ypodemsk@redhat.com
Subject: Re: [PATCH] sched/core: Fix arch_scale_freq_tick() on tickless systems
In-Reply-To: <20221130125121.34407-1-ypodemsk@redhat.com>
References: <20221130125121.34407-1-ypodemsk@redhat.com>
Date:   Wed, 14 Dec 2022 09:49:45 +0000
Message-ID: <xhsmhzgbq5n7q.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/22 14:51, Yair Podemsky wrote:
> In order for the scheduler to be frequency invariant we measure the
> ratio between the maximum cpu frequency and the actual cpu frequency.
> During long tickless periods of time the calculations that keep track
> of that might overflow, in the function scale_freq_tick():
>
> if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
> =C2=BB       goto error;
>
> eventually forcing the kernel to disable the feature for all cpus,
> and show the warning message
> "Scheduler frequency invariance went wobbly, disabling!".
> Let's avoid that by limiting the frequency invariant calculations
> to cpus with regular tick.
>
> Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in frequenc=
y invariant accounting")
> Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
> Suggested-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> ---
> V1 -> V2: solution approach was changed from detecting long tickless peri=
ods
> to frequency invariant measurements on housekeeping cpus only.
> Link: ee89073a1e9de11c7bd7726eb5da71a0e8795099.camel@redhat.com
> ---
>  kernel/sched/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index daff72f00385..1bb0a840c817 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5469,7 +5469,9 @@ void scheduler_tick(void)
>       unsigned long thermal_pressure;
>       u64 resched_latency;
>
> -	arch_scale_freq_tick();
> +	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
> +		arch_scale_freq_tick();
> +
>       sched_clock_tick();
>
>       rq_lock(rq, &rf);
> --
> 2.31.1

