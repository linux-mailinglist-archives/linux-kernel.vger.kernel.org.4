Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE0560CD17
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiJYNLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiJYNKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:10:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D74133343;
        Tue, 25 Oct 2022 06:10:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED10C6192B;
        Tue, 25 Oct 2022 13:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E2DC433D6;
        Tue, 25 Oct 2022 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666703448;
        bh=bw03ye+rKmsbJIFPx/gqKVQcse2xCyext/afkDTHNgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFF1KfhIa+bjSE5HPkhIJ5sFxpcsyvYHolYGozyIAgw8a/YnpBippARd7DVRhDrjE
         +yw1Y7+2xS0IoS2JuE7Oe3aOltqiUA1GzL8nWbK1cD02yQRWWq3L0eEex+q+Xukw/9
         PY5ID6lyYe33QctLppJC29WO53mjWA7pHbKnx8HMmHCZsPhnEgINvOpIQ7XyQ+6m99
         /io8ELlCHYY4qkcoH8bFRcwRwBolSb5yWRu78PV6ohCllQGzU8NjHESWv8ktnQtznl
         7ZiJa0cXpekoP4LDZO0MMvT0LRCeYidnsMGPfhf5wDEbXXrxDhQvTStAylxtiw80m6
         Mq1Y6ClxQepQQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 46BA7404BE; Tue, 25 Oct 2022 10:10:45 -0300 (-03)
Date:   Tue, 25 Oct 2022 10:10:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/8] perf test: Use a test program in perf record tests
Message-ID: <Y1fgVUaOhEdYro2P@kernel.org>
References: <20221020172643.3458767-1-namhyung@kernel.org>
 <20221020172643.3458767-4-namhyung@kernel.org>
 <CAP-5=fWKCdyFzR8ZZSK_2v6vT_RKngxxnXGieUVb8PBATJ64eQ@mail.gmail.com>
 <Y1Z3/t4RtnB8r03t@kernel.org>
 <960317d2-1bf8-cc2a-8772-8d0f5a136b6b@intel.com>
 <Y1a2lmO/dmjEiZb0@kernel.org>
 <CAM9d7cidzNM1XJbcouF47HY0UHH_EoYjx=3FYMJOm3q4f+Cu+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cidzNM1XJbcouF47HY0UHH_EoYjx=3FYMJOm3q4f+Cu+w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 24, 2022 at 09:12:21PM -0700, Namhyung Kim escreveu:
> On Mon, Oct 24, 2022 at 9:00 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > Em Mon, Oct 24, 2022 at 05:00:14PM +0300, Adrian Hunter escreveu:
> > > On 24/10/22 14:33, Arnaldo Carvalho de Melo wrote:
> > > > Em Thu, Oct 20, 2022 at 04:52:14PM -0700, Ian Rogers escreveu:
> > > >> I wonder if these utilities should just be built into perf to avoid
> > > >> the cc dependency. Perhaps we can have a hidden option built into
> > > >> perf test.

> > > > Agreed, not depending on a compiler makes 'perf test' usable in more
> > > > systems, particularly production ones where we may want to check if perf
> > > > is passing all tests applicable to that system.

> > > I haven't seen anyone package anything except the perf executable, so
> > > I presume the only people running these tests install the source, and
> > > so need a compiler anyway.

> > Humm?

> > [root@quaco ~]# head -3 /etc/os-release
> > NAME="Fedora Linux"
> > VERSION="36 (Workstation Edition)"
> > ID=fedora
> > [root@quaco ~]#G

