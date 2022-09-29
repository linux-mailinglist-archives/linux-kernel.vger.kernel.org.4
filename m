Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCE35EFD23
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiI2SiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiI2SiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:38:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5009612112A;
        Thu, 29 Sep 2022 11:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD42E6215B;
        Thu, 29 Sep 2022 18:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150AEC433D6;
        Thu, 29 Sep 2022 18:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664476681;
        bh=+cp10QalntLANvJDrlD/o8CXEGGdD/OGJ35ESRtZxMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qe7nWhINkdTjc5ImGliaFl4sr8POetibPZpNU9Gu1n0DB5OsRIpYeKVd8MdjW9pwg
         Orl8iTpQj0E3+Kxkw3NTRkPZlTT4vNk0jObi7N75JzeKbs6/ZDnqXw/N0qup4zL1Wm
         6r/MlyfDUT3JMIip9Ew9VCsJBCe7fBLpE7aq+HOkLAK8Ifag3ab0u3bbfNst9ccXy3
         iHKzQ5vLYlFzqdkrD4wC9W0+ftEQg3PsocIjfphcVq+f/yRz7m+T/1U73cpxvAOAW0
         ihMfSQLNgDhDU70KIR4OBqT2XK+aHzdx8y0rhYd3UG3pLdqiB/zGDtNOlT72DOIjj0
         SmDN5yIFYWhQA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A977B405F0; Thu, 29 Sep 2022 15:37:58 -0300 (-03)
Date:   Thu, 29 Sep 2022 15:37:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf tools: Fix bison object compilation with clang
 15
Message-ID: <YzXmBrvLY23z4zB4@kernel.org>
References: <20220929140514.226807-1-jolsa@kernel.org>
 <YzXdjNNh+jbYDnYz@kernel.org>
 <CAM9d7cia_Hsqsj=J4rSM68TQADMAt=at5SWRMYTGv4FJxNGpTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cia_Hsqsj=J4rSM68TQADMAt=at5SWRMYTGv4FJxNGpTg@mail.gmail.com>
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

Em Thu, Sep 29, 2022 at 11:22:41AM -0700, Namhyung Kim escreveu:
> On Thu, Sep 29, 2022 at 11:01 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Sep 29, 2022 at 04:05:13PM +0200, Jiri Olsa escreveu:
> > > Arnaldo reported compilation fail with clang 15:
> > >
> > >     CC      util/parse-events-bison.o
> > >   util/parse-events-bison.c:1401:9: error: variable 'parse_events_nerrs'
> > >   set but not used [-Werror,-Wunused-but-set-variable]
> > >       int yynerrs = 0;
> > >         ^
> > >   util/parse-events-bison.c:72:25: note: expanded from macro 'yynerrs'
> > >   #define yynerrs         parse_events_nerrs
> > >                         ^
> > >   1 error generated.
> > >
> > > Disabling -Wunused-but-set-variable check for bison object compilation.
> >
> > So we have to disable something else:
> >
> >   37    44.92 fedora:32                     : FAIL clang version 10.0.1 (Fedora 10.0.1-3.fc32)
> >     error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
> >     make[3]: *** [/git/perf-6.0.0-rc7/tools/build/Makefile.build:139: util] Error 2
> >   38    61.77 fedora:33                     : FAIL clang version 11.0.0 (Fedora 11.0.0-3.fc33)
> >     error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
> >     make[3]: *** [/git/perf-6.0.0-rc7/tools/build/Makefile.build:139: util] Error 2
> >   39    66.59 fedora:34                     : FAIL clang version 12.0.1 (Fedora 12.0.1-1.fc34)
> >     error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
> >     make[3]: *** [/git/perf-6.0.0-rc7/tools/build/Makefile.build:139: util] Error 2
> >
> >
> > I'll try yours + -Wno-unknown-warning-option
> 
> Is `-Wno-unknown-warning-option` known to older versions? ;-)

Excellent question! ;-)

And one we should learn something from, so that we
can prep tools/perf/ (and other projects we contribute to) for the
future:

So far, so good:

[perfbuilder@five ~]$ echo `grep FAIL dm.log/summary | cut -c15- | cut -d: -f1,2`
alpine:3.12 alpine:3.13 alpine:3.14 alpine:3.15 alt:p10 amazonlinux:devel debian:11 fedora:32 fedora:33 fedora:34 fedora:37 fedora:38 fedora:rawhide ubuntu:21.04
[perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.86.14/perf/perf-6.0.0-rc7.tar.xz
[perfbuilder@five ~]$ time dm debian:experimental alpine:3.12 alpine:3.13 alpine:3.14 alpine:3.15 alt:p10 amazonlinux:devel debian:11 fedora:32 fedora:33 fedora:34 fedora:37 fedora:38 fedora:rawhide ubuntu:21.04
   1   140.66 debian:experimental           : Ok   gcc (Debian 12.2.0-3) 12.2.0 , Debian clang version 14.0.6-2
   2   132.82 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
   3   140.40 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1
   4   143.75 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
   5   147.77 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
   6    98.79 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
   7: amazonlinux:devel

- Arnaldo
