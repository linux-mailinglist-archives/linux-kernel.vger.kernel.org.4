Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15D563F472
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiLAPqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiLAPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:46:20 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637BC638A;
        Thu,  1 Dec 2022 07:46:19 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id n1so2335633ljg.3;
        Thu, 01 Dec 2022 07:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdojLaVMTpjC3HNtLnBKu1Bus4grE5zzcOEqK4rU84o=;
        b=oRLc44P0fjUnudowxh4wRpGPchgKMdAudNsOhnO5JvCoqTEnfU34BUi9Kdrq+Ij+zd
         mO1OUGsd2N5AaxNgxZyYoP3fJKkIk4kkFFaRmOAFtVlop4YARYnr4TmGKAtuIv2KZ2VZ
         CXvWbSuUO23fNeRul9VnNVrNArM8ZZiRiwxGh81n7chKF1SGNUU4fr26pRmrb+uZj8XD
         6h5GLIhZ1/pO/5MIaieXc//XkX/gjXGR85CXiNVg5WX7hwbbOUgIHfxg1GlpgBjylUSF
         GgsUFtMB43bMzinfyRQsF9G5Lbpd/ssPYNPl/R7JXhBiJ3aHFnZNXqoHraLpKJBO4Xew
         jz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdojLaVMTpjC3HNtLnBKu1Bus4grE5zzcOEqK4rU84o=;
        b=O1zIwlN+SJo+fhutFzTr0AbDRG93ie5foQdo2Vn8RXPmVF98CmEL/4nvK/Usv9Rv+C
         IbQg+HyDu9V/beL4VOR8e117m+1aJHicl2c0TjHdgThSIiDqT827mN+d7hJI7xYXjS/+
         imgPEI5DXiOX9zKaEx3bQzOQUidyxd7WEz2F9uJXbH0A3OR7PTgjBKn2moHpmwotFVAk
         Jwv/Z3qBY/NGnHmkWJBWA528D9ymGfM2DueHQtyjJsoc6Lxk1Tjt7U1zpwI//kRBkq83
         WoLfFXwKX7rDjJ2sP+J5RSHMChwQq5GCzZSv6AVuj6xIhdhrNoETvJ6yDU8dFnTsrM7v
         SMIQ==
X-Gm-Message-State: ANoB5plv8IO0naO5/fs3ywnvq+tYINaU5gq8lFa1rQLPI5zeFkAU0MM3
        WJh9jqD+VzQuTTZGas1W2UE=
X-Google-Smtp-Source: AA0mqf7wPAGvJGI2w6SblqJCEUB5t6+5tQ7XJz5zR3Z5bgUcor23OM4a5d+XmGhoGNu4jq5qvfJcWQ==
X-Received: by 2002:a2e:b004:0:b0:279:c02e:7457 with SMTP id y4-20020a2eb004000000b00279c02e7457mr3866016ljk.475.1669909577574;
        Thu, 01 Dec 2022 07:46:17 -0800 (PST)
Received: from localhost.localdomain (077222238151.warszawa.vectranet.pl. [77.222.238.151])
        by smtp.googlemail.com with ESMTPSA id t15-20020a056512208f00b004b4ec76016esm680965lfr.113.2022.12.01.07.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 07:46:17 -0800 (PST)
From:   Szymon Heidrich <szymon.heidrich@gmail.com>
To:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com
Cc:     szymon.heidrich@gmail.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: uvc: Prevent buffer overflow in setup handler
Date:   Thu,  1 Dec 2022 16:45:46 +0100
Message-Id: <20221201154546.11226-1-szymon.heidrich@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <abe0cc82-2fb8-2e29-e7b9-90fe6ae4d203@gmail.com>
References: <abe0cc82-2fb8-2e29-e7b9-90fe6ae4d203@gmail.com>
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

