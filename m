Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2D623A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiKJC6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiKJC6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:58:49 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABE75F8F;
        Wed,  9 Nov 2022 18:58:48 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id f63so488230pgc.2;
        Wed, 09 Nov 2022 18:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pvz205DnpMYHAC74hYEPtX/pc7K6R5jYdg5JQ8ou98w=;
        b=om6xhvj1Dif40J0ma2nZNHqR4zbPBvrVJXZ2gRRs/6SCtI89feoKTCwzpw8RqyOQD/
         nSm3tuwZD+pQhZiPQBybXayqS09vD5Pq4hGLjNbTPemO/8qkI2yKPr/MYeKBZTWeglRH
         TyAzFN9AA/umJz67fnPXeoi5i+stD+OFlhTLgf0ZZUA6vfegZkjXwY9r7F9+y6ifAIte
         tK5QlkD3KNSYSoSmdKaUHYCbhcF4Dcubi2oO0O5+qknx35O2haOuU5kPC1WWvt1iGoWi
         +pLoBzKCFP4mP8ubtk9Qp81KZypLfrtudcndXrp059ti9ojw/H7O7SKsVXXCcPr1gC6D
         t+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pvz205DnpMYHAC74hYEPtX/pc7K6R5jYdg5JQ8ou98w=;
        b=d51fQuRXHh1HfLdky2Wdn8kBUy7gW9SljoffMiG93xT4CpnZv8uMn9Y8AXo8yCpxCf
         V2Fh9/vLpxVcX5qOcaIKoI0Li3B6/eislesO5nqtJc2uNkdI5f5yxqK7dmTffrVmJbf6
         vJTIiz5nXMJuIFjMSRJfWd6YWjimwWnUjHUveHPIzqx+GJZHP/W9N1Ih3eYvxIo9U8kq
         pyGTiM3v1C/KLMiP2CPSlyWOBODSoJZnc3Sq2lbpfWI+gi518yDmPx6bWxYB9B/psFjT
         lPEx9lXCOV0HA9RMS4neTl92+RuC+dCiqahVayCXCndruw1sQdJC8WGfKktrKwAVQ0xp
         fPOQ==
X-Gm-Message-State: ACrzQf2vAcZBlRDc67do6lJ5DwsETAsoBFBcutd2Ns3BjPvKoy+Qsj0W
        Ig9QVoWPwVKQ8+0yNB5TJjGb+jgeJ0JcmIlL
X-Google-Smtp-Source: AMsMyM4XLyYu30PUcwOIp3OUIXUywgKftZPwtv2iyCqObaEGYOgvNy/y5V2TGA1z/vPttY2qjZFeYQ==
X-Received: by 2002:a63:8641:0:b0:46e:c693:2e57 with SMTP id x62-20020a638641000000b0046ec6932e57mr52122180pgd.341.1668049127688;
        Wed, 09 Nov 2022 18:58:47 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id iz5-20020a170902ef8500b00176a2d23d1asm9817368plb.56.2022.11.09.18.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:58:47 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] module: Fix NULL vs IS_ERR checking for module_get_next_page
Date:   Thu, 10 Nov 2022 06:58:34 +0400
Message-Id: <20221110025834.1624394-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.37.3.671.ge2130fe6da78.dirty
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

The module_get_next_page() function return error pointers on error
instead of NULL.
Use IS_ERR() to check the return value to fix this.

Fixes: b1ae6dc41eaa ("module: add in-kernel support for decompressing")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 kernel/module/decompress.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index c033572d83f0..720e719253cd 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -114,8 +114,8 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 	do {
 		struct page *page = module_get_next_page(info);
 
-		if (!page) {
-			retval = -ENOMEM;
+		if (IS_ERR(page)) {
+			retval = PTR_ERR(page);
 			goto out_inflate_end;
 		}
 
@@ -173,8 +173,8 @@ static ssize_t module_xz_decompress(struct load_info *info,
 	do {
 		struct page *page = module_get_next_page(info);
 
-		if (!page) {
-			retval = -ENOMEM;
+		if (IS_ERR(page)) {
+			retval = PTR_ERR(page);
 			goto out;
 		}
 
-- 
2.37.3.671.ge2130fe6da78.dirty

