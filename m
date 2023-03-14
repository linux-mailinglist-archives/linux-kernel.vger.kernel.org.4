Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B936B93C9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCNMah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjCNMaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:30:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6CF567A1;
        Tue, 14 Mar 2023 05:29:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA8C761760;
        Tue, 14 Mar 2023 12:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3F6C433EF;
        Tue, 14 Mar 2023 12:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678796869;
        bh=vbeWbuMMkwlJv+y3unLq1mLlzily5khhcnymITruDKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ME00DZ1OkXbWbr9pgoweiYdkBLvW6bm5H7eLk9IGsCSLZPIkGzTpF2UMM1OcJNpdS
         nWMA78tVH7KJloXM48qK1AkTkCHBfvhhh9pS1JRcvjOfEVa7v7Y+jOYFeWN4LwJkJe
         94ZtaAD6SYfQ+INtgwIlUEmUDR5USEeU9jubc6f1SoxDZi0FAb0xn/yLYMvW5od1DE
         0RsTGXiPbblGGxQvf7K5hpj+kexk5NFWhaXBURnBS2mmUYgHkbtZr8h1KG8myOcVom
         ePEvMZiga7q+ss5Bj3oih0HZ2OWBrbkkYixq+u7zsEIc1VTZK6ibNFOHKTKsOZBV9w
         YP92w2aCly9qw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7F3504049F; Tue, 14 Mar 2023 09:27:46 -0300 (-03)
Date:   Tue, 14 Mar 2023 09:27:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 00/13] Perf tool build improvements
Message-ID: <ZBBoQggQI8Vcy7QL@kernel.org>
References: <20230311065753.3012826-1-irogers@google.com>
 <ZBBkWDFdBDC9Spt9@kernel.org>
 <ZBBkkye0TGP9EVYl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBBkkye0TGP9EVYl@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 14, 2023 at 09:12:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Mar 14, 2023 at 09:11:04AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Mar 10, 2023 at 10:57:40PM -0800, Ian Rogers escreveu:
> > > Make the default build options a more preferred set, such as making
> > > BPF skeletons default and failing the build if jevents or libtracevent
> > > dependencies fail. The binutil dependencies are opt-in given license
> > > restrictions. abi::__cxa_demangle demangling support is added so that
> > > libiberty, from binutils, isn't necessary for C++ demangling.
> > > 
> > > Some build/test dependencies are fixed and the code cleaned up.
> > 
> > I'll continue fixing more stuff, like adding NO_LIBTRACEEVENT=1 to
> > things like amazonlinux devel, that still doesn't package libtraceevent,
> > but so far...
> > 
> > [perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.86.10/perf/perf-6.3.0-rc1.tar.xz
> > [perfbuilder@five ~]$ time dm
> >    1     5.58 almalinux:8                   : FAIL gcc version 8.5.0 20210514 (Red Hat 8.5.0-4) (GCC)
> >    2     5.38 almalinux:9                   : FAIL gcc version 11.2.1 20220127 (Red Hat 11.2.1-9) (GCC)

This one seems to have an old libtraceevent, so this message:

Makefile.config:635: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
Makefile.config:1046: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1137: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev
Makefile.config:1155: *** ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel or build with NO_LIBTRACEEVENT=1.  Stop.

Has to change a bit, like for libbpf, I'll check

> >    3     4.57 alpine:3.15                   : FAIL gcc version 10.3.1 20211027 (Alpine 10.3.1_git20211027)
> >    4     4.27 alpine:3.16                   : FAIL gcc version 11.2.1 20220219 (Alpine 11.2.1_git20220219)
> >    5     4.27 alpine:3.17                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4)
> >    6     4.67 alpine:edge                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r9)
> >    7     4.47 alt:p9                        : FAIL gcc version 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) (GCC)
> >    8     4.58 alt:p10                       : FAIL gcc version 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) (GCC)
> >    9     4.57 alt:sisyphus                  : FAIL gcc version 12.1.1 20220518 (ALT Sisyphus 12.1.1-alt2) (GCC)
> >   10     3.97 amazonlinux:2                 : FAIL gcc version 7.3.1 20180712 (Red Hat 7.3.1-15) (GCC)
> >   11     5.77 amazonlinux:devel             : FAIL gcc version 11.3.1 20220421 (Red Hat 11.3.1-2) (GCC)
> >   12   160.30 archlinux:base                : Ok   gcc (GCC) 12.2.0 , clang version 14.0.6
> >   13     4.68 centos:8                      : FAIL gcc version 8.4.1 20200928 (Red Hat 8.4.1-1) (GCC)
> >   14     5.07 centos:stream                 : FAIL gcc version 8.5.0 20210514 (Red Hat 8.5.0-18) (GCC)
> >   15     5.27 clearlinux:latest             : FAIL gcc version 12.2.1 20230202 releases/gcc-12.2.0-400-gd31bd71386 (Clear Linux OS for Intel Architecture)
> >   16     3.37 debian:10                     : FAIL gcc version 8.3.0 (Debian 8.3.0-6)
> >   17     3.57 debian:11                     : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> >   18     4.08 debian:experimental           : FAIL gcc version 12.2.0 (Debian 12.2.0-10)
> >   19     3.78 debian:experimental-x-arm64   : FAIL gcc version 12.2.0 (Debian 12.2.0-14)
> >   20     2.77 debian:experimental-x-mips    : FAIL gcc version 12.2.0 (Debian 12.2.0-14)
> >   21     3.47 debian:experimental-x-mips64  : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> >   22     3.47 debian:experimental-x-mipsel  : FAIL gcc version 12.2.0 (Debian 12.2.0-14)
> >   23     4.37 fedora:26                     : FAIL gcc version 7.3.1 20180130 (Red Hat 7.3.1-2) (GCC)
> >   24     4.27 fedora:27                     : FAIL gcc version 7.3.1 20180712 (Red Hat 7.3.1-6) (GCC)
> >   25     4.27 fedora:28                     : FAIL gcc version 8.3.1 20190223 (Red Hat 8.3.1-2) (GCC)
> >   26     4.87 fedora:29                     : FAIL gcc version 8.3.1 20190223 (Red Hat 8.3.1-2) (GCC)
> >   27     4.97 fedora:30                     : FAIL gcc version 9.3.1 20200408 (Red Hat 9.3.1-2) (GCC)
> >   28     5.38 fedora:31                     : FAIL gcc version 9.3.1 20200408 (Red Hat 9.3.1-2) (GCC)
> >   29     5.48 fedora:32                     : FAIL gcc version 10.3.1 20210422 (Red Hat 10.3.1-1) (GCC)
> > 
> > 
> > Yeah, I'll take the opportunity and prune the older ones.
> 
> One more!
> 
>   30   181.19 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
> 

-- 

- Arnaldo
