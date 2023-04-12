Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC56DFFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDLU03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjDLU0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3665594
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5AF36390B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA5BC433A0;
        Wed, 12 Apr 2023 20:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681331182;
        bh=1f+D/INVsHu7FMXl7yZ+eU5VEMYIQVwkoMtNsfmlqSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pP+al7otwpbXGE80VGWlfTn9pWbN4cNBbQ2+KqmiaPq120LvBUGSf2OTCjJPTUkeg
         jroiqW0R8dJO+svdRTI7WKALwssdYQqpdSHaAQWRMpbgShx9Pdi7ha1Kb+3V4x8EmI
         h2tCUFObYtaDioKtWNyK78YNrAilq5fH9S1P4wcqaMuVCS2LqEm5hpoibxXUI4rvPs
         A7mOYjCXWT7E4A+0qvg0lhThk+WETbMBjx8kHtMm0vSJuWa+vLtWdQpAuUHSHDY0xm
         RkP8cxVzfG2XQoBocJwDjMn+b5FDP+gO8V6+ykj8FMpVBs8dnbfZolDje7Jzr+5/iP
         02Dgp6UoUQO/g==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 2/3] x86/linkage: Fix padding for typed functions
Date:   Wed, 12 Apr 2023 13:26:14 -0700
Message-Id: <721f0da48d2a49fe907225711b8b76a2b787f9a8.1681331135.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681331135.git.jpoimboe@kernel.org>
References: <cover.1681331135.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CFI typed functions are failing to get padded properly for
CONFIG_CALL_PADDING.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/linkage.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index dd9b8118f784..0953aa32a324 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -99,7 +99,7 @@
 
 /* SYM_TYPED_FUNC_START -- use for indirectly called globals, w/ CFI type */
 #define SYM_TYPED_FUNC_START(name)				\
-	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
 	ENDBR
 
 /* SYM_FUNC_START -- use for global functions */
-- 
2.39.2

