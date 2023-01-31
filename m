Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55167682669
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjAaIdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjAaIdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:33:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BDABBB5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ANSSQvXLkAdB5vLFBiWOsNzzD5+Ok+WeTzqp79+9obU=; b=gThzmfIRxolj0u9xAVBDjK9jFn
        Lf8J7skNxuA0lPWxaZraA0WTyGXxau82RSlqm2UlTnsBpkuUGzROFlpq2aIICIhpyYD46OC7qbsgt
        Le6nsHRmWiJXUxNo9TtdaGH8JV++gjkOGIzGa38i1AW6uuIS6Jub+Npn9bm9SG/cUG1PiNkDSoaN8
        zGI+VwsbfP3qurvij4w9J0Zqs97JBiTWOMhMKoa8kpocACi/AM/JwcCvInj7GPGEyat0zS+3f0ZgO
        YioYV0h8PSaqHEdIMZ93dBe05FPi9Wu33lnaQLFFNfu9vyOIj32Oj81rsqOunDog1M1s65HJVoyOw
        pr8054og==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMm4F-00B9KN-32; Tue, 31 Jan 2023 08:32:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CEB903002BF;
        Tue, 31 Jan 2023 09:32:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABF1B2083586E; Tue, 31 Jan 2023 09:32:37 +0100 (CET)
Date:   Tue, 31 Jan 2023 09:32:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] x86/tdx: Do not corrupt frame-pointer in
 __tdx_hypercall()
Message-ID: <Y9jSJUwNlXSpV3uM@hirez.programming.kicks-ass.net>
References: <20230130135354.27674-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130135354.27674-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 04:53:54PM +0300, Kirill A. Shutemov wrote:
> If compiled with CONFIG_FRAME_POINTER=y, objtool in not happy that
> __tdx_hypercall() messes up RBP.
> 
>   objtool: __tdx_hypercall+0x7f: return with modified stack frame
> 
> Rework the function to store TDX_HCALL_ flags on stack instead of RBP.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: c30c4b2555ba ("x86/tdx: Refactor __tdx_hypercall() to allow pass down more arguments")
> Link: https://lore.kernel.org/all/202301290255.buUBs99R-lkp@intel.com
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
> 
> The patch is against tip/x86/tdx. tip/sched/core removes
> TDX_HCALL_ISSUE_STI. The trird hunk of the patch is not relevant
> after that.

Right, this should work. But it does leave me wondering, should we
perhaps strive to completely remove the flags thing and move to
__tdx_hypercall() and __tdx_hypercall_ret() or something? That is,
simply have two different functions, one with and one without return
data.

It should be trivial to generate that without actual code duplication.

