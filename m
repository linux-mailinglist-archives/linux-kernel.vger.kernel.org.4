Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBED15EC34E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiI0Mwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiI0Mwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:52:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F2B1B84
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/aH2gcFAvMkC4dN5ZbxdXmb/yda8CDpfjwcWlpsGSi0=; b=XRjCWqexzatOWCyqh1VtZSDXwE
        GYN5kw85MzU16gIhDn0UJ3FipIMR67bgrEQpYJo9wCv2ypV9gyeXV4CqqzDO50OJ3TBQSfQ43ozjg
        2HXgF0RC1pTIzvdczWrCFS/pLyHW+ZAiiC+71gWDtPNNF6SLhPShYQnRI44mdI5gTYGkwEey1mHkG
        IIhj3jv6M9DDAv0BVZDo1OSIJaFYb+fKitW05fnNDsMnTa4QTu8QtyEPfRBK5+VM7L0BtRbQlChgg
        kpm3SBSzs/VN+0yfTIv3Lx67OpMlx5MjLgQHyB9LqKQd1s3W75tsNWJsaxbnC2hSpK235nkfQ9Q/o
        QAfu4SEw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odA4b-00BRVw-R5; Tue, 27 Sep 2022 12:52:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C432300205;
        Tue, 27 Sep 2022 14:52:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BD5320424F6E; Tue, 27 Sep 2022 14:52:25 +0200 (CEST)
Date:   Tue, 27 Sep 2022 14:52:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 23/23] x86/process: Reset hardware history in context
 switch
Message-ID: <YzLyCD0P7MATFiVM@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-24-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909231205.14009-24-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:12:05PM -0700, Ricardo Neri wrote:

> +void reset_hardware_history(void)
> +{
> +	if (!static_cpu_has(X86_FEATURE_HRESET))
> +		return;
> +
> +	asm volatile("mov %0, %%eax;" __ASM_HRESET "\n" : :
> +		     "r" (hardware_history_features) : "%rax");
> +}

	asm_inline volatile (ALTERNATIVE("", __ASM_HRESET, X86_FEATURE_HRESET)
			     : : "a" (hardware_history_features) : "memory");

