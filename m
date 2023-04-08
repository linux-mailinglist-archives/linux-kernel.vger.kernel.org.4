Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F42B6DBC39
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjDHQvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 12:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDHQvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 12:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CBA173C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680972628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qy6SYd3f0i8ho8eow+vyxJgxXrM08wU7g/SGD1LI0yQ=;
        b=VXCzxBMlZ525F0Z4tGvRyNZxM2EU8OT2jeYkgdXqvJKh0+/hrfJHA7Rv6WtrEap4haKS0S
        CCC0CZOCG8G/0t2GRXaXJSgWpDh+j6Glb9SU52dQz14PP6kiKfA/KiXZoACIrxwE6v6UjF
        MMZO9Psk0CGuPhw8/sdUwJCDPHa7g/E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-5C9VBM-rMvaCnqCQBkeXJw-1; Sat, 08 Apr 2023 12:50:26 -0400
X-MC-Unique: 5C9VBM-rMvaCnqCQBkeXJw-1
Received: by mail-qv1-f71.google.com with SMTP id pe26-20020a056214495a00b005df3eac4c0bso17555174qvb.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 09:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680972626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qy6SYd3f0i8ho8eow+vyxJgxXrM08wU7g/SGD1LI0yQ=;
        b=Q/yXBFvwmb4Uq5CJAyMVv6iSRveDbVv7I0z9q+hhumZOJ6VButcOi08juQzUfdpOkk
         P4oaRAAFMzrLqD5L09gRFRsfZQfAIewThe8sI43nTnv15EpXarQ44uh0Yw5yrG7rawk/
         S1hOSHpt+QYXA0Eh6Ro5Hh8vw20Pym4GySnpwVtAVJW77W8o8Vo76mOx2yt4aDMZcf6n
         X8hMGwO3aSzEJT7brNI1m2RHSs4Npm7VLW+XUUsQJ9IhEP2oFz1fziX8STaNlJVz8qDx
         fh8EDhIDpp8swpRlHm25qtHornSsYL8jsVn4UyX+nU0+egI1TiUSZ/DkPfKBN2VEbKLm
         Wxaw==
X-Gm-Message-State: AAQBX9cQP04uGTxyYuM1Tz90w/XcqaxSFS5srJrRzFVVWFIAl5ghUajl
        yQ98o/R8VjcPPCUQgbsO4O8B6qHyd5ygvC81kGdgJNR1Oyb9aGkIhKR8XYWWB20XXbgmFEQbDOL
        62S9nJJQx57XQU16WrcmXLQUS0vHsTWfP
X-Received: by 2002:a05:622a:15c3:b0:3e1:b06d:e9e1 with SMTP id d3-20020a05622a15c300b003e1b06de9e1mr3842258qty.57.1680972626208;
        Sat, 08 Apr 2023 09:50:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350a46s9y+/itqppzPjf57cV1ZevRRKIKzqVvsO1UIrG/xBtSg7j5IKxAIQvMkkT/GV64uTG74Q==
X-Received: by 2002:a05:622a:15c3:b0:3e1:b06d:e9e1 with SMTP id d3-20020a05622a15c300b003e1b06de9e1mr3842236qty.57.1680972625999;
        Sat, 08 Apr 2023 09:50:25 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s128-20020a372c86000000b0074688c36facsm2113865qkh.56.2023.04.08.09.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 09:50:25 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     airlied@redhat.com, kraxel@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com
Cc:     virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/qxl: remove variable count
Date:   Sat,  8 Apr 2023 12:50:23 -0400
Message-Id: <20230408165023.2706235-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable
  'count' set but not used [-Werror,-Wunused-but-set-variable]
        int count = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_cmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 281edab518cd..d6ea01f3797b 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -421,7 +421,6 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
 {
 	uint32_t handle;
 	int idr_ret;
-	int count = 0;
 again:
 	idr_preload(GFP_ATOMIC);
 	spin_lock(&qdev->surf_id_idr_lock);
@@ -433,7 +432,6 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
 	handle = idr_ret;
 
 	if (handle >= qdev->rom->n_surfaces) {
-		count++;
 		spin_lock(&qdev->surf_id_idr_lock);
 		idr_remove(&qdev->surf_id_idr, handle);
 		spin_unlock(&qdev->surf_id_idr_lock);
-- 
2.27.0

