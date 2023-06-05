Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DB8722227
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjFEJ2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFEJ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:28:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B9DD2;
        Mon,  5 Jun 2023 02:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=edEp8QIKfJn6F2bGmfqREfiBWe5wjWDfn3SnYuov1ho=; b=hMGo4madH9axx65nVtWK4w0Exz
        8RjTQuQmbuIc8CFPSu67CV8SL0uunWprHX4tPhUVj6K7FnEP5mcbF5W/xePTpdJef/Qf++CWa4vBv
        zo78SG5FslcPNSXzLwr8S56hXxj2ZVWolmYrPdb/xcCzB7GHBec3mb3qjLuqlB9Z4hbO2LjwR1SbM
        +W9Wl/MKylYHydp3M25TABQ6m5l8lMXbZfbR9egG2ra6obM9oY58xj9/HiGVH3IMQ9I8We+vEv10z
        olYpbbpuaOTruBWXF8+dQk+wGMHJ1UAr3wkgexjsB3h+NBqtMPFB8utd2fzUe+QN61ozvf0FH541h
        0Zs5d1wA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q66Uv-00BsA1-Nt; Mon, 05 Jun 2023 09:27:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7230300274;
        Mon,  5 Jun 2023 11:27:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85CF8243CC1CF; Mon,  5 Jun 2023 11:27:31 +0200 (CEST)
Date:   Mon, 5 Jun 2023 11:27:31 +0200
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
Message-ID: <20230605092731.GZ4253@hirez.programming.kicks-ass.net>
References: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
 <ZH2KVyyC5oMr+Vk2@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH2KVyyC5oMr+Vk2@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 08:10:15AM +0100, Mark Rutland wrote:

> How does this work on x86? Do you have pseudo-PMUs for PERF_TYPE_HARDWARE and
> PERF_TYPE_RAW ?

Generic code maps TYPE_HARDWARE and TYPE_HW_CACHE to TYPE_RAW for a
first go, only if that fails it will try the actual type.

And x86 has the (first) CPU PMU has TYPE_RAW, on hybrid, it will
transparently pick the right actual PMU.

That said; given that this commit has been tagged twice now, I suppose I
should go revert it and we'll try again after a more thorough audit.
