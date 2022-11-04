Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E82619675
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiKDMqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiKDMp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:45:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AFB248CD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 05:45:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b2so12962376eja.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 05:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vMdsfsYERMDBAPUkWs1w2zEqq3IRS+1ssQTKQjMtV/A=;
        b=bnow1SlH0H0KTdF/oxjpVqUWkm5rf//QS4RZPcghZ6MpbXyDAx/L9OTJB9GwxyvEfA
         9bf/QFhR4zGpLSvN5XoDV8PTrl9VE4Eepvl9nfJfF0XddQ/6NmXhY+BZjv5pz6Ij66gl
         M+tak0ycEfyDaCIGgQ/mMPV0F91vg0h8SGs9Dw91nLzllPWkbYCUFfScipI/kGKVDgCx
         ByNn/S2jBYzER1eAUVHmPK/rw7OT5Q5t31bWaC4HT+a4DA4vMIzJR1N1VBLAb7+itycc
         oECQs8Q92V4xrKRA9bjr9JMOuqjqqggIth3NF0IbMBRPCoYaBZ5pWdU+HrZhBLPKDLcp
         UCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMdsfsYERMDBAPUkWs1w2zEqq3IRS+1ssQTKQjMtV/A=;
        b=PsihX4N09fe7zSPeo270AqFwliT8v3/Bm/8Pf6pNIFGnuNCPTJeTmjpAy5qZ6k+QB8
         P41l1I8JCCfIBvs5naTL9+uvhmkdZ+n2+LXXdGPKnPREq1dKvbIG2/C31ZBO99zryVe6
         cJYccYbGCbPpBUv1wdzY8pPYMvAkolqtXD0Jv2/HrAWTSQAEOqWIjKJFlvcqtcFvR79W
         316R25rYUgsPSBPRqT8EVUvGRqpAi2jwSSes8BpLN5Lendy0lkwqIhSIXtrdQnQhjSXq
         j1Zdz8YrUQp3/kQ32aUnsqSAtwmVYm7ot0NI0ZUxjq7dtJ59Hekge4eDrDM5FSyLiuj/
         1bXQ==
X-Gm-Message-State: ACrzQf1fpes8dkmFiH4+BPBtq4fWcOtQNz82+PxSVM4lM/emWJjfD1R3
        eUfSCMI2tAekKWNXC9YL7vI=
X-Google-Smtp-Source: AMsMyM5jTFGSCBAsvm1CKRATuIlcXZ7wWaFfriQ2bwaSumSKpr+eWAxbAKyK7ghIfySSHHICKUjwyw==
X-Received: by 2002:a17:907:75cc:b0:7ad:b9b7:582b with SMTP id jl12-20020a17090775cc00b007adb9b7582bmr31366757ejc.150.1667565954786;
        Fri, 04 Nov 2022 05:45:54 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id kv5-20020a17090778c500b00780f6071b5dsm1760134ejc.188.2022.11.04.05.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 05:45:54 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/boot: Remove x86_32 PIC using ebx workaround
Date:   Fri,  4 Nov 2022 13:45:46 +0100
Message-Id: <20221104124546.196077-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Current minimum required version of GCC is version 5.1 which allows
reuse of PIC hard register on x86/x86-64 targets [1]. Remove
obsolete workaround that was needed for earlier GCC versions.

[1] https://gcc.gnu.org/gcc-5/changes.html

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/boot/cpuflags.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
index a83d67ec627d..d75237ba7ce9 100644
--- a/arch/x86/boot/cpuflags.c
+++ b/arch/x86/boot/cpuflags.c
@@ -64,20 +64,11 @@ int has_eflag(unsigned long mask)
 	return !!((f0^f1) & mask);
 }
 
-/* Handle x86_32 PIC using ebx. */
-#if defined(__i386__) && defined(__PIC__)
-# define EBX_REG "=r"
-#else
-# define EBX_REG "=b"
-#endif
-
 void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d)
 {
-	asm volatile(".ifnc %%ebx,%3 ; movl  %%ebx,%3 ; .endif	\n\t"
-		     "cpuid					\n\t"
-		     ".ifnc %%ebx,%3 ; xchgl %%ebx,%3 ; .endif	\n\t"
-		    : "=a" (*a), "=c" (*c), "=d" (*d), EBX_REG (*b)
-		    : "a" (id), "c" (count)
+	asm volatile("cpuid"
+		     : "=a" (*a), "=b" (*b), "=c" (*c), "=d" (*d)
+		     : "0" (id), "2" (count)
 	);
 }
 
-- 
2.37.3

