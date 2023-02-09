Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAA969044C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBIJ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjBIJ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:57:59 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2995917168
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:57:58 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1061685wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 01:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sfV9Do/HdQcq0uCvQUoySDURgWgOboDw/UZwNSh/pAM=;
        b=fSx63I84gOz9OPIxJw6+FADvwnIIRIyjvbWceLbEwIzlrgvMjqfe9MEm61vibCO1zO
         mThigyA7VOoeAMZdqZteWUtdoDker/xSwP/d23xWlB+GACN1nsnZElYk/Em7g/Nwb4GX
         QxSyjCBZk46NrajzwZII3P074OVe0p7Cc4k8sZEA2zT2ymo3E6Qy3BBzQW4yobfT1eOa
         BUaNNAV0F+1Xa+na5S7A4ojplSzUOmJeRY7utxeMigfwUFxrsAremUQyWkml3akMmXD1
         y23yO4nNh5v7bnFKnkW6Y725JL18oxzZ1q1eqmD8Lapn7LOC0vKqoPzl8uc+YGAKnX1K
         QovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfV9Do/HdQcq0uCvQUoySDURgWgOboDw/UZwNSh/pAM=;
        b=LlRM9LbkY2goAzucs1aJ5/hExaTM0lpmNkE0/mo+wIMQfXkje4v/ZcG40kdkhh3vfh
         LDx2R+axc4wz3heAdz9RlQbY47ZUVtnjF3H0ff4dbvDCAAVAMUx3Cvj23ZAn5jQEKcDx
         eYB3wJUKlifuPIuuTesClkCVun6v4SAFfv0svCQRm/j/aQWjeQBhb7ex8aW2HdpcpUOj
         ziLk+/qCofb8QOW5mEQyP5uEZGS46psNGAyZt9yRim1vNpJvt1y/dtVjW1C9emTA9qFT
         0Y/0LJIXAvhGLi0pDVEzF2cVf6ia0DFoU9UOE0lHEaSilk/PTMBzUpM2RRgBYtZxiobP
         6dQA==
X-Gm-Message-State: AO0yUKWfGpEnbaKnKXivc2TT/5Uzo3t3qtIr3b7w+VwfreSDrTZJFEhQ
        zGL7iAQy9xJYdYXNm7XXCMqykQ==
X-Google-Smtp-Source: AK7set+qS3I9bog7FRrEMzV0+pxdlS90NpWG0myLi+/1qLIMC28to8WdM8qVVaZcgrCl9AQrTayQjw==
X-Received: by 2002:a05:600c:1713:b0:3dc:5b88:e6dd with SMTP id c19-20020a05600c171300b003dc5b88e6ddmr10730501wmn.10.1675936676768;
        Thu, 09 Feb 2023 01:57:56 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7e6e:bfb6:975d:225b])
        by smtp.gmail.com with ESMTPSA id c63-20020a1c3542000000b003df14531724sm4628913wma.21.2023.02.09.01.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 01:57:56 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 0/3] arm: qcom: sa8775p: add socinfo support
Date:   Thu,  9 Feb 2023 10:57:50 +0100
Message-Id: <20230209095753.447347-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This series adds support for qcom-socinfo for SA8775P SoCs.

v1 -> v2:
- fix ordering of socinfo defines
- fix the commit subject line for patch 2/3
- collect the Ack from Krzysztof

Bartosz Golaszewski (3):
  soc: qcom: smem: update max processor count
  dt-bindings: arm: qcom: add the SoC ID for SA8775P
  soc: qcom: socinfo: add support for SA8775P

 drivers/soc/qcom/smem.c            | 2 +-
 drivers/soc/qcom/socinfo.c         | 1 +
 include/dt-bindings/arm/qcom,ids.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.37.2

