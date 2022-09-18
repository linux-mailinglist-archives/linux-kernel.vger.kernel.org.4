Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CD45BBE76
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 16:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiIROhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 10:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiIROgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:36:48 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C25220EC
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:36:46 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 3so18565051qka.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=u9zxwUyjTnHb6dXIFQytfA/XLHMka2VsioSd5KiJT2E=;
        b=RY2Mr3NDbqAgsjX3zKMzgwQjcbJ72qukf8T92w9gtIFCtbkwlRlkaXaPVmEcz3hgRE
         cFwJ3ed38oAz2AC0a2DjY3BAzdNj4OXNDY4iuFyJNxwC7NxmlOpcJcFZ5SQr7GpIkUQJ
         XL11dqieC0VWaPPC/wKCTivFfnaPWl6CwDpNFLUVz2GKqmr5COcWESV6ENYAhzlzgqVC
         wA/6l400tjUBURU4+BGZ87Dpg5oo7OGLErGMgBVvVlURnfRxWERv8HH+zKFIl5hBhbVg
         j7Hj+oFVgGvFKDh7AACiVqY+WGkx9vgXrDGTLXgGL2XMySFW8zPXj5HjgrkekYtKutf4
         ouWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=u9zxwUyjTnHb6dXIFQytfA/XLHMka2VsioSd5KiJT2E=;
        b=TDSQpmpPcC3CDrCZ7OAMZezjDv6ZmVP8gMLZLN1Bhn+jMOByHnG2HGkczc5C9q+HCz
         ZRBRQ5EhBanU+yTe3UYk5ycblIQybuaAtZ1JatbK3kDBNK43QJBnlHSvxgWrv1nx8iKf
         2f8OG1pRVZo1lLsgE88qmY1xTk8zNI+e13EOyMjivEnz183YEofAWhJk+2ZBkCyOKcyn
         rjDuyA/7u9lT2mmgSskrwLmsDG48ERh5cMh1QVRPEG3206nibQN+IXeWDLZf3EkgkaQX
         MA25CZhLqbQ64xI7MFS8RSilLVAYrpfP2pu+7fAeAegusiL04mCUyoRHBMfnqR72pJ+l
         8Mvw==
X-Gm-Message-State: ACrzQf3WN7ROssQbRdaFEE1j+oc2xPQp20vqESBJAV+C/WbH/gJkpSMu
        NodNMBplu+RT/dBZF1/B0Haxsg==
X-Google-Smtp-Source: AMsMyM6HllhhFSEheppcL+yu/C1Uoet8wvrjV8iLcVLIyoJRks+syjJK/GNqjbyUW8i0odyAE2ZxgA==
X-Received: by 2002:ae9:f302:0:b0:6bc:c42:e80d with SMTP id p2-20020ae9f302000000b006bc0c42e80dmr10389336qkg.426.1663511805488;
        Sun, 18 Sep 2022 07:36:45 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q31-20020a05620a2a5f00b006bb0e5ca4bbsm11456215qkp.85.2022.09.18.07.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 07:36:45 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 3/4] counter: Consolidate Counter extension sysfs attribute creation
Date:   Sun, 18 Sep 2022 10:36:33 -0400
Message-Id: <8c508570e1a2accc0d55abcae4cd508883952ec8.1663511054.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663511054.git.william.gray@linaro.org>
References: <cover.1663511054.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Counter extensions are handled for the Device, Counts, and Signals. The
code loops through each Counter extension and creates the expected sysfs
attributes. This patch consolidates that code into functions to reduce
redundancy and make the intention of the code clearer.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/counter-sysfs.c | 98 ++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 92d3d4f549cb..7ce7c51395da 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -591,6 +591,46 @@ static int counter_comp_id_attr_create(struct device *const dev,
 	return 0;
 }
 
+static int counter_ext_attrs_create(struct device *const dev,
+				    struct counter_attribute_group *const group,
+				    const struct counter_comp *const ext,
+				    const enum counter_scope scope,
+				    void *const parent, const size_t id)
+{
+	int err;
+
+	/* Create main extension attribute */
+	err = counter_attr_create(dev, group, ext, scope, parent);
+	if (err < 0)
+		return err;
+
+	/* Create extension id attribute */
+	return counter_comp_id_attr_create(dev, group, ext->name, id);
+}
+
+static int counter_sysfs_exts_add(struct device *const dev,
+				  struct counter_attribute_group *const group,
+				  const struct counter_comp *const exts,
+				  const size_t num_ext,
+				  const enum counter_scope scope,
+				  void *const parent)
+{
+	size_t i;
+	const struct counter_comp *ext;
+	int err;
+
+	/* Create attributes for each extension */
+	for (i = 0; i < num_ext; i++) {
+		ext = &exts[i];
+		err = counter_ext_attrs_create(dev, group, ext, scope, parent,
+					       i);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static struct counter_comp counter_signal_comp = {
 	.type = COUNTER_COMP_SIGNAL_LEVEL,
 	.name = "signal",
@@ -604,8 +644,6 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	struct counter_comp comp;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Create main Signal attribute */
 	comp = counter_signal_comp;
@@ -619,21 +657,9 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	if (err < 0)
 		return err;
 
-	/* Create an attribute for each extension */
-	for (i = 0; i < signal->num_ext; i++) {
-		ext = &signal->ext[i];
-
-		err = counter_attr_create(dev, cattr_group, ext, scope, signal);
-		if (err < 0)
-			return err;
-
-		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
-						  i);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
+	/* Add Signal extensions */
+	return counter_sysfs_exts_add(dev, cattr_group, signal->ext,
+				      signal->num_ext, scope, signal);
 }
 
 static int counter_sysfs_signals_add(struct counter_device *const counter,
@@ -718,8 +744,6 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	struct counter_comp comp;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Create main Count attribute */
 	comp = counter_count_comp;
@@ -742,21 +766,9 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	if (err < 0)
 		return err;
 
-	/* Create an attribute for each extension */
-	for (i = 0; i < count->num_ext; i++) {
-		ext = &count->ext[i];
-
-		err = counter_attr_create(dev, cattr_group, ext, scope, count);
-		if (err < 0)
-			return err;
-
-		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
-						  i);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
+	/* Add Count extensions */
+	return counter_sysfs_exts_add(dev, cattr_group, count->ext,
+				      count->num_ext, scope, count);
 }
 
 static int counter_sysfs_counts_add(struct counter_device *const counter,
@@ -849,8 +861,6 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	const enum counter_scope scope = COUNTER_SCOPE_DEVICE;
 	struct device *const dev = &counter->dev;
 	int err;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Add Signals sysfs attributes */
 	err = counter_sysfs_signals_add(counter, cattr_group);
@@ -887,19 +897,9 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	if (err < 0)
 		return err;
 
-	/* Create an attribute for each extension */
-	for (i = 0; i < counter->num_ext; i++) {
-		ext = &counter->ext[i];
-
-		err = counter_attr_create(dev, cattr_group, ext, scope, NULL);
-		if (err < 0)
-			return err;
-
-		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
-						  i);
-		if (err < 0)
-			return err;
-	}
+	/* Add device extensions */
+	return counter_sysfs_exts_add(dev, cattr_group, counter->ext,
+				      counter->num_ext, scope, NULL);
 
 	return 0;
 }
-- 
2.37.3

