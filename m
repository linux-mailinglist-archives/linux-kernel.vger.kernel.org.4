Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5493560BE10
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJXXA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiJXXAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:00:20 -0400
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9262D7814
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:22:36 -0700 (PDT)
Received: by mail-lj1-x249.google.com with SMTP id e9-20020a2ea549000000b0026fd9ba87acso4523196ljn.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G4yBv7Ojnp7UF/vJeQGCUBcD6F1oQa7UXx9ZrIQaMAU=;
        b=aSgkiacZ+5LH66/OSoz3MSDqz3zMIfvjCb/vyfftyLM0xQDT8v/cV4qgWN9uIWbM2D
         5OZHLV9CdDaSYabYM5oDhFl/9ZFZxBB7UVaE+TCMSdHJ4OzpgUiYTbbaREJDJ5M7BdKw
         7Yp611r8+sMWV+GwAvNDb5hW2BH9LuS76Frg8V4l+RxJ4pp10FD3oo1s5NeIbhGUhz0w
         0i1mgmg0nYSCbbb5eW6qpKn9lWSlUKvjLWMU81zY+MVDWxf5KApWMkH3yS1m1A1Ci/5R
         956P5mfY7HvBAFj+8gGanEIbLdPqM2iOq+oUYtxU3AimbVdcembaQ3RioMtPFtX9O6iC
         4i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4yBv7Ojnp7UF/vJeQGCUBcD6F1oQa7UXx9ZrIQaMAU=;
        b=trZdlrhrSvzQHvlSJAcvPL8nIE708iKGjGX3qHy8aDxzTVrhD6mT59RDGOL7AGZge5
         VBiU31z/YxZzLAm5o9qnqOmXxP6C2tZ617Kr3c7wbNNeozOxDtvVbtMP+S8EE7G9Uk8W
         BNBlgZ9MraU3fsIHOF441ObJTyJcECA1a1HGZtZG8z57PJaoTGZCcz/nZ70Ptadn9qHY
         UHJRBfF+urvV/bNfs0l1UOPNMoCNSwbUdsq1nxJx+swFBxYkb+HNbUFQzkfnK+AIrzZ/
         HXLvzN9krxWnFjvED6b7gPfIu+f8eEGBAf+62C5FgJDG3Pfb2faBf3zixV+FrDBLcNCq
         rvlA==
X-Gm-Message-State: ACrzQf3K8Ogkw0AH0zIbXCdFKNF7Ll7GOChrt5WeMd4z/1rBn9eu4C1O
        qXZK4I92pCitFN3j+vNZRojB/M5GCcc=
X-Google-Smtp-Source: AMsMyM48tMgyNJTcQaeP49oPDEv9IHgkDLnPXKM/jKBNnXEO6qCwgCXK+Fopa0pPG4zOuEJQI1VErzmH0jI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:8695:7c88:66ed:f9d1])
 (user=glider job=sendgmr) by 2002:a05:6512:104c:b0:4a2:6b99:c8f3 with SMTP id
 c12-20020a056512104c00b004a26b99c8f3mr13590896lfb.519.1666646508884; Mon, 24
 Oct 2022 14:21:48 -0700 (PDT)
Date:   Mon, 24 Oct 2022 23:21:40 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221024212144.2852069-1-glider@google.com>
Subject: [PATCH 1/5] mm: kmsan: export kmsan_copy_page_meta()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
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

Certain modules call copy_user_highpage(), which calls
kmsan_copy_page_meta() under KMSAN, so we need to export the latter.

Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: b073d7f8aee4 ("mm: kmsan: maintain KMSAN metadata for page operations")
Link: https://github.com/google/kmsan/issues/89
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmsan/shadow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 21e3e196ec3cf..a787c04e9583c 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -167,6 +167,7 @@ void kmsan_copy_page_meta(struct page *dst, struct page *src)
 	__memcpy(origin_ptr_for(dst), origin_ptr_for(src), PAGE_SIZE);
 	kmsan_leave_runtime();
 }
+EXPORT_SYMBOL(kmsan_copy_page_meta);
 
 void kmsan_alloc_page(struct page *page, unsigned int order, gfp_t flags)
 {
-- 
2.38.0.135.g90850a2211-goog

