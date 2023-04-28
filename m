Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA706F123D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbjD1HSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345471AbjD1HSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:18:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535DB49CB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:17:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2470e93ea71so6813178a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682666278; x=1685258278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4couG4BvY3JielUUZmpwOAXPZt7eiYYa/cnyqJtYMcY=;
        b=UNZiuLA31nfuIZXnpg1UDGAw70JBijGze3Ipp7cFW7Xes/GxV5/ep/9cZIhyX/f6LW
         3WOJLCPMKF0SOuMFT8IKdFith2VP+RLp2ImQDFWvn00bNCZEObQ+48FpxaMljx0UgaxJ
         jZ2irFzHRE/SCeFgOgo3c6Gy9dTFXwssAkoteZ5L5jDkhCFboqWY1Q7Esia5Lcs3EHTn
         XNl49vIpjuCo5owRYU3+pgWJbl175FF/vNvIPOkgYB+nhXTj9ccpfFqeKvVBpuocHAp+
         vmLQJtfw4EbJNWAdMuAmPDacE+8YkameJBei+xVuYm05JY2XlDmWHliAgUr0ZQnRtuiz
         b2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682666278; x=1685258278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4couG4BvY3JielUUZmpwOAXPZt7eiYYa/cnyqJtYMcY=;
        b=JJ6KYZqj1XufgOa1dK2UcmUBjh5Bb0W71S+8R/Xqd0lJ1B+femovvtPR3j70D93GRX
         pHjn0/l6vASG8nFgKNAqLCwelTqPta0ON/NOCw0OrWUqkNTup9t8/jdc0Equ1JC2Kd1X
         UuXPdSiSsvrkb8MYVaj+AekcjzPwo1j6RpheaNhzH9gjoBgmkyoz1tungebPOnEKs/G4
         ow3MhOi28BIiV4pZREvGy5oh0zt3I5LBHCq5UugoJpR7LN3UBzZ7ZutwzSKZ2EGOWn0s
         0pT0UD+xT9PXNb7D/f970wjW9MHvvp5Q3R3ZjSkE0GK6knF+vn0M33b40X1qQ8ic0+EB
         ajsg==
X-Gm-Message-State: AC+VfDxT7VFmiGAPuojb6L1i7Iv8CjOWDMAOIF31vw+a92PG6xlWBeTI
        +bKbW4RoMUEudfRQeDG01dQgSw==
X-Google-Smtp-Source: ACHHUZ5CWg/M4bQAH4GZcYwHsNyR5prU/jNcdmueDnZTm3k4N46PrmOMlEcbkil/EUWg6ndcG4AvLQ==
X-Received: by 2002:a17:90a:d3d5:b0:24b:b22d:c78c with SMTP id d21-20020a17090ad3d500b0024bb22dc78cmr4412642pjw.9.1682666277813;
        Fri, 28 Apr 2023 00:17:57 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a318200b0024739d29252sm14159939pjb.15.2023.04.28.00.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 00:17:57 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v4 1/2] bpf: Add bpf_task_under_cgroup() kfunc
Date:   Fri, 28 Apr 2023 15:17:36 +0800
Message-Id: <20230428071737.43849-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230428071737.43849-1-zhoufeng.zf@bytedance.com>
References: <20230428071737.43849-1-zhoufeng.zf@bytedance.com>
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

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Add a kfunc that's similar to the bpf_current_task_under_cgroup.
The difference is that it is a designated task.

When hook sched related functions, sometimes it is necessary to
specify a task instead of the current task.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 kernel/bpf/helpers.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bb6b4637ebf2..453cbd312366 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2149,6 +2149,25 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
 		return NULL;
 	return cgrp;
 }
+
+/**
+ * bpf_task_under_cgroup - wrap task_under_cgroup_hierarchy() as a kfunc, test
+ * task's membership of cgroup ancestry.
+ * @task: the task to be tested
+ * @ancestor: possible ancestor of @task's cgroup
+ *
+ * Tests whether @task's default cgroup hierarchy is a descendant of @ancestor.
+ * It follows all the same rules as cgroup_is_descendant, and only applies
+ * to the default hierarchy.
+ */
+__bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
+				       struct cgroup *ancestor)
+{
+	if (unlikely(!ancestor || !task))
+		return -EINVAL;
+
+	return task_under_cgroup_hierarchy(task, ancestor);
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2400,6 +2419,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_SET8_END(generic_btf_ids)
-- 
2.20.1

