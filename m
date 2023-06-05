Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019877227DF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjFENxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjFENxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:53:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF0790;
        Mon,  5 Jun 2023 06:53:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C851B614B3;
        Mon,  5 Jun 2023 13:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C72C433EF;
        Mon,  5 Jun 2023 13:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685973185;
        bh=XdrGiF2qW4zmcHGmdQX26U4gcVnu9woLBBCYvTe20L8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YsAnhrKeP7mcDyfrMOxRvXQBemX7xUB1g1rRK2jgNZsndveJS9hJUynDiXNjUIKkR
         Ha/x8D0DWnSrBHvl/uvLIdnSO3lxvizmkptQrdgaLJhkfTVwsaKyezIb0P9Y/oigwG
         qLiqDqbAmXmqQjxv+ovgPaZfJsJiwh6eXcFdXjByx1Ejivb3J/oMPYK4kQLLE0NZNo
         wCJI3+cjJX1xbJQgStIHdJCyOy7N6ydcmcalzLmuEQhqTXDTjEhYegD42ITnxBfXD+
         6ZlAUgVWncT9CVAZ5lSYIasGwr0iTbPDz0tt+D9Q3heK361ptCC4TqtUCl5MnneXsP
         EWvumtp2diZdA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6821C40692; Mon,  5 Jun 2023 10:53:02 -0300 (-03)
Date:   Mon, 5 Jun 2023 10:53:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
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
Message-ID: <ZH3ovt4WnTJuTinF@kernel.org>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-11-alexghiti@rivosinc.com>
 <20230531-31bd9ddeaca8cb338f81ed14@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531-31bd9ddeaca8cb338f81ed14@orel>
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

Em Wed, May 31, 2023 at 05:15:15PM +0200, Andrew Jones escreveu:
> On Fri, May 12, 2023 at 10:53:21AM +0200, Alexandre Ghiti wrote:
> > riscv now supports mmaping hardware counters to userspace so adapt the test
> > to run on this architecture.
> > 
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  tools/perf/tests/mmap-basic.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> > index e68ca6229756..f5075ca774f8 100644
> > --- a/tools/perf/tests/mmap-basic.c
> > +++ b/tools/perf/tests/mmap-basic.c
> > @@ -284,7 +284,7 @@ static struct test_case tests__basic_mmap[] = {
> >  			 "permissions"),
> >  	TEST_CASE_REASON("User space counter reading of instructions",
> >  			 mmap_user_read_instr,
> > -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> > +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || __riscv_xlen == 64
> >  			 "permissions"
> >  #else
> >  			 "unsupported"
> > @@ -292,7 +292,7 @@ static struct test_case tests__basic_mmap[] = {
> >  		),
> >  	TEST_CASE_REASON("User space counter reading of cycles",
> >  			 mmap_user_read_cycles,
> > -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> > +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || __riscv_xlen == 64
> >  			 "permissions"
> >  #else
> >  			 "unsupported"
> > -- 
> > 2.37.2
> >
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Was the kernel part merged upstream?

- Arnaldo
