Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1A76FA1CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjEHIAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjEHIAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:00:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C168203FC
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683532757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Do5cxKLb8h80paBttvd+Pmn2/iiZatJNSZpVANHwiHM=;
        b=YznHsA1WSKaV8k7t12U8xCbwkenGt4VeIdR7stO4p26AgMzCFShKEnIzefsyD40Gwd3qK1
        oCXgE/tTe0zRXRpuAdZD9KkshQiA/I/i4VmLDP7sW3aCbPI9R1GfKA81NaSQTmhLSAOCd6
        B8mSWAzjC7OGbZTagTZG7+Ay7FzUoNo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-bsjv2M1SMJaJ4iF6CjWjSQ-1; Mon, 08 May 2023 03:59:16 -0400
X-MC-Unique: bsjv2M1SMJaJ4iF6CjWjSQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f421cfb4beso4756115e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 00:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683532755; x=1686124755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Do5cxKLb8h80paBttvd+Pmn2/iiZatJNSZpVANHwiHM=;
        b=C8zi4zixSegS3NgBmgNvaeRlkHbGDB5rQ+eOQ8w6yFpSO3vH/QH7toJgjPK6x39EJT
         Lzig6D4gq1O+fqzEaEEE/3pUspFAofVuKVvFQwbxqZ1FCgEvsHirPO4PmEYgGT1WKldJ
         OOrYNBvIYwi4jw4g27xadZDa07/e5jjQXEVXna/Dy0LZTJlcR119wfv8oFGw5jvua4UB
         g6iYV848VKm8aaJRb3kaBdYyRqbSueLClDmlaM8WETG+vYQon5eNsLUo+NuMbPKBdChl
         Brz4+LZ8dJYZvd0Mttd37yIbISO1zUxfDIWc0AKXxIIb98qjHEMMtYCqZK3hZ2RCaelF
         Jl5A==
X-Gm-Message-State: AC+VfDwuIGr3szzALDkV8aGDbQIxQ64CSJOElVKXfoZ2sw5etXqMnqcV
        mi0MVdRKg7EMiv81P0dUviz+lPHVA2fIQAy3nf+btkIhbVRrjcuEn81+a1ykeh4hF3dCJ0NVR92
        H9I4r2ve++eYZUGrXzltdIgYy
X-Received: by 2002:a05:600c:2055:b0:3f1:74c3:3c51 with SMTP id p21-20020a05600c205500b003f174c33c51mr6675863wmg.35.1683532754956;
        Mon, 08 May 2023 00:59:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5v14zKFo1pDg4Wh9qV7TE7jGoda/WgLtlS5cHxbXYtBW1ITXfsgw5+X8in60Yf0lXwCpjuaQ==
X-Received: by 2002:a05:600c:2055:b0:3f1:74c3:3c51 with SMTP id p21-20020a05600c205500b003f174c33c51mr6675845wmg.35.1683532754642;
        Mon, 08 May 2023 00:59:14 -0700 (PDT)
Received: from localhost.localdomain.com ([176.206.13.250])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bcd08000000b003f42894ebe2sm250423wmj.23.2023.05.08.00.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 00:59:14 -0700 (PDT)
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
Subject: [PATCH v3 4/6] cgroup/cpuset: Iterate only if DEADLINE tasks are present
Date:   Mon,  8 May 2023 09:58:52 +0200
Message-Id: <20230508075854.17215-5-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508075854.17215-1-juri.lelli@redhat.com>
References: <20230508075854.17215-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 968a49024871..c7a346cfdd8d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1092,6 +1092,9 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
 	struct css_task_iter it;
 	struct task_struct *task;
 
+	if (cs->nr_deadline_tasks == 0)
+		return;
+
 	css_task_iter_start(&cs->css, 0, &it);
 
 	while ((task = css_task_iter_next(&it)))
-- 
2.40.1

