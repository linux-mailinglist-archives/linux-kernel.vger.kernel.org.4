Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F5B68736B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 03:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjBBCzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 21:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBBCzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 21:55:42 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7346A728CA;
        Wed,  1 Feb 2023 18:55:41 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id t18so512126wro.1;
        Wed, 01 Feb 2023 18:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9EyjIfbgptUK2LF3a5kUjyxnjAVq3qXJFHfKvB2EjI=;
        b=osETY1mJFb80FK1f4Ue19oEOS/pVKRrsMk+Hq+DCKJOUSFvrcML4lVkTd7RbguoPzb
         GtgNfs9PIWpNyONn4TYsQievYkSABB2bX8zsAZ1mgiHbUAQfNPQSWe6MnZCzE3cq+TwD
         s8ykX5wRUatxNw3sjXyUhY/HAQ6EWY5mTAwseUl+QL9nYYXtwQQ3HYaUlkJBdcE75uPv
         YtZDWOdP1NO+63AlNXhvyP2qS5jQzfiSoyrnqhW81gBnVtILhsH2Bmrz2L0dD9/fpoP/
         Pr8w/sW4wB1E78kXyT5TQGw/enQP7PIAOhfqLIffyzgfaqNetx+33+sid7Wm3e80lQlc
         RxrA==
X-Gm-Message-State: AO0yUKW/jYFcPIVdyftCb5GCYcZo2x4uCP7y+/czdN+cb6nvpsNhZcJt
        c+UP+dw4H1qqVkPeupoFIXudMdUzh2Yh/NtnxblGwSjp
X-Google-Smtp-Source: AK7set9pN1Xwh2+NZpOZEphmJ3EBcZWVA9ozm4WKeqHyI35rya+xVuCT51sRxFmOVcgWgFLGGEp9jIGBPWoXvxP6fgo=
X-Received: by 2002:a5d:6605:0:b0:2bf:c1b3:e015 with SMTP id
 n5-20020a5d6605000000b002bfc1b3e015mr223798wru.220.1675306539694; Wed, 01 Feb
 2023 18:55:39 -0800 (PST)
MIME-Version: 1.0
References: <Y01Mof9qMpFToRWY@kernel.org> <20230129232145.31307-1-hcvcastro@gmail.com>
 <Y9sQNUqaLqFCf0dN@kernel.org>
In-Reply-To: <Y9sQNUqaLqFCf0dN@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 1 Feb 2023 18:55:27 -0800
Message-ID: <CAM9d7cjLsnn5df60jNW5x-r514Z_tfy-r7By0PgZ9LDUhe=bAQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf: fix the probe finder location (.dwo files)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Henry Castro <hcvcastro@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Feb 1, 2023 at 5:22 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Sun, Jan 29, 2023 at 07:21:28PM -0400, Henry Castro escreveu:
> > If the file object is compiled using -gsplit-dwarf,
> > the probe finder location will fail.
> >
> > Signed-off-by: Henry Castro <hcvcastro@gmail.com>
> > ---
> >
> > Hi,
> >
> > Polite ping?  Any feedback?
>
> Namhyung, are you ok now? Masami, can you please take a look and provide
> an Acked-by or Reviewed-by?

Sorry about that.  I completely missed this..
Now it looks ok, but it'd be nice if Masami could review this.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> >  tools/perf/util/probe-finder.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> > index 50d861a80f57..5f6781e712db 100644
> > --- a/tools/perf/util/probe-finder.c
> > +++ b/tools/perf/util/probe-finder.c
> > @@ -1200,6 +1200,20 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
> >                       continue;
> >               }
> >
> > +#if _ELFUTILS_PREREQ(0, 171)
> > +             {
> > +                     uint8_t unit_type;
> > +                     Dwarf_Die cudie, subdie;
> > +
> > +                     /* Check separate debug information file. */
> > +                     if (dwarf_cu_info(pf->cu_die.cu, NULL,
> > +                                       &unit_type, &cudie,
> > +                                       &subdie, NULL,
> > +                                       NULL, NULL) == 0
> > +                         && unit_type == DW_UT_skeleton)
> > +                             pf->cu_die = subdie;
> > +             }
> > +#endif
> >               /* Check if target file is included. */
> >               if (pp->file)
> >                       pf->fname = cu_find_realpath(&pf->cu_die, pp->file);
> > --
> > 2.20.1
> >
>
> --
>
> - Arnaldo
