Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA01D6F5135
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjECHXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjECHXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3948B3C3C
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 00:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683098580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXQ0mcO+uCMP4DfjuxEbtb+zWtt0HFFweQAzf8+D5iw=;
        b=DN20QMBEWaHcIFcfgoTC6zmUGt56cKGs9cThhrVg048TeNUFo5epJEalFtkMEgrujY35cT
        s29IF4fXY7Pxk36PjMe+THtdLYO2H3qsk0CUSprrBLNGR0cTEuz4GaeewybKogIEkIjNMF
        5iPllgpcLSXvBMIy73KsmxvK4wvbPmo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-f3p2cN7mNryo2L9L_SpoUA-1; Wed, 03 May 2023 03:22:59 -0400
X-MC-Unique: f3p2cN7mNryo2L9L_SpoUA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3063287f1c9so845940f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 00:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683098578; x=1685690578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXQ0mcO+uCMP4DfjuxEbtb+zWtt0HFFweQAzf8+D5iw=;
        b=fTb9S3l8/D2yDuHClX9hOrauki7w2DI2nSJC+yx7dhgXdjGANW4uU07rbkbDnx6yCG
         1n4gbRRXyfNfn4NNhBbt2z8HVyQfYvp9eCB+uJFxd+bsBscjZpTSyTSV2Ehk3B1MIwWy
         az45UHT6MOONzstJwFTDzHARB0sbpYNRct2Whe/VmM1Q9os7+2fFvxA0ZNsC1iS9evGg
         ZXN9XJfaFjfOtsWwUann07Cny7bb0n2lWSNYj31p7E+156yVXt9q9d0jOpgg+FCTr2I5
         LDVzaPJtsXAb2PWxCJrelEZPvlHJjqn7vnWivc0KjUu4PQPBSG3b/+q8NZ1GB2eG4jvy
         wVsw==
X-Gm-Message-State: AC+VfDwj5Z+rHwzSF2elphW9U14+gOYUdQ8vbg0Yx3KQjcAwTiE5ZOcP
        930HCMXNekRPPayMxxNUMcrUdQDU5VtvnHCiSe0rcEKg6FdR2QwtrdS+2Cly0UQu7NaBIZ0seSE
        Chi1gw+ue0l7ZiVqojXWpqMSq
X-Received: by 2002:a05:6000:87:b0:306:31e0:964 with SMTP id m7-20020a056000008700b0030631e00964mr4690155wrx.55.1683098578072;
        Wed, 03 May 2023 00:22:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7IsmgvCEc91+vccIosngVc0cb9AhRXn2gn7scW6eTn6p2GrpJB0youeMSz9+1tYhmLDptwXw==
X-Received: by 2002:a05:6000:87:b0:306:31e0:964 with SMTP id m7-20020a056000008700b0030631e00964mr4690133wrx.55.1683098577748;
        Wed, 03 May 2023 00:22:57 -0700 (PDT)
Received: from localhost.localdomain.com ([2a02:b127:8011:7489:32ac:78e2:be8c:a5fb])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc301000000b003eddc6aa5fasm947259wmj.39.2023.05.03.00.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 00:22:57 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 1/6] cgroup/cpuset: Rename functions dealing with DEADLINE accounting
Date:   Wed,  3 May 2023 09:22:23 +0200
Message-Id: <20230503072228.115707-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230503072228.115707-1-juri.lelli@redhat.com>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rebuild_root_domains() and update_tasks_root_domain() have neutral
names, but actually deal with DEADLINE bandwidth accounting.

Rename them to use 'dl_' prefix so that intent is more clear.

No functional change.

Suggested-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/cgroup/cpuset.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e4ca2dd2b764..428ab46291e2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1066,7 +1066,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	return ndoms;
 }
 
-static void update_tasks_root_domain(struct cpuset *cs)
+static void dl_update_tasks_root_domain(struct cpuset *cs)
 {
 	struct css_task_iter it;
 	struct task_struct *task;
@@ -1079,7 +1079,7 @@ static void update_tasks_root_domain(struct cpuset *cs)
 	css_task_iter_end(&it);
 }
 
-static void rebuild_root_domains(void)
+static void dl_rebuild_rd_accounting(void)
 {
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
@@ -1107,7 +1107,7 @@ static void rebuild_root_domains(void)
 
 		rcu_read_unlock();
 
-		update_tasks_root_domain(cs);
+		dl_update_tasks_root_domain(cs);
 
 		rcu_read_lock();
 		css_put(&cs->css);
@@ -1121,7 +1121,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 	mutex_lock(&sched_domains_mutex);
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	rebuild_root_domains();
+	dl_rebuild_rd_accounting();
 	mutex_unlock(&sched_domains_mutex);
 }
 
-- 
2.40.1

