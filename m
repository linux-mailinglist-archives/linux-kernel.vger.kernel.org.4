Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FBD639974
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 07:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiK0GX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 01:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiK0GX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 01:23:56 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A2113E85
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 22:23:50 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id io19so7386798plb.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 22:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=72GXX8ZYM+/F11yUI2R0qGFMz7iU9xS9gHw3n6THSFw=;
        b=DuS4VioqpRy9NFmVGMIemRyEgh/7Ge23dr43cJylPR/vs811Zoy67oR1VPL2C5c9XY
         3RWh1CgOyX9gjBH9reYmNTif46fvJS0LHYNkcL5qpPebnOyeY5ZUS5FcC7GwUFDWFUM0
         qKJdj318/PLSNlzwvg9hcolblHtohCtt222C0mz+WiRHl6pFsu+iBYUxlorWiComrXnp
         HyEWbpbWbXdalr7pgIVbhU7A6Cn0YiGb8Tf6eWbCDzliE1SPS6K5dnLWN03SeeEG0xFf
         wq7hHxnAPKQiTxo0Tps7f7qKArP4ulSPk9tRb2Bv0+Nof1jELdLlZpvKTbAUbP3Fi/vO
         8Z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72GXX8ZYM+/F11yUI2R0qGFMz7iU9xS9gHw3n6THSFw=;
        b=c5z3PnrJgeZHqXz8HqtBJVWUN9iJJH4DCpuqZIQF0CZq8i76A1ubN74dN9Bdqa+pxm
         MMfEtOS98SbbtzrqsfnZJFOVmswkn+DOpSyxE7ILcfUm8G4C4e7ambWBGIpesLsa401O
         36dte1p1ofLhDney7KAXmbkaPNFj+sR9rfa/mJHt63DWXv4UxciDx3lvKP1IagxD2pc2
         GZTMDlXje4f/uyMuvAdB1vkqsrHhcHv74bVG/p1aYlQe8AQvzlS0b7yvUXEOwls7UxSj
         T3xdqhkUrQSCorp46+1i5oyX9FbGWS/CEusw1X2kdt/ld358oNqrbIlmtmLnbYNe3ZOY
         C8LQ==
X-Gm-Message-State: ANoB5pkYAPfP7CpBDcG6bRFPlQA1MZXUvMR00D/lbfxEORrBRpN2g5Oy
        Pdn/VX3D4CALkg5SG7iVXtc=
X-Google-Smtp-Source: AA0mqf76JFM4izP/3hWZ5aRcumD6yEc9qpF65R75H8Z2R0X8bp4O6ZtsznzkQrSsxy6gQq5V9WB8CQ==
X-Received: by 2002:a17:902:ef47:b0:186:a394:aef7 with SMTP id e7-20020a170902ef4700b00186a394aef7mr40034160plx.79.1669530229649;
        Sat, 26 Nov 2022 22:23:49 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709027e8700b001769206a766sm6177918pla.307.2022.11.26.22.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 22:23:49 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] x86/asm: Remove unused COMPILE_OFFSETS macro from asm-offsets.c
Date:   Sun, 27 Nov 2022 15:23:35 +0900
Message-Id: <20221127062335.330758-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following [1], the macro COMPILE_OFFSETS becomes unused:
  $ make W=2 arch/x86/kernel/asm-offsets.o
  <...>
  arch/x86/kernel/asm-offsets.c:7: warning: macro "COMPILE_OFFSETS" is not used [-Wunused-macros]
  <...>

Remove COMPILE_OFFSETS macro.

[1] commit debc5a1ec0d1 ("KVM: x86: use a separate asm-offsets.c file")
    Link: https://git.kernel.org/torvalds/linux/c/debc5a1ec0d1

Fixes: debc5a1ec0d1 ("KVM: x86: use a separate asm-offsets.c file")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 arch/x86/kernel/asm-offsets.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 437308004ef2..cf2e02bafbef 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -4,7 +4,6 @@
  * This code generates raw asm output which is post-processed to extract
  * and format the required data.
  */
-#define COMPILE_OFFSETS
 
 #include <linux/crypto.h>
 #include <linux/sched.h>
-- 
2.37.4

