Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15899607E38
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiJUST3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiJUSTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:19:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C3F297;
        Fri, 21 Oct 2022 11:19:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bk15so6194242wrb.13;
        Fri, 21 Oct 2022 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Te2D+O/dmhyY7I6GW0ko5spH0/ons5hMu2IA6w5aW0Y=;
        b=lEDT/zllJSBCa52U0EqXXG+BfRl7bIUFw43JqFvqrmx5IxDDM19hy3BOuuW2pc4P6W
         kQ6OnZV3kmY1ggTCIn0jIgtk6jZ2flR1Afug+i5A3Hqyw9nE6omwimaP3mJybAAwIWfF
         SbELbG8bz8QypD+nnKXhVb11cm/ivslvjlB3eNtyhu6rCYvs7wFx/NMoErt+b/ah4rfz
         Tfiw4E+UIWFTaSd0AIZzqiGCy7bO+HrdMIYq+rqVhaoF6f+arYbmVetVxvEE8wrIEQYV
         WYMA43sGyr+sdrKuI9jvMzu2HILFNYwTMiOiKMukwzvhCNvpFq6ik9Ii0CdgZMkRzJHp
         NgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Te2D+O/dmhyY7I6GW0ko5spH0/ons5hMu2IA6w5aW0Y=;
        b=d3coe1MZqfRDgaPzga5qh7mtqi8R8gST3vUUaOs//0L6qNXFFsTuT1Jn2fs7LZoruy
         0T2iIFYxaOlfGDY75wOpcDWTukgI08R4X4PCCEA3TMuQ0rUOIBE0bJuOc1Mz5IHeKTcw
         cv/IEBA+7Z8BUrpstFrXf9ATbFlYdamnnw3jjAyR1dAoIPfduOQDFlMynzJbmKSAS38h
         VeXGDbQ+CGANUj+CZYtWC/CgOdJtqszrCJ7CTQU6OjVQppgVJAJdKItorlIVW5KMqryY
         Bw7IvwJw8ruVkzq6JJGauibdfnAt6vv4RBcf1/q3MAcF9AfNA++xckpKOpVh7pFGs6u0
         m9mA==
X-Gm-Message-State: ACrzQf3/BDhw8k8KcOENzA46kLQFoV0J12O2qNOtXuvn6OlkoP/yvOSv
        WWgGRFL5YXoV4QrVgcn2GXI=
X-Google-Smtp-Source: AMsMyM5tCVvm7H98qVCWlorWfA70mZvkDIx69S+m9jgI37Ler28IZemd0y1ydu3QmpT42dgn5NPS4g==
X-Received: by 2002:a5d:4ac1:0:b0:235:ef61:68ba with SMTP id y1-20020a5d4ac1000000b00235ef6168bamr6620408wrs.316.1666376357805;
        Fri, 21 Oct 2022 11:19:17 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id j8-20020a05600c1c0800b003c6b7f5567csm11157313wms.0.2022.10.21.11.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 11:19:17 -0700 (PDT)
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
Subject: [RESEND PATCH 2/2] thermal: qcom: tsens: simplify debugfs init function
Date:   Fri, 21 Oct 2022 20:19:06 +0200
Message-Id: <20221021181906.16647-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221021181906.16647-1-ansuelsmth@gmail.com>
References: <20221021181906.16647-1-ansuelsmth@gmail.com>
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

Simplify debugfs init function.
- Add check for existing dev directory.
- Fix wrong version in dbg_version_show (with version 0.0.0, 0.1.0 was
  incorrectly reported)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
---
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

