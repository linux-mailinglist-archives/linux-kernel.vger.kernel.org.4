Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A963A6CAB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjC0RBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjC0RBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:01:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFDB3ABA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:01:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h8so38968536ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679936489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psu4ofpncoCQSYgbBGuLj7J5oQ90Aa4oswGxv8KP4JU=;
        b=cJqF1kO/34CZQDvUzjw0nFJI3uzZdbpWLYwh/sTURwSu3Zr7QVA3YB+xmzgjIXtxNw
         plTPyZ6Ff6nayjkPG65E5AbN6P4Br9KHA5h6J3SznKc7ceg+iApLDn78xbkIAA1tLJRM
         0u6L7uk6uGWd5oQPkH2F3498o8rXSeu4vZLaZmUMftuHVTmZZrw35vDfC6fP/M5rBTGC
         oEJlhMH0hQsmZAs+mnqaI+s0N0uaUMD6RtXee01BUvrp8DvII6FNEUVk3tp9ckagjAeq
         BVTbcDwYhsqF2YJlqJcRfYfOtSlgwevlMeHevvq1dBw4qsIvUsevLMq7ibDfJK0pR+gU
         xlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psu4ofpncoCQSYgbBGuLj7J5oQ90Aa4oswGxv8KP4JU=;
        b=v6PaB0CAU2Y6DL0zmJpZOoztqbebayyj5w47whDUCbkwyqCgdIc2LleuwI0Dme70Vr
         HTqgIiilU1rQSi1AyHF9qSunNvl6Lye5lHWR0pvwu1F8b6EwS1KBZYWVKJSfaHv1Fuol
         2y5oIcXQBgFzf/OYWwJTBbjfrZ3tmp8ffx26GKc4CyzdKXv0sbjNQ4/khQNOHxOGsvTy
         5nWfgkvsKaXTnRVd+kS06Z1RFAT3BzNmRaw3hrlEGcX6S2RjfI8poscE7zGQKoGwEsgA
         qP0pntMP1rVcck5FdZV0iJY2hfyll9wngAwSTPHjM2knZWlGPxCuu6R7jNZBPsdC1Sq8
         jJOA==
X-Gm-Message-State: AAQBX9c1XxfXgcV8PheQLPleqizufIHHpQ/jRLK9Z6Y2k/tN1XBHjOSL
        etX++0EmZQXJT5U24tZiFe0=
X-Google-Smtp-Source: AKy350b3TXjxOhtha+OJSC79RBMwaldUw1aNzY57gPVRrx9yYKI8P7dgqIT+mPM/VNQnIURkGSaMiw==
X-Received: by 2002:aa7:cd8b:0:b0:502:3ea4:7f95 with SMTP id x11-20020aa7cd8b000000b005023ea47f95mr5894891edv.35.1679936488703;
        Mon, 27 Mar 2023 10:01:28 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id t27-20020a50ab5b000000b004c0c5864cc5sm14936026edc.25.2023.03.27.10.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:01:28 -0700 (PDT)
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
Subject: [PATCH v3 2/2] lib/test_vmalloc.c: Add vm_map_ram()/vm_unmap_ram() test case
Date:   Mon, 27 Mar 2023 19:01:26 +0200
Message-Id: <20230327170126.406044-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230327170126.406044-1-urezki@gmail.com>
References: <20230327170126.406044-1-urezki@gmail.com>
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

