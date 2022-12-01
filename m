Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E3F63F7F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiLATMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiLATMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:12:30 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF88FC5E10;
        Thu,  1 Dec 2022 11:12:28 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p8so3948515lfu.11;
        Thu, 01 Dec 2022 11:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pm/wKN9Xbr6T4OtsXw6Ao3XmpX+dPEJDVEZw2H20Ro4=;
        b=YL6SvZQbGf4LBFrQ09+q9R7WMak+EbBf03VBVZ4cXUREQb9nfTzr05Qv1JqYH5uBBt
         zF8TxVpLLFithWhXWnFTNCb/ZkcqmBvVtO+W0SwKLLdKxHBzW7/CTRKWuvEoAXZabNzI
         UnrRFeJ9kWZRnlLOKoi7H0/rWOOCciKpFFzUwPhdjrRu30afcMDvurYQIemowkGqqHvl
         YiRRcT7daT4bOBEqAYg/8AuSKFLhFlOg2tJgz8ad1GudaquYVZOFq6D3uvyu28giXhXc
         o0vTQ5bqbS0ig4BOtQ5HbnMXYWO6lFTmVR7zQeRYni385yu3DLvZH7THXC0thzbFmGCz
         n0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pm/wKN9Xbr6T4OtsXw6Ao3XmpX+dPEJDVEZw2H20Ro4=;
        b=3AJgI51A6+z5prH3Hq2CY38SgpU0b+Y44ZfX2wQkg3Od0U7tpuvDKj70FN/nyCc2D6
         YAVijUn0QzIJfu6GB1LDFJ4vlKhCzDh+2IC9uvjHDLBH2k+m7oOSKCIdFQBMyI7ia6X6
         JTTD9lw5jl871BEhMd/eC0Mkpe/UelltQEgrm7oTKHZFXlHwZujZS1xoPCDB4qBE4RYw
         nk0ANsy9JpQMQBk8WX/cgW+OdBaJlyJ4lsrmD9b0DpYj9+XH9ZOdV0Eq9ShFxhVdLSJi
         coxefUAKoBMVuszcKNIKm1d8Ya1pet0KQeYvMjsul15LvtQvsVL8ZivPp0g6j7s0gvf9
         Myrg==
X-Gm-Message-State: ANoB5pn0dF9+/mnB9H703s5PR5xX+tG+4bD8IDCoycnHdn+C0Roxo00+
        6k4FJGclrwQ51pWGPLBpTZM=
X-Google-Smtp-Source: AA0mqf6AGLESDX30+/NBov+MLFO8wi5Kqkw847g8Eb9eUSyv/oR2nAexVyZVh7zECCEfvaT7Xdci5Q==
X-Received: by 2002:a05:6512:749:b0:4ae:d0fc:1bce with SMTP id c9-20020a056512074900b004aed0fc1bcemr21543853lfs.107.1669921947266;
        Thu, 01 Dec 2022 11:12:27 -0800 (PST)
Received: from localhost.localdomain (077222238151.warszawa.vectranet.pl. [77.222.238.151])
        by smtp.googlemail.com with ESMTPSA id h1-20020a056512220100b004b4e67c3c00sm737940lfu.53.2022.12.01.11.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:12:26 -0800 (PST)
From:   Szymon Heidrich <szymon.heidrich@gmail.com>
To:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com
Cc:     szymon.heidrich@gmail.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: uvc: Prevent buffer overflow in setup handler
Date:   Thu,  1 Dec 2022 20:11:34 +0100
Message-Id: <20221201191134.12404-1-szymon.heidrich@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <Y4jqVZfEj+/VdfnH@kroah.com>
References: <Y4jqVZfEj+/VdfnH@kroah.com>
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
V1 -> V2: Corrected commit message and changed ?: in favor of min_t

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

