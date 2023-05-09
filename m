Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B76C6FCD8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjEISQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEISQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79252120;
        Tue,  9 May 2023 11:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1066263638;
        Tue,  9 May 2023 18:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04921C433EF;
        Tue,  9 May 2023 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683656198;
        bh=jfcOfENDXVo1zvtGdJGG+4yuDzgrOfrlQMEP4qdEXh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fhs00o+RG1r5a6r5BnnkBobooevjXBIMZW+Eh7OIzQboi9Q+PqpKnAM9vDmfKFFqc
         m3I1neHHeUuaDYjuyrQ8dgpg1qUKxTBNF27KArWKIZZLsJActk0us99JLQUhHk3KHi
         BPVyvzK7ZR2IRjCjSnrqy6P/442ZQzqswtCHb1ADc9ZCrgtyfyKlePGP55Tne14dQu
         jZ2bbDeiLkKTiBa/45R8T9RiHcruXU30cKEIwBIQ3QDpQcnpvQXZ2SKNFVe6CX2mLC
         z+briRaH/kFMsX4rfYMsfolu1zXtv34ge94D0WBfDIL65R1Z8pP/I/QuJ5cqNA/3d7
         IzZh5/jCqShWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E46F403B5; Tue,  9 May 2023 15:16:35 -0300 (-03)
Date:   Tue, 9 May 2023 15:16:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf/test: reduce run time of perf test Test java symbol
Message-ID: <ZFqOAwM2mgvnExnC@kernel.org>
References: <20230509131847.835974-1-tmricht@linux.ibm.com>
 <CAP-5=fVC1bAMk5gOGSXi0sHdetdLHGT2tqW43dxTTyJ3jRz8QA@mail.gmail.com>
 <ZFqMsjJg00zmQyJG@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFqMsjJg00zmQyJG@kernel.org>
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

Em Tue, May 09, 2023 at 03:10:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> > On Tue, May 9, 2023 at 6:19 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> > > -if ! perf inject -i $PERF_DATA -o $PERF_INJ_DATA -j; then
> > > +if ! DEBUGINFOD_URLS='' perf inject -i $PERF_DATA -o $PERF_INJ_DATA -j; then
 
> I noticed this delay, It is good that someone worked on rootcausing this
> excessive delay, thanks Thomas.
> 
> I'll test it now.

gdb asks the user if debuginfod should be used, perf is doing this if
the system is configured for debuginfod queries via a systemwide config,
what is best? Unsure, but since the test passes, i.e. the expected
symbols are found in the 'perf report' output, avoiding debuginfod
queries seems to fit the bill,

Applied,

- Arnaldo
