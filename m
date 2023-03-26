Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B6A6C9385
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjCZJ1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 05:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjCZJ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 05:27:21 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6DB1B6;
        Sun, 26 Mar 2023 02:27:20 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-177ca271cb8so6337369fac.2;
        Sun, 26 Mar 2023 02:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9Wz9FA6K66dH4iQn0+o/IUAerAr/7nO1FAUqwypmmc=;
        b=Zy2mEILszn1VXZ4Ywhouk3Rno3vyq78tnWi1nySuIR3RStvomuHO64quO85ROT7ohY
         9VYpO66eMjykYlEGCLvBT5De+qYze0Wg9xdV5/DFXE6B/mWliyqHK5OYKXbYB0gCN/qV
         LThdm3e/IqswUt9DVAfFVHJBJQK2T/LOqaAUHuIunGRYoGgC654xRC7PEdBg7WN4ILPk
         tdY14TILf6e9KcVQDi/JY7KBePLRxoCZCFgk+WWd4DFvu+ELMeBJnknY656vIulZhNkY
         I5WJWsPhlsgnnsqvhKOEve/G6i7LSMWM6U3LWvBqL8xucrd5mRkMUnn1rw7aoMty8XT7
         v4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9Wz9FA6K66dH4iQn0+o/IUAerAr/7nO1FAUqwypmmc=;
        b=GBPW3CTejVqlIPPJll4kor0TnnmVgi32c42aid50d7G8B5kTd96wVALQmLXghH6a5U
         RimusjJN2d+7bqcBlHu32DRTgGoEwDGtLA/aEiyCxabdXAZvEzewKG59VHQLzhPPIGeA
         fvrRe34cRfXmyZa/0v0gzXKd95Y076AZHCQftjbWoxqQT4kEDhQIbv39xQWTr5fgzvrW
         qu1JQyUptKDwjaHkLORXFoLtdgj62v/x+JC4kToy3uTgkUeWIk2qz+z7/kxBNu7f1ary
         mIMyOA8kiEoxFC6zsFh2sMt0lTb0bVKyOilcbZlAgGm/xjaVVN/BXFw263PGMwKVXEtH
         f94g==
X-Gm-Message-State: AAQBX9cJ3b3o9sfZ4VgaERHq2/NcpK6z/OHwdg9ofb7+5uaTdFB5MI2z
        tVctDTW1OIJI9/1CT01LqpM=
X-Google-Smtp-Source: AKy350baPvGHW1nWOaIPMdIXPXH/u4mFHT02fBqyVQoqyso2Y9v31RYPqconwbS4xEgiVaows8aaoA==
X-Received: by 2002:a05:6870:f154:b0:177:a1ab:8c53 with SMTP id l20-20020a056870f15400b00177a1ab8c53mr5766544oac.12.1679822839849;
        Sun, 26 Mar 2023 02:27:19 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id v10-20020aca610a000000b003848dbe505fsm10068303oib.57.2023.03.26.02.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:27:19 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     martink@posteo.de
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH v2] media: hi846: Fix memleak in hi846_init_controls()
Date:   Sun, 26 Mar 2023 09:27:12 +0000
Message-Id: <20230326092712.139791-1-harperchen1110@gmail.com>
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
Changes in v2:
 - move v4l2_ctrl_handler_free to error tag
 - handle memleak in other failure positions

 drivers/media/i2c/hi846.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
index 7c61873b7198..f86997a261f5 100644
--- a/drivers/media/i2c/hi846.c
+++ b/drivers/media/i2c/hi846.c
@@ -1472,21 +1472,26 @@ static int hi846_init_controls(struct hi846 *hi846)
 	if (ctrl_hdlr->error) {
 		dev_err(&client->dev, "v4l ctrl handler error: %d\n",
 			ctrl_hdlr->error);
-		return ctrl_hdlr->error;
+		ret = ctrl_hdlr->error;
+		goto error;
 	}
 
 	ret = v4l2_fwnode_device_parse(&client->dev, &props);
 	if (ret)
-		return ret;
+		goto error;
 
 	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &hi846_ctrl_ops,
 					      &props);
 	if (ret)
-		return ret;
+		goto error;
 
 	hi846->sd.ctrl_handler = ctrl_hdlr;

 	return 0;
+
+error:
+	v4l2_ctrl_handler_free(ctrl_hdlr);
+	return ret;
 }
 
 static int hi846_set_video_mode(struct hi846 *hi846, int fps)
-- 
2.25.1

