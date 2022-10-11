Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531045FA943
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 02:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiJKAXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 20:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJKAXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 20:23:12 -0400
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Oct 2022 17:23:09 PDT
Received: from mail.yuka.dev (mail.yuka.dev [IPv6:2a0f:4ac0:0:1::ec3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D800E7FFA6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:23:09 -0700 (PDT)
Message-ID: <9b7e4894-deec-39ba-bb7c-3c6d6427fa1d@yuka.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yuka.dev; s=mail;
        t=1665447465; bh=ZEXWibNk0G+0njFhoJ+ESklUwZYerAFgwVyY2eFpiks=;
        h=Date:From:Subject:To:Cc;
        b=upu52iPC5a+qk/xHIMVsMQKXit+TDMIKjgAoldduOzz8futJdBDS8o18xy5WpWHSu
         uTeetSPPCUPaP9vZFm30vjK15xIhOmhzZk4TmH4k8f1AjyQaJOOssmsMLnfr9dvsLp
         BF+DzcdNlD0p3D9Ua8Qlkvx+62256FzHWFdxMB5Y=
Date:   Tue, 11 Oct 2022 02:17:43 +0200
MIME-Version: 1.0
From:   Yureka <yuka@yuka.dev>
Subject: [PATCH] speakup: remove usage of non-standard u_char
To:     samuel.thibault@ens-lyon.org
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com,
        chris@the-brannons.com, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yureka Lilian <yuka@yuka.dev>

This code is included in the build tools makemapdata and genmap, and it
expects that libc exposes a definition of u_char. But u_char is not
defined in either C or POSIX standards, and some systems don't have it.
Namely this breaks the build on hosts using musl libc, because musl only
exposes u_char if _GNU_SOURCE is defined.

Signed-off-by: Yureka Lilian <yuka@yuka.dev>
---
 drivers/accessibility/speakup/utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/utils.h b/drivers/accessibility/speakup/utils.h
index 4bf2ee8ac..4ce9a12f7 100644
--- a/drivers/accessibility/speakup/utils.h
+++ b/drivers/accessibility/speakup/utils.h
@@ -54,7 +54,7 @@ static inline int oops(const char *msg, const char *info)
 
 static inline struct st_key *hash_name(char *name)
 {
-   u_char *pn = (u_char *)name;
+   unsigned char *pn = (unsigned char *)name;
    int hash = 0;
 
    while (*pn) {
-- 
2.37.3
