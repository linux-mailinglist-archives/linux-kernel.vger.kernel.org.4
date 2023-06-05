Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39029722245
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjFEJe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjFEJeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:34:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DED3BD;
        Mon,  5 Jun 2023 02:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U6Rs8a1yqf5xr+ElMRlsYvavjPCQLMdxxIEBLNZIQtY=; b=bNe5Cm5J5NgNKQ+iPXJml2TpTZ
        1DZrkOF/s1GlcWpc01qwugGA7J1GHRnHXb6eqisktBUsHsrU9BbpluPUo95gp5NVuAfM4rg5sqaYQ
        ksEsrwiF1NZ+txiRRx+a7yHCFvWUztsmI2LnFuSUg8notAi45jWw9SwGDmgFpQPl50Bn7SIRtFyM8
        4YUj/RwEb5kCv4+JvIA+x9JgsFUb1uymk/cceGqa07t9v6vuJcGhS6o4DbX3Z0SJomVrCGSWEjxVN
        afaRCpZMMuil9ar5pVal2G1NAU6XvJK5abq0wj4Wyk7eu+UsdIBhZ1MZZsPyOBsuyIXh0408B0j8p
        P2mUf5Wg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q66bC-003KDV-1Q;
        Mon, 05 Jun 2023 09:34:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11AE0300274;
        Mon,  5 Jun 2023 11:34:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDCD620AC06F5; Mon,  5 Jun 2023 11:34:00 +0200 (CEST)
Date:   Mon, 5 Jun 2023 11:34:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>, jolsa@kernel.org,
        irogers@google.com, bp@alien8.de, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECT] perf/core: Remove pmu linear searching code
Message-ID: <20230605093400.GK38236@hirez.programming.kicks-ass.net>
References: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
 <ZH2KVyyC5oMr+Vk2@FVFF77S0Q05N>
 <20230605092731.GZ4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605092731.GZ4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 11:27:31AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 05, 2023 at 08:10:15AM +0100, Mark Rutland wrote:
> 
> > How does this work on x86? Do you have pseudo-PMUs for PERF_TYPE_HARDWARE and
> > PERF_TYPE_RAW ?
> 
> Generic code maps TYPE_HARDWARE and TYPE_HW_CACHE to TYPE_RAW for a
> first go, only if that fails it will try the actual type.
> 
> And x86 has the (first) CPU PMU has TYPE_RAW, on hybrid, it will
> transparently pick the right actual PMU.

Oh, I might've misread that last bit.. TYPE_RAW is always the big core,
it will not magic the thing. If you want little events you gotta
manually find the little pmu.
