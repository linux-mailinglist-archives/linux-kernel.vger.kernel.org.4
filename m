Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A116F7FB9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjEEJRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjEEJRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:17:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA69E4B;
        Fri,  5 May 2023 02:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XgffjADJueiaBKtq3vhPj7C6S2yqagj9t0to9VzS6Xs=; b=Rlz9BJSPkpRxxRFZtVP6M3TiJu
        e/2YQdUQ8rgk0GZKJ+29hc47yt39PK1k4TIfFGlf598IpDcRPh0sudyGbmxQeTd9tpYjaJNyivxz9
        k+YX0UYfkeCkSx0Bp/sNu1cxylrpB2iF5LM0lpD1QQ++s/29vD4uuJJKZVYBF4dNqkWejR6MLUN65
        YG66GWrSyMUThtezexDg2IL6HIe89V7PpkqBLMvu0i+UM63COcB0IVLgWLQUcIwgL9ihcewCgRdj5
        lHqqv0mzigZ2DK5ee33qcYPe19ePm4zx0nRysnK6s7M+3fLTNPgfg19u7lWUzSPSCmUhOkGRR6PH/
        Y8LYmrUw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1purYY-003CsK-28;
        Fri, 05 May 2023 09:16:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09C2930602A;
        Fri,  5 May 2023 11:16:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D6BB5241D3325; Fri,  5 May 2023 11:16:48 +0200 (CEST)
Date:   Fri, 5 May 2023 11:16:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     namhyung@kernel.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, kan.liang@linux.intel.com, adrian.hunter@intel.com,
        maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v4 4/4] perf test: Add selftest to test IBS invocation
 via core pmu events
Message-ID: <20230505091648.GC1770668@hirez.programming.kicks-ass.net>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
 <20230504110003.2548-5-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504110003.2548-5-ravi.bangoria@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 04:30:03PM +0530, Ravi Bangoria wrote:
> IBS pmu can be invoked via fixed set of core pmu events with 'precise_ip'
> set to 1. Add a simple event open test for all these events.
> 
> Without kernel fix:
>   $ sudo ./perf test -vv 76
>    76: AMD IBS via core pmu                                      :
>   --- start ---
>   test child forked, pid 6553
>   Using CPUID AuthenticAMD-25-1-1
>   type: 0x0, config: 0x0, fd: 3  -  Pass
>   type: 0x0, config: 0x1, fd: -1  -  Pass
>   type: 0x4, config: 0x76, fd: -1  -  Fail
>   type: 0x4, config: 0xc1, fd: -1  -  Fail
>   type: 0x4, config: 0x12, fd: -1  -  Pass
>   test child finished with -1
>   ---- end ----
>   AMD IBS via core pmu: FAILED!
> 
> With kernel fix:
>   $ sudo ./perf test -vv 76
>    76: AMD IBS via core pmu                                      :
>   --- start ---
>   test child forked, pid 7526
>   Using CPUID AuthenticAMD-25-1-1
>   type: 0x0, config: 0x0, fd: 3  -  Pass
>   type: 0x0, config: 0x1, fd: -1  -  Pass
>   type: 0x4, config: 0x76, fd: 3  -  Pass
>   type: 0x4, config: 0xc1, fd: 3  -  Pass
>   type: 0x4, config: 0x12, fd: -1  -  Pass
>   test child finished with 0
>   ---- end ----
>   AMD IBS via core pmu: Ok
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/arch/x86/include/arch-tests.h      |  1 +
>  tools/perf/arch/x86/tests/Build               |  1 +
>  .../arch/x86/tests/amd-ibs-via-core-pmu.c     | 71 +++++++++++++++++++
>  tools/perf/arch/x86/tests/arch-tests.c        |  2 +
>  4 files changed, 75 insertions(+)
>  create mode 100644 tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c

Arnaldo, ok if I merge this along with the other patches or would you
rather take it?
