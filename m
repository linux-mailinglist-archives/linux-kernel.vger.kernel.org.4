Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C66B5B02
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCKLR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjCKLQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:16:50 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3195EF34C0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:44 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j11so30740317edq.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Un3CjoEdCB2Y+KA2war6cOphuSBhkuVlcMrtsEspY0=;
        b=bv9EYEBXgAO23nOb44UGWdsSf4eIg+pYeE7wW1LDGL6NGBjeDmB7yHcei2z0l7ZsKZ
         IySTRB4IaiKSHfLBqvMas2pV585r5fr+wWCuoGSX3NVliJp7NDr+J2Ahmt7jLqAdkB+3
         FggQ9pNdJxi2YZFSF1khYqlzOBYFdiuP1w0x/y+DblGiGPGkMNR9svbtvuKkCmHGkjfI
         5KyBmFokh/ZPC06bXJwqeMO1e90NPZ9CkkN/CDm5pg80fcBDCOqw8EwofLxhkO3xLn6V
         LdVkaZEZiEyQV0RxDIlRsxxctsaSgwlbPD7exG3ECqIkNEIiCKjLvJuD7VlnXydCfz+Y
         4ytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Un3CjoEdCB2Y+KA2war6cOphuSBhkuVlcMrtsEspY0=;
        b=3qUE6PAVaueWpuyIgSSCMZuiVx7thpdRHyuIqfAXzSNy2N2N5/QD2Qp/zahMA6NgOD
         xq2qy4wzvbZ6XdQEQVYAShTF04x6CsL5bFDdIEX545ykScgX8EfyIAYaGEolp0pT4qBH
         RxgdWFhIp46yWXxHyfG/SE0wx6Zu+PoSFfiFyMCqPIUmUXPsFFrtgvDFaaOmt17LflfL
         OZP1+HkEEKlqBH5bLH4rJX0OdFo/q0K/ipKO7OgXTejwa4AYht8RvGXAwupYsX0z8iTI
         VdVm8A749afmcek844IHoNbsXnQohrU1hY+Ge2ZT7qpUIi90blGY/mS5Oi9yNE3vGTQm
         DPGQ==
X-Gm-Message-State: AO0yUKUSd4gKA7SCo9cULmq6mOxE35f0cyv+3fSo2XXqgFxSEJmk3SzU
        hpKlUXyXZEY6zVHmxbtFGuHZPA==
X-Google-Smtp-Source: AK7set+6UYUp9rH3P3Zh3iQMRqVkuLuZtpFRsnFDS9D11L5+PLpBWrXkMsuOXt8YeuY44hiWdjIEmw==
X-Received: by 2002:a17:906:8a64:b0:88d:d76d:8527 with SMTP id hy4-20020a1709068a6400b0088dd76d8527mr26282349ejc.47.1678533337111;
        Sat, 11 Mar 2023 03:15:37 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id w15-20020a50c44f000000b004bf28bfc9absm1064150edf.11.2023.03.11.03.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:15:36 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/6] power: supply: lp8727_charger: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:15:29 +0100
Message-Id: <20230311111532.251604-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111532.251604-1-krzysztof.kozlowski@linaro.org>
References: <20230311111532.251604-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/power/supply/lp8727_charger.c:601:34: error: ‘lp8727_dt_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/lp8727_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/lp8727_charger.c b/drivers/power/supply/lp8727_charger.c
index e6c21377d53c..dc42d354b892 100644
--- a/drivers/power/supply/lp8727_charger.c
+++ b/drivers/power/supply/lp8727_charger.c
@@ -598,7 +598,7 @@ static void lp8727_remove(struct i2c_client *cl)
 	lp8727_unregister_psy(pchg);
 }
 
-static const struct of_device_id lp8727_dt_ids[] = {
+static const struct of_device_id lp8727_dt_ids[] __maybe_unused = {
 	{ .compatible = "ti,lp8727", },
 	{ }
 };
-- 
2.34.1

