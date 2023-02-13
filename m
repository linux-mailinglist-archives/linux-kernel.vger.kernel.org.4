Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D262E693DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBMEzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjBMEzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:55:09 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B41258A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:36 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso3099188pjn.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kFxia6anvFekuQwjCC0QPCBdBTnfubmGffGfTpNbSM=;
        b=Afh0xW9utFfUPrEQU4hWTDRSLlXwhIpd8cKrKCCTb090OxZcC7+dw1lGI4WLigSRcR
         SlTrKyg46yjgyducZFlnzNgMFLW5ERNIE51qDZs52oKKqKeicOr0GQ+2vSpH+tMZHU2f
         xYrN3xaSDbe059vhC8YmE0Mo0lm4LvpwwnWJlS9G0hlCENclXKagmo2zWcBcb/mdENgY
         1gAOJIewodgaQQlqmUK6bvaKGXX2/aGrqMFG9OmQDkZFfYSfsjHFpOrGmHNtyqkqNXHp
         spSkkxoNxWE3KUzm1/n3/sYW083aXMKfQdw4fAAEkBpyepXmSDGgPYoR/nS0jY3uaDuw
         o80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kFxia6anvFekuQwjCC0QPCBdBTnfubmGffGfTpNbSM=;
        b=HjELvOLvvmCruCvG9BwYML0DEwZ2KHzJMcsvSNGJ5KndrssaDcddsLyVkK75Ntb27t
         1IW3wb3PQQQMjZ/y58dS3whZ2p7SIBqjcp+O60Gqeag6qg1k6DjalCC1lfbpnvHgVT38
         R9oNY+gKT/+l59lGovEw8aCzMTR7RBPQJyFun4I9vJAXb+wBSb/IVqmFArAzE+440xPJ
         Q15/4fByaEg3HfaOmh/t7I+EJV6mXzvVQr63oOM9QaxRXgJMAbrY05HhueGp0eycr0Gx
         ETpW4Ac6Gsl6UI4iY3PkYS0sdSpKnYa76VYNeRbPmngLlM5w9ll5zF9zfvLpVlINSuvo
         TbDQ==
X-Gm-Message-State: AO0yUKVMIU5qzbvvnSkPcnHS2Yud/NNQ+rNlyjqm79Vh66EQtWm3FKWU
        +7LiDSa13Zb23W4xjR2jajp7Sz7YO/fsgxc2
X-Google-Smtp-Source: AK7set9VuKBu8EY+mqmdMSQsVnXb77Y1JO5W24ZyHIbOWCePXvCVZrSZJKZ86C/lIOIyZdIFSrBmVw==
X-Received: by 2002:a17:902:f64f:b0:198:adc4:229f with SMTP id m15-20020a170902f64f00b00198adc4229fmr16162307plg.26.1676264066962;
        Sun, 12 Feb 2023 20:54:26 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:26 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 17/20] riscv ucontext: adding shadow stack pointer field in ucontext
Date:   Sun, 12 Feb 2023 20:53:46 -0800
Message-Id: <20230213045351.3945824-18-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213045351.3945824-1-debug@rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shadow stack needs to be saved and restored on signal delivery and
signal return.

ucontext structure on riscv has existing large padding for possible
future extension of uc_sigmask. This patch steals XLEN/8 bytes from
padding to keep structure size and offset of existing member fields
same.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/ucontext.h | 32 +++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/include/uapi/asm/ucontext.h
index 516bd0bb0da5..72303e5618a1 100644
--- a/arch/riscv/include/uapi/asm/ucontext.h
+++ b/arch/riscv/include/uapi/asm/ucontext.h
@@ -21,9 +21,12 @@ struct ucontext {
 	 * at the end of this structure and explicitly state it can be
 	 * expanded, so we didn't want to box ourselves in here.
 	 */
-	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
-	/*
-	 * We can't put uc_sigmask at the end of this structure because we need
+	__u8		  __unused[1024 / 8 - sizeof(sigset_t)
+#ifdef CONFIG_USER_SHADOW_STACK
+				   - sizeof(unsigned long)
+#endif
+				  ];
+	/* We can't put uc_sigmask at the end of this structure because we need
 	 * to be able to expand sigcontext in the future.  For example, the
 	 * vector ISA extension will almost certainly add ISA state.  We want
 	 * to ensure all user-visible ISA state can be saved and restored via a
@@ -31,7 +34,30 @@ struct ucontext {
 	 * infinite extensibility.  Since we know this will be extended and we
 	 * assume sigset_t won't be extended an extreme amount, we're
 	 * prioritizing this.
+	 */				  
+
+	/*
+	 * Zisslpcfi will need state in ucontext to save and restore across
+	 * makecontext/setcontext. Such one state is shadow stack pointer. We may need
+	 * to save label (of the target function) as well (but that's to be decided).
+	 * Stealing 8 (64bit) / 4 (32bit) bytes from padding (__unused) reserved
+	 * for expanding sigset_t. We could've expanded the size of ucontext. But
+	 * shadow stack is something which by default would be enabled via ELF.
+	 * ucontext expansion makes more sense for situations like vector where
+	 * app is willingly opting in to get special functionality. Opt-in allows
+	 * for enlightening in ucontext restore. Second reason is shadow stack
+	 * doesn't need a lot of state and only shadow stack pointer. Tax on
+	 * ecosystem due to a small size change (8 bytes) of ucontext is more than
+	 * simply keeping the size same and shoving the ss pointer in here. Please
+	 * note that shadow stack pointer is pointing to a shadow stack address.
+	 * Shadow stack address has shadow stack restore token using which shadow
+	 * stack should be restored.
+	 * Please note that we're keeping uc_ss_ptr at that this location so that
+	 * every other offsets are same and thus works for compatibility.
 	 */
+#ifdef CONFIG_USER_SHADOW_STACK
+	unsigned long uc_ss_ptr;
+#endif
 	struct sigcontext uc_mcontext;
 };
 
-- 
2.25.1

