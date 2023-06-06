Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBA8724B51
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbjFFSZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbjFFSZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:25:10 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A742C11D;
        Tue,  6 Jun 2023 11:24:42 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-33aa60f4094so19032095ab.1;
        Tue, 06 Jun 2023 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686075867; x=1688667867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V12rCjy7mPc3LIBp5uRLQjG6txyB7DcxNo61Y87f3E8=;
        b=iy/xvJarg3bLpHU7R7JQ/+OIqn6X9rB1vjDBEYSmRbGrF2GYKSNyCBxqDKaTg3TsY1
         m8XyTGpH3SUlb8n2kQg7nkhHq0b+xvMWHVAwznViXl32hPsaKltXyM7txeJ3El3WXp2H
         /RsZ/MHX05X8ig+jqB6WkaMITlkFjywymK1swg8trjjSAYwPLIC84KO7kM2we1+ZWb8x
         Vpq/cQw/auxNKUg100D2+YjMMUajgwlUt09Z73LOQworieqQRB3yUdq/odGQZDC+Xl0Q
         mwL7r6Z+4XZ7veO+wP2a9CgrH8sfBr9vQdwtRPstIS8z/ofMvJYtn8MFqNF6uDm7mvl+
         2P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686075867; x=1688667867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V12rCjy7mPc3LIBp5uRLQjG6txyB7DcxNo61Y87f3E8=;
        b=YVeIXuC8MIwciJhis37aO+lbz3lhpHjywreeMm9lTAZdDgbAIx4FN+tPLFcEk8K5hu
         YpRYFXnmSinKRmmxvNkYHBQuiUJ4TwZYZipSi4ApOZc0A/WHFEqiXSeOcebeQA9PSFL/
         5zHlRxT8qGaK2FMU5rkFlJU2CfEllFm22rAqGe2ZWbunXeg9LB7OnpB6EwY1iUU/XNno
         Y7SC7GTvT181Q4Fzi2IdWeqUbaTQGX72MfsXMtxm/IlsfPOxTfAHzIcqHR2jHLqBnLyG
         q9uPanwufc9seBY6woY0H9cxvKEe8JD7VijB3GYqoBS+fl1rZ6ZNVNmRze2flUGzecXN
         1pUQ==
X-Gm-Message-State: AC+VfDyBrSRykUBwrIms1ibpGpr6DZpA84Vlstadx9QefFGUAmmhXzCa
        LDyXfVw/bqX8r8HkzKjOBaM=
X-Google-Smtp-Source: ACHHUZ4Xl6Q3aZU+8ToKIEYcfoUZ4oDIRjhiWwJIU6JSAcZnO8WFZANa3GqrSDV09npzYmGy1N2rbQ==
X-Received: by 2002:a92:2805:0:b0:334:de38:d600 with SMTP id l5-20020a922805000000b00334de38d600mr2401946ilf.3.1686075867141;
        Tue, 06 Jun 2023 11:24:27 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id p15-20020a92da4f000000b0033a4f125238sm3235543ilq.41.2023.06.06.11.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 11:24:26 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] uml: Replace strlcpy with strscpy
Date:   Tue,  6 Jun 2023 18:24:09 +0000
Message-ID: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305311135.zGMT1gYR-lkp@intel.com/
---
v1: https://lore.kernel.org/all/20230530164004.986750-1-azeemshaikh38@gmail.com/

Changes from v1 - added strscpy declaration. v1 does not build.

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

