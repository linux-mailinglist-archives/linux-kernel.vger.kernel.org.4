Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008096413EF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 04:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiLCDGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 22:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiLCDFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 22:05:49 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CECF8192
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 19:05:47 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so6715037pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 19:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSVgH09qEnpbMDCTLASqX2OMVKXLGyPI/rjfeHRIKu4=;
        b=wrC9Di4g/FkQry/CsUbIzu4ShoQtDm632rHMb1y98183Vkm7GE+1KgGiQeiqPRu746
         EpOqc9dOuSYQ+KgbsAL0f0eaO3YxXVARb1Qy/aZlLGx5xT8FJkymkARbubJV3UJhsZIH
         X0s2m87BWl0Nk7Bcfhw39dO5P0B7WZR3xG8jCR7ylvOfUZJOlQHN0djD0b5b36wlrQxo
         jgkGiA62CEcQWD//xV7j8pXqM1WcnxGbE2honL5gHULuNRyMkT1dxPj0xOx1vMDLAewW
         AXdhismtJx65svzL/lahWs98kLQcqmbFwviKntKjqxOCAmGqWokX22ZxG9BANL1F6/V3
         RqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSVgH09qEnpbMDCTLASqX2OMVKXLGyPI/rjfeHRIKu4=;
        b=c3tjCeuEzVNyCheg032JLVMJcqzYyzrg8C4zc9ddS05sBEtvkeWgzXYKCMzEhuRZV6
         gsw2ZA+CaeB4pVRMcjGg6KMxsx2H1nNNqNJeiOJKFt9At6o5/I5+2dUEcD66kZmPBIPZ
         5XN4VFP/5PbEo/4RqbJ5JnyHcFFn+pRPdEzCd5C51HwUsbY9p3urvLqu9kIxH4+O/mKE
         OcEGPR7opch1FEF6DrxfFEzkvjVcdauEAJ80eX/g1hHcu4oNdr6bMXtESQdKRfTz6Tmw
         K8Cw0IMQ97doKPohNE2vyqUyJ5VbQ8xCbv3+ikVhNMNTZ6jKvz1QvCwphGmTA31I6Q0g
         K1ZA==
X-Gm-Message-State: ANoB5pkQeIcwbIYd58mtwztygO+8lvCIvJoYQzoBQ7NdL9Li3Uo5spAq
        2Nsoj6GOrlaP+ZEo7tgViJAbRA2zpUZQS5jd
X-Google-Smtp-Source: AA0mqf4XSUxHT34o8cfUz81MqLg2uR3iZhKmjmdLNRSRwmN3btpX4jv5Kh1mNew10ARt+0Rl1idwLg==
X-Received: by 2002:a17:90a:2b88:b0:219:a1e4:20e2 with SMTP id u8-20020a17090a2b8800b00219a1e420e2mr2146067pjd.182.1670036747139;
        Fri, 02 Dec 2022 19:05:47 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id z27-20020aa7949b000000b00575fbe1cf31sm4894634pfk.67.2022.12.02.19.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 19:05:46 -0800 (PST)
Subject: [PATCH 5/5] RISC-V: fault: Convert to VM_FAULT_ARCH_* codes
Date:   Fri,  2 Dec 2022 19:03:56 -0800
Message-Id: <20221203030356.3917-6-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221203030356.3917-1-palmer@rivosinc.com>
References: <20221203030356.3917-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
           linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These conflict with VM_FAULT_HINDEX_MASK, so move to some designated
arch-specific values.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 3fdc2eebdd36..bd990735aa90 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -202,8 +202,8 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
 	return false;
 }
 
-#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
-#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
+#define VM_FAULT_BADMAP		VM_FAULT_ARCH_0
+#define VM_FAULT_BADACCESS	VM_FAULT_ARCH_1
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 				unsigned int mm_flags, struct pt_regs *regs)
-- 
2.38.1

