Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC5B5F57C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiJEPs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJEPsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:48:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A9D79602;
        Wed,  5 Oct 2022 08:48:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1287634wmb.0;
        Wed, 05 Oct 2022 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=zvdzV5NONJDBCUm21IdAffqRPiRBCG67doUzQ6+6n0M=;
        b=S1kciJzoCzZUa4tt3vXo7YVeSCxjGaFD1BSLvS0yn+5ccmY2uH2Xtih+RraA+BMYRw
         +55G3rWaXUJh1Jla9cm508lioJeLPw6UJkCcw6Lwevau8BeeYtyHE3e6Yb3fimx4klD7
         0EqPVpr0ghLat8si2WI0uSaDKwukEIRDknmFA+eSSr1FzngYjwk04DUavcGR2MoV5BOW
         P7sFuvBfia2u1hGWiTf9KmUtajxC/WWadbBKE8mZxDLqQrFulIf8fMY61LQj6frCld0D
         xTMpwK+jIN4AYT7+0hl3FVQKXl7bs3YMhSMzxkz+Du+eVR5TrnG9TZgHZIAjENOewwEq
         PfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zvdzV5NONJDBCUm21IdAffqRPiRBCG67doUzQ6+6n0M=;
        b=teQVidXNHK4Bc0vuqOvwuzS7vapGoMkYewB8/rFADyhNWJJ8/wr9/T0+8J/iVmHlH7
         XtepfHcA8LzJIXxiOZLpjUKdR/TAqElXsh6/zRhlLkeu22Vu42SW13MFQkjYpKYTn7Gt
         H7XldPdoMgKESja0NS39sHOSm8VuW3cmK8TzEfV74P6bfMhqAGNaAQfil0mpw95sQobV
         VN22NUFhjvwZ3iDPNbUBTxEGm3TSdJ1TWfxj1d1y4k3/ki7i4yVoboTup5FSs284sJlM
         acRENWzwjqI2UfLGXzejMTqx3/SAj7afo5oCg0fM95/rjhrFhDPbpNLiHnKbjSXuMn90
         MagQ==
X-Gm-Message-State: ACrzQf0moLDVduklZLLW5RynD4FNXCXcu/q6sS8INLFmdVXH5prlTLRS
        rr1VNqhCUtuO1/3ZE/BwsIs=
X-Google-Smtp-Source: AMsMyM70b4J3oBB1GdfcnfZoJSjEKLdqnLlJEOP+3HB/DpM4fEkK2ed/MryS26WZ/KsgUxz1AKAb+w==
X-Received: by 2002:a05:600c:3555:b0:3b4:c0fd:918e with SMTP id i21-20020a05600c355500b003b4c0fd918emr121056wmq.61.1664984933317;
        Wed, 05 Oct 2022 08:48:53 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f6-20020a1c3806000000b003b3365b38f9sm2275751wma.10.2022.10.05.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 08:48:52 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: dlink-dir685-touchkeys: Make array bl_data static const
Date:   Wed,  5 Oct 2022 16:48:52 +0100
Message-Id: <20221005154852.320056-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only array bl_data on the stack but instead
make it static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/input/keyboard/dlink-dir685-touchkeys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/dlink-dir685-touchkeys.c b/drivers/input/keyboard/dlink-dir685-touchkeys.c
index a69dcc3bd30c..7db7fb175869 100644
--- a/drivers/input/keyboard/dlink-dir685-touchkeys.c
+++ b/drivers/input/keyboard/dlink-dir685-touchkeys.c
@@ -64,7 +64,7 @@ static int dir685_tk_probe(struct i2c_client *client,
 {
 	struct dir685_touchkeys *tk;
 	struct device *dev = &client->dev;
-	u8 bl_data[] = { 0xa7, 0x40 };
+	static const u8 bl_data[] = { 0xa7, 0x40 };
 	int err;
 	int i;
 
-- 
2.37.3

