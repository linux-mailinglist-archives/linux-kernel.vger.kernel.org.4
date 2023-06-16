Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB800733661
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345582AbjFPQpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjFPQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:45:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C778530E7;
        Fri, 16 Jun 2023 09:45:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f738f579ceso7586495e9.3;
        Fri, 16 Jun 2023 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686933930; x=1689525930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8V8q96OOXdGau1TedNc2n90X++sVPNRGGXHlrWVRBEc=;
        b=i3YMB8s2sNQ/jSgkkXlqbo+NkETRLlYYZq8OJPUg/h6JEYLiHckfl+M5nU05AA2FP1
         TxtgdKZFXZCunRpwjNko8IUzbadarz/MJ3c4G708uD+fCH9FSFs8vzIQxLlnUK5Ms2cy
         wKO3A5nUaIsLqZ9ngVRW7CBjH9wcNaFJZS5yOQIp+A7djGgdbQywRdGodzqSz5PtZlvM
         wz5b05QrhLY4gSTRRmqPbe/3+d7k1t07arE2z/IDDao/Fy83b6ongXoT3IpP19QRuaqG
         6tg3rvtYbImek8pFfA1WZRyQ6Yv0V3d23594qpbGUomRV9Hn0tBg+a8d7ayNOZQYM+Zz
         pMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686933930; x=1689525930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8V8q96OOXdGau1TedNc2n90X++sVPNRGGXHlrWVRBEc=;
        b=RoT6Jijehm6nhpvp/I4BkvhOeofqxCWXxl4xvca3UHt0W+VEcG/vvvObMgnYBi/S8X
         YmlK3giXvXvi5yvt67OalpVolX6v/fyvh2+YJAqML4fAW2PLPBZ06oMzpw14SW4gucZN
         pE2i+uewNUdCiAn9M0Xv5mn/inLPcMxr50Eev6Xon5/buNYFHzAzEFyYDp9jaRH+1R/p
         wWa8NkxSkmyUj1tCyFM/X1RzS35mIhxwnKIb8vM4r74psxsyc4kG2R8O6Znejqc3t9y1
         SFS4IKW0ugNXxXPreyYN6wt6o2lAkUDCKX7Zn0hqZ2yVQY1E8/1uabQer1yE+yNrJtuR
         +uuQ==
X-Gm-Message-State: AC+VfDwqSh841ztRj2wrxeoQWdDp8cijQLFTzqPStpnWo6pIH0MwSPMA
        d4V28wj09jRhk9mH2uKrB/4=
X-Google-Smtp-Source: ACHHUZ64k1pdHed8InLXt7Gttw1k3psGS3dQa/8W2hpx8V25//2s5Z4b05o/W2he1wB3HtDeJYgqeQ==
X-Received: by 2002:a05:600c:290:b0:3f7:33da:f218 with SMTP id 16-20020a05600c029000b003f733daf218mr2068916wmk.35.1686933929885;
        Fri, 16 Jun 2023 09:45:29 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q13-20020a1ce90d000000b003f8e4b22bc2sm2630817wmc.44.2023.06.16.09.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 09:45:29 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drbd: remove redundant assignment to variable owords
Date:   Fri, 16 Jun 2023 17:45:28 +0100
Message-Id: <20230616164528.2342460-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable owords is being assigned a value that is never
read, the exit path via label out returns before owords is ever
used again. The assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/block/drbd/drbd_bitmap.c:654:3: warning: Value stored to 'owords' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/block/drbd/drbd_bitmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 85ca000a0564..897bf211e985 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -651,7 +651,6 @@ int drbd_bm_resize(struct drbd_device *device, sector_t capacity, int set_new_bi
 		spin_lock_irq(&b->bm_lock);
 		opages = b->bm_pages;
 		onpages = b->bm_number_of_pages;
-		owords = b->bm_words;
 		b->bm_pages = NULL;
 		b->bm_number_of_pages =
 		b->bm_set   =
-- 
2.39.2

