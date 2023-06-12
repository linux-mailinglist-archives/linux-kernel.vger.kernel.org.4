Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0B272C8C3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbjFLOit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbjFLOip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:38:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01114CC;
        Mon, 12 Jun 2023 07:38:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30e412a852dso2924449f8f.0;
        Mon, 12 Jun 2023 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686580720; x=1689172720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qpp1USHGcqO04WoWBbryL5M8e9S80vQGjt+eEysyPmM=;
        b=qW3mxqp1UEKpHcv7ICrOiqLR0JCzOb7gUubLgpnxcZsMVeUNL17oNcibiuW5nNxgpJ
         n6EF9BdfZoPx+qFTuNBqiLegJ0Bx3yQ1Qpg6nF8NrywKQH3GC2olIgyE6AndvoKPMc/M
         fKyzqwgO17RJ7ey04hiWMW7bNhq+Yov2J02fwhqOPJZn04ugeyNY4WnE0ATv/mUw6zNB
         f7ZzN4wSQc3eS1/0HDAw7ma8WyQdVhm6bbWSdPC3c0wAWUlfr6LlH+hhzOJKskm24WRE
         2KN2JB1+XluXt65G7rZgiUrxPQGyhDMqHmISloRtV08H5vsmSeW8l1vwPiTWGsKNO0d7
         GBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686580720; x=1689172720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qpp1USHGcqO04WoWBbryL5M8e9S80vQGjt+eEysyPmM=;
        b=d+uN/+0TIkBrwsD66FIVytz9lGN6T6ZkBFLvBuqZ+d1w3WO15XFZ7tMuSmETBF5v1a
         ahCecOQRahNRtZxmvJlQvdl+HwPHs1O8D/+mitbqc82rzqIWqmzfgVnUrs29Sz0mBXmz
         VkoLjT8rhw35Ea2lDwVMD89h/mxNNDl7Kf1xhXMAOgYPDBPB4RyUESHyHx2XBgMtBkHP
         6Ps6ejRN5BqVeMBoiJaoojUTrbW0vALoQYuy7bcdUzk2OO16Qv6H3X882aJYAbHxaN7G
         iP0EtU6EDnERcb/9vavuTbWnmlBwFZF8GHUPlMFHjo9lNT6nqu9C8VlvHlTb6ME6ookg
         IbHQ==
X-Gm-Message-State: AC+VfDwr/K2XW7/TguuW/M+hcV1VCH7+kBjZ8yy9a/xpW7IAj9PCXgd9
        t5OL3oa2sodAXnsk3DQd53E=
X-Google-Smtp-Source: ACHHUZ4JXuS1VBcsFH33Jc5dY/EQj6s0sCmTvbnDSzwOcOUKv0+vt+vFWoQcOyPs2UGUzpUrNVQc+g==
X-Received: by 2002:adf:cd05:0:b0:30a:e9a9:a4e4 with SMTP id w5-20020adfcd05000000b0030ae9a9a4e4mr3912546wrm.51.1686580720220;
        Mon, 12 Jun 2023 07:38:40 -0700 (PDT)
Received: from archbox.v.cablecom.net (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id e40-20020a5d5968000000b002fda1b12a0bsm12721064wri.2.2023.06.12.07.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:38:39 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-rockchip@lists.infradead.org, stable@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: rk817: Add missing module alias
Date:   Mon, 12 Jun 2023 16:36:52 +0200
Message-ID: <20230612143651.959646-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the rk817 codec alias that was missing, the rk817 charger
driver is missing a module alias as well. This absence prevents the
driver from autoprobing on OF systems when it is built as a module.

Add the right MODULE_ALIAS to fix this.

Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 drivers/power/supply/rk817_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 1a2143641e66..76b991e112da 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1211,3 +1211,4 @@ MODULE_DESCRIPTION("Battery power supply driver for RK817 PMIC");
 MODULE_AUTHOR("Maya Matuszczyk <maccraft123mc@gmail.com>");
 MODULE_AUTHOR("Chris Morgan <macromorgan@hotmail.com>");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:rk817-charger");
-- 
2.41.0

