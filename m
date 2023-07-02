Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2B744E28
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 16:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjGBOrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 10:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGBOrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9103DE6D;
        Sun,  2 Jul 2023 07:47:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 703C160AFF;
        Sun,  2 Jul 2023 14:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8124C433C8;
        Sun,  2 Jul 2023 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688309240;
        bh=0j3BWNbc1EuIzI14t2vLiSWuYOrWEhCXmtAiUJ1Ieoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avuKLwDiBbU6kUUkcFm26n8F33qwy3lyQ8+OM6g9oGJNosVoWfqr8R10IgOgo33to
         Lkv7JiLodUnnObnxXu/0TpGawQt+iZmt4Daxy8Gl8dWnwqbrWyalRkduBrMWcCEt7c
         riQNKq97VuyWOf2EkIEth0A2B1mHVW1GiDcyRI+hc2CVppG9PCa2b9ZPRb9lK0GG2P
         /2C2RuNl1Tzyt76V8S+cENV66ve16/0mJbzBTNxQSn+EOkWDDVPLrSCa2FyqJo1xyu
         LnYUs5ZkaDz7NUzKyfzt0F/1SVNLGm6KDwviaWtc548yyiAnF5gd/JHZQxQsQUXfbx
         uxNN+utxDH5oQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/3] tracing/probes: Fix to avoid double count of the string length on the array
Date:   Sun,  2 Jul 2023 23:47:17 +0900
Message-ID:  <168830923752.2278819.12200306485001986374.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To:  <168830922841.2278819.9165254236027770818.stgit@mhiramat.roam.corp.google.com>
References:  <168830922841.2278819.9165254236027770818.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

If an array is specified with the ustring or symstr, the length of the
strings are accumlated on both of 'ret' and 'total', which means the
length is double counted.
Just set the length to the 'ret' value to aviod double count.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain/
Fixes: 88903c464321 ("tracing/probe: Add ustring type for user-space string")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_probe_tmpl.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 00707630788d..4735c5cb76fa 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -156,11 +156,11 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 			code++;
 			goto array;
 		case FETCH_OP_ST_USTRING:
-			ret += fetch_store_strlen_user(val + code->offset);
+			ret = fetch_store_strlen_user(val + code->offset);
 			code++;
 			goto array;
 		case FETCH_OP_ST_SYMSTR:
-			ret += fetch_store_symstrlen(val + code->offset);
+			ret = fetch_store_symstrlen(val + code->offset);
 			code++;
 			goto array;
 		default:

