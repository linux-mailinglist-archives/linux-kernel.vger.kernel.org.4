Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32D1611E06
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJ1XTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ1XS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:18:59 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46A4247E17
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:18:58 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h18so3717474ilq.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bn9D9kuzB0NhBMRKYFistkOXIvTNO5wPVqxp1zHUjc8=;
        b=WojazKC0d63LVfJ/T+T2JiU6FUu4WAxWNzgr8bbMShpYRjsGvJLOX6FM6Ll0XdyqyG
         KoQ/0QbAQHAoVz5AkhHQFPWE60wFseeOcgVxlRT0GFls7wg4LezmfYXe6elg7TdUg3kh
         VLGjbqmT2QLCJq6AdnqiRSuB8WZnrcY4DRnXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bn9D9kuzB0NhBMRKYFistkOXIvTNO5wPVqxp1zHUjc8=;
        b=WqrGGVIdOg7pPwyqsuIWgW5jX2THo/87F0x1Sh4JWzDzopi+fXgbmOZ4F2VV9m+LqK
         QbEpRWRK8d1Np8Xfzj9hsfHg1ObFmWglYPmhPKQWnD1+5pmjgBPqL86z3TCZd1Gqu03o
         f0UBSYC1YjDJUj4hA6xROkquAeT69Dvq6vwGGs3UH+5QPk0csdcelABqfjccnjaIlVLE
         TWgC3bVtsxfFcQdCTv4+4b85aeb9qq2JNGA41nzo+TgolXFPns6tnkgivHh/za8OHMfh
         ATQDMHiCnj7ZLQneehRu5zzOOPDzkNnNdpFL6+UC+QEIo3li2xfUTXgLw/x3hstr0nEa
         bGZg==
X-Gm-Message-State: ACrzQf34QL3RmkLRlYEW7rKG4UOI0mYpG6mGTKUhFYMRFIhA8Wern1qc
        HUNgxe/hmNxLIaoIAhUDLO1ewA==
X-Google-Smtp-Source: AMsMyM5I/UiaH28bV/RZ17OwbrA3rYeBNyGNSjKjgnnoNH201C6V1iLEKWvXR4T1aFgB1x15UAFjbQ==
X-Received: by 2002:a05:6e02:1c44:b0:2ff:c897:de3c with SMTP id d4-20020a056e021c4400b002ffc897de3cmr869564ilg.59.1666999138068;
        Fri, 28 Oct 2022 16:18:58 -0700 (PDT)
Received: from timvp-p620-9115096.bld.corp.google.com ([2620:15c:183:200:d811:d631:c956:7aba])
        by smtp.gmail.com with ESMTPSA id w15-20020a056602034f00b006cad30ad430sm1555iou.23.2022.10.28.16.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 16:18:57 -0700 (PDT)
From:   Tim Van Patten <timvp@chromium.org>
To:     rrangel@chromium.org, robbarnes@google.com
Cc:     Tim Van Patten <timvp@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v8] platform/chrome: cros_ec_lpc: Move host command to prepare/complete
Date:   Fri, 28 Oct 2022 17:18:34 -0600
Message-Id: <20221028171820.v8.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
.prepare() and cros_ec_lpc_complete() during .complete(). This moves the
host command that the AP sends and allows the EC to log entry/exit of
AP's suspend/resume more accurately.

Signed-off-by: Tim Van Patten <timvp@chromium.org>
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
---

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

 drivers/platform/chrome/cros_ec_lpc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 7677ab3c0ead9..4158bdeee197b 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -530,23 +530,31 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 MODULE_DEVICE_TABLE(dmi, cros_ec_lpc_dmi_table);
 
 #ifdef CONFIG_PM_SLEEP
-static int cros_ec_lpc_suspend(struct device *dev)
+static int cros_ec_lpc_prepare(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
 
+	dev_info(dev, "Prepare EC suspend\n");
+
 	return cros_ec_suspend(ec_dev);
 }
 
-static int cros_ec_lpc_resume(struct device *dev)
+static void cros_ec_lpc_complete(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = cros_ec_resume(ec_dev);
 
-	return cros_ec_resume(ec_dev);
+	dev_info(dev, "EC resume completed: ret = %d\n", ret);
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
2.38.1.273.g43a17bfeac-goog

