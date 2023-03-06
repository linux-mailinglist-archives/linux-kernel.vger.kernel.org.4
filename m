Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04946ABB51
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCFKM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCFKMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:12:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C21D2596E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:12:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j2so8172738wrh.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678097514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1h0okW1SUYRg49oazoVjcO5bMYOaJZLCLBwHV2dZW4=;
        b=EMZAl0BqiCWold3b3C38rsHmbpnckzvazuotfqyAygprjpgHtlCdk95ea79kWKRLrV
         U6XMhHFvclkOgi3L/v+ylZBOQvn6tUzvuim0HQwUKGxupR8pr/cdpnka84ciGvoHp5MK
         5nDpzoZyRplE1XFnz9Ax5iwVaQ2FV1wHFg/NU0X8O4tXbIlWYCy6CTVNW1KIYOAzQHpN
         tWE9Kcl6bAIP16bXSlt4/0Ihie/5/kcSj0xSK8mLx71UONBN30F0Qd3KHBHvhCbVm11k
         7+Ft57b+ldj7lu02+cEIDJ7Q+pG2qxi/smqFvzGRYUionCSrC0vXRgpWchZKphYQ9tnh
         0KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678097514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1h0okW1SUYRg49oazoVjcO5bMYOaJZLCLBwHV2dZW4=;
        b=cdJR3TQkTDROlqcjQfKlpaS0Kt+ZSSPuc9oKYlH+LDOMpM5HBM5VyKCGk/qXGQDNhP
         iCvGQIavG1VzT629/thIyjKp+X9yjBdJ95GjxTd1bQlV82f3F51/sgd9kH/CHW6UhUsj
         NcG+byRMCu0AUk5YtE2GWBUALHF85i/aNO3ABHQ6JyrU0KX6RnWdaehZxqLI5sHA0PDL
         0RVKBm73otmqSSMPFxd0/zwNagkE7OSHyoqwvaAFdK0EHYITL+SEyUpJtt4TT5zYtN4H
         E1XvZ1A5NPVcuCrF9wkuP3/4unOVRHcKgiBUSwl5IgbhKsP1NlfnlipcaNTDhKd6+QPR
         qlyw==
X-Gm-Message-State: AO0yUKVys6J6nQ5Go2mlnvbu5JurYWNfRv2y93wZr3oDfTiAbqVWYY1Y
        3bckQwgezunQqVKe1N3AHYsA1Q==
X-Google-Smtp-Source: AK7set84SDqJMyb5tX4HpLYkx78YL5jTu9vCbAM4nh8g1qMolbgUVkJmghsotdDVgwziiFCkBXpIDw==
X-Received: by 2002:adf:e908:0:b0:2c3:e0a0:93f with SMTP id f8-20020adfe908000000b002c3e0a0093fmr6273394wrm.8.1678097514529;
        Mon, 06 Mar 2023 02:11:54 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d40c3000000b002ce37d2464csm5799852wrq.83.2023.03.06.02.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 02:11:54 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 06/26] microblaze: Remove COMMAND_LINE_SIZE from uapi
Date:   Mon,  6 Mar 2023 11:04:48 +0100
Message-Id: <20230306100508.1171812-7-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230306100508.1171812-1-alexghiti@rivosinc.com>
References: <20230306100508.1171812-1-alexghiti@rivosinc.com>
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

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/microblaze/include/asm/setup.h      | 2 +-
 arch/microblaze/include/uapi/asm/setup.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/include/asm/setup.h
index a06cc1f97aa9..2becbf3b8baf 100644
--- a/arch/microblaze/include/asm/setup.h
+++ b/arch/microblaze/include/asm/setup.h
@@ -7,7 +7,7 @@
 #ifndef _ASM_MICROBLAZE_SETUP_H
 #define _ASM_MICROBLAZE_SETUP_H
 
-#include <uapi/asm/setup.h>
+#define COMMAND_LINE_SIZE	256
 
 # ifndef __ASSEMBLY__
 extern char cmd_line[COMMAND_LINE_SIZE];
diff --git a/arch/microblaze/include/uapi/asm/setup.h b/arch/microblaze/include/uapi/asm/setup.h
index 6831794e6f2c..51aed65880e7 100644
--- a/arch/microblaze/include/uapi/asm/setup.h
+++ b/arch/microblaze/include/uapi/asm/setup.h
@@ -12,8 +12,6 @@
 #ifndef _UAPI_ASM_MICROBLAZE_SETUP_H
 #define _UAPI_ASM_MICROBLAZE_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
-
 # ifndef __ASSEMBLY__
 
 # endif /* __ASSEMBLY__ */
-- 
2.37.2

