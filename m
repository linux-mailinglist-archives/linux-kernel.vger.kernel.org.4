Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA4563BBDA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiK2IlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiK2Ik7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:40:59 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1770610AC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:40:54 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so16609677pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rYD5rIQKhS/OhTx0Z2BOJefPOcSuVOVdbyHaSlf2Gvk=;
        b=QNsN6i4r6SXUwQcFRSHAlDdrcAN+sj+wmkOJGOBnCOm3GfQKq4KetYR5dc3ySxrFAZ
         GjpTQOBSIXHsywGpW1SgUPg6Q4FaabNkCQ+VWDX2Pn4TEJj2rFpEOxMLt+JXGd1DHUCw
         REusv+3eduQdc9pq39kuRnxUdKGzS0RYb14kGosLxYoKLMR1iPxcAuIJj5w3JMBwd5Dr
         zOIBbJJQsVovA3H9PUgKHQjMvEpchSgxnaa2YjPIaZVFEwNRouh3iQjh1cveISu3au9+
         Fxwry14fxKV3FoxaKLpt0p7xJuvnuqLWIGp4V/Gs5anWRvo2uBRFeTxrIPYb51kKsLeg
         wFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYD5rIQKhS/OhTx0Z2BOJefPOcSuVOVdbyHaSlf2Gvk=;
        b=moEBLqjNk4c/XB2FEBRLk7qktDuXnR/01SW00chL5OcMrGUD1DIcwRR9JS2SJorgVo
         Dp7WkwAnPnrMyaT2BrCDIVHoxgD80WTgBoAJHEra2z5H6i8PQ1hZJx/G4enKXsNYf9NW
         RnqAPGEyQPKmejzv2v3535k9QWNdL9BY6yf479twYHGw+H/KLQS2WCrdl8ejlTSuJwxK
         50jQBKZOLFBsF7dlzouBuvAEJO6mzCc50daiAXFwjN6jrJPvwrHrqHeSUjqft7Ujfsio
         17uFm/xtDCmRxbwJcm16v1Eg2bgyxOZJbV2TLvaG465oIDgFl4K4+vKZefqPHSL7UZzu
         aWRw==
X-Gm-Message-State: ANoB5plSMK+ZClFc2Iua/6ju1RYG+igDfosWrqRnqNi9HeBSDKFv/LS/
        MJSCGi0A12QF12X9US777Gg=
X-Google-Smtp-Source: AA0mqf47JmtIb2NvfkQgu889YntCw6oa8afXgVRXQefMosergFiVq3Km37AXVvKfwMgfGPZlzKSqtw==
X-Received: by 2002:a17:90a:d38b:b0:218:821e:f734 with SMTP id q11-20020a17090ad38b00b00218821ef734mr55232023pju.87.1669711253527;
        Tue, 29 Nov 2022 00:40:53 -0800 (PST)
Received: from localhost.localdomain ([47.242.114.172])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b001801aec1f6bsm10239317plk.141.2022.11.29.00.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:40:53 -0800 (PST)
From:   Chuang Wang <nashuiliang@gmail.com>
Cc:     Chuang Wang <nashuiliang@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/kprobes: Use switch-case for 0xFF opcodes in prepare_emulation
Date:   Tue, 29 Nov 2022 16:39:51 +0800
Message-Id: <20221129084022.718355-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the `FF /digit` opcodes in prepare_emulation, use switch-case
instead of hand-written code to make the logic easier to understand.

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
 arch/x86/kernel/kprobes/core.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 66299682b6b7..66ec32b6cd0e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -655,17 +655,19 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
 		 * is determined by the MOD/RM byte.
 		 */
 		opcode = insn->modrm.bytes[0];
-		if ((opcode & 0x30) == 0x10) {
-			if ((opcode & 0x8) == 0x8)
-				return -EOPNOTSUPP;	/* far call */
-			/* call absolute, indirect */
+		switch (X86_MODRM_REG(opcode)) {
+		case 0b010:	/* FF /2, call near, absolute indirect */
 			p->ainsn.emulate_op = kprobe_emulate_call_indirect;
-		} else if ((opcode & 0x30) == 0x20) {
-			if ((opcode & 0x8) == 0x8)
-				return -EOPNOTSUPP;	/* far jmp */
-			/* jmp near absolute indirect */
+			break;
+		case 0b100:	/* FF /4, jmp near, absolute indirect */
 			p->ainsn.emulate_op = kprobe_emulate_jmp_indirect;
-		} else
+			break;
+		case 0b011:	/* FF /3, call far, absolute indirect */
+		case 0b101:	/* FF /5, jmp far, absolute indirect */
+			return -EOPNOTSUPP;
+		}
+
+		if (!p->ainsn.emulate_op)
 			break;
 
 		if (insn->addr_bytes != sizeof(unsigned long))
-- 
2.37.2

