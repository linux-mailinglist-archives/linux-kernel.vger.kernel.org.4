Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8321572B1D3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 14:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjFKM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjFKM03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 08:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C43E9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686486341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VzHpqAgwVyjsEyqlii/oXrS26otgDxyqE8QW1Ofzr/o=;
        b=U+08OCPOGm8Llwq0gDgYlg8bWsTA3GZoIsOwoEa0oRlH9RECgWNyq+84zkoJrgaCaWEFX+
        r1ia1Cbdmle9zeVlu/di7Qat7nUiMPGcSpZTgGqL85kExf6CWtjG9l5GGxZKqIFW+B2SX5
        vd3F6Cy6z/gZYOX3N4+0n6UlyAosqRY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-C_B1wJt9NgO1Ateq_XRs6g-1; Sun, 11 Jun 2023 08:25:40 -0400
X-MC-Unique: C_B1wJt9NgO1Ateq_XRs6g-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75ec66a016fso497284685a.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 05:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686486339; x=1689078339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzHpqAgwVyjsEyqlii/oXrS26otgDxyqE8QW1Ofzr/o=;
        b=A8xb+bvtALBWJOVBnsUrWBNsd5PzC6+uOFJWwLiiHKosl7+STkOISPAIDCLilTZu39
         GYArm0MLmk4MGYGROIZNRnd0My/2o3ZhGY96V+692f3/ihZThwgG5le9zB9Cpf9g1Plt
         zFT+NxJ491uYhWn3eyB97Wragn5CY7ySKRWBPt7xUSwsjJv/I/Xob5RCo5xnduwRYogq
         zHUSwSYaGbmX0bXwjuxEyyadJyBrS6nZpNAJutHuDblBMSBCeaa07tMhHVoapbY7jMO3
         CEG5KEiFjX3Bhjmr8rUvadqCwbBtF3O+LBmuLvyq2kMewMy8ox51gzSCSE4W0jM7dyPe
         U5JA==
X-Gm-Message-State: AC+VfDyh7HzxA/3QoeMW711AIEF7Tg05mCxoXG3Ub9rAxjdgFLfsr+14
        YATQq8vnmsqe/uIi5nOfwgID63xjykor1NX7rY3QVB9mIOqSw0CflLynnD5RriCuor5xn0PYBlC
        h23WtkVRCB3ZP0oPllzi/rvCf
X-Received: by 2002:a05:6214:c89:b0:62d:e8d0:b11a with SMTP id r9-20020a0562140c8900b0062de8d0b11amr1060440qvr.45.1686486339535;
        Sun, 11 Jun 2023 05:25:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4h0ZiRL429pl1/04YC3gfIsts/6xKRPbTpu8Jc8MSofShrdwUH8ar8zAQIsfk8aKeD5gwR2g==
X-Received: by 2002:a05:6214:c89:b0:62d:e8d0:b11a with SMTP id r9-20020a0562140c8900b0062de8d0b11amr1060417qvr.45.1686486339309;
        Sun, 11 Jun 2023 05:25:39 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l12-20020ad4452c000000b005ef5f8dc89esm2463910qvu.88.2023.06.11.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 05:25:38 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] sched/fair: rename variable cpu_util eff_util
Date:   Sun, 11 Jun 2023 08:25:35 -0400
Message-Id: <20230611122535.183654-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck reports
kernel/sched/fair.c:7436:17: style: Local variable 'cpu_util' shadows outer function [shadowFunction]
  unsigned long cpu_util;
                ^

Clean this up by renaming the variable to eff_util

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6189d1a45635..7666dbc2b788 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7433,7 +7433,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 	for_each_cpu(cpu, pd_cpus) {
 		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
 		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
-		unsigned long cpu_util;
+		unsigned long eff_util;
 
 		/*
 		 * Performance domain frequency: utilization clamping
@@ -7442,8 +7442,8 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		cpu_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
-		max_util = max(max_util, cpu_util);
+		eff_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
+		max_util = max(max_util, eff_util);
 	}
 
 	return min(max_util, eenv->cpu_cap);
-- 
2.27.0

