Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C046D269A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjCaRZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCaRZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDA91CBA5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680283469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+275kAcImYiE9dFTXdrtG3cpkttX7JRc/BM6QuCRJUs=;
        b=NYPpaODtMqxlI3+Q5ZRkY7vysdiS2y4FGDEIlDXYUlaKIpgaAskveYjyQCbrR/JZ13VOM1
        aM4G+bUwKjpkrH+ayVTo5mY0s8X6y7s8smElOKlyh3Ur33NL2uHnIFoytTTYE2LIbOPKdy
        9maHOEA4BeOlpYhDhKXiGSWkVSHC0zU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-MCe7VrB2P-GKE3LA0O3wQg-1; Fri, 31 Mar 2023 13:24:28 -0400
X-MC-Unique: MCe7VrB2P-GKE3LA0O3wQg-1
Received: by mail-qk1-f198.google.com with SMTP id d187-20020a3768c4000000b00746864b272cso10789788qkc.15
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680283467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+275kAcImYiE9dFTXdrtG3cpkttX7JRc/BM6QuCRJUs=;
        b=Go0x6y+LegvlP/+9JFB3/q+V3RLxgXUBpSq5uukbdre8X/CSV0eChD5xbE++4zttNb
         EAEA/WCNZhE5eIr/k0pZYBX+CslSYod+vnZI9RmYaxBRFrIFU7kGV+64Xo8ZdzRB794A
         lFPoBG+RT9TXi3iTUvs3zRZUBJQbVOKtGpFcWTzJXg5Ltt4SWdxAL+M/89iStI1EXYLB
         7ghHceSr+P3CXA/lWeRL/sOvoo4Y5MN1yZBfKNLu3j85qvcL6SaHVcOd2KF9dkUaJeNZ
         svh9x8tqrhH9nlY7vTXEMk5Cw7M5Hbd9xsHUMwBdFqZ0WNKwH/+5WoUCs6pW7XgaT68F
         6V8A==
X-Gm-Message-State: AO0yUKUi1XGzzd6bUEhjQ1v4tU4QCwdiopS24rDe1LQMUr/uxs45Hzmh
        iPJ9QipLwFZM0jWj8hqfRvUXRl39+pIWuTT5njvtcnKTEuVDILSIQyWANlXvgFRZ/jsJv3RU6Ri
        kVS6YyyG03TODge8ZgCM6+btu
X-Received: by 2002:a05:622a:215:b0:3e3:867e:1811 with SMTP id b21-20020a05622a021500b003e3867e1811mr50922121qtx.17.1680283467398;
        Fri, 31 Mar 2023 10:24:27 -0700 (PDT)
X-Google-Smtp-Source: AK7set9Sv9pA4EKixyjGPgkC70YS7QWxatBhiN9or/3O6SwY+f275wnQJfX5KnQMa83+KWSsgCh25Q==
X-Received: by 2002:a05:622a:215:b0:3e3:867e:1811 with SMTP id b21-20020a05622a021500b003e3867e1811mr50922089qtx.17.1680283467204;
        Fri, 31 Mar 2023 10:24:27 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b17-20020ae9eb11000000b00745c437b38dsm804613qkg.82.2023.03.31.10.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:24:26 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     airlied@redhat.com, kraxel@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com
Cc:     virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/qxl: remove unused num_relocs variable
Date:   Fri, 31 Mar 2023 13:24:23 -0400
Message-Id: <20230331172423.1860083-1-trix@redhat.com>
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
drivers/gpu/drm/qxl/qxl_ioctl.c:149:14: error: variable
  'num_relocs' set but not used [-Werror,-Wunused-but-set-variable]
        int i, ret, num_relocs;
                    ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 30f58b21372a..3422206d59d4 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -146,7 +146,7 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	struct qxl_release *release;
 	struct qxl_bo *cmd_bo;
 	void *fb_cmd;
-	int i, ret, num_relocs;
+	int i, ret;
 	int unwritten;
 
 	switch (cmd->type) {
@@ -201,7 +201,6 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	}
 
 	/* fill out reloc info structs */
-	num_relocs = 0;
 	for (i = 0; i < cmd->relocs_num; ++i) {
 		struct drm_qxl_reloc reloc;
 		struct drm_qxl_reloc __user *u = u64_to_user_ptr(cmd->relocs);
@@ -231,7 +230,6 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 			reloc_info[i].dst_bo = cmd_bo;
 			reloc_info[i].dst_offset = reloc.dst_offset + release->release_offset;
 		}
-		num_relocs++;
 
 		/* reserve and validate the reloc dst bo */
 		if (reloc.reloc_type == QXL_RELOC_TYPE_BO || reloc.src_handle) {
-- 
2.27.0

