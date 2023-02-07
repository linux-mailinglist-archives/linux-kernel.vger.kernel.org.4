Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92E768D39E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjBGKHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjBGKHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:07:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA1719F15
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:07:34 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so5729543wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2bUmzyfqOyEnpTaYpyDnunYUhui4cc0dg5QjGPGCBeU=;
        b=yYIzBZLZjAKSmKXH3OGQM4VOdBfFtdvdBBqQeIKJALRs1Gj2T1yM/TSuffZR/tgO9d
         s10pXpSQ3ER3CDj/kqaZrpJtOo05poBxBBxt5tIrcblN/HpHclhLNVtzgplWUiM6QrVa
         QTx4U3UtlXnw27NxJNE+U57LZXEC4pb1hyIZC5CDqI8zmKmb2tgnJvqooVEmx1oJPkib
         q5J9sQ/IDFNHEL6XFr1/vIa5c606LJqSE7OYEOcMdraFfZKHvT5aFK3T4dfP2a9mQBgX
         X0kLIFvSkZLWA23yFe1r1H0t+MhNTm1exRdf5qxMoyswRAabzOPBylC7BNijrfwYh+Mz
         rj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bUmzyfqOyEnpTaYpyDnunYUhui4cc0dg5QjGPGCBeU=;
        b=cqv+psIehdmKX4HZmvCMb2d1pXeWAdGtz0GIaFaG68m6DlgWo/ABXKqNCS/fxr/+R8
         0VGhajScllTbJkZBsgK3e86XB9oaMlH0DmJ5Levwzy37jprOT2wFRQTliBZhqyPXlfAI
         uI5n5g9JemsAFMCSSVUkWD+ZizPdZqHVN2whOFFn0JtefubXSbttKKJUViEPsmq9Obul
         w6NXARsX59FohsNPkLgwlkySN5iUIZdR2n5GSvNa408bTqZBPCE9Jc9DmqnpX3vAUgR7
         p4EDmXq25jiMAbNyxP6Pp+phs3HT0dyB4QryiE4lPTMFylpxPYJBhqJYhG9xS6Tdlqab
         /eiA==
X-Gm-Message-State: AO0yUKXf65LEPO5fZeG5NghklPbneMZ4R6bQO7tRAupVJD+Xqqe7xOxN
        /IIb6uhd/DH7lFFDEjFEcS7ofLhyX2AVSL/w
X-Google-Smtp-Source: AK7set8y9+iFilpoEeJDurTwNm5aImAhBUZgLCyhAcEX+H3u1cP3uSwvJbbYT1c1ZfExuTsb7voqNg==
X-Received: by 2002:a05:600c:4da5:b0:3df:de28:f819 with SMTP id v37-20020a05600c4da500b003dfde28f819mr2625901wmp.15.1675764453180;
        Tue, 07 Feb 2023 02:07:33 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:274f:8489:6db8:7d33])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d4572000000b002c3e7474b0fsm5283173wrc.13.2023.02.07.02.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 02:07:32 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/3] arm: qcom: sa8775p: add socinfo support
Date:   Tue,  7 Feb 2023 11:07:27 +0100
Message-Id: <20230207100730.218725-1-brgl@bgdev.pl>
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

Bartosz Golaszewski (3):
  soc: qcom: smem: Update max processor count
  dt-bindings: arm: add the SoC ID for qcom SA8775P
  soc: qcom: socinfo: add support for SA8775P

 drivers/soc/qcom/smem.c            | 2 +-
 drivers/soc/qcom/socinfo.c         | 1 +
 include/dt-bindings/arm/qcom,ids.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.37.2

