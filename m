Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A8073322E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjFPNa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFPNa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:30:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B3DED;
        Fri, 16 Jun 2023 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=39t1+CziOcEwSKMaEbR6TuXAr4gx63Q66OzrK8Qmsn0=; b=gPI80sYSfhefZyneYhc7SdBorI
        jFXlh4K3aA9RocNpMvSHeuuvYsxYkuYDAqJn4jP0/fdEfz+yniYaPfxYmcprm+hfCEMV0NfUhCzpZ
        fa9TvcofyZtV1acXBNpKBZyz1ZHSGsr3cxZQ3gCHHxIoLba+mqn1rE6zVOCgJsboy6bGaGlQS782D
        s6Hs0ZhuNy/x6E+AIzCLomosGaS+rxxreADilU7ysyHgZ01TqMbLvDhp8nrxG5h1NE6xY9LkJkxfX
        0wEa5tPlpR6tTfz98fyLATvCYP87R4nHLbvGVxikqEZYijeTFyh+pnWkjgrmc0a9UvT9AFlV2sdTu
        CbLQregg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qA9WW-00CvXi-2b;
        Fri, 16 Jun 2023 13:29:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DA71300208;
        Fri, 16 Jun 2023 15:29:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4AA32743896F; Fri, 16 Jun 2023 15:29:54 +0200 (CEST)
Date:   Fri, 16 Jun 2023 15:29:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
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
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
Message-ID: <20230616132954.GG4253@hirez.programming.kicks-ass.net>
References: <20230616115316.3652155-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230616115316.3652155-1-leitao@debian.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 04:53:15AM -0700, Breno Leitao wrote:
> On some systems, the Performance Counter Global Status Register is
> coming with reserved bits set, which causes the system to be unusable
> if a simple `perf top` runs. The system hits the WARN() thousands times
> while perf runs.
> 
> WARNING: CPU: 18 PID: 20608 at arch/x86/events/amd/core.c:944 amd_pmu_v2_handle_irq+0x1be/0x2b0
> 
> This happens because the "Performance Counter Global Status Register"
> (PerfCntGlobalStatus) MSR has bit 7 set. Bit 7 should be reserved according
> to the documentation (Figure 13-12 from "AMD64 Architecture Programmer’s
> Manual, Volume 2: System Programming, 24593"[1]

Would it then not make more sense to mask out bit7 before:

+	status &= ~AMD_PMU_V2_GLOBAL_STATUS_RESERVED;
	if (!status)
		goto done;

?

Aside from being reserved, why are these bits magically set all of a
sudden?
