Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C046F1BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346087AbjD1PiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjD1Ph6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:37:58 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8372261BF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:37:34 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-187edc01fa3so54276fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1682696253; x=1685288253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CyDKyhnwLuSHe3Pt1oWnnqhaliuSPXZ8kkqT+VPebrc=;
        b=BIkkKaRpFBd3urV+vSawOBTZX0bQR+BkkO8Rd/Jc1KN8j6qLxKSPPaSXZC3n6DgAgO
         3Z+RmiHURS6ePvEOciMI/4oYVrE6dBzt6/4OtSwawXyqKobp5qMnViycUzl4HjnK4ers
         Lm0Fi45mAn83WaArPNfo9yHfPPs3SYD58Dj0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682696253; x=1685288253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyDKyhnwLuSHe3Pt1oWnnqhaliuSPXZ8kkqT+VPebrc=;
        b=cOqj6HU6braabS15xHu7CB46ggbcblHXvSZUn5yYGdXYRjYfx7UgEiGm11yHkroc9E
         /UcLIkqV8Ui5ePYMcrJuiPkYFLe4mtWXIbux90T7zH2NKzxU9z5nQ+Ak9oGd9QSau/w5
         jIuGIYrFwKVh0vBGVSUAVlUVHQRuXaBANGpM+FI5oC15dFim3qgxz6klrLks88RSdnFn
         yHF8UxcFQ+8gdlZ1/9LZnU9jJtsxYNBaeJHMG8adr17vTJYOGK5H+k9Cr4YbOzJLIc7b
         PCzPDKVBFmclS5cWwAi/nJGKlT0z9IrpViZVFY7trwIJX+nt2xE999cS2lTT8DP9FdGT
         aT3w==
X-Gm-Message-State: AC+VfDxigV1bC0ApBbbhqP/y32EmVk0EyDR6bFi0PA4teYKZ3jKwVW8f
        aVIdYep8C9FLpXEGSKNNkkuK/iPedoulEEwhgtlcwA==
X-Google-Smtp-Source: ACHHUZ54opno+yARwWVbpo8L/9U+XgM/pv7bJFIToQYYsPlIB8FVH7oJ7hmf+fPqy09NmlP8CbmfmQ==
X-Received: by 2002:a05:6870:a3c3:b0:187:7c2b:edc7 with SMTP id h3-20020a056870a3c300b001877c2bedc7mr2792041oak.15.1682696253315;
        Fri, 28 Apr 2023 08:37:33 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id w22-20020a056870a2d600b00172428894e0sm8874479oak.28.2023.04.28.08.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 08:37:32 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
From:   "Justin M. Forbes" <jforbes@fedoraproject.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jmforbes@linuxtx.org,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: [PATCH] Revert arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
Date:   Fri, 28 Apr 2023 10:36:45 -0500
Message-Id: <20230428153646.823736-1-jforbes@fedoraproject.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the ARCH_FORCE_MAX_ORDER changes clarified the descriptions quite
a bit, the aarch64 specific change moved this config to sit behind
CONFIG_EXPERT. This becomes problematic when distros are setting this to
a non default value already. Pushing it behind EXPERT where it was not
before will silently change the configuration for users building with
oldconfig.  If distros patch out if EXPERT downstream, it still creates
problems for users testing out upstream patches, or trying to bisect to
find the root of problem, as the configuration will change unexpectedly,
possibly leading to different behavior and false results.

Whem I asked about reverting the EXPERT, dependency, I was asked to add
the ranges back.

This essentially reverts commit 34affcd7577a232803f729d1870ba475f294e4ea

Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1201d25a8a4..dae18ac01e94 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1516,9 +1516,11 @@ config XEN
 # 16K |       27          |      14      |       13        |         11         |
 # 64K |       29          |      16      |       13        |         13         |
 config ARCH_FORCE_MAX_ORDER
-	int "Order of maximal physically contiguous allocations" if EXPERT && (ARM64_4K_PAGES || ARM64_16K_PAGES)
+	int "Order of maximal physically contiguous allocations" if ARM64_4K_PAGES || ARM64_16K_PAGES
 	default "13" if ARM64_64K_PAGES
+	range 11 13 if ARM64_16K_PAGES
 	default "11" if ARM64_16K_PAGES
+	range 10 15 if ARM64_4K_PAGES
 	default "10"
 	help
 	  The kernel page allocator limits the size of maximal physically
-- 
2.39.2

