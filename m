Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38596483D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiLIOeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIOeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:34:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE93413F31
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:34:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F7CB6225E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 14:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB7AC433EF;
        Fri,  9 Dec 2022 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670596448;
        bh=pLXGrv6QU5pjiha0Gmm0P9l4TU00BqZ7toYM+O8aNqo=;
        h=From:To:Cc:Subject:Date:From;
        b=qeTmW4fZNzcLD+0x8ka17uR60lVLqxsaCPD/GA94JUzMp6LwnhJegYFZw2mR5PWct
         MFH2e7Yc7hapk000BPRdCPosicpsYKGqMUygDgKVX0SBwlz1mle56kWt+p0Bz8vPHz
         807O5Q1uxHLJC8nwDhfLXFsYNuDdVuz4cxUAgVRbQcYj1ssOhPFIH1bXdn/WvzcXLm
         V0RvL7NUvjAOP2LGlLrhO+ZcoVvr1aVt5xL9otfNUYr4RYD/DbNcW/d/j//DAj7RF+
         A5tmSVU8PqqZLXAbcwNvpmK851ObKOa0C+cDYO9hZ56CLriD9FZAZcbnodxiDnyS8v
         5dxiIqQcsKm6A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        will@kernel.org, rostedt@goodmis.org, samitolvanen@google.com,
        keescook@chromium.org, mhiramat@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] ftrace: Allow WITH_ARGS flavour of graph tracer with shadow call stack
Date:   Fri,  9 Dec 2022 15:34:02 +0100
Message-Id: <20221209143402.3332369-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=ardb@kernel.org; h=from:subject; bh=pLXGrv6QU5pjiha0Gmm0P9l4TU00BqZ7toYM+O8aNqo=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjk0dZBTgLiAH9vDjLSbo2y5Awsx6gYL476wnx23X/ vVWfK2iJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY5NHWQAKCRDDTyI5ktmPJBk6C/ 9V27+4l/iFZaaoDRAUTOz3OgxvFfNA10/QjiK8UWS5UpGRiq3KTKllk6hQIuovBv3jWyjo+1s2sz/R 3lp+oF4ka95H9eAvWQADNqgFsNLoBJxVQD0FCU7keE54ZnH1dGkw0u4QDU7k3nmCCwUsrbIOngyRz5 W+QrfzKrdn/p5G0YpdUHEFjm+xJbBODLgEenBvYcZgrgAMrLj+wLITAZLr3nqtntxG0XQnFFyT85Dx 9GAXqd+2rYwrZzRikexo+mBq+4ohaVr8UHAloUZwaxLCoErUIemtosQkeK3araw+/2Jj7uD7/u4iki 9UAI8m3i0paF2DiK51kmQQqo22G9ZENYrAbH2jJSbIILaNljFNJ7xr616S5F9oMJolm0uFxKP5uyUu fBYvUs0Ocwb5A362NHKED8wjnR+mfuvtqETlYjB7qndNr2D/HmeitbRFf49W6SLva8OJUbaWl20nX6 vke8SrRzXQGa+znEWjir6ka3BSLI/Pp/oqIcEqdAY8958=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent switch on arm64 from DYNAMIC_FTRACE_WITH_REGS to
DYNAMIC_FTRACE_WITH_ARGS failed to take into account that we currently
require the former in order to allow the function graph tracer to be
enabled in combination with shadow call stacks. This means that this is
no longer permitted at all, in spite of the fact that either flavour of
ftrace works perfectly fine in this combination.

Given that arm64 is the only arch that implements shadow call stacks in
the first place, let's update the condition to just reflect the arm64
change. When other architectures adopt shadow call stack support, this
can be revisited if needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 072a1b39e3afd0d1..683f365b5e31c856 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -635,7 +635,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
 config SHADOW_CALL_STACK
 	bool "Shadow Call Stack"
 	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
-	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
+	depends on DYNAMIC_FTRACE_WITH_ARGS || !FUNCTION_GRAPH_TRACER
 	help
 	  This option enables the compiler's Shadow Call Stack, which
 	  uses a shadow stack to protect function return addresses from
-- 
2.35.1

