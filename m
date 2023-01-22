Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2F3677297
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjAVVLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAVVLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:11:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9B314E8A;
        Sun, 22 Jan 2023 13:11:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC30060C6C;
        Sun, 22 Jan 2023 21:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C06C433D2;
        Sun, 22 Jan 2023 21:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674421903;
        bh=FafjG3X/vdoJPsflhPttxNdSKifAkgdt8Z7YJK9fMHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aVa6eMXPCj6uxiJwSHdCQg0nP1Q2LUh1XQq9diOYCLjmBaEk/R9KofvXcyGgqOtIB
         Xol1ZatQRux9+GNoYOsguEiEvetQi0CicD/lAwJf4HmyiR1V4Gx7m9zHdOxpZ/D5eZ
         rSUyXU5EiyoH6pBNMfiC5G29XzII8OjX8EtJ4APYj6uxMqt1gZgvp8MQYkpXK5zIjd
         FY41SMhzyRNiLYZZoNTblztMLRyd5zWTTJGsaPWSeX9/h/ihpGCaW5t3c2DGzWSviC
         MkpKbU/N1Zcy1Mp8Pw1/4kzOF7rUeEjtnddN9IuCIj8OJe2plEHDtQYnhUlxScJszi
         bek3kpDhfAgBQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 47016405BE; Sun, 22 Jan 2023 18:11:40 -0300 (-03)
Date:   Sun, 22 Jan 2023 18:11:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 00/10] perf symbols: Improve dso__synthesize_plt_symbols()
Message-ID: <Y82mjOIHnC2g5sqY@kernel.org>
References: <20230120123456.12449-1-adrian.hunter@intel.com>
 <CAP-5=fUwkghLbz7O4peCSMbt2LjAtUwi+tB3_wgnZrjkg9jn9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUwkghLbz7O4peCSMbt2LjAtUwi+tB3_wgnZrjkg9jn9w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jan 21, 2023 at 09:53:53AM -0800, Ian Rogers escreveu:
> On Fri, Jan 20, 2023 at 4:35 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > Hi
> >
> > This is the first of 2 patchsets to improve dso__synthesize_plt_symbols().
> > This patchset is really preparation for the 2nd patchset, which focuses
> > on getting rid of unknown symbols that show up in Intel PT traces.
> > The 2nd patchset is still under development.
> >
> > These patches are small and staightforward. Only the new Symbols test is
> > slightly interesting because it provides a way to see what symbols
> > perf discovers for any given dso. The test fails initially, but
> > should pass after patch 7 "perf symbols: Add symbol for .plt header".
> >
> >
> > Adrian Hunter (10):
> >       perf test: Add Symbols test
> >       perf symbols: Factor out get_plt_sizes()
> >       perf symbols: Check plt_entry_size is not zero
> >       perf symbols: Add dso__find_symbol_nocache()
> >       perf symbols: Slightly simplify 'err' usage in dso__synthesize_plt_symbols()
> >       perf symbols: Do not check ss->dynsym twice
> >       perf symbols: Add symbol for .plt header
> >       perf symbols: Allow for .plt entries with no symbol
> >       perf symbols: Combine handling for SHT_RELA and SHT_REL
> >       perf symbols: Check SHT_RELA and SHT_REL type earlier
 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, added to the tested patches, will push to perf/core shortly.

- Arnaldo
