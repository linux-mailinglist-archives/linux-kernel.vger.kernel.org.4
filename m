Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734E16D1ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjCaIxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCaIxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC565BAD
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680252755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvLw4mvzyoe66j5YooKZQUM0RLq2l1MwiNMdbPsqMr8=;
        b=QuXGKX5Tpepi/JqY4eZM7xHIW9eu2cawDpGcTq7yke4S6iOK4nWlb2dqlKAALe4R1L+0f3
        KfHudHLNn5KmjKq7xEvP0Ffx1jhoAzUhJF7CQ4ct4N7p9NFntZlw11aqRqiO8WMZF2c/z2
        HH885rynjsRFgFBlXHJoQ06kLz8vFRg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-ku1Ytj2hPFuhoEakXWNdcg-1; Fri, 31 Mar 2023 04:52:29 -0400
X-MC-Unique: ku1Ytj2hPFuhoEakXWNdcg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7326A855300;
        Fri, 31 Mar 2023 08:52:28 +0000 (UTC)
Received: from samus.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 626D14042AC5;
        Fri, 31 Mar 2023 08:52:26 +0000 (UTC)
Date:   Fri, 31 Mar 2023 10:52:24 +0200
From:   Artem Savkov <asavkov@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH 0/1] perf report: append inlines to non-dwarf callchains
Message-ID: <20230331085224.GA688995@samus.usersys.redhat.com>
References: <20230316133557.868731-1-asavkov@redhat.com>
 <CAM9d7ciT7Wtmxt0_2ZVv4nbAb1KoeX_itTSAhz8B9T41-NeZYQ@mail.gmail.com>
 <ZBQZoyJc7mhUrL8n@samus.usersys.redhat.com>
 <CAM9d7ch9NjnaB5dB6fO7WKdwPd8M9DmNpdu4-V-8R+96ssxMvA@mail.gmail.com>
 <ZBtalEw0qKQFlVWR@kernel.org>
 <8f7077e8-bcce-a13f-48d3-92a3cb80b02a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f7077e8-bcce-a13f-48d3-92a3cb80b02a@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 08:06:20AM +0300, Adrian Hunter wrote:
> On 22/03/23 21:44, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Mar 22, 2023 at 11:18:49AM -0700, Namhyung Kim escreveu:
> >> On Fri, Mar 17, 2023 at 12:41 AM Artem Savkov <asavkov@redhat.com> wrote:
> >>>
> >>> On Thu, Mar 16, 2023 at 02:26:18PM -0700, Namhyung Kim wrote:
> >>>> Hello,
> >>>>
> >>>> On Thu, Mar 16, 2023 at 6:36 AM Artem Savkov <asavkov@redhat.com> wrote:
> >>>>>
> >>>>> In an email to Arnaldo Andrii Nakryiko suggested that perf can get
> >>>>> information about inlined functions from dwarf when available and then
> >>>>> add it to userspace stacktraces even in framepointer or lbr mode.
> >>>>> Looking closer at perf it turned out all required bits and pieces are
> >>>>> already there and inline information can be easily added to both
> >>>>> framepointer and lbr callchains by adding an append_inlines() call to
> >>>>> add_callchain_ip().
> >>>>
> >>>> Looks great!  Have you checked it with perf report -g callee ?
> >>>> I'm not sure the ordering of inlined functions is maintained
> >>>> properly.  Maybe you can use --no-children too to simplify
> >>>> the output.
> >>>
> >>> Thanks for the suggestion. I actually have another test program with
> >>> functions being numbered rather than (creatively) named, so it might be
> >>> easier to use it to figure out ordering. Here's the code:
> >>
> >> Yep, looks good.
> >>
> >> Acked-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > So, I'll apply this shorter patch instead, ok?
> > 
> > - Arnaldo
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 803c9d1803dd26ef..abf6167f28217fe6 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -44,6 +44,7 @@
> >  #include <linux/zalloc.h>
> >  
> >  static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
> > +static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);
> >  
> >  static struct dso *machine__kernel_dso(struct machine *machine)
> >  {
> > @@ -2322,6 +2323,10 @@ static int add_callchain_ip(struct thread *thread,
> >  	ms.maps = al.maps;
> >  	ms.map = al.map;
> >  	ms.sym = al.sym;
> > +
> > +	if (append_inlines(cursor, &ms, ip) == 0)
> > +		return 0;
> > +
> >  	srcline = callchain_srcline(&ms, al.addr);
> >  	return callchain_cursor_append(cursor, ip, &ms,
> >  				       branch, flags, nr_loop_iter,
> 
> This seems to be breaking --branch-history.  I am not sure
> append_inlines() makes sense for branches.  Maybe this should be:
> 
> 	if (!branch && !append_inlines(cursor, &ms, ip))
> 		return 0;
> 

Right. So when cllchain_cursor is appended through append_inlines it
always discards branch information, even for the non-inlined function.
So adding !branch makes sense to me. Does anyone else see any problems
with that?

-- 
 Artem

