Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685A25E77E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiIWKDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiIWKDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:03:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE849126473
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:03:28 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso4941133pjm.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Igny7pTb9AijsoV7hvvN55djeYxG08/baILhy9iEypk=;
        b=VyNg8Ii30CtNaDjTaFtYwnCPGNizxdHazep/PeUMboCspqgfeSQKiTDgFqQ/vnSWap
         I6K+5rIOzf6oPLowz6qMKern4LAU+kuhCxl2cKsoDyaMK5RQBAdbOTcSQdsWjYs7fH/2
         r2ifcY+C7IcX/MgZHx2XCZCtc9FWTEhhD9cp8tcZNX4r65ktat7ezbP4J7S0MzKJVvaf
         blucuvgyjLxrT7LyKHphiuoB6HBLdMdch+R44ds3IpGA4zV+TntlFd5qfftF0ZD9gdu8
         mXzhYsqjs6u7tHiObI+Ezy69dAFTYIpvLcHuYzgtjtte3xIEMPQzbsx7Q0PMJsahI81Y
         M9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Igny7pTb9AijsoV7hvvN55djeYxG08/baILhy9iEypk=;
        b=mU5AVmUIzxl2uM+xM4rTL0g333Kfi5uQrZsEPUmmoDi2PDayUMvD1obyneanMfAGKv
         WADx/0WenDBzpd7+9nOVvIfS1hGw79FNsSecMJAuzebrwezrlPoLkKWytiiRlfAt6tOd
         wRd8vAzl+FhIeMTsvCIyCo8UD2kELcNveEnLeqwbKSpytUy/E9AaeCjVuMvHyIcLeuZZ
         +CPt0Za/q3dWE63unv7TiYvFhd5YRKbAfKBnOV3oc7VPpp9FFJ5StBCTNvXWbTgkTVXt
         3MUcFjCuX9ttM+CA4NUJQEAMkX4cMhAil/uMroa9XjRv4Sqhc2XzWj5CeVKk+IzUc/Ei
         fXXQ==
X-Gm-Message-State: ACrzQf00cP+E5B5CxuN53L0notoJ/nWmj/EIQmgZrPVnczqDtr+bDwW3
        jELbjHZ8xlNLyjdrBSJFHJncm6LLNpERqaMoulmp/Lpg
X-Google-Smtp-Source: AMsMyM422saiBMn/ttuHBBoJOpy7D9O9IJYmJtuUdgGr8ByYU4QCQaCJ++5PPH1JIak8CwDVtGUjpQ==
X-Received: by 2002:a17:90b:1a90:b0:202:ff17:4a80 with SMTP id ng16-20020a17090b1a9000b00202ff174a80mr20367969pjb.213.1663927407990;
        Fri, 23 Sep 2022 03:03:27 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id l25-20020a635b59000000b0043395af24f6sm5374100pgm.25.2022.09.23.03.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 03:03:27 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     guoren@linux.alibaba.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH RESEND] riscv : select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Date:   Fri, 23 Sep 2022 18:01:49 +0800
Message-Id: <20220923100149.2647325-1-suagrfillet@gmail.com>
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

riscv now uses -fpatchable-function-entry with dynamic ftrace after
the `afc76b8b8` commit, which means recordmcount shouldn't be called
to create the __mcount_loc section before the vmlinux linking.

We should select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
Makefile not to run recordmcount.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c22f58155948..25db8cea876a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -246,6 +246,7 @@ config ARCH_RV64I
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
+	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
 	select SWIOTLB if MMU
-- 
2.20.1

