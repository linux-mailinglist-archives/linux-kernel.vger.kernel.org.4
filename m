Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD386C1552
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjCTOpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjCTOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:44:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBAAE1B0;
        Mon, 20 Mar 2023 07:44:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d13so12380068pjh.0;
        Mon, 20 Mar 2023 07:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpnnpJi0jMpuVIirJnKhht3Br4nZk/nWgbLPyeNVKoM=;
        b=NHg2rsAQuZBbVNpWJoQ7SMYcg1sSGv6708+Yi51sSumVAb7P4W0Sgz+ZApLe1OBqQ9
         X4zeyzHi7Wf4djrzl44O+b73TLhdaiCP0bG11wMhDpw/6pxLwiYlL/DiH+WLDYQCYKpY
         73ETis2vl6NE7mVLY6bltE4zQhwR94ZiaarsDBky65Sl+A2ZdOAvgjAWoL1RhZ71BZXM
         GWmAn7CXAaMoxvvx/9+TgN7MBQEYTlO/uGlA3CtgeEGwsBHV1q00mTLF2m0rEJI2Aw2O
         dK8VeGnQI4ASznl7F14ZJRe5gCd+knY0S0CGUEO6h7v/Dr3YeYiuQDFMBNJClq6nWmGR
         5Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpnnpJi0jMpuVIirJnKhht3Br4nZk/nWgbLPyeNVKoM=;
        b=TgMoD8l+oc2aMLbp8r8buP1Roj3tRWm3La7/HTgj7N3cHSOUf6UUymlWE2ZtVygch5
         aDTHHySkfqSzdfKXZ/Z6ZLBZHmEfKZoUPnC88jz4RasGGhxiqTGwqZaM5xYdwfTS+xg1
         R/myBN3gITQsX0tuFoGoV9t3GUX19cqRXcCrTjNE3PznFrtv+QQDiyiGXsdxdK46Mgdo
         Ay5jGl4tHFdvEB0ZTqRqInXcJK7zRvhaXaUl0O99wDnfo16AwB1EcEPv069zT3VbbUhK
         +fT9DS/N9nSykBTW2FwkruYXxkDFYFU7LRkVieU0hQRvR00rvRcPhpB6I+NOvqcO87H8
         t1yA==
X-Gm-Message-State: AO0yUKVkYdOlHPhEFd/dufZI8fDiTy1lsi4KgUsCheAxwu8rxXWN3Ga/
        D96JtpLHY4KIWKkXz0gVsa8=
X-Google-Smtp-Source: AK7set9gngSUjr4POl841Y/cEm5ZUCas4/gLzFTfM7Kwi3k2gQ4K9PnIhK/7pgWuEZJlzgwJ1vs7Yw==
X-Received: by 2002:a17:903:124d:b0:19e:7a2c:78a7 with SMTP id u13-20020a170903124d00b0019e7a2c78a7mr21091860plh.57.1679323481613;
        Mon, 20 Mar 2023 07:44:41 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b0019468fe44d3sm6806113plk.25.2023.03.20.07.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:44:41 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 06/23] drm/gem: Export drm_gem_lru_move_tail_locked()
Date:   Mon, 20 Mar 2023 07:43:28 -0700
Message-Id: <20230320144356.803762-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320144356.803762-1-robdclark@gmail.com>
References: <20230320144356.803762-1-robdclark@gmail.com>
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

Export the locked version or lru's move_tail().

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_gem.c | 11 ++++++++++-
 include/drm/drm_gem.h     |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 59a0bb5ebd85..693f7f35a7bd 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1344,7 +1344,15 @@ drm_gem_lru_remove(struct drm_gem_object *obj)
 }
 EXPORT_SYMBOL(drm_gem_lru_remove);
 
-static void
+/**
+ * drm_gem_lru_move_tail_locked - move the object to the tail of the LRU
+ *
+ * Like &drm_gem_lru_move_tail but lru lock must be held
+ *
+ * @lru: The LRU to move the object into.
+ * @obj: The GEM object to move into this LRU
+ */
+void
 drm_gem_lru_move_tail_locked(struct drm_gem_lru *lru, struct drm_gem_object *obj)
 {
 	lockdep_assert_held_once(lru->lock);
@@ -1356,6 +1364,7 @@ drm_gem_lru_move_tail_locked(struct drm_gem_lru *lru, struct drm_gem_object *obj
 	list_add_tail(&obj->lru_node, &lru->list);
 	obj->lru = lru;
 }
+EXPORT_SYMBOL(drm_gem_lru_move_tail_locked);
 
 /**
  * drm_gem_lru_move_tail - move the object to the tail of the LRU
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 772a4adf5287..a811c7e346ec 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -475,6 +475,7 @@ int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
 
 void drm_gem_lru_init(struct drm_gem_lru *lru, struct mutex *lock);
 void drm_gem_lru_remove(struct drm_gem_object *obj);
+void drm_gem_lru_move_tail_locked(struct drm_gem_lru *lru, struct drm_gem_object *obj);
 void drm_gem_lru_move_tail(struct drm_gem_lru *lru, struct drm_gem_object *obj);
 unsigned long drm_gem_lru_scan(struct drm_gem_lru *lru, unsigned nr_to_scan,
 			       bool (*shrink)(struct drm_gem_object *obj));
-- 
2.39.2

