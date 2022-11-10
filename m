Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E999F624990
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiKJSfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiKJSfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:35:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CA11582A;
        Thu, 10 Nov 2022 10:35:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 17E41CE249A;
        Thu, 10 Nov 2022 18:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15EEC433D6;
        Thu, 10 Nov 2022 18:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668105303;
        bh=w217Ff/N57hJS24hKUs+XsjXvSk1sr2hCTvbGYBVlOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brq2G995vju4lbKn11htJgaxjDNbsxO2OQXdViBbo8E+Fzk2sZTkgO7kFhpU0Pzpw
         G0CCGPtq6L/pHCMmWcRU4i7CQTeywNaIUpC+YiXMJg4vTlzEIaQQiJtXmJw0JIh+bY
         K1Nq3KkBf30ffsgv+wAR37/tDqO5oNQwr99G7rg8SBBW9llKgo6DryXYestO7KrJkj
         yka27yiSUfHg4fhQOlkMXWMf8JauU7n1CLE77heh8ejFku3GHSYS9Xcsrr+I+AXsKF
         bqIsZsOSzaBFPC2+TLP3ESzeVIZFkUcfzCu/Yp7A6OHAUOg9AKd0/f72tzxS5qdOwb
         9a3YYdO4OjC9w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DB6604034E; Thu, 10 Nov 2022 15:34:53 -0300 (-03)
Date:   Thu, 10 Nov 2022 15:34:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf lock: Allow concurrent record and report
Message-ID: <Y21ETduUDa86eib6@kernel.org>
References: <20221104051440.220989-1-namhyung@kernel.org>
 <CAP-5=fXm1EkFiQMWmTgG80xkwzcPDKjwA4wCQr765AGVSG=Ucw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXm1EkFiQMWmTgG80xkwzcPDKjwA4wCQr765AGVSG=Ucw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 08, 2022 at 03:26:01PM -0800, Ian Rogers escreveu:
> On Thu, Nov 3, 2022 at 10:14 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > To support live monitoring of kernel lock contention without BPF,
> > it should support something like below:
> >
> >   # perf lock record -a -o- sleep 1 | perf lock contention -i-
> >    contended   total wait     max wait     avg wait         type   caller
> >
> >            2     10.27 us      6.17 us      5.13 us     spinlock   load_balance+0xc03
> >            1      5.29 us      5.29 us      5.29 us     rwlock:W   ep_scan_ready_list+0x54
> >            1      4.12 us      4.12 us      4.12 us     spinlock   smpboot_thread_fn+0x116
> >            1      3.28 us      3.28 us      3.28 us        mutex   pipe_read+0x50
> >
> > To do that, it needs to handle HEAD_ATTR, HEADER_EVENT_UPDATE and
> > HEADER_TRACING_DATA which are generated only for the pipe mode.
> > And setting event handler also should be delayed until it gets the
> > event information.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

