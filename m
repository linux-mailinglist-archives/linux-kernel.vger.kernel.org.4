Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59C60BC29
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiJXVax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiJXVa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D65E295B1C;
        Mon, 24 Oct 2022 12:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAA4461575;
        Mon, 24 Oct 2022 19:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF505C433C1;
        Mon, 24 Oct 2022 19:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666640171;
        bh=fldEejBmWhb2dcNXpmcrmZPAcI08NnoyTAQGGcT+UNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjQkd+T/t3ZgB8kCMwcKd5h5QKQnhN3rF7FHtJiiRNpwHApD7Bw4+FUGk7noUPUby
         lnKEcOo1sE7gJ6GaHYjMhJ2j5rLMe4pFhrL5zPLyGw3j0K4tGV/8hElPd8m1v7bZBT
         1rzdBFF+qLA980xACh8aD8HIU8FwAMf35XYVJi1cAYqpYQJV/lMol/fACcofds5sfk
         wD/pTD2l2ZSGK+NtmTpVVrGD6tnr4ggd4QUgtCIHQOIgGdOTE1fTeNvnCc8HXgvmaM
         FKXE0UDLbz6tT5RQ6pkEvlSXqKjUoLfwubX18OncucgtQKrAGdIFAZIjJpwjWZqk3s
         fdiwSGePzY9WA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E08EF404BE; Mon, 24 Oct 2022 16:36:07 -0300 (-03)
Date:   Mon, 24 Oct 2022 16:36:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 0/8] Update to C11, fix signal undefined behavior
Message-ID: <Y1bpJ5zqDOBYCQCx@kernel.org>
References: <20221024173523.602064-1-irogers@google.com>
 <Y1bQlxxABicj4k3+@kernel.org>
 <CAP-5=fWPdmHPXc9D2LP6TVmhuNf93gZCnogWXCVGytkhuqi2uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWPdmHPXc9D2LP6TVmhuNf93gZCnogWXCVGytkhuqi2uQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 24, 2022 at 10:59:03AM -0700, Ian Rogers escreveu:
> On Mon, Oct 24, 2022 at 10:51 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Mon, Oct 24, 2022 at 10:35:15AM -0700, Ian Rogers escreveu:
> > > The use of C11 is mainstream in the kernel [1]. There was some
> > > confusion on volatile and signal handlers in [2]. Switch to using
> > > stdatomic.h (requires C11) and sig_atomic_t as per [3]. Thanks to Leo
> > > Yan <leo.yan@linaro.org> for the suggestions.
> > >
> > > [1] https://lore.kernel.org/lkml/CAHk-=whWbENRz-vLY6vpESDLj6kGUTKO3khGtVfipHqwewh2HQ@mail.gmail.com/
> > > [2] https://lore.kernel.org/lkml/20221024011024.462518-1-irogers@google.com/
> > > [3] https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers
> >
> > I think I'll apply this to perf/core, i.e. for 6.3, ok?
> 
> Sounds good to me. 6.3 or 6.2? I suspect there is more cleanup like
> this and to the iterators (from C11) that can be done.

oops, 6.2, sure, 6.1 is the current one, merge window closed. :-)

- Arnaldo
