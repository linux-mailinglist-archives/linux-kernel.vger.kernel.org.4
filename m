Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C751B63CE25
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiK3D6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiK3D6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:58:31 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7C06B384
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:58:28 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-348608c1cd3so144869137b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uianWyO94cQpF/P6HGzSV03i6PkpsS/S96Y6uBo/3Ds=;
        b=E8mhl3MsUu8J7sEV9cjA5n8kjdZMdvqNIv8yFsHsA6PeKqXy5VCYYgmw89HSnDDLa/
         Bem4EzOGEkFQmAo/7/tXsCa1QaQeFap30WRLI2JrzeD7ZAVamY4WY/qrFIVlDWJPP2GX
         0r+MTtAS3JhwEWrwAmYq0Qw9ve+og1OpfxlpyeLj/xFv18SGeWkoivPzSFqRoRc8X0y0
         3ZyN5XXXrUnedET8Uj016XcYNAHfFEI/HmtjuKQf5s0ABZUqdH1TS4PFqDxnbFAQEXOl
         tP5GY0K71O+vWgI8dBg0DH4FlZ4lbJetRzKwh3bhb1NdgequVj+4OYokPYhR9O0iOj9l
         r+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uianWyO94cQpF/P6HGzSV03i6PkpsS/S96Y6uBo/3Ds=;
        b=7eHdkyjVqY0CZWyWeeoxLBpj6cUrLeTXlfcbF/1VoCvbm/ENja3ia7QeU77E7aN8CG
         hbVAH0zrNccoAPsEwyalxaVVzoQwzL6zC2looXHnvbI67f3CeJUQ3rvyJ3ZZ38mc6LsM
         A0sBowtUOcFzcUWQkKjvn9GaTK97W6IvXFdw0ClymVe2hsf2jX+eJgLyrMh0SKDFzsWO
         RQaYNjsjMhSp0YidWqV8mDEjm/8Gd4eTcAsfZ2YO4lFk2k3zcAu2y0DyFcr9fpT+E3HQ
         nrCouMBFKRG4/1emIIhU+ZJEO1TNfhJnGc/5LQF20hZxUJ4k6l1IJkrbKcThdKIggUTD
         iJBQ==
X-Gm-Message-State: ANoB5pkn3oMlt5rgner8KI1FlgK/jZf8jT9dEX5JY3yF6p/fIi3UCnJG
        4gFhWQQ7/MojeWClhHeMYIYGK01DELk/bQ==
X-Google-Smtp-Source: AA0mqf4w5pglV1vHvNzYl4KLvK1hn1UvzZu5PRErTMNPxsAeSqOpbhJYWmb+p+kn3nFS/EFIlONMWnu63PsjYQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:e758:0:b0:6f7:b717:d64d with SMTP id
 e85-20020a25e758000000b006f7b717d64dmr10263671ybh.236.1669780707969; Tue, 29
 Nov 2022 19:58:27 -0800 (PST)
Date:   Wed, 30 Nov 2022 03:58:03 +0000
In-Reply-To: <20221130035805.1823970-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20221130035805.1823970-1-cmllamas@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130035805.1823970-5-cmllamas@google.com>
Subject: [PATCH 5.10 4/6] binder: fix pointer cast warning
From:   Carlos Llamas <cmllamas@google.com>
To:     stable@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Arnd Bergmann <arnd@arndb.de>, Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 9a0a930fe2535a76ad70d3f43caeccf0d86a3009 upstream.

binder_uintptr_t is not the same as uintptr_t, so converting it into a
pointer requires a second cast:

drivers/android/binder.c: In function 'binder_translate_fd_array':
drivers/android/binder.c:2511:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
 2511 |         sender_ufda_base = (void __user *)sender_uparent->buffer + fda->parent_offset;
      |                            ^

Fixes: 656e01f3ab54 ("binder: read pre-translated fds from sender buffer")
Acked-by: Todd Kjos <tkjos@google.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20211207122448.1185769-1-arnd@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 83c4501153b4..398ce65b578b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2908,7 +2908,8 @@ static int binder_translate_fd_array(struct list_head *pf_head,
 	 */
 	fda_offset = (parent->buffer - (uintptr_t)t->buffer->user_data) +
 		fda->parent_offset;
-	sender_ufda_base = (void __user *)sender_uparent->buffer + fda->parent_offset;
+	sender_ufda_base = (void __user *)(uintptr_t)sender_uparent->buffer +
+				fda->parent_offset;
 
 	if (!IS_ALIGNED((unsigned long)fda_offset, sizeof(u32)) ||
 	    !IS_ALIGNED((unsigned long)sender_ufda_base, sizeof(u32))) {
-- 
2.38.1.584.g0f3c55d4c2-goog

