Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D73644564
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiLFOPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiLFOP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:15:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B31428E2C;
        Tue,  6 Dec 2022 06:15:25 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p36so19520242lfa.12;
        Tue, 06 Dec 2022 06:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=024XHQZhW04SgcQC2KqdmXN3Ig7UIvwFGK8yLeCveCs=;
        b=IC3YI7L2zP6PdFVpmcjT+PF0EsABV8BOzNiKm/KFRUGbc+XiEGRafMBc4sodAdmN9Q
         DHlP1Kv5xHjtpJnjDCxK2fEjFTM7AIpUFFGkNBvlrW6AHdVunRqaMBqq0bCnH4YbidIe
         h0GVwtTZ/DGK03GfaaNclSc1LISn2HN9xXt7z8xYAEueQQoHn924hyMhVF/V01RLx3OM
         hB9a3ltancOn8YWmnC6Qt3HG7EUxqsdeqk3G1L1bA5XYFp+0c/bi67IGaW4f2ttMTV3R
         UXmZQN9FgvpprTpmbeH7yT4LhejC5hKasx8kwUueWl6gHXdkCydaomOttFPd/lIc4+1q
         uf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=024XHQZhW04SgcQC2KqdmXN3Ig7UIvwFGK8yLeCveCs=;
        b=atxy7YrD4OYXGyAZDamwGnEHycRlcYzxUjVnHv97sezhwAJFbEAhah9NjctrsM6Tei
         +76F+itoVY9KDxOt6IRpKjYocfVZ8NxNOAgQTGlgNYdkHjGQtpzDZ0c+TKfEuTVZ3CwQ
         4JsVc6o0fh2EecsLH8wu6KWLPsdSgBIZBnha710JgTINKeO0b2FZi0ImeJIqbvjA5IST
         zWYsu+wfljb2mLaEa6irmcqgB0OAWR8SPo3borpr8VfS7d3hmAcK1AfsxA0BhhshbQhA
         ChgGsvMGa9JTEybDpYVMNsZrbtTv2D+/wYJLhDkp87abKOfa4w9V/dK65RyekVkI2bFF
         OctA==
X-Gm-Message-State: ANoB5pli/64ioSPqD7SjyvorfMCptx3PmvvCdhXBW9osMziQr1nTnowX
        O4g2kqkyv635oYrrLmXuHw4=
X-Google-Smtp-Source: AA0mqf5DworZ3E/hFyVGhjVfIkQ143dy228hODZvZLbyLz3AbosJTf5D8xNSB1TPK8zuzJT5OvZ2dw==
X-Received: by 2002:ac2:5548:0:b0:4b5:7924:758a with SMTP id l8-20020ac25548000000b004b57924758amr2406444lfk.171.1670336123818;
        Tue, 06 Dec 2022 06:15:23 -0800 (PST)
Received: from localhost.localdomain (077222238151.warszawa.vectranet.pl. [77.222.238.151])
        by smtp.googlemail.com with ESMTPSA id e1-20020a195001000000b0048aee825e2esm2495299lfb.282.2022.12.06.06.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 06:15:22 -0800 (PST)
From:   Szymon Heidrich <szymon.heidrich@gmail.com>
To:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com
Cc:     szymon.heidrich@gmail.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: gadget: uvc: Prevent buffer overflow in setup handler
Date:   Tue,  6 Dec 2022 15:13:01 +0100
Message-Id: <20221206141301.51305-1-szymon.heidrich@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <9ffc4812-ab45-d7f9-7d93-fcacf629a754@ideasonboard.com>
References: <9ffc4812-ab45-d7f9-7d93-fcacf629a754@ideasonboard.com>
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

Setup function uvc_function_setup permits control transfer
requests with up to 64 bytes of payload (UVC_MAX_REQUEST_SIZE),
data stage handler for OUT transfer uses memcpy to copy req->actual
bytes to uvc_event->data.data array of size 60. This may result
in an overflow of 4 bytes.

Fixes: cdda479f15cd ("USB gadget: video class function driver")
Signed-off-by: Szymon Heidrich <szymon.heidrich@gmail.com>
---
V1 -> V2: Corrected commit message and changed ?: in favor of min_t
V2 -> V3: Added fixes tag

 drivers/usb/gadget/function/f_uvc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 6e196e061..4419b7972 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -216,8 +216,9 @@ uvc_function_ep0_complete(struct usb_ep *ep, struct usb_request *req)
 
 		memset(&v4l2_event, 0, sizeof(v4l2_event));
 		v4l2_event.type = UVC_EVENT_DATA;
-		uvc_event->data.length = req->actual;
-		memcpy(&uvc_event->data.data, req->buf, req->actual);
+		uvc_event->data.length = min_t(unsigned int, req->actual,
+			sizeof(uvc_event->data.data));
+		memcpy(&uvc_event->data.data, req->buf, uvc_event->data.length);
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
 	}
 }
-- 
2.38.1

