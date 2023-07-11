Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7537F74E3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjGKCLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGKCL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E2912E;
        Mon, 10 Jul 2023 19:11:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CD05612B9;
        Tue, 11 Jul 2023 02:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AABC433C8;
        Tue, 11 Jul 2023 02:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689041488;
        bh=zwpa7syMeSYhTZBa9ItWWjpkC7dz4g0aJQWZT5Tc5g8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jp5PL+r/ZBA4NiHySk0h/kh9G2ejCb9dvpJqZdD1f43zVnusgqqA0XVGmO4Vrdk54
         B4QAv4hF0SP9e2jiFJaZtkdXqBVSklAdFOuOFucqZ614i065wJNmD/UpzFp2gyTHm0
         6IDI6PQNqy2yppOkNfIUKTNBC/ZAK4oXF1FTFHMOZ8GxO5w7VARFytEFEuzmdLErAf
         Bv+cvxvzPwvUI8dQx5Wra6hdKp3I1INM2ZFb+hQgaMZJFsqo/iDO59EnEowOo70nM/
         m84crjA7vg4z2K2zWxvPOw546DX9OBLBt8xVbwp2SOS2cohJ4rr2cit9jq9Andtnbc
         p8sIdOc2PZEmA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 1/4] tracing/probes: Fix to avoid double count of the string length on the array
Date:   Tue, 11 Jul 2023 11:11:24 +0900
Message-ID:  <168904148467.2908673.7907708071012864793.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To:  <168904147563.2908673.18054267804278861545.stgit@mhiramat.roam.corp.google.com>
References:  <168904147563.2908673.18054267804278861545.stgit@mhiramat.roam.corp.google.com>
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

If an array is specified with the ustring or symstr, the length of the
strings are accumlated on both of 'ret' and 'total', which means the
length is double counted.
Just set the length to the 'ret' value for avoiding double counting.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain/
Fixes: 88903c464321 ("tracing/probe: Add ustring type for user-space string")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes in v2:
 - Fix patch description.
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

