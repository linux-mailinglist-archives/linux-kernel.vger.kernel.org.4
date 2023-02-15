Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2070B697A22
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjBOKpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjBOKpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:45:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5993065AC;
        Wed, 15 Feb 2023 02:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+VcSXjQcwN7qvQ16idt+kCzDltRjU1KCRBCzhS3aUVs=; b=Gec6wQWXs1cShlEObFN3algpx3
        AjRiW+nWaD40LEx8ys6wHCqem48xafMPvzf/TcUSxrdrikX7BgYwA+Sdflt+flEw49Z/3ev67CGVk
        TccS8f8TZ50N8DFjapDYCufTCQeiz8AAZiAPTecAgWRZQ92iSH0SJBr5PyNDmjNrBqf+C6kj4bAjZ
        SHI2CvRne3OL/4BilJuQV/ONGAuvsi+VCrxpIrOWulYxVrn0hP4FeHthEQEaMLkPFye8c7WNpQfn9
        +DoCscxOlxVQLgwNS1gNiRrdaGrn3tRNkWfOrNDFa12G9JiyU4rrN0quOMCcx0zqHcRR5z7KxyLKF
        R80s2Omg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pSFGv-009uuQ-34;
        Wed, 15 Feb 2023 10:45:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5776B3001E5;
        Wed, 15 Feb 2023 11:45:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E0F323884781; Wed, 15 Feb 2023 11:45:03 +0100 (CET)
Date:   Wed, 15 Feb 2023 11:45:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Coly Li <colyli@suse.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+y3r8Q5GT+oJsvd@hirez.programming.kicks-ass.net>
References: <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+oBveWO2z6xdTW/@hirez.programming.kicks-ass.net>
 <Y+pWhyFJeE93nlWd@rowland.harvard.edu>
 <Y+plfZnEqw6mG+XH@hirez.programming.kicks-ass.net>
 <Y+rpD7QPheQQ8Lxj@boqun-archlinux>
 <Y+tm59SmBEY1Ywq7@hirez.programming.kicks-ass.net>
 <Y+u1RBMMcCkvKISZ@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+u1RBMMcCkvKISZ@boqun-archlinux>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 08:22:28AM -0800, Boqun Feng wrote:

> Ah, right, I was missing the fact that it works with 2 classes...
> 
> But I think with only one class, the nest_lock() still works, right?
> In other words, if P and Cn are the same lock class in your example.

I don't think so, but I don't think I've carefully considered that case.

> Also seems I gave a wrong answer to Alan, just to clarify, the following
> is not a deadlock to lockdep:
> 
> T1:
> 	mutex_lock(P)
> 	mutex_lock_next_lock(C1, P)
> 	mutex_lock_next_lock(C2, P)
> 	mutex_lock(B)
> 
> T2:
> 	mutex_lock(P)
> 	mutex_lock(B)
> 	mutex_lock_next_lock(C1, P)
> 	mutex_lock_next_lock(C2, P)
> 

This should in fact complain about a CB-BC deadlock, (but I've not
tested it, just going on memories of how I implemented it).

> Because of any pair of
> 
> 	mutex_lock(L);
> 	... // other locks maybe
> 	mutex_lock_nest_lock(M, L);
> 
> lockdep will not add M into the dependency graph, since it's nested and
> should be serialized by L.

We do enter M into the dependency graph, but instead ignore M-M
recursion. Specifically so that we might catch the above deadlock vs B.
