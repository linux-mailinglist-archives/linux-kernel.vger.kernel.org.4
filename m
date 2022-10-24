Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D1660BE13
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJXXBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiJXXAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:00:33 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85CE2D73A0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:22:51 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id x18-20020a05640226d200b00461e027f704so2852237edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=volBetDwZhQX9fC04zMVYOMbO1RkS1wEneNzDmowndU=;
        b=J4G17c7UDbBB6vaIpcTMG+Yagy71XxidcSxJ/NpEIZ/jbOzoWk0kfwY4J5fIF7ruNg
         uGi67M7F6hDRJg9OeFqAKsiOneRo4mQZvIZQBucP08UFRGzIzuGOszxXz8ZopyHKDuIS
         IULIJgo8TuuvhCkpN2E1BwhlE/tvb0ROX1J8+selQyU1FbEVIVZjgsRAfyWC7ZcYSyo4
         UjBJSA65gpAUSXRfDlsMoLWLxjJd5ueHDjT7imXUcZo67G6nmMBYnLAJ2fFWILv1HmXJ
         loSrTZVNG/l/jpFZB3PUMQp3G0hSpSh8ejfuFn4zQ+5FICyuMUvWK71XzUK5hasUFpYa
         eOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=volBetDwZhQX9fC04zMVYOMbO1RkS1wEneNzDmowndU=;
        b=mCwrwtC+uvL0+YDkF50bH3MzIUzMLyyUqLRPnLnGgNfbMpjEh4TD05UtUR9L6POm6q
         gc+h8cxj8U0slxtEThVsDi19dhPAcUoHTsjpu3Se6Q9Pqcp6TyvN2PAP/dd6lTRxWkn3
         DWMWsEOFfjQyCw2wO8clXfH6uL0v5lLJvbCxTffGipdyq1dl32zlQ1MoMm4C568K0q0u
         knkK+T6bHqgv7aHShgQ/qH8s2lqMoH94cI+T7i1QRMRUPbftp4oL6B0xHl29YBkttp0v
         Jusqw+Pw5aRm4ux68CKlMzcmE0G5WYIWZufVPbJqQncBS/X2pKSeLbLuZnJUyHVxnDr0
         ytVQ==
X-Gm-Message-State: ACrzQf3Go0iOnvIEyU5TMDQR9Ce7MkyYV17Ed2+HKsphGATQ/i0Igdu0
        JTZdv8wJmhRInsqyI16xPOw4s4wkNE4=
X-Google-Smtp-Source: AMsMyM6Tq20dngPWWsHMTzhzn39uWvW18mFyDgT+su4EaQ1IkASlw4U74YHbIUx7kj1tUnUMLAaBPw2aqg0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:8695:7c88:66ed:f9d1])
 (user=glider job=sendgmr) by 2002:a17:907:3f96:b0:7ab:34aa:9094 with SMTP id
 hr22-20020a1709073f9600b007ab34aa9094mr2182051ejc.85.1666646527998; Mon, 24
 Oct 2022 14:22:07 -0700 (PDT)
Date:   Mon, 24 Oct 2022 23:21:43 +0200
In-Reply-To: <20221024212144.2852069-1-glider@google.com>
Mime-Version: 1.0
References: <20221024212144.2852069-1-glider@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221024212144.2852069-4-glider@google.com>
Subject: [PATCH 4/5] x86: asm: make sure __put_user_size() evaluates pointer once
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        youling257 <youling257@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User access macros must ensure their arguments are evaluated only once
if they are used more than once in the macro body. Adding
instrument_put_user() to __put_user_size() resulted in double evaluation
of the `ptr` argument, which led to correctness issues when performing
e.g. unsafe_put_user(..., p++, ...).
To fix those issues, evaluate the `ptr` argument of __put_user_size()
at the beginning of the macro.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Reported-by: youling257 <youling257@gmail.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Fixes: 888f84a6da4d ("x86: asm: instrument usercopy in get_user() and put_user()")
---
 arch/x86/include/asm/uaccess.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 8bc614cfe21b9..1cc756eafa447 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -254,24 +254,25 @@ extern void __put_user_nocheck_8(void);
 #define __put_user_size(x, ptr, size, label)				\
 do {									\
 	__typeof__(*(ptr)) __x = (x); /* eval x once */			\
-	__chk_user_ptr(ptr);						\
+	__typeof__(ptr) __ptr = (ptr); /* eval ptr once */		\
+	__chk_user_ptr(__ptr);						\
 	switch (size) {							\
 	case 1:								\
-		__put_user_goto(__x, ptr, "b", "iq", label);		\
+		__put_user_goto(__x, __ptr, "b", "iq", label);		\
 		break;							\
 	case 2:								\
-		__put_user_goto(__x, ptr, "w", "ir", label);		\
+		__put_user_goto(__x, __ptr, "w", "ir", label);		\
 		break;							\
 	case 4:								\
-		__put_user_goto(__x, ptr, "l", "ir", label);		\
+		__put_user_goto(__x, __ptr, "l", "ir", label);		\
 		break;							\
 	case 8:								\
-		__put_user_goto_u64(__x, ptr, label);			\
+		__put_user_goto_u64(__x, __ptr, label);			\
 		break;							\
 	default:							\
 		__put_user_bad();					\
 	}								\
-	instrument_put_user(__x, ptr, size);				\
+	instrument_put_user(__x, __ptr, size);				\
 } while (0)
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-- 
2.38.0.135.g90850a2211-goog

