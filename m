Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE65E63FE14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiLBCS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiLBCSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:18:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B196CAF8A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 18:18:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFE21620DF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B914C433D6;
        Fri,  2 Dec 2022 02:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669947527;
        bh=l+zSv5Pd3wyhqUmwoKQIAVoeZtKtlu6AJ8Bvwt0QiX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zii/5dPf7Jv4cEPjUQA2jGVbRF1TX6Q20gJvpJPtsZ7BYH8G7nNgi7RcAYXTs9O2W
         42eQmwYyhdB9miTrO9IVQve1gUnMi9vyD7xZOdQPsOPcbVIrcJRoXnsesxyGPjnSFR
         VMmi1WME5mYK5YaxnFORjAEp5hsm/FQ5rBBNylZaRq8BKDeXTzJ+ozojWnzpVn9ry/
         OrmAQHUXvtvwo6mhuvCtoOQEt4s2qJ5ge36PdYyhOIpCJF3fG04uO9Ejhnw+V4KsI+
         6mrCVeNVyRTWq9wGLL7j5Z6SfHrLB7Csjq+ZfUFRWrWoLxtO5MiHURjGNZjoP85lkY
         pSGk+ZKaIAG9A==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
Subject: [PATCH v2 2/3] arm64: kprobes: Let arch do_page_fault() fix up page fault in user handler
Date:   Fri,  2 Dec 2022 11:18:42 +0900
Message-Id: <166994752269.439920.4801339965959400456.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <166994750386.439920.1754385804350980158.stgit@devnote3>
References: <166994750386.439920.1754385804350980158.stgit@devnote3>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since arm64's do_page_fault() can handle the page fault correctly
than kprobe_fault_handler() according to the context, let it handle
the page fault instead of simply call fixup_exception() in the
kprobe_fault_handler().

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/probes/kprobes.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index c9e4d0720285..d2ae37f89774 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -294,14 +294,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 		}
 
 		break;
-	case KPROBE_HIT_ACTIVE:
-	case KPROBE_HIT_SSDONE:
-		/*
-		 * In case the user-specified fault handler returned
-		 * zero, try to fix up.
-		 */
-		if (fixup_exception(regs))
-			return 1;
 	}
 	return 0;
 }