> > [root@quaco ~]# rpm -qi perf
> > Name        : perf
> > Version     : 5.19.4
> > Release     : 200.fc36
> > Architecture: x86_64
> > Install Date: Mon 24 Oct 2022 12:57:34 PM -03
> > Group       : Unspecified
> > Size        : 12663136
> > License     : GPLv2
> > Signature   : RSA/SHA256, Thu 25 Aug 2022 07:16:04 PM -03, Key ID 999f7cbf38ab71f4
> > Source RPM  : kernel-tools-5.19.4-200.fc36.src.rpm
> > Build Date  : Thu 25 Aug 2022 06:30:42 PM -03
> > Build Host  : bkernel02.iad2.fedoraproject.org
> > Packager    : Fedora Project
> > Vendor      : Fedora Project
> > URL         : http://www.kernel.org/
> > Bug URL     : https://bugz.fedoraproject.org/kernel-tools
> > Summary     : Performance monitoring for the Linux kernel
> > Description :
> > This package contains the perf tool, which enables performance monitoring
> > of the Linux kernel.
> > [root@quaco ~]#
> >
> > [root@quaco ~]# rpm -ql perf
> > /etc/bash_completion.d/perf
> > /usr/bin/perf
> > /usr/lib/.build-id
> > /usr/lib/.build-id/0c
> > /usr/lib/.build-id/0c/54d587cab1b533b9ab777717ddd256ff84f241
> > /usr/lib/.build-id/15
> > /usr/lib/.build-id/15/6552556be0d4ca8cffb8e002d8a67add55aed5
> > /usr/lib/.build-id/15/c4dfaa3861f530ef60def5506385d4b0b8924f
> > /usr/lib/.build-id/1f
> > /usr/lib/.build-id/1f/799c084e326516a24a647cfd5f484cd054e0a2
> > /usr/lib/.build-id/23
> > /usr/lib/.build-id/23/311fe148dd3f3d487ca5ace54ff2faa72ea8da
> > /usr/lib/.build-id/37
> > /usr/lib/.build-id/37/c9ee70f321fae7fc1fc00fca91514c63f9f052
> > /usr/lib/.build-id/54
> > /usr/lib/.build-id/54/43b6bc332ad188b907fdde69ac02c9a69d158f
> > /usr/lib/.build-id/7e
> > /usr/lib/.build-id/7e/55e7a8e4df03137ec23b4135e205bc8eb77e05
> > /usr/lib/.build-id/84
> > /usr/lib/.build-id/84/3c3863a123d129c98fa7cb99a58d620c9e5edc
> > /usr/lib/.build-id/86
> > /usr/lib/.build-id/86/d063d2f9833a447d96504e5f9e472048d12c49
> > /usr/lib/.build-id/98
> > /usr/lib/.build-id/98/a28589fde6ce95d9f3d305f7c9853333a9415b
> > /usr/lib/.build-id/9e
> > /usr/lib/.build-id/9e/567f55ca9c2b4867eb95d4182da07d4843976d
> > /usr/lib/.build-id/b6
> > /usr/lib/.build-id/b6/f8c9a6d6e1990f8577a9fbac875f812a316a20
> > /usr/lib/.build-id/c0
> > /usr/lib/.build-id/c0/8b255f02ce8f3e90df2b6156d2d38b1221995d
> > /usr/lib/.build-id/d5/e964c3413f52492e6355852d25b2ab23b03e38
> > /usr/lib/.build-id/e8
> > /usr/lib/.build-id/e8/2de614bf77f501a4511cb70151b98392669c77
> 
> Interesting, it contains some build-ids for system libraries?

[acme@quaco ~]$ ls -la /usr/lib/.build-id/e8/2de614bf77f501a4511cb70151b98392669c77
lrwxrwxrwx. 1 root root 67 Aug 25 18:33 /usr/lib/.build-id/e8/2de614bf77f501a4511cb70151b98392669c77 -> ../../../../usr/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so
[acme@quaco ~]$

Yeah, strange:

[acme@quaco ~]$ rpm -ql perf | grep build-id/../
/usr/lib/.build-id/0c/54d587cab1b533b9ab777717ddd256ff84f241
/usr/lib/.build-id/15/6552556be0d4ca8cffb8e002d8a67add55aed5
/usr/lib/.build-id/15/c4dfaa3861f530ef60def5506385d4b0b8924f
/usr/lib/.build-id/1f/799c084e326516a24a647cfd5f484cd054e0a2
/usr/lib/.build-id/23/311fe148dd3f3d487ca5ace54ff2faa72ea8da
/usr/lib/.build-id/37/c9ee70f321fae7fc1fc00fca91514c63f9f052
/usr/lib/.build-id/54/43b6bc332ad188b907fdde69ac02c9a69d158f
/usr/lib/.build-id/7e/55e7a8e4df03137ec23b4135e205bc8eb77e05
/usr/lib/.build-id/84/3c3863a123d129c98fa7cb99a58d620c9e5edc
/usr/lib/.build-id/86/d063d2f9833a447d96504e5f9e472048d12c49
/usr/lib/.build-id/98/a28589fde6ce95d9f3d305f7c9853333a9415b
/usr/lib/.build-id/9e/567f55ca9c2b4867eb95d4182da07d4843976d
/usr/lib/.build-id/b6/f8c9a6d6e1990f8577a9fbac875f812a316a20
/usr/lib/.build-id/c0/8b255f02ce8f3e90df2b6156d2d38b1221995d
/usr/lib/.build-id/d5/e964c3413f52492e6355852d25b2ab23b03e38
/usr/lib/.build-id/e8/2de614bf77f501a4511cb70151b98392669c77
[acme@quaco ~]$
[acme@quaco ~]$ rpm -ql perf | grep build-id/../ | xargs realpath
/usr/lib64/traceevent/plugins/plugin_sched_switch.so
/usr/lib64/traceevent/plugins/plugin_kmem.so
/usr/lib64/traceevent/plugins/plugin_tlb.so
/usr/lib64/traceevent/plugins/plugin_jbd2.so
/usr/lib64/traceevent/plugins/plugin_hrtimer.so
/usr/lib64/traceevent/plugins/plugin_mac80211.so
/usr/lib64/libperf-jvmti.so
/usr/lib64/traceevent/plugins/plugin_cfg80211.so
/usr/lib64/traceevent/plugins/plugin_xen.so
/usr/lib64/traceevent/plugins/plugin_kvm.so
/usr/libexec/perf-core/dlfilters/dlfilter-show-cycles.so
/usr/lib64/traceevent/plugins/plugin_scsi.so
/usr/lib64/traceevent/plugins/plugin_futex.so
/usr/bin/perf
/usr/lib64/traceevent/plugins/plugin_function.so
/usr/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so
[acme@quaco ~]$ rpm -ql perf | grep build-id/../ | xargs realpath | xargs rpm -qf
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
perf-5.19.4-200.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
perf-5.19.4-200.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
perf-5.19.4-200.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
perf-5.19.4-200.fc36.x86_64
[acme@quaco ~]$

