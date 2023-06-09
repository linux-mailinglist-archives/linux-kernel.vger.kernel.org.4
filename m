Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FD6729311
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbjFII1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbjFIIZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:25:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E3F449E6;
        Fri,  9 Jun 2023 01:24:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76E2DAB6;
        Fri,  9 Jun 2023 01:24:59 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.25.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6E033F71E;
        Fri,  9 Jun 2023 01:24:12 -0700 (PDT)
Date:   Fri, 9 Jun 2023 09:24:10 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jackie Liu <liu.yun@linux.dev>
Subject: Re: [PATCH RFC] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <ZILhqvrjeFIPHauy@FVFF77S0Q05N>
References: <20230608212613.424070-1-jolsa@kernel.org>
 <CAEf4BzbNakGzcycJJJqLsFwonOmya8=hKLD41TWX2zCJbh=r-Q@mail.gmail.com>
 <20230608192748.435a1dbf@gandalf.local.home>
 <CAEf4BzYkNHu7hiMYWQWs_gpYOfHL0FVuf-O0787Si2ze=PFX5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYkNHu7hiMYWQWs_gpYOfHL0FVuf-O0787Si2ze=PFX5w@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 04:55:40PM -0700, Andrii Nakryiko wrote:
> On Thu, Jun 8, 2023 at 4:27 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 8 Jun 2023 15:43:03 -0700 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > On Thu, Jun 8, 2023 at 2:26 PM Jiri Olsa <jolsa@kernel.org> wrote:
 
> There are BPF tools that allow user to specify regex/glob of kernel
> functions to attach to. This regex/glob is checked against
> available_filter_functions to check which functions are traceable. All
> good. But then also it's important to have corresponding memory
> addresses for selected functions (for many reasons, e.g., to have
> non-ambiguous and fast attachment by address instead of by name, or
> for some post-processing based on captured IP addresses, etc). And
> that means that now we need to also parse /proc/kallsyms and
> cross-join it with data fetched from available_filter_functions.
> 
> All this is unnecessary if avalable_filter_functions would just
> provide function address in the first place. It's a huge
> simplification. And saves memory and CPU.

Do you need the address of the function entry-point or the address of the
patch-site within the function? Those can differ, and the rec->ip address won't
necessarily equal the address in /proc/kallsyms, so the pointer in
/proc/kallsyms won't (always) match the address we could print for the ftrace site.

On arm64, today we can have offsets of +0, +4, and +8, and within a single
kernel image different functions can have different offsets. I suspect in
future that we may have more potential offsets (e.g. due to changes for HW/SW
CFI).

Thanks,
Mark.
