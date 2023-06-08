Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84BB728BDB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbjFHXb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjFHXai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:30:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9753730D6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:30:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bac6a453dd5so1656157276.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686267004; x=1688859004;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/XZkwenxaaHVyn1hVE7P7MuCL0PTGSRSdV23z9MHnOc=;
        b=75tmqSXX65bSoRA5vlcyAF43ZjhIM0r5BM3xBN28av2EJVL53fBWeBvuFQ0ohIFV41
         V3e/SfmjxZDxFllZWY+DfzkPwq5EuwupokhRmWxhsB+cabmeNVtyY+rArxf9IpdCeymO
         VjRW1RuE/6ehKGlfxe+QEbCmweVU8ffBiyN/2T/IzUjUVf8kKGxl4/CPvzmG6TALsD37
         scAps/eFy6y1VLMpZ7G0O1AbiCez+FkMnTroSZQ/C6xlu2nYF28x/1tRUWH0MH+nJmqp
         90NcTyaFWyB7rJgedrkuHPCs1hLxw0udDBCYzMnxUVICERgPpbmS7u4kcIaE4MMnEoPU
         R+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686267004; x=1688859004;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XZkwenxaaHVyn1hVE7P7MuCL0PTGSRSdV23z9MHnOc=;
        b=GLpPbcMrPG4vsq+6o3GBb8PEDV5CmWVwqXszzu27AKZ0RcXkqeT3yADTIrJlV+wsBb
         XwlImkwGhtSJWa2qb2i7Rk1ITRLhBlgSuaykj3mBIHFehFkjP1XJ0m9oD/FjDN4FyiVS
         hjs7XUZ56bHbJDwTF0viysFzn71uzBi4TjewaMd/SbEOJKsENWGYDPEjXlnNj//DyYjT
         BnItYWv9oyxgSARYmSr87tX8cpyj3U8EpmyT68yDAQqOpm+nkO4cqn0URyuWoyThmhUa
         9NA7KDB5trGq5o/SEW3Oxe3J9Q1zL3+Sa033c84H+uB8purB+OuIQ2GW2BkhLNgaiSNC
         Kj0Q==
X-Gm-Message-State: AC+VfDzQVK/u/b08c0ZtOyOYfmCAuQigyPxwukqH6l/MOrHdGo4X2L0K
        3KwI2DESSjENHK6j9gvZWRA1l+GURMOg
X-Google-Smtp-Source: ACHHUZ4p6MK7UPxQ9Y6RWB+kMCGrMnATf9tWGxq4NXy8eTZomZQ5exYqGqOKFmxU9NXUDopUSDfZylb4u6F2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a5b:784:0:b0:bad:99d:f087 with SMTP id
 b4-20020a5b0784000000b00bad099df087mr609214ybq.6.1686267003834; Thu, 08 Jun
 2023 16:30:03 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:18 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-22-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 21/26] perf annotate: Fix parse_objdump_line memory leak
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
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

fileloc is used to hold a previous line, before overwriting it ensure
the previous contents is freed. Free the storage once done in
symbol__disassemble.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b708bbc49c9e..fc5f44535ebe 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1524,6 +1524,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 	/* /filename:linenr ? Save line number and ignore. */
 	if (regexec(&file_lineno, parsed_line, 2, match, 0) == 0) {
 		*line_nr = atoi(parsed_line + match[1].rm_so);
+		free(*fileloc);
 		*fileloc = strdup(parsed_line);
 		return 0;
 	}
@@ -1572,7 +1573,6 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 	}
 
 	annotation_line__add(&dl->al, &notes->src->source);
-
 	return 0;
 }
 
@@ -2114,6 +2114,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		nline++;
 	}
 	free(line);
+	free(fileloc);
 
 	err = finish_command(&objdump_process);
 	if (err)
-- 
2.41.0.162.gfafddb0af9-goog

