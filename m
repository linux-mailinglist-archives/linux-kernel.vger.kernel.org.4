Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E5C6B66FE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCLNvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLNvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:51:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D87B38013
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:51:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id fd5so4836567edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678629094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDnsPd/LWUjlQN35JHFuhsEYXZwtHp7Tg6xyrNKkcx0=;
        b=leBUfM+kGmFx3lbw8Ds4LVAFb0egI+bpB6A6mZMS/VNVxu+4LPnPL28e8VsC1XrG3i
         2CAyg+YYxTPz5SkZ1ZbvFBj9aVsaD2i4aG2QkhlrYGx0qWrcFh4P9M9+2byWYonW5fog
         Kc6pcOdb62onyN7rODrAxvycOm0YoDb5yby5JYkvMar5Z81FR+N/XRoNw6ZfT3TRHKyW
         i/Sj5bY6LfKwb3+hyElcwSxDtUmDJzNRmfM8MOxfdk2LrXdUw4h4fEKzeTATAwN8zw0H
         NVIbhrzFARIYBJphMTx+paHb47T1pTPQnIttnaGCTXh77Sxst8zvE0qF9EYk2MR1uArV
         trWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678629094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDnsPd/LWUjlQN35JHFuhsEYXZwtHp7Tg6xyrNKkcx0=;
        b=2moj826/dkqvBNcegz2X/n4CoMErbPdFeKbMHN6Z7WHrwa0FE6U5HWCMVP+cGKh1bq
         MW62nej2kpPdhCCUMkRfnYYBu5f052wHG/Ul2t9NoPCkewmreU5Cg6p4uefXisvbb55k
         Scb9A+1AjC+nOgd4yZgsUWeGsdecXeMvya9szP8qztjzlU3kE9BpU9T/YMeh7/0n2R4R
         /iXNNjiu1g4S8Jdc+1cMGfpr2Z4drn3LzyJE88VXN68zs9jkKbX+shGYY/SyNur41P7T
         /Tn98KFuBy1OwfJ9VFn3M8obe6nJ3Kb2kaHmihAMfgJ8AeXBy1W3RI+YkzgzoIhC0B1Y
         IdWQ==
X-Gm-Message-State: AO0yUKWCRMMMbnpt3kC2VlUdhAs68QKx0+7dFbgQJ/CmTusgJOawqpai
        wKaYO9CftofC5US9SRGdoO1vcg==
X-Google-Smtp-Source: AK7set8AeZI1EJibmWQqUYa4b/A/UWGiDLtXaCZSIsf/yj70h2qpSmPI1UJGcprS5rWdcrtwc7TkPQ==
X-Received: by 2002:a17:907:980b:b0:88c:4f0d:85af with SMTP id ji11-20020a170907980b00b0088c4f0d85afmr39938981ejc.75.1678629093861;
        Sun, 12 Mar 2023 06:51:33 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906701400b008b17fe9ac6csm2263946ejj.178.2023.03.12.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:51:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] pwm: rcar: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:51:19 +0100
Message-Id: <20230312135120.357713-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).  This
also fixes !CONFIG_OF error:

  drivers/pwm/pwm-rcar.c:252:34: error: ‘rcar_pwm_of_table’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Extend commit msg.
---
 drivers/pwm/pwm-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 55f46d09602b..8f31f3cc93d5 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -260,7 +260,7 @@ static struct platform_driver rcar_pwm_driver = {
 	.remove = rcar_pwm_remove,
 	.driver = {
 		.name = "pwm-rcar",
-		.of_match_table = of_match_ptr(rcar_pwm_of_table),
+		.of_match_table = rcar_pwm_of_table,
 	}
 };
 module_platform_driver(rcar_pwm_driver);
-- 
2.34.1

