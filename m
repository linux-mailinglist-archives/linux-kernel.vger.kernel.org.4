Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB770082C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbjELMhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241183AbjELMg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:36:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15D411D93
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:36:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50db7f0a1b4so7256055a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683894998; x=1686486998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZQ8GDuFAvgqepYx6b1uzHQNtmnv1SVXVHXSDSbTkGE=;
        b=mwlpr1pQ+DZQA69VLo6Ah/pyM2RCGPGxG3v/jKXRCzXMlTzAEDwPXWzwZYmJoiE2Gu
         5N5jX3qGQtSrgUoJabYcq1wpq7cnIRNuPeOHd/UCZj8Uv0PaeNxZ4WJH2T4CAVodHkUq
         RhJpDFQhyjDK0Beo2F7ucClKIAk6hJvY7TVZV72NZePKO+4kgi5BzmDGiFLzw+IQW8uL
         LfXX5TkFoi3iHzoD7QK5usfEww987Gy3swJ86+jZ5s3FEUk5oaQUPl0OwJufVrzxv30H
         gIU/ut9LVagUSN9XXLUEjvxEntCZlnLCgYXsy59+HkdhQfwY2AMt16OPo3LyEhefVO91
         cWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683894998; x=1686486998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZQ8GDuFAvgqepYx6b1uzHQNtmnv1SVXVHXSDSbTkGE=;
        b=l+goRGmRqr8q67JH7n1vfvVoZaddprS77qaLVnGw4CHt+tkOSOYXmQtjtdkhp3VtJI
         pMqBAkq+pfxsgQKqCnOaRdlxIuJXGHm6K4hqftHV+iKIYyhF2Azl1hEW2mosS4yblGJX
         T/UWNbwch9zPFtknXtvePVajA1ghDz+Axp4YrnqEQxPtKvh73YUGHyplUEzC85TMdTyf
         /oLZHk6GYhvvdaT9ot8cQRF8M6ToIqB0TGsnfkJOMVtwe1oqSu6J2GrZbOK50aAWUROA
         jZsKAn6Ws/muNJN7UxwdXdkJN9wcr6kuC08REhpdfe/v8FouzILZ2imXHNGqgTe4ogAy
         iOxg==
X-Gm-Message-State: AC+VfDwe9MaxLAcPbklY0lMp6m/yuzDFOTb6QdGMKoqJaGUROHJt7PVw
        ZTeUVeEsKncFcuU2O4GdIP7NtzSUHELGW/RyvW0=
X-Google-Smtp-Source: ACHHUZ6cr+6qvMXlf4sTm1nzBfllxwPKGnmkue0ah5ho5GBasL67Du4GTO5zsFiLnqh9pe0c2oVGAQ==
X-Received: by 2002:aa7:da0a:0:b0:50d:b92e:d1ff with SMTP id r10-20020aa7da0a000000b0050db92ed1ffmr10565067eds.0.1683894998357;
        Fri, 12 May 2023 05:36:38 -0700 (PDT)
Received: from hackbox.lan ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id c4-20020a056402100400b0050bc41352d9sm3852978edu.46.2023.05.12.05.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 05:36:37 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        manivannan.sadhasivam@linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] soc: qcom: Rename ice to qcom_ice to avoid module name conflict
Date:   Fri, 12 May 2023 15:36:32 +0300
Message-Id: <20230512123632.3024857-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following error was reported when building x86_64 allmodconfig:

error: the following would cause module name conflict:
  drivers/soc/qcom/ice.ko
  drivers/net/ethernet/intel/ice/ice.ko

Seems the 'ice' module name is already used by some Intel ethernet
driver, so lets rename the Qualcomm Inline Crypto Engine (ICE) from
'ice' to 'qcom_ice' to avoid any kind of errors/confusions.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v1:
 * changed filename from qcom-ice.c to qcom_ice.c (with underscore)
   to be in line with other Qcom SoC drivers.

 drivers/soc/qcom/Makefile              | 2 +-
 drivers/soc/qcom/{ice.c => qcom_ice.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/soc/qcom/{ice.c => qcom_ice.c} (100%)

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 0f43a88b4894..cacf3113ec3c 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -32,4 +32,4 @@ obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
 obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
-obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= ice.o
+obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/qcom_ice.c
similarity index 100%
rename from drivers/soc/qcom/ice.c
rename to drivers/soc/qcom/qcom_ice.c
-- 
2.34.1

