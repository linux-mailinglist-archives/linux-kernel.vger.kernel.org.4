Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76A6623A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiKJDIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKJDIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:08:01 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC5B27DDF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 19:08:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b11so586341pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 19:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6OU4ENNozkhINhc2+IJdoCoJp+Y8ceNlE8roxKPBjE=;
        b=oaJmLTjfJVaa50Gd8bDUYhN/nxHUbBZEnP+s0IbUrmsk5dtTaf/iqkrlaswYcgxT/l
         /Ssntrn5Fqaaj1VCXld7535lk2/u7QmvZPTBGHljv/7Nj96/3Qa8p+T4Ta9cX5gOZX+v
         1nj3qCWZE4K+fhQ3z1pAd2QJfJtx3kc54c7wnzQpQOOa1X7QnUnrZUvtIulF9RvGWIDz
         wy7EVVA0A9GUcWoiwptyhBcT2xQJ6vLWh1GY3MXfhjHKySMpXNvH9W1C0XdNIjFff4fC
         Es5/daXC9Ysst7KAWH+b0HLY86EBUeUtYQGxLmyUlsQAyyYALoTwSe+zWYCWsYgk6ngq
         Nspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6OU4ENNozkhINhc2+IJdoCoJp+Y8ceNlE8roxKPBjE=;
        b=Y2XQjmR44gBrEOGFNhmxbN4nM3vh9iJ9tJaTzEWUagNNmxjACFMjoeEXvP2I0pZ6K7
         GlHj83LDB3lyYeO6RoYLzJ7P99DPUh3Y9yVw+iJdIdxJDPzGmxkImR2YwljVLgjn/fvG
         0AAJToROeBjjPz8p0oMaCfWhKshc+bwUTJOgL4hmPp51WSQI5xvxDWdD5KTE4UhS/xBh
         5gHdGFTtCHrnpsLsULLl9u184cPXSa6tSITGOxeG74DIYofO2RwYIi6R8XttCyPSYnX9
         vy19dnHqj/wGoTXtmva3spv+/s+a+ZpyTbT4eBr6oP+VcuSne1JZ3jPOvuCbzuUfWUJ7
         +/+Q==
X-Gm-Message-State: ACrzQf0O74wT/l0IaYq0NkcQXTrEizZepfYhq/HlpsqH6KO7frzxx+4t
        +Iv0FTjSBXMD9sFoxgYIbMI=
X-Google-Smtp-Source: AMsMyM6Y9a6DvS8fqDSmM0Y81Av5H17sZdN/qLSkdiZaSUmkyLKxGeU3UvQ1KzlfoOqpZI4qVj/bNQ==
X-Received: by 2002:a17:902:c405:b0:187:76e:2891 with SMTP id k5-20020a170902c40500b00187076e2891mr57723416plk.25.1668049680817;
        Wed, 09 Nov 2022 19:08:00 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id kx4-20020a17090b228400b002008d0e5cb5sm1906221pjb.47.2022.11.09.19.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 19:08:00 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Wei Xu <weixugc@google.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] mm/demotion: Fix NULL vs IS_ERR checking in memory_tier_init
Date:   Thu, 10 Nov 2022 07:07:51 +0400
Message-Id: <20221110030751.1627266-1-linmq006@gmail.com>
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

The alloc_memory_type() function return error pointers on error
instead of NULL.
Use IS_ERR() to check the return value to fix this.

Fixes: 7b88bda3761b ("mm/demotion/dax/kmem: set node's abstract distance to MEMTIER_DEFAULT_DAX_ADISTANCE")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 mm/memory-tiers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index fa8c9d07f9ce..ac0dae9e54bf 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -645,7 +645,7 @@ static int __init memory_tier_init(void)
 	 * than default DRAM tier.
 	 */
 	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
-	if (!default_dram_type)
+	if (IS_ERR(default_dram_type))
 		panic("%s() failed to allocate default DRAM tier\n", __func__);
 
 	/*
-- 
2.37.3.671.ge2130fe6da78.dirty

