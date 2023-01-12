Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBFE6668FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 03:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjALCj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 21:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbjALCjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 21:39:21 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5022A4732B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:39:19 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so19315014pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yHUC+FGbuzxyoJZZC/oBJ6Z9AMmMcVj10+sB33bo44=;
        b=G/FOM0msaVTnwbw4qK7VT0i0xMSkmfkyRGDTsBaISva6prL+2i+MtiYYTrs6j81RKE
         Xu2bDqDgZaVkxuFejICevS6TtnB35IfREiU/iajqcizWkJNlb3WijoSa/TRdfPGqKADw
         LyX2WIBosI7Qxneyp8J/C/YzlAYTTyFZxfemeY9cax1oeuZHYaQ3M7EtZpFS+m7nIX8F
         OMiYaX1MTQLZKsNoGCEKifkw6Gr4hiKXTXgrQ+o6c4Vm21ou2Djgx/gQ4EpbSneqoemn
         fzxVnXZ8pbFBPME0FGlPWdx8OQjR3r4+z9jq7Ijx4k0q4ItH5HXwWvC/0BfRLm+i6Y2o
         k8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yHUC+FGbuzxyoJZZC/oBJ6Z9AMmMcVj10+sB33bo44=;
        b=Ea8UwncLC76R5i+NLHTG41vT5rxy+8NIoiAwX+56Nk9kUwwIuracfZUiyKl0210K8i
         J+qLGGGvixtdHKAbMfPGXvFelaCUTbGxSohTA1QqaOHH2IMwneHTzERZywutQwgjvfaL
         96agHu+UMW2hARdp+K231Ni9X87vQ3N+0/hk+UZ2CSRiJZX7FMBHBYkld5K3zdbZPsl3
         dTYDydkBK9clWJ45LL68DLejNMbBcrqxzupxkmzxKl0jUeYOwOqgBUAw0Fo4+RNMzOR4
         VavY0+f7lgAh1H6WhkMuUk/guGINwyeTIUYB7b+IHQaKFEj0Q38HGoHdTZl+qtvZlYt6
         pR8A==
X-Gm-Message-State: AFqh2kpDWyvV7VquS5AhSxuR+pu8te5L+hBkOg6jWlc6tRnNdwym5WiG
        amDhkcC5fhn1iKXIg+uVu8NqYQ==
X-Google-Smtp-Source: AMrXdXue0xJ4HI4ans4UT8lvfrGxwgsi/5eRclODGohFrlmU4bptOcxuvjj7ju88KrgTJpZTkJnbGg==
X-Received: by 2002:a17:902:7889:b0:192:6bc9:47ba with SMTP id q9-20020a170902788900b001926bc947bamr63652434pll.31.1673491158898;
        Wed, 11 Jan 2023 18:39:18 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
        by smtp.gmail.com with ESMTPSA id w7-20020a1709027b8700b001944b1285easm2310331pll.198.2023.01.11.18.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 18:39:18 -0800 (PST)
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
Subject: [PATCH v7 3/7] arm64/sysreg: Add CCSIDR2_EL1
Date:   Thu, 12 Jan 2023 11:38:48 +0900
Message-Id: <20230112023852.42012-4-akihiko.odaki@daynix.com>
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

CCSIDR2_EL1 is available if FEAT_CCIDX is implemented as per
DDI0487I.a.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 45648fa89be8..90b64697345f 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1663,6 +1663,11 @@ Field	5:3	Ctype2
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
2.39.0

