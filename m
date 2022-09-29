Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5405EFD9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiI2TIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiI2TIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:08:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2640914F8FC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/m7cJEPQCo3MdhSQwqZsgFMDCRxk7SKXfVV6nCzeN/A=; b=aeCAcBdB71HzUBakRLvnpxLF40
        RJ4ysUTjgTPXWp9QBc1kstzw1R1avI++Cguo3GbSG1hNf5yVMi8o1kZjcd1TIWR0RlhZf5xaDZPcx
        tYhf9XKEt8Xi700wv3gdns2E5vidbR15Q/aaijTtfOKC+S+bsxxas9hJ0dtrN3fP3xFcbs+bs/94N
        qCWZe7x6uG5NNtH8vAC98bo9w+NjbS9TNaLrBPeFQEAnJNyAMIlJohXJ2vmUu095EScClHs6X8kZL
        HGJXAx4Q0z0n0Ay2u3udSQ/dueNNVwmQqHwHWx+1G+8rP5R/G5ZkzmktvvXIeOAjmeF/+4ckYDNXN
        rxtEyiKQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odytq-00DXIZ-IK; Thu, 29 Sep 2022 19:08:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1176A300110;
        Thu, 29 Sep 2022 21:08:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F00B52BEB5D04; Thu, 29 Sep 2022 21:08:42 +0200 (CEST)
Date:   Thu, 29 Sep 2022 21:08:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <YzXtOi7rjjWI0ea0@hirez.programming.kicks-ass.net>
References: <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
 <YzV5vqoLInptafJm@hirez.programming.kicks-ass.net>
 <20220929152044.GE4196@paulmck-ThinkPad-P17-Gen-1>
 <YzXFWEL52MRp2s5j@hirez.programming.kicks-ass.net>
 <20220929163624.GN4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929163624.GN4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 09:36:24AM -0700, Paul E. McKenney wrote:

> > How has this been tried; and why did the energy cost go up? Is this
> > because the offload thread ends up waking up the CPU we just put to
> > sleep?
> 
> Because doing the additional work consumes energy.  I am not clear on
> exactly what you are asking for here, given the limitations of the tools
> that measure energy consumption.

What additional work? Splicing the cpu pending list onto another list
with or without atomic op barely qualifies for work. The main point is
making sure the pending list isn't in the way of going (deep) idle.

