Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A73D72C38D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjFLL7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFLL7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91B1A1;
        Mon, 12 Jun 2023 04:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74D00615E6;
        Mon, 12 Jun 2023 11:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AC4C433EF;
        Mon, 12 Jun 2023 11:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686571141;
        bh=nyqDX+87HZc8e3DFhKVw9S8HR74VWyXjorE0FFDF0vc=;
        h=From:To:Cc:Subject:Date:From;
        b=ujN530MQXGeKb/DiyJ4NQESC5sMVOZ5+fr9SQw21q127rlbpFlDsxzxws0H+1xPhc
         1wuAohCVh+URymvlAN0jUKAavNyaGpBj2ziVmnP7sR2K7hSIWo1cKzTX04ZnN78Vum
         6R6QwpCkxN6K0PBVScZIWqsV8xfFGWmkMemunuwOY32YUv8p7N3zzL5N1OizlRmtCT
         WOxXV83CQGLGdAgOLGznpRki6dvwwpan9Y7MGs2u+xZSZv8OfxoVvmiJSbQMNVHTLW
         l9nj3yzrBXvkTIagLyfRkoTS7Ik8RRiJqxXZSsVueMoEwKCGFn4Y7IsbNsFGk31Ycb
         cnROUJR0AleBQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] tracing/probes: Fix tracepoint event with $arg* to fetch correct argument
Date:   Mon, 12 Jun 2023 20:58:57 +0900
Message-ID:  <168657113778.3038017.12245893750241701312.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

To hide the first dummy 'data' argument on the tracepoint probe events,
the BTF argument array was modified (skip the first argument for tracepoint),
but the '$arg*' meta argument parser missed that.

Fix to increment the argument index if it is tracepoint probe. And decrement
the index when searching the type of the argument.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 473e1c43bc57..643aa3a51d5a 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -456,7 +456,10 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
 
 		if (name && !strcmp(name, varname)) {
 			code->op = FETCH_OP_ARG;
-			code->param = i;
+			if (ctx->flags & TPARG_FL_TPOINT)
+				code->param = i + 1;
+			else
+				code->param = i;
 			return 0;
 		}
 	}
@@ -470,8 +473,11 @@ static const struct fetch_type *parse_btf_arg_type(int arg_idx,
 	struct btf *btf = traceprobe_get_btf();
 	const char *typestr = NULL;
 
-	if (btf && ctx->params)
+	if (btf && ctx->params) {
+		if (ctx->flags & TPARG_FL_TPOINT)
+			arg_idx--;
 		typestr = type_from_btf_id(btf, ctx->params[arg_idx].type);
+	}
 
 	return find_fetch_type(typestr, ctx->flags);
 }

