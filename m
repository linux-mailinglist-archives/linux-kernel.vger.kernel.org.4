Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9467569849A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBOTjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBOTjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:39:35 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE4D3E632
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 11:39:32 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id dt8so16817587oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 11:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+gy9nLNyoIQUK6iwX/Y0FCLjl3H31hI6ury00skryq4=;
        b=MWcU3QEll9pf0YdfxZEo6BIrtfcqPJnmHeyxMxC4JCaieJXorrJ9DXlOoYGQ4N9TE6
         fdFJFUujY6GchLIliA05LdROnfWKVPJa0qCilaja0BnyyIuSE3dcD/EenGs0oJqlNL9A
         I2EhTjajUMYLKFYe7y31BrkHCIs3M/qu5/HXmaaLO80xWsYjWLBGOI7N0JJdCyfIipKQ
         /MIX9qrw1mEHzg06zJ2a3UBSCU8L+I0yEsa+pBo2gAmUjURM8nwOQS3VzKIA6btRczVO
         NZDrdsAoKIWb67LZcDvjNHTaXY7PcwCCF3ThzcKCjUU9D5fPUPxQJ0ztwX3ZPYRundRz
         1lJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gy9nLNyoIQUK6iwX/Y0FCLjl3H31hI6ury00skryq4=;
        b=ZWH/6ZUe5f1F8zGe0svoQ0TGQLZcU7NGJ+zPoNXzNpdgjQFxbd2TTKkKmc2fYuYm66
         jAod/Xk+vD7xMjpGcjMQzoqCxhUdt506ETXWv8iINoNGZOFQSqOtFK5IErQPk9R4JiyT
         0zgCncD6HrKgabawxSFtx/xrBCVA1DNsl5rZP8tjc6yerdC+gQn/d8A9iDY5IfkfES5t
         rmMMMH2s+dQZ5hFgeUnn+ewfwlyBff8WUYPuaHxPl/ul0mn+kUn6lCzh5MgCgfKBbtyv
         5YdFJZj25+aeO0Cgp3atNeswHvJDy3EGD3AVVLJ0QzT9CSAhrfI8L2J0htQiKIpsyXwd
         WesQ==
X-Gm-Message-State: AO0yUKXrbSNjNX2uzM7p8OoL1qD+bqcHUn+2ODicLNCWXUojNyq4npQ7
        IsVunxkTzKaJEpfeaycuqQIs1Q==
X-Google-Smtp-Source: AK7set/RbYIbriNGlWV+8yhX2eMc6Wc3l4GJWkr3tSVWhf+ljWb4Dz7LcZQx8qoF9ZF8mqjqg0rqiQ==
X-Received: by 2002:a05:6808:219:b0:364:fc2c:687a with SMTP id l25-20020a056808021900b00364fc2c687amr1248492oie.57.1676489971741;
        Wed, 15 Feb 2023 11:39:31 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id o4-20020acad704000000b003785996ef36sm3024980oig.19.2023.02.15.11.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 11:39:31 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH] gpio: 104-dio-48e: Utilize mask_buf_def in handle_mask_sync() callback
Date:   Wed,  8 Feb 2023 05:55:42 -0500
Message-Id: <20230208105542.9459-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mask_buf_def argument provides a mask of all the maskable lines.
Utilize mask_buf_def rather than hardcode an "all_masked" mask.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-dio-48e.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index a3846faf3780..74e2721f2613 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -106,7 +106,6 @@ static int dio48e_handle_mask_sync(struct regmap *const map, const int index,
 {
 	unsigned int *const irq_mask = irq_drv_data;
 	const unsigned int prev_mask = *irq_mask;
-	const unsigned int all_masked = GENMASK(1, 0);
 	int err;
 	unsigned int val;
 
@@ -118,7 +117,7 @@ static int dio48e_handle_mask_sync(struct regmap *const map, const int index,
 	*irq_mask = mask_buf;
 
 	/* if all previously masked, enable interrupts when unmasking */
-	if (prev_mask == all_masked) {
+	if (prev_mask == mask_buf_def) {
 		err = regmap_write(map, DIO48E_CLEAR_INTERRUPT, 0x00);
 		if (err)
 			return err;
@@ -126,7 +125,7 @@ static int dio48e_handle_mask_sync(struct regmap *const map, const int index,
 	}
 
 	/* if all are currently masked, disable interrupts */
-	if (mask_buf == all_masked)
+	if (mask_buf == mask_buf_def)
 		return regmap_read(map, DIO48E_DISABLE_INTERRUPT, &val);
 
 	return 0;

base-commit: 4827aae061337251bb91801b316157a78b845ec7
-- 
2.39.1

