Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C67C6F3B93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjEBBB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjEBBBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:01:24 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0802930EA;
        Mon,  1 May 2023 18:01:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaf706768cso13728865ad.0;
        Mon, 01 May 2023 18:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682989283; x=1685581283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MlM+MP8l0VCzSnSfC6Wxsg48Nqd9uvGwM4g7AYYZM+8=;
        b=N/mlLksxtNtWpRlXON/RQZGJVwdummnAgQT7GyP50jnQOAsUd+1prO0m5RhKzqYsDi
         DX59ksBpDDZp6HhJADTrzl+HfNOhgmqRq3eSZAJf50uSwHd05XSXfCPqz0FbN5UtDwM5
         /HMZk2s1asU3dRtK1dOgwuIYUO+M2hILe8KTaAMMhohdsPELKA08BuQhQ2DIjj5D5WJr
         rNvcC+MHT83YW5Bj49CRgKL7AeO9ZS3PcnZIPOm8vl8mEyaM+fafjWfaSNbvseyiDeXt
         K6vdOs8/FFK1zVmwxv88OvFplk7ECylF/meiNPx/j5VgcinYfJOXY7bHu1GmYbBdao0l
         9c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682989283; x=1685581283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlM+MP8l0VCzSnSfC6Wxsg48Nqd9uvGwM4g7AYYZM+8=;
        b=lngqqndsuswrIssP/Ybuv+gCXYzGR66AUTrA6lTbJxZ9XzSz3y9Suvbu6d6FK/W+mk
         8X0zV+eR38YaqKStn4h/BIxC6Ygz6ZAuxIieKFkhXyuN6nxwiZP/FXR6j02g7gddz25N
         Ms689jZirOcCutGVut4RTjncfFnSVK5HVD3qctMyDEV2uXDiuQ60sfdJ4zdnYha3EhyO
         eu1vqVCB3Due2rQ6JMQf+03eLMgTno7JGrHDdIFtwUrqt+XdH5vJNMdmlLjW7Yz0x+Aq
         BfOEGEMhYoTEWDc0I6vdlR4adZMC7BXtxWjWo50Pa123F12FD+n5C5MZ87VnmOSnTyQW
         Esdg==
X-Gm-Message-State: AC+VfDz+Zl5dy8K6t0wPEddLUcl4QpYlopUVKceoBFgBPnuzRLiPAwmx
        YQDfXoabgQ4Bi8HHBd9crN6pU8PWzDk=
X-Google-Smtp-Source: ACHHUZ7DxG5whxrx8ndX7yLW2K+kpNsFOyAivmHUewPdpl1UPeqYNJD18H8NrE0Be8wVwfj/JF6FCw==
X-Received: by 2002:a17:903:2350:b0:1aa:e0c9:7e77 with SMTP id c16-20020a170903235000b001aae0c97e77mr10449632plh.36.1682989282684;
        Mon, 01 May 2023 18:01:22 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d30500b001aae64e9b36sm3676187plc.114.2023.05.01.18.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 18:01:22 -0700 (PDT)
Date:   Mon, 1 May 2023 18:01:19 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Teng Qi <starmiku1207184332@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: avoid calling input_set_abs_val() in the event
 handling core
Message-ID: <ZFBg379uuHjf+YEM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

input_abs_set_val() can nominally call input_alloc_absinfo() which may
allocate memory with GFP_KERNEL flag. This does not happen when
input_abs_set_val() is called by the input core to set current MT slot when
handling a new input event, but it trips certain static analyzers.

Rearrange the code to access the relevant structures directly.

Reported-by: Teng Qi <starmiku1207184332@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 37e876d45eb9..f791d14ecf23 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -190,6 +190,7 @@ static int input_handle_abs_event(struct input_dev *dev,
 				  unsigned int code, int *pval)
 {
 	struct input_mt *mt = dev->mt;
+	bool is_new_slot = false;
 	bool is_mt_event;
 	int *pold;
 
@@ -210,6 +211,7 @@ static int input_handle_abs_event(struct input_dev *dev,
 		pold = &dev->absinfo[code].value;
 	} else if (mt) {
 		pold = &mt->slots[mt->slot].abs[code - ABS_MT_FIRST];
+		is_new_slot = mt->slot != dev->absinfo[ABS_MT_SLOT].value;
 	} else {
 		/*
 		 * Bypass filtering for multi-touch events when
@@ -228,8 +230,8 @@ static int input_handle_abs_event(struct input_dev *dev,
 	}
 
 	/* Flush pending "slot" event */
-	if (is_mt_event && mt && mt->slot != input_abs_get_val(dev, ABS_MT_SLOT)) {
-		input_abs_set_val(dev, ABS_MT_SLOT, mt->slot);
+	if (is_new_slot) {
+		dev->absinfo[ABS_MT_SLOT].value = mt->slot;
 		return INPUT_PASS_TO_HANDLERS | INPUT_SLOT;
 	}
 
-- 
2.40.1.495.gc816e09b53d-goog


-- 
Dmitry
