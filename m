Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765156B7326
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjCMJu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjCMJuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:50:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3527FA255;
        Mon, 13 Mar 2023 02:50:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so16296920pjb.3;
        Mon, 13 Mar 2023 02:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678701012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HG3KG6VQNJrTxZcAoDu4OYtxrPugKypRTH1cm2KrTvM=;
        b=qmNbxg+/zafbEzl8LVY73WJv/tnPnP1u65jbXrRjR0ifAxslhjvPyHfH96My+r5CRV
         rEYIENbEzFNQJyGOA7lEBkSILjeiNZql4OEX9ZbGOLdl2eChvXM73kCJIrsluybH7jkc
         DAcnLz9JGKJxOnaGTwTUQ62XyXyTVK5gC+AAWw97DloErOm0V7bR+3yijC9fLqAwBOkO
         O2ZG9w+8fjSrT4iZdn6X9BtzMmS474szqbBwwMH2DqQ53TbsQVTOIDkda5z45oqo6Q9/
         Te3PPJNE2hWfv6zs2knRSmLLPEJHfJ38PVbacaXiJGwp8X0pt3GzMPhC8PI6z2Qq3n1G
         npOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678701012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HG3KG6VQNJrTxZcAoDu4OYtxrPugKypRTH1cm2KrTvM=;
        b=YhWvQIxv9DbjbktCKFIrjmVdfD56CUMy1FyIK0+J6GOrHd8pIwC6zwP3A16A5zoCXu
         M1pS0sj8+vtgf/9r5NZsJ5WPy7MnZ0Qb4T4lFAusSHGS0Bt+IwEZ+jppasWl8HiN8/iu
         WIMh3WRW2ZWerrS9/UQe/QRPiaHlxLLUGcvRmshKoercYp/LnxVlYDDd4lOQFFLe+mud
         y33RBGNmi0jfbssm860rQtBWzPM5uRVN15/n9+lOtTnIY1vzBEmKurrfEWOfWvuGdYM3
         6egAGdA8MAuCu6ccofETqsUwHo+eqRNcivLAGSHvKBh1DvZiiKiBiKDGTpF8giXJPGvJ
         +K1w==
X-Gm-Message-State: AO0yUKX4p1u/ihJcT98hhIu1+6vKKExgoUTpJLZUfGNn6Y3lJ3cGK9tc
        y9gd1gjLZy9OlwQ+GAZPKvo=
X-Google-Smtp-Source: AK7set9X/eLJm4HatzB8FVC4j7JM46lgk9d3TBh2MX3eA17lo0ZO50hhD2xz6IZRPrFxjLdFN4FESA==
X-Received: by 2002:a17:902:d492:b0:19c:b7da:fbdf with SMTP id c18-20020a170902d49200b0019cb7dafbdfmr42661165plg.26.1678701012550;
        Mon, 13 Mar 2023 02:50:12 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id ki5-20020a170903068500b00196251ca124sm4340511plb.75.2023.03.13.02.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:50:11 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] media: dvb-usb: digitv: Fix null-ptr-deref in digitv_i2c_xfer()
Date:   Mon, 13 Mar 2023 09:50:08 +0000
Message-Id: <20230313095008.1039689-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In digitv_i2c_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach digitv_i2c_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen. We add
check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a ("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 drivers/media/usb/dvb-usb/digitv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/dvb-usb/digitv.c b/drivers/media/usb/dvb-usb/digitv.c
index 2756815a780b..32134be16914 100644
--- a/drivers/media/usb/dvb-usb/digitv.c
+++ b/drivers/media/usb/dvb-usb/digitv.c
@@ -63,6 +63,10 @@ static int digitv_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num
 		warn("more than 2 i2c messages at a time is not handled yet. TODO.");
 
 	for (i = 0; i < num; i++) {
+		if (msg[i].len < 1) {
+			i = -EOPNOTSUPP;
+			break;
+		}
 		/* write/read request */
 		if (i+1 < num && (msg[i+1].flags & I2C_M_RD)) {
 			if (digitv_ctrl_msg(d, USB_READ_COFDM, msg[i].buf[0], NULL, 0,
-- 
2.25.1

