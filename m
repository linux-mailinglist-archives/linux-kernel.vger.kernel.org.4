Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247255E65A8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiIVOcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiIVOb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:31:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E02F6863
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s+t51A9G5TKAVlX9W9Kx0FTvae9linxMEZpeImRvbaI=; b=D8CB/+yPFbPniJg9eIvlCYqbMu
        EkpsMWif5gp7LArh7MdnvyxFiY084ZJ5bnQ4+LAo3ZU/9XxQ/hDVLO5OZcDq8Cpt9O1uwgkFz0I54
        j78ifkg1LqqekztVknxn19mrmbMIgaLdfOgckbyiD6WP2KadgbI8p/1Oh1L6tdHFW46nZHcR1pGIp
        ww7gg+YVZK2xbDIQ3MpXKUodey/y3g6019d6ZJS4fWzgLM1HHY07I/0luUGwttVIoPiJiNMEH1QdY
        79jBaKkkkQeb7QjVB6CR46DYDEu0bYxCP0X4u2i6TvE1qfiPfuzTLsIMdMsS0Xzt66D5N+HGDiuhW
        78NjJ1Jg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obNF0-0072zN-L7; Thu, 22 Sep 2022 14:31:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A62C5300169;
        Thu, 22 Sep 2022 16:31:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D7302BBFEF19; Thu, 22 Sep 2022 16:31:46 +0200 (CEST)
Date:   Thu, 22 Sep 2022 16:31:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Disable interrupt or preemption before
 acquiring arch_spinlock_t
Message-ID: <Yyxx0jhmN6ZTRYhd@hirez.programming.kicks-ass.net>
References: <20220922133158.1731333-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922133158.1731333-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 09:31:58AM -0400, Waiman Long wrote:
> It was found that some tracing functions in kernel/trace/trace.c acquire
> an arch_spinlock_t with preemption and irqs enabled. An example is the
> tracing_saved_cmdlines_size_read() function which intermittently causes
> a "BUG: using smp_processor_id() in preemptible" warning when the LTP
> read_all_proc test is run.
> 
> That can be problematic in case preemption happens after acquiring the
> lock. Add the necessary preemption or interrupt disabling code in the
> appropriate places before acquiring an arch_spinlock_t.
> 
> The convention here is to disable preemption for trace_cmdline_lock and
> interupt for max_lock.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Waiman Long <longman@redhat.com>

This seems to be missing a Fixes: tag :-)
