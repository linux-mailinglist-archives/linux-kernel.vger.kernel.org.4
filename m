Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F157228D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjFEObn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjFEObl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:31:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D85E9;
        Mon,  5 Jun 2023 07:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C1A462077;
        Mon,  5 Jun 2023 14:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3745BC4339B;
        Mon,  5 Jun 2023 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685975499;
        bh=mrOtizINhh5fwcPJizUYE/rj2XWhdL1zZyiYvybGQy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ipUDWWw91EH6WtuSoZK4XL6EcAt2gTqwhl+h3IOz3di7bYV00b/T/zOXk/p4Ju31h
         c4AdttDWyfVpNILj2dEM9x3F7vusCqfB7bxt/TejnJmyRkzif3EKIcXYl54VxmHKL8
         bQiIp0oLAoAsQVlNh2rbhqLTeLSXShn6is1Y2aaewZav/zEEUisL9ZxpxYm6KzuPVJ
         oh7IxDtgC1Xse94PiLhzHr2teO1eAlow7zSV9NbMbL10lLxSL83SE87Fqm3WEwOYqE
         2bUuLcFRAC1Mqxbx77lvECE55OK9AO+2snJL279hxAz51Aai6EevkbrgBQ0HmrEy2Q
         F0pvcXDa5IP7w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E3B0240692; Mon,  5 Jun 2023 11:31:36 -0300 (-03)
Date:   Mon, 5 Jun 2023 11:31:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 10/10] perf: tests: Adapt mmap-basic.c for riscv
Message-ID: <ZH3xyJkEf1b51Ydy@kernel.org>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-11-alexghiti@rivosinc.com>
 <20230531-31bd9ddeaca8cb338f81ed14@orel>
 <ZH3ovt4WnTJuTinF@kernel.org>
 <CAHVXubhofC+WaSysWaxcTA2GdJAF8kTD3COBeQDAy25af_rSLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubhofC+WaSysWaxcTA2GdJAF8kTD3COBeQDAy25af_rSLg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 05, 2023 at 04:00:12PM +0200, Alexandre Ghiti escreveu:
> On Mon, Jun 5, 2023 at 3:53 PM Arnaldo Carvalho de Melo <acme@kernel.org>
> wrote:
> 
> > Em Wed, May 31, 2023 at 05:15:15PM +0200, Andrew Jones escreveu:
> > > On Fri, May 12, 2023 at 10:53:21AM +0200, Alexandre Ghiti wrote:
> > > > riscv now supports mmaping hardware counters to userspace so adapt the
> > test
> > > > to run on this architecture.
> > > >
> > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > ---
> > > >  tools/perf/tests/mmap-basic.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/perf/tests/mmap-basic.c
> > b/tools/perf/tests/mmap-basic.c
> > > > index e68ca6229756..f5075ca774f8 100644
> > > > --- a/tools/perf/tests/mmap-basic.c
> > > > +++ b/tools/perf/tests/mmap-basic.c
> > > > @@ -284,7 +284,7 @@ static struct test_case tests__basic_mmap[] = {
> > > >                      "permissions"),
> > > >     TEST_CASE_REASON("User space counter reading of instructions",
> > > >                      mmap_user_read_instr,
> > > > -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> > > > +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> > || __riscv_xlen == 64
> > > >                      "permissions"
> > > >  #else
> > > >                      "unsupported"
> > > > @@ -292,7 +292,7 @@ static struct test_case tests__basic_mmap[] = {
> > > >             ),
> > > >     TEST_CASE_REASON("User space counter reading of cycles",
> > > >                      mmap_user_read_cycles,
> > > > -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> > > > +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> > || __riscv_xlen == 64
> > > >                      "permissions"
> > > >  #else
> > > >                      "unsupported"
> > > > --
> > > > 2.37.2
> > > >
> > >
> > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> >
> > Was the kernel part merged upstream?
> >
> 
> No, I still haven't answered the reviews :)

Ok, I'll then wait for it to happen to consider merging the userland
parts,

Thanks,

- Arnaldo
