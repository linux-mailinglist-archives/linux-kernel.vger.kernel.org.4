Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1D75F874C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 22:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJHUOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 16:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJHUOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 16:14:45 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747902720
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 13:14:44 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so8886188fac.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XHx3X9LziObAexksOpffeVkKG/1z7y76WbQ1Tlfnt2g=;
        b=lQsDaLFr2MJET6QUQfFYg6DA1rhd1TQaqaGTdbplgOkyYZ6oHI6V18W2n+Qrz3tF8g
         0+bXzUHsOoLBXHOiWsNRHP2i3GrOPUROYE5ZTcxJwbGGQKBBz0ibv0DzXot1H+fBaSU1
         Y1QYNaPL3xfkGVUZe5lhfTsne4uKiWt0feiHV+MQ7/ayCLXzNZgkFSXS7M8Cv+YOIVmT
         IXI0o4UXTxTz6Egvs/a7+pmvRTQeZRwLYGuVCR8WhVtj8ZjhjkBqGtZBUX/0UHHwTUbz
         Ca8gDI+H9uxLzIeaQfTCxVGkhFmjQZZXRubPm0O4Qvz+5RR/9DgGZ9EtTqG3fJ0Ns0Rv
         CkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHx3X9LziObAexksOpffeVkKG/1z7y76WbQ1Tlfnt2g=;
        b=FYlxMWKNsyX4UAqsQ8XYsjPGgAvwrkWeS7MHsfcrBKZUrgDbNqXPY4ZxGLHl8yWSvI
         dmamzSYIQpXTmFJqgTrylvfklxCjXPOtMkOWm2AUsjOD6VWv68oEIGGYi1EcAqiWmdbe
         anZY2Exq0XdTCys1NiwCW72lQ5OpcGfBXVfnKCRAOeRG4HOAo+i3cdMOjSiN8GwyUwjS
         TyrO2SmrzIroC2d1Hc97j2paOQ8LvaBi1xXinqMrXBNKJXNZGmG+SHyrxhSFfSwiKuV0
         3N+kIvTiPpER2YHm2VAO+ydnY5DhrqjB+RocIyS6uZxH8X9AzhmVJGQ5DTuFwQxsGBZ1
         u+lg==
X-Gm-Message-State: ACrzQf3peeiuSOWM62FjQVvAleXBxOBb1pEc1MqEOS1sCp3lXhXI6pTe
        E5RnLGhLXDnKxDbsxvVdEwO1NAiBkA==
X-Google-Smtp-Source: AMsMyM5yhL9nyMMOMNpMmuqDdfBMdWQVI6cohRBMzCGy/ChoOi9tS2/Gjq4k8goMcjTXutUFh147yg==
X-Received: by 2002:a05:6870:d626:b0:132:9149:dc8a with SMTP id a38-20020a056870d62600b001329149dc8amr10940767oaq.141.1665260083642;
        Sat, 08 Oct 2022 13:14:43 -0700 (PDT)
Received: from citadel.. (075-134-122-108.res.spectrum.com. [75.134.122.108])
        by smtp.gmail.com with ESMTPSA id az14-20020a056808164e00b0034f684ca159sm2437919oib.29.2022.10.08.13.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 13:14:43 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH] x86/alternatives: Remove double patching in ALTERNATIVE_TERNARY
Date:   Sat,  8 Oct 2022 16:14:29 -0400
Message-Id: <20221008201429.102040-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ALT_NOT(feature) instead of X86_FEATURE_ALWAYS to avoid patching the
code twice when the feature is present.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/alternative.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 9542c582d546..f4efce972277 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -181,7 +181,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, feature, newinstr_yes, newinstr_no) \
-	ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
+	ALTERNATIVE_2(oldinstr, newinstr_no, ALT_NOT(feature),		\
 		      newinstr_yes, feature)
 
 #define ALTERNATIVE_3(oldinsn, newinsn1, feat1, newinsn2, feat2, newinsn3, feat3) \
@@ -386,7 +386,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, feature, newinstr_yes, newinstr_no) \
-	ALTERNATIVE_2 oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
+	ALTERNATIVE_2 oldinstr, newinstr_no, ALT_NOT(feature),		\
 	newinstr_yes, feature
 
 #endif /* __ASSEMBLY__ */
-- 
2.37.3

