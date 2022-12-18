Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E53864FDB4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 06:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiLRFPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 00:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiLRFPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 00:15:33 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A3DDED7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:15:32 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso10014527pjt.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOI4ejQZZiODftrBSHrXI1yj065pP5UP36eyaXzR3dw=;
        b=5vOoY2ROQYHTbYM3+RnIE9hlmPwzzQgFUeowIh+C/4V9gTf+l5bnTa2QzkNUnqQwxr
         3GgkF6GUjCXw9MZFqkdBaBeMYIL59Cc0WtqAI9/oj1HmwjGy3flLLlS8WOMO6Pbob/Gx
         jfGlhJe3VFYnBiWMGf8du0YwYHYTQB0gnZUmWqLr2GwB9S6eTRGdZdtbF+a+mxGQ8lVb
         8Mj1VU5avG7zyE24Rk/OHZnHGBhit9avvW+NyeY4DKssVug5N7YvvKNSYQPL3FBzsHI8
         0DgZwsBfWfirRYsZFPZKwCAEOdbAIL0GAH+UYx221RmJDoHsYlz8pxB7RMqDMZ1rho4b
         1x3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOI4ejQZZiODftrBSHrXI1yj065pP5UP36eyaXzR3dw=;
        b=HwZLyjCc/dsec5I7V2J9Suczz/YF4Mof0/TJOXCyVPoS0ij2jRX9xo8Eholpz9g7TA
         GrCiOpWipA59um1qEkkHmiEw542sA/QvMO2SN1wFPmaDCWFaGxj7qSM3XurdrSboLzVb
         klXlz+dJbeUHOY+wGdmeFGhp0x/TiZHeWlx5yBx+oeCnSwrHb0k24AMpp/3u/OSjE2n7
         6M0Ybjd/vbIb2tgtchTpdyFjnJ+Nhz9XCeAS35vMKqA94auCAV9n5CRBzLZzJpkx2h56
         NMFKB/u1Xs2sm9OS8kooQQkR9frVQAzuZJuHpc4b/BAPDp+LclQMJ+gRQCCSLnNTjvCY
         wrtg==
X-Gm-Message-State: ANoB5pmEumDhWcCoPuq5PHV/o2MVdkRwX3vVtBkEMtVmky+f0SKNHYHy
        y6dSTUAx6cv8FmKL9RlayfaD+Q==
X-Google-Smtp-Source: AA0mqf40ve5metyNeR9pqP85whi8pYrughaxn166zWUj52zuKSORgShjFuv3JDhVbBqfLRVYmrDThQ==
X-Received: by 2002:a17:90a:f681:b0:219:6bf0:9861 with SMTP id cl1-20020a17090af68100b002196bf09861mr39034573pjb.10.1671340532431;
        Sat, 17 Dec 2022 21:15:32 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a6ac100b002139459e121sm7002417pjm.27.2022.12.17.21.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 21:15:32 -0800 (PST)
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
Subject: [PATCH v3 2/7] arm64/sysreg: Add CCSIDR2_EL1
Date:   Sun, 18 Dec 2022 14:14:07 +0900
Message-Id: <20221218051412.384657-3-akihiko.odaki@daynix.com>
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

CCSIDR2_EL1 was added with FEAT_CCIDX.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/tools/sysreg | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index acc79b5ccf92..0a302b4e6d7a 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -898,6 +898,11 @@ Field	5:3	Ctype2
 Field	2:0	Ctype1
 EndSysreg
 
+Sysreg	CCSIDR2_EL1	3	1	0	0	2
+Res0	63:24
+Field	23:0	NumSets
+EndSysreg
+
 Sysreg	GMID_EL1	3	1	0	0	4
 Res0	63:4
 Field	3:0	BS
-- 
2.38.1

