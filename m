Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692D1617E02
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiKCNhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiKCNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:37:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BC363D5;
        Thu,  3 Nov 2022 06:37:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bs21so2824110wrb.4;
        Thu, 03 Nov 2022 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hQObRj1fLljMghwTGdyG7iiJYiKrhA/G2GUNBFCKkL4=;
        b=moxz4QNk4yCb2aQKy6jQXahW8ajOrZtC/diHD7ZWobwQKBrhHqNZI3L8x6S4yuUxEb
         rBm1527B8GEjc3Evo4RRqMHD160JLzBo1zhgm9LT4b7rhNj6W5SCQhjJPA0IGW5GUOpq
         ZTCPE3BEZAH3o3ugBWCMz4R1ZfDBB750HbKtsRUWexuUsjFpTrP09j8KBLahcT4m/hWO
         B1cnLQAbpbk5TAC7himNSXrQ6SWaFDVv98RNg5iaXR9aQz8ubwJ4xCRbslQbxYvhj2cB
         L2yFnxhNibz9eQd2b6JYU/rZSVXMlNDNG+5Psrj7yI1BTutqfd6kcxp3b/pdM7DNv9Aw
         jTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQObRj1fLljMghwTGdyG7iiJYiKrhA/G2GUNBFCKkL4=;
        b=laR0Mp+cA/M4ZWADcwXSj1IHqbxqkDyWHBWsXcV4+4UCSf/wzAI/OHfsp+7+TNis6g
         yaM8bE1SLs8jYmHuLtKlrBg3M2DHBmA0OGs/DXixitewjRJOVdD7vtyyPGEP7oL/gF+y
         KWoAa+/o0E4Ca4B4OBAWilbdoll43ao2MlVA62mNp7zcFXoIgs0aTJrPwSdKW0tqpeyW
         8qNItoMLyvztMFu7D4D+OaVUAXBy9In+dpX92MDOY49V6bSWCQYPSrRG6LxWQMX/SWUd
         tyHqQznunMNoiDkgEk9zOrqk0ufi6WA7hW8RUE3Y0h4h57R7DX2+g8joKrqsBJ3ZVGkq
         8Gcg==
X-Gm-Message-State: ACrzQf0dpMokg/Fh5vH40W/+bVB5HqS6kiZu+7DyyIU1dhMXpuJX031u
        V00xfYgKTAE2OJLSBnbtx8c=
X-Google-Smtp-Source: AMsMyM6VJhNaQLv2eovD9bo01zxxi/6VKi2YUfWTTpGGyKS+fCjLc2njBZf9ROSGWp5O4FwsZnRENQ==
X-Received: by 2002:a05:6000:1e0b:b0:236:8a6e:8d with SMTP id bj11-20020a0560001e0b00b002368a6e008dmr18586010wrb.20.1667482651976;
        Thu, 03 Nov 2022 06:37:31 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bt12-20020a056000080c00b00236576c8eddsm929171wrb.12.2022.11.03.06.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:37:31 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/edid: make a couple of read-only arrays static const
Date:   Thu,  3 Nov 2022 13:37:30 +0000
Message-Id: <20221103133730.80940-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Don't populate two read-only arrays on the stack but instead make
them static const . Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 4671dc23abe0..50d488cc840e 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3916,8 +3916,8 @@ static int drm_cvt_modes(struct drm_connector *connector,
 	struct drm_display_mode *newmode;
 	struct drm_device *dev = connector->dev;
 	const struct cvt_timing *cvt;
-	const int rates[] = { 60, 85, 75, 60, 50 };
-	const u8 empty[3] = { 0, 0, 0 };
+	static const int rates[] = { 60, 85, 75, 60, 50 };
+	static const u8 empty[3] = { 0, 0, 0 };
 
 	for (i = 0; i < 4; i++) {
 		int width, height;
-- 
2.38.1

