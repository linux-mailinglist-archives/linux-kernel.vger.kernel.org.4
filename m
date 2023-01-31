Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0059A682B06
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjAaLA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjAaLAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:00:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB1D47EF9;
        Tue, 31 Jan 2023 03:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zjviUSUPr5M8hEPUfDl2kMa5y6J74xGv1mMvHMYGeQU=; b=u3V83LfwHGcN3YHWzUJSjDkE4W
        Rjp+BcNBTwC2wF1ciJukeW5Ghiv6xb57TSa3joTm1KuD6wdMZePGwdRqL/Qj3PC72oNM6VWY4oPbZ
        PPPFvGDFPmFbLwHNAxIhXNAefNDVw5afGB5qFZF6En/nPS6noPNPpOom+yz4nuvog5SdI0OmiDM91
        DjdqCRajfOTnBEKABuQXka+KnKpY4g73CyMC3od5EqU/wQhhJdh6ECbuIunzr3LXwgFUoh/brpEvB
        YHNYRigFClK7uQcJOWxO876TQv+sqFIRJhiD4I0Hu0/RZDPDwP8b1H0cgMFAcbpinmz2MTrVZNvoE
        R4EsFuKw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMoMP-00BFNS-Hw; Tue, 31 Jan 2023 10:59:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9924130012F;
        Tue, 31 Jan 2023 11:59:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80E98240A5DF8; Tue, 31 Jan 2023 11:59:31 +0100 (CET)
Date:   Tue, 31 Jan 2023 11:59:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH] perf/x86: KVM: Disable vPMU support on hybrid CPUs (host
 PMUs)
Message-ID: <Y9j0kwYiqYdQpx28@hirez.programming.kicks-ass.net>
References: <20230120004051.2043777-1-seanjc@google.com>
 <1dec071d-c010-cd89-9e58-d643e71e775c@linux.intel.com>
 <Y8rQJf3ki8a1aRjW@google.com>
 <50e840ea-ce9c-9290-2187-d3ff0d9a6709@linux.intel.com>
 <Y8r604tRexxWlF8F@google.com>
 <e161b7c0-f0be-23c8-9a25-002260c2a085@linux.intel.com>
 <67facb87-f835-abcd-3d1b-527531b26e52@linux.intel.com>
 <8eda340a-8c5d-a801-54eb-501c44a68d89@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eda340a-8c5d-a801-54eb-501c44a68d89@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 10:31:00AM -0500, Liang, Kan wrote:

> Yes, and also the CPUID leaf 0x23H support to enumerate the PMU features
> of each types.

Note that this is not enough or even useful. There is nothing that stops
a vCPU from migrating between types at every instruction. There simply
is no relation between a vCPU and a type, so knowing what a type does or
does not support is useless information.
