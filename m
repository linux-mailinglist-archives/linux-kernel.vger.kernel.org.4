Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD5260DBBD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiJZHDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiJZHDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:03:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3526840BC0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i6NKTP6esT+t2iJ1Gjt0oCdk9A4YcTe2NsQr3WhUXgM=; b=gnOSiIczXNlo7+3hXx+XZqyqYo
        +Z/FkjjS42jlzj6LYZkzv88gpdRrOfUuOkRnNW6gJzJPSgqP+KxM9A7Z6T8HYt8sDuGdF6yxDMxTL
        rGuuHUy9PLeQzEVgNwCdYz3uQQdLR/HSkrB72voarGCLnIrMfB+TMzsPe+5rPs+PXiL2Nl+WGnC/l
        zzmDf5UlZR9bgjSYskHhU/AiuMXIKkmIYtScRI5qv+03tg7sdIHQY9w3WGIRiId2mu2pi5QrvsynL
        YJzOGG8bVKZtdhuD52jtzyFIWtyeduUegiDc03QLCW3vay0cX5lMP+2Z/yOvupsjZhgiOO4k3y4Z7
        bTbhRJtw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onaR7-006WF4-C3; Wed, 26 Oct 2022 07:02:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D414A30010B;
        Wed, 26 Oct 2022 09:02:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B88222C259E92; Wed, 26 Oct 2022 09:02:47 +0200 (CEST)
Date:   Wed, 26 Oct 2022 09:02:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     torvalds@linux-foundation.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
Subject: Re: [PATCH 4/5] x86/ftrace: Remove SYSTEM_BOOTING exceptions
Message-ID: <Y1jbl8SQ9EQ/Cw/a@hirez.programming.kicks-ass.net>
References: <20221025200656.951281799@infradead.org>
 <20221025201057.945960823@infradead.org>
 <20221025165956.415d82d9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025165956.415d82d9@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 04:59:56PM -0400, Steven Rostedt wrote:
> On Tue, 25 Oct 2022 22:07:00 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Now that text_poke is available before ftrace, remove the
> > SYSTEM_BOOTING exceptions.
> > 
> > Specifically, this cures a W+X case during boot.
> 
> We have W+X all over the place (the entire kernel text). And I don't think
> we really want this.
> 
> This will slow down boots in general, as it will cause all static_branches
> to use this memory page logic. And I don't think we really want to do
> that at boot up when we don't need to.

Both static_call and jump_label explicitly call text_poke_early() when
appropriate.

> I would change this to:
> 
> 	if (unlikely(system_state == SYSTEM_BOOTING) &&
> 	    core_kernel_text((unsigned long)addr)) {
> 
> This way we still do memcpy() on all core kernel text which is still
> writable. It was the ftrace allocated trampoline that caused issues, not
> the locations that were being updated.

I would suggest changing ftrace to call text_poke_early() when
appropriate if it matters (it already does a little of that); doing a
boot test with and without my patch 4 on shows no noticable overhead
over being horribly slow either way.
