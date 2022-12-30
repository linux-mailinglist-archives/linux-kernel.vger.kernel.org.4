Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13255659703
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiL3JzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiL3JzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:55:09 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B28E1A818
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:55:08 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d3so21352852plr.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zggXqOYMewY2d3hZ3CPkP3qIf0LN+Vu5ELXaG5NbWEQ=;
        b=ik8i2dsg/lcvg+AOR1XkFPLbf+47WOq+jw8TuhUVIVQWRyTfG7IJaZZMvrzfES/Mlg
         62EzM3P3LwoYs2k9zXyitXQi2IElphOjRFxxZgWs+Z6U2bdaOlTHTRJZJ8YK71mAJ+hF
         c+4Std/TW2WunQoAeFkpiMGGoD6V7w2CwnVL6rCfrpJtFYUcuauyJiRd7ugqhkFzNKOo
         irpSMGLiuw8ShHjYDpPzE4j1BwlfpPD0qQlTSIMJEL0IHdrlzCBdKMxmWc++LFXNIiWq
         7fnxUH0OWw34OYz+WYwmKOQneo9H7IytsjlRH92SbjxnTg+BNQpTaslTiynIRmshIXA6
         O3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zggXqOYMewY2d3hZ3CPkP3qIf0LN+Vu5ELXaG5NbWEQ=;
        b=Wtp1hhe9go2RWdmdI0AdBy57PHw94K/wdO1MU2gFiiLNPsBhXT7FITxsd15wegulbG
         qZZxjVvDhVKftbabEiFgMxzRybiN/NiGsgg7hgR/f6Kz/tliXd34gl751SnICVLjYs7G
         HXXYJkNVXzU4TexoYxhKFIq8ikix2mVJEEKBRzaCA2Os0e/qVfa3pU6v16Rqjwk1390X
         wkHRTEvlxuPIngBGnMrjvmDnrN1MjjncLuAL9mhCPqMHr77K6eRElAXUibBMvx74HOJ9
         ABsHULyFzzRq+2b/js9seBmckkeQrsCTiZ/AVtv6RnvOAsIYs/nzj6EwHLmwtYU9jxV9
         1GfQ==
X-Gm-Message-State: AFqh2koSoGeNB74v3rzHUq9W/fo4wQXjyfs0HLHS4xcnfSdd6RrwCWMk
        qzgdnNskt1cpJYy1hkhI8oONBQ==
X-Google-Smtp-Source: AMrXdXvGMIVFFgtATbw0q2lsn/zLJnzh6sQGfMIVn1mk9W3uwE553KoECNHYMuTkJK21nl/C/+mFdg==
X-Received: by 2002:a17:902:6a85:b0:191:420e:e6b1 with SMTP id n5-20020a1709026a8500b00191420ee6b1mr33509015plk.32.1672394108083;
        Fri, 30 Dec 2022 01:55:08 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b00189c536c72asm14487719plk.148.2022.12.30.01.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 01:55:07 -0800 (PST)
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
Subject: [PATCH v5 2/7] arm64/sysreg: Convert CCSIDR_EL1 to automatic generation
Date:   Fri, 30 Dec 2022 18:54:47 +0900
Message-Id: <20221230095452.181764-3-akihiko.odaki@daynix.com>
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

Convert CCSIDR_EL1 to automatic generation as per DDI0487I.a.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h |  1 -
 arch/arm64/tools/sysreg         | 10 ++++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7d301700d1a9..910e960661d3 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -425,7 +425,6 @@
 
 #define SYS_CNTKCTL_EL1			sys_reg(3, 0, 14, 1, 0)
 
-#define SYS_CCSIDR_EL1			sys_reg(3, 1, 0, 0, 0)
 #define SYS_AIDR_EL1			sys_reg(3, 1, 0, 0, 7)
 
 #define SYS_RNDR_EL0			sys_reg(3, 3, 2, 4, 0)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8f26fe1bedc6..097d6faafc87 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -873,6 +873,16 @@ Sysreg	SCXTNUM_EL1	3	0	13	0	7
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
2.38.1

