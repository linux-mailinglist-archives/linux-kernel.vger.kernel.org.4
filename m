Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEA474E7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGKHFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGKHFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:05:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43069B1;
        Tue, 11 Jul 2023 00:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QxgzYpZE009pZG+5bv71DNHRjYXXCX5nQ2jB455OlTc=; b=KkS4HDn/L3XGdv1EwoWxDUk2Fw
        iP1cBEG34Vl0vbZT04PUSF2oYwW8RPTmQoZ+LAHJdVXESzN1Dt516DZQdomIzwMsqVnIJ6igVM6O3
        QrHNKmSa0DADCaFDaVTVbPaQEv5A1z5wlRXMa9eJcjALdnbV9RKDTA/vQNeBpXAQ08YvlUephkT9+
        LYRbFge7PZ79YyJPo8DpOdU2aUbDOzYDD+wm92n6C3d0QXD+JQbbwj4ZAW6BR2XNArWrDWwJN7H/r
        N8ajlWiAjutymdTnzdAmN8vx3ES1pkJ3fkmkSoE3JXFDnLyWbnpBNvYWwi+dokRJ2q0vHdk/215Lr
        KArSiCNw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJ7QU-00FUQg-QA; Tue, 11 Jul 2023 07:04:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B339F30014A;
        Tue, 11 Jul 2023 09:04:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89CD1240EBDA9; Tue, 11 Jul 2023 09:04:45 +0200 (CEST)
Date:   Tue, 11 Jul 2023 09:04:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] x86/kprobes: Prohibit probing on compiler
 generated CFI checking code
Message-ID: <20230711070445.GB3062772@hirez.programming.kicks-ass.net>
References: <168899125356.80889.17967397360941194229.stgit@devnote2>
 <168899127520.80889.15418363018799407058.stgit@devnote2>
 <20230710161643.GB3040258@hirez.programming.kicks-ass.net>
 <20230711085837.fac80c964ea7667cb75bd6e5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711085837.fac80c964ea7667cb75bd6e5@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 08:58:37AM +0900, Masami Hiramatsu wrote:

> Oh, is FineIBT different from kCFI? I thought those are same. But anyway
> for kCFI=y && FineIBT=n case, I think this code still needed.

Yeah, FineIBT relies on kCFI and IBT (and selects CALL_PADDING) and
dynamically re-writes the kCFI infrastructure.

All the gory details are in arch/x86/kernel/alternative.c, search for
CONFIG_FINEIBT, I've tried to write a big comment, but please let me
know if something isn't clear and I'll write some actual words :-).

But basically kCFI is a pure software solution and does the check before
the indirect control transfer (it has to). While FineIBT relies on the
IBT hardware in order to do the check after.

As such, FineIBT can do the CFI check without memory loads, which is
good for performance. Another useful property of FineIBT is that it is a
speculation barrier.

