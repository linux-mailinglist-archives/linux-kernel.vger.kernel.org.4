Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51D363416E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiKVQ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiKVQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:26:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54B4205DB;
        Tue, 22 Nov 2022 08:26:44 -0800 (PST)
Date:   Tue, 22 Nov 2022 16:26:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669134403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7z18Qsa6WKgfd8idYg0zbdnSVfun8wkjQ1dd6pBtws=;
        b=Wn7oefSBIV1qyIlXDqpUW4zqQP5CPirWg7oJCx41mipW5DsnmAKXzm4jFLrzmBha3IqA0v
        S40naqMJ0RE/H7PKJi9lXw1ed+Xp8cZpKQMRnLRnHfvCLpFa2661gJrteOkWhYIuNPvik2
        VultdZfE+PRBGYNVfwW2zRdjXvXznQcQaqhWED1e82Y7kGwi37AJDn6ERPAKptrXNg83Yt
        HBZohkBYXX+mWhkc/iu6LSpYqh1pAZmNh4XXvsaWEinzQ9UWaA2+EqXfkZ/YtLlVlPYqF4
        EdTh98v1BRzFS+hxrqm89YFYlGDrEn6O8s96Syqgwd5qJJRiWgdBYckbF8cKgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669134403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7z18Qsa6WKgfd8idYg0zbdnSVfun8wkjQ1dd6pBtws=;
        b=cAIEZQJPM4qu43O+saG7R6wjLZD8lCYKsvBdO4uye7axhnqFEpS2z4PKCxKiCSEPj4vAtP
        c7ZRqa+8YYQ25UDg==
From:   "tip-bot2 for YingChi Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Use _Alignof to avoid undefined behavior in
 TYPE_ALIGN
Cc:     YingChi Long <me@inclyc.cn>, Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220925153151.2467884-1-me@inclyc.cn>
References: <20220925153151.2467884-1-me@inclyc.cn>
MIME-Version: 1.0
Message-ID: <166913440179.4906.11745141572917292511.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     55228db2697c09abddcb9487c3d9fa5854a932cd
Gitweb:        https://git.kernel.org/tip/55228db2697c09abddcb9487c3d9fa5854a932cd
Author:        YingChi Long <me@inclyc.cn>
AuthorDate:    Fri, 18 Nov 2022 08:55:35 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Nov 2022 17:13:03 +01:00

x86/fpu: Use _Alignof to avoid undefined behavior in TYPE_ALIGN

WG14 N2350 specifies that it is an undefined behavior to have type
definitions within offsetof", see

  https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm

This specification is also part of C23.

Therefore, replace the TYPE_ALIGN macro with the _Alignof builtin to
avoid undefined behavior. (_Alignof itself is C11 and the kernel is
built with -gnu11).

ISO C11 _Alignof is subtly different from the GNU C extension
__alignof__. Latter is the preferred alignment and _Alignof the
minimal alignment. For long long on x86 these are 8 and 4
respectively.

The macro TYPE_ALIGN's behavior matches _Alignof rather than
__alignof__.

  [ bp: Massage commit message. ]

Signed-off-by: YingChi Long <me@inclyc.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20220925153151.2467884-1-me@inclyc.cn
---
 arch/x86/kernel/fpu/init.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 8946f89..851eb13 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -133,9 +133,6 @@ static void __init fpu__init_system_generic(void)
 	fpu__init_system_mxcsr();
 }
 
-/* Get alignment of the TYPE. */
-#define TYPE_ALIGN(TYPE) offsetof(struct { char x; TYPE test; }, test)
-
 /*
  * Enforce that 'MEMBER' is the last field of 'TYPE'.
  *
@@ -143,8 +140,8 @@ static void __init fpu__init_system_generic(void)
  * because that's how C aligns structs.
  */
 #define CHECK_MEMBER_AT_END_OF(TYPE, MEMBER) \
-	BUILD_BUG_ON(sizeof(TYPE) != ALIGN(offsetofend(TYPE, MEMBER), \
-					   TYPE_ALIGN(TYPE)))
+	BUILD_BUG_ON(sizeof(TYPE) !=         \
+		     ALIGN(offsetofend(TYPE, MEMBER), _Alignof(TYPE)))
 
 /*
  * We append the 'struct fpu' to the task_struct:
