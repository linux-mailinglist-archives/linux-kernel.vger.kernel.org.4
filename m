Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709A56C2EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCUKWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCUKWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:22:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A974C17A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D7Ag9nt9cs09xQBTT9eeFcQs2/K2AJPf7XfYfcN6rX0=; b=GTweXrKhSd2lbQOsgNLUS1j/Fk
        az4Au94tDs3OpUi+aKp2ioDcbIMEOMMv4j5pMLH/p6WioTjAy2632jVDAcgAvrXEkiPaTWytZVDtX
        DQsyIgThlwBZ7S+2RoY0Eg7zYabVb0m1s14bPJXpGSGllHw0GqujiDi6JKEj6zKC1KcjvYY0HOZ3L
        8+3KZQYikBgdZFgj/OSIMXcqD5YXLsG3FyztklLc1kLD7l/tR3kcBMjfanBnD5iuAvWOaKbt0mu6Y
        JJU1Hv+N63h3KV0UfbQEe2VNEdrFJA5cXWePkznptPczFSRREuEtz7gNSc67oepybSm+Qn09PjpAQ
        Fkg6Bv2g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peZ8H-004EF0-2M;
        Tue, 21 Mar 2023 10:22:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE3143002FC;
        Tue, 21 Mar 2023 11:22:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C59F2438EBB4; Tue, 21 Mar 2023 11:22:20 +0100 (CET)
Date:   Tue, 21 Mar 2023 11:22:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, jgross@suse.com, mingo@kernel.org,
        corbet@lwn.net
Subject: Re: [PATCH RFC smp] Remove diagnostics and adjust config for CSD
 lock diagnostics
Message-ID: <20230321102220.GH2234901@hirez.programming.kicks-ass.net>
References: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 05:54:39PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series removes CSD-lock diagnostics that were once very useful
> but which have not seen much action since.  It also adjusts Kconfig and
> kernel-boot-parameter setup.
> 
> 1.	locking/csd_lock: Add Kconfig option for csd_debug default.
> 
> 2.	locking/csd_lock: Remove added data from CSD lock debugging.
> 
> 3.	locking/csd_lock: Remove per-CPU data indirection from CSD
> 	lock debugging.
> 
> 4.	kernel/smp: Make csdlock_debug= resettable.
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  Documentation/admin-guide/kernel-parameters.txt   |   17 -
>  b/Documentation/admin-guide/kernel-parameters.txt |    6 
>  b/kernel/smp.c                                    |    2 
>  b/lib/Kconfig.debug                               |    9 
>  kernel/smp.c                                      |  260 ++--------------------
>  5 files changed, 47 insertions(+), 247 deletions(-)

Yay!! How do you want to route these, should I take them through tip?

What about the rest of the thing? Your commits seem to suggest it's
still actually used -- why? Are there still more virt bugs?
