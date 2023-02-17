Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C0269ABDC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBQMvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBQMvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:51:13 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E437011E9B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:51:11 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o3so1521819lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jgNqnsBkYaCl5xkY3KlgmTZm82cO+lOw99V4TeAbx8s=;
        b=VBbJd3E2ahAuXoQ9gq2Evs4X9KEgqjGa4Tg5BkFu4z4jBSrk/PVVxjvR4dZbujdofX
         YS5LZ6jXtenSdl63536STE/eRY4ZcTZYN15BG6apVceJJE6ccdNfsIwwsKMln2LpzYo0
         eWZm1DWVTwx8B8YV4IDspQcY4RsAgauDE2IzlruIXBPEUqHyXPJ170g7DaC3M1OZsr7u
         3ytd2ubOA4wXKi8dwRvmRn0hnGqs5GyQTOayR6KXGpBQNlDYvb598wy/qGWLtnGiqrmF
         Xao3BKYqV6rUO/3lQjMTD6ZbIPQ8ROtRor2QaUaJG32k98uY7kOiUJICTkoh2umfFX5s
         lHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgNqnsBkYaCl5xkY3KlgmTZm82cO+lOw99V4TeAbx8s=;
        b=g8lNGMg5utac5sVV1PUYA2KNKO1/QDbQOq2ds+Cnk1ogLLMcB5YjIbi2KFPqvS0gn8
         PPmAXLtrNpbI4IzL7joICHe+svoxU0ZS/dFcR49AV690ZT4TrnAf5a/eIAunW6gSp+RG
         vqEyOP6g+obbOW42DaQUQhUU8ZAV8XKYodczz4+F0ZWKdiK0lc5sAG8jM7wa4y8Oqdka
         Y6Qu3GC7cSPjJus+tXXVxwpXBG57CS0y6VkCT0lAdYsCiXMQyrGn+4NCoJyujjQ+WHiv
         wVd8i7ROPvDlvtW57UBnRMxStlGiB9WyiBWI/wevmQJxLU5U7HECNu+peqtuLK0E0mIN
         ri6Q==
X-Gm-Message-State: AO0yUKVw90vpmZGBIZwRMsIpn4vByeWUZNJtk5u8CTMoFzbr37ybsfk4
        Z/ed8REMNCH/WPvISjZEMaE=
X-Google-Smtp-Source: AK7set/1BG58dEEH7rx4ZHr9S10NWckBjtDSjNDcX+jBE02MDMlxlumkQDceZsPwi7VpNoJroONmwA==
X-Received: by 2002:ac2:5972:0:b0:4d8:6540:a72f with SMTP id h18-20020ac25972000000b004d86540a72fmr369208lfp.46.1676638269937;
        Fri, 17 Feb 2023 04:51:09 -0800 (PST)
Received: from alsp.securitycode.ru ([2a02:2168:8bff:fb00:c81a:1ac1:84a6:458f])
        by smtp.googlemail.com with ESMTPSA id v24-20020a197418000000b004db250355b3sm673997lfe.138.2023.02.17.04.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 04:51:09 -0800 (PST)
From:   Alexander Sapozhnikov <alsp705@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Sapozhnikov <alsp705@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] mm/vmalloc: fix unsafe dereference of potential null ptr in vmalloc_init()
Date:   Fri, 17 Feb 2023 15:51:05 +0300
Message-Id: <20230217125105.12385-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Return value of a function 'kmem_cache_create' is dereferenced 
at vmalloc.c:2444 without checking for null, but it is usually 
checked for this function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com>
---
 mm/vmalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ca71de7c9d77..ed75dfd44b85 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2426,6 +2426,8 @@ void __init vmalloc_init(void)
 	 * Create the cache for vmap_area objects.
 	 */
 	vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);
+	if (!vmap_area_cachep)
+		return;
 
 	for_each_possible_cpu(i) {
 		struct vmap_block_queue *vbq;
-- 
2.34.1

