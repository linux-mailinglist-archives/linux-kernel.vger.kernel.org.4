Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9425E7F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiIWP7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiIWP6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:58:32 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC46147690
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:57:50 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x29so581370ljq.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QErVhPRsr6N34SxJtyWhiwnyHyeW0kuOVw7a/uaJPXU=;
        b=K90C3hBC6wd5wX5fUY+1rT0FrcxSVMtXeBam2xxfpXbCDnmo2fyDcdgG9nSnADKhgc
         o2OWb061x6VWvbk9dEQrp/ePFAimAEzue6BUNwKD8D+jnciw5fX8KSljEMbkxJ4ubc5+
         JcsV14M4u1b4vcTxCWhY/vF4t5qB+ONaqEsca+a0xJ8LewPoup13Tr+JooMVwEw/6NfW
         VL9HsHhxI9BEbeBoZsgPhA7P5nhbAvydwvQo8DZ9hwF9uZ+OY35lyF9WSCg/iLLERh1O
         Hy6hTcAaGuVVEh5xCawr/KmXvG54ToUvvcdhRwVK6HCyTvcjHApHE4dAHP4Q5DniMhzR
         lwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QErVhPRsr6N34SxJtyWhiwnyHyeW0kuOVw7a/uaJPXU=;
        b=ZU78cVBHvH0AIFEAMzcCKydqJqlmfrKBFrPhz+XJO7wiknkQWb7HDOAwSCF2myw5QH
         r113LZhbLgTWWuxe5YsUOQP+TzAbV9GjabKoEUOYpHvjmnwClLbY2B/4qYueimEEYjmD
         Z83pBV26Z+tFP3zxWC7Ij3bMsVw2HSeZY96BuJl2t69UIo0hBM3t22pHmgXyUL9k/eCw
         qJFX5r+8yOQVtT/slnLEC6PlmiVTY5UycAwsJbV6FbYZKm6K5pT4Fgpt1R3yeX0chev5
         0EGnGoLNsgsIWwyY9ZKzgoIpAK0EpfHtukqvNmVR+bf0LkfYw5PeF4hPan2xxY7gP3GF
         zt6Q==
X-Gm-Message-State: ACrzQf1lWfUno+LRktbBaOLc3mZ3ei24sg5tBNGrd1+jqBmOa7gBbAna
        gEWeioeBwbCFmO8A+c78pYwPHw==
X-Google-Smtp-Source: AMsMyM75V1fMGaL7US5/aDsMjZmatRFTONq2M7J8EAALYekOySKgoE+XfmX2rP9Y0C4bmxwyKYSNYQ==
X-Received: by 2002:a2e:9dd3:0:b0:26c:3c23:a7e0 with SMTP id x19-20020a2e9dd3000000b0026c3c23a7e0mr3014306ljj.22.1663948668446;
        Fri, 23 Sep 2022 08:57:48 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be17-20020a056512251100b0049a4862966fsm1502286lfb.146.2022.09.23.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:57:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] slimbus: qcom-ctrl: drop unneeded qcom,apq8064-slim compatible
Date:   Fri, 23 Sep 2022 17:57:37 +0200
Message-Id: <20220923155740.422411-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923155740.422411-1-krzysztof.kozlowski@linaro.org>
References: <20220923155740.422411-1-krzysztof.kozlowski@linaro.org>
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

Bindings require usage of fallback "qcom,slim" compatible, so
"qcom,apq8064-slim" is redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index c0c4f895d76e..bb106eab8ae2 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -718,7 +718,6 @@ static const struct dev_pm_ops qcom_slim_dev_pm_ops = {
 
 static const struct of_device_id qcom_slim_dt_match[] = {
 	{ .compatible = "qcom,slim", },
-	{ .compatible = "qcom,apq8064-slim", },
 	{}
 };
 
-- 
2.34.1

