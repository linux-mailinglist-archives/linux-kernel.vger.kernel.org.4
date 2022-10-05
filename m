Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1BF5F57FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiJEQGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiJEQGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:06:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB985C35E;
        Wed,  5 Oct 2022 09:06:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso1277245wmq.4;
        Wed, 05 Oct 2022 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=pwSoe76/9sXHlthLlGvZI3z8LwisXO4XEQ5zMXLYIi4=;
        b=BpiZOY5qoInatS2yLzXnvi6Pjkam8b8Z1vfnW8uDgXuqxF1Yp2XN8rMYz/2v2VorHj
         Zw/KcYt7iPALUfJ2Bt78PA/UeYQMQiG4OVqRboIlrl4Pto9pTknD6ed0GmcFU4L7kS0c
         xHGzeFo50d2hMRm8X+LurDsaQPdd0LKnp8yBEnYNXttGKfeMJpoNsUv8rjjiYJKEvn8U
         tcaSbYUItsIi2Icq0LmjptCvK9Bwir7Z3W+5rxW682zSFFMnvNXPF0YYLAhEErZVx5fK
         Ls7A+uNThcC5siK7vi1hIGv16R+YRyvroBzXl3wjFp/IcboqwSZMFNL22tqbyXWzUD29
         GbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=pwSoe76/9sXHlthLlGvZI3z8LwisXO4XEQ5zMXLYIi4=;
        b=RTmkCqJL9dgbpdA1IrKsotBa5fnIu7sIRj4iYFanLfZhwRCAl5GaYGAn349R0Dja8b
         3HMaTj9rjYibXUjtH71yggQMypOhbBuAfhX0tXeU32jSDbAApOEnz+oFocsPs1JqVkpo
         L3BYpdX3tAMFZAoTMKeuU2WnPlnucJxK2EBGiw/aD7G/lO/gQnSFycMYdHxEbWU6264j
         xTWgm/LyZZK+/LvtPglRRqVCJjK14KFrau+ejnuY1iY2y335ASkJG2KXENANtfXOv8yg
         7c2lOuKNlAJ+Me8n0xDqM8L8W9P5Ub+BFdsywn5Be+3Pyv/gW9tM0UElsnqPZ8Ng7J7s
         r+iA==
X-Gm-Message-State: ACrzQf0UXSafWOmuY9FAgIxFzqcaC1mV58Q0Fdwl2Bc6UwPyDArdrgXr
        uQOBW6qE+GPBi7AfSzdQaGE6yD7UGcn70RxX
X-Google-Smtp-Source: AMsMyM4UWs5s2tWICWcVCZmWsRQhUm89CoHX5AtLtAuCy42s8VJcnOgfEvPdmSE736f/zFWukd4Llg==
X-Received: by 2002:a05:600c:1e23:b0:3c0:2cb4:49cd with SMTP id ay35-20020a05600c1e2300b003c02cb449cdmr1214556wmb.95.1664985964636;
        Wed, 05 Oct 2022 09:06:04 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b003a83ca67f73sm2469448wms.3.2022.10.05.09.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 09:06:03 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: mxl5005s: Make array RegAddr static const
Date:   Wed,  5 Oct 2022 17:06:03 +0100
Message-Id: <20221005160603.321421-1-colin.i.king@gmail.com>
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

Don't populate the read-only array RegAddr on the stack but instead
make it static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/tuners/mxl5005s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/tuners/mxl5005s.c b/drivers/media/tuners/mxl5005s.c
index ab4c43df9d18..cd9f225ca26c 100644
--- a/drivers/media/tuners/mxl5005s.c
+++ b/drivers/media/tuners/mxl5005s.c
@@ -3637,7 +3637,7 @@ static u16 MXL_GetCHRegister_ZeroIF(struct dvb_frontend *fe, u8 *RegNum,
 	u16 status = 0;
 	int i;
 
-	u8 RegAddr[] = {43, 136};
+	static const u8 RegAddr[] = {43, 136};
 
 	*count = ARRAY_SIZE(RegAddr);
 
-- 
2.37.3

