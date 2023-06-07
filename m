Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0327251BB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240608AbjFGBqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbjFGBop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44621BD7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:44:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5689bcc5f56so102379647b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102284; x=1688694284;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg608H21VywQV17FYEJQzmeGbvSJZFZmCrQOqYvdbrQ=;
        b=Mp6konrADVL+r/RypaI/wa9bkKBtNFGLSrryt6LQNP3gpo9rqLMzpl4NpNPFInZK5x
         2Xf/y8SE3JllYicl1RrvycyR9c+YDUN+qpZX09ZtAN8/InDBiAM3suwPKrrDd03Nu+Rw
         6z/87/U1VBLHA1S90Ti2ZbC1aGQkRk8PIxh018BaJ8e5znaiM1DkqIncYQ3EywmUi4oM
         WIGm8ZAf2LdIIT0MZUkJY2gCxw/eQDvwcGwG+BYzq7BiKqxPA+VGFNE6i8S7qL7+A+T/
         lfkDmEuIl054e2itV4FXdkmaDSeWFZDT1ZPCFXTigWURYAeoZAopUrOTKCY6ijFkvOOu
         gAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102284; x=1688694284;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg608H21VywQV17FYEJQzmeGbvSJZFZmCrQOqYvdbrQ=;
        b=BWic/8vKciUeqRYCJdG1tZsmrEyPr0mIodfFsuZNbtfqw0oeZERG0P60uWx5zhl3BG
         swKJX/4TPoSlgxYC/Qx5viTbkax/Emj3uCxvId9I5iiifTfdWd53/LeLSRIAZs5fFWka
         Jnefu0kRNRkqStacpfmTvjcIU4MmrMhoUcKT5EtMx9R2oTUAHCOf6FLwGk94BVIaMQj+
         WgZEfiL0DT/4QdbKQb02oMSvDsjOUIXCNdYKuSZOopgdC34bDbhjWPddYUutx5vbZ/vd
         Bkm0g5rETRFTYw/7REgevlwcHOG/8S/5yJ5H7qSr8DwEvcVtXt6RbaDB9y0W7hyjv/CX
         95kA==
X-Gm-Message-State: AC+VfDy+weC4tpQi6il1ibavuPcJNvxDvqC1EnqVEwmkS7YU51i9b6pD
        5w9+c4pLpkn4ihkInEi9PGtyTrq4TXxV
X-Google-Smtp-Source: ACHHUZ4dmJcqnnrUfPvPiLDilO76aOm556UMNf2RdYxYeymQ/5xTB+p2huyxjiCVxRNBr/2ZTRUFrzVnJzsc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a81:ad1c:0:b0:55d:6af3:1e2c with SMTP id
 l28-20020a81ad1c000000b0055d6af31e2cmr2025412ywh.3.1686102284355; Tue, 06 Jun
 2023 18:44:44 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:48 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-16-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 15/20] perf jit: Fix two thread leaks
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

As reported by leak sanitizer with reference count checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/jitdump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 2380b41a4caa..6b2b96c16ccd 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -800,6 +800,7 @@ static void jit_add_pid(struct machine *machine, pid_t pid)
 	}
 
 	thread__set_priv(thread, (void *)true);
+	thread__put(thread);
 }
 
 static bool jit_has_pid(struct machine *machine, pid_t pid)
@@ -811,6 +812,7 @@ static bool jit_has_pid(struct machine *machine, pid_t pid)
 		return false;
 
 	priv = thread__priv(thread);
+	thread__put(thread);
 	return (bool)priv;
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

