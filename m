Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F86748FD8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjGEVcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjGEVcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:32:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2240D1BCB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4aSLSjsOXrHcGMVuRFn80IJVcHXwZzbRbgGO/RYsbxU=; b=ShVGdSCi88bb3fTZeS6G24qea1
        jZXdz0tmD8xVt0TLa54/4BY41sBr8C0fvw4aMSbp/kb+VLCvjOztii4OZ4qQKgH1z8ehAvOhSlOoS
        j1YuGkRQZ+lEU90rH1DFsrmhPAjLddGZ1HsspR/iE0xAruY2zrgThko0SlBkMstCxOf2W0Etikyio
        rGMTOJITT+eSc8qUHi6mrNfL/LFK/swqFo5yMIhTG62Mdx/GTsYvcKgJVjlGllpF7yiiJTZTziFsG
        iKeLrSQJT2j43LwilfSPta9IVNC7h0aUd0dd7JQKd0I0SCw5EuKdukZ2mTbhai9NYOYv37vED+3CP
        IgIij5RA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHA5i-00CGI9-28;
        Wed, 05 Jul 2023 21:31:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E8D030005E;
        Wed,  5 Jul 2023 23:31:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 545712007F0C7; Wed,  5 Jul 2023 23:31:13 +0200 (CEST)
Date:   Wed, 5 Jul 2023 23:31:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM <llvm@lists.linux.dev>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: CONFIG_UBSAN_TRAP #UD error message on x86 [was: Re:
 [CRASH][BISECTED] 6.4.1 crash in boot]
Message-ID: <20230705213113.GC2813335@hirez.programming.kicks-ass.net>
References: <202307022230.6121D6896@keescook>
 <ed3e4315-b149-2f9e-70d4-45d7f83b9922@alu.unizg.hr>
 <202307031149.823F9A3@keescook>
 <202307031606.3FD9D0D@keescook>
 <fbf4103b-6471-1f06-34a8-4aa227f5e091@alu.unizg.hr>
 <3CDD1188-7B2A-4D53-9B8F-C07BC39844E9@kernel.org>
 <19d0e63c-db47-8f02-2f79-0923f675898c@alu.unizg.hr>
 <DA3FEB08-DF39-406B-89CC-9076CFCF597A@kernel.org>
 <CAG48ez0kmSqS_WJ1=neKpxKmMMkPYgNHfBD6ZSif_EWnso84wQ@mail.gmail.com>
 <202307051405.E746464@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307051405.E746464@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 02:08:09PM -0700, Kees Cook wrote:

> > Even just a "WARNING: CONFIG_UBSAN_TRAP active, #UD might be caused by
> > that" on every #UD that does not come from a known BUG() location or
> > such might be better than nothing...
> 
> I've considered it, but usually CONFIG_UBSAN_TRAP isn't accidentally
> set. Also, the crash info is something we can get help from on the
> compiler side, to mark up where the traps are, similar to what we do
> with KCFI, but it hasn't happened yet for x86. For example, arm64
> already encodes the details in the trap instruction itself:
> https://git.kernel.org/linus/25b84002afb9dc9a91a7ea67166879c13ad82422

Right, so you could easily use a different #UD instruction that has an
immediate, something like:

  0f b9 40 ff          ud1    -0x1(%rax),%rax

or even:

  0f b9 80 00 ff ff ff         ud1    -0x100(%rax),%rax

if you need a 32bit value.

It shouldn't be hard to fix up the #UD handler to decode the instruction
and obtain the displacement for a clue.

Typically we use ud2 because it's the smallest #UD instruction (2 bytes)
and that's enough, but if you want to provide additional clues, there's
options...


