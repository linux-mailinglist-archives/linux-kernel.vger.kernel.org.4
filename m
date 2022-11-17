Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B4F62E60F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 21:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbiKQUjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 15:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiKQUjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 15:39:11 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB747FF29
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:39:10 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id o13so1531020ilc.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Qtp1sQRQzBXlT3WBoRlm6hPTuZynYBPeMuxiH1WVCs=;
        b=mxu1ZgEQKaJCi68utQFU0bC1fkMRs13p4Xs2GkoaBU2QH4wFfg/WxjPA5j0rkPnioW
         Sa5tyQFiUFI53GUAjfZmJOPp62c17/GzgAM9E4RPx2/t9PW165trmk7Y3EQGLXX0exeX
         byktKViokoVJeV3MqqKA1XbBPxlvSrLz2Zfxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Qtp1sQRQzBXlT3WBoRlm6hPTuZynYBPeMuxiH1WVCs=;
        b=2bp1Q5qTD4fTgFHxNDkt2F/CCoyvSk6LfJaHaji/EnRbA4P5TRAFtftjUJYPVUpiZL
         aET6rJAqk/PQxIvbGKleUrpex59c00AgElSM/0/kWAGQPQzL9j4tih11D+HWNZEn9/fG
         qIjLFd6y/Pt7GsLQG+OONBkNIrRn05UqE1Hem13ehkuhIdPODHK5EmlnMH3A3STwWxVA
         Zpqoeu6SBIE7xqd2/eFPSliYFkD7VfSzEkVxW63htv1Mi1gt6qdvv7R6r8JuVJzeIeht
         jf/oOx6tl0RR8rJ4wRhK61+vimq8kZHo6kgNonIueB8TWHXXWWg6Eqv0zJIQFp87kURP
         p+YA==
X-Gm-Message-State: ANoB5pkd21k3vjQmZ48pYvZWcNdlJVf15Yu+JrXdf3sL5V/X38V2GDQf
        5do7gNFtuLdIqv4Qaqgc+VaQAg==
X-Google-Smtp-Source: AA0mqf7jiV+CUhBJR5sMY+0ATWmq+aNHemsPzFFpBRvofMaokqK+YPcfrO4aRwlaJTF1Dm4QFUvHQA==
X-Received: by 2002:a92:dd0e:0:b0:300:b9c4:8c1 with SMTP id n14-20020a92dd0e000000b00300b9c408c1mr1945545ilm.124.1668717549772;
        Thu, 17 Nov 2022 12:39:09 -0800 (PST)
Received: from midworld.bld.corp.google.com ([2620:15c:183:200:b285:6808:3f3e:f538])
        by smtp.gmail.com with ESMTPSA id d191-20020a0262c8000000b00363da904602sm570192jac.13.2022.11.17.12.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 12:39:09 -0800 (PST)
From:   Drew Davenport <ddavenport@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     dianders@chromium.org, Drew Davenport <ddavenport@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] drm/panel-simple: Use ktime_get_boottime for delays
Date:   Thu, 17 Nov 2022 13:38:46 -0700
Message-Id: <20221117133655.3.Iebd9f79aba0a62015fd2383fe6986c2d6fe12cfd@changeid>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
References: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
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

ktime_get_boottime continues while the device is suspended. This change
ensures that the resume path will not be delayed if the power off delay
has already been met while the device is suspended

Signed-off-by: Drew Davenport <ddavenport@chromium.org>
---

 drivers/gpu/drm/panel/panel-simple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 8a3b685c2fcc0..065f378bba9d2 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -280,7 +280,7 @@ static void panel_simple_wait(ktime_t start_ktime, unsigned int min_ms)
 		return;
 
 	min_ktime = ktime_add(start_ktime, ms_to_ktime(min_ms));
-	now_ktime = ktime_get();
+	now_ktime = ktime_get_boottime();
 
 	if (ktime_before(now_ktime, min_ktime))
 		msleep(ktime_to_ms(ktime_sub(min_ktime, now_ktime)) + 1);
@@ -307,7 +307,7 @@ static int panel_simple_suspend(struct device *dev)
 
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 	regulator_disable(p->supply);
-	p->unprepared_time = ktime_get();
+	p->unprepared_time = ktime_get_boottime();
 
 	kfree(p->edid);
 	p->edid = NULL;
@@ -351,7 +351,7 @@ static int panel_simple_resume(struct device *dev)
 	if (p->desc->delay.prepare)
 		msleep(p->desc->delay.prepare);
 
-	p->prepared_time = ktime_get();
+	p->prepared_time = ktime_get_boottime();
 
 	return 0;
 }
-- 
2.38.1.584.g0f3c55d4c2-goog

