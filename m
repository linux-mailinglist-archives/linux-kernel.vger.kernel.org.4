Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E6C62E60C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 21:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbiKQUjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 15:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiKQUjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 15:39:09 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C157FF2D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:39:09 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id q5so1516987ilt.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gf8nhbkFhV5ptHrI9veNeEBBvPRhZbZD4Iy3OsOWDI=;
        b=k0wtomc04CLFQ/oimpQEAfFsC/wFKEOaxydy/xnMuiwqXbbATpyDxEBzbOsUZYGMQl
         qinO5vMHF8KVson4eE9qULhgf8njZDv7dGRuYQHaYrKdDRJ/ahSFYuTM2zUI5MsQ74s1
         cPkpZpgPjpWjQtTvwoC11osToRj8xlIdMq1zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gf8nhbkFhV5ptHrI9veNeEBBvPRhZbZD4Iy3OsOWDI=;
        b=CW4H0X35ung9kU0awQoflZozcVxCZamxLRrsa0foyErDvxTH86H0nUpqt/wFaaqTuV
         +jCjQvKMHow+rpXAJ8F7i1HmswowzAqNuyolwQf9deEyJO3d4/PQieRcF/l6WyqfN+by
         NnVup74XoAhfhDGZseoOmhMxziPBHQgPrTvs8z0IzqP0cQt1enBUPGOUfAHKizuprXZ1
         ImlyJy+N/LCKbyZGeewIA27a+FEbjEYKU//yIFKhWhl7ertaKHAM8dKgyxKTfprob50x
         VeTPYxAh3935ID7etTCHbgjNj6xt+QTq+B0CmAQBN18/DN1dN4NNWB7Tn2XX4SnDBE4j
         XuyQ==
X-Gm-Message-State: ANoB5pmr6kcL+TOxCSauybOddgWSoVIPAYmxsHs+oov2CUMWd5U+rRdn
        sFnT5ZOv0R8UJ/DoOyWatCytwQ==
X-Google-Smtp-Source: AA0mqf4tJHcO2Ouv5AD2ke3z2Di7gzp4vSmuxtlE/UGTeC6ckHk83kP8c4sK0i+mhkakqYR2crIuuQ==
X-Received: by 2002:a92:c506:0:b0:302:4981:64b with SMTP id r6-20020a92c506000000b003024981064bmr1998342ilg.200.1668717548714;
        Thu, 17 Nov 2022 12:39:08 -0800 (PST)
Received: from midworld.bld.corp.google.com ([2620:15c:183:200:b285:6808:3f3e:f538])
        by smtp.gmail.com with ESMTPSA id d191-20020a0262c8000000b00363da904602sm570192jac.13.2022.11.17.12.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 12:39:08 -0800 (PST)
From:   Drew Davenport <ddavenport@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     dianders@chromium.org, Drew Davenport <ddavenport@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm/panel-samsung-atna33xc20: Use ktime_get_boottime for delays
Date:   Thu, 17 Nov 2022 13:38:45 -0700
Message-Id: <20221117133655.2.Iebd9f79aba0a62015fd2383fe6986c2d6fe12cfd@changeid>
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

 drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index 5a8b978c64158..f4616f0367846 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -53,7 +53,7 @@ static void atana33xc20_wait(ktime_t start_ktime, unsigned int min_ms)
 	ktime_t now_ktime, min_ktime;
 
 	min_ktime = ktime_add(start_ktime, ms_to_ktime(min_ms));
-	now_ktime = ktime_get();
+	now_ktime = ktime_get_boottime();
 
 	if (ktime_before(now_ktime, min_ktime))
 		msleep(ktime_to_ms(ktime_sub(min_ktime, now_ktime)) + 1);
@@ -75,7 +75,7 @@ static int atana33xc20_suspend(struct device *dev)
 	ret = regulator_disable(p->supply);
 	if (ret)
 		return ret;
-	p->powered_off_time = ktime_get();
+	p->powered_off_time = ktime_get_boottime();
 	p->el3_was_on = false;
 
 	return 0;
@@ -93,7 +93,7 @@ static int atana33xc20_resume(struct device *dev)
 	ret = regulator_enable(p->supply);
 	if (ret)
 		return ret;
-	p->powered_on_time = ktime_get();
+	p->powered_on_time = ktime_get_boottime();
 
 	if (p->no_hpd) {
 		msleep(HPD_MAX_MS);
@@ -142,7 +142,7 @@ static int atana33xc20_disable(struct drm_panel *panel)
 		return 0;
 
 	gpiod_set_value_cansleep(p->el_on3_gpio, 0);
-	p->el_on3_off_time = ktime_get();
+	p->el_on3_off_time = ktime_get_boottime();
 	p->enabled = false;
 
 	/*
-- 
2.38.1.584.g0f3c55d4c2-goog

