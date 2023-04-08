Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124266DB921
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 07:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDHFyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 01:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjDHFwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 01:52:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011876580
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 22:52:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c67-20020a254e46000000b00b88f1fd158fso15973295ybb.17
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 22:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680933134;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2dWon3rHJ1nD139lVaQ1WrnfCqCvaQvEhPXDcZYjwM=;
        b=T4kCWB3JooK6L8NchDif5VHk4VQ5lliH7Lz9Ifuwebm2kE6RsdT8Fvu7FrnnUI4Twb
         w8xWnsMr9cHk+6Gw43Fcov8QfAOXzSaORpROP+WxtHVeAQ+Y8BBI13RWv6DjQgj8h+iI
         aPzBV0PV9cOgVOoMvGjAlAHXyf2ToqnvCkAcHvJQ62O/XI1zRCjaU709aLtFRTHUr2ss
         +O0NSJbTj8wKI47aaEL+nm/UnpB+eiFyXlQC6noLORyr9g8TyW88UJOVYECivc0QxE7x
         UGEwPwn/pE5Pd2rrdcSQCjUMMrrmAAvXZm3IhSIrqJPSv4KThFWM98XtuY6cnl+bwIIT
         Pfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680933134;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2dWon3rHJ1nD139lVaQ1WrnfCqCvaQvEhPXDcZYjwM=;
        b=NtmifY+KrO3V4H+uorYlklh6+pZyxZEmoyO/qEI0GuTT+GMtRcIiLjDIDY4ucC1iV2
         JuHPDLwWp9YfHf+k+077jc68ymNeM9crsj/pK+TiW2TK3zuH661f5c5ZjVKjoc4k/bKD
         vuSJUfxvs9pWJnL6x+o8zgycj025z8E0b1wJeTnu0USz5AvIDsUGOypaTaQA6Kb04f2z
         6y8GuFV+WgB3yvI71JEwK0xkSk1J/BRqlMDik9MbLYrukj9A05DlRTu7bPL2oj1je2A7
         O9ZWah2/WfybJdrnXEBU7QRGBc7A+xLoUSofy1WxqUUObqiECcsR/3zrTNf5wiClEuQB
         HVkw==
X-Gm-Message-State: AAQBX9eANq84q9zEWRzvosorRX47vGknw8xquIx4VPJNaswkwLw1ZuT/
        BCVFHbOkA34S+VU37a2b71gH3yv+ICUs
X-Google-Smtp-Source: AKy350Z7mK7eScp79F3uWgqZbq7wHnhBRy2d3bczXxjBl3iURo4swsW9rkDpDn/cynJWxcjKuqzwsGHyNbH+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b240:9cdf:7861:b23e])
 (user=irogers job=sendgmr) by 2002:a25:d988:0:b0:997:c919:4484 with SMTP id
 q130-20020a25d988000000b00997c9194484mr651735ybg.6.1680933134194; Fri, 07 Apr
 2023 22:52:14 -0700 (PDT)
Date:   Fri,  7 Apr 2023 22:52:08 -0700
In-Reply-To: <20230408055208.1283832-1-irogers@google.com>
Message-Id: <20230408055208.1283832-2-irogers@google.com>
Mime-Version: 1.0
References: <20230408055208.1283832-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v1 2/2] perf bpf filter: Support pre-5.16 kernels
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mem_hops bits were added in 5.16 with no prior equivalent.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 28 ++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 57e3c67d6d37..cffe493af1ed 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -24,6 +24,24 @@ struct perf_sample_data___new {
 	__u64 sample_flags;
 } __attribute__((preserve_access_index));
 
+/* new kernel perf_mem_data_src definition */
+union perf_mem_data_src__new {
+	__u64 val;
+	struct {
+		__u64   mem_op:5,	/* type of opcode */
+			mem_lvl:14,	/* memory hierarchy level */
+			mem_snoop:5,	/* snoop mode */
+			mem_lock:2,	/* lock instr */
+			mem_dtlb:7,	/* tlb access */
+			mem_lvl_num:4,	/* memory hierarchy level number */
+			mem_remote:1,   /* remote */
+			mem_snoopx:2,	/* snoop mode, ext */
+			mem_blk:3,	/* access blocked */
+			mem_hops:3,	/* hop level */
+			mem_rsvd:18;
+	};
+};
+
 /* helper function to return the given perf sample data */
 static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 				    struct perf_bpf_filter_entry *entry)
@@ -89,8 +107,14 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 			return kctx->data->data_src.mem_dtlb;
 		if (entry->part == 7)
 			return kctx->data->data_src.mem_blk;
-		if (entry->part == 8)
-			return kctx->data->data_src.mem_hops;
+		if (entry->part == 8) {
+			union perf_mem_data_src__new *data = (void *)&kctx->data->data_src;
+
+			if (bpf_core_field_exists(data->mem_hops))
+				return data->mem_hops;
+
+			return 0;
+		}
 		/* return the whole word */
 		return kctx->data->data_src.val;
 	default:
-- 
2.40.0.577.gac1e443424-goog

