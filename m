Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158DA6BA5BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCODp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCODp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:45:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A721979
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:45:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v21so8584811ple.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678851922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ufxsYZFIRnn+ldduLkLg4bGkJpmUn4VR4A6IuCdxW00=;
        b=dg0Zc85b60uFcQsEyeM2HVp7VR5yCO0uH+/OtvELnMEXmhdyLWg2ruNnFhZFXdae8P
         ffJj8SmJ1khEYn2U/Y55FPgRSradkCKkRXpgYo+VKEvu+gL+v+Qo+8zex0hIIJmm5JYH
         5GVaklNdvGCs3sJU2le+AGtIIRluUZttDQN6cKwf4c5Qong2+OwlYqbDTxv/8hKyo4ox
         VzbD8KXs4Q0UhAqGhCETsw5e8Xd1Fs/dJ6Re+e64Mn0eS+ZLBfCMZGWtH1WteoSpmA5S
         mtgehdbtBfqoZ2AQPuES5dqrIB6BYkp0I9wPOVkZkO7zy/0gepYkaBPOOdypQPLldeUo
         QQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678851922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufxsYZFIRnn+ldduLkLg4bGkJpmUn4VR4A6IuCdxW00=;
        b=Rd0rTcduDzOgc9AGhGD8O8xLfvJPueEX7g18Dw4StTNa/zfe3cK2CGvUVPeuwVi0Lj
         7/t9eXGVtJCXKn776OcaAevWuoVNG1CBl52mD4kuDE9MUJ1kAz8U/U2VsdebQw/4A3vs
         dnXmLtt0EjMvk+psV2ovamDweji3kbmbsfRMguWtdw7bUYJCyD4EC+GbRopsPLcl8ZJB
         2syUDxcL/MLDCHgnRTc2+C68vn3gjbvwMflq/W40AsYTMy7xZOi7T+0sW7GwGcbsm0Ze
         pB4aab4FULubPhwBp4pb1eyy30qZH9MbbfPdyAwUAlkJH+KGJGjItwk6paH3CF15f8nF
         qq+w==
X-Gm-Message-State: AO0yUKV0ROJ51MvJhR5tOqMMW9XoDGtuZZSs3FMMw5zk7Elv6zuDFIr+
        y4J/b7JVZNYJ2wnp8oB+eGNGEw==
X-Google-Smtp-Source: AK7set8NPpPy05CtArxi3hzNCU0RjupArdPbdOOSdf5EjczXQxGFxpPVHURTwlD4xAtYVBIjwNxKtg==
X-Received: by 2002:a17:903:187:b0:19c:1455:d588 with SMTP id z7-20020a170903018700b0019c1455d588mr1227815plg.0.1678851922251;
        Tue, 14 Mar 2023 20:45:22 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902789700b0019f0e766809sm2436258pll.306.2023.03.14.20.45.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Mar 2023 20:45:21 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, jannh@google.com, sjpark@amazon.de
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: kfence: fix using kfence_metadata without initialization in show_object()
Date:   Wed, 15 Mar 2023 11:44:41 +0800
Message-Id: <20230315034441.44321-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable kfence_metadata is initialized in kfence_init_pool(), then, it is
not initialized if kfence is disabled after booting. In this case, kfence_metadata
will be used (e.g. ->lock and ->state fields) without initialization when reading
/sys/kernel/debug/kfence/objects. There will be a warning if you enable
CONFIG_DEBUG_SPINLOCK. Fix it by creating debugfs files when necessary.

Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/kfence/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 5349c37a5dac..79c94ee55f97 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -726,10 +726,14 @@ static const struct seq_operations objects_sops = {
 };
 DEFINE_SEQ_ATTRIBUTE(objects);
 
-static int __init kfence_debugfs_init(void)
+static int kfence_debugfs_init(void)
 {
-	struct dentry *kfence_dir = debugfs_create_dir("kfence", NULL);
+	struct dentry *kfence_dir;
 
+	if (!READ_ONCE(kfence_enabled))
+		return 0;
+
+	kfence_dir = debugfs_create_dir("kfence", NULL);
 	debugfs_create_file("stats", 0444, kfence_dir, NULL, &stats_fops);
 	debugfs_create_file("objects", 0400, kfence_dir, NULL, &objects_fops);
 	return 0;
@@ -883,6 +887,8 @@ static int kfence_init_late(void)
 	}
 
 	kfence_init_enable();
+	kfence_debugfs_init();
+
 	return 0;
 }
 
-- 
2.11.0

