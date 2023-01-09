Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548DB662D40
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbjAIRqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbjAIRpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:45:41 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FD439FBE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:45:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m7so8997507wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 09:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qw8eZixHDL2dRAUa2XkR2Jsdq88VMBF0YbbIjG4LHy4=;
        b=aAtTAKNqQsYaZ/i0ZVGhOYIZnHRVYUTMZY8atbsZHlXSGzIXY5fOqxQh4oxjJGpEWY
         R0LkKitclPjp2HFv03XADNu4R5a7VDz9u2JOFnW3ruoiXI0CiS6esbVdzfMvspW22u1Z
         7U+4vx3UyT1PKPoYZt2M+eWjxjZ2lgQE8k2aY6R5SdXuIkC10ga6EjOjzRi4M20rBmza
         aE6mz6AekzBZNJ31NiL27kPapvqI5SvZ0KWZHmQZujV+eVN8PFecUdy13h2aqcyzUGkW
         XC0MyOq/VuxNt09x2IKUvysAJDuRupN35+HIHA/QIzDqIkR9zAs0lvbLgTDfUkb94C/h
         NjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qw8eZixHDL2dRAUa2XkR2Jsdq88VMBF0YbbIjG4LHy4=;
        b=OYUKmejbfy6eAj4/Qmmn0sxHwKnbIk6txznXWTTswMPnmJrLQsbHS+0nd8nzUawmsU
         Iepd0H0Tgux6xfsfEte68xt2ZlWduS7rAMEmEVYX0mKHwEIPyx+pSB0RohF570C3+M/S
         vVf5BvFHV9slfD3iEPqkFxIySDfvSCWN46EkrLvLdxrBUnsiSdtzai6gH2fXj/CEz4Sr
         OIJElIPYe1kYI8EnOcnYa6RNUMAB1jGWjKmJ/m19hRawA9Mz9Z2FEjYdGYGRuTzCTU5+
         dXQLOV+U+kR4Ijl88EjnlZjblqBPh9RiM6tNqIj8zTnO3bSAuzyxnTBtAJCSHcMke7zJ
         Gykg==
X-Gm-Message-State: AFqh2kr3QjL7UkerGXo//P+KtXKTGNjwO0XiN9DQ0DoKbRz/x5L8/VTB
        ahgJ9OY6UlOpIdTVKEVjWINmow==
X-Google-Smtp-Source: AMrXdXturhH1xyjTga/Q0FqTsjlFE5lYghYaMPrK8Ts5VSyNbgY+qI6+4j8qRQSg3cYNUwIAgti8aQ==
X-Received: by 2002:a05:6000:1d8b:b0:2aa:1d10:1ecf with SMTP id bk11-20020a0560001d8b00b002aa1d101ecfmr12306950wrb.37.1673286336572;
        Mon, 09 Jan 2023 09:45:36 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c88:901e:c74c:8e80])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b002bbdaf21744sm6142902wrv.113.2023.01.09.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:45:36 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 03/18] arm64: defconfig: enable the clock driver for Qualcomm SA8775P platforms
Date:   Mon,  9 Jan 2023 18:44:56 +0100
Message-Id: <20230109174511.1740856-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230109174511.1740856-1-brgl@bgdev.pl>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the GCC clock driver on SA8775P platforms. It needs to be built-in
for console to work.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 851e8f9be06d..1cb586125c46 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1098,6 +1098,7 @@ CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
+CONFIG_SA_GCC_8775P=y
 CONFIG_SC_GCC_7180=y
 CONFIG_SC_GCC_7280=y
 CONFIG_SC_GCC_8180X=y
-- 
2.37.2

