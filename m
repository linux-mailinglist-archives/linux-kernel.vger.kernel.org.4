Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471156B5262
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjCJU4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjCJUy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7AB132AAD;
        Fri, 10 Mar 2023 12:54:55 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481694;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h0dR0inVz8gR/sb4C4cDn6wf5TOCd2gsXb1skIBfTaE=;
        b=a7rC2YTQyy7fIeI1QbOcnSIBy8v7UswIjo1lreFWvsChKfVvdAmq6huh13YOOue5n2cMkb
        EbC7fwd9TrMTQHWd5D3A2B+kpC7TyzvnlMPZVEkMv+IBuBM+iRMFgm7LuZAM21kWCbhJxi
        xqB2+6k/OjHkprykGTlAlsNmp89uWDmnZw3NTejTtLrlf7U0Rl98XKPATlurQUfg1g06WD
        9zY89CzVA0CqEaKWcHX8LRzZ50N1Urb/q1KDZ+xEr6Ih1VKreadfg8dhvFtR28SZ5xhn/F
        N+YMHy3RDxfXGaI11NylS+2QVFx++8Fm8QtJfPA+hz/iYKTBoUUVfix1p/nw2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481694;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h0dR0inVz8gR/sb4C4cDn6wf5TOCd2gsXb1skIBfTaE=;
        b=szV94LWCnUVOLsC8n31FgxS9SH523TbSZNMr7kTg7FPNmGtT8azhSTtD9i/whxswFa3PGz
        BNzsoPd3lh1nAKAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] loongarch/cpu: Make sure play_dead() doesn't return
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <21245d687ffeda34dbcf04961a2df3724f04f7c8.1676358308.git.jpoimboe@kernel.org>
References: <21245d687ffeda34dbcf04961a2df3724f04f7c8.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167848169385.5837.15599094312506772594.tip-bot2@tip-bot2>
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

Commit-ID:     13bf7923a4dd34f3d2681768a148b10ddbdb95ed
Gitweb:        https://git.kernel.org/tip/13bf7923a4dd34f3d2681768a148b10ddbdb95ed
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 23:05:41 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 06 Mar 2023 15:34:06 -08:00

loongarch/cpu: Make sure play_dead() doesn't return

play_dead() doesn't return.  Make that more explicit with a BUG().

BUG() is preferable to unreachable() because BUG() is a more explicit
failure mode and avoids undefined behavior like falling off the edge of
the function into whatever code happens to be next.

Link: https://lore.kernel.org/r/21245d687ffeda34dbcf04961a2df3724f04f7c8.1676358308.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/loongarch/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 8c6e227..51f3281 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -336,7 +336,7 @@ void play_dead(void)
 	iocsr_write32(0xffffffff, LOONGARCH_IOCSR_IPI_CLEAR);
 
 	init_fn();
-	unreachable();
+	BUG();
 }
 
 #endif
