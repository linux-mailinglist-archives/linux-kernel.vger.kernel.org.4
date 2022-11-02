Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BFB6160BF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiKBKYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKBKYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:24:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D652270
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 03:24:00 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p15-20020a17090a348f00b002141615576dso1664995pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 03:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTP63kQwOw1YO+WrEKDysOnr36FxfbvLN7e4W99sGyg=;
        b=SjxUIEHrr1myH5WYkP+7nEZ/j4tFv1FWQYYo/B6f9yRmaXWlGXeTFt3cFD2GJaZZjq
         bhrJTCBNiDXW4OvsvDeGANs3++n4jVZzr6QuSAHrNI4bbhGvZI9ge8s7K9Yy5wG8xfIb
         RnYg9D4LIbJjjli1+lmVcHcTrpFxPW83bvYHCvH82tS7w6gyB0fWi+oD/uT58z0Xf4cJ
         BlFLx+NyXWD2/Lia2aix3aSYxWgMSbTSgpNUxy9+sfZikF0zVxp3AzK/I2QLFKb/Jg8e
         WI3IG/d1+MT3uUdpdH4/silRtSFrKo5h9eDVU56RZ8/DRFLcW8JSpuuHi2ETQKhehiy5
         1IIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTP63kQwOw1YO+WrEKDysOnr36FxfbvLN7e4W99sGyg=;
        b=O80isSKdjDT+QvfwR+xeJ7rOMDU0f9xRff4lEM3gPHWhW/2zNQ3aGZQzKSoQcojoOn
         h7gQU/PTirsfj68kYaQp80GuogEhYrFAUePSdsDylEe0Rr0oxcRrKlihMQTYWz17QrlE
         KVQphhMz1DWq473ZLQLDut34wXNUwy/GBGwACwHNqFoaS9xySLu0aXMNwCT4ItgvmRbh
         NAKIa+PxXJsmduqg6Qq14lrrAoh8TxxNfZT10TNt8G3G8LBlfRQsbAT8K667nnq7Hsax
         6uQlw4MUsfMb6FuPE+XtbV6OaqR2kcs3BpZGCIA9JiyT50avBjB7k44GnJ4rw+NNYctL
         CScA==
X-Gm-Message-State: ACrzQf3VFDMQVwWFtuyb0M+eOQeltp3dfoNkxxt+tP3o+393wxa3dZcH
        3JtmX20lClDr5effJ2Nz2tQFpg==
X-Google-Smtp-Source: AMsMyM74nfxQldBgt3dzAkimFGpm81YKM2RK1fMlbG87Z1BjhhyNSfRo0bgLmITRvHFUn2FQgkcuaQ==
X-Received: by 2002:a17:90b:4a42:b0:213:383f:cd21 with SMTP id lb2-20020a17090b4a4200b00213383fcd21mr41550560pjb.23.1667384639784;
        Wed, 02 Nov 2022 03:23:59 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ec8500b00177f82f0789sm7973613plg.198.2022.11.02.03.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 03:23:59 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] sched/core: Minor optimize ttwu_runnable()
Date:   Wed,  2 Nov 2022 18:23:43 +0800
Message-Id: <20221102102343.57845-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
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

ttwu_runnable() is used as a fast wakeup path when the wakee task
is between set_current_state() and schedule(), in which case all
we need to do is change p->state back to TASK_RUNNING. So we don't
need to update_rq_clock() and check_preempt_curr() in this case.

Some performance numbers using mmtests/perfpipe on Intel Xeon server:

                           linux-next                patched
Min       Time        8.67 (   0.00%)        8.66 (   0.13%)
1st-qrtle Time        8.83 (   0.00%)        8.72 (   1.19%)
2nd-qrtle Time        8.90 (   0.00%)        8.76 (   1.57%)
3rd-qrtle Time        8.98 (   0.00%)        8.82 (   1.82%)
Max-1     Time        8.67 (   0.00%)        8.66 (   0.13%)
Max-5     Time        8.67 (   0.00%)        8.66 (   0.13%)
Max-10    Time        8.79 (   0.00%)        8.69 (   1.09%)
Max-90    Time        9.01 (   0.00%)        8.84 (   1.94%)
Max-95    Time        9.02 (   0.00%)        8.85 (   1.86%)
Max-99    Time        9.02 (   0.00%)        8.88 (   1.56%)
Max       Time        9.59 (   0.00%)        8.89 (   7.29%)
Amean     Time        8.92 (   0.00%)        8.77 *   1.65%*

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 87c9cdf37a26..3785418de127 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3718,9 +3718,8 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 
 	rq = __task_rq_lock(p, &rf);
 	if (task_on_rq_queued(p)) {
-		/* check_preempt_curr() may use rq clock */
-		update_rq_clock(rq);
-		ttwu_do_wakeup(rq, p, wake_flags, &rf);
+		WRITE_ONCE(p->__state, TASK_RUNNING);
+		trace_sched_wakeup(p);
 		ret = 1;
 	}
 	__task_rq_unlock(rq, &rf);
-- 
2.37.2

