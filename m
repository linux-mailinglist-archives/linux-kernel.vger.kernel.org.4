Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4064570E383
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbjEWRNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjEWRNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:13:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D143CA;
        Tue, 23 May 2023 10:13:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510d8d7f8eeso198126a12.0;
        Tue, 23 May 2023 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684862028; x=1687454028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sfaNkSC70bMQJMuU47w08F3kvk3rqUDEG0U+c6ybHYU=;
        b=ssHYJqFN/ug0+EtfwzpMEpXszBasCf0OKsYAOe344HHjWDFUArQlf25r5DbpbynpXC
         092+h5i2bAyL8PZzjFqkoxuHps0U1FGGmuGDs57Iek9GVKK0DjL+wbtX+l42q625/xI4
         zwGLvGmhrDXcciFDbYDWh/iZ+WJNfyrobOkzrZJHY94CHi0hayEnF132Mt4ESbBqqCEu
         HfZVcEEMnJFJG+5mWcrZMrBbc/NmsXmdXtugp/QO1dUECDsshVx4bRvOhm19ySwiuFvs
         PeWVrZAwzRFekl9yXghGg3fV7zWHothzHnY48aN12pAYhUoVfz74VZzP97WD70iBb+m1
         kGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862028; x=1687454028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfaNkSC70bMQJMuU47w08F3kvk3rqUDEG0U+c6ybHYU=;
        b=lOqYQB9Js+bMMphSyNPcZxwBKNN0hoMjs19J/Fi2pClD2YPJPlinKKSJiE4C+myjNR
         psj7S8uZcaqHFSAg3H4TN76BKDV1lGB9Q8HRkg2D70LETJBnRIo4A4yUkOsIf18gM9a+
         kVtW5AiqTEqEspk8PEIQ/WnZ55SLXUriHFHYAEPuqmBe9ySZYbbnShjSOhHRLhYcWyc8
         imbL7+1NxFih7z1flEQlDVW/CrP4B4/rJkiihHkLuboqybhUAvxk7Re976AlRPG9rC09
         qsVehWfmuu/xxFefcaTUMM6We/U4js7vT9ZuyMc1M0dKjgHqdjKIOZsZprm+aCEG3ss0
         L3vA==
X-Gm-Message-State: AC+VfDyInoDNwUDHzGGj9yRzS1Eyaf1ZJXJXxHCVxIKOxpUXyHdrGcwG
        pLcSqrdkl9xixucKUbsgel8vQBOr+9w=
X-Google-Smtp-Source: ACHHUZ7/QcxfQ7OotrZxJOQ2TcNKfRrGrT1KB7UCAaxxDGbpRlZqYI5sZaxCqaaXpI7YB+89Ofyw6A==
X-Received: by 2002:aa7:c74c:0:b0:506:bda9:e063 with SMTP id c12-20020aa7c74c000000b00506bda9e063mr10718310eds.16.1684862028077;
        Tue, 23 May 2023 10:13:48 -0700 (PDT)
Received: from Osmten.. ([103.84.150.89])
        by smtp.gmail.com with ESMTPSA id e20-20020aa7d7d4000000b00501d73cfc86sm4215241eds.9.2023.05.23.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:13:47 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     david.rheinsberg@gmail.com, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] hid-wiimote-debug.c: Fix error checking for debugfs_create_file
Date:   Tue, 23 May 2023 22:12:40 +0500
Message-Id: <20230523171240.12930-1-osmtendev@gmail.com>
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

This patch fixes the error checking in hid-wiimote-debug.c in
debugfs_create_file. The correct way to check if an error occurred
is 'IS_ERR' inline function.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/hid/hid-wiimote-debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
index a99dcca2e099..eddd981fee1a 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -183,12 +183,12 @@ int wiidebug_init(struct wiimote_data *wdata)
 
 	dbg->eeprom = debugfs_create_file("eeprom", S_IRUSR,
 		dbg->wdata->hdev->debug_dir, dbg, &wiidebug_eeprom_fops);
-	if (!dbg->eeprom)
+	if (IS_ERR(dbg->eeprom))
 		goto err;
 
 	dbg->drm = debugfs_create_file("drm", S_IRUSR,
 			dbg->wdata->hdev->debug_dir, dbg, &wiidebug_drm_fops);
-	if (!dbg->drm)
+	if (IS_ERR(dbg->drm))
 		goto err_drm;
 
 	spin_lock_irqsave(&wdata->state.lock, flags);
-- 
2.34.1

