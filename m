Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8748B710FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241667AbjEYPjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241327AbjEYPjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:39:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8F099
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:39:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96f5685f902so118977466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685029144; x=1687621144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GfIokcEoUcrcdH5Go22anmvwVolnzE/qQC062YOEZBw=;
        b=cvguMHhN93mqSQdUe1bjg940LLueVFfQ47fuxKmIVJY/Ts6fCEhW9ogRFrfJA+RRR+
         RBcXG0QSx/sambwpr+QIBK1LV5uqmTgGP6ooQuHGTTZN/FhWue1mcwJxp98ulY6Hp9ML
         6DLu7ziSS/4wROUF6FS0zJELXciorIweRVpuj6oxGyigLIT+1P9HuQ7JF7fbhPF42A3r
         2SaUdYpBLNiM7uyoY1rEzwfQaAW2nm+DrC5FBvAteUOt+p4kXLFOEjj0RZqXI9cYNp3b
         /FMfrlChKs5sx75VUR8S4uiPFqH3wUVDvM6TOvTAUAAGxuEQViiHd2/iVDQdiLyC1IcU
         gfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685029144; x=1687621144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfIokcEoUcrcdH5Go22anmvwVolnzE/qQC062YOEZBw=;
        b=WSqi1ykm7O9HEh2dD/efedCskCp0HaymN2R9VXaUkOKGlDLd4+UHpdlfThBpYM3pOS
         MZ6MeeHzvzllfzdGR8cGxCHMW9JBVgGpwlltjWE5Gbi/GRetlLFSNqDiaPiijgIrHb/r
         9F+8LN6asOtk0R9HwU7y4+8CRleMv6TNgVGz6JPt0qNRZhYX8ifLVvvntnD1o6q8Jkj8
         1CsoLLbFUCsItnYrhvUOVVOLPaTaWx0JivO3BYHc4w+/LSP7iDOv0tIjDLthSIC0YxJB
         9evQVRkX1vWLdsEUpH2TdiARC07eDjytTH5FhqmBK89jsXUw5YvrIQNBrhMMgXzm+VOE
         kgoQ==
X-Gm-Message-State: AC+VfDyv1W0il2Pu7cjryoU/6WGRvsoRRvvz70Sibm4N99GANuMC1Ivc
        DFz+ByaGlizEsjZKu3lF8cJkMAU8NiCOdQ==
X-Google-Smtp-Source: ACHHUZ6YyP9kiSwwOJOPi/Waygje0qyYEtUEHEDx7A8q1UjnvXuwJoPlLNUOL0Q5qhBjpxhoJ/uQiA==
X-Received: by 2002:a17:906:4fc7:b0:973:9337:1aac with SMTP id i7-20020a1709064fc700b0097393371aacmr2177841ejw.60.1685029143624;
        Thu, 25 May 2023 08:39:03 -0700 (PDT)
Received: from Osmten.. ([103.84.150.78])
        by smtp.gmail.com with ESMTPSA id j22-20020a1709062a1600b0096b1206aa3fsm979608eje.89.2023.05.25.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 08:39:03 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     sre@kernel.org, jinpu.wang@ionos.com
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] omap_ssi_port.c: Drop error checking for debugfs_create_dir
Date:   Thu, 25 May 2023 20:38:37 +0500
Message-Id: <20230525153837.13198-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch fixes the error checking in spi-dw-core.c in
omap_ssi_port.c. The DebugFS kernel API is developed in
a way that the caller can safely ignore the errors that
occur during the creation of DebugFS nodes.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/hsi/controllers/omap_ssi_port.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 7ad41599baa5..8feb91d256fd 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -151,23 +151,20 @@ static int ssi_div_set(void *data, u64 val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(ssi_sst_div_fops, ssi_div_get, ssi_div_set, "%llu\n");
 
-static int ssi_debug_add_port(struct omap_ssi_port *omap_port,
+static void ssi_debug_add_port(struct omap_ssi_port *omap_port,
 				     struct dentry *dir)
 {
 	struct hsi_port *port = to_hsi_port(omap_port->dev);
 
 	dir = debugfs_create_dir(dev_name(omap_port->dev), dir);
-	if (IS_ERR(dir))
-		return -ENOMEM;
+
 	omap_port->dir = dir;
 	debugfs_create_file("regs", S_IRUGO, dir, port, &ssi_port_regs_fops);
 	dir = debugfs_create_dir("sst", dir);
-	if (IS_ERR(dir))
-		return -ENOMEM;
+
 	debugfs_create_file_unsafe("divisor", 0644, dir, port,
 				   &ssi_sst_div_fops);
 
-	return 0;
 }
 #endif
 
@@ -1217,11 +1214,8 @@ static int ssi_port_probe(struct platform_device *pd)
 	pm_runtime_enable(omap_port->pdev);
 
 #ifdef CONFIG_DEBUG_FS
-	err = ssi_debug_add_port(omap_port, omap_ssi->dir);
-	if (err < 0) {
-		pm_runtime_disable(omap_port->pdev);
-		goto error;
-	}
+	 ssi_debug_add_port(omap_port, omap_ssi->dir);
+
 #endif
 
 	hsi_add_clients_from_dt(port, np);
-- 
2.34.1

