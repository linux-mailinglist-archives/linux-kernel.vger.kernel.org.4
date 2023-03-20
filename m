Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CFD6C1564
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjCTOqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjCTOpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:45:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F301CBC0;
        Mon, 20 Mar 2023 07:45:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so16745718pjt.2;
        Mon, 20 Mar 2023 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETBxoAbrNslCbg8f3yN7x2XxTKk/U7inb50D/YGBCKI=;
        b=AhmyuHGG/8/igp1P9vAPy7ZPfETRY0TeHFg6mYwFSEp4TLgeIwiFdiaf87Ez+cq6wm
         C0AW68YtTAXKI9AjPeHGpqoOKDOJViRoc8P16XiAr8I0ETNoavUX0aN2VHu+L3I9EpAx
         94JZm4mKBNIp2ZQQhCmhmIZ27ex95EPXwwPo+NBFflXpuSJp8pFQ/0voEc1oCOpHxoni
         8ULQEqZIlQ/lAaBa+oSmDtiumvwxw3FoD1C5KzD46aL5yq6V/jfmsoA6q9c/g0UnjK9Q
         +ppWuOEEO16lI8FMgRLUeqiUz80fjx84GrCxTDpQrCeJtaFq7ZgM+N/oZ2y/H2BMqU2+
         UzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETBxoAbrNslCbg8f3yN7x2XxTKk/U7inb50D/YGBCKI=;
        b=KEvqarqcrvlBApjWBE72fLKpENpHDpvn2MVPvp2Hi+64Swsd19Cg6oCfmBSMSUYJ52
         OS3p266Ztq/vE0tFzr0gQlw1/9pbyi1dqHRR4OSprxH9gdL+fSdi4YSq+Y2MZtqb3X5j
         wRMAudID0EUcGzqQar3CBTov7Gh3Vd2Zk+r4ukh2gLDkw7jxoL419I0g8qzS+QCIMBhk
         c6a5vP6C1R6yyuDojzruDyp+mP4gG/DO1K/TCt5ZzNeRNPLNyvexnOyWKDl5mpOGb7m1
         4q4NSAef2LzHe//Qdz7M8iHVMqwrnl9XcZ2NrQFE/YhMXtwipek6dHWG+D3xni/dvaPe
         ocSQ==
X-Gm-Message-State: AO0yUKUa7ihIEq3B9haywr+Bxc9m336hX4xygtAb0AeB7e6iITPNQPxd
        omzTZKNLKwg92Eil4VNJLiE=
X-Google-Smtp-Source: AK7set9nBsw0YboqA8HGtkhw/1efSi+yfRsWBIzz4ldlha0ygO0WznYR00bgmoDEmsF5J6m1TLVXgQ==
X-Received: by 2002:a17:903:280c:b0:1a1:adb0:ed72 with SMTP id kp12-20020a170903280c00b001a1adb0ed72mr9170835plb.4.1679323506157;
        Mon, 20 Mar 2023 07:45:06 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902ee5100b0019339f3368asm6853516plo.3.2023.03.20.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:45:05 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY (DEVFREQ)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 16/23] PM / devfreq: Teach lockdep about locking order
Date:   Mon, 20 Mar 2023 07:43:38 -0700
Message-Id: <20230320144356.803762-17-robdclark@gmail.com>
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

This will make it easier to catch places doing allocations that can
trigger reclaim under devfreq->lock.

Because devfreq->lock is held over various devfreq_dev_profile
callbacks, there might be some fallout if those callbacks do allocations
that can trigger reclaim, but I've looked through the various callback
implementations and don't see anything obvious.  If it does trigger any
lockdep splats, those should be fixed.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/devfreq/devfreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 11b774048bd2..5ce3bf9b59e7 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -817,6 +817,12 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 
 	mutex_init(&devfreq->lock);
+
+	/* Teach lockdep about lock ordering wrt. shrinker: */
+	fs_reclaim_acquire(GFP_KERNEL);
+	might_lock(&devfreq->lock);
+	fs_reclaim_release(GFP_KERNEL);
+
 	devfreq->dev.parent = dev;
 	devfreq->dev.class = devfreq_class;
 	devfreq->dev.release = devfreq_dev_release;
-- 
2.39.2

