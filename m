Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F79652820
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiLTU6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiLTU6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:58:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5581DF1B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:58:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s6-20020a259006000000b00706c8bfd130so15433277ybl.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xKXJYD4y3GZm6HnbUvNVngViJ+1dwURTi8LZvK89erU=;
        b=RXCH9eozNGJe68h9FMYrzQJhw22LY0QHXX6+wB2um85IcAi5F13jRtC7I0TNFbJIar
         RwQvRrrx7hfydCNo0RhFfUO89kcOUdFDqQDCHOt4/Iifcm1/zFd3wX+48WBj+rWbV1ZT
         v2kGq6yI4qZj5C14WmsSZIK8enEWBQbGS4KpYT3VvM6NafsmikBtRWx1bcZPBkCYeEXM
         ZrCsjNSciIkJu9ZGo027Kyo7DBkJ1Y4VcNjzH5HCVG73UcVlirgFm+ql7XrJ363COUiG
         EKvLb1wejLOUOro1C4+BpciF34R+J4JCJcXFqZCJ6R1Ks5lIbZ2NAuvIVUL3cfOq/oLc
         sNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKXJYD4y3GZm6HnbUvNVngViJ+1dwURTi8LZvK89erU=;
        b=rMKPag+QwpLjWxjFhjSSUXXN29z5srEvdQXwIycZhp2fkmz0BgrCHN3jp7pwSw54G3
         d/BKkokE+dnxntQL5V2yPvfgalW6NNN2am1fSdUmX0Oon+7AsCflJHbASnH9bNsmMIzU
         gKjnMCVZRU9Kj5k5tAo/an/UJ4lpfMPvN2tuy6Fbodxil1mgmB7+XABy4WFJEHv7lcHn
         4DyB+jIUr/pzV3RSWdgCicJ1JgdkOK7iiYXDVixN+a3SZOHUuyR7kXWYPiMb7k2adAdQ
         tLWzHgD/JyMxSz23NPlX4IFDelPT/TgXa4DiyHpau9bciWq3SN+IgL02S20J/OTgZwAb
         93vw==
X-Gm-Message-State: ANoB5pnXG9HepNHOnYSKfrIhUT/Jcy2m+ZUXDCzqrScuQOdq9u5S8AV5
        CWbKC6O80oZc+7HYqCXxUfbCRV8=
X-Google-Smtp-Source: AA0mqf62lrjKa/xKuoPUB06pOfTcVG9jO7sxI6hq7SOB/NNrncyWkccriCLbejKVXjezqQgqvYhpWDE=
X-Received: from ptf16.nyc.corp.google.com ([2620:0:1003:314:ef24:68f2:407a:84b9])
 (user=ptf job=sendgmr) by 2002:a0d:e783:0:b0:3bc:d289:f4b6 with SMTP id
 q125-20020a0de783000000b003bcd289f4b6mr4168855ywe.417.1671569913163; Tue, 20
 Dec 2022 12:58:33 -0800 (PST)
Date:   Tue, 20 Dec 2022 15:58:26 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221220205826.178008-1-ptf@google.com>
Subject: [PATCH] drm: Add orientation quirk for Lenovo ideapad D330-10IGL
From:   Patrick Thompson <ptf@google.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Patrick Thompson <ptf@google.com>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panel is 800x1280 but mounted on a detachable form factor sideways.

Signed-off-by: Patrick Thompson <ptf@google.com>
---

 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 52d8800a8ab86..3659f0465a724 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -304,6 +304,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad D330-10IGM"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
+	}, {	/* Lenovo Ideapad D330-10IGL (HD) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad D330-10IGL"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* Lenovo Yoga Book X90F / X91F / X91L */
 		.matches = {
 		  /* Non exact match to match all versions */
-- 
2.39.0.314.g84b9a713c41-goog

