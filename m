Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770076DA248
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbjDFUIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbjDFUH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:07:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88CE93D2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:07:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g5so709332wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680811672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rfkTef0ZdTkMKzZCQdBC5k73nnYAxbztufMSetHz8w=;
        b=mCMuhp+j3/ZIScGPav1F7wnjUdBKQG5tZsAQswaFdMzngFC6npciIIEQZWbzH1gUFQ
         sg8VJVfPvTwPYRZwV2oF9L74hvJYVNCm7Vjfrk7zqOToVWKTpVoJNXjOvyGNLXI2ELTf
         5xNe6Fs/wThBc1JdbSTEN/p3afVWtSY8t8rNAais0fU9QIKJTyYPkMDRWLoaBf3roGFo
         L4/23jTn/8M7RZQcgjSpOrX/RE4j76jyG2UhsRVR/78khJaTdT8d/Uh/SftSPDPZtZhX
         Y6SQRyTynq4hutVQY4Af36TZaXOt80jMT59ZX6yT3CYLlE3nApobe28AmebrSqbSh3s/
         F/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rfkTef0ZdTkMKzZCQdBC5k73nnYAxbztufMSetHz8w=;
        b=KE2l/Fg60dvIYgtFjStw9i4khLZrill2PM9rHltjJXfZ4YCDbFY9LN4sFYJqbnj4E0
         i805hk1lrNUABqBoncb1z8DmSE9Fx5LeDYfyQ5IvFFizK31Tvdc3rdhF13ud7vk6EEKQ
         VIMOuuRnlxXmnEO1G5UJg3xgDMse9Mg9pxbC/F7JArVwd31exQYV5z+to2VLSpgN9As+
         ffWgSptZ5/g0Zg9pSJCJkiP2Wvlfxe9ZFKW2mygD69bSlxP1L63Aow6yDgDqTyqu+fKL
         WwpeG+63i+znQj5PPFEf02dVr8u+JosSs6CgEheYQxGwuhqd9l4VlEJaoFebs6Mw6ojx
         64sA==
X-Gm-Message-State: AAQBX9caoDzYTcB8gDROeRXtyGo57qZo6BxxEViz7AvRAsWrCt8OqhO+
        3CaoDfnjzmf2MEG+EUW9+BneHg==
X-Google-Smtp-Source: AKy350YKkQTWxX+kH1yWryMZ/grGykBiuDsvJYQJSRjDnKkKwqTJ7J8Pu6b3BMhV3BCqCxqelyxfUw==
X-Received: by 2002:adf:e70b:0:b0:2ef:5560:bae9 with SMTP id c11-20020adfe70b000000b002ef5560bae9mr1435908wrm.68.1680811672178;
        Thu, 06 Apr 2023 13:07:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4793:cb9a:340b:2f72])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b002d89e113691sm2560506wrn.52.2023.04.06.13.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:07:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 3/7] arm64: defconfig: enable the SA8775P GPUCC driver
Date:   Thu,  6 Apr 2023 22:07:19 +0200
Message-Id: <20230406200723.552644-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230406200723.552644-1-brgl@bgdev.pl>
References: <20230406200723.552644-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 1e7021ead7f5..aaeccedd49bb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1162,6 +1162,7 @@ CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SA_GCC_8775P=y
 CONFIG_SC_DISPCC_8280XP=m
+CONFIG_SA_GPUCC_8775P=m
 CONFIG_SC_GCC_7180=y
 CONFIG_SC_GCC_7280=y
 CONFIG_SC_GCC_8180X=y
-- 
2.37.2