Humm, but then the build-ids are different...

[acme@quaco ~]$ rpm -ql libtraceevent | grep build-id/../
/usr/lib/.build-id/00/59bd37dc1c345eb2f98cf2bc1163bc1fd4b63e
/usr/lib/.build-id/00/b22aa8cc2b81e4cb383d8b4dc14cbeb958fda6
/usr/lib/.build-id/11/6a8d17c89795d2269d3d65906ea7c7c5bcb856
/usr/lib/.build-id/24/8bfb4534954eb71ab3e5f7887507cb8981f921
/usr/lib/.build-id/57/0768e8ea5155cf2759c4f5dca3736a73c3dfad
/usr/lib/.build-id/61/2744cd9cb2d1b0c569b0c86578d11be7227f27
/usr/lib/.build-id/9d/630834441f4e382ddcecef810b100737bb56e4
/usr/lib/.build-id/b0/57189b558351ace427ae0a650c248deca4badd
/usr/lib/.build-id/b1/a0003b83e307cf61d7c8a2751e5c78e6ccfc87
/usr/lib/.build-id/b4/b8a30ebf86cb849bcb0cabc4d452c1a44487cc
/usr/lib/.build-id/ce/5e0647f756ec2c30b2e6df9a5a98e552871cb6
/usr/lib/.build-id/e0/a6a6207f56674ffacd7b063fd2acd4cec3f661
/usr/lib/.build-id/f4/86fb5b3072945405d0590045715d18adc7aa18
[acme@quaco ~]$
[acme@quaco ~]$ rpm -ql libtraceevent | grep build-id/../ | xargs realpath
/usr/lib64/traceevent/plugins/plugin_function.so
/usr/lib64/traceevent/plugins/plugin_scsi.so
/usr/lib64/traceevent/plugins/plugin_futex.so
/usr/lib64/traceevent/plugins/plugin_cfg80211.so
/usr/lib64/traceevent/plugins/plugin_hrtimer.so
/usr/lib64/traceevent/plugins/plugin_mac80211.so
/usr/lib64/traceevent/plugins/plugin_sched_switch.so
/usr/lib64/traceevent/plugins/plugin_jbd2.so
/usr/lib64/traceevent/plugins/plugin_tlb.so
/usr/lib64/traceevent/plugins/plugin_xen.so
/usr/lib64/traceevent/plugins/plugin_kvm.so
/usr/lib64/traceevent/plugins/plugin_kmem.so
/usr/lib64/libtraceevent.so.1.5.3
[acme@quaco ~]$ rpm -ql libtraceevent | grep build-id/../ | xargs realpath  | xargs rpm -qf
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
libtraceevent-1.5.3-2.fc36.x86_64
[acme@quaco ~]$

I.e. libtraceevent has the plugins and the build-id symlinks, perf has
just the symlinks:

[acme@quaco ~]$ rpm -ql libtraceevent | grep plugin_.*so
/usr/lib64/traceevent/plugins/plugin_cfg80211.so
/usr/lib64/traceevent/plugins/plugin_function.so
/usr/lib64/traceevent/plugins/plugin_futex.so
/usr/lib64/traceevent/plugins/plugin_hrtimer.so
/usr/lib64/traceevent/plugins/plugin_jbd2.so
/usr/lib64/traceevent/plugins/plugin_kmem.so
/usr/lib64/traceevent/plugins/plugin_kvm.so
/usr/lib64/traceevent/plugins/plugin_mac80211.so
/usr/lib64/traceevent/plugins/plugin_sched_switch.so
/usr/lib64/traceevent/plugins/plugin_scsi.so
/usr/lib64/traceevent/plugins/plugin_tlb.so
/usr/lib64/traceevent/plugins/plugin_xen.so
[acme@quaco ~]$ rpm -ql perf | grep plugin_.*so
[acme@quaco ~]$ 

And perf is being built with the libtraceevent that is in fedora:

[acme@quaco ~]$ ldd `which perf` | grep traceevent
	libtraceevent.so.1 => /lib64/libtraceevent.so.1 (0x00007f43496dc000)
[acme@quaco ~]$ rpm -qf /lib64/libtraceevent.so.1
libtraceevent-1.5.3-2.fc36.x86_64
[acme@quaco ~]$ rpm -qf /usr/bin/perf
perf-5.19.4-200.fc36.x86_64
[acme@quaco ~]$
[acme@quaco ~]$ file /usr/bin/perf
/usr/bin/perf: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=c08b255f02ce8f3e90df2b6156d2d38b1221995d, for GNU/Linux 3.2.0, stripped
[acme@quaco ~]$

So it seems its just a matter of removing those /usr/lib/.build-id/
symlinks to the libtraceevent plugins from the fedora perf rpm.

Justin?

- Arnaldo
