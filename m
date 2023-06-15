Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12258731FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjFOSFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjFOSFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:05:17 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DE0294A;
        Thu, 15 Jun 2023 11:05:16 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77af8476cd4so241245539f.1;
        Thu, 15 Jun 2023 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686852315; x=1689444315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTzjIPEwDtJWLAzeAsvb4NlWnTXxzWKQpJzFMf/OIsI=;
        b=ct3m/61tx+sYa32N9Sp1Jwh41tW7jnAAUkoUHq5YUkhE+EVShqAfdRz+Y6s6ZnJDXs
         KUvVJzDyxk94OBkAvUpxBd2f4ZRSEUAk0DKE+mbHfrHqyOKTkLnPXvwB8SNnShItzXGr
         wqZ2/rzsJzU1CTRdqKHMoCxFjlMvZF1EkXjCGvHcbhicTKF5EfnEJZ//osnpCG5glNwE
         rvwJuLaDc/T/y/ZfF7rMI2EjKAdD38xm/ZljGGXt4ujLfeSmswFZgLDGds4d3Kr5Ia5s
         qXaRa5fr3Wz3SkulrW8GDcS7IJSY5WNKiFNjfhIpLbqcs3Vfsp3yFJqVuXjK1S6ra1qv
         KI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686852315; x=1689444315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTzjIPEwDtJWLAzeAsvb4NlWnTXxzWKQpJzFMf/OIsI=;
        b=Ra8yP1pyrHqePBh84+/HKbQZN5Q3iGPi/SXTvMziFDgf0sU580302+kn1asvTyAT/X
         h/ANoxhmIIYzyYpTX+PYMm+TosWq64mCouXCNyCjo7V7Bwea6r7BdXuEK0wcTWqVa6Bw
         h5ZTx7Fb9UegitRvOZpmTuxA1ll83bvK0H+FUCWrZI8MBHnBiiforNXEwdnWROj3+7Dm
         jVmUMLhPtOeq9tX90g9vkC2mOrsv4TTezrfeyukyfxeGEXT4d7Jz/B5NJCmAQvUatKdc
         LRM5nJwYDbdqeUiblX1BGzdziBAquJvXGS1XGGkOtVGwjcPDJtnSXRL66dZgEz0pu4YT
         GuQw==
X-Gm-Message-State: AC+VfDxjeKZDxH5yR6EFVhbi0Kkplk2LGOA/e27XJWihG2/PULh+TjDL
        WXyK1Y+UgcNh6ntsVRw6RfQ=
X-Google-Smtp-Source: ACHHUZ6mmB3OzONX3r+Aj/HQ4dIm0PuOXHfMGHTcwWWY7Lj3eAwyXjK0u7JcOUDO9mWODf4yM6uHdQ==
X-Received: by 2002:a6b:e803:0:b0:777:84d7:8e77 with SMTP id f3-20020a6be803000000b0077784d78e77mr201040ioh.14.1686852314186;
        Thu, 15 Jun 2023 11:05:14 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id h2-20020a02cd22000000b00420cda3fd2esm5739573jaq.155.2023.06.15.11.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 11:05:13 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Hongren Zheng <i@zenithal.me>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] usbip: usbip_host: Replace strlcpy with strscpy
Date:   Thu, 15 Jun 2023 18:05:04 +0000
Message-ID: <20230615180504.401169-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since return value of -errno
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
v3:
 * Removed declaration of @len to fix build failures in v2.

v2:
 * https://lore.kernel.org/all/20230614141026.2113749-1-azeemshaikh38@gmail.com/
 * Use "< 0" instead of "== -E2BIG".

v1: 
 * https://lore.kernel.org/all/20230613004402.3540432-1-azeemshaikh38@gmail.com/

 drivers/usb/usbip/stub_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index e8c3131a8543..0a6624d37929 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -167,15 +167,13 @@ static ssize_t match_busid_show(struct device_driver *drv, char *buf)
 static ssize_t match_busid_store(struct device_driver *dev, const char *buf,
 				 size_t count)
 {
-	int len;
 	char busid[BUSID_SIZE];
 
 	if (count < 5)
 		return -EINVAL;
 
 	/* busid needs to include \0 termination */
-	len = strlcpy(busid, buf + 4, BUSID_SIZE);
-	if (sizeof(busid) <= len)
+	if (strscpy(busid, buf + 4, BUSID_SIZE) < 0)
 		return -EINVAL;
 
 	if (!strncmp(buf, "add ", 4)) {
-- 
2.41.0.162.gfafddb0af9-goog

