Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0CE5FDE95
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJMQ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiJMQ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:57:52 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94BF4D4E3;
        Thu, 13 Oct 2022 09:57:50 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1370acb6588so2970755fac.9;
        Thu, 13 Oct 2022 09:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wp9gOD2D8Cn2++oAEo67TBNzJG0AuFo0QYkoCA4FJW0=;
        b=ks8AQCp+maiExyHfoGNUdQVCQLJDYUWQgClqgr7n4rROJlLWfuZ1q+/DvlnOGUYHDo
         lo0pqTOhoDhJDGcgDCFvYQNzpBetYQY2LNudSw9HfxLXslUhx+WNV0JX54prCbphTcoG
         fWu1ZaJFlRvbpv9celKGUPApWCSTmV4wEDRyNI47wdIBz6MZQImb2ISY/eg3mRcMIHrh
         7KX2Tg1Dqpp0XoyNUijeVpz+ey2jU5VqHNzMFp/vw+Di83iUDvfD1C1KYYxkzUfg8GK7
         SuC8xtspH5Hdyv3gvc2HmRzqe4fiuRF/wkyOt8UKLWczy8qnrHmF5gUJ5HXc4hGoKlX3
         trkQ==
X-Gm-Message-State: ACrzQf2EaiKdIxkj01Wn+ZQ6972rLLHkTiy2K/XvAV3vUOxn5p3+sP2/
        beLt2lb2v4of3rlfmSrE23D0mfPvTmcNdb3AFf4=
X-Google-Smtp-Source: AMsMyM60dbAgh8DjIGH3/Ouhpt7QTFvoI/CT9wWyi8j5wpPrdSarlVjMRaDP9KxfUG0bTwiVROhR4BDG4myCpjJRNK4=
X-Received: by 2002:a05:6870:4184:b0:136:5e73:b40e with SMTP id
 y4-20020a056870418400b001365e73b40emr334466oac.209.1665680269454; Thu, 13 Oct
 2022 09:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221012111025.30609-1-james.clark@arm.com> <62f485df-4f5e-64a2-1294-6e162de25556@arm.com>
 <CAM9d7cgNrZ6iwRQsGHWGLWCd7cJm+L6UOU9BiGGgTVPdJ0_GJQ@mail.gmail.com> <e0b47b51-87f0-42db-4a76-b240bf07cd41@arm.com>
In-Reply-To: <e0b47b51-87f0-42db-4a76-b240bf07cd41@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 13 Oct 2022 09:57:38 -0700
Message-ID: <CAM9d7cg+tTw5vTOycqRciQx8He-WLG0TSdcWa0tyzeu49DmgxA@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix "Track with sched_switch" test by not printing
 warnings in quiet mode
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 10:12 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 12/10/2022 17:50, Namhyung Kim wrote:
> > On Wed, Oct 12, 2022 at 4:13 AM James Clark <james.clark@arm.com> wrote:
> >>> The test already supplies -q to run in quiet mode, so extend quiet mode
> >>> to perf_stdio__warning() and also ui__warning() for consistency.
> >
> > I'm not sure if suppressing the warnings with -q is a good thing.
> > Maybe we need to separate warning/debug messages from the output.
>
> I don't see the issue with warnings being suppressed in quiet mode as
> long as errors are still printed. In other cases warnings have already
> been suppressed by quiet mode and this site is the odd one out.
>
> What use case are you thinking of where someone explicitly adds -q but
> wants to see non fatal warnings?

I don't have any specific use case.  If it's already suppressed in other
cases, I'm fine with it.

Thanks,
Namhyung
