Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392917118AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjEYVCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241863AbjEYVBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:01:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7861B3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685048459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tJfvnTa7LvHqmI8tQ9doB+bZM4q5v1Nf/27PBhPpK8Q=;
        b=HF1RBgsCkocZ+fYQ8QA76lty5HEu0aK10GwVEIv1lOfN43fCefB1qH4JPX4LvSf1cBG/JN
        lET+P8rbJS2Ux4Cs2OZvL8C3jtuPFlURcMC/I+busNDvjTVAZrOW11G+xQFvpIP4QEIMBL
        vj7xnJpprqyu9gHd3CyVL0wAlcXTmuY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-I4qFxg-5Nj6vGzs8IbW2mg-1; Thu, 25 May 2023 17:00:57 -0400
X-MC-Unique: I4qFxg-5Nj6vGzs8IbW2mg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75b02834141so8768485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685048457; x=1687640457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJfvnTa7LvHqmI8tQ9doB+bZM4q5v1Nf/27PBhPpK8Q=;
        b=AQkZBakUP1Lgrvrr9nicq7ygVaJ6/jEhfM/xh6BRp15wThjx9qZqCVw5ppc3SxtLUk
         /e9zUQ61g609l59tySmGOjvFoEHJlyO85Q3usnd4xIDnYsFuYhw9EbAJVz2V3d3L4P3/
         ESlmWgtfoT5qXX8NR5pyGmR/uyuRbYhtuueVEKQSt09XMiJQl+3I8rDfrrYOW+dwAOl/
         xP8hF5mcikLnHw//3rfbSUM57FjcmOjTLLQg8cTvchLqQsT4dTVpFWN5upJzcUxiFlh/
         /Fi7LrB6fKbXeKzpULVmleVVUzZQg1mt7XXFCj2vdfojUror1yKSpQiRutIuzdH/Xh0o
         LsnQ==
X-Gm-Message-State: AC+VfDw4MFczZ6Bucou6a17g/9oFJ7s6PIMb7KENTisI1t4G+YRq8pnl
        GmWDAHHMMbjn+CnOViTyLFf59Kr37SGzXRAcc9aUIbdpf4yE5k1IOIkxts+0eSx/6dQvCcBkT0W
        Yd9fBDQwK/yp5bkzdLfNngLae
X-Received: by 2002:a05:620a:4894:b0:75b:23a0:d9c7 with SMTP id ea20-20020a05620a489400b0075b23a0d9c7mr2663qkb.29.1685048456902;
        Thu, 25 May 2023 14:00:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xll8jco9wkwI9OOHu1rNZaj2ifaVP4j38rDEla1Dsbharx5BlkOzrgfF9xnXt6hzd5Vaefg==
X-Received: by 2002:a05:620a:4894:b0:75b:23a0:d9c7 with SMTP id ea20-20020a05620a489400b0075b23a0d9c7mr2648qkb.29.1685048456666;
        Thu, 25 May 2023 14:00:56 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o15-20020ae9f50f000000b0075b0c1f4ad6sm684847qkg.0.2023.05.25.14.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:00:56 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/radeon: remove unused variable rbo
Date:   Thu, 25 May 2023 17:00:54 -0400
Message-Id: <20230525210054.3233539-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 reports
drivers/gpu/drm/radeon/radeon_ttm.c:200:27: error: variable
  ‘rbo’ set but not used [-Werror=unused-but-set-variable]
  200 |         struct radeon_bo *rbo;
      |                           ^~~
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 4eb83ccc4906..de4e6d78f1e1 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -197,7 +197,6 @@ static int radeon_bo_move(struct ttm_buffer_object *bo, bool evict,
 {
 	struct ttm_resource *old_mem = bo->resource;
 	struct radeon_device *rdev;
-	struct radeon_bo *rbo;
 	int r;
 
 	if (new_mem->mem_type == TTM_PL_TT) {
@@ -210,7 +209,6 @@ static int radeon_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if (r)
 		return r;
 
-	rbo = container_of(bo, struct radeon_bo, tbo);
 	rdev = radeon_get_rdev(bo->bdev);
 	if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
 			 bo->ttm == NULL)) {
-- 
2.27.0

