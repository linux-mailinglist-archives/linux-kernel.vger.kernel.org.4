Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB46666AB26
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 12:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjANLVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 06:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjANLVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 06:21:52 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5796EBF;
        Sat, 14 Jan 2023 03:21:51 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id y25so36535911lfa.9;
        Sat, 14 Jan 2023 03:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J5fd62izaRzYKahE51Ez8OS6iAYgUaFPo+1VfaByxNo=;
        b=M8/CANIF4UP/MqZe9a6Ypax6eHzS9U0jbDs0VRK9lrRiFwQKSHxYtVUR+MSn2g5lfj
         exO7IfrsR8HQZFnTkeNMNl8HPXdr7FEWmgJiiGqddEtbmajuoLv3YDu63CKWyy5T6fgX
         d78+dqBnrOgIJ4Gqhqp+f4b/96PhKB1fLDfaqX+eSnJ5OXf45qiy9Cx6zU4BxFv/zPX+
         XxEvAQXefPG0EYeCmd6+3qaTwEevnOn9sf8jzYvqwIsVdCD0TRX0f6qxfEpsRDfUK5BH
         LMxvQ7H+k0IIbqp+2suqxhoGnHKJOCNV31mqVk5viTezddRTnEbLwdK3pfIYr4arv5ux
         RPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5fd62izaRzYKahE51Ez8OS6iAYgUaFPo+1VfaByxNo=;
        b=DHvkObHCE+UxeTE5ceNLdpoxqhd+N0VFjtRYET3nRSPHxvvNwazGiDUTZFrJiSObTG
         fkglqpltGvxetIzUvLBBbOQxNk0DWJhm37dF1jCQc9P/awaumFsNvAMW5Heidxkott3z
         E81DcOtMrGHgLUCifJkmBsCPhXWZviI7YLunSo7LyScWQUmqoxMv58WGhBEhfTW3mxSW
         o7hPQT8zYDqNWAszqf37qHdBTv4NB53w2DaNN/T9hspDtPLR89lXOFmOI3HSOGBCRJeV
         5RsC7g5iidGuL76fs5DoLpmjXE7ZlTtxvU1cS5fjogQxnwI2AtxSTQgJ0tJluY3ei7YQ
         CY9w==
X-Gm-Message-State: AFqh2kqF6PBEfAS4NvC7B9ArZVPcwYm57NDyFph+EQI7V5sWln16wp5m
        G2nTVSdwYDZPZg/cGvYAGv0xqCYxmhs=
X-Google-Smtp-Source: AMrXdXvBzvrH+tjRI+9mhSpvuGwwi4mrGueZ5fbQE+C8+qYsOCNm6qLBRvm3aoaG55oEz0Lf+C79KA==
X-Received: by 2002:a05:6512:1049:b0:4b0:a1e7:915a with SMTP id c9-20020a056512104900b004b0a1e7915amr27257766lfb.49.1673695309242;
        Sat, 14 Jan 2023 03:21:49 -0800 (PST)
Received: from localhost.localdomain ([2a05:3580:f312:6c02:b940:4283:cb3e:a3e8])
        by smtp.gmail.com with ESMTPSA id f16-20020a056512361000b004cb27d8edd1sm4281728lfs.85.2023.01.14.03.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 03:21:48 -0800 (PST)
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] media: ov5640: Update last busy timestamp to reset autosuspend timer
Date:   Sat, 14 Jan 2023 14:21:09 +0300
Message-Id: <20230114112109.982005-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
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

Otherwise autosuspend delay doesn't work and power is cut off
immediately as device is freed.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/media/i2c/ov5640.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index ac35350..f71c0f7 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -1238,6 +1238,7 @@ static int ov5640_write_reg(struct ov5640_dev *sensor, u16 reg, u8 val)
 		return ret;
 	}
 
+	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
 	return 0;
 }
 
@@ -1305,6 +1306,7 @@ static int ov5640_read_reg(struct ov5640_dev *sensor, u16 reg, u8 *val)
 	}
 
 	*val = buf[0];
+	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
 	return 0;
 }
 
@@ -3615,6 +3617,7 @@ static int ov5640_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
+	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
 	pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
 
 	return 0;
@@ -3702,6 +3705,7 @@ static int ov5640_s_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
+	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
 	pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
 
 	return ret;
@@ -4034,8 +4038,10 @@ static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
 out:
 	mutex_unlock(&sensor->lock);
 
-	if (!enable || ret)
+	if (!enable || ret) {
+		pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
 		pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
+	}
 
 	return ret;
 }
@@ -4203,6 +4209,7 @@ static int ov5640_probe(struct i2c_client *client)
 
 	pm_runtime_set_autosuspend_delay(dev, 1000);
 	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
