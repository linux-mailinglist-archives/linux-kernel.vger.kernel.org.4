Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD7D73397D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346075AbjFPTRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345658AbjFPTQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:16:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CF535B3;
        Fri, 16 Jun 2023 12:16:56 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:16:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J7Snn6U24d8xSQ9Lr7uM8UfI+4r2O+m0DUlyTmTUJKg=;
        b=I9U3yMPkyh7LrK2384KDH17m7hsQ0EW2I/jZGF2AT7JGKE1z47KM/uy6jfjgtRoUdJzDF4
        wKfPmLYjDxa9OO+7qSLOWqU9ZmgWx0isp0U98rDQ6DNqSGGwCqORiQZ5Kn1ULZ6ZthYOrJ
        xlp7pcevWssxivERxSOeiA+c8LR5DG0M401hLLu4zF0WABAIjdgVdls35TaeyXydZ3VdZL
        IvXfQYqxuYjEAV5jOKKdGQ6CGaucDkXClHJPNzYy/y038b/q7CUJSrhdbJAHt6VJq1L9rN
        +X25PIDd2x01zIZ9O70Xcfprt9EXLF1vLckct5vJQKD9Qf0xOI1pHe4H071jZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J7Snn6U24d8xSQ9Lr7uM8UfI+4r2O+m0DUlyTmTUJKg=;
        b=eeUIP6kjndIFLeqL8cYr/t/eDG8n6b+bS1WEC3FOErZqBFJL5jbpP2Z06mZc+qX5pFTozO
        7dnKeT2EnkR2UFBw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Check that SSP is aligned on sigreturn
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694301494.404.16782501347946423933.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     1d784497577b8f30374e4c0f12fbf1cb98986416
Gitweb:        https://git.kernel.org/tip/1d784497577b8f30374e4c0f12fbf1cb98986416
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:58 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:34 -07:00

x86/shstk: Check that SSP is aligned on sigreturn

The shadow stack signal frame is read by the kernel on sigreturn. It
relies on shadow stack memory protections to prevent forgeries of this
signal frame (which included the pre-signal SSP). It also relies on the
shadow stack signal frame to have bit 63 set. Since this bit would not be
set via typical shadow stack operations, so the kernel can assume it was a
value it placed there.

However, in order to support 32 bit shadow stack, the INCSSPD instruction
can increment the shadow stack by 4 bytes. In this case SSP might be
pointing to a region spanning two 8 byte shadow stack frames. It could
confuse the checks described above.

Since the kernel only supports shadow stack in 64 bit, just check that
the SSP is 8 byte aligned in the sigreturn path.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230613001108.3040476-33-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/shstk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index f02e8ea..a8705f7 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -252,6 +252,9 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 	unsigned long token_addr;
 	int err;
 
+	if (!IS_ALIGNED(*ssp, 8))
+		return -EINVAL;
+
 	err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
 	if (unlikely(err))
 		return err;
