Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025B05B8C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiINPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiINPqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:46:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31A1402D5;
        Wed, 14 Sep 2022 08:46:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z21so22894296edi.1;
        Wed, 14 Sep 2022 08:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3fEMqwu/7m90JA2rCJpdghe2lX/otH8/FVwJWzq7lZI=;
        b=Bi5D09J/lLGHBY4iPgk0h2oeeBJsx+4978gcV1ZbotADTkfIU/amTDzNXVoRQF7niK
         mHN0dYxP4embLRUbQVK1aJdR9QgN41NawraAs7UPykJFiut3sCT3X6WUCBXgVwhUZVmG
         IqiT0oKLAT78NqtUO/27vEq91VvEu5sqizzfwoFmJCy9M6ES/ggeoiflelyjL+NDqz8F
         +S3E7gCYYIS9MT5QjUvWm/rOgRStQ2Y2l0DieRJo4wVB2xNxbym6QZi5A31NCKj7Y2Qf
         nF9I4GbnuZcm+7dBHCAVTMV4W+d4auf4up+xB3e1kWB7Xj52MQMOJRCkYJoRxrDFdc1t
         yrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3fEMqwu/7m90JA2rCJpdghe2lX/otH8/FVwJWzq7lZI=;
        b=DAikOIFP2TDzbyb/j8iH1IHQmLtAjIpzzd/UfR5ph7kpH77pGH8SkouLUGlZBbilqI
         YOPTVVQ799ogcY7rnhB7onlwE7KwO4Si+22LwuCrh3wY809EtWzFMCMmmQWYW4YM26ug
         Kb8GTJMrfgzBe0xhexoXfKJT6zbzfHcsIOdLQfSDTjC8727lEdUOxqxoOjMnbjhGhE66
         d3KhoQK8Chxk4vmEzOUptxYlNN6w393W/bKBsAcm7hYPGAcdqvr7vxfhaEmmFnYZfdZ4
         eZ0QY1LG0mV+bVnnLgk8NuJ09x074GxPfVKgbzNxGBwkcKw5/v0IHjsCoh7/HwPjDXW8
         uydg==
X-Gm-Message-State: ACgBeo1xnQqe2zy7V25IGxi5eLj6hTwQxsaqGJYMiSHxxCo+f8FuM6yx
        B7i1Jecldgux/P9zLLpM+6nFqJ+IFSI=
X-Google-Smtp-Source: AA6agR77XX86RsKcQFSsUFOux7rHsaN4yizVGgXqITU9r0+livb/E1zqr6/mtHFy3iuvb+btiJx1rg==
X-Received: by 2002:aa7:d703:0:b0:44e:a7b9:d5bd with SMTP id t3-20020aa7d703000000b0044ea7b9d5bdmr31096347edq.425.1663170401917;
        Wed, 14 Sep 2022 08:46:41 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id u18-20020a1709061db200b0077077c62cadsm7800849ejh.31.2022.09.14.08.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:46:41 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH v2 2/2] thermal: qcom: tsens: simplify debugfs init function
Date:   Wed, 14 Sep 2022 17:46:35 +0200
Message-Id: <20220914154635.2928-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914154635.2928-1-ansuelsmth@gmail.com>
References: <20220914154635.2928-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify debugfs init function.
- Add check for existing dev directory.
- Fix wrong version in dbg_version_show (with version 0.0.0, 0.1.0 was
  incorrectly reported)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
---
v2:
- Change sob tag with new name

 drivers/thermal/qcom/tsens.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index cc2965b8d409..ff82626cecef 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -692,7 +692,7 @@ static int dbg_version_show(struct seq_file *s, void *data)
 			return ret;
 		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
 	} else {
-		seq_puts(s, "0.1.0\n");
+		seq_printf(s, "0.%d.0\n", priv->feat->ver_major);
 	}
 
 	return 0;
@@ -704,21 +704,17 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
 static void tsens_debug_init(struct platform_device *pdev)
 {
 	struct tsens_priv *priv = platform_get_drvdata(pdev);
-	struct dentry *root, *file;
 
-	root = debugfs_lookup("tsens", NULL);
-	if (!root)
+	priv->debug_root = debugfs_lookup("tsens", NULL);
+	if (!priv->debug_root)
 		priv->debug_root = debugfs_create_dir("tsens", NULL);
-	else
-		priv->debug_root = root;
 
-	file = debugfs_lookup("version", priv->debug_root);
-	if (!file)
+	if (!debugfs_lookup("version", priv->debug_root))
 		debugfs_create_file("version", 0444, priv->debug_root,
 				    pdev, &dbg_version_fops);
 
 	/* A directory for each instance of the TSENS IP */
-	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
+	priv->debug = debugfs_lookup(dev_name(&pdev->dev), priv->debug_root);
 	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
 }
 #else
-- 
2.37.2

