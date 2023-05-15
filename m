Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D077702A71
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbjEOK03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjEOK01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:26:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291FF1B4
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=KlGV2Uq9r7IyVe38YPKCmnCoKgdwioBrjNMLC/4V+jo=; b=jV+GjZbpbbM94JK+TYSpqI+fsM
        4dKFq2C5leD5Vw9uRrXDvIU1NavfC63Dw1M/FiRNdSqzskNB7qIe4a5D6hYIUxZ8LoMKQM4/FcJlO
        jerjRgUh4HEcCklfBWVP9FBD95T/e5ivjyR6Zwp73Mz63gPyP6Hy6PROP9fK/r3+/lnJPqbbAKYd7
        xu9dIhqsfL9MLbRFJKehnCT72410C6/5WAY3kEAjfCpmsdsfJT/ko4L3kOVsW7AwJcK+kVUXjhLus
        p/aqdfyVEInsbr8uE5hyBlCDCh2NV3uc3ZzKOKH7qJtEef8RlWBLuArbFfV4zCxT2Wtm0O9L3eFtM
        l+Zuyuaw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pyVPH-00BS2w-1M;
        Mon, 15 May 2023 10:26:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97939300244;
        Mon, 15 May 2023 12:26:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B2AB268D4223; Mon, 15 May 2023 12:26:18 +0200 (CEST)
Date:   Mon, 15 May 2023 12:26:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew.Cooper3@citrix.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        jpoimboe@redhat.com
Subject: Re: [PATCH 2/2] x86: Shorten RESET_CALL_DEPTH
Message-ID: <20230515102618.GF83892@hirez.programming.kicks-ass.net>
References: <20230515092804.120600032@infradead.org>
 <20230515093020.729622326@infradead.org>
 <0111b953-500e-3716-b349-d5c8012e5220@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0111b953-500e-3716-b349-d5c8012e5220@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 10:47:42AM +0100, Andrew.Cooper3@citrix.com wrote:
> On 15/05/2023 10:28 am, Peter Zijlstra wrote:

> > Shrink it by 4 bytes:
> >
> >   0:   31 c0                   xor    %eax,%eax
> >   2:   48 0f ba e8 3f          bts    $0x3f,%rax
> >   7:   65 48 89 04 25 00 00 00 00      mov    %rax,%gs:0x0

> >  #define RESET_CALL_DEPTH					\
> > -	mov	$0x80, %rax;					\
> > -	shl	$56, %rax;					\
> > +	xor	%eax, %eax;					\
> > +	bts	$59, %rax;					\
> 
> $63 ?
> 
> The disassembly looks correct.

Yeah, uhmm, clearly I fixed it somewhere but not on the version I send
out :-(

Too bad we need the RAX.W prefix...

---
Subject: x86: Shorten RESET_CALL_DEPTH
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Feb 10 10:10:57 CET 2023

RESET_CALL_DEPTH is a pretty fat monster and blows up UNTRAIN_RET to
20 bytes:

  19:       48 c7 c0 80 00 00 00    mov    $0x80,%rax
  20:       48 c1 e0 38             shl    $0x38,%rax
  24:       65 48 89 04 25 00 00 00 00      mov    %rax,%gs:0x0     29: R_X86_64_32S        pcpu_hot+0x10

Shrink it by 4 bytes:

  0:   31 c0                   xor    %eax,%eax
  2:   48 0f ba e8 3f          bts    $0x3f,%rax
  7:   65 48 89 04 25 00 00 00 00      mov    %rax,%gs:0x0

Shrink RESET_CALL_DEPTH_FROM_CALL by 5 bytes by only setting al, the
other bits are shifted out (the same could be done for
RESET_CALL_DEPTH, but the xor+bts sequence has less depencies due to
the zeroing).

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -84,12 +84,12 @@
 	movq	$-1, PER_CPU_VAR(pcpu_hot + X86_call_depth);
 
 #define RESET_CALL_DEPTH					\
-	mov	$0x80, %rax;					\
-	shl	$56, %rax;					\
+	xor	%eax, %eax;					\
+	bts	$63, %rax;					\
 	movq	%rax, PER_CPU_VAR(pcpu_hot + X86_call_depth);
 
 #define RESET_CALL_DEPTH_FROM_CALL				\
-	mov	$0xfc, %rax;					\
+	movb	$0xfc, %al;					\
 	shl	$56, %rax;					\
 	movq	%rax, PER_CPU_VAR(pcpu_hot + X86_call_depth);	\
 	CALL_THUNKS_DEBUG_INC_CALLS
