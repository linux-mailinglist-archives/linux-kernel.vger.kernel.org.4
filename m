Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC626CBB2D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjC1JhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjC1JhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:37:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681A96588
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:36:37 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-62810466cccso571379b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679996197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8E4/REgp9ODotbn96PHap4rQOEyKET0fJwvNul5gBUU=;
        b=kcvEiLGcR7zycIQCd+7hOL4Mu8tar4WGIXDOhiTgEDa/iJ7d3OTT/k7PJ0fgfWXXCw
         0Qq/dQKNTMaRMovY+LFbJBFqk783Piejk6LlnJgvCJkowblsEMf6bgOnT8dYx7Slw5O3
         c4lwNAvDbXUy5ygcBsdUeliCWfCxdOMKo27IY84kWK2qw/b0T49UH0Li1xW2/nchWR0t
         jDwDlT6m0GVLjhrPmlh/QEBK8+BHVf+/MjEkdmHbFXEZuIHdiyntAaCkzJqTyNvjBiUp
         JSeDsk6aHCZqZWq2bC4Mid7Y9N+hPtf9IlJTldxhpCsnlASBl52AVIkvKAQv8fZiazyn
         oe5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679996197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8E4/REgp9ODotbn96PHap4rQOEyKET0fJwvNul5gBUU=;
        b=VxfEHIzhOwVIKfLz4u7t52Ay4DJvRUYiO5xMKSzxszEJKTjuo6cbV0+CaAjNoAcht+
         S6oOfMMXYvif0hhHRnebKYNiawvPOl1WXvNnY/qb5gyfG05Isv3CuhLvkoFp1yHlFcNG
         2c/4r337gcypd4aRzpi3CtKKvjokBPodBJr2BRlXCKrSa4q7SCq+cGmb8sKj4kOLVKae
         YRSCgNqKDsbpLZEtqGdACU3Lnr6a0KFuo09YHl/Ann2TtK4jnBi0OZg8O8j2Ri8ntR2R
         /EtKL9vi13N5vhu5ylzSAnt4hJLJ+6FOaRdAtVO3LwsOU6wkpki0PfHuCK2bnp94FA+8
         nUpg==
X-Gm-Message-State: AAQBX9ckSSxVcr/wKw1ngu62b8KshJeMXUgPXJEAgb8ZCwZB7D5l+h5C
        hnksx321HzePkE/1FK7jT/ATddVYRomiypV6E90=
X-Google-Smtp-Source: AKy350YleEYd7R05h2kxGvupb45hdhpsCF5j3upr5y4AS+OoezqifsjZF3EWhW3l3a7qAH1honoqMw==
X-Received: by 2002:a05:6a00:3002:b0:627:e180:ac04 with SMTP id ay2-20020a056a00300200b00627e180ac04mr12763467pfb.0.1679996196817;
        Tue, 28 Mar 2023 02:36:36 -0700 (PDT)
Received: from ubuntu.localdomain ([183.208.21.231])
        by smtp.gmail.com with ESMTPSA id i10-20020aa78b4a000000b0062619a002f6sm20512150pfd.187.2023.03.28.02.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:36:36 -0700 (PDT)
From:   Min Li <lm0963hack@gmail.com>
To:     jani.nikula@linux.intel.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@gmail.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drm/i915: fix race condition UAF in i915_perf_add_config_ioctl
Date:   Tue, 28 Mar 2023 17:36:27 +0800
Message-Id: <20230328093627.5067-1-lm0963hack@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace can guess the id value and try to race oa_config object creation
with config remove, resulting in a use-after-free if we dereference the
object after unlocking the metrics_lock.  For that reason, unlocking the
metrics_lock must be done after we are done dereferencing the object.

Signed-off-by: Min Li <lm0963hack@gmail.com>
---
 drivers/gpu/drm/i915/i915_perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 824a34ec0b83..93748ca2c5da 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4634,13 +4634,13 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
 		err = oa_config->id;
 		goto sysfs_err;
 	}
-
-	mutex_unlock(&perf->metrics_lock);
+	id = oa_config->id;
 
 	drm_dbg(&perf->i915->drm,
 		"Added config %s id=%i\n", oa_config->uuid, oa_config->id);
+	mutex_unlock(&perf->metrics_lock);
 
-	return oa_config->id;
+	return id;
 
 sysfs_err:
 	mutex_unlock(&perf->metrics_lock);
-- 
2.25.1

