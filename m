Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E319617FA1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiKCOda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKCOd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:33:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456721023
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UhKkd6ywANb7xuG1OzsZSFZRIZlWynpywgjyOk4XnEk=; b=BfdjRXu35DSt6nbUHR87k6mqku
        yK0ofUBGJje8k3cOh2g/Z5pykZqh4H695EbOTw1xzMj8p8mqRY+lL1OWxN6eJRXYDeXo/9nzFaBDw
        HX02426ZqOpLIdp2vNTwCHYjw2lr3KMQewUFnGTWhPhS7XP+aPvHndoMqble/ZbacTEUCFRRZa2fB
        j1QhSMLrUAhWUwnNh8j1fwK0kw+vd/eaSQ7USX1LgRO33wm8QnpM7RCn9yhqFOmOt05Y6b7eNRnoS
        uLIJZP+uUONLGE7zEkRKS91XB1/MAKIhTlN7sJ4btDUfkeqZqZP9UlY3S8NygpNUCBlc94V6+xS0R
        /MNxNq8Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqbH9-008hTa-SE; Thu, 03 Nov 2022 14:33:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 139CF300130;
        Thu,  3 Nov 2022 15:32:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F02BA20B250BE; Thu,  3 Nov 2022 15:32:57 +0100 (CET)
Date:   Thu, 3 Nov 2022 15:32:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [PATCH v2] x86/traps: avoid KMSAN bugs originating from
 handle_bug()
Message-ID: <Y2PRGeTIZU3T3IqX@hirez.programming.kicks-ass.net>
References: <20221103134515.1934867-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103134515.1934867-1-glider@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 02:45:15PM +0100, Alexander Potapenko wrote:
> There is a case in exc_invalid_op handler that is executed outside the
> irqentry_enter()/irqentry_exit() region when an UD2 instruction is used
> to encode a call to __warn().
> 
> In that case the `struct pt_regs` passed to the interrupt handler is
> never unpoisoned by KMSAN (this is normally done in irqentry_enter()),
> which leads to false positives inside handle_bug().
> 
> Use kmsan_unpoison_entry_regs() to explicitly unpoison those registers
> before using them.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> Signed-off-by: Alexander Potapenko <glider@google.com>
> 
> ---
> 
> v2:
>  - move the call to kmsan_unpoison_entry_regs() after the
>    instrumentation_begin(), as suggested by Peter Zijlstra

Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
