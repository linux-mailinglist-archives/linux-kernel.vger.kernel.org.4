Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FDC72D68A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbjFMAoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbjFMAoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:44:13 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9C9197;
        Mon, 12 Jun 2023 17:44:06 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77a62a84855so204583539f.1;
        Mon, 12 Jun 2023 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686617045; x=1689209045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EfdpRgK82uIcWY9DiF8XW3rM3gbbM8fuRAOQCRLpNoU=;
        b=At4Y9fekSW8Lzq4Bl+jd33oBq3U9HO0KTPWDEr03dg4Y27nisUQ+upPdxCl7LSo8Ob
         1Tfi4pKLmKVy1TyuzAFqDMFiMG5S6/nakUHt3IBU6TXT49LitBoLG4wJspnsDHjbw4tp
         1XNYkchZ8s+m5VZLLpSGMl70BJrBWS7LIH49mA6XzcY9YFhPlQ2zS292TLVOlkDf4aWe
         oLSVCnjurllZzQz3ErjurwELXZHv75oBrDrq1tJY8yVlg6dhw/hOb6Si3nwyDverNbMo
         IpfQWSWow1ZL5cAxnvIurkOGDvYuln8MUyx6FqCW6tnVXf0S9sOWm5OmimPm/Nahrxx8
         LUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686617045; x=1689209045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfdpRgK82uIcWY9DiF8XW3rM3gbbM8fuRAOQCRLpNoU=;
        b=Ndea5XJYYoXj+UEipbPijTPsgnfHt2lH41f8N9LHsTAf5pTfuWMQxttGQOMpP+l1E0
         V9Hk0lr2yCclorHW1OxAqXuTQpHK2KmB21hmUrlAeH5c69+hS1Lyb/HpEhaN9HYBooPN
         2WjYS8WCB0Mzv4CrhGkJ5JajPTfTmgaqlf5m1GG6f5KIgqvk13y4QtIC/uuaOeXFZlOj
         +SY4NMS8qCMYRDdrhDnomRKfYsgCreSOwtXp6uFGU4QuGdxLagnGhG4OVbiFkmLpHrq0
         JL29JVQE9OrjU0XyJ2422SIxafe6AhKetqwuGqM5wg2jnPaMudBCm8w7yylc3uFaQ971
         QERQ==
X-Gm-Message-State: AC+VfDzwJjS4pw5QJxpWGsacBZ2Ztd/tam1On4S3fk2n6i3VMI+Fk8YO
        vWteih4T/n2aAw5H3RoNx00=
X-Google-Smtp-Source: ACHHUZ6w+Eq9N8dZexuZSv2xrTC5UmzN3S2cmTdQVxCP1TEaGj+JmzvZ55Yhdiy+y+a4XZVkItsGjg==
X-Received: by 2002:a6b:f915:0:b0:776:fc02:184e with SMTP id j21-20020a6bf915000000b00776fc02184emr8602127iog.14.1686617045259;
        Mon, 12 Jun 2023 17:44:05 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id cu13-20020a05663848cd00b0040bb600eb81sm3117118jab.149.2023.06.12.17.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 17:44:04 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Hongren Zheng <i@zenithal.me>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: usbip_host: Replace strlcpy with strscpy
Date:   Tue, 13 Jun 2023 00:44:02 +0000
Message-ID: <20230613004402.3540432-1-azeemshaikh38@gmail.com>
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

Direct replacement is safe here since return value of -E2BIG
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/usb/usbip/stub_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index e8c3131a8543..a92a284f5abb 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -174,8 +174,8 @@ static ssize_t match_busid_store(struct device_driver *dev, const char *buf,
 		return -EINVAL;
 
 	/* busid needs to include \0 termination */
-	len = strlcpy(busid, buf + 4, BUSID_SIZE);
-	if (sizeof(busid) <= len)
+	len = strscpy(busid, buf + 4, BUSID_SIZE);
+	if (len == -E2BIG)
 		return -EINVAL;
 
 	if (!strncmp(buf, "add ", 4)) {
-- 
2.41.0.162.gfafddb0af9-goog


