Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A362C60DB86
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiJZGnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiJZGnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:43:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79407AE851
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:43:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e4so10457238pfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIlTSDWbVtqkeVttUcwmGvIfocdqv0kcWKfN4GKoIZ8=;
        b=uaadtIEGpfWSDRPGzX2Ka4GTJgjPlMo5p28PF2vQeBzSIzSSz0Ox1TrE239LPGLjZj
         LTY2wizD6N0vBeZ8ZY+dvZPeYIpiqkjTey5L5yHwRz8/UsLboW0ZOwxnOIIPw1C77jqZ
         JFTluMO9P4NxRWnUqe/EbELATGUOmdK5V6SkOSgrFzSwlWXUm8EA8URFCTQMV8b8n8WK
         bpXe5fmTMBZ6/70pOdXuSmpdWvFaDvt+YDlgJtvqiLtYEnbqguIF6dxy8/VDl+8AKer/
         2lrvrXGEdF68wLKMUNVeU2hLLaWuph/WmGLcT59HI1PwqWzhLFqG3GwBBPACjgSpwFJd
         23Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIlTSDWbVtqkeVttUcwmGvIfocdqv0kcWKfN4GKoIZ8=;
        b=Zp+J/10E7dPym7M5CKB8EbyRBpWLgQc9hpKPIU5PDM/NsRLMSIox6gHTFZD/izfCSK
         Imcsa1SqfgUWWFsGPwJvsFmAr/L68Sh/JXwPL8EHkl/Lbc/OADN+0Y7Np8gLLTiH2arV
         hXkupVpwcT8ll6J8IiAoARk2O4h3BjipGWNs29eI6q1NzfKtsgEHKTF19IRNOAbcnjTL
         LITyce5STUFeQq/iUKEmZIjmDelQFzNTjKUzWb+iSKYV44wxqy+ANl66lSxxMdwn0Dtj
         Ge2EEXBLMR0zaSAEnR2+Ek88d8jP3C9h4ytCNlTspf2sPGQuM3LNdpxaxiZ05lHAULA1
         +Lvg==
X-Gm-Message-State: ACrzQf26foSH5H1oFA15HoJ3fNUym04LdS+TyeFncu67AZnK/YabvAsC
        +vQ0yfS0XTDhZSkH016ox86rnQ==
X-Google-Smtp-Source: AMsMyM6X/Taeq1K5WPeOvcJs7Whvsv82vtrWn6y0XUEU8jcFbC8jD9iDRtbubPxT6OYpCukscVzxxg==
X-Received: by 2002:a63:90c1:0:b0:45f:c9a7:15c3 with SMTP id a184-20020a6390c1000000b0045fc9a715c3mr36038681pge.304.1666766597869;
        Tue, 25 Oct 2022 23:43:17 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id b62-20020a621b41000000b0056b932f3280sm2363187pfb.103.2022.10.25.23.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 23:43:17 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v2 1/2] sched/numa: Stop an exhastive search if an idle core is found
Date:   Wed, 26 Oct 2022 14:42:59 +0800
Message-Id: <20221026064300.78869-2-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221026064300.78869-1-jiahao.os@bytedance.com>
References: <20221026064300.78869-1-jiahao.os@bytedance.com>
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

In update_numa_stats() we try to find an idle cpu on the NUMA node,
preferably an idle core. we can stop looking for the next idle core
or idle cpu after finding an idle core. But we can't stop the
whole loop of scanning the CPU, because we need to calculate
approximate NUMA stats at a point in time. For example,
the src and dst nr_running is needed by task_numa_find_cpu().

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..dfcb620bfe50 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1792,7 +1792,7 @@ static void update_numa_stats(struct task_numa_env *env,
 		ns->nr_running += rq->cfs.h_nr_running;
 		ns->compute_capacity += capacity_of(cpu);
 
-		if (find_idle && !rq->nr_running && idle_cpu(cpu)) {
+		if (find_idle && idle_core < 0 && !rq->nr_running && idle_cpu(cpu)) {
 			if (READ_ONCE(rq->numa_migrate_on) ||
 			    !cpumask_test_cpu(cpu, env->p->cpus_ptr))
 				continue;
-- 
2.37.0

