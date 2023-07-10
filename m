Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854FE74CD6E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjGJGqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjGJGqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:46:24 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF00187
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:46:18 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b71ae5fa2fso12736801fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 23:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688971577; x=1691563577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLXkkNKLC2QFI1E0y4rm62aHVfDJbTTFbFsFl9CT7J4=;
        b=tJlWPqtRtUHBDxfXXwiE1c+MIiPPNh4Xf++CCl4xk4XPSvLWCmeiWmx6OrW2ghjDXr
         RSygzL2dz7sfa9RAatb/Y8qW9Twq5p6NbWIaQmRcmU2TXxl6cEQm5r+wYZNBATisJ8SY
         S6F5eOO8pCq0Q4MwR6E3c9t7D4YljjSRRytEn0qasj+PD/t+9XPixcFcbJHmzFijyctF
         YUrOlKm5GuZCJqzURmPMJ7/vWcHyV4pkhWymdtTQ7LFUzggEE1zoZXmaSJ+48i4UEy9X
         bOje3/v0o2k5KH3HJxeo5I2vdTvLpC4lL4tH9Va81pk+TQSlD//xcSxUfq07xXIoJDzk
         5o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688971577; x=1691563577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLXkkNKLC2QFI1E0y4rm62aHVfDJbTTFbFsFl9CT7J4=;
        b=L7PgmwBBAichDa+nwFiuKQiblXwXazdHEFb2uXikBVxkYghz5uU/HnhP8BwF60J+UE
         DnUblteMLpjQ/+lM+JC4/u+pX/6zMDFN6aaDoWWWnz2D2nSJZRYOvuCzoqxQai16kgdA
         IbjnUPcY3/tOq1NgHHjshbiSy3svGL2OHNfNyoZ15RQzsumUPVKo2wawF6+Zu/kp0M9l
         nDCu0pjGTsJGhCzgBM55HZog4mRpY6p2AHlbjkHV8ddaA4+ppPtrfX/lcbOekw4t8Ltm
         ICP7Qr8b50NbFcTzyu7zBVaBCRAPpcvvDdh3++1l3RhAwM/JguqE2EiqruclIZPBqdHx
         yKfw==
X-Gm-Message-State: ABy/qLYE5ZoDce6igUyKZEl3v62Ka8Yu4HvF5IIq25aaJxiwBYIXrkyl
        jqATbhzI/UE5Evv9YuDKZUCa/g==
X-Google-Smtp-Source: APBJJlH0tfoRxyVUloh/dxUjHZplvg8souUi2SQQ+NefPW4sSIatbyO0Pul9/o0YlK7jYmF2duH42A==
X-Received: by 2002:a2e:908f:0:b0:2b6:9ed5:bf15 with SMTP id l15-20020a2e908f000000b002b69ed5bf15mr5758723ljg.23.1688971576905;
        Sun, 09 Jul 2023 23:46:16 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id e24-20020a2e8198000000b002b6ca141b6fsm1875280ljg.87.2023.07.09.23.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 23:46:16 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        Johannes Thumshirn <jth@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>, gost.dev@samsung.com,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>
Subject: [PATCH v7 2/3] ublk: add helper to check if device supports user copy
Date:   Mon, 10 Jul 2023 08:46:05 +0200
Message-ID: <20230710064607.155155-3-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710064607.155155-1-nmi@metaspace.dk>
References: <20230710064607.155155-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

This will be used by ublk zoned storage support.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/ublk_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1c823750c95a..8d271901efac 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -185,6 +185,11 @@ struct ublk_params_header {
 	__u32	types;
 };
 
+static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_USER_COPY;
+}
+
 static inline void __ublk_complete_rq(struct request *req);
 static void ublk_complete_rq(struct kref *ref);
 
@@ -2037,7 +2042,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		UBLK_F_URING_CMD_COMP_IN_TASK;
 
 	/* GET_DATA isn't needed any more with USER_COPY */
-	if (ub->dev_info.flags & UBLK_F_USER_COPY)
+	if (ublk_dev_is_user_copy(ub))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
 	/* We are not ready to support zero copy */
-- 
2.41.0

