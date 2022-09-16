Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4A55BAD74
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiIPM3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiIPM3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:29:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD79CD8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:29:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r5-20020a1c4405000000b003b494ffc00bso1086618wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=JvFd72KY5D3Wu+OH6yJTfUfgelUDQTYT/Fh6hxhVkjE=;
        b=LedG/SkaWRkjc78Cb5B832FSMZVHAQoE/yrgB8mA6yYjq7WFPWCuUNu8gmqrEbyPc5
         c9CVx4EPnufHned/d30gLF9CkSSY1HgU+cSiWPX2EhPCJ4DJ/aIPxyxqWXlqbMby8wR8
         XWnWi3BPqLwu54YcpFuQ69a1uKxXNJyJ0Plylh3Ejj8sGLopmPdpwSunhBqFgGZjlzrW
         1SJpEGy6ic7pvk/uRiJY0u0lg+EyyljQOexIcd+q7bUkEuYNd1nyUlgoX3OYWtbAeLtr
         lNhVvDiJTErSBK3b/GzXLDfvSTh7XQD0T/EaABKgphvNE2epFz9Q0p3B45l1qoC5LlB6
         tBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=JvFd72KY5D3Wu+OH6yJTfUfgelUDQTYT/Fh6hxhVkjE=;
        b=IV2tgTYIfB2YP7ooOXJGr1lPSoLa1RGi1mL54BfW9DoymZsN6dqK+I4SK1JIUzuKVY
         xapMHPcq3m1+V9Knm1Xe4xO4UI6+UTon3oThYf3K5RNb6QYddfrnx2djvnIIfWTtfLM3
         45S20kDKz5VVpl/X5hFmavMAkVSE7kuV8E2AnBQUHk3SZQIVXtAQpnI2zX+GOiN9xWBS
         g5wok28oCwo50HwCpxmfxCQuE/1wBZKTc7llYOA5MWT6OKGJNof0ubRAMOltzSwKsH0J
         ZjJlpxUf572SBTo7+1hPlsurmfAkeLAMXrdK2SOCLIA/dgsZJ3YjMAaFHCpWGU+QQVX2
         gLIg==
X-Gm-Message-State: ACrzQf2pE9nazBpMH3YgB4VtyAvXpzu+7vieXejYfnjwevUsdqrB4ADC
        ztJqebBRKVXT8eNaEheEYNIjwG28Zw5EMg==
X-Google-Smtp-Source: AMsMyM4o/hRHgK61Qp7vt51SRaaAprtiAoTVmHarhG7yftR0NaGFNmoTgsPTTwi1j+mOmJaF3Jd0aA==
X-Received: by 2002:a05:600c:4e8c:b0:3a6:11e:cc08 with SMTP id f12-20020a05600c4e8c00b003a6011ecc08mr3228327wmq.198.1663331367148;
        Fri, 16 Sep 2022 05:29:27 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id m188-20020a1c26c5000000b003b4a68645e9sm1990825wmm.34.2022.09.16.05.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:29:26 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] slimbus: fixes and cleanup patches
Date:   Fri, 16 Sep 2022 13:29:06 +0100
Message-Id: <20220916122910.170730-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
Here are some fe cleanup patches and 2 fixes on SlimBus ngd controller.

could you pick this up please.

thanks,
srini

Krzysztof Kozlowski (4):
  slimbus: qcom-ngd: use correct error in message of pdr_add_lookup()
    failure
  slimbus: qcom-ngd: cleanup in probe error path
  slimbus: qcom-ngd: simplify error paths with dev_err_probe
  slimbus: qcom-ngd-ctrl: allow compile testing without
    QCOM_RPROC_COMMON

 drivers/slimbus/Kconfig         |  3 ++-
 drivers/slimbus/qcom-ngd-ctrl.c | 23 +++++++++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.25.1

