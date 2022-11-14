Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4588A627C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbiKNLoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbiKNLoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DCA21244
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78241B80E70
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6323C433D7;
        Mon, 14 Nov 2022 11:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426250;
        bh=E3kz6aXy90ssypKzOgGT2am24tCg/w/PReJqhb9mnbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsQd0SZ89H+7uMm60Tc7tgzG1ECnHpVa1m0rVKPMJwrQEil5TJFTb3j8QOczdAPMM
         NuHOLOE6InURkI0wviASS+aOoF2WuPyQj3KInhC6tHVQIRD03GSOtPRI75eawVMtJx
         xYDKTeF+gV/KeI1drOd0JIOky/k7ubR/oiMfWhQk2I5tGVQ1uUYslfqXky7YbFk0Ip
         WlIioBSrWtDHo46wCcdfJjsqnMdU4udcLBgneN3qlda/CZw+fu8zNENse9T8yOoGK0
         n4sPxu3c6d/mL2n/ldgK/VCjvGJpTPm+QsFM6mSmNg8BuOqAyirBtjEHM5KZM5CoOw
         I1BEVn7weUpGw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/46] tracepoint, lto: Mark static call functions as __visible
Date:   Mon, 14 Nov 2022 12:43:05 +0100
Message-Id: <20221114114344.18650-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>

Symbols referenced from assembler (either directly or e.f. from
DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
they could end up in a different object file than the assembler. This
can lead to linker errors without this patch.

So mark static call functions as __visible, namely tracepoints here.

[js] unify the __visible placement

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tracepoint.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 4b33b95eb8be..1ce0655f0c9c 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -239,7 +239,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * poking RCU a bit.
  */
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
-	extern int __traceiter_##name(data_proto);			\
+	extern __visible int __traceiter_##name(data_proto);		\
 	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
 	static inline void trace_##name(proto)				\
@@ -306,7 +306,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		.unregfunc = _unreg,					\
 		.funcs = NULL };					\
 	__TRACEPOINT_ENTRY(_name);					\
-	int __traceiter_##_name(void *__data, proto)			\
+	__visible int __traceiter_##_name(void *__data, proto)		\
 	{								\
 		struct tracepoint_func *it_func_ptr;			\
 		void *it_func;						\
-- 
2.38.1

