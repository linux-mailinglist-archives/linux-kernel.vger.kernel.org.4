Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903716C5522
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCVTor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCVTo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:44:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAFC2E0D8;
        Wed, 22 Mar 2023 12:44:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86BA7622AF;
        Wed, 22 Mar 2023 19:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C18C4339B;
        Wed, 22 Mar 2023 19:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679514264;
        bh=v6wrCRpwTbs+zrgf9K0oaoTZYkFPhLyZviupJEf1tXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plL7QeiGkYaJ0K144eidjv+DgL5AyOb2UMgZXIgM8GpE8fWlN60RmyPAEnM94Bdvy
         j7G+yZsXksKF//eOGBis30TdbueyeeEXd0kd872oVYjvc/aHaXKbYAqq7RnwQMZRpI
         WUuCrQMcshiDkBmY5+nAzvcpVYNTew3AXLlFCmZ6XdSBSs9Y/cSYYLwRrVrhXJcrES
         cz9Yp2lwfrQclyWeT3sNxzeI60NqJaEXwg9LVFC3n0ecTHTJPRHBaePidHNP/jjD0D
         7mKahClgSBj8UWM+2892i7lUoTReyf30CBhYunHRzsYjpJNA4RtsMFnuvEDDuTqteH
         pen58IO4Ug4Gg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B24044052D; Wed, 22 Mar 2023 16:44:20 -0300 (-03)
Date:   Wed, 22 Mar 2023 16:44:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH 0/1] perf report: append inlines to non-dwarf callchains
Message-ID: <ZBtalEw0qKQFlVWR@kernel.org>
References: <20230316133557.868731-1-asavkov@redhat.com>
 <CAM9d7ciT7Wtmxt0_2ZVv4nbAb1KoeX_itTSAhz8B9T41-NeZYQ@mail.gmail.com>
 <ZBQZoyJc7mhUrL8n@samus.usersys.redhat.com>
 <CAM9d7ch9NjnaB5dB6fO7WKdwPd8M9DmNpdu4-V-8R+96ssxMvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ch9NjnaB5dB6fO7WKdwPd8M9DmNpdu4-V-8R+96ssxMvA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 22, 2023 at 11:18:49AM -0700, Namhyung Kim escreveu:
> On Fri, Mar 17, 2023 at 12:41 AM Artem Savkov <asavkov@redhat.com> wrote:
> >
> > On Thu, Mar 16, 2023 at 02:26:18PM -0700, Namhyung Kim wrote:
> > > Hello,
> > >
> > > On Thu, Mar 16, 2023 at 6:36 AM Artem Savkov <asavkov@redhat.com> wrote:
> > > >
> > > > In an email to Arnaldo Andrii Nakryiko suggested that perf can get
> > > > information about inlined functions from dwarf when available and then
> > > > add it to userspace stacktraces even in framepointer or lbr mode.
> > > > Looking closer at perf it turned out all required bits and pieces are
> > > > already there and inline information can be easily added to both
> > > > framepointer and lbr callchains by adding an append_inlines() call to
> > > > add_callchain_ip().
> > >
> > > Looks great!  Have you checked it with perf report -g callee ?
> > > I'm not sure the ordering of inlined functions is maintained
> > > properly.  Maybe you can use --no-children too to simplify
> > > the output.
> >
> > Thanks for the suggestion. I actually have another test program with
> > functions being numbered rather than (creatively) named, so it might be
> > easier to use it to figure out ordering. Here's the code:
> 
> Yep, looks good.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

So, I'll apply this shorter patch instead, ok?

- Arnaldo

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 803c9d1803dd26ef..abf6167f28217fe6 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -44,6 +44,7 @@
 #include <linux/zalloc.h>
 
 static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
+static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);
 
 static struct dso *machine__kernel_dso(struct machine *machine)
 {
@@ -2322,6 +2323,10 @@ static int add_callchain_ip(struct thread *thread,
 	ms.maps = al.maps;
 	ms.map = al.map;
 	ms.sym = al.sym;
+
+	if (append_inlines(cursor, &ms, ip) == 0)
+		return 0;
+
 	srcline = callchain_srcline(&ms, al.addr);
 	return callchain_cursor_append(cursor, ip, &ms,
 				       branch, flags, nr_loop_iter,
