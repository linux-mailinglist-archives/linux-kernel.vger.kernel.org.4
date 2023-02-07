Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C02468DD97
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjBGQF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjBGQFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:05:55 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABAD8A5B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X9evdcCRi7hQXB+v8Vh+uJ+CpvpoHB4pM70ZbYL6bHE=; b=Pfj8ImwXkvgkhiBGpPicqtNPE4
        /40HSUFII6++X/dU3ZK3CnLH4/mq/XoXrVgoaYJYh5h2xosS0wBwb70WNfMQJ37kZC89Hq39sk3kI
        E4hdZQsWp6fArVoZ2zdqiva/bbnlIW+7Wtzxevj6bG0w8ox20fxQyg3q/T2ymbdNx/uihIHEelw64
        XS4XaLWbY9BYxACNtikSQD1zisAVyvBj1Unfiqc6kkWhTWg0pnwosUjQEBg+3fV4LOnzFFW0Dfk2f
        xewSuGsM/bjF/Z8oEnLSmUO6LbhIVSFQTI4vbrJA/vtuj30CCCTXieXjHVhNJdhmUSMK0DNInPeXB
        zVLfuWvA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPQSh-006vBD-1m;
        Tue, 07 Feb 2023 16:04:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B9BB300137;
        Tue,  7 Feb 2023 17:05:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B66220AF917C; Tue,  7 Feb 2023 17:05:27 +0100 (CET)
Date:   Tue, 7 Feb 2023 17:05:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/alternative: Support relocations in alternatives
Message-ID: <Y+J2x5sPU0uL8bE0@hirez.programming.kicks-ass.net>
References: <Y+EXQlGSI9WUU8nn@hirez.programming.kicks-ass.net>
 <20230207113813.rqwpuaung2hr433q@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207113813.rqwpuaung2hr433q@box.shutemov.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 02:38:13PM +0300, Kirill A. Shutemov wrote:
> > +static void __init_or_module noinline
> > +apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
> > +{
> > +	for (int next, i = 0; i < len; len = next) {
> 
> 'len = next'? I guess it suppose to be 'i = next', right? Otherwise it
> hangs for me.
> 

Yeah, last minute changes and not testing :/ Sorry about that. I'll try
and post an actually tested patch later today.

Also, Masami, how difficuly would it be to do insn_is_nop() that matches
most/all conventional NOP instructions?

That might make it more convenient to write a more generic
optimize_nops_range() -- it currently needs a single byte nop range and
one of the bugs in the patch as posted is caused by a multi-byte nop
(specifically a 0x66 prefixed 0x90).
