Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A4C6045B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiJSMrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiJSMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:47:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26D812977F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:30:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l4so17089789plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRCTWKYjx2wpPZZk04Ley0VgHSoVGSlzkE3jRQHvIBA=;
        b=J/Z/9XTmxWcYsEXXcMX3wHLvo5mA8In7iIOAmCzDG/x2Eq5v5dGj9fIlE3CaWG1Izp
         RrvUMWXRPQpdzTa3bTTWAQTJsy9E86kONlaiNrAuQD4qfHAYUzSBzWtziP6quryaM6eF
         txli+FDXkF1IO689AUO+4O/Q2ZF5P5anE8bwp9ksrPOb2F6fDz3yrkFBBVUMtEXrUOqa
         Dbqpi1HKpYTvJGCnsBC+mahMgDf+Zr9uWLK/W3iC7E3KC0u151mZAIuQjJPxWHq4Yni0
         WbnUNA1USzFbWIzl8iHJjlgHC9h9493cw1yZ8qH3WNq2YCFQi0ijMggMWwhmDBNXGyp1
         nCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRCTWKYjx2wpPZZk04Ley0VgHSoVGSlzkE3jRQHvIBA=;
        b=O2/P4VEse9kSx5neG6CWkYF8R+5wmKnnFg/O1O3YTLBH7JO8IT1ei/fB0CgPYJA0N1
         Y7/zQ1CdCnQCnrVkFOmzNH49n2Df+Tn+pBQVSV3rMpCLtbk0ZnVbplk+BmOuIKrIGiAo
         8JVX+5JsuXsLrorhUmYyp3yTA7mKzICwVokWWr1WuOrugxruXwZYbJWT2QIy+k9/mPoG
         Xzkipk7lUdAbgY7lkcgXai/K9yXRjMm3I9bs1fEfbMnjlsrnybRvdoDI7r+u28DvoZ5Z
         2EM3nIjKHb44iAEQxJqvCPfsMZZuOx1ZWzuGxoiVpVpTHakh3bsULyMjyTv1+AxdsQeD
         JMSA==
X-Gm-Message-State: ACrzQf1vQYKiTFrGSJmMTU88w0xXTpnlyJsYvkJB2PqkfEcsXQd0fEWs
        tLP3encYFUOjvG7P9tYJcgE+YQ==
X-Google-Smtp-Source: AMsMyM7OGLoSQpWYtdYsdFZuYFB5Qh0+zsR8d8YvOYshQvkPSMLeGO++Iq6kpDrMBRVDIpcfDfW5yA==
X-Received: by 2002:a17:90a:74c2:b0:20a:f63c:2464 with SMTP id p2-20020a17090a74c200b0020af63c2464mr9724981pjl.224.1666182576122;
        Wed, 19 Oct 2022 05:29:36 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id c21-20020a63da15000000b00439c6a4e1ccsm9881825pgh.62.2022.10.19.05.29.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:29:35 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v6 1/4] sched/fair: Skip core update if task pending
Date:   Wed, 19 Oct 2022 20:28:56 +0800
Message-Id: <20221019122859.18399-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019122859.18399-1-wuyun.abel@bytedance.com>
References: <20221019122859.18399-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function __update_idle_core() considers this cpu is idle so
only checks its siblings to decide whether the resident core is
idle or not and update has_idle_cores hint if necessary. But the
problem is that this cpu might not be idle at that moment any
more, resulting in the hint being misleading.

It's not proper to make this check everywhere in the idle path,
but checking just before core updating can make the has_idle_core
hint more reliable with negligible cost.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5ffec4370602..e7f82fa92c5b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6294,6 +6294,9 @@ void __update_idle_core(struct rq *rq)
 	int core = cpu_of(rq);
 	int cpu;
 
+	if (rq->ttwu_pending)
+		return;
+
 	rcu_read_lock();
 	if (test_idle_cores(core))
 		goto unlock;
-- 
2.37.3

