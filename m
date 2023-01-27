Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA3267F209
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjA0XI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjA0XIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:08:55 -0500
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FA71E5DF;
        Fri, 27 Jan 2023 15:08:49 -0800 (PST)
Received: by mail-io1-f41.google.com with SMTP id h184so2491922iof.9;
        Fri, 27 Jan 2023 15:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msAyX3ByOsUek5ziG1EnXhB9F97GMAyCutt3DTEavEI=;
        b=lz5zaOsAqO23QNq8IYi4OVFsifK10KDDcXRe6P3EGDPUjTDX/EhTqsO+jllX+2891f
         QC7RfGiAtOdyQxZL+GWTVEVqFXGLAkmpF6V5hb8TOTNwajHwvDW7+X1wuLOU/A3J5vY4
         aXxRgPBWtbkiHKj2ryg0trjxjzAGcWvxry0yQSmh+rLEFcYIPwk/ZPmAcbd/ToZt3+bu
         YVB1JKWbIV91k/PLxOMQxUhRMWQ9Ns4d0De5R6X6vdRdJ9GWnAP4Ky8kX/WHacGEIX3Z
         xLB4XQ/NJ8GOiu0ccqRJAsHi2WyOrhDmW+OwG6PZmcWCMr/hQbUw5Xb+TSRr3pW5wL1d
         E0uQ==
X-Gm-Message-State: AFqh2krrxBICRNQ8r4kNaZGk+nxCQ6MMToA2lnQhTIdxkKOAhkC3gUp3
        vLo157MiYLwAlsRxdu2Xc2me5TNyMyEdD77XwEM=
X-Google-Smtp-Source: AMrXdXuMNiQzt+xeryqjTx8FNgLd+ZcquxV496yLzsQm6UltcFeIU+br+BbXlRQfDqV5YMRC7In5Dc/vsBmsrjaQV34=
X-Received: by 2002:a05:6638:36c6:b0:39e:8c9c:7e37 with SMTP id
 t6-20020a05663836c600b0039e8c9c7e37mr4970613jau.77.1674860929026; Fri, 27 Jan
 2023 15:08:49 -0800 (PST)
MIME-Version: 1.0
References: <20230127001951.3432374-1-namhyung@kernel.org> <bda606c2-2b1b-de9f-1386-8ee2bf925b4b@intel.com>
 <317a91ff-70c5-57a5-8447-7543057e4055@arm.com>
In-Reply-To: <317a91ff-70c5-57a5-8447-7543057e4055@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 27 Jan 2023 15:08:37 -0800
Message-ID: <CAM9d7chU6kTdG0y65_UaD_hW75GezzNJF1ZwjNWq8BUpACAGTA@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf intel-pt: Fix the pipe mode (v1)
To:     James Clark <james.clark@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Jan 27, 2023 at 6:42 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 27/01/2023 07:22, Adrian Hunter wrote:
> > On 27/01/23 02:19, Namhyung Kim wrote:
> >> Hello,
> >>
> >> I found some problems in Intel-PT and auxtrace in general with pipe.
> >> In the past it used to work with pipe, but recent code fails.
> >
> > Pipe mode is a problem for Intel PT and possibly other auxtrace users.
>
> Just some info from my side: For Arm Coresight we ended up deprecating
> pipe mode, then not supporting it altogether. First was when we added an
> optional step to peek through all of the data to help with an edge case.
> Then we added a requirement to receive a HW_ID packet before decoding
> which necessitated the peek. You can't peek in pipe mode because you
> need to be able to seek, so it's not supported at all anymore.
>
> For Arm SPE I never tested it with piped data. I suppose I could add a
> test at some point, but I don't really see the usecase.

Yeah, it'd be great if we can have a test for Arm SPE.

Anyway, my work env (Google) requires the pipe mode due to the
restriction in disk usage.  Without the pipe support, it's not possible
to run `perf record` in production.

Thanks,
Namhyung
