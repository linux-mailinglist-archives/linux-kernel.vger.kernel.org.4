Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF105731281
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbjFOInk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244453AbjFOInR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:43:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C3B296C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:43:15 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666729f9093so1220153b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686818595; x=1689410595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpzykzsbiMOLk6qot3spisUo8VNsB6lkGRakXgvX2Lw=;
        b=f5u5ND5nwplGrN2UmPJkv0viCKJSKGsY/UI4A0vMG82lz601xyYPuSRYCh50ZPBdKc
         xZfMnrR2BUQmQZD1dLgTlZgt6DHNqhuw1uWV17tAjGf8aTLgGuQJOB5Rp+ETMqhBhEIe
         e9xOrmZd7CJebdQh/HkiPyMeMSA1f3mVlQ2WRanzU9FQhLWN2EZhlhLxjOVdUnOVFOk6
         nF7tkC5CoW4iBhGnjs59/j96iVnqhzidhQy9ukii/QT/USuxV+nT/U3Z7DEL4MmyKltJ
         yM0d3URmYutsVKMrFIr75MB8eACGTg3uOEE/J2eqxWFngrikhAAOtOUSirS1ATZyVLqe
         c3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686818595; x=1689410595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpzykzsbiMOLk6qot3spisUo8VNsB6lkGRakXgvX2Lw=;
        b=Psbl5xZuIsqvurgUGKwWESAEIL6DKvSOseObOi1I8HGvxl9mkcw65ra4iUCaZiUULK
         kNKwz0dLqZT77RL14R1+YfMRrLB/ENYKGKx4+ZSM2dUUNa3VPD57DvfP3+bMrQN/VGw9
         JDqPQf0j27XX3QF6448QTScTzq5wlgA3CkMjAGs7h9T3V2g4HeWBKEnwQNNR0Swu9jiv
         adRT4wTm5+ee/cF6FL+KET7obFvNEw99HVCh9DEJ8uFtomqDM4G2okjbqxgZ3C5hZzHb
         kgcKygFxVNBRyX+HwCshrFNIGiAsP7K+qCVh6+1TokzaB1/OV4CD5VSAye8LMG0BI1wi
         ynww==
X-Gm-Message-State: AC+VfDxHQ/XnXsP2sEs+SSw4eYQ1XZ4JaqAElwri6+ROR/ZL8ER5F/BP
        q3XwTW4CumQf/OsyM0eo/wGnJA==
X-Google-Smtp-Source: ACHHUZ4VQWfVCwhn8hOlPVP9rhgoXWi3pKF2VBEqo221ku0kE/CNCTN7a+kbBIJsTlD3klPehwhA6w==
X-Received: by 2002:a05:6a00:c92:b0:64c:a554:f577 with SMTP id a18-20020a056a000c9200b0064ca554f577mr5393636pfv.11.1686818595126;
        Thu, 15 Jun 2023 01:43:15 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i21-20020aa78b55000000b0064fe06fe712sm11139783pfd.129.2023.06.15.01.43.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 01:43:14 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 2/4] maple_tree: add test for expanding range in RCU mode
Date:   Thu, 15 Jun 2023 16:42:59 +0800
Message-Id: <20230615084301.97701-3-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230615084301.97701-1-zhangpeng.00@bytedance.com>
References: <20230615084301.97701-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test for expanding range in RCU mode. If we use the fast path of the
slot store to expand range in RCU mode, this test will fail.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 tools/testing/radix-tree/maple.c | 75 ++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index c42033172276..0887826946f9 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -45,6 +45,13 @@ struct rcu_test_struct2 {
 	unsigned long last[RCU_RANGE_COUNT];
 };
 
+struct rcu_test_struct3 {
+	struct maple_tree *mt;
+	unsigned long index;
+	unsigned long last;
+	bool stop;
+};
+
 struct rcu_reader_struct {
 	unsigned int id;
 	int mod;
@@ -34954,6 +34961,70 @@ void run_check_rcu(struct maple_tree *mt, struct rcu_test_struct *vals)
 	MT_BUG_ON(mt, !vals->seen_entry2);
 }
 
+static void *rcu_slot_store_reader(void *ptr)
+{
+	struct rcu_test_struct3 *test = ptr;
+	MA_STATE(mas, test->mt, test->index, test->index);
+
+	rcu_register_thread();
+
+	rcu_read_lock();
+	while (!test->stop) {
+		mas_walk(&mas);
+		/* The length of growth to both sides must be equal. */
+		RCU_MT_BUG_ON(test, (test->index - mas.index) !=
+				    (mas.last - test->last));
+	}
+	rcu_read_unlock();
+
+	rcu_unregister_thread();
+	return NULL;
+}
+
+static noinline void run_check_rcu_slot_store(struct maple_tree *mt)
+{
+	pthread_t readers[20];
+	int range_cnt = 200, i, limit = 10000;
+	unsigned long len = ULONG_MAX / range_cnt, start, end;
+	struct rcu_test_struct3 test = {.stop = false, .mt = mt};
+
+	start = range_cnt / 2 * len;
+	end = start + len - 1;
+	test.index = start;
+	test.last = end;
+
+	for (i = 0; i < range_cnt; i++) {
+		mtree_store_range(mt, i * len, i * len + len - 1,
+				  xa_mk_value(i * 100), GFP_KERNEL);
+	}
+
+	mt_set_in_rcu(mt);
+	MT_BUG_ON(mt, !mt_in_rcu(mt));
+
+	for (i = 0; i < ARRAY_SIZE(readers); i++) {
+		if (pthread_create(&readers[i], NULL, rcu_slot_store_reader,
+				   &test)) {
+			perror("creating reader thread");
+			exit(1);
+		}
+	}
+
+	usleep(5);
+
+	while (limit--) {
+		/* Step by step, expand the most middle range to both sides. */
+		mtree_store_range(mt, --start, ++end, xa_mk_value(100),
+				  GFP_KERNEL);
+	}
+
+	test.stop = true;
+
+	while (i--)
+		pthread_join(readers[i], NULL);
+
+	mt_validate(mt);
+}
+
 static noinline
 void run_check_rcu_slowread(struct maple_tree *mt, struct rcu_test_struct *vals)
 {
@@ -35206,6 +35277,10 @@ static noinline void __init check_rcu_threaded(struct maple_tree *mt)
 	run_check_rcu(mt, &vals);
 	mtree_destroy(mt);
 
+	/* Check expanding range in RCU mode */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	run_check_rcu_slot_store(mt);
+	mtree_destroy(mt);
 
 	/* Forward writer for rcu stress */
 	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
-- 
2.20.1

