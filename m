Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05768660D57
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjAGJqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjAGJqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:46:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2E97CBE4
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 01:46:48 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so7701338pjk.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 01:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WC3UnsmGOPR3/UTYcySRXnOtjQN5NHU3ow6N5a9AA1g=;
        b=GZWaUiXC7G9/KoJGzS+SXfWLuchaZwqiH1G0XI1U76KjSKrw6VfHPlCHtH8LMeiSyA
         je8wA/aJvQzr0jwJAD+C6qFkNSqOBEUeKSh3vXB+7WSVzFZtRGNCV0VYKZc3Ix3eYSVn
         8sK3/5wIo/GhI78FQa4Z2IkAd2C0++LOJ+Fe5qd9dTtSXA7Cumb26i/NkpnOr4fX/UHh
         O0QC4VO9TbmhfoRDFrO2+uE6a1XrNF2vcQa93hQM0yEa1zXoIfN7rhNYPBBXnJ0l1er4
         m2G2PtNtXJI23SHIhFR/N1miuNM5nIJbEvAkViQrt2qBHSUDCSqH+xBQeIVONe1sjYCC
         nX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WC3UnsmGOPR3/UTYcySRXnOtjQN5NHU3ow6N5a9AA1g=;
        b=5OScAWxl0Hme3ZeYjy2Kxb+/ANMTZgMB8FtSxTXNjLfYWWs5BcALLOd2LA9mPVO4dA
         BMewbVPg8nOwYNbPjRLHF/DrIf7lZtE4ziVQ72ICu2x1XJS9S1HS5z8C366JYPiLXT/N
         ZHKo2ZtM0IJYvtHZuhKdzucpeSkbkDl9GSjrdDoVQWF5i6Dd5nvDfncHGvmNmL09Zj5C
         Ou+qUzvjtI+c6bqWkWFMDFP9021NlZgaVvUJs0OtWtnzNzOQVAKFuFj9o+mvqVQbXdjz
         V4jGmo8faxijMzd3V8BK6KinV3H+CCRTlHtncgzk+YWb6HvcGk+75xDExBsE1yY011db
         cOAQ==
X-Gm-Message-State: AFqh2krb8WbT2kcxUmo3rvUlS1W0ED8XTkjUjP9i6MSiKQkmt7dm+xGN
        ljixCcfAPQrq2zhFhecX2Nuu0Q==
X-Google-Smtp-Source: AMrXdXsoN7BjynbX+1FW+rDVAt3A++OMZD9/ZKjTPovZH3nsBWOYvCj2DSe9MecBeBaOcFEsZwV+vQ==
X-Received: by 2002:a17:902:a513:b0:192:fe0a:11d4 with SMTP id s19-20020a170902a51300b00192fe0a11d4mr7793194plq.64.1673084807751;
        Sat, 07 Jan 2023 01:46:47 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d2c900b00183c6784704sm2263449plc.291.2023.01.07.01.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 01:46:47 -0800 (PST)
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
Subject: [PATCH v6 2/7] arm64/sysreg: Convert CCSIDR_EL1 to automatic generation
Date:   Sat,  7 Jan 2023 18:46:24 +0900
Message-Id: <20230107094629.181236-3-akihiko.odaki@daynix.com>
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
2.38.1

