Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F63C73EDDD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjFZV7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjFZV6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:58:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369C92957;
        Mon, 26 Jun 2023 14:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC3C860F83;
        Mon, 26 Jun 2023 21:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F39C433C0;
        Mon, 26 Jun 2023 21:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816435;
        bh=E5V6C3Cy2abGlilAmJAR5VqMNIsaaUZD3xWjkT72NbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pUmi7PrIMMiicJTrzrPcl2cjxsPjGBBu2KQB61vcBxhvXujZeQYeJADuuODmlPTSH
         fj7Cy36hY3pRiAMAwnM9027wLGM93TeCyVdUKFJDZ0bpisG6Y2EZV7VLJuaXBilwXF
         FIuI+ZaCqVVtKwjyJHq3JHdgDWACHRwDMN9fz0AgMIixYWZlQUgw5eyv9WyR9D3dkf
         lVzgjTUceF5D3nPycgZ0FxzW2Plvrl33i4C0kWTGOamu8ugMHAfrhkDVpPx9PzUSF5
         yOWno71ZE1XBeBGbKISuMZyE8qduWv0+usircmk0Byyj+MhhCthydRMH1sj8V9d+im
         n4DX/2IHSUBiA==
Date:   Mon, 26 Jun 2023 14:53:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tools: Fix MSG_SPLICE_PAGES build error in
 trace tools
Message-ID: <20230626145353.468fd133@kernel.org>
In-Reply-To: <CAM9d7ch_mWUQGW8G221bZmCPn3wB2mjZm=ZdmhDkczhich9xZA@mail.gmail.com>
References: <5791ec06-7174-9ae5-4fe4-6969ed110165@tessares.net>
        <3065880.1687785614@warthog.procyon.org.uk>
        <3067876.1687787456@warthog.procyon.org.uk>
        <2cb3b411-9010-a44b-ebee-1914e7fd7b9c@tessares.net>
        <CAM9d7ch_mWUQGW8G221bZmCPn3wB2mjZm=ZdmhDkczhich9xZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 14:31:39 -0700 Namhyung Kim wrote:
> Right, we want to keep the headers files in the tools in sync with
> the kernel ones.  And they are used to generate some tables.
> Full explanation from Arnaldo below.
> 
> So I'm ok for the msg_flags.c changes, but please refrain from
> changing the header directly.  We will update it later.
> 
> With that,
>   Acked-by: Namhyung Kim <namhyung@kernel.org>

Ah, missed this email, sounds like this is preferred to Matthieu's
fix, we'll take this one.

> Also I wonder if the tool needs to keep the original flag
> (SENDPAGE_NOTLAST) for the older kernels.

That's a bit unclear, because it's just a kernel-internal flag.
Future kernels may well use that bit for something else.

Better long term solution would be to use an enum so that the values
are included in debuginfo and perf can read them at runtime :(
