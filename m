Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22874F179
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjGKOQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjGKOPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:15:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C8170A;
        Tue, 11 Jul 2023 07:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D15646150C;
        Tue, 11 Jul 2023 14:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEF1C433C8;
        Tue, 11 Jul 2023 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689084952;
        bh=5Y9sWGJd4HJzLogg+iWU8edbrK9/5rH7d1aurm3YzgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aReD0A+1tRpSeAhG5xZHxoEfgPqj/cIAjHv5Z4zOwhd3S7Z4wLSHzDiwKz3dWmVPB
         olT6rBr8eKo6yrOVIN/QlfyLwLhToLP9rNvm0gIdSpX9aPA+9Yv/6SL/7J4uqSsMjC
         zHrhLLgcGapkXdRl+Ga4UB03d368RaOzFaoU+ILQhCICSDUW3gzAxhTD7Lfo+Kuvxt
         jOoJdydJtXRmH/EoxUaPd5caAnHcUz2ElaFcA6ig8tiPnq09t6IiIXQSMuljQ9RAXQ
         rXpVzluE6t3+fiwKXb4yON3bOY56bvM08Pj3bzk8blEgezzi7N3HgIcOYDgMs6nFk8
         LWHO/woKPxf4A==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v5 3/5] tracing/probes: Fix to update dynamic data counter if fetcharg uses it
Date:   Tue, 11 Jul 2023 23:15:48 +0900
Message-Id: <168908494781.123124.8160245359962103684.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <168908491977.123124.16583481716284477889.stgit@devnote2>
References: <168908491977.123124.16583481716284477889.stgit@devnote2>
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

Fix to update dynamic data counter ('dyndata') and max length ('maxlen')
only if the fetcharg uses the dynamic data. Also get out arg->dynamic
from unlikely(). This makes dynamic data address wrong if
process_fetch_insn() returns error on !arg->dynamic case.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Link: https://lore.kernel.org/all/20230710233400.5aaf024e@gandalf.local.home/
Fixes: 9178412ddf5a ("tracing: probeevent: Return consumed bytes of dynamic area")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe_tmpl.h |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index ed9d57c6b041..185da001f4c3 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -267,11 +267,13 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
 		ret = process_fetch_insn(arg->code, rec, dl, base);
-		if (unlikely(ret < 0 && arg->dynamic)) {
-			*dl = make_data_loc(0, dyndata - base);
-		} else {
-			dyndata += ret;
-			maxlen -= ret;
+		if (arg->dynamic) {
+			if (unlikely(ret < 0)) {
+				*dl = make_data_loc(0, dyndata - base);
+			} else {
+				dyndata += ret;
+				maxlen -= ret;
+			}
 		}
 	}
 }

