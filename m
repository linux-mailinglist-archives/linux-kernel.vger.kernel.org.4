Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAE3745413
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGCDMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGCDMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:12:43 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0CFBA1BE;
        Sun,  2 Jul 2023 20:12:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id A79E76096E8F9;
        Mon,  3 Jul 2023 11:12:39 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?kprobes:=20Remove=20unnecessary=20=E2=80=98NULL?= =?UTF-8?q?=E2=80=99=20values=20from=20correct=5Fret=5Faddr?=
Date:   Wed,  5 Jul 2023 03:43:59 +0800
Message-Id: <20230704194359.3124-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'correct_ret_addr' pointer is always set in the later code, no need
to initialize it at definition time.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index db8a3aa53cf6..ec50f9f380c1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2007,9 +2007,9 @@ void __weak arch_kretprobe_fixup_return(struct pt_regs *regs,
 unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 					     void *frame_pointer)
 {
-	kprobe_opcode_t *correct_ret_addr = NULL;
 	struct kretprobe_instance *ri = NULL;
 	struct llist_node *first, *node = NULL;
+	kprobe_opcode_t *correct_ret_addr;
 	struct kretprobe *rp;
 
 	/* Find correct address and all nodes for this frame. */
-- 
2.18.2

