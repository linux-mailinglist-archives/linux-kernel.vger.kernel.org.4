Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57240665D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbjAKOQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbjAKOQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:16:08 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6301B7FC;
        Wed, 11 Jan 2023 06:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=13MEdz4iJ2vVIT4qZus8tp4KQdEvpmtZcNgcvXYg/50=; b=q0Un1ViVqDfyyC7buQJ07rIqiv
        geVf1FTDEIhq4vUURyUkBDlR3Mxa5uoQebA3cfEMpIfUIwm3p9/O+UW7hu5oS4OMF0lXeRT/wo1CA
        JNJqS2ARU35yr+kKdoXSh6EytPa0KfE1txGfG9ADArHwPM5YlwcKZ/Q62vcmr1xQnU7fvxiE2j/oh
        KkqjhAkiRch2wzOJ1/lTsKcSD0zA9z3dvEWwVX68ux88Rm/7vI8CEmKUvSnJBEJtvpR6fxOp5aL8z
        //TmY1nYmzCyz6qgtoaaq35eYO+5IbWKDw+R+5z4ktyGmABzb0qUznZbJ5hjYdgs/K+7Dh1TjU/y7
        wJRvLlAA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pFbt7-003hbQ-1c;
        Wed, 11 Jan 2023 14:15:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2BB9A300129;
        Wed, 11 Jan 2023 15:15:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14DED2CA1DB41; Wed, 11 Jan 2023 15:15:40 +0100 (CET)
Date:   Wed, 11 Jan 2023 15:15:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
Subject: Re: [RFC PATCH tip] rseq: Fix: Increase AT_VECTOR_SIZE_BASE to match
 rseq auxvec entries
Message-ID: <Y77Ei4/WIT4ARQQj@hirez.programming.kicks-ass.net>
References: <20230104192054.34046-1-mathieu.desnoyers@efficios.com>
 <Y7XSWdLZqwEXWXml@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7XSWdLZqwEXWXml@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 12:24:09PM -0700, Nathan Chancellor wrote:
> On Wed, Jan 04, 2023 at 02:20:54PM -0500, Mathieu Desnoyers wrote:
> > Two new auxiliary vector entries are introduced for rseq without
> > matching increment of the AT_VECTOR_SIZE_BASE, which causes failures
> > with CONFIG_HARDENED_USERCOPY=y.
> > 
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Link: https://lore.kernel.org/r/Y7XJKZhuU9VJZQ11@dev-arch.thelio-3990X
> > Fixes: 317c8194e6ae ("rseq: Introduce feature size and alignment ELF auxiliary vector entries")
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> This resolves the boot failure with the configuration I tested:
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Thanks!
