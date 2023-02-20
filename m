Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB19969D4C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjBTUT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjBTUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:19:38 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228771EBF0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:19:33 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id bh1so2745792plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Jl0bAAXIZTjQ7NsDAeqTzIEhvjQzgg5/X7BsK4u81Y=;
        b=VWGYtfqNhp7B6nf1c5rcB1hn1/aTMiBMh/TisbyUXTPDYchTD7dH8S55BhZKeSEIr+
         03hj8zQYZMESK/6c4d3fRxa/w4WooAzdJBPJ8/VWpaF06G1aHxdlKB29U3aBoRxl8pG9
         lhz4VFqMYDjNn7utqgYjWHabzq8ZYsRn9/jLbtpnATAFjeV84tvNiTTmjW21dkGa87Bo
         BCdG0VIoPT5IG6WL3vCWR5Cs/9pu+OSNC6ytsz3L6iomug5Ys/ZXtW1WbgYfoiPaWtwy
         eRK2/hsZTxMfAbRSugzRZV+8A5OAWYdt0Dxwq8bO0x5KyZMagHwy/xs0lWT9bszYL27m
         w8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Jl0bAAXIZTjQ7NsDAeqTzIEhvjQzgg5/X7BsK4u81Y=;
        b=DnNTepUIXS+W4Iheiz3LPfY/B6/bSRtQvkqtSjgKF60ivPfp5HO7r22DBSAMr6pmvK
         pT/AZ0fyRayINMA8HGFR5Tp+DIwUycX6KVjxi15Vcs2DhFV8r8agjsJMFKw9FhdHdcds
         MNFadcatavM/bL+Nzre5d8/Yc59I4XfFMa3OPZdOkWWTGwUsBK+jtUQUqc3GhDP4UEVu
         V/BlA5n/1JHoPZbsyrbqAHHOaxlYR7Aj/h/I05qoZM1H5IAu30F2MeEzg3xQBuEsEXFs
         AE1ACPEJvQb22odmz7ofG1I2B7CvmIsh0TW5bqFvFKVxyRVpL0cAYOlyKeFKVyv3dPDM
         A23g==
X-Gm-Message-State: AO0yUKWuOco3BbzK3ScBY2EaCVqK1PMnqfccQKIgt0Qs5O0fOgaRj/Wv
        qozuwdf3Fa/3SmXnB3sI50o=
X-Google-Smtp-Source: AK7set+q3MKo5iZVfbDma9lHblnO0T/NKkpxdHihd2LIe6SBmUPSnRLrjIdwXidmbST3DQEMqrXm3A==
X-Received: by 2002:a17:902:d4c3:b0:19c:17d1:28a4 with SMTP id o3-20020a170902d4c300b0019c17d128a4mr3168962plg.67.1676924372594;
        Mon, 20 Feb 2023 12:19:32 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ea8500b0019c32968271sm1910780plb.11.2023.02.20.12.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:19:32 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 10/14] drm/vblank: Add helper to get next vblank time
Date:   Mon, 20 Feb 2023 12:18:57 -0800
Message-Id: <20230220201916.1822214-11-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220201916.1822214-1-robdclark@gmail.com>
References: <20230220201916.1822214-1-robdclark@gmail.com>
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

From: Rob Clark <robdclark@chromium.org>

Will be used in the next commit to set a deadline on fences that an
atomic update is waiting on.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_vblank.c | 32 ++++++++++++++++++++++++++++++++
 include/drm/drm_vblank.h     |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 2ff31717a3de..caf25ebb34c5 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -980,6 +980,38 @@ u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
 
+/**
+ * drm_crtc_next_vblank_time - calculate the time of the next vblank
+ * @crtc: the crtc for which to calculate next vblank time
+ * @vblanktime: pointer to time to receive the next vblank timestamp.
+ *
+ * Calculate the expected time of the next vblank based on time of previous
+ * vblank and frame duration
+ */
+int drm_crtc_next_vblank_time(struct drm_crtc *crtc, ktime_t *vblanktime)
+{
+	unsigned int pipe = drm_crtc_index(crtc);
+	struct drm_vblank_crtc *vblank = &crtc->dev->vblank[pipe];
+	u64 count;
+
+	if (!vblank->framedur_ns)
+		return -EINVAL;
+
+	count = drm_vblank_count_and_time(crtc->dev, pipe, vblanktime);
+
+	/*
+	 * If we don't get a valid count, then we probably also don't
+	 * have a valid time:
+	 */
+	if (!count)
+		return -EINVAL;
+
+	*vblanktime = ktime_add(*vblanktime, ns_to_ktime(vblank->framedur_ns));
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_crtc_next_vblank_time);
+
 static void send_vblank_event(struct drm_device *dev,
 		struct drm_pending_vblank_event *e,
 		u64 seq, ktime_t now)
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 733a3e2d1d10..a63bc2c92f3c 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -230,6 +230,7 @@ bool drm_dev_has_vblank(const struct drm_device *dev);
 u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
 u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
 				   ktime_t *vblanktime);
+int drm_crtc_next_vblank_time(struct drm_crtc *crtc, ktime_t *vblanktime);
 void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
 			       struct drm_pending_vblank_event *e);
 void drm_crtc_arm_vblank_event(struct drm_crtc *crtc,
-- 
2.39.1

