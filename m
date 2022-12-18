Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813CC64FDB1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 06:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiLRFPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 00:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiLRFPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 00:15:30 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D25DED7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:15:29 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d15so6086017pls.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSSvNarkcX8fxYBT0hcpDCN4tMu56rqMEzf7f5+m+DY=;
        b=iLqdfLkStRaxHz+T3WwGYnUjZRwjQLDIM6smk/z9ggwXePajQv6m0ooG9QKQ0GWRTA
         wqdAAu0KvXiBq/eKd+yVFjDuOUwe+wF+VD0VTuWUEasfwUtJtRw5ySEbZg7q74TrfE6u
         MZTYLlVYskcnskHNAw1baY8qVMmQOP3ZU4bmyuRcOtD2UWIC/3lVpWyYigGECtFjYxAA
         4CsfHveHyc6NYMba0olefWZFBbCxIl8BjdNDhdpoPfnEtcH1NOAn96086MnE1pOtjZ+n
         89ChjXUU7yurmLWae+JylmBuTNf1ZGfFjVRK1xNYBkoPA4KWHOMd3fZEZ+bYF3tYsQeg
         y1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSSvNarkcX8fxYBT0hcpDCN4tMu56rqMEzf7f5+m+DY=;
        b=NbmHagDkg6HZWG8+p1imQcvRuc08jBYJeBX5VaTCex9Tonar373BkgDzjjqMnYW5YW
         aUsaMEsJppkoNYS8NIYxJEKtyPJMYBMNQytS+ixmTnUJZsQ1ptAq3bRuRPBnvwDO7lp0
         ijREM/SgZ9E4UDia2yVPEUSr4Rr8tKKHnhC6+jr4cEQiKioR3uTQYXNvvckExCLAiLgl
         pVH3XNFBcTngZxZ6fhM1AJv4a9KHigm9WzgU7ej+dDyO9YzpbSoRhtxtP9nnST6CjLM9
         vF6ha4WBpenTl7ipGBLTctgB7zl3rzr0Ue4OJ///sJi3FUDdA6TRoxbHNHnzQLtVrsB6
         MfiQ==
X-Gm-Message-State: ANoB5pnn7p07NkokOJC1b2HBS18TEAoXaSalXGpwXhvyZYSM3gme5agc
        9LjtBAp5Kp6zDGIziDL6pDEKDA==
X-Google-Smtp-Source: AA0mqf7vb6+GyWqLL5OnXKgkL1qGpIo5stbUWTmlKYousX0ZRaRgIzvlA59WnLDwjmcjYLYidZRXJA==
X-Received: by 2002:a17:90a:b891:b0:21d:5e73:d562 with SMTP id o17-20020a17090ab89100b0021d5e73d562mr37465528pjr.27.1671340528507;
        Sat, 17 Dec 2022 21:15:28 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a6ac100b002139459e121sm7002417pjm.27.2022.12.17.21.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 21:15:28 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
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
Subject: [PATCH v3 1/7] arm64/sysreg: Convert CCSIDR_EL1 to automatic generation
Date:   Sun, 18 Dec 2022 14:14:06 +0900
Message-Id: <20221218051412.384657-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221218051412.384657-1-akihiko.odaki@daynix.com>
References: <20221218051412.384657-1-akihiko.odaki@daynix.com>
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

Convert CCSIDR_EL1 to automatic generation as per DDI0487I.a. The field
definition is for case when FEAT_CCIDX is not implemented. Fields WT,
WB, RA and WA are defined as per A.j since they are now reserved and
may have UNKNOWN values in I.a, which the file format cannot represent.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/include/asm/sysreg.h |  1 -
 arch/arm64/tools/sysreg         | 11 +++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

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
index 384757a7eda9..acc79b5ccf92 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -871,6 +871,17 @@ Sysreg	SCXTNUM_EL1	3	0	13	0	7
 Field	63:0	SoftwareContextNumber
 EndSysreg
 
+Sysreg	CCSIDR_EL1	3	1	0	0	0
+Res0	63:32
+Field	31:31	WT
+Field	30:30	WB
+Field	29:29	RA
+Field	28:28	WA
+Field	27:13	NumSets
+Field	12:3	Associavity
+Field	2:0	LineSize
+EndSysreg
+
 Sysreg	CLIDR_EL1	3	1	0	0	1
 Res0	63:47
 Field	46:33	Ttypen
-- 
2.38.1

