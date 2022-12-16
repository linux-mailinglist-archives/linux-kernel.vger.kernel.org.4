Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A90864E9D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiLPK7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiLPK67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:58:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037AC33C15
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3eOq5AiMFGg2goy12qjl6w/qgwWLFA+6P+xdDc05VDg=; b=gj6LctJbsDl0bxvwVpR4GFykcB
        PsDDPEGfPKINC6swjs1XU/iaGawaqjtncYCoPG9PdN3z+WSK18SFQjFFYWyBJ8OF9/BdWP2m+r6nF
        5M+Phlp8WZ1P9F1tiy/wSxsa9clx//9azr1P9Atwc8d79M+G2pjvJuKTXUq4+KWPYpuUjq4csCyZ4
        Jv28kzR8NgaZTSaTqD05ya89tF3giP8ly85NSbX6Jxe9R0+C4HejB2pHqKhQuIHWTOB+cNpkeyC6l
        EPCoTa8mzeePpl+///dqiqevnOI8mxEhVwWQiTOCG5zAR6wHCG6FDUIe+7oyMX6bWEdH3jqma1ZI5
        leOigtrQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p68QL-00B8KS-BD; Fri, 16 Dec 2022 10:58:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29E7930029B;
        Fri, 16 Dec 2022 11:58:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0761C201D8151; Fri, 16 Dec 2022 11:58:40 +0100 (CET)
Date:   Fri, 16 Dec 2022 11:58:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: callthunks: fix incorrect init section references
Message-ID: <Y5xPXxqJhfXJSIMP@hirez.programming.kicks-ass.net>
References: <20221215164334.968863-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215164334.968863-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:43:23PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The addition of callthunks_translate_call_dest means that
> skip_addr() and patch_dest() can no longer be discarded
> as part of the __init section freeing:
> 
> WARNING: modpost: vmlinux.o: section mismatch in reference: callthunks_translate_call_dest.cold (section: .text.unlikely) -> skip_addr (section: .init.text)
> WARNING: modpost: vmlinux.o: section mismatch in reference: callthunks_translate_call_dest.cold (section: .text.unlikely) -> patch_dest (section: .init.text)
> WARNING: modpost: vmlinux.o: section mismatch in reference: is_callthunk.cold (section: .text.unlikely) -> skip_addr (section: .init.text)
> ERROR: modpost: Section mismatches detected.
> Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
> 
> Fixes: b2e9dfe54be4 ("x86/bpf: Emit call depth accounting if required")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!
