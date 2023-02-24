Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E1E6A17BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjBXIIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjBXIIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:08:49 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA7B410B8;
        Fri, 24 Feb 2023 00:08:48 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u14so11987267ple.7;
        Fri, 24 Feb 2023 00:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EEL2HyedoF+UklknccP5xY2+UWWtxfoRRN75JeZ10qE=;
        b=GUwPchEWjiNhwck/7W0OgNznTF3W7C+JaLo99cxcHdXB+TsfD0ffqJbLikn1daBxDp
         fCurBvZEv0kLVrx+V0hnMAyQLrDcboy91DcC7fZu+Za+O+OkpRqlxO3moGxAaB1z9i7T
         eBCWx0WdwG5A3KwKv4lriJOCvxKK+kPF/rEwlHK239VjJoZDfWkz5YUM5L1ftogtx4hY
         cKW5qpOHbZoVcAt7WpbV6nlW5ouorKZqLKPYzNdI3KtTCPFlXC0wsY7XVSDANSQqALCJ
         ohxn/Wf5xESdn7nK+oUMsuMMsN0Qpljq0QUuszXasU5Zu/43tsGmINhcDSCwpQsHjjge
         DSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEL2HyedoF+UklknccP5xY2+UWWtxfoRRN75JeZ10qE=;
        b=Ra+EaoUNN5gF8CM7mLaIcC4UPk6UfqVbdH2uLUEwA2b21mTCK3Ze/iXsehltH2fzq7
         l5qVgoN7orIklRQNJJ+2upHSgngVQEz1vG80RrPq+8jSyx7CPMdAiAyKgcEnceg9P7OO
         DLF4qfeZvF4Vx/fyehGhzVwvdKgT6sVi9rQjun1M0Fn38ZxlzuN2txhVzFxRZK5GGPov
         qW59qem9Np7q0l/k3FkuoBsztMZb72RgE9RK5iNmOZ3qeNFVw8PqK/u8x/stB9WVZT67
         xXU2XYmtl7YAQInwimOCWgGDt0v4/qxEZfZpQaZtKpVK96j2oj47ZheT3iuGvlP9bhwY
         dNTA==
X-Gm-Message-State: AO0yUKXuVJshez36Zs9K+dCjz5DRyUbGfh9csx0QzQf/hZPJBBKRZVwN
        FGxMc3tllCze1pi1dO7J/2I=
X-Google-Smtp-Source: AK7set9tp76k57dkBl7tLBrFxa4vTFtlsNKv7hrcBsYByGMnQw7//dCXS4AaqRB9PXs5UmsZu8PqRw==
X-Received: by 2002:a17:902:ecc1:b0:19a:8680:ba86 with SMTP id a1-20020a170902ecc100b0019a8680ba86mr17757527plh.50.1677226128047;
        Fri, 24 Feb 2023 00:08:48 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902bd4a00b0019c2cf12d15sm10239365plx.116.2023.02.24.00.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 00:08:47 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        void0red <void0red@gmail.com>
Subject: [PATCH] usb: gadget: udc: add return value check of kzalloc in mv_udc_probe
Date:   Fri, 24 Feb 2023 16:08:42 +0800
Message-Id: <20230224080842.3104911-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Even an 8-byte kzalloc will fail when we don't have enough memory,
so we need a nullptr check and do the cleanup when it fails.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217081

Signed-off-by: void0red <void0red@gmail.com>
---
 drivers/usb/gadget/udc/mv_udc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index b397f3a84..6dd6d52de 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -2230,6 +2230,10 @@ static int mv_udc_probe(struct platform_device *pdev)
 
 	/* allocate a small amount of memory to get valid address */
 	udc->status_req->req.buf = kzalloc(8, GFP_KERNEL);
+	if (!udc->status_req->req.buf) {
+		retval = -ENOMEM;
+		goto err_destroy_dma;
+	}
 	udc->status_req->req.dma = DMA_ADDR_INVALID;
 
 	udc->resume_state = USB_STATE_NOTATTACHED;
-- 
2.34.1

