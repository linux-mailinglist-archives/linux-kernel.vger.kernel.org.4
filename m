Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079E76C697A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjCWN1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjCWN1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:27:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFADD23A62;
        Thu, 23 Mar 2023 06:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C6D7626C2;
        Thu, 23 Mar 2023 13:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0C5C433D2;
        Thu, 23 Mar 2023 13:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679578058;
        bh=yGbF5Q3qHUa3pndqRjQnQx3tEe3gowJu+n88KB3G++c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITDZtljquGRjLZwSbnlTqd/Ku/JhcLqsTDc8JIMl3CTm51cs8MwRCN4ZMV/Pa3PMS
         tq46rpXPLD/zOvTM9AfM0R33X1/U5rSXbUi9Zu0cMbmZiOkCTHjbEQKSHqLuvlxU0b
         hWXd90deIKteXf7VtCgeBq/eEFn4VilMNTtmzhab63ZajiV260Mq2tC2XPObdnTyVL
         GGptvLi4t5F06KJImm/VDS7Hay1U4cJ4eI0l0GSBz0ocil5+Bbiq6SMxqyOiWCu7YG
         czy7DXoPiNvWJocrRkGvaL20/VuLPIDMPfWGQMmNRm4ID79JTwKR4vEsCu9JgSmrv3
         08EG9kRvA1I6Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 34F2E4052D; Thu, 23 Mar 2023 10:27:36 -0300 (-03)
Date:   Thu, 23 Mar 2023 10:27:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        namhyung@kernel.org
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <ZBxTyLqkIaoVhIXU@kernel.org>
References: <20230317095025.49aa34f9@canb.auug.org.au>
 <20230322083956.5c051777@canb.auug.org.au>
 <CAP-5=fUHqrQWPjk7QJB=r2Gzj7z5X3nL4bRuBAKzy2HvdSAr-A@mail.gmail.com>
 <20230323095437.1ecccec1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230323095437.1ecccec1@canb.auug.org.au>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 23, 2023 at 09:54:37AM +1100, Stephen Rothwell escreveu:
