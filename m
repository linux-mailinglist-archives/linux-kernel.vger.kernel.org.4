Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF36661521
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 13:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjAHMiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 07:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHMiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 07:38:17 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE418A19C
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 04:38:15 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id cf18so7425190ejb.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 04:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Avq55gRD0o24gHHFPcHLu6HTKb28LUs31qoNXBnZq7o=;
        b=SaRq11IRo9W5C99Bvfz6SYfn4HdsdfBFfQWi6NBPtPLz1Gb/qDzWd8WnqYPNs6llUr
         35itgXqlGWAcRp7VZScT0IT73imvtXOVbNb/IRNKoo/VjnUrs/cv7IDScj6HiHeHhhoo
         svaX1tcRvBkyH5cGqT4STpAfINPyw9bCgHs7VuFbDNY5S2mq3mgmPKoAO7ZWL/E7HEAo
         4BsM77RYm+0VkdKxeEu1SgwEhY0u1E7phyLx7BN7xcM6ucODYmql+tlOyhYMHNsEHWwD
         JteerpUUcLCY+W9M8LMp3GEj5el1F7EpTPYpmiA2Hw2VaonVv7IE7yKISSEyTY0TUsoS
         Dnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Avq55gRD0o24gHHFPcHLu6HTKb28LUs31qoNXBnZq7o=;
        b=UlSAsJZnUKS2HhzMJahFIj1tKDjvwHfxfu4V7y4TtH0T8pSz4fiimdM20eMjEOt1Bn
         V2bothWwdAzzifgIWNBbITjhgrCJOLTyg4Nk/0ydgv7fAxZpdumlmNb5Toe3vi2abmGf
         32UQOGCXpUED/m9kbs2OJbxxhKgllN7NouavIUfQ7gkBMEd5euaxJqutXheuB9RA3nuV
         +gcL8Jf5EC8JXrxJeSILkfJXh7SrlSLXLfgjwIlE1GJK18ITJWlVX198DA0GnpK3bBy9
         7jg+39BUmqJ+27dCx05dqvXfQe6WiyUV+2Qb+smXqSIzVldeDqfudzjxFho0uxjUzkKd
         jdSQ==
X-Gm-Message-State: AFqh2kq6WNYJaXiZxVoEtu0Pz787TeUM5KQ9WfKEEjnqo7pjo++NKvPY
        vsUoYie0ocwSVQw/3HpgJK8=
X-Google-Smtp-Source: AMrXdXsGwNrCX7itkrEzflpaam01vpOlqAU8MXw5HzlKCcaeLy7rER92TGCNEedyar9AJR2l1umm9Q==
X-Received: by 2002:a17:906:71c3:b0:7c0:dd80:e95e with SMTP id i3-20020a17090671c300b007c0dd80e95emr59081397ejk.51.1673181494346;
        Sun, 08 Jan 2023 04:38:14 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbc8.dynamic.kabel-deutschland.de. [95.90.187.200])
        by smtp.gmail.com with ESMTPSA id e15-20020a170906c00f00b0084ca4bd71b8sm2448014ejz.208.2023.01.08.04.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 04:38:14 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: convert rtw_writeN() to common error logic
Date:   Sun,  8 Jan 2023 13:38:04 +0100
Message-Id: <20230108123804.3754-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.0
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

Convert the function rtw_writeN() away from returning _FAIL or
_SUCCESS which uses inverted error logic. Use the common error logic
instead. Return 0 for success and negative values for failure.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
Tested on x86_64 with Inter-Tech DMG-02.

 drivers/staging/r8188eu/core/rtw_fw.c       | 10 ++++------
 drivers/staging/r8188eu/hal/usb_ops_linux.c |  7 ++-----
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 682c65b1e04c..1e4baf74ecd5 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -89,9 +89,8 @@ static int block_write(struct adapter *padapter, u8 *buffer, u32 size)
 		addr = FW_8188E_START_ADDRESS + i * block_size;
 		data = buffer + i * block_size;
 
-		ret = rtw_writeN(padapter, addr, block_size, data);
-		if (ret == _FAIL)
-			goto exit;
+		if (rtw_writeN(padapter, addr, block_size, data))
+			return _FAIL;
 	}
 
 	if (remain) {
@@ -105,9 +104,8 @@ static int block_write(struct adapter *padapter, u8 *buffer, u32 size)
 			addr = FW_8188E_START_ADDRESS + offset + i * block_size;
 			data = buffer + offset + i * block_size;
 
-			ret = rtw_writeN(padapter, addr, block_size, data);
-			if (ret == _FAIL)
-				goto exit;
+			if (rtw_writeN(padapter, addr, block_size, data))
+				return _FAIL;
 		}
 	}
 
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 7c72f5e04d9b..f02f8568cdcf 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -179,14 +179,11 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intf = &io_priv->intf;
 	u16 value = addr & 0xffff;
-	int ret;
 
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
-		return _FAIL;
+		return -EINVAL;
 
-	ret = usb_write(intf, value, data, length);
-
-	return RTW_STATUS_CODE(ret);
+	return usb_write(intf, value, data, length);
 }
 
 static void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf)
-- 
2.39.0

