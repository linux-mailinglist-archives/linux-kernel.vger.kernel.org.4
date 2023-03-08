Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F85F6AFAF8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCHATZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCHATX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:19:23 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0101E960A9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 16:19:20 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id ce8-20020a17090aff0800b0023a61cff2c6so2661151pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 16:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678234760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbbkKWGQad1Yo20rF0OSP26kDIz9idmRlHUsiPHwLP0=;
        b=Rm+qhWk2qemYa9svIsqx6TTWMg1Zx0Ip5gtBEEpY6kzQhHMvkEt/VCl9Z2/F1e4Rqp
         ml1bDveChx60PEPlfF88iBrkNnEJFZQpyAxM92NXbhnf9TeofmIeqa+EVGNzENmZuTuN
         MT6JO7vCpYcEFlD2qYn7UipubEAjLGmSJKyeZ1ZCqY7vfU1JnRmCBAzpJoG4UqpjL8/W
         yGUhcM4dJ2jnHol+XsR32P/w898aLZSmPFzNAp6iseI4ht2ZfbUi/YwesGUlSWpYxheU
         ok4cWjpLDK3xOjM4gyYsA99zBXvB6aSah3TYFwA3bh+ygGWd8Sp/wbN/CwSDZ8HS75xi
         l5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678234760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbbkKWGQad1Yo20rF0OSP26kDIz9idmRlHUsiPHwLP0=;
        b=DB2PCGgPzzdjbTVnY+nXbMrbtvNaPDyjIa9myYCRIErNRVmUEQfew43yxtDjiKR5Sx
         0P/Ehia5INf0D35IxSuagEmzZqoKXqFmXiQ5pJ+5yfy4HTK92Tl3CFBOPOzX+DZUEE1C
         ukuHF68/fPv3NYqraiW4xumtCXB9yaHovyT1oiHsGq2RFpgB+Xfo5/NnVDRl1uDS0DKJ
         Dh0c8vz35GKqOPobrpASpJVr2Xvs2Ss2ry5P+xKRvo9bGAGjrhXCPQsidRBG2jVbB5Wx
         e8wmVTD+gqvKvVkzpLvFlNj+JenFG16y/1WHZv+hktpvQDqojvqtEXrNgeKnwigRrbyN
         pz1A==
X-Gm-Message-State: AO0yUKUzbjG4iQ1aOln01OwaZUzqQjV6OBy94eKeF9NG0M3B9WRvAiRl
        QvuoxfXLNKEq4UCl1TPEow0=
X-Google-Smtp-Source: AK7set8AFivGG9BQh9psczFalSR8xG8ofPsLWNbpH6SfZcW/EPMaaAmp91RyP6uKjST1thbRzcRLAw==
X-Received: by 2002:a05:6a20:8404:b0:c7:af88:3dd8 with SMTP id c4-20020a056a20840400b000c7af883dd8mr20385425pzd.6.1678234760003;
        Tue, 07 Mar 2023 16:19:20 -0800 (PST)
Received: from olv-ct-22.c.googlers.com.com (132.111.125.34.bc.googleusercontent.com. [34.125.111.132])
        by smtp.gmail.com with ESMTPSA id b9-20020aa78109000000b005a8e97fc71bsm8366463pfi.84.2023.03.07.16.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:19:19 -0800 (PST)
From:   Chia-I Wu <olvaffe@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: fix a potential double free in pqm_create_queue
Date:   Tue,  7 Mar 2023 16:19:02 -0800
Message-Id: <20230308001903.2841087-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
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

Set *q to NULL on errors, otherwise pqm_create_queue would free it
again.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 5137476ec18e6..4236539d9f932 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -218,8 +218,8 @@ static int init_user_queue(struct process_queue_manager *pqm,
 	return 0;
 
 cleanup:
-	if (dev->shared_resources.enable_mes)
-		uninit_queue(*q);
+	uninit_queue(*q);
+	*q = NULL;
 	return retval;
 }
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

