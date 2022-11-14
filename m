Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDC9628B93
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbiKNVrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiKNVrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:47:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B7019C2A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zR+/p7R1t4TzeOU8mz6hY5ameEwAhb4NtsNQ0xjhUD8=; b=Mt3AqQMklztbdZDjXkrNqtPBk9
        SDLSAmnRuP3roc/lB9QR3Z17g8ZB7hUmskBGsjsKN9jGKj5lhBajd+dQa9cd/2xVhjRp+FfSo+tqA
        PN6nqi8yir6yZpdZLeB3K5KSsXDnDmDAGkK6MLad1T/AGUas3qx9h+3NzTQXtIzOyv5EI2qxeMPHS
        G2YRkENYidG6cdVj4jn9b5s27KItikGHK8/codTaF4LSOUVtLG8a5ITD7zQs212P1jS177dpSNY+U
        6TXR6uG1GHpAYoWHXVB3FHOOW9kvL29Wz6AmuUxwxDFAufrG98+sCK8Wt66NoY3Gcnkr/L9SpCnwr
        TyvLK+1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouhI9-00Fo7J-44; Mon, 14 Nov 2022 21:46:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9EE67300422;
        Mon, 14 Nov 2022 22:46:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BA352C777C44; Mon, 14 Nov 2022 22:46:49 +0100 (CET)
Date:   Mon, 14 Nov 2022 22:46:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 5/5] x86/kasan: Populate shadow for shared chunk of
 the CPU entry area
Message-ID: <Y3K3SVOMvGMteAtd@hirez.programming.kicks-ass.net>
References: <20221110203504.1985010-1-seanjc@google.com>
 <20221110203504.1985010-6-seanjc@google.com>
 <3b7a841d-bbbd-6018-556f-d2414a5f02b2@gmail.com>
 <Y3Ja33LyShqjvmQZ@hirez.programming.kicks-ass.net>
 <Y3KAp+yNQ54IKvTn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3KAp+yNQ54IKvTn@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:53:43PM +0000, Sean Christopherson wrote:

> Wrong one, that's the existing mapping.  To get back to v1:
> 
> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> index af82046348a0..0302491d799d 100644
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -416,8 +416,8 @@ void __init kasan_init(void)
>          * area is randomly placed somewhere in the 512GiB range and mapping
>          * the entire 512GiB range is prohibitively expensive.
>          */
> -       kasan_populate_early_shadow((void *)shadow_cea_begin,
> -                                   (void *)shadow_cea_per_cpu_begin);
> +       kasan_populate_shadow(shadow_cea_begin,
> +                             shadow_cea_per_cpu_begin, 0);
>  
>         kasan_populate_early_shadow((void *)shadow_cea_end,
>                         kasan_mem_to_shadow((void *)__START_KERNEL_map));

OK. It now looks like so:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=x86/mm&id=14ca169feec3cb442ef4d322f8f65ba360f42784

If the robots don't hate on it because I fat fingered it or seomthing
stupid, I'll go push it out tomorrow.