> Hi Ian,
> 
> On Wed, 22 Mar 2023 11:37:31 -0700 Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, Mar 21, 2023 at 2:40 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > On Fri, 17 Mar 2023 09:50:25 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:  
> > > >
> > > > After merging the perf tree, today's linux-next build (native perf)
> > > > failed like this:
> > > >
> > > > Auto-detecting system features:
> > > > ...                         clang-bpf-co-re: [  [32mon [m  ]
> > > > ...                                    llvm: [  [31mOFF [m ]
> > > > ...                                  libcap: [  [32mon [m  ]
> > > > ...                                  libbfd: [  [32mon [m  ]
> > > >
> > > > make[1]: *** Deleting file '/home/sfr/next/perf/util/bpf_skel/vmlinux.h'
> > > > libbpf: failed to find '.BTF' ELF section in /boot/vmlinux-6.0.0-5-powerpc64le
> > > > Error: failed to load BTF from /boot/vmlinux-6.0.0-5-powerpc64le: No data available
> > > > make[1]: *** [Makefile.perf:1075: /home/sfr/next/perf/util/bpf_skel/vmlinux.h] Error 195
> > > > make[1]: *** Waiting for unfinished jobs....
> > > > make: *** [Makefile.perf:236: sub-make] Error 2
> > > > Command exited with non-zero status 2
> > > >
> > > > To be clear this is a native build of perf on a PPC64le host using this
> > > > command line:
> > > >
> > > > make -C tools/perf -f Makefile.perf -s -O -j60 O=../perf EXTRA_CFLAGS=-Wno-psabi
> > > >
> > > > (I could probably remove the EXTRA_CLFAGS now that I am building with
> > > > gcc 12.2)
> > > >
> > > > I don't know which commit caused this.
> > > >
> > > > I have used the perf tree from next-20230316 for today.  
> > >
> > > I am still getting this build failure.  

> > The build failure is intentional as not having BPF skeleton support in
> > the perf tool will remove features. I've just sent:
> > https://lore.kernel.org/lkml/20230322183108.1380882-1-irogers@google.com/
> > Which will recommend adding NO_BPF_SKEL=1 to your build options when
> > this failure occurs. I didn't think a features test was appropriate
> > for this as the feature test would basically replicate the vmlinux.h
> > generation and I didn't want to move that support through the build
> > system.
 
> I was trying to understand why this step fails, but from the error
> messages, it seems to require something to be present in the distro
> supplied kernel image?  Is there something missing from the ppc
> build process?  Or toolchain?  Why is it looking at the installed
> kernel and not the built kernel?  Does the perf build now depend on the
> kernel being built first?
> 
> I will add NO_BPF_SKEL=1 to my build from tomorrow, but surely that
> means that we miss some perf build testing :-(

Before this BUILD_BPF_SKEL wasn't on by default, so you're back testing
as much as before.

Having said that, we need to improve the warning and I processed a patch
from Ian to that extent:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf-tools-next&id=12a83df53444165d39d3e09fcd9627e7bec7828e

 $(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
 ifeq ($(VMLINUX_H),)
-	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
+	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@ || \
+	(echo "Failure to generate vmlinux.h needed for the recommended BPF skeleton support." && \
+	echo "To disable this use the build option NO_BPF_SKEL=1." && \
+	echo "Alternatively point at a pre-generated vmlinux.h with VMLINUX_H=<path>." && \
+	false)
 else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif

 Which improves a bit the situation.

We could check if bpftool is available and if not, suggest installing
it.

If it is available, we could check if /sys/kernel/bpf/ is available, if
not suggest using a kernel with CONFIG_DEBUG_INFO_BTF=y, as most distros
have by now.

As to the features this enables:

⬢[acme@toolbox perf-tools-next]$ ls -la tools/perf/util/bpf_skel/*.c
-rw-r--r--. 1 acme acme 5581 Oct 17 09:07 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
-rw-r--r--. 1 acme acme 1764 May  5  2022 tools/perf/util/bpf_skel/bperf_follower.bpf.c
-rw-r--r--. 1 acme acme 1438 May  5  2022 tools/perf/util/bpf_skel/bperf_leader.bpf.c
-rw-r--r--. 1 acme acme 2290 May  5  2022 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
-rw-r--r--. 1 acme acme 2164 May  5  2022 tools/perf/util/bpf_skel/func_latency.bpf.c
-rw-r--r--. 1 acme acme 9017 Aug 26  2022 tools/perf/util/bpf_skel/kwork_trace.bpf.c
-rw-r--r--. 1 acme acme 9251 Mar 14 08:33 tools/perf/util/bpf_skel/lock_contention.bpf.c
-rw-r--r--. 1 acme acme 6109 Feb 27 17:47 tools/perf/util/bpf_skel/off_cpu.bpf.c
-rw-r--r--. 1 acme acme 4310 Mar 15 11:08 tools/perf/util/bpf_skel/sample_filter.bpf.c
⬢[acme@toolbox perf-tools-next]$

For instance, take a look at these csets:

⬢[acme@toolbox perf-tools-next]$ git log --oneline tools/perf/util/bpf_skel/lock_contention.bpf.c
d24c0144b1dde00f perf lock contention: Show per-cpu rq_lock with address
1811e82767dcc6eb perf lock contention: Track and show siglock with address
3ace2435bb93445e perf lock contention: Track and show mmap_lock with address
17535a33a9c1e4fb perf lock contention: Fix compiler builtin detection
1bece1351c653c3d perf lock contention: Support old rw_semaphore type
3477f079fe70b3c9 perf lock contention: Add -o/--lock-owner option
ebab291641bed48f perf lock contention: Support filters for different aggregation
5e3febe7b7b99f94 perf lock contention: Support lock addr/name filtering for BPF
529772c4df286159 perf lock contention: Support lock type filtering for BPF
688d2e8de231c54e perf lock contention: Add -l/--lock-addr option
eca949b2b4addd94 perf lock contention: Implement -t/--threads option for BPF
fd507d3e359c7e06 perf lock contention: Add lock_data.h for common data
c66a36af7ba3a628 perf lock contention: Do not use BPF task local storage
433b31fa00797a2a perf lock contention: Fix a build error on 32-bit
c1da8dd5c11dabd5 perf lock contention: Skip stack trace from BPF
6d499a6b3d90277d perf lock: Print the number of lost entries for BPF
6fda2405f414b24a perf lock: Implement cpu and task filters for BPF
407b36f69efbdccf perf lock: Use BPF for lock contention analysis
⬢[acme@toolbox perf-tools-next]$


or:

⬢[acme@toolbox perf-tools-next]$ git log --oneline tools/perf/util/bpf_skel/kwork_trace.bpf.c
acfb65fe1d11a97f perf kwork: Add workqueue trace BPF support
5a81927a407c050a perf kwork: Add softirq trace BPF support
420298aefe94840f perf kwork: Add IRQ trace BPF support
daf07d220710a3c8 perf kwork: Implement BPF trace
⬢[acme@toolbox perf-tools-next]$

So we need to fine tune this detection of needed components to build
these features, in time for the v6.4 merge window, that is why we
decided  to make this opt-out to hammer out problems.

Other arches probably will hit some of these problems, lets try to
encourage others to try what is in linux-next.

- Arnaldo
