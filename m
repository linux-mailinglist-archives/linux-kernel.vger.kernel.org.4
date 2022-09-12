Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4E15B5B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiILNZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiILNZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:25:13 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830FE286ED
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 06:25:12 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id g4so6667290qvo.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6qc6Fq7WjXd45CBlCVxnAWHOUA7RJG5XdRwboZFpNcc=;
        b=B/cCxnLWF+VSZTEGMpYqw2UoHhrK85tP+s0yKHr6aI0QsNYlMgZGo7QV8/7nXg3hf1
         AQN7FOgCODDl0aI8zw83d0TfzmIdChCMS1XysKQ111UejKs/QpZSCwz4O0oGh1GD7Bno
         6Nt7AtqRXpW+DJi47KVqmQ8zvNj+0rXQO8oZD5jKvK9inOtInvpayuYY1ZZ56n6/aBWW
         fgHBARmWI2jQFUqYmNDN0tbUT7Ikpdo8IKZnxdqqMVlNaZ+6GuIB1VpiCtb9CK5DI521
         bh7ftNP6+zE8dQW4Sxw11DbpGTdZgrkd/vDmS4jAGsws7BPFnDZPaJd29x/kkYgDZbmL
         gc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6qc6Fq7WjXd45CBlCVxnAWHOUA7RJG5XdRwboZFpNcc=;
        b=SZwLPPH3HxeY+FGrVsRZ+XwZLP2RvpToHVoHo1leNUy4YIlbBXcUDNZYGbTlmC5p2V
         VL3WwMudIYkZaXQRtTyeeHryu014OhRRO3yFnrk/se5uBfaVhEu9f/KGl9bMqCSswBtF
         HfwHYLmvKRzekpWD7MRpW7/PXXruggm/QLhGD+4valbg9wB4jE6VqiMhmZHcEwk9m1tf
         /ASud/Uq6lvFjnWG3toBXbUEyFQk4ivIe0e3EKItWBPGpD9iGhvbf89Uim5Nr28lD9wj
         WIGLZanephGIITpLJRI0SI9NnGTUQwem3andY7qoO7lxWkgYi36WDTGX52cZPAiTt3e1
         zjpQ==
X-Gm-Message-State: ACgBeo1g96WlsR+HKN1wddwh7OJaW6RJ2GSUMfJSXJ5ViBPEG98YVa+i
        fpMc31//Y13CxN+keM1EgT4=
X-Google-Smtp-Source: AA6agR6SnU8mTSISRy/pYKDlx3ZPkeCI58FMZ3WtY7C262H+y9uz825k+AhPp7NmCN/Xc+uoXMwF+A==
X-Received: by 2002:a0c:f445:0:b0:4a6:9f4a:9a66 with SMTP id h5-20020a0cf445000000b004a69f4a9a66mr22987963qvm.65.1662989111544;
        Mon, 12 Sep 2022 06:25:11 -0700 (PDT)
Received: from gpee-next.corp.roku ([65.125.88.5])
        by smtp.googlemail.com with ESMTPSA id fz16-20020a05622a5a9000b00342fc6a8e25sm6569842qtb.50.2022.09.12.06.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 06:25:10 -0700 (PDT)
From:   george pee <georgepee@gmail.com>
Cc:     george pee <georgepee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Keith Packard <keithpac@amazon.com>,
        Austin Kim <austindh.kim@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM : Support for optional ARMv8.2 half-precision floating point extension
Date:   Mon, 12 Sep 2022 08:24:58 -0500
Message-Id: <20220912132501.1812575-1-georgepee@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report feature /proc/cpuinfo as fphp to be consistent with arm64

Signed-off-by: george pee <georgepee@gmail.com>
---
 arch/arm/include/uapi/asm/hwcap.h | 1 +
 arch/arm/kernel/entry-armv.S      | 3 ++-
 arch/arm/kernel/setup.c           | 1 +
 arch/arm/vfp/vfpmodule.c          | 2 ++
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
index 990199d8b7c6..5d635dce8853 100644
--- a/arch/arm/include/uapi/asm/hwcap.h
+++ b/arch/arm/include/uapi/asm/hwcap.h
@@ -37,5 +37,6 @@
 #define HWCAP2_SHA1	(1 << 2)
 #define HWCAP2_SHA2	(1 << 3)
 #define HWCAP2_CRC32	(1 << 4)
+#define HWCAP2_FPHP	(1 << 5)
 
 #endif /* _UAPI__ASMARM_HWCAP_H */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index c39303e5c234..161f8df852e1 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -625,11 +625,12 @@ call_fpe:
 	ret.w	lr				@ CP#6
 	ret.w	lr				@ CP#7
 	ret.w	lr				@ CP#8
-	ret.w	lr				@ CP#9
 #ifdef CONFIG_VFP
+	W(b)	do_vfp				@ CP#9  (VFP/FP16)
 	W(b)	do_vfp				@ CP#10 (VFP)
 	W(b)	do_vfp				@ CP#11 (VFP)
 #else
+	ret.w	lr				@ CP#9
 	ret.w	lr				@ CP#10 (VFP)
 	ret.w	lr				@ CP#11 (VFP)
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1e8a50a97edf..8887d0f447d6 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1258,6 +1258,7 @@ static const char *hwcap2_str[] = {
 	"sha1",
 	"sha2",
 	"crc32",
+	"fphp",
 	NULL
 };
 
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2cb355c1b5b7..0806b0b1f2c7 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -831,6 +831,8 @@ static int __init vfp_init(void)
 
 			if ((fmrx(MVFR1) & 0xf0000000) == 0x10000000)
 				elf_hwcap |= HWCAP_VFPv4;
+			if ((fmrx(MVFR1) & 0x0f000000) == 0x03000000)
+				elf_hwcap2 |= HWCAP2_FPHP;
 		}
 	/* Extract the architecture version on pre-cpuid scheme */
 	} else {
-- 
2.37.3

