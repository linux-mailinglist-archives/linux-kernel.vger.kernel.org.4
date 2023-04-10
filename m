Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2975D6DC31C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 06:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjDJEe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 00:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDJEeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 00:34:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04BD3C29
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 21:34:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id ik20so3612443plb.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 21:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681101262; x=1683693262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ecKT1WgumVZWHqkbiz0HGwciSPCvvYfzypMqhbHlCE=;
        b=QeXYCEsNv40wBCRXzI295jNyAdVdPf1PAT7061zh5DS9PYmUTru+XSI1I5rHE3bO/4
         ss3EC9Q09/WYM3qK0shaKpyWwXPY8nx2QvxIGM9AAQZZG1jySu7ApGQ6NwPd4ICfKJZP
         XC35bbkXCIGvFh1iW2Row1UVlmNObI3qntQegPZFn+b1GsBJYbWkHWvqgJ27Aiz8Skiu
         zbeqfaMDrcFh8EsmZ5LlYJMckFgfck35VHCd1MhtXRVXFfNrD1bJwxPRs9vU2lVPzv4B
         Y93xMZD2qCtzjfzgigWrk0zTfBQ/gSHKf7nxJ2HG3RaxVsB+mEDfYklHgQs2Y3T3eTSq
         OHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681101262; x=1683693262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ecKT1WgumVZWHqkbiz0HGwciSPCvvYfzypMqhbHlCE=;
        b=mEk2vDvZQTJ1ZHt123IC2rDd6LVOlZDisTi8zTTF0+JohdBP0TWUzrmF2CI98x6gPe
         pEpVPSgzOaGtpY9bLXsJSBPJ42/ic+HicncWnX13hNKZWwhwPp68UtIfYYnXzzRdvdn/
         RwNdmahMnhlOnoR3TTD35xyzOnhu1zyTJDoOcC0B0dEZXz0W7LURdUqPWwsRCtDlLr7Z
         jJK9G+YaNxxnxxaEAjPqc53neSE7EvUq1IsEE0ZEqI5phTdlKHKMDWGvsrW9WinrHhCp
         0E9o0+j6LzOtpFI85jCK5waj9bgqeJZwYcWhd/vZ1O3TN7L3ZubYUgTEVCEyu2G2CcCS
         2BjA==
X-Gm-Message-State: AAQBX9f8C9WiMyURVN4p3bQFNjsslBML2blCDKFK4oQNeqp8wRyHh6H3
        F3tMhey+UUIQl0Qq1wVpCFKjBg==
X-Google-Smtp-Source: AKy350YsGs/FeHP8pm5lKkePm0VFJjupN5AEbHfEF4j3r2KlkU/WQ4HHiT/4WGzUGPr/Kvpv92e3Lg==
X-Received: by 2002:a05:6a20:4b15:b0:da:c7e:6ec0 with SMTP id fp21-20020a056a204b1500b000da0c7e6ec0mr5945527pzb.25.1681101262373;
        Sun, 09 Apr 2023 21:34:22 -0700 (PDT)
Received: from x1.. ([2601:1c2:1801:d250:45c0:94f2:eea7:6dc3])
        by smtp.gmail.com with ESMTPSA id x24-20020aa793b8000000b00634a96493f7sm2394411pff.128.2023.04.09.21.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 21:34:21 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Patra <atishp@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 1/2] RISC-V: Detect the Ssqosid extension
Date:   Sun,  9 Apr 2023 21:36:45 -0700
Message-Id: <20230410043646.3138446-2-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410043646.3138446-1-dfustini@baylibre.com>
References: <20230410043646.3138446-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kornel Dulęba <mindal@semihalf.com>

Detect the Ssqosid extension (Supervisor-mode Quality of Service ID) as
defined in the CBQRI (Capacity and Bandwidth QoS Register Interface)
specification.

Link: https://github.com/riscv-non-isa/riscv-cmqri/blob/main/riscv-cbqri.pdf
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
[dfustini: rebase from v6.0 to v6.3]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Note: the Ssqosid extension and CBQRI spec are still in a draft state.

 arch/riscv/include/asm/hwcap.h | 2 ++
 arch/riscv/kernel/cpu.c        | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 9af793970855..6dd717030723 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -44,6 +44,8 @@
 #define RISCV_ISA_EXT_ZIHINTPAUSE	32
 #define RISCV_ISA_EXT_SVNAPOT		33
 #define RISCV_ISA_EXT_ZICBOZ		34
+#define RISCV_ISA_EXT_SSQOSID		35
+
 
 #define RISCV_ISA_EXT_MAX		64
 #define RISCV_ISA_EXT_NAME_LEN_MAX	32
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 9203e18320f9..04bd0a21910e 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -190,6 +190,7 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_DATA(ssqosid, RISCV_ISA_EXT_SSQOSID),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 00d7cd2c9043..94bf5556347d 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -226,6 +226,7 @@ void __init riscv_fill_hwcap(void)
 			} else {
 				/* sorted alphabetically */
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
+				SET_ISA_EXT_MAP("ssqosid", RISCV_ISA_EXT_SSQOSID);
 				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
 				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
 				SET_ISA_EXT_MAP("svnapot", RISCV_ISA_EXT_SVNAPOT);
-- 
2.34.1

