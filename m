Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADD4664413
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbjAJPGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238828AbjAJPFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:05:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9935A8E9B0;
        Tue, 10 Jan 2023 07:04:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1C62B816D7;
        Tue, 10 Jan 2023 15:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CE7C433F2;
        Tue, 10 Jan 2023 15:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673363069;
        bh=BoEnbr/eDcQ/EJ6JsPc1z5jbuiyapCdGXR2pXG7CW3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOk9BjE4iLg0bmvUfrxUV7sq8lM6Vxd6wM7ct3rLOKhqvPXVQGqrrvkRwp4y34Ky+
         qSAuEAw00ZilCK7q57KCs/Sj/1xY7APwE1LrxtvIAIuPf1F547o3gTLq6Aa/zrlDE7
         ukz4GcpAKKJknNXTb5nCcE4tknuZ6/nL/G43uN/JtwjSFbR2mkxHXAy/Y6Z3a7Y1ZE
         hXK7FyJ8AIIVsUIYMJUkLYqeZ4vQzeUDD+UxvIefJziuDfxhQfEx0pzrf03BMJjsD9
         acT8QcdZRObwXu4eeoD/qjo65WvWLQSlMrflogNTTJ6reNgP9LFALGvpeLDBuIf6QY
         AXJiPcVQIAx4A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 06CE040468; Tue, 10 Jan 2023 12:04:27 -0300 (-03)
Date:   Tue, 10 Jan 2023 12:04:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] perf bpf: Avoid build breakage with libbpf < 0.8.0 +
 LIBBPF_DYNAMIC=1
Message-ID: <Y71+eh00Ju7WeEFX@kernel.org>
References: <Y7hZccgOiueB31a+@kernel.org>
 <Y7hgKMDGzQlankL1@kernel.org>
 <Y7hgoVKBoulCbA4l@kernel.org>
 <CAP-5=fXPPSHvN6VYc=8tzBz4xtKg4Ofa17zV4pAk0ycorXje8w@mail.gmail.com>
 <Y7wuz6EOggZ8Wysb@kernel.org>
 <Y7xYimp0h4YT72/N@krava>
 <CAP-5=fXwO5_kK=pMV09jdAVw386CB0JwArD0BZd=B=xCyWSP1g@mail.gmail.com>
 <CAP-5=fVa51_URGsdDFVTzpyGmdDRj_Dj2EKPuDHNQ0BYgMSzUA@mail.gmail.com>
 <Y712sCnYBJobe2eY@kernel.org>
 <Y716Nt3c/Lc0Z4P5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y716Nt3c/Lc0Z4P5@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 746bd29e348f99b4 ("perf build: Use tools/lib headers from install
path") we stopped having the tools/lib/ directory from the kernel
sources in the header include path unconditionally, which breaks the
build on systems with older versions of libbpf-devel, in this case 0.7.0
as some of the structures and function declarations present in the newer
version of libbpf included in the kernel sources (tools/lib/bpf) are not
anymore used, just the ones in the system libbpf.

So instead of trying to provide alternative functions when the
libbpf-bpf_program__set_insns feature test fails, fail a
LIBBPF_DYNAMIC=1 build (requesting the use of the system's libbpf) and
emit this build error message:

  $ make LIBBPF_DYNAMIC=1 -C tools/perf
  Makefile.config:593: *** Error: libbpf devel library needs to be >= 0.8.0 to build with LIBBPF_DYNAMIC, update or build statically with the version that comes with the kernel sources.  Stop.
  $

For v6.3 these tests will be revamped and we'll require libbpf 1.0 as a
minimal version for using LIBBPF_DYNAMIC=1, most distros should have it
by now or at v6.3 time.

Fixes: 746bd29e348f99b4 ("perf build: Use tools/lib headers from install path")
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/CAP-5=fVa51_URGsdDFVTzpyGmdDRj_Dj2EKPuDHNQ0BYgMSzUA@mail.gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9962ae23ab8c5868..5b87846759036f6f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -589,6 +589,8 @@ ifndef NO_LIBELF
           $(call feature_check,libbpf-bpf_program__set_insns)
           ifeq ($(feature-libbpf-bpf_program__set_insns), 1)
             CFLAGS += -DHAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
+          else
+            dummy := $(error Error: libbpf devel library needs to be >= 0.8.0 to build with LIBBPF_DYNAMIC, update or build statically with the version that comes with the kernel sources);
           endif
           $(call feature_check,libbpf-btf__raw_data)
           ifeq ($(feature-libbpf-btf__raw_data), 1)
-- 
2.39.0

