Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACDE6EDD2A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjDYHt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjDYHt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:49:57 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC6C18D;
        Tue, 25 Apr 2023 00:49:55 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51b603bb360so5530022a12.2;
        Tue, 25 Apr 2023 00:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682408995; x=1685000995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wlv8uOscUQTkFimk+Z+36ap1X5k01cfrmLi0iGMV0kg=;
        b=kjC9ImGiGBAnfUAAkUsFjHzZa1uW61vra+8cFcvjZGuwjLKVHJoRLIGEKXuf+NaMBA
         QPk+izgXy5XtKLcHrdSf9v/IZHe4KDYPpKTzrFimI4/vEJ+ONjR/REmVu502DD6nw1Pl
         uyirRTrnikBfBbMf4Tt01ug1y6V6xwYAI92WwV7f5LASKNbBp2zQxWlTmDC5822GS9xs
         6U0G4EhbDDorkXCnUKzyPr35y366UjBsEwXanGSK8t+8HkKHX6q0iyc+XWyYO+KcD/hd
         nAFipe17w1Uue6QxqKoXcf5zmc/P8/2wrjAQazX7kcxLSi8rIhIa4gZ50MKlGs4DgQ54
         v8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682408995; x=1685000995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wlv8uOscUQTkFimk+Z+36ap1X5k01cfrmLi0iGMV0kg=;
        b=b7WpWuzXumhjgNqZFUs2LUqY566smE+ToOWq7v0TEovUgOMGxSqhPx+iJ3fKJhV16G
         /lo9fGh4qWdGYYMxFbJ+3FYNaaLQ6KDG9dkZqG7kgLmxuMa7/K38cPAntdyBw2GdmeAD
         +G0+WhUXuxAFUV9UIRvCgcmCz4O1Ye7cC0TWZkeAVyIraDwSiaxKgg77xEY2S5HSJeIy
         OGnihu6mSIPgCMDl0MOJcRYBdHEj9DB0mMtbgOGdVmIs9wwtSnCEoEl7CbwwYLuTNe1F
         dcMrsVcK4sDFSq3up6w0T/L1rzHUyq/A7/5VCpHfT2yoYpm6DtKYhT8L1qIdkPV9Ei4v
         Hibg==
X-Gm-Message-State: AAQBX9ev2rQzLmNMKEAwsgLqszhRnl+Bxly4fz/a6R5mwZ7K7NwZS9+C
        3jZZo1uWnUOz8qtXADjZYjmSGtHjKt0=
X-Google-Smtp-Source: AKy350bFvUSVTYlb7ngEsykKihkWd80xu7KOLDXAz0y9uXgqcqFRuJoe5WPv4AkcreUt43C8F2OAiQ==
X-Received: by 2002:a17:90b:341:b0:247:42f6:e8ca with SMTP id fh1-20020a17090b034100b0024742f6e8camr16703764pjb.12.1682408995109;
        Tue, 25 Apr 2023 00:49:55 -0700 (PDT)
Received: from localhost.localdomain ([106.39.42.1])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090a3f0800b0022335f1dae2sm7387081pjc.22.2023.04.25.00.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 00:49:54 -0700 (PDT)
From:   starmiku1207184332@gmail.com
To:     dmitry.torokhov@gmail.com, rydberg@bitmath.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Teng Qi <starmiku1207184332@gmail.com>
Subject: [PATCH] drivers: input: input: Fix possible sleep-in-atomic bug in input_alloc_absinfo()
Date:   Tue, 25 Apr 2023 07:49:51 +0000
Message-Id: <20230425074951.1042694-1-starmiku1207184332@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Teng Qi <starmiku1207184332@gmail.com>

input_alloc_absinfo() may cause the kernel to sleep by calling kcalloc() with
the GFP_KERNEL flag. It may be called by input_event() holding spinlock through
the following call path: 

input_event(), 433
input_handle_event(), 399
input_get_disposition(), 294
input_handle_abs_event(), 232
input_abs_set_val(), Clang suggests it calls input_alloc_absinfo()
	unconditionally
input_alloc_absinfo(), 483
kcalloc(..., GFP_KERNEL)

This call path can potentially trigger a sleep-in-atomic bug. To prevent this
potential bug, we modify input_alloc_absinfo() to use the GFP_ATOMIC flag
instead of the GFP_KERNEL flag.
The possible bug is detected by a static code analysis tool.

Signed-off-by: Teng Qi <starmiku1207184332@gmail.com>
---
 drivers/input/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 37e876d45eb9..eefc4c85a693 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -480,7 +480,7 @@ void input_alloc_absinfo(struct input_dev *dev)
 	if (dev->absinfo)
 		return;
 
-	dev->absinfo = kcalloc(ABS_CNT, sizeof(*dev->absinfo), GFP_KERNEL);
+	dev->absinfo = kcalloc(ABS_CNT, sizeof(*dev->absinfo), GFP_ATOMIC);
 	if (!dev->absinfo) {
 		dev_err(dev->dev.parent ?: &dev->dev,
 			"%s: unable to allocate memory\n", __func__);
-- 
2.25.1

