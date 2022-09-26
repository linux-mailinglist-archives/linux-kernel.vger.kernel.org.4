Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E165E98E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 07:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiIZFo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 01:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIZFoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 01:44:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3DE25EB4;
        Sun, 25 Sep 2022 22:44:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o99-20020a17090a0a6c00b002039c4fce53so11328493pjo.2;
        Sun, 25 Sep 2022 22:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=LmEtACextzjMs9rgRkVC6wxNN5ZO8mUWrZVgnP50qzk=;
        b=ooR2BQrjlGLdjZKiZLqx+ltIssLpQE8HzfDEywq+P0dxB2AWsayKt2bo4tugkn/Z5W
         2Fpot46178CF2AkEWNV7oRoDGxwXDdTXdX47w710jqL5R0e3qEFBh02M3UkZ3/K5W3YD
         PnlJTvWlxvoLerSZm0HPEb/dDTjt9bZe8M1NGyj+UDSmLBZo32vIcl6tB/VKPKthAZ/8
         1Rpbk7m7RO6q3svbmjy8OmqRjOzcH2btaM4Ys9H8Gfuv6Que9DjqxEBap7Qb0ESAM92T
         jewX0U7YHyIMSt7Xvpc2BPeBfQGlqik1gbJ2kXy91wHDIxFZ2c1xQep/EFvYYCuGWYpg
         Fxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=LmEtACextzjMs9rgRkVC6wxNN5ZO8mUWrZVgnP50qzk=;
        b=Rxwfr9RAPkyP7jQM2o3YgGquE43kaCopJt7bu8kHXYdvJj63NPOsSoeBbx2Io1Xoys
         3z0YkuThpqkth0bS0abUdz9kBtzQaeVedXWVLYwEoQ3WCCIFvethHDwn6x0yRHXbaYRe
         XlV3C559Z305HDL8uE0IIhI+9F9gyeuqH11EDVZFjUrkYvZrNZrdNVxsVKa5wuvSaii4
         IszHVwEXXyLrZEOEJC/quWFTYhyiaOgCyEZ3JNj9zZHaYvKzgnLfRUVDk/h9A+83jLTU
         JF1EASfD1md/wgj7DA7eNbs9VogbKvs+gIFhYHPkzROaBgTRbYqRFF1xahR90x7L6Acw
         uTBg==
X-Gm-Message-State: ACrzQf2mJwcz00N+DTIMXeHrfO0zjptSfb/91hTfLa2YyhrJ8yZqadRG
        5agN+1kciHy4p9XpNxxUt3s=
X-Google-Smtp-Source: AMsMyM6ddVumC3trczj55x6enEXoPq6YD7qL19brT8nwgnKnLY/t9axEuh+FzYWijjEm4Bw9VAyQ7w==
X-Received: by 2002:a17:902:e801:b0:178:11e9:2ba2 with SMTP id u1-20020a170902e80100b0017811e92ba2mr19384754plg.26.1664171063543;
        Sun, 25 Sep 2022 22:44:23 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:7e1b:858c:19dc:934])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902be0b00b00176c0e055f8sm10110489pls.64.2022.09.25.22.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 22:44:23 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH 1/5] mfd: mc13xxx: stop including of_gpio.h
Date:   Sun, 25 Sep 2022 22:44:17 -0700
Message-Id: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
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

Neither SPI nor I2C variant uses any APIs from of_gpio.h so let's stop
including it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/mfd/mc13xxx-i2c.c | 1 -
 drivers/mfd/mc13xxx-spi.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/mfd/mc13xxx-i2c.c b/drivers/mfd/mc13xxx-i2c.c
index eb94f3004cf3..89ab01105460 100644
--- a/drivers/mfd/mc13xxx-i2c.c
+++ b/drivers/mfd/mc13xxx-i2c.c
@@ -11,7 +11,6 @@
 #include <linux/mfd/mc13xxx.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
 
diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index f803527e5819..2809fbeb317c 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -15,7 +15,6 @@
 #include <linux/mfd/mc13xxx.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
 
-- 
2.37.3.998.g577e59143f-goog

