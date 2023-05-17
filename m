Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C303706F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjEQRZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEQRZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:25:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3FB93F7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:24:54 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510b154559fso1811036a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684344291; x=1686936291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ydp0nzIqTf9GiPFxJfFUQZhMHTtnoSpeoV+NHzLr6E4=;
        b=r4B62BFbS7AmMFV5HoMdEg0dcw8fXjpKt8dMdOraIXcuiW8WxxXKc+E3Amka7WhJeK
         6R3WVymoGOszC7ipCN0+dtYSTLx5clCCAi/DZmq0+M7Bdz9/t5biJVH8u+ldKXHoKV0o
         tZB3EYg79tj+51BuP+PRlWxE8ZXFsUG637Gmk4aAFzfIh/Y93N9DB8K2ey16bs3YliwH
         pR1VOZ9oL2eDSLuecpttUZ5rFGj5YLHsPAxY03jxchARCvSiHFD33s38RuXNShCB6w8t
         SL6luzV1wPMP7p6U8kN3Fk2ltKHiPjaODJ4/Dmf/A0UZFazk9qMZZ8JGyJT9oUsIFpKY
         tMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684344291; x=1686936291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ydp0nzIqTf9GiPFxJfFUQZhMHTtnoSpeoV+NHzLr6E4=;
        b=ainB/iKMt0REFrrQOSyH1/2DaXeoR0K7wi79xGK7ozNZv92Ie/uJSFGUyhfgp37JCR
         Gmcw6XnMBTrk8r3dPO9PEMWDyOypE4TM0BM9OrYD0d1u+2VDI2LsmuqgD5AMs7Np+lxP
         DDRmiKw6bjLdHGyKmqhAJ3m7UqF2gEBG5h0ARK0uhanMigC7E5scZbqBW3lhKKVr7KeD
         BFTnJJtQp833IwcCDZTUHvTxl8k3k8DXwE8yxhmpGN7iuJPE1+b57D7/MG4CpbEhsLU1
         7L90u+U2T8jc+w0xDN0OvISRZkzVbhZIgMGkQgWIRIof6SbQ5Ld0GganxnM97zHiCZff
         SCZw==
X-Gm-Message-State: AC+VfDz1AsAeLXWcZJqb8UMPM+QzsngISyORklI6jJ7s3PIFTD2RY2Fr
        aF2dyQlhBt15wgzbdejDKWo=
X-Google-Smtp-Source: ACHHUZ78xtzzPlt84o9mNoDNQHi/wtMMcy6VkXVTXf+I5gP3pgGtigo30f7CZchPznk2+9nYiqRAkg==
X-Received: by 2002:a17:907:74c:b0:965:6aff:4f02 with SMTP id xc12-20020a170907074c00b009656aff4f02mr36680500ejb.41.1684344291101;
        Wed, 17 May 2023 10:24:51 -0700 (PDT)
Received: from Osmten.. ([103.84.150.101])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709067a0100b0096b0e93193asm5440858ejo.90.2023.05.17.10.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:24:50 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     nm@ti.com, ssantosh@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] wkup_m3_ipc.c: Fix error checking for debugfs_create_dir
Date:   Wed, 17 May 2023 22:24:31 +0500
Message-Id: <20230517172431.13507-1-osmtendev@gmail.com>
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

This patch fixes the error checking in wkup_m3_ipc.c in
debugfs_create_dir. The correct way to check if an error occurred
is 'IS_ERR' inline function.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index c9197912ec24..3aff106fc11a 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -202,7 +202,7 @@ static int wkup_m3_ipc_dbg_init(struct wkup_m3_ipc *m3_ipc)
 {
 	m3_ipc->dbg_path = debugfs_create_dir("wkup_m3_ipc", NULL);
 
-	if (!m3_ipc->dbg_path)
+	if (IS_ERR(m3_ipc->dbg_path))
 		return -EINVAL;
 
 	(void)debugfs_create_file("enable_late_halt", 0644,
-- 
2.34.1

