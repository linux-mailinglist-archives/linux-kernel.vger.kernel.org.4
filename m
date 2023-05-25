Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624DC71060C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjEYHMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbjEYHMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:12:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E86DE74
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba82ed6e450so538142276.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998730; x=1687590730;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUCIph9jK5qjiaVbzBCW9jd0y4OBlbaAbGAhyKWQXwI=;
        b=Ud1pJbb8PouEaxMx39Qsb0pgXQhuacyg9dE15yBm5r7rhKMfmT/wtYE2bXvB9haeyo
         BUBUKC8ETaG4qAGi43orR7MBCDD3xmJ0ggNCx/vfVb0gwfAPQnuhooRT2CMQb9SDBlej
         aeuAnMX/JNhCmbxg7K4mABEvgSx55qB0QBWlNojB1OzD6HniNhvVSXqsOrZTo2JeLiQ2
         AqnarGa9CWEnF2Ot0/Ipz5Slnp3JLrSRn6xuYI+mxDu6NEXLWJOn+9Ql5p4km3xx2FO7
         eeZs0v7UgYnrvrpw64ig+vyli3RyuBx44SDd8pzAjOE244wfPz1Sld6TGQMAJGA8zoNr
         W88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998730; x=1687590730;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUCIph9jK5qjiaVbzBCW9jd0y4OBlbaAbGAhyKWQXwI=;
        b=EaDWpTbUH/z/215+Tk7EyZmxchr38CPBkRIEDwwnTp7wHFnq/gDgktHnQJtadZT5Ws
         sRL5YnIFWAqH4N98l41udu758+JoBGD7LkKkoNXjJq1isRHbOyyNCkdTioEpEx2rKCPU
         mbxbQPDJw3RnJXl9u0do+yMtY+fqr63Wxfr2a7IsVoBDtHKjXuPHwmftbq+sipUONaSZ
         dciRrI+yyGr3MTg3jUTYgnDYAHfUOMLx0dJmgmMN5SB59QaZWezXJGI6Rb4eIohR4c8g
         H+Ok6WNelBRf7c1F+q1Ofl0O0GR4ABsPxe1K28DSi3nQGl2HtxB9nIaRO4BVNje6flyd
         YAtw==
X-Gm-Message-State: AC+VfDxnkioxirxW7UqDvBJO9pfOZ0ep5dA6rqhuakBYGcUBqB4lA5U8
        S1LZ8vqnYrs9EBqMF67k+RLN84jlFatd
X-Google-Smtp-Source: ACHHUZ68HRyMlyMUL7VBgU/YBf0IxbbVeqtg8y5j3FkwNP9nVcYZcks0CIY+Vf/g6P81tElQnzKI+NlxoEYW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a05:6902:118e:b0:ba7:5bec:7772 with SMTP
 id m14-20020a056902118e00b00ba75bec7772mr1217518ybu.5.1684998729741; Thu, 25
 May 2023 00:12:09 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:22 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-6-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 05/16] perf trace beauty: Make MSR arrays const
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

Allows the movement of 46,072 bytes from .data to .data.rel.ro.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/trace/beauty/beauty.h               | 2 +-
 tools/perf/trace/beauty/tracepoints/x86_msr.sh | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 4c59edddd6a8..3d12bf0f6d07 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -11,7 +11,7 @@ struct strarray {
 	u64	    offset;
 	int	    nr_entries;
 	const char *prefix;
-	const char **entries;
+	const char * const *entries;
 };
 
 #define DEFINE_STRARRAY(array, _prefix) struct strarray strarray__##array = { \
diff --git a/tools/perf/trace/beauty/tracepoints/x86_msr.sh b/tools/perf/trace/beauty/tracepoints/x86_msr.sh
index 0078689963e0..fa3c4418e856 100755
--- a/tools/perf/trace/beauty/tracepoints/x86_msr.sh
+++ b/tools/perf/trace/beauty/tracepoints/x86_msr.sh
@@ -13,7 +13,7 @@ x86_msr_index=${arch_x86_header_dir}/msr-index.h
 # Just the ones starting with 0x00000 so as to have a simple
 # array.
 
-printf "static const char *x86_MSRs[] = {\n"
+printf "static const char * const x86_MSRs[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x00000[[:xdigit:]]+)[[:space:]]*.*'
 grep -E $regex ${x86_msr_index} | grep -E -v 'MSR_(ATOM|P[46]|IA32_(TSC_DEADLINE|UCODE_REV)|IDT_FCR4)' | \
 	sed -r "s/$regex/\2 \1/g" | sort -n | \
@@ -24,7 +24,7 @@ printf "};\n\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0xc0000[[:xdigit:]]+)[[:space:]]*.*'
 printf "#define x86_64_specific_MSRs_offset "
 grep -E $regex ${x86_msr_index} | sed -r "s/$regex/\2/g" | sort -n | head -1
-printf "static const char *x86_64_specific_MSRs[] = {\n"
+printf "static const char * const x86_64_specific_MSRs[] = {\n"
 grep -E $regex ${x86_msr_index} | \
 	sed -r "s/$regex/\2 \1/g" | grep -E -vw 'K6_WHCR' | sort -n | \
 	xargs printf "\t[%s - x86_64_specific_MSRs_offset] = \"%s\",\n"
@@ -33,7 +33,7 @@ printf "};\n\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0xc0010[[:xdigit:]]+)[[:space:]]*.*'
 printf "#define x86_AMD_V_KVM_MSRs_offset "
 grep -E $regex ${x86_msr_index} | sed -r "s/$regex/\2/g" | sort -n | head -1
-printf "static const char *x86_AMD_V_KVM_MSRs[] = {\n"
+printf "static const char * const x86_AMD_V_KVM_MSRs[] = {\n"
 grep -E $regex ${x86_msr_index} | \
 	sed -r "s/$regex/\2 \1/g" | sort -n | \
 	xargs printf "\t[%s - x86_AMD_V_KVM_MSRs_offset] = \"%s\",\n"
-- 
2.40.1.698.g37aff9b760-goog

