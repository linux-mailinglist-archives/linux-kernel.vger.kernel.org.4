Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263D4733311
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjFPOFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345817AbjFPOFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:05:15 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D806F3C04;
        Fri, 16 Jun 2023 07:04:57 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-30fcde6a73cso546665f8f.2;
        Fri, 16 Jun 2023 07:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686924233; x=1689516233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lX3qyAy2K9wVkyWquOfum4ksPZ0rfQWIAZiVU0Bgd5A=;
        b=URU/pOUtPm3w80kQuQ4wL6uqCG4NtWX52oeSiLoQWe1lXgGy03pmZQAr4d1giaaXoV
         a4K8OTyTO5ZapmrlZdq7TdWsO6EjiDzzmBNgVwv9m4osakkIXfSEJU2as0Jl+FO8j5RK
         9S/yHFHtCMaWCwDd2bQgib4cpSZlKIl76h5ZSZYbLLlCVDOjHKleul31J71GOQhsnwN7
         UMC2cbN9+8Lf8C1V4Bn6I0cwj5J27ZgpHRmldAw002ESHzW/90VZC+nkxJgSg//iZKSI
         tgDb0ZCJK6plDKAtelnQU+tj7B9zhE8HSt6wWBcFjuCxLEVly0j/wJBluci2IBuTctGs
         VluQ==
X-Gm-Message-State: AC+VfDzzX9YeM93NRq7NB6UpNz5H9kOEHM22T6Bhrr7Xi1QyP7XaXMvC
        6IIWgoeJT5j4s6pLN/tYHMM=
X-Google-Smtp-Source: ACHHUZ4BnvfwehA3ZVZrfqKrDxQBPRbv2M+9xY6ZO0Tf+/o2GmgCglvedHRXxLB6+z2/J1tve1a3kQ==
X-Received: by 2002:adf:e8c8:0:b0:30a:e9a9:a4e4 with SMTP id k8-20020adfe8c8000000b0030ae9a9a4e4mr1430634wrn.51.1686924233019;
        Fri, 16 Jun 2023 07:03:53 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-014.fbsv.net. [2a03:2880:31ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id n11-20020adfe78b000000b0030fc666686bsm12802150wrm.85.2023.06.16.07.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 07:03:52 -0700 (PDT)
Date:   Fri, 16 Jun 2023 07:03:50 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <ZIxrxpYtffT0FtEx@gmail.com>
References: <20230616115316.3652155-1-leitao@debian.org>
 <20230616132954.GG4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230616132954.GG4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 03:29:54PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 16, 2023 at 04:53:15AM -0700, Breno Leitao wrote:
> > On some systems, the Performance Counter Global Status Register is
> > coming with reserved bits set, which causes the system to be unusable
> > if a simple `perf top` runs. The system hits the WARN() thousands times
> > while perf runs.
> > 
> > WARNING: CPU: 18 PID: 20608 at arch/x86/events/amd/core.c:944 amd_pmu_v2_handle_irq+0x1be/0x2b0
> > 
> > This happens because the "Performance Counter Global Status Register"
> > (PerfCntGlobalStatus) MSR has bit 7 set. Bit 7 should be reserved according
> > to the documentation (Figure 13-12 from "AMD64 Architecture Programmer’s
> > Manual, Volume 2: System Programming, 24593"[1]
> 
> Would it then not make more sense to mask out bit7 before:

It is more than bit 7. This is the register structure according to the document
above:

Bits 		Mnemonic		Description		 		Access type
63:60	        Reserved RO
59 		PMCF			Performance Counter Freeze		RO
58 		LBRSF			Last Branch Record Stack Freeze 	RO
57:6 		Reserved				 			RO
5:0 		CNT_OF 			Counter overflow for PerfCnt[5:0] 	RO

In the code, bit GLOBAL_STATUS_LBRS_FROZEN is handled and cleared before
we reach my changes

That said, your approach is almost similar to what I did, and I will be happy
to change in order to make the code clearer.

> +	status &= ~AMD_PMU_V2_GLOBAL_STATUS_RESERVED;
> 	if (!status)
> 		goto done;
> 
> ?
> 
> Aside from being reserved, why are these bits magically set all of a
> sudden?

That is probably a question to AMD.

