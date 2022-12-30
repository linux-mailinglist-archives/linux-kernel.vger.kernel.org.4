Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F8F659705
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiL3JzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiL3JzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:55:17 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEF01A809
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:55:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n12so8903778pjp.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WsGIW0prujF8xnGwWysGoOLhN4qrtpWJqnT9WJSTvs=;
        b=MZ6hFxp5qb6KiM3qQ8o8778D0L6Lw+2wriw4sEEuZvPRigiDoS8q20iBToS0o8mTbr
         8UOGh6wBCkHuycrokxGKZ4NTVN5uQZSEuvHR7gzhS2+91NYif0CMakcWPjQvot4xaAnN
         kIOvYiyWnjVNbJtIDYqZDdSIA+SB8xBhoVH7WJEOnmynYxuSyJ5aBQIjTjrtf9hOSlBL
         AfIX9IV7sdlPCbp4GqUEztdfZ8RTVdjOpZXDELTHY3reO2aczIVPa6xmQIDNkHg9v6kV
         dmQLbjAt4B1fV50c8E0Mk4JkDGZFAas4wwraQ7HBhmWI2p0CDi2RMsjxTycA9zfR08JG
         bGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WsGIW0prujF8xnGwWysGoOLhN4qrtpWJqnT9WJSTvs=;
        b=VGrTLlX6ZnEJtODY53PJpZWBx/NWjDwJ5T209sA/e96uF/Z14AhMDw7piaFZQP+Lax
         nTd/5Fv8Hc36lYvB1uiiJ2aLxLe6KjDMQPGQsQoeZjoqgPN1KkJxgz9PQJAALZGN3GP6
         gQtM9SUpkAeu0lETD8YFwonhrGczq23kxRxGsZZFQrl7WSPCDuArit0bbv7r8e3ci44G
         ooXD7wp1qHUVY3o6P3/5aSlaTkz+hW5E841CpKWVNxn9u/YzEl11sabJLC1XvJe6W+Go
         DpvzNu2kHOhiANqnivdAb5jdvCaQBUhotrQE0rLSqlbc1c11jCkoc9VZ1gkQvJe3KL/K
         bxew==
X-Gm-Message-State: AFqh2kol23CCHFxgYc/x+5ivOnSuxxBcXmkg7CKS+U2TB1rwM8NEksP5
        GwYLzt06hMlIobcHoEvbExSUWg==
X-Google-Smtp-Source: AMrXdXss13QkrMhRA6dr0nvpfHQKU4tawzB8AD/+ZDrDtMGJ64TnpAhtOhFlWJsYFDiTDW6CVK9iCg==
X-Received: by 2002:a17:902:d051:b0:192:581b:25d3 with SMTP id l17-20020a170902d05100b00192581b25d3mr26381526pll.17.1672394116193;
        Fri, 30 Dec 2022 01:55:16 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b00189c536c72asm14487719plk.148.2022.12.30.01.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 01:55:15 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 4/7] arm64/cache: Move CLIDR macro definitions
Date:   Fri, 30 Dec 2022 18:54:49 +0900
Message-Id: <20221230095452.181764-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230095452.181764-1-akihiko.odaki@daynix.com>
References: <20221230095452.181764-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros are useful for KVM which needs to manage how CLIDR is exposed
to vcpu so move them to include/asm/cache.h, which KVM can refer to.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/include/asm/cache.h | 6 ++++++
 arch/arm64/kernel/cacheinfo.c  | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index c0b178d1bb4f..ab7133654a72 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -16,6 +16,12 @@
 #define CLIDR_LOC(clidr)	(((clidr) >> CLIDR_LOC_SHIFT) & 0x7)
 #define CLIDR_LOUIS(clidr)	(((clidr) >> CLIDR_LOUIS_SHIFT) & 0x7)
 
+/* Ctypen, bits[3(n - 1) + 2 : 3(n - 1)], for n = 1 to 7 */
+#define CLIDR_CTYPE_SHIFT(level)	(3 * (level - 1))
+#define CLIDR_CTYPE_MASK(level)		(7 << CLIDR_CTYPE_SHIFT(level))
+#define CLIDR_CTYPE(clidr, level)	\
+	(((clidr) & CLIDR_CTYPE_MASK(level)) >> CLIDR_CTYPE_SHIFT(level))
+
 /*
  * Memory returned by kmalloc() may be used for DMA, so we must make
  * sure that all such allocations are cache aligned. Otherwise,
diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 97c42be71338..daa7b3f55997 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -11,11 +11,6 @@
 #include <linux/of.h>
 
 #define MAX_CACHE_LEVEL			7	/* Max 7 level supported */
-/* Ctypen, bits[3(n - 1) + 2 : 3(n - 1)], for n = 1 to 7 */
-#define CLIDR_CTYPE_SHIFT(level)	(3 * (level - 1))
-#define CLIDR_CTYPE_MASK(level)		(7 << CLIDR_CTYPE_SHIFT(level))
-#define CLIDR_CTYPE(clidr, level)	\
-	(((clidr) & CLIDR_CTYPE_MASK(level)) >> CLIDR_CTYPE_SHIFT(level))
 
 int cache_line_size(void)
 {
-- 
2.38.1

