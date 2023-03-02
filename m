Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4E56A7ED1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCBJwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjCBJwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:52:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25F63E0A9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:52:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so1257964wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 01:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677750730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/w7ieSXW+WzBEEqtsZC24vvchjHjLnvFIFUR1Ngux8=;
        b=SUtNZ4kc8a6JEPa4tbaMVB2zZPSOdSvymYroHh3/0a3pj3EYdR6kjKNBN8Il1Cb6w9
         +i/EDcKqHaogNz6VVZCeM+mjKoIq1r8REAn0j0lbyT0rp3rAuRLWQE+owOZtLO2hTQYd
         jmWcJNxUJ9d2I+XRKC832YEAlQjXaSYfDtFnH02p1A2DjQzvV7khMNmFvk5x/Axj5ngu
         6qYtDjzevh+iTXHQPLpkDpnvwoFSL6ahLT/Ypau/FuH1ZsgsLY/QkX7mTU+CVqqqDyRS
         AsEYJ9Q5y0W/IGo8Np3s8Jf92dI0KhniVqZJXWYnKHxdTiuhj88yCUGK8iphvFXzkquP
         73Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/w7ieSXW+WzBEEqtsZC24vvchjHjLnvFIFUR1Ngux8=;
        b=O/0PwG1hF/lGQsOlUk2x4PXRBDNk/gHtuuyCkafsczBZ+7T77izcZjhVNZniRd6vAt
         dRBME9bddyGFrZH4lDKzqPCmNoNcMz2QDG8ZYfqPOkP3jbdSW6IdHjsB4L0lHouaQIVK
         Fp8hacNXuVluLp26pTvELV2KKXP0Y4yQWAi94vhiXz41MZhQ1spIaATOh9LUy8z/EGDz
         oQ33X3jym6/2h4CJQcc4qG/jIQm/2v+KbAO52KIbMBCIh4oxxOMWFs4ckRcJ0X/oB4n+
         2HIDaH+PjgLHW/CK4S60acCA8N91hg0hNgIUUoh91GMq6vP//fNvujKjto02wQlE6f8N
         ZDpg==
X-Gm-Message-State: AO0yUKVOm7V9wOUev1V6u3DLRzu29zhUbDHzXisTh/wTQLmGrxcJCURg
        ZToPSK/glQ0kS9Yz0IgC2X6NfQ==
X-Google-Smtp-Source: AK7set8xXXNjFuAiVjVA6G35CFfSYzj2/d9FHwm8o3qlA6y6smKEZ5mP1aEub8GJqdo2kC1Vui33IA==
X-Received: by 2002:a05:600c:3544:b0:3eb:3fea:a2ac with SMTP id i4-20020a05600c354400b003eb3feaa2acmr7448856wmq.22.1677750729760;
        Thu, 02 Mar 2023 01:52:09 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c458900b003e1f6e18c95sm2586998wmo.21.2023.03.02.01.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:52:09 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v4 16/24] arm64: Remove empty <uapi/asm/setup.h>
Date:   Thu,  2 Mar 2023 10:35:31 +0100
Message-Id: <20230302093539.372962-17-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230302093539.372962-1-alexghiti@rivosinc.com>
References: <20230302093539.372962-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/arm64/include/uapi/asm/setup.h | 25 -------------------------
 1 file changed, 25 deletions(-)
 delete mode 100644 arch/arm64/include/uapi/asm/setup.h

diff --git a/arch/arm64/include/uapi/asm/setup.h b/arch/arm64/include/uapi/asm/setup.h
deleted file mode 100644
index f9f51e5925aa..000000000000
--- a/arch/arm64/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Based on arch/arm/include/asm/setup.h
- *
- * Copyright (C) 1997-1999 Russell King
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_SETUP_H
-#define __ASM_SETUP_H
-
-#include <linux/types.h>
-
-#endif
-- 
2.37.2

