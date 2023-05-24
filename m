Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17BF70FC00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjEXQzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjEXQzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:55:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEC5E9;
        Wed, 24 May 2023 09:55:01 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so1201057e87.1;
        Wed, 24 May 2023 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684947300; x=1687539300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1YllsulOzXX6In9v1+K/QqMkoSsg3BKziTf7i1CVwA=;
        b=fQWeDuL4JDCwu6wz0ipW7bhSwXjdqHoZfFH38HNnRo211GPYoOBWsB0dgK287/KsCW
         oDBlQkjd/AWNVJrIeHYloTum2stfhBYqCvfJy3y2C7xjMtJwJBaOArlHsJ5JX7E1kdVz
         /8SKrXFhXUDvCJXGiDA5LULw7fJVXanBIAsoz1naxJsYSL9tlpy/ZUl0klLPVfbJJYF6
         hrwNaa6M7sXJPV5Y2KMvuNkbAHETZ99g5ucKJ6zU/nfVY5klEPZvjBXeMqE9D31sg0dA
         FdrTNItkt4rPhvMUxRHLOcrJa3rcZC61AtqKx/ffDAusgg8keHOLz/J/t8qgN2QsYtuk
         G8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684947300; x=1687539300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1YllsulOzXX6In9v1+K/QqMkoSsg3BKziTf7i1CVwA=;
        b=VSTxc6QmUsI/ok3LRjYI9y/54lDq9DY4x1VfVK/X3dLP0kZ0epH/h/PjP2uakXAy/S
         7ve2W7PTig2hHJY+/43enO7jrd+eSTw6zwiOZjYbLF8UjehZ8Q3zEY+ErgVeGXZfVZ6Y
         yFH+duBiU8Nlsf6WF3UsFw3QpqeYTaWq4mevBQ8LMf6BT7gzoH7g2tYpMOkORsZTw+cE
         h+Lsd5f4Wg5QHHmqskjBtYev1mQfAUbLTNz+hL14hNL9lY49Mm2AsiioTkcMVy/SOR6k
         fPHYgsKvqK9pHVowAOa7xpoF913suTmBPbfSff4iu6R0SVXjS/aRut6FClCTKRtruQD7
         cAww==
X-Gm-Message-State: AC+VfDzc1CrHLcfUzsTev6YH/PXmSYRKp6BeaqtGMEIhvksTtiP4HuFQ
        i0g3HAppedSNFB1rWt3Gd9U=
X-Google-Smtp-Source: ACHHUZ6eb9VAaxu1Z5T0JsWjUivhMz0YgLwW3IanQr0IHq6gmtDb+84K98tsiBsScSoeqe1e7S7Eiw==
X-Received: by 2002:a05:6512:3765:b0:4f3:8244:95dc with SMTP id z5-20020a056512376500b004f3824495dcmr5306642lft.15.1684947299527;
        Wed, 24 May 2023 09:54:59 -0700 (PDT)
Received: from Osmten.. ([103.84.150.66])
        by smtp.gmail.com with ESMTPSA id y17-20020ac255b1000000b004f3778239adsm1787135lfg.19.2023.05.24.09.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:54:59 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] adm1266.c: Fix error checking for debugfs_create_dir
Date:   Wed, 24 May 2023 21:54:23 +0500
Message-Id: <20230524165423.21024-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch fixes the error checking in adm1266.c in
debugfs_create_dir. The correct way to check if an error occurred
is using 'IS_ERR' inline function.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/hwmon/pmbus/adm1266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 1ac2b2f4c570..d88b6115b42e 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -340,7 +340,7 @@ static void adm1266_init_debugfs(struct adm1266_data *data)
 		return;
 
 	data->debugfs_dir = debugfs_create_dir(data->client->name, root);
-	if (!data->debugfs_dir)
+	if (IS_ERR(data->debugfs_dir))
 		return;
 
 	debugfs_create_devm_seqfile(&data->client->dev, "sequencer_state", data->debugfs_dir,
-- 
2.34.1

