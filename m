Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B319164FE69
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 11:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiLRKUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 05:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiLRKUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 05:20:00 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2531DF4A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 02:19:44 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so10268171pjs.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 02:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USiySWTOh1CETJ0YaQTua6YhrtEN1JVTOEmqLQEb+nc=;
        b=bWK2HUZitrMe3mACDaUw2c6Wef/saP741RD5s+0F3g7SGx1ocQQGgA3KQo+0LBvYS/
         1AdRIdFNalVr6Szi/z72zeefH3ICn+Qd2dC6Egi/6wkaWWyA+Y8tlGU6Vs47aChPbtx9
         O2bhTef3xY1/9W+oenTVALT0gBi6whnKo7eS8DdlerbX94y/feD283qBLf3rKcBD0RWJ
         Ly8Jz4yocDAlnLz43nG6gfP+R/veNmiX/jkOnAAJSZTii0CEIZwWBfSX3IBcpw3Fh4dY
         0ZpF7xElp98dXVYTyhT5eI8lcFhxdm5C6i+8dRC08sLo9plyGPmZI4uv++OYORdWD2hu
         8VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USiySWTOh1CETJ0YaQTua6YhrtEN1JVTOEmqLQEb+nc=;
        b=UzNEefuQclERKbqk1E6A/3EH01/op6iwjmNxIRGHV4EoAvzs6e2jCEEUknyWrtxFzL
         xzvo0rM5lIjerWd3rrOnf+gpNqHbgCc4WffLNe1rF66pVq6en6XcWXtko5tychLkbp4V
         Y4rnCKC0I4G1c7pvOgPvoVjcRTlxGLGbBXiRWfU7MsEaVnAeRkaNpfjXb+Yw+yzK75qo
         xA08BqCe+P5IyP8tqIHwfuacMzCyZU64XHRsahrS2mOyPY8NwEzxl+Q38RHuv5T9sTNo
         M7VV1lUj95ALHHZiXB3KgMZ+0rNBsBMNNNEacsweohJ59wEcVj8fhz8wTJU8j5DTo+S5
         pY9Q==
X-Gm-Message-State: AFqh2koE4nbzXKpkveooMCIqrM/Rr8GwBKzd7AWcfCz1zRbY9sy1tszl
        R7o4b00PpdLzf5lSh0LqAlo=
X-Google-Smtp-Source: AMrXdXvKE5/ZFpRCUmyw11BJzvZeV02MBGI0qTsOGM0h4S9hXXpZmBes+89J/16brPjl+7ootVUf/Q==
X-Received: by 2002:a17:902:d4c6:b0:191:a19:e768 with SMTP id o6-20020a170902d4c600b001910a19e768mr7877083plg.48.1671358784136;
        Sun, 18 Dec 2022 02:19:44 -0800 (PST)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001897bfc9800sm4789791plb.53.2022.12.18.02.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 02:19:43 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        =?UTF-8?q?HORIGUCHI=20NAOYA=28=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F=29?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v3 4/4] mm/debug: use %pGt to print page_type in dump_page()
Date:   Sun, 18 Dec 2022 19:19:01 +0900
Message-Id: <20221218101901.373450-5-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221218101901.373450-1-42.hyeyoo@gmail.com>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some page flags are stored in page_type rather than flags field.
Use newly introduced page type %pGt in dump_page().

Below are some examples:

page:00000000e47d45a7 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10175e
flags: 0x200000000000000(node=0|zone=2)
page_type: 0xffffffff()
raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: just after alloc_pages()

page:00000000e47d45a7 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10175e
flags: 0x200000000000000(node=0|zone=2)
page_type: 0xffefffff(slab)
raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffefffff 0000000000000000
page dumped because: page with PG_slab set

page:00000000e47d45a7 refcount:1 mapcount:2 mapping:0000000000000000 index:0x0 pfn:0x10175e
flags: 0x200000000000000(node=0|zone=2)
page_type: 0x1()
raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 0000000100000001 0000000000000000
page dumped because: page with _mapcount == 1

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/debug.c b/mm/debug.c
index 5ce6b359004a..d6a0eb0a9bb8 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -120,6 +120,8 @@ static void __dump_page(struct page *page)
 
 	pr_warn("%sflags: %pGp%s\n", type, &head->flags,
 		page_cma ? " CMA" : "");
+	pr_warn("page_type: %pGt\n", &head->page_type);
+
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
-- 
2.32.0

