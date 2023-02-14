Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954EC695B41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjBNHyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjBNHyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:54:09 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9272326B3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:54:06 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so10856850wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CISuzHFPlWEL0+BckqkuDR3KPCbCkgyxsx0yLTYCfgQ=;
        b=TbwsWG1Sn+sWyFPn93RQ/E8FmcL5js4qcQYMxtbZXz+Vuq/lOwgnwszhywHHgoFdy2
         7+VWbilZfSUk+bbREGoM2Esjrn4SEdqWACckKJIxPYE/hCT0HqSJI4v1hwL5gwiFv+P8
         9Wh4x2D8Q9jU/jJEdL6p7FteTGz8eAd5CjtUvl05zpXbipeHr9ppDsTmp+Iqjh63V5oJ
         DqPmjcjAdehZFmnqAZxvgwTTbUt47kEA6Eua6Dljyl1PxvepgZOg3k3QaUD9vs/nV/G8
         D29m2UsrBWY7AG3VIwTVeQB1nAYkz8se+m7qFSN2ubp3C+Qxjjv67nhupuqOhscVsQxC
         7oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CISuzHFPlWEL0+BckqkuDR3KPCbCkgyxsx0yLTYCfgQ=;
        b=WRg7UiJ4BXjjauiQLYiwEGpL5cchqad/qrldphSjDXsI4UcsMG4zK1koKyrE2ksMCy
         syv7BqVLvKEVQ1JKnp4lt+IGwVIIBgTF5QKBhjuyR1P4lfnpT2KgYkypd+GzME5kYgJG
         bSDzlPPZnntTr74k70oiQHneiPzBIcFgRJm7kpoFJ5JsLCaUtSQo8LP56B0Sv6qT50KE
         y59n/2Qn1wumYK961ySTkHTf2fW4zsunYfmY7gLc8RiwiKZLAKqHsk/9DkZgF0Izi68z
         i8AqQAB3dawxJ9JcMcE+aQF9TnQmvPPD5NNBkV9JzNDtPWd+NHYBPmsOSSlcoLjUekNS
         cdeQ==
X-Gm-Message-State: AO0yUKXS1lsrtCMKTwJRI8+shCjQ2Rrukt1BTo+fsJ8HTYvhi9RA1/qR
        jMcwN/Rir5VMcaPFDFK6Dc0Esg==
X-Google-Smtp-Source: AK7set9BzCtqV+RYkgGgKe564EJVd05WyCH1yfNfnKO1SUr9SI4GuO9h1eq0NzoXBm8eLk/pvUJNSQ==
X-Received: by 2002:a7b:c855:0:b0:3db:742:cfe9 with SMTP id c21-20020a7bc855000000b003db0742cfe9mr1711836wml.34.1676361244922;
        Mon, 13 Feb 2023 23:54:04 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id f24-20020a05600c491800b003dc0cb5e3f1sm15292695wmp.46.2023.02.13.23.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 23:54:04 -0800 (PST)
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
Subject: [PATCH v3 04/24] ia64: Remove COMMAND_LINE_SIZE from uapi
Date:   Tue, 14 Feb 2023 08:49:05 +0100
Message-Id: <20230214074925.228106-5-alexghiti@rivosinc.com>
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

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/ia64/include/asm/setup.h      | 10 ++++++++++
 arch/ia64/include/uapi/asm/setup.h |  6 ++----
 2 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 arch/ia64/include/asm/setup.h

diff --git a/arch/ia64/include/asm/setup.h b/arch/ia64/include/asm/setup.h
new file mode 100644
index 000000000000..0b19338ea3ec
--- /dev/null
+++ b/arch/ia64/include/asm/setup.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef __IA64_SETUP_H
+#define __IA64_SETUP_H
+
+#include <uapi/asm/setup.h>
+
+#define COMMAND_LINE_SIZE	2048
+
+#endif
diff --git a/arch/ia64/include/uapi/asm/setup.h b/arch/ia64/include/uapi/asm/setup.h
index 8d13ce8fb03a..bcbb2b242ded 100644
--- a/arch/ia64/include/uapi/asm/setup.h
+++ b/arch/ia64/include/uapi/asm/setup.h
@@ -1,8 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __IA64_SETUP_H
-#define __IA64_SETUP_H
-
-#define COMMAND_LINE_SIZE	2048
+#ifndef __UAPI_IA64_SETUP_H
+#define __UAPI_IA64_SETUP_H
 
 extern struct ia64_boot_param {
 	__u64 command_line;		/* physical address of command line arguments */
-- 
2.37.2

