Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A807236B6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjFFFNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjFFFNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:13:40 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE6D196;
        Mon,  5 Jun 2023 22:13:39 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b02497f4cfso30102595ad.3;
        Mon, 05 Jun 2023 22:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686028419; x=1688620419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WKYJR4KA+z1U9gxuSR1ySk9nbCZtFbh4aaGz3XbVcPg=;
        b=bMqnpM8yEvMJzPCBcEH/atpe1a2XjmGjUVaW+QPk8Bx6NjExHUkn2r4zZEgjbw/rHg
         qua8E0QuivjnJdbyDubRJs6I5qnJR4q6RPc/NcOQ32nukki5LRpZLuarZsCBbuSVLc0m
         PEbg4AcmSGAgVZr6q9nZbLi/4Bqdcg10UDPGwagEZ1ddnhODUTdnzv924jR9ElZkrpj5
         RBzPW/WOOS3Gi4QTKGkmbHPQeVtb+ITPtAMiQ/8EK2ujicitK+/gyC9fffjyMPsHXoQu
         LAyx/O8xBhsgWNJTw+LvK1fjvimy4f/sRHas+3pInOImisiDdWpADwB0dnLu6LwBbTEF
         crYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686028419; x=1688620419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKYJR4KA+z1U9gxuSR1ySk9nbCZtFbh4aaGz3XbVcPg=;
        b=HJ2pqnq228mSl9M86ll21J/px2UBW7q9UmTAHhmkxnMDoezD8+4S9LxroQIMfPG8MY
         ovjN6n78h7/ta4n+c4MoSLpJ8LHB20T/n02iW7MlzzA2Nmd7snUSaYNqH5hqWdLEzouk
         NTdU1h9zxUQaaA7/qZ60FId8ioR90hYnJZnUojdMyWzKXygrP2RcUoR62fct2Ow2yjK/
         w0Vk3UcZOw5w0ctO8q8Z2Of1RU6mUo0CeLRIA3G7VXYcRKF7KSpoNebOMk8z7T1xlren
         iX463fXv/2w832iSHutogbAAEfn8dRmuLDrFIMfs6dxB9VJ88Yj+ZqnzlktcoWULe8uC
         4/GA==
X-Gm-Message-State: AC+VfDw2ThOazHXBhCz3Hwlx19Qgyi2QC3GP0V2owMdXXCtjpVr+zeeJ
        +jGHeeHt5zLM5x2gy347wX0JChYrqe0=
X-Google-Smtp-Source: ACHHUZ51pB7YKIoF1Key5pGmcTN1sBlDszt26yOQh+m+BIWIHmK/3f0GcSaiuD2Cmb0P02/+JOEyRQ==
X-Received: by 2002:a17:902:d508:b0:1af:cf34:a645 with SMTP id b8-20020a170902d50800b001afcf34a645mr775161plg.21.1686028418705;
        Mon, 05 Jun 2023 22:13:38 -0700 (PDT)
Received: from sol.home.arpa (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id i16-20020a170902c95000b001aafb802efbsm7484639pla.12.2023.06.05.22.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:13:38 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH] gpio-sim: fix memory corruption when adding named lines and unnamed hogs
Date:   Tue,  6 Jun 2023 13:13:23 +0800
Message-Id: <20230606051323.17698-1-warthog618@gmail.com>
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
Signed-off-by: Kent Gibson <warthog618@gmail.com>
---

After writing the comment above, and looking at the code again, it may be
clearer to instead check that the offset is within the bounds of the
array.  Or do both.  Consider that my review.

Cheers,
Kent.

 drivers/gpio/gpio-sim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index e5dfd636c63c..923e8ff53128 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -721,8 +721,10 @@ static char **gpio_sim_make_line_names(struct gpio_sim_bank *bank,
 	if (!line_names)
 		return ERR_PTR(-ENOMEM);
 
-	list_for_each_entry(line, &bank->line_list, siblings)
-		line_names[line->offset] = line->name;
+	list_for_each_entry(line, &bank->line_list, siblings) {
+		if (line->name)
+			line_names[line->offset] = line->name;
+	}
 
 	return line_names;
 }
-- 
2.40.1

