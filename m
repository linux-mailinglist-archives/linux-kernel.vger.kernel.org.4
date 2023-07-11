Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4A874E7E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGKHYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGKHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:24:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAB3E73
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:24:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fbbfaacfc1so8526305e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1689060244; x=1691652244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLXkkNKLC2QFI1E0y4rm62aHVfDJbTTFbFsFl9CT7J4=;
        b=Ftypam7peF0jzVg1jOvJGykz+ctIhQtlZw9llhkyUUbT5jfcOz2NmfqvHqqQjxymx/
         TSBs8G4zUCEPFFMORMYNJwU2gf8PWgaF8fm/Lmw1+asDemT/L7Q6Fqqq5nsD6sxNLcFQ
         CLKrsWdjxq79XTDMdsaRq0x1ebYoMl7MexdqdAVHxW8Hwm9TXzjuEu+4+UZwJspiN0kX
         7IdFVFoqRNEtTjp9HvhUiGZ/RjY0ZHscDP6tI0iaWjm0ti26N/85za5ra+bn3FIkK/vq
         OSnVg+RccPykMBoVKEVz7gro2oKGkkGjcF8JOeyeYrHiK/UjVaOogzXhNJ5k/DF52qp6
         DyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689060244; x=1691652244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLXkkNKLC2QFI1E0y4rm62aHVfDJbTTFbFsFl9CT7J4=;
        b=G8PULLT1oo5/Asn/+68fqvlbQx7HMK3Xqgc+q5WqXFMA19lET2L3+tbKGYDejBOuXQ
         b29MBiHh2tkxE953AFVuBS7v1uVlUT/4XRyl9D+tuKPW56Ii8/mH1beH91tqGJyr0jaw
         F0+zsPC+orbXrGns9nIk28ELEXcpbJaE026oBpBHEii4+SV9qtiRItjvZyHrYgyt6loY
         RRNeWL72wMN53w+gOR9s5sMTIsMEFO7kZSw5YgxTp3tLwKqIq/aTuc4FG0MFU8j8hCjD
         stnfx8hIQioo5vB9r4PiMDLzl10MP2qwHPNJR+YFkiOTGJVc9Hu5vzerK/oppT3XdG6t
         Y99Q==
X-Gm-Message-State: ABy/qLZ+mjPJNXvEBeRG7l09q0DMFnew1MPkD1iDRfGoJv32Kk9rwh3t
        UFHMc7bf5/1tQwcXCIhBF6HpQQ==
X-Google-Smtp-Source: APBJJlFJITQ7e41WIb3Lta+hpyz2Vn/KTvN5favGapGXaEAY7o32K29tdoLFTHK4aD4iWSgWczXDvw==
X-Received: by 2002:a19:645e:0:b0:4fb:8948:2b2b with SMTP id b30-20020a19645e000000b004fb89482b2bmr10837808lfj.48.1689060244068;
        Tue, 11 Jul 2023 00:24:04 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id b24-20020ac247f8000000b004fbb0ccbc9csm206562lfp.83.2023.07.11.00.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 00:24:03 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org (open list),
        Andreas Hindborg <a.hindborg@samsung.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v8 1/2] ublk: add helper to check if device supports user copy
Date:   Tue, 11 Jul 2023 09:23:52 +0200
Message-ID: <20230711072353.200873-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711072353.200873-1-nmi@metaspace.dk>
References: <20230711072353.200873-1-nmi@metaspace.dk>
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

