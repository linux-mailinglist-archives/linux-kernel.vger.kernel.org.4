Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DF8695C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjBNIMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjBNIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:12:43 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE6F13D58
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:12:41 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bu23so14712420wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWpoWTHF+daqxuKXm60VZYbfqB4+Spk5kTFrpLEIhE4=;
        b=Veh/EHYixy/BVr2GrHtk30P5YOPi4EHeSNqoamBT39WTsSXejEs0UE30C93HqcRFbp
         izPwCu8TUcJCCnqCQUAY76bJWXbwocobxnV2kZxn2xUtxnjsLvfB+9HbXWhAb+VvhxwT
         ARoUqyHz4DGmfUVA+DxyMln0z753FAek0lIkRmiTL+glPB9eA2+4Y+LhwF4bY5+c6Fj7
         K5SkuIZ/rdq4GcLIl9I10pHsVItae5lluUj0xTVWSi285VRJODP7+Dsb+9bCPUpOm4mh
         jpS7KbvLNAtE7HUyXRC7hgyv9H7uPIhwNYJ1Tdh6UaI1eBiLIy+6gQu11e3k700HLthN
         ofOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWpoWTHF+daqxuKXm60VZYbfqB4+Spk5kTFrpLEIhE4=;
        b=LmYuLTt0lY/fqu1QmTzx4qyFxOoiGQup8HqY7WYEwXFhoCO+Y0WEaQVk4L0tjMOl8n
         6cGZDiyCCEAXutailH9rJ0WuD8gB9noL/ade3I6jHx0fBgOvNf2jVN6SKU9Ltj0gbrQl
         IS487zbRuWFCPW916Ror6yrTrLI7sMpUVbbBUjLifsucQ1/89PlVxuugQKCu/0eymgH3
         cEzFSbBHpif7eHU8sYH75Rn6tsbYBIDVSsFyqsiyCkXdXJ/sNB3daqbJHEhmvIJWmSYI
         ZggVHaEpzeHVQT47JRK/W2MpVtarrXG3UbKRRRENop1fJJaXtSPDbr3BAaXsteDRKVQa
         vGLg==
X-Gm-Message-State: AO0yUKWIp+sH10P3spFneBiRXIAc4NNeIcCLu2OtL0j7hzA7bQuhcQkX
        0o6IWoxjyjkqfvQJSnT10HazVw==
X-Google-Smtp-Source: AK7set+d/Wk+5hZQ8NSPgK4Evsk6EpiRcuFavYqIB7p0C+RXb/iGs1hy6ywVSaUPMKt3GJQZyND31w==
X-Received: by 2002:a05:6000:1b01:b0:2c3:f4bd:2582 with SMTP id f1-20020a0560001b0100b002c3f4bd2582mr1210111wrz.46.1676362360196;
        Tue, 14 Feb 2023 00:12:40 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b002c569acab1esm120587wro.73.2023.02.14.00.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 00:12:39 -0800 (PST)
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
Subject: [PATCH v3 22/24] powerpc: Remove empty <uapi/asm/setup.h>
Date:   Tue, 14 Feb 2023 08:49:23 +0100
Message-Id: <20230214074925.228106-23-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230214074925.228106-1-alexghiti@rivosinc.com>
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
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
 arch/powerpc/include/uapi/asm/setup.h | 5 -----
 1 file changed, 5 deletions(-)
 delete mode 100644 arch/powerpc/include/uapi/asm/setup.h

diff --git a/arch/powerpc/include/uapi/asm/setup.h b/arch/powerpc/include/uapi/asm/setup.h
deleted file mode 100644
index f2ca747aa45b..000000000000
--- a/arch/powerpc/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI_ASM_POWERPC_SETUP_H
-#define _UAPI_ASM_POWERPC_SETUP_H
-
-#endif /* _UAPI_ASM_POWERPC_SETUP_H */
-- 
2.37.2

