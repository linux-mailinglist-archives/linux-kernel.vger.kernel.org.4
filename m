Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EB57334DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346011AbjFPPcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjFPPcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:32:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D952812B;
        Fri, 16 Jun 2023 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8C7YhXPhh7ijldw00jMSUNhsgYPXxCbnNmJt5aUxlOc=; b=FGe0HEly7Lxm991DNpcRl4iBD1
        YimMZxQGg2DHVZB20woYNjjZ2ZQVg8XhsMQTDqCrhihHWy0oQHxrKiB6vQnT+E8elYcDYP5vxifuC
        /v4iD8bXTAm0sjoT4qmuUqMx2LEe9MOQMob0NSZs8CwyTikJZeKmUsJCN/D/AuJzpEV5Gya41Qvy5
        M8r5Ryb87t3JvObZXFLmsJiYRNGMCr97OB3C4taLgNOznfBu0s38SFgO70wYyIUT/+1V7S5Qx1AV0
        VQXdNhT12PEy3BplKW0T4nwQOdcx2LZrFZbGeFl954RDkEG57DJUgDiC8N451MeSySg5qs9w6aSqC
        WoRVTjFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qABR0-0097p0-TR; Fri, 16 Jun 2023 15:32:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73BE2300208;
        Fri, 16 Jun 2023 17:32:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BCBB24519B2F; Fri, 16 Jun 2023 17:32:21 +0200 (CEST)
Date:   Fri, 16 Jun 2023 17:32:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Sandipan Das (AMD)" <sandipandas1990@gmail.com>
Cc:     Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sandipan Das <sandipan.das@amd.com>, leit@fb.com,
        dcostantino@meta.com,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>, ananth.narayan@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
Message-ID: <20230616153221.GI4253@hirez.programming.kicks-ass.net>
References: <20230616115316.3652155-1-leitao@debian.org>
 <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZIxrxpYtffT0FtEx@gmail.com>
 <100041d0-f2fe-331b-13a7-ad09082aeb7d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <100041d0-f2fe-331b-13a7-ad09082aeb7d@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 08:13:22PM +0530, Sandipan Das (AMD) wrote:
> The reserved bits should never be set. The purpose of the WARN_ON() is to catch such anomalies.
> I am working out the details with Breno and will report back with a resolution.

Thanks!
