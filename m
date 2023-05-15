Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0718670388E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243291AbjEORdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbjEORcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:32:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A2BDD8A
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:30:15 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643990c5319so9449595b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684171814; x=1686763814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz6acpVUz4kPc93Wpq7DpAV+sFsxdMkORJPc+9xniKI=;
        b=TYrpIHObAw0kzPfEsnuwqQyOu1/BCuubh1hUcVGmOlFkgXdfujmAdjFHAgHuLI9RJm
         /BEsCNaINosoxZFMJPI5wr9mSysPp7VuiJnFqw16DesJDfuKVYB9epBBTr5ZgipvNpSM
         Ann7mnJSxtN+cYt2L+tMve5UJ+zvB3FtMdTKDdscYtpYQ6dVoJdk3gUtSuhj5czbZ/te
         UPtRxKOdJw8PtqW10P3QSvAEoR9LzauNIXFAx4a+do5VjOr9jn1BdsfKtdwI24ybVOdt
         cbScidEI8XOcidq5y8hxlwT0w1ozO/hwbW8kKmmOXIp3ma/VMoROH1xDfungQ9U7Cd0l
         d9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684171814; x=1686763814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fz6acpVUz4kPc93Wpq7DpAV+sFsxdMkORJPc+9xniKI=;
        b=g8W8RdHlGXM3jcnpB5UHo0kRUF08vf3Lgomw0CIv8BY0n2vA3WVnLXGwzREA4syAI3
         NT1XVrlxUzY9ATiOsTdV3Ag1laDt1F32kAPzPVYsTZw0JrsQRBaviRWmFzkrqL50El9i
         yX8X8T1Hfb1uRJ1hV1aBwwLcJc0hZXjBEK9PXGcCUYhIcoWw1zCnzOujidIcuw8Q20bC
         Rimtni8MJWPZtDE+uIXg9s5kvy+Zf+b0PVZmDqWYnHrENkdMvrI66F+CDoFY9q0P5hUi
         6Y31LgpwgWJ3BLHdmFCgnb4rVGZfvHi3PK0HsK8IqOHLw7b5qdwDXrlbAJaf2mBkFFds
         eERA==
X-Gm-Message-State: AC+VfDxKYCGozoTHk4oYROTgZAwxoyKRRwkig8Yn3dPXHRV6Kt6PFrLf
        ghh/utudMca1ju/xydz+Oxw=
X-Google-Smtp-Source: ACHHUZ4hKhXIiIdnwGGZ9sJZTgo6o/C9CJiZkEPuqAEtultZ1jIVTARvvy1E4dfH7lenUE6HDdPW+Q==
X-Received: by 2002:a05:6a00:acc:b0:63b:435f:134a with SMTP id c12-20020a056a000acc00b0063b435f134amr44408367pfl.28.1684171814146;
        Mon, 15 May 2023 10:30:14 -0700 (PDT)
Received: from Osmten.. ([103.84.150.77])
        by smtp.gmail.com with ESMTPSA id y9-20020a62b509000000b0064ca1fa843fsm2575177pfe.62.2023.05.15.10.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 10:30:13 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>
Subject: [PATCH] regulator:core.c: Fix error checking for debugfs_create_dir
Date:   Mon, 15 May 2023 22:29:38 +0500
Message-Id: <20230515172938.13338-1-osmtendev@gmail.com>
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

This patch fixes the error checking in core.c in debugfs_create_dir.
The correct way to check if an error occurred is 'IS_ERR' inline function.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dc741ac156c3..698ab7f5004b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5256,7 +5256,7 @@ static void rdev_init_debugfs(struct regulator_dev *rdev)
 	}
 
 	rdev->debugfs = debugfs_create_dir(rname, debugfs_root);
-	if (!rdev->debugfs) {
+	if (IS_ERR(rdev->debugfs)) {
 		rdev_warn(rdev, "Failed to create debugfs directory\n");
 		return;
 	}
@@ -6178,7 +6178,7 @@ static int __init regulator_init(void)
 	ret = class_register(&regulator_class);
 
 	debugfs_root = debugfs_create_dir("regulator", NULL);
-	if (!debugfs_root)
+	if (IS_ERR(debugfs_root))
 		pr_warn("regulator: Failed to create debugfs directory\n");
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.34.1

