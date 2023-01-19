Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6E667306A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjASEhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjASEgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:36:52 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F19B7C84B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 20:33:28 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id g10so731049qvo.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 20:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=932/KQGWtMWjBdrKFZjdbv0KuCSiMt6IcZgAE6+dbyE=;
        b=EhzBLEnM/KzZH9y8HH+CW6J/9tes2aMNaJ1KN5SKhC916AaYIqDUcFYYjJzdTsdcNi
         zxDXYEQsbNs/nw17sjlITGjjevhf717/PVzSXkJnebUPDUFUhbxv5GOE7nOcM8FbsW0B
         hvzi+TyAIR1mkuSGyif4bKGxECg4c01vNOEo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=932/KQGWtMWjBdrKFZjdbv0KuCSiMt6IcZgAE6+dbyE=;
        b=7yCkVAxn17eVQHa2qNzd32QaX4FIe2bSiJIZYFUdHMTrZsVw2n6/d9ln/D6wNBEPDE
         TtRJ9oRrbG2W62selAYoW/p+zqSfpweoAyyJIxI0/EcpR2QPXN7+BdnJF1dWt5EiJXOk
         rMixNu0STp3ood1Oe3KCMbfauX1ZVW3uTPNomPM7/wlRYOPs2xnZlgiVqVTPtU5Ud1nj
         bIY7kMmRiltm/Wv1Wx/uTGYBzNdKhzP9UAtEMqynp+Xbw2ov8lbizZLsI1pwTxIvk64u
         OGw6t5VrCksoFR98MyiPE0kTwFYXgzdaVzOLn3VcejiYeARLAST+QKxesttZ3ekqyDrl
         foSQ==
X-Gm-Message-State: AFqh2krrpZjfas7gZApbSJ4WBwWutbcSf8rjqeM3W+DgvJ1uCWtl/0I1
        rc/MY8Txqsk7DYWX8SRTHUlNXHHG+JSdvyo6
X-Google-Smtp-Source: AMrXdXvxvxXnINoIrUWSo06I1ZVSMYQimE0lPuCxqnVGQe+a1eymA/7hGJNzSxahRJ2MTtacimuKng==
X-Received: by 2002:a17:90a:c282:b0:229:472d:af3d with SMTP id f2-20020a17090ac28200b00229472daf3dmr9641936pjt.1.1674098611663;
        Wed, 18 Jan 2023 19:23:31 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:dc41:dbaf:a0e3:7b4b])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a154900b00229bd164ba9sm2042173pja.7.2023.01.18.19.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:23:31 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] soc: qcom: stats: Populate all subsystem debugfs files
Date:   Wed, 18 Jan 2023 19:23:29 -0800
Message-Id: <20230119032329.2909383-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver relies on SMEM to populate items for each subsystem before
the device probes. The items in SMEM that are being looked for are
populated by the subsystems lazily, and therefore may not exist until
the device has booted. For example, if I build this driver into the
kernel on Trogdor Lazor and boot up, I don't see a 'modem' debugfs file
populated, because the modem boots and populates the SMEM item after
this driver probes.

Always populate the files for the subsystems if they're in SMEM, and
make the qcom_subsystem_sleep_stats_show() function return 0 if the SMEM
items still isn't there. This way we can run a simple command like

	grep ^ /sys/kernel/debug/qcom_stats/*

and collect the subsystem sleep stats without interspersed errors or
missing details entirely because this driver probed first.

Fixes: 1d7724690344 ("soc: qcom: Add Sleep stats driver")
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/qcom_stats.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index 6228af057120..c207bb96c523 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -92,7 +92,7 @@ static int qcom_subsystem_sleep_stats_show(struct seq_file *s, void *unused)
 	/* Items are allocated lazily, so lookup pointer each time */
 	stat = qcom_smem_get(subsystem->pid, subsystem->smem_item, NULL);
 	if (IS_ERR(stat))
-		return -EIO;
+		return 0;
 
 	qcom_print_stats(s, stat);
 
@@ -170,20 +170,14 @@ static void qcom_create_soc_sleep_stat_files(struct dentry *root, void __iomem *
 static void qcom_create_subsystem_stat_files(struct dentry *root,
 					     const struct stats_config *config)
 {
-	const struct sleep_stats *stat;
 	int i;
 
 	if (!config->subsystem_stats_in_smem)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
-		stat = qcom_smem_get(subsystems[i].pid, subsystems[i].smem_item, NULL);
-		if (IS_ERR(stat))
-			continue;
-
+	for (i = 0; i < ARRAY_SIZE(subsystems); i++)
 		debugfs_create_file(subsystems[i].name, 0400, root, (void *)&subsystems[i],
 				    &qcom_subsystem_sleep_stats_fops);
-	}
 }
 
 static int qcom_stats_probe(struct platform_device *pdev)

base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
https://chromeos.dev

