Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0915C6E499F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjDQNO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjDQNNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:13:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4BBB470
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:13:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dx24so19968232ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681737176; x=1684329176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuITCu8i/li8kE8CEtM/U6x5Upz1m7yYpvjZ7zwPQTw=;
        b=IRJeIcBiZZeBw1gIQN5i/XNOGAIEtu1Tx+9I0eRau531kGeeEmJMkEXL/YiWnd3zxK
         /QnTzPYAgNnP9FAySuEbhh1fvLVCnkcxfhRoJBMV8X2b2zfQUxbRjpzc4vvgjsNFocnG
         KQiqf1n/ANrFllPa4Px5fDByIJQ1yArIDW3dctNbubxlpzaDr3KiZkFjseQL0xX/twrx
         14xdPS28LqFJ1HgQ0BkCHX8q16hUCyRqWU3921pPyg7RM1o2pDBcLTqX7rd0f2skUOoA
         JNPtS259vg1vI1vP3w0MBcXs7A30tURymO22rS7+sjeD6og7cFBmDjVM7W4dftGhh+xp
         q33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681737176; x=1684329176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuITCu8i/li8kE8CEtM/U6x5Upz1m7yYpvjZ7zwPQTw=;
        b=AnLBWMUvXEiYwWYvOBu+WLI7/y4h2OjC97o0zm3jYcdBDWVLMtaJGPiP6s8FRF1wu4
         x82Wr9DulN9+jKXys80ZmmFhnexNsm5d9CQQ8tFAeuR06cVJioEKKVYtIdadEK2AvJnC
         RAkNTrU7FazkAsTui8/6pPkLVPywHnpccE2Km/MErpOxi0r4SkPKJabcIzA1SZCuTsyx
         LKPn98HlKER6LKzyBX6xPXV6jb0Vs0eNP91sRvaZPA0jg3RbWIf6Lor3uuudXWGic80R
         SGpv0gbKlO3KoonJlVdrXFUOtdl7hTUKnvcWdrIsI5q87Ux5TXUzcsuRJ/Dq+EaPI4D0
         6gFA==
X-Gm-Message-State: AAQBX9cyg63SwJliRsCZo/FGvdX2MLoUTISJFAZwurKk/aMAItqWx52H
        kaTt/G7Szy46EMXUAOsfpkh+yGH2XLJRHeJKQQ0=
X-Google-Smtp-Source: AKy350YYJSLvINl73EmHpD86PAlOoFXuPnqV6KCbJ2kTnUUZ4i6TgTz/EYFSBIxG56b50i2GrzcLLQ==
X-Received: by 2002:a05:600c:247:b0:3e2:589:2512 with SMTP id 7-20020a05600c024700b003e205892512mr11213289wmj.21.1681736329304;
        Mon, 17 Apr 2023 05:58:49 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:374a:ffae:fd26:4893])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c471500b003ef5bb63f13sm15557546wmo.10.2023.04.17.05.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 05:58:48 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 1/5] arm64: defconfig: enable the SA8775P GPUCC driver
Date:   Mon, 17 Apr 2023 14:58:40 +0200
Message-Id: <20230417125844.400782-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230417125844.400782-1-brgl@bgdev.pl>
References: <20230417125844.400782-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the GPUCC module for SA8775P platforms in the arm64 defconfig.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b6342b40c600..e1063ab32658 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1164,6 +1164,7 @@ CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SA_GCC_8775P=y
 CONFIG_SC_DISPCC_8280XP=m
+CONFIG_SA_GPUCC_8775P=m
 CONFIG_SC_GCC_7180=y
 CONFIG_SC_GCC_7280=y
 CONFIG_SC_GCC_8180X=y
-- 
2.37.2

