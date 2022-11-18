Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCC862FB87
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbiKRRXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiKRRXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:23:12 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9562F03B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:23:11 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id sd31-20020a1709076e1f00b007ae63b8d66aso3376923ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e+LcyMNkInxJbEkI4dZYVXRRy3OSinTohFLJ8BhSGEI=;
        b=Wl236N0EDKtBFLF3ZJNWeD3tjBamKSe4XEAfRsjqhhj+klve+os4bfTYg83EIPQ/4Q
         hp+cnUMvnITTbvKaNTXl07JdHoz+lGr+X/aXxb52r7wymAxIwAIlxeIHxKP3vsHuijiw
         eKuG/BOL2Jok/B9WT8pPYUhfJYFKk38jGlzqBHlvKuiGPUu5XDHXAr2LPnEu6Rloyt+W
         JCjDKRBdf8/ZZBamqF8rAC0KvR9N6tjia/WnhQgoFQE0X2V9opZjTcdwxnqaV7Xt8Hv1
         q3fTPwUJeU8+AFSdVnASzguBS9QvQSpSqKPMg0TiRl+NXPG7ObOlcOmYUwi6HWl/BBfB
         dm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+LcyMNkInxJbEkI4dZYVXRRy3OSinTohFLJ8BhSGEI=;
        b=BzjThSeC2mL63ERPJbI8Fs212tyXV+Q5LFhfqm8sh+JrOqja+N63NchOHoGNoZS9Av
         8rz+kF0gQ5aREU4hqjnzyH8iTR982qlzULn4ymD+FVJz60tpiMqbdjiijkMiM1eqxr8J
         gM7XF2F99IUz11MZPxRvGQB+lWx0ZEryHe0/zrwYnxX77+YkqUDYiOZYsWhY94lrRcHi
         9u9MT5hhS7jDNjlb2sPaGh3tV9qeBxsi7HEg8YkzD9rzQK3TTjBaDi/4P2MPLZO35LSf
         k1jPHiE3WDFqpGjn3DxLuGmzGLSz46NpF1lm9lCPn9Yo8I3YFl9T7CXQrlqchI2cEDl2
         KB1g==
X-Gm-Message-State: ANoB5pli/miXVX9RHL+1xSKVFTFGDraUNy9G+3SUKXgSQcpDU+j9FwFt
        Se58acC7KecpBBruW4rnsIhzX6p1kWI=
X-Google-Smtp-Source: AA0mqf6CBR8r/3p+/QPQA85y/BjrtndOTwIpc+lEGZVk9wmvkrbQpdqmtw1o1xb/PSRNT6TmR0gzHWc6jeY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:ec10:bae8:fee8:751d])
 (user=glider job=sendgmr) by 2002:a17:906:1188:b0:7b2:c594:2182 with SMTP id
 n8-20020a170906118800b007b2c5942182mr2246482eja.290.1668792190132; Fri, 18
 Nov 2022 09:23:10 -0800 (PST)
Date:   Fri, 18 Nov 2022 18:23:05 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221118172305.3321253-1-glider@google.com>
Subject: [PATCH] x86: suppress KMSAN reports in arch_within_stack_frames()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
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

arch_within_stack_frames() performs stack walking and may confuse
KMSAN by stepping on stale shadow values. To prevent false positive
reports, disable KMSAN checks in this function.

This fixes KMSAN's interoperability with CONFIG_HARDENED_USERCOPY.

Link: https://github.com/google/kmsan/issues/89
Link: https://lore.kernel.org/lkml/Y3b9AAEKp2Vr3e6O@sol.localdomain/
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/x86/include/asm/thread_info.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index f0cb881c1d690..f1cccba52eb97 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -163,7 +163,12 @@ struct thread_info {
  *	GOOD_FRAME	if within a frame
  *	BAD_STACK	if placed across a frame boundary (or outside stack)
  *	NOT_STACK	unable to determine (no frame pointers, etc)
+ *
+ * This function reads pointers from the stack and dereferences them. The
+ * pointers may not have their KMSAN shadow set up properly, which may result
+ * in false positive reports. Disable instrumentation to avoid those.
  */
+__no_kmsan_checks
 static inline int arch_within_stack_frames(const void * const stack,
 					   const void * const stackend,
 					   const void *obj, unsigned long len)
-- 
2.38.1.584.g0f3c55d4c2-goog

