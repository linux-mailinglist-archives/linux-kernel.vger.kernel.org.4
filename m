Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6AD6F5140
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjECHYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjECHX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98B840FD
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 00:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683098591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqYMRmafBeRnD0m4iF8Fupf42DdArIxTTZivyAku9O8=;
        b=CJ7KQtEzF6hRKiZKQggPGeQyCMAuZbmOzYe2XcBodfsWuSpVodSjM+Va2AcwHptaDrLUiR
        AMEPFCDjn6+/NlFdEqdxK2eFYAms+qMdfZiThAjnNwhs8SWslnX5O9Mw/iUk+IJiy9BpX2
        0T3fh+u3Po3BVxmHSDvBHIxfwigFtMk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-EfQFO7JqNOq1LkQraJqDew-1; Wed, 03 May 2023 03:23:10 -0400
X-MC-Unique: EfQFO7JqNOq1LkQraJqDew-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f3fe24912cso1278685e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 00:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683098589; x=1685690589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqYMRmafBeRnD0m4iF8Fupf42DdArIxTTZivyAku9O8=;
        b=mD+Ayy/L2oQmqmIzZoHfYNNNpp4vAbpupDOy+3S4zGKAntlcCQ6Jmvr89V+GqWC1HB
         aob/VZ1KuS9cPqZMAEvCx9Ks+XaMWt5gEALHQvtGmbepARnowJK0bzevO/CLqohFBMFy
         MsdqWfJQAl3r/GJgHxUoPAoXWIsNW+KmZIrB9ZLslZlAnEtUbWLO2JLKLkEajJ+gMKHh
         0eLBEXDyKbkuYnW0+DYZpqlsE9/wxtlCVxCBoZnuOr1cGXgS7lkWFe44gFANbkwZppZ3
         QdwAwO8NaUwPnBGqfPuQ1OVa+jAg3MhpU3Z6stx8qyPQ5oE6yyO6wdb0TyBEyxDsDlgC
         1vYw==
X-Gm-Message-State: AC+VfDwhzSUZhPPhlU8JnMFcYp3+/xJAAriOuxrWpk5/qhvX2wCM59iR
        d1dwSiRDrDIWtGs/w9AR/giQ7ePGoCV/hZEqNnC6O9NCRGyo6C2x1zR2gs7kq5PhJzWtDjimFSi
        zWsK7DCjsFMXq2LabPqeU0ffi
X-Received: by 2002:a05:600c:2212:b0:3f1:73c1:d1ad with SMTP id z18-20020a05600c221200b003f173c1d1admr13737472wml.35.1683098589220;
        Wed, 03 May 2023 00:23:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5RlhA8wxdPVUgoKIGKIcjL4ZrUuXw+jJs9X7ZuopcCEs+AoifkgGTYiqb7y5Q+s+hK+h9Z9w==
X-Received: by 2002:a05:600c:2212:b0:3f1:73c1:d1ad with SMTP id z18-20020a05600c221200b003f173c1d1admr13737445wml.35.1683098588945;
        Wed, 03 May 2023 00:23:08 -0700 (PDT)
Received: from localhost.localdomain.com ([2a02:b127:8011:7489:32ac:78e2:be8c:a5fb])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc301000000b003eddc6aa5fasm947259wmj.39.2023.05.03.00.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 00:23:08 -0700 (PDT)
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
Subject: [PATCH v2 4/6] cgroup/cpuset: Iterate only if DEADLINE tasks are present
Date:   Wed,  3 May 2023 09:22:26 +0200
Message-Id: <20230503072228.115707-5-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230503072228.115707-1-juri.lelli@redhat.com>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_tasks_root_domain currently iterates over all tasks even if no
DEADLINE task is present on the cpuset/root domain for which bandwidth
accounting is being rebuilt. This has been reported to introduce 10+ ms
delays on suspend-resume operations.

Skip the costly iteration for cpusets that don't contain DEADLINE tasks.

Reported-by: Qais Yousef <qyousef@layalina.io>
Link: https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b9f4d5602517..6587df42cb61 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1090,6 +1090,9 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
 	struct css_task_iter it;
 	struct task_struct *task;
 
+	if (cs->nr_deadline_tasks == 0)
+		return;
+
 	css_task_iter_start(&cs->css, 0, &it);
 
 	while ((task = css_task_iter_next(&it)))
-- 
2.40.1

