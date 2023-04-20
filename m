Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06E36E8E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbjDTJfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjDTJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:35:16 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672722D5A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:35:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5144043d9d1so579401a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1681983314; x=1684575314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ryva+FQmb09SgOiCE7P4pQBiT6BdeSdh3y4Qn91oZ9M=;
        b=d4ER6huQjMtUV4wHdMb9ME9KpU3d2FGtvqsgiDTUlUyLvDePcXJ0PKh98S6NEnsa2G
         XpQA1rCPbkz2/bCmmRIw/iKSY7Jc/iG598aSV3OIGqyeUx4IBcGUZKtO4vIBwSqT9r0P
         p5FSKMM0VYyfyGjMat2EmIyNNAimvy6yE8WNCYrKGxEhDc/YAWf+Pc70ybdNvL8zO+JA
         QpNju3Pf0hJEFC4gFdxrSa9X6mz6r/WWX5OMVqulCgrYK2qAWDlWa525eBQUcoKAVN9a
         K70k1rCm/C/aU30qmXDSBl7EG/LeuOhixKwJILpFQprjgRGLNArBduUmQD/Zx6K1YSUy
         l2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681983314; x=1684575314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ryva+FQmb09SgOiCE7P4pQBiT6BdeSdh3y4Qn91oZ9M=;
        b=ASuFW4UE6ex0l5cIowIvDm8gh8ccNsRAT6exORwywLDLucjrL9xuOuD5oJaITaxnXB
         dT/q1Eyn1H29JYIGsAFAiTxRuxVXbJYp899e7OmhPEpISrDyLXZ52hEcgAjCj8cpVzMF
         vi2cQfnJEqE8Hg9y7EJ95K8q0KYccVKJSrRrEFpFG1znVQfBIkMjIiy8a8ekJYtXPZtw
         F1KlRT1LNjaWAt3fPg1XGEJNA3AuIKSqtZ6BsZDIM82Qvk7idHjxX3ONgHr36EeTIJBY
         qlXJz54b/t4qe2t3mhnls7E7SJDo8gV8syRqoE8qUqP0oyTf2XchYM+6ourQwNpLCY/1
         PDxA==
X-Gm-Message-State: AAQBX9duMGPl2pJWdO9GzQExfKytt+JZFQmTyVoDVxBuj5wdjwVrRkc4
        Oc/tnh0dmBmPaZIgzkr70+TNrg==
X-Google-Smtp-Source: AKy350br6fKdRCr0Nj4YKMv9Nvtjoq+VqjzrOMC15lETcCmUtAqFU5evu54VS9v+FLXPiour7tCHKQ==
X-Received: by 2002:a17:90b:10c:b0:23f:9fac:6b35 with SMTP id p12-20020a17090b010c00b0023f9fac6b35mr1017558pjz.39.1681983313820;
        Thu, 20 Apr 2023 02:35:13 -0700 (PDT)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id p5-20020a63c145000000b0051ba9d772f9sm781551pgi.59.2023.04.20.02.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 02:35:13 -0700 (PDT)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     aou@eecs.berkeley.edu, conor@kernel.org,
        emil.renner.berthing@canonical.com, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nylon.chen@sifive.com, nylon7717@gmail.com, zong.li@sifive.com,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/2] pwm: sifive: change the PWM controlled LED algorithm
Date:   Thu, 20 Apr 2023 17:34:57 +0800
Message-Id: <20230420093457.18936-3-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420093457.18936-1-nylon.chen@sifive.com>
References: <20230420093457.18936-1-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `frac` variable represents the pulse inactive time, and the result of
this algorithm is the pulse active time. Therefore, we must reverse the
result.

The reference is SiFive FU740-C000 Manual[0]

Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf [0]

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 393a4b97fc19..d5d5f36da297 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -132,13 +132,13 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
 	struct pwm_state cur_state;
-	unsigned int duty_cycle;
+	unsigned int duty_cycle, period;
 	unsigned long long num;
 	bool enabled;
 	int ret = 0;
 	u32 frac;
 
-	if (state->polarity != PWM_POLARITY_INVERSED)
+	if (state->polarity != PWM_POLARITY_NORMAL && state->polarity != PWM_POLARITY_INVERSED)
 		return -EINVAL;
 
 	cur_state = pwm->state;
@@ -154,10 +154,13 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * calculating the register values first and then writing them
 	 * consecutively
 	 */
+	period = max(state->period, ddata->approx_period);
 	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
 	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
-	/* The hardware cannot generate a 100% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+	/* The hardware cannot generate a 100% duty cycle */
+	frac = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
+
 
 	mutex_lock(&ddata->lock);
 	if (state->period != ddata->approx_period) {
-- 
2.40.0

