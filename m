Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3F36CF817
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 02:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjC3ANm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 20:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC3ANj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:13:39 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B78259D0;
        Wed, 29 Mar 2023 17:13:30 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id bg13-20020a05600c3c8d00b003ef90adc168so2950019wmb.5;
        Wed, 29 Mar 2023 17:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680135209; x=1682727209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MbJUhmfp2/sjO2bCujmzTffPzek7PDtiEwqtyllI5s=;
        b=NgJh1Lh8+YqvKQ05GQYt4TL4YhRX6tSC4xyScv6DEuPFup30FLCCPTJ1YawMGuTged
         z2WFf7yXn9swA6Y5Iog++XHj+Rdr3NylWPkWpxXDcKw9dJOYdnWhs4m9U4d/w/fbqjqB
         px1lb03fK9MruDiZMqQzNvy+J6v05VD84Ei18+h4NpxHqoPxG3EClgbhyw+kkF8TiL7l
         fkJ1c95lhOwfq8eHlD9I1bxoWEA5bLlBeC+VKsbDjxr0vOiGiiPKrFtbJ1SDuLu1zowV
         u4k0Wx+nTQ5gEuZKctL5J4ZWHg/TiswUMGQt+JHkOmxej+SsQJ5ujuqHkag4MbG5YxmT
         lOAw==
X-Gm-Message-State: AO0yUKULpPzA2btmDD9Ys1jHSnsDoytmDEFdOlWLA8CO0cHnawQTC3mu
        PXykoWW9M0jE9+CwIntuTl7zLSCmiWxr8BcaDVs=
X-Google-Smtp-Source: AK7set+xUSucWKhr/d8qUx5lNEsNTPJQ/xRt2amK24OOt3jck3xt0Sn8BYbJfoO4e7g7n3olRvv7l+WhLCiaf/aBZxE=
X-Received: by 2002:a1c:4b07:0:b0:3eb:29fe:f911 with SMTP id
 y7-20020a1c4b07000000b003eb29fef911mr16334958wma.13.1680135208723; Wed, 29
 Mar 2023 17:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235543.1082207-1-irogers@google.com> <20230328235543.1082207-2-irogers@google.com>
 <ZCQ4nERbit/f6yhh@kernel.org> <ZCQ6kqhODsxSCXdP@kernel.org>
In-Reply-To: <ZCQ6kqhODsxSCXdP@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Mar 2023 17:13:17 -0700
Message-ID: <CAM9d7cjSEx_=UTMpDHMwGb=5H6Yf8UdHTMt1xO=4CVToh60oSA@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] perf annotate: Delete session for debug builds
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, James Clark <james.clark@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Andres Freund <andres@anarazel.de>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 6:18 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Mar 29, 2023 at 10:09:48AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Mar 28, 2023 at 04:55:38PM -0700, Ian Rogers escreveu:
> > > Use the debug build indicator as the guide to free the session. This
> > > implements a behavior described in a comment, which is consequentially
> > > removed.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/builtin-annotate.c | 16 ++++++----------
> > >  1 file changed, 6 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > > index 4750fac7bf93..98d1b6379230 100644
> > > --- a/tools/perf/builtin-annotate.c
> > > +++ b/tools/perf/builtin-annotate.c
> > > @@ -692,16 +692,12 @@ int cmd_annotate(int argc, const char **argv)
> > >
> > >  out_delete:
> > >     /*
> > > -    * Speed up the exit process, for large files this can
> > > -    * take quite a while.
> > > -    *
> > > -    * XXX Enable this when using valgrind or if we ever
> > > -    * librarize this command.
> > > -    *
> > > -    * Also experiment with obstacks to see how much speed
> > > -    * up we'll get here.
> > > -    *
> > > -    * perf_session__delete(session);
> > > +    * Speed up the exit process by only deleting for debug builds. For
> > > +    * large files this can save time.
> > >      */
> > > +#ifndef NDEBUG
> > > +   perf_session__delete(annotate.session);
> > > +#endif
> >
> > So now, but default, we will call this, as we don't have this defined
> > only if DEBUG=1 is set, right?
> >
> > ⬢[acme@toolbox perf-tools-next]$ find tools/perf/ -type f | xargs grep NDEBUG
> > tools/perf/util/mutex.c:#ifndef NDEBUG
> > ⬢[acme@toolbox perf-tools-next]$
>
> We can discuss this later, applied the series with just that zfree()
> change to annotation_options__exit().

I don't think it's just an issue in the perf annotate.  Maybe we can
do the same for perf report and so on.

Anyway we could define NDEBUG=1 for release builds from now on.

Thanks,
Namhyung
