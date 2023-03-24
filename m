Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C986C834D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCXRYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjCXRYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:24:42 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE7118B0F;
        Fri, 24 Mar 2023 10:24:35 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id m20-20020a9d6094000000b0069caf591747so1258056otj.2;
        Fri, 24 Mar 2023 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679678674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kvgynts9pGunaYTqyxyW8b1uVo2ebWpPqOLNHUAp5s=;
        b=oB+95YCdnFSnDNUAsmd3akZYut4IbwPvelIZLYP3hiX0NQCJJ6AgqdHo4hFOQiQGCS
         hzzPfqMKlfTr9PXTDc6vufgbr2Yilw7biRtdlDfZxHSwo6WEh+dcKorVWSfYOLy+WnEE
         pOPfH8KZARyRRpnR2xUDAw00GgMeD5Bed74rCQWBw6pBpYkFYsyHiz6GtuH5tBQ9DKA6
         SWPjr6iwRZqDbLPXiI5uWvO51wT26c7hMu9Hz1jzcfwi3gkD32W8hMwVcxhv2vXrKtod
         7QB8AQukpAPhoD6nMFqx9xaOEOoVzeXN/2Cj/xICn3LkQmr1WBOLEqlJ9krwe8q7/qJL
         jggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kvgynts9pGunaYTqyxyW8b1uVo2ebWpPqOLNHUAp5s=;
        b=a/w3FDLS1RtrfbiVeD+MW4bXa/ZpYwGsMQiUXVTjRt6ZKqPdeMFuTTku1cR0sHrql+
         TnwV0+2f/kYZSkTZHts9+Up+zqZEfvEkI5Km6o4KCarpWh3tFhWXEoW/ZH2uyexDFUaD
         Cb6kzfQAGoVOiEBKDk5bCbTasBDK96eN3JudXC2AowDpRrTj1mViSEkIbCWkOVQ+6DF2
         8rMQkNQRCsoZGilBnhg0OX1CAn4Hn2+Un+YivR5nxOC/UP4AzvjfTu/C4ppVSYDzcbh5
         kuL8FpIbxjzzYgATpxB1uYH6j1ePs4lw2aFT9Fq6M9iUmtCtr9AcokSvoePwpXIt3krk
         EMKA==
X-Gm-Message-State: AO0yUKXiJNj3WWCloQs549Wd9iEBzIvzJkMBgFGDCvwH29AsrtihcBIJ
        mHI0eoOvMoMXb4wtjqHBPS0=
X-Google-Smtp-Source: AK7set8KDAF+aCox9rB6Co7TEOAS2+YtRH474WjczxT35sigu855c1Zvbt48bD9gxtOxKFL/F6bsfg==
X-Received: by 2002:a05:6830:1da6:b0:69d:8f5e:b24b with SMTP id z6-20020a0568301da600b0069d8f5eb24bmr2223161oti.25.1679678674500;
        Fri, 24 Mar 2023 10:24:34 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id w16-20020a9d77d0000000b006a11dd6d2c1sm102045otl.29.2023.03.24.10.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:24:34 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     martink@posteo.de
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] media: hi846: Fix memleak in hi846_init_controls()
Date:   Fri, 24 Mar 2023 17:24:27 +0000
Message-Id: <20230324172427.3416342-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi846_init_controls doesn't clean the allocated ctrl_hdlr
in case there is a failure, which causes memleak. Add
v4l2_ctrl_handler_free to free the resource properly.

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 drivers/media/i2c/hi846.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
index 7c61873b7198..c45a6511d2c1 100644
--- a/drivers/media/i2c/hi846.c
+++ b/drivers/media/i2c/hi846.c
@@ -1472,6 +1472,7 @@ static int hi846_init_controls(struct hi846 *hi846)
 	if (ctrl_hdlr->error) {
 		dev_err(&client->dev, "v4l ctrl handler error: %d\n",
 			ctrl_hdlr->error);
+		v4l2_ctrl_handler_free(ctrl_hdlr);
 		return ctrl_hdlr->error;
 	}
 
-- 
2.25.1

