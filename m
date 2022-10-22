Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A2608D4E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 14:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJVM51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 08:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJVM5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 08:57:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190A822B7AE;
        Sat, 22 Oct 2022 05:57:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m15so15295125edb.13;
        Sat, 22 Oct 2022 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfeD3Vie7kg8iBMU4bkz+AYFFromxwoh/hIWgeFhX/4=;
        b=C25zegeG71PPfAEE2c+D+wLiz7zAx/3KhgWHknRipTMUBTCQNNzbai4ngRH7syML4C
         Zoi7cwUtl1Gcs3mLf8u2nEd42RZ6TmKYokdY9wce00/FXONAg6+ePfxMI3yKrl0ihnlv
         jBLDEF6ADT65ExUTwIuaQPj2IFXIIUpfWtFIYhqikSsg095U4mGRVwz6Bqkmb3OxrDYQ
         wDzdhqmHcdgUpbVRwswZOMknMJAkcjQ4vUf+xFOs86VNIxRiBf9WEEgl63FDSd2PUJrZ
         eNQ5HVioybp84avkdM3PrK0nT8qNvtMBTnK3eqS/eaI8+2hiUt6bNL/tbSA/1B9ftySj
         Hgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfeD3Vie7kg8iBMU4bkz+AYFFromxwoh/hIWgeFhX/4=;
        b=D8FFlbr+vaSoZjACpxYxOp/yOu1uW3BnB95l9/RENgQhdD2j8lVqSPum2U2nPKmkC5
         r8+JpgR6JOB796qIYwg4Lsr7aqQcRg1tnzj6mQRny3CWGxwCJroOPlRml4LepmNsHKQ0
         QE2sCVCEX0Wiy926byDfD94QuN3c1EyeF6PDwGEKWYmkLkWmJUs/lN0PRTxdghtTZDmw
         FyNHAZo+vhq2pXkETx8RWI7w/ziT/c+dE2zK9FqH+HVFETYD69XZpYJ/gwo6s5nTq7jI
         7/kHn246HqAcV9NRTXp4NJuIBGYH6Fb0hTV85uottkgap0jAoRJOZNfC0bv8v0LuMG8t
         SFdw==
X-Gm-Message-State: ACrzQf2K1ygGHvCdlJmtocMFA4wBX71GtfLushBQ6zVOOoLTw59CWGB0
        1giWkyCpAZ6UuAo4CWLEf/Q=
X-Google-Smtp-Source: AMsMyM4jRHLbhVT3BOYqYw8t6Kk5iE5G5XJrfuMXsPdVuaayzQ0ZePMqdu1S5M398MVACvFI0RHIpg==
X-Received: by 2002:a17:906:c152:b0:78d:9dbb:150b with SMTP id dp18-20020a170906c15200b0078d9dbb150bmr18972923ejc.542.1666443433316;
        Sat, 22 Oct 2022 05:57:13 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id t29-20020a056402241d00b0045ce419ecffsm15173970eda.58.2022.10.22.05.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 05:57:12 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 3/3] thermal: qcom: tsens: rework debugfs file structure
Date:   Sat, 22 Oct 2022 14:56:57 +0200
Message-Id: <20221022125657.22530-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221022125657.22530-1-ansuelsmth@gmail.com>
References: <20221022125657.22530-1-ansuelsmth@gmail.com>
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

The current tsens debugfs structure is composed by:
- a tsens dir in debugfs with a version file
- a directory for each tsens istance with sensors file to dump all the
  sensors value.

This works on the assumption that we have the same version for each
istance but this assumption seems fragile and with more than one tsens
istance results in the version file not tracking each of them.

A better approach is to just create a subdirectory for each tsens
istance and put there version and sensors debugfs file.

Using this new implementation results in less code since debugfs entry
are created only on successful tsens probe.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 467585c45d34..fc12d7c07de4 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -704,21 +704,14 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
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
-
-	file = debugfs_lookup("version", priv->debug_root);
-	if (!file)
-		debugfs_create_file("version", 0444, priv->debug_root,
-				    pdev, &dbg_version_fops);
 
 	/* A directory for each instance of the TSENS IP */
 	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
+	debugfs_create_file("version", 0444, priv->debug, pdev, &dbg_version_fops);
 	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
 }
 #else
-- 
2.37.2

