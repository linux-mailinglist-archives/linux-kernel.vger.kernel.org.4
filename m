Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D6874788B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGDTBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 15:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGDTBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 15:01:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE0819B;
        Tue,  4 Jul 2023 12:01:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-263036d54b9so4173067a91.0;
        Tue, 04 Jul 2023 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688497308; x=1691089308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eiQcnG0xBxPngdSjyCA9YtXcq9HfBPPqojDVTf5BQ4Y=;
        b=r/Pq4xAxhdGXMZwuvWgEYRPutk/RsJuJaH2ewYmEYt3MkEPuAyAFS/r5OE/fFWYKI/
         CIZ7R/oKLrZ9z3onjn7HY8BN66YLwd07TOhmU64zGEJpyz3ItuzS+vlhsnl3HtxAFn/1
         gKkgk/UcYs+bQgU/HVsBaGfVGbpn/RhiCzQ5wsIPrUave1Th4LlQboWA5EX5PBxi5u3N
         EKI72a4If7vaVd4dICTpSaFIQ3odbWQa+2DPa7Qa200fIPxBq5WSxS1GtmA3i9ZFFYtP
         VIyIZpptNhpZmMNsqPa1YBbvzkopH9uxwFZZVRGNZ6v8LWGg4RbA/5WsUVWqzVjBScBq
         FHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688497308; x=1691089308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiQcnG0xBxPngdSjyCA9YtXcq9HfBPPqojDVTf5BQ4Y=;
        b=HGF+CmWhPLi2l6FFLbwdaH2K3Xk9p3La+p9LTksiiOpLd9i8dMoAF/CtBF5263lQbN
         KNFSwXgv1x4ZYaY9L6h9/0fRMX+MOmkOL4Y7DbelCb4zNiDGAsIc6bMP/FQ+KSfw7zFX
         3HBbiyqpfHCe+TmCuSqTlZi1FMUG+uKmz4WGS+sfJ4PuGwPqkpYZkT9d/r5sy1zC99MM
         EgcBgvhFF8PcIZZXSHyI3Ho7L7ItTFGq1tEF+prZZA5wVGz4g3/6gfjo0/80wI7HfDaB
         7cvePVb/hoXwDSlgfcWyIR0yHEAs5/t3+XBdmkejLNyjUlCdTy9SBq7zgY5JrGVzrA2X
         o/CA==
X-Gm-Message-State: ABy/qLZ80jCKCMUovR0nOnuDb+rsreMOzGuKk4bwwNPYVgglgKiuup/v
        m1l+h1rLA8GNMK6+I7vSnnEh3Yfhi4U=
X-Google-Smtp-Source: APBJJlGkB/q064LFOm0pow+xA/tO0GOb9ShtyQYmWjadpmklFJTR/D5UOzYUAwf8gusRfkrDBdWupQ==
X-Received: by 2002:a17:90a:1954:b0:262:e3aa:fd73 with SMTP id 20-20020a17090a195400b00262e3aafd73mr15737820pjh.17.1688497308295;
        Tue, 04 Jul 2023 12:01:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 6-20020a17090a018600b0025bd4db25f0sm18544108pjc.53.2023.07.04.12.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 12:01:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] sh: provide unxlate_dev_mem_ptr() in asm/io.h
Date:   Tue,  4 Jul 2023 12:01:44 -0700
Message-Id: <20230704190144.2888679-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unxlate_dev_mem_ptr() function has no prototype on the sh architecture,
which does not include asm-generic/io.h. This results in the following
build failure.

drivers/char/mem.c: In function 'read_mem':
drivers/char/mem.c:164:25: error: implicit declaration of function 'unxlate_dev_mem_ptr'

This compile error is now seen because commit 99b619b37ae1 ("mips: provide
unxlate_dev_mem_ptr() in asm/io.h") removed the weak function which was
previously in place to handle the problem.

Add a trivial macro to the sh header to provide the now missing dummy
function.

Fixes: 99b619b37ae1 ("mips: provide unxlate_dev_mem_ptr() in asm/io.h")
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sh/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index fba90e670ed4..d8f3537ef57f 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -286,6 +286,7 @@ static inline void iounmap(volatile void __iomem *addr) { }
  * access
  */
 #define xlate_dev_mem_ptr(p)	__va(p)
+#define unxlate_dev_mem_ptr(p, v) do { } while (0)
 
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 int valid_phys_addr_range(phys_addr_t addr, size_t size);
-- 
2.39.2

