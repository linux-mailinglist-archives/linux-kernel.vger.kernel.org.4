Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5240674000
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjASRdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjASRdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:33:22 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE01B48A05
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:33:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso2473433pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LPLlNSnzLIud/SdIjCx832sULylUvnbc8QUJ7Ss0K9I=;
        b=k1cvGWKFMNGBv17/1p6v1IzvK0wT7IqiQaY0qVkC9tFtXwvnQeVPQI2Ave2sLVk2e0
         MfuORfn+YssgcdOkxHddBrrGWaafBL5IURnRtFlvY+e5+W4Og+ghhiUHLxN4jjdybZKd
         FTeoilFVWhfnfVDBFSUBRG0PTbJLHyco19q4i/XPJ48+lVMv3yAtRMr/YaPoKBbjGOhr
         5r5sfXajaygIY7QmIfKP9AM0yOgw+qMvcpeb6kxlZbXJ7cxkoupDp3VMRiLePsuT87AT
         IVokInBr9wvB6h6eApokTwZZ5nH2Br01Jrkn5i6jgjOiJE0U4l0EnAWYj1t5TRUonDU0
         l/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPLlNSnzLIud/SdIjCx832sULylUvnbc8QUJ7Ss0K9I=;
        b=epdlO0afnMiFy00g3JAu/tYKds1mvb6ZhsoPd4Cfzz2p0C9/imUU/pDUMyjYV/eUfi
         2OvUe19X88kxnyoLztgATycVjZ8TG9wYC0aMQZ1n8I9LQ/PlU5hmGU7UdMdl5DrcGGtj
         PR+Uc4fbSOEgPHkoiBeTSl7ztNJEIEsU7Nnxs5MxWmjFFijxqKtzS0+LsYuMR7cakjzw
         1demIv8FNGwRrl+HrBh5/djO22zTNngpj0n0pTDZR8YvUy0RJ38lOJGTBxNhS99I28Lw
         Mvqf48QCMb1PlxkYHau5ZIZ19I4+ud1b23W5fHivh3S9puuOAOq5CcMhosKqqZ5FMdck
         q87A==
X-Gm-Message-State: AFqh2koPct4hr9PfHGtYJHTZ+39OFzb278KEjWcSbyyeKYYRUFeDCIQS
        DdgO99eXTrs9/AoNOPk3V1c=
X-Google-Smtp-Source: AMrXdXv2qS952OsbhGL/YPtOfwGxEviqVp97NLihSuTFSqNi0Ri2Pdr4RxBMsphukL35cOs0qRhcEA==
X-Received: by 2002:a05:6a20:d045:b0:ac:3f3f:9fbd with SMTP id hv5-20020a056a20d04500b000ac3f3f9fbdmr13438174pzb.48.1674149600323;
        Thu, 19 Jan 2023 09:33:20 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id k36-20020a635a64000000b0048988ed9e4bsm20523336pgm.19.2023.01.19.09.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:33:19 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        katrinzhou <katrinzhou@tencent.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/i915: Avoid potential vm use-after-free
Date:   Thu, 19 Jan 2023 09:32:58 -0800
Message-Id: <20230119173321.2825472-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Adding the vm to the vm_xa table makes it visible to userspace, which
could try to race with us to close the vm.  So we need to take our extra
reference before putting it in the table.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
Note, you could list commit e1a7ab4fca0c ("drm/i915: Remove the vm open
count") as the "fixed" commit, but really the issue seems to go back
much further (with the fix needing some backporting in the process).

 drivers/gpu/drm/i915/gem/i915_gem_context.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 6250de9b9196..e4b78ab4773b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -1861,11 +1861,19 @@ static int get_ppgtt(struct drm_i915_file_private *file_priv,
 	vm = ctx->vm;
 	GEM_BUG_ON(!vm);
 
+	/*
+	 * Get a reference for the allocated handle.  Once the handle is
+	 * visible in the vm_xa table, userspace could try to close it
+	 * from under our feet, so we need to hold the extra reference
+	 * first.
+	 */
+	i915_vm_get(vm);
+
 	err = xa_alloc(&file_priv->vm_xa, &id, vm, xa_limit_32b, GFP_KERNEL);
-	if (err)
+	if (err) {
+		i915_vm_put(vm);
 		return err;
-
-	i915_vm_get(vm);
+	}
 
 	GEM_BUG_ON(id == 0); /* reserved for invalid/unassigned ppgtt */
 	args->value = id;
-- 
2.38.1

