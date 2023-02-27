Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE8D6A3E25
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjB0JUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjB0JTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:19:51 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F60023314;
        Mon, 27 Feb 2023 01:15:45 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n6so4631612plf.5;
        Mon, 27 Feb 2023 01:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpHa+9Qi+yl092RQ8sVwxFPgJ03A4k/EwplJBc+eab4=;
        b=iK7j2q5qHQp1pfs5IP0HTzd/uPC47wQjVyQvpCU3m6dlQgdptSsWLU7vt5RbjGj5GQ
         g+ISkHhj3wHOff1tKye952+0Ax4xj+BUWsDapEwfz45jCTest1KVZqrQ+jE3hnZiKLF9
         V2Ionr696u9D0I5/Ks+mUmBzkagy10qu67vmi+BnH1O7CRPolulBztXpTSm8DQ6dSnYm
         rwnukaNqakaE2km7+VzTMs4j7tdK/sjpLY4eWtM4UZC8rmcaaM3ccpQseNI8+3dEqiq5
         x5JjlKpMyH0rVC3qnmFx4vJUKRsd0+yQQyzz5eX1xQLXzd27h2dxS8oEC3XwL5zicmuN
         +Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpHa+9Qi+yl092RQ8sVwxFPgJ03A4k/EwplJBc+eab4=;
        b=FjW0cJF7pMoC3hoyke6MfnMAbZV/Iovvx86QF8BDGMHAPv4Bfm4dDdzMlG2b7glH7E
         DhZLjCNjGxbQV7oDn/Weo0SYck5cPENd3R+SVuiJqUNlLTyy9rqyXcfRcjjZqghHMKd+
         E6fbadN7VjxZPJdK6ejXk+uKL8ef1vyImGJ47Z1fH+818UzEH0+CjS85gvu/TlwPFwQg
         lWpkHpP1zVGqdHwbkkwuEPF1Dgs/0IjvSr8lsSB7jJwRNQ15/XgUFclxJswn6Lqoqhqj
         hKQc/Z+JZqDsKJM4Hzmnb43A+Zhl0zSwkDfbZLkiRcJjsVBkef/9zFYOuGjhf1WRd5OK
         3vVg==
X-Gm-Message-State: AO0yUKV4q03h2kQWPG8c7gm/Fg4l+bkqcNE7jMjF7MrXDOfrSzdGZMs+
        EQOpWyu1fu0QsAuTvA2mXgg=
X-Google-Smtp-Source: AK7set/irtrfwp+D585jGDRQJKWGfP6zlsSqYMAS9eOzzC2CUH9T80cEz8Yk2/UplVVK+1ZzzdbFJA==
X-Received: by 2002:a17:902:f7c5:b0:19c:dd2e:d508 with SMTP id h5-20020a170902f7c500b0019cdd2ed508mr8032884plw.4.1677489340309;
        Mon, 27 Feb 2023 01:15:40 -0800 (PST)
Received: from localhost.localdomain ([103.116.245.58])
        by smtp.gmail.com with ESMTPSA id iy12-20020a170903130c00b00183c6784704sm4068281plb.291.2023.02.27.01.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 01:15:39 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mezin.alexander@gmail.com,
        void0red@gmail.com
Subject: [PATCH v3] hwmon: nzxt-smart2: handle failure of devm_add_action in nzxt_smart2_hid_probe
Date:   Mon, 27 Feb 2023 17:15:34 +0800
Message-Id: <20230227091534.907101-1-void0red@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <f5043281-9b3e-e454-16fe-ef4cde36dfdb@roeck-us.net>
References: <f5043281-9b3e-e454-16fe-ef4cde36dfdb@roeck-us.net>
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

1. replace the devm_add_action with devm_add_action_or_reset to ensure
the mutex lock can be destroyed when it fails.
2. use local wrapper function mutex_fini instead of mutex_destroy to
avoid undefined behaviours.
3. add a check of devm_add_action_or_reset and return early when it fails.

Link: https://lore.kernel.org/all/f5043281-9b3e-e454-16fe-ef4cde36dfdb@roeck-us.net
Signed-off-by: Kang Chen <void0red@gmail.com>
---
v3 -> v2: use local function and devm_add_action_or_rest
v2 -> v1: split the patch

 drivers/hwmon/nzxt-smart2.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
index 2b93ba896..340002581 100644
--- a/drivers/hwmon/nzxt-smart2.c
+++ b/drivers/hwmon/nzxt-smart2.c
@@ -721,6 +721,11 @@ static int __maybe_unused nzxt_smart2_hid_reset_resume(struct hid_device *hdev)
 	return init_device(drvdata, drvdata->update_interval);
 }
 
+static void mutex_fini(void *lock)
+{
+	mutex_destroy(lock);
+}
+
 static int nzxt_smart2_hid_probe(struct hid_device *hdev,
 				 const struct hid_device_id *id)
 {
@@ -737,8 +742,9 @@ static int nzxt_smart2_hid_probe(struct hid_device *hdev,
 	init_waitqueue_head(&drvdata->wq);
 
 	mutex_init(&drvdata->mutex);
-	devm_add_action(&hdev->dev, (void (*)(void *))mutex_destroy,
-			&drvdata->mutex);
+	ret = devm_add_action_or_reset(&hdev->dev, mutex_fini, &drvdata->mutex);
+	if (ret)
+		return ret;
 
 	ret = hid_parse(hdev);
 	if (ret)
-- 
2.34.1

