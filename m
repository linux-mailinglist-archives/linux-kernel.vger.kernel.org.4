Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE8B64E1C4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiLOT2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiLOT2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:28:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EE547310;
        Thu, 15 Dec 2022 11:28:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so122588pjj.4;
        Thu, 15 Dec 2022 11:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJtu96UaLUbxmrQaw47zeCnhCw3DINxkl6YWOTS0s0A=;
        b=qhgx6fDuh1uq//jERerz82Du7xXn0/9GhYjPUsjvIF1t/xm7f1Lbka9VnZKKN+VxBp
         cyKtsGYFN4TR/bn23IlUg/8yMNINkiqCVjUC0AWbQCjaK3ml6Flq8PlNoDgVyXtXkhVq
         v5acFGQ9D2WjVMuQ8pyeiwCwNIu2TLY7NLgF1tBdxT1kIRhbw5pSJUQDcp6+XnF3HXZH
         T07wdy/kEZFErte0xjbrzXVZCi1bizWWPc5i1rer5w2FX0Dwcfc3WiMWtmUOmbuRP6AI
         fFm4oPl7US12fKGCxeoDIX39wk7knGh8K2RPLkvkBu1UjduppoBwc3PYvQaBof4B7kGL
         UrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yJtu96UaLUbxmrQaw47zeCnhCw3DINxkl6YWOTS0s0A=;
        b=HYocK/IPKds966oN+WWal8IkiBg6pwkfliLGjrCWUaUluwntnkjGx5WbVZOEeqj6Np
         TIU1AH2kZjgjRavnvPo6i2R9S21VH9vFSWwpSYffI5qpybYGLDvBBUsiGPPAq/ekGzFh
         vCzq1BISzW8Kr6PCC9vr3m4FX8Qv2VjjVmK000nnvfh21hJ21GOm1ZNnzNCAkNxHkyeq
         y08XayEgrW56IHtv4Ix+MM4ptYX2FcH1E+aasx7U7QRvh4j0NX89Tbo2LYRxpMh2p61A
         lMiL155eGRlItg81J0Uzeqzv1CC2IxfM2DDM08uIvX7chSCdx4mOJY7ry1PBR5hleO4e
         zLIg==
X-Gm-Message-State: ANoB5pnm5pFaMd4A7xqYskuoEov8vgC734MbMkEzIwx9A5+9zh1rIsL4
        jD89+a3eRPmYFC4erTovRdKnKXY8kT8=
X-Google-Smtp-Source: AA0mqf6w64z3r7k1xNh6B1RM4typbb1MMllIiAWQ0juBiASb4wgSyqo809egPFI3anEFOc+DF1zJEw==
X-Received: by 2002:a17:90a:9b0b:b0:219:28b7:c580 with SMTP id f11-20020a17090a9b0b00b0021928b7c580mr29605270pjp.22.1671132504206;
        Thu, 15 Dec 2022 11:28:24 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:ecc1:3e44:be34:129c])
        by smtp.gmail.com with ESMTPSA id ep14-20020a17090ae64e00b00219cf5c3829sm3475129pjb.57.2022.12.15.11.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 11:28:23 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 3/9] perf symbol: Add filename__has_section()
Date:   Thu, 15 Dec 2022 11:28:11 -0800
Message-Id: <20221215192817.2734573-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221215192817.2734573-1-namhyung@kernel.org>
References: <20221215192817.2734573-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The filename__has_section() is to check if the given section name is in
the binary.  It'd be used for checking debug info for srcline.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol-elf.c     | 28 ++++++++++++++++++++++++++++
 tools/perf/util/symbol-minimal.c |  5 +++++
 tools/perf/util/symbol.h         |  1 +
 3 files changed, 34 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 80345695b136..96767d1b3f1c 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -233,6 +233,34 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 	return NULL;
 }
 
+bool filename__has_section(const char *filename, const char *sec)
+{
+	int fd;
+	Elf *elf;
+	GElf_Ehdr ehdr;
+	GElf_Shdr shdr;
+	bool found = false;
+
+	fd = open(filename, O_RDONLY);
+	if (fd < 0)
+		return false;
+
+	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
+	if (elf == NULL)
+		goto out;
+
+	if (gelf_getehdr(elf, &ehdr) == NULL)
+		goto elf_out;
+
+	found = !!elf_section_by_name(elf, &ehdr, &shdr, sec, NULL);
+
+elf_out:
+	elf_end(elf);
+out:
+	close(fd);
+	return found;
+}
+
 static int elf_read_program_header(Elf *elf, u64 vaddr, GElf_Phdr *phdr)
 {
 	size_t i, phdrnum;
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index f9eb0bee7f15..de84da3b0d96 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -385,3 +385,8 @@ char *dso__demangle_sym(struct dso *dso __maybe_unused,
 {
 	return NULL;
 }
+
+bool filename__has_section(const char *filename, const char *sec)
+{
+	return false;
+}
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index e297de14184c..f735108c4d4e 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -165,6 +165,7 @@ int modules__parse(const char *filename, void *arg,
 					 u64 start, u64 size));
 int filename__read_debuglink(const char *filename, char *debuglink,
 			     size_t size);
+bool filename__has_section(const char *filename, const char *sec);
 
 struct perf_env;
 int symbol__init(struct perf_env *env);
-- 
2.39.0.314.g84b9a713c41-goog

