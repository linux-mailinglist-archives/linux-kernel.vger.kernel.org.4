Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E75740AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjF1IIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjF1ICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:02:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1513C2956
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:01:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666ed230c81so4949703b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687939316; x=1690531316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVHRGKJQOMwzWN83g2m+Cd2Oov5QH2ldO2Pug8KfAvg=;
        b=QOF6Ti9wHMS5didrT90b4hH0tCVqbTZyim+VdQRTLxqzWA856cXTokXmeMWVkTD2Ny
         0B3SvYZpfGwTQrNApbz4ShZf7vOBjBDFJsaJ27GPbzmsTlcIwumIGyFD3t83FY1TyTrj
         kAhNuxx65kG1/+r3TfAmStel9sNMof6P4yhLtSnnzMA2kF6oy2WQhVRrDBVRqf1FTjU2
         CqF8ftEyF5/zVqxfMSfbgxRN2dI3KjpwvCfFlCCgPrhgZotdY0S8FhmwBuPNIFpjPNf5
         ob5CNzzmX2pcBvjCeczYimVqFzLNmGWm6eo+9UBAnBi/Yi2R3tlHauVRRDnI9H1KtBTb
         m/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939316; x=1690531316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVHRGKJQOMwzWN83g2m+Cd2Oov5QH2ldO2Pug8KfAvg=;
        b=Usn+H8IXBC+oLwPMAYGja9b85VQ3TeJ4PnxBWR1sKiYuIQp8cusQj5drcEJxQynsLq
         nyYuiV1/EU4gFRrogjZ0hSLnsaOkUISJrv5qOY9ssxVGYHGM2L0duaGQCRQ5Yeu4NENs
         18/l5MzVGaDB6FehNWWDT5EXXh8COGTgBjmN2U3gQRJdp2WDCJPLrwlmCMODi1/lihxL
         hWGpIYTfKzhYaBX/KoLmHKb6MoiDIuVHy0xR8kNRd19bLMgtkmPOtsiVepv1T38bnhub
         iMju84nyq7DzyYK5/qfcDxBU7KcmwDuoZI65och//bMIyj9jOS3QynIs9zKfdGWM2fKN
         mWsg==
X-Gm-Message-State: AC+VfDzd8Az1uZlfmK5JpBThzV90nHbKu4jRoSk/CKs1wT8xI4qaEKtR
        tXoXxycvE67X+OXXeQbATlWNWfFniPLkhQ/2JI2YRw==
X-Google-Smtp-Source: ACHHUZ5+PvtsHNs9Wy1quunYgyqWj1bXlsRhzyJYtceWJ7YMan2oFDzco6hyvxSK51LzuybFcQy+cg==
X-Received: by 2002:a17:902:d2ca:b0:1b6:8c7e:4e7a with SMTP id n10-20020a170902d2ca00b001b68c7e4e7amr15240644plc.67.1687937834808;
        Wed, 28 Jun 2023 00:37:14 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001b8021fbcd2sm4836988plb.280.2023.06.28.00.37.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Jun 2023 00:37:14 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 2/4] maple_tree: add test for expanding range in RCU mode
Date:   Wed, 28 Jun 2023 15:36:55 +0800
Message-Id: <20230628073657.75314-3-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230628073657.75314-1-zhangpeng.00@bytedance.com>
References: <20230628073657.75314-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test for expanding range in RCU mode. If we use the fast path of the
slot store to expand range in RCU mode, this test will fail.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/radix-tree/maple.c | 75 ++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 03539d86cdf0..312c0d9fcbae 100644
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

