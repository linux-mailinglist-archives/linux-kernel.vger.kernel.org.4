Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA25F6242
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiJFIFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJFIFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:05:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4EA37F96
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:05:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14AACB82019
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE8AC4347C;
        Thu,  6 Oct 2022 08:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665043518;
        bh=fFQNaZ2RLqPaAtkFJag0rwOfiBc5yvWp/CWgrpl1HCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OytthnZVbgOc8GCwPYORem/9PBnXzM4ld0jpeXCnNWptZpn1/6xMdKoB7kd9SxN3R
         pFZ86XjViWYhKQ1haiAyIun2om/Zca1N4qnu1XdNdtqFNc22rDoBgx5VvG1O9p1W8f
         k/I8FsmWWjlCucByuYR0p+wKUrghvhGApLwfw9+sE2BIZnhQV1ZNh5UQz3Hh+uUsBr
         Eufija/70Xlfd8yjBOiwyv1czID/n/yx9485m88EUuw5CXRJECC8ItC6J2RKK8hxo3
         53eDsj83JwmeDF+lpFJnrRpOSgijVHH5WRYTy32/YCtCx+sJK3NmkmAImwAdNQQ4DU
         GwdokIu0RKcuw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: jump_label: mark arguments as const to satisfy asm constraints
Date:   Thu,  6 Oct 2022 15:55:41 +0800
Message-Id: <20221006075542.2658-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221006075542.2658-1-jszhang@kernel.org>
References: <20221006075542.2658-1-jszhang@kernel.org>
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

Inspired by x86 commit 864b435514b2("x86/jump_label: Mark arguments as
const to satisfy asm constraints"), mark arch_static_branch()'s and
arch_static_branch_jump()'s arguments as const to satisfy asm
constraints. And Steven in [1] also pointed out that "The "i"
constraint needs to be a constant."

Tested with building a simple external kernel module with "O0".

[1]https://lore.kernel.org/all/20210212094059.5f8d05e8@gandalf.local.home/

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm64/include/asm/jump_label.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index cea441b6aa5d..48ddc0f45d22 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -15,8 +15,8 @@
 
 #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
 
-static __always_inline bool arch_static_branch(struct static_key *key,
-					       bool branch)
+static __always_inline bool arch_static_branch(struct static_key * const key,
+					       const bool branch)
 {
 	asm_volatile_goto(
 		"1:	nop					\n\t"
@@ -32,8 +32,8 @@ static __always_inline bool arch_static_branch(struct static_key *key,
 	return true;
 }
 
-static __always_inline bool arch_static_branch_jump(struct static_key *key,
-						    bool branch)
+static __always_inline bool arch_static_branch_jump(struct static_key * const key,
+						    const bool branch)
 {
 	asm_volatile_goto(
 		"1:	b		%l[l_yes]		\n\t"
-- 
2.37.2

