Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BFA62E60A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 21:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbiKQUjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 15:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKQUjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 15:39:06 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140302737
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:39:06 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p184so2312336iof.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZEHbyUygY8mL/VudOEJPrn+JnbHs5KjIjH28m2m7pA=;
        b=UER82uY/1H5jglIAPvq1HsO4gdv4BFQBRhaokleoscz7Q4tld2LY9bERy0ACZV8fhB
         IxIqhMTIkOn6F4rz+ndD8NGvcSuANM7pvoitxcDZcPvzhzsADp3S64VuG+X0BO9X0ker
         Ux1ahNLGD7fRkaIH2Ib+C1+uCkYKYrs9mWlXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZEHbyUygY8mL/VudOEJPrn+JnbHs5KjIjH28m2m7pA=;
        b=x/r5L4HPPqHQKN8dQbeCrwEBDMrn8DGLc5oKC+Ya5Fnn6ni+ttxI4QvYO/FTl944hX
         Ab2Xcn5P/BhKUz7hpypDkfzmWgEU1oo9EoFmFqS3pATY33qCekifpB9cK1VNSxdm8aA+
         pNl1ChY3i+TzJIyShmSNN4orajAardOunHaM167LT5kSlxXPQqsMkA/ziujGIeTRVGvE
         hkVQrGD+Lj5pi0zvPvkPqE8VQ7k/VRW8zZWkhnDFCd4UvuJl4TIgP9uow1p83m0JCRy6
         ThXMYH7Ms8a/0+Z1mnysmN7X3vZOLJGWSeuHKmZogFWo9p8e9v70kZpDasg3d23TofxW
         6haw==
X-Gm-Message-State: ANoB5pl6F4cCFR1jy6fMogsClFa5UDoPutHR9DaMztmhd3Uwdl2IxhOX
        f8uAA1YNT2wY1Fcv2Z36eDiC9Q==
X-Google-Smtp-Source: AA0mqf6DFioq87cI1ZJtq/Ye8wvmc8ZleSSIc+du2UJgDEkL5FsB9OHxasI3b5ipXufFJbhum4CRyA==
X-Received: by 2002:a05:6638:440b:b0:374:fbbe:2da6 with SMTP id bp11-20020a056638440b00b00374fbbe2da6mr1806005jab.163.1668717545484;
        Thu, 17 Nov 2022 12:39:05 -0800 (PST)
Received: from midworld.bld.corp.google.com ([2620:15c:183:200:b285:6808:3f3e:f538])
        by smtp.gmail.com with ESMTPSA id d191-20020a0262c8000000b00363da904602sm570192jac.13.2022.11.17.12.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 12:39:04 -0800 (PST)
From:   Drew Davenport <ddavenport@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     dianders@chromium.org, Drew Davenport <ddavenport@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm/panel-edp: Use ktime_get_boottime for delays
Date:   Thu, 17 Nov 2022 13:38:44 -0700
Message-Id: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ktime_get is based on CLOCK_MONOTONIC which stops on suspend. On
suspend, the time that the panel was powerd off is recorded with
ktime_get, and on resume this time is compared to the current ktime_get
time to determine if the driver should wait for the panel to power down
completely before re-enabling it.

Because we're using ktime_get, this delay doesn't account for the time
that the device is suspended, during which the power down delay may have
already elapsed.

Change to use ktime_get_boottime throughout, which uses CLOCK_BOOTTIME
which does not stop when suspended. This ensures that the resume path
will not be delayed if the power off delay has already been met while
the device is suspended.

Signed-off-by: Drew Davenport <ddavenport@chromium.org>

---

 drivers/gpu/drm/panel/panel-edp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 5cb8dc2ebe184..a0a7ab35e08c9 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -351,7 +351,7 @@ static void panel_edp_wait(ktime_t start_ktime, unsigned int min_ms)
 		return;
 
 	min_ktime = ktime_add(start_ktime, ms_to_ktime(min_ms));
-	now_ktime = ktime_get();
+	now_ktime = ktime_get_boottime();
 
 	if (ktime_before(now_ktime, min_ktime))
 		msleep(ktime_to_ms(ktime_sub(min_ktime, now_ktime)) + 1);
@@ -378,7 +378,7 @@ static int panel_edp_suspend(struct device *dev)
 
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 	regulator_disable(p->supply);
-	p->unprepared_time = ktime_get();
+	p->unprepared_time = ktime_get_boottime();
 
 	return 0;
 }
@@ -464,14 +464,14 @@ static int panel_edp_prepare_once(struct panel_edp *p)
 		}
 	}
 
-	p->prepared_time = ktime_get();
+	p->prepared_time = ktime_get_boottime();
 
 	return 0;
 
 error:
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 	regulator_disable(p->supply);
-	p->unprepared_time = ktime_get();
+	p->unprepared_time = ktime_get_boottime();
 
 	return err;
 }
-- 
2.38.1.584.g0f3c55d4c2-goog

