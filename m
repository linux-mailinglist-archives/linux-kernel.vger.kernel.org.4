Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9DF703E98
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245150AbjEOU0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbjEOU0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:26:12 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C01E6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:26:11 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-32c83c66b1cso93239585ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684182370; x=1686774370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WtsdvTBA3WKi5YHrPj2RYjpUUqiBU6dPu45EYIw0z5Y=;
        b=NWhH4DpGt8VieswRPgRtgtYvAFGYENdIDHcSwOZhy/E1vflMfs4Pu1fe5X2inS1d76
         ZBQn2oTBbqmofMRUMFYcT8dpsqyBEfqeyM9Mb8lqdrAAOnEBee5fWKoCRIHUmJ58OcFI
         yF2nm5/e+q8LA0gqzHW6q2lfWIprZKROilJsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684182370; x=1686774370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtsdvTBA3WKi5YHrPj2RYjpUUqiBU6dPu45EYIw0z5Y=;
        b=addlq7JrIh4ZcuBIrsGT5OY1ta+UaoB24YmQLW9e+VzafgSiq1CvbCXKcB4f6neGVf
         f8cXePsZyGDisWfOyU3I4fV0W/U6PBM5mW7+rEgllXh9bFhtprpYTGDexYW48nLBpY/M
         5M1Chby2GGofit9NlnJJdP0TLr6P64ziHZmEbC0QAWB9Fpi8O0/zTMzamArnuHGsVU5j
         4OKShzwqLBdNn54W5ElDz4zk4MQbOlq62MACB0kRvGpwxwrgyeYNZmF5a27fiTeUp18l
         ZIH/+TP2NVt2JstgSIKSGSvnaevGXLV4AaYZ8KXNod20U7PitG2Olj2YrbaMAwZps42D
         TG9w==
X-Gm-Message-State: AC+VfDyVdPxB4zPFVYeCjIFHQfRjt0vV8yE5XPMhsRMGzo9hA5gvczQe
        xzlWVvfNkf3UnlvdfV44Kin0JXFQfCimHVNp8em7Pg==
X-Google-Smtp-Source: ACHHUZ4ir542iMVtI2Ji0s7aVVlQ1Rk/0NZdCKmBmOb1sZyQTr9SzKBI8PYLm5fOC4B+AtOCVUAKEA==
X-Received: by 2002:a92:d403:0:b0:326:3a39:89d0 with SMTP id q3-20020a92d403000000b003263a3989d0mr22977766ilm.1.1684182370715;
        Mon, 15 May 2023 13:26:10 -0700 (PDT)
Received: from timvp-p620-9115096.bld.corp.google.com ([2620:15c:183:200:f061:bf7d:2f95:2b91])
        by smtp.gmail.com with ESMTPSA id cb9-20020a0566381b0900b0041669a9fb62sm6296296jab.131.2023.05.15.13.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 13:26:10 -0700 (PDT)
From:   Tim Van Patten <timvp@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     robbarnes@google.com, lalithkraj@google.com, rrangel@chromium.org,
        Tim Van Patten <timvp@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH] [v9] platform/chrome: cros_ec_lpc: Move host command to prepare/complete
Date:   Mon, 15 May 2023 14:25:52 -0600
Message-ID: <20230515142552.1.I17cae37888be3a8683911991602f18e482e7a621@changeid>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
.prepare() and cros_ec_lpc_complete() during .complete(). This moves the
host command that the AP sends and allows the EC to log entry/exit of
AP's suspend/resume more accurately.

Changes in v9:
- Remove log statements.
- Ignore return value from cros_ec_resume().

Changes in v8:
- Resend with chromium.org account.
- No code changes.

Changes in v7:
- Rename "host event" to "host command" in title/description.

Changes in v6:
- Fully restore fixes from v3.

Changes in v5:
- Restore fixes from v3.

Changes in v4:
- Update title and description.

Changes in v3:
- Update cros_ec_lpc_suspend() to cros_ec_lpc_prepare()
- Update cros_ec_lpc_resume() to cros_ec_lpc_complete()

Changes in v2:
- Include cros_ec_resume() return value in dev_info() output.
- Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.

Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: Tim Van Patten <timvp@chromium.org>
---

 drivers/platform/chrome/cros_ec_lpc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 68bba0fcafab3..2318eccd9c6ad 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -543,23 +543,25 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 MODULE_DEVICE_TABLE(dmi, cros_ec_lpc_dmi_table);
 
 #ifdef CONFIG_PM_SLEEP
-static int cros_ec_lpc_suspend(struct device *dev)
+static int cros_ec_lpc_prepare(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
 
 	return cros_ec_suspend(ec_dev);
 }
 
-static int cros_ec_lpc_resume(struct device *dev)
+static void cros_ec_lpc_complete(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
-
-	return cros_ec_resume(ec_dev);
+	cros_ec_resume(ec_dev);
 }
 #endif
 
 static const struct dev_pm_ops cros_ec_lpc_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend, cros_ec_lpc_resume)
+#ifdef CONFIG_PM_SLEEP
+	.prepare = cros_ec_lpc_prepare,
+	.complete = cros_ec_lpc_complete
+#endif
 };
 
 static struct platform_driver cros_ec_lpc_driver = {
-- 
2.40.1.606.ga4b1b128d6-goog

