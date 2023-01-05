Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D089265F3E9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjAESoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjAESoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:44:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154221054D;
        Thu,  5 Jan 2023 10:44:06 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id az7so12627175wrb.5;
        Thu, 05 Jan 2023 10:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5VFmITpcq980NC7BHDSxAFwvqy7pS4EajnFTTRxXo8=;
        b=KwmlitPYUG0nvLmz8rNf3rqtW8HM76f8nSBVunCIkaSBPwbAvZxYZzHGK3PwNwR7aP
         fXmL4M+I2ETLzUWtEaUP9ZgpU40ro0a++SN8LS/D/grUAMzOWx6pMpjTO2xBTma+fF+p
         8Z3nxBZ+cC1pRdAij++ZrS7CSicWYw5vryfLTNzHWibH4C2JwL/mO05ngE6FAeKFTJPp
         7117FL10SSEFxQmIZmC6nSjOs4c24ZGqcR7nqVsYXQU9BeeIsdoNF9Bm4KRUmUoNNXC8
         SmTSY6Ry8x2RKUASJo4qsQmKlVlyA07StKm5osrTpfbX+VlP9JLQW2BgFMmSPB+jWHEV
         wp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5VFmITpcq980NC7BHDSxAFwvqy7pS4EajnFTTRxXo8=;
        b=bU649uZNiyAxsI/wt+12O4I2nDUwEnAruxKftYohPFRZMkUJL8ywPAK7GktKWRa7kj
         TGMYvZ4Wlde637ne3+UEHZv/4Uy0cRkJuEhHE78NDhsT+q2hZ2GL/LOLh3N/CtYp+R/j
         m1OFGA+XLapQ7d/M1KKCTvq4o5OM2YyfFOfFnVEquzzn8sSeAspsxNAvfFnbPAQQya9I
         IXdW28bRy/OOE1N57eErb13iawlpmP6BrxMUKLfDHW3Rz3OFvX8H32VTCimgRtcNiM2n
         Ty3HqcWjgXNXKnMQ8HWs0nU7JHmQ9VXFDI9cAJXhOXJTYejZ53WRee130AGrgJvK3m3P
         5QAA==
X-Gm-Message-State: AFqh2kqBfzirxGPXOdYrQWfGOT+HZumjgZdo4wPRJxiyo1+7UpcdD9pQ
        WlPovBXrGypbMZ5IazZokyg=
X-Google-Smtp-Source: AMrXdXupHpSiCAPJMry8NhE3IeKFncHiPo3XY0ysiysKAVmAVt/UICl6Oja6cqmdM/4eTxSax6ktpw==
X-Received: by 2002:adf:db11:0:b0:242:6055:dee3 with SMTP id s17-20020adfdb11000000b002426055dee3mr31114213wri.63.1672944244668;
        Thu, 05 Jan 2023 10:44:04 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0023c8026841csm37004971wrx.23.2023.01.05.10.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 10:44:04 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] media: rkisp1: make a few const arrays static
Date:   Thu,  5 Jan 2023 18:44:03 +0000
Message-Id: <20230105184403.63419-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Don't populate the const arrays on the stack, instead make them
static. Also makes the object code smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../platform/rockchip/rkisp1/rkisp1-capture.c     | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index d4540684ea9a..d1d1fdce03e3 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -1131,10 +1131,12 @@ static void rkisp1_try_fmt(const struct rkisp1_capture *cap,
 	const struct rkisp1_capture_config *config = cap->config;
 	const struct rkisp1_capture_fmt_cfg *fmt;
 	const struct v4l2_format_info *info;
-	const unsigned int max_widths[] = { RKISP1_RSZ_MP_SRC_MAX_WIDTH,
-					    RKISP1_RSZ_SP_SRC_MAX_WIDTH };
-	const unsigned int max_heights[] = { RKISP1_RSZ_MP_SRC_MAX_HEIGHT,
-					     RKISP1_RSZ_SP_SRC_MAX_HEIGHT};
+	static const unsigned int max_widths[] = {
+		RKISP1_RSZ_MP_SRC_MAX_WIDTH, RKISP1_RSZ_SP_SRC_MAX_WIDTH
+	};
+	static const unsigned int max_heights[] = {
+		RKISP1_RSZ_MP_SRC_MAX_HEIGHT, RKISP1_RSZ_SP_SRC_MAX_HEIGHT
+	};
 
 	fmt = rkisp1_find_fmt_cfg(cap, pixm->pixelformat);
 	if (!fmt) {
@@ -1336,8 +1338,9 @@ void rkisp1_capture_devs_unregister(struct rkisp1_device *rkisp1)
 
 static int rkisp1_register_capture(struct rkisp1_capture *cap)
 {
-	const char * const dev_names[] = {RKISP1_MP_DEV_NAME,
-					  RKISP1_SP_DEV_NAME};
+	static const char * const dev_names[] = {
+		RKISP1_MP_DEV_NAME, RKISP1_SP_DEV_NAME
+	};
 	struct v4l2_device *v4l2_dev = &cap->rkisp1->v4l2_dev;
 	struct video_device *vdev = &cap->vnode.vdev;
 	struct rkisp1_vdev_node *node;
-- 
2.30.2

