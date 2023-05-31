Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F738717F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjEaL5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbjEaL5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:57:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DD89D;
        Wed, 31 May 2023 04:57:18 -0700 (PDT)
Date:   Wed, 31 May 2023 11:57:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685534237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+o20mS6w1wkNNtk/4F00y/i6GrVObsqbUJdcIo3p1Wc=;
        b=rJxJ8gWtmgwo00Z04we4DXBABrrXrWNX272iBBGdOPgPw/krjP1JAM5zSDyGb/5auz07pt
        AdoFaXvzWiq4deZk7JE2stXDzNAPV9ZKgurx29pywHVG0N/ova4SpCcvelteG9oyxzzLyG
        XyFZDnnJ4PMT8imu+fI0AhwAQmSdfMmfITkTO79kAXby836tcuPxIe0JPs4fg2kZTOOT4b
        Bxh6+WpJDbcN1npuXtL9YQgog7V5UZssvS2CErVxik2iym4dT1kk9lZrkzfltSf+cBlKeP
        eWXM2V6EAmmWYuEGPutxr/Id5RVDwxnrR+ga1uwQROI8zZtuGlvDM95wNjop2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685534237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+o20mS6w1wkNNtk/4F00y/i6GrVObsqbUJdcIo3p1Wc=;
        b=D/vCJajLdIgjNPyXgFqinD6JPLh3CIQl+au2mD5T4jymAHxEZ++35VDbmHaSncgKJS4jjY
        NeHLXiaNuam/5JCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/nospec: Shorten RESET_CALL_DEPTH
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515093020.729622326@infradead.org>
References: <20230515093020.729622326@infradead.org>
MIME-Version: 1.0
Message-ID: <168553423619.404.1623011385278155776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     3496d1c64a0fcc9bae3ed40decc3ecd7f8ac072f
Gitweb:        https://git.kernel.org/tip/3496d1c64a0fcc9bae3ed40decc3ecd7f8ac072f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 10 Feb 2023 10:10:57 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 May 2023 13:40:57 +02:00

x86/nospec: Shorten RESET_CALL_DEPTH

RESET_CALL_DEPTH is a pretty fat monster and blows up UNTRAIN_RET to
20 bytes:

  19:       48 c7 c0 80 00 00 00    mov    $0x80,%rax
  20:       48 c1 e0 38             shl    $0x38,%rax
  24:       65 48 89 04 25 00 00 00 00      mov    %rax,%gs:0x0     29: R_X86_64_32S        pcpu_hot+0x10

Shrink it by 4 bytes:

  0:   31 c0				xor %eax,%eax
  2:   48 0f ba e8 3f			bts $0x3f,%rax
  7:   65 48 89 04 25 00 00 00 00	mov %rax,%gs:0x0

Shrink RESET_CALL_DEPTH_FROM_CALL by 5 bytes by only setting %al, the
other bits are shifted out (the same could be done for RESET_CALL_DEPTH,
but the XOR+BTS sequence has less dependencies due to the zeroing).

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230515093020.729622326@infradead.org
---
 arch/x86/include/asm/nospec-branch.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index edb2b0c..55388c9 100644
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
