Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1590870F090
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbjEXIYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbjEXIYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:24:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C49132
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:24:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so40025255e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684916668; x=1687508668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7S8YiFtaRj/FEKOy7ugtwuuXH8gMTMGNxbGTnZXrWWI=;
        b=B5xRig/b/0O5ZspeIVwHcd2M9muwN88/QZRDW59sLhCQYsBHlIcilk7vC/3SmMOjRU
         mI1attXluGofNHO3o6zqrKvE3BmGB5S/5zYDmbiuXBaCaXImX0+to+5MTi4kqnVcc9QD
         3aqeFqty+0UtS3XO637GAT+m3befp2T36c7i4PTWoxC+JIku2s1alA6g0csYQL1upeGT
         G9xOnmWDmyDhOTsPZ3JwulfFUvpfaWlNuJbAIoa8XZpcUxS1owE5hKXG5wPfWi6XO7jE
         9DeVb2J43woXjJH4G8/ZCAcbl8x89gq4Iuvvka8TWcU6RAuIkdwOYhY8iEQTUFUj9KxJ
         6v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684916668; x=1687508668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7S8YiFtaRj/FEKOy7ugtwuuXH8gMTMGNxbGTnZXrWWI=;
        b=ZJRdFgsebBDe/m9UXsXxX63oUQwYqQDbtsfa13J65IyUDkzlPsGe72dR13NlAUvry6
         uTRR+9sAWjINXmq3xGJ+eIMftiIuRCawEw8j6LLHd28+mf6wDA1JMf8M48Q0311U6V+H
         A73I7/J6KrSVEeCndlaeu+QRRNVqxRnxoGFkDbdOWt2WAg8YzPNtWS2vn1FM15u2qe+x
         Xair1gS4TcVg0IupyNRczqwTRnA+DrRkexaUrFz+oC0rTIXwarjOQhQ6zBeKsac3+Art
         3UxgoyBiVq79AIfd6IseQmf1bywetfSGqq1lcRxxmFoqFojm/eUdtfFtd0wHzRG6NXOq
         FARw==
X-Gm-Message-State: AC+VfDzTLtBw1gds6Rya+PQP9DtiaRTlNbIUWk4Ty6UygOaY0wgVaGHC
        JYsUY94VVNVfZ5csToMS7B4=
X-Google-Smtp-Source: ACHHUZ5ZmbHPHGD6ALC2KbVxj8uSXpU83tkbIWRAvSFK1QMXXPAx3969ZTiAxeTn9+lcd3dwirOrlw==
X-Received: by 2002:a7b:c385:0:b0:3f6:8ba:6ea2 with SMTP id s5-20020a7bc385000000b003f608ba6ea2mr4775407wmj.15.1684916667799;
        Wed, 24 May 2023 01:24:27 -0700 (PDT)
Received: from lucifer.home (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.googlemail.com with ESMTPSA id s4-20020a5d4244000000b00307bc4e39e5sm13467258wrr.117.2023.05.24.01.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 01:24:26 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] lib/test_vmalloc.c: avoid garbage in page array
Date:   Wed, 24 May 2023 09:24:24 +0100
Message-Id: <20230524082424.10022-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that alloc_pages_bulk_array() does not treat the page_array
parameter as an output parameter, but rather reads the array and skips any
entries that have already been allocated.

This is somewhat unexpected and breaks this test, as we allocate the pages
array uninitialised on the assumption it will be overwritten.

As a result, the test was referencing uninitialised data and causing the
PFN to not be valid and thus a WARN_ON() followed by a null pointer deref
and panic.

In addition, this is an array of pointers not of struct page objects, so we
need only allocate an array with elements of pointer size.

We solve both problems by simply using kcalloc() and referencing
sizeof(struct page *) rather than sizeof(struct page).

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 lib/test_vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 9dd9745d365f..3718d9886407 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -369,7 +369,7 @@ vm_map_ram_test(void)
 	int i;
 
 	map_nr_pages = nr_pages > 0 ? nr_pages:1;
-	pages = kmalloc(map_nr_pages * sizeof(struct page), GFP_KERNEL);
+	pages = kcalloc(map_nr_pages, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		return -1;
 
-- 
2.40.1

