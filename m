Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2887E63F05D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiLAMWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiLAMWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:22:46 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECD06244;
        Thu,  1 Dec 2022 04:22:43 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id r8so1675776ljn.8;
        Thu, 01 Dec 2022 04:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NOExxS2IjahwCF/S/WjAjF0c/H0u99gptUVy0XMPdbc=;
        b=JF2WeLbwMFKR38u4Giaiah8fZew5H5mwyzSwBzBjrGud/hQUaiEQO6fzZXlrFbyuWK
         MGRZK2VTqN1UHQBr07fG8P0L5mVPcccKclxvy9Cqr7MZlRGCVZDN9JlJMDYe1vM1iuOH
         NhjhlEmgKsKrF0HOEnaNJDyMVsAS+/AQgJXDrzauhkieKSr5jrQNWChhMVLwaj1k8q14
         tr7qgXxmI7RTt5gaAZFs0PQKmq4V3Vm7fCu+dbmR/Td7xbJej4rglj3vWqtqcFrqJlrf
         QAfZqRYpmVNJRqNyy9xCkDhg3A3pyy5uXEbXdwvwtnAHJZZmhpMwx9piLBdd1bjtIdxv
         h9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOExxS2IjahwCF/S/WjAjF0c/H0u99gptUVy0XMPdbc=;
        b=Zwo3y27M+/ZnpdOUCYZBvkO5EeCBwH0+8sh5Lk7+/nS7jgI+AlOCJw/U4ktts9qFjM
         AV7WENjfiie05u5lQQ37ZY+M4Eq+SHOQPZICBdQAjrE4d3M7v2OzuxFfCQwTkaw16G+A
         9s8XIOqTZzB5c/+jq6CI6kkC91PsP4as4FxrVZxbWSzR10oqromQKyKfAPXGkGSXbYg1
         Sws8y+UJ8a4NLRoj0E+PHQc5xXYHtv3PAcdVqzDQbk9jxGsvV0nKgXpQLeBl/oOGTI2Q
         WYo5SeZQjJe7WQuTVSnlrS3NYj0vJ2yHQ4cs1qqTe8aWeiRjEhRLOcyBpPVZGSdqJVvU
         Jn5g==
X-Gm-Message-State: ANoB5pkYF8iPkIGuBnTAju4xhbdtftXgkuqeNix+gS4Q9fsAA9ty4sHB
        E1IRxzzv+sFHszFajb0VcVs=
X-Google-Smtp-Source: AA0mqf7wEdj4ql8TNl/pKZ5ROwZ8e68q5E8vY/MPsgX1mM0BAnCMcq4QDDHqm8eydKtYZGdTvb1KSg==
X-Received: by 2002:a05:651c:c8b:b0:277:f8b:bb4f with SMTP id bz11-20020a05651c0c8b00b002770f8bbb4fmr16556345ljb.161.1669897362141;
        Thu, 01 Dec 2022 04:22:42 -0800 (PST)
Received: from localhost.localdomain (077222238151.warszawa.vectranet.pl. [77.222.238.151])
        by smtp.googlemail.com with ESMTPSA id 11-20020ac25f4b000000b00492dbf809e8sm627184lfz.118.2022.12.01.04.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 04:22:41 -0800 (PST)
From:   Szymon Heidrich <szymon.heidrich@gmail.com>
To:     laurent.pinchart@ideasonboard.com
Cc:     szymon.heidrich@gmail.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Prevent buffer overflow in UVC Gadget setup handler
Date:   Thu,  1 Dec 2022 13:21:41 +0100
Message-Id: <20221201122141.8739-1-szymon.heidrich@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Signed-off-by: Szymon Heidrich <szymon.heidrich@gmail.com>
---
 drivers/usb/gadget/function/f_uvc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 6e196e061..69c5eb3a3 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -216,8 +216,9 @@ uvc_function_ep0_complete(struct usb_ep *ep, struct usb_request *req)
 
 		memset(&v4l2_event, 0, sizeof(v4l2_event));
 		v4l2_event.type = UVC_EVENT_DATA;
-		uvc_event->data.length = req->actual;
-		memcpy(&uvc_event->data.data, req->buf, req->actual);
+		uvc_event->data.length = (req->actual > sizeof(uvc_event->data.data) ?
+			sizeof(uvc_event->data.data) : req->actual);
+		memcpy(&uvc_event->data.data, req->buf, uvc_event->data.length);
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
 	}
 }
-- 
2.38.1

