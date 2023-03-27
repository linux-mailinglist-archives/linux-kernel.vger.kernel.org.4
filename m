Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E698A6CAB19
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjC0QxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjC0Qw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:52:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0FC30D0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:52:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w9so38944479edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679935951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psu4ofpncoCQSYgbBGuLj7J5oQ90Aa4oswGxv8KP4JU=;
        b=oqLO6H8UszXaMp/SFz19taH9BEbDwduqf6iMDkFtdJHaO195+2htbsYsmJLvDI6+HH
         R/m3LYGi5ke97tU6RqC52NkdYRk8mJp5an604LUc4TFpFboDPOrE3LKM99rHPd1OFw+6
         8I294X01903WfnqY8p/F+rpHHO4e1hCf+HwQb+TqnmbODIpB4Q/v6Lxhzixp0TobaIB/
         SUub76+dzYpeiwkECh3GSb9z340MsmyfbOYJ1V24AI4nH5id2fkFTj+0Hoqy2zXPQqXt
         kf3NnKUoYtq9j2nlDlWO9nV3i5q1wV+xwOLUPJo47WnYdpjaebcYrJdhMGgVUO2DKYp4
         mvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679935951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psu4ofpncoCQSYgbBGuLj7J5oQ90Aa4oswGxv8KP4JU=;
        b=NTsbS/c4dF5Y2LQntuEJrYlKXPg0WzzRuNW0qu/0ORPAP7dTbZE2/wC1rpMuZjztmg
         4MoHyh/EeR2R7a0qyf75ot3gohS/iTSBhIQkab1m84BiDKG6mnN+8I52eVjgVKZpv2MH
         jNXmVON/nMwzEFs2XXGQ/CLHk3FBofBJGiacQMMy7TNg31+LkWP6xwZCA9HbUhIIt/iN
         icTJGLE7HUiAxHgpOv6iFbLhcCwr8rHyXoFto6n2fwIRcikLhXSOvQ/J2b8JWbrBMbS2
         vPSmvoGpcnjppNo5zTlrDZ/2174606yCd1dL6/eTQR1IurnEY8L+ZSs09QGK+eYwwjv2
         KXxw==
X-Gm-Message-State: AAQBX9f+ScamlyLfSDPLHBN1LVZeAWnnb7mksdGe565lPars96FQ06vG
        fU/CTC8xk1tqp5/wUpyxn40=
X-Google-Smtp-Source: AKy350aqqGV4WSXqY4JijppBYLY54SH1M8lng+djwiThsPYVbd6JJK1pASBCkFqGbfRGWDgK7uthVw==
X-Received: by 2002:a17:906:5608:b0:8b1:78bc:7508 with SMTP id f8-20020a170906560800b008b178bc7508mr12515293ejq.20.1679935951241;
        Mon, 27 Mar 2023 09:52:31 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id b24-20020a170906491800b008e82cb55195sm14217282ejq.203.2023.03.27.09.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:52:31 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 2/2] lib/test_vmalloc.c: Add vm_map_ram()/vm_unmap_ram() test case
Date:   Mon, 27 Mar 2023 18:52:27 +0200
Message-Id: <20230327165228.405045-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230327165228.405045-1-urezki@gmail.com>
References: <20230327165228.405045-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vm_map_ram()/vm_unmap_ram() test case to our stress test-suite.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index cd2bdba6d3ed..6633eda4cd4d 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -53,6 +53,7 @@ __param(int, run_test_mask, INT_MAX,
 		"\t\tid: 128,  name: pcpu_alloc_test\n"
 		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
 		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
+		"\t\tid: 1024, name: vm_map_ram_test\n"
 		/* Add a new test case description here. */
 );
 
@@ -358,6 +359,45 @@ kvfree_rcu_2_arg_vmalloc_test(void)
 	return 0;
 }
 
+static int
+vm_map_ram_test(void)
+{
+	unsigned int map_nr_pages;
+	unsigned char *v_ptr;
+	unsigned char *p_ptr;
+	struct page **pages;
+	struct page *page;
+	int i;
+
+	map_nr_pages = nr_pages > 0 ? nr_pages:1;
+	pages = kmalloc(map_nr_pages * sizeof(*page), GFP_KERNEL);
+	if (!pages)
+		return -1;
+
+	for (i = 0; i < map_nr_pages; i++) {
+		page = alloc_pages(GFP_KERNEL, 1);
+		if (!page)
+			return -1;
+
+		pages[i] = page;
+	}
+
+	/* Run the test loop. */
+	for (i = 0; i < test_loop_count; i++) {
+		v_ptr = vm_map_ram(pages, map_nr_pages, -1);
+		*v_ptr = 'a';
+		vm_unmap_ram(v_ptr, map_nr_pages);
+	}
+
+	for (i = 0; i < map_nr_pages; i++) {
+		p_ptr = page_address(pages[i]);
+		free_pages((unsigned long)p_ptr, 1);
+	}
+
+	kfree(pages);
+	return 0;
+}
+
 struct test_case_desc {
 	const char *test_name;
 	int (*test_func)(void);
@@ -374,6 +414,7 @@ static struct test_case_desc test_case_array[] = {
 	{ "pcpu_alloc_test", pcpu_alloc_test },
 	{ "kvfree_rcu_1_arg_vmalloc_test", kvfree_rcu_1_arg_vmalloc_test },
 	{ "kvfree_rcu_2_arg_vmalloc_test", kvfree_rcu_2_arg_vmalloc_test },
+	{ "vm_map_ram_test", vm_map_ram_test },
 	/* Add a new test case here. */
 };
 
-- 
2.30.2

