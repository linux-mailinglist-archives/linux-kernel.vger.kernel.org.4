Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B9668727C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 01:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjBBAq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 19:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBBAq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 19:46:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B5C3C295;
        Wed,  1 Feb 2023 16:46:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 13FE5CE269F;
        Thu,  2 Feb 2023 00:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1704DC433D2;
        Thu,  2 Feb 2023 00:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675298783;
        bh=xk6f4NHas/vT/Qe7b8z9Hi0bMapUpjdB9ydGAUQ5Ocw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IivLYCFt96qUfOs4fVGoC5rgdG4i6lQiSf5clLOhito5sc2MJErMOUXJQj4VxNt7C
         Kp4M7MS9mfqwxQpsVVV/4YHGJDoWELKE3/32AJjHiwlXHKDc5dRdaYpblSlrtmkRew
         MqYwJXC529Dso0kabD6QmKlWbc2wodyuYh8lsk96qZae1nPyGecyP7nmU3W0/ytQFP
         PBnuAjerep2WYl5Nwr9fJuhDCQadNvLtCgR5iklxQQ7Y5YBYVl4aRXJfjaGgKX+4Mh
         wFWk+9+KvSbB3OokfG80ZcEYIZFoRxbDMBKK/smxo+hPv/NbPSzB49PEkLoNOQL30n
         /t8YhC04snewg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EFE54405BE; Wed,  1 Feb 2023 21:46:20 -0300 (-03)
Date:   Wed, 1 Feb 2023 21:46:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V2 0/9] perf symbols: Improve
 dso__synthesize_plt_symbols() for x86
Message-ID: <Y9sH3DD4QVKGkoru@kernel.org>
References: <20230131131625.6964-1-adrian.hunter@intel.com>
 <CAM9d7cj=8YQEnaqwxNpvPjPpcF2d0cyvb=jq6fM20U0de5tO+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj=8YQEnaqwxNpvPjPpcF2d0cyvb=jq6fM20U0de5tO+w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 31, 2023 at 10:59:58PM -0800, Namhyung Kim escreveu:
> Hi Adrian,
> 
> On Tue, Jan 31, 2023 at 5:16 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > Hi
> >
> > This is version 2 of the second of 2 patchsets to improve
> > dso__synthesize_plt_symbols().
> > This patchset focuses on getting rid of unknown symbols that show up in
> > Intel PT traces.
> >
> > x86 has 2 more plt's, namely .plt.sec and .plt.got, so support is added for
> > synthesizing symbols for them.  Special handing is needed for IFUNC symbols,
> > and it is also possible to have a .plt for static executables, so support is
> > added for that.
> >
> >
> > Changes in V2:
> >
> >     perf symbols: Add support for x86 .plt.sec
> >         Amend commit message and example about -z plt
> >
> >     perf symbols: Get symbols for .plt.got for x86-64
> >         Fix get_plt_got_name() not to segfault with EM_386
> >
> >
> > Adrian Hunter (9):
> >       perf symbols: Correct plt entry sizes for x86
> >       perf symbols: Add support for x86 .plt.sec
> >       perf symbols: Sort plt relocations for x86
> >       perf symbols: Record whether a symbol is an alias for an IFUNC symbol
> >       perf symbols: Add support for IFUNC symbols for x86_64
> >       perf symbols: Allow for .plt without header
> >       perf symbols: Allow for static executables with .plt
> >       perf symbols: Start adding support for .plt.got for x86
> >       perf symbols: Get symbols for .plt.got for x86-64
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> >
> >  tools/perf/util/symbol-elf.c | 365 ++++++++++++++++++++++++++++++++++++++++---
> >  tools/perf/util/symbol.c     |   4 +
> >  tools/perf/util/symbol.h     |   2 +
> >  tools/perf/util/symsrc.h     |   1 +
> >  4 files changed, 350 insertions(+), 22 deletions(-)
> >
> >
> > Regards
> > Adrian

-- 

- Arnaldo
