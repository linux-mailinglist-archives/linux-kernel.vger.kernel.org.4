Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BB470E086
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbjEWPbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbjEWPbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:31:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA06129;
        Tue, 23 May 2023 08:31:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6093A63304;
        Tue, 23 May 2023 15:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B50C433D2;
        Tue, 23 May 2023 15:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684855900;
        bh=B5vj1o10A+ayLVD82jognpVSNrFBmnFy2ZXqq20SMdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJ7tODB1uVoZNjoFH803TVw2OKMh/qY0EUPZuVXpVTr4KW0OqYTU1HwSii+E7cyN5
         Wbf3heYcvTPHWo08Ketm0eymMPUbxPSt2tj2mcoAMgNKzhkDNdIl9Hmzrd8qIfnSxz
         9TlPUh3Sdau9q5AizNFoc8ATOvOAV1kg+F+eoUY/d0iq6BSnFIg7bNQGa0+WgBFcG6
         TgZEaKllL0G6JDOMmapLLXBm/M0nMa5JmOULGNtIsyy4gKyhLI56DmLxbS2lgxFmU2
         uWUY5M98IENrRD5qprA4gXkQNqS3Nfhj9670N8XbDOUMDvIABRHSY+BDWDmwf5h31M
         515YbDMka1qvA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D18A6403B5; Tue, 23 May 2023 12:31:37 -0300 (-03)
Date:   Tue, 23 May 2023 12:31:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, ravi.bangoria@amd.com, sandipan.das@amd.com,
        ananth.narayan@amd.com, gautham.shenoy@amd.com, eranian@google.com,
        puwen@hygon.cn
Subject: Re: [PATCH v4 0/5] perf stat: Add option to aggregate data based on
 the cache topology
Message-ID: <ZGzcWb4Z8/P/Dca4@kernel.org>
References: <20230517172745.5833-1-kprateek.nayak@amd.com>
 <CAP-5=fUCvQNsW0Tnj7Q8sjFTqTEC9YUbFxAedRFtA=5zUe7BVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUCvQNsW0Tnj7Q8sjFTqTEC9YUbFxAedRFtA=5zUe7BVA@mail.gmail.com>
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

Em Wed, May 17, 2023 at 10:58:01AM -0700, Ian Rogers escreveu:
> On Wed, May 17, 2023 at 10:22 AM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> > K Prateek Nayak (5):
> >   perf: Extract building cache level for a CPU into separate function
> >   perf stat: Setup the foundation to allow aggregation based on cache
> >     topology
> >   perf stat: Save cache level information when running perf stat record
> >   perf stat: Add "--per-cache" aggregation option and document the same
> >   pert stat: Add tests for the "--per-cache" option
 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, great, documented, with accompanying 'perf test' entries, applied.

- Arnaldo

