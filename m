Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA8373759A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjFTUD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFTUDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:03:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C671726
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98934f000a5so137592466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291417; x=1689883417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8jfpdKH0fFzjA8Web6QRbnSKKAkYrL/UQcXZfCIDJU=;
        b=KBOjswneiJ+wctkMg8hkQH4cU9SDT9ijrERRYyhkTyXu6Bw+GLleNaeKrIY3DaQtkT
         L4ivG2jFZjppHpokA0mlmN28izpa7UDdWVU+w4B6Af5nhou+hIkXvRA2ht2+GrmAtL1e
         NGuN6H1XX0gcIOKgghYFZcOrKa9v1IlIsFggvYGbcdoO5yXQy5n6xMxjNaVYv3UIX4Hh
         3RfG99THfkwCoRZMUgT+7tjCFG1i1vozp6FMHxxC13u/Hp4I25Ry3Sfrm22688JHzG6s
         lJxtaf9cm6dLCvdDNzTNtlAgoUjJF87Rx6sRnpsbNJlzfHM0xnFEbhcg047ggOEA/V3x
         U2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291417; x=1689883417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8jfpdKH0fFzjA8Web6QRbnSKKAkYrL/UQcXZfCIDJU=;
        b=S0ki4ONdmTqeCl7/ATZvwk9TNAIit7/Tf3icly0ek+QdeBdXsAMeY/6WmZoKJ4uzJZ
         4YCF7ABvM9gv4P6cR0g7J2n1hPB1zMYyf0OcwvoDDeNvjAp+cfHo3uGR9Ap5zSoiA3la
         q3oj8zseny2yjsDu4VvN6H6a17+W8Z61EaFTLgvXm4CF4cTj7gEIpJX/ZhAfUcJ5h6hz
         fdAuWtkwjGPGUGAvaErUrRQv/RZhGQL7+pICE7PllyJKfORQs17WDwy/aEtLxOCYzsI+
         3NyMX/GX2dSeNc87DSGu53kGOAhWyoQ7jO9pqPflegEjPey7P1gbTkzJ6x5zgJZHF12W
         xyMg==
X-Gm-Message-State: AC+VfDzeG63/gB3PXp+q7GEyiY0VOCgbCzgIPuiELaWdVT2EDq1/WPb+
        lVBkNJKjVJniK1navXQZ/yo=
X-Google-Smtp-Source: ACHHUZ6F29c4fsU8BMMP2TV7m1XjWd4RTw6VBgO6ETEP6Ez5JQuIfCNiIoT7iFjdAi0oY+drw4tEGg==
X-Received: by 2002:a17:906:58ce:b0:988:ffb9:b944 with SMTP id e14-20020a17090658ce00b00988ffb9b944mr3756956ejs.29.1687291417474;
        Tue, 20 Jun 2023 13:03:37 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090617d500b00977e0bcff1esm1947064eje.10.2023.06.20.13.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:03:37 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Tue, 20 Jun 2023 22:02:59 +0200
Subject: [PATCH RFC v4 06/13] regulator: set required ops for monitoring
 workarounds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v4-6-4d3734e62ada@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

If the core should be able to handle the monitoring workarounds, certain
regulator ops are required:
- is_enabled() to decide whether a monitor should be turned off or not.
- get_active_protections() to find out if the device-tree is missing
  active protections.
- get_mode() if the regulator is in a mode where monitoring is not
  supported.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/core.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dc741ac156c3..ca5d6ba889dc 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5540,6 +5540,40 @@ regulator_register(struct device *dev,
 		goto rinse;
 	}
 
+	/* monitor workaround properties require ops to ensure functionality. */
+	if (regulator_desc->mon_disable_reg_disabled ||
+	    regulator_desc->mon_disable_reg_set_higher ||
+	    regulator_desc->mon_disable_reg_set_lower ||
+	    regulator_desc->mon_unsupported_reg_modes) {
+		/*
+		 * is_enabled() to make sure the monitors aren't disabled on
+		 * disabled regulators.
+		 */
+		if (!regulator_desc->ops->is_enabled) {
+			ret = -EINVAL;
+			goto rinse;
+		}
+
+		/*
+		 * get_active_protections() to know if a regulator is monitored
+		 * without the device-tree being aware of it.
+		 */
+		if (!regulator_desc->ops->get_active_protections) {
+			ret = -EINVAL;
+			goto rinse;
+		}
+
+		/*
+		 * mon_unsupported_reg_modes property requires get_mode() to get
+		 * the old state in case a state switch is failing.
+		 */
+		if (regulator_desc->mon_unsupported_reg_modes &&
+		    !regulator_desc->ops->get_mode) {
+			ret = -EINVAL;
+			goto rinse;
+		}
+	}
+
 	rdev = kzalloc(sizeof(struct regulator_dev), GFP_KERNEL);
 	if (rdev == NULL) {
 		ret = -ENOMEM;

-- 
2.34.1

