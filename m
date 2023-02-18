Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC3269B8C0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 09:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBRIdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 03:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjBRIdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:33:03 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D5D42BE1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 00:33:02 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5365a8dd33aso26531997b3.22
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 00:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qjy8cu1Mo/UjSfKWZ07U2cuwjaexJWXy+SB7TrdOfOk=;
        b=f53tiO60I7XJ6TYtB0DYyxwXSpcAe/3+SEcd0gpn65PwjUBmVPmeN9N9fDUOBYx5B4
         +X7KrrUprexujhvtlkEgvIfjbcMWCznLWm9Q2HYqghq4BXq9y2mFTVxVx9jn5Y7y1eaZ
         ffgr0uY71tCr9u2eDrFwAts+aRI1E/vJIOLkcQ91jVmvN1VQrZjcdFFzvqqHIslrdbWF
         zE0iNSA99G7liBZMABYJlwRR+RuoBa0pi01AOq5G9xUZwbkpk56WZEVQz5Dhs1UiItM7
         ns4h02cjsUESNq7Mu34jCsSe1nJzft00ohzoO6r6GKzCXjmwM8yYdk/4KBW9yf2aOPnQ
         Edxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qjy8cu1Mo/UjSfKWZ07U2cuwjaexJWXy+SB7TrdOfOk=;
        b=Dz/LjpEo0lpa62nAwfMfQ3COzt+XGNLzmHodpi/utgV44vPTSjrVk/ovJywE2zwFuy
         CtOui4jb+Z0FYmt1sEb8PWgK24VDsFiD004pG6ekTzQWL5fBtXw/QHYIWZLx3TWE9Iqv
         ccaBCZijN+Scj3lsi41r1sIcF9pDnlkH+lvxWjkUhshaOriiJV32mH2+dvp0gI1AZLYg
         93eiNlX55TSOAwYn21GedpXxZPhJha8VOo/QvOMYR74SIYzS46f8JcYkcLKsmbbYwy63
         XBWP56Wa/TurR5ruwa9dRvKUSLXKtLtGOqdB51QprHKb7sVZkZrPdTwMVqNj2+SSd8AA
         HhXQ==
X-Gm-Message-State: AO0yUKVGB80veUV+39yJqMbBuT699ob+JR1Z9CYs9WlndtZxAQKdtmD8
        6ESe1+0lAUXPpFvMf4PAHj5iFKgfi7LqkmY=
X-Google-Smtp-Source: AK7set+48hgPOTFKTqBSI90PC+RvCcTohAUN+b4zsz5OY4rILu8FJ6rmwMaDGyWWzun7reT7l5xJktc/c1ZgOb4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:382:7632:f7fc:4737])
 (user=saravanak job=sendgmr) by 2002:a5b:688:0:b0:931:2b11:6584 with SMTP id
 j8-20020a5b0688000000b009312b116584mr1169840ybq.591.1676709181337; Sat, 18
 Feb 2023 00:33:01 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:32:49 -0800
In-Reply-To: <20230218083252.2044423-1-saravanak@google.com>
Message-Id: <20230218083252.2044423-3-saravanak@google.com>
Mime-Version: 1.0
References: <20230218083252.2044423-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [RFC v1 2/4] regulator: core: Add sysfs class backward compatibility
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

A regulator device's sysfs directory used to be created under
/sys/class/regulator when it is added to a class. Since the device is
now moved to be under a bus, add symlinks from /sys/class/regulator to
the real device sysfs directory.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/regulator/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1a212edcf216..b6700d50d230 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -43,6 +43,7 @@ static LIST_HEAD(regulator_coupler_list);
 static bool has_full_constraints;
 
 static struct dentry *debugfs_root;
+static struct class_compat *regulator_compat_class;
 
 /*
  * struct regulator_map
@@ -5636,6 +5637,11 @@ regulator_register(struct device *dev,
 	if (ret != 0)
 		goto unset_supplies;
 
+	if (class_compat_create_link(regulator_compat_class, &rdev->dev,
+				     rdev->dev.parent))
+		dev_warn(&rdev->dev,
+			 "Failed to create compatibility class link\n");
+
 	rdev_init_debugfs(rdev);
 
 	/* try to resolve regulators coupling since a new one was registered */
@@ -5702,6 +5708,8 @@ void regulator_unregister(struct regulator_dev *rdev)
 	unset_regulator_supplies(rdev);
 	list_del(&rdev->list);
 	regulator_ena_gpio_free(rdev);
+	class_compat_remove_link(regulator_compat_class, &rdev->dev,
+				 rdev->dev.parent);
 	device_unregister(&rdev->dev);
 
 	mutex_unlock(&regulator_list_mutex);
@@ -6107,7 +6115,13 @@ static int __init regulator_init(void)
 {
 	int ret;
 
+	regulator_compat_class = class_compat_register("regulator");
+	if (!regulator_compat_class)
+		return -ENOMEM;
+
 	ret = bus_register(&regulator_bus);
+	if (ret)
+		goto unreg_compat;
 
 	debugfs_root = debugfs_create_dir("regulator", NULL);
 	if (!debugfs_root)
@@ -6120,11 +6134,16 @@ static int __init regulator_init(void)
 	debugfs_create_file("regulator_summary", 0444, debugfs_root,
 			    NULL, &regulator_summary_fops);
 #endif
+
 	regulator_dummy_init();
 
 	regulator_coupler_register(&generic_regulator_coupler);
 
 	return ret;
+
+unreg_compat:
+	class_compat_unregister(regulator_compat_class);
+	return ret;
 }
 
 /* init early to allow our consumers to complete system booting */
-- 
2.39.2.637.g21b0678d19-goog

