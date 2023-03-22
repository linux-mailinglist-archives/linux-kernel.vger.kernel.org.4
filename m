Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F1A6C3FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCVBhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjCVBhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:37:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6B3570A8;
        Tue, 21 Mar 2023 18:36:42 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id bf15so7814788iob.7;
        Tue, 21 Mar 2023 18:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679448995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnkm/lF+4QiievpuG5aB+/enRuP0EybYte+rz+ieDGI=;
        b=Rp5FDiWA5X39lZ0AaWfjiZv1khAeB+MoVUr7Ai8MiF8gVBMeD4aZh53+AskX75aflF
         hT/lK79E2mYKR+Qt3AOhPWnSLfMIowGZgi4OpOelnj01aJeg9UsN3cvwG5xVgIFbkJ/D
         rL+snB5ydTmd6BsGwav3dmoXKplnouRi/IpGImKwBiiesl1fa5b2uEZp24TqprO/xGvr
         w7XrAXvyQ13XQbD0Mbe1Pl84w4+F7su4LrAjPEKxGKJPrKGjtHENiv2z4bJKYZGsDKCb
         zTE7C+t+o9erPLtkZzwCBGD0/B+yQiUNviON3gfvZKHh/8RzQ6uTmd9mUZiHaU0z5cUu
         tSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679448995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnkm/lF+4QiievpuG5aB+/enRuP0EybYte+rz+ieDGI=;
        b=q5fciN01zgSaWZIzcL9NFDU28HNT72W1Lbc2UCRXhDU8Z2sn4vQf20m8q3miwwTUL1
         8ge4R0X5+ullNPeF0JFX2HQK5mWd1on1MnxMb7HkEUK5POO1/s6/F2UYLa3FGl26ZxN/
         dVbHg651j0QvLYMWTbrbQgJUG0k0z7obJngZ/UpY21NtX4GpS5tYygKPzGZNnMq7C31o
         57KWCBdQFcRmSsZTe78s7pK3AfX+kMcf34ZlRNYFztoewZs7SZCUQGmgfKIG67VJBPoJ
         mS5SGceWRdIgNcedX5WKepbJiA+lUH0WAZfuOIt3iatpcbnaCrGtBg7dwwOhNTfeETNF
         Nu1w==
X-Gm-Message-State: AO0yUKX1mBFHxq+G2+tw4QjVJUjlLw7T/U6BEe96r6P2N4NKyTkFOXHA
        /Q/vXBRjaRm3B7SdxGc57t2G26KvNnw=
X-Google-Smtp-Source: AK7set+A7Tk+TLQvxE+Z0O3tb4ALO9hvfN4R6hR1H8G6ETAt59MgDmKCpLqfq5ttfInhV5UIJ7uX0Q==
X-Received: by 2002:a5e:850c:0:b0:758:b06f:6ab2 with SMTP id i12-20020a5e850c000000b00758b06f6ab2mr17376ioj.2.1679448995117;
        Tue, 21 Mar 2023 18:36:35 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id a22-20020a6b6616000000b007530bbfa577sm3925058ioc.18.2023.03.21.18.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 18:36:34 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 3/4] module: add section-size to move_module pr_debug
Date:   Tue, 21 Mar 2023 19:36:22 -0600
Message-Id: <20230322013623.251401-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322013623.251401-1-jim.cromie@gmail.com>
References: <20230322013623.251401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move_module() pr_debug's "Final section addresses for $modname".
Add section addresses to the message, for anyone looking at these.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 kernel/module/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index e248a3697ffb..a2a8ed8564ae 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2177,8 +2177,8 @@ static int move_module(struct module *mod, struct load_info *info)
 			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
 		/* Update sh_addr to point to copy in image. */
 		shdr->sh_addr = (unsigned long)dest;
-		pr_debug("\t0x%lx %s\n",
-			 (long)shdr->sh_addr, info->secstrings + shdr->sh_name);
+		pr_debug("\t0x%lx 0x%.8lx %s\n", (long)shdr->sh_addr,
+			 (long)shdr->sh_size, info->secstrings + shdr->sh_name);
 	}
 
 	return 0;
-- 
2.39.2

