Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91D36C618B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjCWIXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCWIXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722AF2FCC2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679559757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQFvGwxqqLN396IhDeFz5FJaqv+iuigtoiE/PIq/ePw=;
        b=fLBjWLJTxMd6Hpnev36RTwRCPU5hYSiuVO5c6enLAHSCJLqXCMAQhkpsCpb0rf/eYhSD+3
        i7dIvL+T54xDDfCzjWhsdmWgTbcqYwT7fvO46QgHpNtt6vyyH62O19zIb6izU2kWDOzFl8
        502lW71sNyvEtYNDysAIgqyKOyDFmZY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-La0iLdZ6O_SkidRSz9vVcg-1; Thu, 23 Mar 2023 04:22:34 -0400
X-MC-Unique: La0iLdZ6O_SkidRSz9vVcg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7E4E185A790;
        Thu, 23 Mar 2023 08:22:32 +0000 (UTC)
Received: from samus.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADF6640C6E67;
        Thu, 23 Mar 2023 08:22:30 +0000 (UTC)
Date:   Thu, 23 Mar 2023 09:22:28 +0100
From:   Artem Savkov <asavkov@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20230323082228.GA94843@samus.usersys.redhat.com>
References: <20230316133557.868731-1-asavkov@redhat.com>
 <CAM9d7ciT7Wtmxt0_2ZVv4nbAb1KoeX_itTSAhz8B9T41-NeZYQ@mail.gmail.com>
 <ZBQZoyJc7mhUrL8n@samus.usersys.redhat.com>
 <CAM9d7ch9NjnaB5dB6fO7WKdwPd8M9DmNpdu4-V-8R+96ssxMvA@mail.gmail.com>
 <ZBtalEw0qKQFlVWR@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBtalEw0qKQFlVWR@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 04:44:20PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 22, 2023 at 11:18:49AM -0700, Namhyung Kim escreveu:
> > On Fri, Mar 17, 2023 at 12:41 AM Artem Savkov <asavkov@redhat.com> wrote:
> > >
> > > On Thu, Mar 16, 2023 at 02:26:18PM -0700, Namhyung Kim wrote:
> > > > Hello,
> > > >
> > > > On Thu, Mar 16, 2023 at 6:36 AM Artem Savkov <asavkov@redhat.com> wrote:
> > > > >
> > > > > In an email to Arnaldo Andrii Nakryiko suggested that perf can get
> > > > > information about inlined functions from dwarf when available and then
> > > > > add it to userspace stacktraces even in framepointer or lbr mode.
> > > > > Looking closer at perf it turned out all required bits and pieces are
> > > > > already there and inline information can be easily added to both
> > > > > framepointer and lbr callchains by adding an append_inlines() call to
> > > > > add_callchain_ip().
> > > >
> > > > Looks great!  Have you checked it with perf report -g callee ?
> > > > I'm not sure the ordering of inlined functions is maintained
> > > > properly.  Maybe you can use --no-children too to simplify
> > > > the output.
> > >
> > > Thanks for the suggestion. I actually have another test program with
> > > functions being numbered rather than (creatively) named, so it might be
> > > easier to use it to figure out ordering. Here's the code:
> > 
> > Yep, looks good.
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> So, I'll apply this shorter patch instead, ok?

Looks good to me, much cleaner. Thanks.

> - Arnaldo
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 803c9d1803dd26ef..abf6167f28217fe6 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -44,6 +44,7 @@
>  #include <linux/zalloc.h>
>  
>  static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
> +static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);
>  
>  static struct dso *machine__kernel_dso(struct machine *machine)
>  {
> @@ -2322,6 +2323,10 @@ static int add_callchain_ip(struct thread *thread,
>  	ms.maps = al.maps;
>  	ms.map = al.map;
>  	ms.sym = al.sym;
> +
> +	if (append_inlines(cursor, &ms, ip) == 0)
> +		return 0;
> +
>  	srcline = callchain_srcline(&ms, al.addr);
>  	return callchain_cursor_append(cursor, ip, &ms,
>  				       branch, flags, nr_loop_iter,

-- 
 Artem

