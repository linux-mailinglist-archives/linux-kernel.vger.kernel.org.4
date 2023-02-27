Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10A96A3942
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjB0DJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjB0DJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:09:25 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E469E041;
        Sun, 26 Feb 2023 19:09:24 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i10so5293786plr.9;
        Sun, 26 Feb 2023 19:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Trp/vR8DThjFf6YmscyB4zrOKQwpzckPU820EYJvgFw=;
        b=YMadYORhS31M8ogyNVO7bO7r/6p/QlHgeLSH6n3UO6SWjRBVz21C5gbxIaNglSM57z
         6KjXLtVmt8QAgokEaLNNjDQIl3YpBNrj+FP1aW55JuP1XOWS7XMMNMT6YuKhzAZeqDDL
         TC8VlWdAAPY9p1C84pAB5/jXMiWVgNObHJCKtpqygWkEczd5i4JlaBDpq5l2uSvYZxaX
         GSx4P4AiRZKabBxWeU0QCnKncw1Yrrw+/1sglxJrVWQwZGc/Hbxtb5LiiEm65clDuq0U
         0tn+Q7F4QjOY1X40IJGCZV/DyjOPjaXJLPsx8HrjcFsRkHo7j2yId4wv7IQIIbmDEg9u
         Ufrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Trp/vR8DThjFf6YmscyB4zrOKQwpzckPU820EYJvgFw=;
        b=N3KUKJy/7LaUlbcYADypqPiq1MjvEfbr35nrFpJZaNLp9OMj0x8j/s5t2Sn0WZTMWH
         LsbiahGzFUp/6z0kNFB48ho0PEMvZlm8XB2JNQFaXVPgGEuT8mrf4Jt9ghkZc9rvrVIc
         BvmNsz9WvU8pOKBx93ZSArpnTdEzHeYNH3A9PsbAKe8sYuyZ7kX0rYhFGbRxeYP2lXz/
         X6S91zeJttf/dKOVgf2PzGjhHiq62Lgs5XU5xYURFh24sFRW4Cb9LNbtoLN6GnsxDR9n
         ZmGfb/ADOSIR74f7mF1M6TdWAqnW1oYU12AmemYSFiGPzr5vVA1sdJgtCzyFLoP5qRLm
         qDrw==
X-Gm-Message-State: AO0yUKWPAkL+wamA4YdR22IK5zDtNhTYnJfYCsG02esJvyGL6C6QHN/L
        OTsWvfgVW8uzfMoS9egOXIk=
X-Google-Smtp-Source: AK7set+oazlLkoiSLcwaQPrF8z4qwasmJHhVZ8eN1sDjWR6mjMITdO/fOxgSQK19iTq9gU/5ChOxiQ==
X-Received: by 2002:a17:90b:4d0a:b0:237:c04b:7365 with SMTP id mw10-20020a17090b4d0a00b00237c04b7365mr7037685pjb.7.1677467364093;
        Sun, 26 Feb 2023 19:09:24 -0800 (PST)
Received: from localhost.localdomain ([103.116.245.58])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090a5c8600b00234a2f6d9c0sm3189852pji.57.2023.02.26.19.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 19:09:23 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mezin.alexander@gmail.com,
        void0red@gmail.com
Subject: [PATCH v2 2/2] hwmon: nzxt-smart2: add a check of devm_add_action in nzxt_smart2_hid_probe
Date:   Mon, 27 Feb 2023 11:09:13 +0800
Message-Id: <20230227030913.893004-2-void0red@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230227030913.893004-1-void0red@gmail.com>
References: <42cdd5e4-c9da-b31a-0ffd-76846757645c@roeck-us.net>
 <20230227030913.893004-1-void0red@gmail.com>
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

From: Kang Chen <void0red@gmail.com>

devm_add_action may fails, check it and return early.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
v2 -> v1: split the patch

 drivers/hwmon/nzxt-smart2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
index 2b93ba896..725974cb3 100644
--- a/drivers/hwmon/nzxt-smart2.c
+++ b/drivers/hwmon/nzxt-smart2.c
@@ -737,8 +737,10 @@ static int nzxt_smart2_hid_probe(struct hid_device *hdev,
 	init_waitqueue_head(&drvdata->wq);
 
 	mutex_init(&drvdata->mutex);
-	devm_add_action(&hdev->dev, (void (*)(void *))mutex_destroy,
+	ret = devm_add_action(&hdev->dev, (void (*)(void *))mutex_destroy,
 			&drvdata->mutex);
+	if (ret)
+		return ret;
 
 	ret = hid_parse(hdev);
 	if (ret)
-- 
2.34.1

