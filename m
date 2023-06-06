Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A832724198
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjFFMBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbjFFMBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:01:24 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712A210FE;
        Tue,  6 Jun 2023 05:01:02 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-39810ce3e13so5316312b6e.2;
        Tue, 06 Jun 2023 05:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686052861; x=1688644861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AhrfkRC2d1Nzu0rFUFmWucm1SEXL2rGUMQoBfN9aZzY=;
        b=iHvkabwU4JKGe8CglZWMOgqSzh8iYE0TdPuAjrDuLowg8lus7vPfB3P3gB4Yl1Hxhq
         i+ZWhLXhQW3Oo1E9c6zlyIRqS1FIjkiyqds/IclnFRyFY9HysSVUf9fzzRQbn5kiqkS1
         +1FORx+bOeJBExergOlw1RhziKnLqPG9ox0qK9kVCbKiC1Hzrq2AW6bbfamPXv4WWNtz
         73xatfGvBLdmXT5DUtGDBZmFya3wgPTBIEFAtKwosN3N1P800/lAMTMwW1O4XcC7r6vd
         x+ZqsiacLBYuRfEqZZOXn/bp8pqOVhf3V/xwXckxtsMJcMJby7g1TnbCQkaKtKqaZAB1
         ssBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686052861; x=1688644861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhrfkRC2d1Nzu0rFUFmWucm1SEXL2rGUMQoBfN9aZzY=;
        b=jO522hkSUdH7s0C2T19vG+qKQ3gbq8qg4T5epaZrrW21wjUVIJK8vN/5R72VhipjpV
         a60MqEKGNLWUlJJsKpLw4cMZDARWSPwdTM3TOeg8quwoeKidD8jzGrBA5mZcPeDKdPWb
         67eWgpZf4gQk9GrNY5t4gH0nidfG84MP/KcAXDqy7U23rSRd/DEH5ATRsZYuZkzh7jMy
         Qk20Ah+g2RzjsLO5liqALD/kjRJ6qvT1KpFjX0dw/h6YuOASPB0lhsfNlnvCAsikDeeH
         qLig01JE7feuYQURGJYYe6Hue7pv8o0zx+DIYF9ur0Dx88cBqBP6eHoSmlUX5KdMnGLr
         k31A==
X-Gm-Message-State: AC+VfDxn/nOYhwZqTjOxoN/opDl6p7m1rl/hrMlgghYdpO/qoXED7+s8
        yLdDdjo9ykHtMgBoz7MrrvsIAWymor0=
X-Google-Smtp-Source: ACHHUZ6NpuKk0Y4F2GEqXu30GWz9/oqv638NhXJF31o1PR5PqRJkOydZSeF4hBMw67ab0/QD15rGwQ==
X-Received: by 2002:a05:6808:250:b0:39a:bc5c:f265 with SMTP id m16-20020a056808025000b0039abc5cf265mr1905409oie.28.1686052861478;
        Tue, 06 Jun 2023 05:01:01 -0700 (PDT)
Received: from sol.home.arpa (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id z8-20020aa791c8000000b0063d2989d5b4sm1330427pfa.45.2023.06.06.05.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:01:01 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2] gpio: sim: fix memory corruption when adding named lines and unnamed hogs
Date:   Tue,  6 Jun 2023 20:00:34 +0800
Message-Id: <20230606120034.42904-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When constructing the sim, gpio-sim constructs an array of named lines,
sized based on the largest offset of any named line, and then initializes
that array with the names of all lines, including unnamed hogs with higher
offsets.  In doing so it writes NULLs beyond the extent of the array.

Add a check that only named lines are used to initialize the array.

Fixes: cb8c474e79be ("gpio: sim: new testing module")
Signed-off-by: Kent Gibson<warthog618@gmail.com>
---

changes v1 -> v2:
 - check offset as well to make the purpose of the check clearer

 drivers/gpio/gpio-sim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index e5dfd636c63c..09aa0b64859b 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -721,8 +721,10 @@ static char **gpio_sim_make_line_names(struct gpio_sim_bank *bank,
 	if (!line_names)
 		return ERR_PTR(-ENOMEM);
 
-	list_for_each_entry(line, &bank->line_list, siblings)
-		line_names[line->offset] = line->name;
+	list_for_each_entry(line, &bank->line_list, siblings) {
+		if (line->name && (line->offset <= max_offset))
+			line_names[line->offset] = line->name;
+	}
 
 	return line_names;
 }
-- 
2.40.1

