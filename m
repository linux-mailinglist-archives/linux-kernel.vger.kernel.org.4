Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7316C3894
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjCURsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCURsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:48:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4E893FB;
        Tue, 21 Mar 2023 10:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A481E61D70;
        Tue, 21 Mar 2023 17:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17C2C433EF;
        Tue, 21 Mar 2023 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679420888;
        bh=XdBv7dMWKQWKxGOS239zoahEirm3umu1JUUI+nQGGoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6Cfh60uLTCqTDgwE6WCuaEtBG/0Idu8xTtckfw1rqfo3G+/vj/NkUIH+f2QbP0ld
         LLJ4Oq/kXzTVcAzi5osGVtIkJET7Pe54+KZZFObAcN1MDkMgMAU0Vgml5XMeUHuvjk
         CRj9FdJv5YFPGoCmhnPlemFgdmOt9jjo9GK81fMyeMldV/tQKkcW2QHb9qblF/itow
         kkjjI7gP7RSn367adaoU/6oOl47C0WPlPCiKt3732PwcEiB0iJ/cst85w5hTv7KiNk
         5fzwZ3Kx3gO0hSUityQeAmZpUBSjs553w531+dK56Rn8KTDQxcHbl8DI4Ma2oskT7p
         tOrZVs8YceDfQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 505584052D; Tue, 21 Mar 2023 14:48:05 -0300 (-03)
Date:   Tue, 21 Mar 2023 14:48:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf kvm: Support refcnt in structure kvm_info
Message-ID: <ZBnt1XhhJL/7lsdl@kernel.org>
References: <20230320061619.29520-1-leo.yan@linaro.org>
 <20230320061619.29520-2-leo.yan@linaro.org>
 <ZBmqiKC1FSGI0/iE@kernel.org>
 <20230321142235.GD221467@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230321142235.GD221467@leoy-yangtze.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 21, 2023 at 10:22:35PM +0800, Leo Yan escreveu:
> On Tue, Mar 21, 2023 at 10:00:56AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> [...]
> 
> > > +static inline void __kvm_info__zput(struct kvm_info **ki)
> > > +{
> > > +	kvm_info__put(*ki);
> > > +	*ki = NULL;
> > > +}
> > > +
> > > +#define kvm_info__zput(ki) __kvm_info__zput(&ki)
> > > +
> > > +static inline struct kvm_info *kvm_info__new(void)
> > > +{
> > > +	struct kvm_info *ki;
> > > +
> > > +	ki = zalloc(sizeof(*ki));
> > > +	if (ki)
> > > +		refcount_set(&ki->refcnt, 1);
> > > +
> > > +	return ki;
> > > +}
> > > +
> > >  #endif /* HAVE_KVM_STAT_SUPPORT */
> > >  
> > >  extern int kvm_add_default_arch_event(int *argc, const char **argv);
> > 
> > I had to add this:
> > 
> > Provide a nop version of kvm_info__zput() to be used when
> > HAVE_KVM_STAT_SUPPORT isn't defined as it is used unconditionally in
> > hists__findnew_entry() and hist_entry__delete().
> 
> Thanks a lot, Arnaldo.
> 
> Just want to check, before I sent out this series I have run building
> test with the command `make -C tools/perf build-test` and I didn't see
> the building failure.  Do I need to run other testing?

Yes, but I didn't manage yet to make them public in a way that you could
use it easily :-\

I have a set of perf build containers and in some cases
HAVE_KVM_STAT_SUPPORT isn't defined, thus I noticed the problem.

Since you're working on kvm stat, maybe you could add a way to disable
it from the make command line and then add it to tools/perf/tests/make?

Here is an example of this for something that was opt-in:

⬢[acme@toolbox perf-tools-next]$ git show 9300acc6fed8e957c8d60f6f8e4451b508feea2c
commit 9300acc6fed8e957c8d60f6f8e4451b508feea2c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri May 29 16:25:34 2020 -0300

    perf build: Add a LIBPFM4=1 build test entry

    So that when one runs:

      $ make -C tools/perf build-test

    We make sure that recent changes don't break that opt-in build.

    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Andrii Nakryiko <andriin@fb.com>
    Cc: Daniel Borkmann <daniel@iogearbox.net>
    Cc: Florian Fainelli <f.fainelli@gmail.com>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Igor Lubashev <ilubashe@akamai.com>
    Cc: Jin Yao <yao.jin@linux.intel.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Jiwei Sun <jiwei.sun@windriver.com>
    Cc: John Garry <john.garry@huawei.com>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Leo Yan <leo.yan@linaro.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Martin KaFai Lau <kafai@fb.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Stephane Eranian <eranian@google.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Yonghong Song <yhs@fb.com>
    Cc: yuzhoujian <yuzhoujian@didichuxing.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 8fe6c7911f46e7ef..9b651dfe0a6b8a91 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -90,6 +90,7 @@ make_with_babeltrace:= LIBBABELTRACE=1
 make_no_sdt        := NO_SDT=1
 make_no_syscall_tbl := NO_SYSCALL_TABLE=1
 make_with_clangllvm := LIBCLANGLLVM=1
+make_with_libpfm4   := LIBPFM4=1
 make_tags           := tags
 make_cscope         := cscope
 make_help           := help
@@ -152,6 +153,7 @@ run += make_no_sdt
 run += make_no_syscall_tbl
 run += make_with_babeltrace
 run += make_with_clangllvm
+run += make_with_libpfm4
 run += make_help
 run += make_doc
 run += make_perf_o
⬢[acme@toolbox perf-tools-next]$


----------------------

Look at tools/perf/Makefile.perf and try to add a NO_KVM_STAT=1 perhaps,
and then add it to tools/perf/tests/make so that we catch problems like
the one I found and fixed in this thread.


Thanks,

- Arnaldo
