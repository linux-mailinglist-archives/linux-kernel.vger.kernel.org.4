Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA53D69F1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjBVJdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBVJcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:32:41 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F783A08A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:30:57 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e9so3056010plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFgk/M229EQhqqhZZFLKtBybO/8gTLURLdA1DMiN/Z4=;
        b=SKL0epEoRnNDpRxCuPp05LozjCazXtjQDMYJEDXu4wLP3uxCrXoGFjIqisjU22SYe7
         Q37rNJX/dP0bMhglb10pCszg4dDzqlYGcdIiLlG1fa0mZ1EAnB7OEaDRI8zl6KzvnEI5
         U1c/h9SoWEaePzNd+2p7taVz7VyDo1gKTPH1DPX/LDr+jgIuHzfJphu8lOY1jONMpene
         YCwtC6LqlerjDStuvGfY2jE3oAeimNKGl0YNNVRUJhPYNkwOPyV9ivfF10aDqbH87LAB
         mPC8tnsSbWHrDP7wC4FZLFgbti5gKetmFHuAKl7iNbAIvF0tYsm9tTvjghwdusHcPMnp
         NxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFgk/M229EQhqqhZZFLKtBybO/8gTLURLdA1DMiN/Z4=;
        b=a0neoPGd/sOOfxm7WkNjnTbpKsHnt98BJmLMFODPNnLenfhcX6EBDT4YUmfAUAYo74
         uudZR3kowac7cTSuDL0U7czMwu9Do9uflY8Eb3UxdUOfBMXw/urFQpQyph9cNqlfwyqp
         rjl7R32yHgjzR7d6Pb1nJJwP/2seI0UOtK/S0YeR/76tvPVw/zp1dk7g864LcwJCBiTQ
         +/8jOIRaCIWskSugi8YOwaQdNyi89dLytar1hiX+/uSc2MdUTOy6LaZMPtNnWzj9+mRl
         CqPePb6x8bpOC06d9YkAE+aUnx2o2xMJ13Sp/q4mvqciHhwgL9eyPcAeqcuWfxuYKvPE
         iHFQ==
X-Gm-Message-State: AO0yUKUUJPIFpiqocCS982+jve0d27oAM0sAomhV3gZ7kei82TXZoekt
        lyCw+niYoK4ai4wY5UPjGReEOhYlLCc=
X-Google-Smtp-Source: AK7set+Zq9/rQ6pC3pgMRwgmOPnKp79DZJlyKSs0by9U3Xt5GgWFVInczrMk430lwA6Ils4yWD1VrA==
X-Received: by 2002:a17:902:cf4d:b0:19a:b302:5156 with SMTP id e13-20020a170902cf4d00b0019ab3025156mr5761702plg.24.1677058158472;
        Wed, 22 Feb 2023 01:29:18 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b0019a88c1cf63sm2735670plc.180.2023.02.22.01.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 01:29:18 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     jan.kiszka@siemens.com, kbingham@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH] scripts/gdb: add lx_current support for riscv
Date:   Wed, 22 Feb 2023 17:28:06 +0800
Message-Id: <20230222092806.1824615-1-suagrfillet@gmail.com>
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

RISC-V uses the tp register to save the current task_struct address
as its current() defines. So lx_current() of riscv just returns the
dereference of the address cast via task_ptr_type.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 scripts/gdb/linux/cpus.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 15fc4626d236..b382016552e5 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -173,6 +173,9 @@ def get_current_task(cpu):
          else:
              raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
                                 "while running in userspace(EL0)")
+    elif utils.is_target_arch("riscv"):
+         current_task_addr = gdb.parse_and_eval("$tp")
+         return current_task_addr.cast(task_ptr_type).dereference();
     else:
         raise gdb.GdbError("Sorry, obtaining the current task is not yet "
                            "supported with this arch")
-- 
2.20.1

