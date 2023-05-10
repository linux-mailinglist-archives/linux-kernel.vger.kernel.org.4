Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C206FDE2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbjEJM76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjEJM7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:59:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1A849E9
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2942E633BB
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 12:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29082C433D2;
        Wed, 10 May 2023 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683723591;
        bh=0nLs3JU/GUw6Os0PCHQlygKF+f8Q9AanNGb4mE/Ys50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nGh3n0ekOm4F5mbc3kefIqqvxgr7CqGVJQS5SejIVjvfeTpvR4VszIGGNiJ2DZq01
         9qzO9UQWfV2dESy4IcKasMXo7SRbt54qKx/mzwR5mwFsF2jky03Krdlhc/WH4yeVCk
         x44UMNRVxROdfu0Yff1LK1ifOc6M5tnl9WbziIzh8LExrQf9OMIrK9zm5EHmyKvwmL
         jukda4annxBJc6NxqCRF4ump44flT7s+U6mzzVa1UyVZbz3vUtJP9KoOQDEsz9ccXY
         VpMhTG4X8k5HaDOqtD0+hnL6mDtHrh0u28BM1WzrzCy5ICTK3p/rzOcdDpWhA0gNQB
         3UZOzD1pRTSFQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A78BF403B5; Wed, 10 May 2023 09:59:48 -0300 (-03)
Date:   Wed, 10 May 2023 09:59:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Use $KBUILD_BUILD_TIMESTAMP as man page date
Message-ID: <ZFuVRK4cKapgaRwD@kernel.org>
References: <20160517132809.GE7555@decadent.org.uk>
 <ZFqZAB2ZShmdKtvy@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFqZAB2ZShmdKtvy@eldamar.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 09, 2023 at 09:03:28PM +0200, Salvatore Bonaccorso escreveu:
> Hi Peter, Ingo, Arnaldo,
> 
> On Tue, May 17, 2016 at 02:28:09PM +0100, Ben Hutchings wrote:
> > This allows man pages to be built reproducibly.
> > 
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> > --- a/tools/perf/Documentation/Makefile
> > +++ b/tools/perf/Documentation/Makefile
> > @@ -120,6 +120,9 @@ endif
> >  ifdef DOCBOOK_SUPPRESS_SP
> >  XMLTO_EXTRA += -m manpage-suppress-sp.xsl
> >  endif
> > +ifdef KBUILD_BUILD_TIMESTAMP
> > +ASCIIDOC_EXTRA += -a revdate=$(shell date -u -d '$(KBUILD_BUILD_TIMESTAMP)' +%Y-%m-%d)
> > +endif
> >  
> >  SHELL_PATH ?= $(SHELL)
> >  # Shell quote;
> > --- a/tools/perf/Documentation/asciidoc.conf
> > +++ b/tools/perf/Documentation/asciidoc.conf
> > @@ -71,6 +71,9 @@ ifdef::backend-docbook[]
> >  [header]
> >  template::[header-declarations]
> >  <refentry>
> > +<refentryinfo>
> > +template::[docinfo]
> > +</refentryinfo>
> >  <refmeta>
> >  <refentrytitle>{mantitle}</refentrytitle>
> >  <manvolnum>{manvolnum}</manvolnum>
> 
> As we do apply the change in Downstream in Debian, I was wondering if
> it just felt trough the cracks and could still be applied. Is there
> anything missing?

Isn't this fixed in:

commit d586ac10ce56b2381b8e1d8ed74660c1b2b8ab0d
Author: Ian Rogers <irogers@google.com>
Date:   Fri Sep 20 21:13:27 2019 -0700

    perf docs: Allow man page date to be specified

    With this change if a perf_date parameter is provided to asciidoc then
    it will override the default date written to the man page metadata.

    Without this change, or if the perf_date isn't specified, then the
    current date is written to the metadata.

    Having this parameter allows the metadata to be constant if builds
    happen on different dates.

    The name of the parameter is intended to be consistent with the existing
    perf_version parameter.

    Signed-off-by: Ian Rogers <irogers@google.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Stephane Eranian <eranian@google.com>
    Link: http://lore.kernel.org/lkml/20190921041327.155054-1-irogers@google.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
