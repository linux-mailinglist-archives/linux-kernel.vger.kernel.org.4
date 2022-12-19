Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234AD650ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 12:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiLSLk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 06:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiLSLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 06:40:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10950DFF0;
        Mon, 19 Dec 2022 03:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TrE6OgjSAc6yr5fKoh1ygWugQbxZw3+sC738DdV6aBs=; b=EgSr3jN34NYAXGx+nPIm5v37La
        E84qvsefUi81X8zh+jm/xw/1x/c4kqLk266KONS4eb33wxYKeNGT2hy6lXYPSk6PfbEEwUPvtNbOL
        MCIoW3WqIP8NFif865H3/ofASbXe3X7aBJWPg3pUvKDf0d001zYHPEFbTaVB+rCSnxLzS9Gcg/3zl
        0uoJsDhO/BwGPnYXhC8ypaIwHEeIs5gP7+2Q2cRrqhB5/MZDEpE2TF/w28t7kPeRZpfGahKec2wzK
        stOthM7u4SFJoUEEYo7gzuQLCBhbt4xV1H6SBikSCHU0wQOIib7w1ZQg7tEJQrnxchhityLoa3nrq
        vqgGqvZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1p7EUp-00CZF1-31;
        Mon, 19 Dec 2022 11:39:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 953AB300348;
        Mon, 19 Dec 2022 12:39:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A261202FE504; Mon, 19 Dec 2022 12:39:49 +0100 (CET)
Date:   Mon, 19 Dec 2022 12:39:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        tangmeng <tangmeng@uniontech.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Stafford Horne <shorne@gmail.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exit: Use READ_ONCE() for all oops/warn limit reads
Message-ID: <Y6BNhQ2C2huPaOqa@hirez.programming.kicks-ass.net>
References: <20221216203024.never.640-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216203024.never.640-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 12:30:28PM -0800, Kees Cook wrote:
> Use a temporary variable to take full advantage of READ_ONCE() behavior.
> Without this, the report (and even the test) might be out of sync with
> the initial test.
> 
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/lkml/Y5x7GXeluFmZ8E0E@hirez.programming.kicks-ass.net
> Fixes: 9fc9e278a5c0 ("panic: Introduce warn_limit")
> Fixes: d4ccd54d28d3 ("exit: Put an upper limit on how often we can oops")

Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
