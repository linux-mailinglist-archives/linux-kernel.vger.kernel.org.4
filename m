Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47395627D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiKNMA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbiKNMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:00:31 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AAB2314F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=40sIaQoouB2fCw1UV23MMK398vTaLFekQy3cMh9yWEc=; b=V1U0mMHUMgCCjfQiCYUjVFoJDF
        0c3FRqeusDxJH4NOg8xKE/8WCTTfrnayLFRExJKCm20UHrhLaDOKC79QvY/ahdwSbtwlgqBAfpMKp
        grqlriwXAjSU1M4dVOJPOWS8wpGxk9qq1aDUxToKphydspuSRx7OmpnJGF3mO8W6VEkQjSfaLsWBn
        77eqmHFgYAU1aU980U8wFGnmKK77y+o3GgJbuOcDaLwkzHZLD31FL2YRxW/GTx1XHsuSnIpKvkjuW
        vynMIcvC3VhTkYBD1D1Qku3NLPaLPRTxFqiXjzhSSi+dHCMGOFhevyW5M7F+big6yawNOdnVUGRTA
        HOV8kRfg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouY67-000p0Y-E8; Mon, 14 Nov 2022 11:57:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 568CF300392;
        Mon, 14 Nov 2022 12:57:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3AF792C809EA6; Mon, 14 Nov 2022 12:57:54 +0100 (CET)
Date:   Mon, 14 Nov 2022 12:57:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 0/5] x86/kasan: Bug fixes for recent CEA changes
Message-ID: <Y3ItQm4Q+zvsT9eD@hirez.programming.kicks-ass.net>
References: <20221110203504.1985010-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110203504.1985010-1-seanjc@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 08:34:59PM +0000, Sean Christopherson wrote:
> Three fixes for the recent changes to how KASAN populates shadows for
> the per-CPU portion of the CPU entry areas.  The v1 versions were posted
> independently as I kept root causing issues after posting individual fixes.
> 
> v2:
>   - Map the entire per-CPU area in one shot. [Andrey]
>   - Use the "early", i.e. read-only, variant to populate the shadow for
>     the shared portion (read-only IDT mapping) of the CEA. [Andrey]
> 
> v1:
>   - https://lore.kernel.org/all/20221104212433.1339826-1-seanjc@google.com
>   - https://lore.kernel.org/all/20221104220053.1702977-1-seanjc@google.com
>   - https://lore.kernel.org/all/20221104183247.834988-1-seanjc@google.com
> 
> Sean Christopherson (5):
>   x86/mm: Recompute physical address for every page of per-CPU CEA
>     mapping
>   x86/mm: Populate KASAN shadow for entire per-CPU range of CPU entry
>     area
>   x86/kasan: Rename local CPU_ENTRY_AREA variables to shorten names
>   x86/kasan: Add helpers to align shadow addresses up and down
>   x86/kasan: Populate shadow for shared chunk of the CPU entry area
> 
>  arch/x86/mm/cpu_entry_area.c | 10 +++-----
>  arch/x86/mm/kasan_init_64.c  | 50 +++++++++++++++++++++++-------------
>  2 files changed, 36 insertions(+), 24 deletions(-)

Thanks for cleaning up that mess!
