Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862FB712918
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243792AbjEZPGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbjEZPGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:06:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB05D19C
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:06:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-309550263e0so763745f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685113593; x=1687705593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oi5cyxzC3+NP4WFp104cxanaFNMsvwaBhA2yhJz87ao=;
        b=P7quhgvBOopgAHuzia2KUJHr2xr8NWuMqlE0TFHCX6FF/5Vj/uKKTS+5ef85RnYLgW
         poBu4LQrIlgcRfNICvz0AU6lWjZYbojLsyvxu+X/Vzjsu113PBPyWYXwQfVj+zy/nIlT
         aFH0op8csKGw9AcOY5EPln0FKoiphGdh25a/YaXcUfPOPYmXc2dqScDI9z9R8fZsDalX
         2f8kg1Q3wSVOYpsqApB696RKAPSNb2H8wTtQBlix3eZIlK354zQDbSGIvnXYgKk+jd2M
         1h/sktzAL9gu1Ibk1QhXzRxoYZIqB5gZHdicWhRylQzfHzv2vg+YTobgM8H/lpPxZMJv
         MvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685113593; x=1687705593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi5cyxzC3+NP4WFp104cxanaFNMsvwaBhA2yhJz87ao=;
        b=Ixyz65jqt74lOKapeXlQ/2omIien83HWSWeD3fvmuuuKxA/QrjRy4Ov9OCpBKwnw/+
         bixNacw50sF7HADXKjqGQc7+TywfQ6uVZFYTqY+1DyosxblWEI5zuM8Dlwm3rJbNYEi2
         0FDWcjQxotVnGRSO0KjiC4u6J34tE+oLmBNOYSw0gxRlLYddPcKPDjrIx5VZnC3/qCGd
         T4LW5ie4sLfC5wW0/+JaAiGWiDZh0C+wXM8TjchToowiKcge2AfIp+YD69btTWqfQfzF
         /2xQUtk7+GiFJzLw2CtZkUmX02f7ppPG/F5l63lS+hdUh7sw6+Ud4ipyjcSYfqtd9Sak
         1nzQ==
X-Gm-Message-State: AC+VfDxlajDRImKn/orro3Xn1gJUEoR6Hv9pf9gzlPxsU1Jj+cPsyABK
        HCBclDha+JFb1vPZVxQrJjc3DCesa48JZ1J9vGd8AA==
X-Google-Smtp-Source: ACHHUZ5+QZ71P9nVzbXxHaNvR734vRgaxpRheudeITcgM9TJ68kWae/8YlJC+MiKrbeJvDLsrc1E2Q==
X-Received: by 2002:a5d:5186:0:b0:30a:df14:516b with SMTP id k6-20020a5d5186000000b0030adf14516bmr410273wrv.6.1685113592839;
        Fri, 26 May 2023 08:06:32 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s17-20020a5d69d1000000b00304adbeeabbsm5422146wrw.99.2023.05.26.08.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 08:06:32 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
Date:   Fri, 26 May 2023 17:06:04 +0200
Subject: [PATCH v3 2/2] mfd: tps65219: Add gpio cell instance
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230511-tps65219-add-gpio-support-v3-2-19837a34d820@baylibre.com>
References: <20230511-tps65219-add-gpio-support-v3-0-19837a34d820@baylibre.com>
In-Reply-To: <20230511-tps65219-add-gpio-support-v3-0-19837a34d820@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>,
        Jerome Neanne <jneanne@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685113589; l=1009;
 i=jneanne@baylibre.com; s=20230511; h=from:subject:message-id;
 bh=nMeCcxVhE7+un5EdrNfRU6JWVC4UNE7togljBBNu77I=;
 b=xsPejS6p6ProbkhOqcLxbLpxdNuT/A7IDSrDhq/YAG09J6Hzd/jNYLijhCHt8zIjP9t4pMpMN
 aSPJ+gvos87D1uob29Jx3G1J2X6r36gazIcRgDompYBxZRmXyGjGafi
X-Developer-Key: i=jneanne@baylibre.com; a=ed25519;
 pk=5rvbqNoG+28jQjC9/50ToY7TgKWf9rJukuCI8b6jkUo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tps65219 PMIC GPIOs are exposed in a standard way:
gpiodetect
gpiochip0 [tps65219-gpio] (3 lines)

tps65219-gpios is incorrect cell name (plural):
Changed to tps65219-gpio (singular)

Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 drivers/mfd/tps65219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index 0e402fda206b..e1d090ba4258 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -106,7 +106,7 @@ static const struct mfd_cell tps65219_cells[] = {
 		.resources = tps65219_regulator_resources,
 		.num_resources = ARRAY_SIZE(tps65219_regulator_resources),
 	},
-	{ .name = "tps65219-gpios", },
+	{ .name = "tps65219-gpio", },
 };
 
 static const struct mfd_cell tps65219_pwrbutton_cell = {

-- 
2.34.1

