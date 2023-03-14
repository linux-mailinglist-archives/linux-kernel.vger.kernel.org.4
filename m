Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269A06B95A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjCNNLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjCNNLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CA29AA0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678799188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hMEgWvZUG6qO1PqKglF/V8CaNHty0qtVjMQOxDeWDFc=;
        b=eLeprbCf3+2Kxhvb31Qf88ptOthdcN3d+MEfnuxnqB4a8Ey3R5vMoHyIjVmY75dD3aMhi1
        vkDa8ZquivieYaghHp8kTyxLzAdPNX5NlK1Rk8u5gqJyscDTKLtsQqlrNBaVWxOnspfUpr
        jHLwYIoLqlbToQCdanCKtHN/ae11BBA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-YF75hRKnPquPnmFM24U8Dg-1; Tue, 14 Mar 2023 09:06:27 -0400
X-MC-Unique: YF75hRKnPquPnmFM24U8Dg-1
Received: by mail-qv1-f69.google.com with SMTP id e11-20020ad4536b000000b005a9292e8c2bso2847653qvv.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678799187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMEgWvZUG6qO1PqKglF/V8CaNHty0qtVjMQOxDeWDFc=;
        b=Mwi/Pb+MjorHzWHN7j3/ikKzXOtbIfTCDXhBoTvhEwr3r0a4c3B2pAUHY/xEf+XIy2
         RwNv/4eV2NdwZwjKpSqFkT8O8Eglj87+g62qpkeLUsSZffgFtP45LSqgNhcqOE3Sy3YG
         FMydX8EqBe6InstQDU6xSWaUQdWvjiI9+00O/CxeV85456pD2feR2zL+3e1IFWWgC70F
         cl+3KJtVt3dMO8WiFTZCsvC6B+qsARpeQt9DhFUWBBu08VVrzZEf2kWVvIXjbksqXc8q
         XINZHrJJwD/Jhg0a0JJWcznbcjs9wjz1EsowEgBL+sHxGXjmRr4Z8UNCPKuRdjouKy7u
         iqmQ==
X-Gm-Message-State: AO0yUKXABhQTU44sN0HSIigkmxtR0GuzeUKBpSXELPzWdPZtZLu/6uoV
        KC9D8aQTgK/GlBKaxRrRrMBnjxFL21LjSbz+87OI5/kZUxjj9DbYOOYEfgr88zVL3Kmpxij0ubh
        pVKmr2Q0V0OH+WDQVFbXJCvaU
X-Received: by 2002:ac8:5e08:0:b0:3bf:c83d:5d4c with SMTP id h8-20020ac85e08000000b003bfc83d5d4cmr59779101qtx.64.1678799182200;
        Tue, 14 Mar 2023 06:06:22 -0700 (PDT)
X-Google-Smtp-Source: AK7set9k9IedTfQ65vtzZ6gDRjmULVgJGaURZvyzzIxUwogrHRw3OQKTz3pFVe2b8l6tkgGNH294DA==
X-Received: by 2002:ac8:5e08:0:b0:3bf:c83d:5d4c with SMTP id h8-20020ac85e08000000b003bfc83d5d4cmr59779062qtx.64.1678799181828;
        Tue, 14 Mar 2023 06:06:21 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 185-20020a3706c2000000b0070648cf78bdsm1731416qkg.54.2023.03.14.06.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 06:06:21 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/radeon: remove unused variable rbo
Date:   Tue, 14 Mar 2023 09:06:16 -0400
Message-Id: <20230314130616.2170856-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 reports this error
drivers/gpu/drm/radeon/radeon_ttm.c:201:27: error:
  variable ‘rbo’ set but not used [-Werror=unused-but-set-variable]
  201 |         struct radeon_bo *rbo;
      |                           ^~~

rbo use was removed with
commit f87c1f0b7b79 ("drm/ttm: prevent moving of pinned BOs")
Since the variable is not used, remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 2220cdf6a3f6..0ea430ee5256 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -198,7 +198,6 @@ static int radeon_bo_move(struct ttm_buffer_object *bo, bool evict,
 {
 	struct ttm_resource *old_mem = bo->resource;
 	struct radeon_device *rdev;
-	struct radeon_bo *rbo;
 	int r;
 
 	if (new_mem->mem_type == TTM_PL_TT) {
@@ -211,7 +210,6 @@ static int radeon_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if (r)
 		return r;
 
-	rbo = container_of(bo, struct radeon_bo, tbo);
 	rdev = radeon_get_rdev(bo->bdev);
 	if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
 			 bo->ttm == NULL)) {
-- 
2.27.0

