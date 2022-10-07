Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520985F79EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJGOuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJGOuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:50:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00A031DFD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gP7xsO9cyEMHQsua78LuEGfwPbb4ID2j321XcwffKOM=; b=B/TLotH4eJji0kI+mOSPmy2yRb
        yOV58kWH5stlMmmPBi99V0xWo9Yj8slsik9fKWrbJ1Q5xGsl7mLQLUkRBcmy8Bh5hDUMmqv8bEF2J
        /f/sjS2XKvWHkXbVWqoWEzTtxbBRNNVHr2g/G40VtA7jqkKjzyHg073W37qhqwex9UA4UDPMu64U/
        6TXxyPO4AL0OKb6IwXb7S0BeCnyniTIebEPi/XlNF+laU0T5G6vtlxWNoxPKF+fW6+yngHGFbLG8L
        VVZINxPfz73Ak38iiFJq4+R0QGEN7Fl2ZTFwtufKkMmhX8B4yBu8q3ESsPZmHtHXhpx1lvCB74Kgo
        Bz9drnhA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogofq-001U9Z-52; Fri, 07 Oct 2022 14:50:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE7AD30006D;
        Fri,  7 Oct 2022 16:50:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A50392BDA8087; Fri,  7 Oct 2022 16:50:01 +0200 (CEST)
Date:   Fri, 7 Oct 2022 16:50:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Subject: Re: [PATCH 4/6] x86/gsseg: move local_irq_save/restore() into
 asm_load_gs_index()
Message-ID: <Y0A8mWvT0mLm3nVD@hirez.programming.kicks-ass.net>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-5-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006154041.13001-5-xin3.li@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 08:40:39AM -0700, Xin Li wrote:
>  SYM_FUNC_START(asm_load_gs_index)
>  	FRAME_BEGIN
> +	pushf
> +	pop	%rax
> +	andl	$X86_EFLAGS_IF, %eax	/* Interrupts enabled? */
> +	jz	1f
> +	cli
> +1:

Why the pop,andl,jz ? AFAICT our arch_local_irq_save() doesn't even
bother with that, why does this function.
