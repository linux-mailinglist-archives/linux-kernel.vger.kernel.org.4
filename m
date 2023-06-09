Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7EB72A103
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjFIRNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjFIRNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:13:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE6C3C00;
        Fri,  9 Jun 2023 10:12:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAC9265A37;
        Fri,  9 Jun 2023 17:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184B2C433EF;
        Fri,  9 Jun 2023 17:12:54 +0000 (UTC)
Date:   Fri, 9 Jun 2023 13:12:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jackie Liu <liu.yun@linux.dev>
Subject: Re: [PATCH RFC] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <20230609131253.0d67e746@gandalf.local.home>
In-Reply-To: <ZINW9FqIoja76DRa@krava>
References: <20230608212613.424070-1-jolsa@kernel.org>
        <CAEf4BzbNakGzcycJJJqLsFwonOmya8=hKLD41TWX2zCJbh=r-Q@mail.gmail.com>
        <20230608192748.435a1dbf@gandalf.local.home>
        <CAEf4BzYkNHu7hiMYWQWs_gpYOfHL0FVuf-O0787Si2ze=PFX5w@mail.gmail.com>
        <ZILhqvrjeFIPHauy@FVFF77S0Q05N>
        <ZINW9FqIoja76DRa@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2023 09:44:36 -0700
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Fri, Jun 09, 2023 at 09:24:10AM +0100, Mark Rutland wrote:
> > 
> > Do you need the address of the function entry-point or the address of the
> > patch-site within the function? Those can differ, and the rec->ip address won't
> > necessarily equal the address in /proc/kallsyms, so the pointer in
> > /proc/kallsyms won't (always) match the address we could print for the ftrace site.
> > 
> > On arm64, today we can have offsets of +0, +4, and +8, and within a single
> > kernel image different functions can have different offsets. I suspect in
> > future that we may have more potential offsets (e.g. due to changes for HW/SW
> > CFI).  
> 
> so we need that for kprobe_multi bpf link, which is based on fprobe,
> and that uses ftrace_set_filter_ips to setup the ftrace_ops filter
> 
> and ftrace_set_filter_ips works fine with ip address being the address
> of the patched instruction (it's matched in ftrace_location)

Yes, exactly. And it's off with the old "mcount" way of doing things too.

> 
> but right, I did not realize this.. it might cause confusion if people
> don't know it's patch-side addresses..  not sure if there's easy way to
> get real function address out of rec->ip, but it will also get more
> complicated on x86 when IBT is enabled, will check
> 
> or we could just use patch-side addresses and reflect that in the file's
> name like 'available_filter_functions_patch_addrs' .. it's already long
> name ;-)

No!  "available_filter_function_addrs" is enough to know that it's not
kallsyms. It's the filtered function address, which is enough description.
If people don't RTFM, then too bad ;-)

You can use ftrace_location() that takes an instruction pointer, and will
return the rec->ip of that function as long as it lands in between the
function's kallsyms start and end values.

-- Steve
