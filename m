Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F47678882
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjAWUlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjAWUlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:41:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F2A3800B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0xN7hOPDsbgth1lPxi0MXO8fcKBUctMvHiKYNT0njNY=; b=iH2KtTEZUm2GCo5Ai3vYCcozMK
        TyX8083e9g6tvTsF6AeH0yOASL2bZ0JdZWU64xjpxSEKQ4LzJA71SzJJK03Xvrccyz3sVNIIwzi6G
        7kG5IxLqnM+cZqlr+aM66s/TkoEt51mnrkLwhqP8bDvnhU5zau0raV1WnX9TnIY4nA+RwRHIbJx5J
        YPNcD/6LNhapgrxLz+Li6D/U6TG2D9ZtSjVf+Rm2hYt1HC0pWZytRs+tLtmW47P9L+465YyC0TjZ2
        XIRL8IPJ7uK5ksS7FPnfs59Tf9Q3ya+cg32tG7G8O2XESIjA0t+uwonxGoA8DNRObprDN6cZ5xjW1
        moP52f1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pK3aj-001dch-0f;
        Mon, 23 Jan 2023 20:38:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 402963001E7;
        Mon, 23 Jan 2023 21:39:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 227F22077B1DE; Mon, 23 Jan 2023 21:39:25 +0100 (CET)
Date:   Mon, 23 Jan 2023 21:39:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] perf/x86/intel/ds: Fix the conversion from TSC to perf
 time
Message-ID: <Y87wfaMJ2HLchgap@hirez.programming.kicks-ass.net>
References: <20230123172027.125385-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123172027.125385-1-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:20:27AM -0800, kan.liang@linux.intel.com wrote:
> The TSC unstable case seems to be some corner cases (e.g., due to broken
> BIOS). This patch doesn't support the conversion when the TSC is
> unstable. The TSC in a PEBS record will be dropped and fallback to the
> software perf time provided by the generic code.

:-(

You're saying there's modern systems (PEBS timestamps are fairly new)
that trigger unstable TSC ?

What systems in specific have you observed this on -- we really need to
name and shame them, this is fully unacceptable.
