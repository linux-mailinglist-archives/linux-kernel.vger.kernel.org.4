Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E99563CD73
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiK3Cfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiK3Cfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:35:47 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D7612091
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:35:46 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so574227pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=cCcorQr3xt7S/9kPkpKfyFY9wnh4zyqAGWy8g0u82Pg=;
        b=zIgXfyOIwEsoklp4Pj2VNqVlzqwOyXMyUOmtxXL8XX0HZeDXxESlEZt18Ufk8JeuWs
         7Q7DrZZk/oBitKWBF64Y72Kp2UZQ7dqDF1tWUk9honYowHZWf7T07fwYEp42FE86aX1Z
         gotSBlRsn35YWoYFAbebcGNynvUUURc8MWORwvu2WIiMk6mdXfZHEGtdcZ0V537kul+v
         xAfm8oj9auHJEgnhK834L9M7MGTTIIaw5+ZBB9pNrXTs3FyLHdQzM9t0LKeC8H5zFH92
         oL0JH5gN1h6OJbnPfadyReZYXdDjEC1MrmIOqa9EU60CrE7FKP5+UH69dvLJ3D/kKeOV
         roog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCcorQr3xt7S/9kPkpKfyFY9wnh4zyqAGWy8g0u82Pg=;
        b=2duwX4HUnFjLcqFQw80wcFePk24Y2rub64xeOyiTHaFC2C/jwVJnaoNOzsEuE9CkO1
         brc5Gv9KhPRCij2JiQWm/v3LG0mKtfqY0XD7Si8EdfJjHIcrkcnwYSyCUwVBPz1+tSGr
         l4wCLctcEJHeMeXbFt8wLEmHW9BLXhXUO84KZ/mEN3lJN9bNbaAvXZXMa6FQ9l6LB5bU
         GHWNbAVhyI1htge4tNcXGI+GHAv+/ZkjRBtORvTylxoyPK4VWFgX7k9yTmeXLQ3c/I2w
         iMIjVs++rEHXQwCVd0M6g+s3VjF2aIWcpN5UAjhdEjRKl9Bgi9zo6bEoQQIv/bMZ4hVb
         BO0Q==
X-Gm-Message-State: ANoB5pnvj1mPWAnf8Zoz232d/MX4ZB747wk1zTSj9DPCIbqQu18XfOCo
        SGYlxOBTD4R4NgiAT4xZnhgzl/7qgcCoQw==
X-Google-Smtp-Source: AA0mqf4G6U9qyc4jE7f2+26f9t+8SDqoSZjzcCGOgkAolwJTuoVkqtHn3/RkqtSOEZJoe1ltS8Cs8g==
X-Received: by 2002:a17:90a:588b:b0:219:c40:e5f with SMTP id j11-20020a17090a588b00b002190c400e5fmr25718858pji.49.1669775746080;
        Tue, 29 Nov 2022 18:35:46 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709027e4a00b0018912c37c8fsm7638pln.129.2022.11.29.18.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 18:35:45 -0800 (PST)
Subject: [PATCH 1/2] RISC-V: Align the shadow stack
Date:   Tue, 29 Nov 2022 18:35:14 -0800
Message-Id: <20221130023515.20217-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     jszhang@kernel.org, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard RISC-V ABIs all require 16-byte stack alignment.  We're
only calling that one function on the shadow stack so I doubt it'd
result in a real issue, but might as well keep this lined up.

Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index be54ccea8c47..acdfcacd7e57 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -206,7 +206,7 @@ static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
  * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is used
  * to get per-cpu overflow stack(get_overflow_stack).
  */
-long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)];
+long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)] __aligned(16);
 asmlinkage unsigned long get_overflow_stack(void)
 {
 	return (unsigned long)this_cpu_ptr(overflow_stack) +
-- 
2.38.1

