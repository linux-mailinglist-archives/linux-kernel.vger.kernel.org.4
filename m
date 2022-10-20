Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1F860699D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJTUlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJTUlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:41:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B86F1E574D;
        Thu, 20 Oct 2022 13:40:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bk15so1203279wrb.13;
        Thu, 20 Oct 2022 13:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mkrkmZwXDzkYF9cZqoYViFYu0UrGpVfkJcqp1qpBeoo=;
        b=a9K8k/CwhSprlmF43UJ2k22M5MSHa7rKHiWH4Nt0pNXlYmi08nQKOCCjpW8uFBbhCl
         33Pu1CdDye7E9TGgScGq9PX5KlgahSIe7UgScicfUYAry7ygOtF2IkBEtoV35y43G65O
         Ocr5Mt2qxuO51FrQCTiuLomFFim23vL6yi6PKyZXjHEoJzQ3PtOiKIksRSX92UEEyy/1
         XHS4mEKAr5WIM9bu82LpZgHIXc8AXMK6BaYHB2cxfT7GVolwmgTxyu+vBaO3Nw53x5tP
         32+mluIb/8nif83ugri58TyUimXNs3Ikg1veOmPAcZD+fpZNtK1RZpMPxqtuzX4TCdOp
         jFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkrkmZwXDzkYF9cZqoYViFYu0UrGpVfkJcqp1qpBeoo=;
        b=TsNTxEWvaBgwJtKdgr67Iu3MwJMEpoxtKjh1nZoA/cWRE3/r08ULkiL9jtgBzfMnsy
         XuCl3HWhGAcDYToJCGAYWLBda5//qOr0T5fyHhPRbLTYnB2vESPXlcKUqxWNaX78PzqH
         7matGCh7EXbrk4eAZe+9XTPO878NUoxQPsfWolBGtjL/bO6miVhPEvtTDrr6I9O0qXHP
         Vn9GsBvudYglcKw3F7y+yRT3XpCA6WkXT3uyXz2r6ZbmEP2fm0GI32sBAWTS9VC1OS9F
         +/RzqI7qxc1riptsXSf+ZsCuOgK2Om9JF7LsCH4EQbEiIGJSCKDnLp7phTT4bxv7DIu+
         58sg==
X-Gm-Message-State: ACrzQf0CTTQNmv/t9gKi+kIPuvoHRJK5Kss9P1ua8n8hoGL/cnxyJWfp
        +de0AYFMqotUEtrKWSWOQkmBC/QCRXbw+EcO
X-Google-Smtp-Source: AMsMyM67tNgAY4J1fpflkAr7KqOx6xMhtrINneS5zul20iJtySnTsSrOlOeIKXA1UNfFZBk2cGHnsA==
X-Received: by 2002:adf:f983:0:b0:22e:3c8:27ae with SMTP id f3-20020adff983000000b0022e03c827aemr10265898wrr.16.1666298453757;
        Thu, 20 Oct 2022 13:40:53 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j28-20020a5d6e5c000000b0022cd27bc8c1sm21014463wrz.9.2022.10.20.13.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:40:53 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/qxl: remove variable num_relocs
Date:   Thu, 20 Oct 2022 21:40:52 +0100
Message-Id: <20221020204052.42151-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable num_relocs is being incremented but it
is never referenced, it is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
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
2.37.3

