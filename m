Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45A3708643
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjERQyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjERQyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:54:20 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5C9F0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:54:18 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-33823abc8a4so5753945ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684428858; x=1687020858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hns3eB+dK6OUYRCN59KV1HcPfgZvWD8joXdIhh2NbIk=;
        b=mh4OZhY6J5bK031y9LdeMq8+QkD8dalo6QvVLeyulTCvPtbUr5GIuE54JDCrC3Jigh
         +w9DjtEHZ2K+OXJbvUwHvEtF/1MenCop7h5Ib8gbmbzMb9gfVoe481+6xnIzahC01MjR
         cEw7wqEX7eH2ms2R0Uu40m2tCy5+9gNz2nMfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684428858; x=1687020858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hns3eB+dK6OUYRCN59KV1HcPfgZvWD8joXdIhh2NbIk=;
        b=ZaEZDoxN6r8bMSRb5IeqdaEy8VDxwFKnqE/OZK0AeIOLlve202S2dGtVIf+YCn0oB5
         wXIiOpvJs1abQi6Ocrf5YrSiuBDl8tsQ0W7Mf0rloWrtMACkup/QMHzWYT286grrzPrp
         43wQ6ujji0jZtSlqdHuR4qgOhUSMuVa+EHxOxk8l7BDH4G1CaurDD7pjnf85wQJAI3f+
         SDV6FYSpXlnIzrlPJfsKc5Wg1kpSU1WVePOOuE4fyqUBAKpQu50WfBqTMC6MP7gP9QM1
         18hBmdnPqZ8fDKnhT7tmj2YLyuWiZ2WB3eSQOxMAKbpBejZGohmoHmivfJzva1FNXccc
         r5sQ==
X-Gm-Message-State: AC+VfDwy4jwb2vs6UjubZG8wL/ZgJ4jK51VKWBYIH3cSfLsIB1obcCEO
        EjMtk2HYULwx3uJVfeURQtFpozevuWP+R636h0ehjw==
X-Google-Smtp-Source: ACHHUZ6asBJ4DVdLm8uFK9WkJNqcfxmcBa06CuGzbApVaHfyEHHyOIA4gO4mpgEhNtMhBZKDroAS4A==
X-Received: by 2002:a92:d18b:0:b0:331:2e7b:9efa with SMTP id z11-20020a92d18b000000b003312e7b9efamr4642506ilz.19.1684428857898;
        Thu, 18 May 2023 09:54:17 -0700 (PDT)
Received: from timvp-p620-9115096.bld.corp.google.com ([2620:15c:183:200:4397:b281:ed71:b174])
        by smtp.gmail.com with ESMTPSA id k42-20020a056638372a00b0041675393f68sm572779jav.6.2023.05.18.09.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:54:17 -0700 (PDT)
From:   Tim Van Patten <timvp@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     rrangel@chromium.org, robbarnes@google.com, lalithkraj@google.com,
        Tim Van Patten <timvp@chromium.org>,
        Tim Van Patten <timvp@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] [v10] platform/chrome: cros_ec_lpc: Move host command to prepare/complete
Date:   Thu, 18 May 2023 10:54:04 -0600
Message-ID: <20230518165408.1909613-1-timvp@chromium.org>
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

Additionally, if the EC monitors the AP's suspend/resume process with a
watchdog, this change allows the EC to cover more of the suspend/resume
process to detect any possible hang conditions and initiate error
recovery if it's implemented.

---


Changes in v10:
- Update commit message

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

Signed-off-by: Tim Van Patten <timvp@chromium.org>
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: Tim Van Patten <timvp@google.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index ba4e3bff3db46..4e5a83a9936cd 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -519,23 +519,25 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
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

