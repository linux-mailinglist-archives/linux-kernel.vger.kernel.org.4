Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BC074B1F3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjGGNlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjGGNlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:41:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCF82685;
        Fri,  7 Jul 2023 06:41:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C0F161995;
        Fri,  7 Jul 2023 13:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97443C433C8;
        Fri,  7 Jul 2023 13:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688737266;
        bh=AdroxX5P9OziwCjJV/WVhJbrj4bvgg6m7fGwBk22czA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNSspgDGl1K7znTM5/p29Q60w1EEAvhuJxKkirUDVM5i73j453wN+0t8RfcNHlKZP
         dJ3fdJcuuDn07saPFmI1qu0kITZP0Rt9wdN5AqpNM7UPmClW0MkwU0obwVM7w0AC0v
         Pjdv/tbPczP7t9DhQKRLD9vbRF2GMWQqguUhzuJDP2eF4hncOotKb1+nVzZ45pq210
         y+VlBEiE4CKbe9Vmpx3yBp84lGTX2ihO1o8fFX0SQGfsA/3whkz2dwRVrSvSgEFVO5
         wIe1BiT7FdvrTQQAbmV2sOus/FKRNV3t+OznSF3TbNrjc7j5yWtpvpC3yI5IVLgazY
         cFnP8cEZ4vIwg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 2/4] tracing/probes: Fix not to count error code to total length
Date:   Fri,  7 Jul 2023 22:41:03 +0900
Message-ID:  <168873726308.2687993.8028219145865540388.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To:  <168873724526.2687993.15242662075324919195.stgit@mhiramat.roam.corp.google.com>
References:  <168873724526.2687993.15242662075324919195.stgit@mhiramat.roam.corp.google.com>
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

Fix not to count the error code (which is minus value) to the total
used length of array, because it can mess up the return code of
process_fetch_insn_bottom(). Also clear the 'ret' value because it
will be used for calculating next data_loc entry.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain/
Fixes: 9b960a38835f ("tracing: probeevent: Unify fetch_insn processing common part")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes in v2:
 - Check and clear ret only for the array argument.
---
 kernel/trace/trace_probe_tmpl.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 4735c5cb76fa..ed9d57c6b041 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -204,6 +204,8 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 array:
 	/* the last stage: Loop on array */
 	if (code->op == FETCH_OP_LP_ARRAY) {
+		if (ret < 0)
+			ret = 0;
 		total += ret;
 		if (++i < code->param) {
 			code = s3;

