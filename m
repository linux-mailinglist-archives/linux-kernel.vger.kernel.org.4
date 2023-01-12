Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453F06668FE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 03:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjALCji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 21:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbjALCjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 21:39:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6995048280
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:39:23 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso22085535pjp.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q11Z4l9+meOu0rzmEtmKXYHwkGk1nv/AXC1xA1NUM9A=;
        b=oL3TZ2dQxMBhcKitnoQhS1LoJ6uR2+zkvR8Eqz84efKSa0hVT8TfnGnO7R6drx+20E
         PNdOLie+7x4MOuZr4VI87moTqvVmPRKURVNWr4Bat8BBueScZjuYH75Gtesd8J3U4nO9
         GCepPYEPp5As+lhcQeDXihSh7ny+enh8oSYTD/gX02dL5gB5mEIUvU/0icGTXJv3zChb
         LMcriZSgeA8hD0Vo1yXV3I+l3jAmqvNG/ho1FaTbgR/GDFbZWEPEBU++O8Pz6S4LahrU
         yesMbxzBcKMRmwjElahvrCSTJk+uKumdCYCyGCbhxdd92RGq2+lJQShqQLS+0lM/u15Q
         JaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q11Z4l9+meOu0rzmEtmKXYHwkGk1nv/AXC1xA1NUM9A=;
        b=q3b58rDWZuqLlv8w0fsOP/lXBvPHSnd/kaAir1mJL3M3cuJbOGB4CyFMn4mSb0M4rR
         aJGEGbuN1pVoLbIrJoprd4wvUEjzbeZ2qyzcAIgHBifxJZx63eDHXGt/Y2k6oSPNpIBt
         hFh0CEE0YTpfhK5kG3XI+2UQ+UHk8ArCAfp/xhgr/6Cee4kNnDwVOjEk5wsRmI7gJr3h
         RdYSSiwOYUD9fQEiH/dvxEfPMuo52a+ilgKVBI+2SfN+X7Cw0cm/Jgjc3TBpr253/6/N
         G3vvXblKAGdmWqz4efBkoZ8v/e8e+9r91hc6EJtPgO4Ox97j7/YMpkQn2SmDA1VOT2Qi
         IBLQ==
X-Gm-Message-State: AFqh2ko2AIniYHjfj4by2xRwB8p2+QouE2ok+C53ZvUBU2581oNTS7sO
        teZttH+qiQNDISav+GJRr3PN6g==
X-Google-Smtp-Source: AMrXdXs4JCW4EgJN6T2CnYFlcBDqDu57etx9LSqwZ4HIj1zhBxa77MgspzOEkuOdlzRn/jHdjb+kuQ==
X-Received: by 2002:a17:902:cd0e:b0:193:37a7:cc1c with SMTP id g14-20020a170902cd0e00b0019337a7cc1cmr12189330ply.56.1673491162975;
        Wed, 11 Jan 2023 18:39:22 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
        by smtp.gmail.com with ESMTPSA id w7-20020a1709027b8700b001944b1285easm2310331pll.198.2023.01.11.18.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 18:39:22 -0800 (PST)
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
Subject: [PATCH v7 4/7] arm64/cache: Move CLIDR macro definitions
Date:   Thu, 12 Jan 2023 11:38:49 +0900
Message-Id: <20230112023852.42012-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112023852.42012-1-akihiko.odaki@daynix.com>
References: <20230112023852.42012-1-akihiko.odaki@daynix.com>
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
2.39.0

