Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130E46F2222
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347280AbjD2BhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347248AbjD2BhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:37:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A351720;
        Fri, 28 Apr 2023 18:37:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFECA63517;
        Sat, 29 Apr 2023 01:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BBFC433D2;
        Sat, 29 Apr 2023 01:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682732232;
        bh=safyuNki+N1k88yCxEEMHpvARQypKYxX3S+zh9xS0Z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wtb+eZ4zClQ5SF3L7/BbnC+QlTqO+lKH/H9Oa2SofOZOz5GIcllupthfvpl8T4mIs
         1OGtpkKKaDAzxGo1plRnVQhqNbmVlaztQiNRNliIZ/8QD6rXlFd64gqNFwjnXxQcaq
         +VN5wKcx5k83dNVc5DV0HGasdT6Dz7dUBklFu4WNXi8HXaaF0du6oRpJZPBg2p5T7i
         Sh8fO1cdf0iDRsVHJFf4MFyEovfmZtuK/E87mRpbcMzy70YcSkmT4wgjs4laqglduE
         6vlp40EG19uQlG5mbltBSX3UjD9mWPNP73YBMC+4xFw4xAAMIOF0K/gG6EoJAw65IZ
         tu7n2ZIy5A33g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1277B403B5; Fri, 28 Apr 2023 22:37:09 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:37:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: Re: [PATCH v2] perf: Avoid implicit function declarations in
 lexer/parse interface
Message-ID: <ZEx0xAamEl66qk2w@kernel.org>
References: <87sfcn7uot.fsf@oldenburg.str.redhat.com>
 <CAP-5=fXZv+KCdCN05wVUcAwDCZAgXjWunoaviGBQEiUPqNwOmg@mail.gmail.com>
 <ZEx0IQAtBatrRDCR@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZEx0IQAtBatrRDCR@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 28, 2023 at 10:34:25PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Apr 25, 2023 at 10:40:14AM -0700, Ian Rogers escreveu:
> > On Tue, Apr 25, 2023 at 10:12 AM Florian Weimer <fweimer@redhat.com> wrote:
> > >
> > > In future compilers, -Wno-implicit-function-declaration may not bring
> > > back support for implicit function declarations, a feature that was
> > > removed from the C language in C99.  Instead of relying on implicit
> > > declarations, include the flex-generated header from the
> > > bison-generated C code.
> > >
> > > he expr-flex.h header needs to be included later than the others
> > 
> > nit: s/he/The/
> > 
> > > because at the early point, the definition of YYSTYPE is not yet
> > > available.
> > >
> > > Signed-off-by: Florian Weimer <fweimer@redhat.com>
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > 
> > Thanks for fighting the build wrt parallel dependencies!
> > Ian
> 
> 
> Thanks, applied. BTW b4 coulnd't find this message (nor the original):
> 
> ⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 87sfcn7uot.fsf@oldenburg.str.redhat.com
> Grabbing thread from lore.kernel.org/all/87sfcn7uot.fsf%40oldenburg.str.redhat.com/t.mbox.gz
> That message-id is not known.
> ⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers CAP-5=fXZv+KCdCN05wVUcAwDCZAgXjWunoaviGBQEiUPqNwOmg@mail.gmail.com
> Grabbing thread from lore.kernel.org/all/CAP-5%3DfXZv%2BKCdCN05wVUcAwDCZAgXjWunoaviGBQEiUPqNwOmg%40mail.gmail.com/t.mbox.gz
> Analyzing 1 messages in the thread
> No patches found.
> ⬢[acme@toolbox perf-tools-next]$
> 
> I applied it in the old fashion.

Not so fast, removed it for now:

  CC      /tmp/build/perf-tools-next/util/parse-events-bison.o
In file included from util/pmu.y:14:
/tmp/build/perf-tools-next/util/pmu-flex.h:496:1: error: unknown type name ‘YYSTYPE’
  496 |
      | ^
/tmp/build/perf-tools-next/util/pmu-flex.h:498:19: error: unknown type name ‘YYSTYPE’
  498 |
      |                   ^
/tmp/build/perf-tools-next/util/pmu-flex.h:546:17: error: unknown type name ‘YYSTYPE’
  546 | extern int yylex \
      |                 ^~
util/pmu-bison.c: In function ‘perf_pmu_parse’:
/tmp/build/perf-tools-next/util/pmu-bison.c:69:25: error: implicit declaration of function ‘perf_pmu_lex’; did you mean ‘perf_pmu_free’? [-Werror=implicit-function-declaration]
   69 | #define yylex           perf_pmu_lex
      |                         ^~~~~~~~~~~~
util/pmu-bison.c:1007:16: note: in expansion of macro ‘yylex’
At top level:
cc1: note: unrecognized command-line option ‘-Wno-unknown-warning-option’ may have been intended to silence earlier diagnostics
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/pmu-bison.o] Error 1
make[4]: *** Waiting for unfinished jobs....
util/bpf-filter-bison.c: In function ‘perf_bpf_filter_parse’:
/tmp/build/perf-tools-next/util/bpf-filter-bison.c:69:25: error: implicit declaration of function ‘perf_bpf_filter_lex’; did you mean ‘perf_bpf_filter_parse’? [-Werror=implicit-function-declaration]
   69 | #define yylex           perf_bpf_filter_lex
      |                         ^~~~~~~~~~~~~~~~~~~
util/bpf-filter-bison.c:1283:16: note: in expansion of macro ‘yylex’
At top level:
cc1: note: unrecognized command-line option ‘-Wno-unknown-warning-option’ may have been intended to silence earlier diagnostics
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/bpf-filter-bison.o] Error 1
make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:140: util] Error 2
make[2]: *** [Makefile.perf:676: /tmp/build/perf-tools-next/perf-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
  LD      /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'

 Performance counter stats for 'make -k CORESIGHT=1 O=/tmp/build/perf-tools-next -C tools/perf install-bin':

       40330976311      cycles:u
       73953066660      instructions:u                   #    1.83  insn per cycle

       9.268030835 seconds time elapsed

       9.546339000 seconds user
       7.391844000 seconds sys


⬢[acme@toolbox perf-tools-next]$ cat /etc/redhat-release
Fedora release 37 (Thirty Seven)
⬢[acme@toolbox perf-tools-next]$ rpm -q bison flex
bison-3.8.2-3.fc37.x86_64
flex-2.6.4-11.fc37.x86_64
⬢[acme@toolbox perf-tools-next]$ gcc --version
gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4)
Copyright (C) 2022 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

⬢[acme@toolbox perf-tools-next]$



I tried rm -rf the O= build dir, etc.

- Arnaldo
