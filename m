Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D30773FADE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjF0LQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjF0LQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:16:33 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4131FE2;
        Tue, 27 Jun 2023 04:16:32 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3524588a12.3;
        Tue, 27 Jun 2023 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687864592; x=1690456592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T9iTeVNQzTAU/7wMteUmuuKnmFgHV1312sTxoQaB0Y=;
        b=oRdVZMq7mZxqe5psKMkwXd3Pw7E2LBRN1zI62YKG2ZUagZMZvBOaW2F9ZW9XvWMIem
         5GyPj+pWI7ZrRpbvuj/HijnqITvfZ3fDXPaCMDtnDFIakgmO0tpimV9TGLMfEnC8LM+F
         fptP3WOvzCaIWzuCBafL3fgGpNIFzr9Bxo5J9MforIUYiCLhfclAmSU7ZSwii4OoSoJF
         v9WIIRAC/utMm8EZJo01UjbwSynpl/EhFdewcOXrLobY+3BUHOqFkObXKyfJY0Iyes23
         34z+nEnNAOZ6yl+JvGVmMCtJqPdQ5Tj3dGPCFFDPo76vRmBoRWgzWbODKJR353dtz0sM
         zxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687864592; x=1690456592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T9iTeVNQzTAU/7wMteUmuuKnmFgHV1312sTxoQaB0Y=;
        b=jwxMaROYpZjMhf+uGvXMQDO7Mg3f1oOceCpgVn7jbPwnkl8pvoSjdrY3xRnG6z467d
         g82CaH6uFg0J0qHeGPFU3kpk/3XydziU5c4w+UYDtrXFHCweISH0wJvyfCavvNsrILuW
         Vqhnyo2dzOBFQvBFPcmgDrIo22LR4Ur2YRjiuhvBEqjn4HHZ46V8HUAj3FZ1QRRY9rJG
         AtwpHh91Ax2gwSYsVamRirD+k4oFMLN8hwIQW/g2obnrjxvsfLyiznV+i6ixiDBKFxj1
         Kctx/YzUeaDJQt/bNMkJZM2+O5yAbd+5VIz+zZ6zVyjI18gFocSEPCYhliPypxpWADeP
         fOxQ==
X-Gm-Message-State: AC+VfDy9Pany6nIHx4heNh5394T/sPTHdK2IHcfwfTmjl+5vxNtflvDZ
        oGdbm3cW4j/rRK/paVOjxS4=
X-Google-Smtp-Source: ACHHUZ79Fi8jt2Wz+6tpKuWWobH/1Bfv1d7qGECksB47nYmt7I9vII5rUXyK39VKG8wiF7jntfi7Qw==
X-Received: by 2002:a17:90a:2f06:b0:25b:bae6:3c67 with SMTP id s6-20020a17090a2f0600b0025bbae63c67mr31684018pjd.43.1687864591997;
        Tue, 27 Jun 2023 04:16:31 -0700 (PDT)
Received: from localhost.localdomain ([58.240.82.166])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a004800b00262d6ac0140sm5438658pjb.9.2023.06.27.04.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:16:31 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, suagrfillet@gmail.com,
        bjorn@rivosinc.com, jszhang@kernel.org, conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, songshuaishuai@tinylab.org
Subject: [PATCH V11 1/5] riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Date:   Tue, 27 Jun 2023 19:16:08 +0800
Message-Id: <20230627111612.761164-2-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230627111612.761164-1-suagrfillet@gmail.com>
References: <20230627111612.761164-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In RISC-V, -fpatchable-function-entry option is used to support
dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
don't have to be called to create the __mcount_loc section before
the vmlinux linking.

Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
Makefile not to run recordmcount.

Link: https://lore.kernel.org/linux-riscv/CAAYs2=j3Eak9vU6xbAw0zPuoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
Link: https://lore.kernel.org/linux-riscv/Y4jtfrJt+%2FQ5nMOz@spud/
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Acked-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5966ad97c30c..756d854e6cdd 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -59,6 +59,7 @@ config RISCV
 	select COMMON_CLK
 	select CPU_PM if CPU_IDLE || HIBERNATION
 	select EDAC_SUPPORT
+	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
-- 
2.20.1

