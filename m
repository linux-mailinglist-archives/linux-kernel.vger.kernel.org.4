Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B84863F307
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiLAOjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiLAOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:39:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A1EA6CE5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:39:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 743B962033
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B80C433C1;
        Thu,  1 Dec 2022 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669905555;
        bh=0xKyH1g6a3IOZfst9FQ+WJoEUTNNFziSOx8E0KHTQaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXecHXb04f/aEoCGGcNU1Jpa4NgqXjuULFzxWvcxe4DBU9YoPJ8PSDZhRIj/cEDL0
         MKizi7jV7LHaQCIkNsekjbzQI4r2USzz/0zsChFeQjxBuOpmDFbZNLWpwMd1PO2h9N
         09FqRkRqskUJD4YU4E5mjoNjItOSZh/kgj4BthWyrZuDJBd+5ChMOacc4y4K+S3kOM
         j5O7W1e7CPYZzHql7Fr3bfYIp3kTpwM779VVBUD+W8KXvUo4QJWrjpA2s8PypDd3MH
         ZGtCD91GQyNFRzZiW162WQH3NsqDbv3plhmdDcx9Jvxk3bDr9OV9IvwCgFvExIOuuG
         T/+LSDsl+4SIA==
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
Subject: [PATCH 2/3] arm64: kprobes: Let arch do_page_fault() fix up page fault in user handler
Date:   Thu,  1 Dec 2022 23:39:11 +0900
Message-Id: <166990555186.253128.6694458405311467597.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <166990553243.253128.13594802750635478633.stgit@devnote3>
References: <166990553243.253128.13594802750635478633.stgit@devnote3>
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

