Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE7E73CBDB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 18:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjFXQSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 12:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFXQSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 12:18:22 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839621BC1;
        Sat, 24 Jun 2023 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1687623491;
        bh=t9PX+gmI/UcKkpcbDt6R77sgA+FoIjM4NOaJUDP49iw=;
        h=From:To:Cc:Subject:Date;
        b=LlU9ooFauSX2TF5vuDT7+eRYQ+SFZ7Sg6xnkipyLIJR25pp/9F/p2FX1lXQ5J3faW
         ZrUe9yTBVke4sMU4k+cmTkiF0PxNiBhQIUhR89q/j3b8AYxIx41j/hkffO5s0TrAlK
         idqI7hvQ5tjD2zFFlzaw20j89tbUUa9ADG7Ut0dQ=
Received: from localhost.localdomain ([220.243.191.12])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 4369B8A1; Sun, 25 Jun 2023 00:16:54 +0800
X-QQ-mid: xmsmtpt1687623414t8wdy9pz9
Message-ID: <tencent_72AB00ACD94346E10E954A42FBC6A3567E05@qq.com>
X-QQ-XMAILINFO: NRsgaNGnQ1mYXSLvJsE20/BEtApm6wd+h+4qUWSseRo64YtLfRF/SEx46U+keq
         FPzj9eNWVCNEJMblY/Bpjz4MPrAE2G4RLGZ4IaWAHbkjBxeJNST5FZobvO6OM9vUEAYqOw+r43Nm
         tmOUCQE3Tt7Cp1nsf1+jmjBo9hKOnBTkAmgWax7COrfEh6QVSjLfjdoxEtCiOsjZVWv82ItIwPgP
         LaXfZaVSXkAwabzm5TVHAccuDYcRpgPfvJRzS8jroXgfq5KD9w7kXuWBE4cK9qNIropRTRzbYSah
         e0yMBKyOoCTT/eEVmLn+ykmfnfAC7fcQbQXLhFNH3ejutAWClDD97IqB6clvSrVmk1xCCd97hASv
         zKJzEedCqRapGz6BztSOMHBd95Pum4sRd+tLmm0s5rx7hnGDuhmTDsRLfQ8DilvR/ND0eSB7fG0J
         D43g+cX27fnjkq+g49hx1Lp+zPoEGC/T0OSq6cp3dJJFOoAEDoD+N/iIWfEopvhyQaCZU2bJex+7
         yWfJXi3CYV8nWjEYCtskocqzdfYqwjlP+/u4sfKCxjiG55rHbhzjynCKkmbdx5ongNLip9gkJNlb
         olcV28uAzuKXojZwTB1Qan6ooGGu2gaYfYzMGar+lD+80nX6Bo+57zt4m52Z5WwIlV3oIwOo9ob6
         Hxl/jr8ke/0//xJSQFQ9xG/JAxQDD8Div6uChBqg3j2txBmx2E08ycmsdfmlqLicATFho6pem5jx
         k5MMOMP4r/asT+J4VAumR6X47GDJLfZY2IXUXt2vfkRp6ecwCO8gHyHUmWRDynsjzUsGoPASgl5S
         bZegNrtzRjCwJog3+NZmzMeZWwyNMQqZcQazTQhl/Ejhv7hbnSgkTMAfSmRhNf9nN61llPdZOnJO
         /UCQMS6J6TKkqwUPKWeeXAJvDr+VaiJW304XEsj3TEJlXqGt9/jNJc38CQE7Ps4xltmEo3wc6XJG
         f9jkrE+j0m0v+LYcwpdqUtz1INWY4DJ0AdEgjseO5ty5689MC2FfkJ9bNE8BJs
X-QQ-XMRINFO: N9UmAew/oWQdyj+ues2o31rfXVIHRUyJrg==
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     daniel@ffwll.ch
Cc:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] video: fbdev: fix potential OOB read in fast_imageblit()
Date:   Sun, 25 Jun 2023 00:16:49 +0800
X-OQ-MSGID: <20230624161649.13823-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential OOB read at fast_imageblit, for
"colortab[(*src >> 4)]" can become a negative value due to
"const char *s = image->data, *src".
This change makes sure the index for colortab always positive
or zero.

Similar commit:
https://patchwork.kernel.org/patch/11746067

Potential bug report:
https://groups.google.com/g/syzkaller-bugs/c/9ubBXKeKXf4/m/k-QXy4UgAAAJ

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/video/fbdev/core/sysimgblt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/sysimgblt.c b/drivers/video/fbdev/core/sysimgblt.c
index 335e92b813fc..665ef7a0a249 100644
--- a/drivers/video/fbdev/core/sysimgblt.c
+++ b/drivers/video/fbdev/core/sysimgblt.c
@@ -189,7 +189,7 @@ static void fast_imageblit(const struct fb_image *image, struct fb_info *p,
 	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
 	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
 	u32 bit_mask, eorx, shift;
-	const char *s = image->data, *src;
+	const u8 *s = image->data, *src;
 	u32 *dst;
 	const u32 *tab;
 	size_t tablen;
-- 
2.41.0

