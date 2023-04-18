Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495246E5C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjDRIrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDRIrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:47:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0635D40CC;
        Tue, 18 Apr 2023 01:47:40 -0700 (PDT)
Date:   Tue, 18 Apr 2023 08:47:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681807659;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RH1QL+CMMUftjue/1I+BE+vaXEZ73VCJ4XeV2fk8Lj0=;
        b=UUG9NnR4yfIvRMs3Bl7FESxzQlE8K8PQIl7CodAVuH1D2N22lrAkq2xTcxBub2Ah8y4VaG
        ojnoAWR6xKXKTGuGiN55EbsyCx72Uosg595kz1EOixk6sU6fzKwusat6rLO6lffFN8eyXP
        Bp+1hN0sy2ctn8PR7dcuL1bRX5sVhl9d9E3l1CgBizujN7ob3gR2JTM72CPeQuuKrkm4IZ
        fFWpPJ9Mgp6nWa2lYBwlzUiA5Xcx9+djpTu+s+fJBgyQalH1UYeoWW15xw1bFNNvhuEn+p
        COs2+D3d5IlHyh+tp2s3ApFx6mKrvdATYHTcKtBIbomeqFufsHP0c2xK4EehlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681807659;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RH1QL+CMMUftjue/1I+BE+vaXEZ73VCJ4XeV2fk8Lj0=;
        b=w0gs+xu7KLm4gvfWZMs/eBzZw8gCYEaeQue47nwrW02woD8LYdpksgrpzJZILeBo/yxQon
        zCSR6NIBm9TOMMAQ==
From:   "tip-bot2 for Gregory Price" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] syscall_user_dispatch: Untag selector address
 before access_ok()
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Gregory Price <gregory.price@memverge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230407171834.3558-3-gregory.price@memverge.com>
References: <20230407171834.3558-3-gregory.price@memverge.com>
MIME-Version: 1.0
Message-ID: <168180765889.404.10655049417638355294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     463b7715e7ce367fce89769c5d85e31595715ee1
Gitweb:        https://git.kernel.org/tip/463b7715e7ce367fce89769c5d85e31595715ee1
Author:        Gregory Price <gourry.memverge@gmail.com>
AuthorDate:    Fri, 07 Apr 2023 13:18:32 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 16 Apr 2023 14:23:07 +02:00

syscall_user_dispatch: Untag selector address before access_ok()

To support checkpoint/restart, ptrace must be able to set the selector
of the tracee.  The selector is a user pointer that may be subject to
memory tagging extensions on some architectures (namely ARM MTE).

access_ok() clears memory tags for tagged addresses if the current task has
memory tagging enabled.

This obviously fails when ptrace modifies the selector of a tracee when
tracer and tracee do not have the same memory tagging enabled state.

Solve this by untagging the selector address before handing it to
access_ok(), like other ptrace functions which modify tracee pointers do.

Obviously a tracer can set an invalid selector address for the tracee, but
that's independent of tagging and a general capability of the tracer.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/all/ZCWXE04nLZ4pXEtM@arm.com/
Link: https://lore.kernel.org/r/20230407171834.3558-3-gregory.price@memverge.com

---
 kernel/entry/syscall_user_dispatch.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 22396b2..7f2add4 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -87,7 +87,16 @@ static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned lon
 		if (offset && offset + len <= offset)
 			return -EINVAL;
 
-		if (selector && !access_ok(selector, sizeof(*selector)))
+		/*
+		 * access_ok() will clear memory tags for tagged addresses
+		 * if current has memory tagging enabled.
+
+		 * To enable a tracer to set a tracees selector the
+		 * selector address must be untagged for access_ok(),
+		 * otherwise an untagged tracer will always fail to set a
+		 * tagged tracees selector.
+		 */
+		if (selector && !access_ok(untagged_addr(selector), sizeof(*selector)))
 			return -EFAULT;
 
 		break;
