Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66E064CD8C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiLNP6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238491AbiLNP5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:57:30 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF47F22BF2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:57:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s7so3774281plk.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yzm0Z8s50B7PxlfwYMM7oE1GHaBVbWJfzBfeRipGHLY=;
        b=D5si8z0bqc6iQSOs4DzfBe7ssxqwcUZpw/grziFTWhO9M9XiZ7KIarEabtR90rMCJe
         b159DFIIX8t3F4lfBIN3fmZZHD7WVptLlehPQYO4LKiecXjdLa+/46Yzk+EGTUd0KqYr
         6f+QwSb8p9AxW2xcTZdHNyKTg6b4EF4pyv9HIuxrXzCuqKUB5IHSlM7wamT8m+xrQVsc
         QX9TNjuFRc8bhDqeV7JkA/wzNAENgLawEf/wN8l1K2dNw+Ze8gBFZpDHmGJ9cuWSdtrZ
         aFVy+LoiJGeXKRJZeW2A6BycPJcmmtMz/X9pGMl4xmNGGpQcLpbHVpBnxU899Sxtyjwu
         JUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yzm0Z8s50B7PxlfwYMM7oE1GHaBVbWJfzBfeRipGHLY=;
        b=SKeN6vWVvkCngxt9ypK6pao9TFPzlVmBPQunWza+WmF5a+2nDelVStd23O80F3W0n+
         wjiYLqGOk/zx49LuQousmyG23b6Jw+U2P/cUw4GN0ZtkycMf/2x7c2sHz6fH8dcyHrK0
         oBErnTdIXDQZMGm+dHb73GHgi0ea802rIgZSm1u9zn0XsXvPB5jh6auGAGDsPTPNJrBk
         JMHzBviHEHLHc+zaD261VeI4oq5YYNrz07eW7Xff0oGXJJIYa8uvCbDX2Qnp9iVCClx4
         1U+k0zVJqzAIq/ee6ZvGI78+KjpiRfRHQG9w9yedC8OCRAcoDmniwMtlZAxNxVB0dBrI
         Fo1Q==
X-Gm-Message-State: ANoB5pmimXcamZyMvbdDqoG9bXzFQDn6HEPR2S6yvYENNdSpTUbl3IPb
        UPwd3cyzjwURjj+C/vuENh6teQ==
X-Google-Smtp-Source: AA0mqf5m8YDzq/xZPuLE8hJmVlZd3SUP5u1iUSl4EN1k9vvaqltt4+SSILDlCBaTjX+tS2Bc190uPQ==
X-Received: by 2002:a17:90a:cf93:b0:219:34cb:477e with SMTP id i19-20020a17090acf9300b0021934cb477emr25649406pju.44.1671033447143;
        Wed, 14 Dec 2022 07:57:27 -0800 (PST)
Received: from leoy-yangtze.lan (n058152048149.netvigator.com. [58.152.48.149])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a2dc700b00219feae9486sm1627127pjm.7.2022.12.14.07.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 07:57:26 -0800 (PST)
Date:   Wed, 14 Dec 2022 23:57:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        =?iso-8859-1?Q?Adri=E1n?= Herrera Arcila 
        <adrian.herrera@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, songliubraving@fb.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org
Subject: Re: [PATCH 2/2] perf stat: fix unexpected delay behaviour
Message-ID: <Y5nyYeVWpLA/IH1E@leoy-yangtze.lan>
References: <20220729161244.10522-1-adrian.herrera@arm.com>
 <20220729161244.10522-2-adrian.herrera@arm.com>
 <e3e123db-5321-c96e-1753-27059c729640@arm.com>
 <Y5iPsjF/lEsEldU8@kernel.org>
 <CAM9d7cj=Pu2QAONzd2JSVzd_X9DakeV=khcFGD_d-ES5zrx+KQ@mail.gmail.com>
 <Y5ngs0bh/R8xPFvo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5ngs0bh/R8xPFvo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:41:55AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 13, 2022 at 08:40:31AM -0800, Namhyung Kim escreveu:
> > Hi,
> > 
> > On Tue, Dec 13, 2022 at 6:44 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Mon, Aug 01, 2022 at 09:20:37AM +0100, James Clark escreveu:
> > > >
> > > >
> > > > On 29/07/2022 17:12, Adrián Herrera Arcila wrote:
> > > > > The described --delay behaviour is to delay the enablement of events, but
> > > > > not the execution of the command, if one is passed, which is incorrectly
> > > > > the current behaviour.
> > > > >
> > > > > This patch decouples the enablement from the delay, and enables events
> > > > > before or after launching the workload dependent on the options passed
> > > > > by the user. This code structure is inspired by that in perf-record, and
> > > > > tries to be consistent with it.
> > > > >
> > > > > Link: https://lore.kernel.org/linux-perf-users/7BFD066E-B0A8-49D4-B635-379328F0CF4C@fb.com
> > > > > Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
> > > > > Signed-off-by: Adrián Herrera Arcila <adrian.herrera@arm.com>
> > > > > ---
> > > > >  tools/perf/builtin-stat.c | 56 ++++++++++++++++++++++-----------------
> > > > >  1 file changed, 32 insertions(+), 24 deletions(-)
> > > >
> > > > Looks good to me. Fixes the counter delay issue and the code is pretty
> > > > similar to perf record now. Although I would wait for Leo's or Song's
> > > > comment as well because they were involved.
> > >
> > > I think I didn't notice Leo's ack, it still applies, so I'm doing it
> > > now.
> > 
> > I think the BPF counters should be enabled/disabled together.
> 
> Ok, so I removed this one and applied Namhyung's.

I can guess why Adrián doesn't enable/disable BPF counters together :)

Since 'perf stat' doesn't enable BPF counters with other normal PMU
events in the first place, I believe this is deliberately by Song's
patch fa853c4b839e ("perf stat: Enable counting events for BPF
programs"), it says:

"'perf stat -b' creates per-cpu perf_event and loads fentry/fexit BPF
programs (monitor-progs) to the target BPF program (target-prog). The
monitor-progs read perf_event before and after the target-prog, and
aggregate the difference in a BPF map. Then the user space reads data
from these maps".

IIUC, when loading eBPF (counter) program, perf tool needs to handle
eBPF program map specially (so that perf tool can know the latest eBPF
program's map in kernel).

I don't know anything for eBPF counter, so this is why I am still a bit
puzzle which way is right to do (bind vs separate eBPF counters).  But
I personally prefer to let eBPF counter to respect delay, so it's fine
for me to apply Namhyung's patch.

Thanks,
Leo
