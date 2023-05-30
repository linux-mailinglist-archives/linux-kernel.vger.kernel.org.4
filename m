Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FD6716759
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjE3Pna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjE3Pn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:43:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B147C7;
        Tue, 30 May 2023 08:43:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so3368563b3a.1;
        Tue, 30 May 2023 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685461405; x=1688053405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vele4YWsi+J6d+qVbhW/qc7qJ7IPCeYE5nE6Y6xvDXM=;
        b=fDoGxdsiVbe2gJMJIUnQSnKcLmMpYfdGpuptA/y6nb9/co5YEJ7o+mc5scJG5NxP5v
         IZi+h0MJKcRskMFiBR6Ny2X+43XZQoruOZk0qBEP4MZNTS9Y8IEynVMGTsSH+T/GyG+b
         5xmC5L4BFgRoWOzrGkUNlslVuehZNEnMTHmMNUNeGvulD/aJZDmUMCZU32gUdm6DzzZH
         rduTfSs4CChc1MKin1wxNYnTYYdVagh1JICanbqDxQGA4cRSjfD7ZvAns8et9/UvPMEw
         QGv7O+MSep9vVlbu6c/8nJw64zLAIS19dGMQNFKSmS1jo1pZ8/VRKzMaLq7VonvfeJpX
         4+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685461405; x=1688053405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vele4YWsi+J6d+qVbhW/qc7qJ7IPCeYE5nE6Y6xvDXM=;
        b=U+Bhjzy8GZk/f4gipqdtSgIQAZ/CpGbTX6+Lfvo3ynYjTWALDkb1/Yg7OlbjwcKhzI
         /DPEG+TXi0XmDVaE2BsiSFha1DMZ2TnYUAu6JHzT5wmlyfKfT4cS8sRi08NuSVXmxGBR
         8yEk2d8G43HL01MWZUCt//HbL1ugu7F4nI6XboiBoXYzSZ0o8elnMWdifaHFYBjIGPN5
         4N+IPHe+bgYXTEf4az4KBYGDCFCk1iI6ZomUgyyqJdOJzX7NEFQxxl7fS7EDxJVd9uou
         a/3T00NfWOYCbtvEmhzdIZ5howBi5FwxfV5xeKim4EAxBqo/RhKCkat0k8ldKaQvRSnJ
         9Jcw==
X-Gm-Message-State: AC+VfDwTYkXX5E+NcezJmjzK0W4t0L4Sxs29nC8ENmYHron2fvk+6fGb
        OPRKdDG5DE1EisBPTS7vinQ=
X-Google-Smtp-Source: ACHHUZ4mZMh7SZcKu7kRR4Y9KeZjfqyrDm6IHpe411QC5Woi/2wq0u94xAnlMvtwCyz9+TBRwNEYxA==
X-Received: by 2002:a05:6a20:c191:b0:10b:f590:5a26 with SMTP id bg17-20020a056a20c19100b0010bf5905a26mr2796135pzb.26.1685461404529;
        Tue, 30 May 2023 08:43:24 -0700 (PDT)
Received: from Osmten.. ([103.84.150.71])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78e58000000b0064d34ace753sm1799642pfr.114.2023.05.30.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:43:24 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     david.rheinsberg@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH v2] hid-wiimote-debug.c: Drop error checking for debugfs_create_file
Date:   Tue, 30 May 2023 20:42:52 +0500
Message-Id: <20230530154252.7895-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the error checking for debugfs_create_file
in hid-wiimote-debug.c.c. This is because the debugfs_create_file()
does not return NULL but an ERR_PTR after an error.
The DebugFS kernel API is developed in a way that the
caller can safely ignore the errors that occur during
the creation of DebugFS nodes.The debugfs Api handles
it gracefully. The check is unnecessary.

Link to the comment above debugfs_create_file:
https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L451

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

---
changes since v1
	-In v1 the IS_ERR was used for error checking which is dropped now.
---
 drivers/hid/hid-wiimote-debug.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
index a99dcca2e099..00f9be55f148 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -173,7 +173,6 @@ int wiidebug_init(struct wiimote_data *wdata)
 {
 	struct wiimote_debug *dbg;
 	unsigned long flags;
-	int ret = -ENOMEM;
 
 	dbg = kzalloc(sizeof(*dbg), GFP_KERNEL);
 	if (!dbg)
@@ -183,13 +182,9 @@ int wiidebug_init(struct wiimote_data *wdata)
 
 	dbg->eeprom = debugfs_create_file("eeprom", S_IRUSR,
 		dbg->wdata->hdev->debug_dir, dbg, &wiidebug_eeprom_fops);
-	if (!dbg->eeprom)
-		goto err;
 
 	dbg->drm = debugfs_create_file("drm", S_IRUSR,
 			dbg->wdata->hdev->debug_dir, dbg, &wiidebug_drm_fops);
-	if (!dbg->drm)
-		goto err_drm;
 
 	spin_lock_irqsave(&wdata->state.lock, flags);
 	wdata->debug = dbg;
@@ -197,11 +192,6 @@ int wiidebug_init(struct wiimote_data *wdata)
 
 	return 0;
 
-err_drm:
-	debugfs_remove(dbg->eeprom);
-err:
-	kfree(dbg);
-	return ret;
 }
 
 void wiidebug_deinit(struct wiimote_data *wdata)
-- 
2.34.1

