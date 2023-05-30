Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731767169DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjE3QkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjE3QkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:40:10 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D258F;
        Tue, 30 May 2023 09:40:09 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7773a735bf8so46703339f.1;
        Tue, 30 May 2023 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685464809; x=1688056809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9agsz9BdjIrnVIxMaWFsK/cg3sewH3cif2PKAjY54I=;
        b=A4n+XhPujTRI+NiRmDmvoi3Hoq6SkXjqZHO7TUcoOpafJPQqCKiZSaZkESe4mrOBDo
         pdla6Kmb1acTOmDCpBKITbAbdjuXF/ZQ9OSn1yrD6ExSuADNkkHVefu2zMfCepFibH/y
         X/GD3wN5lTeNDOVKW2oXNOZcnMvXte5ZQtzkiDqeMiL4PHyUNC8piFNmGzzmZ6yZ//Do
         GZTsTNdhEcsuudsZR7zyiE23IHQKzf2+7xFujVaD+7XM0n3LyEGSiocbVsXbN4WMeyP+
         3lesFI3FS6EF1VMM3Oj2fhmjD8Xb2k9TJNjomesUswmn8T0pBs7UfsOpyVeobKPY8d1y
         bO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685464809; x=1688056809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9agsz9BdjIrnVIxMaWFsK/cg3sewH3cif2PKAjY54I=;
        b=TiWziHXNnXLcMVIiRBXKRv0a9096yl1wueABlPTp5m4Q80AY7UFUIvPqblJGK1aZ/U
         ZAoornR5JSrherRu45Kuie+U6+VhOcMtX7cSKCUftML4i3KP7DU11SW3K1SVe84E/jPP
         XwPJlhK+3utwePUDFcOrIxUSPB18ibQ0O1UX6XHCO6Fz13sMO/tzIAgHl5A4aYc7gx2Q
         yyOq1YvlQEvj0YXKKlAmCeUMBprbWjO6nFfR+qXyO643HX7pU4o789c7SHgaPIpUHwGt
         zkfoI79i9jCFvnmh2YsfYfnbE1iJm/x+WNjTnbTumS3fb3QanADtOyH+kQST2M6JsiJh
         7n0g==
X-Gm-Message-State: AC+VfDwEsfoBFF7kLhkR3dAKuo/wwGFDJXhEc/fFOqlm7RV8XeBLTpzY
        vfKZuU6JRX/cT4DqfJqw+tk=
X-Google-Smtp-Source: ACHHUZ5MI/JShx0lc4b7BjKuSUS7T9wjVGEPE6GI2tCvjroHoHLFi6oGYoUUd77mQWSytwYcuyvKkA==
X-Received: by 2002:a05:6602:2598:b0:760:ed78:a252 with SMTP id p24-20020a056602259800b00760ed78a252mr2054989ioo.9.1685464808981;
        Tue, 30 May 2023 09:40:08 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id l13-20020a6b700d000000b0076c81bf2731sm3330165ioc.20.2023.05.30.09.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:40:08 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Maxim Krasnyansky <maxk@qti.qualcomm.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: [PATCH] uml: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:40:04 +0000
Message-ID: <20230530164004.986750-1-azeemshaikh38@gmail.com>
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
---
 arch/um/os-Linux/drivers/tuntap_user.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

