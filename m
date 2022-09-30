Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FEC5F10A5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiI3RTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiI3RTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:19:13 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC26C1C2F91;
        Fri, 30 Sep 2022 10:19:11 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-131b7bb5077so6212463fac.2;
        Fri, 30 Sep 2022 10:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=R+WiXLP47nyLieKcyaFDm7uI3zYvk9uOSTGnPEnMU9U=;
        b=TOPSVhNwt7EZ7u4qF0rKbaqUCqneaifZuenOBH/8RJzHFHXaLw9z8dy2THkWfneHCl
         S1vklorS9FFiumS6Fm0vnsWISQSNQ/4zgIuhsPTWbSMxOWcg1V8qmk4kmhAh9r6HGKWI
         PolzDTK3D0PS6RDyptPw13pY4LVJWj9RCutmCUZBrDbuDDm6vnJKS0lbeH4VDenVnUJT
         t7sidgE1vdNDSEL5iOug9EMpo4NJxK2ouZ7kJaYjts2lSfpAHzAwoQ5Ztcs6dsOuN1vc
         2495lt8WgtshIrZ0whhbOWbRF4kuc/QI+9x9UHNVq+8Bq8YIeI4Dj/EhkjaSA8CmEzbi
         jE3Q==
X-Gm-Message-State: ACrzQf2ODkcD+uHdkmH90xBuCq93hOiMPD2cRonEeDi3PrCyUyZvj2hY
        535beUINOqcHhq9JUvCpIIoMLrgmJKrFhVWcSRQ=
X-Google-Smtp-Source: AMsMyM6t30+xps3ZdXVQugxAvrSCNYpaEL3BJ696XpL3I7uM/JBXV2Q0bz1rpPPlbSbJYelHKPFdYPVFWY9OmTz5OvA=
X-Received: by 2002:a05:6870:a70f:b0:127:666a:658 with SMTP id
 g15-20020a056870a70f00b00127666a0658mr5377853oam.218.1664558351169; Fri, 30
 Sep 2022 10:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220929205958.22225-1-hcvcastro@gmail.com>
In-Reply-To: <20220929205958.22225-1-hcvcastro@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Sep 2022 10:19:00 -0700
Message-ID: <CAM9d7ciaMJuG-LgOGoT-u2qwXp8Tk=Zb3ZJPCzA1oQN9hk5ENA@mail.gmail.com>
Subject: Re: [PATCH] perf: fix the probe finder location (.dwo files)
To:     Henry Castro <hcvcastro@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, Sep 29, 2022 at 2:00 PM Henry Castro <hcvcastro@gmail.com> wrote:
>
> If the file object is compiled using -gsplit-dwarf,
> the probe finder location will fail.
>
> Signed-off-by: Henry Castro <hcvcastro@gmail.com>
> ---
>  tools/perf/util/probe-finder.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 50d861a80f57..6d7c5461251d 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1161,7 +1161,8 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
>         struct perf_probe_point *pp = &pf->pev->point;
>         Dwarf_Off off, noff;
>         size_t cuhl;
> -       Dwarf_Die *diep;
> +       Dwarf_Die *diep, cudie, subdie;
> +       uint8_t unit_type;
>         int ret = 0;
>
>         off = 0;
> @@ -1200,6 +1201,14 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
>                         continue;
>                 }
>
> +               /* Check separate debug information file. */
> +               if (dwarf_cu_info(pf->cu_die.cu, NULL, &unit_type, &cudie,
> +                                 &subdie, NULL, NULL, NULL))

It seems dwarf_cu_info was introduced in elfutils 0.171 which
was released in June 2018.  I hope all the test setups have
more recent versions.


> +                       continue;
> +
> +               if (unit_type == DW_UT_skeleton)
> +                       pf->cu_die = subdie;

Is this DWARF5 thing?  Will it handle the previous version well?
IOW wouldn't dwarf_cu_info() return fail?

Anyway I think it'd be safer to do

    if (dwarf_cu_info() == 0 && unit_type == skeleton)
        pf->cu_die = subdie;

Thanks,
Namhyung


> +
>                 /* Check if target file is included. */
>                 if (pp->file)
>                         pf->fname = cu_find_realpath(&pf->cu_die, pp->file);
> --
> 2.20.1
>
