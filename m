Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BCD73AF50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjFWEOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjFWEOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:14:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390922688
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:14:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bc502a721b1so775010276.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687493658; x=1690085658;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eNUUC1qhFC8BaXPxkTz70Auf+6/vfYl3zUIKz5jKhk=;
        b=po3z9layU6zmEdpr6sz5mdOaALXq8MEmCSQ655ehbQ752sTCxwwul3mEaCJMt1jjcx
         9pAIVLSiQNTEHbz2mfftFK1xhGU09BLRN5VE9NzRcIG3x3Kc3lbm57ayO6aGdTxGt1JO
         NuFh1W1Ee3G9Md2e0UWqU1FLPfDIeIVY1duAgkn0iCYoqS2SaCGD/qDnP2P8h1yBytcZ
         BcuS414q9naG98jLI+h08zOvGF6pI9NBqvF1UlY4T/DQ+vfZx3Y+WzQ8EberbpajHmvA
         ALQnT+6mcGSdJAqt6k92H/EFlh7QT1jMgS3ITeHmfHndZqOBSb7HfeAell7829W0KdUp
         5eFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687493658; x=1690085658;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5eNUUC1qhFC8BaXPxkTz70Auf+6/vfYl3zUIKz5jKhk=;
        b=JENo9u5+PQo8YoaUzeYvG+m0xCkml35vN9glgSb72kq5RlfyhL0jjmsVAvTo4s9OJY
         JKJTLnE+gsvCeiP3LjvBniov22m9+gA7w2t1YrCApRfEXTjS9CnpYXkQPID01ANv6ZMT
         Fx4KI5qRNBsFtE00+b/wtZkcQJKP0X2ZAwYHqHqclenCe5Uc7cBZto++D/FLoZdyr1FA
         xgOalIyKpvFSgmZ9/fV3+gv6BefT/5xDvyZ1TrLFXQIQHkmx9PLtD5zGyA6TvBLm4XKS
         Tx3myNNtkAr6qCbME9UU9D+uVm3eFQTfmMZErkqMb70bREDYwYka7PgQL3ItR+z53//I
         1aig==
X-Gm-Message-State: AC+VfDyKan78Hzawpr+PxdeOSJnFH26VoboAxbSAMOMtDgLY9kno2VnN
        iCbQxXrbbhK5OEo9OtCq39AIBm5j21Rr
X-Google-Smtp-Source: ACHHUZ6siMIzasbytzIi0CCx3XeoDodWisIP4cOQIkEVErG/A8qcf2a6WWiOnrBsOSufKz3gaW6nIPMeh0Ap
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a05:6902:561:b0:bad:2b06:da3 with SMTP id
 a1-20020a056902056100b00bad2b060da3mr8555838ybt.3.1687493657950; Thu, 22 Jun
 2023 21:14:17 -0700 (PDT)
Date:   Thu, 22 Jun 2023 21:14:03 -0700
In-Reply-To: <20230623041405.4039475-1-irogers@google.com>
Message-Id: <20230623041405.4039475-3-irogers@google.com>
Mime-Version: 1.0
References: <20230623041405.4039475-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v4 2/4] perf bpf: Move the declaration of struct rq
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>
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

struct rq is defined in vmlinux.h when the vmlinux.h is generated,
this causes a redefinition failure if it is declared in
lock_contention.bpf.c. Move the definition to vmlinux.h for
consistency with the generated version.

Fixes: 760ebc45746b ("perf lock contention: Add empty 'struct rq' to satisfy libbpf 'runqueue' type verification")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c |  2 --
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h     | 10 ++++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 1d48226ae75d..8d3cfbb3cc65 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -416,8 +416,6 @@ int contention_end(u64 *ctx)
 	return 0;
 }
 
-struct rq {};
-
 extern struct rq runqueues __ksym;
 
 struct rq___old {
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index c7ed51b0c1ef..ab84a6e1da5e 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -171,4 +171,14 @@ struct bpf_perf_event_data_kern {
 	struct perf_sample_data *data;
 	struct perf_event	*event;
 } __attribute__((preserve_access_index));
+
+/*
+ * If 'struct rq' isn't defined for lock_contention.bpf.c, for the sake of
+ * rq___old and rq___new, then the type for the 'runqueue' variable ends up
+ * being a forward declaration (BTF_KIND_FWD) while the kernel has it defined
+ * (BTF_KIND_STRUCT). The definition appears in vmlinux.h rather than
+ * lock_contention.bpf.c for consistency with a generated vmlinux.h.
+ */
+struct rq {};
+
 #endif // __VMLINUX_H
-- 
2.41.0.162.gfafddb0af9-goog

