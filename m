Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB436033F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJRUbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJRUay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:30:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A285E559
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n0CSh5tVQ5N3FkcSMwrTMYelDmAJEeswdTr0UOVkxZ4=; b=gR9cb+pyk1f1dAOjUsj8C1OLTc
        QZOdFr2/SSRiZA7RnFHyrBBlsPC0nN/OUcfGK1kAUSE/ZWrTZRND+/oYoLxI/S2s4jnAFUyvZeRr1
        QoQEzPCX0UNp8A1iBULKorYHOvnhoJMnm4OKbSC+DJF2P/ff9AAOx2pkEcTb4lWpvS5e9JSRaH1bk
        k8qjfiRA+fH37e9hz77t1srQb2WROjSpGvKI2skt3gq1+n6Of9kxjXHnTVmdQg/uLGPuyfgdm+Vlb
        l23K5w4MsKc68KUJTjfDo5usVsGcQsjBf5tNqojH2JX6eXEAYV7oTexWQLg7RmEPtO5cx856lAomJ
        y4+ol4tQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oktEO-00B0At-Vi; Tue, 18 Oct 2022 20:30:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DBE833000DD;
        Tue, 18 Oct 2022 22:30:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAC3A28574ADE; Tue, 18 Oct 2022 22:30:27 +0200 (CEST)
Date:   Tue, 18 Oct 2022 22:30:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <Y08M4+GxoqvuZ+bq@hirez.programming.kicks-ass.net>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08H8zJ5lQ62jel5@hirez.programming.kicks-ass.net>
 <c561dd8ec384bfc77998a6db6ed824e7@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c561dd8ec384bfc77998a6db6ed824e7@overdrivepizza.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:17:28PM -0700, Joao Moreira wrote:
> > 
> > > Tangent: why are these nop instead of 0xcc? These bytes aren't
> > > executed
> > > ever are they?
> > 
> > Because that's what the compiler gets us through
> > -fpatchable-function-entry.
> 
> Is it useful to get the compiler to emit 0xcc with
> -fpatchable-function-entry under any circumstance? I can probably change
> that quickly if needed/useful.

Having it emit 0xcc for the bytes in front of the symbol might be
interesting. It would mean a few kernel changes, but nothing too hard.

That is, -fpatchable-function-entry=N,M gets us N-M bytes in at the
start of the symbol and M bytes in front of it. The N-M bytes at the
start of the function *are* executed and should obviously not become
0xcc (GCC keeps them 0x90 while LLVM makes them large NOPs).
