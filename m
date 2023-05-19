Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81A07094CA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjESK3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjESK3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:29:39 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08962E6E
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:29:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a516fb6523so29353425ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684492156; x=1687084156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dyCts+3MIamz/ZP/Th1oUrcgbH11s2oWCUMvcOwKW/c=;
        b=QwQQ1jJWLOQbljg6TCUXa5q9qgSjdve6OeoE561RDnhWjdKSN8Ga4m81FubQ9mtfC7
         iPCKNMdZNbrLBp0aYOQ3WyKkrYI8Rksn8fKcwFdXF+46wQYH/mB1rxMeHXeo+PyXJ1/O
         8l5l25MIW2Kg198SOnoYzl6NQcdfRqrHAUglrIUPPTB0GfWfh+zH3FzG1cE+133HABWJ
         W5XMihnrXeQEkPbQtdELGmA5Sm0LHRMqN8osScTjCYITHfWrr45XfAsS7IuQ5vmPT/FQ
         krpPDhSJ8yhIvvidzzMDrc4am9qi3WZygZMG1TC0uncBnRDIwwCps2co07joA0pXRcCS
         vKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684492156; x=1687084156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyCts+3MIamz/ZP/Th1oUrcgbH11s2oWCUMvcOwKW/c=;
        b=U7QSbfskgdttNoPoaO3j86Hq21rOk7bCUMQcMGzBW4SrpMI/dLtXpr1mnEegdI7HEY
         qtJxfbLtN7eVFWHwLypj8AmaAH6/rwJWXTqoM7FctCfplif7Q2b9mriMKujsorG1ipZK
         PYAME486bkc7SoZo1tT2MnOWVrYAeIE5pcOVSRHgLZx9iDxmolvyX9AUYUa4lm5+vr90
         3fqvZ/PqZ8XV0Co8dLFUPSf2yjcA0bkHnlcDx4RQRoJN0+wNUbHVNLTGVix59tyNFJSx
         NTgaVomyWFhDrBTJ+q9HV81HWJH7z4A+QBkWB13tA7JIb98bEENndReqK6nS4BabQVm9
         xnXA==
X-Gm-Message-State: AC+VfDyxSsVuAMhOuwEuQoLMvupvGitXhXo4JSdg+3tSTHmha8RvcqPx
        i4SQWCESkL81oBvkZ2OFKaI=
X-Google-Smtp-Source: ACHHUZ7NMUT3TKAc7YbJrIYDWFZGmpcw+HSt+Acfdj11Pwa6UO0f3XrjjVk5DPL0j87P6igKTx2o+A==
X-Received: by 2002:a17:903:1112:b0:1a6:8ed5:428a with SMTP id n18-20020a170903111200b001a68ed5428amr2918121plh.22.1684492156382;
        Fri, 19 May 2023 03:29:16 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001aaffe15f39sm3102770plb.30.2023.05.19.03.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:29:16 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, suagrfillet@gmail.com,
        mason.huo@starfivetech.com, leyfoon.tan@starfivetech.com,
        ajones@ventanamicro.com, jeeheng.sia@starfivetech.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH] riscv: hibernation: Remove duplicate call of suspend_restore_csrs
Date:   Fri, 19 May 2023 18:29:08 +0800
Message-Id: <20230519102908.253458-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
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

The suspend_restore_csrs is called in both __hibernate_cpu_resume
and the `else` of subsequent swsusp_arch_suspend.

Removing the first call makes both suspend_{save,restore}_csrs
left in swsusp_arch_suspend for clean code.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/kernel/hibernate-asm.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hibernate-asm.S
index 5c76671c7e15..d698dd7df637 100644
--- a/arch/riscv/kernel/hibernate-asm.S
+++ b/arch/riscv/kernel/hibernate-asm.S
@@ -28,7 +28,6 @@ ENTRY(__hibernate_cpu_resume)
 
 	REG_L	a0, hibernate_cpu_context
 
-	suspend_restore_csrs
 	suspend_restore_regs
 
 	/* Return zero value. */
-- 
2.20.1

