Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46C274E923
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjGKIb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGKIb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:31:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C336BC2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:31:25 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666ecb21f86so4804972b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689064285; x=1691656285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rofOJD2PEXHX+UfeHTQCqCECMr9/lYMQMtv8+LwhAUQ=;
        b=P6A0pA9ITf6al+15du8ek7nlPUlClDBxUH1hZIB1C9IlYHPFlUbaVUPv4aE8lRt+H9
         9urxpsHuYPzrnVXITxB0swQsGpnoTyvhAgWnCjLNTc8k27WUvzQdiVQ5NT1beq+MN8is
         1aXkZZsDeaP+/iP91u7UBNkcezZh5pG7bP188=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689064285; x=1691656285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rofOJD2PEXHX+UfeHTQCqCECMr9/lYMQMtv8+LwhAUQ=;
        b=BmniEa1uiWzLcvh531UAsWNcSVT/5e0LiB6kQQ51MdpOvcMh+eATD++prWk1BCZ+74
         eLvtqohpzjIYkcgeM5Js5Pv4OrVduYYiN1bdvFKLZAIf9qlwA11AABWymEHgks9UrK6C
         IsiR+oYMhVMG3UDVsytb+Z3h5bTJ3CfBTvJX6qB2QSKb60q31FuEJwLoRI+Och0CRYDQ
         zTY+iTI4G8AyZRAZbIBb3eBI93JTxCf7v9PLoS2Gr6JI1F+SVff/FGSrlfo2ZWOIopeT
         baja8HIKyPuNzxYAtvNGKM6jgMq+fhAX9Kjk0yaqKusxQnXeRoFTiE4cRr2Oj3kxSSaq
         zyIA==
X-Gm-Message-State: ABy/qLahoNwMwiPnQmcKBmY4bwfjtUt3loCjIvIF0n5zRuBS2O6/xHuq
        BJiOS1XZI2gXjrLl347LWD+p2g==
X-Google-Smtp-Source: APBJJlEVuRnWrgPtRHxfnSweZ6D18Mv5lFZ8nOu/CVG5UPhpVA599ndJjMw/jfjqWUfqQBYnnxvqzw==
X-Received: by 2002:a17:903:41c8:b0:1b8:a73e:aaac with SMTP id u8-20020a17090341c800b001b8a73eaaacmr21002030ple.62.1689064285198;
        Tue, 11 Jul 2023 01:31:25 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:4de:ea8b:eb72:c51d])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902b20800b001b89466a5f4sm1273471plr.105.2023.07.11.01.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 01:31:24 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Fei Shao <fshao@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH] leds: pwm: Fix an error code
Date:   Tue, 11 Jul 2023 16:30:41 +0800
Message-ID: <20230711083055.1274409-1-fshao@chromium.org>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the negated -EINVAL as the error code.

Fixes: 95138e01275e ("leds: pwm: Make error handling more robust")
Signed-off-by: Fei Shao <fshao@chromium.org>

---

 drivers/leds/leds-pwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 29194cc382af..87c199242f3c 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -146,7 +146,7 @@ static int led_pwm_create_fwnode(struct device *dev, struct led_pwm_priv *priv)
 			led.name = to_of_node(fwnode)->name;
 
 		if (!led.name) {
-			ret = EINVAL;
+			ret = -EINVAL;
 			goto err_child_out;
 		}
 
-- 
2.41.0.390.g38632f3daf-goog

