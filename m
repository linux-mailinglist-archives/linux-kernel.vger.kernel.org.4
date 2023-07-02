Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B43744E29
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjGBOre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 10:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGBOrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:47:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1330AE7C;
        Sun,  2 Jul 2023 07:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81B9660C23;
        Sun,  2 Jul 2023 14:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA09C433C7;
        Sun,  2 Jul 2023 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688309249;
        bh=2jfrAoMO9/kQoKHT25bmipL2nxynNXAFTeOpPLGh8dM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJeyzMvOtAY5zLGziIGZvukiqdPzsdAlcxcsGQtg1x9cK0Xkw4L0FFJWz1hqk82Vp
         CkNfsJFTRYIrJ3ilEnPTjV5keLJXkfEGrvIJWGx9fNWewLCn1VcEikNnYxIJUs3Qmz
         ZcsJZ4qMwy5QSKjPx6ABgueXEO4uasH/hkgKqDoZsIWCtQor8+wrBSXuaw4d12XZQ8
         wdDBqmxGXDT4Or9edVsXSv6ajFmQeLHUHQ7/xDpNYx1a9A+nCbC9hJFz6/GCtaaAfZ
         gjs8DD66vWxyH3bvQ79yQdwiCLwxQ/OvhWY7Di9MO5VOe9KqiOsxtFRyjctp33BHsR
         rda1JADnnpKmg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/3] tracing/probes: Fix to exit fetching if an error is detected
Date:   Sun,  2 Jul 2023 23:47:26 +0900
Message-ID:  <168830924625.2278819.7022958622963157629.stgit@mhiramat.roam.corp.google.com>
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

Fix to exit fetching arguments if an error is detected when storing
strings. Without this fix, if an array is specified with string types
it may store the data at the wrong address.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain/
Fixes: 9b960a38835f ("tracing: probeevent: Unify fetch_insn processing common part")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_probe_tmpl.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 4735c5cb76fa..d6f2bf69f9bc 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -193,6 +193,8 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 	default:
 		return -EILSEQ;
 	}
+	if (ret < 0)
+		return ret;
 	code++;
 
 	/* 4th stage: modify stored value if needed */

