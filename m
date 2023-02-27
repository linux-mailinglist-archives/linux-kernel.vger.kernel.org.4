Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042656A3940
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjB0DJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjB0DJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:09:19 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157FB6A50;
        Sun, 26 Feb 2023 19:09:19 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u5so1908944plq.7;
        Sun, 26 Feb 2023 19:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U6MZpaD1EOJajQO4fgDPUHTzMf+D4q3s0m/2f40QEo=;
        b=JIDUckAkqW8btXTq/k2qg++a2aoYsu/HER3CRmNV51TrL0fdm5k962NCVZJUZ6gTcQ
         FYPjC5bf6Y2Et8uzioTwqfOCTY7RVWKmd6A490AU+XmzpZ27sXAn1Dadzl4Y2RlnET5n
         GzejZtZOPM+aEQC5ICUKjsm0emC0gzvN6rmhvSqucDhiqwI4rrFXQ7lpsnRKpcN3BaMx
         2f9OLGwGxE+L1l+0ahfotkN/nwLfR9TmGZZc6DthAurxQDrp1T/qpNdT0MQ9jmLfZWau
         wX9s+joc4Ft9L6Wc9ERU0hlkXkXUHCLTIspSvV7yF9zAq14z9gQ2m16bK8T5pLmVQhip
         Tpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1U6MZpaD1EOJajQO4fgDPUHTzMf+D4q3s0m/2f40QEo=;
        b=M5faDXC8eF3FhkdeXp7cmFgAJtmS8goFO3GY6Rhait8WIFery6+X5z4SWEb4Ny9wUd
         WUfDy32XpmQTZGa1KV86C7lS8BnT+0SllMJ0BRlVUzpYjX7HCJyYWuCqVgbPXBAtsUk5
         pDLasfLm8tztTWfGap/jggc57mENnNjOvl4Ink8mxyuwLtAzSm8P5HTIANTzI0f4z2HU
         sxn0EFyCdqddCz1126RVFQLSL2OOYo27GXPVdnniy7UApKu7X4tVjdPWaDwq1b9mMj5D
         jnKJt9f7ms0wE/HCNhHkcPOSmvxOYhUUSzXA1Ip7Qh6lleLiYrTpS8tTxu8l+Awofm71
         RBJw==
X-Gm-Message-State: AO0yUKVrO1acoNA1j6DPsnA9qOQ5hBzs3OE7J/M4U/U7EGCkot0kWPeG
        +jq9PsFdcxaWkmrpZOpumKg=
X-Google-Smtp-Source: AK7set+tuqTlwQTaAQONHe37YHToLq/9wufM+u3StxeeSU3JQZh8pf/sPH+1TUUROHW9ndMLuLffrA==
X-Received: by 2002:a17:90b:4a03:b0:236:6dea:87b4 with SMTP id kk3-20020a17090b4a0300b002366dea87b4mr24893121pjb.39.1677467358458;
        Sun, 26 Feb 2023 19:09:18 -0800 (PST)
Received: from localhost.localdomain ([103.116.245.58])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090a5c8600b00234a2f6d9c0sm3189852pji.57.2023.02.26.19.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 19:09:17 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mezin.alexander@gmail.com,
        void0red@gmail.com
Subject: [PATCH v2 1/2] hwmon: g762: add a check of devm_add_action in g762_of_clock_enable
Date:   Mon, 27 Feb 2023 11:09:12 +0800
Message-Id: <20230227030913.893004-1-void0red@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <42cdd5e4-c9da-b31a-0ffd-76846757645c@roeck-us.net>
References: <42cdd5e4-c9da-b31a-0ffd-76846757645c@roeck-us.net>
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

devm_add_action may fails, check it and do the cleanup.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
v2 -> v1: split the patch

 drivers/hwmon/g762.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index 64a0599b2..e2c3c34f0 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -620,7 +620,12 @@ static int g762_of_clock_enable(struct i2c_client *client)
 	data = i2c_get_clientdata(client);
 	data->clk = clk;
 
-	devm_add_action(&client->dev, g762_of_clock_disable, data);
+	ret = devm_add_action(&client->dev, g762_of_clock_disable, data);
+	if (ret) {
+		dev_err(&client->dev, "failed to add disable clock action\n");
+		goto clk_unprep;
+	}
+
 	return 0;
 
  clk_unprep:
-- 
2.34.1

