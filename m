Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE480700DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbjELRgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238074AbjELRgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:36:15 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6B91718
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:36:14 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-76c4bb969faso144574739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683912974; x=1686504974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv93mD4EqgevAcbmXFwBEuOtcFUngrr1N34sRRE8Vrc=;
        b=j7G/Qmbnl1GQ4XKXwMPUQWnqEOJTgGl/6VXphk6Aep1ie7bohp2Yd0m0/17ukdnLA4
         hEqP86t5/V6sa/V7fBVxzuzBodutbB9tizsiLXOwNIzVrH1Qlc+9trVgXFWLUdA12jH6
         PaTs5gL3KFDjTqbz319EEmex/ReXbUNgVIspg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683912974; x=1686504974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yv93mD4EqgevAcbmXFwBEuOtcFUngrr1N34sRRE8Vrc=;
        b=TasNyzPJ4ZHI4om+z5InTm2el0lYANr9wY0BSwAX3ctbRokxlXGmlhEm5U/cqLhYla
         3c9jSKLctGBbbCpWoQmTPiKky4NogBU93Cust6iJINn844mvkY/WTTQw9a+gsNbsDcCo
         k58P0SF/tD4giGNHIyrx498J5SvbpLR03A8TpvM7UqAfLDW0kqt0LqM8yfvlVFarx4U8
         FeeGTq7v9OFiOYlpUX/ZQ4r0CjRJ2ydVC6CFSB+xn/Y+vVsr08SLsvNe+cUYzehGWYZY
         j8g37VpK4wrmQ2vqg8uwyKwSL5b6AgIMcqkNErVN5QwK4jeUJ90yb/2Fyhj7zDboTU38
         i7kA==
X-Gm-Message-State: AC+VfDxvYCjrnFI/ZNo9RVOiEG5NHyRC7Nlfyh7mfq/9NUJuGAn7p9XH
        qLd8cBux2Yoz0158G0X2mOr81W6H/FLDsxuOugLREg==
X-Google-Smtp-Source: ACHHUZ6w2z4/ld2w4Bdvbl0Jrn/6Di4lmq7Mlj4FsXXe/Na6XKeaYNv5VJi/SQgnD2yUC1oNLk7Nig==
X-Received: by 2002:a6b:dd15:0:b0:76c:65df:a118 with SMTP id f21-20020a6bdd15000000b0076c65dfa118mr7954998ioc.6.1683912973867;
        Fri, 12 May 2023 10:36:13 -0700 (PDT)
Received: from timvp-p620-9115096.bld.corp.google.com ([2620:15c:183:200:424a:848:d237:b7d3])
        by smtp.gmail.com with ESMTPSA id a2-20020a6b6602000000b0076c750dc780sm1525856ioc.29.2023.05.12.10.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 10:36:13 -0700 (PDT)
From:   Tim Van Patten <timvp@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     lalithkraj@google.com, robbarnes@google.com, rrangel@chromium.org,
        Tim Van Patten <timvp@chromium.org>,
        Tim Van Patten <timvp@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH] platform/chrome: cros_ec_lpc: Move host command to prepare/complete
Date:   Fri, 12 May 2023 11:35:57 -0600
Message-ID: <20230512113556.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Tim Van Patten <timvp@google.com>
---

 drivers/platform/chrome/cros_ec_lpc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 68bba0fcafab3..93820654a555b 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -543,23 +543,31 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
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
2.40.1.606.ga4b1b128d6-goog

