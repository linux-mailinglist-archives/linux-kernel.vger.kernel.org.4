Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34BA700FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 22:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjELUp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 16:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjELUp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 16:45:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C56726AD
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 13:45:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-953343581a4so1630946666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683924323; x=1686516323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PTDMnR3OyExbfWoz3X2LoFJmsuEY0L9ndoVEyulagGY=;
        b=XSPAERS87dxVd5iLcGQlnDpD+2fFf1rGrTl2AGY/uMkMDAju/+apSs8jGHSsmWK9WM
         wJd4jFKFSrTSF+BkdmFqJlIUf9JhBsCt+p6apleUJxfydxraRAQjnnZ/LjSGFrhJBEB9
         hSuFDW2yUgoV34HihSoLydKHYXq8JjDMFOOEhZXRm9jXusVojLkp+wMhTn5yf9/Zvgk5
         0u3X6EyzqxifxQ1Z+7Ig1cpIGjZIG4noAOyD2Njm+uk+ucv8y8zCMGH3LQEk9voGb7rl
         f1Us37jX9qnSfCDmD8MFoqc6gsgL7KGhMjdJG1HrjuBXjAQAetpg2bTnRSHg/mgCYJ4f
         si9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683924323; x=1686516323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTDMnR3OyExbfWoz3X2LoFJmsuEY0L9ndoVEyulagGY=;
        b=a7K9fOhFYuBQzHxEQiDtn8DWKTK0ycWUN5jBEzcVJ6uf2Ka3cWy2OlcPkj++MQSgN7
         Jpz1Ay3qfTzJacxenxGpmAzIwTasTofuv1aFccEKBxdHRkmlK72joXYuJQ2UP7J2kXOG
         7DIyli3/bEE9lg7O/oFpWNyJwLFVGmo6b2J5KVEI3/dPHUZWbbH1AjZvFref6ivqmDaS
         IWw7NuMXQyhq2Zo33h6uin+9/CRdeggLNq+K5VUCvVxo0F8INR1AM46cpT47asw4BmzQ
         9wamZI+95xMFsnFbW5fqT1kCKQCXvVXc4y+sX3F8NyvT0DiXxylWEtT/o5mSLy3sw/yv
         Aidg==
X-Gm-Message-State: AC+VfDznd0Gscpao2NQcfArMU9PZ/aGHdEkfIers9N6iGeoDbvA6avhK
        wMCAqP7qTPIY3DI/Xy90XjQ=
X-Google-Smtp-Source: ACHHUZ6RUwTeF266/lxxWTcXX+JVT8b3v7yTbvK3RrDuKWnxrIA0XV79antMMbX1z4X8tSP9TRYHlQ==
X-Received: by 2002:a17:907:846:b0:965:e5cf:bb35 with SMTP id ww6-20020a170907084600b00965e5cfbb35mr23645317ejb.22.1683924323459;
        Fri, 12 May 2023 13:45:23 -0700 (PDT)
Received: from arch.localdomain (82-132-224-222.dab.02.net. [82.132.224.222])
        by smtp.gmail.com with ESMTPSA id l9-20020a170906078900b0094ed0370f8fsm5856059ejc.147.2023.05.12.13.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 13:45:23 -0700 (PDT)
From:   SikkiLadho <mushi.shar@gmail.com>
To:     mw@semihalf.com
Cc:     linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        SikkiLadho <mushi.shar@gmail.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>
Subject: [PATCH] net: marvell: fix error checking for debugfs
Date:   Sat, 13 May 2023 06:46:28 +0500
Message-Id: <20230513014628.39727-1-mushi.shar@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes error checking in by using IS_ERR inline function to
check for errors.

Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: SikkiLadho <mushi.shar@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index 75e83ea2a..9c53f378e 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -593,7 +593,7 @@ static int mvpp2_dbgfs_c2_entry_init(struct dentry *parent,
 	sprintf(c2_entry_name, "%03d", id);
 
 	c2_entry_dir = debugfs_create_dir(c2_entry_name, parent);
-	if (!c2_entry_dir)
+	if (IS_ERR(c2_entry_dir))
 		return -ENOMEM;
 
 	entry = &priv->dbgfs_entries->c2_entries[id];
@@ -626,7 +626,7 @@ static int mvpp2_dbgfs_flow_tbl_entry_init(struct dentry *parent,
 	sprintf(flow_tbl_entry_name, "%03d", id);
 
 	flow_tbl_entry_dir = debugfs_create_dir(flow_tbl_entry_name, parent);
-	if (!flow_tbl_entry_dir)
+	if (IS_ERR(flow_tbl_entry_dir))
 		return -ENOMEM;
 
 	entry = &priv->dbgfs_entries->flt_entries[id];
@@ -646,11 +646,11 @@ static int mvpp2_dbgfs_cls_init(struct dentry *parent, struct mvpp2 *priv)
 	int i, ret;
 
 	cls_dir = debugfs_create_dir("classifier", parent);
-	if (!cls_dir)
+	if (IS_ERR(cls_dir))
 		return -ENOMEM;
 
 	c2_dir = debugfs_create_dir("c2", cls_dir);
-	if (!c2_dir)
+	if (IS_ERR(c2_dir))
 		return -ENOMEM;
 
 	for (i = 0; i < MVPP22_CLS_C2_N_ENTRIES; i++) {
@@ -660,7 +660,7 @@ static int mvpp2_dbgfs_cls_init(struct dentry *parent, struct mvpp2 *priv)
 	}
 
 	flow_tbl_dir = debugfs_create_dir("flow_table", cls_dir);
-	if (!flow_tbl_dir)
+	if (IS_ERR(flow_tbl_dir))
 		return -ENOMEM;
 
 	for (i = 0; i < MVPP2_CLS_FLOWS_TBL_SIZE; i++) {
-- 
2.38.1

