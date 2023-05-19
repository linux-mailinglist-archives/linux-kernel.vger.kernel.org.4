Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5855C708FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 08:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjESGJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 02:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjESGJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 02:09:04 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DEE10DC
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 23:09:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae87bdc452so557685ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 23:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684476542; x=1687068542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=acsQIdfOS76XIGk2swzVCmK3bhSNOQiVKEd2nYdPHpU=;
        b=Z2qCGytiQpchdC6MxLuKGoEvkb2VfBPkRy2QsiC5Q1O3AOnOKHJw9in47cqEYkMy1I
         UPEYPuSkizH6nzxRp4OEjAUDHKoFHVK/io21UxMWJvdD2YgbVZiQmK4w4ntxX/i99Av1
         NwC3B7dkT63/FH02hZu2VNkDBWg3TRTVFbZduKLgPy3OijMuBjGU0eBtkzARLBCIpTy/
         ApmtnZNeI22IkxZM1GMfsBFwNTPEiahf6S9R1WHykTKppX3Afs8hR4sUWC4f4f1HE3/6
         bWmD7YMPpR2bAu5zaMs6o+HF13Dwhza2abnLD8ZPoOEnAtexriKADNnqPtBtTdPIKtDZ
         N8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684476542; x=1687068542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acsQIdfOS76XIGk2swzVCmK3bhSNOQiVKEd2nYdPHpU=;
        b=L8I93e6S2xomgIsem5eRz2acIUNIRZxGFS7XTkFdXpqDOfa/Vagr+wDRvKH5XePTzs
         pArbAq+kcuOiIEUmOOLkq4NosnZvfF4z8QW4GOXNVoRIVyeJhBZzDpCglFxV0jktIMA1
         IJf//aj9bNiUIrJzc0Yqv0mIKk9BIq0hLB1n7H+3YRJh1/eABxOhVAmEX5tCbd7lIBji
         d0Dh3xjU44BWT2d/BDfaBF7S7z4yRw9YU/wwg+GvRcQK9D3SGD+QzfDM8gc9f/+aA1RC
         nl2KGkAsLnFifmaRZNBtz+G6KsVFirDOnCK6i4kNw4rQnHQ7UOknXD5PCfMWNCH9a2Jf
         Mzlw==
X-Gm-Message-State: AC+VfDx7hi30HNEDrdUa6ZFBt/qt5+Gx3mq1KwOyCydlAK3rOeh1gm7W
        3hdBeoFsN0PqdWvMpSxu/WU=
X-Google-Smtp-Source: ACHHUZ6QvRaX1TLkAV5jlA5TIsRZxiJZnHkB7qA3Qv2B9/UdpMj2b2oN78KP8GZIw345iuylwsH9ig==
X-Received: by 2002:a17:902:e848:b0:1ad:d500:19d3 with SMTP id t8-20020a170902e84800b001add50019d3mr1989643plg.23.1684476542275;
        Thu, 18 May 2023 23:09:02 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090282c100b001a64a2b790fsm2508936plz.164.2023.05.18.23.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 23:09:01 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, jeeheng.sia@starfivetech.com,
        mason.huo@starfivetech.com, conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH] riscv: hibernation: Replace jalr with jr before suspend_restore_regs
Date:   Fri, 19 May 2023 14:08:54 +0800
Message-Id: <20230519060854.214138-1-suagrfillet@gmail.com>
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

No need to link the x1/ra reg via jalr before suspend_restore_regs
So it's better to replace jalr with jr.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/kernel/hibernate-asm.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hibernate-asm.S
index effaf5ca5da0..5c76671c7e15 100644
--- a/arch/riscv/kernel/hibernate-asm.S
+++ b/arch/riscv/kernel/hibernate-asm.S
@@ -50,7 +50,7 @@ ENTRY(hibernate_restore_image)
 	REG_L	s4, restore_pblist
 	REG_L	a1, relocated_restore_code
 
-	jalr	a1
+	jr	a1
 END(hibernate_restore_image)
 
 /*
@@ -73,5 +73,5 @@ ENTRY(hibernate_core_restore_code)
 	REG_L	s4, HIBERN_PBE_NEXT(s4)
 	bnez	s4, .Lcopy
 
-	jalr	s2
+	jr	s2
 END(hibernate_core_restore_code)
-- 
2.20.1

