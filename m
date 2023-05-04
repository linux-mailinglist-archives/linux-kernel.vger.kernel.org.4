Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91546F6ADC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjEDMIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjEDMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:08:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0BD59D3
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:08:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-306f9df5269so248658f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683202081; x=1685794081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z/HOoqmO08h3u2Yvh7Ep4JiYOBfgZY0A+BuaNi4hKi8=;
        b=rH4Kg6CiTjM7F3xylJNwT4SBXybDUmEgdrx/v5oelKsA9dtaYw5OM0PRHGaRRdn76d
         7QF4Q7HdK7hJA9oB/cs8bi8MD8HT2QCBT6zwqo18Q0fI4fhkn+GUD4vS9fVqjRU0Nuku
         r8QHfkcsEIXrFoOJypBRximVoOzEIX2cj/5i/PDWcmYHcqadbSYrg3NOqPhk3FjIiQCt
         xpynI+Q5WAMJT0+PRB9aKDclfgUGfUWkFl+2kPG3Q+WiHxuqED2QCbdYGvY1ZpVOSNAP
         2T3hFtieuW2ZI+6mbLAh5kqeYJqHLXsSnwnDWsD9kkSkPxipLWsy5mrz0b6RxmBWqLhB
         SloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683202081; x=1685794081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/HOoqmO08h3u2Yvh7Ep4JiYOBfgZY0A+BuaNi4hKi8=;
        b=ggfXqYTMyCd1IT/McQmFQnmFv+H2pWA6E/mkNFZlZCa5y7AVwJUpy1Hr92CiW4e8St
         vc8V5ecKW7odUv/Kp+r1Sf0M2Dlc7ByuXExbt6lzVtf8lDZwt/khhkxPZHh9pNHbxSKM
         R954lEG5jQ0jR4R6EMi4VSmMEhh0Jb0XCHPVPAUkbCHEHlYLfGmRn3WKL/bcvJg0Xu8Z
         ruDFByMn9ozeWEeOLHn+tX7F3sGdzc5NTr8U4uF98AkYUDMdrMRFpzEusPbCW+Awqtop
         IDlZ9h3ahdT8dcZS1vNggzbpgnyQw8sdYhXbXTqKARkpm/WObO6XQRmPY6hnMPBRh20o
         BVsQ==
X-Gm-Message-State: AC+VfDwkw6JXfJp4f0Fg3j3fRUjdV4Af8zgdk53a/ATs0vIjiv4lMuBf
        vrB9u/odoyNPOM1duojgVnjIPIwhQ196jUgEPJA=
X-Google-Smtp-Source: ACHHUZ5hzqq3dnn/lEi88tYMgY4qut+pP1uM8kWq0ar6fkaOkqDMCTR5l2AkNdgegQ6EMAeNddu3NQ==
X-Received: by 2002:a5d:6504:0:b0:306:4943:2e18 with SMTP id x4-20020a5d6504000000b0030649432e18mr2176434wru.58.1683202081312;
        Thu, 04 May 2023 05:08:01 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id s4-20020adfeb04000000b003047f7a7ad1sm27433451wrn.71.2023.05.04.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 05:08:01 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH -fixes] riscv: Fix orphan section warnings caused by kernel/pi
Date:   Thu,  4 May 2023 14:07:59 +0200
Message-Id: <20230504120759.18730-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/pi gives rise to a lot of new sections that end up orphans: the
first attempt to fix that tried to enumerate them all in the linker
script, but kernel test robot with a random config keeps finding more of
them.

So prefix all those sections with .init.pi instead of only .init in
order to be able to easily catch them all in the linker script.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304301606.Cgp113Ha-lkp@intel.com/
Fixes: 26e7aacb83df ("riscv: Allow to downgrade paging mode from the command line")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/pi/Makefile   | 2 +-
 arch/riscv/kernel/vmlinux.lds.S | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
index 741b7bd3a84c..07915dc9279e 100644
--- a/arch/riscv/kernel/pi/Makefile
+++ b/arch/riscv/kernel/pi/Makefile
@@ -22,7 +22,7 @@ KCOV_INSTRUMENT	:= n
 
 $(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_ \
 			       --remove-section=.note.gnu.property \
-			       --prefix-alloc-sections=.init
+			       --prefix-alloc-sections=.init.pi
 $(obj)/%.pi.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 305877d85e96..e66e26640f63 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -84,11 +84,8 @@ SECTIONS
 	__init_data_begin = .;
 	INIT_DATA_SECTION(16)
 
-	/* Those sections result from the compilation of kernel/pi/string.c */
-	.init.pidata : {
-		*(.init.srodata.cst8*)
-		*(.init__bug_table*)
-		*(.init.sdata*)
+	.init.pi : {
+		*(.init.pi*)
 	}
 
 	.init.bss : {
-- 
2.37.2

