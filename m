Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603F7628751
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiKNRnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbiKNRnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:43:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F01B7EC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rgYtpYSDeeeAyOKKIz8SA+g2LVtMu4xota226sIvZsU=; b=ijb0Ic36z7dMPDwWHquBnaLGbl
        aWpKRINVkx/ryCemdjmDOWN8qoS6NKy8DRB/juJHjCw7cjpD7aiFbThLvOfJ7XU65URCoeg+HUSO+
        7uI3gEfWNJJy6J0mGSMl5O0T6nDzq/x/wVmojH4CbfKoPFLWw7T0YnSRZjpcmgD1M3UbTi2pNI+TP
        iVXo4LD4n4tH6v80Aj9tYoJ0TNbRSRRYBk2t56eZsJMJ/XmFKZyxnH2hUlTgixLXa6FxK0XrZjKuF
        kRQUDPTHCCZilnkn6bINMxaivt3NiLzSXFfVcmWgawAT6fonsS/0lZNjL85LGrOCQXQUJfaSr2sbd
        iviHvjhQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oudUa-00FcB5-0Q; Mon, 14 Nov 2022 17:43:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48674300137;
        Mon, 14 Nov 2022 16:58:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D1372C0E2A8E; Mon, 14 Nov 2022 16:58:27 +0100 (CET)
Date:   Mon, 14 Nov 2022 16:58:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 12/46] x86/paravirt, lto: Mark native_steal_clock() as
 __visible_on_lto
Message-ID: <Y3Jlo+ZQ/gYDiSdW@hirez.programming.kicks-ass.net>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-13-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114114344.18650-13-jirislaby@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:43:10PM +0100, Jiri Slaby (SUSE) wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Symbols referenced from assembler (either directly or e.f. from
> DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
> they could end up in a different object file than the assembler. This
> can lead to linker errors without this patch.

> @@ -120,7 +120,7 @@ unsigned int paravirt_patch(u8 type, void *insn_buff, unsigned long addr,
>  struct static_key paravirt_steal_enabled;
>  struct static_key paravirt_steal_rq_enabled;
>  
> -static u64 native_steal_clock(int cpu)
> +__visible_on_lto u64 native_steal_clock(int cpu)

More hate; same reason, DEFINE_STATIC_CALL() takes the function address
and stuffs it in a variable, WTF is GCC-LTO eliminating it?
