Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09FE731471
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbjFOJt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245580AbjFOJtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:49:25 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27132719
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:49:23 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f76a223ca5so2117607e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686822562; x=1689414562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3p2ort1XGfY89Cgvtn4nymi2nkRUSI09DjSmE7WY64=;
        b=kVrPSKy7KyGgnDr4LKymAdyubnBUxWo6NacITX7FMUNOqMJ8w8GKCtzciWjJBFr39x
         BRbctzM4SnBNnI2SIDDQDkvvEKwYJMyQBOI08Hp1d/n3UGx3IbiV5rP4Mie09D9oFBfM
         TnEwup86+4It36/MZUU3W4Are7TN2awSJB/ZqSlR7aCv4kyY1B7qfh2DnkC8UrFCMe3x
         D6rW0uQLfA8lQwqcgddKclcrZnfnXMPPlnafTHmEHeKgDB57TUSjapFxDGQw2JOmbLyL
         WaOQZTN98cqxeIMcQNoblhlfbMugybBstgibWUqfknJ2bXMGgJdGNjvR9jhwyWfIrFAr
         rLmA==
X-Gm-Message-State: AC+VfDwKV3JCasRElddzcUDEb8S7P68bh6mXzq0Edh3IOs2vGx6Sp/xo
        VfQDGTmxoEQZGLfAJL8JCuQ=
X-Google-Smtp-Source: ACHHUZ6n1qAOSY3/0bIrcpUeXl81ZgXAtxlDJsdZNrgMFHeGSnpSuSse7UXpr46DQ9B0soM8Gyp3xQ==
X-Received: by 2002:a05:6512:b08:b0:4f8:46e9:9f1b with SMTP id w8-20020a0565120b0800b004f846e99f1bmr355064lfu.3.1686822561819;
        Thu, 15 Jun 2023 02:49:21 -0700 (PDT)
Received: from localhost (fwdproxy-cln-022.fbsv.net. [2a03:2880:31ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c114a00b003f7e60622f0sm20038060wmz.6.2023.06.15.02.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 02:49:21 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     leit@fb.com,
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] nvme: Print capabilities changes just once
Date:   Thu, 15 Jun 2023 02:49:03 -0700
Message-Id: <20230615094903.1341683-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This current dev_info() could be very verbose and being printed very
frequently depending on some userspace application sending some specific
commands.

Just print this message once and skip it until the controller resets.
Use a controller flag (NVME_CTRL_DIRTY_CAPABILITY) to track if the
capability needs a reset.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/nvme/host/core.c | 6 +++++-
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 76e8f8b4098e..4b7f9edab5e8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1125,8 +1125,11 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		mutex_unlock(&ctrl->scan_lock);
 	}
 	if (effects & NVME_CMD_EFFECTS_CCC) {
-		dev_info(ctrl->device,
+		if (!test_and_set_bit(NVME_CTRL_DIRTY_CAPABILITY,
+				      &ctrl->flags)) {
+			dev_info(ctrl->device,
 "controller capabilities changed, reset may be required to take effect.\n");
+		}
 	}
 	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
 		nvme_queue_scan(ctrl);
@@ -3280,6 +3283,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 			return ret;
 	}
 
+	clear_bit(NVME_CTRL_DIRTY_CAPABILITY, &ctrl->flags);
 	ctrl->identified = true;
 
 	return 0;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 78308f15e090..f3182134487a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -243,6 +243,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_STARTED_ONCE		= 2,
 	NVME_CTRL_STOPPED		= 3,
 	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
+	NVME_CTRL_DIRTY_CAPABILITY	= 5,
 };
 
 struct nvme_ctrl {
-- 
2.34.1

