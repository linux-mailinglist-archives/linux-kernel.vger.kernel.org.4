Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB4074D200
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjGJJlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjGJJkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:40:05 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D6DB7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:38:10 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b7541d885cso3303361a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1688981890; x=1691573890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ajnJvW3EoQVJM0A0noZ1rC2u8boZf4rH9jk39u5cacQ=;
        b=gw73FRuZrFPnkV5NTcmHiATnoKGdlzBbk7Zha3RsDNwHj1pXcT7rz3tSc1f4hJwzJU
         ZjtxAGIihXOLHxbL/Uehbm9jhqvqJbEL8EqcmyI3Vir7NACkhcGy8YyQK1fANGfNI8CK
         OP0tLpTYfL8RIAztdrIBBst02TVn8QF/cvOzBE8KKFTobjUU/XwcbYuSUwLLNFE4Jvf3
         1DQ3l4bHad7clIktBN8GpVZLbX9wWeLHL1P5tglldY06oBIcnYxao5hQsIybyhucUlcY
         252LqvYSm5IKrUGcIc/JFjzD2QQ3wse4XpjsOoFYYSlqA0P45VShI3YYGdoEa0MBBAqV
         s/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981890; x=1691573890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajnJvW3EoQVJM0A0noZ1rC2u8boZf4rH9jk39u5cacQ=;
        b=Egg3CmA6/8fzrbr5nn8rz+DOp9LBO32Bdvz6zOAeYn3gnXqQ30uQWsUxcd6cjaaUrM
         bWC7s4qL1rqtj/D+IziAbXz0wU9z5JIiyr6jWGvCTN8XjFVXmB1i6eMCTLiAWeiXlMDr
         PUTnh4ZkYNYtZc7XFJ7+KS/wuB/7eYihBPVmerk2WrXbL9PuYC6cUFSvzB4z1lt1yFr9
         MT/8mlBpCMq9tUo7TTmPFQRQ60wudF0ryGl9/dGLuAVKC7QUz/R2VhtVvQx62hy2gnJT
         jOizJLJX/4niCm7deqx/DBB8S9n8l2FQeghppiOFlOYlILudAX3ChIawpvLMvnlZxKjl
         D5gA==
X-Gm-Message-State: ABy/qLbLaoVzGijDO1IiMBZvnJBMbVn/VTH6i6fxa2qLZQ5f+AcnlyXs
        o2bFsAFtSOSgjJQUMKGDSrJUkTYa7+NaJdwMKS6mHA==
X-Google-Smtp-Source: APBJJlFeI5XDX0P4b55BqbdbW60MiTpiZFi6tmEd+sPge9ZvH4xhIrTPEag4qJO0cBuMkhwjZQWJ+g==
X-Received: by 2002:a05:6830:22f6:b0:6b7:4e25:4c08 with SMTP id t22-20020a05683022f600b006b74e254c08mr10815570otc.12.1688981889863;
        Mon, 10 Jul 2023 02:38:09 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id w18-20020a639352000000b0055c430c311asm2089032pgm.33.2023.07.10.02.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:38:09 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] mm/mm_init.c: mark check_for_memory() as __init
Date:   Mon, 10 Jul 2023 09:37:50 +0000
Message-Id: <20230710093750.1294-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of check_for_memory() is free_area_init(), which
is annotated with __init, so it should be safe to also mark the
former as __init.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/mm_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index a1963c3322af..a313d1828a6c 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1737,7 +1737,7 @@ static void __init free_area_init_node(int nid)
 }
 
 /* Any regular or high memory on that node ? */
-static void check_for_memory(pg_data_t *pgdat)
+static void __init check_for_memory(pg_data_t *pgdat)
 {
 	enum zone_type zone_type;
 
-- 
2.25.1

