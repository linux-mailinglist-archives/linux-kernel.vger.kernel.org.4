Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FCB6BEA69
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjCQNpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjCQNo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:44:56 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4E326B1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 06:44:54 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id o12so20509633edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 06:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679060693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YezikHQUygm0KAkzKI4mrR3/7OjNf8PCGFqoeYhJShw=;
        b=AAFW63e+eppt68OPxTT/AQxPyu+iGOgLoSs1zmOotKqHP8S4Q+XuL2Dkn2cO/1YA9n
         FJFo1pVZ9pUtGRzuRPcWHfkS+QD5lxv1ucwrqITGcncTKe3ZyBwBEfBfbIrzAe7inBLM
         ZHkL4BsJpMyxXN4/SyvgvyK6bQxtrOUJY999U9XijXOGGBiM4IsSpzDbxpLJDlRIwXiP
         zJjbntqyLhxFEzcFzh6/blQrn8rGpA7EZ2Ct/W0GCxLfMsbRF7fYo0c9TPZolx9QyWN5
         z/1euYRzqwLEqg6s9Z/AClov6FI+UDuiSlO9RTNmGzGiaCoFJT7XdwMjqZkjTFWQG3GW
         NvFA==
X-Gm-Message-State: AO0yUKVmLElz0DreRSXOZgcGTsuGxB66geD2xPQ0o07NZZ+IO4lVrcfS
        fwBUmo30foKSbRnLnJRo8z8=
X-Google-Smtp-Source: AK7set8W6CBQK9DHME/oMj44VdHDuWDaYeldL0uT0YRT9PqS8dczD/Fs05iiv7KqmxIKgTa6EaVd8A==
X-Received: by 2002:a17:906:2645:b0:882:ed4a:f23 with SMTP id i5-20020a170906264500b00882ed4a0f23mr13791775ejc.49.1679060693197;
        Fri, 17 Mar 2023 06:44:53 -0700 (PDT)
Received: from localhost.localdomain (85-160-41-201.reb.o2.cz. [85.160.41.201])
        by smtp.gmail.com with ESMTPSA id gz14-20020a170906f2ce00b00923221f4062sm999273ejb.112.2023.03.17.06.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 06:44:52 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leobras@redhat.com>
Cc:     Frederic Weisbecker <fweisbecker@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 1/2] sched/isolation: Add cpu_is_isolated() API
Date:   Fri, 17 Mar 2023 14:44:47 +0100
Message-Id: <20230317134448.11082-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230317134448.11082-1-mhocko@kernel.org>
References: <20230317134448.11082-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Provide this new API to check if a CPU has been isolated either through
isolcpus= or nohz_full= kernel parameter.

It aims at avoiding kernel load deemed to be safely spared on CPUs
running sensitive workload that can't bear any disturbance, such as
pcp cache draining.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/sched/isolation.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 8c15abd67aed..fe1a46f30d24 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -46,6 +46,12 @@ static inline bool housekeeping_enabled(enum hk_type type)
 
 static inline void housekeeping_affine(struct task_struct *t,
 				       enum hk_type type) { }
+
+static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
+{
+	return true;
+}
+
 static inline void housekeeping_init(void) { }
 #endif /* CONFIG_CPU_ISOLATION */
 
@@ -58,4 +64,10 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
 	return true;
 }
 
+static inline bool cpu_is_isolated(int cpu)
+{
+	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
+		 !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
+}
+
 #endif /* _LINUX_SCHED_ISOLATION_H */
-- 
2.30.2

