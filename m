Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2A57470B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGDMSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDMSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:18:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324C4E6A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:18:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso54753175e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 05:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688473119; x=1691065119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOxTf/FoItb3tkCzHBcD5o9fcnb2mULyauZWaQEOj5s=;
        b=GQH147pJZZd0uy7HRqLSeRD4MqK0jpuyx9VA/x2qMTyfs0Ub6QrFkCnJxE4twAFKzC
         a5aSjiBKFpA59XP+5bbH2d4OtmkjTWMAjvbtmWGtV3wTgvKH3W2dTAnVTpjf7V/4t3kV
         pPumyphSN6NXKU9sqn8t0HeTmk7l2f0kJebl/ZrbKHVFleZDdjzfpdQ/hQXLGF7N6DZa
         aLKts8Ebf7KY84NpVDqqCmlmWU70AppsltS+lagdNuSYYiK/xmVCRcyLFyayiXmOlyJV
         SDN7yS1GSSdkM9SaH3486h7ROcBzo+DMnsFao3dwAdAGDOSqeYPxVPL1zXec6Tg0SAf7
         57vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688473119; x=1691065119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOxTf/FoItb3tkCzHBcD5o9fcnb2mULyauZWaQEOj5s=;
        b=eq5tzS7Bky4Cas1oteA+i7rKA7IQNpamNqenEkIxgm8gkRDeEHK74rqEMECC+8SFLA
         zY4WgWnfVhWliZL8cI5V6B2X73fBoK0Yg4MmQ30qIGHCQwlmnYOgYWtVyW1LyPvz+oWT
         GMH1HkdWhlgjgbc6ZR4ptq96Moshu/nSNxifPTLx6qOWXlA+rt3ba8t/UemOLNIsm7OM
         gucvsaSB76bJ6Ka61DfeooxSFsqiT/YtoAfmJDn2fnEVSMpokPjCZh9Hm2jvX+kuCmOS
         Eb4BhxfFV4KgKeywT/2U1txY5rGoBqXxXviKFvEdD7Q5XhWJWO2gqR3Qf/s17uqHqW1p
         neaQ==
X-Gm-Message-State: ABy/qLY32UmH4TEtSDRgHFyermzRK/FE/YJ9hXREdIuFCFI2MmQmpd1P
        j0XzvtRJ1Bhpn+tQMEpyGAMYytn2JTxIZc9CzCI=
X-Google-Smtp-Source: APBJJlHKVFGDj8HJUjauugyXiH1dEykKVH1qQGBxW8/WWijgQIiyPCS5d3e9pSEYj/z2DB72x0U24g==
X-Received: by 2002:a5d:6986:0:b0:314:37a9:f225 with SMTP id g6-20020a5d6986000000b0031437a9f225mr5409529wru.40.1688473119531;
        Tue, 04 Jul 2023 05:18:39 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id d11-20020a1c730b000000b003fb416d732csm22409679wmb.6.2023.07.04.05.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 05:18:39 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Start of DRAM should at least be aligned on PMD size for the direct mapping
Date:   Tue,  4 Jul 2023 14:18:37 +0200
Message-Id: <20230704121837.248976-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
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

So that we do not end up mapping the whole linear mapping using 4K
pages, which is slow at boot time, and also very likely at runtime.

So make sure we align the start of DRAM on a PMD boundary.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4fa420faa780..4a43ec275c6d 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -214,8 +214,13 @@ static void __init setup_bootmem(void)
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
 	phys_ram_end = memblock_end_of_DRAM();
+
+	/*
+	 * Make sure we align the start of the memory on a PMD boundary so that
+	 * at worst, we map the linear mapping with PMD mappings.
+	 */
 	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
-		phys_ram_base = memblock_start_of_DRAM();
+		phys_ram_base = memblock_start_of_DRAM() & PMD_MASK;
 
 	/*
 	 * In 64-bit, any use of __va/__pa before this point is wrong as we
-- 
2.39.2

