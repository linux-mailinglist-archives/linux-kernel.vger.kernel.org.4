Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64D65213F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiLTNIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiLTNIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:08:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84910EE0E;
        Tue, 20 Dec 2022 05:08:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D43BC61414;
        Tue, 20 Dec 2022 13:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DF8C433D2;
        Tue, 20 Dec 2022 13:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671541685;
        bh=mE5BvE/i4BNlPYZYGRNiCNfd6he/sFm8J9pnZ0DgWHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lcs2lUJU0r2xFJK4cI2leOC6qttxLPlpSCcDQmjItc9+atxoowLCobv7FTGvh6v03
         xowvNMefcl21T/t2fqVVSRB9zVphQJnk9I6ERFmaHGyfabmTdnCsRvUYW64mIsCf7Z
         wnoE4wl8rbkEmw6Wg+0XLV0qa8z5Xlaf4qSYeT748AUcZUaXOOKn6gwrplrV++UUdj
         Ve+Kq6h6elkPRt+7/nL2vKVefoIeACQHiOge6AIug8ZeIw4LsSAq6dtDqx9k3aUgZs
         EKkIXuGH1qiZ35qh58XKYOAMKgc7kvFLpzi9BBOvc5ZTNQ/dY3eoYzmWo3fTEjPQP4
         rto7aUYzMbkiQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3BE7C40367; Tue, 20 Dec 2022 10:08:02 -0300 (-03)
Date:   Tue, 20 Dec 2022 10:08:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        James Clark <james.clark@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kautuk Consul <kconsul@ventanamicro.com>,
        Leo Yan <leo.yan@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikita Shubin <n.shubin@yadro.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf tools changes for v6.2: 1st batch
Message-ID: <Y6GzshPKxK2Oiqjg@kernel.org>
References: <20221216143609.186415-1-acme@kernel.org>
 <CAHk-=wj+FNSnspKwVWAatD+DHz3Uy4eHxQryrfoZz6=4D=1X1w@mail.gmail.com>
 <Y53XHw3rlsaaUgOs@kernel.org>
 <CAHk-=wjpO5LBx-mVD8+GBj3u7iNJHXn5y4OreKxsoRGi+4vMCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjpO5LBx-mVD8+GBj3u7iNJHXn5y4OreKxsoRGi+4vMCQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr;: if you do:

$ make -C tools clean
$ sudo dnf remove python2 python2-devel
$ sudo dnf install python-devel

It should build cleanly, below I looked at the various places these
feature detections are made and found places for improving messages,
etc.

Ian, that "jevent generation" gets confused when python2 _and_ python3
is installed, please take a look at that.

- Arnaldo

Em Sat, Dec 17, 2022 at 01:55:25PM -0600, Linus Torvalds escreveu:
> On Sat, Dec 17, 2022 at 8:50 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > The python3-setuptools package is needed to build the python binding, so
> > that one can use things like:
> 
> So this fixes the error, but there's some other reason for it.
> 
> I have
> 
>   Package python3-setuptools-59.6.0-3.fc36.noarch is already installed.
> 
> and with that patch the 'perf' build now works for me, but it says:
> 
>     Makefile.config:898: Missing python setuptools, the python binding
> won't be built, please install python3-setuptools or equivalent
> 
> and then (pre-existing)
> 
>     Makefile.config:921: Python interpreter too old (older than 3.6)
> disabling jevent generation
> 
> but I have
> 
>     python3-3.10.8-3.fc36.x86_64
> 
> Now, for some reason I *also* have python2 installed, but that one is
> called "python2".

> [ Me trying to figure things out ]
> 
> Ok, so if I uninstall my old python2 install, I now get
> 
>   Makefile.config:880: No python interpreter was found: disables
> Python support - please install python-devel/python-dev

>   Makefile.config:915: No python interpreter disabling jevent generation
> 
> ok, so I didn't have 'python3-devel' installed. Installing that fixes
> some things, but then I get
> 
>   Makefile.config:889: No 'Python.h' (for Python 2.x support) was
> found: disables Python support - please install
> python-devel/python-dev

Humm, I couldn't reproduce this one, as I have:

⬢[acme@toolbox perf]$ grep libpython /tmp/build/perf/FEATURE-DUMP
feature-libpython=1
⬢[acme@toolbox perf]$

And that message only happens when that feature-libpython != 1

That is set by this feature query snippet:

⬢[acme@toolbox perf]$ cat tools/build/feature/test-libpython.c
// SPDX-License-Identifier: GPL-2.0
#include <Python.h>

int main(void)
{
	Py_Initialize();

	return 0;
}
#undef _GNU_SOURCE
⬢[acme@toolbox perf]$

One can see the output of building it at (if you build it without O=,
please look at tools/build/feature/test-libpython.make.output instead):
):

⬢[acme@toolbox perf]$ cat /tmp/build/perf/feature/test-libpython.make.output
⬢[acme@toolbox perf]$

