Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49046C2E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCUKPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCUKPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:15:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E33546159
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=myZeeIZ+99lKWhEqcJ0NcMY8rj0d8bMphmX0xRE+tl0=; b=l2oMnjetMX4keDC+q5ktTbF5V8
        fOI5Dz5D3un98/Rio5si3KVnG2u0bh0Sy1K8EcRsaz+ze/LH1r8oBXybyPiRRh/01DdEQJSwqk/7K
        C3wdHCQNsOEF5fKWzJWtcBAF48LBxkR2vBlgFu8UzL2QWlGUZYHF8jKY7OcWW8WIM22JhdDYfuYaP
        6nJoobnLeIMP0YjgnKY/mLdivwpwEVuBgWdLmWffUzdn8aIpsi5Gliio49E1PuqFRK74KDAPbxev/
        h22H4+qnNoNC6EiwnUcNkK36bfqGq011k8xOUQhAMXZWaONpAKbzteB9tUCCxnGK4bp2gRy9FX+2p
        bbVn98uw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peZ1U-004EBl-1f;
        Tue, 21 Mar 2023 10:15:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1DDB3001D6;
        Tue, 21 Mar 2023 11:15:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B83B240EA549; Tue, 21 Mar 2023 11:15:19 +0100 (CET)
Date:   Tue, 21 Mar 2023 11:15:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     bp@alien8.de, dave.hansen@intel.com, luto@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH, REBASED] x86/tdx: Drop flags from __tdx_hypercall()
Message-ID: <20230321101519.GG2234901@hirez.programming.kicks-ass.net>
References: <20230321003511.9469-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321003511.9469-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 03:35:11AM +0300, Kirill A. Shutemov wrote:
> After TDX_HCALL_ISSUE_STI got dropped, the only flag left is
> TDX_HCALL_HAS_OUTPUT. The flag indicates if the caller wants to see
> tdx_hypercall_args updated based on the hypercall output.
> 
> Drop the flags and provide __tdx_hypercall_ret() that matches
> TDX_HCALL_HAS_OUTPUT semantics.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
