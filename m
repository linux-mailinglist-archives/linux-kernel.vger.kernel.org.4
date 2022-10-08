Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6852A5F8469
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 10:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJHIt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 04:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJHIt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:49:26 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5E74D159;
        Sat,  8 Oct 2022 01:49:25 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id a6so1253145vkm.9;
        Sat, 08 Oct 2022 01:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4DaO/Q3O3pM/djsRG+MNdNULYgwU9KBFaAmYTttXdHc=;
        b=dRslYHH8QTFf2Iw+zTIu+Q4WkHOU2/sFSeY3EnJSGS+1RpzwrO6nDDcPg8aqKnINmO
         izLshd83P/0VzibFdJSUB5RYb1teXMmGkJrEb4UU+Obdn/5RR+n1Bhs0vjPdLVF5L7Fm
         25zCP8LANRlln7zh857Hd9cLhCfYOqjAxz2DQYyT1fShAydIxxOh7mz11ym2hLduwUb9
         L6DF0YzVoDidKWaumYaeuRpgml/++x9dcoa0h50c6uyKKAUCkcxYDMy2CzvKmS6JLTkS
         +1gjdQpF4sU/WqF+N+qYoeQf0ZR9cCYyX5SO5HaulMQJpryFvo4jlTtlem0mneFIb47B
         v/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DaO/Q3O3pM/djsRG+MNdNULYgwU9KBFaAmYTttXdHc=;
        b=7kQpaBmQzN1bNirc27szaN2IUQlt5JzAK3Fz5/i1MBNvAnClJNzAuvt4N0RCh3h3Gc
         KTstz9Kw+jY4/dOZeIDXsaAYIt9BOtb9GL5O+jS7KdpGu0fZKjngvwtybiSwKwm7TcKZ
         Vk0PsvVbMWtnM+nlMrP6PTUNMaWS2fMIJpKvJ4WGesboS3L6rwo2gy1Rk0RAxDdQSbhj
         b5ivqAXJBPkTlaN6c2w/y8OKR/qCC3naEgBDWANMQVlQoNyB/YPnFyZQfZEhiHfXYiZt
         B3dVzENmBNBY5K7+BeIE7zJhocoNqTV5ImVmosrGmP1A7GwB+F0XUEgvHIG+YYrT0wzD
         q9jA==
X-Gm-Message-State: ACrzQf1vODiqhxBB9T2u9kFK1aHAAIgzhhYjIhcv+u3TB4l2XPQ1vWXu
        Ih66FqCUyH8HLHVzkOnvVWVAU/Cr7Yk3dNki
X-Google-Smtp-Source: AMsMyM4i13fzonaL3MlgrnsTY5dGhhnQM1mbsMGe4VNycJu3g30Sc7G+KFCDy/rdXSTA2KqKvaP4YA==
X-Received: by 2002:a17:902:e74f:b0:179:fdfd:2c84 with SMTP id p15-20020a170902e74f00b00179fdfd2c84mr8738374plf.41.1665218953809;
        Sat, 08 Oct 2022 01:49:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902b59000b0017e232b6724sm2822573pls.69.2022.10.08.01.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 01:49:13 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     martin.petersen@oracle.com
Cc:     hare@kernel.org, jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] scsi: myrb: replace !strcmp with sysfs_streq
Date:   Sat,  8 Oct 2022 08:49:07 +0000
Message-Id: <20221008084907.309320-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_streq().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/scsi/myrb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index e885c1dbf61f..7f269b90c9e4 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1813,12 +1813,12 @@ static ssize_t raid_state_store(struct device *dev,
 	enum myrb_devstate new_state;
 	unsigned short status;
 
-	if (!strncmp(buf, "kill", 4) ||
-	    !strncmp(buf, "offline", 7))
+	if (sysfs_streq(buf, "kill") ||
+	    sysfs_streq(buf, "offline"))
 		new_state = MYRB_DEVICE_DEAD;
-	else if (!strncmp(buf, "online", 6))
+	else if (sysfs_streq(buf, "online"))
 		new_state = MYRB_DEVICE_ONLINE;
-	else if (!strncmp(buf, "standby", 7))
+	else if (sysfs_streq(buf, "standby"))
 		new_state = MYRB_DEVICE_STANDBY;
 	else
 		return -EINVAL;
-- 
2.25.1

