Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25E864685E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 05:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiLHE7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 23:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLHE72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 23:59:28 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561588C6A0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 20:59:27 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id p6so130071iod.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 20:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEABOhd6hdre/A2DrnBe6xPyxAgZ3J92ayUPieX7BSM=;
        b=JssevVea5i8jS+l86dT7ED0xxRmp4xv+sewRNcKYa6cJNVUeqbWYCXZhkD45jRmvKG
         4A1Ccj0rrOm1lyZOBE3U4H4QDhrqjtL6Aq3Ay8aPCSHrv3Q3Mdn6bJhHramL19tRMk5G
         dwHJQEsYay/XckRVXY0BB0onN3M5O7zCmQz2DmDG62JkCY+cbvCgmYWvjgeFdG/kpTF0
         vU8cjHoxitNvPDH+mqtWQ38ToSnRDwE85w47DD/tA/pYO69y6yqaoefM4Ct9l6lxsPxn
         sGkl1QkKa7GE8oMleSC+SVTBDJd2PlHBJhkdS5zhQ/546WAbjGu8vhRg83u0Iou0yO54
         BsDw==
X-Gm-Message-State: ANoB5plze4lctocUFVsxuhTG25WjvtjoLq1CIbUBrq/m2XunjgZNTpPt
        iyxW3t77ZjbND6L/ppseu5uzf4lQGC9yRnuwhzlJHSSV
X-Google-Smtp-Source: AA0mqf4ZUXezjdc/fC0vDmi6my8N2/z8vCLjOMUEsNpvrDTKVGXKcMIZZpoIZm9CIj7WsFb0g81ujms3Fo/6x91J//E=
X-Received: by 2002:a5d:87c8:0:b0:6e0:1ddd:7da6 with SMTP id
 q8-20020a5d87c8000000b006e01ddd7da6mr5899313ios.145.1670475566492; Wed, 07
 Dec 2022 20:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20221206154406.41941-1-petar.gligor@gmail.com>
 <CAM9d7cizPC3p0-Z1oYsDPofwNfZHyKYiJR5JXEcS31Q=mgzcLg@mail.gmail.com> <Y4/AfA2OYtlTkKwo@debian>
In-Reply-To: <Y4/AfA2OYtlTkKwo@debian>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 7 Dec 2022 20:59:15 -0800
Message-ID: <CAM9d7chLZVDg_-tnUh_qFYzchnpis-e7HYNDVM_OPjj_QXMeKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf: introduce perf based task analyzer
To:     Petar Gligoric <petar.gligor@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>
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

On Tue, Dec 6, 2022 at 2:21 PM Petar Gligoric <petar.gligor@gmail.com> wrote:
>
> On Tue, Dec 06, 2022 at 10:32:35AM -0800, Namhyung Kim wrote:
> > Hello,
> >
> > Have you looked at 'perf sched timehist' ?
> > I think it has the common functionality and can be easily extended if there's
> > missing one.
> >
> > Thanks,
> > Namhyung
> >
>
> Thanks for the input! For this patchset we explicitly decided against
> extending "perf sched timehist" - after some pros and cons. Mainly we
> didn't want to break existing programs (which might parse the output of
> perf sched) and also the goal of the task-analyzer is a bit different.
> E.g what will follow as a follow-up patch, is to show IRQs visually
> pleasing intermixed with tasks to show potential sources of task
> latency. This will be offered as an option for the task-analyzer, but
> would be too much functionality for "perf sched timehist". This was the
> main reason why we decided against the extension.

Then you might want to add a new sub-command under perf sched.
But I guess we can just add a new option for the different output
format in the perf sched timehist.

Anyway, "perf script" is a generic tool not targeting specific events.
This functionality requires sched_switch (and more?) then we need
the record part to make sure the data has the events.  That's why
it's natural to have it in perf sched IMHO.

Thanks,
Namhyung
