Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD355BAD79
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiIPM37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiIPM3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:29:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFF61116
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:29:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay36so6422623wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=aibk6Jc9VAZ5PSG3dauyBZkAwA2GeZcL8c5pEn//11Y=;
        b=dCMChoikGfDu/Q7zhcPNMzfo026BbCwMA3C7i5Fm9nvwoPi575yXSnt4ZuYHMSk5Sn
         Tyt1zN7NM59PJkR2Cuisk/zqJOa+u8bU3MRLlLRQJh5HBi/gv3wySgf5clxHTWMjz6rW
         ErssEs+4vHQy/6Wl6yBWs+x9eq0QRS6TBTynf+YOD/XBL0dDCG+R7H6YCPjSWSA7mWvV
         +OSfVnV2js8b68fqwJcsOCTXVB5b3+ahiy+vhR+GOdXexkRoeZDvxuFdhcUYmJ6p+nfZ
         d5NSiBRudN7sjIMzCL4EJA7aodL0tY7BdzZlYR2P+Q67/yId2AvUVoTK172t97fv0eE0
         7OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aibk6Jc9VAZ5PSG3dauyBZkAwA2GeZcL8c5pEn//11Y=;
        b=i7Lf++4RkShvVvQCFkGJkKO9gJ957aQhposWgg4r2kdBcwBfLRhPhWBoJ2Of1CUFO5
         hmvUUjo3Rino5ZlaokzgB0QhkgTRseqX3Ko4IatBt/WtMK2BBwPFXPl5FMi2jIp9JDT4
         8HnBHL+vWL0fP/PE/4FXJFtD4LeLPILzJjU7b7asjipkq+nPF7i/nCD7KaFtENp+b4oX
         KlbyRpDgOphjpQNd+L9s+/od0FV1ELDG0ch5QPpIHiJFDodkdVHzlmPq/boE//VKRkep
         0hyYD0cRI+oCHedA3D9tivM8zYp62IBoQ8jy68Sn9hfKZyEMVn7n9NZa/TWi+czZiOiW
         RkzQ==
X-Gm-Message-State: ACgBeo1t1W9Wxro+7zOmteObCS3bywEjBx2QObGlyVbbTFzdjym+8v5y
        fMSaIGbMZA8pPwYiFMCoQHbfKg==
X-Google-Smtp-Source: AA6agR61DbWvoQEMtBUS/Q/nln2iLqn51Y07MebWxX2PHXX7J9JqoQjso//12id3wZBzWiyzkDCLxQ==
X-Received: by 2002:a05:600c:348e:b0:3b4:a9f1:c240 with SMTP id a14-20020a05600c348e00b003b4a9f1c240mr6304682wmq.192.1663331371025;
        Fri, 16 Sep 2022 05:29:31 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id m188-20020a1c26c5000000b003b4a68645e9sm1990825wmm.34.2022.09.16.05.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:29:30 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] slimbus: qcom-ngd-ctrl: allow compile testing without QCOM_RPROC_COMMON
Date:   Fri, 16 Sep 2022 13:29:10 +0100
Message-Id: <20220916122910.170730-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916122910.170730-1-srinivas.kandagatla@linaro.org>
References: <20220916122910.170730-1-srinivas.kandagatla@linaro.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

The Qualcomm common remote-proc code (CONFIG_QCOM_RPROC_COMMON) has
necessary stubs, so it is not needed for compile testing.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 1235b7dc8496..2ed821f75816 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -22,7 +22,8 @@ config SLIM_QCOM_CTRL
 
 config SLIM_QCOM_NGD_CTRL
 	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
-	depends on HAS_IOMEM && DMA_ENGINE && NET && QCOM_RPROC_COMMON
+	depends on HAS_IOMEM && DMA_ENGINE && NET
+	depends on QCOM_RPROC_COMMON || COMPILE_TEST
 	depends on ARCH_QCOM || COMPILE_TEST
 	select QCOM_QMI_HELPERS
 	select QCOM_PDR_HELPERS
-- 
2.25.1

