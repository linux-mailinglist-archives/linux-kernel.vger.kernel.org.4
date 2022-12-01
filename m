Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F4263E75E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiLABz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiLABzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:55:37 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4F3E16;
        Wed, 30 Nov 2022 17:55:36 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 140so509392pfz.6;
        Wed, 30 Nov 2022 17:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C8hpJ+dhKLwcq6yGKXl9JYCXBoLbIiY9R+toMXs7xSY=;
        b=PXW7kMdCN3ai+CI0xhP8dUH6+O2YzxU2IhSV5eUBFDR4EwrNFfWs9iu7/OUr82Un6v
         Xf2FxRIXxOn71D8Csqze226LrlxI2ZYZgVWHq8dAdMV0Yr3bRyOZ3UbFb7rA0qIdsFHi
         SKiZSi5nqW4qutJZNdS9mLQZykYBw+dVCuW3lFaN4P+n8nvRhHBnAo5t7BnJeMlX0P7p
         vNxhz5gBRw/Qwhol3ns2Y4F1VMvh6Qg7GefnnMVokuX+Lo3UTT72XDF/yqHTLJogFzSl
         VRzU5lLsVhFSl0PojqcwKhDkrjQEXpRdONrkgc+bD27rsP26wYC2DJxHIn7jC7CiOUE9
         iD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8hpJ+dhKLwcq6yGKXl9JYCXBoLbIiY9R+toMXs7xSY=;
        b=tW42Axpamc9EBmBe98OZI4lEypyZMzFWQQW0wlN3ghWYXKS1mzsubZjO/GIt4MRTkf
         xxTBOhY2smBjc7QFOJuhI8jiR/BcuUD1EIAwATE8X3csRnH3dFJ45RCtNzBwDKma9+7D
         qgo0EGxoLj+0282dh0RvXu8zj+iSBb8Ga0vSwo9t4Z3ApACSen5l93FaNMKdKOinbD9c
         dzn7DXh5VQTSTbzl+QytJnWBHfZTG3FiMEgkYPvvXibX6wwa8KSLSoZhk1c5wiElTFQR
         74E+UBBIYVCnNsDjO2DYgcfYWpv8vuU+RbIRWBTz/SQ9keCEYUMkr5yzPGBbRE4cMKhV
         wnUw==
X-Gm-Message-State: ANoB5pkc++zu8nYLxEWIUuX6au3irgAv/MyAe+JlbGjYPrRV1odYmm5y
        gfAtKBViO2TCAvmW/G7SnKg=
X-Google-Smtp-Source: AA0mqf7W++ZGlAQng+eeRI1JZVWPEnuY6Xb3IZoLdPXSTzOLfDjzAs7B0Z6Sl0DCk+ll7W7tSZa5qA==
X-Received: by 2002:a62:8446:0:b0:574:8c08:6c15 with SMTP id k67-20020a628446000000b005748c086c15mr34168668pfd.82.1669859736108;
        Wed, 30 Nov 2022 17:55:36 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id x9-20020aa79a49000000b0056e0ff577edsm2013079pfj.43.2022.11.30.17.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 17:55:35 -0800 (PST)
From:   zys.zljxml@gmail.com
To:     thierry.reding@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH] gpu: host1x: Remove redundant null checks before kfree
Date:   Thu,  1 Dec 2022 09:55:21 +0800
Message-Id: <20221201015522.38163-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yushan Zhou <katrinzhou@tencent.com>

Fix the following coccicheck warning:
./drivers/gpu/host1x/fence.c:97:2-7: WARNING:
NULL check before some freeing functions is not needed.

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
---
 drivers/gpu/host1x/fence.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/fence.c b/drivers/gpu/host1x/fence.c
index ecab72882192..05b36bfc8b74 100644
--- a/drivers/gpu/host1x/fence.c
+++ b/drivers/gpu/host1x/fence.c
@@ -93,8 +93,7 @@ static void host1x_syncpt_fence_release(struct dma_fence *f)
 {
 	struct host1x_syncpt_fence *sf = to_host1x_fence(f);
 
-	if (sf->waiter)
-		kfree(sf->waiter);
+	kfree(sf->waiter);
 
 	dma_fence_free(f);
 }
-- 
2.27.0

