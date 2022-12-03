Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00A86413EC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 04:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiLCDF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 22:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiLCDFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 22:05:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAE2F7A09
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 19:05:45 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t17so6566275pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 19:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhR/DvZbp+3vR9eB4A5wFYKGQTjA+LqOJxd/xHKwNw4=;
        b=KpJKmzUqKuY7RNz1zoEByIJW90y1Livh3n8yRVCtF7Wr2SNUWd5EFqo0EjjNi6loJv
         TlFuL2eEbd8DZ8FBCGv2ReWj958YzPC2Tt8AZagpgWofFTbPz3N9Aoss5wquaRZv35pt
         zf534yNV0g0gfKF8Bxz3qsNDzOBS2wJGcO2gP6yGN2p/yU3fATEm0f/qdKSMHwBwAsqk
         jnSfc+OaPsVevmGerR1dP9afYP2sPSSOlwlnAwWpFHuq0XqOLftSexffps5iSRlfBRFT
         fJHeyOjJR8qw7F5Bxhqn6UBDRAZfg680T48PHv4bOtksy7UlERFx7XNKzkB4IIToom71
         zAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhR/DvZbp+3vR9eB4A5wFYKGQTjA+LqOJxd/xHKwNw4=;
        b=6hGSSc3B9W/YmCf5gzPEt1BodrV9mmHMMi44eTptWOm6CP29zqcErMdxnft5TufPg0
         8Dl8f11to1O66c6Rvhy8/9sDmoktsjgHc/ogw2ylV1N7IdX+df6uBvDRkVsh1lQEtLOa
         hol61lnyrCi9FXeJ+HS2kIxA3fcLopOK6K/Q5Thc6TfVhmagobIpV8kFGz7eESfoSp+n
         O6Gkr5XhCjk2KFyNSqaypFzaaWdXBlfNZDq1O3ceRtEFe6woZ3NefVlfGmroiPVW5zzX
         BFI3gHB2cI+HFuFMBmkCj7lHOrzJnYQqKtQO8wnUpwMqGHil0nvD9eq4sHSSc+SwLkX5
         iWHg==
X-Gm-Message-State: ANoB5pmP7KA45H/q1MMVl6dyifvr3v6wc7G31RvMYG98Cbc9EQhy/Bek
        wlkflafdOodNlLTOaQEh5amnfA==
X-Google-Smtp-Source: AA0mqf7bOAyepA04ituLKXHZJH3uQ4cqneDkfqNEF7GDlldsPNuzsJMKn7BDVi7Zx/YGZ+BpcYq8AA==
X-Received: by 2002:a17:902:bf06:b0:188:d3b1:dbfc with SMTP id bi6-20020a170902bf0600b00188d3b1dbfcmr57933988plb.127.1670036744950;
        Fri, 02 Dec 2022 19:05:44 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b00186c3afb49esm6182561plh.209.2022.12.02.19.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 19:05:44 -0800 (PST)
Subject: [PATCH 3/5] arm: fault: Convert to VM_FAULT_ARCH_* codes
Date:   Fri,  2 Dec 2022 19:03:54 -0800
Message-Id: <20221203030356.3917-4-palmer@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These conflict with VM_FAULT_HINDEX_MASK, so move to some designated
arch-specific values.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/arm/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 46cccd6bf705..7063b875b05f 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -201,8 +201,8 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 }
 
 #ifdef CONFIG_MMU
-#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
-#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
+#define VM_FAULT_BADMAP		VM_FAULT_ARCH_0
+#define VM_FAULT_BADACCESS	VM_FAULT_ARCH_1
 
 static inline bool is_permission_fault(unsigned int fsr)
 {
-- 
2.38.1

