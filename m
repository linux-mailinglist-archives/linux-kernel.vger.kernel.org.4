Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5F869B8C1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 09:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjBRIdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 03:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjBRIdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:33:05 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E061547432
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 00:33:04 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5367836c7e1so5418237b3.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 00:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+eMvh/5RpB1yBDTApxHgHfIOTnGW3OoKdzhdswhPdc8=;
        b=IBwqlFD+FCaDqWg/idHuaAxR0CYrFVJMbtxMjDSvmEkNhayk8QbmlvNJQNqxg+alsM
         ZvC/mNmTjTx1Rbw1rctbABzwis4tAMyEDJwLoZrHPxngikDinW09R+TTuLG/2vWGLYQg
         9T67C6HKuhhJHJQ0szi2JKR1/BxRvaw5zELhdmSWxcTbM846z2AHMpjIBLEKBqiQF1ns
         tQzQ5EBuAClKshZu3NT4MOAPtPQiEKgCwXBlT0OGTqyX0FoIWqHVUGy9lUN0Mf40iWcO
         UVhio5dw3Jr3hrTFlgm26scaAUGjdEGwTps4agz0k6HbkE47VOdhQFyCO+srFRnt/E6v
         45ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+eMvh/5RpB1yBDTApxHgHfIOTnGW3OoKdzhdswhPdc8=;
        b=A2uvypY4LhLBSQUFfd2j/p1WfL2xeLZpYJv4goWYtQI0madhyzgD0+Te2k4Z/WOpcO
         4Su/BegTiC+z7FBsJVmtoRBi0la5i12AvB8MRomQy6PPnkP3OBvz9/S6KZzKevB0xw71
         msUfGgdb5YgEgGFVqudXklXR172COMuujLi4pAaGwNKP6rJw8Fe+W8Lg6mx9n7g1Ca9d
         zZcipQgDRmVs8M/J5OR7Hv+xqIN+V3lYQiwMNUCIxhMN3nci9gjb5wYxAk8M3Xh1iDrI
         T/pt40OENXhQkiIbrJ4VU3hzeyaQeI8b62K+bHNqDhObapzFZ0CWKkygYyxFXgkh/l9n
         Cl6g==
X-Gm-Message-State: AO0yUKXK5hAPyIh7WkekOC+AfaamkOocB8sNouQk89w9/mkTKaSkDt8j
        gCgZ9NuTDbEA1MceJl3BOlQoJWrOzU8sLaQ=
X-Google-Smtp-Source: AK7set9hRgiEvFBiFppHL8eT54ybwc2hZv7z3Blb0CFN5CcOP1YQbX8QCulFE4e/SFDWs0v35PqiJF0QK13gDmk=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:382:7632:f7fc:4737])
 (user=saravanak job=sendgmr) by 2002:a81:ca03:0:b0:52e:fb7a:94b7 with SMTP id
 p3-20020a81ca03000000b0052efb7a94b7mr349890ywi.7.1676709184201; Sat, 18 Feb
 2023 00:33:04 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:32:50 -0800
In-Reply-To: <20230218083252.2044423-1-saravanak@google.com>
Message-Id: <20230218083252.2044423-4-saravanak@google.com>
Mime-Version: 1.0
References: <20230218083252.2044423-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [RFC v1 3/4] regulator: core: Probe regulator devices
From:   Saravana Kannan <saravanak@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since devices added to a bus can be probed, add a stub probe function
for regulator devices.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/regulator/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b6700d50d230..d5f9fdd79c14 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5780,6 +5780,17 @@ static const struct dev_pm_ops __maybe_unused regulator_pm_ops = {
 };
 #endif
 
+static int regulator_drv_probe(struct device *dev)
+{
+	return 0;
+}
+
+static struct device_driver regulator_drv = {
+	.name = "regulator_drv",
+	.bus = &regulator_bus,
+	.probe = regulator_drv_probe,
+};
+
 struct bus_type regulator_bus = {
 	.name = "regulator",
 	.remove = regulator_dev_release,
@@ -6123,6 +6134,10 @@ static int __init regulator_init(void)
 	if (ret)
 		goto unreg_compat;
 
+	ret = driver_register(&regulator_drv);
+	if (ret)
+		goto unreg_bus;
+
 	debugfs_root = debugfs_create_dir("regulator", NULL);
 	if (!debugfs_root)
 		pr_warn("regulator: Failed to create debugfs directory\n");
@@ -6141,6 +6156,8 @@ static int __init regulator_init(void)
 
 	return ret;
 
+unreg_bus:
+	bus_unregister(&regulator_bus);
 unreg_compat:
 	class_compat_unregister(regulator_compat_class);
 	return ret;
-- 
2.39.2.637.g21b0678d19-goog

