Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCB7624AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiKJTrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJTrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:47:42 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61AA15732
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:47:40 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id q21so2092407iod.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P1FnuNG2bRYfl+49iTwNU1I/yOXgzb8jSaOCKZ4qfj8=;
        b=EsCYvpQMDeHpAz74mMzxulzivjrWL9eb/CZxFrSZcTAR9I55QFobY3SKK74agPlpRa
         S5uGjHzZ8pi7AiFFwbaZh3LTAENy3tb9kKkOw7r1MynAoJpwobeGnqQqrQ7n375396n3
         F1q0D2falmnyhCZtzebdmFPLXf0wP1MBziVtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1FnuNG2bRYfl+49iTwNU1I/yOXgzb8jSaOCKZ4qfj8=;
        b=xw5ou8/j4MRcZvuEWypYaMk47BeanEZpMOrST+NDMe/8Qci2NFs6XfyYlvsJuGyjt7
         eUUsl0gLP4pIQ/4Ew36LMIs8e+EPBgMZWT8rKmCKxOJc5KxMhs8Apz2QGi6JY0lEI2a3
         1cQNbt+pnTytFaayiGlK1XDVxNwBh3CJAczGegbU4caFlpVwICSp3YFaZsa3mg1kyhta
         gkRieahMm2z2t1atDf1NFH7XahINegYYEFGuhjh6Ssc2uysyejUBVYhSkwDwzlqZPmHC
         BW8BNaRr/hvJ375FzOBhTq5wcMwOOHHZoBh1EEtvp32I1O20MGpVu9Uj4Y5wOYkOoMyH
         pM2A==
X-Gm-Message-State: ACrzQf2RSStRrUdiTXGxD+Q5a35IxXh8q4XICXTiyHMgo/zZsgwO1Q6V
        u4V3+2rGBSPp+ATDyMwImepJvQ==
X-Google-Smtp-Source: AMsMyM7JogcOwoDfpb4LeYpJkGSLrqDUbWphVenvgUb84nm9tF40jDodVXJ4x6E4O3XoIQF0NfkHWg==
X-Received: by 2002:a02:7101:0:b0:363:e6b8:2bac with SMTP id n1-20020a027101000000b00363e6b82bacmr3629504jac.229.1668109660183;
        Thu, 10 Nov 2022 11:47:40 -0800 (PST)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x12-20020a026f0c000000b003750f7b7296sm97371jab.179.2022.11.10.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 11:47:39 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, valentina.manea.m@gmail.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb/usbip: Fix v_recv_cmd_submit() to use PIPE_BULK define
Date:   Thu, 10 Nov 2022 12:47:38 -0700
Message-Id: <20221110194738.38514-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix v_recv_cmd_submit() to use PIPE_BULK define instead of hard coded
values. This also fixes the following signed integer overflow error
reported by cppcheck. This is not an issue since pipe is unsigned int.
However, this change improves the code to use proper define.

drivers/usb/usbip/vudc_rx.c:152:26: error: Signed integer overflow for expression '3<<30'. [integerOverflow]
 urb_p->urb->pipe &= ~(3 << 30);

In addition, add a build time check for PIPE_BULK != 3 as the code path
depends on PIPE_BULK = 3.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
v1 -> v2:
- Use BUILD_BUG_ON_MSG

 drivers/usb/usbip/vudc_rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vudc_rx.c b/drivers/usb/usbip/vudc_rx.c
index d4a2f30a7580..51bb70837b90 100644
--- a/drivers/usb/usbip/vudc_rx.c
+++ b/drivers/usb/usbip/vudc_rx.c
@@ -149,7 +149,9 @@ static int v_recv_cmd_submit(struct vudc *udc,
 	urb_p->urb->status = -EINPROGRESS;
 
 	/* FIXME: more pipe setup to please usbip_common */
-	urb_p->urb->pipe &= ~(3 << 30);
+	BUILD_BUG_ON_MSG(PIPE_BULK != 3, "PIPE_* doesn't range from 0 to 3");
+
+	urb_p->urb->pipe &= ~(PIPE_BULK << 30);
 	switch (urb_p->ep->type) {
 	case USB_ENDPOINT_XFER_BULK:
 		urb_p->urb->pipe |= (PIPE_BULK << 30);
-- 
2.34.1

