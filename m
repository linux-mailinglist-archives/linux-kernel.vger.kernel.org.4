Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B1A5B4170
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiIIV1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiIIV1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:27:41 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B4C121104
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:27:39 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id r20so1605483qtn.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 14:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dB7aB7ydAsOfWnmw3wC7w0o+kgP2MH0De3DP8wevgV8=;
        b=GY3BRWQWGGj1Ko79vpxpCZgd66JyEAtNWt3a4lTwp5nOONldrg0bK5IxP4xUkISLih
         RwnIS4tJz9im/Nc6yXRupuwPeFHx9911EYQseFXQV5f1exucPQCSkIzXquyiFlbADFq/
         obQz6e/w/27+5I0Cq7FrqUd7zBFuDm/eNJrOavSgmmV7YV1C/WRLXairJPoLnlJFg5+b
         r5JQPWip3Lq3Kqpx5qsTMtEoCi1dfBDsy7xDLkzzxJZBM2RElCkuvPrccFBhQ/FvE1qP
         rqf1xxHrxEdZenESTZNhMtfCbtSxVYTcjdaJMU93zFftvODuY80r0HuKi1qJ8cHZsQ0s
         z/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dB7aB7ydAsOfWnmw3wC7w0o+kgP2MH0De3DP8wevgV8=;
        b=gSEJXXMc+wWIahYpz4qUbuhSH32VH+sWxHlGOEcw7BaBaeQT1wuU2y31XNdFn38zGi
         aJJUfEbH0GO9ykhrWLLDVyvoNbhcLUmvPsyirtogWnFcYaywH6Q+Lsnky9+3MhWLeZtg
         lMg2358fLvViXe6dqxLbKQ0GdgHQbc1F14uGjF08FKv49o+VEuJJWAlV/qLuS+E+nLNI
         WZ0eHhkknZKDPKCp1I8mHqd8s465EGoJ2PMqG6ys1nl9l93q4UcGUxrHprrjb01egXid
         TFvtfMzXBqX6ZX5U6KzqBoWBFyxqFVF+6dSpWySUDeX7Kd5bilBb0pc4Xtpl7OOuE8FF
         0oFg==
X-Gm-Message-State: ACgBeo0ibIvyz9QvpomEePKtfn58+lYz0x9+zWHYEDKX5OV4JcGaft1k
        pW3OisuGhpkQ6FpRy8eAJvXbMw==
X-Google-Smtp-Source: AA6agR6TgVwVZWdRLnm4mtuaKCgIR16McG5+g4KNgQugD0Yaz+c3sjyDAJ7BTtHmchyMuojz7xR+sQ==
X-Received: by 2002:ac8:7f53:0:b0:343:652:ce62 with SMTP id g19-20020ac87f53000000b003430652ce62mr13795166qtk.514.1662758858422;
        Fri, 09 Sep 2022 14:27:38 -0700 (PDT)
Received: from abrestic-xps.ba.rivosinc.com (pool-71-105-112-35.nycmny.fios.verizon.net. [71.105.112.35])
        by smtp.gmail.com with ESMTPSA id o22-20020ac872d6000000b0034359fc348fsm1085138qtp.73.2022.09.09.14.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:27:38 -0700 (PDT)
From:   Andrew Bresticker <abrestic@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v3 2/2] riscv: Allow PROT_WRITE-only mmap()
Date:   Fri,  9 Sep 2022 17:27:31 -0400
Message-Id: <20220909212731.1373355-2-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909212731.1373355-1-abrestic@rivosinc.com>
References: <20220909212731.1373355-1-abrestic@rivosinc.com>
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

Commit 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is
invalid") made mmap() return EINVAL if PROT_WRITE was set wihtout
PROT_READ with the justification that a write-only PTE is considered a
reserved PTE permission bit pattern in the privileged spec. This check
is unnecessary since we let VM_WRITE imply VM_READ on RISC-V, and it is
inconsistent with other architectures that don't support write-only PTEs,
creating a potential software portability issue. Just remove the check
altogether and let PROT_WRITE imply PROT_READ as is the case on other
architectures.

Note that this also allows PROT_WRITE|PROT_EXEC mappings which were
disallowed prior to the aforementioned commit; PROT_READ is implied in
such mappings as well.

Fixes: 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is invalid")
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
v1 -> v2: Update access_error() to account for write-implies-read
v2 -> v3: Separate into two commits
---
 arch/riscv/kernel/sys_riscv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 571556bb9261..5d3f2fbeb33c 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -18,9 +18,6 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
 
-	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
-		return -EINVAL;
-
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
 }
-- 
2.25.1

