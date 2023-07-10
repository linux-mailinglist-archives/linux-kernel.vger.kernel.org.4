Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159A774DFFD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 23:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGJVIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 17:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGJVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:08:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA2ABF;
        Mon, 10 Jul 2023 14:08:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307d58b3efbso4901456f8f.0;
        Mon, 10 Jul 2023 14:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689023291; x=1691615291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wREkc9/s2frBQXho8+/CmRUkUf/FKLAaYC6JcuNeuKw=;
        b=AOa/4+nDWhX8zfxWmovYsSScEa4jmw+KEHo/LrsK1V7QSZ0S/i8tBBN8oW0o4Cmkw5
         BUVboHgy9+V0i2v912vrXnZLoh9g2PIIIDCQDMaptj23UBAsOLGiJgZTuDfP76nwsuR7
         DkQJbjyxIMMu/JV8x6yjPnl5u4B1KISE7UeIxLU/fAXSCx4nD0cNx+sNKor8Hl9ADzoE
         5MCtaaMRf+FW9k0avTPTyRBY8HeBsGDe55mof7iodo3DzK9zgw5GiQrjlWbIWtlPBMkm
         zPpjtTI0Nh5jXIkF+BX4W9peDNuRTr+QUmdCQGv+ScNTXkmpdQUKXiA5OmraFaej2H9M
         UfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023291; x=1691615291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wREkc9/s2frBQXho8+/CmRUkUf/FKLAaYC6JcuNeuKw=;
        b=deE/bKX6I4fDT2FShZkUd1zcVsMLRJTKfe8aTRW/ABl5+ovG4Rf4ZqbCrS8oXJ/PNp
         wdZRyOrb7BFYMGlb4l1VdGsAJLhrkuhXwyn89maYDzzRyo1Yz7OSpifRe4oi+eQBwdBt
         5cJM3PgxS3EBJT6VnTk3SrEmkbFA7LlrSMJGzQ+tYIk3vm4S13/wzhgP7z1ZsSyatiJZ
         1RtaM5hXfdVEmtlhoHnErr6U39fkgKPjBzuPJcnpSNszqGbQNOEh5wnE4MiqqZoF8plh
         gC6efNjaPg5YPsXza3Td50riz4gcvFDyvIjXr+VI81giSKyt85lYw6q3A7+7WkM4kzBE
         72uQ==
X-Gm-Message-State: ABy/qLb3UKM9miJpV/D8gUZVb7SD9rWqwI7SuuNncD++fBLumXLkRDTQ
        kx//DI2QS8a6Wd7y0bQ2cexazyaE5sgLgA==
X-Google-Smtp-Source: APBJJlHYBAcwrGSqDfxFbssGAqXTqJroNEjE/qAl+zAEuxHi7EuOR7UuLqv3UPiQ6thnN1dT7+FuxQ==
X-Received: by 2002:a5d:6b47:0:b0:314:152d:f8db with SMTP id x7-20020a5d6b47000000b00314152df8dbmr10481002wrw.58.1689023290492;
        Mon, 10 Jul 2023 14:08:10 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4e05000000b003143d80d11dsm364606wrt.112.2023.07.10.14.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:08:09 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rich Felker <dalias@libc.org>, Stafford Horne <shorne@gmail.com>,
        Szabolcs Nagy <nsz@port70.net>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-openrisc@vger.kernel.org
Subject: [PATCH v4] openrisc: Union fpcsr and oldmask in sigcontext to unbreak userspace ABI
Date:   Mon, 10 Jul 2023 22:08:03 +0100
Message-Id: <20230710210805.131666-1-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 27267655c531 ("openrisc: Support floating point user api") I
added an entry to the struct sigcontext which caused an unwanted change
to the userspace ABI.

To fix this we use the previously unused oldmask field space for the
floating point fpcsr state.  We do this with a union to restore the ABI
back to the pre kernel v6.4 ABI and keep API compatibility.

This does mean if there is some code somewhere that is setting oldmask
in an OpenRISC specific userspace sighandler it would end up setting the
floating point register status, but I think it's unlikely as oldmask was
never functional before.

Fixes: 27267655c531 ("openrisc: Support floating point user api")
Reported-by: Szabolcs Nagy <nsz@port70.net>
Closes: https://lore.kernel.org/openrisc/20230626213840.GA1236108@port70.net/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Changes since v3:
 - Fix typos in commit message
 - Add back change log
Changes since v2:
 - Don't use a struct in sigcontext as hinted by Rich Felker
Changes since v1:
 - Rather than revert the change, just use the oldmask slot for fpu state.

 arch/openrisc/include/uapi/asm/sigcontext.h | 6 ++++--
 arch/openrisc/kernel/signal.c               | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/uapi/asm/sigcontext.h b/arch/openrisc/include/uapi/asm/sigcontext.h
index ca585e4af6b8..e7ffb58ff58f 100644
--- a/arch/openrisc/include/uapi/asm/sigcontext.h
+++ b/arch/openrisc/include/uapi/asm/sigcontext.h
@@ -28,8 +28,10 @@
 
 struct sigcontext {
 	struct user_regs_struct regs;  /* needs to be first */
-	struct __or1k_fpu_state fpu;
-	unsigned long oldmask;
+	union {
+		unsigned long fpcsr;
+		unsigned long oldmask;	/* unused */
+	};
 };
 
 #endif /* __ASM_OPENRISC_SIGCONTEXT_H */
diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 4664a18f0787..2e7257a433ff 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -50,7 +50,7 @@ static int restore_sigcontext(struct pt_regs *regs,
 	err |= __copy_from_user(regs, sc->regs.gpr, 32 * sizeof(unsigned long));
 	err |= __copy_from_user(&regs->pc, &sc->regs.pc, sizeof(unsigned long));
 	err |= __copy_from_user(&regs->sr, &sc->regs.sr, sizeof(unsigned long));
-	err |= __copy_from_user(&regs->fpcsr, &sc->fpu.fpcsr, sizeof(unsigned long));
+	err |= __copy_from_user(&regs->fpcsr, &sc->fpcsr, sizeof(unsigned long));
 
 	/* make sure the SM-bit is cleared so user-mode cannot fool us */
 	regs->sr &= ~SPR_SR_SM;
@@ -113,7 +113,7 @@ static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	err |= __copy_to_user(sc->regs.gpr, regs, 32 * sizeof(unsigned long));
 	err |= __copy_to_user(&sc->regs.pc, &regs->pc, sizeof(unsigned long));
 	err |= __copy_to_user(&sc->regs.sr, &regs->sr, sizeof(unsigned long));
-	err |= __copy_to_user(&sc->fpu.fpcsr, &regs->fpcsr, sizeof(unsigned long));
+	err |= __copy_to_user(&sc->fpcsr, &regs->fpcsr, sizeof(unsigned long));
 
 	return err;
 }
-- 
2.39.1

