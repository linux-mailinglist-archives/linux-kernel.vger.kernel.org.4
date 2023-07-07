Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1853B74B8A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjGGVXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjGGVXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:23:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE1F1FD9;
        Fri,  7 Jul 2023 14:23:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so26074335e9.2;
        Fri, 07 Jul 2023 14:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688764981; x=1691356981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jpRfv0tpTRGbIbIqr1xIENMhATsCOnSuVBh9rAn5bZc=;
        b=axzxEZcw2zNOny2sJyy26SKtO5JrSbx/+rijTVpE05o6yXzznFK90jjrz4cbWUBKgJ
         OOu/dkH6tJiMfdRQf8EhhP4DCWOMVj2TIxcesnF0p0svQfxKMoZWK0PUiIQuHKwJ6xOo
         NPLzt001Au678jD5uu8ywVdTTYBdYRCh7jpkqgmgTmAfX+eB4jFgIcwFp9bVqkLjDgKI
         fz4g7TKtDZYZWq/5LWPbfmW0805CHg2zoJgY6+oHAqls/j63cNUjtWBRcLEbm88l40lV
         /xGQycAIvOzmlBch3WzMNL8BUDabUkJ2KWb1sv4HabB8lr30sMcOLpyFYVg6BEx1oRGY
         ANwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764981; x=1691356981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpRfv0tpTRGbIbIqr1xIENMhATsCOnSuVBh9rAn5bZc=;
        b=dYW+BttHGOPZe8BPMbXUjwk90icQPufDBY1iUIkeJzrniGFPTuF9E8sCpp/kQ8AHwK
         t9lEfaNJNIQhl24uxN6btZsQ3dS7H8q1krrqhK2rNhInXfOUj9BwYvTJdhZqQfYBKwP7
         LHdVnPzq+ycGh5RKO2LsF4jex242XXA5tQ95rEewv33oV1pxx1AlvMj09FN8ALUS8kFY
         LEMu3VNXoEBbPElRRruV55r93Ji271Xbm0FvTjx84XNYDGISqVxmjou1YSBgTXIvA5BI
         ODfDnYsS1aWATcT8zyfEFK87pZSTbUw8EdbIvRD50qUduQWtQPdnTJn5cdublgmbz8VG
         ZpaQ==
X-Gm-Message-State: ABy/qLYKf/nnmtq5/dXLa4OwyFX2s9DgAxEIZ0GAYP+QI76WXwe1UDuF
        FeCR8+CqafYTFXFlEH+56OOCSTk46uBY9g==
X-Google-Smtp-Source: APBJJlFilQqKe0tgUtdNgxbwpDDWCEY9+HZ6b4q+j04Nd9A4l69EReQo/F6tdvSZ3h/krgSvsHDfhA==
X-Received: by 2002:a7b:ce87:0:b0:3fc:2d2:caa8 with SMTP id q7-20020a7bce87000000b003fc02d2caa8mr947641wmj.29.1688764980599;
        Fri, 07 Jul 2023 14:23:00 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id n21-20020a1c7215000000b003f91e32b1ebsm3440529wmc.17.2023.07.07.14.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:23:00 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rich Felker <dalias@libc.org>, Stafford Horne <shorne@gmail.com>,
        Szabolcs Nagy <nsz@port70.net>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-openrisc@vger.kernel.org
Subject: [PATCH v3] openrisc: Union fpcsr and oldmask in sigcontext to unbreak userspace ABI
Date:   Fri,  7 Jul 2023 22:22:51 +0100
Message-Id: <20230707212252.3898950-1-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 27267655c531 ("openrisc: Support floating point user api") I
added an entry to the struct sigcontext which caused an unwanted to
change to the userspace ABI.

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

