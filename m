Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992C668F463
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjBHRY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjBHRYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:24:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1824ED19
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Ki0eJe+BBfgVdZtQHY6Ihx06bAxCNT64t7j0255dl/4=; b=P0M3DiAj0TvRasgj3eum/crA7n
        9qbBlg3VJId6sDFxJtT2p5PdMqOGA18NShnLqyTf3r+9EVhKkKBFD6zEYybYnyVbdMX2flhaE3ydH
        eKUsczXA9WOf/Nh7Y8W5OLHdtzTIMwJnpv0rXofyQKkAfaMqTEsdiFKgf4eUbK4QXUWc3Ns3QXfvH
        MagsUVTDBKBGhnTa0NsHfki99SM+PBWizgXthmI/PNnZo/SU8YSpe2IZUPRwc8gVpGcJAlojKS/2D
        KumQaYuPs9uznL8Sq8sP5lA1WK+/zXYNrxwJL7dc4SyhGpM0A/lvKRXzBFMZzS7MCOP7NWjjqWfC6
        S5TX1I1A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPoAg-001PY7-Qh; Wed, 08 Feb 2023 17:23:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 497E13021D4;
        Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1EF4623D8CFB4; Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Message-ID: <20230208172245.783099843@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:18:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 08/10] x86: Fix FILL_RETURN_BUFFER
References: <20230208171756.898991570@infradead.org>
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

With overlapping alternative validation fixed, objtool promptly
complains:

vmlinux.o: warning: objtool: __switch_to_asm+0x2c: stack layout conflict in alternatives: .altinstr_replacement+0x47

.rela.altinstructions:

000000000000009c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 16dc
00000000000000a0  0000000600000002 R_X86_64_PC32          0000000000000000 .altinstr_replacement + 3a
00000000000000a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 16dc
00000000000000ac  0000000600000002 R_X86_64_PC32          0000000000000000 .altinstr_replacement + 66

.text:

00000000000016b0 <__switch_to_asm>:
    16b0:       f3 0f 1e fa             endbr64
    16b4:       55                      push   %rbp
    16b5:       53                      push   %rbx
    16b6:       41 54                   push   %r12
    16b8:       41 55                   push   %r13
    16ba:       41 56                   push   %r14
    16bc:       41 57                   push   %r15
    16be:       48 89 a7 18 0b 00 00    mov    %rsp,0xb18(%rdi)
    16c5:       48 8b a6 18 0b 00 00    mov    0xb18(%rsi),%rsp
    16cc:       48 8b 9e 28 05 00 00    mov    0x528(%rsi),%rbx
    16d3:       65 48 89 1c 25 00 00 00 00      mov    %rbx,%gs:0x0     16d8: R_X86_64_32S      fixed_percpu_data+0x28
    16dc:       eb 2a                   jmp    1708 <__switch_to_asm+0x58>
    16de:       90                      nop
    16df:       90                      nop
    16e0:       90                      nop
    16e1:       90                      nop
    16e2:       90                      nop
    16e3:       90                      nop
    16e4:       90                      nop
    16e5:       90                      nop
    16e6:       90                      nop
    16e7:       90                      nop
    16e8:       90                      nop
    16e9:       90                      nop
    16ea:       90                      nop
    16eb:       90                      nop
    16ec:       90                      nop
    16ed:       90                      nop
    16ee:       90                      nop
    16ef:       90                      nop
    16f0:       90                      nop
    16f1:       90                      nop
    16f2:       90                      nop
    16f3:       90                      nop
    16f4:       90                      nop
    16f5:       90                      nop
    16f6:       90                      nop
    16f7:       90                      nop
    16f8:       90                      nop
    16f9:       90                      nop
    16fa:       90                      nop
    16fb:       90                      nop
    16fc:       90                      nop
    16fd:       90                      nop
    16fe:       90                      nop
    16ff:       90                      nop
    1700:       90                      nop
    1701:       90                      nop
    1702:       90                      nop
    1703:       90                      nop
    1704:       90                      nop
    1705:       90                      nop
    1706:       90                      nop
    1707:       90                      nop
    1708:       41 5f                   pop    %r15
    170a:       41 5e                   pop    %r14
    170c:       41 5d                   pop    %r13
    170e:       41 5c                   pop    %r12
    1710:       5b                      pop    %rbx
    1711:       5d                      pop    %rbp
    1712:       e9 00 00 00 00          jmp    1717 <__switch_to_asm+0x67>      1713: R_X86_64_PLT32    __switch_to-0x4

.altinstr_replacement:

      3a:       49 c7 c4 10 00 00 00    mov    $0x10,%r12
      41:       e8 01 00 00 00          call   47 <.altinstr_replacement+0x47>
      46:       cc                      int3
      47:       e8 01 00 00 00          call   4d <.altinstr_replacement+0x4d>
      4c:       cc                      int3
      4d:       48 83 c4 10             add    $0x10,%rsp
      51:       49 ff cc                dec    %r12
      54:       75 eb                   jne    41 <.altinstr_replacement+0x41>
      56:       0f ae e8                lfence
      59:       65 48 c7 04 25 00 00 00 00 ff ff ff ff  movq   $0xffffffffffffffff,%gs:0x0      5e: R_X86_64_32S        pcpu_hot+0x10

      66:       e8 01 00 00 00          call   6c <.altinstr_replacement+0x6c>
      6b:       cc                      int3
      6c:       48 83 c4 08             add    $0x8,%rsp
      70:       0f ae e8                lfence

As can be seen from the two alternatives, when overlaid, the NOP after
the shorter (starting at 66) coinsides with the call at 47, leading to
conflicting CFI state for that instruction.

By offsetting the shorter alternative by 2 bytes, this alignment is
undone.

TODO: arguably objtool should be taught about the max nop length used
      by the kernel for tail padding, or unconditionally use JMP.d8 to
      not use the intervening bytes at all.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -261,7 +261,7 @@
 .macro FILL_RETURN_BUFFER reg:req nr:req ftr:req ftr2=ALT_NOT(X86_FEATURE_ALWAYS)
 	ALTERNATIVE_2 "jmp .Lskip_rsb_\@", \
 		__stringify(__FILL_RETURN_BUFFER(\reg,\nr)), \ftr, \
-		__stringify(__FILL_ONE_RETURN), \ftr2
+		__stringify(nop;nop;__FILL_ONE_RETURN), \ftr2
 
 .Lskip_rsb_\@:
 .endm


