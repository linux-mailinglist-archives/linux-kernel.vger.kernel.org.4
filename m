Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326F66668FB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 03:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjALCjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 21:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbjALCjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 21:39:16 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7A44086D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:39:15 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso1467516pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWGlTS8+yHcgXZKRtAzBrKdh4sbwRwlmgz2Vd7srghs=;
        b=6gAjtKNnIaTPJBhOC31QUnQAENMLhTTnXyG9U4wR7LqVdyWYCj5FwgBR0YBYk+Uwn5
         9VZpwi0U3dL4puxYQi98k7+YqN+T6IgAZqXUfkvolQ3gC9/nrn5bFy8FuIh0je95Vpp1
         askvGKIJskp3GkF67XlpSZteo/0E/gKLusdq08nvHqZsrKC5/xnvqs5u5x4Uklx9OshT
         jD/16aMbK2ZhOHiVPX7KNU5HJ4Y6unXTDUQgXO14lgMXvvvpfg5ZnkCoLQNt+aqof/Du
         6ru9i5khQ8xAEPn9Ked57yZ9J75lQD+hFhMoO2Mh0MYxkZYHQ6EvBQWjY6McT1wt7qFV
         FT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWGlTS8+yHcgXZKRtAzBrKdh4sbwRwlmgz2Vd7srghs=;
        b=fP5ev0yBsznagnCiFi9Sf/vL7gNiPNgL4xyIld5UHzUMW2UbDNZhEPnE02qGlxaVlU
         A19UWrqE3lS+9ANxm5dE8qdXjPBHelBomFUxKNBbrY5SPukYwegcyVJPfllPnEOudWSm
         hVMbW5m1xPKYKq2Gt8B/Iy2uFw9Vi17oaCMgeX/USJK71PtGswLW27+KbLJ/dJw6pQ32
         /zwtDNCvKKE9F5KR0J4Ax7OhT/ZuiDaGi1rkwknk2LbQmjs+t65mNjTKx47yTlO848tS
         vcMyBlvi+RLxoItj9oxZKI8kjAnDxj9BDiurXUA/ajQ2eDoxvyKLNGhH+pQVRq4htG/Y
         pRiA==
X-Gm-Message-State: AFqh2ko8ox11T5om0v8WcjKpRFpDuOoThTHd4wwwBDKau5lBLieIGpJ4
        qY8bZvBI46K3sNNs39LMFEQYOw==
X-Google-Smtp-Source: AMrXdXtWWWycGnURjan6UARSOEmwP/lbYNDRVbY4DK7ruYKAglN8VqBmCIRpKg4ZdfTsSwzHDZJIjQ==
X-Received: by 2002:a17:902:d5c8:b0:193:38b4:b9a7 with SMTP id g8-20020a170902d5c800b0019338b4b9a7mr12733028plh.31.1673491154915;
        Wed, 11 Jan 2023 18:39:14 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
        by smtp.gmail.com with ESMTPSA id w7-20020a1709027b8700b001944b1285easm2310331pll.198.2023.01.11.18.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 18:39:14 -0800 (PST)
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
Subject: [PATCH v7 2/7] arm64/sysreg: Convert CCSIDR_EL1 to automatic generation
Date:   Thu, 12 Jan 2023 11:38:47 +0900
Message-Id: <20230112023852.42012-3-akihiko.odaki@daynix.com>
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

Convert CCSIDR_EL1 to automatic generation as per DDI0487I.a.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h |  1 -
 arch/arm64/tools/sysreg         | 10 ++++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 1312fb48f18b..a2a93b3fc557 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -404,7 +404,6 @@
 
 #define SYS_CNTKCTL_EL1			sys_reg(3, 0, 14, 1, 0)
 
-#define SYS_CCSIDR_EL1			sys_reg(3, 1, 0, 0, 0)
 #define SYS_AIDR_EL1			sys_reg(3, 1, 0, 0, 7)
 
 #define SYS_RNDR_EL0			sys_reg(3, 3, 2, 4, 0)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index f754265aec5f..45648fa89be8 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1637,6 +1637,16 @@ Sysreg	SCXTNUM_EL1	3	0	13	0	7
 Field	63:0	SoftwareContextNumber
 EndSysreg
 
+# The bit layout for CCSIDR_EL1 depends on whether FEAT_CCIDX is implemented.
+# The following is for case when FEAT_CCIDX is not implemented.
+Sysreg	CCSIDR_EL1	3	1	0	0	0
+Res0	63:32
+Unkn	31:28
+Field	27:13	NumSets
+Field	12:3	Associativity
+Field	2:0	LineSize
+EndSysreg
+
 Sysreg	CLIDR_EL1	3	1	0	0	1
 Res0	63:47
 Field	46:33	Ttypen
-- 
2.39.0

