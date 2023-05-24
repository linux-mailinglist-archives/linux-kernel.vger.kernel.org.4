Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE6B70FB54
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjEXQFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjEXQEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:04:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EC218C;
        Wed, 24 May 2023 09:04:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f683e8855so160914366b.2;
        Wed, 24 May 2023 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684944257; x=1687536257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4kbf7t2pjWoddD/1MgzGcuAxsDnlYNa6SWc1ur855+0=;
        b=XhD7ZTwRg5hQpPojq8rOyf59MuJ/qo/orICMJ3Gdy+ebzPL5HfD/EeN1LUufBJvXqx
         F3NqMSNuN0EwBtInPwkaUoRzafUTIdptWNJBahQd4rmuhMcAKtiO5iyxhyFcfC/lt0tT
         XXVq3PCg7Buu2pp4JU3L70aThvmQgYfQALjY5hw+Qg2NClu2m/eb5OrmFKMJNyCW1WQw
         8qNacPvJPV7juEugKy4L94KIil10lr5Wv1tEu4PPOFZdG89NO0F9kOD2V7ZM/lcoHfR5
         bp6pJXf20ZKBe7tk7whf2Dwq8FOmr6LHDfFECTrHuzg5uHxDyrXQla5c1cEBcxvTw4AJ
         IHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944257; x=1687536257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kbf7t2pjWoddD/1MgzGcuAxsDnlYNa6SWc1ur855+0=;
        b=NJ311M1zBleR+R3HJswC68oga3O19eQmpScBmFUcOSUtvNHJzhIHTyjkvp44oAqqgI
         C32LCbRu3EHhZf1GHVYpbus8hPsq/z5bhg4PuAEsDhZinxXWqbfmWh0g8A/J52XQJHKO
         z9kpi9jRTS+/oAX7cbFCVDxPYEfq+qLnAMDTwepi7IXh4uNKT2gJR73umEdWwQwPudD6
         TDY85IjSC21P6A95J+7fLw0CEoJORZSoGe8VTMW0ARcsAneUafG0nMNy2dCdQ9+SKXIk
         PGYPGiEPKwqOYeZuNKWet7RwGLa2gCS9py7r+PanlzbNP31HoVb1nc5VqBnRzt41aLAP
         Njkg==
X-Gm-Message-State: AC+VfDyLC6MaNXEIXbu7NaPJTpH/nakQ8kDCJEEAfM8C609KkxdkcY4s
        0nUvdvOOayBTZpavmLyu1dE=
X-Google-Smtp-Source: ACHHUZ6C8yNw/UxyHTDYSjn75RxO0AsCVtDKdsK2VfVhCxqyB/r7LKc43zomLnbMqbzBCGTWywoXqA==
X-Received: by 2002:a17:906:eecd:b0:94a:74c9:3611 with SMTP id wu13-20020a170906eecd00b0094a74c93611mr18129346ejb.35.1684944256346;
        Wed, 24 May 2023 09:04:16 -0700 (PDT)
Received: from Osmten.. ([103.84.150.66])
        by smtp.gmail.com with ESMTPSA id gw17-20020a170906f15100b0096f78953b77sm6025576ejb.147.2023.05.24.09.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:04:16 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     nbd@nbd.name, ryder.lee@mediatek.com, lorenzo@kernel.org,
        shayne.chen@mediatek.com, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] debugfs.c: Fix error checking for debugfs_create_dir
Date:   Wed, 24 May 2023 21:03:52 +0500
Message-Id: <20230524160352.19704-1-osmtendev@gmail.com>
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

This patch fixes the error checking in debugfs.c in
debugfs_create_dir. The correct way to check if an error occurred
is using 'IS_ERR' inline function.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index 57fbcc83e074..d9ba700131fd 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -109,7 +109,7 @@ mt76_register_debugfs_fops(struct mt76_phy *phy,
 	struct dentry *dir;
 
 	dir = debugfs_create_dir("mt76", phy->hw->wiphy->debugfsdir);
-	if (!dir)
+	if (IS_ERR(dir))
 		return NULL;
 
 	debugfs_create_u8("led_pin", 0600, dir, &phy->leds.pin);
-- 
2.34.1

