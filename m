Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE92A6F03E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243280AbjD0KBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243117AbjD0KBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:01:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7174B40E6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:01:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a66888cb89so64217915ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1682589664; x=1685181664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9mOuUkhnwntmiMJZCh4kgvplTAXhV1xgo2sdUsRp4E=;
        b=H3P7NwYuB35IHIsCq1x7d0AnmUoCg1MOfVetmnmXeLL/hjuZvDTcJow+MCS+SFLN8F
         b+hMvRaQpfFxfi19GkOihP7GTGdydBKRMFh6gYyE5UVFtra3QUX8U0sGJQUQjuPQpVJa
         l+TElK7z5G3Ef7yKDxbkiTTTDkFc1FaeoCgGH4tP/GH30aK8/E290DLdbjiDkYl4/Wnz
         WL/nxpEFQtuWp/5OZ4z4o51EwAMpO+STong6rC4Yes8NSSBTPovxk9Dmnr9a1hXFSv4r
         pMDWCZLeA1h7QIJhW6puZCDFrXQW9XXOzonTuW1VvEhpCFYDpZYBpsOKd0H9bsc4vlRU
         xcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682589664; x=1685181664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9mOuUkhnwntmiMJZCh4kgvplTAXhV1xgo2sdUsRp4E=;
        b=eCtwEj/tpSvrJ7ge/XcqB8ufmJNRj5uaJc1/dp+GujqHxbB/5iqkar9az0HYwBzKh1
         Mg3PTv9GJ60gWa6JzlZyqqZzG816uG/wPttd4iCUb6qSWhAPl0kDlhNKAczqEwM/1sbk
         QzZJHL43gdC+2qI6GPCQFd86owS/Nl5l1UBiZk0JVOjZOtU36BF04HEH0Oi0eGCABjiX
         PKw0sMqeboCM51gyPPmgf01zSgRCtu4HClQ2ErC4qyOkTyzCJ00T38RYAsP6fIDzNnlg
         2ZpsMQuaXUJ110QtgjmcjrdE9ttTnB64EkxxPoD3aeAXdrrBY2j0PAASVpNNx4ivOUsB
         17iw==
X-Gm-Message-State: AC+VfDwyLxHZBbCVUnMJY/kkdR3/hEZl8WnWNy6A0B1sPrd1Zgw7asee
        nqMKmJgJ0DmURae8nFjvXx4zf5U6YjuTVbSQ0ZEGs+2r
X-Google-Smtp-Source: ACHHUZ6iMKV8sKifSn/PKDp8xiDUoGRtRtuBPGj8FFt801gaMLUFRpqt5TSY/E6n9lTtZfNxyy8dxg==
X-Received: by 2002:a17:903:22d2:b0:19e:ad18:da5c with SMTP id y18-20020a17090322d200b0019ead18da5cmr1114789plg.37.1682589663819;
        Thu, 27 Apr 2023 03:01:03 -0700 (PDT)
Received: from paddy.. ([101.78.151.194])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ab8300b0019a97a4324dsm11366104plr.5.2023.04.27.03.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:01:03 -0700 (PDT)
From:   tongjian <tongjian@huaqin.corp-partner.google.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tongjian <tongjian@huaqin.corp-partner.google.com>
Subject: [PATCH] power: supply: sbs-battery: return -EPROBE_DEFER when battery err
Date:   Thu, 27 Apr 2023 17:57:49 +0800
Message-Id: <20230427095747.3889718-1-tongjian@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some batteries are not init complete when the first poweron, this cause
the devm_power_supply cannt be registered. we will return -EPROBE_DEFER
for probe retry.

Signed-off-by: tongjian <tongjian@huaqin.corp-partner.google.com>
---
 drivers/power/supply/sbs-battery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index f84dbaab283a..0669c1bc1e4f 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -1187,7 +1187,8 @@ static int sbs_probe(struct i2c_client *client)
 skip_gpio:
 	/*
 	 * Before we register, we might need to make sure we can actually talk
-	 * to the battery.
+	 * to the battery. If a failure occurs when talking to the battery, we
+	 * will return -EPROBE_DEFER for probe retry.
 	 */
 	if (!(force_load || chip->gpio_detect)) {
 		union power_supply_propval val;
@@ -1195,7 +1196,7 @@ static int sbs_probe(struct i2c_client *client)
 		rc = sbs_get_battery_presence_and_health(
 				client, POWER_SUPPLY_PROP_PRESENT, &val);
 		if (rc < 0 || !val.intval)
-			return dev_err_probe(&client->dev, -ENODEV,
+			return dev_err_probe(&client->dev, -EPROBE_DEFER,
 					     "Failed to get present status\n");
 	}
 
-- 
2.34.1

