Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD20A64291E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiLENRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiLENQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:16:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E321A232;
        Mon,  5 Dec 2022 05:16:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEC98B80F79;
        Mon,  5 Dec 2022 13:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5391DC433D6;
        Mon,  5 Dec 2022 13:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670246202;
        bh=K0wO0fZAcT1JLDcHrwAPZK7snFfOuqbvKkHzWu3AJU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCqwmmzX61WuTJJBKaNCTHN2J51bck6n44krFWPJiMsF6IFUjQBAi2xdHmkPQ9bK6
         xmnAujeTegnRHNUFA5k3drmvPgOB1GZxQzE1oVi4VXkg/Ghtt63K6BhgETRvlBS9nG
         VSVCKkLzQtwaRyN1rKmRlZRvObPrQeKg9LSeE1F8NMkIBYCJzKWCBFEcmt2RZ3ssTp
         tNvD0CKYDL1z1Os37IuirZyiWCXpwcsoe8ApCD8+0bvhLZ2QU6ZvxypDNvSvYpebVC
         lrnSYpAtfJDJi9qUtMH6oHgS5fnrOH6Mtc83CmLnaI6s1r/tv8SMKqroWgrKSI0fFU
         BvHitvMciDSww==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EAE9740404; Mon,  5 Dec 2022 10:16:39 -0300 (-03)
Date:   Mon, 5 Dec 2022 10:16:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 2/4] perf util: Add host_is_bigendian to util.h
Message-ID: <Y43vN2cxlSERMh2/@kernel.org>
References: <20221130062935.2219247-1-irogers@google.com>
 <20221130062935.2219247-3-irogers@google.com>
 <CAM9d7cg1pmkMTFEoK7tNxQTmux7obr7KPr-5SPNDrB=S5Xp=vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg1pmkMTFEoK7tNxQTmux7obr7KPr-5SPNDrB=S5Xp=vw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 30, 2022 at 10:52:35AM -0800, Namhyung Kim escreveu:
> On Tue, Nov 29, 2022 at 10:30 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Avoid libtraceevent dependency for tep_is_bigendian or trace-event.h
> > dependency for bigendian. Add a new host_is_bigendian to util.h, using
> > the compiler defined __BYTE_ORDER__ when available.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> A nit below...
> 
> > ---
> [SNIP]
> > diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> > index 63cdab0e5314..87d418cb6792 100644
> > --- a/tools/perf/util/util.h
> > +++ b/tools/perf/util/util.h
> > @@ -94,4 +94,23 @@ int do_realloc_array_as_needed(void **arr, size_t *arr_sz, size_t x,
> >                 0;                                              \
> >         })
> >
> > +static inline bool host_is_bigendian(void)
> > +{
> > +#ifdef __BYTE_ORDER__
> > +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> > +       return false;
> > +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> > +       return true;
> > +#else
> > +#error "Unrecognized __BYTE_ORDER__"
> > +#endif
> > +#else
> 
> It'd be nice if we could have a comment at least there's a nested
> ifdef condition.  Like below?
> 
> #else  /* !__BYTE_ORDER__ */

Reasonable, added it and applied the first two patches in this series,
with your Acked-by, thanks.

- Arnaldo


diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 87d418cb67929576..a06c54ab85ee4506 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -104,7 +104,7 @@ static inline bool host_is_bigendian(void)
 #else
 #error "Unrecognized __BYTE_ORDER__"
 #endif
-#else
+#else /* !__BYTE_ORDER__ */
 	unsigned char str[] = { 0x1, 0x2, 0x3, 0x4, 0x0, 0x0, 0x0, 0x0};
 	unsigned int *ptr;
 
