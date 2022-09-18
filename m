Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6325BBE5B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIROXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 10:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIROXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:23:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB0C1EC4F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:23:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a29so2096714pfk.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=pCvLRXZeSS8Xv+P2yZLemIO5TfCptl+VP0tjVjXoGzk=;
        b=hIP/czaoK3n/oe9GdrWrAxteKBysKQHjv9bn3oug3XwbloDqohDeHe6nZw5wAOEmFS
         xHFw0bei3z2mVntO+xdSnIxrT0l/OOnt+j6hgv19f8Ue+Ydj61QQBL1tpMQvqbIPewvj
         Yg3Q6VgHq/ih3fk55J412esBw1dgrn41zsv5JYEj8ycpsbZ1yxT/sPfodviVntFZQlLy
         ZSEJWykE9WCn/u+PyDBDZsji16qBzFu6J6aFgYMrkOHzlYlN3vHMcoj87T3Yhe5/nfjX
         hUIhYm+xOJ6SwnriJRXXoIY5FNSFmcwYwsOxRDSGt7F6U2ndBIF5TMvjlRLp0pDMKqfu
         Cu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=pCvLRXZeSS8Xv+P2yZLemIO5TfCptl+VP0tjVjXoGzk=;
        b=GctBd5adeXehb0n8uAtABEaZ2wJcFE94mg/8bq7zAAhXoftGozALZsGsF4c1BBV2aF
         fLkaPOar4u3q8Xlamyz9rHpKyfDAehJLqppFp/kNsaqMW2K9QJwlRJmeUZpS6zZmsGqU
         Jxwxr9FThdZwIM15JpklFE0Os6Puhd/ni/qxdPiM2MPXkzQBe86sewDoZdoMxGEaOToS
         jNmaTsaehbKHWxq9gXg8fRtICWfdYxx6Qsoh97E91lBXE2p9x+DQ1HcPASXzIzSO6tzT
         7Ng9oboY4RNe1l4t+KDOLNJLJZ0b+j2nHHc0o1QYvndXC4vP7Qs/VQqXnm2K+TCUGy2v
         Mkeg==
X-Gm-Message-State: ACrzQf2L/6poWSSaSFkXWGQ6gdE8q0uynpDXSqwUplkjnBu+F2RFijNz
        epF9aZ41zlTLN6ZPEX1T7Nc=
X-Google-Smtp-Source: AMsMyM6ZNE36tmix1QHVskobn8R/nKoKZdw+Q6QOKboCQIvTA5IxJc5V3Gv7M/zYuwtsqqoYrZwKOQ==
X-Received: by 2002:a63:9856:0:b0:439:e932:3957 with SMTP id l22-20020a639856000000b00439e9323957mr4497208pgo.385.1663511015998;
        Sun, 18 Sep 2022 07:23:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902d4c400b001782f94f8ebsm15606356plg.3.2022.09.18.07.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 07:23:35 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] lib/test_maple_tree: fix comparing pointer to 0
Date:   Sun, 18 Sep 2022 14:23:03 +0000
Message-Id: <20220918142302.209905-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

Comparing pointer whith NULL instead of comparing pointer to 0.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 lib/test_maple_tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 4f69e009a015..ef28aa8e79f1 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -34612,7 +34612,7 @@ STORE, 140501948112896, 140501948116991,
        mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
        check_erase2_testset(mt, set27, ARRAY_SIZE(set27));
        rcu_barrier();
-       MT_BUG_ON(mt, 0 != mtree_load(mt, 140415537422336));
+       MT_BUG_ON(mt, NULL != mtree_load(mt, 140415537422336));
        mt_set_non_kernel(0);
        mt_validate(mt);
        mtree_destroy(mt);
@@ -34736,7 +34736,7 @@ STORE, 140501948112896, 140501948116991,
        mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
        check_erase2_testset(mt, set37, ARRAY_SIZE(set37));
        rcu_barrier();
-       MT_BUG_ON(mt, 0 != mtree_load(mt, 94637033459712));
+       MT_BUG_ON(mt, NULL != mtree_load(mt, 94637033459712));
        mt_validate(mt);
        mtree_destroy(mt);

@@ -34744,7 +34744,7 @@ STORE, 140501948112896, 140501948116991,
        mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
        check_erase2_testset(mt, set38, ARRAY_SIZE(set38));
        rcu_barrier();
-       MT_BUG_ON(mt, 0 != mtree_load(mt, 94637033459712));
+       MT_BUG_ON(mt, NULL != mtree_load(mt, 94637033459712));
        mt_validate(mt);
        mtree_destroy(mt);

-- 
2.15.2

