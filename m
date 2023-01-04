Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C87F65DD08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbjADTmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjADTmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:42:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F78DC1;
        Wed,  4 Jan 2023 11:42:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E468617F7;
        Wed,  4 Jan 2023 19:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45878C433EF;
        Wed,  4 Jan 2023 19:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672861354;
        bh=UHfk10VmRyhzrHAbPtPOJisE7qOppsAydAy+Wc6k6FU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fMYHmLy4bqN8unmX2KcmxsIiWFxfBaXJ/e3qr3HoV+XSO7SCX0y7FxYyPtmqY1zKb
         NHQpfGAc+TJmHUZfTpRRP9gV41BRTt+9DCkpSXYONpdB3w/fzfmJg7BiWJb5/7tb8+
         jRZVWrBrzbrhHf8uuLcmCAOVQ5GxNKJOD3oO5RUbc9nlCt9W+CJbOKBDKN4gBIYEo8
         EcuzxTxMU0BmwHEPcyVZYK6ko2/7Fgh7f94umlgIWWqBx0IyXc3XodgpS8djD11cPn
         edze6NqCZWyWmWmYgJfqvTFQSwfDUg1KLrBXCZM2xoQ1wHfofuvIRkelCeavWwACYL
         j2nHvv4GncH6A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9F66740468; Wed,  4 Jan 2023 16:42:31 -0300 (-03)
Date:   Wed, 4 Jan 2023 16:42:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>
Cc:     linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Add missing sys/types.h include
Message-ID: <Y7XWp9T3mZF52+FV@kernel.org>
References: <20230104182313.3164736-1-jesussanp@google.com>
 <Y7XP66TlOpkVlwyp@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7XP66TlOpkVlwyp@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 04, 2023 at 04:13:47PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jan 04, 2023 at 10:23:13AM -0800, Jesus Sanchez-Palencia escreveu:
> > Not all libc implementations define ssize_t as part of stdio.h like
> > glibc does since the standard only requires this type to be defined by
> > unistd.h and sys/types.h. For this reason the perf build is currently
> > broken for toolchains based on uClibc, for instance.
> > 
> > Include sys/types.h explicitly to fix that. This is a follow up to
> > commit 378ef0f5d9d7 ("perf build: Use libtraceevent from the system").
> 
> Do you mean this problem started with the 378ef0f5d9d7 commit? If so
> then this is the fase for adding:

Yeah, it was:

  tools/perf/util/trace-event.h
    /usr/include/traceevent/event_parse.h # This got removed from util/trace-event.h in 378ef0f5d9d7
      /usr/include/regex.h
        /usr/include/sys/types.h
	  typedef __ssize_t ssize_t;

So sys/types.h was _always_ missing in tools/perf/util/trace-event.h,
that got it by luck.

I'm adding these details and the Fixes tag pointed to that 378ef0f5d9d7
commit.

For the curious:

http://vger.kernel.org/~acme/perf/size_t_from_trace-event.h.ps

Using an old tool I wrote around graphviz :-)

- Arnaldo
 
> Fixes: 378ef0f5d9d7 ("perf build: Use libtraceevent from the system")
> 
> To this patch, ok?
  
> > Signed-off-by: Jesus Sanchez-Palencia <jesussanp@google.com>
> > ---
> >  tools/perf/util/trace-event.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> > index add6c5d9531c..9b3cd79cca12 100644
> > --- a/tools/perf/util/trace-event.h
> > +++ b/tools/perf/util/trace-event.h
> > @@ -4,6 +4,7 @@
> >  
> >  #include <stdbool.h>
> >  #include <stdio.h>
> > +#include <sys/types.h>
> >  #include <linux/types.h>
> >  
> >  struct evlist;
> > -- 
> > 2.39.0.314.g84b9a713c41-goog
