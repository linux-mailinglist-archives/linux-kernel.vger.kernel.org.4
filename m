Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8148E63F214
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiLANx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiLANx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:53:26 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F421C403
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:53:21 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bs21so2813945wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgLh6uMMR0Rcr9C+nyDLv9c+8u2wrvtTYa0+ThJna9I=;
        b=bmeNS2iEKjeqg6unQ+LJECbDmv0XQqeKqaACNC+HASzyAlGgmwAIi+IyPgR5TQy2Vm
         NKjpmkgZMPqWZdpaF0oqQrrcwqYrmQQPkcwE3JL1XH1rHQLcgECF7o6fz9wFLWkdCGEM
         y19q5D5ob+B6Q0p0SNy4JjQViJIShBPxcMLj9FC1HZsa6kYJM/k770E94SQ6RWRXBGbe
         dTBGarcCH9bDXHSGYNz/jUkT2OuX5WZUG9T6VGw8tZJAA6cHqbtFVXmon2eUWuwWOTMy
         JVIl5O0xYviC0vXwrGsyghXQcMnCS4OnEy88xxdHA2rM5ZTszL23U5etmCO/MItuC8JB
         hwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgLh6uMMR0Rcr9C+nyDLv9c+8u2wrvtTYa0+ThJna9I=;
        b=jGgERpNyzrPXVw51DhuTHVemKlfp0BxRuidVG21mBy8frZnvh1A4akKIS3BfB/wdvI
         dijym6YvucC6WAUXAvwvZNE9CPva2YbKWGYBQFWHmD8u5ox0tALGHCD3gStF6tT+fFpa
         yquYMbkHlJ0R1ivPUE5pXQf6h4QhtAhbATm/jkNYH1qxmvVMvrADh/gb6hTT6Eoat1/X
         xDGqs0Dl9UpoYSap3TttSfvoVLsYN6yKI3b8lcq/KBOJQmS9NlCVnQ/a20glr0ylxJZP
         ik7lETd0Lak2t9S+1dyp9QcXXExhvE+eSlHB2yRcAxO2ltqX+UyvVJ/hA9YNPz2U7UDk
         5mvQ==
X-Gm-Message-State: ANoB5pm84sCeYBCa/6SCjm112gB2nz17DORRZ88pCYNeaCTzCryp6JPA
        56EQ8RlAsdqkkqvCZ4tKh/pXAg==
X-Google-Smtp-Source: AA0mqf7uWenO+LbmKE9LuMiukYmFeUw50rRJmRTVFYoCgTjjVHaNFb5qH68Z/YfC8l8bquXihHFdHw==
X-Received: by 2002:a5d:6503:0:b0:22e:35e8:382d with SMTP id x3-20020a5d6503000000b0022e35e8382dmr41094490wru.475.1669902800271;
        Thu, 01 Dec 2022 05:53:20 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-gre-1-201-46.w90-112.abo.wanadoo.fr. [90.112.163.46])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c199100b003c7087f6c9asm9589361wmq.32.2022.12.01.05.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:53:19 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 1/1] riscv: Fix P4D_SHIFT definition for 3-level page table mode
Date:   Thu,  1 Dec 2022 14:51:28 +0100
Message-Id: <20221201135128.1482189-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221201135128.1482189-1-alexghiti@rivosinc.com>
References: <20221201135128.1482189-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V kernels support 3,4,5-level page tables at runtime by folding
upper levels.

In case of a 3-level page table, PGDIR is folded into P4D which in turn
is folded into PUD: PGDIR_SHIFT value is correctly set to the same value
as PUD_SHIFT, but P4D_SHIFT is not, then any use of P4D_SHIFT will access
invalid address bits (all set to 1).

Fix this by dynamically defining P4D_SHIFT value, like we already do for
PGDIR_SHIFT.

Fixes: d10efa21a937 ("riscv: mm: Control p4d's folding by pgtable_l5_enabled")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable-64.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index dc42375c2357..42a042c0e13e 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -25,7 +25,11 @@ extern bool pgtable_l5_enabled;
 #define PGDIR_MASK      (~(PGDIR_SIZE - 1))
 
 /* p4d is folded into pgd in case of 4-level page table */
-#define P4D_SHIFT      39
+#define P4D_SHIFT_L3   30
+#define P4D_SHIFT_L4   39
+#define P4D_SHIFT_L5   39
+#define P4D_SHIFT      (pgtable_l5_enabled ? P4D_SHIFT_L5 : \
+		(pgtable_l4_enabled ? P4D_SHIFT_L4 : P4D_SHIFT_L3))
 #define P4D_SIZE       (_AC(1, UL) << P4D_SHIFT)
 #define P4D_MASK       (~(P4D_SIZE - 1))
 
-- 
2.37.2

