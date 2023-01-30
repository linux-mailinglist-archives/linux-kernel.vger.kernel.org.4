Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C0E6804F8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjA3E0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbjA3EZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:25:57 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B98234F9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:25:50 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z1so3842581pfg.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+2uSEts9I7Ewx+xS7afTWjlA6S/QLMMkQDB6ml0kj0=;
        b=hKdHkX186An3SlPIdCV6Z762EQ3Mp+tUKDZoyrcHW4XH0L3AXgSWzAsinGVxCJr3iL
         o7ET8OmEff0FDqiWcyWz2HksAKY0eqrS2JhdnHs4xoHvbxotnBAsJDlH4cFwn9sZ5uPJ
         Mx6zVjix4c6pHAUF30Zhvibm1eolctdmqCeeqMYN/dqDEtywpaIczX7OifZ3R+jRG6hd
         CFeZohdbVbwh5Ahc31iEbp95nM8NbxoCnAIVR6icduxEirkVOZLncYjoVM7XKzfO6oEr
         b9KjhqYvZnMA66sE9SRqYxYTOhNRiff2Vh/hylLUBahbTvtYNv9HOoVtpVuwM8uNWJT2
         rbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+2uSEts9I7Ewx+xS7afTWjlA6S/QLMMkQDB6ml0kj0=;
        b=TPmWPt7n+YQ7P0P+PdTLAW1/pdoLe3LvGocSe/dD9mVWj9xIdyTPpLHeXG9Bb9GPAV
         8gScJGbRIHM4GwN1rYyNkG5STXqctDrB6Oa+rwBZJIudeitjkh3vBIgTOQMqudICMY1g
         ibfRFzkBt3vfYDuTCXTVwArTC4Cx1fxDBkElIUZ5FGU1Im4uO9ROw0TXeeLpCtka2X/D
         PxSdDXN5dTf3+GnnCMY2XI31s1xv1383VUKjl0VvKLQG5IYfpJPhpiivjpChZFFQsd/F
         Q17flcnThgE1AafhfMIz9ENm5PUe+itxZXZmUg9mxdThyUyW/daJPcC81x7rJ5cGRCQg
         qwHQ==
X-Gm-Message-State: AFqh2koXsOCAE78Y5Wn0WiTOVoIFcvqstjyHj+U0uMLgHcs6z1qJ8rTY
        zqkYoonqSTAdmu/U24/0Ka8=
X-Google-Smtp-Source: AMrXdXt/vTOJEaTIid9fdett6eIQmY9527OXjpDlZK3RUh7rX89GJQs62AZMfIi62ZnaGn5d/ZYSpQ==
X-Received: by 2002:a05:6a00:3315:b0:582:294d:f465 with SMTP id cq21-20020a056a00331500b00582294df465mr49045478pfb.13.1675052749382;
        Sun, 29 Jan 2023 20:25:49 -0800 (PST)
Received: from localhost.localdomain ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id 138-20020a621790000000b0059312530b54sm4275969pfx.180.2023.01.29.20.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:25:48 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable v4 3/3] mm/debug: use %pGt to display page_type in dump_page()
Date:   Mon, 30 Jan 2023 13:25:14 +0900
Message-Id: <20230130042514.2418-4-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130042514.2418-1-42.hyeyoo@gmail.com>
References: <20230130042514.2418-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some page flags are stored in page_type rather than ->flags field.
Use newly introduced page type %pGt in dump_page().

Below are some examples:

page:00000000da7184dd refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x101cb3
flags: 0x2ffff0000000000(node=0|zone=2|lastcpupid=0xffff)
page_type: 0xffffffff()
raw: 02ffff0000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: newly allocated page

page:00000000da7184dd refcount:0 mapcount:-128 mapping:0000000000000000 index:0x0 pfn:0x101cb3
flags: 0x2ffff0000000000(node=0|zone=2|lastcpupid=0xffff)
page_type: 0xffffff7f(buddy)
raw: 02ffff0000000000 ffff88813fff8e80 ffff88813fff8e80 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffff7f 0000000000000000
page dumped because: freed page

page:0000000042202316 refcount:3 mapcount:2 mapping:0000000000000000 index:0x7f634722a pfn:0x11994e
memcg:ffff888100135000
anon flags: 0x2ffff0000080024(uptodate|active|swapbacked|node=0|zone=2|lastcpupid=0xffff)
page_type: 0x1()
raw: 02ffff0000080024 0000000000000000 dead000000000122 ffff8881193398f1
raw: 00000007f634722a 0000000000000000 0000000300000001 ffff888100135000
page dumped because: user-mapped page

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/debug.c b/mm/debug.c
index 01cf0435723b..c7b228097bd9 100644
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
2.39.1

