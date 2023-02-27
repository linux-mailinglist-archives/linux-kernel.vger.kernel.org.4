Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CDB6A3888
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 03:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjB0C3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 21:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjB0C3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 21:29:14 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBBC1B56E;
        Sun, 26 Feb 2023 18:26:32 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-17235c8dab9so6077661fac.7;
        Sun, 26 Feb 2023 18:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fz5QpFY+3NFeGt8tf7598EozOgjkMuS7nJw1aNeWOk=;
        b=m2C1JCPKQax4aUNht7ugrPynkIzrgXe76LWKq3xB/UOtsK56klQ2a5pY9tX1FdlTVt
         BIis1iHWEPErBzTuQftmu4T6IjCY3NlGfXAdUDED8Waq6Y3FA8DjUaEDbb4J/+9sed+N
         ko/uUIMgnLowrZsWUSBziCChmCA67RzM18x4XbPxESrOkPIcWsPd5/lma2NraXUrTLWU
         hjhRJ3zXsuh+Y3NCET/wxv8FBaEoZrCPtQFa6vPEzuN5fsgSeHNg+UxDlXEK/gkeaqdu
         XQifb/DqS7IojiwGk9IQQzNt0z2yMpj752Rw9H+dT9mqz4slOAM3FENU9CeaNklJvWMx
         TkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fz5QpFY+3NFeGt8tf7598EozOgjkMuS7nJw1aNeWOk=;
        b=OVL0gtK8eyziVqX0jcikYtlIkr7su9RjYBpaa1Ukm+sSL/ABw2ZPQOkTpmnhTZymfm
         eWCJjQn/t7zMZzUkoQtCYxVE8jQz3jGyk4fSuzhxgNTO1FUmZomd/LZJn5qEyOE+/QrG
         3XNKt9bdRv7FtGcjo7heLN4LM5N/Q5VZ88bM6ipk68vaVlr6wPp2oWNJF6h2crai0dc6
         j2XZqCVg2PCl/OJBb7AGNbnB1TFS43qwJ76LxL4k0Jm7W1bg/UXhTsMaQ+Lwsr5MJ2Fh
         P3RFz7f9qZZdE62tGX6vrKoDXJAnZ8o+xkSLynFUspdqiHWOxKWW37M5lH30bfigHXtL
         l9vQ==
X-Gm-Message-State: AO0yUKWxMsF/CdRZId9IF0QIqnkx5DdVzOOZ5D1BBUxyZ4axaL49TdpX
        71XM7XdUWhvW2qkl+/9PpwjeqxKB2QOTR4fl
X-Google-Smtp-Source: AK7set9h4NilykhO0vMn/fJsucQSFz6qC7Y6J0p35qcKuxq3I/ZUv+95Dwpdjw+zmP39TtuSR65RiQ==
X-Received: by 2002:aa7:9478:0:b0:5db:db1c:37f9 with SMTP id t24-20020aa79478000000b005dbdb1c37f9mr12508256pfq.10.1677464278236;
        Sun, 26 Feb 2023 18:17:58 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id m12-20020aa78a0c000000b005a8ae0c52cfsm3176086pfa.16.2023.02.26.18.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 18:17:57 -0800 (PST)
From:   Kang Chen <void0red@gmail.com>
To:     jdelvare@suse.com
Cc:     linux@roeck-us.net, mezin.alexander@gmail.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kang Chen <void0red@gmail.com>
Subject: [PATCH] hwmon: add a check of devm_add_action
Date:   Mon, 27 Feb 2023 10:17:20 +0800
Message-Id: <20230227021720.1578781-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
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

devm_add_action may fails, do the cleanup when if fails.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/hwmon/g762.c        | 6 +++++-
 drivers/hwmon/nzxt-smart2.c | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index 64a0599b2..d06d8bf20 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -620,7 +620,11 @@ static int g762_of_clock_enable(struct i2c_client *client)
 	data = i2c_get_clientdata(client);
 	data->clk = clk;
 
-	devm_add_action(&client->dev, g762_of_clock_disable, data);
+	ret = devm_add_action(&client->dev, g762_of_clock_disable, data);
+	if (ret) {
+		dev_err(&client->dev, "failed to add disable clock action\n");
+		goto clk_unprep;
+	}
 	return 0;
 
  clk_unprep:
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

