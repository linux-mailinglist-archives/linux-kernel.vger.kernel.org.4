Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC2A6EB7F2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 10:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDVIIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 04:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVIIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 04:08:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0BB1981
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ouu/rInpyYocF7+zLk5w+0lcXJWjye0/kyUDNTc5/o8=; b=KQp7XJd9UfTct6nM2xsUx27N9n
        hNGicymfEJ9TLaE+DsW8kzjg/ecz7lQF1cOl0c306RzxFoC6gnQfIzW/4jSSXjJyMV4QAwLIyRXF0
        uwuuuqn30iNGPqgdhsVPw5z9yZqhUbJdyZs2VoTPTlYdI7op8R2jBCRF3Lk3AR4NJHeLKmCJ9H64k
        xku2dNrcWuIJS7lA/NUsYsU/UOnRDLRo7SR+ma13zP9ou2fFHXdIdY5C+aSw+nHJt+jqEsj1B6/Ik
        TRuSP/ehfmBMZAaYwto3O7fK+MyeyXW1FDhoBC+yuhaXo7YDn/fmHlTlv+yYK1750f8Rn8qJjFWfx
        6MUViHyw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pq8I4-00G49A-Hg; Sat, 22 Apr 2023 08:08:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6998D30035C;
        Sat, 22 Apr 2023 10:08:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 250F523BD94AA; Sat, 22 Apr 2023 10:08:14 +0200 (CEST)
Date:   Sat, 22 Apr 2023 10:08:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
Message-ID: <20230422080814.GA1214746@hirez.programming.kicks-ass.net>
References: <ZEKDZEQmKExv0O7Q@lothringen>
 <20230421142446.GA1185829@hirez.programming.kicks-ass.net>
 <ZEK+IeTYsauHLozy@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEK+IeTYsauHLozy@lothringen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 06:47:29PM +0200, Frederic Weisbecker wrote:

> > *HOWEVER*
> > 
> > intel_idle_irq() is affected -- except that we only (normally) use that
> > for very shallow idle states and it won't interact with NOHZ (because we
> > only disable the tick for deep idle states).
> 
> Well I don't know, that doesn't look comfortable... :)
> 
> Also why does it need to enable IRQs if ecx=1 ?

Supposedly this is some interrupt latency hack. See commit:

  c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")

