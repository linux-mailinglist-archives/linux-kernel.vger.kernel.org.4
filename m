Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A80472F10D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 02:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbjFNAgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 20:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjFNAgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 20:36:09 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4960F1980;
        Tue, 13 Jun 2023 17:36:08 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34096e3799bso1279985ab.2;
        Tue, 13 Jun 2023 17:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686702967; x=1689294967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xqWV/pnyyDUYkwTA+7Sh2AJ6YJrRKoUQXxS4iBU19zk=;
        b=NCdkRND0uC2XlA7YPldjVoBxqUJXvAxX7EBgqaLCwuIE8u6vezjwlRYBPCd27LPDe7
         IQPBonjnPAyfxfdB5Dcz/5eJSuoOPJxNja+LFwip4HxQ/92Y/HnfUiWrTXeptg9Ln3Di
         Wpnbi5+1op2bx6K3IVIKJaczm6oe1uaiCJq5HA+2F5A2koZeG4Wqx79co2Jj5B9MqZlt
         uYi22nj2CTpJLiSaXNDtdEQ4WhvmmeIQjw+QzbtvZ+X2DgW0ouQheD/ax8HxZO2Z9x60
         jiPSN6NZv+Gh1KtGjKm5O2UurZN5ySGNk92P/embGIhWX4PqaZ3yxuusBfX/95562kKF
         CO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686702967; x=1689294967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqWV/pnyyDUYkwTA+7Sh2AJ6YJrRKoUQXxS4iBU19zk=;
        b=AC3JY/w8dOVBpQK5dyJPmT1fj9cpvRGJyq4zM10jYSY3xgG4Fug78Apxj/NQe1948P
         P7/wz1LBIQkqY9OEXxMNMss2842nDcK4Y6NxYxhPW4Ml7zX3v1XoUMg/oa2GgD0So8Ro
         gmRucUJPZim3SO8g/n06Z1by8n/k6jf9sIqXel+eAxqOCgERDn+LdrJkwOCq3j8Omo7g
         IpJPzGXSi5KbpFDaQVvb5cPcfB9zN1VhlMTLBB4Leu3rHn7q2+7pABgmyWfeZrOhZzjj
         ErDPECrOBIrnUW7sRO2HN75fJ/Yv5bZoXz2Ru3mXfTDfLwtWZCvrIXCxUUjrVExnsLx+
         9P9A==
X-Gm-Message-State: AC+VfDx+SVWR31C6pvtgTP2awlf/bYSiw3ol2Hr1atvc2o9n55w6VHQ0
        czGN1K0XAFyBHb3u49iarsQ=
X-Google-Smtp-Source: ACHHUZ49GziAH6p4LMsFcDvEgpV5WbArcvQ1nZ7RKW63pE36shMn/iEVZa5UqboftYUVTUBdPn2lIw==
X-Received: by 2002:a92:d44d:0:b0:335:a70:5e4d with SMTP id r13-20020a92d44d000000b003350a705e4dmr11322786ilm.16.1686702967478;
        Tue, 13 Jun 2023 17:36:07 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id q18-20020a920512000000b0033b2c178254sm4131604ile.22.2023.06.13.17.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 17:36:07 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3] uml: Replace strlcpy with strscpy
Date:   Wed, 14 Jun 2023 00:36:04 +0000
Message-ID: <20230614003604.1021205-1-azeemshaikh38@gmail.com>
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
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
v1: https://lore.kernel.org/all/20230530164004.986750-1-azeemshaikh38@gmail.com/
v2: https://lore.kernel.org/all/20230606182410.3976487-1-azeemshaikh38@gmail.com/

Changes from v1 - added strscpy declaration. v1 does not build.
Changes from v2 - removed Reported-By: and Closes: tag from commit log.

 arch/um/include/shared/user.h          | 1 +
 arch/um/os-Linux/drivers/tuntap_user.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index bda66e5a9d4e..0347a190429c 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -52,6 +52,7 @@ static inline int printk(const char *fmt, ...)
 extern int in_aton(char *str);
 extern size_t strlcpy(char *, const char *, size_t);
 extern size_t strlcat(char *, const char *, size_t);
+extern size_t strscpy(char *, const char *, size_t);
 
 /* Copied from linux/compiler-gcc.h since we can't include it directly */
 #define barrier() __asm__ __volatile__("": : :"memory")
diff --git a/arch/um/os-Linux/drivers/tuntap_user.c b/arch/um/os-Linux/drivers/tuntap_user.c
index 53eb3d508645..2284e9c1cbbb 100644
--- a/arch/um/os-Linux/drivers/tuntap_user.c
+++ b/arch/um/os-Linux/drivers/tuntap_user.c
@@ -146,7 +146,7 @@ static int tuntap_open(void *data)
 		}
 		memset(&ifr, 0, sizeof(ifr));
 		ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
-		strlcpy(ifr.ifr_name, pri->dev_name, sizeof(ifr.ifr_name));
+		strscpy(ifr.ifr_name, pri->dev_name, sizeof(ifr.ifr_name));
 		if (ioctl(pri->fd, TUNSETIFF, &ifr) < 0) {
 			err = -errno;
 			printk(UM_KERN_ERR "TUNSETIFF failed, errno = %d\n",
-- 
2.41.0.rc0.172.g3f132b7071-goog

