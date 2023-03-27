Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB256CA2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjC0L6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0L6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:58:20 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A993584;
        Mon, 27 Mar 2023 04:58:19 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p15so10141529ybl.9;
        Mon, 27 Mar 2023 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679918299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Doe7pet32ZDC5C9QjTizakUZOQlL9yMgkyH48O/Iy/I=;
        b=o+oGoEDiS+zRLyaaaVxnV3wlt3U5HBn5fGnGvwWJLsabKUb5mT2qVG28j4HvYY/+MB
         O/RblVI12IaO7Z5k7vdonKSz1k3/n+3IENiAe9KNZqRWl1oAmIPgI6ij6ZO34w62FAVC
         nZwI/grBgdid1+zXMd9vN1fHo1OQwMp+9EsJrAJ+Jju89ixByJxejq09Tg5QvzfbqGlJ
         YINAsA6/DvYHh/Lgu5Py0znucFJerZxpca5qsXu6/77Drw1GY96GTnwgF6g0/9Q/DRqB
         yEQITJr8Us7eayS9tn7mFXZYOoGMIAw3fGZMPkVFNtplaK+6SiAzF4AUohQm2ZcN7lbg
         RQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679918299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Doe7pet32ZDC5C9QjTizakUZOQlL9yMgkyH48O/Iy/I=;
        b=71+Edgb4pA+iTPmi6uJEEHxjuZXGM0Ccz7S12NG0C60t3FMpydiRGrvAeL6yIvspYM
         IEpCNFOH+9kFfGkY0zzmF548CVuGNYz/0h6KeiC02QWOVDjrZNre+tnyDyiAGBJcCsGe
         XOQVbDR6BSNlhYUerZj9h9mXF23laZOnu/GCtCEw8P0sWz1P6J/epuGG+kBxoer+GsxO
         xQ1WVecfWvL8LCr2bD7LCxcvxELZlBv4wFc4Ggwz6rIIQM0eqYIABlKON4/bOJs3199b
         9QX4reKeEHL/A3flwoQEkeKKyKZm/jJvqQHUx/gMlBqKHCrsQ7AYJ+zbodt/1gM93Lw7
         4Xcw==
X-Gm-Message-State: AAQBX9c2OZFgPMY4bxeXE0QLOrm4adaeSI/4BZnDExsKL4ZLYmlbLBXU
        wq7i8rSKgGXP1Fd+qmG2w7nhyBLZkFT4yw==
X-Google-Smtp-Source: AKy350b28UOS8zfGbqy7fr2qKza0zgZiSnZHy++vjipFJow5V2A/ODpW9Qmqk9mxALkoWWi3DNF1BQ==
X-Received: by 2002:a25:f609:0:b0:b68:129b:6127 with SMTP id t9-20020a25f609000000b00b68129b6127mr11336593ybd.50.1679918299134;
        Mon, 27 Mar 2023 04:58:19 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id i8-20020a255408000000b00b7767ca746bsm2243730ybb.8.2023.03.27.04.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:58:18 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     martink@posteo.de
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH v3] media: hi846: Fix memleak in hi846_init_controls()
Date:   Mon, 27 Mar 2023 11:58:09 +0000
Message-Id: <20230327115809.297633-1-harperchen1110@gmail.com>
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

Fixes: e8c0882685f9 ("media: i2c: add driver for the SK Hynix Hi-846 8M pixel camera")
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
Changes in v2:
 - move v4l2_ctrl_handler_free to error tag
 - handle memleak in other failure positions
Changes in v3:
 - add fixes commit tag

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

