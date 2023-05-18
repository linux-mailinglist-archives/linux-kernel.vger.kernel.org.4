Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F3E707EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjERLJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjERLJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:09:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4088213D;
        Thu, 18 May 2023 04:08:36 -0700 (PDT)
Date:   Thu, 18 May 2023 11:08:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684408084;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfkepp8n9DFZjIdQo9gJbfuMIUEXsMOcfYyoO10MrH8=;
        b=BwJNbCj0VN6R7V2EHWwIaBgGkZCJ95UoaCEk8mvrYaJ5zA5tpyLHz7CizyzexXxYX/pWdv
        G+taMZXycG50/IB9gQ1iPaqPyRW/4o4GFfEhmPU5ceq4GLjc8//JwU+Ov5VJ0cPsDl0WXN
        m36wRpoXaCCm/HZs5ARVtvohuleFZk31ANN5ceiqBCBb5ZsxwfjFNG2CdNQ94qS7GD6AFR
        YNlUVJ7Spd6SFrfZ1ZZKMaiK2Oa/j08MXIMnbIDoy11KKdDQpoAeGytGSN0B5x6ESC5K+I
        GvZDkNcn+PR59BVuwx/myRABeF8JnOTOhETUFWY2Dvunor8osV0d0PtonkWV/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684408084;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfkepp8n9DFZjIdQo9gJbfuMIUEXsMOcfYyoO10MrH8=;
        b=/Wdj8QuvCS4oklEpE+zW91Cg8CTx3OU92Thcu2KWbfVmU0JW9h9V+3D6TMYhGoOp5evMKF
        DqyI5ruMsslOT6BA==
From:   "tip-bot2 for ndesaulniers@google.com" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] start_kernel: Omit
 prevent_tail_call_optimization() for newer toolchains
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230412-no_stackp-v2-2-116f9fe4bbe7@google.com>
References: <20230412-no_stackp-v2-2-116f9fe4bbe7@google.com>
MIME-Version: 1.0
Message-ID: <168440808364.404.15005624206596163176.tip-bot2@tip-bot2>
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

Commit-ID:     dc1d05536f44cee16e46e86316e6718b2c0d8872
Gitweb:        https://git.kernel.org/tip/dc1d05536f44cee16e46e86316e6718b2c0d8872
Author:        ndesaulniers@google.com <ndesaulniers@google.com>
AuthorDate:    Mon, 17 Apr 2023 15:00:06 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 16 May 2023 06:28:24 -07:00

start_kernel: Omit prevent_tail_call_optimization() for newer toolchains

prevent_tail_call_optimization() was added in
commit a9a3ed1eff36 ("x86: Fix early boot crash on gcc-10, third try")
to work around stack canaries getting inserted into functions that would
initialize the stack canary in the first place.

Now that we have no_stack_protector function attribute (gcc-11+,
clang-7+) and use it on start_kernel(), remove the call to
prevent_tail_call_optimization() such that we may one day remove it
outright.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20230412-no_stackp-v2-2-116f9fe4bbe7@google.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 init/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/init/main.c b/init/main.c
index c445c1f..c0b6499 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1088,7 +1088,13 @@ void start_kernel(void)
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
 
+	/*
+	 * Avoid stack canaries in callers of boot_init_stack_canary for gcc-10
+	 * and older.
+	 */
+#if !__has_attribute(__no_stack_protector__)
 	prevent_tail_call_optimization();
+#endif
 }
 
 /* Call all constructor functions linked into the kernel. */
