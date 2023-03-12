Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883B06B6B55
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCLUnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjCLUmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:42:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6C23B21E;
        Sun, 12 Mar 2023 13:42:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so15048492pjh.0;
        Sun, 12 Mar 2023 13:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678653761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETBxoAbrNslCbg8f3yN7x2XxTKk/U7inb50D/YGBCKI=;
        b=UL0wiKz4KiPifc9v8jO42gd8BNURYM9h75Sx3INvyxosx9LLnhXPjEeuTBxFMBUJXY
         /mlcX0mfa9BHN9Awv2tKzMxLHZxdv/XEl6HlzOaI/j6pYf70+TlqXXIqtuc1d1AVL3U+
         A01lKDJ+vHG1B/IM0KlAjDVAu+uAx6VvAlph41qDmDWuhU5CkZ38fbkoIwCSGweyvB87
         4EgbnHSjNzCKQC9FZcyv/ECJM1qziprUth8q0QNI5XrYVUqmJ14uAGTpnEa5ATzR9mKR
         Z6UB5r+xA5SEO3RcXAYHTEm9Y+/5O8GAF2Jg1u/kkaH/vPLZ8dZP6lvgYxMWGLisN9Yl
         iIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678653761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETBxoAbrNslCbg8f3yN7x2XxTKk/U7inb50D/YGBCKI=;
        b=mIhf4fMAgUhHfQPJIUpIfz3rSy5cNBom+vRVMZEqL3Q2Y+sLIrgPOOb3iG+c+kktmO
         RBRy83ggKTkagoJ50gAogBcoPL2oy/fdInlIusckXmj7V7YVCKXkEp5MtkARdrJxcBLZ
         S2FuwhZXphHvZrnGbJTpHFi2X4FlsfxI4jwXVmAo/MR/EGdwty5aMbB9gfCLTOi1Z5D2
         SrfCj7yXlnrR1gVmdgQ1yYIirBrvaZDnp/NNeWcqU6dKbvJOQtOXc5cPUjL+Gi3Li9x+
         AfLeWrQgHFgYc9cI4li04WPHSLPSmVPtCbMw5UhOzbD+RGgYjOrAVbwgzHMfrd4d6qb2
         6O5w==
X-Gm-Message-State: AO0yUKVlZS911/pqBroyFM6mrBP/tBKAVhEJMQ3xqMNREU2pw0hpirYP
        257ikHBggAOBLt5+ZvtvIB0=
X-Google-Smtp-Source: AK7set+rXLhKPDCm8P7o+cVlVPeEg/Xp4bPKsrPllcqxjFJybvnW61FVqm65akYCijFEv5MoEag7uA==
X-Received: by 2002:a17:902:dac8:b0:19a:a650:ac55 with SMTP id q8-20020a170902dac800b0019aa650ac55mr7163529plx.23.1678653761364;
        Sun, 12 Mar 2023 13:42:41 -0700 (PDT)
Received: from localhost ([2601:1c0:5080:d9fa:9b45:95de:f47d:f85e])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b00189f2fdbdd0sm3205355plb.234.2023.03.12.13.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:42:41 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY (DEVFREQ)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 07/13] PM / devfreq: Teach lockdep about locking order
Date:   Sun, 12 Mar 2023 13:41:35 -0700
Message-Id: <20230312204150.1353517-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312204150.1353517-1-robdclark@gmail.com>
References: <20230312204150.1353517-1-robdclark@gmail.com>
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

