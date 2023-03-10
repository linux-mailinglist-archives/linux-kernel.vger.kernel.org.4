Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE496B525C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjCJUzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjCJUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234D7118BED;
        Fri, 10 Mar 2023 12:54:53 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xx/xb8nW0noM4NPp5Z+niYn3IjmBl5tllV8+M8Fi18=;
        b=lJu9BURT1qnJHceKBt7UYfKf4vzW5HwFddaKWCkP4VbPfhXzYU9LH1mGofLQV3NKd+PeZ8
        TUh5BwcCnMJkoZo4+8GlEZ8m83L6h1NSyAJowtP+wC9luDev5S522gkyQMx6hUgpjOBZwt
        K4q2cl/dtRHEkLPPZIct/nlqG3PVeqZqmRytYokTkcfd19bRsBVEfJM9aOsYxawbkwlAib
        D8aZTxRBn/895+0Je7OJ1mqfzUve1QodIVovgxcpuFtS5qBpttvjbXBMApUQx6go9Pdrn5
        Y6jfTKhnkfi7A1QJ0XGLPzOIab4cLltgoBHtSuI971Pakh3oiIC/X4ucQH/S5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xx/xb8nW0noM4NPp5Z+niYn3IjmBl5tllV8+M8Fi18=;
        b=lxnBhUFZ0124NGJIWBbPV9VlPowV0L7X+gMG6MG060sApUlDO0kjfGi1EFOrlCkvL+YU5p
        hC4akQ6HfNDq7JAQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] sh/cpu: Mark play_dead() __noreturn
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <03549a74fad9f73576d57e6fc0b5102322f9cff4.1676358308.git.jpoimboe@kernel.org>
References: <03549a74fad9f73576d57e6fc0b5102322f9cff4.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167848169065.5837.9512220401429601298.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     1644b74192265875cdf37dadfa33f34e0ea4fcc8
Gitweb:        https://git.kernel.org/tip/1644b74192265875cdf37dadfa33f34e0ea4fcc8
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 23:05:48 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 08 Mar 2023 08:44:24 -08:00

sh/cpu: Mark play_dead() __noreturn

play_dead() doesn't return.  Annotate it as such.  By extension this
also makes arch_cpu_idle_dead() noreturn.

Link: https://lore.kernel.org/r/03549a74fad9f73576d57e6fc0b5102322f9cff4.1676358308.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/sh/include/asm/smp-ops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/smp-ops.h b/arch/sh/include/asm/smp-ops.h
index 63866b1..97331fc 100644
--- a/arch/sh/include/asm/smp-ops.h
+++ b/arch/sh/include/asm/smp-ops.h
@@ -24,7 +24,7 @@ static inline void plat_smp_setup(void)
 	mp_ops->smp_setup();
 }
 
-static inline void play_dead(void)
+static inline void __noreturn play_dead(void)
 {
 	mp_ops->play_dead();
 	BUG();
@@ -43,7 +43,7 @@ static inline void register_smp_ops(struct plat_smp_ops *ops)
 {
 }
 
-static inline void play_dead(void)
+static inline void __noreturn play_dead(void)
 {
 	BUG();
 }
