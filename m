Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104336E5FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjDRLcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjDRLca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:32:30 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFBD4215
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:32:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f178da21b2so6064605e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1681817547; x=1684409547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH6qJUfWL9zJ79gRC7zWLV6OUPZJsPitBsnwEKwZJzc=;
        b=dYUwrH3cwlb/VxM7YYjAPDY7d/PWsWZ/ahEUtKV2iEx7AIXgFCrrdTZXOwllrCJKk4
         srvp+L2cb/LktGtpfu5JSBX4pUGDwDShUHIN6jCGJTax2V2m5sO22+0vljXw4Iq/w6gS
         37D5Br1I1D8fcOgYJbpfgwUXQUHIkJR1uXMqHp3HyBOylbE5VJaBcF6OAfP34b/tQqgc
         96kCNRXyfTxcMfuE4BxW1kTgICp/XQljEdZ376ffZd3ERJc22tW7BlkXvm0lk6axHOm6
         49Aeeh50xLWdUPqeSyqwi3O10KWRFvU1MD2Baya16XDu9Z9diOwGvkXNmCbFKY/i4+df
         0qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681817547; x=1684409547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SH6qJUfWL9zJ79gRC7zWLV6OUPZJsPitBsnwEKwZJzc=;
        b=QKnhMXOuPC94UW78n4YBU2213ZZkp36inHPqPNvnoyfNtxiyUABT/Ww+FmyepbqcyD
         SzRy3Fp0lc9cCr1oytH+xSS9vf/8/fLhf2e63GGdkxc8FIWoXTYLAYXDz04DDrfSzI6b
         bGFAjztPmqQsVWyiVnQpa1WvX81LOYXcgqXFp+dvL8crcebwuVpwYqEOEbuzdNtRHpih
         BoPmCfUsBFMUXssWLzajBhCdrq4vwGaOgUW6WQkvcmruj1LcyYMOm0nzpJd/hpNJVIG8
         lbHX7E5Hu3L8J6oLcNXcYwKLJx6/a+TF4O8/mqD2Q60kpHCApzkQiYYhbKHHNx2BAojc
         NMmA==
X-Gm-Message-State: AAQBX9dBzGoMTQMIDXVKY/CjwKs91n6hxGrnpm+NxEZ8ueD9Z+8oTXB1
        0w2xTFOz9RcbdU822rvAH5N2uA==
X-Google-Smtp-Source: AKy350aMjaf6xGbP/S2Z5Z9i+emE+iz2bk11Y03Ha/+prgGlprwQ0eo2pRL8eH3nq2LMMAa+9bdzxg==
X-Received: by 2002:a5d:688e:0:b0:2f8:f775:c885 with SMTP id h14-20020a5d688e000000b002f8f775c885mr1543151wru.6.1681817547289;
        Tue, 18 Apr 2023 04:32:27 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id z18-20020adfd0d2000000b002da75c5e143sm12901633wrh.29.2023.04.18.04.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 04:32:27 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (max6639) Add compatible string
Date:   Tue, 18 Apr 2023 13:32:17 +0200
Message-Id: <20230418113217.781524-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230418113217.781524-1-Naresh.Solanki@9elements.com>
References: <20230418113217.781524-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use maxim,max6639 as compatible string for the driver.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/max6639.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 9b895402c80d..ada410bfb7b6 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -618,11 +618,17 @@ MODULE_DEVICE_TABLE(i2c, max6639_id);
 
 static DEFINE_SIMPLE_DEV_PM_OPS(max6639_pm_ops, max6639_suspend, max6639_resume);
 
+static const struct of_device_id max6639_of_match[] = {
+	{ .compatible = "maxim,max6639", },
+	{ },
+};
+
 static struct i2c_driver max6639_driver = {
 	.class = I2C_CLASS_HWMON,
 	.driver = {
 		   .name = "max6639",
 		   .pm = pm_sleep_ptr(&max6639_pm_ops),
+		   .of_match_table = max6639_of_match,
 		   },
 	.probe_new = max6639_probe,
 	.id_table = max6639_id,
-- 
2.39.1

