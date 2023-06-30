Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47959744315
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjF3UMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjF3UMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:12:12 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF9F13E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:12:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc54caad5so14949825e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688155930; x=1690747930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f2ZM8TAtIacJ4fI9wC/ZCbMv5lNvIQluS4wA6x6MSls=;
        b=BWDFeb5Yrm02k2/rQGE2yNvMFjOIpxixKtPY/K7ZLPB7OeoS2YJRFMm5XQ+NaGkrKg
         v2yvDru+Ya9+sQGTRl7AacdNxJmmrbZvJ/xWZNGVCXVb/x9bNUWbvIwVLE9wm5S7OBIg
         UG5J/ib2grrT1hD9HS4lfsedaibUfOl+mHISEXNcjolXpcMd3RBfdmR/S8CKr4yS/oGV
         7JICnbcW8LKOhhf1dahdBLIxvpx+l9iA2yYyX1XEP05mhVTb8F58xyg9GlFb1aQO+o3z
         OEKHLrNUPWR59Mk/O25x10Gt7HCj7j8cpozrqXFRBxEpNBPKNNLW+b/g3ec4K/nza1Ns
         CnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688155930; x=1690747930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2ZM8TAtIacJ4fI9wC/ZCbMv5lNvIQluS4wA6x6MSls=;
        b=ITuGDUXEj96aH7Q+f8my3vuDB1DPey4dLsAvWHebvpdrHzMXGb8OdyytcQbExAMro2
         CYjqQR5z3ALasRDoKLuf1wTTgSPpvlrrI+BOtEpPI8onvzzFJIpKx19U5LN4SauDyCml
         MLiAtfCju5FFGb2AUEXm8HuZeOukQc4XGeRIh5xQvzsxwTs4ws3i9tWkWR5uixsSXJgm
         b9ULhsJt4khirYUdlbI5rJf8fTwicRi7HeHT1FUIMHeo8yrXPBMR6yVXZUEKNzUAJNP1
         4gC6GOfl6fDPSbMAyxE71hS0rv109smxJdHDyoMykv/sjEiPbfILlSHWN/dT4atHULwJ
         sJrw==
X-Gm-Message-State: AC+VfDzKWgfg+jJDCBoLCNpGOtXfH78n07VJWdIQ1UeYzsn4NySSZPE6
        PW4UXWiAE5fFSYGrZ0lcil6RjQ==
X-Google-Smtp-Source: ACHHUZ772+lDulYVp/lG3ggTa/L0EU4PTnIcpqAElW5g0jYoioXAknBYmrt94ZrEgkCfhctQPwf/1g==
X-Received: by 2002:a05:600c:2253:b0:3fb:a5b3:4f02 with SMTP id a19-20020a05600c225300b003fba5b34f02mr2810094wmm.36.1688155930010;
        Fri, 30 Jun 2023 13:12:10 -0700 (PDT)
Received: from wychelm.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c0b5000b003fba6709c68sm10686143wmr.47.2023.06.30.13.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 13:12:09 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] kdb: move kdb_send_sig() declaration to a better header file
Date:   Fri, 30 Jun 2023 21:12:06 +0100
Message-Id: <20230630201206.2396930-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdb_send_sig() is defined in the signal code and called from kdb,
but the declaration is part of the kdb internal code.
Move the declaration to the shared header to avoid the warning:

kernel/signal.c:4789:6: error: no previous prototype for 'kdb_send_sig' [-Werror=missing-prototypes]

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 include/linux/kdb.h            | 2 ++
 kernel/debug/kdb/kdb_private.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kdb.h b/include/linux/kdb.h
index 07dfb6a20a1c4..f6c2ddb16b958 100644
--- a/include/linux/kdb.h
+++ b/include/linux/kdb.h
@@ -196,6 +196,8 @@ int kdb_process_cpu(const struct task_struct *p)
 	return cpu;
 }

+extern void kdb_send_sig(struct task_struct *p, int sig);
+
 #ifdef CONFIG_KALLSYMS
 extern const char *kdb_walk_kallsyms(loff_t *pos);
 #else /* ! CONFIG_KALLSYMS */
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 1f8c519a5f81c..548fd4059bf9b 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -194,7 +194,6 @@ extern char kdb_task_state_char (const struct task_struct *);
 extern bool kdb_task_state(const struct task_struct *p, const char *mask);
 extern void kdb_ps_suppressed(void);
 extern void kdb_ps1(const struct task_struct *p);
-extern void kdb_send_sig(struct task_struct *p, int sig);
 extern char kdb_getchar(void);
 extern char *kdb_getstr(char *, size_t, const char *);
 extern void kdb_gdb_state_pass(char *buf);

base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
--
2.39.2

