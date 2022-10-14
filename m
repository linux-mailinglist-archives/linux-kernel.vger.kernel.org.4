Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0EE5FF5E9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJNWFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJNWFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:05:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3842181D83;
        Fri, 14 Oct 2022 15:05:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F615B811D9;
        Fri, 14 Oct 2022 22:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6C2C433C1;
        Fri, 14 Oct 2022 22:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665785147;
        bh=/RAr9VwoMAS8yb49Oyf2pts2P9qIXMc0E07MraouJFg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CYoyqKbVJHbG2w+wF8a3E/xLB2TqXTcefrnXQqZs2iLJ4P+3JwNPc4sXKjLafZ4e9
         u7uWE1iJJ7aZkkMI1oZbnhEf2sc7IehP/gOobqC49EJvRro6EedVU/T1ejQZrYYvKZ
         vmao7gxPAIT6ur7D4pTupuP4S1BBKqLvsI92mqSvfze8pdhJnKYZ45YV/JplFs8QFQ
         /Ch0cZ+V+BD90rs/iT8np8Z1xRBNh6dt8DVMlioi3a0DR7BkcUSQG/+2j725Pf7X8E
         LhPD7WgseGOy529Zea6taa3wQ94rw/3BX5a0DvrLBwWLL5cyzwYwpMxOBGXG/4N0D6
         1ody04j5gp2mw==
Received: by mail-vk1-f169.google.com with SMTP id g85so2897944vkf.10;
        Fri, 14 Oct 2022 15:05:46 -0700 (PDT)
X-Gm-Message-State: ACrzQf0ToHGorj3DSuoq3i82ParypXMeOrJJB5pKtXlBHsAoJfRDr2br
        pKjltcAqDX9ZVqDXZ92TI1F6rbkegkntedtz4A==
X-Google-Smtp-Source: AMsMyM5lf52NgWIdCO0huRu2gXpgPKejjKfHv1dEWNI+Eka0Tq2Yv4hxCnw2Jg0XeWkV/dDCmvcYrSqAZDvH0XgCZm8=
X-Received: by 2002:a1f:60cd:0:b0:3ae:da42:89d0 with SMTP id
 u196-20020a1f60cd000000b003aeda4289d0mr3760991vkb.15.1665785146005; Fri, 14
 Oct 2022 15:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org>
 <20220914-arm-perf-tool-spe1-2-v2-v4-2-83c098e6212e@kernel.org> <Y0nZ3HQ6q9HzvEas@kernel.org>
In-Reply-To: <Y0nZ3HQ6q9HzvEas@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Oct 2022 17:05:36 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+oGm47TjWzSENvck+i9AX7vzrd6zOYrEk3PQbtPHT78Q@mail.gmail.com>
Message-ID: <CAL_Jsq+oGm47TjWzSENvck+i9AX7vzrd6zOYrEk3PQbtPHT78Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] perf tools: Sync perf_event_attr::config3 addition
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 4:51 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Oct 04, 2022 at 02:12:36PM -0500, Rob Herring escreveu:
> > Arm SPEv1.2 adds another 64-bits of event filtering control. As the
> > existing perf_event_attr::configN fields are all used up for SPE PMU, an
> > additional field is needed. Add a new 'config3' field.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > This patch is dependent on the kernel side landing first.
> > ---
> >  include/uapi/linux/perf_event.h       | 3 +++
> >  tools/include/uapi/linux/perf_event.h | 3 +++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index 03b370062741..b53f9b958235 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -333,6 +333,7 @@ enum perf_event_read_format {
> >  #define PERF_ATTR_SIZE_VER5  112     /* add: aux_watermark */
> >  #define PERF_ATTR_SIZE_VER6  120     /* add: aux_sample_size */
> >  #define PERF_ATTR_SIZE_VER7  128     /* add: sig_data */
> > +#define PERF_ATTR_SIZE_VER8  136     /* add: config3 */
> >
> >  /*
> >   * Hardware event_id to monitor via a performance monitoring event:
> > @@ -474,6 +475,8 @@ struct perf_event_attr {
> >        * truncated accordingly on 32 bit architectures.
> >        */
> >       __u64   sig_data;
> > +
> > +     __u64   config3; /* extension of config2 */
> >  };
> >
> >  /*
>
>
> I'm removing the above part, as this is for the kernel, not for tooling.

Oops, yes.

>
> Was this part submitted upstream? I couldn't find, so far, where it was
> submitted, can you please clarify?

I have to respin it after rc1. I'm waiting on patch 1 to be accepted first.

You should only take patch 1 (for 6.1/stable) as I've noted in the
patches. I sent the whole thing because Leo asked to see the whole
thing...

Rob
