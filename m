Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C766863F35E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiLAPOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLAPOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:14:00 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E41999F3E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 07:14:00 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id k79so2135234pfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 07:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/er6mpZXuoOXiwjII93qCAD0DwhwK6TrNP8twH3ex9c=;
        b=Wh42ilCrtHogvmaFxBSyOZkt9nk1GMDPGzbrMCvJqS4LX9nGXWV3BTsxxgqqX4pNDW
         pzZzVVkViYwtb3woFOL2sBIEQ+xa3ceXjzFC77TfjktFqbm8tjMuyDWjs2DHyrtFKSZX
         esfCXo1cepoNbyjO0//ov0aSQradFf0ofVzZpSjkP7Ft+cWCcJGanQJQuZ/9DCTQQeT+
         YdULKrVNJYFTrPeWP9Bh/YEIg7Kd4sFE/zTVECh5GbQZ5ZjQM/jEU7FOJYWJ6fB2vKlv
         i3RluPWBAC7jx9ZuPMtYgRF5wHnCs/iD5pRboq/U8la8UIKoSiQWUclbYNEhOF8XqjGj
         yASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/er6mpZXuoOXiwjII93qCAD0DwhwK6TrNP8twH3ex9c=;
        b=qR9N7RkJh8uYE06osvEuW9aEhzMHCyta/qHDjQ0idmfzhXUc2mUWR2//+nXwyjvVGe
         fyDYxLX9rrxv5aFVDZuwWFlRQGqNEXmG4FPiC1zyBz7p3fPO3DHJ2EIPYkidvs9/vAEc
         G0Ro6cdRrz1lHv/Nm4u7wtGoLSbVRntyiWX5vgquBEGVXOyvDkcHtRWBW2j7+PSeGASH
         zNJdACjluKTSn6GlSZMNChF1dGbfQylMG2AieY1C6VddwBBabjET9BSVuo8TofQvBFtP
         6JecOuy+l4xLxpC3VxgrUIjmGs7rTKT+kmHNkZx2EomMF46G80g6cKym0apP+kT71+d8
         cFrQ==
X-Gm-Message-State: ANoB5plx3hscW8BSgqfYWwO5iT89DXLkdg0VtdQgBrZvioARHfof5/U1
        sCPJ1LA/7fo0Kr//Exk3NEqUYSfS890=
X-Google-Smtp-Source: AA0mqf4wg1LApXKzAVVBhTOwJDdWKh84yT8AM7iTreutx1Uu7x2S5xSi20wRnhDAkZVcxljrbKbMaw==
X-Received: by 2002:a63:6742:0:b0:478:538a:8d1b with SMTP id b63-20020a636742000000b00478538a8d1bmr9700251pgc.140.1669907639530;
        Thu, 01 Dec 2022 07:13:59 -0800 (PST)
Received: from localhost.localdomain ([112.2.230.25])
        by smtp.gmail.com with ESMTPSA id z32-20020a17090a6d2300b002190eabb890sm4996174pjj.25.2022.12.01.07.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 07:13:59 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        atishp@atishpatra.org, heiko@sntech.de, anshuman.khandual@arm.com,
        suagrfillet@gmail.com, liaochang1@huawei.com,
        juerg.haefliger@canonical.com, wangkefeng.wang@huawei.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] riscv : select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Date:   Thu,  1 Dec 2022 23:13:36 +0800
Message-Id: <20221201151336.8044-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
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

In RISC-V, -fpatchable-function-entry option is used to support
dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
don't have to be called to create the __mcount_loc section before
the vmlinux linking.

Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
Makefile not to run recordmcount.

Link_v1: https://lore.kernel.org/linux-riscv/CAAYs2=j3Eak9vU6xbAw0zPuoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
Link_v2: https://lore.kernel.org/linux-riscv/CAAYs2=iYn8sLQB8oh+RzTKd2VKs8MXOLX6Mwpamx5gdVVN6mkA@mail.gmail.com/T/#m62138d7a76664798d00051818a438a601eff4cf1
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 572973103d73..c19cddb8feb9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -277,6 +277,7 @@ config ARCH_RV64I
 	select 64BIT
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
+	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT
-- 
2.20.1

