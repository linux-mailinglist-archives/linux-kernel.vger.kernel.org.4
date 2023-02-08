Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D122068F9A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjBHVVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHVVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:21:31 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C02E0F7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 13:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vi2o3wrvK4ugHLhR5V6gHfXdMTtAGFOndL/HWO1/Vfk=; b=VkoE8ysJUjtZOG7wiXZS67zXBy
        19PBow/ozSITRvedq2YqSTJGtrrUTY2m6T1dnzzrH3vtcbyPba78ik6MbfIiHilwCbhIwoVuPqK7v
        uPMfMu3LJQdZ4Dh3RIS2LPQtnH+WBF7cGOmDoxk6TSOdg6xHuYkSUUsbsa6aRD9EIMDq6YzxVhLYF
        +GqiTeyPl8jiEL3OAEeuQcP1KvVHXgwfnpBZhS/kxDFouM6k1Y4DZL7WZBb6Q76CdjI7LbtlmfmE/
        tNT03/DMmRyRmjEWP0YxQV0QdU8yt+7I2GYptcpEc3V573d9aleJUQ/EDSlccTMPUCvpXFuXcOPsT
        yvuOxmWQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPrrm-007bFX-0H;
        Wed, 08 Feb 2023 21:20:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FE5B3001CB;
        Wed,  8 Feb 2023 22:21:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DAB5209BAB68; Wed,  8 Feb 2023 22:21:12 +0100 (CET)
Date:   Wed, 8 Feb 2023 22:21:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew.Cooper3@citrix.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        kirill.shutemov@linux.intel.com, jpoimboe@redhat.com
Subject: Re: [PATCH v3 3/4] x86/alternative: Rewrite optimize_nops() some
Message-ID: <Y+QSSFEfA5oXdKUS@hirez.programming.kicks-ass.net>
References: <20230208171050.490809180@infradead.org>
 <20230208171431.373412974@infradead.org>
 <f0b54521-26cf-ed38-d805-3a8eef3b3103@citrix.com>
 <Y+QGIiOupDKxlKKR@hirez.programming.kicks-ass.net>
 <Y+QHyF5K5hSN0ziP@hirez.programming.kicks-ass.net>
 <Y+QJlK637EYg/Zst@hirez.programming.kicks-ass.net>
 <Y+QPPFQ4DzSaJC3m@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+QPPFQ4DzSaJC3m@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 10:08:12PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 08, 2023 at 09:44:04PM +0100, Peter Zijlstra wrote:
> 
> > [   11.584069] SMP alternatives: ffffffff82000095: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> > [   11.590068] SMP alternatives: ffffffff820001f3: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> > [   11.720069] SMP alternatives: ffffffff8200189f: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> > [   11.731069] SMP alternatives: ffffffff820019ae: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> > [   11.738069] SMP alternatives: ffffffff82001a4a: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> > [   11.746069] SMP alternatives: ffffffff82001b2d: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> > [   11.766069] SMP alternatives: ffffffff82001d14: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> > [   11.770069] SMP alternatives: ffffffff82001dd5: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> > [   11.779069] SMP alternatives: ffffffff82001f35: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> 
> UNTRAIN_RET -- specifically RESET_CALL_DEPTH

19:       48 c7 c0 80 00 00 00    mov    $0x80,%rax
20:       48 c1 e0 38             shl    $0x38,%rax
24:       65 48 89 04 25 00 00 00 00      mov    %rax,%gs:0x0     29: R_X86_64_32S        pcpu_hot+0x10

Is ofc an atrocity.

We can easily trim that by 5 bytes to:

0:   b0 80                   mov    $0x80,%al
2:   48 c1 e0 38             shl    $0x38,%rax
6:   65 48 89 04 25 00 00 00 00      mov    %rax,%gs:0x0

Who cares about the top bytes, we're explicitly shifting them out
anyway. But that's still 15 bytes or so.

If it weren't for those pesky prefix penalties that would make exactly
one instruction :-)


diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index e04313e89f4f..be792f9407b5 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -84,7 +84,7 @@
 	movq	$-1, PER_CPU_VAR(pcpu_hot + X86_call_depth);
 
 #define RESET_CALL_DEPTH					\
-	mov	$0x80, %rax;					\
+	movb	$0x80, %al;					\
 	shl	$56, %rax;					\
 	movq	%rax, PER_CPU_VAR(pcpu_hot + X86_call_depth);
 
