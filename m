Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC17251B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbjFGBpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbjFGBoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5CC1FCA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:44:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8338f20bdso9299112276.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102273; x=1688694273;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUbHNYf/MJgzoTRlEaaugzHE4j52eJzTeoSuIJqBVp8=;
        b=mDxFyn0QLcNsdiAzzx71y7UkQElsKG9LsfMOAKnDObqJJMZu0ZK1j0kIjqs0UOpm9N
         0EFbZDkGlJa0hsar61LD7b/fh9s2uVuibl2RJgs0kmUuSFpGvN9ddolHCkyPzUP/Jpv6
         Ys+lbFcAiZA6FsmmvDfoQpI1VR7oWaz++fm/4AUUzvQCUWLmIJT+kO5IP4yydQinNFxS
         mxyTO5kmtqH4FIAIHYNtnC4Y2BeRosZzvfTJSLgdV5leI60GpuCS8sR0f7RerhMVOYwW
         0el61bZcUrMJIdRgqLjB0KzhXHNYgvdSqBxvez/VXTp49VZkM+V6gTIQ+vFYQMIfB0Uo
         a4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102273; x=1688694273;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUbHNYf/MJgzoTRlEaaugzHE4j52eJzTeoSuIJqBVp8=;
        b=SU86X9fmO9f9Ou8n0oXGtR88AovFo/ghMTgLXXGF1WkH7DMBK9A6DyU2tI9C3jBE3G
         t2UOqnIrkCFuwNe2nGGricGu6cSU0sQbrd8jBurrB8sKnUWi2oDuWxdChnnkvWOnQm39
         /5UlPJqgDF7U8HefBBKGqLekYM1BPl25ROmOkuh8JLYk0/oF53Vwz0lrmhKGLUk226E7
         MyPeJJO5SCU2fWCpQ/dS3S+0UV+Z9amMqDo+9wrcQsH3mNGkUkuK5RSv80nsbRfrFNkJ
         GVStqyK1ry9NEZJwdPydOf7BRRFwr5Vv5x12wNUSaDBkeGfQ1l7pRcFxH7jApuLfltgs
         NExw==
X-Gm-Message-State: AC+VfDzWp9vN0ig3i7PSu1Q+40yzlHoU/Sr0HWXkZPM6hoHuvLaM0z92
        uGbTjoEPFtLuDb+gBQL+Mege7HoCml9q
X-Google-Smtp-Source: ACHHUZ5a+CpqfjKkQ7fqBxXnwKGqx/AECiFTCrwlTru0QiARSPI8xTMSovdhp5kwTAoMyL2CPyfnJ3qDtNpY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a05:6902:100c:b0:bad:155a:1004 with SMTP
 id w12-20020a056902100c00b00bad155a1004mr2290237ybt.2.1686102273011; Tue, 06
 Jun 2023 18:44:33 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:43 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-11-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 10/20] perf header: Ensure bitmaps are freed
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        "Shawn M. Chapla" <schapla@codeweavers.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory_node bitmaps need a bitmap_free to avoid memory leaks. Caught
by leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d85b39079c31..3db7c1fae71e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1389,6 +1389,14 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 	return 0;
 }
 
+static void memory_node__delete_nodes(struct memory_node *nodesp, u64 cnt)
+{
+	for (u64 i = 0; i < cnt; i++)
+		bitmap_free(nodesp[i].set);
+
+	free(nodesp);
+}
+
 static int memory_node__sort(const void *a, const void *b)
 {
 	const struct memory_node *na = a;
@@ -1449,7 +1457,7 @@ static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
 		*nodesp = nodes;
 		qsort(nodes, cnt, sizeof(nodes[0]), memory_node__sort);
 	} else
-		free(nodes);
+		memory_node__delete_nodes(nodes, cnt);
 
 	return ret;
 }
@@ -1516,7 +1524,7 @@ static int write_mem_topology(struct feat_fd *ff __maybe_unused,
 	}
 
 out:
-	free(nodes);
+	memory_node__delete_nodes(nodes, nr);
 	return ret;
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

