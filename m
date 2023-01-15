Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2795066B337
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 18:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjAORaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 12:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjAORae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 12:30:34 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1014CC21;
        Sun, 15 Jan 2023 09:30:32 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id cf42so39856081lfb.1;
        Sun, 15 Jan 2023 09:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ebf/oMXVYkekYORrvr7onKgABPLQXE20mj48sKZlpw=;
        b=VgSLbySZZ5EApqg7phVC233TMn/iI/ffZlfBP4ilUSsmwPmPwadMmGQal7pNVCMYZJ
         I/0DfwoSYpgfDpoJPjDoxHUdCEaLEolKMNQsns65U1AGWFux7DlOjuxON5LUt0p8Alyc
         WAbGDQ+JADw6z9qFxG1HFrnSGsxKqy0FIt1oT6ai1pJZP7s7LmjUHNaDU5zwAs+Wlu+N
         rF86s9kLAmWybL6z4cOhT8Nx+btz3K7qA/WGNQ8GyAxTsRiTt1K3yZII9F82nlpUVUIv
         /+Zs9XJxx85r6J8vSdtitWqRvOhk/stPN166HgBBzJStrOgUxzYqFgB9YD7W913CTaml
         6Gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ebf/oMXVYkekYORrvr7onKgABPLQXE20mj48sKZlpw=;
        b=6HQoSKEEvDQQdPvSC6XYZKog2V637Nh18qJ6XBMSIeP2djOtlkVnsGjrTvpYT6Mc4n
         At3LWN+EJNV2JSutmFInKG4mC2qoqh9M494qaHojkyDwTpC2RhkD4PSCycyl6vh82Lh0
         T+c9FM0u5H6KzdsMNg5ELXqM/+xiuyg0BjdoxfgZ8Dle5E29Rpyae9DYnX3mfhyIyeoL
         5Il7SRjmMYHNwMMlKRyEkqXD+gwSdlV/rC9ul/QyRVkMVdFh4dPChpqdNOmN7adZKclr
         /+tbGqLdw9dpCKIrkepdGSivlCvzQ5jEoSK1376hU2l0k9rzXHLkEkKjK8Q2EGoDnzh2
         bYlw==
X-Gm-Message-State: AFqh2kp6y7M8yPbZoWOF2Xs8oZ9H2TJ6wYvAd5pZ2fIMxB2gGc4viDLZ
        DgUJxfucwJ26sjDxv2rbzt7uvTHSzW8=
X-Google-Smtp-Source: AMrXdXuON2TYlGB3cTjE1TQOgzZuKnHEmOWjNQzjLqbiXcX72nj9b3rAeLf5ZlQoXk/kWW+DzM8gjw==
X-Received: by 2002:a19:6552:0:b0:4cc:8572:c7bc with SMTP id c18-20020a196552000000b004cc8572c7bcmr1928468lfj.65.1673803831077;
        Sun, 15 Jan 2023 09:30:31 -0800 (PST)
Received: from localhost.localdomain ([2a05:3580:f312:6c02:b940:4283:cb3e:a3e8])
        by smtp.gmail.com with ESMTPSA id u10-20020a05651220ca00b004cb10c151fasm4775008lfr.88.2023.01.15.09.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 09:30:30 -0800 (PST)
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCHv2] media: ov5640: Update last busy timestamp to reset autosuspend timer
Date:   Sun, 15 Jan 2023 20:30:10 +0300
Message-Id: <20230115173010.1237320-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <Y8KgGhu0e/+xIfDm@valkosipuli.retiisi.eu>
References: <Y8KgGhu0e/+xIfDm@valkosipuli.retiisi.eu>
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

Changes since PATCHv1:
 * Removed pm_runtime_mask_last_busy call from ov5640_write_reg and ov5640_read_reg
   as suggested by Sakari Ailus
 * Updated diff against next-20230113

drivers/media/i2c/ov5640.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index e0f908af581b..24f4f395aad6 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -3316,6 +3316,7 @@ static int ov5640_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
+	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
 	pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
 
 	return 0;
@@ -3391,6 +3392,7 @@ static int ov5640_s_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
+	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
 	pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
 
 	return ret;
@@ -3710,8 +3712,10 @@ static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
 out:
 	mutex_unlock(&sensor->lock);
 
-	if (!enable || ret)
+	if (!enable || ret) {
+		pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
 		pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
+	}
 
 	return ret;
 }
@@ -3912,6 +3916,7 @@ static int ov5640_probe(struct i2c_client *client)
 
 	pm_runtime_set_autosuspend_delay(dev, 1000);
 	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
-- 
2.39.0

