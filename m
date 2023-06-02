Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069E971FA75
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjFBHAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjFBHA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:00:28 -0400
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4421B1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:00:26 -0700 (PDT)
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-4f256ddef3aso1404893e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685689225; x=1688281225;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O9ZIKWjkpmVJpjBcwd1faCmsxJuo8++sV8GGVf8Hz50=;
        b=U72D0fLMqOp4oA8phBBdvIbzJLJ9VTFx8AuXqPq4b2fhFTXnUi7GxtRrZ5ULcZ7ljZ
         VOTcv6UUD4qDSioa6UUTeQfzaR+Y6to596MBqJ+qpIlfrHR8CVN/0S68f4DLXRTk7/9/
         w3MKYBrpPcv+m5YVObunkAfWWqWJOg/T9rql0HFfqdY/bqm/dxmrsUscCk53ucXPCWBG
         rHXzuBIgQSxOEO5DjejKOAv/EX9zUKAA+ohtnxGNGdMwNI2jsj4lBpPHEG8/0DFqlzzC
         z9JPwDIy5phlh97+z/5Ych0qwQ63N/ZmK1nxLVaMJsQNOG4EwAbEt5SPWouRNV2R3mUA
         H66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685689225; x=1688281225;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9ZIKWjkpmVJpjBcwd1faCmsxJuo8++sV8GGVf8Hz50=;
        b=fapHm9ZiS3/Xa9kv4ITvFk7pmSyGXccW8Nu3N8e5oBRHP+9vgCmo+sZzpBZT1WQeue
         G9qyCTGKdoa2d9AHjwV5F7iNuFs8gIMo2loaKpmAA9ImLrrZVuMCuUmld86n41TuffkV
         tVGkl8KTKhF8eDvjDM9vztr2mtiP8UHRWg8NOwRy/Yu8gmSBM/jFn3PSyO1bAMaHlIYe
         gbbOtXvzXhn3SAc1199Cl78mK12U7cbNyWoPR/0mbdeV/I8GASwk+w4VpOyNMZ6W/cuk
         twss6vr/NcZZ9QGqdxMeoQmNwuKM0KrW+CVovFGwgq/PP2cJhwhYhK0KiG7bfXWEBcJa
         wAbQ==
X-Gm-Message-State: AC+VfDzJIjsEY96mLV+2FZhNO4cIQERUYA3lHn8w5+7RDPpjuXw+Ha9/
        yHtjSXnq43A5kTDbEaejFgCfwGMiqoU=
X-Google-Smtp-Source: ACHHUZ6oBlvLdJULcpGlUGRE+UmAIvUjgyqxTa110SwNR4R2uKlXcaEHp+qVShmBy6Uh5ox0yKQZI8Vy6vM=
X-Received: from khtsai-large-gcloudtop.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:289])
 (user=khtsai job=sendgmr) by 2002:a19:ee13:0:b0:4ed:b87e:2fce with SMTP id
 g19-20020a19ee13000000b004edb87e2fcemr504185lfb.5.1685689224623; Fri, 02 Jun
 2023 00:00:24 -0700 (PDT)
Date:   Fri,  2 Jun 2023 15:00:06 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602070009.1353946-1-khtsai@google.com>
Subject: [PATCH] usb: gadget: u_serial: Add null pointer check in gs_start_io
From:   Kuen-Han Tsai <khtsai@google.com>
To:     gregkh@linuxfoundation.org, quic_prashk@quicinc.com,
        christophe.jaillet@wanadoo.fr, xiujianfeng@huawei.com
Cc:     raychi@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kuen-Han Tsai <khtsai@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If gs_close has cleared port->port.tty and gs_start_io is called
afterwards, then the function tty_wakeup will attempt to access the value
of the pointer port->port.tty which will cause a null pointer
dereference error.

To avoid this, add a null pointer check to gs_start_io before attempting
to access the value of the pointer port->port.tty.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/gadget/function/u_serial.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 97f07757d19e..1115396b46a0 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -539,16 +539,20 @@ static int gs_alloc_requests(struct usb_ep *ep, struct list_head *head,
 static int gs_start_io(struct gs_port *port)
 {
 	struct list_head	*head = &port->read_pool;
-	struct usb_ep		*ep = port->port_usb->out;
+	struct usb_ep		*ep;
 	int			status;
 	unsigned		started;
 
+	if (!port->port_usb || !port->port.tty)
+		return -EIO;
+
 	/* Allocate RX and TX I/O buffers.  We can't easily do this much
 	 * earlier (with GFP_KERNEL) because the requests are coupled to
 	 * endpoints, as are the packet sizes we'll be using.  Different
 	 * configurations may use different endpoints with a given port;
 	 * and high speed vs full speed changes packet sizes too.
 	 */
+	ep = port->port_usb->out;
 	status = gs_alloc_requests(ep, head, gs_read_complete,
 		&port->read_allocated);
 	if (status)
-- 
2.41.0.rc0.172.g3f132b7071-goog

