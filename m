Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C89B642706
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiLEK7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLEK70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:59:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18EF034;
        Mon,  5 Dec 2022 02:59:25 -0800 (PST)
Date:   Mon, 05 Dec 2022 10:59:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670237962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+iKQb7tlXQKT9kmhFxRWPOGNkOQ5rp1A8q+lu1eey6I=;
        b=ye7xxGWSUGXEVevalAd8H0+aVqySJeSMN8aJy/BCCIpXYnVvJK4+7CM6Z3rBBeT9FJsnvn
        PENUR9LZXTIooCNF6GZsR2qNnNsurFqbue3rd5TMCRPqCIGEROERO4m+wmelh7YbtZjd0U
        sxn2us+WuCrAAbkPXG5FeAbw2pUhJUYjiQ9657AEPSz+f/jjRO9iBwa0LDtHDP8YMHH4dQ
        vAqvPvZL5DspsKL7asl1XshLbVQhqodNzeQV0Up3HPuyL7kqxKotiItD4FNxkLE7nynFYg
        r+FsYR6YO0oqfEB8FElhKwDtdUI/EcA+jb1uIPiLZXig7vK4cq3Tz5Uudo0HvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670237962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+iKQb7tlXQKT9kmhFxRWPOGNkOQ5rp1A8q+lu1eey6I=;
        b=NvaD6x1G4dNzzP2Niad9KRwtRWx3+SX9gMNQGk43gp8sKwWP0Hcd6x6rZ5qqBBS9ae1yhh
        rgItNHWhq/rCVcCg==
From:   "tip-bot2 for Miaohe Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/alternative: Remove noinline from
 __ibt_endbr_seal[_end]() stubs
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221011113803.956808-1-linmiaohe@huawei.com>
References: <20221011113803.956808-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Message-ID: <167023796201.4906.1759849830808373616.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     023e59d4cee91dd3ca811eb01db2c5fb9f783dc2
Gitweb:        https://git.kernel.org/tip/023e59d4cee91dd3ca811eb01db2c5fb9f783dc2
Author:        Miaohe Lin <linmiaohe@huawei.com>
AuthorDate:    Tue, 11 Oct 2022 19:38:03 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Dec 2022 12:54:43 +01:00

x86/alternative: Remove noinline from __ibt_endbr_seal[_end]() stubs

Due to the explicit 'noinline' GCC-7.3 is not able to optimize away the
argument setup of:

	apply_ibt_endbr(__ibt_endbr_seal, __ibt_enbr_seal_end);

even when X86_KERNEL_IBT=n and the function is an empty stub, which leads
to link errors due to missing __ibt_endbr_seal* symbols:

ld: arch/x86/kernel/alternative.o: in function `alternative_instructions':
alternative.c:(.init.text+0x15d): undefined reference to `__ibt_endbr_seal_end'
ld: alternative.c:(.init.text+0x164): undefined reference to `__ibt_endbr_seal'

Remove the explicit 'noinline' to help gcc optimize them away.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221011113803.956808-1-linmiaohe@huawei.com
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5cadcea..beaf9fc 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -624,7 +624,7 @@ void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
 
 #else
 
-void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end) { }
+void __init_or_module apply_ibt_endbr(s32 *start, s32 *end) { }
 
 #endif /* CONFIG_X86_KERNEL_IBT */
 
