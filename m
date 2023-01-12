Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4496E66782C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbjALOxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbjALOww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:52:52 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658AC61479
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+hVGbhW+kq8WeUTnRFVIQ4y6xF6mTUDTY1iojLvcO/Q=; b=VD2YCgkTmE2CQ4Y8uw29qiC2TE
        R80ib0ot/jJ/vDVx1nc81VA/UdFYRNG0RCJX9If+JwIwax/MdSzvs+229sqAm51rlqFP4ZtmBL6KE
        ZGwzJaeaNt97uYlCPg3WWmvJH6/Qc2TRui52REAxdkfvawrPGc1AlBYy8r3QDtkibYhajuP5B7DDl
        e4VUHACu7Phw+gAfdvDwUrseQHxbEogW6ZFrf4DGNzODQW73kd/B4Gn8iBVxRaIIdPZwruHvk8R/J
        U+pz1lXQCECLx95TWt3y1l8JrPMkbqVDOu1nEJOjWfQjLPnHBvOtaLz8Bxx4rBAruF+c4Yb+M8UAF
        +VcR5hIg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pFyjS-0040tE-0z;
        Thu, 12 Jan 2023 14:39:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EA5E2300C50;
        Thu, 12 Jan 2023 15:39:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B77922CC949A1; Thu, 12 Jan 2023 15:39:12 +0100 (CET)
Message-ID: <20230112143825.644480983@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 12 Jan 2023 15:31:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com
Subject: [RFC][PATCH 2/6] x86/power: Inline write_cr[04]()
References: <20230112143141.645645775@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we can't do CALL/RET until GS is restored and CR[04] pinning is
of dubious value in this code path, simply write the stored values.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/power/cpu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -208,11 +208,11 @@ static void notrace __restore_processor_
 #else
 /* CONFIG X86_64 */
 	native_wrmsrl(MSR_EFER, ctxt->efer);
-	native_write_cr4(ctxt->cr4);
+	asm volatile("mov %0,%%cr4": "+r" (ctxt->cr4) : : "memory");
 #endif
 	native_write_cr3(ctxt->cr3);
 	native_write_cr2(ctxt->cr2);
-	native_write_cr0(ctxt->cr0);
+	asm volatile("mov %0,%%cr0": "+r" (ctxt->cr0) : : "memory");
 
 	/* Restore the IDT. */
 	native_load_idt(&ctxt->idt);


