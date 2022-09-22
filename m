Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FD75E5CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiIVHzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiIVHzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:55:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE078C44B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ia+3n+0s7JzkFZM6g7zJFMXSOuQVq3XhZk+TgJBwLPY=; b=jBDmWQtTwqRlkE+XLQ+/TFlvQN
        44Xp45DXisxganosfPnitmQE9mFxCGkc+2+gaf072rSF79lnrUh86CdfkqmWDjJUYxRwi53PfixdU
        2jfS1/6tkRVh5RdOPx+9C7FJ1d3XOGGZ/CKdTbUnqaRCTm15NMXNlZPgBu4+qhEI49H2ODkgwLuQl
        K90kBiMlwxJuNXYfprJN+9fM9iC7NXGH7UBWa8wrMX8OgIXeonyHIDukAZf30bs7i7IxRp9q1AAcM
        KQciYQbnUlnf8iu06EGIEjSOYNiXzl5idRX7Qchg4ddbcfJoaGTajQFWgoiAviNR0zapv1KDLyKt6
        nfrTn6cA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obH3V-006rJ5-7t; Thu, 22 Sep 2022 07:55:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EA0583001FD;
        Thu, 22 Sep 2022 09:55:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAD14200FBDF3; Thu, 22 Sep 2022 09:55:29 +0200 (CEST)
Date:   Thu, 22 Sep 2022 09:55:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: Use proper do_arch_spin_lock() API
Message-ID: <YywU8U7yD1nvvGlZ@hirez.programming.kicks-ass.net>
References: <20220921132152.1622616-1-longman@redhat.com>
 <20220921132152.1622616-3-longman@redhat.com>
 <20220921181721.3a51afe9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921181721.3a51afe9@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm with Steve on not adding wrappers for this; people that use
arch_spinlock_* get to keep the pieces :-)

On Wed, Sep 21, 2022 at 06:17:21PM -0400, Steven Rostedt wrote:

> > @@ -1819,7 +1819,7 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
> >  		return;
> >  	}
> >  
> > -	arch_spin_lock(&tr->max_lock);
> > +	do_arch_spin_lock(&tr->max_lock);
> 
> Nothing here is needed, as interrupts had better be disabled when this
> function is called. And there's already a:
> 
> 	WARN_ON_ONCE(!irqs_disabled());

You can write that as lockdep_assert_irqs_disabled();
