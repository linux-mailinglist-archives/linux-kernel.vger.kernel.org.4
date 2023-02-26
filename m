Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA48A6A3033
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjBZOra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjBZOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:47:22 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33B01353C;
        Sun, 26 Feb 2023 06:46:44 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so7573485pjb.1;
        Sun, 26 Feb 2023 06:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Eh6AmMfT4Z+u0BxDIOeBlEartGnGmnuI1Dw64al8WY=;
        b=pP5ekyYkj7NMTorx/wTpbuMcCiQg3gopUUJX0FqPDE1nicPxdCSlEPbuEaXTHut52k
         PIUIw3esd40bPzQ8F8CZf3dYarXzmUE7VRhZP4CB4xNtmgH+jUpxvuBW8gkmcfUeUMDY
         x2PUjesUnaQr8eI56WbJOOo2Vr5+bBJgW+R5klg2mws0KG6hM80UI5HqJ/vcbuVcJeDq
         V+1fWoMlL43fhs4m5VjQMfl9oLCfSnlaTuYLey4f8L+TXZP6/3xLhv8935/amIUCyjDI
         IQWnG0B47gaoYe/hyid3o5mkAjp9zke07nN68ql8mfPWVSNs5WaaACfP82fhK4MS2lQs
         FvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Eh6AmMfT4Z+u0BxDIOeBlEartGnGmnuI1Dw64al8WY=;
        b=WtgvyKwg9hfRV/2MOxu6x94hczU8Xg1x/j647Jnq6zuMtszaqA+Vx+1y2Oqa0QYIqT
         B1791IofuTYYwARDY+v10diqAWWwZOzd4hixMAXWGb1O/9SPUimiNEpWs3JGrK60YPUW
         mgyosEUF7yjz0lfqht2vrlw778L4ZnW9vD8pnIds2q8WUd/eCejyqCvstuMEnkE1dJvx
         txgM+QocsAo95u6ME0M/5zAv6loZRmOpOzpShQ6MvGHXKFc3yKCcGCyg03QD6FnevgKu
         kLVZPo4yhM8LkWNJhUqWrke8hjTRsOQexisj00zMQIjRtV5ES+sQXN7q1VweVaqQBhqS
         scnw==
X-Gm-Message-State: AO0yUKWnD9WkMpbShEYC04Q207yXEqxa/bCBGmrI25YHtwBKzXm+ezsb
        dQv8/4h2ANKT6/e6B6zJ6N8=
X-Google-Smtp-Source: AK7set/r42gZuvNsks4Vk9J9KM00FWB0ahB9jvPWHetB3KtfZqT2HXPauXzdqLggsnYBHBU9A0v0WA==
X-Received: by 2002:a05:6a21:78a0:b0:cc:4db0:f2c7 with SMTP id bf32-20020a056a2178a000b000cc4db0f2c7mr6444731pzc.23.1677422769035;
        Sun, 26 Feb 2023 06:46:09 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id k4-20020aa792c4000000b0058bcb42dd1asm2545898pfa.111.2023.02.26.06.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 06:46:08 -0800 (PST)
From:   Kang Chen <void0red@gmail.com>
To:     konrad.dybcio@linaro.org
Cc:     agross@kernel.org, andersson@kernel.org, ohad@wizery.com,
        baolin.wang@linux.alibaba.com, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kang Chen <void0red@gmail.com>
Subject: [PATCH] hwspinlock: add a check of devm_regmap_field_alloc in qcom_hwspinlock_probe
Date:   Sun, 26 Feb 2023 22:45:45 +0800
Message-Id: <20230226144545.4187442-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_regmap_field_alloc may fails, priv field might be error pointer and
cause illegal address access later.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/hwspinlock/qcom_hwspinlock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
index 9cf186362..b69d43d30 100644
--- a/drivers/hwspinlock/qcom_hwspinlock.c
+++ b/drivers/hwspinlock/qcom_hwspinlock.c
@@ -197,6 +197,8 @@ static int qcom_hwspinlock_probe(struct platform_device *pdev)
 
 		bank->lock[i].priv = devm_regmap_field_alloc(&pdev->dev,
 							     regmap, field);
+		if (IS_ERR(bank->lock[i].priv)
+			return -ENOMEM;
 	}
 
 	return devm_hwspin_lock_register(&pdev->dev, bank, &qcom_hwspinlock_ops,
-- 
2.34.1

