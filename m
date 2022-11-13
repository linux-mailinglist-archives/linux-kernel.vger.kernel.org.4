Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1B2627161
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 18:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiKMRzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 12:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiKMRz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 12:55:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5514611458;
        Sun, 13 Nov 2022 09:55:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o4so13528986wrq.6;
        Sun, 13 Nov 2022 09:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCqMItUHQoCNVI22cgNNHayq5fUO1JHuNXhR6Kkhq4o=;
        b=QUDC3T0LasYGTrZpUqjcj/tBg5QvLuJ3nNWp6fP/Czgiq0nwuAfbxGIfdsP+05+qvU
         hM7Iwri+HYfpnlxAt4YmZ0VXf0BoK5uj1hHPmvgSfFOFPBmeQDNVO8c5KGQK4cUVHxFs
         YwMWOF48BHAR5ixmYzFYHonE/+HeR7RzXXrzG7kx/bdCZQEc9+dk4wKxnM8sf+PFBatx
         npjkWwAJt/W9B2t5buI2GdadcYFYMe8nyvPVQ6OCx8C0PD1yeOBmPMOfbl4rYW79cEu9
         gFIVlAy1rOUd4CSkZb8jUK9qnFekPla6SYIu2fIozhdZ+AjXnTtlqOczMLOUWcF7reA/
         udOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCqMItUHQoCNVI22cgNNHayq5fUO1JHuNXhR6Kkhq4o=;
        b=wGA+RufE+heZsGXIl0Xn3K+KH8sUnnbH/U2/gy/Al38Zlyy7p4nkPuN76Y40TnPX4U
         0Z+/l6Th5ICPhOHT4/GaH1rgVa1haf19fkg1Vw9EwrJxQCemzrwYHKlhrztrrtHlHLVp
         iH4/8/EBrirrdDxYrnpcCmF4QUNftzY+JOxxwj86D1F8hwbmKriEdbJiDF3YvQZj+H2F
         zt/0O/mJNWlmaMcAXTDoSednenH89CVXBOWle0aZ5VgWSweBkWnHrn9KfhkQoYTJbNIv
         T3o+bIF4lEElEojXz07Cc/Ufvt0Ir5mMv91R9bmIKHS0Awq3uafbdwRCUDEaYbuLhxtD
         H5tQ==
X-Gm-Message-State: ANoB5pmSS+I6uCEXR0KH3P3Z+riAjcC7ShCzGfLjkqzxDCkLxtKIefqn
        faQ/Zvi3AKt88iZ42sWivX34c9kdkCs=
X-Google-Smtp-Source: AA0mqf4wCO0kqGyBpU3gFzL70cPEFyp8v5skaJUUJNUTKhTnpu/Ng9/qz+soF5SczvgeT01wTOoC5A==
X-Received: by 2002:a05:6000:a1d:b0:241:7d0a:65ef with SMTP id co29-20020a0560000a1d00b002417d0a65efmr3239019wrb.491.1668362121660;
        Sun, 13 Nov 2022 09:55:21 -0800 (PST)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id bk11-20020a0560001d8b00b002416f0f1e96sm7004999wrb.43.2022.11.13.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 09:55:21 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 2/2] iio: pressure: bmp280: convert to i2c's .probe_new()
Date:   Sun, 13 Nov 2022 18:54:46 +0100
Message-Id: <5dcaa389ea2ffe7050091b07a3bc4b0c1c9d586b.1668361368.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668361368.git.ang.iglesiasg@gmail.com>
References: <cover.1668361368.git.ang.iglesiasg@gmail.com>
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

Use i2c_client_get_device_id() to get the i2c_device_id* parameter in the
.new_probe() callback.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 0c27211f3ea0..14eab086d24a 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -5,11 +5,11 @@
 
 #include "bmp280.h"
 
-static int bmp280_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static int bmp280_i2c_probe(struct i2c_client *client)
 {
 	struct regmap *regmap;
 	const struct regmap_config *regmap_config;
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 
 	switch (id->driver_data) {
 	case BMP180_CHIP_ID:
@@ -65,7 +65,7 @@ static struct i2c_driver bmp280_i2c_driver = {
 		.of_match_table = bmp280_of_i2c_match,
 		.pm = pm_ptr(&bmp280_dev_pm_ops),
 	},
-	.probe		= bmp280_i2c_probe,
+	.probe_new	= bmp280_i2c_probe,
 	.id_table	= bmp280_i2c_id,
 };
 module_i2c_driver(bmp280_i2c_driver);
-- 
2.38.1

