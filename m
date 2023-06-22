Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FE5739B44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjFVIzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjFVIyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:54:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF52C212B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:54:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b515ec39feso12619125ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424083; x=1690016083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQaNNe8oXaUFeFpLguh+yca1iGAODo9pDL1sZw6pJSE=;
        b=bLkRMM1jSdqXsEty9KLAFC9vFSq6Mb8s85EPujNxx1fG7cL+WhObUy7eJvjIIVVT27
         Kiy5rsYxFdvQkjX/Hn7QfCF/H515sUldxTAV8THo6pKuerK5LdnjnrVU9ezaWAUUfrz8
         rV0yX1ewF3SUu27Tytlc8UIGxdmoc2rf5KwQXmt4TN0xZENUrrBpDEpOBdYckFOGmW+/
         CnWb/ghzLgegjrSPuJYmDsQVFRVYxO2XxU7X4C2jxwq5osf5N5i/+CYLyq1fNxhJsVCX
         q//piIl1OJNIHjgKTj8Fx/a4slkfZ5A+zdUvxvyRJBR/16JSIqSsZUTa9z9xdPFzC7nq
         BhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424083; x=1690016083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQaNNe8oXaUFeFpLguh+yca1iGAODo9pDL1sZw6pJSE=;
        b=hFWU4iTJTKXGx5QADSHVIaXAhSwZE2qJXKLrrmCR5VhYDpzpMPLKP9w9ODHRFj2ddE
         n67CatxmL1LumZZq+Wm2INz2IU+VCzjW2m2FXo1xa0fuS+4uJlqQipqB+uCqaS2JNzgN
         yRlgwbxMsenO7JB7U1bqZbZfG9QjTKuMd4jK7ZI72kJi2rL/0W3NfEFuXzysC718LrMD
         30tG/UETQrffA4VrzXoofAD+2qm3HMeMmMViB+21gJQBu7QpODi0RKQGYKnbyBDeZg/H
         Tdu3Li/1jsIxwtnPcz1Plc4Vk+YCFZOsMlw3olDFX10eHJ3yjE1GnE2fVOvv7iw+KprI
         O7AQ==
X-Gm-Message-State: AC+VfDzPDMySOxjF36CcQq8ywCDmD5+LZqo5vdPSH+AXs8NA2DyGFYS/
        RX2WeYi5AVcwB7xc4H0L/11Cog==
X-Google-Smtp-Source: ACHHUZ6gH/Pv0NlMjwBsqv6k+8Uik3ghEf6lWW7kovYDQCKB++KLEA1PTcfQABA8HOR66RClg4yAXA==
X-Received: by 2002:a17:903:32c4:b0:1b0:3cda:6351 with SMTP id i4-20020a17090332c400b001b03cda6351mr21555341plr.0.1687424083229;
        Thu, 22 Jun 2023 01:54:43 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:54:42 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 05/29] drm/panfrost: dynamically allocate the drm-panfrost shrinker
Date:   Thu, 22 Jun 2023 16:53:11 +0800
Message-Id: <20230622085335.77010-6-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for implementing lockless slab shrink,
we need to dynamically allocate the drm-panfrost shrinker,
so that it can be freed asynchronously using kfree_rcu().
Then it doesn't need to wait for RCU read-side critical
section when releasing the struct panfrost_device.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h    |  2 +-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  | 24 ++++++++++---------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index b0126b9fbadc..e667e5689353 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -118,7 +118,7 @@ struct panfrost_device {
 
 	struct mutex shrinker_lock;
 	struct list_head shrinker_list;
-	struct shrinker shrinker;
+	struct shrinker *shrinker;
 
 	struct panfrost_devfreq pfdevfreq;
 };
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
index bf0170782f25..2a5513eb9e1f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
@@ -18,8 +18,7 @@
 static unsigned long
 panfrost_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
 {
-	struct panfrost_device *pfdev =
-		container_of(shrinker, struct panfrost_device, shrinker);
+	struct panfrost_device *pfdev = shrinker->private_data;
 	struct drm_gem_shmem_object *shmem;
 	unsigned long count = 0;
 
@@ -65,8 +64,7 @@ static bool panfrost_gem_purge(struct drm_gem_object *obj)
 static unsigned long
 panfrost_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 {
-	struct panfrost_device *pfdev =
-		container_of(shrinker, struct panfrost_device, shrinker);
+	struct panfrost_device *pfdev = shrinker->private_data;
 	struct drm_gem_shmem_object *shmem, *tmp;
 	unsigned long freed = 0;
 
@@ -100,10 +98,15 @@ panfrost_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 void panfrost_gem_shrinker_init(struct drm_device *dev)
 {
 	struct panfrost_device *pfdev = dev->dev_private;
-	pfdev->shrinker.count_objects = panfrost_gem_shrinker_count;
-	pfdev->shrinker.scan_objects = panfrost_gem_shrinker_scan;
-	pfdev->shrinker.seeks = DEFAULT_SEEKS;
-	WARN_ON(register_shrinker(&pfdev->shrinker, "drm-panfrost"));
+
+	pfdev->shrinker = shrinker_alloc_and_init(panfrost_gem_shrinker_count,
+						  panfrost_gem_shrinker_scan, 0,
+						  DEFAULT_SEEKS, 0, pfdev);
+	if (pfdev->shrinker &&
+	    register_shrinker(pfdev->shrinker, "drm-panfrost")) {
+		shrinker_free(pfdev->shrinker);
+		WARN_ON(1);
+	}
 }
 
 /**
@@ -116,7 +119,6 @@ void panfrost_gem_shrinker_cleanup(struct drm_device *dev)
 {
 	struct panfrost_device *pfdev = dev->dev_private;
 
-	if (pfdev->shrinker.nr_deferred) {
-		unregister_shrinker(&pfdev->shrinker);
-	}
+	if (pfdev->shrinker->nr_deferred)
+		unregister_and_free_shrinker(pfdev->shrinker);
 }
-- 
2.30.2

