Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D0E5ECE52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiI0UVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiI0UUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:20:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC67193EB;
        Tue, 27 Sep 2022 13:20:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bq9so16707170wrb.4;
        Tue, 27 Sep 2022 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=zRc0Y5sMwosqx4xCSGN4sLyylCyDIBBTwvLFxl3b27w=;
        b=WOvLBIhWwmdbQ+lXC2sozZ3M1yuEDHAmRM9P2sNHUUIlMvLibM0OJAdSuyvGlzoTQe
         0FatI6rOCO+AlLaNvkgPcMxJoC3Shfvt/QAI4UnoR3X33ZI93fiFOV7hj/K8AgbcZLWz
         yv9A+1MBexqSv7bRt2ChsUwqT/JPjKYMyNqfNVEZWzEXHAWXkvI8EWgpOTvN/oDlBloX
         e3vtsXpVBHa6RYgqa+J6UeZREtLPXbzwr6rii3pDUAPqRo55iMRJ7VqyizxRIWe28fZE
         N0s5wyuMtpRMlAj7rkUj+shurWyg8jtf9xOQV7dJ1m6JOvQbpF5XETsmiFjELQBUX1eq
         zGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zRc0Y5sMwosqx4xCSGN4sLyylCyDIBBTwvLFxl3b27w=;
        b=mVfG7BVziibA/nemsPViiN4emI1tk6VAaMjNWLh6pH8N0GWWL3yxo9SWemi1lsRXDj
         ajqkzWOH4zLoWkIL5nKO6qlb82g4/nYUJdklhwPxc7gMC1JKca9BFhH8N/R6MrePl4Sa
         V9D3fxOO+/HE/rSwEHrKdxzeeA2b+faAPH7u0mYJjjOFuoML3Hu8UaArbE2INmuj7vYv
         18CGxci15S1NBk07H5t2uaKv/+MmgtQUXbzFmzm206Xwwy+T9KRQNb3o8XhcskKC2BwI
         ITWyKECAIvZVFL/5T9HzhjPLXd/UmlvidavFJpF7SsfJJBEtn/yn90FMGpB6uv1+ZbXP
         R31A==
X-Gm-Message-State: ACrzQf2jDGaV2Mm/u2q30oEwP4ziTINaM0hTL9PQNWQ5DQtQCntyn/BM
        06NHn0owVZxOmD7rYBGTHJg=
X-Google-Smtp-Source: AMsMyM4xg43nsd6Ubura7VuC2SnoXuKqb0hlnF5X/ELQb9+0nNt9pcvm2WPsdGN1X9xRuh1e5x80rA==
X-Received: by 2002:a5d:5a16:0:b0:22c:a07c:649e with SMTP id bq22-20020a5d5a16000000b0022ca07c649emr8383801wrb.107.1664310014351;
        Tue, 27 Sep 2022 13:20:14 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:c6a:3c62:baf6:511c])
        by smtp.gmail.com with ESMTPSA id q22-20020a1ce916000000b003b4764442f0sm2627810wmc.11.2022.09.27.13.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:20:13 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] media: i2c: ov5645: Drop empty comment
Date:   Tue, 27 Sep 2022 21:20:05 +0100
Message-Id: <20220927202005.750621-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Drop empty multiline comment.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 3c3b30338328..754abc979adb 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -14,9 +14,6 @@
  *   https://www.mail-archive.com/linux-media%40vger.kernel.org/msg92671.html
  */
 
-/*
- */
-
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.25.1

