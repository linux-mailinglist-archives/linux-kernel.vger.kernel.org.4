Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC856E4596
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjDQKtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjDQKsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:48:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298BFA9;
        Mon, 17 Apr 2023 03:47:52 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:46:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681728405;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W5gz0IAPwW8Ml+TPwzI2zzEnnHxfoa0E4AWfaz+JnGM=;
        b=ycu5EFvgo2VWpyjSRBGDmDd/h4hpo2wBiH2VbxpHQWJCJTgxEpgsCJTLSSNe5wtQdzF82k
        1wP0+5Dj/23IkzjhhHkjT4ZutwjKoOfIZtOt0D6wVxLuq6agj7czZhRAOmEbZUZty/jAjW
        BhUsh26jqs6wtY4z7VadeOmaBTSO0Ubt8ECebRkMqupeZ8ijziTm8zowr2wOKG347CVCWW
        qNE1g6PST6VoZ4f3gNNDtvH4Al2MBKQ9RCpPa8lxJhrWHGY0eNemvIPyLCjpTPYywnSnJi
        MJsxaCOIoHhFfVmO+dj89I5f702XDHIue0NuQhtnkzfH+1HZJPG/a5e7bJPk+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681728405;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W5gz0IAPwW8Ml+TPwzI2zzEnnHxfoa0E4AWfaz+JnGM=;
        b=IatCR1nrLl6AdV6PUJGG4QhrGoFAjl7fG+oIycCyls0pO3vzN7IlLYcokWLz9hFJhm0bMm
        Rw+FNMkVxSBqTSDw==
From:   "tip-bot2 for Guilherme G. Piccoli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <32453a703dfcf0d007b473c9acbf70718222b74b.1681342859.git.jpoimboe@kernel.org>
References: <32453a703dfcf0d007b473c9acbf70718222b74b.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168172840540.404.15994550116544514863.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     611d4c716db0141cfc436994dc5aff1d69c924ad
Gitweb:        https://git.kernel.org/tip/611d4c716db0141cfc436994dc5aff1d69c924ad
Author:        Guilherme G. Piccoli <gpiccoli@igalia.com>
AuthorDate:    Wed, 12 Apr 2023 16:49:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 17:31:28 +02:00

x86/hyperv: Mark hv_ghcb_terminate() as noreturn

Annotate the function prototype and definition as noreturn to prevent
objtool warnings like:

vmlinux.o: warning: objtool: hyperv_init+0x55c: unreachable instruction

Also, as per Josh's suggestion, add it to the global_noreturns list.
As a comparison, an objdump output without the annotation:

[...]
1b63:  mov    $0x1,%esi
1b68:  xor    %edi,%edi
1b6a:  callq  ffffffff8102f680 <hv_ghcb_terminate>
1b6f:  jmpq   ffffffff82f217ec <hyperv_init+0x9c> # unreachable
1b74:  cmpq   $0xffffffffffffffff,-0x702a24(%rip)
[...]

Now, after adding the __noreturn to the function prototype:

[...]
17df:  callq  ffffffff8102f6d0 <hv_ghcb_negotiate_protocol>
17e4:  test   %al,%al
17e6:  je     ffffffff82f21bb9 <hyperv_init+0x469>
[...]  <many insns>
1bb9:  mov    $0x1,%esi
1bbe:  xor    %edi,%edi
1bc0:  callq  ffffffff8102f680 <hv_ghcb_terminate>
1bc5:  nopw   %cs:0x0(%rax,%rax,1) # end of function

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/32453a703dfcf0d007b473c9acbf70718222b74b.1681342859.git.jpoimboe@kernel.org
---
 arch/x86/hyperv/ivm.c           | 2 +-
 arch/x86/include/asm/mshyperv.h | 2 +-
 tools/objtool/check.c           | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 1dbcbd9..4f79dc7 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -127,7 +127,7 @@ static enum es_result hv_ghcb_hv_call(struct ghcb *ghcb, u64 exit_code,
 		return ES_OK;
 }
 
-void hv_ghcb_terminate(unsigned int set, unsigned int reason)
+void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 4c4c0ec..09c26e6 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -212,7 +212,7 @@ int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool visible);
 void hv_ghcb_msr_write(u64 msr, u64 value);
 void hv_ghcb_msr_read(u64 msr, u64 *value);
 bool hv_ghcb_negotiate_protocol(void);
-void hv_ghcb_terminate(unsigned int set, unsigned int reason);
+void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e1b01ea..5b600bb 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -213,6 +213,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"ex_handler_msr_mce",
 		"fortify_panic",
 		"hlt_play_dead",
+		"hv_ghcb_terminate",
 		"kthread_complete_and_exit",
 		"kthread_exit",
 		"kunit_try_catch_throw",