In my case, it is working, so empty make.output file and the test binary
works and links with python3 (tools/build/feature/test-libpython.bin
when building without O=):

⬢[acme@toolbox perf]$ file /tmp/build/perf/feature/test-libpython.bin
/tmp/build/perf/feature/test-libpython.bin: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=601e3a065cc8e045e7a46199234c0bbf80707981, for GNU/Linux 3.2.0, not stripped
⬢[acme@toolbox perf]$ ldd /tmp/build/perf/feature/test-libpython.bin
	linux-vdso.so.1 (0x00007ffc371fe000)
	libpython3.10.so.1.0 => /lib64/libpython3.10.so.1.0 (0x00007fddb0200000)
	libcrypt.so.2 => /lib64/libcrypt.so.2 (0x00007fddb05f9000)
	libm.so.6 => /lib64/libm.so.6 (0x00007fddb0122000)
	libc.so.6 => /lib64/libc.so.6 (0x00007fddafe00000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fddb063f000)
⬢[acme@toolbox perf]$

The needed file is available and is part of the python3-devel file:

⬢[acme@toolbox perf]$ ls -la /usr/include/python3.10/Python.h
-rw-r--r--. 1 root root 3224 Oct 11 08:21 /usr/include/python3.10/Python.h
⬢[acme@toolbox perf]$ rpm -qf /usr/include/python3.10/Python.h
python3-devel-3.10.8-3.fc36.x86_64
⬢[acme@toolbox perf]$

That message needs updating, its from a long time ago:

9734163b6ee1425c6 tools/perf/config/Makefile (Ingo Molnar 2013-09-30 15:18:37 +0200  888)       ifneq ($(feature-libpython), 1)
6c5aa23704e2786eb tools/perf/config/Makefile (Ingo Molnar 2015-02-28 09:33:45 +0100  889)         $(call disable-python,No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-devel/python-dev)
6e533cf12de06368a tools/perf/config/Makefile (Jiri Olsa   2013-03-18 00:35:32 +0100  890)       else

> so apparently perf really wants *both* python2 and python3 installed.
> Isn't that a bit excessive?

I'll update that message, its one or the other, and we will work to make
it support only python3 as python2 is deprecated.
 
> Anyway, it's clearly something about the install on this laptop, but
> the error messages and the "this package is missing" things are
> clearly not entirely right.

Right, perhaps a 'make -C tools clean' may clean some previous feature
detection that stuck somehow? I'll do continue tinkering here to see if
I get this in a better shape.
 
> Whatever. It does build cleanly now for me, and I'll ignore that "No
> 'Python.h' (for Python 2.x support)" thing.

The only time I got this message was now that I uninstalled
python3-devel:

Makefile.config:889: No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-devel/python-dev

The next one I got because I have python2 installed:

⬢[acme@toolbox perf]$ rpm -qa | grep python2
python2.7-2.7.18-22.fc36.x86_64

Makefile.config:921: Python interpreter too old (older than 3.6) disabling jevent generation

Removing python2 I get:

Makefile.config:880: No python interpreter was found: disables Python support - please install python-devel/python-dev
Makefile.config:915: No python interpreter disabling jevent generation

So you get this message:

>   Makefile.config:889: No 'Python.h' (for Python 2.x support) was
> found: disables Python support - please install
> python-devel/python-dev

When you have python2 and python3 but no python3-devel nor
python2-devel:

⬢[acme@toolbox perf]$ rpm -q python3
python3-3.10.8-3.fc36.x86_64
⬢[acme@toolbox perf]$ rpm -qa | grep python2
python2.7-2.7.18-22.fc36.x86_64
⬢[acme@toolbox perf]$ rpm -q python2-devel
package python2-devel is not installed
⬢[acme@toolbox perf]$ rpm -q python3-devel
package python3-devel is not installed
⬢[acme@toolbox perf]$ m
make: Entering directory '/var/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
<SNIP>
Makefile.config:889: No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-devel/python-dev
Makefile.config:921: Python interpreter too old (older than 3.6) disabling jevent generation

Auto-detecting system features:
<SNIP>
...                               libpython: [ OFF ]
⬢[acme@toolbox perf]$

If I then uninstall python2:

⬢[acme@toolbox perf]$ sudo dnf remove python2

It changes to:

Makefile.config:880: No python interpreter was found: disables Python support - please install python-devel/python-dev
Makefile.config:915: No python interpreter disabling jevent generation

Which is more sensible, then if I install python-devel:

⬢[acme@toolbox perf]$ sudo dnf install python-devel

$ sudo dnf install python-devel

I see no warnings, clean build and libpython detected:

...                               libpython: [ on  ]


⬢[acme@toolbox perf]$ ldd /tmp/build/perf/perf | grep python
	libpython3.10.so.1.0 => /lib64/libpython3.10.so.1.0 (0x00007f1eea200000)
⬢[acme@toolbox perf]$

- Arnaldo
