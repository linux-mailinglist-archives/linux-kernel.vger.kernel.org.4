Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B16664041
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbjAJMSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbjAJMRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:17:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8FA13F22;
        Tue, 10 Jan 2023 04:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SiB2jRQGUlHVDHAXVwUG4UEQzd7YZBKTamCddpXoI7o=; b=s4jD6ZVSelwNJ7L77pLFTzvSeh
        rpZ0+4jaSu1/X2hHix2GAsp5Ji1z3tc753NtUx6us6IiIbXz7nxtGTak/Rly+70aJnAm3XwdpKD0J
        xPO9btBtYpUgLiZOC2cCxn4gYApF6WplgURAM2ZkrxvCQIZPePlqKSjkq3hHl/pxCjxl2U9R88Nhx
        OJI2XDwbOrfdeR6VZvoEDujCLecL72peihwUpb4MASpXN7PPo/jyDI1/k1rDJhVhszZdDv41OZ3yZ
        5oJoSH9pn1MahVU+Kjwyuflf6gNNePm6z+0D3l8acoUK27slQJOYt592Gjre4TdVuQia9tYig4G0N
        lqUkKA7w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFDYR-003Bw4-GX; Tue, 10 Jan 2023 12:16:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7CB29300033;
        Tue, 10 Jan 2023 13:16:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F5252C539E1C; Tue, 10 Jan 2023 13:16:21 +0100 (CET)
Date:   Tue, 10 Jan 2023 13:16:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <Y71XFYhST36FvYpz@hirez.programming.kicks-ass.net>
References: <20230106142743.30759-1-mgorman@techsingularity.net>
 <Y7wxjBN9bDaZ0BKo@hirez.programming.kicks-ass.net>
 <20230110120447.q7jtsk6i6lyu4wv5@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110120447.q7jtsk6i6lyu4wv5@techsingularity.net>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 12:04:47PM +0000, Mel Gorman wrote:

> Story of our lives. Is https://www.cs.unc.edu/~anderson/papers/ecrts09b.pdf
> the right paper to start with? (just a quick search, haven't actually
> read it)

The paper I (re)read was: https://cs.unc.edu/~anderson/papers/rtsj10-for-web.pdf

Same people though, so might be closely related.

