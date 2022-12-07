Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBEA645902
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiLGL3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiLGL3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:29:21 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB112E6BF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:29:20 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p24so16761770plw.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 03:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt0s6DqATufn0DNLjv/Y4V9qqe/cu6nc3D6m36jdz8E=;
        b=crhz935DKX64Fr36S335EHU59RoazmPtGrt0qI7BOOSH1fCM5gIZyS2SJVdSAfEMZn
         qhRJwfUb/mhUoVszPDEUSZgu/FRX7M45GIrzgQSvZyDZb18DjRD+mI80hb5WJaFzTWeZ
         QdSZ5tmvS0X9Vf2fN4vkKKiZ1SmxNGsZRJy5zKkAR3Am52rr37KeEkYjj8wyJMDBraCl
         mvq76fS+bZXXPsLM3p7dYRhP1WbAbbJ1FnLoNAFGcSYcaoF2nt9aAnXK1xjZBfIFylSI
         1r3K2GR6x0gwHRJRDO/vil6BECqyAycgw6Aok/SMwE3NnNhBvl+1j7QKULNKtT7E6zjD
         HEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xt0s6DqATufn0DNLjv/Y4V9qqe/cu6nc3D6m36jdz8E=;
        b=sy6F1G61qf/4+GG8fifJXhjUVthWFY4kHhoqW0tfoQEPyTUKy/ILzlmVVCLkWOuYoo
         Mu/bIQzMxF3UdKpY6y0curLlZV0QSrEbp6I+aJkNuJYNBFJO6i+l4JEIcvBkqK+WNr2B
         QeO1tW4OCEbAtlIGWrUtREI29w8OQtdz80ccADJee41sB2GoZ/Uh+A5wM5YzNtVbpsRk
         O+LS8EPX4elR4G+xBdjIaWR6Y7n12jAYkqhYo2MMAm0HwCL0Vf4ZG/eES1K9B0nv0BmT
         feh/sf4MOo66IWK/HMBQT3dUi+Br0lZFXVDrzuMSMYwDKTCkfFHX4+VQFtR5hpGdOEEc
         d5Gw==
X-Gm-Message-State: ANoB5pknaPbRXqhA5mxRIngBJu6gcQRvcx8cpc5P8vBlpjhjvcNRIVQ3
        bvAo37ZzsbBipoXH2anPwX56cCtQOeRYfPEF
X-Google-Smtp-Source: AA0mqf4K2lKCaERMfu5mWJUHG4BGTld9gSMyUjyjjBecCE6g9XzI/uw9U8eXqqVsJLU8pXDrjybYZQ==
X-Received: by 2002:a17:90a:e648:b0:219:2567:dc1e with SMTP id ep8-20020a17090ae64800b002192567dc1emr54697020pjb.237.1670412560302;
        Wed, 07 Dec 2022 03:29:20 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id i15-20020a63130f000000b00478eb777d18sm1372807pgl.72.2022.12.07.03.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 03:29:19 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] drm/i915: Fix documentation for intel_uncore_forcewake_put__locked
Date:   Wed,  7 Dec 2022 15:29:09 +0400
Message-Id: <20221207112909.2655251-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_uncore_forcewake_put__locked() is used to release a reference.

Fixes: a6111f7b6604 ("drm/i915: Reduce locking in execlist command submission")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/i915/intel_uncore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i915/intel_uncore.c
index 5cd423c7b646..acb40543eb32 100644
--- a/drivers/gpu/drm/i915/intel_uncore.c
+++ b/drivers/gpu/drm/i915/intel_uncore.c
@@ -819,9 +819,9 @@ void intel_uncore_forcewake_flush(struct intel_uncore *uncore,
 }
 
 /**
- * intel_uncore_forcewake_put__locked - grab forcewake domain references
+ * intel_uncore_forcewake_put__locked - release forcewake domain references
  * @uncore: the intel_uncore structure
- * @fw_domains: forcewake domains to get reference on
+ * @fw_domains: forcewake domains to put references
  *
  * See intel_uncore_forcewake_put(). This variant places the onus
  * on the caller to explicitly handle the dev_priv->uncore.lock spinlock.
-- 
2.25.1

