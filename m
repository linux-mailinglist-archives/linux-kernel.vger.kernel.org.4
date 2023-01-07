Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C503660D59
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjAGJrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjAGJrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:47:08 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7352F7CDC3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 01:46:56 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so7742688pjq.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 01:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WsGIW0prujF8xnGwWysGoOLhN4qrtpWJqnT9WJSTvs=;
        b=uwwO51i+XHTXo8O9nKgbbA0lOkbriZTkrqa8jcN0VhIN4prie8UVuu7ej+GkwXbm5y
         jK0FWBckpsVp4AvFJIy2ne2goeAO3ym6QnETeO+6noasVeGVFnrKBMnXYfgicYGudp4b
         ESP+A9AzOlNEOZ3mCInyRtZC8an612XUuza95ok2/JoQy/eWFZ5NBP18Kv2hjxIFc+Ct
         DHp3cmMlP9f/519jZ5CvvPu8kjHLiPxFMeTDPglFVthapVvf4DgIzplS2sgkvx1CuQRK
         YaJkL5h4dVVQUO2DUetmoWH7VYCHdFRDFR8hj1dYIpgvDmrWn3WObSGNJAH7MrUOXUvQ
         MGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WsGIW0prujF8xnGwWysGoOLhN4qrtpWJqnT9WJSTvs=;
        b=kGvIRiNuiKK+SM0UvwAbebdIiHCAiaZTBAXxXaRXx883sXFeDqk9REJISs8AaQw2v9
         rbOp6De/j9YLa1Iiuh9VZhT06HpCDSQLRPazkesfUiK7B4yDYlCPg6TiE0fMVm+cac74
         Seyx40+P5300rF1+jwcira9SsCUXwdQLrBM6N9jCR9iQhS8wo8MaXfs8JlDNrRrJ9R/K
         9Q/uWJTSh98F/Vy3SJzudlVDHsDHcUam/I4PMNu46NqPQL9UaaXoLR2/GHtOdbG+kZYJ
         CVqBn26lLSsx9nEGtmx8jyVUqilXLy31sJSHeH72h8Q+ARj2z8vbxtTBh5DC0yw/0w54
         dPoQ==
X-Gm-Message-State: AFqh2koqPukwD3y5pAZpaOCr4VmHP6T/t9/IFvLyCMG1aFm30FMXX7LU
        YbS2GhJqs4Dvr/p07rh/1BWI9g==
X-Google-Smtp-Source: AMrXdXsdJ6TeUQc1Kx3Tfav35gNPG1ueF1TbZrqaKgy0AtqGnB9bhh4LQY40bWlMQSU35445eoUkfg==
X-Received: by 2002:a17:902:cf0f:b0:188:f5de:8908 with SMTP id i15-20020a170902cf0f00b00188f5de8908mr60574722plg.65.1673084816052;
        Sat, 07 Jan 2023 01:46:56 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d2c900b00183c6784704sm2263449plc.291.2023.01.07.01.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 01:46:55 -0800 (PST)
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
Subject: [PATCH v6 4/7] arm64/cache: Move CLIDR macro definitions
Date:   Sat,  7 Jan 2023 18:46:26 +0900
Message-Id: <20230107094629.181236-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230107094629.181236-1-akihiko.odaki@daynix.com>
References: <20230107094629.181236-1-akihiko.odaki@daynix.com>
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

