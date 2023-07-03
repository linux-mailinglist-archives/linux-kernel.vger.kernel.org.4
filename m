Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649ED74605F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjGCQHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGCQHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:07:00 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56AC138;
        Mon,  3 Jul 2023 09:06:59 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-77a62a84855so186812139f.1;
        Mon, 03 Jul 2023 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688400419; x=1690992419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XBgsg73vfcfpxpvplcZPVuxEEYtarzD8ZTzO1oit0Y=;
        b=pZf/pW1HVY7519wBp/TXZgywkPiZqjv+/84lT/jbDTW3z+eo7zbRhZz9oIJ+XX9eky
         dH5+U3Y809G+J3F8tSRbBF8aa9jCsOF9fafygVVyF6siZhwAejXPCRPSmUwPRnfZ2EkJ
         iSkaL0h8Y4uDz68d25P/lGFJXro0bCUkt1NQ71V1mBB42FvTHLMTSuOmuuqncmxYhOD+
         DtPLxCdS4IdquAgmpl+Guy8vBEf40UoR4xSWdamXfCUI2FVsG4Ee1ny2h/68Q0xDHjV0
         kLJAKf6ewmRMG5petrdzoO2rMjRbcYIERqKFyxL8bq473DTT+qrVdsW5U22+mCQfriUY
         +txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688400419; x=1690992419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XBgsg73vfcfpxpvplcZPVuxEEYtarzD8ZTzO1oit0Y=;
        b=ISqNTAkazP6e9vbs/DDwM80ZGsjc96nK4PJrkCe0Fj3Lc0T9a5ORbRNUaXa/R5+rtc
         UNEr3L1Yv+tb94Ti1WC8EVsFW3qvxGx8i4xWhadVRBRLcYc3uwhsVS2cHkbQuM6k0mLi
         O3pOBEOul5Y8PLLAjjyQiucAucU8JhfrA3q1MqzYvBTJXpFJ4z380LUHi4AL+EeJ6k2w
         CYyoQWNNlhX9S3d5tnLVANw0xOVSJ4qYSUrLesPhXFIoR9UnD8DvQ1mY/qTrVOb5qHIu
         SNl0N9vCJU0Oab884sb/e7tk4HokK4q18w0WHJCFX9MN8wKBacLqlGzMjNiKZXmpmC6v
         bGHQ==
X-Gm-Message-State: AC+VfDwaFuiBwg6KCIG1Tu2UWUrI+c/u5BsL+JdO4Hdl/FWSdT0UVRuZ
        orczV14JGnC/guty7VwFhLCdNzgQkHD7IkFh
X-Google-Smtp-Source: ACHHUZ4eTaCX/Uf7PO4YEGe29tb5DCx7JVB122+zEXfUxscjYX8gmyEhHlAVa0Ypb9J6vm3ETUWKYA==
X-Received: by 2002:a5e:d70c:0:b0:785:d06d:7b04 with SMTP id v12-20020a5ed70c000000b00785d06d7b04mr10641511iom.1.1688400418947;
        Mon, 03 Jul 2023 09:06:58 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id q15-20020a0566380ecf00b0039deb26853csm3760963jas.10.2023.07.03.09.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 09:06:58 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] um: Remove strlcpy declaration
Date:   Mon,  3 Jul 2023 16:06:41 +0000
Message-ID: <20230703160641.1790935-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
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
 arch/um/include/shared/user.h |    1 -
 arch/um/os-Linux/umid.c       |    6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index 0347a190429c..981e11d8e025 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -50,7 +50,6 @@ static inline int printk(const char *fmt, ...)
 #endif
 
 extern int in_aton(char *str);
-extern size_t strlcpy(char *, const char *, size_t);
 extern size_t strlcat(char *, const char *, size_t);
 extern size_t strscpy(char *, const char *, size_t);
 
diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index 7a1abb829930..288c422bfa96 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -40,7 +40,7 @@ static int __init make_uml_dir(void)
 				__func__);
 			goto err;
 		}
-		strlcpy(dir, home, sizeof(dir));
+		strscpy(dir, home, sizeof(dir));
 		uml_dir++;
 	}
 	strlcat(dir, uml_dir, sizeof(dir));
@@ -243,7 +243,7 @@ int __init set_umid(char *name)
 	if (strlen(name) > UMID_LEN - 1)
 		return -E2BIG;
 
-	strlcpy(umid, name, sizeof(umid));
+	strscpy(umid, name, sizeof(umid));
 
 	return 0;
 }
@@ -262,7 +262,7 @@ static int __init make_umid(void)
 	make_uml_dir();
 
 	if (*umid == '\0') {
-		strlcpy(tmp, uml_dir, sizeof(tmp));
+		strscpy(tmp, uml_dir, sizeof(tmp));
 		strlcat(tmp, "XXXXXX", sizeof(tmp));
 		fd = mkstemp(tmp);
 		if (fd < 0) {
-- 
2.41.0.255.g8b1d071c50-goog


