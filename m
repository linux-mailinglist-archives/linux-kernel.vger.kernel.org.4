Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB956D0E51
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjC3TGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjC3TGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:06:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9D926B9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:06:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so80534513edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680203203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voXOGIdYOWM2wLNWqmTahTqMnugMmbDeB8dmByAxjSs=;
        b=mNXgQ0SRS48kDk5F+4+TYcIY68iJFezo2AcCPQVSkQkTvq5hJG0XolZpaqsLaZARmx
         tFzenxMn1LAXy5MrS+W1o4Upp8BJzcUuOS5hedmSRfR006gAxaUiMnO7XqYQpeLEyQPJ
         2lWnIBO8KbOEOhh2UD9M/6BBFnC4IFdp76kciTBnyFArOvmKJgLwfFbO0glV6lVu1JXB
         YWQH0CGqsBeRqwvmFg3rhKJrvzs43CO9rIxeb9XBquzS7MxCnmPFexNGPfIrvFslsxSK
         d5UykufwU9IhTzQ7d5VSJwPGE+lJ20pe9QckBuC81p6MTJN2iVuvo3obysSIvoWt6dyc
         RLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voXOGIdYOWM2wLNWqmTahTqMnugMmbDeB8dmByAxjSs=;
        b=wkVtJPHWGYeKN6IoYQGm7PQDZX0WP7b5BrfXiesvEcf4ZGxdZcwfxwWJpkOHUi+rCT
         MuGbHYAQ0mFwonyCIDliHrbf2FkJsWM81GfQivb9gzj/SadvEZubbzHChb0YrCJ0K8I5
         0IERI889R+Zzd9FttHXu0jSe4nmzlFI7WOnncGEtZwRgneMtK8vdGmRD4PCEeYIgTlZ3
         w6rHJ9UKh9KGwdqHpz22/16GxhBUagRlZqUSKQ8dLUYWjnzm67ghscaDDi8OGyG8MR+H
         5FGLIExc2YIGF8CDrjf4NOXHhULH7RARPfeY+8iUO7LB3gndMOzFMW8Q+aacPBLjPq8E
         Ljyg==
X-Gm-Message-State: AAQBX9e7S5g50L8na7DbSc/qgIPQyFbshlMmYbkei8KvtZMn9FRc28r7
        eYz4dJLvGTu2NeS9D153Z+s=
X-Google-Smtp-Source: AKy350bRthKl0rgnD5bNDKbIzTOBEPf+AIAt2HRlcVZrT3FbMB536ToFxOSzKbPE1+MuS7SWfepGPA==
X-Received: by 2002:a17:907:d047:b0:945:2f54:5eae with SMTP id vb7-20020a170907d04700b009452f545eaemr14046768ejc.77.1680203202841;
        Thu, 30 Mar 2023 12:06:42 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090608d200b0092973e209f2sm122240eje.109.2023.03.30.12.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:06:42 -0700 (PDT)
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
Subject: [PATCH v4 2/2] lib/test_vmalloc.c: Add vm_map_ram()/vm_unmap_ram() test case
Date:   Thu, 30 Mar 2023 21:06:39 +0200
Message-Id: <20230330190639.431589-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230330190639.431589-1-urezki@gmail.com>
References: <20230330190639.431589-1-urezki@gmail.com>
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
 lib/test_vmalloc.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index cd2bdba6d3ed..1622f3f9ec23 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -53,6 +53,7 @@ __param(int, run_test_mask, INT_MAX,
 		"\t\tid: 128,  name: pcpu_alloc_test\n"
 		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
 		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
+		"\t\tid: 1024, name: vm_map_ram_test\n"
 		/* Add a new test case description here. */
 );
 
@@ -358,6 +359,41 @@ kvfree_rcu_2_arg_vmalloc_test(void)
 	return 0;
 }
 
+static int
+vm_map_ram_test(void)
+{
+	unsigned long nr_allocated;
+	unsigned int map_nr_pages;
+	unsigned char *v_ptr;
+	struct page **pages;
+	int i;
+
+	map_nr_pages = nr_pages > 0 ? nr_pages:1;
+	pages = kmalloc(map_nr_pages * sizeof(struct page), GFP_KERNEL);
+	if (!pages)
+		return -1;
+
+	nr_allocated = alloc_pages_bulk_array(GFP_KERNEL, map_nr_pages, pages);
+	if (nr_allocated != map_nr_pages)
+        goto cleanup;
+
+	/* Run the test loop. */
+	for (i = 0; i < test_loop_count; i++) {
+		v_ptr = vm_map_ram(pages, map_nr_pages, NUMA_NO_NODE);
+		*v_ptr = 'a';
+		vm_unmap_ram(v_ptr, map_nr_pages);
+	}
+
+cleanup:
+	for (i = 0; i < nr_allocated; i++)
+		__free_page(pages[i]);
+
+	kfree(pages);
+
+	/* 0 indicates success. */
+	return nr_allocated != map_nr_pages;
+}
+
 struct test_case_desc {
 	const char *test_name;
 	int (*test_func)(void);
@@ -374,6 +410,7 @@ static struct test_case_desc test_case_array[] = {
 	{ "pcpu_alloc_test", pcpu_alloc_test },
 	{ "kvfree_rcu_1_arg_vmalloc_test", kvfree_rcu_1_arg_vmalloc_test },
 	{ "kvfree_rcu_2_arg_vmalloc_test", kvfree_rcu_2_arg_vmalloc_test },
+	{ "vm_map_ram_test", vm_map_ram_test },
 	/* Add a new test case here. */
 };
 
-- 
2.30.2

