Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86C8682BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjAaL4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjAaL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:56:07 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450C412073
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mkAe6TmYYkzvvnpiwG2ehepwj7crTZ8RcQhIqTHIfOA=; b=HI/m2XYMDLdEa0gWcfGp3NqZX8
        ioKa6MoCyyuf6hQ377FI33L/Dkvgq0yI0JHpZVa/MDHr7rTO9uEZ4lkYMvMEPMTn9HNA9pm+H0l2d
        eWhrxxck2FVfSGaqujOSH70M2pCf9UAgumYybWM8pE4fvbOA+JOuDWYpd7C8DHXFCTF0A0C4A1A6E
        omdrHdqyQcpJhot/m82EIKJeHJgU5zyJs+b56tQgdFp33CfqHVH7pKiI7IJtDTeV35jaPt258BCHH
        2Je4VYHzQMq5nD5/cHTuvcZ5lDWfR56F0tSBn8Q4FnsoPkNZp/+i0XLLWTxZjD2TtuXSm3KUEFq9L
        fmlvWscg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pMpEK-004LI9-0S;
        Tue, 31 Jan 2023 11:55:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33A28300673;
        Tue, 31 Jan 2023 12:55:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14AC320835864; Tue, 31 Jan 2023 12:55:49 +0100 (CET)
Date:   Tue, 31 Jan 2023 12:55:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Drop flags from __tdx_hypercall()
Message-ID: <Y9kBxcBC9EfJuVva@hirez.programming.kicks-ass.net>
References: <20230131111406.28816-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131111406.28816-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:14:06PM +0300, Kirill A. Shutemov wrote:
> After TDX_HCALL_ISSUE_STI got dropped, the only flag left is
> TDX_HCALL_HAS_OUTPUT. The flag indicates if the caller wants to see
> tdx_hypercall_args updated based on the hypercall output.
> 
> Drop the flags and provide __tdx_hypercall_ret() that matches
> TDX_HCALL_HAS_OUTPUT semantics.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

Nice!
