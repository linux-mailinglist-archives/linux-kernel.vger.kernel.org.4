Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11667251BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbjFGBq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbjFGBo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089EA1FE1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:44:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb2fae9b286so4733905276.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102288; x=1688694288;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOIINORTn0PFJFSJlhKwC+O6Tqe9UX93OtBkr06o1MI=;
        b=Wa0jHgYu7yo6yDbvDMoChgMV4Y/i3gAhc51C7Y/1Zp4qXLse4hCqY1eFCW8jXhZAeh
         wVF1lTpIU5m54nO3wa3E4cFY++lS1ESwVmUNBEQV22QkrsV9fPoB0L0YGJtsB92UCjZo
         VNSS0+rTT7I+GOgWUHqmZOSJjnWWqLzyUwasAanqINU2E7LRBlfYN1DhvY8G1nu08lVv
         uNaD3E7u6lcFaI8kIuzI5iat8BjY815NhGDQlsZuVPdo0PipMa9wrwJ+OM92XjhB373w
         VGRvpWwaOSp9/mPj+UTdhsKi4LX9iPjemg84hvvbIdNxJVE2qdStqIAh4n2NzoAV00oQ
         I8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102288; x=1688694288;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOIINORTn0PFJFSJlhKwC+O6Tqe9UX93OtBkr06o1MI=;
        b=VZdhe0uyz4jlreEASVssm16XfgkkUkW0Egs43UMAgdojtGmvfEeTtXbyosaqdpCAlB
         8MzGEtL/hRAmxTQmFwH8d8JUa2njMUZ3bMJ8EYTkuGq/WUNwrVXUW2Pq1hBrq0pBkFQ+
         UbWtc2waggfaSNYhvzfYEEVLvfwY326phwdWlQkzQ1s0k84w1k3D3gIeuS3M83blwCAq
         +TrjcPErQFBel2OKWNwQecBXsFLr7d3YfQ6K1/eXwSLBbaZAg/NcaGiq/bGrbhY3TD3b
         yUfbLpsDgsZYo7AH76kolvN9jJErVASgqg6JciWHv8oyaVrkJ2joTHkE2I0JXmAKsl6h
         T4fw==
X-Gm-Message-State: AC+VfDxLtIZgJc/l8bxyGDjmjBO929tWVYs7wOByoijS8uknoRF3IjS2
        ZgnB/BZRU0dNx2RgIErL1IrPqG0ybmzd
X-Google-Smtp-Source: ACHHUZ6bhSqGSNTPX7PPLeAh4LDoJ50x15oKgeKxKdgw6QbIsf0UJ97hv8l0FaRESJRHlzcYJw/vhj9Npw4v
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a05:6902:124f:b0:bab:9391:470a with SMTP
 id t15-20020a056902124f00b00bab9391470amr1478491ybu.0.1686102288644; Tue, 06
 Jun 2023 18:44:48 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:50 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-18-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 17/20] perf maps: Fix overlapping memory leak
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

Add a missed free detected by leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 5206a6433117..233438c95b53 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -374,6 +374,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 		}
 put_map:
 		map__put(pos->map);
+		free(pos);
 	}
 	up_write(maps__lock(maps));
 	return err;
-- 
2.41.0.rc0.172.g3f132b7071-goog

