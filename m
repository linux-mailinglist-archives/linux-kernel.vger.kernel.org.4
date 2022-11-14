Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9739628743
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiKNRit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKNRin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:38:43 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D1517884
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8PlpYY+vP5Rrdd5T8dnq/iP+uWZYn4QdrChaBtGnOwA=; b=miXVHeb/tDvgc2f3bbWKa3qSBw
        hb9clp+orzrLwvVDwT1zCzIwSN7ELjEs1MvF7A/1hCAI8k7NV4/hUcstsFjFd/J8n7sTW0DrxImUK
        FO2qz4IiPdT1fb4rEMkwBI6pIb4vCnMNAa5OGsrLM6izXP5p3231+SCo9hqIBwZTbZ/+zgeHVj7cV
        L3RznL/HQetsxmSlctAU3GRgONUDja1HPjbNCXQ2sThj9iHwS9Nh6buaCm5U0+Os3ZbhJkFhpCanD
        j8YNwVAOwULa0iybp4kjv6dfU27QAkDoKU4ps6FbpOmGKJ80BbeLZul3Wzk2KdDoYVoN+ZNw9AwAv
        s8cqlkSA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oudPe-000qQm-4l; Mon, 14 Nov 2022 17:38:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C67A3010E0;
        Mon, 14 Nov 2022 16:12:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 213952C0713BB; Mon, 14 Nov 2022 16:12:31 +0100 (CET)
Date:   Mon, 14 Nov 2022 16:12:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
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
Message-ID: <Y3Ja33LyShqjvmQZ@hirez.programming.kicks-ass.net>
References: <20221110203504.1985010-1-seanjc@google.com>
 <20221110203504.1985010-6-seanjc@google.com>
 <3b7a841d-bbbd-6018-556f-d2414a5f02b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b7a841d-bbbd-6018-556f-d2414a5f02b2@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:44:00PM +0300, Andrey Ryabinin wrote:
> Going back kasan_populate_shadow() seems like safer and easier choice.
> The only disadvantage of it that we might waste 1 page, which is not
> much compared to the KASAN memory overhead.

So the below delta?

---
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -388,7 +388,7 @@ void __init kasan_init(void)
 	shadow_cea_end = kasan_mem_to_shadow_align_up(CPU_ENTRY_AREA_BASE +
 						      CPU_ENTRY_AREA_MAP_SIZE);
 
-	kasan_populate_early_shadow(
+	kasan_populate_shadow(
 		kasan_mem_to_shadow((void *)PAGE_OFFSET + MAXMEM),
 		kasan_mem_to_shadow((void *)VMALLOC_START));
 
