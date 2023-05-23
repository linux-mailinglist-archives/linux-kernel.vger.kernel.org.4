Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C305070D10B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjEWCUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjEWCTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:19:48 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B029CA;
        Mon, 22 May 2023 19:19:47 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-332cc0efe88so2498565ab.0;
        Mon, 22 May 2023 19:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684808387; x=1687400387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kzTqOaIPWfW9eLUYmANhI0oqNLmXhJYkC7KiwdLC9Pk=;
        b=HSD7l7aKqkH7bpomTMkzPvcKzQpp2eYwyn0IteDdsQLQjpEWrRaSrLc67veKl7F0/T
         cn2iJlW2p3p+ttdzw9ZAV7HQ8xxxsTjGKeDqk9ze5VrKHVaDEi+t3OW7XqBuV/glXXnC
         D2eds/9o/cQ3eOaOppD0DjNpMbm7bViiVNn4xVcB+ZMtP9Pzx2mqEv3rSuUKAgMxU6nL
         gqqvNmyRkrNekvbh16k/UGWh5sknRUXgxI9DzPtYOgcYIE58tIKFTJbuDRwL5PBaJyQ5
         8aQnfvzVb1Tev33snfKB5whGHevkySQHAoZR2clKZs9dZU5d0XWHlZc0r5BlpjMUYgkj
         FfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684808387; x=1687400387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzTqOaIPWfW9eLUYmANhI0oqNLmXhJYkC7KiwdLC9Pk=;
        b=kq6wzNSJQ6z1OQfkS0x2XG8r8EX+Ae/nb8H3mpLXXCiLzp5L+5vviNji+Nuchj2y5T
         QuBaoyx2TLmb/i5ZXhqo7q924X45bkZ0zks2Ht/SMkdC2xZ2sQaQYw+bISNZbY6544L0
         zsuzhsZ7vZNvp1H+jFiWLcQ+/uKapEUN8utTIDz3YRgicHVFIu49EQwUTmb00j7rmguW
         wy1Fb8fwHsfuWMkaFYt9sv23mjlT8Q0/2QLWYXaPyiDcCZa1/BAsf/Sc3yjBH6WKX5V/
         yJzOl6YLNmwsncFlunT5opE01F2uUTkNLsP4lMtz/4tDQxf1tozWX8ODKIX1hbNopbyJ
         imGw==
X-Gm-Message-State: AC+VfDwXM8ZBZRtmokc2y6CygvOXZZA4nsDJ/9OMI9dT8c6YLw+9IpHQ
        WPJtiCiB1qLzT4A2pidif0Q=
X-Google-Smtp-Source: ACHHUZ4+DJLABRuPBSRDE1JxdVeIA6RNnSI8JrvW9bu3YuMmFMvYwh3HXeHrlA5FYY/ygXGrB/itLA==
X-Received: by 2002:a92:d8cf:0:b0:338:1a22:bf47 with SMTP id l15-20020a92d8cf000000b003381a22bf47mr7507410ilo.21.1684808386720;
        Mon, 22 May 2023 19:19:46 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id x1-20020a920601000000b0033549a5fb36sm2131699ilg.27.2023.05.22.19.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:19:46 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH] dma-buf/sw_sync: Replace all non-returning strlcpy with strscpy
Date:   Tue, 23 May 2023 02:19:43 +0000
Message-ID: <20230523021943.2406847-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
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
 drivers/dma-buf/sw_sync.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 348b3a9170fa..63f0aeb66db6 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -85,7 +85,7 @@ static struct sync_timeline *sync_timeline_create(const char *name)
 
 	kref_init(&obj->kref);
 	obj->context = dma_fence_context_alloc(1);
-	strlcpy(obj->name, name, sizeof(obj->name));
+	strscpy(obj->name, name, sizeof(obj->name));
 
 	obj->pt_tree = RB_ROOT;
 	INIT_LIST_HEAD(&obj->pt_list);

